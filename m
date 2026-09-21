Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD25B3793D2;
	Mon, 21 Sep 2026 09:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983080; cv=fail; b=PtIslDnbYg9HFHuDt7epIcYlx9cSOkFpJ7MD1TqEyJrWq5kCcTH4mGnwQnpQqH8lOqz9A20TR7ZXTMIqjtYnz1ZvXxwnkSxq3LwW5IJZPdPvKBHRnL1dLD94WZ+0JV0peUoIWxdTDtURVb1H0c39MKc1IyTZq5K3ohXiAXjbqgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983080; c=relaxed/simple;
	bh=kdG+8sUAO0heRdEeMwytjH/gIbclSzlzdu+qMQ/NG7s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iJg0k3SZ/qkxWghhmej2xmQ+VDMqlA7mfQET1PcQ7a1AykGTM3gsqq2X5Xj1sN0bw1G/4cKDT6Kqr5dPBfYEZa011BlaCJbadOrJRIBHzByDQJP5VmkHcUrwTTvh+PZG0Hp81dRqXSEQ8qESMSalop54cAkTuUkgfG9nGOx03oA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OfKPP/Zq; arc=fail smtp.client-ip=192.198.163.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OfKPP/Zq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789983078; x=1821519078;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kdG+8sUAO0heRdEeMwytjH/gIbclSzlzdu+qMQ/NG7s=;
  b=OfKPP/Zq/VRALq7udCXyuKbkRFwUn3tnhEsQgSoVCGsr41wrnWxeTkYZ
   QUG2XqByEYwXJOR2toAUTuEedsiGultuDNQ5iN0Xzd/5vWwtdrIgv7bmU
   foA1SsN5vsixID37UMvvXWJUPjzLwPEKCR0Gzelm8jyUUZ42fjVp9cjWD
   A20ZvYtZAxFHb35q3eCAxeJGmiJArWyLLkOwNLjHW6nlPNW3yWP5m0ad8
   d8fGxg4spPcu75WL1Pn+h2ApyiJHiJLmqctchdpV9EK6OovOt/jsIcgBa
   AbO+pknI5ZlGXlD3alFdBNr7+qr7/Hek+PzPS2Qw217ii0NFczVOuPmIs
   w==;
X-CSE-ConnectionGUID: 7R8XlPgmSWCOdVBjy0YUBg==
X-CSE-MsgGUID: Z3Q2RkB1R5WJqgnukzXB5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="991303"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="991303"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 02:31:17 -0700
X-CSE-ConnectionGUID: vs9AjCvZSG+D3ieW/Uyq/A==
X-CSE-MsgGUID: 3hXayJ5sSSq+ZPJnO6lVng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="271732892"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 02:31:17 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 02:31:16 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 21 Sep 2026 02:31:16 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.62) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 02:31:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UjX8fSb54HRZU0M5U4WXCO5ClkmqdpN2TOHCwsuYNjJEp7SMndhN11jaYq0iRt9zOtG2P2+HBpO/Gt0pbTjmETBwGtc6hyc0mp5kghM5lbcSTcGzx6CHn4sHOUKsQ7wGSzaBg306ZOeA+VgdGy8cPloNT/O9b86g0vt1Nu6cF4Bnb/sAPBjQwiUZH4ChItMmxZKhu+fma89HJPSGJxXW7CwIkye+C3ETspZTEwtVtWH82hK0oj0WGNY8Eg0BP088qQ260n1yK+6BtL8WO4uYx2rRASczBWIBgSXeSXWkWJyuNhDg/9wH/gr7W63rbG1xSc2UlYumxRrDZf7ObfcI9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2dhy1/Iacry13UdYCd8kc+GbTdRh6kK9aA6KJ6yzzc=;
 b=XEQEMZ3WCwHi+ahZWK8BJv5pdOYzY5S6FxIDNdc51mKeJ5HBIEBJmqjGbfTkf2LTZXzXNgoVc5AOXuI4PCkhH+O1yOIUORn37je35Twlk9n3RSUpfpGm7he47a7hIgTzOlrQ1DwL1kUr+xtb4BDUi/8n6paVhLX65+FzkYvQ/VGFwHKEfJUNzhXVsSL4Pmh16LpjFpremhCMlrVzqe2U5fbjleHrioxh6FK0czaLLFCV0K2CkDBfhVX4gLR3x/EKajnJj6KmrnHNcYMBVC0bQsMC6Q4h016RTBWAGSRUuMLGYfjS9Cctk3VweMWsN8mQp8bgwuGEh2HljrKWlp1DMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6006.namprd11.prod.outlook.com (2603:10b6:510:1e1::13)
 by CH3PR11MB525758.namprd11.prod.outlook.com (2603:10b6:610:34d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 09:31:13 +0000
Received: from PH7PR11MB6006.namprd11.prod.outlook.com
 ([fe80::4e2d:28f0:ede9:73bd]) by PH7PR11MB6006.namprd11.prod.outlook.com
 ([fe80::4e2d:28f0:ede9:73bd%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 09:31:13 +0000
Message-ID: <dd60ce64-4af1-479e-99d3-1787a06da882@intel.com>
Date: Mon, 21 Sep 2026 11:31:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: Intel: SST: fix platform device leak on probe
 failure
To: Guangshuo Li <lgs201920130244@gmail.com>
CC: <stable@vger.kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, Kai Vehmanen
	<kai.vehmanen@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.dev>, Mark Brown <broonie@kernel.org>, "Jaroslav
 Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Thorsten Blum
	<thorsten.blum@linux.dev>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260921073847.63505-1-lgs201920130244@gmail.com>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20260921073847.63505-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0011.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::23) To PH7PR11MB6006.namprd11.prod.outlook.com
 (2603:10b6:510:1e1::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6006:EE_|CH3PR11MB525758:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c51ad33-9e1c-4338-7ef1-08df17c313f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: UKCw9T2FgYw3uayUAq7pssQvTd80rKp84G278ykoKumvxa/EI/6u3hZiWFWJ/r4ZT9DNs9lm2diFrUZXTuQ26/97uk8z5ClKwloihy49Os0g0b0Gsbkx6s+CKeR8y8VIqUP1HQOyUggUGlNaNEa1hO+iF9KFNJaKFxufDFKDyexYdzO/mbZHkTe1QP2iSfytlROgIfvx/fzMTXiFCXJ8d5gqkAQU4Doy134k4uaiosrhmWLGiXsBaLchLLJEzjD/NWUxOLkkn7utcbLrCgvDXmZuJ5K0Vd/sumRKfllpOAWKO7pLY1IDeWhTrIJW22QqQpGOV3MXutS5jSh8JCCwRWkSNF+ZpqBlksWfV4nu9petCYKYMwM2T7UyphDnGaAkqPjUek3p21b3WLgmWnHBCDUevZ0jQGM5TRAsPy86vTr0SHBhHq1cQ9HYf6QGcUpJ97NRwTVYedNRlAxSO5rMKPCy+rjknAo0e9MBFRHzrEgh2VgXIQgds/hqBCC+Il7xCt4Hvz1hqNbTq29b8/NhfCFEYj+BDzHpnpkgAYi+gVYt5JjUdjO7+pFix1ZatrCYkO/fshgeXDnkcEqdIIQyFldcUz8UJvoEF+jMAMg0XRQuL6ja2zCZ2vGbP4Avu+fUahko/XaXgd4GRr0fmn/ScuC7jP0cTImSt8tEaCPGOfc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6006.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFV1UWovK1loQ3BQYVpEQ3cwallSOFdUY25NdHVwbWxldGtyY3B0TmRzejlL?=
 =?utf-8?B?MHBJS3Y2NmpMV2g5UFBNK2svdzRxQWVxMURCbUkwZEw3NU9PKzlTelgrdHUz?=
 =?utf-8?B?UGV3cW8vS0x2Tyt1bXYxUDhGa2tjT1VUK1dLYy9IZWNLRFJoUHY2ZWFzalRV?=
 =?utf-8?B?VjE0b2FYU2dlc011Nk80MmgzK2UzOVNJNlJkaG9BVEUxY09rS1ZHZkNaSWMr?=
 =?utf-8?B?d25YZEMrdFJYTDhtS3BjVVhNYVRKcHpsR2FPaHlaKzhSSjJqeTNTTEsrNGR5?=
 =?utf-8?B?c0VCSHl5Tjl6cUY1YWZMMmFRNDRwVzl1VmJoYytqb3FRMVBRVDBCOFFoMWky?=
 =?utf-8?B?akNzTGQydkU5WkQ0R2VGSlN5cnNJRDBNRkRqMldiSzQvM3RiaVlhaVhwcHdH?=
 =?utf-8?B?QXRuV1cwNEhzTVpjRU1IOUxXTU9DWWpaRVQ5Mkh3VnBuaXdXM2ZuSkJhbTNY?=
 =?utf-8?B?dWY0ekFGL2NuclU4YnowTkszU2pwTDJQZDZjakZuMkgvLzlKb3E5QmEySW11?=
 =?utf-8?B?THVmZ09hdExpcy95bEtMbnZxNnQvRnlKbXZBVDgyQW1aOVBHSUtTRnpBc2V6?=
 =?utf-8?B?MWFXVmU2S3h0L1VFMm92Zis3OW5RQUJTNXk1VnRKa3RTQ3RoazVlV2xISEpV?=
 =?utf-8?B?VHl5TWRUWFp0MitYQjFTWjg0M2pDYUd0Zy9KT1gwVng4VlBIbVF2RUVBOFlw?=
 =?utf-8?B?RkFOM0pKWjJrTk9HY0UvUEZlTkNZdkQ2MFNOaEorU1EvcWZ0eXlWQjFzVHpz?=
 =?utf-8?B?K2tpdXgxL2JpQis4ck5POTRLNHo0bCt6ZWNXYTdENFk4OTJIalE4K1BsREw4?=
 =?utf-8?B?alM2cVViRk41cFRKZHgzU0JRT1NydFlXTDJtZHY2aEVrLy9KeGprTHhRSDQw?=
 =?utf-8?B?bFRUVi8wOHJ2VjVwdjRFVllEMkNyemJoWjdweStJOGRWQ1NadzVTcXJodlRu?=
 =?utf-8?B?UlpuZk5waWZ0T25mN0NmMWdkbXNldUJhTDRlbXNWY0F4WU96ZkpuRlZOZCtF?=
 =?utf-8?B?bjJNOXU2NFBnQ1NSQ0lhS1ZES29WelZWUldnbDdlbjUwUkdXa2kycExnL3Iw?=
 =?utf-8?B?MWhnM00waUNGd2REZVB1eEQ3Z2pNRnRucXZiejlDbjRXd09vZ3d5ZTEybFNa?=
 =?utf-8?B?ZWNZbEZFVjduS1MwNU5qK1dTeVhxR2ZVc0dlMElhdkpXZjhFcVM4TVB5MmVT?=
 =?utf-8?B?ZFFDeHE5MWF5SFpmdVVBM1RKNUVrTWhtQ1NzbVQzNXd0Nk9TNlJUaTJvb0pQ?=
 =?utf-8?B?bVhQYWJ6dnZ5N2hlNGtzeXRnS2ZKazJpWmFFWHZmOHl3Sml4b215OTB5dkt5?=
 =?utf-8?B?QnZBZjRvSFFKcTk1d0xXemxDZk4rc3NJYXRQVkxRcDhiMk8vSXJuWFBYQTJD?=
 =?utf-8?B?ZUN6R0RTNGRHb3k1dHhIeVlIdTMvaGdTMUp1ZlZLNWNBUmEvd3AwMzMrbzBW?=
 =?utf-8?B?THRwTENDL1llb0dtWTJGaUlraFdqejhycmhnR2FNMGdwZVYzT3Zic1Myd21K?=
 =?utf-8?B?a1AzeDZEbVIxYytuNVVWQ0l1R0g2NnJsNW5od3dWMGswT09sU2ttN212Rytr?=
 =?utf-8?B?WVR4d3FmUC9TYzF4RVZHUmJWMnl6VHpiN0RzaWRSRXM3T3p1M05BSVowNEZS?=
 =?utf-8?B?Mkt0QjBxRnpEYlZJSmhqNjFuUzkvdi95U1hNQXFZMzBXRTRMVGxha2lNbEJz?=
 =?utf-8?B?c0UxR0ZNSnhwOGJLdXV2WURyNWxlRUxDMEdDcE1vUnFvYWpOWnhPOG0vRkZn?=
 =?utf-8?B?b3Nhd0JGZ3J6UTgvMmhQNkgrTjhhYmoyWnFzMWdnWXNjOHovRXlXWU9JMjJX?=
 =?utf-8?B?NWtqRWJneTRmK1pJelJCakhVekozcEN0ZyswUXI5eE9FVndOVXpwcHFMVFZS?=
 =?utf-8?B?SVNpdnF6UVdITE51SmV1NDh1QWVYM0J0QmZRaXV3blQ5bkxVU2dSakZzYkli?=
 =?utf-8?B?d0lUTzJRVm11UEx0YnZ1b1dTZ2VReVRFa0p1cmhTd0N6b0wrTm8zdWVLRk0v?=
 =?utf-8?B?Q2RVRjZXUnRudmsycmxJY3BjUVRSb0FHVDAvN2MyZHdiYnZIL2RPQTBhWG4v?=
 =?utf-8?B?cmlCY2hzMmVTbFRZSVczOGY2eEh3WnVlaTlBOS95bS9ZeFArc0hUc29INko4?=
 =?utf-8?B?L2pJc0h6c2szODZiVFM4RWRhTTFSVUZjL3JqR1pDYlJvb2FxNytSeEVBOG4x?=
 =?utf-8?B?ZFFQMG03VzF6VlZ3ZTViN3pidWtxYUJLTDcxQVYrazJyTnA4cDdabWZMWis2?=
 =?utf-8?B?KzNWcXlOQ3RJd2xCQVJvZGRRSUVWL2IwcllIQTdkUEhVd0U4Qy9KcW42Rkpo?=
 =?utf-8?B?STQ3M05CSVJVdTkyQVkxMks0aDd4c3FlMnVUTWpNUzhadU9xbmRqajJ2blE1?=
 =?utf-8?Q?ZIIZjrtY47ZA/cIQ=3D?=
X-Exchange-RoutingPolicyChecked: R88Nd+JdCqFVYKrkJGdW3iHDlXGBD3KcsCvhVwEixLA96yFfwL/ZSgMD17aPXDfC/oqp0mmqlnXar7JmYDpa7bU4wpkc8NmGdMjToNw5hJrsu8UUQ5DpMOuDx+9Aa6YjtGbmkH1U2RJA4H2xkBXPwQNQXDpzF+SAA+2OORjtxj240DuI59aMkMskRL7hDst1cdnhYUC8+1Q9GSDIP0wnPkYOF9hMaiAPSNem8HMSSutAdaSDIyLPfD+KOyT/MO3pGOBMtTHSbAuAQHOlqFJ5tWg+HkEkxTMh8niK1tITP3cxEnjqCbnF9DCse3ZZ/0q5vcR8yd+mBzqoTWOl5pMePQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c51ad33-9e1c-4338-7ef1-08df17c313f7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6006.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 09:31:13.3907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0loTP3lm+XavmhaViXZn2iEIrr6oCmqsAflkgOaO6wn4O49pXgJTy6DuF3nSZgpSoBZ96Tr4QvRvC5BblkxWvcgHnJHIjJAsLi76h4QtuQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB525758
X-OriginatorOrg: intel.com

On 9/21/2026 9:38 AM, Guangshuo Li wrote:
> sst_acpi_probe() registers platform devices for the SST platform and
> machine drivers using platform_device_register_data(), but does not
> unregister them when later probe steps fail.

s/machine drivers/machine board/

The above paragraph alone is sufficient, please drop everything else in
the commit message.  There is no need to write wall-of-text for a fix
addressing a missing error path.  In case this wall was provided by an
agent, relevant Assisted-by: tag is needed in the tag area.

You can keep the very last sentence if you want to.

> If machine device registration fails, the already registered SST platform
> device is left registered. The same leak happens when
> sst_platform_get_resources() or sst_context_init() fails after both
> platform devices have been successfully registered.
> 
> A registered platform device owns resources allocated by the platform
> device core and must be released with platform_device_unregister() so
> that the device reference is dropped and platform_device_release() can
> free the backing platform_object.
> 
> Unregister the created platform devices on all failure paths to restore
> the missing cleanup.
> 
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
> 
> Fixes: caf94ed8629a ("ASoC: Intel: bytcr_rt5640: fixup DAI codec_name with HID")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

For the commit title: please update to:
	ASoC: Intel: atom: Fix (...)

Provided both the commit title and message are updated, feel free to add:
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>

> ---
>  sound/soc/intel/atom/sst/sst_acpi.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
> index 73624e1b138a..a1f16083bd3d 100644
> --- a/sound/soc/intel/atom/sst/sst_acpi.c
> +++ b/sound/soc/intel/atom/sst/sst_acpi.c
> @@ -352,7 +352,8 @@ static int sst_acpi_probe(struct platform_device *pdev)
>  	if (IS_ERR(mdev)) {
>  		dev_err(dev, "Failed to create machine device: %s\n",
>  			mach->drv_name);
> -		return PTR_ERR(mdev);
> +		ret = PTR_ERR(mdev);
> +		goto err_unregister_plat_dev;
>  	}
>  
>  	/* Fill sst platform data */
> @@ -361,15 +362,21 @@ static int sst_acpi_probe(struct platform_device *pdev)
>  
>  	ret = sst_platform_get_resources(ctx);
>  	if (ret)
> -		return ret;
> +		goto err_unregister_mdev;
>  
>  	ret = sst_context_init(ctx);
>  	if (ret < 0)
> -		return ret;
> +		goto err_unregister_mdev;
>  
>  	sst_configure_runtime_pm(ctx);
>  	platform_set_drvdata(pdev, ctx);
>  	return ret;
> +
> +err_unregister_mdev:
> +	platform_device_unregister(mdev);
> +err_unregister_plat_dev:
> +	platform_device_unregister(plat_dev);
> +	return ret;
>  }

Looks like sst_acpi_remove() does not unregister the devices either.
That could be fixed by enlisting devm_add_action_or_reset() in
sst_acpi_probe() without altering sst_acpi_remove() at all.

Would you mind sending a separate patch updating the function so both
the error path and the driver-unload clean up the device objects?


Kind regards,
Czarek
