Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013034.outbound.protection.outlook.com [52.101.83.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804A93D3D18;
	Thu,  9 Jul 2026 06:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579015; cv=fail; b=FmQUxfF2JKbTNR+L0PiWhdOJswmvPt4MTs2L5m4AsT0/ykIgD6nd2fN/2WqOqjywzD1GiUySMH3Gnq1U2J9tzKTqtgazVVb69lrv/v9TNT9W7JKrGAr7Z6S5Qa/xPPwSMCxTN1ra9IQ0MuHLrMJsoiH4kYQ/FHRD/G/qCJQkXhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579015; c=relaxed/simple;
	bh=L0b4HPjuyp0Sx7T3p7iSrPy+hj6DWcULvGmlDpU4pOQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l6jIbanZXcFAsI/s632G2hn4Qsjqa1jVzNwCtcGzMwJBG4ofx1iQxXadfQK3lfqZmyiMNucBGMX+fYcjuZZt0ajxGyNa8RqcXzVhZptzb8CBi85Q0LBJ1jP2e/wyegDtLQ7owTcafMceA/rsghC8rAQvJ4u0qloN9k8IPisLeME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=IQQwzEZB; arc=fail smtp.client-ip=52.101.83.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="IQQwzEZB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nug/tFAxTTnFoZdkhsmzsbWKoD66qaIAr3h2nzKzKGPNulm4Q8q3BXsSvMIknryk0zBHw/AsiGqTTRQnAtdcUezt9Zi+5z3WAEWKLx8bSHmqgroada0H/jqCaCu1ukegDU1xYu28fI5/6XTbcQnNpEmVDqUxp8bBYKjMS7W3fg50F5IF8q0dFvAYIbxT97rutE2GC4V773oo+vP/Sy3TOlu6V37qyl8stGWx0Mkzqj7sdMSYSEvSYWLGme6ZtzI4laJLVJS7SmFUKD1WvfwTRTzlYrhMWK5a4yjW3yupke4hhdFOCsd0udOG7qALLyrN7XSwkVA6ydwa6p5dGcqlzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1QJvi9GFrfMSa/cYbwqeFQTpj+rk9uBEBKosJE8TsI=;
 b=Ecw2+8kLUcyOVMdyPoVZPTp++JvLlPW/vOWsZ+IFrNmircL87gn3NHPo65iKurXagCh693r1Lhib0c11vWSjmcvsYdrytyyMJJAlj+omi9rIPLcSry4wbpqzEpYgCY/XKfgacuCXcvO0Roaozo7Whwr4DA6UQN7/FRT/TpGV2hclMPDaq1MGW4khGKB0wd9SLlNovTqousu27XQDwhNR1LyjWuFDvH1x7kvY5ScikIECoss+32fx6gJqEDLWiIkK6+QrluvuGT0MTUwTKnV85QG1LkSTJHWIYD/TEMVztZqAnG6wJy1EuaIRHdhf+lGe3lLaAdWp7AIo84ejHsyVpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1QJvi9GFrfMSa/cYbwqeFQTpj+rk9uBEBKosJE8TsI=;
 b=IQQwzEZB9UNe2qNmBDHWqdBYJC3NhFhbBiDqpFTCJuCPUcJFoWIAbdDkDrcAVe/dYYeXiiXVDfGYX0scTtZCQr7LSHjz44yAUzE3iLM6Fif0gW+OkYg1oPshr5sa3MCNF/He/YfIljaiwDLdisOTzNaYUaqsj4u6hfRv1Jk8up8pCTpPCY8MX7JVZ1GPobnhXhuGVLtI/wmlQZwHljUGM+23AHwwQ1eOqlNv/SBo9IawncI33lYmRBy4BqM4KMIS0S1V7sCaAIm+xeSDGDLe9orcRSOC2DPiFDSm9+8iMH7a/BLcs9q2vIAN3+Af9VXiEplmbQxsv289sNMfXI9SGg==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 VI0P189MB2765.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:253::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Thu, 9 Jul 2026 06:36:46 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0181.010; Thu, 9 Jul 2026
 06:36:46 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Weiming Shi <bestswngs@gmail.com>
CC: Xiang Mei <xmei5@asu.edu>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
Subject: RE: [PATCH net] tipc: fix NULL deref in tipc_lxc_xmit() on node up
Thread-Topic: [PATCH net] tipc: fix NULL deref in tipc_lxc_xmit() on node up
Thread-Index: AQHdDv/rRKGZNvCCMUWwNzY1DQG3/7Zku75A
Date: Thu, 9 Jul 2026 06:36:45 +0000
Message-ID:
 <GV1P189MB19889F69294F168C74685630C6FE2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260708173052.2973990-3-bestswngs@gmail.com>
In-Reply-To: <20260708173052.2973990-3-bestswngs@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|VI0P189MB2765:EE_
x-ms-office365-filtering-correlation-id: f8ce432c-bda4-46af-187c-08dedd84728b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|23010399003|7416014|366016|38070700021|22082099003|56012099006|11063799006|5023799004|18002099003|6133799003;
x-microsoft-antispam-message-info:
 b3vYqZ/zXaFj/msUkuQqam7roEnQ9Ox9cYbCvMd8cUA9caMjaAosmdqheNMo357OLcYGC7rqCxXkYnmO3IYOoXL/u0IdspPWk35s2XmPt6sCKupOzonR2rej/x6jny5442a6jUsqIgGebNMeDgwQschRiSvgYL4qgzqiO75ACez2W/rUBdpZYkFVwTH0nEbYbyarCwoVcjCLVQakfTpbpdUiFm73tdIKxpgGZYINr9hi8HAcVo5Dg70Ja3YkLGv7DBLG0j5uy3uTJrytrxui95zLKFMQdXRMCL+eEjNLeCueRcMoTmXsLJSDaOfuVV2T0WNOir0aazVuPolRYdq6B9Wp6klWh2PYd8+1kSan6kB1DlLTIIfzJxGYWMdNghIWeMO0CSM5b9cmoE+DJsZibltJ7JlkLEh3+Cpk5E9GhTv0QUbnod9cSNjPSnL55DswN+Z/AX7B3jFoTyN3puiJQUtFt7x7/6+/X+LOjw8NvBZB8Z3X2463Lb64bnTrOOL7/0pzNMmOLvG7nBs41SRzkQYZCSZfhdy6ztX+iGs1cSFSl7ytxqqxUDWanoqkE1g0GRHnTpSQKCXWyKhMLKkKakJxkeaSLn5rNsY+no+fGTohBtxRKOW5lFjDjLnP6k3RjJzvL2hJnnFyQawALsxn0KxLM6dOTPulL87gPU/aXnQZiBADx7F9MZ8PUVfM6sg7qJx+t0ik1BZB3c81YysaweBXqoE1HdzarMjKQaRsW6s=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(7416014)(366016)(38070700021)(22082099003)(56012099006)(11063799006)(5023799004)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GufcIW4GFrCvh9xWcF9V4N8JWLcQv9m8NEv/UXvXuc58xHgw57R9zzdxAcH1?=
 =?us-ascii?Q?WcDnnx3Afqf0MjrAJa07yjAsoEC4eSsnSKm15IeRvplggQFn3jQpuDHj6XH7?=
 =?us-ascii?Q?y5LfxDrsicXxqs9IdfBu8a+KfAc3zG+ZH8jzLkNhFrbG/riqWomBfym+9LWK?=
 =?us-ascii?Q?UpHBJEBmpBh3KubPYa76t8r9KVl5W2GOktZyzPwWx3KwY4xIZkwpZt2UebA0?=
 =?us-ascii?Q?jT8YfOtY0eaUixnccrryF1bI5EaJIjs/mKQvCztj/1A2Wtp0TovihVu2sHED?=
 =?us-ascii?Q?ZrNFQlY6DV1+IgN+QzSmRWEuYtQu5MIYY+LSb7pCv1oBDquJEVBxc97+N7/7?=
 =?us-ascii?Q?tqzvieqlRxHTzvY89buGzxZ+5vnnqcRO5Fu46P2ixaN37ewbXcJoJUHvd9b/?=
 =?us-ascii?Q?awXfvxRvchdmk8sqC/ryM69rqt1zXCfVl16M9HP8NKWDB/JZxl5c3jKcsWDm?=
 =?us-ascii?Q?3hWoI2XdXiqhGAKGglLdc5nl+bhGOVtXw+csZotzRJeIfi/bjP2zr14e6A2v?=
 =?us-ascii?Q?IeHO1DBRUWKK+qG8cOg/1Tj9P/5aPMBqUNdx/Z/DD4JD3rbdeXNxHwWC/c+r?=
 =?us-ascii?Q?NwbDd1bbdWpibrCIFVEf2kov7pf5E3xkUKK5H9Azr4/po8FQNSCa1w4u7xXR?=
 =?us-ascii?Q?i3OKeuLGFrmmH9n+9vzeWhpeSYpG/5EftO9Pz5J3sTtqBCElEKZcWalLm1Yg?=
 =?us-ascii?Q?ygMi8mqXzwyXZSa7uEu5/bViFKoB1QJZukD3LORUvw/5b0CI/bjAjxZKRBXf?=
 =?us-ascii?Q?njEzpb+A4gkjsUUjM9QEKzLKoMMZOthJrX86l3lRioLgsU+zHysO+EEQNXS2?=
 =?us-ascii?Q?XeolX+zlz2w1PExINhFezJoIEzfDwftrd1uwm0pDSq72VZDsboo1T65MBqbg?=
 =?us-ascii?Q?UsekguJlFA3qBxi8JxO+0AzdDdAfTMb+g3ix4ujG4a1Xn4tRDo3DBfHNmv+a?=
 =?us-ascii?Q?Ip2mQ4Ra7YL+NcVP5rsNADJHnhKmBEY1RhE4vcjlaxT9a+xo5LO+9UpTR81w?=
 =?us-ascii?Q?hx05oOi4gwlW/g9vcZ6+GfpQ7hzt5Hvn9vnZ/TLRL9uQoaCAoAcZrVh8goCf?=
 =?us-ascii?Q?3tnIPxcZgzF8MUCH7SJ8ZWM1JyqqFyYMoB5r7UljCTerpUz5+i9aSxKoTqBH?=
 =?us-ascii?Q?Ua/v1NIpf5JIsvIt2OPt5Vq6wG6h6BYqcASB9u6BzCbMkKbqvt/MRipXbg1A?=
 =?us-ascii?Q?2N//DZHpYtNFFqzT7IuxGP7cGoDki1I1r/YNQD78zhsHIRfhu4Iecs3ZJi3K?=
 =?us-ascii?Q?0ZzqV66e8QSKNPViu7ILif9Yw5y1HIUGf4xklfwRp8bzwzHgVmn2sV5h8CsA?=
 =?us-ascii?Q?j7ZKjAguL2BAMDlxWh8f4XG6I8xzDlmicD2jZUlerRA/sKVhoKhrN/qvRfDn?=
 =?us-ascii?Q?1rEw0mzXv1SccOo19mtwGZBSNBeQFAkKRTueE1x/jU3iQHJ0hJK5E0mJtgzx?=
 =?us-ascii?Q?U1xW+eXgWigepETtBeBtIZ7xDQbcve5oEki7c2eznC6saBuUNLfYikP08NP+?=
 =?us-ascii?Q?YvZclR95ThWiffDXLHKUW7owYzKR8Tzto5zWSdpzT50MqO3orIrOl9h8j7qh?=
 =?us-ascii?Q?QPbN8QxLlPQXqiKCs5aE+KHkZiVuu1hvImtDpzG7s5zo//AwZwq2jZeL8qCc?=
 =?us-ascii?Q?H/Ijd3bhoTCd9SxLP/w4KePZBPnnqBqEZR6rF9LQzhz2ynVs8E2EqtFQRGnh?=
 =?us-ascii?Q?sAAntWZd+GiV1Z2vshKsM0TmBs/fOKFMA/gC/EDUh6cTroSDsO8iCXsERsR6?=
 =?us-ascii?Q?6zdNkS+qAQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ce432c-bda4-46af-187c-08dedd84728b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 06:36:45.9962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Omy0n7VPg9DSuHzdeP58IvsNE41hGiLI4ApdnoEBHdqOydcGqaRklHhLF+o4/4BmE5ENoEMAveKfpOlIbBoQuh8bRvQPexvi8kAE9iBYYbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P189MB2765

>Subject: [PATCH net] tipc: fix NULL deref in tipc_lxc_xmit() on node up
>
>tipc_named_node_up() builds a bulk of this node's cluster-scope service
>bindings for a peer that just came up and sends it with tipc_node_xmit().
>When cluster_scope is empty the bulk is an empty skb chain, and both
>consumers dereference the head unconditionally: named_distribute() reads
>buf_msg(skb_peek_tail(list)) to tag the last message, and for a same-host =
peer
>tipc_node_xmit() routes into tipc_lxc_xmit(), which reads
>buf_msg(skb_peek(list)). skb_peek*() returns NULL on an empty chain, so
>buf_msg(NULL) faults.
>
>cluster_scope is legitimately empty during the window in
>tipc_net_finalize() between setting the node address, after which peers ca=
n
>link up and trigger tipc_named_node_up(), and tipc_nametbl_publish()
>inserting the first self-binding. A peer linking in that window crashes th=
e node.
>It is reachable by an unprivileged user, who can gain CAP_NET_ADMIN in a
>private net namespace and drive TIPC there.
>
> Oops: general protection fault, probably for non-canonical address
> KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000df]
> RIP: 0010:tipc_lxc_xmit (net/tipc/node.c:1629 net/tipc/msg.h:202)
>  tipc_node_xmit (net/tipc/node.c:1718)
>  tipc_named_node_up (net/tipc/name_distr.c:222)
>  tipc_node_write_unlock (net/tipc/node.c:428)
>  tipc_rcv (net/tipc/node.c:2185)
>  tipc_l2_rcv_msg (net/tipc/bearer.c:669)
>
>Skip the distribution when cluster_scope is empty; an empty bulk carries n=
o
>bindings, so not sending it changes nothing.
>
>Fixes: cad2929dc432 ("tipc: update a binding service via broadcast")
>Reported-by: Xiang Mei <xmei5@asu.edu>
>Assisted-by: Claude:claude-opus-4-8
>Cc: stable@vger.kernel.org
>Signed-off-by: Weiming Shi <bestswngs@gmail.com>
>---
> net/tipc/name_distr.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
>diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c index
>ba4f4906e13b..495e46defddb 100644
>--- a/net/tipc/name_distr.c
>+++ b/net/tipc/name_distr.c
>@@ -218,8 +218,10 @@ void tipc_named_node_up(struct net *net, u32
>dnode, u16 capabilities)
> 	spin_unlock_bh(&tn->nametbl_lock);
>
> 	read_lock_bh(&nt->cluster_scope_lock);
>-	named_distribute(net, &head, dnode, &nt->cluster_scope, seqno);
>-	tipc_node_xmit(net, &head, dnode, 0);
>+	if (!list_empty(&nt->cluster_scope)) {
>+		named_distribute(net, &head, dnode, &nt->cluster_scope,
>seqno);
>+		tipc_node_xmit(net, &head, dnode, 0);
>+	}

Your existing patch already has this check, so please use it plus checking =
non-empty 'head' before calling tipc_node_xmit():
https://patchwork.kernel.org/project/netdevbpf/patch/20260706163024.1205930=
-2-bestswngs@gmail.com/


> 	read_unlock_bh(&nt->cluster_scope_lock);
> }
>
>--
>2.43.0
>

