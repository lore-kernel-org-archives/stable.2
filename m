Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869493783B0;
	Wed, 17 Jun 2026 22:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781734119; cv=fail; b=B4Pc03B2R1volUHcq/Hdkf3xNoQ2FXeg3iGwW8gCiwDU0dBmelKj20xtK27hWpRvJGo07bWkLleqP41IskRFEV7k8fZcCnTE1hlhxIXxAv9+uGBae0p1R0WWRb9gkfgURAL890T3/YN6sgAWgJY4+RJ9v1sfMVNm9A7tuzw9Occ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781734119; c=relaxed/simple;
	bh=sbcCKZIOvqzFbS/BUe3ItWM4JSaQ3qpG1XCLx/zz+2Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d7ozNS3QUVwrKL108RSsLcN8p70xrlwt2RDGMXIVItBaRymztyG801bkdp7w9Mk6tRu3/u4fFTc5kEH4cyP9XmrsdeA/6cOWvoujowe5EIgF0ay7eszR7013h3ehP8FCmF33inhD45sd1nBrd4ANN+04nye8Ng6w4Uh6HrzsbV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NNKs0h77; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NNKs0h77"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781734119; x=1813270119;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sbcCKZIOvqzFbS/BUe3ItWM4JSaQ3qpG1XCLx/zz+2Y=;
  b=NNKs0h77ZjBmYOArt4L7nAR4K9rgucnnspznN/rHxrQAI7/iL7BIV9Gp
   MKgfr5xhNMMVVHgRT4PMwEjHDF9SpZ6QeGaIMYPJLpWBSMCw4Hbm9ait6
   fY0f7mmfslaZJJBowdeDRQE6sJPEkuTAeKMK0oBFaN+Fgw0IsOR4l+7Xa
   9Umji/th+1qPdaNs3bZxaPZPACxG+Jg3K/8WjNUpJ5TQ97adzE1jN7nsC
   H4LuQawn0nKK1CnVVHovYn0+cgdA6jUAF/Nxm0JgrV8+CiQPpztHwfg3G
   w0GHSjwhPHRrBfxNy9/uSrtPl0RDgi6z5OX7mlId0c6DZCjFt/HM/2ity
   A==;
X-CSE-ConnectionGUID: InbeygCARYiSimvTUF6HQA==
X-CSE-MsgGUID: oyXkDo1IQJGXYLh3AzU7ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82750806"
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; 
   d="scan'208";a="82750806"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 15:08:39 -0700
X-CSE-ConnectionGUID: 8WwsPww+T5GzjgwpUKRRnw==
X-CSE-MsgGUID: L9mLcVb/SuGfNAO2nC56MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; 
   d="scan'208";a="247043139"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 15:08:38 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 15:08:37 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 17 Jun 2026 15:08:37 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.24) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 15:08:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lmxg43wTI4EpxwMcC2iRcGvXNRJVW7wzBodFuacYYPQOGlfFefF05SoWbwgFEiSNJ3j6FSNSiB2lFUCVsG/dSvHiIg6+8sn8Zw/G537NAJVSIR5pauYZUKMwL40w7tAdoe6F3aSZ6sIiUFGNlFwOdoF72ryNRVVEKFij1+VX2nUgQ82rUWY4r2ARLC4VAMFmsxwlPCRJnPNSWrJQZYg8B6gHX8v2RnxhY/qYvxvzaGtMi9iUU35fu+NP1Smx4fsS5KbKLSajdqI1K+QMlqG/5Iu7Bt7kJ76Wi6OfH6yqhBeB5JTLCK1YNMsvbzYDvs7V30l4T0aDGsdmWoc8mH4bQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbcCKZIOvqzFbS/BUe3ItWM4JSaQ3qpG1XCLx/zz+2Y=;
 b=Yp5HSavquCGRbCpTvA3iTtQhATCv6d1ldCtB0BP+mPvk/m5wChoNbro0tVEH638Btco/a+oxulZYwwGZhcdDIJ9aD7VmQMRRXAgz7rFLrPkneATJK4oyOBrQAdu/NpHPOJxvNAcfuh7wPenyhKlDKuPs1ngWBalgNu7a3ws0mryFiTGo1WLfRf23ogwQZROnIan9mjOLfWkudi0vPSCAe50n7145pugX+hGyo1Xr5Mz4naXQj7VXFKtTJ6haNLQrHIztHDVjieRuX6p1+AIzx56UEg4xTQ88ARa0uppveU7ocBP+ca5KO9XLDUNDL4CT2euVlzNDRtTBtEdRcSq69A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SJ2PR11MB7617.namprd11.prod.outlook.com (2603:10b6:a03:4cb::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Wed, 17 Jun 2026 22:08:35 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 22:08:34 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "yosry@kernel.org" <yosry@kernel.org>
CC: "jmattson@google.com" <jmattson@google.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "seanjc@google.com"
	<seanjc@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] KVM: nVMX: Always flush vpid02 on first use
Thread-Topic: [PATCH 1/3] KVM: nVMX: Always flush vpid02 on first use
Thread-Index: AQHc/dm+vhBqLF7f3EanPIP01uKgGbZCncWAgAAZzgCAAJbYAIAAAI6AgAAA/4A=
Date: Wed, 17 Jun 2026 22:08:34 +0000
Message-ID: <dc5cb383eba7ff0130b74d1c0f3d34285b51cd3d.camel@intel.com>
References: <20260616214652.2157032-1-yosry@kernel.org>
	 <20260616214652.2157032-2-yosry@kernel.org>
	 <5b5a0f3f21bba5d25410382a9e0170a17c952738.camel@intel.com>
	 <ajKbCii_1LpyQKjJ@google.com>
	 <861c890587cb8cd0e2893ea4041555d33d8e9db4.camel@intel.com>
	 <CAO9r8zOMkyjG+a8YLGskEaHaLpGyo4qnrHBGJu=pZc_4a3bZWg@mail.gmail.com>
In-Reply-To: <CAO9r8zOMkyjG+a8YLGskEaHaLpGyo4qnrHBGJu=pZc_4a3bZWg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SJ2PR11MB7617:EE_
x-ms-office365-filtering-correlation-id: 5435ba09-8e83-4952-c961-08deccbcf9c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|38070700021|22082099003|18002099003|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: etyzSdkWBXhlIRrrGaRiAQXkVkDivXDI2VFLzOW7ZPQ0f9B0z/P27b/7fk12kThEURVacts2iBAAa5hZydnjLjdAeJk3+ydZbmnIN9bmnxFp4APdtP9g0yWR93XwbsFK/pBSzvVAjIzX3pXOxKoouh8BpG3HX+Nl2v5GzjS/oOEqWe9PDCkQXwpiUeNhre88jRLsryiNeJ22vniuC41+DIqRPAO3wVmkSsGSVvE/448F3A5U1cZWIfdfYh4HN41MJ8JCJrvNb0JP+zSgSp4Zi2KGKC8Cz6wF9c5MdvyNiXbEG9zvpd3st8KP2FgZx+ygjn2gEIpFDlJFAjVNBv6OHuf5EeTM97PBiSJbhhHcdkco94Z1dZ+n6CKog2sT9Z5T2RNW+S5WRiabtgzA6sljzMdOQQ/mlBQVRtVMwniNsCgkXjXP8aNcqy+YvTsrZfGQEQcLjCZXmRp6A0HUXFYz07236KNlSqQtM6pyin7Hdi/cxInxxwZfb7zwf9WFb3j1Xqjv9MospZV5mGS7GIqSK/lOVavstCrOH7TBTHy7vzr6yqGn7c0FEMlR7PQRv4xFCvTR6eUQMJ1AE6W4CoN6VAIJg4xAa44OvUKkZAUfD5glh1UZxmHh9f5UYGot/aLxUced34JzAA39OWLz5IYBqDgreEOnMh6GNnWvV7zPYxCSzBCv2QpJsglaPexq4Hfxatb0zBcD7A9BGHkQbtjqbo9b3BtRXE09cX6wpZ9JAMysrgqJ0sG5vDJiCo02lZFq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(38070700021)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1B6VzNlSnI0R0pHSS9ZS1FFRlJjVjltcjR6OGp4UGU2eEpOMjVPeGNIbDk0?=
 =?utf-8?B?bVQ3ZkhhUitFWW43a01PNGNBQlRTZG1MUnlGazdCcXVhSU0rTlQzL0RidUdj?=
 =?utf-8?B?d1JMZC9BNTIvWmlKVWJzNGg3MXU2NFlDSDNlY0VWVDlzalpSSjdXMzZUeGo5?=
 =?utf-8?B?a2pXNFRpeUJHcUdDaGJGeGdMemhnajZiWlR6QVBSbnlQU2Q4SmtxYzZkNm9i?=
 =?utf-8?B?bWFoTGxJRlFFaGlMUU55bDF4YnZPYld1RjhMZXAxNXdzUytjT2RWSi9qNWRk?=
 =?utf-8?B?WVlKTnJmT0pGQXQzKzAyVWxKN3NNN1VCMGNpTlgxbnBzLzk4T2I5VjZVbytP?=
 =?utf-8?B?UENkSmVJazd1SWRjWXRUSWpiUHJFUUhhUEhjVUYySW9MUldqVDFqMUFDM0E2?=
 =?utf-8?B?NElQM1cvWUZPcFlsREk4cHZoTTJPL0kxWXF4S0dyTXVGd091dmlyRlNsRFZu?=
 =?utf-8?B?MFFQOU5QdCsyaHFDUWs4c29wbk5qa2ZPMzJGYXZUQWl3ekxPd0NJQndUOUxl?=
 =?utf-8?B?eHdOcGlUNnBXOFpYY2k2TEN2SDR0dDZaZ1ZNUTdWVGdWN0JBQUVlUXpabDEr?=
 =?utf-8?B?VHhhbHRWeEl6VWlQMGFBa1RuTCtVd1FUeDFTMFNJWW1uNXJrSExUdUZYUkI3?=
 =?utf-8?B?K1dLZ0FWRWcyTEpsakt1bGpZSCtVbWlGaWF2WGFVaVhRNmozVnEwSFlGNGh3?=
 =?utf-8?B?alptY1lNb0NoUjZtbTQyTW81Uml2czNJMU9keWZUWVVQaDI4cHRSOFJaQ0RU?=
 =?utf-8?B?bEpuY0NXS1BIaFVNNU1Ga3NkbysvODBjQVVBU2x6aGgxZWtCVzVWWVZINWpn?=
 =?utf-8?B?TzU3SjVaNHp6dVorc0lGR3h0RDRZaFJCKzFkcjJ2L3lxTFNKbmJzTXdqYlln?=
 =?utf-8?B?R29uZUhSUEZTMDVPd0dMOFk0d3BGMkNwMGx3STBzRFRnNmJldDhNaitDNWlV?=
 =?utf-8?B?aFUrOG5aVStDSDA3U2tDWlJxSkpEVks1a2ZRQUdnU2pDYlhva3hUZXNGWGth?=
 =?utf-8?B?Sm5uZXh5Q25DT0hGMGdJZzRUUmpHa2ZKaDMrN1FqejlQL2M4Tm9mRTB2Vm1W?=
 =?utf-8?B?bE45T1kycEJ2L3haRUE4dnR3bUt3d3V6QU1PaXFvSTg1dnNFeXJTSTQ2RXFK?=
 =?utf-8?B?cVVGR1owakRZeGl1VllyT3kwNmRPWGFFQ2Y0NkhaY2poUzRwZ28wZzI3Rmxa?=
 =?utf-8?B?OUhqKzVsV1g5ZnlsQlRueVhTUFJTRXRuVFVkQ05sK01wSG1sK2lHTTgzbXRi?=
 =?utf-8?B?N0diOUdBT212NFZDQlBQM0dQVW9EY0FSRjJ4U25JbUhZSWhtRi9VVVhCYTdK?=
 =?utf-8?B?OWNjZHRaSDlTbjFGOG1qWWI5a2hEUzJhWng4TDhkUDFHaXV3SUwrVFlsRDRI?=
 =?utf-8?B?ODRDdFUrMzA2K2ZDUUhZSGxoc1U3ZGlLb2gwcU9XSkFUaVI2NkJZUkMvYlc1?=
 =?utf-8?B?S3NXUW9hQzhVN1RJeWRuYTl0NmRJOUxKK01uSkR2d0ZWL0N1NEExTE9vYTNF?=
 =?utf-8?B?WTVGS1FZcXpDd2hHUVk2OHpQeUdvZ0t0dVE4a05RN0s0d1hFc0tmVlVVNXNZ?=
 =?utf-8?B?SXFGMXpoK25LS01JOVhvT1g5VFhMRG5CYldtUFRvaXIxb1hheElCVXpUUDhQ?=
 =?utf-8?B?NDJOM0hyUmdlM0pXU3g1NEZmUUdibXpYYm0vUUM2RHdVUjRpYzVJWkRWeVlu?=
 =?utf-8?B?TFhzRGEzWXNNMi92VmUvdWlsMWFkYWtWNU1LUW5FQWwxTWhYck9weVNuanJ4?=
 =?utf-8?B?N2pLbGxCTlZhUk1IRTBhOGNaUy93Zm5KZWxnOVVHY0NvdUk2Rkw2ZTlwK1B2?=
 =?utf-8?B?R1hmWWttRE5NZkdYLzlYVURTbVBoMkgwOTJtOS9LUkcyNkVEY1RMaFh3OTJU?=
 =?utf-8?B?bS9CMmZ1RXRlcWlqRnVxaHFxdDdaWkdaNk55d1N0OHVIeWFLd0s0djNXYWRp?=
 =?utf-8?B?QWd5UWJiN1dKWmMyVHR2em44cmRFbnFLa0QvTWJkRXV4ZVNiZUwzS2FCd1Y4?=
 =?utf-8?B?MzVHTTVQUFBFd0pmSEhYU0NNZHNvZndvOE1jTDBKeDdyckZyNk1rc2FLaUVC?=
 =?utf-8?B?MWZ5M1RLUXg1UzU0bUpuV0JIcTU3cTNWcDFlaXRpWU1tWHVxNWd3aHBsM05n?=
 =?utf-8?B?Ly8xUncvTGFtdFRweGNVa3k4YnM0d3VJNkFDcDY4Y3VNT0NnQUZtK2FrYXdU?=
 =?utf-8?B?S3dnaTFjM1FxRDh6b3VvT2RjZW1ubWMzbVVkbkFEMlZoem1MNjZlM25xWmNF?=
 =?utf-8?B?aGF6QmpPV0xsRndTNnBoWXk5cXBGekcvNmpQdnhJU01rQWRjTm9BVVB6U1Rq?=
 =?utf-8?B?MDVFL29iRUp4WVMwVldQeG9admxFakR3c2V1TkVZbnhUdmgybm1aZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <04AC844EE5BA4A49B08FCB176CB2500C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rezTcobRkPoYNBv/WXzBCE6llIEEIy8pcZtn2QRsisfMYJeCZU93Ocyc0mE8vgcY39qfl0rFsz57QFd7RB1TilmeQnHq3pmAI3PSUjGsDiUGu/DmyXxLegXmHreZ8NPvBR/ugtcdUOEFu7ZEtRxkcYvaYY5Zo2y/nj0kMkUn5Bh8c8AO6GEJvHi7Yy3uUip3ifmYHYXGrHzlONPEJgjItqOWR8Xe4swsWzLp2UqmiCHJOaaFQ/40qj6MnnUe5JBYBbfhaGQZwnuEEAl8DJseGSy63rjp15z7xKqfN1qrKZFKEDCDOkyAMR6t66z6nk6EcfvAVzr/Jio3VAeAVhVp/g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5435ba09-8e83-4952-c961-08deccbcf9c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 22:08:34.9336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ulzuTPs43+xfRijFFsVxYAH4g3410LpALwD00F0kYp8+KAW6IfmANKhpLq9Sso+3w/VHv8bKyHTsSNGcSWTkoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7617
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA2LTE3IGF0IDE1OjA0IC0wNzAwLCBZb3NyeSBBaG1lZCB3cm90ZToNCj4g
T24gV2VkLCBKdW4gMTcsIDIwMjYgYXQgMzowM+KAr1BNIEh1YW5nLCBLYWkgPGthaS5odWFuZ0Bp
bnRlbC5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIFdlZCwgMjAyNi0wNi0xNyBhdCAwNjowMyAt
MDcwMCwgU2VhbiBDaHJpc3RvcGhlcnNvbiB3cm90ZToNCj4gPiA+IE9uIFdlZCwgSnVuIDE3LCAy
MDI2LCBLYWkgSHVhbmcgd3JvdGU6DQo+ID4gPiA+IE9uIFR1ZSwgMjAyNi0wNi0xNiBhdCAyMTo0
NiArMDAwMCwgWW9zcnkgQWhtZWQgd3JvdGU6DQo+ID4gPiA+ID4gTWFrZSBzdXJlIHZwaWQwMiBp
cyBhbHdheXMgZmx1c2hlZCBvbiBmaXJzdCB1c2UgYnkgc2V0dGluZyBsYXN0X3ZwaWQ9MA0KPiA+
ID4gPiA+IHdoZW4gYWxsb2NhdGluZyB2cGlkMDIuICBuZXN0ZWRfdm14X3RyYW5zaXRpb25fdGxi
X2ZsdXNoKCkgd2lsbCBhbHdheXMNCj4gPiA+ID4gPiBkZXRlY3QgYSBWUElEIGNoYW5nZSBvbiBm
aXJzdCBWTS1FbnRlciBhZnRlciBWTVhPTiwgYmVjYXVzZSBWUElEPTAgaW4NCj4gPiA+ID4gPiB2
bWNiMTIgaXMgbm90IGFsbG93ZWQgaWYgTDEgZW5hYmxlcyBWUElELg0KPiA+ID4gPiANCj4gPiA+
ID4gdm1jczEyIDotKQ0KPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGlzIGF2b2lk
cyB1c2luZyBzdGFsZSBUTEIgZW50cmllcyBmcm9tIGEgcHJldmlvdXMgbGlmZXRpbWUgb2YgdGhl
DQo+ID4gPiA+ID4gVlBJRCwgdGhhdCBtaWdodCBoYXZlIGJlZW4gYXNzb2NpYXRlZCB3aXRoIGEg
ZGlmZmVyZW50IHZDUFUgKG9yIGENCj4gPiA+ID4gPiBjb21wbGV0ZWx5IGRpZmZlcmVudCBWTSku
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gTm90ZSB0aGF0IGxhc3RfdnBpZCBpcyBhbHJlYWR5IGJl
aW5nIGluaXRpYWxpemVkIGFzIDAgd2hlbiB0aGUgdkNQVSBpcw0KPiA+ID4gPiA+IGNyZWF0ZWQs
IGJ1dCBpdCBpcyBub3QgcmVzZXQgd2hlbiB2cGlkMDIgaXMgZnJlZWQgb24gVk1YT0ZGLiBIZW5j
ZSwgdGhlDQo+ID4gPiA+ID4gcHJvYmxlbSBjYW4gb25seSBvY2N1ciBpZiBMMSBkb2VzIFZNWE9G
RiAtPiBWTVhPTiwgcnVucyBhbiBMMiwgYW5kIEtWTQ0KPiA+ID4gPiA+IGhhcHBlbnMgdG8gcmV1
c2UgYSBWUElEIHRoYXQgaGFzIFRMQiBlbnRyaWVzIG9uIHRoZSBwaHlzaWNhbCBDUFUuDQo+ID4g
PiA+IA0KPiA+ID4gPiBOb3Qgc3VyZSB3aGV0aGVyIGl0J3MgYmV0dGVyIHRvIHNldCBpdCB0byAw
IGluIGZyZWVfbmVzdGVkKCksIHdoaWNoIGFsc28gcmVzZXRzDQo+ID4gPiA+IHNvbWUgb3RoZXIg
bmVzdGVkIGZpZWxkcyB0byBjbGVhbiBzbGF0ZSBBRkFJQ1Q/DQo+ID4gPiANCj4gPiA+IEl0IG5l
ZWRzIHRvIGJlIHNldCBvbiBmaXJzdCB1c2UsIGZvciB0aGUgc2FtZSByZWFzb24gdGhhdCBrdm1f
bW11X2xvYWQoKSBmbHVzaGVzDQo+ID4gPiB0aGUgcm9vdDoNCj4gPiA+IA0KPiA+ID4gICAgICAg
LyoNCj4gPiA+ICAgICAgICAqIEZsdXNoIGFueSBUTEIgZW50cmllcyBmb3IgdGhlIG5ldyByb290
LCB0aGUgcHJvdmVuYW5jZSBvZiB0aGUgcm9vdA0KPiA+ID4gICAgICAgICogaXMgdW5rbm93bi4g
IEV2ZW4gaWYgS1ZNIGVuc3VyZXMgdGhlcmUgYXJlIG5vIHN0YWxlIFRMQiBlbnRyaWVzDQo+ID4g
PiAgICAgICAgKiBmb3IgYSBmcmVlZCByb290LCBpbiB0aGVvcnkgYW5vdGhlciBoeXBlcnZpc29y
IGNvdWxkIGhhdmUgbGVmdA0KPiA+ID4gICAgICAgICogc3RhbGUgZW50cmllcy4gIEZsdXNoaW5n
IG9uIGFsbG9jIGFsc28gYWxsb3dzIEtWTSB0byBza2lwIHRoZSBUTEINCj4gPiA+ICAgICAgICAq
IGZsdXNoIHdoZW4gZnJlZWluZyBhIHJvb3QgKHNlZSBrdm1fdGRwX21tdV9wdXRfcm9vdCgpKS4N
Cj4gPiA+ICAgICAgICAqLw0KPiA+ID4gICAgICAga3ZtX3g4Nl9jYWxsKGZsdXNoX3RsYl9jdXJy
ZW50KSh2Y3B1KTsNCj4gPiANCj4gPiBJIHRoaW5rIHlvdSBtZWFuIHRoZSAiYWN0dWFsIGZsdXNo
IiBuZWVkcyB0byBiZSBkb25lIG9uIHRoZSBmaXJzdCB1c2UuICBCdXQNCj4gPiBzZXR0aW5nIGxh
c3RfdnBpZCB0byAwIGlzIGEgc2V0dGluZyB3aGljaCBpcyB0byBtYWtlIHN1cmUgdGhlIGFjdHVh
bCBmbHVzaCB3aWxsDQo+ID4gYWx3YXlzIGJlIGRvbmUgb24gdGhlIGZpcnN0IHVzZSwgaS5lLiwg
dGhlIGFjdHVhbCBmbHVzaCB3aWxsIGFsd2F5cyBiZSBkb25lIG9uDQo+ID4gdGhlIGZpcnN0IHVz
ZS4gIEZvciB0aGlzIHB1cnBvc2Ugc2VlbXMgdG8gbWUgdGhlcmUncyBubyBkaWZmZXJlbmNlIGJl
dHdlZW4NCj4gPiBzZXR0aW5nIGxhc3RfdnBpZCB0byAwIGluIGVudGVyX3ZteF9vcGVyYXRpb24o
KSBhbmQgZnJlZV9uZXN0ZWQoKSwgYnV0IG1heWJlIEkNCj4gPiBhbSBtaXNzaW5nIHNvbWV0aGlu
Zy4NCj4gPiANCj4gPiBCdXQgSSBndWVzcyBkb2luZyBpdCBpbiBlbnRlcl92bXhfb3BlcmF0aW9u
KCkgbWF0Y2hlcyB0aGUgbG9naWMgb2YgImRvaW5nIGFjdHVhbA0KPiA+IGZsdXNoIG9uIGZpcnN0
IHVzZSIgbW9yZSA6LSkNCj4gDQo+IFl1cC4gSSB0aG91Z2h0IGFib3V0IHB1dHRpbmcgaXQgZnJl
ZV9uZXN0ZWQoKSBhcyBpdCBsb29rcyBsaWtlDQo+IGNsZWFudXAsIGJ1dCBzZW1hbnRpY2FsbHkg
aXQgbWFrZXMgbW9yZSBzZW5zZSB0byBwdXQgaXQgaW4NCj4gZW50ZXJfdm14X29wZXJhdGlvbigp
Lg0KDQpTb3VuZHMgZ29vZCB0byBtZS4gIDotKQ0K
