Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013013.outbound.protection.outlook.com [52.101.83.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0203EDE76;
	Mon, 24 Aug 2026 08:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560564; cv=fail; b=H2eayAJ9uniLV9+AlnLf50sRxrzKmUJLHQRvxTe+XSSrO2Wrr+cFMmFSflZ5pUI8z4HyYDyBwkLiOsF87mzlrpr6PkQYTpiktXAFSCyJmVL2HMCEp0FD8oAo4yuUHJ856nEH9nRoXkYNn91c8UfVy0/mHNWdvTNZ4ulmIqaUgRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560564; c=relaxed/simple;
	bh=6lhASRnJ6ELqog9ACsNGIyQ+S93Qb72zwCuOUkk92gQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ezvr+83UMUV5hnahaNXvq/Z6wzpCEOzK3NPx84bneSAkwlOqZrqCYe9odJmmCRTywpR/UVYTxaGv3sYMePWcnGd4A/YuQh8hQey+jn1pzAepVJBfufgG7hQoCIJWSeu89K/dMz/JLrvjIpcNlVW2Z/nSFMXcrfvb9SZ+0dm62eM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=bekMm/ag; arc=fail smtp.client-ip=52.101.83.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="bekMm/ag"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNhB4MftGWxHO4G0fehQZmwToRoVlurUOUHy6mzZlqm4yWqKCSSgnOQ8mZRFEzg6zHi4nLvUQ6LvkB4fPXvL27N6GrJI0nSoNKh08i1qjgs7Xqf2IhvpemioVdkYUWg1Rgw2VW/b24AzWvarM+4gjS6lvj3QsmRRjKxvhv9NPkHaSPvUV+EcwVSya1lAnyJH8A/Plbsg8DNahXNNOJImftjyteDcihbswDa2kmYsZFbKbdbaOFod/Wefrl7tKfAJ/Y76Zijq/AT6PKOpDIkka+E+B5iiFmPeLOR6Z0xb+tdoH0m4bIBrt/zAz+THlssKC+PK6k/oxDg60QamaypImQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jb6jB9qRTNeGma9+D02+qL0B2P4Gve9G5NjG+ZSpHe4=;
 b=TbUiRlmfN5QSwQK019Sj0RwlNMDAaEe4QSYkRLBbfaP6H8Kn5vVrVlywt7Wier592JNozfWhQhL9NNKm00iieSTYxe6rMY3ABKyt+QxhD2vx2irlbTiFT4e1VQBhXQkzpmukKiI9G0ndSjGJh4Rsh/TGSebpXwLHR+9ymhcyCmX5ea1COtJwwl/y60KH0eRyfBOSwUt8lstkWywm8EhywPTEHfQ+8VN/+bpcLUTXmKiOSjyQr8y+5f46ThwK+pVMO6zgOxtKzqolGk7TnFSbZx33ZSfPFjgC3jXXHdgDJGgV/P9OhA5gJGXG6H09vRCnpPVYPivBZcxcZyI9m0FbCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jb6jB9qRTNeGma9+D02+qL0B2P4Gve9G5NjG+ZSpHe4=;
 b=bekMm/ag1Wg9lMV530W71WyhhmJLybGTAG86KPcfIFlu2i7v0qp5E6LFSAENB8fPetSzmEg3qxOErqfvuMns2ei7GdDiTNjKGwefDs0KsNBPg/hBS4sMJ2WJn3CJkZFawuJc3d7UjZF/AaHArl3Y5GoU5xZnTwWj/rzpHxe5eIjLlAlvVOcFVVDsOgX+xI548pXOg+cAQO/DysckG6FsNnk8T+GGHrvERtEoFdvtKexV3d81kC2B4C1zSxLLgmzLI3IFhSkQcz3RusUkqnWyfeXFCV7t7SYBtMj9N1AHFRYXi3DIMDaIVA4ss3nxoC966aiCWSCm5ktXStX5z5Cd3A==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 VI1P18901MB0653.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:128::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Mon, 24 Aug
 2026 08:35:56 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0360.005; Mon, 24 Aug 2026
 08:35:55 +0000
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
Subject: Re: [PATCH net] tipc: protect node reset trace dump with node lock
Thread-Topic: [PATCH net] tipc: protect node reset trace dump with node lock
Thread-Index: AQHdMlUIWq3tJ39DZ0C1QzQ8Zz1oKbas2get
Date: Mon, 24 Aug 2026 08:35:55 +0000
Message-ID:
 <GV1P189MB1988E432599B256A18EED117C6A02@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260822164055.3750284-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260822164055.3750284-1-nicoyip.dev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|VI1P18901MB0653:EE_
x-ms-office365-filtering-correlation-id: e878a8f3-36f1-459e-5eef-08df01bab711
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|38070700021|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 6AvzkTt5GnGBt8cfN0s27bhvckKZa7WxDVjmYRJYP1hWR9P1fKsW/3C7ie9+jOfaQmXD1ssqAYrsx0TMVT1jn2nCGAH34XQ4nZV/nzBLtLzMhvM6pnvgncGZSU8paRMVJjgcIe4h4f61d6JYAIwmXKrwFCKbc2BYhYZg2Sf0J6GGmulAEALDMiXwYQoV2Uy3fRReUGEIPClu9tZfDeAegycqpkwddn7morxW+mK1W/6jrrOGGhwUIFXvB3bycKKndcg2O19phv4shDuV/RqTDtAuONfsHLA04WXTCE5kqZaSjuDz8e1nbQKHP7+I53RKOirYRbyiAtoxLpTgan9cXl4c/hsDGON/wwl8YLKgqDUXYmkYW1lEapNiaKOYRct5EIAH+ns7QLQmn3FUb3DkV9J00Y5gPNILWQry9WdHj5UEAquBKZap/ZyQ9+nW1GshexY8Te7NAUZOjTrUG3wT5jBOe7xKsNxjvm9xEN/jKzeybLJvB/S+EJ7b7BHQlk93NopnsusrV63RvfMgpqrhIL3fPa5HGs0KWaaLFZa867l9mJDn/a2wH4IBvI/LuS3+PM+R/R//DvD1iufey8se4XxzAe1k3a+4yPrHjVAyEysrYYhjTBJl2p0m+n2584RjP76Bn/By8rvxqwjaukHf6qrq04DlHPl+BmtOM0gySNd1Eg7cnDvkErtxQLc3BUM830yYvB6NpE1XbuNNyg4BIy5lyLNEe0PbrWXrrEiYYF4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(38070700021)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?AGRSo4puZEGL6+e4Hl6K1Hzy+Q28T8x9EzLK/BgNSadxwoUlP7YTT8kqt+?=
 =?iso-8859-1?Q?Oc2MMwfvdiT2ZfhGaIl9EAT1JVgzw+v5pAvJqMF4GktlUpEbHfE+jpGHWu?=
 =?iso-8859-1?Q?pgkj1WN1ou8nrsXbTXnGWx/Ct/v3TX1nNSSuoO2NyskQxHQSeMwat7IecM?=
 =?iso-8859-1?Q?P0rpZHxR438Os0dN0R4+4ScDFE0OHF6MQIfNhq3E3tt9+FBAvXJr/Jv8OV?=
 =?iso-8859-1?Q?JJOq+ajjBQxC9qZnEcO8Leb7yTaIxozG4i4XRgx1TwqXBSEQp/VwKM7DI4?=
 =?iso-8859-1?Q?K7aGm/Eadxe5bcnVThIzmnyBBUGFcCpfs3n29XhCKUxwb+ImHvJk9DdNtS?=
 =?iso-8859-1?Q?xx5uc00PlHrBrh2vkZ98/zI7SXzOnS8yF+rbN9hxUm0xezHogU6pbiH4ym?=
 =?iso-8859-1?Q?xItLfi7zrV27TltLu8AJpG4BZjvsIdAvS8cqs8xoiV3oeq0fzXtcophYOB?=
 =?iso-8859-1?Q?Opk+dRS60GSwg/BXgLdiLvM13NhULMk9Fznwd/cbWCd44EuclEV6qtF+JJ?=
 =?iso-8859-1?Q?BXHzqOOhPTpTDC2lqXF9aURlZrap9vKlvebF5VJq4AecpukzU9W4h8Om9w?=
 =?iso-8859-1?Q?HpJXWo859OKwGu+YRY0UswEPP+KUcV9erhkU9PW+oIpoeQmAY34S1ff+q4?=
 =?iso-8859-1?Q?uV4Yx5weAsh1I/Cp6sNJXr8Za9Vl7aTuB2OMGh45WdmKBLIDbSzrizOaJY?=
 =?iso-8859-1?Q?Cu8hVEo9seob+BQQwHhfA0AAstkiAa/T2F1g1jYTlmNEiTXW9aQYd/uiWC?=
 =?iso-8859-1?Q?1Jjt6NjPhCtyDX0rbmhtQMwlz4zd2poXOe38SrsgySwjJXqieJ9yFDxIjG?=
 =?iso-8859-1?Q?+glniIxkL3ei81iVDJwJTW2mmjMI+CwpTJdRLsnmsYp3wytvRpLHpqgOMl?=
 =?iso-8859-1?Q?u/ati/4ubHnLJsOtlsRIXiMcbRAbFrdOx1ovh7P3cqX0NOQbTZlzPNL27p?=
 =?iso-8859-1?Q?j5OIkqPm8FCnqeTcCzS1P/ndri+fCDIK49tLD1Q0kDZsbSFoN2AeLLzT+E?=
 =?iso-8859-1?Q?I+i9PTneL/NkM/VwbJVUfwhWBNLKWZAxIniQjkBPZSKQB45QgMiKpevh3d?=
 =?iso-8859-1?Q?2BHnC0PWP+Wx1wKxp5+UAH8buaviX+CMIp4jFasRprkhmiKIcpOy1xVjWt?=
 =?iso-8859-1?Q?WaTPNTam6ibyaFW0ZAoQJrMbPXh+qMOkqQQEiZg3z7WVRLRqLo8t5U/RXu?=
 =?iso-8859-1?Q?/I9LXh0S8XZqn/Ft3Yf2IprFzAknPYfllBSPeVsJnr8kehOuu0U1Pfb4j6?=
 =?iso-8859-1?Q?ngJXxzN8Drq3Fp62btuBNGkJKUw3AAPqt+Iqp/8iZSMlh2wHNMXWTm7ZOE?=
 =?iso-8859-1?Q?i78inI1V0zwAHVMfi66gxGeQ/tD1HtHj1staXMAnL4YdUaozJor66iC1r9?=
 =?iso-8859-1?Q?/wGING8/7A9ldOgxA9qN+E7SEAerNdBxNjDd7MvWBvHlIIKzhdCoNFbN/q?=
 =?iso-8859-1?Q?cOL6NcJUKjp2u7mDBL+FLCkvN9OjwoxRHe9IovQtofL10+3P8V01qeXTd2?=
 =?iso-8859-1?Q?60TEET/X6OpmpVO8Y0quIujj6a2Pp8qUdZLx8UAHQFfJsUhB+XmGjiyeoq?=
 =?iso-8859-1?Q?/lBL+2zv7docKc5zAnd164caR0GmmvIXi4zTG9HmzY/z3u6B6jLzAOc/Kp?=
 =?iso-8859-1?Q?3gXMkcch9x9yxgmdJRgpFg4RD0/K8KYegihQZOTTEHtMwo1bD+/AERUHCL?=
 =?iso-8859-1?Q?eI7Imvej1fAifF0bhDvUn90vsE0WKGIuUNXUonbBKE0djNqYb4BCnMQUWv?=
 =?iso-8859-1?Q?Ljy2yhrz7pda9YqHCKx0uKpQpkP53rPXU0+WX0zwxPLYl+hL8doeUzpYPl?=
 =?iso-8859-1?Q?1w6m6fFMJA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e878a8f3-36f1-459e-5eef-08df01bab711
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 08:35:55.6689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eJleHFw4ilYkwey2BKtkNP3FEG5LI8+fxjiWfP5TTWiRWDFol6WBAyTZHyxoEdMRyozBE/tyGOeE/zHjzjoKxSUu42CNgg3dorRvDO63uZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P18901MB0653

> Subject: [PATCH net] tipc: protect node reset trace dump with node lock=
=0A=
=0A=
  >BUG: KASAN: slab-use-after-free in tipc_link_dump+0x10cb/0x16b0=0A=
  >Read of size 4 by task ksoftirqd/0/14=0A=
  >Call Trace:=0A=
  > tipc_link_dump+0x10cb/0x16b0=0A=
  > tipc_node_dump+0x4bb/0x740=0A=
  > trace_event_raw_event_tipc_node_class+0x258/0x360=0A=
  > tipc_node_reset_links+0x14d/0x1a0=0A=
  > tipc_rcv+0x13f5/0x3030=0A=
  > tipc_udp_recv+0x4e3/0x670=0A=
  > Allocated by task 0:=0A=
  > tipc_link_create+0x1e1/0x1020=0A=
  > tipc_node_check_dest+0x7d2/0x11a0=0A=
  > tipc_disc_rcv+0xdbf/0x1430=0A=
  > Freed by task 89:=0A=
  >  kfree+0x131/0x3c0=0A=
  >  tipc_node_link_down+0x267/0x4b0=0A=
  >  tipc_node_delete_links+0xec/0x160=0A=
  > bearer_disable+0x107/0x260=0A=
=0A=
Please decode above stack trace (using linux/scripts/decode_stacktrace.sh).=
=0A=
=0A=
> Take the node read lock around the trace event. This keeps link pointer=
=0A=
> loads and all dump dereferences serialized against link deletion while=0A=
> preserving the trace contents and reset flow.=0A=
=0A=
> Fixes: eb18a510b5cd ("tipc: add trace_events for tipc node")=0A=
> Cc: stable@vger.kernel.org=0A=
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>=0A=
> ---=0A=
> net/tipc/node.c | 2 ++=0A=
> 1 file changed, 2 insertions(+)=0A=
=0A=
> diff --git a/net/tipc/node.c b/net/tipc/node.c=0A=
> index 683a136e53ef..127848e8a644 100644=0A=
> --- a/net/tipc/node.c=0A=
> +++ b/net/tipc/node.c=0A=
> @@ -1333,7 +1333,9 @@ static void tipc_node_reset_links(struct tipc_node =
*n)=0A=
=0A=
>       pr_warn("Resetting all links to %x\n", n->addr);=0A=
=0A=
> +       tipc_node_read_lock(n);=0A=
>        trace_tipc_node_reset_links(n, true, " ");=0A=
> +       tipc_node_read_unlock(n);=0A=
=0A=
It is not correct using read lock because trace_tipc_node_reset_links() acc=
esses link's queues that tipc_rcv() might access concurrently.=0A=
Please test this:=0A=
=0A=
diff --git a/net/tipc/node.c b/net/tipc/node.c=0A=
index 683a136e53ef..bd91378b7540 100644=0A=
--- a/net/tipc/node.c=0A=
+++ b/net/tipc/node.c=0A=
@@ -1333,7 +1333,9 @@ static void tipc_node_reset_links(struct tipc_node *n=
)=0A=
=0A=
        pr_warn("Resetting all links to %x\n", n->addr);=0A=
=0A=
+       tipc_node_write_lock(n);=0A=
        trace_tipc_node_reset_links(n, true, " ");=0A=
+       tipc_node_write_unlock_fast(n);=0A=
        for (i =3D 0; i < MAX_BEARERS; i++) {=0A=
                tipc_node_link_down(n, i, false);=0A=
        }=0A=
=0A=
>        for (i =3D 0; i < MAX_BEARERS; i++) {=0A=
>               tipc_node_link_down(n, i, false);=0A=
>        }=0A=
=0A=
=0A=
