Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795784302;
	b=l3ZPK63bevHyU9HjU5DyZPo/j45FzrFf5HH3bef+tEQ+qNwcka/k1IdREjnNc8B3YHPG
	 l5FkQfNj4grQzc0x4EnLow25W9aRaBhEZ/4blida0wQujcPMv1JlGR7LsuS4BgML//SOF
	 +AGSNElk2Byk4o2srQzTo6ERkhEy4NwOfx3BjEnKG3IS9EjshU213mKo1ssrIy8q2BMch
	 PL/fLFEXZ1vHap5W6cgiwcj5lYvnD2v0q+xSnO71rPI+GaqaNVggHfMlZczCGX+Ojffs7
	 r+XG8hgU9wVZSJC3R5F+dCCdoO1v6n8GNetrGy2HXL+pznGOnKRz98xQ3YPdzi6hUJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795784302;
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
	bh=cTa38WIGxDs0vRBdOgjziW2/z6TL37BdYh8xS/NSYBk=;
	b=j0yclAH5wI+lurXOOsn0teQx6CXyMeHWzyKHp/IKEPGWnw7NLOmXNRrhkDlPhVwZqchY
	 1zF8woOs8cPUYJbqKXEdkECP9CesygV7wIVDI0rlHUJ2aWjHnP1/V6mGaeou9Kts8rA80
	 RpZKWPgdfkxbLCQjnvWhNFggCf23wlR6V+hwrCvjjo4LfQR36XZAhorwiUbf99rptc++4
	 LhwsG4jcsa09yks9h0x2tv/Rd/FB7koSTowEai48GxeCMtHAvN4bJvg8VHC0CRrLEy442
	 Y4iJWf4F1FGZkW1ObSjU2WUwVTHAa6n23sAKW0nydOjk3PezMNWFMsBmEVba43kW10A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b="Gg/hFOIH";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.17
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010017.outbound.protection.outlook.com [52.103.20.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75F3606A32D;
	Fri, 27 Nov 2026 12:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C75F3606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Gg/hFOIH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DbJB/RLrqEbxmmfl1qjLLamGfZbtJCTHWZuAbezzCwCH5s+AIb/k42PEfKwmIJp9rz9Fc4HpRLjfU6EQKhyKrvoEfTtu6GhDN6SusEaZX2DwMHBWXNQ/dr8DIqwZPm7UHS4ilN3oVll+vyJoPyiMwa9qFogCvDx8FE9gevQmthbOQkSOSYFf2Hn4y8hFsU8ot2puASTdN/XyqiP0OayMkkPeA1X8r47qPy0jSAYg+Jy55Xz1BZTx+1rZnj6iNzZIcV1EO3+bbTNXSdKNOngM1KVyNMvVinXokr0aSRYpC29c3jTfQ0MQWbkqyx/LUe5LSZ4qtu8qxNIvxA0HV5Op7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=cTa38WIGxDs0vRBdOgjziW2/z6TL37BdYh8xS/NSYBk=;
 b=dXlksYwm3V7yiAGkbic1WWe5Tc7UYQoCVqnVFR54hb6ncyq9jO8ozcD0ieICtfnbwaD0g1Q68dXFxIq1z1hq4OkJ65bKzRd1uJWFMrT0JENb2z+QJF/EmKwUj3o/q+m01RcdOv6InEscCNkS50LLrbPUKNOgSH8H1PFYxtk2tqS5j2LRwC7KH/bdbjAIb59+oUg42EugScyA7j00SzwAAlwPk6lIQlsB7KTUfpi87muZZcE5u/JV74ftDsrMWJ9rTi5WhSgvgVtf0drgP2I77lmK3JgszNsjj8SKgIcwbTeeekFAZ0ETCpWbErUE7fSEXDnuHli/McvktNve9cMlpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTa38WIGxDs0vRBdOgjziW2/z6TL37BdYh8xS/NSYBk=;
 b=Gg/hFOIHgIO30XbVcVT82tRyG6PaqgmOs0+jLXofd5vKNT3Q6oKU4nbd4Hv1m/TCERDxjGEXgXkjgbLVi52oGNLpVQJt4+uI8WaQfURLRN4gulSfxH7J4d/MRFwJkx6FpmC3S+yEDp1Eth9K+65kPmWmjFMgGXKKQ4XmAIgPhbKq0e/uI+whaOFgRvLag0UjCW6vYaxwaWuvjddsP0nWMsCXycqeLM8QbQrKZ0PN78hyd7dtAlJdn+VQPTzDVHZPOvDFSREIeQNGhkAS+/IY8TjFeYgmrcTWCSsAq3/c275OKf/sPrDlr3BCsNDcb+Ry1d/6QbK9EJCaRHa9VgU/Gg==
Received: from BN6PR05MB3281.namprd05.prod.outlook.com (2603:10b6:405:40::35)
 by SA0PR05MB7307.namprd05.prod.outlook.com (2603:10b6:806:bd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Fri, 27 Nov
 2026 12:58:19 +0000
Received: from BN6PR05MB3281.namprd05.prod.outlook.com
 ([fe80::5b9b:67c7:5397:c42]) by BN6PR05MB3281.namprd05.prod.outlook.com
 ([fe80::5b9b:67c7:5397:c42%5]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 12:58:19 +0000
From: Yingjie Wang <x-professor@outlook.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Damien Le
 Moal <dlemoal@kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v3 2/4] null_blk: reject device size overflow
Thread-Topic: [PATCH v3 2/4] null_blk: reject device size overflow
Thread-Index: AQHdfm75PqhdtaRCHU23G1Xtc80Ieg==
Date: Fri, 27 Nov 2026 12:58:19 +0000
Message-ID: <20261127125738.1654012-3-x-professor@outlook.com>
References: <20261127125738.1654012-1-x-professor@outlook.com>
In-Reply-To: <20261127125738.1654012-1-x-professor@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR05MB3281:EE_|SA0PR05MB7307:EE_
x-ms-office365-filtering-correlation-id: d22714da-3150-4dd6-078b-08df4c861c74
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|8062599012|19110799012|31061999003|8060799015|25010399006|4140399003|38102599003|12121999013|15080799012|24121999003|22091999003|41001999006|40105399003|52005399003|26121999007|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?zrR4q32Ott/EaTdZtdH3QpQ3JGWM3EC7aRFGzWsZ05Da2Pu57/QO/Yr5Xq?=
 =?iso-8859-1?Q?I/nnTDEFopeETbqXmjNRlQyHSWy7Sh3jbJZ9WPtiGOJ5mlQ9gAAGuJUazT?=
 =?iso-8859-1?Q?9vRtC5sjszd7haKrf9llyjkKpAD4hd6fWHlFmZ6BwUIoJ3f0YwZxBIHqRt?=
 =?iso-8859-1?Q?mhY5dq9WPuf4UgmJLPEdpm5RttAZldCSYsRGr02N9d+ywqwTSNaQ1tugl1?=
 =?iso-8859-1?Q?Xo8FGOWDTNV9aQDt70NxpcZY+2XRAJRAiqdSf1Yp0hmzLIA33NyKT8QZlt?=
 =?iso-8859-1?Q?FBcaRRx8Y9IchQtjzGcJ57kGt4eESqNeI1q4v+veczCQC8Wnt+WUwXKmK0?=
 =?iso-8859-1?Q?tCZGix5qS+kS/CRS1aJc3dzKPcLSEuaHpkC5BbM87zn9LUqY2qRlLCASOw?=
 =?iso-8859-1?Q?4vbHnBK0V8nZ6nTDlUf9vYHLWyPStxjYh2vm+nHds7+35hj1j+9z8EjUzn?=
 =?iso-8859-1?Q?RmikHxlrpZSIEjaV4MwJvHCAi65MEhrB3rLHqLbU7AMbfyxGkusJHLbbMw?=
 =?iso-8859-1?Q?vu5UqbwZ6evqDzPx1x6MA8/7DAk68UQu47RxnFX/VF3/ags6Ig0es7zrl+?=
 =?iso-8859-1?Q?8cUWYqtWh4bPFBqMRyFQqjLhS7Lw1ukas59+VNC0z6tBLWVBe6v7DN8Hu8?=
 =?iso-8859-1?Q?uVLPlDpnGbc2FkmXqxmFFPMB9ursBjgmKPq0UkAoVObb75NrryRk92g6jD?=
 =?iso-8859-1?Q?bzfgb9lZfsn2zmUbUByc5C40Kezk+Kqpxyaap7iRyV7RfunpfqOeGDtPzy?=
 =?iso-8859-1?Q?KJRn++W71LO3mCoXeit6ZE8MOe9/JEZSxZe4WzXYOSnBc8b2GDUZ6O8At0?=
 =?iso-8859-1?Q?YyZB7lsUUfbFo8SbmlHlm7l6L88pXxa3yETdUuGRtI8A5JSyitrjK19RqY?=
 =?iso-8859-1?Q?w++5pHncuasPrH1c5CnaeXRsvEqGLz83E4vFzsi+avT1XSsdft1yP6jb6E?=
 =?iso-8859-1?Q?MrjxQPGuY1U6HMnkdI7ujOlprAal67AmXcwLgvSoMENSS86oG/1vFsmhyC?=
 =?iso-8859-1?Q?8ie4w27m9ti2ObfbEKlcai6S9AzuWuDkIRxvUgYqOO0QUy2oGxpdyxPkOe?=
 =?iso-8859-1?Q?rsSo7GPD0R+N0ICaCoQ/eIEkM4e3WbkpCaWXtR+FpEphJJY8WSoQhn5SCU?=
 =?iso-8859-1?Q?YHspbqBhvUGp8Ss9jGX2JorB16RJOhf7zs4BqLPiQapoMEsqwc?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Z9ggB6tkutLwYhIWj4je1a5AawJ7EC3uMGv3dUums4X594ZdCCXp4353wA?=
 =?iso-8859-1?Q?d18xrI7W08/whCo7JEt9LhpkAPkg/MuH+zgaorFXPHlGbSHVrVGLQ4geW1?=
 =?iso-8859-1?Q?G8FPgMqraHYKn8z0r1HMixKN6gmDyTiKs1rmIFeqkW+nePpSLJpR4YPeDv?=
 =?iso-8859-1?Q?Txj90QYixJBrF5xGW+pdD9V8iC36d8KvwJjRyXpVCdRJFgv8PGopefbqLB?=
 =?iso-8859-1?Q?c7DTORsDXiFrBONtbkHesXcLUlQ7pHL0OBVrvxSle5s+brIUm6oL1TgZPB?=
 =?iso-8859-1?Q?UyDGduNN00ocsQ/tp+btEciYq48ibPW46imE7npyD78cT/s+AfPQ/6o2xc?=
 =?iso-8859-1?Q?LRm448PigdMyRqib39VDC++rJoKyzrdajH67Rp4WycHCFf0apbRVMccuwm?=
 =?iso-8859-1?Q?CCSupcwPRMPCMf/bqxrLTgXBAYi+VZ4MAx0x20SXGc9ymz3B2eF/+BV3ll?=
 =?iso-8859-1?Q?eZioBiIeldbHYMv4OHDIBXWTHFVJ9uBczW0DYL9BMm4K+7w8dhdAp/rddl?=
 =?iso-8859-1?Q?v2Oif21Ht9V01zrSPmugaSq/ANvl9hsD1KG0G/auwBrko/0W8CeE+h0gK0?=
 =?iso-8859-1?Q?UaVSMyjJHzCWX2/sYkK6WirWqbKSU82869r9xlXU3ly9OWVnYBYJHld2/z?=
 =?iso-8859-1?Q?6DTvT6U0GkHWrAeY/JXDbhFBhpDfTWeSHNLHl4VS8NfSstgJM4TmhACSgM?=
 =?iso-8859-1?Q?+X5Q/5NkVGS+laixh7KTm1uwvZNgQam0Gv5LnbkeC3/qOfMUkmrAj3Lf3/?=
 =?iso-8859-1?Q?wje+sRBBZWcE16RnlvjFOm5Mi/7jzlCG17x4uImdEPAeZpaf2NTXrS6JBC?=
 =?iso-8859-1?Q?zyeDomIVVVzrZbdWzq2Tox8KbF7u739E/e2GvO+NP3N4QNfrt2e1d8iBpT?=
 =?iso-8859-1?Q?UwmA3CGnJTJUo8SMfIEe/iWinVuGK+aYms/pPg3E2aRaYFC+BDvfLA1Jaa?=
 =?iso-8859-1?Q?RyS5vvHZcLrdIxA0ZeB/gVbHtxyb0joUdhLb1bJ0HHq+UNsZcIYhutKo/Z?=
 =?iso-8859-1?Q?CqI6XOO/+Cuh5AtYQ/c5ZnITuDOlJNXIthUr7qX8ICQLvcBCF6FfiDYQ9R?=
 =?iso-8859-1?Q?QOy0owaZv15uBrgCz4qulsnU8W6qfUySjZY7tJX9ilyK9zw+ANiwVZRPqq?=
 =?iso-8859-1?Q?+9vB0AFqEeLlK9jVebRyovOnX3Tu3fUKv5vFXW6XqNVoHBTrHnCHvTvh15?=
 =?iso-8859-1?Q?/tLn9qJtx4o0dwC+hN7G/y6wi9ZK17yO30jDOGb46EzmB6ISPARss7D4V/?=
 =?iso-8859-1?Q?/ZJRhfdGb0J9/60fl+zJSNxeF2LMbybajT0XQiZdnOSng7AL4+Be/Z+j0h?=
 =?iso-8859-1?Q?tmnztxgCW6PciW5Z6fKq3x0+Qh1/Qf6+6RHDOENAehu5g7POSmD4xHVrYK?=
 =?iso-8859-1?Q?0/vSfJZDwNnx2PRfIwO75eF/0EYcpgNgajDWhK9Pgc8qpmejQ0dlFrfch7?=
 =?iso-8859-1?Q?aIcLvsT/GYt4wDwf?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d22714da-3150-4dd6-078b-08df4c861c74
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2026 12:58:19.6256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR05MB7307

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
In null_validate_conf(), convert the size to sectors with=0A=
check_mul_overflow() and reject it if the conversion overflows or the=0A=
result exceeds BLK_DEV_MAX_SECTORS. This happens before any device=0A=
resources are allocated or zones are initialized. Only checking for the=0A=
wrap would not be enough: set_capacity() truncates capacities above=0A=
BLK_DEV_MAX_SECTORS, so null_blk would register a disk smaller than the=0A=
configured size. This check runs for both configfs power-on and module=0A=
initialization.=0A=
=0A=
This bug was found by a fuzzer.=0A=
=0A=
Fixes: cedcafad8277 ("nullb: add interface to power on disk")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Yingjie Wang <x-professor@outlook.com>=0A=
---=0A=
 drivers/block/null_blk/main.c | 9 +++++++++=0A=
 1 file changed, 9 insertions(+)=0A=
=0A=
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c=
=0A=
index ec0d7ba4d938..eb7617fd0964 100644=0A=
--- a/drivers/block/null_blk/main.c=0A=
+++ b/drivers/block/null_blk/main.c=0A=
@@ -1893,6 +1893,15 @@ static int null_setup_tagset(struct nullb *nullb)=0A=
 =0A=
 static int null_validate_conf(struct nullb_device *dev)=0A=
 {=0A=
+	sector_t nr_sectors;=0A=
+=0A=
+	if (check_mul_overflow((sector_t)dev->size,=0A=
+			       (sector_t)(SZ_1M >> SECTOR_SHIFT), &nr_sectors) ||=0A=
+	    nr_sectors > BLK_DEV_MAX_SECTORS) {=0A=
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
