# SouForce - Developer

## Capítulo 01 - Além do Código
- ### Arquitetura Multi-Tenant
*A arquitetura Multi-Tenant é o equivalente a um condomínio com vários inquilinos no mesmo prédio. Essa analogia se refere aos servidores, onde temos várias ORGs no mesmo servidor.*
![Arquitetura Multi Tenant](https://res.cloudinary.com/hy4kyit2a/f_auto,fl_lossy,q_70/learn/modules/starting_force_com/starting_understanding_arch/images/pt-BR/42a9c0226fae35d3349c3402b399f47e_kix.iau1cgvb69op.jpg)

    Vantagens do Multi-tenant
    - Melhor Utilização dos recursos de Hardware;
    - Custo de Manutenção;
    - Atualizações com mais facilidades;

    Desvantagens do Multi-tenant
    - Alta complexidade;
    - Não permite isolar um único cliente;
    - Baixa flexibilidade ( Sempre deve-se ter cuidados para não afetar os outros clientes );

    Pontos de atenção
    - DML - Sempre montar as DMLs da melhor forma possível;
    - Queries - Limitações de Queries;
    - Performance;