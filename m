Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010011.outbound.protection.outlook.com [52.101.84.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6645328B7;
	Wed, 14 Oct 2026 13:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791985045; cv=fail; b=rSYhIwcm2C44DcDQwSNpFyjzTngJN2FLnV6OjB0VaHwQZmDAIDL2teV/a88jlDqmzpF1AOCplNWE+ps3ZF0Xl9mEx3Lbjes3kl4TqfUGggdKxlBNBJOFHlls+9LIEuWMIBt76NEnBap8fOQvppQc2HJN3ZB4hMwQXmojtHRD8qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791985045; c=relaxed/simple;
	bh=C9rpeDcxd1oALsZV7+kdcr8ZPB3wdv8hcvInC1gallA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pGluSvbitqwFQhMvY1EB7p74zMrzmnOlyX7BuK9DrZeofIYEstUqPl/51hHXMTZaTWQXeY2xlegjtgngR3/8ynQIEngkN0zFHoDhhnKzMZd/zsVXvOLt0YpAVJAisBnlr/7AHmg7lIlxor8tjj6Jidqmwpwj0jS4DHHjhVhzJeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=DCR/ePod; arc=fail smtp.client-ip=52.101.84.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="DCR/ePod"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qv5z3d8qLtMycPMHdyY3ZLJOJtudSqipCxkbmtbW45o27klNNem6ZEsEld/PVkI+w7Q+MNKE5QzrMb7DPA8PI9N2ysGq+VPzfodg3hwc0uZThKqNIAK3HqbD/hfIxWZcHsdZY74xPL8gFvzE9/awElBfpY/aL1XqXs1Qu720n6GSIYdVMQQgUdFJK3/R/NsHQGfDT6quFEa8L8FEzSoIDmCDADsZuDTfzt3jpaE+Jk47Eu2ZjziHPM1s8NkP+kD+I7+2mwwppQTpEetKheWXX9+CsqGlMjkgaxPOGqytNU2vZajjztcZVDYQGrPmh0gpueWXE8iAHDrSg0xWeDI20w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YiAo9+JYDENN4hdbGqGV8dcn3HKSCq4K41Df6+3HCXk=;
 b=ed5fQjwZZHNH/REHRapxw+837GjyJhfbQnWS+pbjiyohWggXg0MyEkbOJUZFJzUbXi9m1ky9if+bostbVV7UPFwp2YFr4b7pyioOD5H2XCaD2ljk7+zpv5VXDOQC+aQjhmJ5nA5+wpGnFq+olvnwcntFlWfSxNWNZ/3+s96/5McIkg97lwtSCgr+B1gsjDudvi4dFM59KiFyaPhnpW/z/kec2phwEvkM9ZM4wShirKVDHTEQGet84Km2KbS2XAK0F1dBrpdFlfgq0uVKMeIsZeJNYl3mr1mIV61NUkLA6sCfAMIsn+O0YT6FhMjGmNLLRdoWxgyLzbAPpvLygjdQHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiAo9+JYDENN4hdbGqGV8dcn3HKSCq4K41Df6+3HCXk=;
 b=DCR/ePod8g5RjIWI7B1erprkkNw/OG430OC9HDEPKln8jGukxmUbJ3FRAWMta2edWbj8aRCsRhexpuMZPDw6gOhihr/bKWbdT0SNPpXXCFLUONFqgU/gQHgmJ1OcUVKpn0wWYnVfpOh2LEO+3MF4hy/r0pe0qTAHpQk5BeVoxhYXcrScK5DTGXvC99twb3E0iapMdn1AOeXvs6yWQb7oNI6GEADY5IHoEP2qIk4eVysr7RIYx8/vGldRUD43uM4P9wJZI8fQdYhliMHPip0BdK50CqGSD0LWZHBq3FfcuoTgz+/3LoUwIKFemRuonCLq+TVpyGD5bkqXLv/oRKeoWw==
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:17e::23)
 by DB8P189MB1032.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:16e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 13:37:21 +0000
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5]) by AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 13:37:20 +0000
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
Subject: Re: [PATCH net v2] tipc: fix broadcast sender hang on last acker
 departure
Thread-Topic: [PATCH net v2] tipc: fix broadcast sender hang on last acker
 departure
Thread-Index: AQHdWl8koyVE7p/RIUucHV5lj/tuvrb9C2Mj
Date: Wed, 14 Oct 2026 13:37:20 +0000
Message-ID:
 <AM7P189MB1137302A763554D726AB1482C69D2@AM7P189MB1137.EURP189.PROD.OUTLOOK.COM>
References:
 <AM7P189MB113731FB3655F88C6079EF1CC69F2@AM7P189MB1137.EURP189.PROD.OUTLOOK.COM>
 <20261012153357.1863316-1-bsdhenrymartin@gmail.com>
In-Reply-To: <20261012153357.1863316-1-bsdhenrymartin@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB1137:EE_|DB8P189MB1032:EE_
x-ms-office365-filtering-correlation-id: 51043bf1-4dfc-4614-dce7-08df29f845c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|23010399003|10070799003|376014|366016|1800799024|56012099006|38070700021|4143699003|11063799006|261009223027099003|22082099003|10067099003|18002099003;
x-microsoft-antispam-message-info:
 qk//yV+8bmhx3nFgRv1cfIzmxxHDhhoUdD5mg+R31ZSz/M6P8u6TCEvU822rF9cGthKfPKqeMatOldMrEfdwf0BjcPKB+PzdpQFBiN/xklHOBNReI3pYwco4K5gsaiwELScKJupihmy0DxospMJx7B2UbTP4dHE4arkDVkFiLlDtq4VVVZSHgF+RPrrksR+B07D0+ASvqMA6MXWpJ8TJkVGQ6E/dFOJG2GKJv0+gLe1iATaiW1Y56EOkOHbzJnJrzAmesW052bAZA7w9fliqy46H8hkZ5AKxasoI3rmUG1fw4TF3F4DBYUXwwDjuKUiM0iAQ/gzCEJd31G7EKh68Zx7aFUTNfj9unsgHJ468Nm7tqDE/SwU93GuH5/HrwLT9MqUVhui7mdEkcxgoH8lN/7WMoi0ZkRyqqscpQ4HtIvhH5EZLp5vtUAUZuX2B3SYvZClpp/vMaQdMoOqbXz8vH7BMp16qh3Le0whTwVSHDWRd84pNpAP6uFrnWl5HnrfECihIL8/jFU+6izb5LNogBJUBTJgakEQ2Em7svzjf+s9m59ZOW07wD5CNd0OQyaDeWyK9ypYxjqKQnWG+jbRtk7eDDCYZbsE0xadUI3f4nQ4tZGqz0I1XLvthtRsak50v9xDvUezpPMWSdga4IlF3Rb4jzw/aU/aNjB/2BcXjUJWOQmKpqDZIxjDmcgqS08xDi1IJHYXNriSxgUMgfSstVa7yph1bRKi3ryz5HvwEynI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB1137.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(10070799003)(376014)(366016)(1800799024)(56012099006)(38070700021)(4143699003)(11063799006)(261009223027099003)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?W/kgxH0fJrQR6TVtb2abGE//3Dwq3aKRRy3FYG0kZ6GSGy/UTa66f1RRC5?=
 =?iso-8859-1?Q?mror/pSqcDQkDk2WJnX8ferSIh0IAQa2QIjDhRtyklgp+J9MHJXH+6D72T?=
 =?iso-8859-1?Q?eI8tC8XYso5WH1fTk5vrGs5dn9RrOLW2FVAnwmyF8MDUCIYhTypylMK798?=
 =?iso-8859-1?Q?FVBccgb7KTmIAmZvLWyEiQLTaifm5no9VAAndW63sdso1qr54QSiSz/Pah?=
 =?iso-8859-1?Q?8VPUKEVGJyUbVCIqB3hgw+JRezxZyHp/BV420qZ1FvKm9duc6TivpOcVUX?=
 =?iso-8859-1?Q?b8qy+AQXdd6yFt22Txe76/+Vhq3uC6AELoTAIOgwnWKVvFDJpy0nUiOIiu?=
 =?iso-8859-1?Q?nSdeyQmHoGLNMy+rxVo18UHZW6PVWp0Id9yXEG448LNDs7VSEG5id3e4cs?=
 =?iso-8859-1?Q?hDkm0pTmO/j7/0KlGz65/Rc2oUPaKe7WTmnku7pd9uA+o6EyY8E8cLdHOh?=
 =?iso-8859-1?Q?+dKsAQuxJ/zFwpyxRKSffcdFjs5rm4iqx+VxQv/DrCo0EVUCgC7eMFTnYV?=
 =?iso-8859-1?Q?JAryC7PK485lymhx5zELveLgpQBiisXACDac5TSiDsH+5RxaqUOyAGSuA3?=
 =?iso-8859-1?Q?bhP8NHzv0HBq+grtROmnUgp2jwda49MYpwVST6LmERqAOvg9gB20IYUsbO?=
 =?iso-8859-1?Q?oCCKCCaos2Jx7RPboY9fKctGD0z6u5JytIyVPjPpsXzMshsPudR0KTbQ9d?=
 =?iso-8859-1?Q?2KfqSUaF/MoqRPdw09fgEU5ZjLZy8lrEg1/3GN4yK/sIt5b2kyQUa2oGED?=
 =?iso-8859-1?Q?X2RhI+dLlbwjqHgs4XtlHIENa8iXMzhhFhUWcFaY9+v89QPBuiwgalIg9f?=
 =?iso-8859-1?Q?+XHBbMFyXI2jmGhGaF3ci5W0TVluV17tTHZ7smJHTg5xpfpmyHWL2y7Jo2?=
 =?iso-8859-1?Q?Dhs88cDrNSCDfOQ45/Mr6UnkpmbCD7ihZtJSd5JKoeEWNDZ8Vvsi6vYUAK?=
 =?iso-8859-1?Q?MJCWMt9h7Fy115IxKc7KlX+GvCl0PfrRkdoxiA719Y1vzmyLDa/cnn6xY2?=
 =?iso-8859-1?Q?d5lNrvJdTlNzioVBgLrWhSBtVpoNJHvyNxKAyLIxvuR6fTmMNvdmWZ+DPr?=
 =?iso-8859-1?Q?yxWo1LPDihs2FUsZjQImZzyfJHs9n5dBNVXShY57PfGCaCDoDIx2uEJQLm?=
 =?iso-8859-1?Q?b5zeqUZiCE0Pf2d8kozpCfvBf54O6BQ5sJFaq+wC3wirh+8ML6Ic2sUivF?=
 =?iso-8859-1?Q?EA3j9Ba8Wh68vuy3TioEkba0Ed1m+qBljBpgQ+IECBNYWyH7B1ME70HHnZ?=
 =?iso-8859-1?Q?mtPExFmilDRuIQYYJrNHrOSZBZ3f0rtDzU9TLugXZmqDQWsof6cc/SuhpW?=
 =?iso-8859-1?Q?cTDtlNkpayuO7AhoToj3oCsEniMo73Hz/JsytB01EzGXYMX9wpX5FeT/CG?=
 =?iso-8859-1?Q?Ir3I4K3KKq3iAL64UE6dwsfsLjj2VPNevSHhjGw8dBKrHZaMUxC5kMBQwG?=
 =?iso-8859-1?Q?X9mBSi4DHNjgwqzLsKjWaOvm8vSQHCQW5494KtkgNLRRKrXtzBIysmlAIa?=
 =?iso-8859-1?Q?LLt5IESbHhu8a0mgi4d2yWBnpZ6eLOsLRAaMYqS8/0Psn+qryCY4gawwdZ?=
 =?iso-8859-1?Q?JV8jjRqlqOA0FogV8qsjVnTO8wFst/owfamfdCC9FYSiRYiR5Vz2wwF5SV?=
 =?iso-8859-1?Q?Q5Uwd+qHNFoUBavmOdJBgC8pbgfqcj0yXjwO51D8k3TSSWX5rwf7350P3h?=
 =?iso-8859-1?Q?5tMF7HTOBlwnkclBZ98YyrF7om1yfca2h1SDFDFQIZE7R8f7aPZiLXvf84?=
 =?iso-8859-1?Q?ZhJbi/qEb3663c8PlpVSNzcqTuHGh6ayIeqRGD2DBXRVU4KnnykvR6LC3v?=
 =?iso-8859-1?Q?0Bw05KViNxJy8DHeNiNYO9HpikO5Z4FTJaa6k1waqZqP+IlyvSqE2C3IEX?=
 =?iso-8859-1?Q?So?=
x-ms-exchange-antispam-messagedata-1: WVCOd1rfoXzhPA==
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
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 51043bf1-4dfc-4614-dce7-08df29f845c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 13:37:20.8618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Er1+pT3ThOzmXfpkNoe6SfhOjNRQ+CDNGtU4eSnxbRb4l7BQCXYCesKUsJOcNLCt8oqWvMw8jlyIVw1bQZfUEN3YdnV9xCCUarNEn/IqtjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P189MB1032

> @@ -406,6 +410,8 @@ void tipc_group_update_bc_members(struct tipc_group *=
grp, int len, bool ack)=0A=
>                       m->bc_acked =3D prev;=0A=
>                       ackers++;=0A=
>                }=0A=
> +               if (ack)=0A=
> +                       m->bc_pending =3D tipc_group_is_receiver(m);=0A=
>         }=0A=
=0A=
This needs to be done in a simple way:=0A=
=0A=
@ -405,6 +405,7 @@ void tipc_group_update_bc_members(struct tipc_group *grp=
, int len, bool ack)=0A=
                        tipc_group_update_member(m, len);=0A=
                        m->bc_acked =3D prev;=0A=
                        ackers++;=0A=
+                       m->bc_pending =3D ack;=0A=
                }=0A=
        }=0A=
