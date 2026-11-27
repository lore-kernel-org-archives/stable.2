Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.36
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795784339;
	b=H9NpW7V9hyS2G1vCV6JuXQ9RNsZXNB4Zu2NyNwmD5/WQ08k91UnBBEpTVToRGgkbHRmf
	 JlBtaFei9hHymIbOoCWeS1LE0VPcj+I7cIS4Dt0BP8eKKVSHUWI7P2DpOBOC/vTZmUKYX
	 A4aMprqMu1i2s8s94bfDQdNtlRjiZDmwch1FGMA95GshIdhhyiNQlG+w9IgGTtXWBFtZe
	 ECGc2vgtgZ2iyVM+apGiylzUzuhD0WAmFsPI8l9F7ps6q2D5ledEDqE8AiY0AXmWtsTjj
	 9tEpRLCCkW0Iela8puG+oWBhvrAPzcYg0gYCpc+Hug3MrVMij4kzevtdPhhrm/Fc+iw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795784339;
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
	bh=eRbbr0myHIwnqp2sdyvOJiPlRQTV7iy9Jsc5Ar74tT0=;
	b=MzlZ6RWYQHZc+W5XQ/XanulplB3Og+BfH+5L11vpM0H/uGCeTOS2BGjjITuGwUY7zGRl
	 CA61dLlM8/7/xXCCwg+cLn9LTyxnR5YrzYziWV95vQHz3ih3ajRaCdsBaCa7MGda2FzGt
	 xVdwzx+5ciCG0WPHhzYh6gTdz8pHs34Vvutl3t9lnQP+QRnxC1Tmllg+Fd5uaDckONeBN
	 /bln6GPOd+Q2l2qHn3IrkbchzKcSUJ2WwKvDCuNVrbNVp6ASumfCmdQ7ApoN4DY0Dx8U7
	 v2/ipyylG43UB2Vh7YwapkniT1uxk7ILP8FlqhIAVbUdrKdPD/JlgRNdopmqzpUVlsg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=IRJhTQWd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.36
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012036.outbound.protection.outlook.com [52.103.23.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55676606A321;
	Fri, 27 Nov 2026 12:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55676606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=IRJhTQWd
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njyYNRFHmNMuB5FtX/69STyuczTbu5IdfrB50uj6d501JfZSBK/nFXnXEdytiyt1OC8KZFx2PoYTTQRNDDl3jqdJkbV3l33G7qBc6rHjpP0a5HKl2LXdRultbX3kQ8Rf0YGO4iEi8sOlDbi45IavZcnMEO2iszcbRnMlOQpqjats6+k39QT1+S5HUNT0FkhyXsuHPcw9kOBRKwy42UnDyFkBBbFv9vesj6fzjPaUddCcBIaJWVtY9Gw8ywhiHB4kRqJWXKfDr3GoexyEZaD+BEXRKirT3NgFD1idtGhOPyz3+MNwa25xWM0fB7NCbj5j6Kbh2aJZbkdJOiTD3aqRgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=eRbbr0myHIwnqp2sdyvOJiPlRQTV7iy9Jsc5Ar74tT0=;
 b=ZB6UCC15596Z80/5nY0Q5yGQlDxqjFMJhQKKdOBUhuIvzBzhPWt21VUB89Oxlk2vLNakua5DJo7lA5GDh57/21Qg6+o8qCGnqBZOfpikYaYzLg2rCK4Rm52AxvLA4nEtmRoAZCRnEPzEhCtF5YlBVBVYny0pm6yEZDgBeEVZcbBjaloPT+oqMJGMa71gOtYGOljF0BzE132erZskqLwfrDE08Gtqa45exCndqqIy3qbegStLdw7biemN4TySbjOEcBcjAU9aMd17HKDoQyb1stdFTGzJvWWGt2mXrAd/8UbOimt86ohu8LVw+txtWZXTDGU0U5fOfPqLpZQ+UuUVvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRbbr0myHIwnqp2sdyvOJiPlRQTV7iy9Jsc5Ar74tT0=;
 b=IRJhTQWdx7VxctRPBjgPl/iVlQuSe9U7hOG3iVs3dnFCUYdmIPtNmRE9dOFCF6O8w/mqri8hbEgKR7QlpEVI7GexmeX0blEAvFCnvcB1oZziVPNvppB12ofC2+YAoAwmmv3ka5YF/70CTlJfC35kkl6z36FEmUN/1rvYAKuWQcISDdSc1hg59WfgEYtQk9tzmbIy2y5GPDto3soBk/d+sZB6cf92oZ08PuZcCM6PT+wq9RDF1qdJDJ/NRQfstIF8EMTOQlDmvdruhh2FmZxBrx7f9l219b5Hee4lE3vaqOFC2AMbU0fNKeCEHSilhLEQCcPB5HqB0R9GKaYVsqq2KQ==
Received: from BN6PR05MB3281.namprd05.prod.outlook.com (2603:10b6:405:40::35)
 by SA0PR05MB7307.namprd05.prod.outlook.com (2603:10b6:806:bd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Fri, 27 Nov
 2026 12:58:57 +0000
Received: from BN6PR05MB3281.namprd05.prod.outlook.com
 ([fe80::5b9b:67c7:5397:c42]) by BN6PR05MB3281.namprd05.prod.outlook.com
 ([fe80::5b9b:67c7:5397:c42%5]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 12:58:57 +0000
From: Yingjie Wang <x-professor@outlook.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Damien Le
 Moal <dlemoal@kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v3 3/4] null_blk: reject zone counts that overflow unsigned
 int
Thread-Topic: [PATCH v3 3/4] null_blk: reject zone counts that overflow
 unsigned int
Thread-Index: AQHdfm8QSb+gdnzmGUKypYpFp3mB7w==
Date: Fri, 27 Nov 2026 12:58:57 +0000
Message-ID: <20261127125738.1654012-4-x-professor@outlook.com>
References: <20261127125738.1654012-1-x-professor@outlook.com>
In-Reply-To: <20261127125738.1654012-1-x-professor@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR05MB3281:EE_|SA0PR05MB7307:EE_
x-ms-office365-filtering-correlation-id: 27fcbf88-097b-4612-01ee-08df4c8632c8
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|8062599012|19110799012|31061999003|8060799015|25010399006|4140399003|38102599003|15080799012|24121999003|22091999003|41001999006|40105399003|52005399003|26121999007|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?m2/CxyfMnQEmDPyOznjdCTmlt8F9nKYAT9TiqeMc+ho6uB8WroKntESbOe?=
 =?iso-8859-1?Q?ohbT3l3Z/wLxz7A/vQDewwZCZ+tz5awhdZ/RE4U5LE+Qbd0gj6jQmFLgGF?=
 =?iso-8859-1?Q?DGOxNEoCwRNqsus+wG4bIDneCF2Fi+WNrrbp518suhlSewi/5ZdEtXerX1?=
 =?iso-8859-1?Q?lWm2gXwXJL8lboI9+NKzkxofAO8uX6fSIdn3VaPJT2JfYE5Gp9rTPtxlw9?=
 =?iso-8859-1?Q?6Kpd5FS/jA1aVhyYVY8HbwmKb0eh3ycRKO3rWPui7OTk1WsKBClmuS3X52?=
 =?iso-8859-1?Q?Z7QCv5C/s0JdM6v6zzZEtMePcHdfXCDbjVAqf2yh4VrIEO2nmfL9EH59VI?=
 =?iso-8859-1?Q?lnTk7yWlSaU49ghfMsRPzgm91hPzJsLVkGCI/Kmky+hMlW9ZUB6MzzTGDr?=
 =?iso-8859-1?Q?aPJSz/PoLV49oa1D8xBqUA2RL7T1fS/unXgyB40O3/O6/RvKDi6MaFd0Ac?=
 =?iso-8859-1?Q?TDeU6EG8mwf9sVNTsmPFCcu7wpKV2eNSJMMTUMPO1JZLZJTNnSO/YbTP+r?=
 =?iso-8859-1?Q?VWLQnCG3K++k0jabij5+xwfBvUmuNiODbvnxanrk50smdtEj9z3PpQ5bTe?=
 =?iso-8859-1?Q?E4vYI+8I9ADtjv9ltD4aEy3d7utBQmPUnb5SC+YYRwQBFYS3hbNj4r+uAY?=
 =?iso-8859-1?Q?tgH+bM3jpm3q0+Vz3wie1H/dPQzbolytjyW8RFwsybPHzQhQMxc/T+TcFa?=
 =?iso-8859-1?Q?Fc1IM6kPbZs/j59sYj6RUoMlx6uFiB5CYPJbPWJDHbHGfuMJf4bEiqvJ4o?=
 =?iso-8859-1?Q?4h49whJ6S2BEmhraCCQydm/5lmcwf7kAKtwW76ptu+XvPwaAwEEiMcXiED?=
 =?iso-8859-1?Q?W4Fdp6WQf59+HCpJ+u0alu/K2Og7TWpYjbTnPx91lBXjRkt9RTlsSNVF7S?=
 =?iso-8859-1?Q?52SwBaKj5VqxlXs5otOIsaYkTgYzqI/rEFjpoQJATw0s+E/CTVvG8Exus8?=
 =?iso-8859-1?Q?ief2+IfoYz1LL4e4sDmrXUbvbCHIX6S8DqLhbxkBz4aitFmVdj/qz8hk4M?=
 =?iso-8859-1?Q?tFU6wBk7Y1JVbL6p/zS10fVmw6uceB273sq2gQhv3bikhDiGxOZqe15AhV?=
 =?iso-8859-1?Q?b/IrNcFNzaDNLkY1rbXQay6aN589OXV9bnAyLC6/KVHxkmgA78KRsT1CbC?=
 =?iso-8859-1?Q?WHo5edVg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?56Qc7KZzcicenJgGB84geU8NPE+z+Abo4dZNMnaq7eMYWRdbQI3Z8kzLEB?=
 =?iso-8859-1?Q?E0ohpm3lRctfjJr156XqnAuxQSwFvFaxKRiqPKvtyRgzvPQQBPICHprR4a?=
 =?iso-8859-1?Q?Iq7AroCzLMEK0ZS4uvcdg/K5uccQbCQpONqqYGkjEfDQ1+pTewDgqicjJc?=
 =?iso-8859-1?Q?1kz2luWa0tkcKV594Gwsl7yDNRJF15YY0R1bjogBJ9FahHzuXUbipsxDkr?=
 =?iso-8859-1?Q?O4CJ1lIvAFHWh2eXYZz8v++cOIDH/xkaJSPn4bNT67RfOOfp+I0+yhHOmU?=
 =?iso-8859-1?Q?8zARF0ELE+Ju3p75+XRx47DdF69JgJI0EsSaedLCivpYm04r8iGZyivjxB?=
 =?iso-8859-1?Q?sSF/PKUa5NbMhzbtImJ+65iLWQrdLbs9BjNWfVz/dQR0wi0O/lgYYbF0pc?=
 =?iso-8859-1?Q?WnJMAjMpzVu8Fh3DT+NCwFeNmvdJoyYtNgYA/Nd4GE2Iw9Njj2aflF8Fnl?=
 =?iso-8859-1?Q?G4JXCpDAnzYQguXOa4soTEVCxh3jtaeG3M3mOfGGzfC6N7tuD6bxdpaYTT?=
 =?iso-8859-1?Q?HHGD+dVJpXvi5waaEY/RN8B8xE3mu4nP3BaLzoCMQnZu2v8BdY5mHCa+rr?=
 =?iso-8859-1?Q?oFb8qqS1C0iSNeBbosZxPfDGegsTk750EVyBDUv4FDZHs17QTA8IKYUZTG?=
 =?iso-8859-1?Q?Iw9VuLzmaFgLnnmPunLTDMYEH3w1Jt/6E0pUuddibzQ8D6q8GsCyGRwTp4?=
 =?iso-8859-1?Q?GhZX/4d4VAv7zZUNFvJ5oDgngnXpqh/PAZPY1gOVTTkPzfrCHAUgUo73ES?=
 =?iso-8859-1?Q?15T5pBKBegEEm6vSiLWCw5pkWGYnDQJ53kT3nN61DqQ0pluHeyslLiA3Nq?=
 =?iso-8859-1?Q?gEgrq1BdOjWSdf3IlnAVmIVU1u6ME/5EOUR4D3ruw06Uy8ynf1VE3Dt3+b?=
 =?iso-8859-1?Q?/8XfquIr/gAVfiiIhtu/7IPEZDgdFvaaPVa+IW+ZD4x1Sts2GOO1cS5A7T?=
 =?iso-8859-1?Q?s9Jeo8d9T5kPpkVL0UqTzGuRcMECFBgq4ClgVV3Jw+Ep6+W8pr0RBVZEIn?=
 =?iso-8859-1?Q?871b6UoThq5bV/PDEE3smUyTUO/bp7BjFXImpVTUa6S6e4NdI9HWi+GgS7?=
 =?iso-8859-1?Q?tpPJi08Vf41T7+I56U37zOMYm93QNPHjZTSSddVE4KCgbMIgJk2NBbs5OF?=
 =?iso-8859-1?Q?gNc+qJ0EdVnHyKeVW+3c5WQfhJIg1CQwkT5q0AmahnCjxiN4Tft02rU5X1?=
 =?iso-8859-1?Q?xQrnBMlAT6NC1otb8H0xzLXgntaCPcTolnD8NS4a7haSeAJdqqC4Q2Zfrv?=
 =?iso-8859-1?Q?6lEMqbBS+1O4bsfQBbcUf6ksvFLs2rE9y5ZyzrW5zQ5zcs1CRDDJmFMP1d?=
 =?iso-8859-1?Q?RX817hH/szhEAVwC1n2VlVfWfcocGMXyBNnVz8DWO2gZix3OlvEZHrLwkw?=
 =?iso-8859-1?Q?rojExra5gmktbd4SRZv/CSzdGt4LHjrR/Ci6QReTU/INRY6atXHZQNcKOh?=
 =?iso-8859-1?Q?TtN3bwPYHF2CteAI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 27fcbf88-097b-4612-01ee-08df4c8632c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2026 12:58:57.0860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR05MB7307

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
Keep the calculated zone count in an unsigned long long temporary and=0A=
reject values above UINT_MAX before assigning nr_zones or allocating the=0A=
zone array.=0A=
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
index b271d0a88ff2..28689f15a01a 100644=0A=
--- a/drivers/block/null_blk/zoned.c=0A=
+++ b/drivers/block/null_blk/zoned.c=0A=
@@ -54,6 +54,7 @@ int null_init_zoned_dev(struct nullb_device *dev,=0A=
 			struct queue_limits *lim)=0A=
 {=0A=
 	sector_t dev_capacity_sects, zone_capacity_sects;=0A=
+	unsigned long long nr_zones;=0A=
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
-- =0A=
2.43.0=0A=
=0A=
