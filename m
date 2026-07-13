Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012003.outbound.protection.outlook.com [52.101.66.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E25C35F165;
	Mon, 13 Jul 2026 05:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783918904; cv=fail; b=AM+8LCsCIPG4N0ZOmhrex1yGczcNYw7H/lOXX3N9RlNlg7LJfoYUPvMmAtTpAal3++guKGxHhNnKBhqIQTc4UOdWfJtpH9C5I0yUKpqtJGAi5RcAbvhOZmcMk1J8pPcIktJxtwqXBB+tEN7/Evq7YDlMcMZM1nnKCn38hGjp12A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783918904; c=relaxed/simple;
	bh=6VvdUvMHuXXeo63R0cQfyCGwH7WEcqrnC5GpoUB+nXA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S2Y4w8TpdOyCuqgi162T3xJZTxJdBO+jahbVJUol7kuoo9w1eaAckl2jC4XT+XURxJopa7BxgVAeJRZ16IAuDQGzDZ0UNtPMt7Whdaz7kHntNEYKkTqpNr/yxqPcOP0W3MlOISqrvUZ5gEFGrx/oJ6MDSI2oAx4g5FXi2Wvogk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=Ri1y0Bmi; arc=fail smtp.client-ip=52.101.66.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="Ri1y0Bmi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ii+x3The3cgRjWNTeYbT2JutDFX52tYk6lPrVp/GjzUsKJXnWBS6E+ErF69B5SPb6DMnYUqowxjEMYAkOKZRdBAE4ojVmiO7pM+POgxymt74kY7T9wqLfhga8t4E8pOw5kOPTRYVtZiJjUaZvb4uTYjVzfANNZ6NVZviygx2oljKEzFCcqHwQh/rSW8jos/i+DkNTt2tOmBH/SkmErGpdvApZ3ukoqOk8KgfC6y9XhdmYsqdjziVZtoaNE8EF79HbqJbFIf+NAe/5lhgdMaWJuGQCJI20sGOhQddjvHNnugHpNHUMcPQs50cfWvg2XuKDCs5E31G01IIdy6tCpOMtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hquoJP49SbeCbyLwMzVLp8HA4wQFuJBKqJyytcrt218=;
 b=NSKDL0M9D0SRWx9G2VqHvY67UInqw+k3sXHZ9rpBp6bGIIWcRo+pzakiaZ4m8f/DwGZf55qJQGbi9IOLgXTmFEw8mRwUxhHe27skkiS4j0yHVSDhedVjZ7dLeaXt7dDiv2IWclathBxsdBVDnlN8uZoA6E/DGaQNdxb0CQ298kZXFiFc14pjLRDzI8Trw1P6Cg99o3JyQt0VsIL4p6g2NTODV9DkJjipmL72FGBNzR4AlNeZvTo6xQ7ZWfiEae1rYjnBp12PSG8bTxphhGtWWDpiqXcy0EvY0dwPAnaOXWwwdAUNvyILriV29X9KYMM6MiyTBwCZvVO3a3TeohLi5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hquoJP49SbeCbyLwMzVLp8HA4wQFuJBKqJyytcrt218=;
 b=Ri1y0BmiRQtPYwVMgPw59AlqUWPyFT1EbqoBs2kdJ8cUvNqaHTdAQZF5qmeUkGwKR3d5d5ncvFB0jQMtK7t/uC3d9wLPOFPMAZyhkqVQx5KkvOVViRmeHXvjpsb5jygaMk1OmkA5V32dFmQx57h6wAKVtX7uOT2E/8tKFpoTqZKG+r8nUP2Kump++OMvMkdBPXiQAi6gsHpxwv5w3CIk+Vpun7w7By7SZLa7KY4tpFTAxJjdbaz/yKHlleRVFeCzXcDlcT3FBfhjy0FYbEqTIgjK1uFkTdGsf4oQzqYgSx0Ih1JVd+ddDvqi0QKkn5eKNITL4AwKOnFqlqSgX4m7MQ==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 FRWP189MB3326.EURP189.PROD.OUTLOOK.COM (2603:10a6:d10:17c::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Mon, 13 Jul 2026 05:01:38 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0223.008; Mon, 13 Jul 2026
 05:01:38 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Daehyeon Ko <4ncienth@gmail.com>
CC: Jon Maloy <jmaloy@redhat.com>, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net] tipc: clear sock->sk on the failed-insert path in
 tipc_sk_create()
Thread-Topic: [PATCH net] tipc: clear sock->sk on the failed-insert path in
 tipc_sk_create()
Thread-Index: AQHdEA2+rYe7FoCWcUyy82fCjcu5s7Zq50yQ
Date: Mon, 13 Jul 2026 05:01:38 +0000
Message-ID:
 <GV1P189MB1988AF0F2722101E30D902E1C6FA2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260710014440.2055584-1-4ncienth@gmail.com>
In-Reply-To: <20260710014440.2055584-1-4ncienth@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|FRWP189MB3326:EE_
x-ms-office365-filtering-correlation-id: b43bb2dc-9303-49e9-8fdf-08dee09bd213
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|7416014|38070700021|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 UqQ6rkMp1yI8bbEDuRSV3py7JlhzU2bXkzoMhdiOb1MdMfs4ESikwNQmJXIAHTjpSkAyM/mCzG9A+i5khLM6msKhjKKir316I/tH+iUNUpELE/e1vg+Y6cHsk5eWrWefveUCnE3iXd/A12LlexNgca9vFBqi3RuRpHsGz3P5/a6Kt1DuvaL7ixunjZ/67C8LqzDfCokgTNAGiJ3mFgI6KYjtdOgFGwfOimOjsox5zplFyVf0Pm675tnu42SjbgxN6hFRHWid9+U96RxouTOHsTdGdfIwjE5FxRfbGPQ5K3nIHYZuoR9DNQD1ysXfL3YY/OrIpRgFd5aIF0DWFIeOhZ1DY8NEKuUsm0EYjemNEom6Wk1gau7O6pyV/2uqg5Z1XE0AcifyAmyp6aBWSTwGZv/LiT4z8JcWxnwuUhg9DfpJCLXmfSGbvcdF+LJURlgvJWcBraa+Ax01DXu6HYMkpc5fRI1AUG4slBShclFiol26dLtEn6bqQZk99z8/1cYiyVy8omu+bBMPddcV9nwjXnYkJXPU9DN/5Ryp3kobXQ6mhQixsvaFivk5CBTKYMIeT9iZX/WwPc3wt+/b+TXmM7ud56t15/KmS8m9svzlRKEZ3qcnupWe9mfSYUuUFiMRGwzKWP8djRUzE9qVDE+/BXgIoebsGlWFBDOAY+GuHw/tSZrG3nXhaSdu+XrjPcuS0r7tiOXL7RMr2RuznmxtvbE2YPfPhSukf3B6cQOKV7k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(7416014)(38070700021)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZIl3Qxe0jy6wMdRQPZ38ZTMGgJNR3Y2f2HaziREoIyNKRVuDErx43yKzsQbW?=
 =?us-ascii?Q?TjCdF3iASvw/7xn1ugUS6wL4ZRA0jj7KtbhkpJ/14GAOj6RU3qUo4OUE9JoY?=
 =?us-ascii?Q?1ZQD+t4+PDT+B2w7FVNm6cBn+kFZQmxQX9lPqmql32tyxSPkH9VTKVlw3gx/?=
 =?us-ascii?Q?MUwyzgHGtdEpJ2dNAqCoyAtYShlK9C0iaM/9BFFUECtVHETuBzzzH7n5YAka?=
 =?us-ascii?Q?V/fR8lNoyP8Xuhkj6mRXQvFDlNu0JjRDhZh7wUotdL7TnGPu8fxC+T82LEaH?=
 =?us-ascii?Q?iq9/ro3DxJ7mS1ThUTmWhb4WojXODVirUZxUKbCPdXDap4M+Cn0xiYIq2ytZ?=
 =?us-ascii?Q?GWXx+UMAeTKkjfIneABf0kNRneNVm9u5IZECkUZTtE/5whS9Yt8KboAuuHD/?=
 =?us-ascii?Q?2u+3rMVPMT8GQ9wW1vi+aFnD+nbYaPkcpfoKWtDGvu0T23dS1RgjgXXre0Dd?=
 =?us-ascii?Q?iM+3xVhLvo3s4Wj1C8LgFa7NzF4OO/4CXu6NUFWE0WnCNSXh8w+h5OYUNYOf?=
 =?us-ascii?Q?klfDQh45MUIvgapdJctZHk3U4DGOBpbu/s2c8VJsbcg41nJVFRLwSeLnqczG?=
 =?us-ascii?Q?Gsvk4ztkrJmrCN7luNiNjSXZMinC1XLaK3mHFcJVKMxGQ9x4Lbne1aK3VGgB?=
 =?us-ascii?Q?EJq4uNtJai56d43Rz2nvO1gHp6Mw3Q8KpwZ9KCA05h+GAKqQ1O30vrYtF8gp?=
 =?us-ascii?Q?0LAmhNBa20EdV+gISRaPII/OavSVavvLsePlxsLggCsV5PWr+OZUKh/pA82f?=
 =?us-ascii?Q?nLhhJVs0Yah702o4ciohnuiPDq3p7N6trH/roYycXORFqm0JZBk3mliI77cY?=
 =?us-ascii?Q?fyZVUNIMvCUtlFWWncT4B0cy8V57tEv20KrAkt/Kk78MnvDCOK0oEO17BlqT?=
 =?us-ascii?Q?Bk9wVeSFFS2onvMenUOmNl2MePJ8g0TXatAzAE/eKFCogxLHKRcrXnTGg7Ar?=
 =?us-ascii?Q?yWz2KzSIDCMEIVV2nAuCoI5MfJoRdIpqKCOVT0R5yA9KIN0pvaGT2clTKmVi?=
 =?us-ascii?Q?QfvNT9xa5KoYSZ6/c0UUBlNzL+jRgTcIwe6fFL8H6Uz0cR89sRQMiuKaDec/?=
 =?us-ascii?Q?Ldrrq4QYxj3HPzpaa7kP0MayKLeLzynPAobBYDm4roJdQf2rogaYF+FT3IAj?=
 =?us-ascii?Q?eckDjxiEECUhJzFvmYOs6UAf4o/1/OtpYJ7LD3WvREFQnA63YvKmHr0tncrW?=
 =?us-ascii?Q?vpzciSqrV8evBK4VcTunmXtw2Szm4YFPHARs4KUK8l1pzf3TnxBrlw1R/6JO?=
 =?us-ascii?Q?rcRVOd3uNnN1SsuG22fsOn3VmRYf227pBtm184EwCZLp056rjqhB/CPzMyPv?=
 =?us-ascii?Q?0I2ixhaY0loxnPMC72SiIsW6NIMKIrgm2D7hzezlm6YCjVUR0OsR7/Sba8uf?=
 =?us-ascii?Q?WGIUTaFkfjqyToG/IEguMStUX0ddA2Tc7yXoKVgyejmfeqdtdF4B/hu0bLsU?=
 =?us-ascii?Q?n5WCicAnZXPbpP4iaEGbwuWXwRq+SxzuEkr9f7Zows+Mwya0wnPlX24Pqdd9?=
 =?us-ascii?Q?L/mzMAHVBR+riRrsWYbwgxE3xVbZBs+1VwC/442uV3yMrSk3jS3H6q7Vvi5R?=
 =?us-ascii?Q?9Nw5XkQv4Zjb8Cy7HTNqdOSHQ9e2KGt80BkoQRgBBeS87RnnU6eE4qWfOdCD?=
 =?us-ascii?Q?/tDj5P8RN8IrGhaE+kYpfR83NgqbtoJJuFQbWDrF+7enRcug6dNHgM2gvQgM?=
 =?us-ascii?Q?NbqNSJxeyVznU5ZLFKaD8Htuu8inT+YOYoRIxnzC2497NdCrSHecF/QqHcMp?=
 =?us-ascii?Q?fGsQN+S+0w=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b43bb2dc-9303-49e9-8fdf-08dee09bd213
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 05:01:38.1870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gYfBj0w0ekHXg/S1jYklrXtSoJNduQA9drTqpkJsRDHMY4c+yajlL3u75zS3kEGdXdmu1L1yo12LNGoWNRjCGdlAcIxMlMAEpaBk0nCgYaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWP189MB3326

>Subject: [PATCH net] tipc: clear sock->sk on the failed-insert path in
>tipc_sk_create()
>
>When tipc_sk_create() fails to insert the new socket (tipc_sk_insert() ret=
urns
>non-zero), its error path frees the sk with sk_free() but leaves
>sock->sk pointing at the freed object:
>
>	if (tipc_sk_insert(tsk)) {
>		sk_free(sk);
>		pr_warn("Socket create failed; port number exhausted\n");
>		return -EINVAL;
>	}
>
>This is harmless for plain socket(): the syscall layer clears sock->ops be=
fore
>releasing, so tipc_release() is never called. It is not harmless on the ac=
cept()
>path. tipc_accept() creates the pre-allocated child socket with
>tipc_sk_create(net, new_sock, 0, kern); on failure it leaves new_sock->sk
>dangling and new_sock->ops non-NULL, and do_accept() then fput()s the new
>file, so __sock_release() -> tipc_release() runs
>lock_sock(new_sock->sk) on the freed sk -- a use-after-free write of the s=
k_lock
>spinlock.
>
>tipc_release() already guards this exact "failed accept() releases a pre-a=
llocated
>child" case with "if (sk =3D=3D NULL) return 0;", but the guard is bypasse=
d because
>tipc_sk_create() left sock->sk non-NULL
>(dangling) rather than NULL.
>
>Clear sock->sk on the failed-insert path so the existing tipc_release() NU=
LL
>check fires and the use-after-free is avoided.
>
>The tipc_sk_insert() failure is reached when the per-netns socket rhashtab=
le
>hits its max_size (tsk_rht_params.max_size =3D 1048576, ~2M
>elements) -- i.e. once a netns holds ~2M TIPC sockets every insert returns=
 -
>E2BIG.
>
>  BUG: KASAN: slab-use-after-free in lock_sock_nested+0x98/0x150
>  Write of size 8 at addr ffff8880047cdc38 by task init/1
>   lock_sock_nested+0x98/0x150
>   tipc_release+0xa4/0x7a0
>   __sock_release+0x61/0x120
>   sock_close+0x10/0x20
>   __fput+0x1d6/0x490
>  Allocated by task 1:
>   sk_alloc+0x2b/0x380
>   tipc_sk_create+0x82/0xb90
>   tipc_accept+0x14c/0x650
>  Freed by task 1:
>   __sk_destruct+0x22d/0x2d0
>   tipc_sk_create+0x7b8/0xb90
>   tipc_accept+0x14c/0x650
>   do_accept+0x1d2/0x2a0
>

Thanks for your C reproducer. I can reproduce it and apply the fix. It work=
s.
However, Could you help decode above stack trace (using linux/decode_stackt=
race.sh) to show readable text for later reference ?

>Fixes: 07f6c4bc048a ("tipc: convert tipc reference table to use generic
>rhashtable")
>Cc: stable@vger.kernel.org
>Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
>---
>This was reported to security@kernel.org (Cc: the TIPC maintainer) with no
>response; posting the fix directly to netdev as it is a straightforward on=
e-line
>fix. Full C reproducer available on request.
>
> net/tipc/socket.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/net/tipc/socket.c b/net/tipc/socket.c index
>e564341e0216..55e695748332 100644
>--- a/net/tipc/socket.c
>+++ b/net/tipc/socket.c
>@@ -502,6 +502,7 @@ static int tipc_sk_create(struct net *net, struct sock=
et
>*sock,
> 	tipc_set_sk_state(sk, TIPC_OPEN);
> 	if (tipc_sk_insert(tsk)) {
> 		sk_free(sk);
>+		sock->sk =3D NULL;
> 		pr_warn("Socket create failed; port number exhausted\n");
> 		return -EINVAL;
> 	}
>--
>2.54.0
>

