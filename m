Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9E13BAD80
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 04:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780548867; cv=fail; b=jtNZly60FoSRBM3GCgvaebXnfF9dNW71ZXlMOd/3ZuSeM0wSga/p2FNy7vzMTUHn+4hstYSuNNXrWsP74xTKlaawyxEal8WdCqM2yVai35MFzTeT8jssCE6pNZ7wTtmAQnRlnc+xpZuJuQULZxXUOaSAD8auzzdm0AZ9w1j4RKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780548867; c=relaxed/simple;
	bh=s5OMXfH5qyMVTt/GwVIU3lzcVsc1CKWA9OOAPbG7h6c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SX/neDTU3ZRTRoaulMpZm9pdQxGqRU8/LRYjEc2xtIYXpJn4PwU1fPDc1Qk2qC7oKk9igGqRgAfleY9a4WsmgJ1qtya3A6PTs5y/zCb4PIgT2PKbBmFhgnYk82jylbzy6mPCgA4ofg4GsB9/sBdXJOp2tfNzIYcGFjo3SR/jKR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y+BpQecz; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y+BpQecz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780548865; x=1812084865;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s5OMXfH5qyMVTt/GwVIU3lzcVsc1CKWA9OOAPbG7h6c=;
  b=Y+BpQeczpk9CcU75qm/r7mavsJOo5uBkj04SRhIMxRG+AL/hgCEAZsYM
   3hly6b89k8cSoXfL6bsXq6Inv5mGcgsjViZqRq4AxovCwQjThwO45UMVi
   dzMZjnHARVFq52glE6xaee1gNoM2tHTl97E9xXgZMbzEYcL7Abw75N63s
   rDzy2skFQJLyTo8BjSgDIMT9JRFYawWlbHILaYCLkoryk8BE/x6KiQFkO
   BUDW/xxnThm5IUpbIWygXTfDZO/LJaTOcCUvadQVQqyMQrNGAWpDi0O7+
   p5Fqx6ketLYTHyqN4PgqZuKTq2VmkVSsBPlA3oOxqHjjsiqc4UIX1Pe81
   A==;
X-CSE-ConnectionGUID: XN3++7VpSQKCX0hCm5zukw==
X-CSE-MsgGUID: /HoAXo/ZQy2VLkBAOBxDow==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="92477622"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="92477622"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 21:54:25 -0700
X-CSE-ConnectionGUID: on/STb/bRteWqSd+vAHjkw==
X-CSE-MsgGUID: 6wTTEb6XTo2wME0vh78hFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="244516745"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 21:54:24 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 21:54:24 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 21:54:24 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.63) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 21:54:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PaEquw/xtYdMTZ173oLDuytVswrhcd7XO9Qn0H2f7Bu7L5NDNb7V/hzhCs86ucfvAQHmcJ1m2OS6xVsL23wH0/6QjevStEsZw+rG4DV1cMdnb9oOVaXW+QmOBbZUEjuIDTnLaaUf8BWXnNr8d3IGXK+JasD9dYJLLlM1uHs11NXk+W9tnedHtFp977dqb0nPXRjKKr5zjpnRlL50R+rS2yRNqRODJu9MRRCYEhEWftRfF89O/J7CrgpXCW6XYrB/iEtD4zJCEh/uDgWAfcQpq28Hb11FCrV0dWsxXIt8KXtga4VuKZAqr2VwNpbSxbPLjC5VIy8+mA2T7a+crHO4HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5OMXfH5qyMVTt/GwVIU3lzcVsc1CKWA9OOAPbG7h6c=;
 b=u0UTxJ5EXqIoGXha2qstsQQpxzvbq0NYB2oB3Y07LK7J2yHrtKVfYjSAEDw/kE7FpNb4pUGEJP5hxcZGbFMyo686MyTk/NeytQIlmDr83KGSrkaJoG7Xo3XTsEQzC9AKPfD25ol0PqKS6EM+Fp0EUPsYtog4Z6xg5d+siRWMTqlLUkfIFjwX7hRyulMv3/n/4mOdSCng8vW8d/EY3AGfX7FdqHAr1D8eebG2mjjRw1L00cZWED3vG3/gu9KeAtSAF8nrpVaE3osKq45b80AtrCi2dcKI+eivlMJYwh5MEP1aVzQNroVLqSXoyuAXJm1rUJItm1Hzvl+2N4gjViAOKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by PH0PR11MB7563.namprd11.prod.outlook.com (2603:10b6:510:286::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 04:54:21 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::b2e3:da3f:6ad8:e9a5]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::b2e3:da3f:6ad8:e9a5%4]) with mapi id 15.21.0071.015; Thu, 4 Jun 2026
 04:54:20 +0000
From: "Gote, Nitin R" <nitin.r.gote@intel.com>
To: "Gote, Nitin R" <nitin.r.gote@intel.com>,
	=?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, "Auld,
 Matthew" <matthew.auld@intel.com>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>, =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?=
	<ckoenig.leichtzumerken@gmail.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, Thomas Hellstrom
	<thomas.hellstrom@linux.intel.com>, "Brost, Matthew"
	<matthew.brost@intel.com>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
Subject: RE: [PATCH] drm/xe: Fix UAF in xe_gem_prime_import() on attach
 failure
Thread-Topic: [PATCH] drm/xe: Fix UAF in xe_gem_prime_import() on attach
 failure
Thread-Index: AQHc8aq802CLhkFC/EqM+Lp7FGALlLYphJgAgAAOzQCAAAYZAIAABFoAgAAN3SCABCEuQA==
Date: Thu, 4 Jun 2026 04:54:20 +0000
Message-ID: <SA3PR11MB8118C54C085BCAF117582849D0102@SA3PR11MB8118.namprd11.prod.outlook.com>
References: <20260601101536.1333480-2-nitin.r.gote@intel.com>
 <ff4a02f0-5a59-4bad-af76-3d71146f136e@intel.com>
 <5e3854dd-d6ad-4110-966e-9029ef7c2374@amd.com>
 <b9b9e20f-703d-4e43-bd1a-17d8bbcead70@intel.com>
 <157c5cfc-b0a5-4ee9-b91a-909e87df3080@amd.com>
 <SA3PR11MB8118477615C02DD99CA966F7D0152@SA3PR11MB8118.namprd11.prod.outlook.com>
In-Reply-To: <SA3PR11MB8118477615C02DD99CA966F7D0152@SA3PR11MB8118.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR11MB8118:EE_|PH0PR11MB7563:EE_
x-ms-office365-filtering-correlation-id: 4a83d405-0361-4967-28c9-08dec1f55751
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|4143699003|5023799004|22082099003|18002099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: N4zjsOn/ZwSROOuBnZB6jZzIcBUP9ocOi7Ll8r12WJv5UfCk/aLzBXloExrb1NntZs2paZMR+OWpvMNGOFlX+hwuz2ZN8kp+ZqTJuTfBy47HA4LA2DQWyZkEWJTdW8dzzSRTw3vpSDvrLERfVnP0FZQ33qgP4xPvfl95OPv9oPKCKdh7rdDDBHePS7sxLJZGLEoo/UyH4qfzajY0jCbfF1dp0I0RfbyL5mKIn9Pc+n4l/Gwm5X37zTGRBcHoUEvHKVdam6IJiObMyAEK1V0+iyoGDRY5HTJ4joz/CCwXP5ZFaPpAoRNZw0kSJMJboqPFvkyarlYX2spzkLjUr4m/kFr2ozPN0t1zNNfWHqi0X/uKAmzZkjJeeh58vtQaX5UATmSMEqiwnWfPgWu3OUl4t8njTwQW5hKa32FqOBrhFFf8s2nQR/sc9teoCvNnCjoMZAGKNYYlHhuVGPNEbDZhNZG037qhHj+uCjmeKSAtCZTwYRPBV1oED11c7tBdi4j4R5CJ+m1rQdSmbvK8b9wGXBdcL6ssymRKFFoazuKuLkmnCRfChzhOO41SkC3WxxBYxISmb7lwEDvpgx01amwM/Me380oAzlJ4Cdg1CQkyC/B4H0J5WQw6BpnzGm2E74QsK1Rbhg0kD2JbA2ARWBT+IeSvb7doafWLThPPTCYZblVjIZqZSEnBBsaUZchiy/U0oNFkbH04dWnJFKS2F0W10Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(4143699003)(5023799004)(22082099003)(18002099003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzlEd0JhcDYrNWh0QUhiN1VlYS9pcDVsc2ZOVFppd3AzaVdEL2huclkyRzVR?=
 =?utf-8?B?QVRHK3MvTngzZC9DZElvOHI4R05JaW9GUUwvbVg5VDVobytPYU1sMUVnbko1?=
 =?utf-8?B?TWdFWnUrRHhpTG9ucmJCdjJQRkQwYUh6VW54aEZVSE9EcE9qU3pYMGtJLzF4?=
 =?utf-8?B?TEVBZUJTbDd4K3YvMEJMS0NkbkY0UUNvYitsYk9ONHVOT1lIZXZldHhpeXNo?=
 =?utf-8?B?TmZBeGg0OThQMXZFVmR1dS9oOXA4YzM1MUd6ejBibTlZT2xuNVdKQXlzM0Zm?=
 =?utf-8?B?d0hpemNLUDBHSDJQZU8zN3BMVWNUSy9YR3Y1MlZLSDhzWUVqOTYzRDEwMDRt?=
 =?utf-8?B?QVIyUmx5d2lwT21LN0g5eStqWm85Q3kwQmVzOWlnN0dBWXYycU85ayt6TkRG?=
 =?utf-8?B?STN2REtCcCtzMGJJekxNejc5MVdKSjRCNmYrNldsZHU5dkNsMU8wdkxiSDNq?=
 =?utf-8?B?bWVCYllFOHJQY0JRc0pYaVBrZUpMKy9MM01WT3IrTUQrL1M0b0dlNXJONTNH?=
 =?utf-8?B?Q2VEYnhuekVoSzEreTlqWjV5NGVadE03dDBHTGNRbVU0UWlIdWZEWWdzaUFP?=
 =?utf-8?B?MzA3S2lYU1dHb0UwK2RvYnhRTEJKZXYyQW5YWUNUbTVrRkFuTGNRYW5TOGtG?=
 =?utf-8?B?T3VGOUNBK1E1aG1leXhjZkNMT3BLYldrRE9OT3N1R0l5bkhzSFhIdmVTaTd3?=
 =?utf-8?B?c3g4d0RFSUp0dWthLzhZQzFzNW5Malk1WldPVTJCbjZUVVRMcmp0QlR0R1BF?=
 =?utf-8?B?RW1FYnJHbUVRcTJNVjY2RlNheHlVc1FjYlBzYmlCNkljSVRBeUt0REFCeGls?=
 =?utf-8?B?ZFE0MTBTd0Y5ZndGelZtWnh3eHJ4bWxMeFdsSFVPSklpa0Q2M0N4VWVPL2s0?=
 =?utf-8?B?S1FqSWxZaGxQNEI5K2dMbG42dGtUcllPTzZMUGZJck9YRnAzSytYWGt0S1lJ?=
 =?utf-8?B?OEJDSmtnSno0N3lGOE5vQ3BlejkxRmsxaXpSUndrNmVJQ3M4VWtPQzhlaHZC?=
 =?utf-8?B?aENlRFpOUDZydm82MWxNdCtFTDMxOVMzckw4cjc5QjluU085RzB0RnFMRFlD?=
 =?utf-8?B?c0lVcm9ETDNCUXF5N0pOeHRTVjJ2MFc2K1JTaVVLUE1LcFowd2ZlSEJqSTlT?=
 =?utf-8?B?LzJYdmlPdzducDllZDJnb3M0dEcveWkzTnk5bVhmWVo3WFZmUnVaQi9oRml5?=
 =?utf-8?B?UGtlSDhlcXZXNUFwc3JxU1cxVGYyQXp0R2ovcjdZaHlXa3VvNGs4WEhWVnYx?=
 =?utf-8?B?VTU1YXFJSXBJTmozeVR6eHpyR0NiOEd1SnIySThBZlpKejRjeDhBMUdkN1B6?=
 =?utf-8?B?cnkwT2RXVnhJYUVWTnVJb2c5OUhJZTZaVmNwVUJ6NHhyYTFJWVNDRStxVldD?=
 =?utf-8?B?OWRXdDBwN1hRalJnY0U0NkVZOXdDUURjd2pYMnlnZ3gwYnhaU29GdDFiMzhz?=
 =?utf-8?B?Z1BFMkZSc0RUd21nUEgyU3BYY1NmUTFHTWNQMTRLV3k4WHkya0RIbGRXUmdx?=
 =?utf-8?B?QysvKyt0eEdLd2lSMitGeG5TNElVZGJWd3VnYTc5elR3NWVQTGI4YzdwMzc0?=
 =?utf-8?B?NDAvL2VsNHI2UjlOdjFWak1FaGZpQWFVNGVjSUcva1J3eVBWS1NjelZFd0Jt?=
 =?utf-8?B?MmtOV3dtZVpJYUZEM1BLUldrZlJTSEdWQ0U5T3pac1dmV2JlaW9EN1VmTjQx?=
 =?utf-8?B?RmhlRzlSQ3dtV0dseVlmelB0MXMyamhReTVBeDZVTlhUVVNkWnpsNFM3YU51?=
 =?utf-8?B?R1M5R3hNb0pvb2lJOWZRN05CM3NzMHQ3MlM1QmQxREtsV0pyVWRSUXpVS1JX?=
 =?utf-8?B?MUJDZDlibWw1THVvcjFsQURYVkdZQzcxQjNtblp6UXBsVndDTmhiTHFRc3dG?=
 =?utf-8?B?cityRHVVSnkzd3pna1dvQlRqWGxMcHdqbExsTGhxZHpCV2t0NGExMk9iR1hG?=
 =?utf-8?B?RjRVc0dacHdNSysxNVU5dTRZVFpseVNZeC9BaXYrL0tvRXE0TE9HZ0ZmQk9U?=
 =?utf-8?B?dkhSMWRIUmlndEpYdHJuV2ZsL0pzWi9wZFRoSDN6bG1sM2JPeU1TVWV5dDFo?=
 =?utf-8?B?SC90Vmk3TFgzZzBnK3poZFpveFJhcE90ZHZ0VDBJeGp2OWo1Y3A0a0lNM25M?=
 =?utf-8?B?bndQZnc5ZWlhWVRkeVhvUUg4bVJtVTB3WEFBVmY3c29hdmVESldyN2t0V0lX?=
 =?utf-8?B?TmZTbUYrVGtNelF5bS83U0NWamxQUXVzZjZ6TGowbll6aXJ4WVh3bkdjRzlh?=
 =?utf-8?B?MFZZQjFxSDA4MkZWYkJJM1dqazZSVFgvYy8yKzR4WTZIMi9qOTV2RnlvMzRw?=
 =?utf-8?B?UTBybWNVQk51bHhXZEZRSnYySUhDQ3JkclY1ZkRzM1dvazdoTkh4UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dT8j0AX5NxE+fuQNbBTnADdmm17EDnBFEFBkrSNB+J1krWy49Z+wbjSVV/5R7fJfqTOxQLpC/PiAtZnIFSXFuST0h3OTNW1IZcTo2I74PuEHdzrftUhAkYFMV+Yy47mjlVucStjjak2sVBGkXegFZO8og6ZBWBRtU1XPdPKdDI6PyunskOKACEk1NquqDznsB0bEruRKO/dKfeXF+VZIO6xK6Y/IIPaU5Hn8jPCiLV+lYKEXZLUsuRS2h+Uaj2yiw52UnH+Rebn+eejRXaod1jpINL9o0GQvKS0sVrePH+iU1GHMfz2j+vm26vzz+4ca2MjEJO3ZQJxE+Ue79NPwAA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a83d405-0361-4967-28c9-08dec1f55751
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 04:54:20.9219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 51Y4LW0PwIErLbBtdcigmCy64snNBvE89EyRbO2ZnarzAg8UnrN+hh6z0rcv+SuDHdwXLwW++xqyOKRyjIBFqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7563
X-OriginatorOrg: intel.com

SGksIA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEludGVsLXhlIDxp
bnRlbC14ZS1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEdvdGUs
IE5pdGluDQo+IFINCj4gU2VudDogTW9uZGF5LCBKdW5lIDEsIDIwMjYgODo1NyBQTQ0KPiBUbzog
Q2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPjsgQXVsZCwgTWF0dGhl
dw0KPiA8bWF0dGhldy5hdWxkQGludGVsLmNvbT47IGludGVsLXhlQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZzsgQ2hyaXN0aWFuIEvDtm5pZw0KPiA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5j
b20+DQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnOyBUaG9tYXMgSGVsbHN0cm9tDQo+IDx0
aG9tYXMuaGVsbHN0cm9tQGxpbnV4LmludGVsLmNvbT47IEJyb3N0LCBNYXR0aGV3DQo+IDxtYXR0
aGV3LmJyb3N0QGludGVsLmNvbT47IFByb3N5YWssIFZpdGFseSA8Vml0YWx5LlByb3N5YWtAYW1k
LmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSF0gZHJtL3hlOiBGaXggVUFGIGluIHhlX2dlbV9w
cmltZV9pbXBvcnQoKSBvbiBhdHRhY2ggZmFpbHVyZQ0KPiANCj4gSGkgQ2hyaXN0aWFuLA0KPiAN
Cj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IENocmlzdGlhbiBLw7Zu
aWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gPiBTZW50OiBNb25kYXksIEp1bmUgMSwg
MjAyNiA1OjQ3IFBNDQo+ID4gVG86IEF1bGQsIE1hdHRoZXcgPG1hdHRoZXcuYXVsZEBpbnRlbC5j
b20+OyBHb3RlLCBOaXRpbiBSDQo+ID4gPG5pdGluLnIuZ290ZUBpbnRlbC5jb20+OyBpbnRlbC14
ZUBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IENocmlzdGlhbg0KPiA+IEvDtm5pZyA8Y2tvZW5pZy5s
ZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+DQo+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc7
IFRob21hcyBIZWxsc3Ryb20NCj4gPiA8dGhvbWFzLmhlbGxzdHJvbUBsaW51eC5pbnRlbC5jb20+
OyBCcm9zdCwgTWF0dGhldw0KPiA+IDxtYXR0aGV3LmJyb3N0QGludGVsLmNvbT47IFByb3N5YWss
IFZpdGFseSA8Vml0YWx5LlByb3N5YWtAYW1kLmNvbT4NCj4gPiBTdWJqZWN0OiBSZTogW1BBVENI
XSBkcm0veGU6IEZpeCBVQUYgaW4geGVfZ2VtX3ByaW1lX2ltcG9ydCgpIG9uDQo+ID4gYXR0YWNo
IGZhaWx1cmUNCj4gPg0KPiA+IE9uIDYvMS8yNiAxNDowMSwgTWF0dGhldyBBdWxkIHdyb3RlOg0K
PiA+ID4gT24gMDEvMDYvMjAyNiAxMjozOSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToNCj4gPiA+
Pg0KPiA+ID4+DQo+ID4gPj4gT24gNi8xLzI2IDEyOjQ2LCBNYXR0aGV3IEF1bGQgd3JvdGU6DQo+
ID4gPj4+IE9uIDAxLzA2LzIwMjYgMTE6MTUsIE5pdGluIEdvdGUgd3JvdGU6DQo+ID4gPj4+PiB4
ZV9kbWFfYnVmX2NyZWF0ZV9vYmooKSBjcmVhdGVzIHRoZSBpbXBvcnRlciBCTyB3aXRoIG9iai0+
cmVzdg0KPiA+ID4+Pj4gcG9pbnRpbmcgYXQgdGhlIGV4cG9ydGVyJ3MgZG1hX2J1Zi0+cmVzdi4g
V2hlbg0KPiA+ID4+Pj4gZG1hX2J1Zl9keW5hbWljX2F0dGFjaCgpIGZhaWxzLCBubyBkbWFfYnVm
IHJlZmVyZW5jZSBpcyBoZWxkIHNvDQo+ID4gPj4+PiB0aGUgZXhwb3J0ZXIgY2FuIGJlIGZyZWVk
IGltbWVkaWF0ZWx5LiBTaW5jZSB0dG1fYm9fcmVsZWFzZSgpIG5vdw0KPiA+ID4+Pj4gYWx3YXlz
IGRlZmVycyBjbGVhbnVwIGZvciB0dG1fYm9fdHlwZV9zZyBCT3MgdG8gdGhlIFRUTQ0KPiA+ID4+
Pj4gd29ya3F1ZXVlLCB0aGUgd29ya2VyIGxhdGVyIGNhbGxzDQo+ID4gPj4+PiBkbWFfcmVzdl9s
b2NrKCkgb24gdGhlIGFscmVhZHktZnJlZWQgZXhwb3J0ZXIgcmVzdiwgY2F1c2luZyBhIFVBRi4N
Cj4gPiA+Pj4+DQo+ID4gPj4+PiBSZXNldCBvYmotPnJlc3YgdG8gdGhlIEJPJ3MgcHJpdmF0ZSBf
cmVzdiBiZWZvcmUgY2FsbGluZw0KPiA+ID4+Pj4geGVfYm9fcHV0KCkgaW4gdGhlIGVycm9yIHBh
dGguIFRoZSBCTyBpcyBub3QgeWV0IHB1Ymxpc2hlZA0KPiA+ID4+Pj4gKGF0dGFjaA0KPiA+ID4+
Pj4gZmFpbGVkKSBhbmQgY2FycmllcyBubyBmZW5jZXMsIHNvIHRoZSBzd2l0Y2ggaXMgc2FmZS4N
Cj4gPiA+Pj4+DQo+ID4gPj4+PiBPYnNlcnZlZCB3aXRoIGlndEB4ZV9saXZlX2t0ZXN0QHhlX2Rt
YV9idWZfa3VuaXQgb24gQk1HIChRRU1VKToNCj4gPiA+Pj4+DQo+ID4gPj4+PiDCoMKgwqAgT29w
czogZ2VuZXJhbCBwcm90ZWN0aW9uIGZhdWx0LCBwcm9iYWJseSBmb3Igbm9uLWNhbm9uaWNhbA0K
PiA+ID4+Pj4gYWRkcmVzcyAweDZiNmI2YjZiNmI2YjZiOWMNCj4gPiA+Pj4+IMKgwqDCoCBXb3Jr
cXVldWU6IHR0bSB0dG1fYm9fZGVsYXllZF9kZWxldGUgW3R0bV0NCj4gPiA+Pj4+IMKgwqDCoCBS
SVA6IDAwMTA6bXV0ZXhfY2FuX3NwaW5fb25fb3duZXIrMHgzZi8weGMwDQo+ID4gPj4+PiDCoMKg
wqAgQ2FsbCBUcmFjZToNCj4gPiA+Pj4+IMKgwqDCoMKgIDxUQVNLPg0KPiA+ID4+Pj4gwqDCoMKg
wqAgPyBfX3d3X211dGV4X2xvY2suY29uc3Rwcm9wLjArMHgyZGQvMHgxOGUwDQo+ID4gPj4+PiDC
oMKgwqDCoCA/IHR0bV9ib19kZWxheWVkX2RlbGV0ZSsweDQxLzB4YzAgW3R0bV0NCj4gPiA+Pj4+
IMKgwqDCoMKgIHd3X211dGV4X2xvY2srMHgzYy8weGIwDQo+ID4gPj4+PiDCoMKgwqDCoCB0dG1f
Ym9fZGVsYXllZF9kZWxldGUrMHg0MS8weGMwIFt0dG1dDQo+ID4gPj4+PiDCoMKgwqDCoCBwcm9j
ZXNzX29uZV93b3JrKzB4MjM5LzB4NzQwDQo+ID4gPj4+PiDCoMKgwqDCoCB3b3JrZXJfdGhyZWFk
KzB4MjAwLzB4M2YwDQo+ID4gPj4+PiDCoMKgwqDCoCBrdGhyZWFkKzB4MTBkLzB4MTUwDQo+ID4g
Pj4+PiDCoMKgwqDCoCByZXRfZnJvbV9mb3JrKzB4M2JkLzB4NDcwDQo+ID4gPj4+PiDCoMKgwqDC
oCByZXRfZnJvbV9mb3JrX2FzbSsweDFhLzB4MzANCj4gPiA+Pj4+IMKgwqDCoMKgIDwvVEFTSz4N
Cj4gPiA+Pj4+DQo+ID4gPj4+PiBDbG9zZXM6DQo+ID4gPj4+PiBodHRwczovL2dpdGxhYi5mcmVl
ZGVza3RvcC5vcmcvZHJtL3hlL2tlcm5lbC8tL3dvcmtfaXRlbXMvODAyMw0KPiA+ID4+Pj4gRml4
ZXM6IGQ5OWZiZDlhYWI2MiAoImRybS90dG06IEFsd2F5cyB0YWtlIHRoZSBibyBkZWxheWVkIGNs
ZWFudXANCj4gPiA+Pj4+IHBhdGggZm9yIGltcG9ydGVkIGJvcyIpDQo+ID4gPj4+PiBDYzogc3Rh
YmxlQHZnZXIua2VybmVsLm9yZyAjIHY2LjgrDQo+ID4gPj4+PiBDYzogVGhvbWFzIEhlbGxzdHJv
bSA8dGhvbWFzLmhlbGxzdHJvbUBsaW51eC5pbnRlbC5jb20+DQo+ID4gPj4+PiBDYzogTWF0dGhl
dyBCcm9zdCA8bWF0dGhldy5icm9zdEBpbnRlbC5jb20+DQo+ID4gPj4+PiBDYzogTWF0dGhldyBB
dWxkIDxtYXR0aGV3LmF1bGRAaW50ZWwuY29tPg0KPiA+ID4+Pj4gU2lnbmVkLW9mZi1ieTogTml0
aW4gR290ZSA8bml0aW4uci5nb3RlQGludGVsLmNvbT4NCj4gPiA+Pj4+IC0tLQ0KPiA+ID4+Pj4g
wqDCoCBkcml2ZXJzL2dwdS9kcm0veGUveGVfZG1hX2J1Zi5jIHwgOCArKysrKysrKw0KPiA+ID4+
Pj4gwqDCoCAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+ID4gPj4+Pg0KPiA+ID4+
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV9kbWFfYnVmLmMNCj4gPiA+Pj4+
IGIvZHJpdmVycy9ncHUvZHJtL3hlL3hlX2RtYV9idWYuYyBpbmRleA0KPiA+ID4+Pj4gOGE5MjBl
NTgyNDVjLi42ZDk0NGJkNDA2NWMNCj4gPiA+Pj4+IDEwMDY0NA0KPiA+ID4+Pj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL3hlL3hlX2RtYV9idWYuYw0KPiA+ID4+Pj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL3hlL3hlX2RtYV9idWYuYw0KPiA+ID4+Pj4gQEAgLTM4NCw2ICszODQsMTQgQEAgc3RydWN0
IGRybV9nZW1fb2JqZWN0DQo+ID4gPj4+PiAqeGVfZ2VtX3ByaW1lX2ltcG9ydChzdHJ1Y3QgZHJt
X2RldmljZSAqZGV2LA0KPiA+ID4+Pj4gwqDCoCDCoMKgwqDCoMKgIGF0dGFjaCA9IGRtYV9idWZf
ZHluYW1pY19hdHRhY2goZG1hX2J1ZiwgZGV2LT5kZXYsDQo+ID4gPj4+PiBhdHRhY2hfb3BzLCBv
YmopOw0KPiA+ID4+Pj4gwqDCoMKgwqDCoMKgIGlmIChJU19FUlIoYXR0YWNoKSkgew0KPiA+ID4+
Pj4gK8KgwqDCoMKgwqDCoMKgIC8qDQo+ID4gPj4+PiArwqDCoMKgwqDCoMKgwqDCoCAqIFRoZSBC
TyB3YXMgY3JlYXRlZCB3aXRoIHJlc3YgPSBkbWFfYnVmLT5yZXN2DQo+ID4gPj4+PiArKGV4cG9y
dGVyJ3MNCj4gPiA+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgICogcmVzdikuIFNpbmNlIGF0dGFjaCBm
YWlsZWQsIG5vIGRtYV9idWYgcmVmZXJlbmNlIGlzDQo+ID4gPj4+PiAraGVsZCBhbmQNCj4gPiA+
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgICogdGhlIGV4cG9ydGVyIG1heSBiZSBmcmVlZCBiZWZvcmUg
VFRNJ3MgZGVsYXllZF9kZWxldGUNCj4gPiA+Pj4+ICt3b3JrZXINCj4gPiA+Pj4+ICvCoMKgwqDC
oMKgwqDCoMKgICogcnVucy4gU3dpdGNoIHRvIHRoZSBCTydzIG93biByZXN2IHRvIHByZXZlbnQg
YSBVQUYNCj4gPiA+Pj4+ICt3aGVuDQo+ID4gPj4+PiArwqDCoMKgwqDCoMKgwqDCoCAqIHR0bV9i
b19kZWxheWVkX2RlbGV0ZSgpIHRyaWVzIHRvIGxvY2sgdGhlIHN0YWxlIHBvaW50ZXIuDQo+ID4g
Pj4+PiArwqDCoMKgwqDCoMKgwqDCoCAqLw0KPiA+ID4+Pj4gK8KgwqDCoMKgwqDCoMKgIG9iai0+
cmVzdiA9ICZvYmotPl9yZXN2Ow0KPiA+ID4+Pg0KPiA+ID4+PiArQ2hyaXN0aWFuLCBkb2VzIGFt
ZGdwdSBub3QgaGF2ZSB0aGUgdHlwZSBvZiBzYW1lIGlzc3VlIGhlcmU/IEFsc28NCj4gPiA+Pj4g
K2FueQ0KPiA+IHRob3VnaHRzIGhlcmU/DQo+ID4gPj4NCj4gPiA+PiBPaCwgZ29vZCBjYXRjaC4g
WWVhaCBJIHRoaW5rIHdlIGhhdmUgdGhlIHNhbWUgcHJvYmxlbSBvbiBhbWRncHUgYXMgd2VsbC4N
Cj4gPiA+DQo+ID4gPiBNYXliZSBkdW1iIHF1ZXN0aW9uLCBidXQgd2h5IGRvZXMgdGhlIHR0bV9i
b19pbmRpdmlkdWFsaXplX3Jlc3YoKQ0KPiA+ID4gc2tpcCB0aGUNCj4gPiBmaW5hbCBzd2l0Y2gg
b2YgdGhlIHJlc3YgZm9yIHR5cGVfc2c/DQo+ID4NCj4gPiBCZWNhdXNlIHdlIG5lZWQgdGhlIG9y
aWdpbmFsIHJlc3Ygb2JqZWN0IGZvciBjbGVhbmluZyB1cCB0aGUgbWFwcGluZw0KPiA+IHNob3Vs
ZCB0aGUgaW5pdGlhbCBhdHRhY2ggYW5kIHRoZW4gbWFwIGhhdmUgc3VjY2VlZC4NCj4gPg0KPiA+
ID4gSXQgZ29lcyB0aHJvdWdoIHRoZSB0cm91YmxlIG9mIGNvcHlpbmcgdGhlIGZlbmNlcyBhY3Jv
c3M/DQo+ID4NCj4gPiBCZWNhdXNlIHdlIG5lZWQgdG8ga25vdyB3aGVuIHRoZSBpbXBvcnQgY2Fu
IGJlIGNsZWFuZWQgdXAuDQo+ID4NCj4gPiBJbiBvdGhlciB3b3JkcyBUVE0gdGFrZXMgYSBjb3B5
IG9mIHRoZSBjdXJyZW50IGZlbmNlcyBhbmQgb25seSB1bm1hcCwNCj4gPiBkZXRhY2ggYW5kIHRo
ZW4gZG8gdGhlIGZpbmFsIGNsZWFudXAgYWZ0ZXIgd2UgYXJlIHN1cmUgdGhhdCB0aGUgc2V0IG9m
DQo+ID4gZmVuY2VzIHdoaWNoIHdhcyBhY3RpdmUgb24gZGVzdHJ1Y3Rpb24gaXMgbm93IHNpZ25h
bGVkLg0KPiA+DQo+ID4gSWYgbmV3IGZlbmNlcyBhcmUgYWRkZWQgdG8gdGhlIHJlc3Ygb2JqZWN0
IChtYXliZSBieSB0aGUgZXhwb3J0ZXINCj4gPiBpdHNlbGYgb3Igb3RoZXINCj4gPiBpbXBvcnRl
cnMpIGFmdGVyIG91ciByZWZlcmVuY2UgY291bnQgZ290IGRvd24gdG8gemVybyB0aGVuIHdlIGRv
bid0DQo+ID4gY2FyZSBhYm91dCB0aGF0Lg0KPiA+ID4gSWYgd2UgZG8gbmVlZCB0byBoYW5kbGUg
dGhpcyBoZXJlLCBkbyB3ZSBhbHNvIG5lZWQgdG8gZ3JhYiB0aGUgbHJ1DQo+ID4gPiBsb2NrLCBs
aWtlIHdlDQo+ID4gZG8gaW4gdHRtX2JvX2luZGl2aWR1YWxpemVfcmVzdigpIHdoZW4gZG9pbmcg
dGhlIHN3YXA/DQo+ID4NCj4gPiBHb29kIHF1ZXN0aW9uLCBvZiBoYW5kIEkgd291bGQgc2F5IHll
cyBidXQgSSBjbGVhcmx5IG5lZWQgdG8gY2hlY2sgdGhlDQo+ID4gc291cmNlIGNvZGUgYXMgd2Vs
bC4NCj4gPg0KPiA+IE1pZ2h0IGJlIGJldHRlciB0byBzd2l0Y2ggdGhlIHR5cGUgb2YgdGhlIEJP
IG9uIGVycm9yIHNvIHRoYXQgdGhlDQo+ID4gbm9ybWFsIGNsZWFudXAgd2lsbCBqdXN0IHN3aXRj
aCBvdmVyIHRvIHRoZSBsb2NhbCBkbWFfcmVzdiBvYmplY3QuDQo+ID4NCj4gDQo+IC0gICAgICAg
ICAgICAgICBvYmotPnJlc3YgPSAmb2JqLT5fcmVzdjsNCj4gKyAgICAgICAgICAgICAgIGdlbV90
b194ZV9ibyhvYmopLT50dG0udHlwZSA9IHR0bV9ib190eXBlX2tlcm5lbDsNCj4gDQo+IFN3aXRj
aGluZyB0aGUgdHlwZSB0byB0dG1fYm9fdHlwZV9rZXJuZWwgbGV0cyB0dG1fYm9faW5kaXZpZHVh
bGl6ZV9yZXN2KCkgc3dhcA0KPiByZXN2IHRvIHRoZSBCTydzIHByaXZhdGUgX3Jlc3YgdW5kZXIg
bHJ1X2xvY2ssIHdoaWNoIHByZXZlbnRzIFVBRiB3aXRob3V0DQo+IG5lZWRpbmcgYW55IG1hbnVh
bCBsb2NraW5nLg0KDQpDaGVja2VkIGFsbCBiby0+dHlwZSByZWFkZXJzICh4ZV9ldmljdF9mbGFn
cygpLCB4ZV9ib19tb3ZlKCksIHhlX2JvX2Nhbl9taWdyYXRlKCkpIGFuZCBmb3VuZCB0aGV5IGNh
biBiZSBjYWxsZWQgY29uY3VycmVudGx5IGJ5IHRoZSBzaHJpbmtlciBvciBldmljdGlvbiBwYXRo
cyB3aXRob3V0IGFueSBzeW5jaHJvbml6YXRpb24sIG1ha2luZyB0aGUgYm8tPnR5cGUgY2hhbmdl
IHVuc2FmZS4NCg0KU3dpdGNoaW5nIHJlc3YgdG8gJm9iai0+X3Jlc3YgdW5kZXIgbHJ1X2xvY2ss
IG1pcnJvcmluZyB0dG1fYm9faW5kaXZpZHVhbGl6ZV9yZXN2KCksIGlzIHRoZSBtb3JlIHJlYXNv
bmFibGUuIA0KSSdsbCBzZW5kIHRoaXMgYXMgdjIsIGFsb25nIHdpdGggYSBzZXBhcmF0ZSBwYXRj
aCBmaXhpbmcgdGhlIHNhbWUgaXNzdWUgaW4gYW1kZ3B1Lg0KDQotIE5pdGluDQoNCj4gPiBTaW5j
ZSB3ZSBkb24ndCBuZWVkIHRoZSBvcmlnaW5hbCBkbWFfcmVzdiBmb3IgdGhlIGNsZWFudXAgdGhh
dCBzaG91bGQgd29yaw0KPiBmaW5lLg0KPiA+DQo+ID4gPiBJZGVhbGx5IHhlIGFuZCBhbWRncHUg
Y2FuIGp1c3QgaGF2ZSBpZGVudGljYWwgc29sdXRpb25zIGhlcmUuDQo+ID4NCj4gPiBZZWFoIGNv
bXBsZXRlbHkgYWdyZWUuDQo+ID4NCj4gPiBSZWdhcmRzLA0KPiA+IENocmlzdGlhbi4NCj4gPg0K
PiA+ID4NCj4gPiA+Pg0KPiA+ID4+IEhvdyB0aGUgaGVjayBkaWQgeW91IGZvdW5kIHRoYXQ/IERv
IHdlIGhhdmUgYSBkdW1teSBkcml2ZXIgKFZHRU0/KQ0KPiA+ID4+IHdoaWNoDQo+ID4gY291bGQg
YmUgbWFkZSB0byBhbHdheXMgZmFpbCBhdHRhY2htZW50IGZvciBhIHRlc3QgY2FzZT8NCj4gDQo+
IFRoZSBidWcgd2FzIGZvdW5kIHZpYSB0aGUgZXhpc3RpbmcgS1VuaXQgdGVzdCAoeGVfZG1hX2J1
Zl9rdW5pdCksIHdoaWNoIHdhcw0KPiBmYWlsaW5nIG9uIGEgQk1HIFZNIGRldmljZS4gVGhlIHRl
c3QgcnVucyAyMCBwYXJhbWV0ZXIgY29tYmluYXRpb25zLg0KPiB0aGUgZmFpbGluZyBvbmVzIHVz
ZSBmb3JjZV9kaWZmZXJlbnRfZGV2aWNlcz10cnVlICsNCj4gbWVtX21hc2s9WEVfQk9fRkxBR19W
UkFNMCArIG5vcDJwX2F0dGFjaF9vcHMsIHdoZXJlDQo+IGRtYV9idWZfZHluYW1pY19hdHRhY2go
KSByZXR1cm5zIC1FT1BOT1RTVVBQLCBoaXR0aW5nIHRoZSBlcnJvciBwYXRoLg0KPiANCj4gT24g
YmFyZSBtZXRhbCBCTUcgdGhlIHJhY2Ugd2luZG93IGlzIHRvbyBuYXJyb3cgdG8gaGl0IHRoZSBp
c3N1ZS4gVG8gbWFrZSBpdA0KPiBtb3JlIGRldGVybWluaXN0aWMsIGFkZGVkIGEgc21hbGwgbXNs
ZWVwKDEwMCkgaW4gdHRtX2JvX2RlbGF5ZWRfZGVsZXRlKCkganVzdA0KPiBiZWZvcmUgdGhlIGRt
YV9yZXN2X2xvY2soKSBjYWxsLCB3aGljaCB3aWRlbmVkIHRoZSByYWNlIHdpbmRvdy4NCj4gV2l0
aCBLQVNBTiBlbmFibGVkLCB0aGF0IGdhdmUgYSBjbGVhciBzbGFiLXVzZS1hZnRlci1mcmVlIGlu
IF9fd3dfbXV0ZXhfbG9jaw0KPiDigJQgdGhlIDB4NmI2YjZiNmIgU0xVQiBwb2lzb24gcGF0dGVy
biBpbiB0aGUgZmF1bHRpbmcgYWRkcmVzcyBjb25maXJtZWQgdGhlDQo+IFVBRi4NCj4gDQo+IFRo
YW5rcywNCj4gTml0aW4NCj4gDQo+ID4gPj4NCj4gPiA+PiBAVml0YWx5IGNhbiB5b3UgdGFrZSBh
IGxvb2sgYW5kIHRyeSB0byBjb21lIHVwIHdpdGggYSB0ZXN0IGNhc2UgZm9yIHRoYXQ/DQo+ID4g
VGhhbmtzIGluIGFkdmFuY2UuDQo+ID4gPj4NCj4gPiA+PiBUaGFua3MgZm9yIHRoZSBub3RpY2Us
DQo+ID4gPj4gQ2hyaXN0aWFuLg0KPiA+ID4+DQo+ID4gPj4+DQo+ID4gPj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB4ZV9ib19wdXQoZ2VtX3RvX3hlX2JvKG9iaikpOw0KPiA+ID4+Pj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIEVSUl9DQVNUKGF0dGFjaCk7DQo+ID4gPj4+PiDCoMKgwqDC
oMKgwqAgfQ0KPiA+ID4+Pg0KPiA+ID4+DQo+ID4gPg0KDQo=
