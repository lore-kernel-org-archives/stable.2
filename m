Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023139.outbound.protection.outlook.com [40.107.162.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B5F4908DF;
	Fri, 14 Aug 2026 18:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786733773; cv=fail; b=GrvT2jHp9j6SMvUhxVN3+zFSLbIIUTsgnc8xMosXOpSrAeawFaFvxybI9IwUwmI2tpxfEf5GPqyADr3LQXSH4jnj/VbcdkTqoby+QvXvlY5NzeSxf7+EtbjgXz6pNB74ciGJ9t1XEBJD13/giJqzGPUL/UGkIJtoeCkmvHIyMkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786733773; c=relaxed/simple;
	bh=6RRPcE1PkvyjE6PeNgchYHGtADU6vZWPq59Rej5LX+I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JFWAZnGLmJgfjupHx7sKlxKMiNm796fek0sQhtmrvc1cNx9/Bj0rJOGsBSp7tFt0YsTxF9livRSLG5bbn1+0nXPhKibUsUK909dtvjsCpdwJs9n7O7Viiz9kQMoqw6p0ZNvHutAm1n0OJm9hxvRjVHdhOIiCQ/MslqmRPO64o9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nebius.com; spf=pass smtp.mailfrom=nebius.com; dkim=pass (2048-bit key) header.d=nebius.com header.i=@nebius.com header.b=oFT6W/6t; arc=fail smtp.client-ip=40.107.162.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nebius.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebius.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebius.com header.i=@nebius.com header.b="oFT6W/6t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nObW0K2sBjwdxQ7yhHaOIZMwUHY59ZE9hpsWFFhuvLrT7eGGcGPcM73mUSpKvkhrYGMsPcovEgHO2/wHiGs1bz9F+Mq9Q91u89zvlmmhx6aPOcEEhXo8dfZqRZwS0PH2MIaiRfO1T9jJjzyJbyJUG5KnHoU0Rw8bqN2P1b25PctfKK9IRDeHt1pH0Rte7rP7BEDZBXyGR2F6OoCv6Sz6gyXIKVnhox6agvBVheVGeFBu5VxGASbD23AySinrY8t4HO0rT4ZCTYSUBHi0Z96VZvkjhH552xq1dTQQV83Y1UZXHFiL0sm/TX/48dqk5yKPYmGAy0hWavf2JmBrfJxJxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RRPcE1PkvyjE6PeNgchYHGtADU6vZWPq59Rej5LX+I=;
 b=OUkhxSCPDcj0VYq/+uDkTgA44g4LInUFxI7MVR/H8NHdSXYmrp1e2Un2A+0tP96vg0JKHP8PGN0Ka4rK0hOB6sJ2qJXJq1wxJueM55OguVOiQSm7aP8Ho90otyjY2/ty1YvSYnQ0Gh1ZEmYT6+JWQHK5bLzvk0KKfjqPrjPzKKAM/N9zoSKBK/pC0yBHyY5sQMc56FT8MGRKMQ+RtkNcWgtUzTH4Fp5bUIXFdO1lbUDIgtHyeSWQXrX6Zxs8F5AvNeVbZs0qDlObpqnaicnc/3QkqSRYhN3MEsJ3YgU8AHQVxesixdXNj0EQEoHVbReOyKkjU1zVnc4jfp2CRVSC1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nebius.com; dmarc=pass action=none header.from=nebius.com;
 dkim=pass header.d=nebius.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nebius.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RRPcE1PkvyjE6PeNgchYHGtADU6vZWPq59Rej5LX+I=;
 b=oFT6W/6tFWhgV7kzCw1RcbKMpBh93uimEps/eg50IPWsWGYmurkhXQsc9QDEqQjjlsD4AyXET6cGKAIO+gtXCkuoSUxGiFqHlB8tqHTIolLQLX3QP8k9TB8O0EX2jd6W1QMn68WtQuQXfLSNs4kbNMHvP1p9QeCm89Hiw+sfNCVd6RA2UaSkfrel5BmIgWVlR8wbhnneeK01X/5tXZVrEFuyfstKBMj/IkCL82qKdrrA9quDaWYJhZALtFhWTNm7s7tgBcWDv2jG5WQiFsm3H6uE6B6mu4o5ExwuqjuFxxQB7Cjzeuv2jeQHHhxACFbG+2BJ7WW05IfSw0j3EjSEig==
Received: from PA1P190MB2557.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:4fb::18)
 by AS8P190MB1912.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:508::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 18:56:05 +0000
Received: from PA1P190MB2557.EURP190.PROD.OUTLOOK.COM
 ([fe80::d0eb:eb62:7779:c6f0]) by PA1P190MB2557.EURP190.PROD.OUTLOOK.COM
 ([fe80::d0eb:eb62:7779:c6f0%5]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 18:56:05 +0000
From: Dmitry Malkin <dma@nebius.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg
 Roedel <joro@8bytes.org>, Nicolin Chen <nicolinc@nvidia.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, NB-Core Team <NB-CoreTeam@nebius.com>
Subject: Re: [RFC PATCH] iommu/arm-smmu-v3: Allow nested attach for PCI
 bridges without vDEVICE
Thread-Topic: [RFC PATCH] iommu/arm-smmu-v3: Allow nested attach for PCI
 bridges without vDEVICE
Thread-Index: AQHdK9Pu+fg3Gt/XVU6V74nnaDIiLLad0o6AgAARZHE=
Date: Fri, 14 Aug 2026 18:56:05 +0000
Message-ID:
 <PA1P190MB25573D7CFE42EF7DD2A8CDE8DBDA2@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>
References:
 <PA1P190MB25578C482C8A3B06A4DCC6FDDBDA2@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>
 <20260814174825.GC510472@nvidia.com>
In-Reply-To: <20260814174825.GC510472@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nebius.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA1P190MB2557:EE_|AS8P190MB1912:EE_
x-ms-office365-filtering-correlation-id: dd7479a1-1ef9-43ef-57f1-08defa35b1c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10070799003|56012099006|18002099003|22082099003|38070700021|10067099003|11063799006|4143699003;
x-microsoft-antispam-message-info:
 bIxXL5c+5TVAAYzaZ1gTDPVXzY1gkxnyZrMWYfB242OsjoB06rYZ1rys5s8zAQcU0mhGxmmTHUP507OHo5FnNU6oR3VTBvdb8uqpq4hgPQo/TDvubWYH7pNjekNwwB4Na2AFwCxn96+77ZRdAEQ4F4gTtLdkJ3eYw/Az8VkAE108hwwScDLIerYfsKbbB+zNgO+R9oCv5HqgFmy2s+jQrSsoWm/J8XQV8u/MM8igWk5vpIjAipraZhDXECgr5hBMT3gKz9/sSfkyXkcectTipfSJrxzojua7R/CtSkHsBbYtnijEkdu1nGTlcC6zD2Fwf+gsoA87K8NwCUB99RqkC7sBGBK64Z3qyx9/fyQpV6y1USbtbQPnItwgTFsBqvFMeOIoABNpbkHboXxWxSoXVTDg1A4P8HVJdVDMEk/YPkO7x3pdhGDohgV+/zh3arYPwSDDx3Ugs/p8Q1/52oEuergyM2X5Nc1s1SKZRG+733DQgzDlygX0FRhbRvI5MP7bWhCvyhCBu66/IF/7aXas34ZoORpT4Gr1M4om0YO+vsAjlEpjA/IYVig3Lio952Ic1KcnAGO+3s03Z5eVnmW/knKmaNGLj6Yh5ECGF/25QWY3zhhVzyYY7ZHUfGVqosg+cSEE6pwNZAJydhsq1g1zcqU2itszRfHFtptlOyRRwfEk1Y6FoURz2b42j14ibGTF6CXjPuRlcQkmRqOEqArx5A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA1P190MB2557.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10070799003)(56012099006)(18002099003)(22082099003)(38070700021)(10067099003)(11063799006)(4143699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?NQm/R0t9AdFQ8DWA1TOJT50iEeeJES1RsNPHy7Mc8Ksv76vED3tD6dqgRF?=
 =?iso-8859-1?Q?WcjldspMzp881+/JeoiWyzoD318ne2hnrxgd5EgJMxZvE3KFaPcmptquVe?=
 =?iso-8859-1?Q?RE7+zcEyvRnNOrpBhcbOrQrSdyKovZd2pgT00PTKg3GMLEY0ZteOMKyGgN?=
 =?iso-8859-1?Q?CAug1Mfwq4SLuRwIuTj5PqRqdYj3DXImlTj4nQw/Neq9Y0m56G6H3X83z4?=
 =?iso-8859-1?Q?0KGuNKsrND43tITshCACiIqxnU2EhP19RgBszBcmkJLtwMrSd6Z0ceLGoo?=
 =?iso-8859-1?Q?rH0BXVIEVyrcgZnZfB01ydikpTsEYTuflE/ERpK+FOwEwKrcrIPxKoq6uL?=
 =?iso-8859-1?Q?GalTRYKXxFjlCFw8sAmr1w6AcFZSXpDxB6BlkeCj4t+XZyHUucTRuJiMkw?=
 =?iso-8859-1?Q?OC1qKBuXxNbUgNUU03gQsMC9RvSrFDf8NbMNU4LZnJhI1M6y54Ok09yQ0D?=
 =?iso-8859-1?Q?B3zaBZtPCcTLg5c63M53KIp+nk4jfCerprmgGdU/UeQh2DmI/BwKL7lBKC?=
 =?iso-8859-1?Q?BxEwwS6yfVSgf/M6SbAnMV1SY6ol/qUJzp4iqc/evR3+g27BDFXDxqWss2?=
 =?iso-8859-1?Q?sgLK4/oTsFlEARC6BlNgsuenjQa3lnGRa0BBnqT3iLxB6OTQjAUoxjnQks?=
 =?iso-8859-1?Q?OMZnL5e34cmRvxqT+bGLBgS93uY9FtjHxvJV2N3cgX5NH/FW+h69wgXiix?=
 =?iso-8859-1?Q?9/wP72FhwjWjo/kYc3w3kRaCPD/e2fSi3eMOXmP6GMiFsMcPVyNfexb959?=
 =?iso-8859-1?Q?d3hadTrwIafZj1HG6HBeD2uhhraYVQYGE24MlFl+kCFxFE4jYXjuvjvAoc?=
 =?iso-8859-1?Q?LJ8H5AvqI3beoTt0MedAD0udYPy/0yxK885DKYmAIvp4xlrv6AoUn+Uk1Y?=
 =?iso-8859-1?Q?x1Ra6Axuh26eJYAAdM2VIjgIOicBugktYsHXn5E6GdBzF6nZNzJnb2QUlG?=
 =?iso-8859-1?Q?cfGXSGpZ9WPg0fabJmuTDDQxChmVPD9cYznQEVF1Wf3CiOZSbC3xLIEr1S?=
 =?iso-8859-1?Q?NwuggKq6r7Wr+zxmb+wOM6MbMFC+rf33b6fMmr4E5RfPiJeHFzNqUL23JC?=
 =?iso-8859-1?Q?AVYbR+xAzYn6UnuKhBt+kjX7jVkVhCgTc+qbUs6Duf4SgPdxfKCxdnqTPV?=
 =?iso-8859-1?Q?jUqz8Iw5No5DOj+IJqRYdVeXeX8VI5smLFn6Z/Vl0pTYQxMGBWkvdg5Q6w?=
 =?iso-8859-1?Q?7kMKjMlfhg5htCopFt/laNSyvk+46orZQA/fg4hg6R15ZtExzKX++N6d6G?=
 =?iso-8859-1?Q?MhZVi83/qZE/PNl3YoEXSCc0JwTWWhrBumQ5am1dqByCbnhezpTaGrE/xB?=
 =?iso-8859-1?Q?EqQTIzisHCcJdpWV5fv80Kge0j/8n/v/5ScvLgURvCSynJbjyt/ivhlyng?=
 =?iso-8859-1?Q?wgkZmZdcRzXA3FrdGFTd/wNZbQ7iN8/Sx5N6EPbbt0Y7YZaIi3PBwll8dS?=
 =?iso-8859-1?Q?xa1Sx0N7q6e8/1Wx5Q7x0zwu32xluhyQUC3SC0iTGkVyorAZkZ4V6fHVCY?=
 =?iso-8859-1?Q?2W42QXVNIPEeZQEbCUus6KJIENM6BsM8A3qiOV/TJQK/iMLauQkecQKzx9?=
 =?iso-8859-1?Q?9KOqrnWl7iN7ms9OYosD1id+EHVKf4LJWsftVHXJpjXcob6HSvJ7HTbeN8?=
 =?iso-8859-1?Q?0nJd7YJd/usBPfer0QUbEuBJdIuzHPlDluCaxYJ6KQjNiRSYvyabEejfrI?=
 =?iso-8859-1?Q?xhqMVISlcloKpJB4Ih1o2tnfoDE8Q7ZCnqTM9uWSRr/vSqznczrUU8PhXK?=
 =?iso-8859-1?Q?nX7ySWRmUsb/biwf0ibpDkwsBt1EcLOw0f7N9sBWeo42T8CqdRm75IwHef?=
 =?iso-8859-1?Q?+K+LjkmJO8C3s4o3N1hHgKRN4IDfySwByVbrfgwtOGspOT0THBoU?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nebius.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA1P190MB2557.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7479a1-1ef9-43ef-57f1-08defa35b1c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 18:56:05.5542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4eb23c52-f3a5-49bc-b555-0b061267a984
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y/lUVrdHCu4RWwNITzmO1QSd7+MZaap2ZoMMIOReJNmKq9R4EL/wuxWymUC+AlDb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P190MB1912

Hi Jason,=0A=
=0A=
> If viommu should support multi-device groups, I'm not sure. I want to=0A=
> know why you even have multi-device groups in the first place because=0A=
> that is not normal at all.=0A=
=0A=
That is because of the 'pci=3Dconfig_acs' kernel command-line parameter. Th=
is causes the kernel to create a single IOMMU group containing multiple PCI=
e devices, including the bridge (PCIe Root Port).=0A=
=0A=
Dmitry=0A=
