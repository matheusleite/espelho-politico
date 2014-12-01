# -*- coding: utf-8 -*-

import sys
import xml.etree.ElementTree as ET
from datetime import date
from time import sleep
from urllib2 import urlopen

import MySQLdb
import unicodedata

db_name = str(sys.argv[1])

db_user = str(sys.argv[2])
try:
    db_pwd = str(sys.argv[3])
except IndexError:
    db_pwd = ''

db = MySQLdb.connect("localhost", db_user, db_pwd, db_name)
cursor = db.cursor()


# Classe para parlamentar
class Parlamentar():
    def __init__(self):
        self.id_cadastro = 0
        self.matricula = 0
        self.condicao = ""
        self.nome_parlamentar = ""
        self.url_foto = ""
        self.uf = ""
        self.partido = ""
        self.telefone = ""
        self.email = ""
        self.gabinete = 0


#  Classe para proposições
class Proposicao():
    def __init__(self):
        self.id_proposicao = 0
        self.ano = 0
        self.numero = 0
        self.ementa = ""
        self.explicacao = ""
        self.tema = ""
        self.autor = Parlamentar()
        self.data_apresentacao = ""
        self.situacao = ""
        self.link_teor = ""


def remove_acentos(nome):
    try:
        # Normaliza nome do parlamentar se não tiver acentos
        return unicodedata.normalize('NFKD', unicode (nome, 'utf-8')).encode('ASCII', 'ignore')
    except TypeError:
        # Caso haja acentos, remove-os
        return unicodedata.normalize('NFKD', nome).encode('ASCII', 'ignore')

print "Obtendo os dados dos parlamentares"
url_parlamentares = 'http://www.camara.gov.br/SitCamaraWS/Deputados.asmx/ObterDeputados'
xml_parlamentares = ET.parse(urlopen(url_parlamentares))
xml_parlamentares = xml_parlamentares.getroot()
parlamentares = []
total_parlamentares = 0
for xml_parlamentar in xml_parlamentares:
    parlamentar = Parlamentar()
    parlamentar.nome = xml_parlamentar.find('nomeParlamentar').text
    parlamentar.id_cadastro = int(xml_parlamentar.find('ideCadastro').text)
    parlamentar.matricula = int(xml_parlamentar.find('matricula').text)
    parlamentar.condicao = xml_parlamentar.find('condicao').text
    parlamentar.url_foto = xml_parlamentar.find('urlFoto').text
    parlamentar.uf = xml_parlamentar.find('uf').text
    parlamentar.partido = xml_parlamentar.find('partido').text
    parlamentar.telefone = xml_parlamentar.find('fone').text
    parlamentar.email = xml_parlamentar.find('email').text
    parlamentar.gabinete = int(xml_parlamentar.find('gabinete').text)
    insert_parlamentar_string = """
    insert into parliamentarians
    values ("%s", "%s", "%s", "%s", "%s", "%s", "%s", "%s", "%s", "%s")
    """ % (parlamentar.id_cadastro, parlamentar.matricula, parlamentar.condicao, parlamentar.nome,
           parlamentar.url_foto, parlamentar.uf, parlamentar.partido, parlamentar.telefone,
           parlamentar.email, parlamentar.gabinete)
    try:
        cursor.execute(insert_parlamentar_string)
        db.commit()
        print "Parlamentar", parlamentar.nome, "encontrad@"
    except MySQLdb.IntegrityError:
        print "Parlamentar", parlamentar.nome, "já cadastrado"
    except Exception:
        print "Erro!"
    print
    parlamentares.append(parlamentar)
    total_parlamentares += 1

print
print
print "Total de parlamentares:", total_parlamentares
proposicoes = []
print '-----------------------------------------------------------'
print
sleep(2)
total_proposicoes = 0
tipos_pl = ['PL', 'PLC', 'PLN', 'PLP', 'PLS', 'PLV', 'EAG', 'EMA',
            'EMC', 'EMC-A', 'EMD', 'EML', 'EMO', 'EMP', 'EMPV',
            'EMR', 'EMRP', 'EMS', 'EPP', 'ERD', 'ERD-A', 'ESB',
            'ESP', 'PEC', 'PDS', 'PDN', 'PDC']

for parlamentar in parlamentares:
    print "Obtendo proposições d@ parlamentar", parlamentar.nome
    nome = remove_acentos(parlamentar.nome)
    for pl in tipos_pl:
        url_proposicoes = 'http://www.camara.gov.br/SitCamaraWS/Proposicoes.asmx/ListarProposicoes?sigla=%s&numero=&ano=&datApresentacaoIni=&datApresentacaoFim=&parteNomeAutor=%s&idTipoAutor=&siglaPartidoAutor=&siglaUFAutor=&generoAutor=&codEstado=&codOrgaoEstado=&emTramitacao=' % (pl, nome.replace(' ', '+'))
        try:
            xml_proposicoes = ET.parse(urlopen(url_proposicoes))
        except Exception:
            print "Parlamentar sem proposição de", pl ,":'("
            print
            sleep(3)
            continue
        num_proposicoes = 0
        proposicoes = xml_proposicoes.getroot()
        for proposicao in proposicoes:
            url_proposicao = 'http://www.camara.gov.br/SitCamaraWS/Proposicoes.asmx/ObterProposicaoPorID?IdProp=%s' % proposicao.find('id').text
            try:
                xml_proposicao = ET.parse(urlopen(url_proposicao))
            except Exception:
                print "Erro ao abrir URL"
                print
                sleep(3)
                continue
            root_proposicao = xml_proposicao.getroot()
            nome_autor1 = root_proposicao.find('Autor').text
            temas = root_proposicao.find('tema').text
            if cmp(nome_autor1.upper(), parlamentar.nome) != 0 and len(temas.strip()) != 0:
                proposicao = Proposicao()
                proposicao.numero = root_proposicao.attrib.get('numero')
                proposicao.ano = root_proposicao.attrib.get('ano')
                proposicao.id_proposicao = int(root_proposicao.find('idProposicao').text)
                proposicao.ementa = root_proposicao.find('Ementa').text
                proposicao.ementa = proposicao.ementa.replace('"', '').replace("'", "")
                proposicao.explicacao = root_proposicao.find('ExplicacaoEmenta').text
                proposicao.explicacao = proposicao.explicacao.replace('"', '').replace("'", "")
                for tema in temas.split(';'):
                    insert_theme = """
                        insert into themes
                        (description)
                        values ("%s")
                    """ % (tema.strip())
                    try:
                        cursor.execute(insert_theme)
                        db.commit()
                    except MySQLdb.IntegrityError:
                        print "Tema já cadastrado"
                    except Exception:
                        print "Exception"
                proposicao.autor = parlamentar
                data = root_proposicao.find('DataApresentacao').text
                data = data.split('/')
                data = date(int(data[2]), int(data[1]), int(data[0]))
                proposicao.data_apresentacao = data.isoformat()
                proposicao.situacao = root_proposicao.find('Situacao').text
                proposicao.link_teor = root_proposicao.find('LinkInteiroTeor').text
                insert_proposicao_string = """
                    insert into propositions
                    values ("%s", "%s", "%s", "%s", "%s", "%s", "%s", "%s", "%s", "%s")
                    """ % (proposicao.id_proposicao, proposicao.ano, proposicao.numero, proposicao.ementa,
                            proposicao.explicacao, pl, proposicao.data_apresentacao,
                            proposicao.situacao, proposicao.link_teor, parlamentar.id_cadastro)
                try:
                    cursor.execute(insert_proposicao_string)
                    db.commit()
                except MySQLdb.IntegrityError:
                    print "Proposição '", proposicao.ementa, "' existente no banco de dados."
                except Exception:
                    print "Erro!"
                    print

                for tema in temas.split(';'):
                    try:
                        get_theme_id="""
                          select id from themes
                          where description like "%s"
                        """ % (tema.strip())
                        cursor.execute(get_theme_id)
                        res = cursor.fetchall()
                        theme_id = int(res[0][0])
                        insert_propositions_themes = """
                          insert into propositions_themes
                          values ("%s", "%s")
                        """ % (proposicao.id_proposicao, theme_id)
                        cursor.execute(insert_propositions_themes)
                        db.commit()
                    except MySQLdb.IntegrityError:
                        print "Relacionamento Tema-Proposição já existente"
                        print
                    except IndexError:
                        print "Erro ao recuperar tema"
                        print
                    except Exception:
                        print "Erro!"
                        print
                num_proposicoes += 1
                total_proposicoes += 1
        if num_proposicoes > 0:
            print "Proposições de", pl, "d@ parlamentar", parlamentar.nome, "obtidas :D"
            print "Proposições de", pl, "encontradas:", num_proposicoes
            print
        else:
            print "Parlamentar sem proposição de", pl ,":'("
            print
        sleep(3)

print
print
print "Total de proposições:", total_parlamentares
db.close()
