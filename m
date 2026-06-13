Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010052.outbound.protection.outlook.com [52.101.69.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE37514AD20;
	Sat, 13 Jun 2026 02:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781318078; cv=fail; b=lmc+02I+91qwiJhrLM8BL98PDBZMTbZC2OPoBGNX9pJ3HbqFx7898MGolh+cBLkTNEq3oYt2TNUsfD8JtdYCnBOwjwrDmc18mw3ZRu0w6aSAyo0IDTo0TFenRolocL/oKSnE5S+QclK20rNPd5k1f9yBLKeqiZH8+XudSJv3OKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781318078; c=relaxed/simple;
	bh=aGqqYTGQkihmPQVC0P9NodRVQRLJrHw9eRJdEWurwwE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gamh8Wgn/83kZAFel2lvgyzL1R5KA3AmrUgZ5no7UZd4ILqXVnRhqAbSgY5MtKTpNHhNsFJxRMH8MvWIVkPmdzwSMJtbeIF/r0fkXlKht0AM4TOVijJrKIkhhJ57de5N++WBtiBqZblLdSfWOlQ8+lGO/KAs6gmP+0glJnQKrv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=pS66Ov96; arc=fail smtp.client-ip=52.101.69.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="pS66Ov96"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZmk5SKOSb6tZywp4pFA8eYoqfhnwkxHDM0Qzb4+wrsP0Z+JF+cK1iiGyqJ2lVceghOHDy1hK1GZc4N6txwHyUT4RP+zSIpYMYvAxXRZFgnFEIRASJOPitAvIn4bA1fIvkcygpp3Z2ZLpOtFcPUTZRBvG3mEjqCOHC2S0xdZCB6xor9bQ7gEUFJd850xwTWgTpysG6tVOtA8Xm4+HDZo+5YVwlBMJKRvweMkZMElINt5X5ujH2meJORDDypBxm+o81D/zl0IJfZJ8EkSBG7JHTrYHCoIGBhQt0f/7WR/hpdsCljDmFAshXr5D3cvFYEfclDJQKvNJ/tq3R/5XJgNYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hr+YmFJMCRpwN97KtwskfzBteMfxMYxeFe7eRuHCubQ=;
 b=sMzZy3HWYQSugIV+pXPnY8T+ghbRXwiUVaZusL1fVq8PNZ8ZaPYMk3Vqw3BEBngK3LhMiUgOUChRfHDfxX1zMYRGdjV1U2wzpFlkoiHC9H+rqATttlH7EXJVa42r6t3+N/5PmP+MwkRcCBLmZPwZPHznhV9ztjilr4YaohFf0gDBnnC5IIlhTDTkJO62ZezhJ6wwve0FghiyND8K9epfg4tt4cBqtVf5KHg3DdPlJyFSIRe3PiW+TOw3spBUVIY5VE0MVf61U0KELu8l9sgNT7X2Ejw0L+NMONBTlcPzUs/XES5qr+ovZJVIxIg92FMKZ/3vB9BXoqLoWq9w0Xn7WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hr+YmFJMCRpwN97KtwskfzBteMfxMYxeFe7eRuHCubQ=;
 b=pS66Ov96qj+biRATL/fS+usEqRKrLL8A+APTZOt9nS+jXw9oHuopvcW2xlGatQ5cKzzy3hGQKzNRcRlIJZjPrNXgTfvN8WncQ811oIdvXtuqaQHjO1wdhLANjXHq8FgFS68QBC+MVfvm557fFVNZstAgzrHAbjOMWhEAwsRTUNFktqGewW695pnefeOF0ArVlKv3PzahKcRAzkRV0qUjuXBqyPrq3pN3VHBr0+v/OS5f0uDk9UuI10ctOhDUdqbJKDbSI06hR8Lg25tqGSjdZa+mjjt9a8ItiY2rzR0++W67ommVZJ3e+8BPXnCrYGanWCI8R6JSQcuSTSKIs8zq9g==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 DBBP189MB1276.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e1::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.15; Sat, 13 Jun 2026 02:34:33 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0113.014; Sat, 13 Jun 2026
 02:34:32 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Li Xiasong <lixiasong1@huawei.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "yuehaibing@huawei.com"
	<yuehaibing@huawei.com>, "zhangchangzhong@huawei.com"
	<zhangchangzhong@huawei.com>, "weiyongjun1@huawei.com"
	<weiyongjun1@huawei.com>, Jon Maloy <jmaloy@redhat.com>
Subject: RE: [PATCH net] tipc: restrict socket queue dumps in enqueue
 tracepoints
Thread-Topic: [PATCH net] tipc: restrict socket queue dumps in enqueue
 tracepoints
Thread-Index: AQHc+abxTKPu+3qx0UydtlT8bC9OBbY7xn/Q
Date: Sat, 13 Jun 2026 02:34:32 +0000
Message-ID:
 <GV1P189MB19888A1485EEA4CD4F36CBCEC6192@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260611135647.3666727-1-lixiasong1@huawei.com>
In-Reply-To: <20260611135647.3666727-1-lixiasong1@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|DBBP189MB1276:EE_
x-ms-office365-filtering-correlation-id: 5ab358d7-2cbe-4b5d-befd-08dec8f44d57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|11063799006|56012099006|22082099003|18002099003|6133799003|38070700021;
x-microsoft-antispam-message-info:
 sPR7bS6vNt/n6uJOPn402vJend3icAWz2jtbO8Q/45aHIf97antgjAcoJi1/zvUInkEZgEwNmEGlqu22WeKIUyJlXIarCYxSDxR+wGj4tnMp2p7yy/d1Jm2wwYb6SF3pXkSdqS/Ued9z7JE3CiPVKsho7EbEt0CjixgCMhBPa0RbqUX6RadMFfpOMSYWDNVZldqXpyNFmyU5y+maxxXJ/bynNJeQzUBzR8tveS/dhk5uTmpX2spojWOhoqOSDKh7BGS032vCznRL0JSfGoWo5qq7EH4TM2sAjCsf19lRlBgjVADWl6qdi02qQMr6yVDZRDNMotVBzyiXc4WnZrlH12IlLJb2vpNgoVmsQCsNMCBGizHKRxwcokjeZTO2C+KKTsAcMUElFLy30FxP+76grpTyMLuiBc+la1BZBLLtG0Ly0ey+OKZMyQxQlw+4/Fh0ya15x41puuPCY3r6LgPd/iAZMpI7zW+ZAaO8k9xiB/7SmAB7t1DJs7ggDETfzilJsq6Q0KcvbHQx8xT5ofutT7muHwia+nr9NMvskOtYbYCmTvyJ0CTeBuLrNL/fFrQCCoPqg261FNTd7m3t0lRGOUGX5zCeNiKBjItVzZYkqzEog98k/XxiiqVykiAV8M0XpF4hQTblu9nUkxzsRLEm0AFdsiJcnenh4SVGpKSTDLK1LYAt5F4J+YvGLQMlZUuygTz8x/AM/biDPCfFS6gGcjh/WZ97cwDaVIY8ZRbOtWBIFWwL3yaRA2ywSJuAUrVB
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3ktlhmqzQ4accv6elNe/18xmGzab0nbn6ZuOqCHVOFSsYd5+EC0Tc++2/uzq?=
 =?us-ascii?Q?Sj3jKGop0jMkAi7DoF05inSTc2eXBMMyAfYabKhOeujNzGprR4jCsDhtIK2+?=
 =?us-ascii?Q?o+bJhg/4cAUiOPDe7QcUWiNldfKOjiqoL6aUilW39/JmqC/DPRLWn11HWcMQ?=
 =?us-ascii?Q?sLfGKIHfGBlX6IRPp0jOnN/DN6VrYdlw9JovOmULKCXloeIrZIgEdnJbori8?=
 =?us-ascii?Q?NiHtEhvgT7Ymk2uMWrjEf2NFOyOC1Upv1WrQ56mqaWDIpgOIjzHwXhlh64Wm?=
 =?us-ascii?Q?IndWYO6WxsUt6H+x+5MVMurkNb/qhFGHGCM+TqGI1IsbA0Go5ROQj0sqf/6g?=
 =?us-ascii?Q?IzsRcztvULjy8/omDBUvBQoUYHDkT4fY0JArMgIvNXVP5iQvQiqtKBvARbek?=
 =?us-ascii?Q?jeD9Kc7XPMgZFG7/aOm5yZsVw/mrYHavHgZIUY4D/NoF4E8SVB5tcN1/ZO+8?=
 =?us-ascii?Q?iS8St76jvTY7wGhJTZEB4ayBFfwC1xnoT89qUM8k0qu0Hm3+TnJfMvTCqB7C?=
 =?us-ascii?Q?yQZi1RyfnJfyTjR7ivZ0JfXOKyRVE+BurFKqRk+L8dVrczvQBPxqUaPiNaVp?=
 =?us-ascii?Q?YpO4Fm8fI5UStZBKdGW3UALCdIeC38qIAVXp7zYVjYdXdIupJB1duauql3bB?=
 =?us-ascii?Q?npac3RZnlNNSZKTXM4CCZqtTNbjfuW54qtxMTOV63a9mcTiFVLGSkEfYqYUP?=
 =?us-ascii?Q?HBfo/qbha1AllLPsWoi0bMIjkGDsJYxVAhZZ/F6fjMqk7+hQd0qho3vrbhJo?=
 =?us-ascii?Q?P2+mynjgElDvrD/hw4UvsUFiFVh8bSvGMlSa1idnqShAGnlfsqi6i/84LLat?=
 =?us-ascii?Q?jGErz/LT7soe4LfTk5Um0vYvoZ2OHL8L5XpbRM9mGJhK63x+cAwXZiW8jmZu?=
 =?us-ascii?Q?JyYqe5dluhttHphl5utFJJ2ImAkSMFe8TxGyvzEfjXUbyAcA6ct2jb5IQv94?=
 =?us-ascii?Q?sAKj8jPALF/3LOU5V/RSvORhKKFz/+muV4/TaF540PbOrR7/jk6PdKIvq3ab?=
 =?us-ascii?Q?CbNdg3VxGFk15jfn69dlO1IclU7TDJAKcigrbOAXYjTwGzSsdGudwrml8Kqb?=
 =?us-ascii?Q?31sfzUBrj5LD9qcr3V+0XuavbdgAMoDcIn/QuhSIn7pQzeQG5Zdv4vBFU338?=
 =?us-ascii?Q?WjRVixclp8Oc1CkUnbXcYBoznlsjYVqLBh0FS9ITdWMvmV0EV9lZbl7T1LtM?=
 =?us-ascii?Q?FJ+iYdpgSPYP6on+c2UynlVPs88HhxN3xH+49i7yB3kl6+UfHVIr9fiUSmqo?=
 =?us-ascii?Q?P/kJxCis8/I6Ctn8EKBxdAuaYrjB5BDsrcxkzac+BHifX6aIwxtX7QFj+rEq?=
 =?us-ascii?Q?b9krCeLazMcTmRjVir3yBSnLEWj4s1lZEyLXhtQdzn2kn/vwW7fON2MmDJXs?=
 =?us-ascii?Q?rpTb1P8qgG6iKhmsYXJCAajCdCZC1xb5NobalZlPP2ZWnHftDQODQDsEIWtX?=
 =?us-ascii?Q?4ZJBjn3c1XvTCnJl7DMYNxTNhJRbzoqipZzXQQZ7oQ55YRlvpwFmYIOlmcq/?=
 =?us-ascii?Q?GqVQs3thiI/GiSjSvmkVQL9zZl1WRdxKq+37xWTRkz7UZyRBpBM2cztMmTJY?=
 =?us-ascii?Q?9wCTZ0sfafy27t/4UO0LHlICPuMcwaBlID+8cajW+j5TXGEH4alL9gfUU+CH?=
 =?us-ascii?Q?9+QFy3EevHnrAf1CKDvjX/wsnFIR+5qFufu1ukLl5HsgGq2jKKDKoGUaaV9l?=
 =?us-ascii?Q?OpmkS6TcM+2emeGnoi2+JR8IIs4s2ple+sMeEcA33SIyG4DhwdCun9RNV/Rp?=
 =?us-ascii?Q?J/v5e5LDpA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab358d7-2cbe-4b5d-befd-08dec8f44d57
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2026 02:34:32.7920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AX6Fyskkdgn04kByGQG1GU/502NwIH+JqgIzlBHr4wzpFelqcbrv+jMHOnyOM3W1WqS8wgbE6v30lxWssdYtH9ah7frSqpEpvyliePJKOfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBP189MB1276

>Subject: [PATCH net] tipc: restrict socket queue dumps in enqueue tracepoi=
nts
>
>tipc_sk_enqueue() runs with sk->sk_lock.slock held while the socket is own=
ed
>by user context. The spinlock protects the backlog queue in this path, but=
 it
>does not serialize against the socket owner consuming or purging
>sk_receive_queue.
>
>KASAN reported:
>
>  CPU: 14 UID: 0 PID: 1050 Comm: tipc3 Not tainted 7.1.0-rc6+ #126
>PREEMPT(lazy)
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1
>04/01/2014
>  Call Trace:
>    <TASK>
>    dump_stack_lvl+0x76/0xa0 lib/dump_stack.c:123
>    print_report+0xce/0x5b0 mm/kasan/report.c:482
>    kasan_report+0xc6/0x100 mm/kasan/report.c:597
>    __asan_report_load4_noabort+0x14/0x30 mm/kasan/report_generic.c:380
>    tipc_skb_dump+0x1327/0x16f0 net/tipc/trace.c:73
>    tipc_list_dump+0x208/0x2e0 net/tipc/trace.c:187
>    tipc_sk_dump+0xaf6/0xd60 net/tipc/socket.c:3996
>    trace_event_raw_event_tipc_sk_class+0x312/0x5a0 net/tipc/trace.h:188
>    tipc_sk_rcv+0xb1d/0x1d50 net/tipc/socket.c:2497
>    tipc_node_xmit+0x1c3/0x1440 net/tipc/node.c:1689
>    __tipc_sendmsg+0x97a/0x1440 net/tipc/socket.c:1512
>    tipc_sendmsg+0x52/0x80 net/tipc/socket.c:1400
>    sock_sendmsg+0x2f6/0x3e0 net/socket.c:825
>    splice_to_socket+0x7f9/0x1010 fs/splice.c:884
>    do_splice+0xe21/0x2330 fs/splice.c:936
>    __do_splice+0x153/0x260 fs/splice.c:1431
>    __x64_sys_splice+0x150/0x230 fs/splice.c:1616
>    x64_sys_call+0xeb5/0x2790 arch/x86/entry/syscall_64.c:41
>    do_syscall_64+0xf3/0x620 arch/x86/entry/syscall_64.c:63
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>arch/x86/entry/entry_64.S:130
>  RIP: 0033:0x71624e8aafe2
>  Code: 08 0f 85 71 3a ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 =
4d 89 ca
>4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 =
00 00
>00 00 66 2e 0f 1f 84 00 00 00 00 00 66
>  RSP: 002b:0000716157ffed68 EFLAGS: 00000246 ORIG_RAX:
>0000000000000113
>  RAX: ffffffffffffffda RBX: 0000716157fff6c0 RCX: 000071624e8aafe2
>  RDX: 000000000000005f RSI: 0000000000000000 RDI: 0000000000000066
>  RBP: 0000716157ffed90 R08: 0000000000008000 R09: 0000000000000001
>  R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffff00
>  R13: 0000000000000021 R14: 0000000000000000 R15: 00007fff89799c40
>    </TASK>
>
>The TIPC_DUMP_ALL tracepoints in tipc_sk_enqueue() also dump
>sk_receive_queue and can therefore dereference skbs that the socket owner
>has already dequeued or freed. Restrict these dumps to
>TIPC_DUMP_SK_BKLGQ, which matches the queue protected by the held
>spinlock.
>
>Keep the change limited to the enqueue path, where the unsafe queue dump
>is reachable while the socket is owned by user context.
>
>Fixes: 01e661ebfbad ("tipc: add trace_events for tipc socket")
>Cc: stable@vger.kernel.org
>Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
>---
> net/tipc/socket.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/net/tipc/socket.c b/net/tipc/socket.c index
>9329919fb07f..6b761003bcd1 100644
>--- a/net/tipc/socket.c
>+++ b/net/tipc/socket.c
>@@ -2452,17 +2452,17 @@ static void tipc_sk_enqueue(struct sk_buff_head
>*inputq, struct sock *sk,
> 			atomic_set(dcnt, 0);
> 		lim =3D rcvbuf_limit(sk, skb) + atomic_read(dcnt);
> 		if (likely(!sk_add_backlog(sk, skb, lim))) {
>-			trace_tipc_sk_overlimit1(sk, skb, TIPC_DUMP_ALL,
>+			trace_tipc_sk_overlimit1(sk, skb,
>TIPC_DUMP_SK_BKLGQ,
> 						 "bklg & rcvq >90%
>allocated!");
> 			continue;
> 		}
>
>-		trace_tipc_sk_dump(sk, skb, TIPC_DUMP_ALL,
>"err_overload!");
>+		trace_tipc_sk_dump(sk, skb, TIPC_DUMP_SK_BKLGQ,
>"err_overload!");
> 		/* Overload =3D> reject message back to sender */
> 		onode =3D tipc_own_addr(sock_net(sk));
> 		sk_drops_inc(sk);
> 		if (tipc_msg_reverse(onode, &skb, TIPC_ERR_OVERLOAD)) {
>-			trace_tipc_sk_rej_msg(sk, skb, TIPC_DUMP_ALL,
>+			trace_tipc_sk_rej_msg(sk, skb, TIPC_DUMP_SK_BKLGQ,
> 					      "@sk_enqueue!");
> 			__skb_queue_tail(xmitq, skb);
> 		}
>--
>2.34.1
>
Reviewed-by: Tung Nguyen <tung.quang.nguyen@est.tech>
