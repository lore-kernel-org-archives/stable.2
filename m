Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.134
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792664868;
	b=wcOiipsxr6CZGG83esy+w8Mygi31lSxlQXCAjsMx/oNjm0Qsq2xFMAR54wqvzQSdtLNR
	 uji2XMIabMRdUGZ0BgsDy+WwB9zVw0BEHsbnBNWsX1vuDrPmObBs/bcgN9NvTHyfj14LV
	 EJlg5eWYBklIFGJO9rc8eGSVzN3N4EBNlw5NWvRAABcK0ENcZSCJvaXk8LsF9AaY05AkU
	 A5+Ks5SLmzamsudMH9SZnyn4NXekSLXPeRaJU/6cv1tm1uYCufAuCvTBUHiQIvuDDTIms
	 k5uZi+dg8445X8AxKEnAAhU88ZhBexjC0lllYEHYP3VjqiBq3lU6IqvbqZlT8n6gypg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792664868;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=2eR1m4l7TTDavYC1Fnb5lw8KBYw+Thf7HynWa782pZs=;
	b=HW5xW0prpbUjFWxsgUR0LEudkTtBdrfqWXGPCYkRnS4B3lVlf7rqBjKNN04Ux5PiQ/mV
	 NQln5IWImyGcagmUCVmSkAE+MdU1F/OOHJnt0Pysbcj4OuQeFMkS9eDTaCyRWGF3x2v47
	 v9QFFvh546Zd/zg7nsdqDxqeherbhZB5PnJ8iwLYBQzA7JPvKI8zuUg0N5XxAAtPeINiz
	 bfsbFzfXB5nSrjgz/xrWmqgiFDNVmmcPVY/kuIniYffyBkkGJts+eI6zYdJTZtEJEiwzg
	 lG+urgiEdT+lumBDmX82W0M2DqLF7UJs9+LKChJnWiwuvhz2Hj65bVjt6LaJP2UWBmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blueye.no;
	spf=pass smtp.mailfrom=blueye.no;
	dkim=pass header.d=blueye.no header.i=@blueye.no header.a=rsa-sha256 header.s=selector1 header.b=CevJ7FfM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.134
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022134.outbound.protection.outlook.com [52.101.66.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B261606A31A;
	Thu, 22 Oct 2026 10:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B261606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blueye.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blueye.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=blueye.no header.i=@blueye.no header.a=rsa-sha256 header.s=selector1 header.b=CevJ7FfM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=trLKAQc33lzUWXYlkJz6m7w2VsWYHn5UR5YCOx5xbhWiDMS0L7s3Fzer8S5o/FOCuEIQSlMr2QpbjFqSY75oac4LAMKdq/xowk2GmzUyuGUXdVnStmSzdPOSTantkbx1cu6zkF5+pW2curoJDExoNzGI0fZldsVcQX6eWW1HGz41D/tiXrT7iZyA+1wfa4gUckP6/qtS3uNawdBxf7S3ZJmdbRinXpNZ44c3Tow6KlZ30BF5l6ClEx3A5rUlSBEcGHDkzG041ZjFQRZeW9DBRoEn0lmPyQXh5ADnLlfZogjOgCEmein8RRVsJtKHXV8fqy1+6y0SyVvkE4C7NM1H6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eR1m4l7TTDavYC1Fnb5lw8KBYw+Thf7HynWa782pZs=;
 b=si9mBDXlZ06dYBSVJUhyhJ4oGp8aUUsSFz8teuXQ3IspqvvI4MjE72ieKXGiDqm4tIpjBfSuNT+Chg4UiYN2OAcvX3NGCVhHCicExVIr2ZZ8CMusRQbYsxaMXcUsJ+x3WmktYdfUmZb2fo6zT0dfjJK7SSLzQ+98874uFqGTAiXNGOABiVn2gzg8fzAJp3pC1a/VXNEVq80CZ9gfGgEbrvW0tRxVj9ZB9NOqaZ7xph3ETuWVxGkSs6f1jjwgT+2UBDLnmiHvmApRw4c568CCqsH2cXyK1AwJoMHSkzXVLD6pIRvxp5eStKFCKpmZT5J9wTqczSCEHI3G29zajD+WSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blueye.no; dmarc=pass action=none header.from=blueye.no;
 dkim=pass header.d=blueye.no; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=blueye.no;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eR1m4l7TTDavYC1Fnb5lw8KBYw+Thf7HynWa782pZs=;
 b=CevJ7FfMDFwT7kphGybfdhodA5HPoB5Y29GiDNQz8XRNK5Wh8GhxdVfXcVaWbHEype+k8PA2JzXRbLTbDEL77O7dv5LzvFBGurLSnXE9mj/dsLdqHfvJtPnEk1dZH5BD8LBr8ZaIh/NXDHVZIBtlcArhAyOaOhsX+C9hZAfbtuM=
Received: from PAXPR04MB8799.eurprd04.prod.outlook.com (2603:10a6:102:20e::5)
 by VE1PR04MB7293.eurprd04.prod.outlook.com (2603:10a6:800:1a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 10:27:41 +0000
Received: from PAXPR04MB8799.eurprd04.prod.outlook.com
 ([fe80::7546:6bf4:fe97:8e08]) by PAXPR04MB8799.eurprd04.prod.outlook.com
 ([fe80::7546:6bf4:fe97:8e08%6]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 10:27:40 +0000
From: Johannes Schrimpf <johannes.schrimpf@blueye.no>
To: Ricardo Ribalda <ribalda@chromium.org>
CC: "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>,
	"hansg@kernel.org" <hansg@kernel.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "hverkuil@kernel.org" <hverkuil@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] media: uvcvideo: Release streaming interfaces at
 disconnect, not last close
Thread-Topic: [PATCH] media: uvcvideo: Release streaming interfaces at
 disconnect, not last close
Thread-Index: AQHdW/DA3JWwOJKcXUqhzV8Ax8XmbrcER3sAgAUghIA=
Date: Thu, 22 Oct 2026 10:27:40 +0000
Message-ID: <F25B5C94-B856-4074-AB74-920FA3049670@blueye.no>
References: <20261014-uvc-release-intfs-v1-1-18d6e8dfaad8@blueye.no>
 <CANiDSCuv7q2oKbxqVj+4ctT3FChh81a691hzt_S1n5szXRTvXw@mail.gmail.com>
In-Reply-To:
 <CANiDSCuv7q2oKbxqVj+4ctT3FChh81a691hzt_S1n5szXRTvXw@mail.gmail.com>
Accept-Language: nb-NO, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=blueye.no;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8799:EE_|VE1PR04MB7293:EE_
x-ms-office365-filtering-correlation-id: aac9b760-b289-4c78-5cf6-08df30271a0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|42112799006|366016|1800799024|376014|23010399003|18002099003|22082099003|261009223027099003|4143699003|10067099003|38070700021|56012099006;
x-microsoft-antispam-message-info:
 drBWIKMoIgwRfaxMcUBkwL4zUXDB/J5yklKtkchHK7x4PTSDa0NMBMid13gsxItgzknC9QezP3WvdpcsnbdnXE3O54n8ZRtdFf5fp8boBPfP2ti2pS7724gxQTUZT08a9Y7QnS0KzLbFti5WY1eC2Gih7jQXqrhhAU+2mj04nC8k99woz9Ah5DcSAHVzmYULN+dM8tbWhNGbDqLJY1cf6YVeql+IeavEUmhmEbjyalXZwKk0Qord2zF0p45RtVPlJcmuDvrO0QmqBZJwaQgAeFTKtBU6bfXyceos4swRwGWQZeAF3bvCjrm0S6dr9urleNGpnmXapZ/seqSWvFeUMC5uJgaV6xMaYwxTI01k7qw87qzfUL1H7sEL5CgH/p1znQmLlD3VV0zGtdw3yhGRROEL4xftokw8IsQXW0XRFc89a8fyTWbQn/C0pBvNsiF8vYYtH9WPrq7O09/BEXn+z5c7NRdmZWCjXxxD8lVG5hSlnF2G+XBti5yFY9IKlinxOn+rb5NoPFh/B8g94W/ynK/j/dflfK0uvldddUipIQ3cfZG6vj/G9AFIDMaMJopKs++afSJ1pKUgpW8goKp4jTU2S50SYKElmOrvgkpQJ3YhrqPzC6IG592hlk3pYGSeniDcbESjHFdRQi7AO5t4V1xE8G87VcU3KWGMgxUWYaY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(261009223027099003)(4143699003)(10067099003)(38070700021)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TwvLoQazeC57ClSXKPpNTZCJXhaFf63ulreKCgYbG+QDfh+HmmiF4IbfWX87?=
 =?us-ascii?Q?/X+qS27dfbLBq4mzC2tT8cMZs8y/yPecOl/t3YGHus9AoFA4mfBAhQXK9/iR?=
 =?us-ascii?Q?3wq/y4r2b+833NrLK2dkiUY8NalRmJpEbFZzUQmmrwYYNFNzs3x74FGF0T/n?=
 =?us-ascii?Q?2PXfAjCIMb2K9ujI0JPOyHO1S2VTLnThXIlNEAZIrHRugR+CGfQS8MFWTfM+?=
 =?us-ascii?Q?xVWBuOXsIXxWZwtrQmsyFOANTI67pQEO9qY4zvyKwAmUabOigZ0HSI7/Phd1?=
 =?us-ascii?Q?iHQH+G1NPEDq/WrjXG3MXmNgfqC6mIrA+VJmLybI1i4jDm/nXtGjthSWcWpS?=
 =?us-ascii?Q?Doyhbn8YODPhTLsv6yhBlivLXneqXGP1fZCtur1+F4RmpHFuyLwjwpp2EphU?=
 =?us-ascii?Q?WR5Db18nfEM+tObmblnqK+Wq01c7BjiC0txoAwRY4i0cXjxZ9aAahFbYc65l?=
 =?us-ascii?Q?TA+Vk5Jp3NX/bYK999V5PFzAhVrGQ9o8hSJjr4a+5gVzGAGaTTlPhUmwpwcx?=
 =?us-ascii?Q?38Q0LXlgTaZAqfprM0CI3QJWLwjH6C5gL9mmbCbrMkdo7bwqOpoJeKyT9Shy?=
 =?us-ascii?Q?W7ptTCZguuOibRDgh3mvTWgoxSZr/OTIEPelU0GB0a4bIZ9Efw9PGToEuGYB?=
 =?us-ascii?Q?OO10x/CQBvALfIIm3WXEyptkVtaPBgnij3Ccrv2LvZjq3RQLifoyJadK5PQe?=
 =?us-ascii?Q?UbKtnngdgVxigE6TTrMLfbdQsBXVWVXB/jfryWrTzzj97tTxFshuQ+xxj1Qz?=
 =?us-ascii?Q?5iqyZM/Oa3WeW22YxPgZot1cWoTRlD9tMhVf+XZTb6/UScYHwwhSzlFP/qab?=
 =?us-ascii?Q?t1aEtYaQQ0p6NMww41zTU9mYUWISepaeldCmjewwvjYo1HAWBvQEgS1Wy/1H?=
 =?us-ascii?Q?p1/KHM1BUswdRLTkpOrdQFPy8Jn6eEkIeEA1w7zhWGOJJyHEE2xSd1HIcMAJ?=
 =?us-ascii?Q?JAa+/aZMARCreXLlgf0OsFLSWM8Uuub5ZzJy/FQMc4QnWbnvQkJW0nzLgldh?=
 =?us-ascii?Q?GTL6Yqk249J/AFl8d6cjwSeg0KB3k5u2DUJuhx3qWxq9ISFGkdHWfPJ7QxTI?=
 =?us-ascii?Q?TV0HSQd+A3TvazVi5Jkvg+Z34A+lbwoKfbSmfn5P3aDY+2P/RG6IXd4UenxB?=
 =?us-ascii?Q?TDQR7O/JeKWsLF3LEYuK3TyXfJ7LhrLosZvQ8zlYH9MOk5YC2a3azBCTJ1UH?=
 =?us-ascii?Q?nGK8cV6/VrAGqg0Ew/oW1ZWHEPe8wo/U+RM9GW3TQwdr66GAC/jepkR2fqVI?=
 =?us-ascii?Q?TblVgEtkgqpHB116wgsHdrOUpyO6kZjag9rE0cLkw4mjBAfPOoLoonjSbIX1?=
 =?us-ascii?Q?d/0tIdaPYZbZvi+7l5HHhhRTqGiAH65rxzj1L4dOhPFWyMd62nvW4GersMCS?=
 =?us-ascii?Q?KjW/Pm/JYYQytmRJq2t1K+lfdAXJQVX4QKQcpSyY4/F6e1PwX3gbzUiawFTD?=
 =?us-ascii?Q?twxUkGOmBMj11MTeBNl/XYEea04JSFSPvMdm2iP4ANs9fBshDnD5AF1uHmuX?=
 =?us-ascii?Q?U7PWJ+AGtzsecEihu9nE1RtRuLpNnoL/wnetfoFapkZDMi3RLJS39nVauCwe?=
 =?us-ascii?Q?M9b18hPjV2/7hQIzAAx6XHyLwAdjbTkh0+Bx8uEwj9WEXonWGh4PMchDR7BL?=
 =?us-ascii?Q?jygTukwoMVLJiV+prwDlqnzQ8Ds5mrlO8SnLYsKaKTj7aNlICLiVbnzv5uCg?=
 =?us-ascii?Q?/IIRD6Lgn8Ooh3tYDKp3KCRdrSaQ31MFucszLS8lMMCrYxyPtAqMFACBwwFr?=
 =?us-ascii?Q?FTwYROa506rnyNT5l/+Uuiz1VgYcJDs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B4E3208D5EB8824D9068A50B53650616@eurprd04.prod.outlook.com>
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
X-OriginatorOrg: blueye.no
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aac9b760-b289-4c78-5cf6-08df30271a0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 10:27:40.8312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dbc4cd1-1d79-4d06-ad6c-d195dd1113de
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bkgygpmv+C5K6lK377oxFxy8UMqen8BYNTQORp/vHROWKTTJg95gtJ7mlthj1cxa5lJaYcy38e+RN5JRSczZrpzrD6M/GMGbsuukXWyjUPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7293

Hi Ricardo,

Thank you for the review. v2 is out, with the shorter commit message,
the release folded into uvc_unregister_device(), and your Reviewed-by.

v2: https://lore.kernel.org/linux-media/20261022-uvc-release-intfs-v2-1-901=
bc1c47cfb@blueye.no/

Best regards,
Johannes=
