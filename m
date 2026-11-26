Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795679274;
	b=4zg7qNfLGocuVRvGD5iAPxtHXKePMlHPD2kodIiPlnKjeYsGW/Jl/pfnDZYRaIY6P///
	 z3gMme2ZxPajYLsJo0wm4BUNcaNrp76X6vgrap7Yay/oUU+HLcsirwc6dlC2Ztvj73xhe
	 Dkoo8wPYNQkYSrFUd4obXMatmsnJiSyPsLQqqo5WVw+x5PXYwvZU2EKx9BAz1TqSmRgxq
	 34DmFEh6FeKRxpqQCUzPQGJ8x8eZK4zkEJWliYbPSgErE2/p0QYzeQwYxYmqknvJKVX6Y
	 tQEjpFOXKoOyTAM+KV4zNuhTSWswFKrAwewhImlGMukiyLBUtSRnLojssMES7/RRDug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795679274;
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
	bh=mrGvaeBv6AJaxBG0T3uLA3KREt+CTd2oEaKM9Zl/pnQ=;
	b=b8UezVeKxz1pyReRE/th9tX9bC8kY71aK0Ggjh9+u2h6W0BTK4sg4RisiXe1Fv9hnTsh
	 wmr/lLwrWbhEUNoMJC0ftqgAh+/oYjae23VG14848UGAUMZnsaqj1WTf5VOnv4k090Hx3
	 UPQjlc7x+KO2yv6yt5I6vdV8iw66TXsYXx6piqM0j2Z/WCOcNqK3DawrcoOJ3wkC2b029
	 uEV7+cTxegtNItqLxHSahrhSi7/WTIDdZosOJFCw2yD1AEwIk8N3jtjqcDIORrGQY7IMR
	 2U3NDZYUTmBm9+R37Y4THWb0Bc65WQTC4vhVObzT1Fdiu9riHR2k49VZC3VCHnRsv+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=rqMm4Twy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.6
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010006.outbound.protection.outlook.com [52.103.20.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33B7606A323;
	Thu, 26 Nov 2026 07:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B33B7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=rqMm4Twy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKPfVCgk0IVFx7pIXLquNLWYrJvOVRWMwTPMSyWI7g0slG9tCeZiblScmbXHTxdVdYKw07ROw0ummCa03NRfeiBvv+cawRs+eWFUduB9BxKoIs+8NM7Q06z2eFhmW3aIcsst/+TAUdDctsUlqAQEUQe/PS8AYouBiUzNuXJLBETdZBGQnQhYZPnvm2Tts8OJag0Mk34/KnnYHv09rHWnYbs2EZT2iHoVOmYN9oVzo/MIxJf2w8EPa7nGFguY4qaumwZMGE20zAoVsYlKJPGsVw27yGlSb9OnDIHG4iRvqcfeaqswcal3PvHILWPPvM14mA3wjumiDDwmLjlCh9XGoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=mrGvaeBv6AJaxBG0T3uLA3KREt+CTd2oEaKM9Zl/pnQ=;
 b=tIeF9/RDIvnG2jhE9rzFaui4TksccijJUPRxAHUZz93G304m17lv031o1tTcnEs4j16RPHJ+oy/lGtK2ZUFwqMhX1avOBwqSLHc4Xn0PIt151D7ZVPLIkbTN6hk1v1Ly1xelZAT5B5iHpcOWT6LLNEV6/lf09qQNkFd7QbFjrN/0RTVIlRVPPkgK2IXalSs44Gn8ha1Tzvt1kj0oQQOMNY1vNa14S1F1GoO8OvTWZCORLboPGxgtbc+nYhAGgrJKYaKEWIcupvWQGbrfK+t6UEPL8zgClPHdWiS9A+/L8yMaIfukRF3XMXXd700I0OGdwwS/UxeZXC+kQzlV48KXhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrGvaeBv6AJaxBG0T3uLA3KREt+CTd2oEaKM9Zl/pnQ=;
 b=rqMm4TwyZ7hCH85+RmvVu783M6b6K8xnXcevXYXY0oSXlmnjxyolj/U67Cy1WXHHrW4v6LN7xabb/yHW5+YEZIyfH2RrnWd96XvSga71e4UVUYEtvhZW9NDq9/Lca9BOSyRuAj/ENfQFR/fHMjbKq4z04lF865fz9JQrkiIMy8p/y/oNqChwIX4hbKo5KYnnivxqJiue9jGCUGxt8AFpebt7WIXA5J4hD3pO+fBCERMaot3C+IZSAoBQ7u8HxdSHj9HDhakZhXXneXmDPCjnYhUiEvSZJVj3xvhOpnwTrqNVvV/nZvsqH3ydDGylZzWYKhJyhtVNUl9fGPdISAuy0A==
Received: from BN6PR05MB3281.namprd05.prod.outlook.com (2603:10b6:405:40::35)
 by SA7PR05MB998597.namprd05.prod.outlook.com (2603:10b6:806:4cc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 07:47:52 +0000
Received: from BN6PR05MB3281.namprd05.prod.outlook.com
 ([fe80::5b9b:67c7:5397:c42]) by BN6PR05MB3281.namprd05.prod.outlook.com
 ([fe80::5b9b:67c7:5397:c42%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 07:47:52 +0000
From: Yingjie Wang <x-professor@outlook.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH v2 1/3] null_blk: reject device size overflow
Thread-Topic: [PATCH v2 1/3] null_blk: reject device size overflow
Thread-Index: AQHdfXpwHq6E43PHjUqgYKzEhECFag==
Date: Thu, 26 Nov 2026 07:47:52 +0000
Message-ID: <20261126074748.1076774-2-x-professor@outlook.com>
References: <20261126074748.1076774-1-x-professor@outlook.com>
In-Reply-To: <20261126074748.1076774-1-x-professor@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR05MB3281:EE_|SA7PR05MB998597:EE_
x-ms-office365-filtering-correlation-id: 23ee8219-e34e-4ff0-f7a9-08df4b919347
x-microsoft-antispam:
 BCL:0;ARA:14566002|4140399003|24121999003|15080799012|8062599012|8060799015|22091999003|12121999013|41001999006|25010399006|31061999003|38102599003|19110799012|24021099003|3412199025|440099028|102099032|52005399003|40105399003|26121999007;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?LxYjCAnp+qec32DbW14XO/ymcvO9272Syxfith0T4QUnEgHA7Qr0cywoXp?=
 =?iso-8859-1?Q?0H50kj8+iZu4/8/JWxErs/ZwGpGZxqWVq2nyonSGt8QNcVCoJtvqkqvKy8?=
 =?iso-8859-1?Q?7R0lz0zfzGvOh7tw/cnW5p15KwYUhUz06aFYMp4wPAlcpge61sjixOG1s/?=
 =?iso-8859-1?Q?BYYYK56McaAl7iMULEPjh0gN+fO552nO6eAgOk0yvCAPt7ReNqQkQRkMA0?=
 =?iso-8859-1?Q?Y/ZwTtg9IxXiJ8M+gjSKomhG2JeFs+VJYnjk3kdprE7XpeSrRdeSXzAqER?=
 =?iso-8859-1?Q?NK7jR/WOY2PB947V4GlArK2JOYmT3SyAXVQGurQGaOkbfn60HUHQYznOZ+?=
 =?iso-8859-1?Q?rvJZJMxYjBXNZu15BDyk4xYq2MXJQIoyUk9D01DGoUY/prTPdYGn48hMzC?=
 =?iso-8859-1?Q?JAQ9KdPcqxSh6rvIPFGGnMNe3JG0iuhcvCA6wNxPTaquQtRSa3HYlxQufX?=
 =?iso-8859-1?Q?/b5ZDwrLo/dkL2oJqzn26YNFyb1azYFqyr9iOZ9NmaNqL1Q8/nKSmTktoS?=
 =?iso-8859-1?Q?JsQnltP3d+yfEDDE1zxPGOXAMAY3x53jlJiKTOM4O3bg7w4gL2VADHamtJ?=
 =?iso-8859-1?Q?hEfkjlWAM1kAPMyO+vKaswjkMpchviakAuCGyWaA4en8M0Wc7FIz1hih6k?=
 =?iso-8859-1?Q?PNXCXi1OvUchFFsdEnSjxBGEgGJL75zNPCLB7kz3ZD32la4eHtZAo9TqHT?=
 =?iso-8859-1?Q?RBO4vl65zlSNHV00xAZ88M/XnK4nzXDlHAVfDkflijiOsm7SZL6OFjNkoo?=
 =?iso-8859-1?Q?sMkN8Qv40pkg/aMmiqdFhryOKwhISKNeb5Rv1e75ypISIzwCoDee+AXmZN?=
 =?iso-8859-1?Q?dxnIXGccziCtM+tKGLAC9dceIotFT0YeNzOMVBf+IJ/Asjl/ahekNeTLDx?=
 =?iso-8859-1?Q?DdQnQsOAgvbvUpgVSwDddjU7gokNCGRFeO4+X1lT1j+vTjoCZVz4GpF4Ao?=
 =?iso-8859-1?Q?MSoelRO5T9pDZI/y7e8jsp7wvK6VeafruOnPME+8FVtzGUgqWV9Yd4KJgM?=
 =?iso-8859-1?Q?DbAab/k3fsXJcIvO34XiM4WRFVDIBukEs8Rn1AmYkx3M4L6TQuhh9KAK66?=
 =?iso-8859-1?Q?Vx4DimYF4rhN8LReRRaSsrD+fw/wk8OadKYbRWu/EfmLq0Gsu7aupnuRue?=
 =?iso-8859-1?Q?8MUbSvTygA5er8wu8wI6uR5AmlfBkqrwz3KqtR0ZMGsnX92fsT?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?KU8R1Mn7iY5/oQM1uuJ+/48lcDLhx4Wa3WHEMjzwcEpi8KIHzHTI3KzJCe?=
 =?iso-8859-1?Q?dMmO4Vgg0wbvHF3VTvb6MqoBigRF8ACWC8aQbOBvvhjg083m1KB5+jsFPX?=
 =?iso-8859-1?Q?DuQbmimsclDXTBi3MoUPt9gHkUzSJjwqaeINWwuOQlm1LQyFCSJ485RsSL?=
 =?iso-8859-1?Q?FzcNjFxm1PugKrpEw/ic+HosM0cO0jicQ1J48yae+7QiVXqhpoAiHR6DYI?=
 =?iso-8859-1?Q?RqBxstsnDz7pncE8Oj8mrfXi3nOatPKWnuhFh75fvdsnkT0bo+T2KLnECR?=
 =?iso-8859-1?Q?gSXwW7iGluOO8QpkfDcMpC2WL6Cx0JWyaEuahlNq0cUQ2TXbOyYS2Gcbx4?=
 =?iso-8859-1?Q?FgcU2yIudPDypTBjZ+yTFohpTHe5YaMla4OfOu4IJMG5NVJtD8v6NN6q8L?=
 =?iso-8859-1?Q?oWIcXvR36h/Vd9K/J+VP8J74SMLlMtf1vwjG2onWK/8+soj/nLMKG8pK7I?=
 =?iso-8859-1?Q?Cw74XoL/kM2jwil7Fvu45BOCk/Ud+fd8mFtFMGLDwFp5HyRJM/dNW4wX/b?=
 =?iso-8859-1?Q?HPFpVUiFEjZ9L8O2Wnr0Z+qUHIdK+/Dk8U0HmsDH1ZZvombusrYZOvBswI?=
 =?iso-8859-1?Q?3MJXgrPeuK80yTDg7ONimzjJDkFBjXj0yuSslvyOQIrNU4a+/8qJF8447b?=
 =?iso-8859-1?Q?Oy+uRgkqpZN3MW28wXZW0WqY+7+72I7eBdq/Tl38UtQ8JxG9WWa4lteuos?=
 =?iso-8859-1?Q?+b5JxFw7nLjUr3P1wBi15kuoXUNmq4Zi+ctymUdU6a2uGE6vyI0651UjJN?=
 =?iso-8859-1?Q?N4i1dVlgAezM14bVabtO2pgkTxRgghU6mPtIJmPhyDbFtWwQn6Urv926im?=
 =?iso-8859-1?Q?Tc/S8b96G2rQcKnz68pYvRCtxJvCsldjoy+ukVuLo5Z6jeCH1b9A69KYTQ?=
 =?iso-8859-1?Q?BoED3gX/OeemcavKfJHHavYkXz2RIr4WIO4tjJ612Q8P34vtlAY95am8sM?=
 =?iso-8859-1?Q?4bHTGNMcR7pAioVipic86zhI6Is3ZMa77Rtk1EmxJ6vo+gNhEOPdRAxlXl?=
 =?iso-8859-1?Q?Yz6sEzsU2bXOIXkNuXHFR3wWPzjAzIdMS4wPhTrYiJ7UatSDFaxYugHTnj?=
 =?iso-8859-1?Q?XVe1cx9HE8q1w8/iPDHxSt1N4nt4prx4kPb9qnQqM8rMVaMQxYcZikoUKX?=
 =?iso-8859-1?Q?rrlbmsTp/2B/E3xvntAIYc4lpSPCMNBEn5EYPbw5SuhmcIPmjRQocQ+1MQ?=
 =?iso-8859-1?Q?qrdxD+krW8JJk52HlfSXzWdoo8E/dWXbZUujNRxU7/ljtg5kFANT6pJaAZ?=
 =?iso-8859-1?Q?oD8s19+m0v2qlwKZp43rPj0W5oyQp/ohfQfwABfSFtAzRKSHf61w0jm+PA?=
 =?iso-8859-1?Q?k/Xk84yu/1si7vd+738cDtkYzxwsNYs3ZniliUIOslr+VqNf8C/qzGjvKm?=
 =?iso-8859-1?Q?4CeHeM5Z5mRmaC30Du7hi+UuQuzpe4QPU0+rrvCcGjuh9I9z9sjC3rBU6Y?=
 =?iso-8859-1?Q?RnsTdUNt+3HXpAH9?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ee8219-e34e-4ff0-f7a9-08df4b919347
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2026 07:47:52.2329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA7PR05MB998597

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
This bug was found by a fuzzer.=0A=
=0A=
Fixes: cedcafad8277 ("nullb: add interface to power on disk")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Yingjie Wang <x-professor@outlook.com>=0A=
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
