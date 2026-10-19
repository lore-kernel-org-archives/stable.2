Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013026.outbound.protection.outlook.com [52.101.83.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A9C4A2A56;
	Mon, 19 Oct 2026 11:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792408166; cv=fail; b=PgnDZ4Wi9/RbB0UtZLsu0VJHx9muvc03+iVttoYFpE2wzr2sbfXWyF4q7oVnbIV60aKvxDtoRTNu/2Nu1rZGmBMCIK9WrAWe13XehihjHehUzUl8blWr+EfaLhxCqYdmowR5tsGDXV/VWQtZKNCmCjakc82k4qVF/66OgKd6+G8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792408166; c=relaxed/simple;
	bh=zgGcXhYzUxzTyLJwjyYvM/R0koGVVU4D+7xpOo6YYRU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U/9YiLQ0FWtAAI7Dtsd+lXc9W87xF1YRBWb3eUIYmjrXduMCqZYCJkUb5GNHqXrU1wO8cIJb0zU/b5ydwO80LUVjRg5I5EcOZjUACS7zwtd4xERRhU94bRo0/Gbp/doCNGtphtuSYFJkHevqwOldStJ6n3GaQt85DdfhmZmlceI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=ElN6AsCI; arc=fail smtp.client-ip=52.101.83.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="ElN6AsCI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZzgpO4pJLL6A72xbsrXn4ZiDQzo/pnj/XU2Mtjzv3WXeX3lYYwDd/XtTx5u6sLQP2AaMm8skj73XUFhAl0FAGCpfjsuO6ATYgzQkcreGH0g8qlLMxEPBFF9VRrGni/e2DR+1LMPxsWDQ5T3OGDI/IUsCBTtQEDSq6EGEj9qNC+4cGCAdY5Elb0Eac+ooNwQHx6jOronZkmN9fSehg2OWw2X9+rg8immflHkYJJOSYoYsNfIs/zmdb06ImgWwqzrmU1FErCZre9WTJlBsv3MWutp/Q2Ou4UMbXi+9tFzDuZee/iB9L73gZmp8zCm18HJKwFiiGn7LrjuI3iiYhC+HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNsvO1PSWSVpOjDqpFzJuZCnPeAAXRGwdSg407GIzAU=;
 b=mcz4KlmmU6z9c1robQI32kVMX+D0uSNzjTt1hYp1R1TbEgFWdkTkUWXq7aLzP24AgsA0QXh0E4x+XSuaTlv1t19IyEdlkKGMnXMH0xzOjZVM9h8b3CstyBu51XGf8jvXctaxxNakGy6tTc2jI0T6KLo3MyuQCS01wi6tGNWregZqfK/9oz/vbiu+Q1bm8iLFHm7JeaoHIgvaL/MffXRpCfU5ctSmSXNqYuDjfy2NHp4Q4uEH0zmtcNxU2TlRHZEKGvSA3TAkJnLIVkDbdKXQeuq4sr1oBdogrAiKYR9y5O/kJbRiMAmkXPGTiK+9hBw2ZipF0BxlEcbUEOcdpR0klA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNsvO1PSWSVpOjDqpFzJuZCnPeAAXRGwdSg407GIzAU=;
 b=ElN6AsCIgMNJqtVZ1wQ3w3A4TUXLIYSPtgMStoDdLP6PwTzs3gb9KEHk+VDGUU3zn0TAK0l7qX2TpbPxoUN9ly6olhpZ5mRO8sl+jQgpELndBy+A+6Uw8tRdjTrw90hXAAYCbf5XPaWgMzWk8iWbrEsm3q9DynTP9cERARAeXhyiFdz7h7hH4cdAISE+iTwarRXGud6zv+NjwCYt96074Oark0AM/KOjc53bBbq5telEE0+85FBfEDEdv5q+ca8zS8m9DzMwusSsui2yxsX9SsodoaeaWP2cpq0GSZOBnL0hqAjnX09XAjrppmlFV1PbYZKFEO6LKGriWrpz+4+BSQ==
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:17e::23)
 by DU0P189MB2066.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:3bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 11:09:20 +0000
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5]) by AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 11:09:19 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Henry Martin <bsdhenrymartin@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
Subject: RE: [PATCH net v3] tipc: fix broadcast sender hang on last acker
 departure
Thread-Topic: [PATCH net v3] tipc: fix broadcast sender hang on last acker
 departure
Thread-Index: AQHdXEvE5nd+AJgSt0W5S4RmB3gvoLcEurJA
Date: Mon, 19 Oct 2026 11:09:19 +0000
Message-ID:
 <AM7P189MB113757F05921D6EAE994B0BEC6982@AM7P189MB1137.EURP189.PROD.OUTLOOK.COM>
References:
 <AM7P189MB11376F05ED2439EDBC2AEE65C69D2@AM7P189MB1137.EURP189.PROD.OUTLOOK.COM>
 <20261015022023.1894729-1-bsdhenrymartin@gmail.com>
In-Reply-To: <20261015022023.1894729-1-bsdhenrymartin@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB1137:EE_|DU0P189MB2066:EE_
x-ms-office365-filtering-correlation-id: a96577d9-6da3-4f8c-da29-08df2dd16c41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|6133799003|18002099003|22082099003|38070700021|5023799004|4143699003|11063799006|10067099003|261009223027099003|56012099006;
x-microsoft-antispam-message-info:
 NK9iRViajHCs2pztalhvbi5TeAbz8XPA5Im337UMWeOS3hIS6BWPmalQreaScHXcp2YZD9Bra8BhYRWSFeYigJLN5yM7JlfBCpsa/PjLw9ZzX87Wu4vwDzxnKCNB3tv7lGNHHnsfntNGr5LZQJSPIZ1T3AA9ObELG37KNJf3mvH32QVck8SjA0fcJusIfZPfI0kLAQVyX0k0fxtKaMQSbid/WeQ781HySnCgjdbicXeP2N/Y4wj6AFHVlAELN4t1z642ZCpwfxxFHF4+9Pohg4PmuE6yWV1s8jd82dj4ffCr/ghQ8dNYU/H+Y9sdPktCxKODOlPtsyviA86Fn8FyjUvycl2t6VSrQ9lfCZmIAH+3nCFVFx6aRjdDT3gLcGXFknVORZwxOCdvTsYI62KQ/KbLvz77tOn9ZKJGWfWs7PIKryOLY9EPS24iOhnEsrAsLy8nlOXL0/FFvMWKPfsfw8fna+Soxt/PFITS3o/YwsL/GQcFmek8NGD/d0iWr295ka+4UfHyHVV9dJxBATp/9s9yxcVIp5wF4Yqbl0HXEpPfiLTBy9kabrl4EETvo2nDtPjPrcHXNyefjPeRf+7K/8XWdHzS9Ah+wu/yPDvX+A7pQd716QJUAlDpq7wEU+e1QimW6zI2OooWatNaZRMtzr/tpp+LZ4e5lXjs+LIHCPaA9U5YKlGsab13AtL0deCCyvPA+dYEOjL2f2Tqv/QnaRrchK2GC5fTCi7/zTfO2XE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB1137.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(6133799003)(18002099003)(22082099003)(38070700021)(5023799004)(4143699003)(11063799006)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ICBXKbDCpdaVH4n02VG5HksS4i7KI7h9Sk4wd2uPz8RFebbsveaJ2AVAmh4l?=
 =?us-ascii?Q?qvbJUmLPEvXqIAsTOdM7un34ErPUe2ueO6R24gC1OPQOHWa8OIwKeRSJE0Xv?=
 =?us-ascii?Q?BOGtvAsIia/D23Y0WhmxyxgURAtwN8X4fic7ubrW1Ng/LHyjF+a6aKhI1Kr+?=
 =?us-ascii?Q?2ZgpYd6k1ZRIsVx4PyiV7+Lc88ZkORSakovZUSSKEjAJT6fQGOpwA/cLaVtI?=
 =?us-ascii?Q?dKJB2Z9d8GfndXehNfSUmxfh/rUp7bBSeQGRJ9CdSrmGXk13GzyTgWUeF6NP?=
 =?us-ascii?Q?rcVIM0ev8UzYUBLythFcKtnkHfZJSram8m7F03B8KfAXtDRhMLHZbGuuehnC?=
 =?us-ascii?Q?+ZcMwZRxHcdi7j3PLo5bIuZ1krQyJXNRJUVM7JuqqkHTlQMWNsnEXLkGSpR/?=
 =?us-ascii?Q?O59N5N/bi4prEIKceI+5LTKiUU2zSvXTPvGSrZ0FrRhH1/u1Boi7ipdNYfPm?=
 =?us-ascii?Q?/lnFo/HKF4X7TYQx/4xYLfLX9ZBB0e8Ic+IrIcUTwHaf0E+n2TNYsYAmkwNY?=
 =?us-ascii?Q?nF8g0l50USHfnJkfj54fDag4ZgFGUbgp7+UbbYS2wlcCSigtcartOQ0mXL4m?=
 =?us-ascii?Q?j+6rFJPtEmkZ9SU1FpIYmI7mmWat5Hw+ftXRuS+oAhMmGk9XR3QTlW8w7dkh?=
 =?us-ascii?Q?zw4xEyIxWGE3apVAkrhNWhqiog8wMmndz2US4/DX6Bjtjh7Rf/xOrV42Svvp?=
 =?us-ascii?Q?wu9fUb9XqSwhkMD24pOy5i/O7yDN0xKhV+nPcfsYG3kR0kWaQu/l5glpMj6p?=
 =?us-ascii?Q?q5b4R1L9tiZwDPfucxfzykOfsPWhJZ+jfJzG/YaDN7I6nr28SGECJI0T03P2?=
 =?us-ascii?Q?iMxySjqH2rhzrDK6FdL/b3YBKjyyuR7ml9JWhNIO1FcEtw/xiydFU8vb3b3j?=
 =?us-ascii?Q?lWp+fwyADreoHqvUJik8craest0lgjf0WumXn3FzpNer8lZDuZ6wSfX00Gqr?=
 =?us-ascii?Q?D6rvr7gV+4XP3iW9fsG2Bj0sbGa03PNS98H8UT2z4ISyCRwpn/KdUJLz3a/B?=
 =?us-ascii?Q?5K828Q/ILKU9Zmg2yVF6rIYRorSM7qQ04407lZdjWjWO66Yk0kuZWylQqbxS?=
 =?us-ascii?Q?m8CpaG+YCmFmLDaGQmV/KU5Q4k8GmISBz9iIUO7VghMKQHDJQ9Z9Q3HOD/or?=
 =?us-ascii?Q?2yq1+qt7hbA+rj2GH0lsB5ZaOAQZkCSpnDohKuyx9SWT6Gs4aUK+OCPsUBx3?=
 =?us-ascii?Q?dOhrCWELgWR/rUJgJxl+Xr8EhGaIkKAKwHvQCjQgF2butS9x3s8B2ZNS0ukK?=
 =?us-ascii?Q?v+W9QhHve0t9Q99X9/Zxzp9QfH9De6hz+kzyOG0G+2eSA65jmBPMOVeJ4Kr0?=
 =?us-ascii?Q?vEeO5zA/HpPnEUouxs15cEcVbJY3l0My+haUBRNR5ytqV8zmAkYCEBvC3yPs?=
 =?us-ascii?Q?MXeQACnh0vHhhpTjj/wM6f66z/FBUttK3a9WCI7F4VjCp8ijxhkQ/IjWRV9G?=
 =?us-ascii?Q?entNLUbjX6XprX7bN+3EeTORFnGBC7Qq+DFdk/M30n32Iw2XVCghzZWh59yO?=
 =?us-ascii?Q?GjsBiRR0MhTySykQL5gPqpFURQ5eyETuW5MbZeoZrIkNp/T5FLh/C+AUsnvJ?=
 =?us-ascii?Q?GPQiDiYysQ8kOQA1BCNpqjRfSV+lP4Rh7S6FS428WEDYd6AwsKSaM6mKK2gS?=
 =?us-ascii?Q?ZZxAuVZH9ophM+WORVqOb/CuhRdiiQjBqODl4YNoZ9/Bn9ErIl2RRYBIhGnj?=
 =?us-ascii?Q?wNX1SAF0OWG2XQMIRi/Vt234nxpbHuoA9QeKAT0w6Et8zrjnx6Xyjg0B7LH7?=
 =?us-ascii?Q?EXg+nDAL+Q=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a96577d9-6da3-4f8c-da29-08df2dd16c41
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 11:09:19.7305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YFhoy40AauqxBScqsmGe++A/32eF4lN4C0wRuflR/lsnAEOCkCWWdNdaai3gUyqusQWb9a/74PL9YNdIWhlU7CMBIUoGoizSFI+aDTXnBjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P189MB2066

>Subject: [PATCH net v3] tipc: fix broadcast sender hang on last acker depa=
rture
>
>TIPC group broadcast senders are blocked while a replicast still has outst=
anding
>member acks: tipc_group_bc_cong() returns true as long as
>grp->bc_ackers is non-zero, and clears *grp->open, which is what
>tipc_poll() uses to report EPOLLOUT (via tsk->group_is_open).
>
>When the last outstanding acker departs before acking,
>tipc_group_delete_member() decrements grp->bc_ackers to zero but never
>restores *grp->open.  As a result poll(EPOLLOUT) never fires again.  A wri=
ter
>blocked in sendmsg() is only released if some other wakeup happens after t=
he
>deletion: with TIPC_GROUP_MEMBER_EVTS the leave event delivery calls
>sk_data_ready() and wakes it, but without member events nothing does and i=
t
>sleeps indefinitely, since the default send timeout is
>MAX_SCHEDULE_TIMEOUT.
>
>Commit 99cc2a62e07a ("tipc: reject invalid and unexpected GRP_ACK_MSG to
>prevent bc_ackers underflow") already calls this out in its changelog as a=
 pre-
>existing issue.
>
>Restore the open state exactly on the 1->0 transition in the delete path,
>mirroring the GRP_ACK_MSG completion path, and invoke
>sk->sk_write_space() from tipc_sk_filter_rcv() when the group just
>became writable again.
>
>Also make the ack accounting precise.  The delete path used to test less(m=
-
>>bc_acked, grp->bc_snd_nxt - 1), which also matches members that were
>never counted for the current replicast (JOINING/LEAVING members keep a
>stale bc_acked), and the GRP_ACK_MSG handler accepted an ack from any
>member whose bc_acked differed from the expected value.  Either could zero
>bc_ackers on behalf of a member that owes nothing and silently void an ack
>still owed by a real acker.  Track whether a member owes an ack for the cu=
rrent
>replicast in a new per-member bc_pending flag, set when the member is
>counted and cleared when its ack arrives, and use it both to accept an ack=
 and
>to decide on deletion.  bc_acked has no remaining user and is removed.
>Suggested by Tung Quang Nguyen.
>
>This issue was discovered by Tencent CodeBuddy Security.
>
>Cc: stable@vger.kernel.org
>Fixes: 2f487712b893 ("tipc: guarantee that group broadcast doesn't bypass
>group unicast")
>Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
>---
>
>v3: Correct the changelog: tipc_group_bc_cong() only writes *grp->open,
>    and a blocked sendmsg() hangs only when nothing wakes it after the
>    deletion (e.g. member events disabled); also require bc_pending
>    in the GRP_ACK_MSG handler so an uncounted member cannot decrement
>    bc_ackers, and drop the now unused bc_acked field.
>
>v2: Subject no longer claims a leak; add the reproduction; the delete
>    path now discriminates members that were actually counted for the
>    current replicast via a new per-member bc_pending flag instead
>    of comparing a possibly stale bc_acked (Tung Quang Nguyen).
>
>Reproduction (two QEMU guests, TIPC over UDP bearer, groups joined without
>member events; the acking peer withheld GRP_ACK_MSG via a test-only knob
>to emulate the lossy peer, the sender's kernel ran unmodified TIPC):
>
>    UNPATCHED (#88/#90, fix absent):
>      sender:  NO POLLOUT for 30s after member departed -> STALL
>      sender2: R2 NEVER returned in 32s (blocked writer not woken)
>    PATCHED (#89, v1 of this patch):
>      sender:  POLLOUT at t=3D18.5s, when the leave event was delivered
>      sender2: R2 returned at t=3D18.6s, EHOSTUNREACH on now-empty group
>
> net/tipc/group.c  | 20 +++++++++++---------  net/tipc/socket.c | 12
>+++++++++++-
> 2 files changed, 22 insertions(+), 10 deletions(-)
>
>diff --git a/net/tipc/group.c b/net/tipc/group.c index
>74f6d3dac0784..b76edd5001ffa 100644
>--- a/net/tipc/group.c
>+++ b/net/tipc/group.c
>@@ -74,7 +74,7 @@ struct tipc_member {
> 	u16 window;
> 	u16 bc_rcv_nxt;
> 	u16 bc_syncpt;
>-	u16 bc_acked;
>+	bool bc_pending;
> };
>
> struct tipc_group {
>@@ -316,7 +316,6 @@ static struct tipc_member
>*tipc_group_create_member(struct tipc_group *grp,
> 	m->node =3D node;
> 	m->port =3D port;
> 	m->instance =3D instance;
>-	m->bc_acked =3D grp->bc_snd_nxt - 1;
> 	ret =3D tipc_group_add_to_tree(grp, m);
> 	if (ret < 0) {
> 		kfree(m);
>@@ -340,9 +339,12 @@ static void tipc_group_delete_member(struct
>tipc_group *grp,
> 	rb_erase(&m->tree_node, &grp->members);
> 	grp->member_cnt--;
>
>-	/* Check if we were waiting for replicast ack from this member */
>-	if (grp->bc_ackers && less(m->bc_acked, grp->bc_snd_nxt - 1))
>-		grp->bc_ackers--;
>+	/* If this member owed an ack for the current replicast and it
>+	 * was the last one, restore the open state so blocked broadcast
>+	 * senders can proceed.
>+	 */
>+	if (grp->bc_ackers && m->bc_pending && !--grp->bc_ackers)
>+		*grp->open =3D true;
>
> 	list_del_init(&m->list);
> 	list_del_init(&m->small_win);
>@@ -394,7 +396,6 @@ void tipc_group_update_member(struct tipc_member
>*m, int len)
>
> void tipc_group_update_bc_members(struct tipc_group *grp, int len, bool a=
ck)
>{
>-	u16 prev =3D grp->bc_snd_nxt - 1;
> 	struct tipc_member *m;
> 	struct rb_node *n;
> 	u16 ackers =3D 0;
>@@ -403,9 +404,10 @@ void tipc_group_update_bc_members(struct
>tipc_group *grp, int len, bool ack)
> 		m =3D container_of(n, struct tipc_member, tree_node);
> 		if (tipc_group_is_receiver(m)) {
> 			tipc_group_update_member(m, len);
>-			m->bc_acked =3D prev;
> 			ackers++;
> 		}
>+		if (ack)
>+			m->bc_pending =3D tipc_group_is_receiver(m);
> 	}

Not sure if you read my comment for your v2:
" This needs to be done in a simple way:

@ -405,6 +405,7 @@ void tipc_group_update_bc_members(struct tipc_group *grp=
, int len, bool ack)
                        tipc_group_update_member(m, len);
                        m->bc_acked =3D prev;
                        ackers++;
+                       m->bc_pending =3D ack;
                }
        }
>
"

--
pw-bot: cr
