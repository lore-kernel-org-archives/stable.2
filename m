Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010049.outbound.protection.outlook.com [52.101.84.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5634052DE;
	Mon, 19 Oct 2026 05:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792386131; cv=fail; b=hjyq7vz+srFnMPKZxMAYxwz/e2WwPjd6OGY9MGBTHYSwluWJ9PGfQBCEftgp/dH8l/pUShv8hi2FnrnccFEfVuqDArVVmWEsQjVgZ4+/NX/hjeRcEEpMKmNzwP54GC+ZDTGHknksZrdz+duvsOQfU+3C/93v9QihIFX5l5pS0hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792386131; c=relaxed/simple;
	bh=P3irXrPBcPJ4ZaxW6ZI9lxdC3RFD32IfiPRjARACgMo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ScdMYfrvN96g5T3D2Va8zksVEt7S7YcvKLDCRpDzwJtzxz/hxkP8Qq3PnXCKt7LWpNsK4ZEGHQDWfUXJNJU5zWzD7LDm3fgHAilAeil8bktRN6gdb6M67+EeFmhTpt54BUPFGs4axlJ5vOFvRnG8Yq7FXIgN2QwVr8A5eLaHxNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=wRRRXXG8; arc=fail smtp.client-ip=52.101.84.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="wRRRXXG8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHqSRAykRMM1/I2GiW3PSjbVAKxDq/jIxccJeybAbTFNoAN2zl+TvwolomDuS/NQONE3bIMwJEPUPJLEOhSfXGMneyBQ0ufS8XZPPNh4dLD/fJqDUj5ZyEEZ3+xdQiCQMdAn8MIpbwWNdxKKPbZUazyk9a4xwG0YFai8tvKqGajX7uhQaT6CTSC8hJLMaiz/yYwIzZk7fRcvmZDpaK4dgus6pY9j5BTzsn3VAMjW/bYNdp7jObSP2t75Kah6CEMu7/3CfV0lQbpEVplA4/RyntvOFgckjgJTkH7UpWaMxcxKMcj7a5LN79YjUDwNnAVtvTwPYzdClcUt/vBnAp67sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwE0ixvMnwRHhXfwNSOCEBGnyGl2NMKbWaz5zfGVbfM=;
 b=zS/hny3Zo1BnoEgBEdK2RVWIm2r3WNLvbGo0os00VhPpG9pklMDSJW+CyKwP6mKHZGG//8J2JvlNXsZPKnQGJmwCLSLtOgzDNuT0kr0jcnFs5miIvPkNqsw133pH3Gsfu0EjoB6rtaj9/H435xqEv8D9uuSNktacEDSVAnWaMDhWpS7QsfA69/TgJBrkdn6W4/3fWMCyLbk7JovxVbAg0gND5R9eVQLKa0jjuACvO3qAR3IQtB8q4IkFYztDkGASahiLqN0cJiI6522zazvtGPkDRfj3rvF5iMVtW2AnsPyzlTe7W4HfGyFWPfivst18ERvTYR9pUIrjRv8FbK7Aqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwE0ixvMnwRHhXfwNSOCEBGnyGl2NMKbWaz5zfGVbfM=;
 b=wRRRXXG8HK3TnTg0zJvdYtiizhSVYH/5DYcGHONqFyAdj6eLU7a4viCzqnqVfpiRAtxuBRCZOBm3qZMQWIF/LJ7+bBrVem/bVbMXoAiKuzAWXbHLUErCwCBoWvMiRH0qbCiAi8yY+MV6VNiQ2Fw0oZLkpRyyzUb/jx2pIIeuj6sCcc48rPOn0Vrc4rnmKDpryVvMIakSGD/pArOlbDkbSa6wgXiN3/w6Cq2QtQU25UbkbDenQXo5y88lBTedwvZ6iZ3guWt2RLu1+IZA2KW4eD8BXqVhTgpjeH07QMuUe2PyOglSDknsyUD+yWb5xwT8Se6+VgY+RMEPTSRz2GcFNA==
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:17e::23)
 by AM7P189MB0792.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:114::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 05:01:56 +0000
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5]) by AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 05:01:56 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
	"syzbot+0017742620a9d06f06ef@syzkaller.appspotmail.com"
	<syzbot+0017742620a9d06f06ef@syzkaller.appspotmail.com>, "jmaloy@redhat.com"
	<jmaloy@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH] tipc: unshare skb in tipc_l2_rcv_msg() before decrypting
Thread-Topic: [PATCH] tipc: unshare skb in tipc_l2_rcv_msg() before decrypting
Thread-Index: AQHdXxFMI6h/VC/Yl0yr20c2wH9B8bcETa3g
Date: Mon, 19 Oct 2026 05:01:56 +0000
Message-ID:
 <AM7P189MB1137394C7B76344EB2EB5506C6982@AM7P189MB1137.EURP189.PROD.OUTLOOK.COM>
References: <20261018145928.58317-1-ngocthang2710.1999@gmail.com>
In-Reply-To: <20261018145928.58317-1-ngocthang2710.1999@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB1137:EE_|AM7P189MB0792:EE_
x-ms-office365-filtering-correlation-id: aca2881d-967a-41cb-6027-08df2d9e1938
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|38070700021|56012099006|260925022911599003|260925021911599003|260925021311599003|11063799006|261009223027099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 SYcgZDPoug9d8MQGwhUqvEJmSYIJ06O3BeR7sIciEJqr2dcQ4LbQFwyClFgKGTYzb1m6tKlWA1oPS+dtWRyGxLg4nVbMY1NbJTjhHutanthZYt6uLQYTf4sWTMvIpFcG5Ei28h/Nwu5+KgZEMvrsmbc9A9z83Tlkm2UHpEv5j19M8DfxHlQbqbkjJOTqYKyEdkopfityupo7PV9083V8jIN50ul3fGE34JuMUxjss6ZDlip5RX/yBclHMPBSz3SQFJZRxE/wdvZbzQ4yHyXpepJnWB2uHZSa1u0HT2XALYG9U6fOtsbvVxRa0RUXCF958UfS1bT6CqDLT7iHCwAYdTHgXx2r4nXolGS0RkZTRBlVtGnO1+jdM4G+bFNhY3Tjddb0W32TqfiKCJU9hvmCZHmeodn56LYES88QSvQe+w6JrHgJUjnr8YLeCNhQvdPbbKiR9TqA8hbFCSSBchcw3N5v9jmK2ZMmzaAcQXPrNqoEZMSNz/WQqUnqFk9lOJVB4tu/quQDs4ALi27j8Wf5eyQgT54t0+E8WT4QCB7m0H6C6qnstm7ngvvSeMuT2Z0pluRqcWtEe1zFiKnQN/evC3naCnawGU3XVsIVbYjFssAWkHTTuya6Dkn4CnVzXyRR3q6BIRW7KU00W5JW8XFPzaw7xbQnJRTBLBRkBYZHKPE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB1137.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(38070700021)(56012099006)(260925022911599003)(260925021911599003)(260925021311599003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7XmvRApPlt57zawBgBtkJdYWIGVFyBysRn+hT+Q+UQpOFvHweO1TNqVIu2pq?=
 =?us-ascii?Q?vlbuyzvvfmJqXd9RL0EB0U31+UtpJ6nevTWlyzmoWFjvNlWPlepIuh66XJkW?=
 =?us-ascii?Q?i9EfMJKpgq2/lsK4g15Dm/SNrRzssG7ekeRl9f3/wKiV742CJ7NRlYtc/+LB?=
 =?us-ascii?Q?qsS0QtsjzldVmO5GbOQVr7EW+VFP1v6Y0nWUFa3oKrn3Dy0IhWpk2rtLvvCL?=
 =?us-ascii?Q?74Pc1STt1wYPvEU3UUBYDHE+JY+hAtbKPTaWFeS5oFbYjET4WwpnCvCzX41K?=
 =?us-ascii?Q?uUT5qCgaKgzbcYga70jOGlvsT7Fn1GczRQptuKfmDFofYDH+hgqBwCjsfBue?=
 =?us-ascii?Q?lPCykPIaECfhdTq3/zpvPRN+QpUKbUoqDUDHNz8LVh+64QfuGZM4Hb7jIDNT?=
 =?us-ascii?Q?GNaU7tpTmwe0Nj/QHgf1OpvXZdAqd7cdzgH0LGELy5oJRuohd79BxFtB4Dyf?=
 =?us-ascii?Q?VX8FulahVWOTOvPK1VrLH65SDxvGeha8FjN6k9J5E9reljTh35070cu16x82?=
 =?us-ascii?Q?R3lpHje8wYPrKaYYpZuhXyXbiRCwc5cbvJpPtvNVRJkXzkjeFUtQTVyoUBqL?=
 =?us-ascii?Q?GTCIp+O7K5j7B2EOWojQ0XAT+j3QdK/jLNZ5xuP6riTGrQGI/ujCRnFSe3cU?=
 =?us-ascii?Q?GjwnX3ve3IeirvNL+ZO3RFBV0apO0s1CRCpEFA6FgsV1d1oReaa/6pVn4I6T?=
 =?us-ascii?Q?FVeLZMwSIr9HVyVBwjVc84wFr4VRorVgnCM0AaEfJ6sMAp2MVrWxyFLXfn0v?=
 =?us-ascii?Q?NMWSH/uiNWtA8S9Tu2A4xx6WdOu7tZ6d+45UvSjzcL1CXLVWj/NlmgMkX20B?=
 =?us-ascii?Q?03s+cXntXyY70s1Wq32DPNtXz/sjcuqQFwV8dKZ+jp6uLm9lzGRhzkNb624d?=
 =?us-ascii?Q?JSacXrgiLlF4mEzdRgv+AK+gvHk71Z/CFgocgLinFImcwwaQcrn/sWDIc8u/?=
 =?us-ascii?Q?HXR+dOYJ//hoBWRMf5cvZeLGk/JBULNndI+AL9EdO9LNWgaN2n4Z0E1/r6dh?=
 =?us-ascii?Q?zLgr3q3E+lpJris4YRF2VHJBcfqRQIBEmtZT9BtO/dPFSluA9d77d47XXBgT?=
 =?us-ascii?Q?nApV7viqvu2M10eeyRBl1OUOmNHjVrUXjmU1xmhhW1YymIlIkSgcULNYQIBp?=
 =?us-ascii?Q?deYprHjqYTNThydZ1inspGvBhSHbMAg+FFYe7/t5j8fGIb2QZaOJjWrdQNEz?=
 =?us-ascii?Q?YlPUvSblCjQhQONWrAIjJJE78kpJ6i71qZPUoStcF8ZsiSVjnXpseiSgQNXc?=
 =?us-ascii?Q?Rs9F2dYbsot7ito7MAREzCFPAAYF7yLXRMSCpngxWkrc2vWCFc81gffmWM3G?=
 =?us-ascii?Q?oRJ16pUAOqFuvkfXyba8ztVtDelaF0zEnfbNKHfIOoA5EN7rTMv4dHXO2z/E?=
 =?us-ascii?Q?d999i+Rjns//W1Qi9MHFtdG+B1XwOyL59q+yIOqWehSFraXPhN8IUz7wXGFH?=
 =?us-ascii?Q?WFWJJdyfkymUB+MbzgtlZs0ABZNEb3W0Ct0xuZQvJ0J2bte0V039dwrKCS3I?=
 =?us-ascii?Q?feoVlH0s8iQYF7DMXDF9VaANFg+R8EuMl2f+DukFgIHQq5VQ1l9yZ0b0QeN/?=
 =?us-ascii?Q?pC0mulDvqFgXFSlsfWiEmYCsFj+pT7u6iImkScERyUnd7bRN+Pvkuz/cQ8la?=
 =?us-ascii?Q?vSARExi5deFDy+d5SQZsoX76qODlWUs2ITBubiGdGFKUM5rnf61Q893J/nGs?=
 =?us-ascii?Q?FEQFuBcVD9mLFO+023pn7ze+JmCSnNCpLKRBnKXR4SL5XM2qzyhLKU06TYRq?=
 =?us-ascii?Q?a3OvKMIdxA=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: aca2881d-967a-41cb-6027-08df2d9e1938
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 05:01:56.0864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lhlLChiCs7Rf0aur0k3mGX47PgcW1vR9G9Z6YrzQpJAvG8W1qF+bW+oQdX4nZPt6lUofQjisBK1OIvrBuCS/KVlzCamFsCpCX+owk8zpucM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P189MB0792

>Subject: [PATCH] tipc: unshare skb in tipc_l2_rcv_msg() before decrypting

net tree needs to be specified for bug fix.

>
>Packet taps such as AF_PACKET sockets bound to ETH_P_TIPC take an extra
>reference on the skb before handing it to the TIPC packet handler.
>tipc_l2_rcv_msg() passes it on as is, and for an encrypted message
>tipc_aead_decrypt() calls skb_cow_data(), which may end up in
>pskb_expand_head() and hit BUG_ON(skb_shared(skb)):
>
>  kernel BUG at net/core/skbuff.c:2308!
>  pskb_expand_head
>  __pskb_pull_tail
>  skb_cow_data
>  tipc_aead_decrypt
>  tipc_crypto_rcv
>  tipc_rcv
>  tipc_l2_rcv_msg
>  __netif_receive_skb_core
>
>A packet_type handler must not modify a shared skb. Use
>skb_share_check() on entry, which clones a shared skb and frees the origin=
al
>reference.
>
>Reported-by: syzbot+0017742620a9d06f06ef@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=3D0017742620a9d06f06ef
>Fixes: fc1b6d6de220 ("tipc: introduce TIPC encryption & authentication")

Fixes tag does not seem correct.

>Cc: stable@vger.kernel.org
>Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
>---
> net/tipc/bearer.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c index
>05dcd2f9e887..5e7e220fa7f5 100644
>--- a/net/tipc/bearer.c
>+++ b/net/tipc/bearer.c
>@@ -659,6 +659,10 @@ static int tipc_l2_rcv_msg(struct sk_buff *skb, struc=
t
>net_device *dev,  {
> 	struct tipc_bearer *b;
>
>+	skb =3D skb_share_check(skb, GFP_ATOMIC);

This solution is incorrect and incomplete because:
1. skb_share_check() clones a new skb that shares data part with TIPC while=
 TIPC needs to modify the data part.
2. Checking shared skb in ethernet bearer callback is not enough as we stil=
l have udp callback.

As   I was working on this issue at the time you posted your patch, I will =
send the correct and complete patch.

>+	if (!skb)
>+		return NET_RX_DROP;
>+
> 	rcu_read_lock();
> 	b =3D rcu_dereference(dev->tipc_ptr) ?:
> 		rcu_dereference(orig_dev->tipc_ptr);
>--
>2.43.0

