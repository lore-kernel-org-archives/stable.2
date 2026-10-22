Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.36
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792631471;
	b=sKyhPYIGhdmz3MiI1dl7advxlkV/Ffx6GRZ9S6FCP1mmdG5o+FWqQyHH37cnk4sE+EQf
	 ZXN0TIgZzjurwtN96GV76xzLdWbBQ3ESJ8OX88h5/G7iBHmsQNwsFc1I/CzJWQL9eL3br
	 pXY2Pn8geXT295eYDgJ2Mqb1wN73bNQ++9GxD6uO8aeXLCZT3Xtnf1qPph/ew9JerI3Ng
	 20DQIZWv9G2p6mp65TUpdqeK44xIQaTTjgnYu7eyf/RaljQWnJUp82c+mBOimMppfOCPQ
	 0UnG1Xvmqf6uFfbj9Hovmlgz5IVcRMa8+FUelW/YqouQ5ma+aBBOjStBteQuAIOegDg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792631471;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=5R+LwMjdJNbRns/2h7ciApnwq0qN4eDhdtqYSN9QnTk=;
	b=QSuZQzbE1s7l/dyAv8hYw1JpCgv/lFQFbGHGn25trP86vZVxxCnhSGNmwWdwbWsk0gUU
	 m4a8xiiAM36vfCt3SUhaZOL/DsJXnKuhKo1O/kpMm/fWeoPxxTbkAGnmdxqxwl4yZ9mRc
	 NKOqIcsu0x414vQiHakI7kG02TVFWQ+Aki5NKluCXDb7Fx0gepdZhMdxEBGAIJ0u+lWrB
	 aiyM40ynSyUo3tVth/XVd4LT0qwPc4ESxiLoUopAv8tBosKd+VPCqisesMzexxfT9qXek
	 Iw2kJQTMtfGsvq0RBLea3EKshkRYxRu6rIjfJmn7CKkcCsfTmDc1+dw7zMT7Yih5+Ng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=est.tech;
	spf=pass smtp.mailfrom=est.tech;
	dkim=pass header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b="J7qH0/Y5";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.36
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010036.outbound.protection.outlook.com [52.101.69.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDAF606A319;
	Thu, 22 Oct 2026 01:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CDAF606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=J7qH0/Y5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPdFZ9hXp6F4X38JVJp1D9qD21kQAxSx6pO3VhGlMztDsZobAtwXD+bOdwofiETT7IDvkday8j+hVKa3+HoEFtiGViql9MQ84NGscKUtkGjNmHMkivvLku6JrX35Ggmulv3jTEu82d5t0i/RJqr087rlXwze+0xAj32NN+uGl8+wYrEUfE1WCmmOdwL9QZ0LJ7iou7QB6OrJAzhevvy7eKOO5I30FV+We8isHJytn/rUZeTv08x6Pl9YKIL1HukRiVa7Z4K3COYOyo8xrxRQB5A41iAMEKLx7TSbtzjFwg96ceBCK6MyawxwEHypfiGSagEHPmQEpOdoh1U1Ol0v2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5R+LwMjdJNbRns/2h7ciApnwq0qN4eDhdtqYSN9QnTk=;
 b=YCvu6fIgLFfHz+qKg8IaPOe7qZ+B1mxwq7NiWEf/c6PQtO7ehJIyO/Twop8OvhaBjOVJJTE1PJz0KGJrQzdwk7G4kffh9XnZFHl3Yly1S5UqJOOKjXN5prX3Jn7hs3TMq8JfWNGN9dyYdoMSodZkiOPIaBaLqGcvCGcMbsv71gms+IzRg8mGX03CWfhkGXgZ9ViRPEMlmiSKHhHKNSibQfPuXeCJmnZBx8D9RoyyrO23cfAOAi5HHlvL8TcxUMSwJnajnxN6gLVX7Cyd+f8QhXKqUfKqt1i4HSgHfce1hj/0L/UqK60mEoj9aYAU+B5oNlemOfR3PTeO8JrmRpkMNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5R+LwMjdJNbRns/2h7ciApnwq0qN4eDhdtqYSN9QnTk=;
 b=J7qH0/Y5YmRwOdsfaElR2hBZoFBcJIDu7+LUGnhK21exCBPrAs/V8gY57iRA1DJe/nMmj9qt3RnGYGbq0gss4cy6WieyqFDYyyq9oHnRAyBLxzQiX9uFBOamfzpqwzjN0EFRIXHC5eGjCU8PpquFg2LGIpeQAR2YFBwEjHkUk5r5sYZOg8IZy5F4JueeTq5r8BXzrakwFAaPYooWYbiIHYgRJAB6gM+SxsSKD3JSl6avFYPGYiRPuUKkvl+fvVAgLllgECKClqPy4kWecDqgC3p74BjFn+Kz8bdyJfPFl5eqfsurcx0gfItBHZ5U9gQp/nL+F72zGwUG0orG8zlTIA==
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:17e::23)
 by GV1P189MB2648.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:17b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 01:11:05 +0000
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5]) by AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5%4]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 01:11:05 +0000
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
Subject: RE: [PATCH net v4] tipc: fix broadcast sender hang on last acker
 departure
Thread-Topic: [PATCH net v4] tipc: fix broadcast sender hang on last acker
 departure
Thread-Index: AQHdX8FEWR74Hp/sWUOPTas7lgSbIrcIxIOw
Date: Thu, 22 Oct 2026 01:11:05 +0000
Message-ID:
 <AM7P189MB1137CC2A59F776640132845BC6652@AM7P189MB1137.EURP189.PROD.OUTLOOK.COM>
References:
 <AM7P189MB113757F05921D6EAE994B0BEC6982@AM7P189MB1137.EURP189.PROD.OUTLOOK.COM>
 <20261019115859.3471295-1-bsdhenrymartin@gmail.com>
In-Reply-To: <20261019115859.3471295-1-bsdhenrymartin@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB1137:EE_|GV1P189MB2648:EE_
x-ms-office365-filtering-correlation-id: e4115703-a1b9-435f-2545-08df2fd9589d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|261009223027099003|261021123027099003|38070700021|56012099006|11063799006|4143699003|5023799004|10067099003|22082099003|18002099003|6133799003|261021135927099003|261021121427099003;
x-microsoft-antispam-message-info:
 cI0y7aquEjFatMqsOYQ7DSdaPwKItWy8izQr0GHK/IdMvP3ponBvj091UuuGQ4WOybx0TZ/0L7yhd7EvYluxZbiDoPuuT9mpPBRoL2/9uaLgMFNA6flNctpxe6YZQ8ZS5lvctgn1jC4DLUjKxwMlNZ1z5p/+SttTXEM0ims6QRb6KoVcQg/BD+/rVpAhP9w++iyuNRRiXQ37RPBkIJcjXMsGTUY0qxkrQzcyAubsINf/LskR3WzD04CQZl6MDdVKfp592MSuSljuRwbcj9bHQcaSLyaq4bf3B7N0lE9zAMsXoQH1GpuV7VNXnWrs0DWI9xFUH3xbeYiMcKMh433Zdr9NfTL9XxvoYEasqkbfMdnXlJ+NYpSmqYonLOdzHAo6W7PCbZCa2tBPQWXD16tlJQmJJ6x28UxEAe+GmEbHxMBETYmZVy4fMVtkmM4DvpqpNTvkxUA6xlqOXIGQ+IfnLfzkuqSdsMnj07CVKtv0xUIcDo2YkdYsEPHsfgAjW3oBYvW3vzfJETWhbPJAImWxDIIG6wT9N3zPE0DoFKRJ4t7HI+Kd4VJKX42mdzRECEOC7GLCfoLAorxr+dWPN0IM0ZMh7s64kBCwhfNoikLS1kgAolIYaatHo2c8Cyiqq3NDG3+HXxufGppDlTmo6Fbf7zfoljouWuP/Ikiy9Tuv40yJ6mcg/VGRxeK4GD9CWJYBPOLCxU/rKJzB29n96wwboNOUMCRSqrngNoWWTrv92E8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB1137.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(261009223027099003)(261021123027099003)(38070700021)(56012099006)(11063799006)(4143699003)(5023799004)(10067099003)(22082099003)(18002099003)(6133799003)(261021135927099003)(261021121427099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qNV8BvuA3snQxX/rpOgkEjhbtvC1qUuUoXjYHUxpbeElDX+r5Au0B8o7cJMZ?=
 =?us-ascii?Q?iOaUS+wrfvibVkLhjthMVMmLWcPFkpvZN87R6W2bMdx12pqgidDv2UyhCAp4?=
 =?us-ascii?Q?OgcR+8MKUp9h2MpvxonmwG6zwjL8ZFjspoDAEisO49HN5eCpS1EfRcn1KAnk?=
 =?us-ascii?Q?MEkX2anmXL/n95JMU96OhuBdyL4vDQSxV8b9qetZBa6sztDr06my+NG3lRUK?=
 =?us-ascii?Q?4pdYrRUoWMz5LJGorbHSKHAUsPOkUw9+lqAslQvWy18spKpvS5+7jyw8ddgz?=
 =?us-ascii?Q?D5hedB/HDo7ELwd6OPQ+rqEtTNfUrfxePsz9g69mTk9KDFYYDgK7XUBVlqf1?=
 =?us-ascii?Q?hy/CaxAwW05ckfEkXfWliXpAn1ZC6oMpaXxKxZVuKV7J/3MXpQJF4y9Ceg5z?=
 =?us-ascii?Q?vgUfqaI0JQEBJt/MMKGXmZqARRrgkSuczrReULXQxtaz0JIe2DgqZkqYzFit?=
 =?us-ascii?Q?9UBB6QhpYPbwg2nhABet6x0+nz/WPw2JcxnxMZUG8VPkQzzdfVgb5G0e7flJ?=
 =?us-ascii?Q?t5/GtFBbE5cTdMmUOI5hEpHG8xDGdJ932Ou1I1p3TSxAepIUaqV3NscrgvZ4?=
 =?us-ascii?Q?SUS+ump3Jqgy3qoOTKsAfFpR3SSYVouSnrdmTXsNcREKZqsEGgNZlIoJ4JJh?=
 =?us-ascii?Q?t36NgOFWWvtCRIFrH7jb3YZnQTt1Rx7MvHZPCy7vzmZuGVzyXmCJlUMBWA7T?=
 =?us-ascii?Q?dV5v/Uu9kwKvt9TCyFMymGGswvGfy55UZ1KJXTezXr4tZlfqGMEZIgtYhnA4?=
 =?us-ascii?Q?tHVyodOc2AQeM9Sp7S509BkUT3aIlkkR0mII6x1tgTsdX2noI4+VuwyduTb7?=
 =?us-ascii?Q?p5LzX/XMFEGbrNOm1PgGwfPZUnwxFzcUKcM8WWmLtEPNew5SRoYK+it2zAfI?=
 =?us-ascii?Q?hHbsaXvmCfrL8x1HdSlh+hDFcTDlW/RMGSdtFMM3rFWdTfBBqd9PmgkmWM90?=
 =?us-ascii?Q?OBMTfkABtW6n1Zo3Fj0WMtm476YQ0Vavl30CjOmcGTXXDZLT3L9jjrx8Yse+?=
 =?us-ascii?Q?73s59GwvtdeiOh9S2FSvDo8aZ0We1Wden/rDUo6DyFZdHit6he+PnlvHO/3h?=
 =?us-ascii?Q?sZsBBu2jqznmjoMV0mwomJuq56UN0CZL2aQK/B3SYMtTK3DcCVUOH7qy1fOw?=
 =?us-ascii?Q?Uwgj6pgWTRJ39Y7hcZDoOKVlagTe2fBA2b7tlCvfp40qbJqoN/xVJfm8krgL?=
 =?us-ascii?Q?A7fvb4QuVvlvIjKouRinoTIuvkfr7Zbdq88YoPZl3xLUudZ2tdE3FjLpdbte?=
 =?us-ascii?Q?ZPBmma63GVZcKzMhPUTs6M9IQ4tsHhvxkhRWyKBwKQUz9MTECbQ5yv1F4px6?=
 =?us-ascii?Q?FDMP5lQ71/eETNOrdd4/k0Zuzyd1CL8PTY/Ts2NPFK721r/ttKXpvvk2njtQ?=
 =?us-ascii?Q?+aQblPKQENff2YdPr79qTjTI3M5byTv7og4Oipo+G3wta7O40i6xoWoY2ckZ?=
 =?us-ascii?Q?h/4yOfnYtkkt1mnLrPPa2KCdV88ZtiijF6yV0By5fdSxjfbe6jAeHXU/ynKo?=
 =?us-ascii?Q?J5l5SRl1RGqlcfD4j74185s64ULhF7KPfSrJkkPLrynuzr+2VLavIf+xz9VK?=
 =?us-ascii?Q?Pu9pOq/rMT6yAkfiW6Tn+pyQQ8L9vZ0DIFHiHZsOtKeNa5vQaYu0Se6BZlMe?=
 =?us-ascii?Q?DCxeAcrwR2GY9DDhkwW2WCiaTckujozOiDpY3DPu3MWkCX4Ytd5R2p8StRvl?=
 =?us-ascii?Q?5P+eYvE2T+AF9BSCuBtvrv94Pv2vX1I/B5nj4DFWuHIRsmgwYKt2a5ED2o0Y?=
 =?us-ascii?Q?gJNHovsBpQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e4115703-a1b9-435f-2545-08df2fd9589d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 01:11:05.0980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yW/FI/RNeEqMLY4MHyo3fKyntM1ALjigdgbOext/9K8ejCHLUycm5V15Fmp8LW8jHv7q7CH4lGnpi5Ha8hoe7rJ1d17tQBJQeb6N8f5+mpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P189MB2648

>Subject: [PATCH net v4] tipc: fix broadcast sender hang on last acker depa=
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

Reviewed-by: Tung Nguyen <tung.quang.nguyen@est.tech>
