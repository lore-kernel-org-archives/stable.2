Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013048.outbound.protection.outlook.com [40.107.162.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73121624C0;
	Fri, 28 Aug 2026 02:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787883776; cv=fail; b=TZIrZ+Ydi2klwwB756XFMuqhgqDo4ej3TOp1SgnMG3YP2xjRgGeRCTQw8rYdU5Enqzrw7uftT4vcInyQd/vAYjGF8Nu0lKRegMAfo9IYlpt233qBJrBDS+DvKqiuImwPUpYOApE5Pp0yvYX3oDtDQBxkyv3z/JmGXfoVV7ra/s8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787883776; c=relaxed/simple;
	bh=BuRGtcFsJ6Pg+WSuFH8b8q/NXQa31omlq/UM41zL4Fc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g+6Z20HbhIdR4YnGbg92+W7pPWE8BsYieU7ShUcJL2QazATjCuukvvgGU9JVu7C+T6+PkoZLoBHHBXfqG0g34ulZB3pYG7bk/G//VOv5cxODUzJYNBo0lYJR2JnHmY/AZpuwyPS8jw0fozmV2ZVnaHZaSMTrtANxExA0A3UcCWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=DhohxEuK; arc=fail smtp.client-ip=40.107.162.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="DhohxEuK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QvQztsUq/ETfQuuXJW3rEMmaSnyOv3D0T7fi56BChu12R/ZMDn/uojb2+IZ7TaZv/PSWsRtTR+9hkLBNdvuTlfNpoqnwEW9GF4dvsrE63i38sX36f3N9B8u0wULyfgt1CFhniUQuI+LOHEfWR+DQv58NhCi66kZtVrkqSDshd4NNBFGO6WEfI8VppELCoaOoxWPUUBzWZ2NlgHneGXmsRLVYw72+uqIKi/w/wMM53OUfssYzx4QgK8qugRm6ZdzV8K48WiLppA1lA3ca/n+grEpRyE2VZV+bdrzVPi/vTz6dufcwvWFVPt9vpPAZLKPU/E0B/hMDsAzCbFn2gpHKig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJh2/EEVGQawJOe6RaFf7SbA63bS2VV3UZz/qq/mB/4=;
 b=HbiXLADCYk9sSIQehFJuwQ/xr5tv27YWsE8qpTkE1HsyWZ29FpCDWNurQ3maaxFPkFIyLVT4nv8O5P2BEoH9IMCJYXBEG+6BPhKTrOU+Md/vf7CqgiNnOADcFZccDpq26cN/Il/Xp/9UXQoJLdH4sGnvUzsNn+plkFHDM6jCqML8r+G3Y9R8yI9yOgxbgdubPfzm5jeNBIorQLqsg2QXvpU8VpNbUVGIUnDhQX4NzBntroxRzCTpJt8eAz8fkIg5eIlkuyNc3GBtDeahN1aAIRaZLDmgN+58wm2vRy5Jo0zZ4jLnDCG6zZDQ6D4bIGnWorV5/SNmM4hmSJttkc7cJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJh2/EEVGQawJOe6RaFf7SbA63bS2VV3UZz/qq/mB/4=;
 b=DhohxEuKv0glgrttr9dRVbvvD5ZuEtGxEtyV9O/6qMoIOQ5uMOHV13EYOPFdGvuobOPEn3cLVTWcOgAtO6SjmQqXpHbfiMtqJpMoQOhEdhE+s+kQR9pnc5qR5qt63IJydGRAhA7C7H9Co6ncmlRUki8gkVb/BbFWGu/0YN3BAKCRnR5gaP2Oil/gjJ5OpMndR7TJr/bGAn2O39PaJiacaN55ZkY9Foe+gfDXycnsJ1UK8qmLYoAZaus/1dGors6VjNTdrY0/gKzCLQZzvIbovXJXY9nlx3ALp9uFKvSWITpjkcPwebv58vCTy2WbMJGsVBmXfeK5I+gCHucfRW7UVA==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 AM7P189MB0994.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:14c::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.10; Fri, 28 Aug 2026 02:22:50 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 02:22:50 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
Subject: RE: [PATCH net v3] tipc: protect node reset trace dump with node lock
Thread-Topic: [PATCH net v3] tipc: protect node reset trace dump with node
 lock
Thread-Index: AQHdNMQ1/xzPRkHU9EOojJ5rmaJNAbayu/mQ
Date: Fri, 28 Aug 2026 02:22:50 +0000
Message-ID:
 <GV1P189MB19885E9492111A608A9256D0C6AC2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260824122929.210431-1-nicoyip.dev@gmail.com>
 <20260825190141.242219-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260825190141.242219-1-nicoyip.dev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|AM7P189MB0994:EE_
x-ms-office365-filtering-correlation-id: 8dd5f065-2035-4df1-74ca-08df04ab4204
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|38070700021|6133799003|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 Ik4G1wA0NbBaqFHg48En4r5yicotFw8ek6ubVY9FoI12CX5XNdMbYyw5iCvQq6uwIviumyvpsS8Hngf/69HpAp2I2P5Qdh7nj07A6pTXArztAJSwdbxTy2P1aZv+Ehj9fACRPxE4EzjhtMTWGor9sHV5mvE/8v5C5ylbv07jRt04jo5bt+F1UMhZvMwW6oYER/hDNgiclS39hOGy9ZhMOKUDkTlJAded8Jpwhg4yY3AZCtY0p3r9hMnwprWtXCfYaYngRUBkLGkWimJ6ac61eBioDE3j1QhUKe3xNPjH6YRchg9vx+6mQHErZv2NlaLCseM2q9oBoYpK9HH2f+Xe7fW5gbVwWmUW5sQtyoWrZ6H4/YTBhP3JLRfX4DHWfP/gq2axFrw3Kn1vpf00yOyxBp5fmhj9v6SXx9wT6ZgxsmxkfHt+sSYEF9aGZDmpBige67TnLrcnk7AztSA0Z9ML1iZCkgIdONPxwq+ZnCr+V1o8v3QPWiorYGuNXv4gmCkyWqGO+T0ZnGXrqPNSNfuCK4ehd0idn29fSxiNuEv4ymZKal05EMisHjh8aUTwM/1DMGWMmmHGwF8NyulJFpvR6ZKb7TwE5U4ggkWkUAniuVTYbgxuDuXQbNAdtjbpT62zW3W4I8xaPK68F75YTQSE6V+kakKOZl7fxydGYe372LBj8nImc2ukPZGasFDd6wU9dT5EmpUDNK71k3lpKkUUK8ixnwH6nw/bJL0G+vfrG0A=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(38070700021)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OTLnq7NlS3sM5x6EE/mXJQPCZ/xg1flzCzl0tarZPdZrAqwSpLTH9mxBQcsv?=
 =?us-ascii?Q?IMEKZR6tJi6oLObfLhfIWIP5qO0teWGh3JDrRid74z07CT8PFxPbNL6Vtv+R?=
 =?us-ascii?Q?kbvXRNyywyyTGIqVbsTK6jTo4jDE78r5p5TxGWto6quwBuNx1KFqtarrSGUo?=
 =?us-ascii?Q?f5pgL1AaBhQdClcff3mmJXYob+qsU2C877wqOka/RbAvb+2hMbWIlaFD+GAu?=
 =?us-ascii?Q?/C0emD5UycSNCgKjpwfVU06QZJOeJ5NRwN7RamcRM87LUr8VOQSHQgvO/EJ2?=
 =?us-ascii?Q?5/93UqnPZGodHzOVpl/5Brsx5VHhsjDtK0gk2vxslr9LlTJR2X7TIfT98hh/?=
 =?us-ascii?Q?E14JcpMro6AMMzEt7k81P7psN3x3aweXB5/0AN5CEYtFUv6eNn+jKK+r6BYR?=
 =?us-ascii?Q?mMd+HUf3pvzmyEePf5xUXSg8cYeKdCaHVY69xKqisCSe4Ttizm8s+hdvNTqH?=
 =?us-ascii?Q?UsBbNu23M1gGcWackkHS/zlsZE4nDh0xQbHXggjtfE5OmlL+bXIer/xcu7QI?=
 =?us-ascii?Q?/zIxccY2KSqNhX6V7rJYiwxc7Fbq79tZJGEZ/jDbYE1r9zR9A8RXwSbqHjoT?=
 =?us-ascii?Q?q5v7JVIJ9dF2BzQOaTrJ6iOf64qRgmkEDQMpSGzrGpsCi+wahsY386QbS8eJ?=
 =?us-ascii?Q?U4ncqhT1dizZwYDVQ87+6P/2EVKybJ/2oidKakwXIX3yHl0vrv3DROuZXMfY?=
 =?us-ascii?Q?NlxPd8xXCQcK+Suq1agquZUPTcju+awFNt7q0ONR+bayeFFgM12EzCIvGYGj?=
 =?us-ascii?Q?P3asHsSJfMS0PEFjGQf4SC7uJ9Sj4LCLv6TCldMb1TBs2AmubrlXYNiUfLWe?=
 =?us-ascii?Q?3QqdNGMtxsP4POHfPmAo+XCwoLstOmd3sCWt/eXzQEAivmWmBBvJqNZsgePR?=
 =?us-ascii?Q?Ff0LM1RGQv03KLXPWZJ1OTuc0gAzBiVOWBqX2lbwjJImH/u+uWiJx905og6l?=
 =?us-ascii?Q?9e6/Qh7+q6qrAHK9ANd1AYMMWxWdwRNmXGC+f8tDgJucs7+fDShuMCP+BCOn?=
 =?us-ascii?Q?UFHatn90vXYkMA9Si3Vo2V3MEcrx8u3AZ6sFXGKuxtdFeEvrcCUFabcHJjEN?=
 =?us-ascii?Q?YX0C/X7pIzlMCDe4aD7vM/1K3LN+BqPPvwwzH1CGNrLOZK+iaL2uZjCJJHiA?=
 =?us-ascii?Q?gFR5tnay0dWOfBSBDsZAAhVufyIkxuhFZlXSnubftLsENkCJjEO0cvCq7BNS?=
 =?us-ascii?Q?1ne+/bD9CBTbcP/WuRNoL5FIFeRQjK73S9bVvFFj+Y/E4oLZI0cmv8fAYAxL?=
 =?us-ascii?Q?V0IvlymIHNdMH5y0kljvQnMSPPl5DbmtCNtoGK1ozHhdCAEFMJGvmpY34/Kr?=
 =?us-ascii?Q?bl0v9wP0+q5t2RMQqZ9jwK7SKdrTIyY2m0RGCt22wYSPaMBBPtVEwStZovXI?=
 =?us-ascii?Q?Tnh8iiL0AynMO5JOmIiMyB7fS9cNStTy08I+PzNexy3nN0OT7zN3Js9EBkni?=
 =?us-ascii?Q?3a0LxvUwbwT4ikNc5nn6erZZAQCyAt6FkpkIFq2/hGvsbT+rGocgGGExpOsa?=
 =?us-ascii?Q?uAoVXEJjP71cBDs3GNLZgXdM5Hb3iCdIWQVjvQT63zDhv65+uiUIxRdKU7b4?=
 =?us-ascii?Q?MRun6zqeoRcbaxhi3xLmqVlHt9+NTZAtZDfJeN6UqW0KcvTp0VhuGOkvLkxC?=
 =?us-ascii?Q?BRymTCPml7f5w4iA47HiNWkGMcFE8Z6UntL6pORlb2xIchEKkHlmK2pPpltw?=
 =?us-ascii?Q?ZtvsBtWkYEvv7IoFZQV+LQxNCc1CR3xFt7XHKkkrIwHsqhNewDoVfA/r/7vz?=
 =?us-ascii?Q?2wrb3f8rEA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd5f065-2035-4df1-74ca-08df04ab4204
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 02:22:50.2424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BCnEX6AltkczrSSJsH8xFMWXE19Lj9BzW121FG2x6j9KhEBF+I+/IybLUA9GYe1eIejQgM8Jq4mv5tNltWzbzYvCe1pHSPkBPiMe24k+P1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P189MB0994

>Subject: [PATCH net v3] tipc: protect node reset trace dump with node lock
>
>The tipc_node_reset_links trace event asks tipc_node_dump() to walk the
>node's link entries. Unlike the other node events that request link data, =
this
>event runs without the node lock.
>
>This permits bearer teardown to free a link while the trace callback is du=
mping
>it:
>
>  CPU 0                                CPU 1
>  trace_tipc_node_reset_links()
>    tipc_node_dump()
>      l =3D n->links[0].link
>                                       tipc_node_write_lock()
>                                       kfree(l)
>                                       n->links[0].link =3D NULL
>                                       tipc_node_write_unlock()
>      tipc_link_dump(l)
>
>tipc_link_dump() then dereferences the stale pointer. KASAN reported:
>
>  BUG: KASAN: slab-use-after-free in tipc_link_dump
>  Read of size 4 by task poc/115
>  Call Trace:
>   tipc_link_dump+0x10cb/0x16b0
>   tipc_node_dump+0x4bb/0x740
>   trace_event_raw_event_tipc_node_class+0x258/0x360
>   tipc_node_reset_links+0x14d/0x1a0
>   tipc_rcv+0x13f5/0x3030
>   tipc_udp_recv+0x4e3/0x670
>  Allocated by task 0:
>   tipc_link_create+0x1e1/0x1020
>   tipc_node_check_dest+0x7d2/0x11a0
>   tipc_disc_rcv+0xdbf/0x1430
>  Freed by task 89:
>   kfree+0x131/0x3c0
>   tipc_node_link_down+0x267/0x4b0
>   tipc_node_delete_links+0xec/0x160
>   bearer_disable+0x107/0x260
>
>Take the node write lock around the trace event. This serializes the dump
>against tipc_node_link_down(delete=3Dtrue), which frees the link under the
>same write lock.
>
>Fixes: eb18a510b5cd ("tipc: add trace_events for tipc node")
>Cc: stable@vger.kernel.org
>Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
>---
>v1 -> v2:
>- Use tipc_node_write_lock() instead of tipc_node_read_lock() so the
>  dump is exclusive with link deletion.
>
>v2 -> v3:
>- Use tipc_node_write_unlock_fast().
>
> net/tipc/node.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/net/tipc/node.c b/net/tipc/node.c index
>683a136e53ef..bd91378b7540 100644
>--- a/net/tipc/node.c
>+++ b/net/tipc/node.c
>@@ -1333,7 +1333,9 @@ static void tipc_node_reset_links(struct tipc_node
>*n)
>
> 	pr_warn("Resetting all links to %x\n", n->addr);
>
>+	tipc_node_write_lock(n);
> 	trace_tipc_node_reset_links(n, true, " ");
>+	tipc_node_write_unlock_fast(n);
> 	for (i =3D 0; i < MAX_BEARERS; i++) {
> 		tipc_node_link_down(n, i, false);
> 	}
>--
>2.43.0

Reviewed-by: Tung Nguyen <tung.quang.nguyen@est.tech>

Note that sashiko reports pre-existing UAF issue related to link input queu=
e. This needs to be addressed via a separate patch.
