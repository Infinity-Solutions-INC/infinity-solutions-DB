CREATE DATABASE IF NOT EXISTS infinity_solutions
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

use infinity_solutions;

create table IF NOT EXISTS error_logs (
	id int primary key auto_increment,
    mensagem_error text,
    dt_hr_captacao_error datetime
);

create table IF NOT EXISTS cargo (
	codigo_cargo int primary key auto_increment,
    nome_cargo varchar(30) not null
);

create table IF NOT EXISTS arquivoLido(
id int primary key auto_increment,
nome_arquivo varchar(200),
status_arquivo varchar(30),
qtdTurmasInseridas_arquivo int,
dataLeitura_arquivo date,
constraint chk_status check (status_arquivo in("Lido"))
);

create table IF NOT EXISTS prompt_ia (
codigo_prompt int primary key auto_increment,
descricao_prompt text not null
);

create table IF NOT EXISTS area_curso (
	codigo_area int primary key auto_increment,
    nome_area varchar(60)
);

create table IF NOT EXISTS instituicao (
	codigo_instituicao int primary key auto_increment,	
    nome_instituicao varchar(100) not null,
    cnpj_instituicao varchar(14)
) auto_increment = 100;

create table IF NOT EXISTS curso (
	codigo_curso int primary key auto_increment,
    nome_curso varchar(120),
    ano_curso int,
    fkcodigo_instituicao int,
    fkcodigo_area int,
    
    constraint fk_curso_instituicao foreign key (fkcodigo_instituicao) references instituicao(codigo_instituicao),
    constraint fk_curso_area foreign key (fkcodigo_area) references area_curso(codigo_area)
);

create table IF NOT EXISTS funcionario (
	codigo_funcionario char(6) primary key not null,
    nome_funcionario varchar(60) not null,
    fkcodigo_cargo int not null,
    cpf_funcionario char(11) not null,
    email_funcionario varchar(60) ,
    senha_funcionario varchar(200) ,
    status_funcionario varchar(30),
    fkcodigo_instituicao int not null,
    
    constraint fk_funcionario_instituicao foreign key (fkcodigo_instituicao) references instituicao(codigo_instituicao),
    constraint fk_funcionario_cargo foreign key (fkcodigo_cargo) references cargo(codigo_cargo),
    constraint chk_funcionario_status check (status_funcionario in("ativo", "bloqueado", "aguardando verificacao"))
);

create table IF NOT EXISTS turma (
	codigo_turma int primary key auto_increment,
    ano_turma int not null,
	qtd_ingressantes int not null,
    qtd_alunos_permanencia int not null,
    modalidade_turma varchar(30),
    mensalidade_turma double,
    turno_turma varchar(30),
    
    fkcodigo_curso int,
    
    constraint fk_turma_curso foreign key (fkcodigo_curso) references curso(codigo_curso)
) auto_increment = 100;


create table IF NOT EXISTS recomendacao_recebida (
	codigo_recomendacao_recebida int primary key auto_increment,
    fkcodigo_instituicao int ,
    fkcodigo_prompt int not null ,
    descricao_recomendacao_recebida text not null,
    dt_hr_recomendacao_recebida datetime not null,
    
    constraint fk_recEnv_prompt_ia_codigo foreign key (fkcodigo_prompt) references prompt_ia (codigo_prompt),
    constraint fk_recEnv_turma_codigo foreign key (fkcodigo_instituicao) references instituicao (codigo_instituicao)
);

create table IF NOT EXISTS motivo_evasao (
	codigo_motivo_evasao int primary key auto_increment,
    descricao_motivo_evasao varchar(50) not null,
    dt_hr_registro_motivo_evasao datetime not null,
    fkcodigo_turma int not null,
    
    constraint fk_motEvas_turma_codigo foreign key (fkcodigo_turma) references turma(codigo_turma)
);
insert into prompt_ia (descricao_prompt) values ("Gere Sugestões para que a instituição consiga atuar de maneira efetiva com os casos que estão tendo. 
Essa é uma instituição de ensino superior que oferece várias graduações em áreas de conhecimentos diferentes, 
no entanto tem enfrentado grandes problemas com as taxas de evasão de alunos por diversos motivos, 
segundo uma pesquisa publicada pela própria universidade os cursos com período integral e matutino que são <x1> turmas, 
tem maior taxa de evasão pois os alunos precisam muitas vezes trabalhar  e estudar representando 65% do total de evadidos, 
assim como também mensalidades altas a partir de R$ 927,00 que dificultam o pagamento por parte dos alunos que evadem, 
representa 43% do total de evadidos e são <x2> turmas nossas, como também a pesquisa aponta que 67% dos alunos evadidos fizeram o ensino médio em escolas públicas, 
podendo esses alunos estarem classificados em um ou mais dos casos acima. 
Os cursos com mais evasão são os de Ciências exatas ou da terra com 59% dos casos representando <x3> turmas dessa instituição, 
área da saúde 22% representando <x4> turmas, Ciências sociais e aplicadas 20% representando <x5> turmas. 
De maneira inteligente e criativa que planos de ação para modificações no curso, na grade curricular, e nas metodologias está instituição pode tomar?");

    
insert into cargo (nome_cargo)
values
	("Diretor(a)"),
    ("Coordenador(a)"),
    ("Secretário(a)"),
    ("Administrador(a)"),
    ("CEO");
    
    select * from cargo;
insert into instituicao (nome_instituicao, cnpj_instituicao)
values
	("Universidade Federal de Mato Grosso", "12345678901234");
    
insert into funcionario (codigo_funcionario, nome_funcionario, fkcodigo_cargo, cpf_funcionario, email_funcionario, senha_funcionario, status_funcionario, fkcodigo_instituicao)
values
	('vJ8Heo', "Luana", 1, "48825269803", "luacruz2014@gmail.com", "220206", "ativo", 100),
    ('AB2Dce', "Caio", 2, "48825269803", "teste@gmail.com", "220206", "ativo", 100),
    ('Gf2E14', "Patricia", 3, "48825269803", "teste2@gmail.com", "220206", "aguardando verificacao", 100);
    
