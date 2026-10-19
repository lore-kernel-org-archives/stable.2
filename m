Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792443715;
	b=t5Y0fR1m7COn6kpBauDt+5vgEsBVdL3tyKUwgInU4u/Q/6qdIJ8rTUR2ImNGC34kejQD
	 YtUHmXF01mQuMreUVi45EXPMavi85QiPvPnXfXxJqrHNuVE91+xmPZ0bsi3S246leKgIf
	 EpVRZTmGQbLuUXPzLNyNro4x4pQU3Oqwi/bEahcB/qKS+wCSrxUhAqdfo6hrDHuNJ46yM
	 I5G5/Iwd06gTkrdEIyeFJCFfGhU/V6pScYg/uaKbUZj6rn/5xZI/BpszACrG9NouTpr3n
	 pyVao9xV7VnEo09OAeKjreJ+CgPojORXssunjEELDnabFp1jZJB4PGwUW9HQBuAKuGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443715;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=iCPoshU9Q6UiUWW6YWwuJTw90PF9FTt+7XCiOknxDGs=;
	b=1AF6ml9e1N+65M9v87v14Eu82rof+LcotD+6sdpIzOWTWAKDUxEueI7DyTzelK1JvodJ
	 45x2BWv95fyKSkGlWVHlz+aj1Ev44Yp/d+/Dzvf4X0L+hdeq6ALBNwHOjDKlk1bJyvyYx
	 KAhips4iIIyf5m0HB6SUlCJFwDFUeALvKcuH+3QuIbHIdtw0oVaM/52ZPFr9WBl5w2SZs
	 d0uoJkz7bbq07N7L195At6rudtdb0BFOqs1v2UZgKBUpqcVl1Kb7KPm366dIecBmqB+Pl
	 LBVHG/dEQo1agYxL5q5Ui5jt/j5FuHWZWNOg4C1+koUJ4yep02oPIQwIasqi2bPZoKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Us03Us+1;
	arc=fail smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE06D606A31E;
	Mon, 19 Oct 2026 21:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE06D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Us03Us+1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792443715; x=1823979715;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=wafDAVdQyiJENPaqfORUa4RJYzRvBe58XWtDq/ESqcQ=;
  b=Us03Us+1Cee9mhq2J3Pv5fhJFjsUELxvpZDPvkuWJw/iDJTK7+Bcj3HO
   TmMNeEsc0c/BXmzW0WMcvHUN0NgPJdbRHsTzHhrkUuyqkSoiyj3Sj9oEe
   o4j+oKPW5YzlvcERnnb1SKx16GwevjWb1zB1d1/V2B5PpXOlsh9ATGC7h
   b4fGq6XmBJksG4CJKma3ObuObJA7zRnhgT8Un8Mn5Xc8eFZ7/T4WS3NRe
   oxhHi+yiiKP8C/AoEcKvfYuPl+pDR9+/tFy330I8XM97Mb/qeBVxaGEPL
   e9gCnAldW3oXGnYMB5EKecl0esR7r2tDrYvUV87VjyvgZK3/r/2fGlRyt
   Q==;
X-CSE-ConnectionGUID: pa1DKVt5Riygsf8TtGh8CA==
X-CSE-MsgGUID: mvBAxvyySn2fk4ThWj82Zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1153063"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1153063"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 14:01:54 -0700
X-CSE-ConnectionGUID: n79Ao7gpT4yi08r2HKqStg==
X-CSE-MsgGUID: m17ngEsIT+G7rhe0+gl9Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2614156"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 14:01:54 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 14:01:53 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 14:01:53 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.27) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 14:01:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nhs+jiNmAQjLM6SQy98m1w3t3MX2x8ocl4kgF3pldT0xUtMXI5jWhpy1CLwSYSCFzVru9dj9x837BFHj9i2pW31KqXiuQopohmv4CB9MFq/KrvBnk9m8ec8z4Lisa6XJhmTaz/0iqQ6rMPKtuXQq1foQhUyTyZHt7EQhz7c+g0bnJoMKJo5WYRhn9t6a4IW+vEP6YALkcz9Pr9KCYxqHH2fPkolLrSMAEXNHOOukUAEotIjc43P7/zcCbmKa10LHgWfU79DrwVkv4BIbk34SFpHawh8wOF1m9tXKVL6DckuOk58CWEC9rscJae6y8PPTUFHnqISfXyRpR0uI5AsiMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCPoshU9Q6UiUWW6YWwuJTw90PF9FTt+7XCiOknxDGs=;
 b=gwjxgv7ryOPzKOsW3zx67SrmHiMazoYdWyGMapA+JthofG9OosNxIQgwFPPjD0nUjCDdsfjq4H2oeIT6j8x34dli111hHzF7y5Fx8FpeUVaXrQp1RTm0xMWsnJzfummbghOuI9xDacQ5V0m65AafekZKl/ppeR5nVKdHficBYmQtALguGxberfT3TZWo6Ej2cgTA/239gzQCyQDVLx9/5sv6Wom/nA7XdQVU84w81jbA+Za4MAImny2uEs2pXzo2+dhio+swBC5gPopplii+zVSdfPTpd5QB2WSijD+HnlZz9Ajp7fb1Y69feJkF5wQpSgdql4YHWQB42D1vjJhLPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CH3PR11MB7324.namprd11.prod.outlook.com (2603:10b6:610:14f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 21:01:44 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 21:01:44 +0000
Date: Mon, 19 Oct 2026 14:01:40 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Richard Cheng <icheng@nvidia.com>,
	<linux-cxl@vger.kernel.org>, Gaobin Huang <huanggaobin23@semi.ac.cn>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH 3/4] cxl/mbox: Treat unknown device return codes as errors
Message-ID: <ataFNPeoHJjiHj3V@aschofie-mobl2.lan>
References: <cover.1791949910.git.alison.schofield@intel.com>
 <3ed8f5db3f21c937d8783f31ee6faca3703ba72a.1791949910.git.alison.schofield@intel.com>
 <4bcc00ea-1586-471e-a51e-01a0d3f762df@zohomail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4bcc00ea-1586-471e-a51e-01a0d3f762df@zohomail.com>
X-ClientProxiedBy: MW4PR04CA0214.namprd04.prod.outlook.com
 (2603:10b6:303:87::9) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CH3PR11MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: 9625b9fa-faf6-44aa-ab61-08df2e242df9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|4143699003|11063799006|56012099006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mBQ1y6pZXXaoLNamS3WAjIEVK57l0mcD/83o06DHR4Th9/Eu3cYDR8GeoMA4Rw4uuLoR99il37W6sugtc68vGs2DHMhElBmCwhQmlvEJmvFZWBXpAIrzqi3p5c+KIaXIJb+H7sppP7+zyH006bXMpYQXXBEl3qyhTd6W1L+tfOnHW5lw47wiLJ98Y0TMyDYjvoQ8W0lmxYABKoAIBEnvkdMJz5WBDDED8OsQhnGJaAElyQVPuKI9+G7oUwd3M/L2AQOsxWbyl0dHFMSj7jpAp7U322IJSL0+L729+l4jvd0Van6C77Rlypoc3LENfk8Pnpzsn6YVlgMW4RxH59RuLsAXxcPS/LGrI75znEyYldi4iGN2KbUxKpv/IhqLqNX0hXz3ETsah3vzohyckpc1g/RFK42C7/ZD2IinVK/EitzPnjSeMpslKn9M3U5pHXaZyT1sIP7CUQQrKnrYB+PKd86TadAEboEU/0mOnJRjqfu3K+I/27XEtqAAVxl4hoI0QKqWR1OtPQWOcLZ/i7f6W0Lzo+4y+IDY5olFtc7/kOQqv6OFutj4HmgwvzpCwyCHkM82GJmiiR2ikYL2tiBTFWGqrxCf9Q/+3hbInZMKEMw8d+yw4sT80kR4cnOqVEyN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(4143699003)(11063799006)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmgrVE8xR1kvcStCQnh3Zkk3TEx4MTNGcGpub3NCMmFOK2pxTTdsOVpCcVc2?=
 =?utf-8?B?aDJIVG41OWs2QnMrcXZOeU9iR1FyQndXcGhXbEI0K0R2Ym9OZHU5UFF1Q3NF?=
 =?utf-8?B?MjJOeDNnR0swbG5uelFhdU5FM1FPUGRtcjNkVG0reUVrQ2NFQ3JETVU5eVdR?=
 =?utf-8?B?K2pSNU9VZ2FPNDFpLzA0QmdyeGU2dmp3OVd4TDBCek1qVW5VUmg3SzBCZmJk?=
 =?utf-8?B?cE95b3RUWndNTzIvMVJPTHZaNm4vek1sM09MQmVIN2ExTDZ5UVQ4ck9rZGFX?=
 =?utf-8?B?NXpROFZ1L1hCc0cwWll1QVlOKzZBMzdTdnZtZS9xTCtGRG8wUDY3bHhrL241?=
 =?utf-8?B?TzdHQXZtZXJCTnBLaHBjWUlKclZINHRJc1V2QlJNdS9NWU05OE5tSFNZUmg0?=
 =?utf-8?B?TlRibDN4dEZrOUFXRndtS2tWbTh0ait1MldrTVdyK3VpRnZBV1lRNWFwdUZP?=
 =?utf-8?B?dnhvSHVvWVFaeGY4SnZqVDdOTytYVkY2dVlINWJRbFJpQW9lNTJtUUIxZVRh?=
 =?utf-8?B?bmZQSW9jeXhkaHE0ZG5KOWUxSFV5Y0w2K2FtUFpFamZLV2krRVdlclpPdzA4?=
 =?utf-8?B?c1VWenFveUtyMStJdFhERm1pb3BTK2JBeWQrS0VrRUZnK3pzVjlaUTY0NnVh?=
 =?utf-8?B?Q3dNVnlxYVNKMWdZb3pIbmJBaHBhMGZhKzlYaUlSckFsMXZvMS9sQ05aeC9V?=
 =?utf-8?B?alhHdHRyK2ZBUXJSV1hYNDBkMTYrTlNFQVRnU1JEcmhkdUZ5NXNLYWIzY1FW?=
 =?utf-8?B?S1N1bEQ1bzQwbHhIWWVTdG93dDBWVVdna2dpNElaeEVvYi9HQ3JmemlITmFW?=
 =?utf-8?B?akNuNno2UjZhajVuVmgrZGJwNk1hNzcxKzEyc21GZ2V6NGVjWmFWSThvSzdj?=
 =?utf-8?B?cDZFOUlhdVVVT2N3U092TjBSQzZRbG9XU1JWRTNoUGw4bkVOL3haemRoMnk4?=
 =?utf-8?B?YVF3YkRJTlRhbmZ6WDJCWGxQZ0NGTHRvRWIxM0hUejkwOVZCRXlvMWhzUG9S?=
 =?utf-8?B?eklGUXAxdlpqbDNJc2xsVHo3VFJNK29HVGhqSW1sdklIK1BmQ1paYkdkN0NC?=
 =?utf-8?B?ZzYwSDlEU2Z2TExhSDZQc3dkU1pOR0h0R25qeXR3eDEwVHZoUE0vb2QybHhV?=
 =?utf-8?B?Sy8yM1ludC91SmtZcmJQYnhHb3F0SHo5OTR2WVp1cHk3UmNseEltbGhIam9U?=
 =?utf-8?B?bGRmZ1JPaTg5Q2QrL3RQOUYzeUlVYzhBSzE5blZnVEVqUjZLSEFVWjhmSmE0?=
 =?utf-8?B?aXQzL3Y3azdRY29YS1NtQ1AzZyt0aVZDaEZkbGY3aElwclZSaGFLQk05a1R6?=
 =?utf-8?B?ZnRRMDdwdTFNNkVTbDhmNXFCdGVRUTRqV0JQUmhuM0luV0JUdGF6cmJBUmR5?=
 =?utf-8?B?K0ZQMmlPYTRwU1JRajNXVVpodFNneVhENXhNV2VzY0dyZFdVYVU5WlR4RlBF?=
 =?utf-8?B?SlVZZTcrR1c3bWtuNjdpRW5reERyTzh0MlUxbjh0SjNSK0dvd3VPeGZIckR5?=
 =?utf-8?B?cmZOUjBLaTVhTVVwNE5TZy9TUWhtT0NaMlpqSDRvRUJTS1ZHV2pqOHBKLzR0?=
 =?utf-8?B?WC9NRDczMTBSTXZTOWZrb2dCVTRqQmYwRFNlR1B0Ui8wWkFqYWkvNldHOGY3?=
 =?utf-8?B?TEp0dGdEZklhdUtiWjg3MjB6RjVCc1JSbk1Kb0FXVlc0UkRaM0owand1OVBn?=
 =?utf-8?B?SUp3NkdtRm0va3JscWRzK29ScDYwb1J2RVVnTHViOVlob3JqM2xhWHQxdU5Y?=
 =?utf-8?B?Nld5T2RpUW5nOW1pQWhzL2NkaDQrOWxNdlNCcTRSb2tOUEo5UmhpOHg3ZXB6?=
 =?utf-8?B?YzViaWl0MWR2d0V0bW14L0F3WGdBSUNwSnpDQzhxT0IxcWl1cURVOGpFSk1J?=
 =?utf-8?B?aTM3dHRvWkZSVjVxQlVnUXpJd1F1R3BaZjNVMjZTSkMzU0dncElWQ3pIZHBn?=
 =?utf-8?B?V1dGRWxaRWwvUnB0MVNOZEpiYTNxeGFFMGVSYjVaMmV1MHBDcHdOZEQ4S3c2?=
 =?utf-8?B?MXM2aEhxaS94M1c0dWdVK1VnRlRJZjlBbTlUWXJVcjhqQWxaNnJwN0MxYXpn?=
 =?utf-8?B?b3J4TnZ3SjRuQllRTVlIdFFEYzVkeWg1MldTU3hlOU1zZ1d6Z3lFV3d2SG5B?=
 =?utf-8?B?WWVFWDdqTjJ4aFg3Q25iR2tld0NDdS9wdlAvZ2FzVVdoVFRxK3YwZEs1SlhU?=
 =?utf-8?B?dmtGR1htNXl3OG5qa3dvZm5TWHlNQkdWdWRCOVMwUDlTQWF2QTE5QTU0UDZh?=
 =?utf-8?B?aU5pbHkrV09uMzZSdlZsYWFhaFZCTFovQkdYL3pjVG5SZk95ekZBbnZKdGRL?=
 =?utf-8?B?bjcwR25NdTA4Mjd4U0pzb2M3Tk40dmNPdTJZcXc3cDduRzRTVi9mSnpOSTFL?=
 =?utf-8?Q?cAgHpyLL+gIsMmQk=3D?=
X-Exchange-RoutingPolicyChecked: r8OQPDAoVs1b2Ecj0g7OgHMLoNuUARmbs5BhUPc2NXThshFDIIDrYa7JrK/gpbPo4zEgOZ+SemlwiNHQpudvH4kUDT+gXlJSwq5ViIv/Ao/mZj2PCXGz8y40lu036HiYLNC62Apfvkl4aiBHigJw/GFIRUvtRuAJvXZ3D4OBICM0zMy9/Tj8HMhg2HyGMvgUo4ZBDPVgGnOeRk6PldMEybBVtLahtGqp2vSTOW/MewPS87Gs2yrTrhMfsUq9AuKVaKQA4Ql6lZu7uG8Hv9baJ4BTcHPp8NkR50brMPJbcWsaVIKfWXpWrkJhqF2fZCZmwv02cqDWzn0E1w7PbIR7tw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9625b9fa-faf6-44aa-ab61-08df2e242df9
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 21:01:43.9317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6WbvpzTInjFvR2Fpj9im+0V4M1CA6j57qs4b8RflFAQ8q0oZfAIu8BhiKzpA+fXMvkuI7AGrbWJF2fuirNotw+JAJw9onopf/1xOnZ5F3/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7324
X-OriginatorOrg: intel.com

On Thu, Oct 15, 2026 at 05:22:02PM +0800, Li Ming wrote:
> 
> 在 2026/10/14 12:17, Alison Schofield 写道:
> > From: Gaobin Huang <huanggaobin23@semi.ac.cn>
> > 
> > cxl_mbox_cmd_rc2errno() and cxl_mbox_cmd_rc2str() use the device's 16-bit
> > return code to index cxl_mbox_cmd_rctable[]. A return code outside the
> > table's range causes an out-of-bounds read, potentially allowing a failed
> > command to be reported as successful.
> > 
> > Check the return code against the table size. Report unknown codes as
> > -ENXIO, the errno used for most device-reported errors, and describe them
> > as "unknown return code".
> > 
> > Found with a QEMU Type-3 device returning codes 001Fh and 0020h, which are defined in CXL 4.0 but not yet recognized by Linux [1].
> > 
> > [1] https://lore.kernel.org/linux-cxl/20260929060747.3550005-1-huanggaobin23@semi.ac.cn/
> > 
> > Fixes: 92fcc1abab09 ("cxl/mbox: Improve handling of mbox_cmd hw return codes")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Gaobin Huang <huanggaobin23@semi.ac.cn>
> > Co-developed-by: Alison Schofield <alison.schofield@intel.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> 
> 
> The issue is not related this patch, but I found it during reviewing this
> patchset.
> 
> I noticed that the default errno of CXL_MBOX_CMD_RC_BACKGROUND is -ENXIO,
> but description is "background cmd started successfully", I checked no any
> driver code checks/uses this CXL_MBOX_CMD_RC_BACKGROUND's errno, maybe we
> should set to 0 like CXL_MBOX_CMD_RC_SUCCESS?
> 

Hi Ming,

Agree. Fixing it to 0 seems like a separate cleanup, not for this
series. Can you send a separate patch for that?

-- Alison


 > ---
> > 
> > This patch is independently applicable and backportable. It is
> > intentionally introduced here as a lead in to the kunit patch
> > that backstops this fix.
> > 
> > 
> >   drivers/cxl/cxlmem.h | 6 ++++++
> >   1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index c401e3a1af06..357d0d873e87 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -6,6 +6,7 @@
> >   #include <linux/pci.h>
> >   #include <linux/cdev.h>
> >   #include <linux/uuid.h>
> > +#include <linux/array_size.h>
> >   #include <linux/node.h>
> >   #include <cxl/event.h>
> >   #include <cxl/mailbox.h>
> > @@ -205,13 +206,18 @@ static const
> >   struct cxl_mbox_cmd_rc cxl_mbox_cmd_rctable[] ={ CMD_CMD_RC_TABLE };
> >   #undef C
> > +/* The return code comes from the device and may be one this table lacks */
> >   static inline const char *cxl_mbox_cmd_rc2str(struct cxl_mbox_cmd *mbox_cmd)
> >   {
> > +	if (mbox_cmd->return_code >= ARRAY_SIZE(cxl_mbox_cmd_rctable))
> > +		return "unknown return code";
> >   	return cxl_mbox_cmd_rctable[mbox_cmd->return_code].desc;
> >   }
> >   static inline int cxl_mbox_cmd_rc2errno(struct cxl_mbox_cmd *mbox_cmd)
> >   {
> > +	if (mbox_cmd->return_code >= ARRAY_SIZE(cxl_mbox_cmd_rctable))
> > +		return -ENXIO;
> >   	return cxl_mbox_cmd_rctable[mbox_cmd->return_code].err;
> >   }
