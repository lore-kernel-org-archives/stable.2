Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011038.outbound.protection.outlook.com [52.101.65.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA4F3AEB26;
	Wed, 23 Sep 2026 03:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790134476; cv=fail; b=E9bW0XLuewsGfmEnHHctOHrKVpQuSn/1khSEcYBNdprkJVltd57OrhdFAen4J+tGGCYHIXDtGr+2NkudYZCNCwwJi0EtXNlNssr4okjaWPsDLBHZphLnkfjTWH66Pop7r6BmuKNa7nEch8f4mbfhR00moLvu5wrAoBGbIcKVJCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790134476; c=relaxed/simple;
	bh=hxUuY8W4u5CZYG5oouM+/nWl1c5fcBfgNPogQtm+4NY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LCGXHKo+HLh+s1o7Yubxx4XOaiVwO8EiDbLgI4TC/wq78h8Lvw1gYtXM5C2B9MwR/0/LnN4dwLmWNDJGOXNRI6Z1/KYTKjjtP/jhf/NErvFy+Sk4z9X6QsoumRWqZr3AyMlxfuHjaiiogd4X7bl3sEwYzAyrfDbP7VA8l8wEbg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=L+CmKBld; arc=fail smtp.client-ip=52.101.65.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="L+CmKBld"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AdQcg5RAOY0do5AaJfL6QuwoIyornSlNWkHSfVSsepLgE/UvgMS38wVSXJmlstnQJuMdCsKhcKgfUKSAMTdys1PQrCsmCguoWVDkbV1UPgqtKzxQFvATmMG4gdY4ZiZ+guxpDhQwMMTLmLYXq9SjiQiaYuXG3J+d7aHj3ZbNXp5nYAx6007yX2y0AHxPWbF8rj1UKgmXJeJBISEt/1SuVWbiMJAJcEHWl2ReKvUffWYhx67JkDaVnxAWYCTPYSFqyghVIYjnKLUDM2voLESH4rubzrTBWWaJ5cvaBCbZPcsFiRSIObtlGpWEajSloO0C4MqG/n3Nqxw+6Jk1qaQDvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxUuY8W4u5CZYG5oouM+/nWl1c5fcBfgNPogQtm+4NY=;
 b=AGT3x8uXfvK5DbYD+W94CzM2gqDLiCdlFYYykjJVZglhZ3/BORiCMBmBF0g+pQnSvf8G+Qa6U5mxx76xFf/6yTAZBmefkKwB8a/WQ+0zr1e2xQ8EBQz4ojXhgsxyHf5ApsRWZz3322bc2a7mb2Et6RiAhoPsJ3c2QwOc49Fc1XWRPkOLHnFZOnE87RFY16rsQjcMpLmXUNHWuR5YYkq1DhaiVRqgZn4Xt4ufHiog+Nj+WE1C4L3hMz+wShQ0TBmgMJF9bYYxag5SlUFszsbjLzpNxP8ZlvI+AdENNI9T6e19AhvObVfGqkmRWCf2n7MoWuADDjTsdPfbcbGYp2H4/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxUuY8W4u5CZYG5oouM+/nWl1c5fcBfgNPogQtm+4NY=;
 b=L+CmKBldeHQ/gOjuX+ASHYPA/74UO8lsQ6ZyqLUjF8FK3RIxedRegWlgLusmAc3J1AcJLTR3aQNAwwcTfqyJIrWQAUhBEnL5giRJ+Sg3v1uDthKXx+68VcjUPyEPXrzODMGmMLtQwwMjcQvjOxNAamyIJVO29pCZrwUn7l6q4ZLbIJWrwX0/eoibXxmqvZdObKA2a5rP9kT83ALjG3qdmBjUjp888pzpzd/0ApLu+Jk3F2K0IQte/wngN96nUF5ZZMyP0tgcy7nUT/BceWrqC/TV8jJ+Hx054MboVvtdZDwZSWbDZbxx/RqL3s6sTeMn2KXmXpv+quUbUEP9gghq+Q==
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:617::19)
 by DB8P189MB0966.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:16b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 03:34:28 +0000
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3]) by DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 03:34:28 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Yuqi Xu <xuyuqiabc@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jon Maloy
	<jmaloy@redhat.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>, "xuyq21@lenovo.com" <xuyq21@lenovo.com>
Subject: Re: [PATCH net v2 2/2] tipc: make conn_idr teardown safe
Thread-Topic: [PATCH net v2 2/2] tipc: make conn_idr teardown safe
Thread-Index: AQHdSa1lJzYvYFumCEu7JO1ybeHtUbbbhMNM
Date: Wed, 23 Sep 2026 03:34:28 +0000
Message-ID:
 <DU4P189MB37505A301CD8A95637006C06C6822@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
References: <cover.1789960909.git.xuyuqiabc@gmail.com>
 <91e85c3211fd31d24b231e8def5755c0f18b71f4.1789960909.git.xuyuqiabc@gmail.com>
In-Reply-To:
 <91e85c3211fd31d24b231e8def5755c0f18b71f4.1789960909.git.xuyuqiabc@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU4P189MB3750:EE_|DB8P189MB0966:EE_
x-ms-office365-filtering-correlation-id: 917b7d0e-5482-499d-a160-08df19239275
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|7416014|23010399003|376014|11063799006|10067099003|22082099003|18002099003|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info:
 MNEdeVHGe0yoplVOQn7D1j5F3H59S29apXXs3iO/kJrYHC0buI3OCFI5WcmJNvjSf+lHrC/J/U0F3B75MIkMaBN2gvSxhyI/ManZ/xbUXNYcWVxUeaILnELdnvSOQyiM3eIISoKL3vG/P4Sz+jUy26Oq9F3dgimlOHT2MwP0ErMOVZggBBSbLEARLMB8oYRMBwZ0jL8VahtRh7/8n05fwArHsdRMQc4DAUnXA96ppvxQUDoKcq4jnXhjqd8kw8S9HHk4gMfJD8RC4+WO6GV1rqlgAhBVoLm7qbubm7tLzMhELpnHRoA4o8mR8liGrQ1uCSebU4G9G584A8sNnlSNDh+SUVzI0P8LDMwF26dUmAxyU9uaFoxGMkDUYrMlCmHaDpnzxlKuM7qsc5r50dgVA8arHyaA6ukzNNzcpM9McL02sjsCXroIss8OLlz3pzl2Ao98GHIPU8HfFyoX57Wd6refGnq+ycGoHQv8aQ7yn8OET1BijyA3WvHjzKe1gGDxLfVGUX7NljCHfexqybSY8ORWlJEhAKUBkgyE8SjZ3752GuXii6w27hZpv9fVcXBTGzYGk8gMDDoi4EKzBEL2z2z8WvvDWUgO4e8p2fLiR1eKAbpq9tJ5xzAbQ+OCSoqTnWtVfv/bYmityVye3hmSxM8SzrvD+eBUALPsv3pebQXe6F6c52AvW/4+J5PB2tY6mIevkf9XcDs3++NQebllKLzy+cGrQCohqOI8LDh/Fp8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4P189MB3750.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(23010399003)(376014)(11063799006)(10067099003)(22082099003)(18002099003)(56012099006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?LTKqCC37yI9h3JEU8umQMd+4PGgjFRw44rNq3QHvPfX1sRvhdolZIbeLBA?=
 =?iso-8859-1?Q?OiP3mORHq1jMK5s4xds4KS9d9NTBR4JiZRVpwN1GnIG4HqMNtYccnfO1RX?=
 =?iso-8859-1?Q?eFefD0zhfaovyd5Y2WUOU4H6up8A2mWGCXPfYLLzutRhsLGnaAV9NnEgvL?=
 =?iso-8859-1?Q?Jx9ACWmmQ0tb5ZQXN2EimLCeeTCqpxJt2th3wXh28Xf44y5UUPEGcTT1OQ?=
 =?iso-8859-1?Q?vg/jQpXYtatDHbQuvr61VOjgxHWQ9Ca6sMuw27Gh5rtbAIEnOFTvSAn4eT?=
 =?iso-8859-1?Q?svfNQfV6yiA6FsbvjzNZ99SJDihmL02WriEtNlFK2thR49ONK9lBrpLVOh?=
 =?iso-8859-1?Q?xdaqw3iF7Og/vVve0YJeC3hCuoNeO/ADh/3iAbDpKXSlVXirwvljeMKtxJ?=
 =?iso-8859-1?Q?RpkV/S0lw0CS/50E3wIhEgedGqXoV9Rp0cuXnUTbgnHqD10qN4fhduaLd3?=
 =?iso-8859-1?Q?SZUGxPSutWg4ePvDjDDelFCmfs2MxhOJwsE4s8NzlQqy2p7ylBZsfjTTYV?=
 =?iso-8859-1?Q?V9g5xCXA3HCH4nfBM6QKTYjKTGeYJyMyCcgfUan49iEnPCTgLobz//SoA/?=
 =?iso-8859-1?Q?OhxYX/KE+OcrCH+6yxjnt6MHQ5Z2Yf+OPGJCwE77vF8BF/dPxw7LB5VGYM?=
 =?iso-8859-1?Q?EnbGZLwPUZaKjC9Iz/6DFLDVd3v3TGKFNDfYbXoMEHQdRAyroHnZiqdhgF?=
 =?iso-8859-1?Q?Zs0T/oXaMwXTO588Euit4yQNxVayXsIoJLt47SGqC0HvG6ovp6OZdXG2rz?=
 =?iso-8859-1?Q?CiLzINuM1vjAexVJFRmi/J8EiQeCsAuARV6s0EuPlsV56Cb5tYbG9UVKcv?=
 =?iso-8859-1?Q?wSG1wdfFE51ttiyABVYEx7y+T0mrk6dYafNJc4ZURSOnbxuQmCxmbkWCAy?=
 =?iso-8859-1?Q?I7nzeG23vaY2BXEt8LrZcZmOqESoPVhAbGqbc542MRr1h4qUkNtWU89jY2?=
 =?iso-8859-1?Q?j3wnvaFeThkP3NGiYr06zAY05ZoCXadMMseKYjVUYcFg9fDHAzrQkZ8CY3?=
 =?iso-8859-1?Q?GQYtZ85gwD8OQxsOzAEUFWAw6naGqpwz2B4b8c9GLs/owDGhGMFphLcfzI?=
 =?iso-8859-1?Q?/XwOTo9IruEvH6HJU2KANaBEEQNJ8u5OIXz0HRhQYuKXms4DIOFafuJ9v4?=
 =?iso-8859-1?Q?PUPNEiXfT5/oUuRcy0MR1iWdtpluNBCyj04F0+Qsgtiawd3BabRKMmdhh7?=
 =?iso-8859-1?Q?ZipKq13MvG3OGps9YAya7z0Mo2MKFmCMTFrFmVwoTt48DKB5keiLGMuOAu?=
 =?iso-8859-1?Q?rzeV3JZHox3hxK1mZPSawUW2JAuOu9mwKWRxaqWk0yykop7xt2j4uU6j57?=
 =?iso-8859-1?Q?oVInjTzHkGgvt5166t/53zii/RSC3we9Svz1JrbOewccxQPG+jxUg+ZQbs?=
 =?iso-8859-1?Q?ZEWi399kioLvnc1sq1/FbLzcQj4vaPADWMhbB48Fbi5yLKmjty1DGzf4+m?=
 =?iso-8859-1?Q?4glmB+R7SZce48vDiO4n8bxwQzkfGxL25UsSUZZ1fZxa2pjj75+WLbcpZq?=
 =?iso-8859-1?Q?H2gcR4ldkTQjUHO/3J9zOOSVOfUMxBARhT0QqiMe+kuvHhMyQQOYTBkBx6?=
 =?iso-8859-1?Q?Ifmxy4HZB3kJF+OSYcd0bu83rXx/GeL+Q9+AI+TXW+Fx6LJpBcOzzzxJEO?=
 =?iso-8859-1?Q?iaibQrxyE1aRPIAdEXdeNa0EDY0/qS85QRmsi1HHdFF48a+8oAI64WsGgO?=
 =?iso-8859-1?Q?paq0pcbOIAjiUBFuflHGlH1zL3r0yN5MPXYuxf31by5KGVHQ5KUL5+PPxf?=
 =?iso-8859-1?Q?lBNOAr/++Bqa0ESHh45p+/lSflFQsbPFiozwGtGJHenmRdQ4GiQfyziHs9?=
 =?iso-8859-1?Q?sPxwmTfN/JE+9VZmffzKnryjLdl47xJnZq4EsZ/Po2TKuoV4ZGO3tQ0Rkh?=
 =?iso-8859-1?Q?xJ?=
x-ms-exchange-antispam-messagedata-1: tdiO1jOyQghaEA==
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
X-MS-Exchange-CrossTenant-AuthSource: DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 917b7d0e-5482-499d-a160-08df19239275
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 03:34:28.1306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QnzFiN+GUu3QCf+5MU71V8JogASl3a25rD5Pza3iHOtYMUEKzzpdjlOGN68iWaANblKRv3MXLaET45M4UkSTrVvet04nJRbdiBVW8s975xc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P189MB0966

> Subject: [PATCH net v2 2/2] tipc: make conn_idr teardown safe=0A=
=0A=
> The teardown walk iterated conn_idr by incrementing a numeric ID while=0A=
> holding idr_lock, so it could scan a large range of unused IDs without=0A=
> letting a connection's final reference release make progress. An entry=0A=
> whose last reference had already been dropped could also be resurrected=
=0A=
> by the unconditional conn_get() while its release callback was blocked=0A=
> on the same lock.=0A=
=0A=
>Walk conn_idr with idr_get_next(), release the lock and reschedule when=0A=
> no entry can be taken, and use kref_get_unless_zero() so a connection=0A=
> that is already being released cannot be revived.=0A=
=0A=
This patch is not needed as we need a complete solution discussed in:=0A=
https://patchwork.kernel.org/project/netdevbpf/patch/d16573ddc2464277a04274=
fc12630daf00b8f149.1789960909.git.xuyuqiabc@gmail.com/=0A=
=0A=
=0A=
