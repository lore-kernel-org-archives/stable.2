Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09EE3D5679;
	Fri, 17 Jul 2026 08:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275496; cv=fail; b=qhqAyKxO/Pdjnz+xsc4EFn9PZ11ipVczsyh/fhzLuw1uYtg1GAxHMyTp+QD3tBdR27gALbFhevZ222REvXl33eIv+Rxczruesz+DQeq4TZO7LEzK8RRZjksm3e6qb5q2azirLV3QY5YGGnOOMKb5EPmgiSOIxmllLqBIE4AxS7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275496; c=relaxed/simple;
	bh=Nvci3RTk3Hbjik50nZo2oxbfJYFHW2aNv1KBQFzqHow=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dh5aIn+E+twnW/rAvCOa8vjaNGO2sucyUwUuRvKlILlbNCVBG4s1XlZoR4eLt7zgG5PUx6W7bfHfxip6t+Us1pHYNQGfzy9+dbXNP83j44keRs2X6eE+Pevn8Q7pGObvFPAEU00q11mI8eZPzbMuMM/aqYFz79bGvT4KeSB5FKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=arWKm1Gj; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="arWKm1Gj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784275494; x=1815811494;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Nvci3RTk3Hbjik50nZo2oxbfJYFHW2aNv1KBQFzqHow=;
  b=arWKm1GjoRr17S8x7Bywwz5rNOh074OE3Kc3+BKxle42SRM/pGV0oiTU
   6cHvaV4nbf/HUcUIQGBz2dZWXuwohmWrRglUu3oJhwZC2NjM1SZ2SYOZV
   5SeUtldJfEF/NGQzJh3eoSnJI4k3Ku4WDOYr25Lgyv50tCIzZcbW64jY1
   12uO5e+DC88ItI5H/mSqy7fJvqVxvqT1B6PDbr+2QLFwAmr6YTgOHrtfD
   6LQX6rFlQiAJUpWhUoPU3MZHuAJsqx/0MzeanfFwvHYW9yzL1CSzSy4x+
   DeHLqHaOQwIfX4ZxaMP9Oytb7SGQV2WPeasDyBsG3Ccn1ed07QCQkdlmD
   A==;
X-CSE-ConnectionGUID: As0+3qOoTwalhNXMzdnOow==
X-CSE-MsgGUID: iTdYBq7PTpmssGOG4WyfSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="110494825"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="110494825"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:04:53 -0700
X-CSE-ConnectionGUID: zyEVTjckQSmwaIzsZuF46w==
X-CSE-MsgGUID: qIOpMVffS7CH8xe11jMfXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="260543687"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:04:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 01:04:52 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 17 Jul 2026 01:04:52 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.54) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 01:04:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dIRNf3cBwq0JhV1y4JE9Em36RzHgX4upMpJkWaxrP1digWHupVFuFwsjTnAQKgnkH89qIwUukHRKtDBwqEnB/LocAS3fbbQEAOVpFvI3vV7TWlcy9lE9Ad6v/vElcXmpLLkccdCFCuArnqATHmd6cOf060BU7gm5VOgIZJ0S5kLg8XrafqbZikVZLyum6axAakVeCchAHHmhoWVeJa4DiN9al8Ol14QU5Af28xEHJi6/FNyfSfQz19xKolY5DtyuKx+dusurEmJhzii9MROTlCvpCAylCWXtcpUUZG858nnfef4ZkVtqgPfJBDdxtwcx0aMHWNjixTmXyWrh88OCZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nvci3RTk3Hbjik50nZo2oxbfJYFHW2aNv1KBQFzqHow=;
 b=IKquoOxBg4O+s1tOnSm5iE6dH3KPeFNPxFSqKRqbvOfOH5O4AIwhucLjudKDnuwSshXuVjeCYiEDfx3wJDTrKRFhL7ywW9+L8J8MP3dJE6zHYl3m47qQGTK0IQSlk1lZazDs+fp42dBIXQHNImxJQD6zxtTP8ZwcCzFJKkD4enNHZBeE9LfThHQWuyUIQ4jBHIP4R9LyIiGl1eeaQW5QV3canDiId9n6rJTa93V6Gq6VupDDwl752urIPMoLY1YHwY7LFjpTKQffltEPCjX9AC+go4CPXEsdFoFjZnYC5AT9W7Ew1fPZAgzS/HJVU8wC5p/cWo6DUSu0+ubcPPlCKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA2PR11MB4844.namprd11.prod.outlook.com (2603:10b6:806:f9::6)
 by SJ1PR11MB6108.namprd11.prod.outlook.com (2603:10b6:a03:489::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 08:04:50 +0000
Received: from SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::61e5:7b38:b8a4:1abb]) by SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::61e5:7b38:b8a4:1abb%4]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 08:04:50 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Disallow SVA if page walk is not coherent
Thread-Topic: [PATCH 1/1] iommu/vt-d: Disallow SVA if page walk is not
 coherent
Thread-Index: AQHdFOa0FvFgbaeXBEWqE3gQxZHchrZxXAcg
Date: Fri, 17 Jul 2026 08:04:50 +0000
Message-ID: <SA2PR11MB48448EA1A7F5B93742920DE58CC62@SA2PR11MB4844.namprd11.prod.outlook.com>
References: <20260716053554.1642374-1-baolu.lu@linux.intel.com>
In-Reply-To: <20260716053554.1642374-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR11MB4844:EE_|SJ1PR11MB6108:EE_
x-ms-office365-filtering-correlation-id: 866e6ce7-88c3-4cb0-8ba9-08dee3da138d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: FuA0pQMSkrIgU6hsy7vutcMnoQRP1i2KsbK8FVfZ+1Ix0xyxC8Yn8rmlppKvfNzudJ5rPeH759WV0YkV7C8Xw+DVeZVCBV51iSyYff1T3Jbz8OXlFRjVFjtv40fnTbvg5g43AhE9wFdAq95T5bkczkhaZuj/sBtKrqU8XfAkFlUAIqI3Wq3E7EdmkP5IBPNNd2NxMfLIDTKC7X6skoQ4zv1777JW6FkaIYnjQUaDJItwLsqd9uTSHaZsLCxL3+yVjLOautNfqQbQh2k6BfqFwmN5k5/FMwP6/ZUg/R/ROCxnn+g8uVTzbDv6ZAPb4aaIzCroC8PCzVi1ezv4vM1fpU9mYm4P+afAiie+SsnRMEfZIqIYD1vnHsqTieVNxlPW507X87541pmKtIhBDSdo7hC6WJ+wHdIL2O1LGKQHjm5XNj7tgtf7CwFlgCWXhxguovMiSIMQO/eDRGhIth+rYH17vk+8ZwG+U2g7hnUksml7ZzWSy7CdM6ELvVV/xSkLqbVY8EO3yQoAteQAZ0LsR7vNKJCiUF48fy5qf2KWJfYwjSL/jcdVxZkbghWQzDdQcSNnrEW5tKvr+5NGfoVIaklMMjBmtKMG7MoL69d3IVQE8vBPYH5/QHEAoGM+FhGnvURU07ZvhfXSGXSg+XhzBtXr/thcTDUTz8ygtp8CQwlmL3M/rAoIQsySAVJYpiYzDgs6nrXr5mdeBNZgokXKK6nWHIM+RAwecR793mvJdos=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4844.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Jt2Edmk+jVSW5Kpg60fYKgo/uqHb/4UJ35At+2zh+ORaYls8lVhX+PWC1nZO?=
 =?us-ascii?Q?VLhrIPgUpackHnqdLLzaLFYUk80Cf54JTEwqrBAufF2tf1ziMQer8gLk0khB?=
 =?us-ascii?Q?dKBNZ9sJk8xqOmJth0t6NFdlT93y/Ehj/LngX1wJ8SbjcVj/nhHnPPkTWlUk?=
 =?us-ascii?Q?Pg6fMa2uo3NlDEwt7aAGD/NnFTLosrqhmssfvsYppMLflNVBS+zFLlUS/pSE?=
 =?us-ascii?Q?Xueb6Lr57QcihhY9DNRxXL/4R0IsJjSY17oLlHA7kUcf1UqAD/b6f/DKmDqH?=
 =?us-ascii?Q?ldpz4hEj2U7bBkgdUwScb6jUBj3iFLiLTnEc6W72YDuozXHzD/CefDgKYkFd?=
 =?us-ascii?Q?TmS4Ep9x9Ee//49Twi4ZNqoQQvPV69eFy1yBJEwRK3IUOtvlBWvm7kPr8Bzh?=
 =?us-ascii?Q?jdXRmbwnWd8+7FIcCL6y4Rj8PAVotlhgWWICu42eRksZ6ejdrcnhQC75NamQ?=
 =?us-ascii?Q?l93WNEAGoE9Y8VGGqS/ZMmr3paS9Pj7JT/q9SHfHKCJq4rswSuB5H1B4jCgh?=
 =?us-ascii?Q?2kVMD31A2p3q2819W67+gNrHqxR1T/MKQdpninAlD4THpQA1u/b1oE9et7XO?=
 =?us-ascii?Q?9tj8DBKJ+BzvzfUhS6kNCRhKsW2J8fPhLuBnvVog5tHY3w1eLQdj4wx1okL1?=
 =?us-ascii?Q?ZuLCJ93J8ljqplt8CR/CtGgAsIYbx7y96Sf168IpBeKbM5m/ZhMm1rJga5c8?=
 =?us-ascii?Q?V22RZuy68B3M/XOS9U1rqlQdXma7yAkGVwmTNKevpJuzZ/WVjOaPgwI5dzLH?=
 =?us-ascii?Q?YKQMZmschAHa/fkm1mU67AU7W5fn3VmFUou1avPW/j08fTDIsJywHAAOVne+?=
 =?us-ascii?Q?gJIeglARO6ebYFsvAGAH0o9PEcpx/0uRJqh9PuGhSju9wCOquWyfqH9Sy54L?=
 =?us-ascii?Q?ATW4vvWau7yhrV8rhGZ42/Pv0zwoORR/9BbYr4eJXBH0Rf2NShX/gGfrRyu0?=
 =?us-ascii?Q?CH/ZwvyweCjnL+cGpsCbS3+Gr6wfq4qc9wN23kVC54hpuI+aLeiOIatlqt4B?=
 =?us-ascii?Q?jFylX/pUSLFoid6gYOa4UW+1fdp2GNMW4uDtrya5L2t3rE3MltqfpD0VcH3K?=
 =?us-ascii?Q?C6miN0dI0+KbBrXyh0unWqaYYfA4XuCU3hpot4SOHWV8btU5kN7/xUlx2quj?=
 =?us-ascii?Q?1ZKLG9eNg775JjNnh7fTOnMKn+1Xu67ReqBQ5mMNgM1SSeDFfy5Q4TrlXHnN?=
 =?us-ascii?Q?jL9jb+AnJ3OxsZXaEorJhJNdLgnZcKH3dJLehYNc0QoTmwl7m0ufjJpfo5go?=
 =?us-ascii?Q?Yjxke1GdlV/MxFh/KbqkmDOlM/WQ45oSOndF/FbFnunWi+KtpHrPRlOQhUGq?=
 =?us-ascii?Q?YKu6lEe4B2IkAH4x6vEHBaVxRJ91ZYNNA4H3Wg2hB+5+UlolxxwIGRal3ldG?=
 =?us-ascii?Q?nkX/bRPo7udUVSqBJntc6l/bRGIVdS7okRmLvl/TWLHKR4VGVpIIrxJcOyWg?=
 =?us-ascii?Q?UcsWQpUHoYbPp58Q4Sgi++11TSocLLfeZaJpEA6n0cqcjNeydyY5mNZ4nHGG?=
 =?us-ascii?Q?KWJTuaR7owSUZ6jDutWR2ifUGH2/iAUj3Fdypk0TqU57IbVwA0yXj8q1/2pa?=
 =?us-ascii?Q?2fwJ75eDvxoZUtSc8jE3qk016AFGzQA1tAEKMBvZAgYkuyTLdKoyyr/UvV0J?=
 =?us-ascii?Q?FRtjQudMCPlhiDl25IckVapOVbtXeNAGy4dwE1rE9sqJ6JccTZQ0V+CWHa/A?=
 =?us-ascii?Q?sacLAEttSvIAxH0E370PKZ5m8ddJyCuuFI4Z6E8Vtc+7ko+8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qJv/bQpw/SnGHodtca3b4fW1/CgEPkQZRVmn72rGalC/xgha8OON8bQGIaTdsWjnHEdoaMoSZxY8PmGNrfDtjpi6GI3tgbh4s1BA0VcjASSmn0FB1Y0gJUW5TXur9bnZNwRVueUD4wNtH/GL3GRiilEgCevZCiYq3LQwdW7uiSLTP0h3hWukTf47UpscIoGEHFqozS4lhryN6knlRxTfd0uAjedcaxzX9GidBdV95o2A5Tf8eNPMGSMW6Cd22XcDlJpKAuPr4YKjBKH8+SR9NO2iErLcSJYreTkd/zZ1FLEh5LV9nrQF1JY/7wcCzJe7xexbW+Co91oeNp3/1gcycA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4844.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 866e6ce7-88c3-4cb0-8ba9-08dee3da138d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 08:04:50.3035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UekGyk2DiBP70uHLQE92LNUPEiZdg+oItNrBQJy6Ji4yTrNRc+MtosGv2DB1KWVDLZwAYiQlBR/qKeBVWuW0Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6108
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, July 16, 2026 1:36 PM
>=20
> Hardware implementations report Scalable-Mode Page-walk Coherency
> Support
> via the SMPWCS field in the extended capability register. If the hardware
> does not support page-walk coherency, a clflush is required every time
> the page table entries (which are walked by the IOMMU hardware) are
> updated.
>=20
> In the SVA case, page tables are managed by the CPU mm core, not by the
> IOMMU driver. Because the IOMMU driver has no way of knowing whether
> the
> CPU page table management code has ensured coherency via clflush, the
> driver must deny SVA if the hardware does not support coherent paging.
>=20
> Fixes: ff3dc6521f78 ("iommu/vt-d: Fix CPU and IOMMU SVM feature
> matching checks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
