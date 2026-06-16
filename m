Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011013.outbound.protection.outlook.com [40.107.130.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCDF3EDADF;
	Tue, 16 Jun 2026 07:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781596254; cv=fail; b=aABFtN0oVpb4Vu/B1oPyv/WSiLHeAHz1GdjHDkEc1QCOCo5TDeDFRoIlHTuM5bnTWT+CJwHTn8IShv22lWwtxPeQn1lsn+6I3zwvNAE8+YRZpPCfAq5uZPMfWexSLdlDs4w+AAQwXn0hd9yOEdjZypFMOBLKuBfFw5MecyW6JoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781596254; c=relaxed/simple;
	bh=64qb5bNskwwbRJVyOpbS83wLXH0PxvhuTbIlA23nCM0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nUqqjluZcHGj9OUk8fM3CyIzUjRQBV82klUkjrW919D+ugoadXGFPg5TUPbawQQ7W+9kQprgyOyXiomn8yUFECw2Lvy9EHK1ThnXI2aMCB7Of2oLC3VBsYJlFkfCVOtwpLvOaA0hNO9EUMPJs/bjRHjyg5tKA24UlOaGxq3N5NA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=x1UznE0B; arc=fail smtp.client-ip=40.107.130.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="x1UznE0B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6rVvbhVZDimxHhvRFiPXdxNLZ8jb4XAd+IkNri/TNP5igneM0PWKjKaAWIBNron0/HOp3FtxB+itqetUAycf6IK1ZMMEArPdZLxXxZaKwJMmYmpDVPOE4psdwcSAYwOR+aQSqTK2BsLGbWSgUWJ/AIYaZEKVxJ7KbXPUxJ/nB6iRm2IB+9lHYmLWqIdCvxJ8wFNbR6g03/VinucrTANttRROJHX8UriJ676fcH+i+Gr4j6nMz4RQCk338s1OoFba+FlzHC7r2/Lh7V9imlr0USTgH7RPty+MCGYJoWBDb//ghXiMwhgaEeFn1ScejhstXeAWg6dL9ZZXBJ/9HnawQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yf94zHia2YK8fcyXFUqxflBMqNF4x36DOdWC0rVhX20=;
 b=Dnb7qw5aMbvzpkhxEv4jrChvpN8TE9GhzTZVKbg6GjjLyFfvOJ+Fv6IMf1q3ZBnhbLCailUwEFoB37jyKWQaqsKT1yzdyJUDGXL8RYSNBDuRswIXcMj14UT7LmWyH63EDHKw8Csx9DkW26p2PPB7MLGrx9zTRnJwA6W/0ofn/7aihxBIKNBuLZdAaBwVvq6rDW4vbZN/1ZsRcGaGLm2FJbcMmagFFwixOcOAshhFbWRGUjS7PqYK6nwUugrGv6wOI8PQ5qhclYI+3I0Ep2rwhPd3k1hqXyLx01stqQAOl5LXHECIwq0QknoiXyyMbvilZ4+hXmMw1OY36rVq4ujJbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yf94zHia2YK8fcyXFUqxflBMqNF4x36DOdWC0rVhX20=;
 b=x1UznE0BncueqB3hqCLlw5OB2gMWDhZZ5PoBuILVkpSsAGDiR4FjlzL2cNEgVS95xjwj38a45Og4VrFa2tO/jceuFN3as59VB7I5sIJcLRmF4VxhP4+tfvjBRykCaJ8KPPO4JfEb24u34bckwwKDZ4pbW9JGjFbCBLk6sGzPbaPVxr5fFqNLHg0CFf8pjWNjDHfeIABDAKGiPjQdUHnmmGzDcrvD9dFfSSQPXY4G+FnEhAPSWAovfH2OiT2fNSm6hRSNg+yRPobidxPRKB3V3niaS+r6ptk3RJ7GGHV6u1GOETv/Pn90HV8N8AAIJ/RDHIjVltjwjJF1NuL45350zg==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 AMBP189MB3110.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:6bc::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Tue, 16 Jun 2026 07:50:48 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 07:50:47 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Samuel Page <sam@bynar.io>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>
Subject: RE: [PATCH net] tipc: free bearer discoverer via RCU to fix
 tipc_disc_rcv UAF
Thread-Topic: [PATCH net] tipc: free bearer discoverer via RCU to fix
 tipc_disc_rcv UAF
Thread-Index: AQHc/NgOlS3jRPn6sEuvn9KJLah7KLZAzXLQ
Date: Tue, 16 Jun 2026 07:50:47 +0000
Message-ID:
 <GV1P189MB19887A9A37B5B170C112DF8EC6E52@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260615150009.1734270-1-sam@bynar.io>
In-Reply-To: <20260615150009.1734270-1-sam@bynar.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|AMBP189MB3110:EE_
x-ms-office365-filtering-correlation-id: 260aba40-0012-4518-b7b5-08decb7bfa9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|38070700021|3023799007|22082099003|18002099003|6133799003|11063799006|56012099006|5023799004;
x-microsoft-antispam-message-info:
 iOVTAY8F7fBTDRX5VK00uUkHpTRnL86GCjeYUCCBx8Z50KQSJTqjQ0Akb0E/x8H65NLK2FvNP8TCW6DqkMrLQd7raHj2VVibBb4qcownbe588Fw/tbD4ll8T8UM+OTWxm6mMDn6PeRmdFCuruiPbEAyETrTPz1HS4TDik2asmgOhKQU0M/ueWGBHhokZRb4L0KXBRJ3rQRtPnsxvqQ83uTNLTh19wI72T5kEyOj/v0f+ghkiJvxrg9bOxPAkwMoTOlJu2h8EkJjHX4m40HjeqxmJj4iw+Nk8/GmTuWBbe4J3QTycXXjmrDd6TtsPh67LbTyW9glKZY/mY5FP+Bt9HkQXWWlNKXsvDh+bq2+BvwbOz9XdSaPJ70fjKc+5N3XFb+ZS1apdUH2HxN0ihEPYzbcM+MV0aqw0msbvoPwez2Oso+qXDJEaV7+VfXE5EoOOhMpKT63/Y81aY1mjkKEMZpAbv5T5Wz1XxVO3l2WLXbXNtEFXaLLHeDL45OSL7CYVztN1Z2A5v3L8mCxYp1L0GXZICpjS23E8nXTpT5zcf1webGDAXGu3jCBTpdVHhM4iXduL3XbBpfNEUrYssmek/gIfsirdgzpIwHLjgBfEPVps7gbFGuSBUA7OHtSsoGzZ06daJqRur8Bz8C/9FXmfbMV2LJ45LSzfnJf6Rd8leJDTvzGfr5tvKeV5Mb0uJPyFksXwkBEiPIyxSTwYGt8ReOyyDkqfw0mPIt2+RT/uv5AYauCF6Xyf27E5jrB67Kwx
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(38070700021)(3023799007)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006)(5023799004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gIiEtbodW7GGWhYECVqrCwbxpQrfiWEpu3u5SSKziH9JIaPfzilHnazgaDl8?=
 =?us-ascii?Q?DjZCpLs+g+2iQhQuA7NO86HLXByq34+Ps5eqc39nAVp3M3vmeq6aKAjBw9wc?=
 =?us-ascii?Q?hetM11dIOLeLMuBKxrRQdCh82ZV46b8KX6O4jAzmHWguNiJRUAOGxt9MNlQU?=
 =?us-ascii?Q?AnQf3CvxtqD5UeFZWAIJSP7V/sBotzT/zuV4+y9b3gLJJZ3pN5Tu6IPQdFwv?=
 =?us-ascii?Q?UJU2zNsknfL07u/6I8CqqMp8IAwNqYFuiA9ziQm+7n18jbOUwC6svgTJDnlD?=
 =?us-ascii?Q?2GJy63Gv69nu/S5w98HEUEwzMm+36P9LDsaKg+J6RnFpe/8v3ZMiehrU2O8S?=
 =?us-ascii?Q?j9ySgpCBYHKEbecTZ4gSoGo3+VEJicoO1IADLStGNSI+cP43xVQL3xpxouWR?=
 =?us-ascii?Q?w/UciNx2ripDsP8Atj7rhMt+rGW6RyhmvA/6EpBlh1vRHtTG0GyjDHIAcBnb?=
 =?us-ascii?Q?bCzXTKtCWlPznXrjbvvrosK4HlADb16zj/kW0FDk3NnglAv+plC+p23DsI3d?=
 =?us-ascii?Q?3h5nkf1xQoOwQhQvIljiJjukfD+r68N9J6MXoMb0NSF0RAcYJ2KcEZatjKl5?=
 =?us-ascii?Q?FaJLDu2BR0oSAT3OaOxtoVEqPj01up6pFOEadOxoNpliNUjwodl0EU9+7CWo?=
 =?us-ascii?Q?hRRhEI+LiBR+Cz0Hx2eirPq8G3iVz0/dk1lEZZBasC8ry6D8XpuNcuSYWpen?=
 =?us-ascii?Q?10m5Hf5fi3dRvSKZ4A7RRTrccI2McHA0YHt4l4ZadD+PXO1trtBRQAtHftM9?=
 =?us-ascii?Q?7kVX9/rErOu1ze2+IOp8fZj3F95WvTMtnZESnnWzYiMfhEYyCiIgKo+vD5HI?=
 =?us-ascii?Q?bpRsMbJIJ9gowxeayzEfb9oRR2HoNRX+/hICqjBW086CrZoY7Z5OkHF6hwtf?=
 =?us-ascii?Q?vAaKls5njIBwgvtRTyITJ2v2Ort4MZQbkxeRnSaX4KNNKExIqLuBkwi6GpcD?=
 =?us-ascii?Q?XzhxPXRmwHZcMTw7xj327d9kFeYyVYVA3NbAk5VZg24MREnGcuhoDLWGZalp?=
 =?us-ascii?Q?CHRR96v74AawTNySmB8/ApkY5jk9Fbj+q0mYBZWAnXTZo637MDvMgHSsoT1P?=
 =?us-ascii?Q?Mr4ll6/sdViBsBCXvn3BVZyHEmx2ja37SoEgG0EDCbNQwdjErTxM2VjnWalf?=
 =?us-ascii?Q?ItwzdAWsQYkOOdvQZ/AZT3z/CUGmhuj+MotgG9u2xSEkilvseW3gXYzQiw3G?=
 =?us-ascii?Q?AUCQzlHcIhcxDWtrr+IiIFzPX55cRGD/Q8lyXWrkmQ9cBd+LYzJnPxU9wfEd?=
 =?us-ascii?Q?pZewiJJkXu9rDTg2gEpFiKpr3+hIjPgf2bA+lZ/ECVR8dF+pMP40RX3+tEz0?=
 =?us-ascii?Q?FNDQoTR6DPYX86VwcTmugF5kr0UtvWtBOolgrpO5uLrxu1olzm1Q97tkiiQv?=
 =?us-ascii?Q?YyUqpfxwe1Xh7WwRpaPr3N+vtvzFSw+ZbtaEeQOBZ/FZMlBjMBV9h2Orkqvg?=
 =?us-ascii?Q?0aV6oqzEtkBgzk9UOlxl1XVBzCYjdnAkfvHnTdb7X/LVRMCqEQ7i8LrfraSy?=
 =?us-ascii?Q?zTmdgS7dJceUESOXEUq0FX7zpoFas289JDoGc5G2YNj3cGOZ++bCmpcCmGF+?=
 =?us-ascii?Q?3i/QFq5W8TtfJFfJB8UlhbqJ8Pfxz72NlJLpQudkY6DSV9Es4tSNMNXvhkoI?=
 =?us-ascii?Q?cveikzlNSJSxJLdrAL84h2gGCI5PrqYC/P2hRdG5o/BkdGBl1qKjqqNVsV/9?=
 =?us-ascii?Q?4d3gHs+s5EWRXoCa0x+S/4fBBGwr4sW04NavjcT0vqRLcdUXp6VduMtaBJtg?=
 =?us-ascii?Q?AIJKB2LL9Q=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 260aba40-0012-4518-b7b5-08decb7bfa9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 07:50:47.8828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ucXy7knt0FqXNy+ISMDcm7CcxnYFCmuRTLIEMCeAiXPx41P//yCU1wG0f+beWkW7ckPPfn+ksiHkjFTRGtCRGYU25V4O9+cTLeGTxfBZtSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBP189MB3110

>Subject: [PATCH net] tipc: free bearer discoverer via RCU to fix tipc_disc=
_rcv
>UAF
>
>bearer_disable() tears down a bearer's discovery object with
>tipc_disc_delete(), which frees the struct tipc_discoverer with a plain,
>synchronous kfree(). The discovery receive path, however, still reads that
>object under RCU in softirq context:
>
>  tipc_udp_recv()            // udp_media.c, rcu_dereference(ub->bearer)
>    -> tipc_rcv()            // node.c
>      -> tipc_disc_rcv()     // discover.c
>        -> tipc_disc_addr_trial_msg(b->disc, ...)  // reads d->net etc.
>
>tipc_udp_recv() only gates this path on test_bit(0, &b->up), which is a TO=
CTOU
>check: an RX softirq that observes b->up =3D=3D 1 before
>bearer_disable() does clear_bit_unlock(0, &b->up) can still be executing i=
nside
>tipc_disc_rcv() when bearer_disable() reaches
>
>	if (b->disc)
>		tipc_disc_delete(b->disc);
>
>and kfree()s the discoverer. The reader then dereferences freed memory (d-
>>net, inlined into tipc_disc_rcv()) in softirq context [0].
>
>The bearer itself is freed RCU-safely (tipc_bearer_put() -> kfree_rcu(b, r=
cu))
>because the RX path runs under RCU, but the discoverer hanging off b->disc=
 is
>freed synchronously. The same b->disc is also touched under rcu_read_lock(=
)
>by tipc_disc_add_dest()/tipc_disc_remove_dest().
>
>Free the discoverer with the same RCU lifetime as its bearer. Add an rcu_h=
ead
>to struct tipc_discoverer and defer the kfree_skb()/kfree() to an RCU call=
back
>so any in-flight reader that already loaded b->disc completes before the
>memory is released. The timer is still shut down synchronously up front wi=
th
>timer_shutdown_sync() (which can sleep and must not run from the RCU
>callback), and shutting it down before the grace period prevents the perio=
dic
>LINK_REQUEST timer from rearming or re-entering the object.
>
>This mirrors the existing TIPC pattern of pairing call_rcu() with a cleanu=
p
>callback (see tipc_node_free()/tipc_aead_free()).
>
>[0]: (trailing page/memory-state dump trimmed)
>BUG: KASAN: slab-use-after-free in tipc_disc_addr_trial_msg
>net/tipc/discover.c:149 [inline]
>BUG: KASAN: slab-use-after-free in tipc_disc_rcv+0xe7c/0x103c
>net/tipc/discover.c:236 Read of size 8 at addr ffff000028f07428 by task
>ksoftirqd/0/15
>
>CPU: 0 UID: 0 PID: 15 Comm: ksoftirqd/0 Not tainted 7.0.11 #3 PREEMPT
>Hardware name: linux,dummy-virt (DT) Call trace:
> show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)  __dump_stack
>lib/dump_stack.c:94 [inline]
> dump_stack_lvl+0xb4/0xd4 lib/dump_stack.c:120  print_address_description
>mm/kasan/report.c:378 [inline]
> print_report+0x118/0x5d8 mm/kasan/report.c:482
> kasan_report+0xb0/0xf4 mm/kasan/report.c:595
>__asan_report_load8_noabort+0x20/0x2c mm/kasan/report_generic.c:381
>tipc_disc_addr_trial_msg net/tipc/discover.c:149 [inline]
>tipc_disc_rcv+0xe7c/0x103c net/tipc/discover.c:236  tipc_rcv+0x1884/0x2b1c
>net/tipc/node.c:2126
> tipc_udp_recv+0x22c/0x684 net/tipc/udp_media.c:393
> udp_queue_rcv_one_skb+0x898/0x1798 net/ipv4/udp.c:2441
> udp_queue_rcv_skb+0x1b0/0xa44 net/ipv4/udp.c:2518
> udp_unicast_rcv_skb+0x13c/0x348 net/ipv4/udp.c:2678
>__udp4_lib_rcv+0x1aec/0x246c net/ipv4/udp.c:2754
> udp_rcv+0x78/0xa0 net/ipv4/udp.c:2936
> ip_protocol_deliver_rcu+0x68/0x410 net/ipv4/ip_input.c:207
> ip_local_deliver_finish+0x28c/0x4b4 net/ipv4/ip_input.c:241  NF_HOOK
>include/linux/netfilter.h:318 [inline]  NF_HOOK include/linux/netfilter.h:=
312
>[inline]  ip_local_deliver+0x29c/0x2ec net/ipv4/ip_input.c:262  dst_input
>include/net/dst.h:480 [inline]  ip_rcv_finish net/ipv4/ip_input.c:453 [inl=
ine]
>ip_rcv_finish net/ipv4/ip_input.c:439 [inline]  NF_HOOK
>include/linux/netfilter.h:318 [inline]  NF_HOOK include/linux/netfilter.h:=
312
>[inline]
> ip_rcv+0x21c/0x258 net/ipv4/ip_input.c:573
> __netif_receive_skb_one_core+0x110/0x184 net/core/dev.c:6195
> __netif_receive_skb+0x2c/0x170 net/core/dev.c:6308
> process_backlog+0x178/0x488 net/core/dev.c:6659
> __napi_poll+0xa8/0x540 net/core/dev.c:7726  napi_poll net/core/dev.c:7789
>[inline]
> net_rx_action+0x360/0x964 net/core/dev.c:7946
> handle_softirqs+0x2f0/0x7b0 kernel/softirq.c:622  run_ksoftirqd
>kernel/softirq.c:1063 [inline]
> run_ksoftirqd+0x6c/0x88 kernel/softirq.c:1055
> smpboot_thread_fn+0x65c/0x958 kernel/smpboot.c:160
> kthread+0x39c/0x444 kernel/kthread.c:436
> ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
>
>Allocated by task 68873:
> kasan_save_stack+0x3c/0x64 mm/kasan/common.c:57
>kasan_save_track+0x20/0x3c mm/kasan/common.c:78
> kasan_save_alloc_info+0x40/0x54 mm/kasan/generic.c:570
>poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
> __kasan_kmalloc+0xd4/0xd8 mm/kasan/common.c:415  kasan_kmalloc
>include/linux/kasan.h:263 [inline]
> __kmalloc_cache_noprof+0x1b0/0x458 mm/slub.c:5385  kmalloc_noprof
>include/linux/slab.h:950 [inline]
> tipc_disc_create+0xdc/0x5e0 net/tipc/discover.c:356
> tipc_enable_bearer+0x8b8/0xf94 net/tipc/bearer.c:348
> __tipc_nl_bearer_enable+0x2a8/0x398 net/tipc/bearer.c:1047
> tipc_nl_bearer_enable+0x2c/0x48 net/tipc/bearer.c:1056
> genl_family_rcv_msg_doit+0x1e4/0x2c0 net/netlink/genetlink.c:1114
>genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
> genl_rcv_msg+0x4e8/0x750 net/netlink/genetlink.c:1209
>netlink_rcv_skb+0x204/0x3cc net/netlink/af_netlink.c:2550
> genl_rcv+0x3c/0x54 net/netlink/genetlink.c:1218  netlink_unicast_kernel
>net/netlink/af_netlink.c:1318 [inline]
> netlink_unicast+0x638/0x930 net/netlink/af_netlink.c:1344
> netlink_sendmsg+0x798/0xc68 net/netlink/af_netlink.c:1894
>sock_sendmsg_nosec net/socket.c:727 [inline]
> __sock_sendmsg+0xe0/0x128 net/socket.c:742
> __sys_sendto+0x230/0x2f4 net/socket.c:2206  __do_sys_sendto
>net/socket.c:2213 [inline]  __se_sys_sendto net/socket.c:2209 [inline]
>__arm64_sys_sendto+0xc4/0x13c net/socket.c:2209  __invoke_syscall
>arch/arm64/kernel/syscall.c:35 [inline]
> invoke_syscall+0x84/0x2a8 arch/arm64/kernel/syscall.c:49
> el0_svc_common.constprop.0+0xe4/0x294 arch/arm64/kernel/syscall.c:132
>do_el0_svc+0x44/0x5c arch/arm64/kernel/syscall.c:151  el0_svc+0x38/0xac
>arch/arm64/kernel/entry-common.c:724
> el0t_64_sync_handler+0xa0/0xe4 arch/arm64/kernel/entry-common.c:743
> el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
>
>Freed by task 60072:
> kasan_save_stack+0x3c/0x64 mm/kasan/common.c:57
>kasan_save_track+0x20/0x3c mm/kasan/common.c:78
> kasan_save_free_info+0x4c/0x74 mm/kasan/generic.c:584
>poison_slab_object mm/kasan/common.c:253 [inline]
> __kasan_slab_free+0x88/0xb8 mm/kasan/common.c:285  kasan_slab_free
>include/linux/kasan.h:235 [inline]  slab_free_hook mm/slub.c:2685 [inline]
>slab_free mm/slub.c:6170 [inline]
> kfree+0x14c/0x458 mm/slub.c:6488
> tipc_disc_delete+0x50/0x68 net/tipc/discover.c:393
> bearer_disable+0x18c/0x278 net/tipc/bearer.c:418
> tipc_bearer_stop+0xe0/0x198 net/tipc/bearer.c:757
> tipc_net_stop+0x110/0x178 net/tipc/net.c:159  tipc_exit_net+0x80/0x19c
>net/tipc/core.c:112  ops_exit_list net/core/net_namespace.c:199 [inline]
> ops_undo_list+0x244/0x694 net/core/net_namespace.c:252
> cleanup_net+0x3a0/0x830 net/core/net_namespace.c:702
> process_one_work+0x628/0xd38 kernel/workqueue.c:3289
>process_scheduled_works kernel/workqueue.c:3372 [inline]
> worker_thread+0x7a8/0xac0 kernel/workqueue.c:3453
> kthread+0x39c/0x444 kernel/kthread.c:436
> ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
>
>Fixes: 25b0b9c4e835 ("tipc: handle collisions of 32-bit node address hash
>values")
>Cc: stable@vger.kernel.org
>Assisted-by: Bynario AI
>Signed-off-by: Samuel Page <sam@bynar.io>
>---
> net/tipc/discover.c | 16 ++++++++++++++--
> 1 file changed, 14 insertions(+), 2 deletions(-)
>
>diff --git a/net/tipc/discover.c b/net/tipc/discover.c index
>3e54d2df5683..844975b691ef 100644
>--- a/net/tipc/discover.c
>+++ b/net/tipc/discover.c
>@@ -49,6 +49,7 @@
>
> /**
>  * struct tipc_discoverer - information about an ongoing link setup reque=
st
>+ * @rcu: RCU head used to free the structure after a grace period
>  * @bearer_id: identity of bearer issuing requests
>  * @net: network namespace instance
>  * @dest: destination address for request messages @@ -60,6 +61,7 @@
>  * @timer_intv: current interval between requests (in ms)
>  */
> struct tipc_discoverer {
>+	struct rcu_head rcu;
> 	u32 bearer_id;
> 	struct tipc_media_addr dest;
> 	struct net *net;
>@@ -382,6 +384,17 @@ int tipc_disc_create(struct net *net, struct tipc_bea=
rer
>*b,
> 	return 0;
> }
>
>+/* RCU callback: free the discoverer only after any concurrent
>+ * tipc_disc_rcv() softirq reader of bearer->disc has finished.
>+ */
>+static void tipc_disc_free_rcu(struct rcu_head *rp) {
>+	struct tipc_discoverer *d =3D container_of(rp, struct tipc_discoverer,
>+rcu);

A similar patch was submitted 6 days ago: https://patchwork.kernel.org/proj=
ect/netdevbpf/patch/20260610153349.2546041-2-bestswngs@gmail.com/

I do not receive updated patch from the submitter yet.
Your patch has the same coding style issue (long line, over 80 columns), se=
e linux/Documentation/process/coding-style.rst

If you break the long line into 2 lines and submit again, I think I can ack=
nowledge your patch.

>+
>+	kfree_skb(d->skb);
>+	kfree(d);
>+}
>+
> /**
>  * tipc_disc_delete - destroy object sending periodic link setup requests
>  * @d: ptr to link dest structure
>@@ -389,8 +402,7 @@ int tipc_disc_create(struct net *net, struct tipc_bear=
er
>*b,  void tipc_disc_delete(struct tipc_discoverer *d)  {
> 	timer_shutdown_sync(&d->timer);
>-	kfree_skb(d->skb);
>-	kfree(d);
>+	call_rcu(&d->rcu, tipc_disc_free_rcu);
> }
>
> /**
>
>base-commit: 47186409c092cd7dd70350999186c700233e854d
>--
>2.54.0
>
