Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742113A8FE9;
	Tue,  7 Jul 2026 06:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783406613; cv=fail; b=WmX1fUpTuAoq75YPJjiRk76CVQAcXBvJPmyjRbrBXsx16uWN45i4hDGwP7bojukgBbLkSU0Cuo4q2pmNZAebI3J+AH6nlp5qYyhKH6Asj1lzrzNF61ffrarL5HcF6/c/xh+eLfl+P9Biw6yitfT+WHsn9kfWJSvPrA3NA4q6zaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783406613; c=relaxed/simple;
	bh=sjna7FDUEvpw5qb3N3jwj0yI5FjB/hSgPt9krn53GFI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rqCjb3WaFpV0nx9ZaLvlQrGK02LGkXmY9ySyVi8rPbscGm5mjaNpeUidc8O/d4Nu5nS4X8GPmljg5tRGf7/z231EX5oMqYlxFmwKkgZQyTrthq1TXZVtFZtirVFtv9u3+UCBtViXdBZgEjp3fJxzzrPgiy4EnfYpU8OgtRBSJc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ASLIFDvk; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ASLIFDvk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783406611; x=1814942611;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sjna7FDUEvpw5qb3N3jwj0yI5FjB/hSgPt9krn53GFI=;
  b=ASLIFDvkdIT8A4MtnSpBXckHFBmAMDnwag442Y9PCrnLUriNYxL6yDwD
   ygI0GrelSvNpSKgYIbJCDyb0uk66S1QHVo5LhZtyUMGFqSXOlr/GOcGko
   fybMlktC9uj53VDKwYoAjysNQ0+REwi8DzgJAhwxTWAYe/3q8dqsSfRm3
   CwOoY02hM8XDktwv2RBq1aKg/lP20jmxDeSN8Vbeqmk8TDrEsh8ZhIlMw
   LYg+j93VAW+R68CXxrTYAcglc9UvzpUUqCNQ1AVGvJ20YRpHW25AWORJ7
   i4whV/20+WGZeO0Zor89LguwEOOCK4qOeixrGIkTONgptBmx1GXHS0e+F
   A==;
X-CSE-ConnectionGUID: +yRUnlWSQkOTrUXI0npZkA==
X-CSE-MsgGUID: L20xrdh7SzOkna/81DXcPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="84166154"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84166154"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 23:43:31 -0700
X-CSE-ConnectionGUID: AzO5ZjmYT0qOmUe23/O1jg==
X-CSE-MsgGUID: SllLcCcARjebV+srQJOOSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="277127797"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 23:43:30 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 23:43:29 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 23:43:29 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.6) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 23:43:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NOeDwVdjlSiOgQU8oh0DazOlQOBT14mkkwFYkvRqBeKjbjuHwmp/E+V9gl5YlyJPNY51Xbv8YCGCCz/aksHAluwW4x2n/pnJjvSQx+fl0+is23XSpiMWyjNvfQJY+6nTdhQgJvWNJf0x6Pg30LN4Ltojy2h6qHYhqk/RLGCofcjZfU7/mew9p6xyPJizgMP7vqJ4ICzrWcLVUkuRHmx+34rJ5sAKg2daHhgArYHN7hDbdXHdz1xRsOsAy0IgsAtIgLpYFYHhY3qAmE1nQWdUxR9kw/KfeOBV/2Vpro/7Hz8KpN28OUj+RLw0jVIcvajh0YsnRakmJ1rVE3Tqzg8gcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjna7FDUEvpw5qb3N3jwj0yI5FjB/hSgPt9krn53GFI=;
 b=Uv5MUJ2SKwtChDswXtHw+wqi1lW0ZbH6YcmkQnT9Zd4bGSvKFI/8fUF3K+c8GhpfcXhtW98eJnzks4/r6hGLZkIuHtB6VFdbbVyIBt0R3SPzLonSL8+xLQSqzg6f3Hm0JvkFSGuvo863pnyF6E77z8CG2FY/z//vTXhU1Z69pM3BqGhVNQQ9Pk4BX7fsab/7iYHBWnuI/n6SgA6EFb+91PddPyGfnOv0mLEzenPa72ktcKPIxV+g15yMgcv2EjFMCR57+85tGatFvemCQ58p00/Qp+F6GOTuws1sic8VreJPpOMPgbFURtJRJS45vDffZ9Y7uNFBfdzN4mNyCRf4uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by SJ2PR11MB8516.namprd11.prod.outlook.com (2603:10b6:a03:56c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 06:43:20 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201%6]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 06:43:20 +0000
From: "Usyskin, Alexander" <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Arnd Bergmann <arnd@arndb.de>, "Nilawar, Badal" <badal.nilawar@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Adin,
 Menachem" <menachem.adin@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, lkp <lkp@intel.com>
Subject: RE: [PATCH char-misc v2] mei: lb: fix incorrect type in assignment
Thread-Topic: [PATCH char-misc v2] mei: lb: fix incorrect type in assignment
Thread-Index: AQHdDUrmkAgWnA8ZpkaOjxvzrrmKn7ZgjgaAgAEN9YA=
Date: Tue, 7 Jul 2026 06:43:20 +0000
Message-ID: <CY5PR11MB63665C97B337ACAC21A8A626EDF02@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20260706-fix_type_le-v2-1-586826351454@intel.com>
 <2026070608-reformat-pungent-aeb4@gregkh>
In-Reply-To: <2026070608-reformat-pungent-aeb4@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|SJ2PR11MB8516:EE_
x-ms-office365-filtering-correlation-id: d6a14eae-8137-4913-6744-08dedbf308b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|4143699003|11063799006|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: Aqh1VveV4Brz+u9kRDc2wDbriKL/ACFkqL1VeZaahCfpSmk80zLAma/Na0wVkM8S/jBrJ9sOLhWte/nzTAfJ5CWcRhKY6aiFoacdQoCCS+Lr86WCJKF3heL+qmdH1JTCHrzZ5QIhM0gP9EQuWVfURCCUYKoRZ4etR8X2qK3rYMfdXuaEm2OOI3Cu9HwY30O8F95qUgxdnHpAhTvBit+Fcx9zhrv8WscJF6jjFJwXJbZCHNENTtU5v3gJwtXiTf23Hm0V46vMGoR+B7FHp+io4QnYHPfkBE1xbenMgL5LEJw+I22eKw3GrN7qiZaQP2XinpYu4vkTWOQECfWkHcUcRAGfYP23CDGBFPBKzzL3osCvxyxWPWXPj0eAFLrS0vP0V1UUu3VmF6r9xx/8eA7713JZbpEYx3YvLGv/NIFLZFTq7pmsaDAOd08P6pchRj+nw7RDncHHoUu/MUWENqInYcqgBekXhUxR/X305IDWpuUQ5gcmqrj+SE5LCjxS/cXy03j/PUzgLD4gZVe6YB4ZJfe0Z0h/Wz4pexWhmbJZGIdHGkCL4b+iegcEe5GBIO/PqHAPOjrLc2yc5V6ycp51PU6YB91vRnQlZNpTX9ncCidNHSD1lJK3/eNNk4sqPGQb0/LLzEpSqsa8R1NaCeVOQlO527ROT293f5Ki7MwfxG9lxWGjlYoHIMFibDo3yu/VHJL7qsGAgcT8AiwdMSvzDxNtg5GaeQ33GWtjx+bpF3k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1ozaDJLZDZQSzM1ZUF1RTUyYVZxbjNKOTBFU09YY0ZyWmYxUzRENGg0Rngv?=
 =?utf-8?B?d0dndmhUU3htVm1aTXl5UWY1NThhUUlTNXlqRUNKOUJZaTFDQThkdm1YOFB3?=
 =?utf-8?B?aGRvcGh0VHU4NEtSMWFCVW1Wbzk3d0tjaXlTOTN3Q2t4RTV4UmU5K2VyNzVj?=
 =?utf-8?B?YnlLbGJUUTk3Q0xweFBFY2U5TzJ3QnljTVJ3Q0VONWIxQXE5NEFqQWVYa05i?=
 =?utf-8?B?cUtTVDRXcDJqU0lNUjlqRitFR1VLeEZkbU1GVmtTaTNsZG9NNGZ6aWdRMGlh?=
 =?utf-8?B?VVFkZXBvNHFCRWlVSVBlRXY1WmRCcGpBMVhESzYwWWlMMFFzenVFb2xDaXpz?=
 =?utf-8?B?a0FRUTZ3M2dYNUd3L210QjBZSi8zdlRQL01Sd0pUVE53QTVhdExmM2dpa3Ns?=
 =?utf-8?B?TDN0VUZTYTQ1UE9WdmI0dEZLQUNtSXdCam9kU3h1M3B4MjZoUHZ5NFpVRmdO?=
 =?utf-8?B?eDl5ekZRUGZVRld4SzY2dGJvR29tUklERjJveVRxcUxFQnppMEN6bjVPZlY0?=
 =?utf-8?B?N2g1dHBZUWVPUTlBLy91L3RYcStMZUxHR0dkYzNGalgxQ1pDbVUvL3pBZjVy?=
 =?utf-8?B?ZFBJL2c5U3J4NXRVbVV5cGNBZ3UrZVpQK0IvbTE5WGs4ODdKME4vNXYrNDJW?=
 =?utf-8?B?U1VxNCtleFBBdHJaUFQyYURGeUdUbUM5NDc1Zk1UTWNpMGZSa0kzR3ZEcWo5?=
 =?utf-8?B?UGRkcXhJcEpNOFd0ZC9GV2xxWlJ0c1FoRmh3TFlwV0g0OEZJVE1XZHo0MmVR?=
 =?utf-8?B?ZUtYcnBiWjdFY2MzLzlheThpdXQzUnVsMGplMHdhVzR1am1QTHlxT0FjZGpm?=
 =?utf-8?B?TUI3M2NoV3JkQ2pyOTBKYVFPUENsTXFmYkZ6WEpGY1hsOXRpM2w4MVJtZEpw?=
 =?utf-8?B?dWNHMDJzVUJiUmtQaGNXa29KUmtsaHVmc1hTR3EzOVNhOFdsUUJiVU9lVjFh?=
 =?utf-8?B?R1lkMU5ZWEdqcGZkSUdmYWhkTzNFOU9xakxaMGUxZldHWFZXc3BMaGIvcDJL?=
 =?utf-8?B?MmtIZ0N3SldnK3hvV0hkdTdYVHZDSklaWXliNjkwOElrM3Azb0dVZktlMnVT?=
 =?utf-8?B?bExKajBzQVR1bzVGaFFuLzBBbGRZVnhMV0JPK1NFd0RsWUdwMVRHZjBHRldH?=
 =?utf-8?B?ekZDc2JaOTI5NFNmRm91UjYwNVF3NUdXZzcrdFdlTmMrQXlCMVB6YnFwTkRL?=
 =?utf-8?B?SlVoeGJnelNWNnRjUi9FdThmWmJ2Ymd2RGVBdzg0S1F6QTFMbXA0d2czNjdZ?=
 =?utf-8?B?VXo5SlAvLytYWk5CQ0FPdElUVXJXYUtwajdtUFBOTDFjV1pzdGtGZTZ2RWFy?=
 =?utf-8?B?Z21tRTkrbGM2U0NnWlJnS0g2eWVQY3VOaTRLVVlubW5qVE1SS1oxUzI0UmNH?=
 =?utf-8?B?L25xSExMaVQ1M3NVMGYwb0VsUTBlTVhHNTR4ZUFTc0o5eUV5UTA2VTh5N3Jp?=
 =?utf-8?B?OE96aHAxUFJlOGNGc2o4NllHYjYwVEFiV2RZVzZ0QndNUmE5RksxdnpIbTdJ?=
 =?utf-8?B?THpoQmd2cGk5N0swV21CZkVRZDVMeUk4T0dHckZFUEVvWDEwZXhRR250MTBX?=
 =?utf-8?B?M3hUY2hWMUkzYXkrdmpNdVBVSkZ4bUozWS9sMXZQN042Y20xb0Z5cnpIQ21w?=
 =?utf-8?B?aTNuemNTc3grK0ZjR1JJVUhJb1RMM3hLNVdJSnZwUFNjVnVZRE4xSERVbHNB?=
 =?utf-8?B?TlV5S1NUcDZKZUMrMHNGSmR4YlNmakhSRW5Eb1FJZEZ0RlpmUjVwS3h6Smp4?=
 =?utf-8?B?cys5dURRYXd6NkdtWk9Xam9mNVpuQU83dk51Q0hGdmdGZEt3R3FnRXJzVTVX?=
 =?utf-8?B?U2xFTUxBc0dmb1FqUFJES2o5T3hndVlvNStvdzl1eDJWOFEySTUvVGhtcm5W?=
 =?utf-8?B?TWZsUjlLSnlOMW4vbUpoQnY5T0NkYmJIZ2NXd1NHT2NhR280V2NZTTVnYlFL?=
 =?utf-8?B?c1ZLVmR5RmQrM2Z1TFF5Y1pxOEZhb2ZGT2UvYytORnRQd0FLYjhpU25IelNK?=
 =?utf-8?B?WTZMZkh5T2FTcWVrazF0VTRmdnJmZU90WFNZeHV1MWZ6QWxIKzUvOFdHZEFz?=
 =?utf-8?B?c3E0by83OGVaOUM0YmMzS2drMkR0NmNjZlBaN2wrRmRoV3BBejlZSDJJd0Y5?=
 =?utf-8?B?UXppc3hxTCt6N2ZiMjlBYVhSSStKbU53SDVoL2tiUEtxK2UxcHlpNlZHVnlD?=
 =?utf-8?B?bWllTmZsYUZXcE56Wmk1MnQ4S2NOUWM4b3QwbGxTdDM4TE80cjVlU0FkdlVp?=
 =?utf-8?B?eTRoVEZYSTdmUWowZ0ErL0x2WGxOUjYzWXNXS3c3RnJWOUNLRGZmQ3RkOEwx?=
 =?utf-8?B?QTNCVS83ZkRvOUQzSmc3V1E0N3VCQ2tCK0hsNXBlYlJwYlZxaGZkdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cP9FH+pcwarWZqqWlgLZKW57oLf0pn0MVASbtvaOutrMdO6CetiZjLbb5ZzSJ5n0Bp9X0duG3QygLf9Xxpq7GVNKt/Amq4/xZQwjaETa6ZGfQNfzaeYa5Oj3XkZ+tWXfmsk+0UvDespWeEh/CEe/XdkWv5gXK8aPHOMy9m9mDpeEYjszYqd1BX7TTdwbLbnRaRZHweVTQIH8Kd/nBeLS807KdE21iDxE2FFptbUood8iI1QngcKtxF6RMqZ2IHyL8FZAzOcFbvEd2HAd0pA2FqRq6143aDP0zBb84U+OpMQxP31hk63SvL/5wBH7sX9iNaoZfvO5ny+w9MvAAQeN/A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a14eae-8137-4913-6744-08dedbf308b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 06:43:20.2508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 07SrtZ7QCfhcoNc+i7e6jzUHCUesfpwNJU+Np2T4jrutA4goAgjYs6IDUyH59/qCMRp3MUJSaZ8bqYjsAQ0fpf6dewPwWIMH+rb6gcYpihM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8516
X-OriginatorOrg: intel.com

PiBTdWJqZWN0OiBSZTogW1BBVENIIGNoYXItbWlzYyB2Ml0gbWVpOiBsYjogZml4IGluY29ycmVj
dCB0eXBlIGluIGFzc2lnbm1lbnQNCj4gDQo+IE9uIE1vbiwgSnVsIDA2LCAyMDI2IGF0IDA0OjAx
OjMwUE0gKzAzMDAsIEFsZXhhbmRlciBVc3lza2luIHdyb3RlOg0KPiA+IEZpeCB0aGUgbWl4IGJl
dHdlZW4gX19sZTMyIGFuZCBpbnRlZ2VyIGJ5IGNhc3RpbmcNCj4gPiB0aGUgTUVJX0xCMl9DTUQg
Y29uc3RhbnQgYXMgX19sZTMyIHdoaWxlIHVzaW5nIGl0Lg0KPiA+DQo+ID4gRml4ZXMgc3BhcnNl
IHdhcmluZzoNCj4gPiBkcml2ZXJzL21pc2MvbWVpL21laV9sYi5jOjI4NDozMjogc3BhcnNlOiBz
cGFyc2U6IHJlc3RyaWN0ZWQgX19sZTMyDQo+IGRlZ3JhZGVzIHRvIGludGVnZXINCj4gPiBkcml2
ZXJzL21pc2MvbWVpL21laV9sYi5jOjMzMDo0MDogc3BhcnNlOiBzcGFyc2U6IGluY29ycmVjdCB0
eXBlIGluDQo+IGFzc2lnbm1lbnQgKGRpZmZlcmVudCBiYXNlIHR5cGVzKSBAQCAgICAgZXhwZWN0
ZWQgcmVzdHJpY3RlZCBfX2xlMzIgW3VzZXJ0eXBlXQ0KPiBjb21tYW5kX2lkIEBAICAgICBnb3Qg
aW50IEBADQo+ID4gZHJpdmVycy9taXNjL21laS9tZWlfbGIuYzozMzA6NDA6IHNwYXJzZTogICAg
IGV4cGVjdGVkIHJlc3RyaWN0ZWQgX19sZTMyDQo+IFt1c2VydHlwZV0gY29tbWFuZF9pZA0KPiA+
IGRyaXZlcnMvbWlzYy9tZWkvbWVpX2xiLmM6MzMwOjQwOiBzcGFyc2U6ICAgICBnb3QgaW50DQo+
ID4NCj4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiANCj4gV2h5IGNjOiBzdGFibGU/
ICBJdCBkb2Vzbid0IGFjdHVhbGx5IGNhdXNlIGFueSBmdW5jdGlvbmFsIGNoYW5nZSB0byB0aGUN
Cj4gY29kZSBhdCBhbGwsIHJpZ2h0PyAgVGhpcyBpc24ndCBydW5uaW5nIG9uIHMzOTAsIG9yIGFt
IEkgbWlzdGFrZW4/DQo+IA0KDQpUaGlzIGRyaXZlciBpcyBmb3IgZGlzY3JldGUgZ3JhcGhpY3Mg
Y2FyZCwgc28gaXQgbWF5IHJ1biBvbiBub24teDg2IHN5c3RlbSwgdGh1cyBhbGwgY29udmVyc2lv
bnMuDQoNCkkndmUgYmVlbiB0b2xkIHRoYXQgaWYgdGhlcmUgaXMgRml4ZXM6IGZvciBjb21taXQg
dGhhdCBhbHJlYWR5IGluIHN0YWJsZSwgSSBzaG91bGQgY2M6IHN0YWJsZS4NCklmIGl0IGlzIG5v
dCBoYXJkIHJ1bGUsIEknbGwgZHJvcCBjYzogZnJvbSB0aGUgbmV4dCBwYXRjaCByZXZpc2lvbi4N
Cg0KLSAtIA0KVGhhbmtzLA0KU2FzaGENCg0KDQo=
