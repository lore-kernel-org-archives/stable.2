Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576F43C1D66;
	Wed, 30 Sep 2026 19:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790794882; cv=fail; b=MZ/ImF9BS0YQqmi/3Zv8tzb5ztaeIIIAY4JA52vsihjSom+m6dDBPyKsTVLbXMMgtS8gnLqh4Z85PZx7RXHGAY4v2MGf+wY9BoMzDejIfsqY5kvZxpjFQZXBy5UiVcWCQjbu8HQp5fNEstTbLYgz6+hwtwxig/cuvWhCi+LHqBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790794882; c=relaxed/simple;
	bh=8278XzRMOLnFvuHaCYi9Cne1RQQnJI9kJ3MIkdODEPg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gy8LOH5RAl24aKjoaBNnueyhCPD+rJPUChiIE9OaetBB6bj8qEsGA/07BNjarzGydoe5DFu8xZNx8or/h/nE8GLYAhIacQZSXP9MUNs+GupQd+HNYN6oRh/p1a1+tD0vIdnmrXC0ofgH5QLCj5pTmCU9p1nHdHTVqFeNUiU1Aj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aepzNqgd; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aepzNqgd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790794856; x=1822330856;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8278XzRMOLnFvuHaCYi9Cne1RQQnJI9kJ3MIkdODEPg=;
  b=aepzNqgd0l5BJWz2bB/kbXYTopowqnojU0vkRCxWv/+pHX/T4p5ztEHX
   Vlw2JeXkQ3uvYWA2KACvhfGQQMOCGR2Jm9lE2gK320sqlsQg1OVPLKGzk
   gdZSoL0F9wCSiaIPqryXfGYY08E3fKeDYWEANbjUgJKjxpqjbeqdVMzI6
   gh5gSJ6kUwX5qPkp+dnVv0JVsYWfEhpVQ+A72l2g1eiGIkJK6eeHCClBW
   FVUEXZvFM+1/c3ci4YzJnHzwj6EysiSdoOww3PWLnIo0fQNP/EQjeFT2A
   K7NOR4OjCHYBFtpT66co7pDmWnfjHAdM/tWqf5eseJo6fYvDAIvHMdnIB
   w==;
X-CSE-ConnectionGUID: tLHBTg4cTHO5ziW2Qrp3Sg==
X-CSE-MsgGUID: mcIweaOuRbaVfIjbu526gA==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="109026964"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="109026964"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 12:00:55 -0700
X-CSE-ConnectionGUID: 3bfIcDwCTRaTyedMnlqZWg==
X-CSE-MsgGUID: XWeUnk/bRWK4AsGinjNKXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="275899781"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 12:00:55 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 12:00:55 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 12:00:55 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.37) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 12:00:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vEY+wS9RE6OsvJb1o/++3yHK+tqeeo6I86Fwkt+BDgFS1JXJz93TqDoNBDrBWGciDO5+JxO/Ij2xlRZBYnP3khF0U76oqg2UBNdhk+yBO8bTpUYGygFzqpSyCG8OE/addHI+owqlmV/gt1PRJ6w1L6Kg7OW/Z8t0aFyfUXoznWyAdBziRzVuDYVRo/rNBEnBMSoHCn7c8qgWOqfyFBLolDUoTXcDfiqrfcEFb1YEr9d2js85BR6t3uZi82z45uro5UN/AkCNckWNvrlxkTyV2+3U6sQ+lmbFByWBUvi0pcAyuj7yGlU5GCpDce6E5CMFFyHxQ0NoeXvgrA/cRG3ylw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvGez0ytadIMJWSRyCRYUTbxa+Be6s3BWqianw2vGqs=;
 b=kLiYuT2N57iUR0iPq8VWGyqukc0yORboVNYUcZ9eHHWS/h5grXbMwQ+yY2LMClNC2O7zGbwiQva4EAWujhg3Maig5xFhfTCvcNFDbpuYlTDKCwBbfxNG5wQEKwezWoLeorPdhVZPD2GzXa3SKtE9TXfREu1EPjZctO0+tU9ivRF2Czu9aSZIOHk+TA/pF+isEA3d/v7mEHyibbPuaggOI0TnUzsdullqk6B4TyuaEM1L0YoX8ki9/d4+WPRgqs3znKdbGU3tJjD8M+X3QZkP19Ngf1qtrlkh7Ih3dqJfRZ+YAHI+JMM41YmwwPWVnYYM9zzP7oK9kAvVlC6T2o8uEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SJ0PR11MB4879.namprd11.prod.outlook.com (2603:10b6:a03:2da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 19:00:52 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 19:00:52 +0000
Message-ID: <791c00cf-4f25-423c-b2f3-4cdc2d2c4a2b@intel.com>
Date: Wed, 30 Sep 2026 22:00:47 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: core: Don't program invalid host driver type for
 fixed eMMC type
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>, Ian Ray
	<ian.ray@gehealthcare.com>
CC: Ulf Hansson <ulfh@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>,
	"Kamal Dasu" <kamal.dasu@broadcom.com>, <stable@vger.kernel.org>,
	<linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260926122908.866-1-ian.ray@gehealthcare.com>
 <CAPx+jO-59V8bg+DB4pOqEmdPZrfLi098YsyzkBRnf2Krb7ufVA@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <CAPx+jO-59V8bg+DB4pOqEmdPZrfLi098YsyzkBRnf2Krb7ufVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0006.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::13) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SJ0PR11MB4879:EE_
X-MS-Office365-Filtering-Correlation-Id: 38a79896-40e2-4099-bac8-08df1f2525c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|4143699003|56012099006|10067099003|11063799006|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: uH9ZUGuqoTVA2W940ypGqDTwSdKSRUi9vb7rKFoblNj3k+pY6+tcHfoseGLvxSJJDFHDCOi8x+6iqthRB01Z8yoInP3nbhtzgKh/7Km1MmnGYcdteFdm0h5FLvaH7Z6RDTsc2v34uLVd7MMY5mfU2LwAQJRBknfwUayyrVuFa0aE9xdyLaRgAJOp/eZ2QxUIl+utiAqBV+6PpPgva1JgcwePv0uZXiOuum8lpH3YIKlCTvTIlRILb7vC0/Jqrif5oGq6qPdEtlHbmOMOukFw6T3n6PnYo6vPF4eL5hrJhHdWHAGc0Ju7O2regOepIzbQnAs/1QtJptCzs7YCQXCUUtXqZ5/E0pGWkPaiVJqCSlcVio6D1x71Q5/bNe8aMpbfnWl0wSr0dNOtyNckuX6e/GvZpmG7VqG56HkbjvBpDq9SnzNK+AD83s2/nfC821PpqFHa+116cc8YVONkQdhwmrqbHj7YtxMU3klb8EypK701bDJIIc+T8btuKT9k/WPi5q9lezGrgqxqYhLcgWJR4R+EcSsVZK0Dm+mUvBpb369OX3tlwl3n/oYqr2LKAHHnz6Mi0gxrzBQXpjiv3bu8y1lsoA8ReE/K07JCP/fM5lU3U5CBespoo4YLDvVmQKnxk0AYgGDsxVvdWEAlAkLNhBxElfs/rbvu6IQZgyg3Gr0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(4143699003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzV0S0NWRUM1N0xmbUg0NFlIM0E3cWZpa1N4emMxRW5OS1hVUG1OOTQ5VWky?=
 =?utf-8?B?TTFYOTRMWE9menhrWUlMbUxzRUV0QVpTSk10QWZHM1Fjd2hyMFo4YWY4QjZF?=
 =?utf-8?B?a3ZJS0tJWEU5RzRvQkFHY3ljQjhQVndncU4zRU5ndmVQdVpEOU5HR1QyclVH?=
 =?utf-8?B?S2trVEJjZmhKcE5NZVVnSzdJUktHd1RXZDNIdXNMaGM1eHlPcjhXUVZSNk16?=
 =?utf-8?B?eU8xV3RWNjdWdjZDdk1KbS9lb3VJT1BaVUdiZFNzMkI5bmNPMVRXTHEzKzJJ?=
 =?utf-8?B?RUZKR3RYVU9FbGpiM1A5R3ppb0RvbE1ZbDRKQVRDcVlUZ0xpLzI4Ym92bWdz?=
 =?utf-8?B?OE1qRmtNTTF4aXJhTTRsaVBVWENtNXY1K0tCaXpzTGd0MVNoSWNQdU04SUt4?=
 =?utf-8?B?TmRZUGxDTTZGOFpvdHArN0I1U3Q5djVWVmR5ZVNveEpuQlVmZEJTaElzblZJ?=
 =?utf-8?B?a0g2Wk5GVEFJQjBlSFlIaWE5UHlYVWpTMlQrTkg4YWRhVjM4VXpxN2E0YVhk?=
 =?utf-8?B?V28xYUxObTErZ1ZHV2dVVWx4TUJoU1V1NDZEWjRlSEpBWlFZN3owdWRaZ0hR?=
 =?utf-8?B?Yi9TVVBPNXZ1dGRmM3dETXBwZjJsV0JyOWdGTGw4TkFsTFNjTFFHNGJzYXhy?=
 =?utf-8?B?WTVvYllSREtML2ltRjhqbVFJSXo1V3lCUXdIRFc4aURQSlRWeGZodlZzU3JX?=
 =?utf-8?B?OEZIQU9ZZTg5clV4Q2x2RTJGZWxKV2FMcmc4N2ZvVHVRbFRFUmRLKzdBbG9P?=
 =?utf-8?B?STlwckI3cmRLeFJJSk92Q25LdEFkMlBnZS9LcDJLQWt2Q29PS25UanQ3TWI0?=
 =?utf-8?B?dXhsVlkxbGRkNk9rdFZ2T1AxakU5SmtuU1RSTlNYSFpFNmw3VlFWWGlhTVh4?=
 =?utf-8?B?U05uM2FyeW9peGVHS3VLdjZpOXpSRENXZmIrVmNlbVp1WVZSbzR6QnRHeHc4?=
 =?utf-8?B?UzkvV2VTK3lsdjAyNFBFb0c5bkVxVlA0bWVXWjMrZnp5WlZOcVEwSEhQNTBT?=
 =?utf-8?B?V1creE5vTlhRYU4yTmFxVGVYTlc5YjFwT2tla3JYOWlmVysxbG5iNjJ3aGEz?=
 =?utf-8?B?bURHTFB3Zk9Qb2dLeEFlNXhTUGdJdkFZVUI0REFYKzdXTitPdUtFSzNtSWpC?=
 =?utf-8?B?azU5b2E1cTZHMmJsSlZQbUNBU2lib1hSSGpWcGFnVUIwR0IyenhJMFErbGNr?=
 =?utf-8?B?QzJQN2c3NVEvUDBtMFlrWFEzNG9qekEwMForWjR0bWFZb1dyMURQQzFHdEY3?=
 =?utf-8?B?Z0N3WVc1dlBjaGhqV1RMTEk0UEFHYmpXdXoxTGpKbkRPZjZHZTQxTVRNbTUv?=
 =?utf-8?B?QzN6d2orOEVtSE5NV2VFSWd0dGVsZEZndTE0ZHBScDU1L2NqL1Rnb1RxeUxw?=
 =?utf-8?B?ZmlQSVAwL1lTcC9oV2lFQVI5emEweEdHM0x5K1M2V0RtZzJweEtMWDJERm50?=
 =?utf-8?B?aVlJczFrdDhKUHNWWnlQOTNBVG96STRNSDlxbmFIVEFFRkUvZ20rNGJEVkZH?=
 =?utf-8?B?T2xIODEyaUJwUDFMMUpLWEE5SlBzN2pPZW9TWFQzbmhESndEOEVHeEQzL01T?=
 =?utf-8?B?eE85QytpUUFOblE4SkxXUWFNRlFIbkxMNTQxSi9oUlFmT1htc0hKd1dMS25n?=
 =?utf-8?B?RjNYZlNUQmZIZHRzZVU5dnBrb1g0WU9BV0dqS0FOWEE5eWlYbzNTMWR2VmNJ?=
 =?utf-8?B?TUNOVERWYk1TMUZaTFZQaWsya3MxZXhoNk9kZ1RWQjJsZ3VIYUVPNVpjeFF5?=
 =?utf-8?B?L1dXQ2N3ZkJ0YmdIRElPVk1NNkljS0NQNzhlOEdWcWJzcjFiUkRIVFMrUGdM?=
 =?utf-8?B?RWdTbEZ1Nkl0TmU1Q3FvQjBmWkhscTEzYTcyYlI5eWdiUlh1bWY3NjE2QlMx?=
 =?utf-8?B?blZxQm1YN004cjBDTzlmUFZLSXFhUituNTU3MEk2NzJFMEtvQXErVjJ5TDBj?=
 =?utf-8?B?b0U0MkEwdjludjVjUUlZVmFXTDJHMnEwRFlSMVZkcUpvUWU4NHNQbU1KK2Rx?=
 =?utf-8?B?cVRSNDBrU292TWhBRjhGUWVFWjc1N2s3bmtaZWh1T09hWUQ1Z0pKTElOZDNH?=
 =?utf-8?B?MGNybkdEUGdqdTdqdEY5UHZwUDErQ081eUJXcHE0UzFGaGd5aUxlU0FoY1Rz?=
 =?utf-8?B?V1FPaWpZUUV3MEFBM2NVV3NwUEdjVit1ajRQWnZFRzVzSVJ5bDg0Z1B3YWVQ?=
 =?utf-8?B?K21aZUo3RlRHOE5odHIwZWJRaWc4dW50Zlp0b1B2OGdrQWZGWkVVeEkyUHNG?=
 =?utf-8?B?ZmUxdlAyMDJtUDk0bzFOdTJUMmNBQ1RlU0doVitmcE9qVU4wc0dONVZwaHkr?=
 =?utf-8?B?Nzd5TFhqbE12eU1iOXFwaHNDTS9iNllxRHFHTXByc2ttdTVpVlJzb251b01I?=
 =?utf-8?Q?XSIQeGypYEuHe9hg=3D?=
X-Exchange-RoutingPolicyChecked: WxLF/6YztCMoE04E5aKeWpaWr1+XH3F1A2UPCjp4Aw0bSspvn3W0bBflD+RpQIgjbbJswQ5wr26cNOokAmI7CiXy3LSJMiRWJKmjIgGFusUCVlpLMeBPfJPVynvjiRsPWPSU6piwk+pnfG0Mcz2jxxusHTvvZNvJ6cmX09JAxIlqEgvKu1rpLbYFNIQMwJfvxQM83FJ92PH1WkTWYI0oVGceYd2H3AL2Ne/K/ClnDr3gy/LjBmKmUQHG90TWJemTVwDmmukk6XLAPED5n8oWF4A+nIK/rFEBxMHxmGkezLAy5SxZdHr4kHnJCULW8Qdg0yjHJdmrflBBHiAIzysaSA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a79896-40e2-4099-bac8-08df1f2525c0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 19:00:52.0059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TR+/YVaxXWYgAK2qaH6pdQlz0Q4j2bXIsC1X8vSWZvwNe5oE0GgvDhenr0knr7KSX/XPOid1mYtSPHnFrHRSKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4879
X-OriginatorOrg: intel.com

On 29/09/2026 16:06, Ulf Hansson wrote:
> + Adrian
> 
> On Sat, Sep 26, 2026 at 2:29 PM Ian Ray <ian.ray@gehealthcare.com> wrote:
>>
>> The host controller driver type value used by the MMC core [1] _mostly_
>> overlaps with the eMMC device I/O driver strength value [2] as shown in
>> the table below; however, there is _no_ host mapping for eMMC value 4.
> 
> I think the mapping exists only because that is what the SD spec
> provided when this was introduced.
> 
> We can certainly add something that corresponds to value 4 from the
> eMMC spec as well, to make this complete.
> 
>>
>>   host value/type   | eMMC value | nominal impedance | strength
>>   ------------------+------------+-------------------+---------
>>   0 / Type B        | 0          | 50 Ohm            | x1
>>   1 / Type A        | 1          | 33 Ohm            | x1.5
>>   2 / Type C        | 2          | 66 Ohm            | x0.75
>>   3 / Type D        | 3          | 100 Ohm           | x0.5
>>   (none)            | 4          | 40 Ohm            | x1.2
>>
>> [1] MMC_SET_DRIVER_TYPE_* in include/linux/mmc/host.h
>>
>> [2] 'fixed-emmc-driver-type', see JESD84-B51 Table 206 and
>>
>>
>> Since commit 5a52c5701a67 ("mmc: core: Fix host controller programming
>> for fixed driver type"), the selected eMMC driver strength is passed
>> directly to mmc_set_driver_type().  For a fixed eMMC driver type of 4
>> this reaches sdhci_set_ios(), which only knows types 0..3 and therefore
>> complains on every ios update:
>>
>>   mmc2: invalid driver type, default to driver type B
> 
> Perhaps the print above from sdhci_set_ios() is simply a bit
> misleading. For example, it looks like arasan_select_phy_clock()
> actually uses the value in ios.drv_type as is.
> 
> To me, it looks like the problem is that mmc_select_drive_strength()
> doesn't really do its job correctly, as it should help us to figure
> out what is supported by the card *and* by the host, so we can request
> a proper driver type when calling the ->set_ios() callback.

mmc_select_drive_strength() returns the card value directly and
the host value in *drv_type.

fixed-emmc-driver-type as described by
Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
doesn't mention the host controller, and the original commits
6186d06c519e2 "mmc: parse new binding for eMMC fixed driver type"
be17f1ce8572d "mmc: core: properly init drv_type" seemingly
deliberately left it alone.

5a52c5701a67d "mmc: core: Fix host controller programming for
fixed driver type" introduces a new policy: fixed-emmc-driver-type
is a host controller setting also.

If that was done by mmc_select_drive_strength(), it would look
something like below ( note it no longer allows fixed_drv_type to override
->select_drive_strength() , and fixed-emmc-driver-type will then hit
any nonremovable SD or SDIO ):

int mmc_select_drive_strength(struct mmc_card *card, unsigned int max_dtr,
			      int card_drv_type, int *drv_type)
{
	struct mmc_host *host = card->host;
	int fixed_drv_type = host->fixed_drv_type;
	int host_drv_type = SD_DRIVER_TYPE_B;

	*drv_type = 0;

	if (!host->ops->select_drive_strength) {
		if (fixed_drv_type >= 0 &&
		    (card_drv_type & mmc_driver_type_mask(fixed_drv_type))) {
			*drv_type = fixed_drv_type;
			return fixed_drv_type;
		}
		return 0;
	}

	/* Use SD definition of driver strength for hosts */
	if (host->caps & MMC_CAP_DRIVER_TYPE_A)
		host_drv_type |= SD_DRIVER_TYPE_A;

	if (host->caps & MMC_CAP_DRIVER_TYPE_C)
		host_drv_type |= SD_DRIVER_TYPE_C;

	if (host->caps & MMC_CAP_DRIVER_TYPE_D)
		host_drv_type |= SD_DRIVER_TYPE_D;

	/*
	 * The drive strength that the hardware can support
	 * depends on the board design.  Pass the appropriate
	 * information and let the hardware specific code
	 * return what is possible given the options
	 */
	return host->ops->select_drive_strength(card, max_dtr,
						host_drv_type,
						card_drv_type,
						drv_type);
}

and:

static void mmc_select_driver_type(struct mmc_card *card)
{
	int card_drv_type, drive_strength, drv_type = 0;

	card_drv_type = card->ext_csd.raw_driver_strength |
			mmc_driver_type_mask(0);

	drive_strength = mmc_select_drive_strength(card,
						   card->ext_csd.hs200_max_dtr,
						   card_drv_type, &drv_type);

	card->drive_strength = drive_strength;

	if (drv_type)
		mmc_set_driver_type(card->host, drv_type);
}

But that doesn't help with drivers where the controller does
do not support the value passed by fixed-emmc-driver-type even
though the card does.  mmc_select_drive_strength() has no way
of knowing that.  The ->select_drive_strength() callback
allows selecting different values. fixed-emmc-driver-type is
one value.

The warning in sdhci.c seems correct.  SDHCI is an SD standard,
so doesn't define value 4 (and only has 2 bits for the field).
The selected driver strength is not being programmed - deserves
a warning.

Perhaps if the affected driver implements
->select_drive_strength():

static int ???_select_drive_strength(struct mmc_card *card,
				     unsigned int max_dtr, int host_drv,
				     int card_drv, int *host_driver_strength)
{
	struct mmc_host *host = card->host;
	int fixed_drv_type = host->fixed_drv_type;

	if (fixed_drv_type >= 0 &&
	    (card_drv & mmc_driver_type_mask(fixed_drv_type))) {
		if (fixed_drv_type == 4)
			*drv_type = MMC_SET_DRIVER_TYPE_B;
		else
			*drv_type = fixed_drv_type;
		return fixed_drv_type;
	}
	return 0;
}

But that requires the changes to
mmc_select_drive_strength() and mmc_select_driver_type()
above (with its caveats), so that ->select_drive_strength()
overrides fixed-emmc-driver-type.  That would be fine for
drivers/mmc/host/sdhci-pci-core.c, and probably
amd_select_drive_strength(), but it is starting to get
complicated.

A simpler alternative is for the affected driver to hook
->set_ios() and fix up the value.

void ???_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
{
	if (ios->drv_type == 4)
		ios->drv_type = MMC_SET_DRIVER_TYPE_B;

	return sdhci_set_ios(mmc, ios);
}

And in probe (assuming struct sdhci_host *host):

	host->mmc_host_ops.set_ios = ???_set_ios;


> 
>>
>> The mmc card itself is still programmed correctly (the HS_TIMING driver
>> strength field is set from card->drive_strength independently), so this
>> is a spurious, repeated warning for a valid, documented configuration.
>>
>> Change to only program the host when the eMMC driver type value maps to
>> a valid host driver type.
>>
>> Tested on i.MX8MP (usdhc3, eMMC in HS400) with
>> `fixed-emmc-driver-type = <4>`: the warning is no longer logged and the
>> HS_TIMING register contains 0x43 as expected.
>>
>> Fixes: 5a52c5701a67 ("mmc: core: Fix host controller programming for fixed driver type")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
> 
> I have looped in Adrian, to get his opinion on this.
> 
> Kind regards
> Uffe
> 
>> ---
>>  drivers/mmc/core/mmc.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 05444ecf3909..ff5d4b805998 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1371,9 +1371,11 @@ static void mmc_select_driver_type(struct mmc_card *card)
>>
>>         card->drive_strength = drive_strength;
>>
>> -       if (fixed_drv_type >= 0 && drive_strength)
>> -               mmc_set_driver_type(card->host, drive_strength);
>> -       else if (drv_type)
>> +       if (fixed_drv_type >= 0 && drive_strength) {
>> +               /* eMMC driver types >= 4 have no host controller equivalent. */
>> +               if (drive_strength <= MMC_SET_DRIVER_TYPE_D)
>> +                       mmc_set_driver_type(card->host, drive_strength);
>> +       } else if (drv_type)
>>                 mmc_set_driver_type(card->host, drv_type);
>>  }
>>
>> --
>> 2.49.0
>>

