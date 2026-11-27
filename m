Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.89
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795784358;
	b=iYdRlLI+rLMaVUYMEkOH8/HY0xKRKW1IwgLpah4M1IgmgoEbcL5xCyydoXQ3hUw+KCiQ
	 02lAGZUHt93Iuj3s9yLknWAxLb+vf5MBLPVyFSSv49kBQ0F7YGajiRPfzTeFcCnhjgTLH
	 /DFD0+p2NG73PwTX0XxbkNhA0qqHVBfnO3pH+B2i7fot2vPGFvqFAFh6Vz/3FvMIad5qB
	 tZ+WfIc1hRyAcEytyDCo3B/A0kZjhoS5cTuB95MrkH0pYgjcI/r4B7W9Q8zuvW8qf4NGh
	 Wgl/11GM3xFl7MmGI75QRm9WHMCBk6JQ+IbI4S3TVYiS+3kq4iWaXmfEe11aD8TL3vg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795784358;
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
	bh=kjlXDpQzQ0KnarlKsz5ZjrIrWOd71+FH3rHLesR7trc=;
	b=GCxySYiXtZcQiJmY82maCYodUPNkw0mi8Rm6cVWaERycuA5bzqqx3uXH3w4nIeF3j2tK
	 UixUDmeWe7BHrxgiAIUfl0ouLnC7tZAShm5tNH/86A0+hfURA7++bt3GpH1cE/smABl3I
	 zWo0iZhWC7jZ+Gc+G41tLDIj+suKny8Wnqrly7WzMW7BasSkBq6ZLubjJ6J3JkjuDuB1U
	 Rclc/jXN5FVUF4keIr25JaIxPYNpi0QxGOElcv61miL4Q76uVQizOBxd/RvlDrqIxcR+9
	 v8alp5SLOKloRNXCWMxHwCfLzADvq+fPIu0OgqzbJYDPCWmzzeYLUltVlSm//+szisQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b="hJMO/tRR";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.89
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010089.outbound.protection.outlook.com [52.103.10.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B66606A31F;
	Fri, 27 Nov 2026 12:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31B66606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=hJMO/tRR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QufzZOcHxTQVhCzrFxN3u0etMbAogubU6vtVspsE6FRnsrmak8wqzZl1wNQwWF3z6MjSDcO54A2M8psRd35Z497yMyXdymlfdtgzEYB8JjoNOsTjujoHeBnugEb8hp8UMbNuAYx1ptQ+U1R/9sxuwpWt7rC9B18Q5UGfntBflVWrW7KfjoxrjjlC0WifXxZhEJb+NZNNTaF33HQlFjDIJWDRR6WlcAxYPjJ/UOkxZoB6rToBAcM+7mhcjlYgNdIVi7qTw6u0RU4174zPRil2x4uGUhMz6U1nhEuJr2k+n+/NwNHD6rIkryhpUlhjwVrvqRlQbtUF8pW/BVeeYp1csQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=kjlXDpQzQ0KnarlKsz5ZjrIrWOd71+FH3rHLesR7trc=;
 b=pok1RgviZKqyFkCCcGOuqJxMII0Q6qh/pZJM++Ila9mY4OA/ZYkpgUgZ2UYMRLSmCGoxz6/nfRfzC2ppxNSv9X/miOZRJIxRgoCpbLUxshQet+tXIGEwci/1o1wEfNaIIBwNqVdrC1osC/v9pOZwzhW4oVtGCdENYU78fncadQSoFoy7k1iHumtpBo/fOfEvYwerprt3t2Zt/V0bWG/Hbq+wpzus0XTIgxdu/dE8bGPLhvnDhvsUpiNeJeRm9K9sXEU9DK1LS7EG0h/j9tXWUM0X78Nzad8jqIArJuG5LWxUJ3xptEEhQf9o3qqAXvM28j/H19gRtQu+yVQVUpND7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjlXDpQzQ0KnarlKsz5ZjrIrWOd71+FH3rHLesR7trc=;
 b=hJMO/tRRPCzc2+Pg3y2r/Odp3cShGPXI9fpxlPLLjxdg96KGlSroN2kuhjf6NWcqdb9oM3FqVLw0bVjG8p/Q8S+pv/eYhKaGPzWbxHEqANYLs/w57xVwua1DHWrWPIyVPMFr5wXejdhZtP1NutqmgaBcnFek5yGGF71q/M6J6yj3Xv4OVcAcKnXKaGz3tIPY7y7KsMOuIo6i6PJg3ug7u99vezjwa1JIhcPFJvM9f7V05y4HvFQaDVULzdWGqgJ3pjsOiO5Tb0nHHbco1N4ymFAFOHZUo6nIvS+CEl+xf++x3J47T2oJjXHhm2U0tE8AAFJVk7ENIa7plX2mnKZSYQ==
Received: from BN6PR05MB3281.namprd05.prod.outlook.com (2603:10b6:405:40::35)
 by SA0PR05MB7307.namprd05.prod.outlook.com (2603:10b6:806:bd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Fri, 27 Nov
 2026 12:59:15 +0000
Received: from BN6PR05MB3281.namprd05.prod.outlook.com
 ([fe80::5b9b:67c7:5397:c42]) by BN6PR05MB3281.namprd05.prod.outlook.com
 ([fe80::5b9b:67c7:5397:c42%5]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 12:59:15 +0000
From: Yingjie Wang <x-professor@outlook.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Damien Le
 Moal <dlemoal@kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v3 4/4] null_blk: validate the configfs home_node attribute
Thread-Topic: [PATCH v3 4/4] null_blk: validate the configfs home_node
 attribute
Thread-Index: AQHdfm8bKz9QfAhJdUKSk60emfnoog==
Date: Fri, 27 Nov 2026 12:59:15 +0000
Message-ID: <20261127125738.1654012-5-x-professor@outlook.com>
References: <20261127125738.1654012-1-x-professor@outlook.com>
In-Reply-To: <20261127125738.1654012-1-x-professor@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR05MB3281:EE_|SA0PR05MB7307:EE_
x-ms-office365-filtering-correlation-id: 12761497-fd42-4d26-2676-08df4c863dc7
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|8062599012|19110799012|31061999003|8060799015|25010399006|4140399003|38102599003|15080799012|24121999003|22091999003|41001999006|40105399003|52005399003|26121999007|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?44AyQTdmVI0nf0ad5ez84/xMZ0s1c8vv8oOuqo6+17ClwWln033h3CznJZ?=
 =?iso-8859-1?Q?V6M2OGp3uTMLVsKDh8vbYWhWGThqQdefQ4Uz3OZdF+2cTlN/OfB827Et+3?=
 =?iso-8859-1?Q?puM7afdemE6w3l6G0DkMXTYR0A9NUkmIWth9MGMbEbPkLLSsR6cB1sBEx1?=
 =?iso-8859-1?Q?klMl9/sTkVSjJ0kE5DgXSopJjF3sUcxYFtoKz1yWN8/wl1l7vkJb/Pxdzg?=
 =?iso-8859-1?Q?Nun2MO7C8OtvoUlKEgrlYhNb57rU3JnxZJYsjuIKUEeAxfM+zHsfAK4sZ+?=
 =?iso-8859-1?Q?IfSGkWVsu38xq43bQ1PhcSDbCkxS6Sb/KnYHpDXofLIsB25N5oLK9wvB4X?=
 =?iso-8859-1?Q?DhQk1EUfCmCsZAAx5eC5tgG6b6nJeU0CGMcL6Ihk0e8FLE9cRfKkFOPi2g?=
 =?iso-8859-1?Q?/u+nOJLKxpVXy/g8PdCV1Y0kb2j3H72jS4hFoxIFFv+HiG6EYslOcdtxhK?=
 =?iso-8859-1?Q?ieFJ1z0LCqk9lo9p1RyTgvoCI5ZmQ26yleCUdCtD0ZYT7ch79Hk5TirXV6?=
 =?iso-8859-1?Q?NO9LAlVpycdK4q07em8RXA2ipSnk0g6fq5oc2HpV5JBkHC5PHx39yGxseo?=
 =?iso-8859-1?Q?tUDt+6IClzfYRMMzcoth2gUS/uQFIp84aAj8k98k1fhPDAzjo4SS7L3ez9?=
 =?iso-8859-1?Q?tBbjbbV12ka51tjdUApqlUcHXjtGD+mUq+YI3cSXRswf9+5OtXPpE5BMMo?=
 =?iso-8859-1?Q?hlZkLfy0Tw+o/9iILvAr9IZ5RA4CbuuLafIEL2PZ8hv+VUINE0GI55ar3A?=
 =?iso-8859-1?Q?0QP9ks1mvI6B5CkuJO6T+BrmwYEntaxGcoW+VKGuO6ue562BjbSF2j3aNc?=
 =?iso-8859-1?Q?MFBGwYVrK5hMOS5YAadPIS+stJnpFmYp77rcTY7NCOIUtvo+4xVqU5Zzda?=
 =?iso-8859-1?Q?MXXYqcdsYPchqMDvPA0eqFdXgyfViTz3A3GvyaDMmCy0rJ+DWvifI++e0a?=
 =?iso-8859-1?Q?vlb7fisNqOGvynWyLcX/h2NFV4dH1K/zGUPMd4GHPxgLEskwJgO03LAXVT?=
 =?iso-8859-1?Q?8uZUHbPE0FQ9hkNUUaFvPpFQuE30OaavOv3LxjYnNlYcktirDyCMhXQBAs?=
 =?iso-8859-1?Q?bvTjQB7RjoYxVvEVjmZjM0rijJqbyWS18JtIuTZfYkG0HC922OeuEl0HYS?=
 =?iso-8859-1?Q?N4NcqMNC6EJniHXxMczLAVqLGliBQ=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?pDVtw1dIwDOPUFUpYMgtsyHdm2HZQIcAtILKhmmkQYGFf58G1k0dcScN4P?=
 =?iso-8859-1?Q?WB7IiH1xvgT7+g6XVJ80b/oCm6/Qzk1twqAfASyqrqVVIBwf1kKGVwvuVf?=
 =?iso-8859-1?Q?H4KCnYJrQo56Mz2GHJIMHMmJWySwgDgAC2aHMZnoxY1qQSdVA8qfBEiNvw?=
 =?iso-8859-1?Q?CZCypb7tJyiSb3Qo1Zhf3sUr9jV+VDolaEZe5W4cUfnjeXY9dEpsIMvFqw?=
 =?iso-8859-1?Q?1I2aq5RKNEK/2dO13qUlp4xsrofvZLmLG/hQYJ6oQ8wGfqG1F/WSqhZWkm?=
 =?iso-8859-1?Q?MREkphAaJMhazYLVZ2Jn5uGEiNRw+vV/nwtHUBYP7wbrjoOWdJ39SHltBu?=
 =?iso-8859-1?Q?0VqaSnpUHCZ9CwCxMVmHDwRefXXz3rMfyxXDzGgzCG2BinmazWWpX/0zfW?=
 =?iso-8859-1?Q?VKtQpj6h+WI2mTy2z1XKUDL8JRhab+UcpbGSozBy02ZwcjThbKga1ejwla?=
 =?iso-8859-1?Q?VE96O9c1N0fxGf6Pe5/VGRwsIpnI4q4rX8hsE8eC/F/TXNXESSA5O5JHZh?=
 =?iso-8859-1?Q?K0IAx+2MrZlRxMwJTkvrZFyRxILYEgILnpBb0ynXHDaRdHvxsHxej5ARbK?=
 =?iso-8859-1?Q?t3PW4qg84ZQBnnfxxh7mvtO/+dzmU6OAG8V2H97dA+fsshLaN3alu7QEyZ?=
 =?iso-8859-1?Q?MUSBarEzSew1mZsZ3m5Y4i28mNsdpktuSgpDK/1yImkiEKAAJD/aJu6nGo?=
 =?iso-8859-1?Q?1OHgWsq7h0O2F+VbGORvhfrokx9xXhwEAulR7UR4l/25RMqhLl2E5io7Zs?=
 =?iso-8859-1?Q?C2uV+LB3VocOQRijnje2wqbiG7tmg6sxI0VDa/eWpMx9REXdQwp01+un/+?=
 =?iso-8859-1?Q?Usn+VfibtSHvpqYD53j9cDedEH1CXsam1e+dTLpB4GoOfdkNfI6uL0vdrF?=
 =?iso-8859-1?Q?3Z8fH/v+VzX91SEQUmpBFkILmZmkzNqhhHnGyeKlWqnZ/GqEBxMPlYV738?=
 =?iso-8859-1?Q?JJ/sT1ivTPumnD65vQFd3mpsFe1CFuYALVoxEn4rPR2XVhZ0BzgPDdMBGY?=
 =?iso-8859-1?Q?ou3vuOA7NPdfCXuq8GAZTC3gf3A8rgjrNx75gJpeVVmGqJuBgzVavAy6I7?=
 =?iso-8859-1?Q?tH479kGe19d3ZjQeMuyOPdfxrSjgaQBEtMTsxkyT3ZTg9gVzyaJEWkPUq7?=
 =?iso-8859-1?Q?R/mouMPZgMMeE8J9ie5DXd0rFKWWKqydkR10rN7MoHW/ZpHwrw9P+3JurQ?=
 =?iso-8859-1?Q?wnBZSF6EOKmdzANJq0l3Vy8dvbFrNo30QiJ6Sp5LpQiC0SMQSkR7sDh+7X?=
 =?iso-8859-1?Q?z4wz4poR4QvIO9eb3CfUfeEWeL1qBRkFK8PNTVra2lMsLqQUnwSJOb4Ofj?=
 =?iso-8859-1?Q?oXRAvzsjHduN/ENyEaXBJbPtJ0hcZKpo/1Bb/1yZrk9oQhCmuzJSVj0r3A?=
 =?iso-8859-1?Q?uVUB4bDWBNn+hY8aAosf8+6JpFvdh+Ps62qOMZ5Lm6z9iyfoyooK4j48Zf?=
 =?iso-8859-1?Q?zBmPGzSYnNUiGCxT?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 12761497-fd42-4d26-2676-08df4c863dc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2026 12:59:15.5051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR05MB7307

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
This bug was found by a fuzzer.=0A=
=0A=
Fixes: cedcafad8277 ("nullb: add interface to power on disk")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Yingjie Wang <x-professor@outlook.com>=0A=
---=0A=
 drivers/block/null_blk/main.c | 6 ++++++=0A=
 1 file changed, 6 insertions(+)=0A=
=0A=
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c=
=0A=
index eb7617fd0964..726c8c58aff4 100644=0A=
--- a/drivers/block/null_blk/main.c=0A=
+++ b/drivers/block/null_blk/main.c=0A=
@@ -1902,6 +1902,12 @@ static int null_validate_conf(struct nullb_device *d=
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
