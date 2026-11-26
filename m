Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795679276;
	b=21i6LrEP2VS6DSVdJKy3cD1LKdXrxywS30aKkAUPirAzO8QeuNi/cl7uMikRC3oDtYSm
	 /tx5i3rtXLITa0cm4keHrhzZdvPYh3Pt4w33CDJRd37obco1LI1JgslG0l7nNgXedWJnE
	 OuCXmIVuIG0mgAnm1DYZH6Jp4fpeiOwae2UYrV9RE7h+EpIKzKDFFQO95UDDHrRZ+KpCO
	 NUhoXmolADmFYRJxmFkTRd4luhZFeHrS5fvNHZWccLHCmZKOWHOF5cnMxlytMB/RyiwRq
	 ThjlJtKNWoJFX4xEX7sQYLg7jw+7/PKgbnV6wiizp5TdYHsahQN0lhMkcg/1L1tA7gg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795679276;
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
	bh=8per3McGROH5xLoeISPL4nxyeEM1NMydKxHqPZhirrw=;
	b=JH4PQNh2c4aXUEqi/J8M3PBw61Jp10hL1ar27XKD11rmiBwIZy2bnTZtpErwMrwSByRd
	 NtfAeS6pT+rn7MS/mnXwMkU320y/7wSJWJITEhxMnFliDOoJTvrKmlWugP9MAK/v9cKb6
	 Wke7eVo24Z/R7rOEuHt1h8ZRuCpQeoSO4ZXS0z9yMv8XSiGUflQZRU82SZFz8+uCynieb
	 C6YjUiBQUEkuKBQEqyFcfKt1RMNt/VHAbxNFAlCBSGlrDDsmaoDI8HpOc2Ge9oYtwt1B9
	 BTTiCwd1TH/9pHjSlCmHAhEgn0C/HGrcI+97s5miPifY6mYgCYA+YsdVtAkBm5BwiGg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=EjgKJ57q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.4
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010004.outbound.protection.outlook.com [52.103.20.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86148606A329;
	Thu, 26 Nov 2026 07:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86148606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=EjgKJ57q
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCufoQHKPHcsqwsSfiFGVXQ2h8dhRhxziL5hQ5ISfFx1MZM+MFx7efRskE9z+VgRgNPAXSbcaEPQ3b8eSfQuyxa45pzN+QvcQ0YFwu45ecUtDqM9li8GlpEQxTfeFdLG+yTaikkXIJfly7+EnTokBxPWqrhVDQi8oKwJ2jwuAOUovLdv3RXF9hvW2x/YGaNmGlv/n6PqYkT8Q5PLJf6Z3H7M96pp1T5sca6pEjS6vwJkdUgax2MU6C44hSCshPkNYIKM+xrEEIvnXP8lxAN8yuerALOXVKf/amDnWyKVTq8KSFioVEqZ1+8Yhe8hEW/d2G4CqkX/am1OL1oM9YAOKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=8per3McGROH5xLoeISPL4nxyeEM1NMydKxHqPZhirrw=;
 b=snbUe4mN2tQ+g88HGpgOV59vfvrfB5vAlLyRjFeWth9xcdxRt31xrq3t6+Fl/ATuf4mR87zXgsVNZM9OEaAwTv380IRrdgOQYB014IJSDUx3bbndwRXcZD7EEh/XS8YY28QpvhuX7YKgDXufrEn2BDEt7w7Njol/++boSI99ZQ9MjcB70cBjaPSkfqoJiLozcgFyj2OP8cWjfpGF42dR7SCIeH2pGYb7KxmouoZbFGjeycSscl+RO8incPnr0wjvrwgkFlYrSl88WGOUxV4MvfY7DnYhYO9mom2QCKUERhBvmEuWjIrTWAOoAAIMgY1hwB50MRgTcqZAm1W4qOjDxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8per3McGROH5xLoeISPL4nxyeEM1NMydKxHqPZhirrw=;
 b=EjgKJ57qt2KWaty0Z1Bbhg5VfHndiqSgXfOJjzD38VPyTUDtMv+/rvVk7JD1bDF1xhE09Th77AI+x5+7TjQ1U+UUNGiTTCwDm0CT+osHREi1ZJfbdp3oeYbGC8wuL4I8GWrPh4owkiNbpd2vK9pv+MvNoDf+e3WcY2pM63uL7YrxIUOCltE8LPrIixVhv0F5zk9p45j8EYMUohrUCqIpXo9uEsc8LBi34jBpVOStYGk5DRmx7sZvon4W54IzyiL8B99vJyjyGj0RVZjD9Xv6iqOiynLXTYNpBypU9QgCoIzy1vxX9ECr2dTSM99aaBQV3I95GMEooPDTl/jlm6buKA==
Received: from BN6PR05MB3281.namprd05.prod.outlook.com (2603:10b6:405:40::35)
 by SA7PR05MB998597.namprd05.prod.outlook.com (2603:10b6:806:4cc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 07:47:53 +0000
Received: from BN6PR05MB3281.namprd05.prod.outlook.com
 ([fe80::5b9b:67c7:5397:c42]) by BN6PR05MB3281.namprd05.prod.outlook.com
 ([fe80::5b9b:67c7:5397:c42%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 07:47:53 +0000
From: Yingjie Wang <x-professor@outlook.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH v2 2/3] null_blk: reject zone counts that overflow unsigned
 int
Thread-Topic: [PATCH v2 2/3] null_blk: reject zone counts that overflow
 unsigned int
Thread-Index: AQHdfXpxAn9k2svBeUevcthimyQUtw==
Date: Thu, 26 Nov 2026 07:47:53 +0000
Message-ID: <20261126074748.1076774-3-x-professor@outlook.com>
References: <20261126074748.1076774-1-x-professor@outlook.com>
In-Reply-To: <20261126074748.1076774-1-x-professor@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR05MB3281:EE_|SA7PR05MB998597:EE_
x-ms-office365-filtering-correlation-id: f0a83568-953f-4b19-3dc0-08df4b91940e
x-microsoft-antispam:
 BCL:0;ARA:14566002|4140399003|24121999003|15080799012|8062599012|8060799015|22091999003|41001999006|25010399006|31061999003|38102599003|19110799012|24021099003|3412199025|440099028|102099032|52005399003|40105399003|26121999007;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?pZnLSLXJfLmyYE1CmDABFjCp2C6aPOxY26EiNbDvIJ7NvrK1Edi8qnghHL?=
 =?iso-8859-1?Q?LqFaY9HVMmBN1IYE6DUb+IlSpe+m2WbtWQqHlGBOsmfEnZZ9CRvy3KO0QA?=
 =?iso-8859-1?Q?M5bWU+DrMgo9OYO9FXZbqFEnbgZwKLxX34b/LJ4C9be7nOFir9iuVDa/6N?=
 =?iso-8859-1?Q?JkedBTgANGjPnNeJ162dWRr9cwGPYEIdNob6X7OyRK5ICL1hCE+40cwWOx?=
 =?iso-8859-1?Q?xzvYeScM91Lk6rSV+baE5RlQrYQetDBfz1lBammFyMH2/YIJ/w7nyFAszA?=
 =?iso-8859-1?Q?ZxFqWE3yTvPvBDjQ9LR4gtpxBFF/oTn0mQUYfwbzfvyxp9FsVRoKFdLkmj?=
 =?iso-8859-1?Q?6kTGRypMo8kOzoAsWW0rlIuNql0OJbs9Gau/AJ0olGYyU4HTU+QUMKbFyo?=
 =?iso-8859-1?Q?IVphCyOBWlN4hTrllm/V60gfXizrKa9huUSj4ESTK6yOfqKjoOJzlnPt5I?=
 =?iso-8859-1?Q?uam//aB3evdqrDvvyGLBZ2j/1iswEHMNemdSysmalGvEu0wv8e3q2w4QKU?=
 =?iso-8859-1?Q?/H7c2KOxq9UGV80HfNr9SShYaJno+pN0JGo7v2GF2NDCQYUVoI3sntp7px?=
 =?iso-8859-1?Q?XRQNlY4Xy7eJJuOe7sPIR27ukmAtA1THCcqRKdToIQIFoOs0Vf4pseac7Z?=
 =?iso-8859-1?Q?gVilXefhLspjUCn1c9BWENHNaEa/YXjBWjj3d7JCPE6Oj/LPK8yDZJxgnB?=
 =?iso-8859-1?Q?WhV8sib8mhZBDeHAstF+va7TeU+7c3BkFQCb+W+PZiVAXx5y8wvRDEJFPj?=
 =?iso-8859-1?Q?0S4bYBbsq4OjdE13hVjnj0y5UbuQxerAIM9pRH1c5zO58p429cYRWbhpdU?=
 =?iso-8859-1?Q?kfTMtArAnSxy648tMwP28r/+ElwoX/8WRWTIGqPnpUnSGKoRujZF1kw7MJ?=
 =?iso-8859-1?Q?uCLXhHsUTY5oSvo5vGvc4yFalktqwINY/uESX80Tvyq3XlGZwPYJFQaI6U?=
 =?iso-8859-1?Q?brSyqmeego4c9A9CMgXrJUSKIuByg7sczrSS0n65ueaW6OViUSdJY20Fan?=
 =?iso-8859-1?Q?eR45SXkHy5z878nd2oRRaJ9IOfiudJ0pg7YTtIWts7WfSzNS4WKyJcsXbS?=
 =?iso-8859-1?Q?1mx6WQiFAFI+0UAAoeaPg234Qd5W1ZgKfcEjcEg8ZKfEzUIcf1IH+Kdz/4?=
 =?iso-8859-1?Q?Od5cEErQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?SCgaqZ9nMTiM2yHPJOL57oJQ5sW1zFtV/m9gqYysnlrh3kwRwvKYiCbZma?=
 =?iso-8859-1?Q?2tppp1CjT24OV2NCacpzj2ZZX9rNWhnUBTKzgHWDhxjy/NXiBdjJenpMRo?=
 =?iso-8859-1?Q?kWI2liP4oor5QqZ7/gfuOwXfjT+0j9re33nQhE23Hn+Gc6ss7ejV5qG9mp?=
 =?iso-8859-1?Q?MX21IpfVyBP77z2KW7lzUa3/XwsUaCmG92Ye3LPmJQvPwyVp0Q2HWRNBDg?=
 =?iso-8859-1?Q?9D7Zhf7UB1AGw71QkJwcOD6Beo38/4CmUGbDh7HeI9uldq47Qvo9SDtPUB?=
 =?iso-8859-1?Q?srvr8o3uM3rFN645Svga4Lc8a3kDZDFpGed9skISRC4Djtzh4sVBUXMkDR?=
 =?iso-8859-1?Q?xy9gL9NNxK1SgT+840GcUJp1Z0qdMr/n+v2woXIytU5eY9FlFnGpE8yLtW?=
 =?iso-8859-1?Q?UUVqzjQlArWZljt4csqlt7leOwMueABrO4hbJ7iQv1XUug0+8P4ZxaYasD?=
 =?iso-8859-1?Q?I2aU0H3nuM+bmdcDuzoyu+zt1BFWv2HpxlThsiQHYnJ0xogAduecx5L5mP?=
 =?iso-8859-1?Q?S5ceaTx9ioWUtkGBeN36DBbhz9cXu8FD5yL/B/SBU3ThqIeSnGHTfpbIE4?=
 =?iso-8859-1?Q?WQWpzyb4OOyJlUIKFs/azkDgU5OBub2yxQ1uNfscC44DbYZf4FjKP0vOC1?=
 =?iso-8859-1?Q?g7G1u/Elaz0BJNgfqCqRsnDQaerTJDT3An4hbkbA8p5kSlbqzTUwHuIp6E?=
 =?iso-8859-1?Q?yGfbuAVtpPBULQoxcnvFRlAJwjjibRWTmKnu4HRHG/BkCrXKWNPRuOnNKA?=
 =?iso-8859-1?Q?dp2tBIxyd+qwsrFO3F3kpzPRgx3UR/yG3gf+LGqB269LqbycqxTFflrFcm?=
 =?iso-8859-1?Q?qzb+d9c8beRKYc2uBqOo2Maqofg7u7TrOeIQ0o3MXlQAGTAk5g2d5MNzz6?=
 =?iso-8859-1?Q?xjD4oqb9jcLuMrRWo0+qrDx8SSdm9ec14cLONEJQy0ZtGqezplakmGLpT5?=
 =?iso-8859-1?Q?zMf7s/SW5aCqsMPuw0DHcWLqQJ6WSbtgE9YrwVC39V0dLPXIhekGK0RzdT?=
 =?iso-8859-1?Q?VWzoQqFVpQS+jMdn7qlBkIMQ9kg1OFWXeiuN4zyX754TGhO1Y3tFJYyAao?=
 =?iso-8859-1?Q?WOZ2WhQP2fPvPYlAeS/17V5Z/0EscTXsE+0yPJ5Kv+K1dYK7fIymHInrH6?=
 =?iso-8859-1?Q?ODpqlOFqD4uq14L8v04fhMF1qRW/gNjTpi0yv8kAWjH8MRPMKebx2LhkJC?=
 =?iso-8859-1?Q?NqrHtiOgTL6fo6+PEz/Sn+mES/M3CB5nwkVhu6J2miTgaqmjZokzX38zK8?=
 =?iso-8859-1?Q?nkLcfIlJ5id3THg+U26K2Ph4s5P3NV1VEF0AB9/qA9LhTPrI7ZluFbMxz/?=
 =?iso-8859-1?Q?Kzw6QtWp+L5FwE0MnSqMpPUrigNdWmTq1pFOhtqvkt4dpK7Wk7NHo5xg83?=
 =?iso-8859-1?Q?H43OfoTQS+z1kjo9Rgpd+dnQzpiougOUMwEG65NXIBuzuswTWFlZs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a83568-953f-4b19-3dc0-08df4b91940e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2026 07:47:53.6142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA7PR05MB998597

null_init_zoned_dev() calculates the zone count from sector_t values but=0A=
stores it in the unsigned int nr_zones field without checking the range.=0A=
For example, a size of 2^40 MiB with the default 256 MiB zone size=0A=
requires 2^32 zones. This count is truncated to zero when stored in=0A=
nr_zones.=0A=
=0A=
The resulting zero-length allocation returns ZERO_SIZE_PTR. Adjusting the=
=0A=
number of conventional zones then underflows zone_nr_conv to UINT_MAX,=0A=
and initializing those zones accesses invalid memory. This happens even=0A=
when the device capacity itself fits in a signed 64-bit byte count.=0A=
=0A=
Keep the calculated zone count in a sector_t temporary and reject values=0A=
above UINT_MAX before assigning nr_zones or allocating the zone array.=0A=
=0A=
This bug was found by a fuzzer.=0A=
=0A=
Fixes: ca4b2a011948 ("null_blk: add zone support")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Yingjie Wang <x-professor@outlook.com>=0A=
---=0A=
 drivers/block/null_blk/zoned.c | 8 +++++++-=0A=
 1 file changed, 7 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.=
c=0A=
index b271d0a88ff2..432a0a2f3893 100644=0A=
--- a/drivers/block/null_blk/zoned.c=0A=
+++ b/drivers/block/null_blk/zoned.c=0A=
@@ -54,6 +54,7 @@ int null_init_zoned_dev(struct nullb_device *dev,=0A=
 			struct queue_limits *lim)=0A=
 {=0A=
 	sector_t dev_capacity_sects, zone_capacity_sects;=0A=
+	sector_t nr_zones;=0A=
 	struct nullb_zone *zone;=0A=
 	sector_t sector =3D 0;=0A=
 	unsigned int i;=0A=
@@ -94,8 +95,13 @@ int null_init_zoned_dev(struct nullb_device *dev,=0A=
 		pr_err("zone_size too large or too small, leads to zero sectors\n");=0A=
 		return -EINVAL;=0A=
 	}=0A=
-	dev->nr_zones =3D round_up(dev_capacity_sects, dev->zone_size_sects)=0A=
+	nr_zones =3D round_up(dev_capacity_sects, dev->zone_size_sects)=0A=
 		>> ilog2(dev->zone_size_sects);=0A=
+	if (nr_zones > UINT_MAX) {=0A=
+		pr_err("Too many zones\n");=0A=
+		return -EINVAL;=0A=
+	}=0A=
+	dev->nr_zones =3D nr_zones;=0A=
 =0A=
 	dev->zones =3D kvmalloc_objs(struct nullb_zone, dev->nr_zones,=0A=
 				   GFP_KERNEL | __GFP_ZERO);=0A=
