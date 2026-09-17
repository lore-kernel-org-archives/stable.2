Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABA249D5B9;
	Thu, 17 Sep 2026 18:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789670626; cv=fail; b=ukH1a83QDtZ68ZfFT/A45/m8/Nu3lQvVtCpuo1udqImuQXR2edFs0urUwp4o8SQL8y7AmM5Ok9JS9Sin0ZrIT36cQlXw5ShEYjiLfsP2NUL2yTRbd++Vq8b8eOe+QD0Nee3nvReEH+GQ2O87sQ26LvUayPxqDBIsEwn2NxLZG1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789670626; c=relaxed/simple;
	bh=9WLU/vfQLUZnSHheEMkwJxmUHfRXrzMRpp+I3rhYWns=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hbdFEvRHT1AupIr2g2SjcyxCHDUaug6BNUbhdWEbAEaJte9MJ84ZonviBWxf9z1CEcgMB/IJXYj+HRpKZ+wu0IfrVLHae55yxk8MbQPQS77sOgVkuDFIEkfrrWtb429/oIj5iQLhXN2OShLnIDTBnMevkvDpZgnCskIuV4H42q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UQZqrOe/; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UQZqrOe/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789670625; x=1821206625;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9WLU/vfQLUZnSHheEMkwJxmUHfRXrzMRpp+I3rhYWns=;
  b=UQZqrOe/DNVsPN+DxPbolIuNRy61SXKoeC4UrcxGjwwheKws0BkzWC9c
   vLgonHwHaLzI51mymNGiW5wccjqI8btUs9wexLyx4icMAhonU8firh3c1
   rWT56g3/8S/8bJHxz4cCycYmVySL9DEogoXaa2spNPrQ4DZTaAjmzoqeF
   Ab/1d9gvyeNeyaOyz4BWiUTpsyOV2u9tNkKdMTxKmMCmbms2g9736KNUC
   Wml2cVlaNM8mV5boUFwC/WTuc+b9w7rLGPutcRJ7tgRFS+HPaK00RsgPY
   9sCzgG1EnJSHRIMlFsIieTMgTm6oEy4ygVAmPDd8QSxgmXW9Dx1zc4ca5
   g==;
X-CSE-ConnectionGUID: bmoyF13qTrmb6x1TpAGCsw==
X-CSE-MsgGUID: mh3t8XEmQeGBOo7NJNU4YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100790572"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100790572"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 11:43:45 -0700
X-CSE-ConnectionGUID: 4oDl/FViSPm1C5YqHJz5yw==
X-CSE-MsgGUID: w6M3cDooSx+7Ykv1sltrcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="2397848"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 11:43:44 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 11:43:44 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 11:43:44 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.52) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 11:43:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SsjHbf2DYBrCS+rT0zhWN0ql8OIiKrKEhuOPTBCSnkZfK8C+DMJDvRB8rKMsmAy35QOu3Dk2H6EG5I8xEQILdyk3Iu8/W0NV9sJHrDesi3d9D6cXm0Ul4C2oBEReRRUtqm14NM7b60eSs6fL3v7aSWDLieu41QODbh9AY5rWb0ml7nACtabvD9SNwlvOzp5bd3JrdpiFQLfkMXCuKp+uHU8Plm2/1G4i+Rs/WOC+BSfgqvtMK36UWfQj9na3SEct/e9RKeQIfE2gR7GmjRtDB/2AuebHa8B5eb75pyjT0K2IUju1qH2QOXceAFo5g/5ji74mEF1Trin8CFDFgr60Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9WLU/vfQLUZnSHheEMkwJxmUHfRXrzMRpp+I3rhYWns=;
 b=lmGYQOme51UydI5m5QFBQwVibrHTiHljOv4WNskOoHVWdTXq1d/DchYFPYx/msSL7w7MzQ32z+ExCB1PYYmr9b44SN+eajP/ajMIFZE5eHMZnCLEDcctSwyS1lWiTp1+FkmGXsw1BB9Yo2mq0IZq4M/dejAeT02t+OdrsL4EqSyEQmJxAa0S5b/HZLuBBOw3vsIKnJUw/n8n7549hJ/ZcMFi5bqA3GPtYHaxRZrO3tyO+SH0Sg4/ZSzBbluc3NMauHnpqA9+SmLrw7laZlhAk/3ka1q4cwxvC9vrHc75OafXKehDcL95Niq4fIA0rdNa825Ql0PoZbQNZuL3d1WtFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8850.namprd11.prod.outlook.com (2603:10b6:408:2b4::5)
 by SA1PR11MB6736.namprd11.prod.outlook.com (2603:10b6:806:25f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 18:43:40 +0000
Received: from LV1PR11MB8850.namprd11.prod.outlook.com
 ([fe80::fb85:4e1d:5e41:7a7]) by LV1PR11MB8850.namprd11.prod.outlook.com
 ([fe80::fb85:4e1d:5e41:7a7%6]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 18:43:40 +0000
From: "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
To: "Bae, Chang Seok" <chang.seok.bae@intel.com>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v3] x86/microcode/intel: Reject problematic loading on
 Granite Rapids systems
Thread-Topic: [PATCH v3] x86/microcode/intel: Reject problematic loading on
 Granite Rapids systems
Thread-Index: AQHdRjLSwVLNxqVpRke88KfQKV6xa7bTDiAAgAAFRgCAAAhTwA==
Date: Thu, 17 Sep 2026 18:43:13 +0000
Deferred-Delivery: Thu, 17 Sep 2026 18:42:48 +0000
Message-ID: <LV1PR11MB8850F9AE30CE6C60F372262F92B82@LV1PR11MB8850.namprd11.prod.outlook.com>
References: <20260908223209.916758-1-chang.seok.bae@intel.com>
 <20260916225939.1144524-1-chang.seok.bae@intel.com>
 <51f6a0e2-25bb-4ac3-9b3e-2883ef7e57e3@intel.com>
 <66a43c1b-656d-4dec-95b1-3f56c9f9057e@intel.com>
In-Reply-To: <66a43c1b-656d-4dec-95b1-3f56c9f9057e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8850:EE_|SA1PR11MB6736:EE_
x-ms-office365-filtering-correlation-id: 114c892c-05a3-4229-eb07-08df14eb97e8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|4143699003|56012099006|10067099003|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: svTeJrSzgzW97hAylz3UZfn8gy9KKHf73PJKA6aOMe5PgW37ZgscPohh0UBPj3pIG9ftsF3IRsKTsVjLQTfpuTgZn747jHGXB99LExbIwi+P45cdW8KzNKw1p1LWKBKLy0LKJ7C2uFm+zPXz+KtLUpQezr5CDgavJfQTVitd0DVT1aKd2YCn0c7G8tuibb15WK6Kq+4Fqh7bob4ar+OkZBUBrF0kjvnaKL5Jut6D62Y3u54e+2KvMYWPZCZ1+u2IhSBrqthqn8ASCnOcZzk0B2496f3jJAeAkNTV9+vplFVJvNdIIK0QrZxhCKzha12GlTE6Hx1qAGCPO3YEGezG+BLX6bIxmweMvtUziq2pLh+woADPdBSsn/is/HCMgtzj68A3zGQKKhMs0gkruyoMFy8Caw1gDsj9uJ4GaHjtmuqK8XB+a3OEeRGwArmmtFOBYFf4+XxS+ff3fMhgHW1a9Zyzj+RGmw/dXcUCpCG6DR1VzJOdKbywxRTmm7XGt44TIynw/ZtL3I0yfGShklYXtaBjgD1ssupO8/rhXnHax6NDv5Ki8N0acQjQIES80IKnkckXoNRFn8YK7hImDSQLLVaMDgPRwcSvR5Kfsn0dv65h4v6hV/UzKUI4ApyOFt/QSJu1pmQX/CSLnYe3ct0OT1MJvialTyxG+EDWe6+5ZEAOD9RACdbVfSVVvd532XWIvxGRIBLM43+mxs4fJRDskoMowaLYQOnMc3Wu1Lg6hxQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8850.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(4143699003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3FXcDdpa0NydktkbjRMSU9wT2dwUklmMXJ1YzFrdFFHM1JDVmM1bmVTT0VZ?=
 =?utf-8?B?azdMYmFFaHRvdDgrK1IvQ1YrRFBhNytFVWRFMkxNVVBqckdoMTQ5WHVCU2FL?=
 =?utf-8?B?R051clM2d1k5c3Q3aG1XK21GMW5rMXhYVVpoaVo2ZFJwR2tKTGpXd1VZRllJ?=
 =?utf-8?B?N3VLVFEzQ05wdURYYUl5QjF0SUFuTjdlNk9jRmRmVEJJakN5bWFDZXFFQWVi?=
 =?utf-8?B?MkJjRk9RS2doejdMZlVRa2ZPaUJCT084aG9vRFlhUGU5UnRpVmZodlEwSmNt?=
 =?utf-8?B?b0VkTmlJVjBhYjEzS1NrenBKVDZEV3VWeUZmRmpNbGhLcjUxUUhkVGtoMWdB?=
 =?utf-8?B?MWo2cytlNS9mVUpLQmRNVk5WcWVJNkRKUjF3R2V4L0tlVmVEbGF4NEZydHZU?=
 =?utf-8?B?aTVpdG4xVTRRQllDZEF1ekV0S2h6NnMxQXdRSW5CUlpUaFJEWkw1Y3M0cVFN?=
 =?utf-8?B?Z0EzREZCeTNhZGJtZ2JDRTQ5OUQrUS9QM1ZrTUJISW1YZDBVV2c5MWw3K3Ry?=
 =?utf-8?B?RVBIa1lRcG9Mam81a0tQbkFHK2hrVUdkeVFJelllcGtDeURxd2doVE52KzVh?=
 =?utf-8?B?ai9lNlM0OFJ5UWZ1NFZ6aGJyRUdjRFNtOVAxRWhjRzI5dGpKVjBxRkpZbDRn?=
 =?utf-8?B?WDB2cVZORmtJMkpDbnhpSldKSGtBa2k0b1NWSUw4MmtsbmlSb052UEFDbDBs?=
 =?utf-8?B?cnJNZUNIN3Q4NlBtcklnMDBKQTRTVWo2TklGNm9FTm1OMjUrSC81aTJMZjVL?=
 =?utf-8?B?cm5ranY2VHVGZFlCd2tNcXFoSE8xdkhnS2lLTzZ0VlFaZzN2T1BLd2dtSEI4?=
 =?utf-8?B?aVpJQVlNR0JBSjI4MGhGWkNTSThOSnpieXd0MStJMGpHNmNpa2JVODEyQmpm?=
 =?utf-8?B?eVo4ZkRFay9rc2Z2V2gvT3VDVnFDOEtiUHUvTnlZUEhkWnJmaHJVTFlwOWRM?=
 =?utf-8?B?emNhbFo2NEFYWGkrWlN5Q08wWitRM2FhSEVYRUV2OGJWQmVyOHo0WWtaVFo2?=
 =?utf-8?B?WG40bUFNaG1ITnBHaDUyaS9OSi92b3FBUUd5b24yNUtZeFhTWE1EOW9ldjRL?=
 =?utf-8?B?endRK3JRV1VQZmpMRi9iWnlEbER3UHhIYW9UNVkyOFcrSHlkK2N6Ynpxd3Jj?=
 =?utf-8?B?Vy9YSElsa1hrMTdIMldMeitCUkMvMVpXN25SVG5VUmpCeEhxdHNBMVNvMzUw?=
 =?utf-8?B?QldNb1pWM014ZUFScndSTjgxSThuR01mNm1BS3ZRYU9QOFpSOTNMWDhNOXkz?=
 =?utf-8?B?Z05EaXdOamxBNFJPRExlUnZkM2pyWWUwNEFQS0NZTG15cEFQODBjL0NuMHFS?=
 =?utf-8?B?c2VUUnlwVFB0L0dPVDV5STVwVHJkbTJ5L2MyVEJjM0ZEbjF1RzZmSVhSNEN3?=
 =?utf-8?B?V3dlSXcvSTVaV1o1MDh6R1hkT0l3ZHUwSlhEdFhtTXlZdE1ZSjhuUkN1SHBt?=
 =?utf-8?B?bHF6YlNSZUdodzlJdmxqSlpuZEthSjhiMVdHa1h5ZVhIUkJQaERIbjZtRUhp?=
 =?utf-8?B?T1F5LzlhZUNRY2xwb2xCYTgraUxVYUsrdHFETUJDS21PK0k0WVVPYUtDVDl2?=
 =?utf-8?B?aEpDR3N2UjYwUDVSZjBtRERGekc2UjZ6VUlHbkRTdWRFZ1E4LzlKems5SUFW?=
 =?utf-8?B?dVVFSDMza1duUUd4SHFHZTJrNFN6L2FuOVlkWUIyaFVHU3lJZ0RyUi9lZjgr?=
 =?utf-8?B?K1N4bWowMjM5bW9DT0FReWVaRmw3bTNJRVFLYnR6SUQwODJaVnBCZmlOVk9K?=
 =?utf-8?B?Ymd6aHB6Nm5FK2U3R04xLzNLak5JVVp2akt4b1JGaG1ycXl4a1BpTVRzQWh1?=
 =?utf-8?B?RzErbFNTSnB4VVlEV1AzVC8vMkF6eXNKeFZ2bS9ML0tRRXlrQnVaQXY0TXlD?=
 =?utf-8?B?V002Z1JEaTdva0VGZ0lHWjdTOWdFNzV5QnF6OGdNRWZVOEpNSWdWMlU2dWNE?=
 =?utf-8?B?THhmM1lQbUc4UThPUGxJT1lxcnBoRHNTS2Q5ZUxiRko2aXg0S2w2M3dTbER2?=
 =?utf-8?B?anEvMXhqVHpoM1NjNzlTQjE3QXJTUTVzdU10QnNsL0o1R2xyMkdNRUlKR0I4?=
 =?utf-8?B?OTBSR2h0QjFNS0w5TnRyTDBNKzRrc0lqUHlEZnIwcFAxcGJTUjhvdzgvcW5r?=
 =?utf-8?B?SUYvb3pCTU9tK0VBL1ozQjAzUE15SC9la2xxdjgxbUVlbDNhVmY2SzIyMlFW?=
 =?utf-8?B?eHVhdGRSbDRMRDlmODJLNUFON1FkR3lVQ052SS9vcHlmVkR4M1V1MysyU2w0?=
 =?utf-8?B?YWxiYnU5aGtwajNqb1NyQ09zK0F6OXRGL014dEd3SjJoajE0M1BwM3lsRFJD?=
 =?utf-8?B?L29kNmhFU2hJWWp2TzEvOG5WWkw0RVJWS1g4REJMVXU0WkZyTmlFaW9IVmtM?=
 =?utf-8?Q?AYYGZHzR5w7g4ci0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 2kuJ0y3Sn77udm2Gn4tED5mgJwLJZhw1Bm1ntNt0bvFS4DQk+EEnMFtqzyU2V6g5hH1rrzHAriU8HWyRPKSdKW72IR2rSm+hq803ZR5WBNr94k6Dn/FjegbW0MJQXpKvrGBx6Rx6dU0iqHaw0QuEWi8s5hBaW8mTKtr9GlP624p4hZYJQxGapTH+MjzKv3LssZ3uKarpkQ6+rHbsGVpWiuLxzho2/Zr3/3eLl+NIknTOpEoo5qCTCDHjgo+tQkjlO5tsuT1MZjvxJyVcpqtyNZB+3g/LBahV+VSKWe2FwXLjC0dQfpmRrl65nOQyyhhj7OmjvNFF04Bpe483pHCJnw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8850.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 114c892c-05a3-4229-eb07-08df14eb97e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 18:43:40.8230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6VfFvbVP/alW8wzau17S+yXBUpwZ9cqnRU8D6pKTvNbelRE5ndFyRJBlm/I23sLxh/UYzU6w3usxG+Ft0LzU4VGKzbqG22vq9EF/qmRpZl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6736
X-OriginatorOrg: intel.com

IA0KPiBJZiB3ZSBtb3ZlIHRoZSBjaGVjayB0byBqdXN0IGJlZm9yZSBhcHBsaWNhdGlvbiwgdGhl
IHBhcnNlciBtYXkgaW5zdGVhZA0KPiBzZWxlY3QgYSByZXZpc2lvbiBuZXdlciB0aGFuIDB4MTAw
MDQwNS4gVGhlIGFwcGxpY2F0aW9uIHdvdWxkIHRoZW4gYmUNCj4gcmVqZWN0ZWQsIGFuZCB0aGUg
c2FtZSBibG9iIHdvdWxkIGJlIHNlbGVjdGVkIGFnYWluIG9uIHRoZSBuZXh0IGF0dGVtcHQsDQo+
IHJlc3VsdGluZyBpbiB0aGUgbG9hZGluZyBwcm9jZXNzIHJlcGVhdGVkbHkgYWJvcnRpbmcgd2l0
aG91dCBldmVyIG1ha2luZw0KPiBwcm9ncmVzcy4NCj4gDQo+IFNvIHRoZSByZXZpc2lvbiBjaGVj
ayBuZWVkcyB0byByZW1haW4gcGFydCBvZiBibG9iIHNlbGVjdGlvbiwgd2hlcmUgaXQNCj4gY2Fu
IGFmZmVjdCB3aGljaCByZXZpc2lvbiBpcyBjb25zaWRlcmVkIGxvYWRhYmxlLCByYXRoZXIgdGhh
biBiZWluZyBvbmx5DQo+IGFuIGFwcGxpY2F0aW9uLXRpbWUgY2hlY2suDQoNCg0KQWdyZWVkIHRo
YXQgd2UgbmVlZCB0aGUgZWFybHkgY2hlY2suDQpCdXQgd2UgY291bGQsIG9uIHRoZSBhY3R1YWwg
YXBwbGljYXRpb24sIGF0IGxlYXN0IGNoZWNrIGlmIHRoZSB1Y29kZSBhbHJlYWR5IGdvdCB1cGdy
YWRlZCB0byBFWEFDVExZIHRoZSB0YXJnZXQgdmVyc2lvbiwgYW5kIHNraXAgdGhlIGFjdHVhbCBh
cHBsaWNhdGlvbiBpZiBpdCBoYXMgYmVlbiB1cGdyYWRlZC4gVGhhdCBpcyBhIHNpbXBsZSBjaGVj
ayB3aXRoIGJhc2ljYWxseSBubyBwb2xpY3kgKCJpZGVudGl0eSIpIGJ1dCB3aXRoIGh1Z2Ugc2F2
aW5ncw0KDQo=
