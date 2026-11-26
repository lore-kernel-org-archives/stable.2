Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=52.103.20.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795679276;
	b=wmoZRqvXdcDmTZmIFBv/geUIYQppSTCPI853VZLlyOs9vXw8C/0/lC69AZIuOqmopkkI
	 WPyadlWrf5NIDGN+1raNFsssRiZEZ+ZcLzXdbZ18/J4S2+XMVz04XejKeDLWFLovfzzf1
	 SEIhJlMFHSmUVylXWAQktEmxf2iocQVmV8MX9G5vhxvfUfK2N0CnKDxQJVPtiiqCqZxfy
	 dVp6RgZyrQ39xqyRHQeuR8gsp/whU4J82PPD3L2GJdEXnlez6q7ZSbU/o7dFEdr2AI548
	 d793OfyNUL+GmgGx7YiJPqo5o3Bk4IgDp11yBYAoeja4t+80hOJpWool2TvABNVVK2Q==
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
	bh=J0WFwJEWL31MvmN7yPLUb+l+yzzA9273za3lsoCvP1A=;
	b=XQC+Nxxp3u6kuccLLcIPmqs6uOSxlnOXNj9n5p0qtMPD9Rz0WNghVInDVbLRy3j+Ldez
	 ALiTZByXDTfZkf1uKtIfQ2mrC1TGH/9n7ml+QTDgp4Uz8WpiCd/ICwCx9xaUN6CIy78tE
	 z2Q3GS587xfWCnk5u0vuzSoQfuduVzPlgcK/gD+uDgIH8Fx0bEog8lH1u6rIKj2+QmN7Q
	 9q8FcM7VQ4DhHcKkj1WrscKmjcAB5VmZbkO7FrAKVcc9Z0TCP8CHjkRiTRFULvgq0gUEh
	 FEctnITVawQjoz7tDmgBxtk+WXACxQMcLp3WGMlr2A4nZV5OA+w1v/Iwz0HLswTwTxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=XqLJg08d;
	arc=fail smtp.remote-ip=52.103.20.4
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010004.outbound.protection.outlook.com [52.103.20.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324F3606A32C;
	Thu, 26 Nov 2026 07:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 324F3606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=XqLJg08d
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jeuDFAaRyrTH7RmAg6+8XxSSMxIyrvRx6kcZ4VBH5+EahiiVR6Ovb37+7Q+obofP1aMBHXcLFOMEaDpvlJr3SlWO+J/+NQgCbV22PLIA8s5JK/WNXQmiFfaqVw0D/QoPE7wGfLzzxmZnl8bqplI0wPh1QMTOCvMQ4d+pwXkXcDrHEUZ6yfZlo+YfOEc9NskPv4xOmViWEmgnvHjL6N3GlRX72UMRiFaL9ypdRPSSVCZd7Y4lsXVMccnkiCsRkuFzpihehlz4Eg/bPfScuH42irJYdXdPlI6qZM2dU192CJvs+f/c/T5WrcXi+LTIGDD3GZYHY9+jiYF6fglpcA9myA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=J0WFwJEWL31MvmN7yPLUb+l+yzzA9273za3lsoCvP1A=;
 b=MyhB8C4TptvbJEiZdPGrXDr4kYYOJJLBKkwE9CoNYQoUNL+kSxTBgYhsSHhXUYG3HXunB8Gg5of28kIkxRWsuyNmFl5eNp9rrdH0BQ+h+oSQnEQcm+iPBORUWgUoBFX0LrBWQgffSF+KTWGviCMm4PsdS/G8TLe0+9vaQXIeUguQQ+OrYIIA1sescyzvt0a+ve7gyBCbsT89oFUmGXdevBGbtKBdg2q8YXMp2yYhR0jpTZuoE2xKo5EjXX+lbTvtFnJYRUgBeniP5QWpHBcyWgpnhbZNK46inzV3oN5aKrAOMU9eilyG3fHRXlzuWX7RcY/fqaL9zBHK2SycO2onPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0WFwJEWL31MvmN7yPLUb+l+yzzA9273za3lsoCvP1A=;
 b=XqLJg08d3GihRWab9wdPvyvJQWpHfjnckf/zpPJVu04r5hIHSFd7IR6ytMrDMqdVV+nC3gPSSDQ0+lL91pG/VaS3nlZzAhBa1mC5vrRgfd0O6pY6MDofzXRSkUPc20RfaY8lKTe3mrszE6HHdLTdq94I2cT4QQDPRpEfcTAl7ClhiL46B61js1zHFO+K6RH4P20g1Q0SzEdQqzdW/p3dCMYs+2FpFco0n0UiDJ+lOPPwB6ksBq3I7gptgbj8FtlpaH7KtM9F+G6dFSwaZ6penSwWqx5PfUIhSSOeNybLEr+cR49iNoT0JaqNI8qraWKTAk0+IFdWhzxQ/EGuOv7Srg==
Received: from BN6PR05MB3281.namprd05.prod.outlook.com (2603:10b6:405:40::35)
 by SA7PR05MB998597.namprd05.prod.outlook.com (2603:10b6:806:4cc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 07:47:55 +0000
Received: from BN6PR05MB3281.namprd05.prod.outlook.com
 ([fe80::5b9b:67c7:5397:c42]) by BN6PR05MB3281.namprd05.prod.outlook.com
 ([fe80::5b9b:67c7:5397:c42%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 07:47:55 +0000
From: Yingjie Wang <x-professor@outlook.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH v2 3/3] null_blk: validate the configfs home_node attribute
Thread-Topic: [PATCH v2 3/3] null_blk: validate the configfs home_node
 attribute
Thread-Index: AQHdfXpybqak7XLAy0mZ9DPW0Axqug==
Date: Thu, 26 Nov 2026 07:47:54 +0000
Message-ID: <20261126074748.1076774-4-x-professor@outlook.com>
References: <20261126074748.1076774-1-x-professor@outlook.com>
In-Reply-To: <20261126074748.1076774-1-x-professor@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR05MB3281:EE_|SA7PR05MB998597:EE_
x-ms-office365-filtering-correlation-id: 2b6968f0-7fd9-4e86-08da-08df4b9194df
x-microsoft-antispam:
 BCL:0;ARA:14566002|4140399003|24121999003|15080799012|8062599012|8060799015|22091999003|41001999006|25010399006|31061999003|38102599003|19110799012|24021099003|3412199025|440099028|102099032|52005399003|40105399003|26121999007;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ddg1Hi8fz6cnHNaHB7deTzeJSLWtwkp/1KtDY0D8vG1IiKHQywYIQvTaEB?=
 =?iso-8859-1?Q?t7pYvm/EfbDztsUmIcwkzfEkJoxTQLiva6CLnDXbSPDwhxbB1BWqlyBIMa?=
 =?iso-8859-1?Q?Wswl2HPzb7OkT8tDWyp5ByXKJWOB++FrDCr3IpyAkaYd2EuRf4da1Q3eiF?=
 =?iso-8859-1?Q?NEagso75DAt+VjnFw+fB3moD4XMYwffGovvw0ZBosYQKGxm4wengAo3Z18?=
 =?iso-8859-1?Q?hYMJ/bKIBXYSVTJG6xLyUR8ZVEIlFE2vX6EeCL/YSQG88SviXzPsSa6mkQ?=
 =?iso-8859-1?Q?NW0meBbz9OlREeLcnkJOMnInNbOWogGlh3Wr3gk3dx0OD+xG59aaLewYUQ?=
 =?iso-8859-1?Q?hqz87FPIvVpWDvP5PElnQN8tmOxdoIOJahNPFebJYNOua5nJTNvjMI6HNC?=
 =?iso-8859-1?Q?+QNCnJnxeXFr+blxK7uH2JK2EG9Yxn2W0yWsLwErSzmVBDpKFgKsd8faQ9?=
 =?iso-8859-1?Q?ZgPJGLAAki3EPkL6AiNQCbHBqtZa5IepNfhRoHsn28z9jhlvNaRTQsKX6e?=
 =?iso-8859-1?Q?+yIF+kDxx+/2CFzbdsl+1ejF3qL7t6Lf5tG7/f5HBPUuGSycmw3JHuDPmV?=
 =?iso-8859-1?Q?3xplGCTyWcbhTIMdXWKEVZahJw762zX2r2V85PoylC9cdQRqzwbo9RxaZx?=
 =?iso-8859-1?Q?CvFmuXe2yP9PV/jwu54VBsAOetPsKmeVFPfRouk2C1GBqtS5wqGwCxqPsg?=
 =?iso-8859-1?Q?wz1dOs6x8xZhBQmDFNxx8xzyLWnleEhutmRQg6FfqE2+h87Xyz8L01t3uy?=
 =?iso-8859-1?Q?tfsHDl1jhCgMu8FLk2s5lcuX8Nq9CNhXp7/P8kabfTtDe8bTDYjAFyTzgx?=
 =?iso-8859-1?Q?TiNNAddnRAs5rUBqsT6JHn5BrYX84GSMUiyV6gj56FjP7aiXFHnAbyu4Cq?=
 =?iso-8859-1?Q?yXQESuIvyO7TMT2K+kLKdCITBpvd622ESBc2dAnngbOJB9jQevSmCQq3lw?=
 =?iso-8859-1?Q?KRSn3pxfqdaFMXsRoEgM+VqozKgaGGkvLhYcsoCqSSDXr0pZbSD5eLBBpJ?=
 =?iso-8859-1?Q?Mzb4I+1haYg01icNhCF9jGPCRVfwWwXHiy3NFzEmgrriOJGJyrrshCuGIv?=
 =?iso-8859-1?Q?Gh/pMnbFVKU4JVUA3zTIXdDSv9YPYJuQwTm6tsxx2nCA0goYI23fUn6H8e?=
 =?iso-8859-1?Q?alkb2E5I/k2/crPilS618wXwdRmhU=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?EMkMxsxo1//FyO24KfGpVP11a2EsBag+xK/tS+yMHeEly7cQ2cgL7+aiyt?=
 =?iso-8859-1?Q?Xusl/jiI9KKK1zQ0bVZC/1Ir+ybFEYfUfD6/1SNBm8N59kqFls9Cg2zRUt?=
 =?iso-8859-1?Q?yzG+F29eoKKaaKfUls8TbnN3B6ihqqUZdq1jzOk/bqh4V4K865ULTD8WAd?=
 =?iso-8859-1?Q?gD+XfiB1Zroir0vZsJ5A6vgyMieobMeWIqm7MFz3/vOrWzW5RqoYdslSU6?=
 =?iso-8859-1?Q?EceafgljJBKuBIk97u9/3TWaHg6HuQng1pZXt4zPB2ns0H57LiCSyo6sxg?=
 =?iso-8859-1?Q?xA39uWPhoYHB1vWF0DbxpC1gFfPpkc7Bvpuj1H+fjhWLw16YGSdg46bw+9?=
 =?iso-8859-1?Q?JlqYb6vXBkKKwxtV4HmPigiSVX6k9X1vg6uoHzj2t/ZUWWrCKMkBpPpsIP?=
 =?iso-8859-1?Q?zqVQu433KQND2njX+ipnaXFA2lbnmqmzPjVTa/42AMOslHU15FJjfI21uO?=
 =?iso-8859-1?Q?+aYbPjRxs1Luy8mu6ejCkKnkyXs0pZzSKbyOgUlNt/EEL1QosvW/7kx5TH?=
 =?iso-8859-1?Q?HtxxUCa+8RfIL2Io9Bby/NtNoVt771Gdwrb7cpbv5XJU63D7UNhtEqFqh/?=
 =?iso-8859-1?Q?7cSvq7lU89LfYpoLayWhusZ+HoACRUt8uM2svcsSLdnfhISUtKYF4q65Bu?=
 =?iso-8859-1?Q?pRcwf9h47+0RH01Sb+ELvk7zJmWpTixaQZygrgsdqUdif9l+aDxBFG7iHF?=
 =?iso-8859-1?Q?9NyzHvmpAfQsCKti4Fua5XXxQxOfsdAwkLSWpDcYDhGhcGAzTfavEtjh0a?=
 =?iso-8859-1?Q?65KQdG8KkaSrD4+z+ZRv1oBXdFsBkcLTANFE2gA0vO4aj/uzprRYk4xBWQ?=
 =?iso-8859-1?Q?MJtj+BED6sqhulfExMxUYEWDsiikD9baHdiW3VH3ZrcD48Vy4HR4n8aE9w?=
 =?iso-8859-1?Q?dfRmk5l9lmy++xNO7hcZYauSxdT0s13ID8pYZyPGS7ykraggyM+RnmOOnP?=
 =?iso-8859-1?Q?QCs97bj+POmQZKUp2UTxCxA2qdBrW+6kCtzg+AMzn7XyPTLnIX4CT2pjhk?=
 =?iso-8859-1?Q?ZrAO4NTlUIaHXeA2gAhSA7SvgxPzONDPvKWHMPKR5dzwzAl+vhHQFY1wUT?=
 =?iso-8859-1?Q?2CahK8nT3Js3WJa1wWBNvX/YACXVVa+sK95QQW7lfAEAYkijexMxO4NT/6?=
 =?iso-8859-1?Q?QKagmtZ/64jFhXL2xJKyNbKcMDG2XGKWtO622EPBCLpd1eOf+JdvYGHFco?=
 =?iso-8859-1?Q?0XV/9zZknNtVT2ofiYUAY9ahPKW26SXOCcthVvpJIy1C3xo4jZtpVUzBZM?=
 =?iso-8859-1?Q?6zddNOk1HwX5S437dGuK/TB6GYXoB2TfBopB4fuYEBhp7DrBVuXNY0P5w9?=
 =?iso-8859-1?Q?aSqnIQ3UW+Ec4xy1ClPPp1976+Tx9/ZWxNmC6xK63/0KXEc1S6yJ6BcYPk?=
 =?iso-8859-1?Q?Ta1M2NiZTpV/ZMlJrObJyNCDUx3zY4mQ8TNcHWtK6AP5HpR3vBLpWJEOzd?=
 =?iso-8859-1?Q?DQhh+jeDbMymAIeD?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b6968f0-7fd9-4e86-08da-08df4b9194df
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2026 07:47:54.9737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA7PR05MB998597

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
