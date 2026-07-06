Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10355389110;
	Mon,  6 Jul 2026 22:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783377199; cv=fail; b=XmAYIiKASK/99qDWSiUI+RhtLBkJ1WDGV3+Fnh3zN96FTsI9CPaz5JdPZXaEjpXaWYLxvoIdPA+hmrljWT061gQrsUXSR4pZxPKVRBRt/v8ufPqgIAFAc/QPIXBzHLtUDkmjaGHPnSFbkhII4i1H5xaiQoSde07acoMLzq2OrBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783377199; c=relaxed/simple;
	bh=BRGrOWZwRluRKviGTNDr888JsmAYfq54O7m2SQBg2JM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GmEQalFpCvSUt7tIcI5IR3axdNMGBjqW4BcFCvF9LtKhbTGC2AvPQcn4GJPg8LiBB7YUFhMRJtX2J9/81Man9m8wviDNNjWI/AfPaNQV8W3eBcjiq8EYjz4IcWxPwqNVvzkDNE8OoRdyL7GllvyeIFfT5aGraXobXh32+6J2f/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=enBoiwAK; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="enBoiwAK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783377198; x=1814913198;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BRGrOWZwRluRKviGTNDr888JsmAYfq54O7m2SQBg2JM=;
  b=enBoiwAKAPWWvVaAe6EZJLBhN0bK45iLAGa8ohLkn6XXuLny14yqHek6
   Mcl+MXwiID8lmlW8BNWZ7VgIUHnqmrmwjDJTaKccd5dm4sfll0doocDCQ
   m7moo7A9nUk3dDxbI/SF2N3e1Z0/dJAPhUxAc7T/DtoncKl+wjRH2V9vA
   g2RHCA4UOIuPJ7bAEA0YqpzEhbEYTECuVi0RFQVZe9YPsCTSoJy6dgyuT
   TtTFeC66mGNKroDXyuFl7+Zxkc5Iimpi2xinm07e3DSZL/H7RuBFtFUoz
   cxfLifiyxg2PChXurVh7Df3tdz1KFfsA4rX4dSraNFGx+GmnZpEiVq+xE
   A==;
X-CSE-ConnectionGUID: hppXL/lvRiag+s31pbCDuw==
X-CSE-MsgGUID: K0Q1yNJ0SSqCFF6yznf16A==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="94377285"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="94377285"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 15:33:16 -0700
X-CSE-ConnectionGUID: Hf8KZdpOSbim0xNhLT+h9w==
X-CSE-MsgGUID: S5FQUaNrRkCNr30KCVKPQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="250480468"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 15:33:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 15:33:13 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 15:33:13 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.39) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 15:33:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Osudx4Ct7fzeF4zyCvEta/DKM2iTBBlIYQ+Jl5YH6rlq8y8q1Sd06DlGqEA5zYdBwz7Bum76HAUVsovHL/ns81D4E4+zKQ/hwKFOj7bvM3c4dHrZVvqFK8PiFgr/aZwt8YcNNQJlBM1ySJfmm4YsIblsg5zw68HNMwkwMRPM5EI+HXv1bM/Io0OxV449G/gly9HvLwlg6r2mHTcyJoCPCe4gx2YfI14HmXWC6DkDlZ/aB1IU3YqnL9+0V844v6LxgmPUocKdQK5hIGzsq6K5l0sJEhGs5JoF3ZtZ6M3St/KzngNTkxqYlxgIFAJE3pnSX+68k8F7DTvSCKw/0wOzmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRGrOWZwRluRKviGTNDr888JsmAYfq54O7m2SQBg2JM=;
 b=xbwN0RGbk2TNHaw7YA7HY9Bg5okI1mhpUBTavcDW9F5K2/SOJYc4nqWMi8HaKzCCXyx8aObj6Qs5wm8lj3rIbyIuJKkKvmGwAoHLt+zjGFFqANIi8NsqouEOVdLkql+j6+Ua/DUTferoI5vrff8P8hpYE6dLW2pjYhND3ie21iTknHcH9aUFD7925wu91li0lPpZsxJFsYW0bkFQPGn0ESUiPpQQZBJGBzsWm0pwXTNKssjB6ThlhGxF0TmXCoVsXDmMlytYIZZbxhlzJhdDJhKRsvGya0t6STw/Bemo5SY1UvHXirl6lC4FUtnylUFGBO/Em917uvpqTX/cW2BNfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4691.namprd11.prod.outlook.com (2603:10b6:5:2a6::21)
 by SA3PR11MB7627.namprd11.prod.outlook.com (2603:10b6:806:320::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Mon, 6 Jul
 2026 22:33:06 +0000
Received: from DM6PR11MB4691.namprd11.prod.outlook.com
 ([fe80::5d52:baaf:8c72:ba5d]) by DM6PR11MB4691.namprd11.prod.outlook.com
 ([fe80::5d52:baaf:8c72:ba5d%6]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 22:33:06 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Wang, Zhong"
	<wangzhong.c0ss4ck@bytedance.com>, "zhanghy@sangfor.com"
	<zhanghy@sangfor.com>, "shixuanqing.11@bytedance.com"
	<shixuanqing.11@bytedance.com>, "bestswngs@gmail.com" <bestswngs@gmail.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "jasowang@redhat.com" <jasowang@redhat.com>
Subject: Re: [PATCH v2] KVM: x86: Destroy the PIC and IOAPIC before destroying
 vCPUs
Thread-Topic: [PATCH v2] KVM: x86: Destroy the PIC and IOAPIC before
 destroying vCPUs
Thread-Index: AQHdDXGHmWBSyPf6DEOzA+pP+a140LZgzV0AgAA/NQCAAAD8gIAABmAA
Date: Mon, 6 Jul 2026 22:33:06 +0000
Message-ID: <82a5be971c5fbc90133f394fba9c7dd5c19fed91.camel@intel.com>
References: <20260705045450.1325048-2-bestswngs@gmail.com>
	 <20260706180025.2735341-3-bestswngs@gmail.com>
	 <akvx7que1BE5DY-O@google.com>
	 <51b8068149510179f59901b439e5f393c7757760.camel@intel.com>
	 <akwnx1ovr-Rkl6q7@google.com>
In-Reply-To: <akwnx1ovr-Rkl6q7@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4691:EE_|SA3PR11MB7627:EE_
x-ms-office365-filtering-correlation-id: a2a0ccc9-b6ac-4d39-90dd-08dedbae8c87
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|11063799006|4143699003|56012099006|38070700021;
x-microsoft-antispam-message-info: CeaDrm+m9Qms6cudrhXQKiDM/5/MH20Sssw/w2DwOYCx9Rhi1RaRl+4Jnw0QULU31d47tIUq9lVa2ra4CLmC5lx+ddnklKzV4dO7KoQ4tnLTWLHuBnBt4Le+zR/vZy7IgbyXInXqlRJFlphRDXAX9kX0Yw5EAP6f09aVn5Gw+y+4YMNh2kHcaxrcPE4JIRzFx2d4sXJ1BqzKh+2EgRPUpdS6G8VVYj2aizsshlTeu2i3hTa25vrFsAE9cAwxf7c/9fKkGy56/4H7VU4NYqgxTmLOzFJB61PXMO7JVYlLh53UZyo/ATViB9c/1QUUl1c/HbohXahAuhPSnjsSrAbpP1EyZvPxSwkeeePH1Olnxc5UV0PUjJAAGLeic0mtxrWU3Dp52l16See9PUSE5Fd+DYs5d0VILeSYKxx8Y1CuHSalwlOUxrKY+NGm8waKqo5iCVmmkVfD+fWOkOnfH4X/kFGdKhIzjdYckDcFwzuontFPrn+l/Pmz2V1pANpkjbgCodKwhT1427B8k1SPVxisAhG3bvl2vLsOkYh9+frybE0KUjotX9OMJkNBWfSvzkszSZkSGGvAfCXX5H/bDsEZougRqkWLpTyaSyY0akpOd3Rx+g7uTEw8EKj+qOH0cVwUYEYkPH9xMVFB2lG++7xpWibF+HDK2muyPgXGXf7Gtw1lISgdCerrnXoSxAGXw0oAd542JwrvDHdfG2Eo0nBF+Oehqal+cFDjsALqKgUuH8A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4691.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEtRYTZDQ0k3V1pyWTNzSE1IM3pGS3VCWkdUMWUrYkdYZUdpRHhyak5OY1RL?=
 =?utf-8?B?UTVMNlhXaVRNRGY2QXhBZDhCbHlBRUlyRGIxd2FLZTh5MHkrTlNERjZjSkpm?=
 =?utf-8?B?cklHdzlLS2NibE5TZFdybnNNSmpiUVBFS21MSDJmSWNlRHhaTURYbThWVG80?=
 =?utf-8?B?REtBbUtGY3psMEZvLzZXczhsQWpWM2MyWjJnK3pSR25BR0VtWEdtWk82UUNU?=
 =?utf-8?B?TEpWckhvejhreUlQV2lxcThwbnR2L0M0dUQwRVpJWkZoeHNsU2s2YWxWTnJO?=
 =?utf-8?B?Z3hWQnBZZFNabUZqQkl1SHZKSG1BRHlrYmR6N3Q3Q2FERjRCL29xemZqS2Js?=
 =?utf-8?B?ZjlYNnpNb0RGY1hwRlpBZlIxZHh6V3RTb2ZpZjBWWEMwUW96Z3NlUWJyckZx?=
 =?utf-8?B?S3hySnMyT0U5LzYzWW1yRm50Qkl1RnRTdHByZVFjVE1RQzNNV0E4RG1lUlMy?=
 =?utf-8?B?dk9acHg1UEc0VEZUQkZWQnp3dkNhWDM1V2dFU3FraUFZTVJGQ0RtRjAxY0J2?=
 =?utf-8?B?bUQ4MWxhQXVpdGthd1BHM1JKUjlRSTJ1bTh5UFBKcElSSjBsQ3BhUWliNW5t?=
 =?utf-8?B?VEFHbHh5S21hZk9sNWRuZFQ0Vm5TQ2UzbUVlR20zZ0VBUmZnWFcwbXV5Mm9W?=
 =?utf-8?B?MTRZSW1CUStzL3RXdjBOVGxlemQzVWdDcmpZdEN3aHJiTDZGcTRNbkdEMEFs?=
 =?utf-8?B?d3YvbFEyUDZNVlloaERTakpDTU1IM2E4dzIxQ1oyWW9jcTIyQ1d1dUtTSTlL?=
 =?utf-8?B?TXlZRFdkNXBFdXZpL2laZVVtdy9OcE5GUGVSZ0JaYVFpYXZoK1I0dXBVcnhq?=
 =?utf-8?B?Rm42b1Y4Zi9PRzZpNWJ0OVVuU0pMb3I2Q3ZMYjVwZC8xOHg5SzZ0TE1tREVs?=
 =?utf-8?B?OExreW1aZGdRME04clIwM0FhYlF6b0laeUcvdUU3WUppaDlNRFRYOU5NN21X?=
 =?utf-8?B?WUx6WTF4S3JCdlVJbTVnUTA1WDR6UmpXMDlUeHhIZnNpWUIxeGkrN1Z4eDFh?=
 =?utf-8?B?NGtxU3ZtWlNrazJ3VHdsUGJrdzNtbW1pZGJRYStVMXU3MkxRRlJXS21SR2U0?=
 =?utf-8?B?YXE2REM0cWc5Qm16SzVWK01yVXNUQTB6UDBFS015WFk4QU8xYWtjdzVERmJM?=
 =?utf-8?B?MlhBUVI0S0FEWDQ4M29MVXQ4TjhJWU5qY2tiZVJqMlFqY0xoR1NGTUdXRzMv?=
 =?utf-8?B?b1NpcVkraHE4Z2ZmZGdBNXpGRFcvWEZSZUZuODNWNjJsV29rT1pWRkEvR20r?=
 =?utf-8?B?aDllTGl0NFZYOWVsalBjaEg0WXBaMjFnZjhaUG8vTW5ab2Vna3pRUEk0WHBM?=
 =?utf-8?B?bGVoVFdrSlJUQ0dHNUkxVndNdU16NFI5UlRZZHBPVXprcUl0cDRFZll4NCtV?=
 =?utf-8?B?cll3OGc5eThBZVRiQzVxYkFUT1E0TnQ4b3EyVmZvYmVnQUFlbE4zM2c0OS9W?=
 =?utf-8?B?aTk2R0FBTThhZmVDVmhqc0d2Z2FiYVhwMEtuNUdPNHBZL3Bkekh6SDFjVjdH?=
 =?utf-8?B?T1ZrM2l3T3M2YzJsTElJR0JLNmFDV2lhRHphUTRvTk5CT2xZSy9kNFBTSGUw?=
 =?utf-8?B?cWdJVm1Rd2c5VjJsb2orMkkrWWRxRWdrSVpqQVI1bnQ4MVJDdGh3WlI5NUwr?=
 =?utf-8?B?eTZwa29BV3FEWUZvWW5mdmpPY3BtczdHRDU2aWRaSjF2Y2pMVVh3N0xlZExy?=
 =?utf-8?B?S21CQjlocGN0TEJ5d0FsVGFSN3lSWVdnMVREWGwyY3JPSFRsYmZpcnlodEM0?=
 =?utf-8?B?S3JZVi9ySG90bmRqdGllNzByRmNNcFA5MGhmQ1IzdVpmbGRxLzNSWG1kUWpv?=
 =?utf-8?B?NjBYRnhmQnFsb1gybU9zbzd4UzJJOTNab3R1czJ6QVIxekJHdTcxR0tiSmNk?=
 =?utf-8?B?VWtHYWZyYmUweUpWeHRMQlFpbkJOeWV1TXo5dTZNOGpHbHE4Q3ZtMTBZcW04?=
 =?utf-8?B?WElRLzlnSnVvM1o0bjRFSnBHVlpZTEY2eXJmSlZkdGM3ZFozcHFFc3MvVFNi?=
 =?utf-8?B?K0JwblUzcklPWXZjR001NUc0Y3hWQ3FtOVB0ajZmQVl1dkRqN1pscDdKQVJJ?=
 =?utf-8?B?R3lINVUwbHRqdFhDM3RORGV5ekVwTlJZOWNldVZxWGVqT0RPQVpPeFo5NEFH?=
 =?utf-8?B?VHpwL1l3Z1JEc3J0NWptT0lCMjV1aVVmKzNLQTh1MEdwYkZHdlFlQ1lCMnRV?=
 =?utf-8?B?b2hmR1d4bDBtWHVEWDlZc2gxSTBLVDB3RzZiekpOd080SE0yckFVV1BiWFIx?=
 =?utf-8?B?OTNucy9uc1U4K3R0cXllRXhRYVlZeFl6SkFBaWtUYWV4bmxzOWRvUTk0L24r?=
 =?utf-8?B?eWFlM1pjaHhGa3hrbitORlNkdU1yUkFIK2ZyQ3A1VE1yTFBnYkFIQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E75B2F5355852846B57F79A3F3C7C26B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Yt0V+EjmWDR2h2qsRDL+Y8sqR3VcwZ0XPFKmgX2YjogYesfCZpWRtx/IWuByXbblLoTMUUa1hT94tmukV5ev/Wev+E7NTZcmrpbaemEO0NWAMNXRFhoVuEq5l2LuY8ga8h+fhPxU2reeln97vpUTYpCJkYeBa+48fLnR7sH2Lqz30uFSuVqcYWRWVt5Aqeht4888+yM891jUC4Z/vCMDd3lAV5THIZFBs6HcvF86qV6KvCaBdQHZszkYyQ3WD4R2mB7VfrFVnJO84Y+5RnIa89jP36UVy3OUdHd5RBYF0dn8dtoa78636vEerjcsM/5Z1AI00iGFbRZmXE01ap+tjg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4691.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a0ccc9-b6ac-4d39-90dd-08dedbae8c87
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 22:33:06.1507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J1tOk7Id0p0HUm3tc+qXtH20SwvwQv667ngy83ieJOzeucTaxb+X7rcbnOlslXtD3tJ4gYn/+Kgh7OOy0GXtrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7627
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA3LTA2IGF0IDE1OjEwIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBNb24sIEp1bCAwNiwgMjAyNiwgS2FpIEh1YW5nIHdyb3RlOg0KPiA+IA0KPiA+
ID4gICAgIEFsdGVybmF0aXZlbHksIEtWTSBjb3VsZCBzaW1wbHkgZGVzdHJveSB0aGUgSS9PIEFQ
SUMgZHVyaW5nIHRoZSAicHJlIiBwaGFzZQ0KPiA+ID4gICAgIG9mIFZNIGRlc3RydWN0aW9uLCBi
dXQgdGhhdCBnZXRzIG1vcmUgdGhhbiBhIGJpdCBza2V0Y2h5IGFzIEtWTSBleHBlY3RzIHRoZQ0K
PiA+ID4gICAgIEkvTyBBUElDIHRvIGV4aXN0IGlmIGlvYXBpY19pbl9rZXJuZWwoKSBpcyB0cnVl
LCBhbmQgbmVzdGVkIHZpcnR1YWxpemF0aW9uDQo+ID4gPiAgICAgaW4gcGFydGljdWxhciBoYXMg
YSBiYWQgaGFiaXQgb2YgdG91Y2hpbmcgVk0tc2NvcGUgc3RhdGUgZHVyaW5nIHZDUFUNCj4gPiA+
ICAgICBkZXN0cnVjdGlvbi4gIEUuZy4gYXR0ZW1wdGluZyB0byBmcmVlIHRoZSBQSUMgZHVyaW5n
IHRoZSBwcmUgcGhhc2Ugd291bGQNCj4gPiA+ICAgICBsZWFkIHRvIGEgTlVMTCBwb2ludGVyIGRl
cmVmZXJlbmNlIGluIGt2bV9jcHVfaGFzX2V4dGludCgpLCBhbmQgaXQncyBub3QNCj4gPiA+ICAg
ICBoYXJkIHRvIGltYWdpbmUgdGhlIEkvTyBBUElDIGhhdmluZyBhIHNpbWlsYXIgZmxhdy4NCj4g
PiANCj4gPiBIbW0gc2VlbXMgdm14X3ZjcHVfZnJlZSgpIGNhbiBldmVudHVhbGx5IGNhbGwgaW50
byBrdm1fY3B1X2hhc19leHRpbnQoKSB2aWENCj4gPiBuZXN0ZWRfdm14X3ZtZXhpdCgpLiAgVGhh
bmtzIGZvciBwb2ludGluZyBvdXQuDQo+IA0KPiBZZWFoLCBJIGZvdW5kIG91dCB0aGUgaGFyZCB3
YXkgOi0pDQoNCjotKQ0KDQpCdHcsIEkgZG9uJ3QgdGhpbmsgdGhlIG9yZGVyIG9mIGt2bV9mcmVl
X2lycV9yb3V0aW5lKCkgYW5kIGRlc3Ryb3lpbmcgSU9BUElDL1BJQw0KaXMgYSBjb25jZXJuIGhl
cmU/ICBBcyB5b3UgbWVudGlvbmVkLCBvbmNlIGt2bV9kZXN0cm95X3ZtKCkgc3RhcnRzLCBWTSBp
cyBub3QNCnRvdWNoYWJsZSBmcm9tIHVzZXJzcGFjZSwgdGhlcmVmb3JlIGl0IHNob3VsZCBub3Qg
YmUgcG9zc2libGUgdG8gaGF2ZSBjb2RlIHBhdGgNCndoaWNoIGNhbiByZWZlcmVuY2UgdklPQVBJ
Qy92UElDIGFmdGVyIHRoZXkgZ290IGRlc3Ryb3llZCBidXQgYmVmb3JlDQprdm1fZnJlZV9pcnFf
cm91dGluZSgpIHRocm91Z2ggSVJRIHJvdXRpbmUgdGFibGU/DQo=
