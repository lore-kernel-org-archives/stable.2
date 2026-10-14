Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010032.outbound.protection.outlook.com [52.101.84.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D599C531605;
	Wed, 14 Oct 2026 13:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791985225; cv=fail; b=akO40W95KixaFdFcE9juHknjbiF1gL222+5xdmOFYctXHlVcDrFu/QWUnkMSWQD2mfLOsIndO0EKCTPxnwBbMl6dI97Ka5K/yjcVKalIszsMvq4iplYwQDrn1MLp7srlRstnowW+P71JBaRDUL22yeLJ9Z0NcL4n7qukcZBzQEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791985225; c=relaxed/simple;
	bh=a41v3awuDydaysSXZ3qt8uqzweRAeQBR89mJcJZ6crg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J+plj9DwD4e4kcF2d1BJMoLAUnQWilEuMQClSuwtGTZaPVsCSMTGCHBb9Ts+uLgUoACEB+3fw1mNrBuBfhHgjbWe4FP37SNVz5zgE2kC8JbLPuRh+lLjzzS1LqD2oO1Uve0nfaztozXzVM+gCEEbkrARs0tMPZsHw/lSiw8m2CA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=0XICcgsn; arc=fail smtp.client-ip=52.101.84.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="0XICcgsn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tuoS16q32Njpyx/7TTDhoK8v+yuSG3FGMHJZY+pSEIN+eXGJ2IpjLT7mURGI1mXZwWNDGNQjkMDI5gnXolvq4w/pYmjY2ZWmbZxpcFgQuMTtyMimfqrjktSYEWh+KF36RXOfgamASAKT3F8X37mzsy+8/2zbUBFIdLd0WElfgRGpo/k5cOS7HnBrIIegNSG7O9//K/BDcEMLhxkrDVpcXjLB4q/ETtW4ufYOCFPTdjALCLxZ/igVS92mvwvwYZkcrXKdGwgK/h9K0NMBrwhFnZ0vmFO4pFE0UiZiDXN1gtZYeCpMqKE0J1hfsEJyZD7swXKsvw6Jh/muJtbCITd6FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsUaPuJto3N7H0ZgIwfnvd/oFDw1PLd0vFE+Ucs4SV4=;
 b=bHIA1+CryzL0qNcgGDedBtO/BywXLP8UxFx54WuGVVUhfsWWI1q9KDUX6+MNvcA5XEvngtSyV0rRbg9EI1h0GNKmPL8qeQIQmqj0r/vafDcav3RRutyQe/kQ4dis3itgCPDheGN8Yi40ZFy5QXbtkZz3AiY2CK9gppw3GjYx5SzPU4BGh5Z093zEH0veNCsnjUWPJznilU38WUeG7QLxCkBHyII63mbni8qH8Yl6QhP+RUHqezgkp2hq0/KJh3Kao1TxYIXo6xb+k6lJadilUfPCpouCM/SXadNgf8+HEB7bC15WOgLt+5uwl0ciQW16CIWRA6PV/+V0qRL0lcyjWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsUaPuJto3N7H0ZgIwfnvd/oFDw1PLd0vFE+Ucs4SV4=;
 b=0XICcgsndAi7PbxeQvaJ3kuiI21UpfUn8N1tB3RjMkjfu5H7eJR1pIo7FrmkuqN7BWkrFyj0PlemC8N1cfKiYcrRZcf+Cs3K0Y0Ha6cgWf/+yR1gqmTfmu49TghWbdhV68+jpbNJ/cMPyrVId0Cf/GoHWutMNax1Gnulqn7zDQM89P6/Efx4R6bNrzHMtrDYcHYYAl9R85QU8p/JWVJHzoWGDnEmXX4W28hHKUdCxNqSEgp9LUhoc0Ztm6GQQztXGI0Csa0GU6Ho0ZzEoEV0vjqx3Ol86gdE1XIespn3t96w6+uZoIZdRLm2hYoJIU1u61ykLf63Pc59zFXPUDX+1Q==
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:17e::23)
 by AM7P189MB0835.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:14f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 13:40:15 +0000
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5]) by AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 13:40:15 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: "bsdhenrymartin@gmail.com" <bsdhenrymartin@gmail.com>,
	"netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: "jmaloy@redhat.com" <jmaloy@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@kernel.org" <edumazet@kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net v2] tipc: fix broadcast sender hang on last acker
 departure
Thread-Topic: [PATCH net v2] tipc: fix broadcast sender hang on last acker
 departure
Thread-Index: AQHdWl8koyVE7p/RIUucHV5lj/tuvrb7qdmAgAE3CBA=
Date: Wed, 14 Oct 2026 13:40:15 +0000
Message-ID:
 <AM7P189MB11376F05ED2439EDBC2AEE65C69D2@AM7P189MB1137.EURP189.PROD.OUTLOOK.COM>
References: <20261012153357.1863316-1-bsdhenrymartin@gmail.com>
 <179190865919.434549.2450236888091417368@kernel.org>
In-Reply-To: <179190865919.434549.2450236888091417368@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB1137:EE_|AM7P189MB0835:EE_
x-ms-office365-filtering-correlation-id: 4aaa07c6-cd5e-4cad-0999-08df29f8adac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003|23010399003|38070700021|56012099006|11063799006|5023799004|4143699003|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info:
 JuTI6f1jfMQR7V/DFx7WnvHY5y/kHvd74Fcq6SqxUIY7TM7SUVh4vA1ciz+bWW6/lYI5LuRW3CKFyclMghDj7+Dybthv8ab5zP/dpp/V6yvkE4u3pWkLVyPoOIO/ufb9TfhUzGI3VFiEcQQYm+oEsD79yJx3y+Z0doFwW1X4lb5eBTHPoz9dLFY1KOUgSyC7/GbokOJpTk5HTAte/N+IJ6bSPxH4yNEpvskjj5avjBORaHtLGr5ideGxebbuh3Zb6q9dmMU3jdbSNKJnmWEZgR47yg9Zzf8GU6Qh4nhiFJh0ykgo/uuM8ymPr5Db8FMMC8p3GM+g5L/Z3n6pfGiKPuUF5lLykEIJEE6h4rNrcE1XNsewkCfMZrAnu7LZ1LXSmi1n96J8EjWAXpAbaYKV6XjmFj8mppApYsEuleCSo5ebXElTrkQ1f9IeBUj7gI2ip9xqSin92KwzXM3Vdx2IYe1p9KZiud8csdsuTJZYZwsj+3vJBW7+8KP5Hbt1GrZPNV6Sckj8AmwJD025Fh4/DUScB2JvJ5ueDF5DnrkyKJW+tbIl1uX0Uhe/qFGtn62yCWnnbXW+i2iqDa6j7vhdisDrovSR3UVSOpqIkggAkSURc9UBHtyCWhYWEPGDjtJ3IqlhWFdWDO5a3FkliDsg18E4/7tg3kaA1tKV2Yn3pNa1KJ0dpdnhffU5EvBzBnx5qaTVHg/ph9P6zcY5so7SYdkaguBCNulVPehK2kiAfWo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB1137.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(23010399003)(38070700021)(56012099006)(11063799006)(5023799004)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?W+oDUHa5FggTaLBJ1HvCQqU7bN2qE6yu+fcI5ZuqO8QSNaaXHoKjvLyF?=
 =?Windows-1252?Q?6EoNQzPy+CsRhbkzAFpVjRjsASTC87JQB+KUf79IpBacMuWdS6TNH4r4?=
 =?Windows-1252?Q?xCHdXc53XcuXnjtJEfATZDjNbVREYdm8+YaNrToQpqkvUvvAsbGOSgye?=
 =?Windows-1252?Q?nzNNVevMgtnMksNwNWsQXWYltyVYgy4qeAqWnUe4bFUgTpQEtbWflBj+?=
 =?Windows-1252?Q?IqSESZJKqfS4OfdXTdJfoWuYBwAddF+h8vLa0QWv3iZQyPJG9GiVQiKQ?=
 =?Windows-1252?Q?aeq6/ojw/crmNVhb9Ov/oSdf+1CpuNKdFnRN/6nlvfUdP37ZLr4rvakx?=
 =?Windows-1252?Q?sNHWIGV/ByW5NEH/51QkLwdLieQCAgpkW0Fmg+tFDULNZasmd1TO0UIm?=
 =?Windows-1252?Q?64L8GoqNRXZrMg6KQE0smfpBf7YSSk/raEh07cIdDfgCBnr3XludEGjf?=
 =?Windows-1252?Q?sDLpVF5N/e/Dhil1XhYHvvsCBHjiLK04G7dOldqz53Oafr5D4ej6LAk2?=
 =?Windows-1252?Q?LwrK6EDevLh7hzZ1Owo4n+4WlgQCRIjLP23F87uDs93wPJz1VqTs+vXr?=
 =?Windows-1252?Q?mJDf/Py5UlZQGh/6VtvihJlxuHOTD12J9V2jXgv7NRw0bBZ6JaaXnUf1?=
 =?Windows-1252?Q?6zbus7lvXOiBHOG6sIMt9lJNsvSRZ7V1kU6vA8KfEhrOFTAmhx/h1y1Q?=
 =?Windows-1252?Q?5E+oPw+NL+KtP6JbN0ucMPEdppzwXKFcRW8wTNCYeNN3ZKuop8qFjpDS?=
 =?Windows-1252?Q?bVT5QvrS9gu9ydmetqZkgkVqScXDle+sMjNGYUw38WH0IV4jdKyU8bwZ?=
 =?Windows-1252?Q?4mU4+EXxxHFlV6hfQni5q015idsWCc3ufdEnzcGFBtUmivvgIZiALu8H?=
 =?Windows-1252?Q?6XiJQTBRn0EpMdIb1aeFz3C5yZaIbbsY6fO5gUnSTkfDVSLAle/1M+es?=
 =?Windows-1252?Q?KBTBhIp+ASnygB54ipanTiIcK2jDOgBYpJnTfpXfb8IbqnqJd99j74Ti?=
 =?Windows-1252?Q?stW45uO0WwoyeLm9bxYnaVXFJDJf4/3XKf1WqTLc34f35L7t3sAVHej8?=
 =?Windows-1252?Q?hZo0EvWjPgyPSo3eALJW0zqyeAjFHBDa7pIzFROy6je3y0qxCFUUJqmA?=
 =?Windows-1252?Q?8K6HPe6pt9dILsOjIkb+6rc0RoL6YqUvfuwhS3CyXQ04pKoeveWrlHjs?=
 =?Windows-1252?Q?VkkjR7plpTtgezEA5zMqM17bU5LpYNo4l7QzmZnJ3LylJAMXpGEYgeJ4?=
 =?Windows-1252?Q?oQ/zMAytoi8MQXOYlRi3oe+iKCcK5+j3FZws3cjU+cs2y2zyq0MZECgo?=
 =?Windows-1252?Q?LaP9YpHTRa++cA2DehdUlpOjadWwylSDbiPVgoDKkiAGL6C6yBB36+gV?=
 =?Windows-1252?Q?kmiHZY4Qei1QTqAwdgu0nlrUQuCZDHpApleROcLiANzoBBhouiSeX0qC?=
 =?Windows-1252?Q?4Q6WSb2jaKfdl0ngTzZNEjXuaIYTW3M3wFr8W3FT9I7KruISagleOKVv?=
 =?Windows-1252?Q?7IZo0r2iydKhVnO0Sa/fMGTJxQjkgZS7ySbppI06n0FGVYk0UOAU6Cqj?=
 =?Windows-1252?Q?8KFLWOHJQTuldEl1ugTr2OOeAoaP8SXjGAMB8I15BugmJA8t3JCEfSb1?=
 =?Windows-1252?Q?zRsF9BJwsHXjgq4le5yZ1qpRsBhPbN/qHFEoi4oGjdaseniM0g9pDxCa?=
 =?Windows-1252?Q?v0f2Cm+t9FjTlNes/lX09wIE0bhePCm5x9UHsxSf6R5/9WIV9FeI9rF8?=
 =?Windows-1252?Q?gwZKph2LQpJkDdCBMkF4ozRrIZF1hJwlVC8/5wiozWTP5HlnREnzJIqn?=
 =?Windows-1252?Q?bCyM3kN2pHX1E7vQp7NmZZbMWmhQH+ACUFfSd13x+WWqFOqaMANNOK/2?=
 =?Windows-1252?Q?m3b4QhS6xJZarfv0Lr0VIlydbwmD2xJgJcEqbyVy/zZbOIXbbOWJFh6J?=
 =?Windows-1252?Q?Ry/j2LQ2?=
x-ms-exchange-antispam-messagedata-1: lOVkyrA/89A6Dg==
Content-Type: text/plain; charset="Windows-1252"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aaa07c6-cd5e-4cad-0999-08df29f8adac
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 13:40:15.2243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cM+lTUsVDgGEw/d/YYKIqAdQXKF/cTAiSetM3ks6STxBbU8uXEr7hqwH1/k8QAf4JchPD/lQeVpxXEuxmx94lUUtH49gAXdnCvO68swOuJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P189MB0835

>Subject: Re: [PATCH net v2] tipc: fix broadcast sender hang on last acker=
=0A=
>departure=0A=
>=0A=
>Thank you for your contribution! Sashiko AI review found 2 potential=0A=
>issue(s) to consider.=0A=
>=0A=
>Critical: 0 =B7 High: 0 =B7 Medium: 1 =B7 Low: 1=0A=
>=0A=
>If you believe none of the issues are legitimate, please reply to each iss=
ue of=0A=
>Medium severity or higher and explain why the AI is wrong.=0A=
>If any of them are legitimate and you plan to respin, please let patchwork=
=0A=
>know by including "pw-bot: cr" as a separate line at the end of your reply=
 (one=0A=
>such reply per series is enough).=0A=
>=0A=
>- [Medium] The patch adds m->bc_pending so that only members counted for=
=0A=
>  the current replicast can reduce grp->bc_ackers, but it checks the=85=0A=
>- [Low] The commit message gives the wrong reason why blocked writers=0A=
>  stay asleep, and it overstates when the blocking sendmsg() hang=85=0A=
>=0A=
>--=0A=
>=0A=
>tipc: fix broadcast sender hang on last acker departure=0A=
>=0A=
>This patch restores *grp->open when the last member that owes a replicast =
ack=0A=
>is deleted. It also calls sk->sk_write_space() from tipc_sk_filter_rcv() w=
hen the=0A=
>group becomes writable again. A new per-member bc_pending flag limits the=
=0A=
>bc_ackers decrement in the delete path to members that were counted for th=
e=0A=
>current replicast.=0A=
>=0A=
>> TIPC group broadcast senders are blocked while a replicast still has=0A=
>> outstanding member acks: poll(EPOLLOUT) only fires when=0A=
>> tsk->group_is_open, and writers keep re-sleeping on every unrelated=0A=
>> data-ready wakeup because tipc_group_bc_cong() keeps seeing *grp->open=
=0A=
>> =3D=3D false (the default sk_sndtimeo is MAX_SCHEDULE_TIMEOUT, so there =
is=0A=
>> no bounded send timeout either).=0A=
>=0A=
>[Severity: Low]=0A=
>Is this description of the mechanism accurate? tipc_group_bc_cong() only=
=0A=
>writes *grp->open and never reads it:=0A=
>=0A=
>net/tipc/group.c:tipc_group_bc_cong() {=0A=
>	if (grp->bc_ackers) {=0A=
>		*grp->open =3D false;=0A=
>		return true;=0A=
>	}=0A=
>	if (list_empty(&grp->small_win))=0A=
>		return false;=0A=
>	...=0A=
>}=0A=
>=0A=
>Its return value depends only on grp->bc_ackers and the head of=0A=
>grp->small_win.=0A=
>=0A=
>> When the last outstanding acker departs before acking,=0A=
>> tipc_group_delete_member() decrements grp->bc_ackers but never=0A=
>> restores *grp->open, and the blocked senders are never woken.=0A=
>=0A=
>The old delete path already brought bc_ackers to 0 when the last owing=0A=
>member left. That member has bc_acked =3D=3D S-1 and bc_snd_nxt =3D=3D S+1=
, so the=0A=
>less() test matches.=0A=
>=0A=
>tipc_wait_for_cond() waits with woken_wake_function, which ignores the pol=
l=0A=
>key, and tipc_data_ready() wakes every sleeper on sk_wq.=0A=
>=0A=
>So with group member events enabled, the sk_data_ready() after the leave=
=0A=
>event is delivered already woke the writer in tipc_send_group_bcast().=0A=
>tipc_group_bc_cong() then returned false and sendmsg() went on, returning=
=0A=
>EHOSTUNREACH if the group was now empty.=0A=
>=0A=
>The poll(EPOLLOUT) hang does look real in every case, because tipc_poll() =
only=0A=
>sets EPOLLOUT when tsk->group_is_open is true.=0A=
>=0A=
>The blocking sendmsg() hang seems to happen only when nothing wakes the=0A=
>writer after the deletion. One example is group member events being disabl=
ed.=0A=
>In that case TIPC_GRP_MEMBER_EVT is freed with deliver =3D false and=0A=
>sk_data_ready() is never called.=0A=
>=0A=
>The code change itself looks correct. Since this is tagged for stable, cou=
ld the=0A=
>changelog describe the actual wakeup path and say when the=0A=
>sendmsg() hang occurs?=0A=
=0A=
Please rewrite the changelog.=0A=
=0A=
>=0A=
>> diff --git a/net/tipc/group.c b/net/tipc/group.c index=0A=
>> 74f6d3dac0784..e9c77f12c9819 100644=0A=
>> --- a/net/tipc/group.c=0A=
>> +++ b/net/tipc/group.c=0A=
>=0A=
>[ ... ]=0A=
>=0A=
>> @@ -340,9 +341,12 @@ static void tipc_group_delete_member(struct=0A=
>tipc_group *grp,=0A=
>>  	rb_erase(&m->tree_node, &grp->members);=0A=
>>  	grp->member_cnt--;=0A=
>>=0A=
>> -	/* Check if we were waiting for replicast ack from this member */=0A=
>> -	if (grp->bc_ackers && less(m->bc_acked, grp->bc_snd_nxt - 1))=0A=
>> -		grp->bc_ackers--;=0A=
>> +	/* If this member owed an ack for the current replicast and it=0A=
>> +	 * was the last one, restore the open state so blocked broadcast=0A=
>> +	 * senders can proceed.=0A=
>> +	 */=0A=
>> +	if (grp->bc_ackers && m->bc_pending && !--grp->bc_ackers)=0A=
>> +		*grp->open =3D true;=0A=
>>=0A=
>>  	list_del_init(&m->list);=0A=
>>  	list_del_init(&m->small_win);=0A=
>> @@ -406,6 +410,8 @@ void tipc_group_update_bc_members(struct=0A=
>tipc_group *grp, int len, bool ack)=0A=
>>  			m->bc_acked =3D prev;=0A=
>>  			ackers++;=0A=
>>  		}=0A=
>> +		if (ack)=0A=
>> +			m->bc_pending =3D tipc_group_is_receiver(m);=0A=
>>  	}=0A=
>>=0A=
>>  	/* Mark number of acknowledges to expect, if any */ @@ -803,6=0A=
>+809,7=0A=
>> @@ void tipc_group_proto_rcv(struct tipc_group *grp, bool *usr_wakeup,=
=0A=
>>  		if (acked !=3D grp->bc_snd_nxt || m->bc_acked =3D=3D acked)=0A=
>>  			return;=0A=
>>  		m->bc_acked =3D acked;=0A=
>> +		m->bc_pending =3D false;=0A=
>>  		if (--grp->bc_ackers)=0A=
>>  			return;=0A=
>>  		list_del_init(&m->small_win);=0A=
>=0A=
>[Severity: Medium]=0A=
>Should the GRP_ACK_MSG handler also check m->bc_pending before it=0A=
>decrements grp->bc_ackers?=0A=
>=0A=
>The new test in tipc_group_delete_member() assumes bc_ackers equals the=0A=
>number of members with bc_pending set.=0A=
>=0A=
>This handler still decrements bc_ackers for any member that passes the ack=
ed=0A=
>=3D=3D grp->bc_snd_nxt and m->bc_acked !=3D acked checks.=0A=
>=0A=
>Two kinds of member can pass those checks without having been counted:=0A=
>=0A=
>- Members that were MBR_JOINING or MBR_LEAVING when=0A=
>  tipc_group_update_bc_members() ran keep a stale bc_acked and get=0A=
>  bc_pending =3D false.=0A=
>- Members created after the replicast have bc_pending =3D false and=0A=
>  bc_acked =3D bc_snd_nxt - 1 from tipc_group_create_member().=0A=
>=0A=
>For both, a GRP_ACK_MSG carrying acked =3D=3D bc_snd_nxt passes every chec=
k=0A=
>here.=0A=
>=0A=
>For example, with bc_ackers =3D=3D 2 for counted members A and B:=0A=
>=0A=
>  ack from uncounted member X     bc_ackers 2 -> 1=0A=
>  B acks, or B is deleted         bc_ackers 1 -> 0, *grp->open =3D true=0A=
>=0A=
>A still has bc_pending =3D=3D true and has never acked.=0A=
>=0A=
>Isn't this the case the commit message gives as the reason for adding=0A=
>bc_pending, where a non-counted member "could silently void a still-=0A=
>outstanding ack from a real acker"?=0A=
>=0A=
>A cluster peer can trigger this. It sends GRP_JOIN_MSG, which makes=0A=
>tipc_group_proto_rcv() create an MBR_JOINING member for any port. It then=
=0A=
>sends GRP_ACK_MSG with acked =3D=3D bc_snd_nxt. I could not find a benign=
=0A=
>protocol sequence that ends up here.=0A=
>=0A=
>Would something like this close the gap?=0A=
>=0A=
>	if (acked !=3D grp->bc_snd_nxt || !m->bc_pending)=0A=
>		return;=0A=
>=0A=
=0A=
Looks right. Please use this approach (Perhaps, bc_acked field of tipc_memb=
er needs to be removed).=
