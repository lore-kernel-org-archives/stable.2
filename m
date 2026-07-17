Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F0B3328FA;
	Fri, 17 Jul 2026 08:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275251; cv=fail; b=GmCSyQdL+rXvYhIdIaekm37fzU3sK929a267m8ydYaIC4/NcuP3r8lCLAchxp1jQkSfIm4W58CTzv4uwjQBh2diofao2IjA+hSf5FnD9yqlUopvOEPVX3UXD7DfkeD18E1VVqBYeikL/Gxs3gsIbLM0cfH3a+pc1KbBPT8HihiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275251; c=relaxed/simple;
	bh=ex7LqQkNtc75LMZkz2zFxLQrQg3D3NgR6YF1IH1v0xI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b6rtX75wK52r3n2LjiETT1mE71sETgOhr02oeXe7a7jT5OphKmWjGQR76kI2w6f5E3kyhcnnIV7kSR/7xvUsDSx+TGwJ/XiZnVlIOzl4KJ6uPGjf4iPzLKGKWVXOUNPVH5KbSgvhp0fQxMFhh3YQXmHoXVdu6C02GO9h8Tydwa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EG2wfPtQ; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EG2wfPtQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784275250; x=1815811250;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ex7LqQkNtc75LMZkz2zFxLQrQg3D3NgR6YF1IH1v0xI=;
  b=EG2wfPtQaTlpxPSrqlrTrrgNXH0ULneOdAW/h8GuWMQDcWvyvkyNtWrt
   6qG/+l860znkobg7ng0qLrCOlTPhhNn/1m1KPh4G847Xkzs7OXFlPhc+4
   +xXfSyR8xBc7fTbF/mgvAw4k28RhedaYallWYKsfm8USAAFfd2OBnjIiT
   jRCRIUEskYD1aoeys67vO+tWeIODwMC9UQO7hiPfmPea0qadoleIslFFV
   Xy7kY1qFqJsuOmJLGDnGHc3/W4JTg2sr6DcBU0AOd2AflfwKKHGrIQDzd
   YodwEXkadFrwUIpPII6zXH04OkIpN6f0L1/IhddINMFy19ZXDb4T58lb+
   w==;
X-CSE-ConnectionGUID: UghuNJhjRkmN/MQDeORAHQ==
X-CSE-MsgGUID: zHDSYY98R5uQfELWSBlEWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="83927688"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="83927688"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:00:44 -0700
X-CSE-ConnectionGUID: tM2PBFUNRse2km3hl0B/dQ==
X-CSE-MsgGUID: jHizv9b4Q2uvTex7pbYoCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="254950642"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:00:42 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 01:00:40 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 17 Jul 2026 01:00:40 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.26) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 01:00:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QvAI1T3LG9oekBY35tXiIlF+QcURI/hWEFD0tbzdC9OUZPAWuM3pRBaRdWFYeJjcFuATNIXqORIK6gwtVCZLYx5MH72KgtV8e0itM9tcPVCyHB+++BHXiLT5xT4j0irI9H3YmVgw2H3lJgs+uriYqlUd8JEOxSY8FBkAJxUwIIZFhPrxoPD7GrPCWlu9ZfUHTZaKHczdzFgS3iBIWhvzEtgTZmrGhmfekb7ySt5YUDP4bHKjMUCQKPgUJ8IL33NdX9I881lgz0/ut/uyJnNGB8BZ7KQug6xHq7VT9G8jmur/SuexYN4w0Omu6kDLvPESHUbP8M3tzCwjb0xiJSL6UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rv210SFYEMRFW5bV8xjBJtWOZpPoQ4DKBxPJlWPGvwI=;
 b=VuNnGNAjwBK6Vwzg8irw1ZAd7hBzZW4/bPocwyZxmBZJhVlgZaNXgC6Eolofh+j0mHcvl5qOZa/cN2s0bLy7X9oVFKR2SyuqI8KzqNpyvJ/I6spR/BBuH/1kY0lfnJ01xgwUxQ1xWzb7zZcvdJoL7bscHhNk+ovVSJYJBQz4KpspIYC6vBcIu/Urm9AiTxkhKtDOKrB6ixQ+GANLC0io4c83ttqRlDYPuR9NYFfNExt7pP7CZug7E4l6h36Z7ck/dZFoE42j+459hJ2qtZ9WY9x0ZApotAeeOuwcnOgHdr7nZDoUOyp3KVg2mlJZqhCEjomNo33oo1Mr7vQAz3b2Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA2PR11MB4844.namprd11.prod.outlook.com (2603:10b6:806:f9::6)
 by BL1PR11MB5977.namprd11.prod.outlook.com (2603:10b6:208:384::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 08:00:35 +0000
Received: from SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::61e5:7b38:b8a4:1abb]) by SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::61e5:7b38:b8a4:1abb%4]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 08:00:35 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Peiyang He <peiyang_he@smail.nju.edu.cn>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
Subject: RE: [PATCH] iommu/iommufd: Fix IOPF group ownership UAF
Thread-Topic: [PATCH] iommu/iommufd: Fix IOPF group ownership UAF
Thread-Index: AQHdFBI8V/YFzAQRO0upS1WRBF9f2bZxWYfw
Date: Fri, 17 Jul 2026 08:00:35 +0000
Message-ID: <SA2PR11MB484486F27784FF0AA0C2D7858CC62@SA2PR11MB4844.namprd11.prod.outlook.com>
References: <B4F28798E2E784CA+d29f723c-b2b5-4b67-8d1c-4f7b9b0b27cb@smail.nju.edu.cn>
 <9BE255A7A4AB5AAA+20260715042421.3148159-1-peiyang_he@smail.nju.edu.cn>
In-Reply-To: <9BE255A7A4AB5AAA+20260715042421.3148159-1-peiyang_he@smail.nju.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR11MB4844:EE_|BL1PR11MB5977:EE_
x-ms-office365-filtering-correlation-id: 99a5308e-89f6-4811-c633-08dee3d97bb9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|38070700021|10067099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info: E6GEtyqU6+OyeoqzwQmXcmsdfxsbgfzqMZB5WiM+BnJuIi0AcO0CHq0Svz4V2RpMulhXDbMeEPDkeoEOS+WDsx3Q9p6B9DnVXH1kHwK3lfalMT3m3wfPvowEzpM1/BBDV8KzZFauv9AZkipMfXon2Ae3heAiU346yxXox7W0VQFrEh3xQ0y/PJuPkGuEY1GAkVaWFSzn2fyMtQBPUwojhSykJ5UfdQMCcGjCp3ciqgax1DCXO+LyI6SySWdkfSBWRNu8Rq8q9lMMangA5KwKqLiFh2SkOYeZ3oKlCQnUmjO9a1rGa+/b/PursJSYnt8wuVA6stmJ8xInCyULfnnNM3Tiy+SeSxk1G1qftDQnGYR4R4RB4BlK3vjkPJK8zPlkYPAOlhtNjigUNpTyMHEpNwEx3dDvbE9iHKjmeP9gevRZ6q/qfUcACvNzLLyh9YDPOZKJQYhN0X8u6TeZjvXF0JBGEJzFHTfPAsDMkOUE4XPQVfLPAmO7WbEkysZjJE6NXoRia6J6RbyMJnnvuJ3qBnzAwf6AdZ/VCJvov+ad6G8QeiYqdA6YruFacXsEodbGUfjjk7JKb5qWhJt8Wh800GMlZGBRirhPJg92tycsbLMrsZHyH36I/XvaqFOk4l0a61PuPsAh1Jxtu1N5gp6BDZtqSIKbaHwGo87x/6/gHAmaGa/XRNPWBk7JWsYrQ9zqUD6vofrkJrBubd3bj28gxyJIxpsv97gJQYA0zyiND4g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4844.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?go+n0blrDl1MhhzHxZFQn+78rGsvI2cOiPwSRgv7p+8kRSSudA3aw2OJQyR2?=
 =?us-ascii?Q?q+/Du09P4Dcc+xM01srqKFPNTU5mKHrY9cS4jRFCJWJCW1g+RiH+3goxFWiR?=
 =?us-ascii?Q?NxdCq2BaQEGXV2tgtJTDq+PkufQl7XlozMvMGx9pZaX0hsmqcUTCEXrUg5hw?=
 =?us-ascii?Q?9Jc7AFohD3V7AFw2DTok74Iz4YAixPoz6vxK0fmApm7csQ5Fz30PjEZQ1XfL?=
 =?us-ascii?Q?kKRZZEaT5oNFimac6ko+vJz1VQXaRKizlYMxLQeOfLZx5ZRp0lfgkCutml+Z?=
 =?us-ascii?Q?Myck6SQnOYEeUq7e3ivZXFZi0iTEc/sOFAZZpLMAGT23SG1MPbTAP8HZaWuL?=
 =?us-ascii?Q?J2ptTj+hpkwnKzytMsOuBonJAmNagRlSmtNNp7W5r+7sCg8djQU5Ug+VTBH+?=
 =?us-ascii?Q?Dsrxb0y1jopE/IkcyHQlkdZHnPILyrC86bPdrnvf7mGaDoQHyjoUzOl2PdQs?=
 =?us-ascii?Q?3r2BsU0sDijURc1pnnyytkkU5AX669C+LS4W+dO3K4KxYtYSS2jzcVaFHiOG?=
 =?us-ascii?Q?DbqB5nlXX8R06Y5h3A+GpNzbBO5cBfIA0STFf32UMvuL5fbafDpi46si0TwX?=
 =?us-ascii?Q?rbkdiia+TkoUukowJRZTEhF4LPnE0RriO2Pr2XBHk47qNeD/8LzBtcrj4+5c?=
 =?us-ascii?Q?WGqTCyUaBXSrttUJ2aKntz2mDEkHgkpnAH7oseHOeDPA2w4OABdAZbxM+euw?=
 =?us-ascii?Q?473Np0LZIIVcW2H/4xnvmzboTwWZOU+CMAAUeVerCWP0jle5XS0+l4jZKVP+?=
 =?us-ascii?Q?xZIgnExIgD3nvvHZsxY/xfQuvkzGwB4QqZSz97JmbUHqCNRpQF/UfcdmrP/9?=
 =?us-ascii?Q?yYtG5hN1t50u0Tf0NE4JZzdkGXmdmgxWsg2sfy+y1d6ov5MnhxG4jhsHhWpA?=
 =?us-ascii?Q?FEC7pPOHpNFf7ZU9DXykZM/EfOJcoUyy2gz/sZCFQ4Wyy+OG0hZ22cCrMOu9?=
 =?us-ascii?Q?PBEw3IwvPfGIZBrjJY8UB7biFPevuWcC2HJ1S8m1ifigbpV4xKRIZR4+f5Sc?=
 =?us-ascii?Q?22jm9SgJ3+hvAIO0+QvLKkYgg1yBryhwu2x4VaedoZRND0ULq1RY8fBx2jG7?=
 =?us-ascii?Q?BlOmNbtfPgrNQ1NsJ4cZRdyN8h9Sx0i/oyOlhK8WxQUQYcXXxWNBlL+nXSqN?=
 =?us-ascii?Q?7pMgY1cY7EgXjlCpOt7GxhZYksFT9T9d5y9k/jKANVZ6X4MssJEcvPLgKFR5?=
 =?us-ascii?Q?mQEAf02ApYYFlidgXTNmhP6LJ1fJ9FjrMqD6rKd7bLgr68gzQKHSz3smNPx2?=
 =?us-ascii?Q?MrqNuq51FEC45RJc1WQsO2nr8i8InXtso5BfI+StBDxdWX1H1xQpiu8BLgWw?=
 =?us-ascii?Q?01EVVTHGQwpnRfGcZ1U45bo0Zv3RGT3qBZ9y8XCBPRYKrJe/8ANJ3Wqfsxnj?=
 =?us-ascii?Q?+AHjesqtwxbGqJtsptDluRRZs8s7XlCZzJhHRIiexXbYNt9yVenP5x54g+cQ?=
 =?us-ascii?Q?anFALY+0RqJ/WUmYiO5GnliIe5Mr3NAtEKB9/d61kWvFsTK/qm1hWlTjZ9ln?=
 =?us-ascii?Q?znWDB3M3N6wF1pxvb2PqSunnF1X8iSAgWrerc7BI/XO76h9Ek2SNqGj1DwYG?=
 =?us-ascii?Q?FizyzkKZcSDbe5elfnQFY1oQ/vqWSeSl5nc9Yr4wK34QAiK8jQQggL3RJOAu?=
 =?us-ascii?Q?IRCckRHfQP5GCTCo2VI6P+bjyyfgN/Hcfv/lc5Z08BErCsX+1zr08jRt5tMp?=
 =?us-ascii?Q?l+JX+zHsDPk0S/GeTikoWNpZ5jUoPzyeqp4BnprTbJwyHGm7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aa8a3MASXreLaSnXlw550rjwf6ujYLzibi0EEg8DaqsLJxtwXTLqsv6XW8EZbGPNLW41yfnCTSmpunYiOp091xFn5hz9+owsOHpDOa/R9ZIwL3UaFKg0gNmtbGZO4QnXDdV+jdB+YW4aumLg72KCM0S1ht+iubO7B0KfrbVOMY6VBBqrdwQTytjDuhQSoa9kD2yWptkVEPXsIJwYKGmdgSqKgja3ZSbqCcHdb93YbeV2rXaRa4mkTxJiw5uvzO7I2nL1A1sQZhfUCUsTrXQhf0JptvJJ2BdxL1MgaMLBcP0A8u74GX9vuLkh7Ipv9l0RUlH6yYIPoFG/xP7sM1O4Ew==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4844.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a5308e-89f6-4811-c633-08dee3d97bb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 08:00:35.5784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /JXjKLOjs6JGKPt9HbOGAkp7QzrbZg94WDu0p0AlJ3MHsWo50UaXzs6Ise5jhlM+ytsravi9ag1VEVsI6IMiNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5977
X-OriginatorOrg: intel.com

> From: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Sent: Wednesday, July 15, 2026 12:24 PM
>=20
> iopf_group_alloc() links each last-page IOPF group into the generic IOPF
> pending list before invoking the domain fault handler.
> iommufd_fault_iopf_handler() also queued an accepted group in the
> IOMMUFD deliver list without removing it from the generic pending list.
>=20
> When detach or HWPT replacement drops the device's IOPF reference count
> to zero, an IOMMU driver may call iopf_queue_remove_device(). That
> function responds to and frees groups through the generic pending list
> without removing the same groups from IOMMUFD's deliver list or response
> xarray. A later read, response, or cleanup can then access the freed
> group and cause a UAF.
>=20
> Fix this by separating response state from generic ownership.
> Add iopf_group::response_pending to track whether a device response
> is still owed, independently of generic pending-list membership,
> and update that state under iommu_fault_param::lock in a helper.
> Before publishing an accepted group to the IOMMUFD deliver list, call
> iopf_group_take_ownership() to remove it from the generic pending list.
> IOMMUFD then becomes the sole owner responsible for responding to and
> freeing the group.

this is ok but could be simplified.

There is no use case in which we allow a group staying in the pending
list after its response has been sent. Actually every iopf_group_response()
is followed by iopf_free_group().

so let's just remove the list_empty() check in iopf_group_response().

better - move iopf_free_group() into iopf_group_response() (with a special
handling in err unwinding of iommu_report_device_fault()).

> +/**
> + * iopf_group_take_ownership - Take ownership of a group of page faults
> + * @group: the group of faults whose ownership is transferred to the fau=
lt
> handler
> + *
> + * Remove the group from the generic IOPF pending list. The fault handle=
r is
> + * responsible for responding to and freeing the group after this return=
s.
> + */
> +void iopf_group_take_ownership(struct iopf_group *group)

iopf_group_dequeue()

> @@ -582,7 +582,7 @@ static int iommufd_hwpt_replace_device(struct
> iommufd_device *idev,
>  	if (rc)
>  		goto out_free_handle;
>=20
> -	iommufd_auto_response_faults(hwpt, old_handle);
> +	iommufd_auto_response_faults(old, old_handle);

this belongs to another patch already queued by Jason.
