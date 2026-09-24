Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92B64AEBF4;
	Thu, 24 Sep 2026 18:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790274721; cv=fail; b=e/uzKHhmkTbN0+cl5om/X5E6Wpjs2wK09IWLdByw/Idj8JhT3qhl9fKwvmm95Dfv0wL/WdVO5rvATMvyg2ETZjUAYpcjRUQs8zVac8HeMDnDPDoNc3hDzbSWspCl6oXtQJcjUO1aLOXlfXhxhZfQOXO4t1pRzm3KMX/ILZXi800=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790274721; c=relaxed/simple;
	bh=DHRIdOp3k/8jGjqPtazQ1fHveCWJCJdn+5aI3uqFp8w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UVcS7DPkN36LwktIiySFGkuLi2OHlK1RvJDP4vcRvzUf0tk+juA1mkZiovdTm7JW2PoNs56+m5i1ilT28MI+3ozhQLcLNeQor5nmuAmNHRWWeg5S7EKiwaa/N1lw2u3KAw4lFOTJ+z8QcCz4DBWt3vU9WLWEk7iIfNyZCalZUfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bug1ED/u; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bug1ED/u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790274720; x=1821810720;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DHRIdOp3k/8jGjqPtazQ1fHveCWJCJdn+5aI3uqFp8w=;
  b=bug1ED/u7yJrUg+MZUxr+eEZSPIccxjByikn050gBYdTh2c/NASGqmw0
   1cy6mHnUghWdenKvEn5mXGpRNz4apDCy9di+mC+dLhYiLWkPqXcWqY/Q9
   NF3ahpXgLvzx4MUUZt6Z/bqC5n2AV5QmciivmGOibQiKJG5SDOHCIutb+
   XoC0VUBP7q45gXyrHuKkvGAWQi4mbs2j6c4vMLfIPbZ+ghM+leQ+pCUDb
   7B42KbmxD0KcxXjMQYYio9wYseiLiVubf4JL+6cnfVq6EUMqAx9xiu9L1
   o7zRmZV87A7NGbvqXRaC+nWbzG5BAgefU+hcU8Tk16jynsRmzR6dawkFd
   g==;
X-CSE-ConnectionGUID: vRMiEmyaTqicjVDyMoI/Ew==
X-CSE-MsgGUID: wGKtSFWmTZmX8Bbt4a4fog==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="91076890"
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; 
   d="scan'208";a="91076890"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 11:31:49 -0700
X-CSE-ConnectionGUID: y4lESnGtRPK+SHNJpuZpeA==
X-CSE-MsgGUID: HvT4AEHOR2WnB3vFeYtbLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; 
   d="scan'208";a="273604004"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 11:31:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 11:31:47 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 24 Sep 2026 11:31:47 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.61) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 11:31:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahpRid55iZ+F+JL1EMQL9QIMl/4KTLmo6UW5kpXrGbBxgSDTwsmDTNeEtCCPVxpIYB7gUZzOfsyQ5TFEl1fF5nYpC7fjMU1tSMyQUHlYppunWjuyteEzJ8Y1Dyd3k8PL6nb9tIdf3ZQ0RzJn3RxB5qp5Ln2MnOQV/uN5M5Itp0mZ4lnVfx+//CQklbjiX6zsljqV4mufUZK0hXEYpUq23fG5+jX8XB8m3mlkZ3SFVCigYRSxBsW47K1WJjqoBsCdZ4aZMGqK5MWztjYwU79/lIpO2iw2VoA4ukU1yi4ah2Kbyn5GYYg5YoR+HnEIXxrFXXRkkd4pnSWMgRvh1teAqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjZRJ64W/6cUtb+ZgWg9KsAPEwpQFCP9PQN22BeycoU=;
 b=WdTIhGaS9TSIz2L3yvCLyipVNJAliIYoJhtWshRkWkCAR9EwzsnRE8mTmG5PR8pavnxMhlrHneGhyxQiNNZVZ4hyqxPjl2/xr/zbysnA0GPYtc1gCt7zAd/X63mY72/QoBAnupAy8zhCq5anrvQhs+vF850gKW3+gUfK5rpcgJ99SzoFeFmOQpqwGMVHdYbb1H3Zbb5gchPcJfPNAHxI7++Koh6AiorOGImQFxMd1dD3io0oYotBZ6SiBGxkO0ejCwd9yggDLE2fQhFYJ5gqLbwVuY+SIsFki7poebgm1x/3LDMJNiXJbNZux/PALctSdmlSmRX95iyb63qLy78Txg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6006.namprd11.prod.outlook.com (2603:10b6:510:1e1::13)
 by IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 18:31:41 +0000
Received: from PH7PR11MB6006.namprd11.prod.outlook.com
 ([fe80::4e2d:28f0:ede9:73bd]) by PH7PR11MB6006.namprd11.prod.outlook.com
 ([fe80::4e2d:28f0:ede9:73bd%6]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 18:31:41 +0000
Message-ID: <2fc6ef64-82e6-474c-9d4e-4d291ed2a1d1@intel.com>
Date: Thu, 24 Sep 2026 20:31:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ASoC: Intel: atom: Fix platform device leak on probe
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
References: <20260924134932.1590967-1-lgs201920130244@gmail.com>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20260924134932.1590967-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0023.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::7) To PH7PR11MB6006.namprd11.prod.outlook.com
 (2603:10b6:510:1e1::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6006:EE_|IA4PR11MB9278:EE_
X-MS-Office365-Filtering-Correlation-Id: c2483622-e691-4520-0a78-08df1a6a13b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: HY3eAqM8coRqZGI+1wfcKyqihncs3JYRP0vN2j/dPAVOfOIYF6IsOD8ILg8S0CoC0xJePGVgJ+sJP9Ink29Yw/S0pVg2P9PTiWUAzP5HiXmSA7JMtAZer6TN1Tl/4MhsEkeoMj5iwIocUlbhjDqG7vCu7+M58y7FiofXGfKs7XLz2zdgUGslNx8P1rXeA+fyS1aWAiKNtuBg2VsZL/LKZT4IAL9gmScqJ+ktXkddNlDTFk8v0VUa5n3GEptv5tVznUWCmqoWo4n2gwAK3TcRGW/MT3+QDqgAjjERAUnWJL64K+UROJrGSuwWp35qYfPRHSMLwFP8/B9pQdvR6QWJ8+4nS1BWpRXAnIK/KyReLKtiLnJi6AjfLK1X417jF3ycjnuPvaZI57MDI2KhASsfvyiIQKxCdBfJyXv//qocvUsZ+Z2ZmbtYXmAPkR9QGE4wxryp5a3GxG+0cHvPlZ50vY1+D6BcrDObZ54wtdZXbQf7lPCwGKZNGBLwY2/1AHXK06ig+wZr+aGsLbhGiCSF+K0xrodWp+/Es9VhMbt0ROiQPgG4oSbNqO0U0Sd6n5iznNsMVtkW2ZSEQ78/421CQnBXVOd/p5oPG5vzSnODN0DocmREwSmYTsMnNWeixe38x4vXfoGmqcY2o1fOoukj3GlqGagc7IU65efxwJJQ/iY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6006.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aStMZkJHTTlSbHlQdlNnU2lLejVHdkR2UkdVM0Q0ajYzMklWVFlSTUVHSytv?=
 =?utf-8?B?TWRuTGd3YThGK2JrYnkveEdQZFN3REdUdVd4dEhRRGdzcVpzRlZKRkhqYjN6?=
 =?utf-8?B?YmVSNnZyUmYvdFVXMUM5TkszRzdWYVZUOGRTZWRST2Z3Kyt3ZjRtMThJMEpD?=
 =?utf-8?B?L3VSeFMyUzRjMWJQY2hFRlpkZHd2RmdOVU9TdmtxWlEraVJrSDBHNjZwTFpJ?=
 =?utf-8?B?NVFBdlpiSm1sQ2g0eWNaSkRaTmFwa1cwMW9iUENtTkNoQW12dmtWVGswNnMz?=
 =?utf-8?B?RTFxNE92NlhNOU5ib0hHZFN5Y3I0cWNKb0xBK2FtSmtrV2krdE0xV25iYkNY?=
 =?utf-8?B?TTg1c1MwM0Z3dlZkUS9OZWhYSW9XTWtlNWhEaEc2WXZHUzdvV0RuNXpkY2RO?=
 =?utf-8?B?Mkw5dWk3ODdIeFdUYWc4VGkyaWNsZUtrNEJzZjRjMjMrbUxVMVl0ZEE1c2FI?=
 =?utf-8?B?YnVqSmROTmt4MFB4Z0g5ZzNiTE03RGE5MHRSYW1KYnVhUlA1OHdCNVFQd3VL?=
 =?utf-8?B?K1Q2ODMvUHdwZWFwOG83a0NUVGxOQS83WGlwNlA4STBRc1o0SzlibzVieWNv?=
 =?utf-8?B?d05scEpoNUlUSDRzYjdzMHZWZXRsN1FGRW14TW5hYUFxR2NaN1kxMnhwRGoy?=
 =?utf-8?B?bHA4UHl6RjZxdmJZRDEzMTVKWGwrOG95MXRSYmVGT1pmL2VRQjUxSjNkQ2x0?=
 =?utf-8?B?MTlUZDY3aHhwS2NJdEVEQXRzMi9YUTBHdXRMQzZiUW1vb0o5eXdBUWtHVkYw?=
 =?utf-8?B?SkpBQmg3YXA2Q3hMU25VWXZ0TGtmYlhVc3JIUmtLNXlkeHBGU1l3bTFubUdI?=
 =?utf-8?B?ZGw5MUFFMVlrL29pdGw0OUFjZi9GOG4zeHl4cmhiNk85dk5yNEF6OXRrSHhv?=
 =?utf-8?B?akxmamV5L28rOVVzb2lhaW9SbmFCN3Nsa3JIcHV6MUtWQ3JQUHVxamNEcU40?=
 =?utf-8?B?bDA3VUNVSk11WW5McjM3MTFTRWZYZWVxUGJDZjkzQ1d0MjM5bTl3bVJhbHdM?=
 =?utf-8?B?L2lFUHo5aS81YUxmTEFFdlI4dnU4UXhxeGJEZUFRUlNqcXJjZnZIVWdkbloz?=
 =?utf-8?B?TjA0THZFckw1Q0ZNS0ovVzh6aXhlS2pobHpERTFqOVZOWHM4UlN4VnUzNTU2?=
 =?utf-8?B?K2JPZlIwd1dEMVNOOUsvZC9nbVVYRVVHNVl5eDcxM2pqU2R3eHF1cDdIdTF5?=
 =?utf-8?B?WmFXd0U3c2dFZS9QSXR0WDFmUXZzMFFHMTFZVUlxekx2bXBTNVgrMmlYWnJO?=
 =?utf-8?B?dlF4UG1iVTgyb1JrRmRaZUNEa1g2dFM1bGFyZjRlYVNWTmw5cXdGUURROW1S?=
 =?utf-8?B?cGsxaFVscmZFbVp5dXphbHh5bXdFazUraDI0RVIzczJ2QnVQdXpHT0dYY1FR?=
 =?utf-8?B?NGNuV2V1TWZseUkzOFNpT2M1ZEpuNG1qNFNuSitxL3N5cnpNM3FlUXZrMFRa?=
 =?utf-8?B?ZkNiZ2VMU2VrU1Z2eklKa0ZSZjVJVDdXb1IzMFVOdFg3ZGp2WGVkMXBrSUxn?=
 =?utf-8?B?d1U2Q0NnZjlnUk5DWVNmUWF0a25QczlIUlB1U0tUYmNZU0JNMEFsb1NtSlgw?=
 =?utf-8?B?dU5qTytkc0M5MTdCbFFtcm1ZRzkvS2x1dDYwemQrQld3d0lvcU1Kbk4vSVRS?=
 =?utf-8?B?V0ppZE1iQ1hOVjFydzdsSFliRnRsUkFwQ29STVZNZFFwWG9kOFlBa25BeTB6?=
 =?utf-8?B?WHcrVmtxbEtSdDlrV0oxM0FZY0ovQTVhWXEwZ0NnTlZvZnJBYXdmSTQ0VlM0?=
 =?utf-8?B?OC9CTTVyWXBUWE5haGFzY1hHa1Y5aDkzYi9Ud2Y5SVBqaVBGYkVoTFUwN09C?=
 =?utf-8?B?SGR6c3REMWpUdUxjOXM5RzFSNG9IN2N0Uzc2ZWs3ZTJrYlN3ckZaNjZvQUdR?=
 =?utf-8?B?dmpMYzJJUm9mWFN6QmpGcGVIU1lxUW91TG82Z29xdHh5VDMzVE1lRHhOWkRo?=
 =?utf-8?B?UHl4TkZTcGFiMlMxekpybzFPTFBQYmVmclRmKzJtUFNkUkZDZ2ZzdGczRHp6?=
 =?utf-8?B?cU1pQVhvTjQzVHFiWW8zd1hIQ3BrN1Q4aUhqeFR4dVE5QWFjNDJDTk4rMVBw?=
 =?utf-8?B?K3UvTUlFdUcyNU8yY3ZjN1VkOWRhTXlWeWRLREJHR1pYK2FzR2FQZk9oYUdq?=
 =?utf-8?B?QUZRMUMrb1RucVgySGNJRVNObGhoMWJadUtVUDFzQ1MyWGVxelVncVY5dVR1?=
 =?utf-8?B?WFB1L2piMmNXUFRHOXlnQ0REZjZVb2pxZ2EvbWF0TXZFbjQxR080cGJkOUZo?=
 =?utf-8?B?STY1emcyVzgzQTE4WjBrbXplVUZaK2JqOHRGUXVjZ09VZFdHdWNNUWExRWhN?=
 =?utf-8?B?RmswMHpvRFNKYjAyWC81ckVONDk3ZEVVZUlSd0U5WjUxU0hKaGk5MTd1RzlH?=
 =?utf-8?Q?tcnykMit3RpF8uP0=3D?=
X-Exchange-RoutingPolicyChecked: QAz2oliX6z/HnVgZY0/P518pE8uUpHg0KzKlLLT4BATPUY0BNGI8zLccvkB6OUS8IDJBjrULLvHKm7g5lVMjEikBd+ZPgejoKmTiLB2+ey4NG8GZxgDikK897DTAVysYenAptONST0Vt/obovv9ejC6DNv3SGl6CbIfXLeuXUsF3sY7jBegTdTLyafykUZXlZUxB9D28X0knxnws9Y7+aKvwQ4EjZdXg1DcJ1pJt+i7NVIONAMLIGfrL1wY5J+l/F3f5bkr4i1S6qDeGDneIqRUtjD8l17m8fVZbhqvMfJnTPW6L4HzwuGhbA0ghAuKcpy81b0jiGx499zFFnAyaig==
X-MS-Exchange-CrossTenant-Network-Message-Id: c2483622-e691-4520-0a78-08df1a6a13b1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6006.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:31:41.1917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VLcVS2AFDHs3G8WFSFdChst4VzXyY1FeyNsRb1cRBYIrIpUKOVZhH7G0Ktmo3QXGQoH9WA9SWVSCgDGB5R2N0fEuqR3xnR2zq7QkQH062Aw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9278
X-OriginatorOrg: intel.com

On 9/24/2026 3:49 PM, Guangshuo Li wrote:
> sst_acpi_probe() registers platform devices for the SST platform and
> machine board using platform_device_register_data(), but does not
> unregister them when later probe steps fail.
> 
> Fixes: caf94ed8629a ("ASoC: Intel: bytcr_rt5640: fixup DAI codec_name with HID")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Below nitpicks are not a must. Thank you for the update:

Acked-by: Cezary Rojewski <cezary.rojewski@intel.com>

> ---
> v2:
>   - Use devm_add_action_or_reset() to clean up the platform devices on
>     probe failure and driver removal, as suggested by Cezary Rojewski.
>   - Update the subsystem prefix and shorten the commit message.
> 
>  sound/soc/intel/atom/sst/sst_acpi.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
> index 73624e1b138a..de1ad168008b 100644
> --- a/sound/soc/intel/atom/sst/sst_acpi.c
> +++ b/sound/soc/intel/atom/sst/sst_acpi.c
> @@ -254,6 +254,11 @@ static int sst_platform_get_resources(struct intel_sst_drv *ctx)
>  	return 0;
>  }
>  
> +static void sst_unregister_platform_device(void *data)
> +{
> +	platform_device_unregister(data);
> +}
> +
>  static int sst_acpi_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -342,7 +347,10 @@ static int sst_acpi_probe(struct platform_device *pdev)
>  			pdata->platform);
>  		return PTR_ERR(plat_dev);
>  	}
> -
> +	ret = devm_add_action_or_reset(dev, sst_unregister_platform_device,
> +				       plat_dev);

Nitpick: No reason for newline here, fits 100-char limit nicely.

> +	if (ret)
> +		return ret;
>  	/*
>  	 * Create platform device for sst machine driver,
>  	 * pass machine info as pdata
> @@ -355,6 +363,10 @@ static int sst_acpi_probe(struct platform_device *pdev)
>  		return PTR_ERR(mdev);
>  	}
>  
> +	ret = devm_add_action_or_reset(dev, sst_unregister_platform_device,
> +				       mdev);

Ditto.

> +	if (ret)
> +		return ret;
>  	/* Fill sst platform data */
>  	ctx->pdata = pdata;
>  	strscpy(ctx->firmware_name, mach->fw_filename);

