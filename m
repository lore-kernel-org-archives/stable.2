Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795784291;
	b=t+prbzVpBY+Hx4U3o1AwwuMnwYJ5isJytT14Mqt8L0fAM8QVR554WKVim4DxIpY84ukZ
	 qHMVttJClJ7skUyKwtvua3zq0dWqNNBXmOtM+7oKU7qnlPP5HWvwt4ItLXtsbnn7KQ3ix
	 hXjfNZ3XwIFbLSdDyn1NIXBXlMuzXkyPhygSpe3qZIUigfyDUF3OoP1bOY1y/htmPD1of
	 AYrIsThIWuxzRCNs7/gGFTMRsapFvomEsRSvy+l/HEDaUoEnqabcxe+ZqVpqY9j/JaqA/
	 JzdzZjeFnjPtuLb+f1ER3oWhdbYONAuXZTrY/amMtQ/23ScMDqDTnnD+NvyJk/MZ5rQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795784291;
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
	bh=W+rZd+p2WkNJoKlnjazGvmcb2V7QtoXpEzQe7wG3MUU=;
	b=aZq/a6c5JyBLgHmyVc3x4qQz8esTTb+FvvvogegHMpnW9sOaisE+bndTyWiLSseVyJ1D
	 MSm4WQeb/1DDWUtfRXBwIEfNl6c39cWIw/cAD5mPxGK6jAFNUTScrSorhhCrkONEia2g8
	 SDwp+4LA9UbPv8W+LGaaiCsAbWE4PvBD4PnOcISB3CMSGDp0ylAkCEXmOM3Ybg5UsfN+f
	 +fePUrQtKF/mnnjt43qDPfONeKCUQt0JpPMPsnRdXX5Z5wirIZcv+cnmqx/wRqX12qDRY
	 kJywkTEhxr9cLbP87Q0eJNZ1iG+QFtVbmzLR+k8VJWaSkkVCM3WnnTZJKJnA9XtNfiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=pZUg7H2P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.13.17
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010017.outbound.protection.outlook.com [52.103.13.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189E5606A31C;
	Fri, 27 Nov 2026 12:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 189E5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=pZUg7H2P
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gjEGCtZkR6Z5ji4QRtyvk/2TfvE3pG1esLB9jp6RZg4geLbRczNM3dS0RKYkrDySFC74j6wYdfg3CmjvYcBIhTonruwadgqPtsbg981eQTy0ZRU/B8pHqr8ChEq0DW+8e5c5wQnCIbWP03KIys1eNTfkMODXQR86XUeV2UNQO0W70Wchy7lGWsf2GXTSwy2MhwI3xRAVuhSpj6exYhuvuhV29dvPKr0BlQxV6/MbhLmntayet2VR8+wImbe9yPMLAhTPDI5Nw77yjWginWPPgh1LCgXT3p1H6BD181rcFB4e+vN5tGQ8K5o8qVAy9f5UYlRn2NCptDQQOuuMr/+YaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=W+rZd+p2WkNJoKlnjazGvmcb2V7QtoXpEzQe7wG3MUU=;
 b=LNEkA8eJAuA3FHwNCNekQHEyKe36cKesRUcKHdy34we5YAiOmXWJ5t+kz8nhKhpmxb6Uw2QejXMlozIaL4us/69N7El7o+Tb5/wq0pvVR/ROcSJfW456Mo/CIQy5RVeQMeH7u60DjTcGqEWOdo3gZRqI8d8c8P0w8ZgFGynz53JLZFUBYrIxnI4U47ur8NALrn5rhapm2SHevOenhT8LU5wNvzn0De52u1YU2lF4cX3LZapjaGCpzmpX+gfICtV5LJYbX2k0qGd8mV3+H8IdpKvLBPILj5Tz6cF8uweddwHFBKCjiXlmW1mYJr7AK4YStd3oqPXMnFEDUddz6qZh8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+rZd+p2WkNJoKlnjazGvmcb2V7QtoXpEzQe7wG3MUU=;
 b=pZUg7H2P8WEI0R4PDkwx8QtntzsHx34KEUOxbVnBSEUiQzzSdnu03lz1kR6XW7ausYFN7XKYNUk+pmKq6AWbvaGTeEkNTgA/1H6/vgZwpZVytkHz9qZed8tStrdNr7bGDvAWDjYfB6Zhp/Gf8fsrGEWBLA3yw5uNvz6cFsrAORhF61KP0OuUjl1KsXJ/xRvxEcbCtoYkOXOe/qlOAoH2ALGUeHfOpp0b9xctSZP+mLH1Q6ECqFs4KPPynLEJnqlCbWSrX5cFynNAdz2Kl75BjrmML6FKTMKzqX5b2FmETchHlqedlw3XLuawHHco9TFjg4BW2W4kHnY2KscR2FdfRA==
Received: from BN6PR05MB3281.namprd05.prod.outlook.com (2603:10b6:405:40::35)
 by SA0PR05MB7307.namprd05.prod.outlook.com (2603:10b6:806:bd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Fri, 27 Nov
 2026 12:58:08 +0000
Received: from BN6PR05MB3281.namprd05.prod.outlook.com
 ([fe80::5b9b:67c7:5397:c42]) by BN6PR05MB3281.namprd05.prod.outlook.com
 ([fe80::5b9b:67c7:5397:c42%5]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 12:58:08 +0000
From: Yingjie Wang <x-professor@outlook.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Damien Le
 Moal <dlemoal@kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v3 1/4] block: move BLK_DEV_MAX_SECTORS to <linux/blkdev.h>
Thread-Topic: [PATCH v3 1/4] block: move BLK_DEV_MAX_SECTORS to
 <linux/blkdev.h>
Thread-Index: AQHdfm7zBxuBsyNsw02MVhS+xiy+1Q==
Date: Fri, 27 Nov 2026 12:58:08 +0000
Message-ID: <20261127125738.1654012-2-x-professor@outlook.com>
References: <20261127125738.1654012-1-x-professor@outlook.com>
In-Reply-To: <20261127125738.1654012-1-x-professor@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR05MB3281:EE_|SA0PR05MB7307:EE_
x-ms-office365-filtering-correlation-id: 421b8997-677a-4f5b-ad7c-08df4c8615d4
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|8062599012|19110799012|31061999003|8060799015|25010399006|4140399003|38102599003|15080799012|24121999003|22091999003|41001999006|40105399003|52005399003|26121999007|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?159F50VeqM61KcBqMDrP6Ckjlhe1ixJ23vU1CES4oBS5CUidSyVWnIIT5a?=
 =?iso-8859-1?Q?wNi4liq2obOUn1p/ZIqeYFiEEMEfufxYckJj/FAe6DPzkhUzML13SpwkPT?=
 =?iso-8859-1?Q?IAP4UE8HrQai0GjPE44wqhR8+caWy/U68q1PT6oioSxktbRPWxTcBuWQ+7?=
 =?iso-8859-1?Q?bnAg9DOy8o4KIEbWQwqqOfXkm5se0ZtUv1gIPd+Ubw0NC2o5pz9delZozh?=
 =?iso-8859-1?Q?8b0aQFOzughMY2+vEMx1rTTvbc1Yoe+tJASX0Xx1FnQpyVan/a8mz8GAow?=
 =?iso-8859-1?Q?WHSVmVddEx77kxKbxwHzEUcRXkyi4kTZoQ9ZvBVEKkxKc4eiKl0k1ME8Hj?=
 =?iso-8859-1?Q?gbMl7dd+8oCKAw9skMyc+k/ibLoN057TcLfu6pA4wFp1R3FRwJP/Ng6zz0?=
 =?iso-8859-1?Q?WDSkEmm86D5gBwZ1Mbnb8fnNek8VHhEDUdzdyfUsmUSycyirYinp3t3sMT?=
 =?iso-8859-1?Q?PpQKwZsO+7spOiHwV6bPufEjyxoREy0hfls7Fv71H3JUxrNi3hyYubSdSL?=
 =?iso-8859-1?Q?4r/WlRdYdOF8iD2dRIyrWfuRrnVP5TXvobJBVQwqsHEwZEWS/hKzKyyLs8?=
 =?iso-8859-1?Q?kOg+kM7u4PaFCWLwlIUhmHdt5G3Tarq0BXnbgo6aAJw+K4Plkh/yb/WTfm?=
 =?iso-8859-1?Q?EONRfLVnT9VQ3ymvv2e5kUWhb0fWtclqiwxbTqf3Zl+6FERmu1mRtRy9wd?=
 =?iso-8859-1?Q?vKo8tq7be8O/ccZmZftSrdXCx53jyMNN1EkZ4NrCdNMoGV0ou7VBeDqzE8?=
 =?iso-8859-1?Q?1lHXHofHNjQVWGx1uTnjX6eRZFslwFyCcE6E3uQjHKL1vS5oIpYRWW5Zx5?=
 =?iso-8859-1?Q?H3Vs/+i+66YCEplVbvpuiedDUF2V05DNJJrsPMPFqC/fkB0Kw6J0KjGJ1B?=
 =?iso-8859-1?Q?5onDRC7P0NVr6AMzl8QRFgKrwDjEMcuFZx1xVVcDxps37n7D0ocW0RV3Em?=
 =?iso-8859-1?Q?XfzwKGdBYKa6FM5rNgVkwknw6Cn+3WO8jY3axdrhrCiomj3+IPt0Awixu6?=
 =?iso-8859-1?Q?3/jWKwejd66ENDJxFv700zyNBI90RbY816ij5inm7RuPQwYelDn+DEiG9K?=
 =?iso-8859-1?Q?aj2HbPima4vAEws688QSRWBSx8HOwGig0UomY+QJkJCw9sDUfXLnIEmPyP?=
 =?iso-8859-1?Q?cqlT2dfd/CwWxzqF/QHipDcN6NZk8=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?mH6Qk0MrXSRuiSHn8+qfu+LUiq3RprqJxDUUAJc5NUkSVtC1Jy5vXnVhiB?=
 =?iso-8859-1?Q?xFjcYXI9914rYIdCV9a5Oa/DCzaZyftvLfJEtoZ+F1sRFKNMP/AjciBDX7?=
 =?iso-8859-1?Q?JOu3WfRGrsXyzBWM5Wer9I7BCOsBJS5oXvJFONtExEbvRIgM9aCxoVk+Du?=
 =?iso-8859-1?Q?r201Xn0h2E7mBDd7u5mmVDF1gQzmKOLKIpqomOuExDbycekt1IK7YnYv/U?=
 =?iso-8859-1?Q?qxA/cXAnCk52B3kzJ/KfvMCqpO4x6mCCXQ1KJfq6K4FYnPb+psa+Dy8H6u?=
 =?iso-8859-1?Q?JN6y0VUwnCOeXHJn520mnVoJO+ZCwz5ChOg3YxGKS6IqhKs4NEz+Nyisdn?=
 =?iso-8859-1?Q?dTshTKyPXGW0UuRz+dcpRtJ9Y40EwNv34cwxgJe29j6sUaBpwWve9PHUaZ?=
 =?iso-8859-1?Q?jtNKFRpXDWNb/7hORYvpLWuNvpbtiOsb4knIgK+Av1q7YGLXiYc5HNbOO+?=
 =?iso-8859-1?Q?APbLGkbCLxN7EGKQwzAxuC3xqoSoAYFTHeB3IQ76bnTCmlOz7rgR7hZz26?=
 =?iso-8859-1?Q?PZMIRqOqN0wFc8tx2juKS+ofPkNHLN7iF/3Pfwr3qXZAvyJZ9R95v4YQxr?=
 =?iso-8859-1?Q?jvLGdqNmg7ZYRIb3rp6OT0ygG/5qEbEMK7CGI81VQaJzU+zT3/q538ew5k?=
 =?iso-8859-1?Q?upoLB6IQzhL/xywSoSgFpFWqxCRCJtJitqirMi4P71wCukfJM34kGZxdY2?=
 =?iso-8859-1?Q?Y8rKza1kGzpF1MSHlRJBRBXlLzNjLQyT6XN69S4x/ldPXvY7886dFE26gL?=
 =?iso-8859-1?Q?R+F7eiPwzceKGzRHmLJTVz6wpcBo/zN6rSSJA13HyY8cFqp+U43tjy3aRf?=
 =?iso-8859-1?Q?3NhHyc1BZuZh/0oBhOUDv5i0yiG2QlFBTp+taxd9JeR49pHEfNK6rQNgVA?=
 =?iso-8859-1?Q?BAuvuIqLLaYAJvtlRupc5fT4gM0hzG+HpARcKCL+TfjnZkISSMVY/kPYw0?=
 =?iso-8859-1?Q?HinqNshjHtbJZ1J+nGBNvWnYe3WaXGToN/Vdmqb4IKJPyTyZ3nVxoNDLnQ?=
 =?iso-8859-1?Q?eFxde7Ypq3in8HfoyG7rT/UhWRaq2QzRo0d9YUv/2ofIrF1MTuLBvXBvk9?=
 =?iso-8859-1?Q?uOHCXfOLmaCGJWQEocIuCVWUYsrc3hL3rk/rFFc0wMsN2iSK2IO8uRzebx?=
 =?iso-8859-1?Q?+eLb/j+dJ1sK2UOpGI00a2KnDdx7l+3iy87kt6D1pIUumZ8zd9RC3Lactx?=
 =?iso-8859-1?Q?pmf93BttkXXvdhZSmKGpbR/7nIPbRRAHAbSExcQl4ePbHYTHfcFBVcNyjT?=
 =?iso-8859-1?Q?kF4pf3D+7CauTifb74TnSol6FPXl63tkjkSL/mEKMBRwDmJ/23mJpEUeTg?=
 =?iso-8859-1?Q?Ymk5zptVobEQtzBQNacbAoCWKnqdr7ffNe7mpAC9kd+mPexuNAWllxB1CY?=
 =?iso-8859-1?Q?N++cOF38j6gDuqICwQRM5DMs2Fk2cli6I1vNEqZ1J1HiW48uVanZW91q6B?=
 =?iso-8859-1?Q?9hSWLFkmvH/zQgem?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 421b8997-677a-4f5b-ad7c-08df4c8615d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2026 12:58:08.4990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR05MB7307

BLK_DEV_MAX_SECTORS is the largest disk capacity the block layer=0A=
supports: set_capacity() truncates larger capacities and add_disk()=0A=
rejects them. It is defined in block/blk.h, so drivers cannot use it to=0A=
validate a capacity they get from the user before calling=0A=
set_capacity().=0A=
=0A=
Move it to <linux/blkdev.h>. The next patch uses it in null_blk to=0A=
reject a configured device size that is too large. No functional change.=0A=
=0A=
Cc: stable@vger.kernel.org # 6.14.x=0A=
Signed-off-by: Yingjie Wang <x-professor@outlook.com>=0A=
---=0A=
 block/blk.h            | 1 -=0A=
 include/linux/blkdev.h | 6 ++++++=0A=
 2 files changed, 6 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/block/blk.h b/block/blk.h=0A=
index 105fff157bfb..13fa24aa05ea 100644=0A=
--- a/block/blk.h=0A=
+++ b/block/blk.h=0A=
@@ -23,7 +23,6 @@ struct elv_change_ctx;=0A=
  */=0A=
 #define BLK_DEF_MAX_SECTORS_CAP	(SZ_4M >> SECTOR_SHIFT)=0A=
 =0A=
-#define	BLK_DEV_MAX_SECTORS	(LLONG_MAX >> 9)=0A=
 #define	BLK_MIN_SEGMENT_SIZE	4096=0A=
 =0A=
 /* Max future timer expiry for timeouts */=0A=
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
index 215753171cef..75d640cc0e9a 100644=0A=
--- a/include/linux/blkdev.h=0A=
+++ b/include/linux/blkdev.h=0A=
@@ -834,6 +834,12 @@ static inline bool bdev_read_only(struct block_device =
*bdev)=0A=
 	return bdev_test_flag(bdev, BD_READ_ONLY) || get_disk_ro(bdev->bd_disk);=
=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Largest supported disk capacity in sectors: the capacity in bytes must =
fit=0A=
+ * in a loff_t.=0A=
+ */=0A=
+#define	BLK_DEV_MAX_SECTORS	(LLONG_MAX >> 9)=0A=
+=0A=
 bool set_capacity_and_notify(struct gendisk *disk, sector_t size);=0A=
 void disk_force_media_change(struct gendisk *disk);=0A=
 void bdev_mark_dead(struct block_device *bdev, bool surprise);=0A=
=0A=
base-commit: 5a29cfaf51105039d156dd8a61d2783e8b653667=0A=
-- =0A=
2.43.0=0A=
=0A=
