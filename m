Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795522177;
	b=UtSvSI71xqVBBDaYTRuZw8zh49UxVIMtQu4nKWh0rwV4yCUUt7hTZ8b28v/TdMTpcz7E
	 APTOq+tJOAsdCsRqkq2CgGpt9Armk9CPukYlWhoNvIigrxEYUgKsf2qzSYNkI9KJhDR76
	 ol2XA7Ku6g23421rWhphs4pAS9mH1aYVcC2Jhf+6gzewl+4RX2Gq+8rBfj7E2kPnUayc8
	 MZaYUlFKoFA8vWS/rU/OA616vVhhVKb0a6j0411eo8hBUhZexHVwHXX+VQ+rBEYqJTWqW
	 Bd1FzK8EzyqP5L/8/P8gQ7yrNmZUJnKLDGTGHGU+znp7O3cNLP+dVGh5g2syYKZ2XHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522177;
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
	bh=FrkCX8pPPHtogYtJosO3f2WBxlb2UYdqgZPVbQHFUTI=;
	b=MHTwpN6+b7/CVLH3nsRWbHMm+fY61w9pmplGoOyxLyCY/UGFm+HMHMqOL2jHuycvDOle
	 QrHVSPKblaPAIG4bvZgqRBesDPDjATnLxS+yUSP6A4UEWUrZIY6eJm36kgDdhGhtyiauH
	 OlG3bGJfY0O5C6CaAv/NAwh+RRWCZdfIktYlKKUqMmyeaI0u9/i7EikkmNg6Z0JGFQWE5
	 lMg9Uh95tObk1hNTZaVnMSho2+vfYcz27q3X7nbKXUFMaxTnbWRY8gpowg4feLNoYIr2g
	 T5GbeZV6P7YlH/zO/NX71VvTrHE+T1UCHzLF3hhAtpXXCpA6xXVLGthiXlGKsDdQOmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blueye.no;
	spf=pass smtp.mailfrom=blueye.no;
	dkim=pass header.d=blueye.no header.i=@blueye.no header.a=rsa-sha256 header.s=selector1 header.b=A7nggQBG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.131
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021131.outbound.protection.outlook.com [40.107.130.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E09606A321;
	Tue, 24 Nov 2026 12:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1E09606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blueye.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blueye.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=blueye.no header.i=@blueye.no header.a=rsa-sha256 header.s=selector1 header.b=A7nggQBG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WeTkZyNX8saGnhSglMy9xE5oFTPN7rO1z35xp3os3zlia54lGeDgZhUkYUeNVQveUdc5AwP6oJkLSrsI31Mr2dHZW6841qjadFVuzyywtdYOq9tjt7dEHlp/+KPw/xj3T2AReMxlOlGmVHuSATd29RULuQr8zN6UeRbjec8CuJvgDEipKl1GPposFHn8UH71v6LC3l0NEcGroQJu8symAqCkJYPNPhoNckENF1Ww4tF6bKLFVN+aezAKkLSlcfOsqtOAWZPseZzHLeajpPckHlD4QdrF36UW701Qo8KZgxZk+4rcS0d1vVNQXe4Nwmg8rEdvjSn6xTXDUN1NRg4qgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FrkCX8pPPHtogYtJosO3f2WBxlb2UYdqgZPVbQHFUTI=;
 b=pT5LdooUDUy4WM6bWpCWd46KULol2NFVx5NcrbcDTwDwCXtzuKM2j7siGOn4wzq6Ul1H+8rReN3kCZHPiX7A5JrjXfGIK304jONFsLLx6pHSRCiiU5lbXPdJbOukLgh5hVn7Xh5VAgtoCZ0Ie7aDCWWK0rPsO6hsACv1YxWsJJ3EQiDncxhfZHVherowuitdQfdAIPHsPIJpuCR1f/u72y50iY9aLTLu1EeLV5QCUCQS2uQhPtzSiQjOrKdcnrjxOjVruTSdPdqMWg+by8ESxTnyKGR8CE9ECNnSHADm4GS2hS955SkxdY0jwLTtjTJOJSSJGUoDnanO/Jdq9+teww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blueye.no; dmarc=pass action=none header.from=blueye.no;
 dkim=pass header.d=blueye.no; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=blueye.no;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrkCX8pPPHtogYtJosO3f2WBxlb2UYdqgZPVbQHFUTI=;
 b=A7nggQBGIRknENbVhyquI1t6FwneD/X/r/wrdEZpwxnDNO/jsBEj2isD+DlCy1FwIZJzet+qCApL72GBTl3luiQuUkkAjqz7teigkuIhcEi2oEXrVptHiNf48DuSGat6R7at1jxdvQdC+WpdSQwIHDTGrP7JLyehPT4gkjgqko4=
Received: from PAXPR04MB8799.eurprd04.prod.outlook.com (2603:10a6:102:20e::5)
 by AM8PR04MB7249.eurprd04.prod.outlook.com (2603:10a6:20b:1d0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 12:09:32 +0000
Received: from PAXPR04MB8799.eurprd04.prod.outlook.com
 ([fe80::7546:6bf4:fe97:8e08]) by PAXPR04MB8799.eurprd04.prod.outlook.com
 ([fe80::7546:6bf4:fe97:8e08%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 12:09:31 +0000
From: Johannes Schrimpf <johannes.schrimpf@blueye.no>
To: Johannes Schrimpf <johannes.schrimpf@blueye.no>,
	"laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>,
	"hansg@kernel.org" <hansg@kernel.org>
CC: "ribalda@chromium.org" <ribalda@chromium.org>, "hverkuil@kernel.org"
	<hverkuil@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] media: uvcvideo: Release streaming interfaces at
 disconnect, not last close
Thread-Topic: [PATCH v2] media: uvcvideo: Release streaming interfaces at
 disconnect, not last close
Thread-Index: AQHdYg6F39I3rj2eckO3x3pliQcV9Lc9VSmA
Date: Tue, 24 Nov 2026 12:09:31 +0000
Message-ID: <AE9F4B7B-1D6C-4286-9A52-5C661F76BE2C@blueye.no>
References: <20261022-uvc-release-intfs-v2-1-901bc1c47cfb@blueye.no>
In-Reply-To: <20261022-uvc-release-intfs-v2-1-901bc1c47cfb@blueye.no>
Accept-Language: nb-NO, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=blueye.no;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8799:EE_|AM8PR04MB7249:EE_
x-ms-office365-filtering-correlation-id: 5661fcbf-13a3-4cf9-b9c8-08df4a23cc1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|42112799006|1800799024|376014|38070700021|10067099003|56012099006|261026121527099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 BW9cLo4YQggsSXjrveRPPHGq/kVgXy3Pqo6FBqnEd85heFGoknYG5yL1IndvFx6VwXmspU15N/jYmVQEqdq9N6XpWrM9Oti8xFxEaeYerQoBqeci6NZXxMtxbA7m45yI6NHpwOwgo01u4k6marrv2CEGZLwJC6lBxJDiddCkfHgrfgW/C1v1JGmeWaSNTi3hIlbu1vINVwLM85JhT94EqGHXgdUkj23A6ElxxH6GgBIwgQ8BWl1yedf5UbhVI/DmHHx+EJ58srPMmLtNT4Iz9AZ63rYagckwx1dv0Jn2FlTj182JmClCdT/UjrrYouBP3ehTL3JQNkm7nKnxgAcsN8uwUtid5QBU87c/Q+UkaNtCCOnSszDuwqyYwH/zmxKf6vPZL71XZzYPf/rtN1ShFgoJc+tV1tgzBMmLHY0Tb10fa08bDUNHSJXIn+aBPUewHP6BZ+KVrkMrzOclODCqJq+sTNw4U45z1whTMynKFQ3qbzjFlHvFId6IXauItO6OSFQaIys/CSLZDPfN1zaVncTpEBD0i0dh8tsk2k73MusG+Jn5UexOjlg/TRMMdbn6QwLRemEBgpRkx6EXRqfcgAIh5wuz476VoUd8t1E8ZGpBmnT3gjPuNiP/Pa/BNJgcdDk9UMqOFQoaxTZtS32f2LVhSqN2+z4DeLKkdBO7XHWNqVyEiHQPjOQYOFNb4XLmcvj+2nhJHei7hS/In5mEmF2IafnG90EZzCbFDZGJmw8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(42112799006)(1800799024)(376014)(38070700021)(10067099003)(56012099006)(261026121527099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8463uNb/RFOSJy/LXCTJN9KWLHpduoMppwxs9XAjLgkBS5gY9tdS2hHWvlZQ?=
 =?us-ascii?Q?rJJkF3k0BvbU7f0HLrT8M+m8J9iJt5UoyW/1abG6tQEd/+QErG5lbrJ3N3Ev?=
 =?us-ascii?Q?YHtn+tL0X8mcWqliZnAnlRgYwts9S22lu5To9TJMTq3i1hylPzAjGhxkdJmK?=
 =?us-ascii?Q?kBjNwNPFps+hJGOs7iWsD6gCtXMBUclBV/4yf0Un1sJyykSZ5/GBydFhu9Qf?=
 =?us-ascii?Q?IULMe5EftblQFkLXoc2x542G/CUMEp92D2piLDc5O45duWkIzYIjxXIyOgNJ?=
 =?us-ascii?Q?QrxtQpdSmfvf8tGNv2ySPHaVsdZGhZPEj4UhNSm7OgIuRAvHIngaKdUjw/or?=
 =?us-ascii?Q?C5Ar0P480UOJbTN6l0g1dYBazYmM7NUuKBpIoxxyMrIwh4T3ck/iMJeyNfzm?=
 =?us-ascii?Q?+muMirqfFIECGZIpGgMa5y5sVh78hWd8zHcqS+MsNXQDc4Sdr5LBd6rtjeW5?=
 =?us-ascii?Q?deDri4E6qP/YkDsVvbIo52Py2ayEGpGDXSN24Z/WaS+mDjr0JPqoFtnDaio6?=
 =?us-ascii?Q?xMDYxLbKjCKVpvt+cHbiJfCk3ybE3SdKgz244g+MCKXULYaVBD/tLKwz2Cg0?=
 =?us-ascii?Q?uGA9nUpT1XU1x5RDMEOkRbqjJbWgPhG303UhMQuc/VUT55CyuUb/plUt0uHj?=
 =?us-ascii?Q?Q/XMvpsMznCjMXORDfdXDpzdW+Nj3eYtnN78BjISkJntyuDEvjIRaecGO4kS?=
 =?us-ascii?Q?Is4fo5RWFtCtmKX//uvoC/CcJpTov6BpdxTGDteMYwNH/kM8Pgd3TXDBH8kr?=
 =?us-ascii?Q?1d7xUO+UEioMfplz6+LQYH0qY9PBGDrqy74MoRKPOhRyuWC6jTPwwESg3/xV?=
 =?us-ascii?Q?wB8HYEEGBz3IcQCh7D8SmdLsULrckMKlugjhJC34cc2X1CM9ertkRStLK9Bx?=
 =?us-ascii?Q?Pa3MYf3nnQlsy9VLj1B43k0RmATX5nZIWCSeIHXUM4ObLeR8TvcG76hJseGR?=
 =?us-ascii?Q?jTZlwOfhp/1rBnwruuO47K3haId92TnJs9TpZ/nBBhzcURDNTyAYdPVvjXQO?=
 =?us-ascii?Q?tC7HAtBWcmplkhBPBwLxSVNzM/a6UgS0M+OHFWIBd3sqODUeqx51xqSQc+aF?=
 =?us-ascii?Q?QgwMB8ITgawaTZ5xber7AKJcfNM1ZyCNuBN5W42O3jBPO0Np416XdQ8aPVWD?=
 =?us-ascii?Q?DW+Wc+UD3wtxR/nPUGmXOq07vo1Tvf25qXUINlJx+i/eKEzFt/3MMlX18MRa?=
 =?us-ascii?Q?Pje/yvLgDtBhSRK/5s/1NzIGOqnPQDIPdsXjoxQilN55kAVapMj8lBboTwq0?=
 =?us-ascii?Q?c7Bgh+fyAdfwOGnvb+X7gW/w3q3GtEDxxjnhxqdXftvAly1zhBU4lQEJIGFP?=
 =?us-ascii?Q?Vj0Gh0cTsHl/onbdhENSm+eb+DXYm2SVe/2ZoQ0x4Ia/UMNZGD0A6OmaD5fr?=
 =?us-ascii?Q?luPaT6ydp6F3VeRgSfgQrn+bYDUEJQH7NlDjQEuR3d3QycKB251vN3bh0TGB?=
 =?us-ascii?Q?UbM9gJUUqyLebHi2tNY84UgEj0f9KaEDtMQM91ph/awMJ2eXiJIdvhbN7Uss?=
 =?us-ascii?Q?WwJZ+6tgNF0DxOtoql6TYLMCE4puFXCkrJIJE3517Ly/G5LTIYaQ3skK14qY?=
 =?us-ascii?Q?dl92MJr+Uz5yEepHxs7CI9ZxgghBNyPyvHl/lulluhK7r55hhC1YE4Q7FLrL?=
 =?us-ascii?Q?7TnkQcHp/vtbNhssBmRTz23FLSLY9JpnjmqBrrWayQljCfJc9kRk6g4IwXiE?=
 =?us-ascii?Q?VNUNRnC3HIsOOo/hk9kTdrrjF+AzDx5MNcSwHZoEb1HVEyWXN3/eazZyRSL9?=
 =?us-ascii?Q?irl5tGhQpaMfvm10maDHFIKKQzExb2w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <99B4C1ADF02796459A8E23990191D379@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5661fcbf-13a3-4cf9-b9c8-08df4a23cc1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 12:09:31.8353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dbc4cd1-1d79-4d06-ad6c-d195dd1113de
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ug5WrFCEjZHojygpmcWBZiC48vUasP5odpwRQ20Wi0V3XQzvvAVjcxo+79H1XF+mj5h5R4tIoswBJ77MFoCQ5RXbROFNppE0RKxCr6MBDIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7249

Hi Laurent, Hans,

Gentle ping on this patch. It has Ricardo's Reviewed-by, and v2 was also te=
sted on hardware. Please let me know if anything else is needed.

Best regards,
Johannes=
