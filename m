Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010035.outbound.protection.outlook.com [52.101.84.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9B08248B;
	Fri, 10 Jul 2026 03:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783654222; cv=fail; b=naZuce3DnUzznWbkCxaUaiBF+rcAkmbWUfVc5IsboyDlgq3OlcisCfzCc/HAh88z3hXQTpCVfGAsJeRuvGH/CxVjpqK6c3eCBO/4TarNzvD4p58r1jytFJpGTnPz3dYdU08FA8TwNOWQ7ItoQerfPZcayhwBayZLwhYArQBwWUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783654222; c=relaxed/simple;
	bh=Gzjl00M+i8j+XnknPKR1RvvNPe5xAhKK5NCdyOzmNgM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pnAj0uxZWDvuXcpWHzPPZ3/hwpwEOVojcVFfdoaeCYPxPAZ4jjfA3wPq9hE5Gw2PWHJNUm7D7RX0QtIUf/11jfDjtGMH+XZxqrcDLfRJvWl7YZLme93CmCcyuDWfDI+sxuYnc/IrqCATb7JXc+sCmipJRbEK4WV5HdC+RW0X33M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=Zh/tJWVn; arc=fail smtp.client-ip=52.101.84.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="Zh/tJWVn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yCeFZAil7RFxDyllkUeR8DvlBFmKVbUhPcHpZ6VApHX5pYYqxKWqj+BoMgZmbWEBGCyFhb3EqySUZxWiu3qn5Jtg3E0woQKRwNf1ImdOsqo5s7pjxuzAGOBv23PqTS5acP1CFphvzX1NBHecxX1b1widF81NzAeclb2E8b5htQ3tvZJRWr+wfYojNUsXX7p+rvhsn8mnMMHkKeWgqLNrCgJivVICGkO1qja7HD5fWwq1oYtaeV4xczbyH0dGFwE1mkH9EncF3jU51Bk93WmSe/w2SGF6wk9A4yEvNWvZEmkql2UakFLi0oGS92wOPVRV83zqT9cuiGYFn49C6UXpjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAaSFBsk9G9yTMwEematZGrOKQQIpoR3/Q73p0815gw=;
 b=GVoemMyacWC1gTXFNi5XORkKwjV9mj/drqH5xLkWM6uJFO84WsSdKCJp0kPdQNnw+vt8jLALfZvoq0+1FmqtLYOV94q/2+eUZqzNyY8vJf3O51OsH8o1C5JYDBxJCYeVqHSJ7zqmRQUzxNXHafpWab0Je70mrOeXf21VTgtHSlxTrFabolTix5xhfZAt+LS0idrPtq+CNm1tHe7dhcBPzH+66+5OdFjsewv1Yt1dEIFPknMd02o8lFqwQ9TDwhL2psQ7Ochb3Ik1/0POpNHcOeIHtrXjUKSWUncOmYU2ACF3P8Qjl4d6yFj23vqGIWR8na/vALxnFPhmcunuWSNEaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAaSFBsk9G9yTMwEematZGrOKQQIpoR3/Q73p0815gw=;
 b=Zh/tJWVnIHJY3eTI5+xApwuK2xThYDj2X/gmGq6gYQIbV6kNOjyIDVwMBU8YFJc+rMeLbrOwHEfi/edHZUkojzM/yhKeldyVBr35Z/CP9bVyqcwXsPKxUlsxmnO6/5I/8BCbYktDega6TWgRmHk902Ol3iNxAxCg7/Yj2kFZVsQA1BxrztUk0v7rDOfKddelJRyN+Qi9VPK0uBTEtDJ/YrAC+kFUEMl4jqXnxspl9xGiolsE3rgeYSbT159LU2rJh92E5C4rZRc93aGKzmpnyUPrPrMIhokYuMP2bawoI+2e4JwMfP2o409thduOIM7Rz7/zrdg2RH+J5z+tX+C/Uw==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 VI1P18901MB0718.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:124::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Fri, 10 Jul
 2026 03:30:15 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0181.010; Fri, 10 Jul 2026
 03:30:15 +0000
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
Thread-Index: AQHdEA2+rYe7FoCWcUyy82fCjcu5s7ZmGEcQ
Date: Fri, 10 Jul 2026 03:30:15 +0000
Message-ID:
 <GV1P189MB19888A8F810E5DB896F9BAD5C6FD2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260710014440.2055584-1-4ncienth@gmail.com>
In-Reply-To: <20260710014440.2055584-1-4ncienth@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|VI1P18901MB0718:EE_
x-ms-office365-filtering-correlation-id: 124d6cdd-f633-40a1-23d6-08dede338ea1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|56012099006|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 4aSk8A7hfxmHg/pyvdwArtdAmlS0SBAyyquHYLAOeFb1e2+r0KaMqxzJczKfV0eIpjhVyyfjMXvfDapHv+Cw642hG+gc3Rsfha2OaYyQbTc46zH93ZkOXGSjFTT6o8TMkOFKbY31pjvS+lUqg5jGmL0aQfCnHZxVNT5KUN5rlZTBJ3Q9rtVKS1o5NaCGr1a1osfh7kgjksc+LYEsPfxTthbJ8FEJXcyFMoMWY4iHIvu9dS9/DMAJai9s142xE3HxbRalDeVlLoMiNBWgyidqynMuLipXZLojv0Q9LMkBZmKei2eXa9DHcZ/whhbaoNcErHRGBgUDOwKwhNMMDEAijnHJ1I9Bv4BnP5j1BThDY+zJxQ7zn2346mb76OLqS3cjSYuiB+WgfyGwlpRLjrx/fGY/Ap+E+Rj7uRzKzFVXYol8FC8G/2JUyVIOqAO4Iwsvv3aPyaztbjYox4MCSVAUnMe6aSGS+gnBNG/PXgUJk3soBvHpKWr4ph/dSNeNcOKetRHUthZWdabiVW2ONLiHi0UgP7JRdhfFTPpqbx0f/IHDyV92HyquQvKcoWmqHMN3L5Ukt3rGYr7AN6O8utSnsYJz4uxY4yGkA1USSCspjyIvJ0zvHt8V0QDlPYn3UkophAU/pwhp7aqlmbptlhic1MAD2+hjMPoNkRUXmisuqfhSmSmWkWq5OurafmJNH6iYum/zGzo3eIeDyYbRVvaAHni6VR6JPAjI5BY+GjuMdLQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Utoju4a7sRJKabWv361l0qb6FWIoE1NSlFE/j6zHWOYMVhFhe7WAd0gwVQ2M?=
 =?us-ascii?Q?9mdPhH5H48kbeq7biQrCw4C8mUw3QbPLN84LQUTeDHcGmU7+D8aQRP0kr3h0?=
 =?us-ascii?Q?PnIqPAwfVF4fR1L4AF7JLYQL2VyPaDlmobMNFlyEqZMwW9Y/8pH8mfw3RMDZ?=
 =?us-ascii?Q?UIYbKwnHV4X9817lXH8KgPsKZfaNebRhA/X+/GVt+TpwFvJrdIaEPXUQhMLe?=
 =?us-ascii?Q?FaxK6I1Sv/qi0R3fMjH2xFm9OC/7Kr43CZYEX23jQ8r4eJauMYdllADxZzFQ?=
 =?us-ascii?Q?5BBUCbkYPvT60GPZc52tvO4r4GOg6M07aDMuXdexrrlJjlNRY8TlFJBy2iQx?=
 =?us-ascii?Q?kdBxflHpaBB8bcZLuxai65r6ehiMYJy4FJulrmAK/kEMRKnF120XmTVpVpc5?=
 =?us-ascii?Q?gOCkuVoXTRq3WSsRMfUMv9dYbWuxpMfei5KPicqpi7Z0mfhyE1EaRmXhqEbW?=
 =?us-ascii?Q?9Bp7trPGX41+4/WyxGQTBG+EBP8ImNpBXGBzH2iVAIuadGct6zlgQIwLmGLP?=
 =?us-ascii?Q?Hn7rEbFFdBbDh9PTn0OzGCFr4OSOwBJF8H4JJoP6+kVX+uoT6QARKlOXNRuU?=
 =?us-ascii?Q?OLv55RWNoSLGjLseTOXEoVYK+pEZpPXBGA6+YYaIg5f9ZVPzlMuinZd621tl?=
 =?us-ascii?Q?3B1d3sWNNECbhIUz1lKztdL4R9gKjs9iGiW7XH4y/uPX9FSLreuc2FKyagaz?=
 =?us-ascii?Q?86MJW3ABQ71xniT7GkP+veuwmNfM8JFlJp09lKlCIw02mOZgFibRoKy3vK7O?=
 =?us-ascii?Q?QlbcuQT6BPJK3yzNwS7xuqFsXbLY6arvTT/VXB4kkdV52h3jdd7si7EUx5mM?=
 =?us-ascii?Q?eTi1Cc3BO9Tlj9oWP9usx+QvpgY4zGw8JYpj7rmbWIbzq2xnbX5nLqDNNIUu?=
 =?us-ascii?Q?yWmrWj/nYpST3VY9IcLWr5cPQYaZeNrxWy1eVE8KFM6ZhQhVqrwkIorfAX3y?=
 =?us-ascii?Q?I9DQXboohl+NqdWVMr0FBXNikVTwte9+o6MHbHiQv/fLJqrtkHk/Y++OCvjI?=
 =?us-ascii?Q?Pz+o8HFW8/qAZVt/TPk3G8QqwUqx/67vLWqQlwLfv/uuExo0R7dww71jRISk?=
 =?us-ascii?Q?s461wv3G4rb/ZJCeC6BK6FNwsgZupH1umipaU75l/twhbK3rNemJZN7/gyCI?=
 =?us-ascii?Q?UlqJsyzuAOiXszrxt3Pfump+rtgDVgjJHUasLRq8FloE+lYEE+6bq6m5l+nw?=
 =?us-ascii?Q?JeH/iRLnK330S2m5WXuE0Q6yIwFn0LAvzlPPDbBE69ZUCgavOp/8HhZPZo63?=
 =?us-ascii?Q?1DoCfUx82hNqFZoaAvs/XL6TjKlS9AnOJNogfOdiACI696SgkU3IWCRJWVaf?=
 =?us-ascii?Q?IeudB9R40+PGHM7b0AxG7VOe789R3Hmv6jwPqcAhJgCe2vfbujelVGDccI6v?=
 =?us-ascii?Q?j8Qo079eo9CptfMYemmT8QARWw1hU0m5wE3G134pEB72Z1Lf9D2fJDiKNycR?=
 =?us-ascii?Q?b1FetrAtGXJMfl9Pp8RKc1radvjwvVELKil+UWxUbngSY+VBvVfFrU5R8YQv?=
 =?us-ascii?Q?IN/U3J6DP1XY4W1sn3FTZa6tabHbQwOWWlo3Fhuuwj3ZI39guk8WywBMEKak?=
 =?us-ascii?Q?KeekkspKHqG8N8oPkxOJFxNX001mv9Ym/9vxKsAPi8l5uxv9ym7tM8M/MV+j?=
 =?us-ascii?Q?o6wosQrDSinbdlv4rN6r94fRoq6Nx8lGazfVzXv5qHh3Oe+zfn3N9RwJ7LhO?=
 =?us-ascii?Q?CCfDynScTIAIJtco8dqdmJQTk7urBqkhaR64ls7hH32K0wwSIsF0MkrZ426I?=
 =?us-ascii?Q?GnaZ2Ut22Q=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 124d6cdd-f633-40a1-23d6-08dede338ea1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2026 03:30:15.0742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JCwf6AkMnpaS3nNJ0Hu8R0fgh/15/Rf9Faz544wKpOhJJj2QdLzf3NNrLqfhcPita/v5lrAduMfl7QXgwZiVH3G7PKCtwDFhKBlSixnH16M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P18901MB0718

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
>Fixes: 07f6c4bc048a ("tipc: convert tipc reference table to use generic
>rhashtable")
>Cc: stable@vger.kernel.org
>Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
>---
>This was reported to security@kernel.org (Cc: the TIPC maintainer) with no
>response; posting the fix directly to netdev as it is a straightforward on=
e-line
>fix. Full C reproducer available on request.

Yes, please send me your C reproducer.

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

