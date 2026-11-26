Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.1.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795674859;
	b=HZGbL1SXqEn2mJqi8V5YD2QANEATN9Z2COGmGdAn2g+fRFpd3391/M2gSSBG8c0XIdLn
	 qDG/wUI5lytJBNno6ovsy1N6uQKNLWhEYxcAXmyEQvIcjPAvAhfFEOlfhLiXDClGXmEJr
	 jDH0U9LN5XxlY+eHvOkR76bPJAJPEfR8b+fr/CC8cXs8iUq05H6xjXNr2+cWlL6Nn2r4g
	 WOoW/+8GVpO3Simpx+s+vKF3tm5GmgCkljOoQIwatL9i/thGmZ4uOkufjU1zagmR9+RHy
	 ieyJOzKRN4eAnbkGqm0mxhA1Y3W5k+nkKpy8SSSlmInTLLzxXcH/d8eiHUknnJlw0Xg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795674859;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=6CM5h6C/hP3aMV23NieQeGKAVSGLZdvX2gIAglh7qi4=;
	b=PPvmvM8pW1yYPfzNclmEsGc0r73/lEoHlfGPncc+lNzmYK7cJ5zmCfEpR62fUUVFvrEw
	 hF6aCPd75nGppKpsJYKDpbMUwm1ZblvBaYVlArmzOa+Dmrgz55ujEFy3LPKOAS0In0HEA
	 I0C35PLo2ubDPXECj5o1pZG0iE5XfqRD2gQlNo6SRz8hy5GocWLFPbOL+Kd0L8s0MHZOj
	 p1cxgPuOUpEI5wD+ItF8XB38DwCNKw7BJChtoiN1KsdFhZPBixlSbTFo4dPhkG7ya+iiS
	 CLiR3Y4R3N8nzieaAaYqKu24jWCIaHum3SQ5DVCEZlEXGZv8ZllYkH8BZ261f51hgOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=vKte92N2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.1.12
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19011012.outbound.protection.outlook.com [52.103.1.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A669C606A330;
	Thu, 26 Nov 2026 06:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A669C606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=vKte92N2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syes1cCDGmli+VPSZQAU33xd6URRdyu/yHkKeL25BlUaQzAI7QDbGcFlOYZ942MxvtUEVTN5gMsyvYwkDH6fV1tRF17XEPJ8DWbe+zjko65jg2Go9JdkKPEwQ+rsJJ4UpSzUu7sEL7Ki5yXVb5RWMNvcrXyZJdmOgAhYnTLxnGZzvpHQB3IqeS5zAdUJMulVsGxG0NPrGsTCe/b8kNWFOQeEDtz5vpJKBCyyoCjYhdDYr7z6fuRQA+lLaUkE6jiVwmT+auaUCRX51Tn4w2hgYR8q53KHA+v9si4lUdFFxkx0uMe66SEPPGVUlqcfeuQXXMNClv7PVF7tZeH+ZywZlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=6CM5h6C/hP3aMV23NieQeGKAVSGLZdvX2gIAglh7qi4=;
 b=cbsMLkxCWoEtYq8OlkfdEubz3bQX7BaBafLiOpmmEGePUapeZJQof2s0J/zWoti+o1jvlWeakAs8sAzv5bNatMAJWQB+UrlxkKjIv+tuHd3VXOEyIai2S0ZPrWGIe4Dslu6QWwLWPsddiYLlJE6O8h4UdYPiTUDMtWvRFJ2ber6lXa1mmjDCHkL8kajRgQBEXczA43/ihyRcDb1e1qLkuDFkI/NJp0MgcuZzlz2n8l7TI0OBAXtaOeYrec0falA9AaGcezmhuc38wy+Ib4tWvWJtcBSy2L7AAAGusC3qPZBWuoUrKlD9vOTSm83ufNPM8RJMLeOkVgimFNLpNMqj8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CM5h6C/hP3aMV23NieQeGKAVSGLZdvX2gIAglh7qi4=;
 b=vKte92N25CJWciJYTLXl7yCmYHRFRqNhpb2nPy4m5LAV8zq5FvNzzv8zyzCWBgVevlKEiKwP1X1SrhE6QHO9OiROfcEiJjbkIXwRyHW1obTSS6BEiOFqBinFErJ/lNmfAJrSWA38JYPlcWQ+NizL/vbGui7T3Fwn8v3EsesxEliHttyvlWiXAygpx+JitqD7gpSt0obAR8beONXNszhrxB9RI0K1oBt9cOc/Lan1CiCfiHQH4AmnDeOICXZELZNBnzu9LpQyLPvEJt7bxpc4gZy4FSEIvvwZy9ALsM68GYm/T0ZAZauR0hwh8RF/GorrHEff8knc4mXYFDH3IMqCJA==
Received: from BN6PR05MB3281.namprd05.prod.outlook.com (2603:10b6:405:40::35)
 by BY3PR05MB8273.namprd05.prod.outlook.com (2603:10b6:a03:3b4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 06:34:16 +0000
Received: from BN6PR05MB3281.namprd05.prod.outlook.com
 ([fe80::5b9b:67c7:5397:c42]) by BN6PR05MB3281.namprd05.prod.outlook.com
 ([fe80::5b9b:67c7:5397:c42%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 06:34:16 +0000
From: Yingjie Wang <x-professor@outlook.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH 3/3] null_blk: validate the configfs home_node attribute
Thread-Topic: [PATCH 3/3] null_blk: validate the configfs home_node attribute
Thread-Index: AQHdfXAoonaIqM3LYkmEIfl3X1pmQA==
Date: Thu, 26 Nov 2026 06:34:15 +0000
Message-ID: <20261126063404.1051061-4-x-professor@outlook.com>
References: <20261126063404.1051061-1-x-professor@outlook.com>
In-Reply-To: <20261126063404.1051061-1-x-professor@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR05MB3281:EE_|BY3PR05MB8273:EE_
x-ms-office365-filtering-correlation-id: a8bad55c-92e9-40e4-1662-08df4b874b19
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|19110799012|31061999003|38102599003|4140399003|25010399006|8060799015|8062599012|15080799012|24121999003|22091999003|41001999006|52005399003|40105399003|26121999007|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?7VvPKOK3/oq9i6RDzlgNenx854MCOieY/RLJW35tpiN6m8F+o8mxeuPYHF?=
 =?iso-8859-1?Q?2h4GYh5XN6zDbYpV7Zdgkg8GN6MsgeWIUv1Ov8+4Nev7hD1/11zHqssaA+?=
 =?iso-8859-1?Q?DjQpHh3FkBd8aAmEehz0yLyT2Gv6nI9GOWTFzk3rBaxKwEdv9FLkjNLs1c?=
 =?iso-8859-1?Q?1CPoGys9kc/7LgjZG0w8e277RR0TDtzu1d8gMds1hl4UOqcxdR+TVffjla?=
 =?iso-8859-1?Q?ZfBpPFpXhsYk4NHDJijWPBHllyItC0yfevbpEGfDuXoccml0T6W4HonPl9?=
 =?iso-8859-1?Q?g+x08QvyyAjaSoY37wUuHAW7zK3HmjU2Z5cgzcTYxFFTK4NXWFb2pz/TfU?=
 =?iso-8859-1?Q?KFDzWJkyDvdQZI57JdgXMk9YHVKJw2s3a3xn17q167aseY6ZLWbWPbm1fQ?=
 =?iso-8859-1?Q?kBr1vTawxjFY2ORZEVJH5WrAk+c2YZkgFMq0m/wmFm5KjAOQnq4Vor39mj?=
 =?iso-8859-1?Q?Dt1ORoA7aCAwsQGJLlXYnUSFSk5frHIU0Eu3wtOZQj3yj81Mb6lv59H6zb?=
 =?iso-8859-1?Q?wl/6hGlpturDwdtEt55U8sIlaHX1bDdtDHj1JNxVcL48q6UewOVPLfT/CC?=
 =?iso-8859-1?Q?DkwH0axcNh4D4lG1I4LqXqPmAPVMwQl+K7Nsx076kMfyTUlNeXqiXJ0nYM?=
 =?iso-8859-1?Q?C7vbKJWf6cJH3BO6Q7p+iDiSXWvebIEOtfdOQpdArB3hpvf9mOVd7Du37X?=
 =?iso-8859-1?Q?HGk+7bP55sa6HK/eSEX/gIzDaQ+IcAeC+DpKnFrkimrwsKKEl3x2IWsqcf?=
 =?iso-8859-1?Q?+aMchMB0If3o6BvWEWkYvsMaVvuUPfB/bZW8emL6Qahtw5yar42DnaLse7?=
 =?iso-8859-1?Q?A1UU1hLl4bwycngvBiY8DuoqiwnkTRpS/YB8tHVXPp2e/+Gh3ynUNKwZbr?=
 =?iso-8859-1?Q?JBqFS0GpOOVanZkLmyJkxbjOFA02G0Lu6oTFcWva9vLSTFdqPNzjGRFh19?=
 =?iso-8859-1?Q?3EEcSlKrQehVqUZJ2MlrCPZRnTNMEf7I/jVcgtBouD9It0USoIgsZZYmkJ?=
 =?iso-8859-1?Q?/CVSFUo6aiK5MVFVVCxO8cwp+7vT7ZC9Jg11sDAU4Tj6dTvq9WwjeWdOl+?=
 =?iso-8859-1?Q?hkBMfqZoX1QfpmxjSBlQfyYXZ3Ec29JA6xh+1M2jgxf9cqrUPuLB2G7Vem?=
 =?iso-8859-1?Q?dVU/x2EA0vaDQVlAgYLb6TJXvKzZo=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?TG/SiIIG876qielAUD5+trDAxKTHnW9ctgNsnbrHs6e0sktmcSWSkPPcnd?=
 =?iso-8859-1?Q?7czrrpawk5CiMuISZ4AZp+SHdCV8MECHZTuSBNK5IeGlyP/fJK7sq6zvCM?=
 =?iso-8859-1?Q?zlQPrBYOGdTu535JPnGotV/GiqybmJ3J56jZbt/4Cvr7hCC764OcIS4axR?=
 =?iso-8859-1?Q?ub2uHsiWcZXReq6M4fgq3ZmuattNbFjcPoZLjDRi+gmOU/CkPR7HIu199T?=
 =?iso-8859-1?Q?mH+Xv7catOyv9rX1THA1vss8p8HKEt5RqsklfUG/IALKJ3L2k9esK9Fqjh?=
 =?iso-8859-1?Q?wJyLh3LotdHoVvHcxh0mujC6MiCxvqM2pYqmoF29PD86kywmnHoGtMBMjf?=
 =?iso-8859-1?Q?2J2D0YpzbetKOEPkZemaH7wDUxP5nvbcQBmyFoCW3rs3++spXGE2fehd0S?=
 =?iso-8859-1?Q?GmOcHqxqysNpwHUHpYNwFbIQNX+Sr8RF5++8vXjp6es+t+MpVzO01BdJLj?=
 =?iso-8859-1?Q?ch85sLg7iht47GM48E/acBoT897TnFZTV9fVwX8tRgX6uVRo14R/b9j27Q?=
 =?iso-8859-1?Q?6OL19PYWxcqXZJPz7NmX9dwoFTzzAy28l25H+uF4EGZ9X4fCbIsGHAP8Ue?=
 =?iso-8859-1?Q?RTDpZBxh2FndRDl6SMj5FrC/fFWwQoYQLxURHq8EwN5q1hBtuS81xlOY24?=
 =?iso-8859-1?Q?Cy7RkL8HdNUlMiAXEHHST7AaEtKx7XezmjnRuKWE1dmWImkIdT2O9RsiLU?=
 =?iso-8859-1?Q?VKGzHG7ZGku8Hmixkei2p2VKFv9elrc7xelg4O6M0qKFTWBO9SlO+7Mdm+?=
 =?iso-8859-1?Q?oVZnvX1c8H0N0u4yQGnttuShRif2xW3jukiggj76wJP4lcaIaTMrBiCaCz?=
 =?iso-8859-1?Q?E9zFRezPmeFb/Qh+YMvx5pXrYVrZskro0RHxlhisznR0mtRfpcMS3qrnSW?=
 =?iso-8859-1?Q?PgaSNO6Z6MTCUz6WgH3flOWyFnwGvbPcsr8ucIK8M9U2qPN3uF4WZLNUVc?=
 =?iso-8859-1?Q?/hLdRpv7IqexQ25lMZHxpC6dvs1mDdCP1u3k1iOf74NV8gqPlCDFiW/cx+?=
 =?iso-8859-1?Q?R6w2HFs08ftjOIb3aGT1U4lSORwifcv9NZMUuyBA8BCoGtWhBm9U8c13lL?=
 =?iso-8859-1?Q?B9X6DaAQ8V/x0UyKlSNUl6kn358PDCd/rC4tkSo3gmIqBfHdB2a39YUaLD?=
 =?iso-8859-1?Q?uv0qPafXt/noi5zkIgbz2MLA0B01rEuiSIs2U6VvTQUHRn8RM20F1leuJZ?=
 =?iso-8859-1?Q?3xqZzLnLeLqNhQDWoZEmFJ0cbGVswy5yi6pGqLnATb4O1TgwHge/d4mL/7?=
 =?iso-8859-1?Q?rOzWQQr3Pu9NqOPC0fyFHCIRtcpGp70tBZqrld5uyuRGXFH5mk2tjgDbQf?=
 =?iso-8859-1?Q?doSJ1R1PLoKKbg4cQ3mKhn4ZCWPr0lbiiRK+x5FDb7fr9RR56YQCn3/3QM?=
 =?iso-8859-1?Q?T7KZ0dVcNqJ+Z3Fb9EsihrPsZDaj2v2eryM0afrtL6sSWe4dnrO90IAMO2?=
 =?iso-8859-1?Q?G2DyVAjFzBIGtpZS?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR05MB3281.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a8bad55c-92e9-40e4-1662-08df4b874b19
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2026 06:34:15.5402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR05MB8273

The home_node module parameter is checked at module initialization, but=0A=
the configfs home_node attribute is stored without any validation.=0A=
Powering on the device then passes the value to kzalloc_node() and uses=0A=
it as the tag set NUMA node.=0A=
=0A=
With CONFIG_NUMA enabled, writing 2147483647 to home_node and then 1 to=0A=
power makes SLUB use that node ID as an index into kmem_cache's=0A=
per_node[] array, causing an out-of-bounds read:=0A=
=0A=
  BUG: unable to handle page fault for address: ffff88880b042e80=0A=
  #PF: supervisor read access in kernel mode=0A=
  RIP: 0010:___slab_alloc+0x5ad/0x760=0A=
  Call Trace:=0A=
   __kmalloc_cache_node_noprof+0x2dc/0x600=0A=
   null_add_dev+0x588/0x1e70 [null_blk]=0A=
   nullb_device_power_store+0x29d/0x350 [null_blk]=0A=
   configfs_write_iter+0x306/0x500=0A=
   vfs_write+0x6a4/0x1030=0A=
   ksys_write+0x12a/0x250=0A=
=0A=
Reject home_node values other than NUMA_NO_NODE that do not name an=0A=
online node in null_validate_conf(), before any allocation uses the=0A=
value. Checking against nr_node_ids alone is not sufficient, because=0A=
node IDs below it need not be possible when node numbering is sparse.=0A=
This matches the validation done for the PCI numa_node sysfs attribute.=0A=
=0A=
Fixes: cedcafad8277 ("nullb: add interface to power on disk")=0A=
Cc: stable@vger.kernel.org=0A=
---=0A=
 drivers/block/null_blk/main.c | 6 ++++++=0A=
 1 file changed, 6 insertions(+)=0A=
=0A=
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c=
=0A=
index 2d6d71690d10..22c284748645 100644=0A=
--- a/drivers/block/null_blk/main.c=0A=
+++ b/drivers/block/null_blk/main.c=0A=
@@ -1898,6 +1898,12 @@ static int null_validate_conf(struct nullb_device *d=
ev)=0A=
 		return -EINVAL;=0A=
 	}=0A=
 =0A=
+	if (dev->home_node !=3D NUMA_NO_NODE &&=0A=
+	    (dev->home_node >=3D nr_node_ids || !node_online(dev->home_node))) {=
=0A=
+		pr_err("invalid home_node value\n");=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
 	if (dev->queue_mode =3D=3D NULL_Q_RQ) {=0A=
 		pr_err("legacy IO path is no longer available\n");=0A=
 		return -EINVAL;=0A=
-- =0A=
2.43.0=0A=
=0A=
