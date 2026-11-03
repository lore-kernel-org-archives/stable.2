Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793687138;
	b=j9aqHpSKtgTXX3K5VrlF/xpgR3Pgc4mqGJstSZgMB37zI+9q0cQavU+rXMsdHllejuvq
	 YHg2WWeMJbtA1msXuyetsQr49Q2TiLHd1HfuFJy4AA0cDkVgPX2Ur1YfcUbcb+eBS8ZhQ
	 m/6G+SrNXsrL0EK/vuNWdrVs//+0ioWWW/a2XX7+D0Nwa3qvqtrHiFtKY1TAaHm+3wtZ/
	 Svp+BaKPV/op5SpDhNaefFzguRlaUCYHqcNXnk8TNU+jLMRLAPmEmW1tOAwoGrFng2V+u
	 madc3KVzB0+QCYpbmNNZ0omyvmWJpvsHMVogxqgTY4WaSWXUo9RxAsz343UwuLED3wA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793687138;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=P8E6oknMIubMtbHkGoRD33rAm9mDfMTD9HYpAHe34Yc=;
	b=LtqeQozHx7jhShkb4fsfp7sfxVJB2h+62L31zS6ONqPMlAEvN0gwDemurrOt2EZuRk0/
	 vTa1/46fi9HODqD5mTm4hjkIVkVZqnvFny3KrTc1/QQ1aEDzaMxWQJkwTxG2LShCNPE4T
	 hmz3I5UUUoAO+VnVIYkLSKlKdrAz7OCbHXqNl1Cj99+H/aHIK2D+c7fVFTzLmETYOmiW9
	 K0eyZvCpkQsWkJd0oKyVgqZrveVY3HIsOJgHH6vw8UoulJ/jDTII4KbuXBsR4lfCCfiTV
	 tFBnb6QsMJSgNFULDWsco6fNTqDUZHJaIxcHsYzQPG5HSVIgfPDMcLg186CzluD/Cgw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=btM81GRS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C520C606A324;
	Tue,  3 Nov 2026 06:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C520C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=btM81GRS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793687136; x=1825223136;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fecGrW9JwHUJThxLN8ShaFDwz9Z8aDKOZL1oGNV3uIE=;
  b=btM81GRSxAcwrwCNR86mvt+bE65MBSLn6fHDjWgU/pASFwNRVarYoykv
   FfpIVNeOTfuj6cGDTUjEmmZh3loGEkeTVQrsVk8ppeL98iHu1zz4yn0iK
   jsbPFTlL4V6uYOygTRa+rWGoh1T0yWk+mrq81YrSBfNDguHPkltFnfzcB
   X3a1Igk5yyX9aZKdf/hMuPOoafJAyeA+WH8BavjHTupq+2/36UR2seC11
   KH+2OP4qOZPCoo1/Ypk7nzIQeaiHlZsGydDr1mls/c+MpUc97IYwuAvfx
   o030bPyoTCKyY50wBUF6kr0wJXGKc0ZlNQbl6+1jY2hXF1YCX8FzEezNr
   g==;
X-CSE-ConnectionGUID: BMljAvsITACAnzN6edZQuA==
X-CSE-MsgGUID: QQG+GX29R1+fdS7JKe8HNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2287211"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2287211"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 22:25:36 -0800
X-CSE-ConnectionGUID: EaQo+BxMR0ifSvfYYKD2Sw==
X-CSE-MsgGUID: FlsH4WNsT067mMbh3VvgYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6658427"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 22:25:35 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 22:25:34 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 22:25:34 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.46) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 22:25:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3m+B5Zbnblr7JfY8b91YJkq5t7EoLz69TdTuFrhRelqKZEaPHDfIVbIs9yASJS0/zh9MFTYLtt4sG6DUrlnpZ9CJX0OlalKcbGqzO96PsQZvMRIf7w9zHPRNtIplpjw4sadjLCvWk6GLKMnR2okSp64QhRDbeAsrK0LXUQWQuc7d6bu1TEhh4h9bZfxUZaLc7NNrYBf7x6PfBr0unmKMdMvYDdYHoD7ok+/xUy1KNY0HpfeUs3NXQUlECdFpdWiIeRwAyncVs6+S4WFwYb3MNiNhtJ/ge2hgOw+E1aE+tPFpZ084igm1RDY4/C0hChZLcPyKFz28yxg8XJu2bPnSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8E6oknMIubMtbHkGoRD33rAm9mDfMTD9HYpAHe34Yc=;
 b=zIpethaNAP0Lh/m1yg8ObsdcfdOCFmVeJh7WFoi2RdQ4cFKorMmyhmNXsNqYLatNFxgB+kCE4Wson6zAUw/n/MnzOuTB36sI8IyrLs/57fygLKhhAL05qoYMOEK/KNZqmXh54Ec/BY/zHWVEu50TbxI0IZshN0EMs6o3sX1YI1oZzhhrg4yOfcaf93AOeHWh6vSbx3ivptdLrzRwi3icAsaozlwCuhy9Lmjt8B6draUW4wQ7uZn3nfso1WwwVC8EC5fxWWuM+tKsV9hMQM+JdFiCDQwhxT3dvyC+tc7DLC1c0budQO0vH6ueqZe3ATqbRqvaHtRe89nCW5HBhxF1mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB6982.namprd11.prod.outlook.com (2603:10b6:303:228::10)
 by SA1PR11MB5923.namprd11.prod.outlook.com (2603:10b6:806:23a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Tue, 3 Nov
 2026 06:25:26 +0000
Received: from MW4PR11MB6982.namprd11.prod.outlook.com
 ([fe80::b676:829:5412:4afd]) by MW4PR11MB6982.namprd11.prod.outlook.com
 ([fe80::b676:829:5412:4afd%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 06:25:26 +0000
From: "Guo, Wangyang" <wangyang.guo@intel.com>
To: Vishal Badole <Vishal.Badole@amd.com>, "tglx@kernel.org"
	<tglx@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "bp@alien8.de" <bp@alien8.de>, "Li, Tianyou" <tianyou.li@intel.com>,
	"tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>, "Liang, Dan"
	<dan.liang@intel.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v6] lib/group_cpus: Snapshot cluster masks to keep
 grouping hotplug invariant
Thread-Topic: [PATCH v6] lib/group_cpus: Snapshot cluster masks to keep
 grouping hotplug invariant
Thread-Index: AQHdapk0nOjimPxSGE6ikHdvSS0VXrcb3ZrQ
Date: Tue, 3 Nov 2026 06:25:26 +0000
Message-ID: <MW4PR11MB698287F2EBAD1EE84171931592692@MW4PR11MB6982.namprd11.prod.outlook.com>
References: <20261102070930.1803698-1-Vishal.Badole@amd.com>
In-Reply-To: <20261102070930.1803698-1-Vishal.Badole@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB6982:EE_|SA1PR11MB5923:EE_
x-ms-office365-filtering-correlation-id: 723f503c-9fbb-42ce-b269-08df39733fb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|10067099003|18002099003|22082099003|38070700021|261028144727099003|261009223027099003|11063799006|261022075727099003|261026140227099003|261022105027099003|261026121527099003|56012099006;
x-microsoft-antispam-message-info: 9CYiI7lH2D60sT0Xl2Y96D2mdO3NIwNYRZ8QDSPVjr+ycG5P2nzOFiTNwrj4TTIZJnYLKY2eeTDQMZaw2o0S902vRtqD8ahkCx0WEiEhC1hVDkEV0Np3relxJqJ830XufGrFaLLdm+h+bqTOtxjmfaCAVvSyLh6+fN0qlXKsBVFydsZGwJJeqLvFMlXCqfgQlMLKtHe73bWx5UTqMXgTyPksSJl4xptFX0ZoPHd4dLsHyZPDtFCO4kz352/bfuc9ZXIeNvVKSc6DHizDst3DhQF+5tftrkkBNcJB2UcpoEDu1cdl9nzY+Y/PniJ6VpqKj5PBQnm5T5bOLPZ3ZNxrhn2xAnM5fBuMrwwTdzujjMOXpdxhN/f5JqpZIB2Mu6J1hcAeLBDV8l+i8hTYy8W14nGdeTvXfZLVzVWM1duT8EUZjC8f566P85jfpKdN9HTf0b5KaPOHacYcKPE2xAL6nS3i6EY1iXXcPI1NG7Sux6WttBw3wdMwWJGgc0aX91JtR6XJ1qr606038HIXAY2vlpK5gIKbS26TTVqwkCyvU4+fvT63PnpWUWRhftoc0sK6NRfIWN844oQEYjDYJ42aDe2vSEWQFggABUcaj93PSzY+Alr1RWEG88d6w0oAWJHf4vlB/6dE8M8oiar6libuYrQGylD6DoB+PnYgDxLlvZOrbR8ozvfAHfeD40bkHLU2SQjDcf8u/X6wJeGYqf7Me0yxghd459CBlvh2eUkKZYs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6982.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(38070700021)(261028144727099003)(261009223027099003)(11063799006)(261022075727099003)(261026140227099003)(261022105027099003)(261026121527099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/Chrj4wPHEQCfhSxe6udFMp5HodooTUDIMmhsANzoeScI80Rb/vFqURKnD3N?=
 =?us-ascii?Q?qf4nN9TJCpz3FRyiZ5Uxa0MwWRoecTln61K+UJ1xAEMOmmFFOqh3mNzlgzCG?=
 =?us-ascii?Q?tiR53Sv4HXqgl5c1OUX69sNyeit00TCKs8QYL0/Gr2kQeVjVuw3yTBTBkwl7?=
 =?us-ascii?Q?6PeYPRhSbX3EDp7FDMJDy08wtR5kftHi2Z8ZZwBk8DHRgmBr81RS/RWqio60?=
 =?us-ascii?Q?DGckGjdeUUVWwNXmSYKqNs22wvn3jL3Aa0bGImFr7fjhh3KyGv9vrlYnPyBS?=
 =?us-ascii?Q?jPWS6P0AO2tJbfwRlqlLdVC5g+XanUDpqsWlNXlB0pP9BLWCgxQDpvrHEG3W?=
 =?us-ascii?Q?CS93o4kEcCq87qcDqHPUbjwEtgC3EHqv/GNLM9gEy6qAnqFK7qm66uJR6/8O?=
 =?us-ascii?Q?Qu8UUS/l79w0H6ZCB+QiRs0hujKgNtI+aM105iPPrPBy+5pxM0td+6UixMeB?=
 =?us-ascii?Q?my88/MMiHJNUm+SPuewX1SmEPcv19OhsQObYrZx1gflFf9+QfUE20YiurJVT?=
 =?us-ascii?Q?urU3W/rOP3TSET22vpdTjyUgbYBypmKlFhiqAn3jygXHhmqeWP88PMJWthTl?=
 =?us-ascii?Q?WjGIwx+nmh9vrMz0swWXIrNxtDBO5Uei7O+F7iagzubOJeeERazWdzJEhskT?=
 =?us-ascii?Q?Y36+l0Leaep/0F37HkGsGQiUQxxtNWCbBYBWEW+PECgLHyhWrlMJJFgZLWMj?=
 =?us-ascii?Q?1LhKN98NlJl+rCxEi+4yiYVbHDcHkdvQSmUPv3XpwGQCjadkLApcEnJQk/4y?=
 =?us-ascii?Q?XZP2P89g2KxzX5IZjvZCWUHnOskBKPpkxApxKgKayhYKAZ+Z4xnzJTiZ6Bxm?=
 =?us-ascii?Q?TFlRbggyOBqIRqH5EO4RARF3Bu/Rc4MOIjMeKGrbCmokstF4QZYsiTjJNUQl?=
 =?us-ascii?Q?SwVK2LGsNZLEoRs7oO2OkpKOF4PeltfD5Nln8jVOi2PP1YFbTspotRAtQXmW?=
 =?us-ascii?Q?uDMJLfEpI8+klW1qFNfSIk3LIkWKKto44ecieRbtbxuvT4XSXe+UpvpqQ2SA?=
 =?us-ascii?Q?umfoMgBuXKU0yAAuhZHPPlwhXd+eFFf9oPtDmm5LsyefXAGB+IVDHAaWvrzH?=
 =?us-ascii?Q?dhBXuEyeG9hVd7ArDjL9qqF1X+aOFWaJWtOOAMckT9q+32osSmLL1t2upxfC?=
 =?us-ascii?Q?k647h2JYq4pew9709tF8f5EMFsK+VoQsXn77GKYQ7vGezCUw2V3ZDMyJbV3N?=
 =?us-ascii?Q?xFrG6acRWuaM2Kj3M+xv5XzeLOpATqbzT1Vq2iTL/NTKXaEBPsxewl4Z2L/N?=
 =?us-ascii?Q?druD3XvwUtTEljg6itxwz9tHbm1bCPdEOKbFxAzuodmAyn8f5bWe1WiggM13?=
 =?us-ascii?Q?sCyz9zelfi5uXdY/TQO5zxQydxewmd3PYtkgDFYd8+HGXzqkLKYbfSifLZ34?=
 =?us-ascii?Q?5YR5Mv5WQjaV4jJAH7zSMbmK5ZOKLaHOmIF19hf7fZ6eQucCqLTSXWTpW6NI?=
 =?us-ascii?Q?hJEJLSMVbgFRtJK44+n0LcYlfOSriea7Hy6XPAeUyv3Yhza8TeK1ux+q77VF?=
 =?us-ascii?Q?kp4+1Z4MUUV1BGEzndDVHjgjDx1GEWtXmfM3Z9PX2Bzg1MMNc2eDuPgzfl5C?=
 =?us-ascii?Q?srXfx9OgkM8j6eCABI4VjEa0Ww1Dz9QYIQ8Ua31pp1YX5HtdUgUpAPLPJhQ3?=
 =?us-ascii?Q?zG1qYT88kyjqlZqzYmEXRR4XnWUDROYyZfqNde680b5hbEyXwxcBP55HKR3K?=
 =?us-ascii?Q?JJnmTHLFBEUbh0xyicVr8bXBCXZmJQnY9GuEov7gZntOck/mnOzly60dpFjz?=
 =?us-ascii?Q?oQ5LfYOlvQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
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
X-Exchange-RoutingPolicyChecked: XXa+jYtwkC0F5Wkn4iy3i+3GHt2p/hELqCdCXHYyFyUhWpj226cr6T6G3RvGeSwp9wI7BE2KGANsTIGn6x3dec3ppFK73hbQJWud80GJfeGxGtnWATRja/KTvDFssz7Ds1LNIkewEb2nAsnPf9lG56xDzjSPO11HiUldMDIWRioZ56s5ZWkD300Vdr3TsXjGQ/laU7M86Vz3b4M6WzN7VWoHfnQGCXOMmNz9IEp9QtE5usB4YYksuwaA8WD+FDutTBkOkcOgrjbDSXMrKkClB0plWCJbMXfkTJgBNoFWR4tClvtNQz+rggl9MLBHT9jHuEwyKwFA6vXKVCO/t/RK0A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6982.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 723f503c-9fbb-42ce-b269-08df39733fb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 06:25:26.2457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SIWA4sEHWsW0ubPknqzfwZzit/YwK2xskddrRap7ZoWRirrPe1n184aoTbdXDcGEx45nwUNbrqCEy+vACGN0kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5923
X-OriginatorOrg: intel.com


Why not use original topology_sibling_cpumask(cpu) if snapshot not
available?
> -		siblmsk =3D topology_sibling_cpumask(cpu);
> +		siblmsk =3D sibling_snapshot ? sibling_snapshot[cpu] : cpumask_of(cpu)=
;


> - * Return: true if success, false otherwise.
> + * Return: 1 if successful, 0 if inapplicable, or -ENOMEM on allocation =
failure.
>   */
> -static bool __try_group_cluster_cpus(unsigned int ncpus,
> +static int __try_group_cluster_cpus(unsigned int ncpus,

If use ncluster as ret: >=3D 1 successful, 0 inapplicable, and -ENOMEM for
error.
the code should become simpler.
>  	ncluster =3D alloc_cluster_groups(ncpus, ngroups, node_cpumask, nmsk,
>  					&clusters, &cluster_groups);
>
> -	if (ncluster =3D=3D 0)
> +	ret =3D ncluster;
> +	if (ncluster <=3D 0)
>  		goto fail_no_clusters;
>
>  	for (i =3D 0; i < ncluster; i++) {
> @@ -392,12 +477,11 @@ static bool __try_group_cluster_cpus(unsigned int n=
cpus,
>  		assign_cpus_to_groups(nc, nmsk, nv, masks, curgrp, last_grp);
>  	}
>
> -	ret =3D true;
> +	ret =3D 1;
>  	kfree(cluster_groups);
>  	kfree(clusters);
>   fail_no_clusters:
>  	free_cpumask_var(nmsk);
> - fail_nmsk_alloc:
              return ncluster;
>  	return ret;
>  }


> @@ -442,6 +526,7 @@ static int __group_cpus_evenly(unsigned int startgrp,=
 unsigned int numgrps,
> -		if (__try_group_cluster_cpus(ncpus, nv->ngroups, nmsk,
> -					     masks, &curgrp, last_grp)) {
> +		ret =3D __try_group_cluster_cpus(ncpus, nv->ngroups, nmsk,
> +					       masks, &curgrp, last_grp);
> +		if (ret < 0) {
> +			kfree(node_groups);
> +			return ret;
> +		}
> +		if (ret) {
>  			done +=3D nv->ngroups;
>  			continue;
>  		}

There is duplication for "done +=3D nv->ngroups", my suggestion:
    If (ret < 0) { kfree(node_groups); return ret;}
    elIf (!ret) assign_cpus_to_groups(ncpus, nmsk, nv, masks, &curgrp, last=
_grp);
    done +=3D nv->ngroups;
}  // end of "for" loop
