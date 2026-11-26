Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.1.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795674857;
	b=FSJUxRLO+lgNzlgooegU8GTAIo3Q6z/o7K1OJrHDZeKjXmVlgstmsofKOPwvjYm8MST3
	 z+IrSKWKdsKvaQj8o6KhIAl1Ct+ue5yEHFSKaYgEsoVA4PxKVNBFV0M4YwEjmT8rCWZNx
	 j2aPxeIzUYSmQEyeB3IvAf4q8/82KkpPhQ5JNsG1H5UP4AHygK7UJP0LrzpvwKm/V9XM5
	 Cy4djSuZ1EBBtzMSmUhvhAAgg+9oPlFoZGl7PlgGTzHEgG0PFGj5V0eAVyVg8KA/ixmLd
	 lNnU5rDP9D58PedPpdEesx4Ht7A7cgRhImEJl1sftM1y6pmXz7Bo/dnvx++NRT4rDtw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795674857;
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
	bh=oWn4nJYYCjjltKgGxMW/nnFDOk1mSF73UHo0ZmAzcs4=;
	b=4JDxIQhfArW4Q1EnV4IXhG0mzxX1Op1DLyCvJEfuqe8b9gl3N7ThaAWeYwBIGVa5ZkfZ
	 KXgL1Jsco8GBUCXqkzMREz6Ke9p5VOag0gKgSMJIWza+wzzIjTH6GUmLkYxNA2g+62UW3
	 w8XkkJfs4ijwZWLHiZpVJmepUG9O59V+iaBBDAsCZQcgNylfgS0XwvZsz28BluyaWBp5a
	 jfmS1265if5uL/jS/HfiNO+TNDnL+raeZDhcrRx85fRlmmFTKwx6ch6IdJ/UzzafgydVF
	 Dh+1TfsHLJGGZtmgvKLR9jCxUADLqyBzLx77wB74YD2/qDVdXk5wRuNN4NY68B3n4VQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=PRnGjrE9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.1.12
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19011012.outbound.protection.outlook.com [52.103.1.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322F5606A31C;
	Thu, 26 Nov 2026 06:34:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 322F5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=PRnGjrE9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDMOyBHHIMC2+1KovmAosX8lCFzKkWneXYyk7cIONKGuGlAWs1h0o2VffRuiRmgnU49tVZqmAAysUNVv4CCbsChRRG4LlF0+icWHv9Zu4gnYDL40k998AlIlBQ5J9foTDeuQ5TfqS7P2vvveV5z8XmRfeZ75uJtBxB9fNXRMCj5nbP6XA5lLEgPmVgMY7ULhPrmF66A19sPSuvTqHih5bn2qtMi+EWXRps8fg/qHTBQzjRXi6X96Eu/SjoWDelIQVoHSzsbDTd2u8cZH+ZbQYxPdg7fXhoZ9N0QHqErjm/IBK6CSdSCVlNUxyk4Cc7JoMjx/qB1W9/XqXbrO6IHlqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=oWn4nJYYCjjltKgGxMW/nnFDOk1mSF73UHo0ZmAzcs4=;
 b=zESo9H1Js8mGhWStt3aHviTHIrF8Dsi6yQ8Ddm5bvu36EFxpe3nhxQ9WYiUW1jQJsyKNyCmmau/5/H1zYohTPl2MYa3pPlsLhM0T4CAdpMlgzMakkpCtRq1itJkT8Y8L6hw2JVrYYaCSxmvJt/L/rU8qmnqDRCaHwlt8CRYdJcg8G/NGoU2WpxJ7xSmGx37Ex7EfZyNd9BGKnXF33Mc4H/Ma/e7+xM5rnerKnyHl0bX/aXvqja5E/RElTlx00i5vYjxWQSNr1agG6rmRwzEZYQ3DrVnSEP0bnNK4r3usyz0tFWCe9QGCIxCijPTP88hoGKzODhiVhQ+cqEKkwKbkFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWn4nJYYCjjltKgGxMW/nnFDOk1mSF73UHo0ZmAzcs4=;
 b=PRnGjrE9FiHqdrCAzhSXJmMKn4x8LwrzAhZXDkA0NKGEo5XTBkDYuLrH2N3POAlm3VEe2YuLBv1LnGwpafwaYA8dYnQVI4j41sTJ/mc2wsatHkE8QRynQz0WEi+WLmcuouAWW9GvqVU40HnxQnc72l5iC9fRvmSUEA3X/bJz4YEyX/VnIekt+bRDWhXjSklgMgk04UzzO1Sf8LdGIyU51U5+vCBtkzz1B7IvKijecHhMRDmWlbTUrUqdKo6x8wFUtBQ192f4kJRh/hRAc08ussUUC+Fg5vcG8b8DWuayZNDvfY8IG+qJVhHjrnTlwAV55NbuO+wlSEzpC5A1BNwQ1A==
Received: from BN6PR05MB3281.namprd05.prod.outlook.com (2603:10b6:405:40::35)
 by BY3PR05MB8273.namprd05.prod.outlook.com (2603:10b6:a03:3b4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 06:34:15 +0000
Received: from BN6PR05MB3281.namprd05.prod.outlook.com
 ([fe80::5b9b:67c7:5397:c42]) by BN6PR05MB3281.namprd05.prod.outlook.com
 ([fe80::5b9b:67c7:5397:c42%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 06:34:14 +0000
From: Yingjie Wang <x-professor@outlook.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH 1/3] null_blk: reject device size overflow
Thread-Topic: [PATCH 1/3] null_blk: reject device size overflow
Thread-Index: AQHdfXAmNGXFYr7JA0mYip05S5CSyQ==
Date: Thu, 26 Nov 2026 06:34:12 +0000
Message-ID: <20261126063404.1051061-2-x-professor@outlook.com>
References: <20261126063404.1051061-1-x-professor@outlook.com>
In-Reply-To: <20261126063404.1051061-1-x-professor@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR05MB3281:EE_|BY3PR05MB8273:EE_
x-ms-office365-filtering-correlation-id: 6e8833e9-ccc8-43cf-8252-08df4b874a4c
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999013|24021099003|19110799012|31061999003|38102599003|25010399006|8060799015|8062599012|15080799012|24121999003|22091999003|8022599003|41001999006|26121999007|3071699003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?sEi2MWEVNBGLPa5b9Eo6CQ728VdhlpJdMKdrt69xfYGau6+OjV/Ug1rmqs?=
 =?iso-8859-1?Q?g2q/q7lhbeGXv/buJcVargODf0IRqQr+iBYnTPoXjZXtj77JDOB5B9mTx1?=
 =?iso-8859-1?Q?cPnFOmAOqreJ7qVIf+rk1jcanKeXF7kaDztadNf+etoraGFzOq3i2eObEv?=
 =?iso-8859-1?Q?QjgpFB+WUzXItUy9g/So9uH86M67mWNyMusfJs6fEa5hmAXrWOGxIfe4pX?=
 =?iso-8859-1?Q?ciKv2rJmMkhrxsIhZQaDvZxoI0pifrxVTifGcrOI2p4apmFXtoqN6LBt9O?=
 =?iso-8859-1?Q?BUowaQBoBbzhImtzwlGvjF0RXc6IaL51QoXm/JWpphdxVTDvPyUKDC5Dmr?=
 =?iso-8859-1?Q?NsyC69huMvRIxduitaQ0qabcFNp7/a/gIujN/GFYMmJ6IWpRyAZZVQvVaf?=
 =?iso-8859-1?Q?gbf3yRuSLUu5hXP9yCuapG8mooYWccfe+gARt7ie8Aq5qfMGGc4Jxq1fnc?=
 =?iso-8859-1?Q?OGDf1gUJDnTvHtW6LhuBXD3vEvIT4/t5OlaYWdYgd9OKEH1ScwwhLz56GT?=
 =?iso-8859-1?Q?9UfoWPoLAI37hNLUNbLimmFCKYn+i1XQdhCJNES4P/4DdOpv6pRwhBx2X4?=
 =?iso-8859-1?Q?lG0SKMgxkZU3DgbO3mVAuTg1kMU+Tm94A1g+8nJ1lLZCjqovptDvF0jn+4?=
 =?iso-8859-1?Q?Phn7Ow8QoxWRDV6Hvdrgl/yEBDEVBwDCKG5q6c6tgCYRloA/L1AaTCtfMv?=
 =?iso-8859-1?Q?DNBaFvU3uUU3hxXSVSClciHn2oW5bhPrHNSCBWybh/+ssiRzeHf/2m0I4l?=
 =?iso-8859-1?Q?/kQl6tSyitx8bXRkmZ7Q+wsPprMCJdYflM4uwC13wT9V79wktOajP1+jch?=
 =?iso-8859-1?Q?w/AmMDfAVUK7vrKBvVaKEP+p/BhCWwCjDvTyzsGlZrpsupxOAjel+5EP8n?=
 =?iso-8859-1?Q?4e3Pq5fOGFVUq19HtVd+lwfrk7wmH+0I0Tyhclq1wwAVkR42eke1b0Imra?=
 =?iso-8859-1?Q?2FZLzXfAztBcQsWcK5PdvNpZinQ7lupAjsSfo4QJSFX4Q8hhLqZ7kiaZa2?=
 =?iso-8859-1?Q?1H4R2rYHs0sR6bD7qTMQYrpVk2qnpzC7OIt5eyMjLPmKgYRSNIa0XJjMCW?=
 =?iso-8859-1?Q?MRHkn3Bwi//TnItKa4SLA6XtjlGCt9ZwqjEQCtz272umSYvXFg1ni4BtL3?=
 =?iso-8859-1?Q?iDwvR0dnPsgEZft0yzwPFmj9TVDB/tUxe4KaGoMIpTAtkPYV/b?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Ub+YD7tYt5y0CxDF0TpncpuITsjaFDReFL1MbEaKDTOm7dhaEDcLwERVPC?=
 =?iso-8859-1?Q?caymjH52GXkQ0286dlr//VS4egyKbRt4sV7TM7YYtjqlSvw8ogVKUgdQAT?=
 =?iso-8859-1?Q?o4S1TwIy7mMGlyNI5kOG2N7SnEDfGhLy6bUG1Y90014ASm2Vuwfm+s1Jr4?=
 =?iso-8859-1?Q?IC1rZg/PdSsjiSxKbD9bOkbSiRbYL1bbVOC0tP/f4McJfd+jinDC1W9jBo?=
 =?iso-8859-1?Q?EjEJrq5TloQ5z6NDMJqLRmdhsYiGueDG/o/p83QQmE7xSupj/87yYQ4nzk?=
 =?iso-8859-1?Q?yuo6dnTlSv5X3OsJqqvK8IFMxbTCDnYUBGx1rfzfcwUkHDdmEdN2EDydTh?=
 =?iso-8859-1?Q?fnoR20RMrXqeH60zlnmygEFqQJ/chkH+FvGauVpVy8+hfOkHhOqyQDwszw?=
 =?iso-8859-1?Q?hqJ/IWTxPX4e+uDO+4UUGzD4UKQKjwsAlIZdj4EO8yB/ycaUQCkxtn7lqK?=
 =?iso-8859-1?Q?Gb7UyvmhWZmtuxmeEqlpKzerSP+ye8ff6+3ETl8aYDcUghBfV8BZdGlXNh?=
 =?iso-8859-1?Q?6eZtygdjqt+ryWLFbo4CQvXbPmKl7WL6vSkbvwWnxXUlN0vHtfSmGFkRIp?=
 =?iso-8859-1?Q?0rySnSn3BmVHcBDFmZ9WqlFkgOSVl9+b2R3jEi48NyTTO/i6rZ79ViJlfZ?=
 =?iso-8859-1?Q?uLYnOtDV6U7K1TRGKkzj6p58OtoJabFpyPGi0Myo74pb2kgFMVylXGRb7g?=
 =?iso-8859-1?Q?K0sjzeYO5msWjFCpNFFwIQmagFsmVAavQnBYhdVYQYA/lpUiFZaKIHNk5+?=
 =?iso-8859-1?Q?uNiq8iAQ5Vt7/TdLDIv0lRwW01y+qRA5vZRV/cBUfVrcon5c2gs2VANb7J?=
 =?iso-8859-1?Q?55jneKc4EXofOWOVewYV2Gpgxb0mexGul3usozMfm3YWhFd/GYQK42Goxu?=
 =?iso-8859-1?Q?KGwpbqVMTnWuL6KexvzIOFxCUIdKn4E7oLcS6U+iiBUb6FLaAhEj7D4Ylh?=
 =?iso-8859-1?Q?FKwQGZ64MqyTX0m0qeRX3z+G5V9YYb/bXVFV8/+WZ2Qbc7ZEWviKz/o8r0?=
 =?iso-8859-1?Q?/WU+9Vn+hfJ28IleKHSfdvcIEx8PXxcyThjlUfa9/KNWD2vr+e2RBIEnXX?=
 =?iso-8859-1?Q?dOFxF1j046lZlXlQ9bzqCjvJ2eg/b8t4WfSSlGoDDnOKsWmjGaCeOPWV/T?=
 =?iso-8859-1?Q?inGoodufZxUJfuyMEqZPlG2KhSpIQE3kSkeFKfUyvf98wUjmoa1Cqe8/4l?=
 =?iso-8859-1?Q?7Torg2haTbyn0BMRkHPLA/cDTSuHH7h069fAZP03Xq2+5peP7yR5ir/u3p?=
 =?iso-8859-1?Q?s9jzBowlnn7s+koklza2suQZO46mWMlQNR6D1Thmx/+yqITYIW3MvU9KWL?=
 =?iso-8859-1?Q?ZCqlLBRQF/BVwds/HUAx4PPT3ZnrtvvvI3j90MBSb9t+af17Hwy6lE3u6s?=
 =?iso-8859-1?Q?MIYQqHdG92P1X5yy4ShLGe8AXwnb4bFICKrVn1LArHdegRoUpFL0s=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e8833e9-ccc8-43cf-8252-08df4b874a4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2026 06:34:12.2530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR05MB8273

The configfs size attribute accepts an unsigned long value in MiB without=
=0A=
checking whether it can be converted to bytes. Both null_add_dev() and=0A=
mb_to_sects() multiply that value by SZ_1M before converting it to=0A=
sectors, so on 64-bit systems a size of 2^44 MiB wraps the byte count to=0A=
zero.=0A=
=0A=
For a zoned device with the default zone size, this also produces zero=0A=
zones. The zero-length zone allocation returns ZERO_SIZE_PTR, and the=0A=
conventional-zone adjustment underflows zone_nr_conv to UINT_MAX. The=0A=
subsequent zone initialization then accesses invalid memory:=0A=
=0A=
  null_blk: changed the number of conventional zones to 4294967295=0A=
  BUG: kernel NULL pointer dereference, address: 0000000000000030=0A=
  #PF: supervisor write access in kernel mode=0A=
  RIP: 0010:lockdep_init_map_type+0x1b/0x230=0A=
  Call Trace:=0A=
   __raw_spin_lock_init+0x3a/0x110=0A=
   null_init_zoned_dev+0x5a2/0x1270 [null_blk]=0A=
   null_add_dev+0x15f5/0x1e70 [null_blk]=0A=
   nullb_device_power_store+0x29d/0x350 [null_blk]=0A=
   configfs_write_iter+0x306/0x500=0A=
   vfs_write+0x6a4/0x1030=0A=
   ksys_write+0x12a/0x250=0A=
=0A=
Non-zoned devices can instead be registered with a wrapped capacity.=0A=
=0A=
Reject sizes above LLONG_MAX / SZ_1M in null_validate_conf(), before=0A=
allocating device resources or initializing zones. This also keeps the=0A=
byte capacity within the signed 64-bit range supported by the block=0A=
layer. This check runs for both configfs power-on and module=0A=
initialization.=0A=
=0A=
Fixes: cedcafad8277 ("nullb: add interface to power on disk")=0A=
Cc: stable@vger.kernel.org=0A=
---=0A=
 drivers/block/null_blk/main.c | 5 +++++=0A=
 1 file changed, 5 insertions(+)=0A=
=0A=
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c=
=0A=
index ec0d7ba4d938..2d6d71690d10 100644=0A=
--- a/drivers/block/null_blk/main.c=0A=
+++ b/drivers/block/null_blk/main.c=0A=
@@ -1893,6 +1893,11 @@ static int null_setup_tagset(struct nullb *nullb)=0A=
 =0A=
 static int null_validate_conf(struct nullb_device *dev)=0A=
 {=0A=
+	if (dev->size > LLONG_MAX / SZ_1M) {=0A=
+		pr_err("Device size is too large\n");=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
 	if (dev->queue_mode =3D=3D NULL_Q_RQ) {=0A=
 		pr_err("legacy IO path is no longer available\n");=0A=
 		return -EINVAL;=0A=
-- =0A=
2.43.0=0A=
=0A=
