Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919101DDC1D;
	Thu, 18 Jun 2026 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781798116; cv=fail; b=b0+p3VdiJUCMKxkTRVaCqhUXm5wQPerz2akGdqTTfGGdBJm5DUjjaWcoNIBOZNBBRTh87h29Q0JQ1lX0jjBTwIzqcvaz9JtB+P0fNPuDOucHgN3nxuX4ubvCEN6hrvq9RJ1ZmYj+1+SlRxqVeXdCycH+5w+cCgjpD6LQYKk0fLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781798116; c=relaxed/simple;
	bh=qoGTIpH4Kt7FjiZ5J+kX7tsPnuik89WNb9MGPZQtmpg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hEcA1RT1haHsXcQhWwYZvy90/QnW3u4TsZ7frxaGhoFyAptMvLPdsQQ8ZM/+mwRkXwfw31DQmcbvPSaLUOFMv1dyCR274VPhhkOK3j/k5jjQzV91aPW6qYGQqKcAStqKXTx4WJLx7vEXU3ygpv7PyRXw6PO+N+YJo9vO0hh+gw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D55a5NVg; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D55a5NVg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781798114; x=1813334114;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qoGTIpH4Kt7FjiZ5J+kX7tsPnuik89WNb9MGPZQtmpg=;
  b=D55a5NVgZ/MTxIfXwIEKmlpAhxR6y1sDwruizzFgyagtOhsVlnFnc+ik
   aQLdjElgwBENV4/pbwtCMRCx6yO7LPNlV5AFixjzkcSfKAcjvYsLiwLRI
   p+v7XUWDQeNXpOpUjBKdPyd3FYOKzVDOTZKd8de2xanzriNz0NEzV7w1e
   52GZGKx/osWJy5MJ8OOahM0VUk2VANfTVU2onIvSfqLzhlLFEcPXspUkz
   w2btYMgaUUMq2Flf2gaAjqQRSk9HqYlJ6aew85mwAmBDJATaoHdg7153z
   iTx6H4IMVARl5Ka36VuupCjAy47tgW2GFaZfgp5FtTfj7ctg3lIuSuoeu
   A==;
X-CSE-ConnectionGUID: 7X1okvrvQCmkcMhjAQ+S8A==
X-CSE-MsgGUID: CsjZ0z+JTpysPlNvzZnqCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="93286167"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="93286167"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 08:55:13 -0700
X-CSE-ConnectionGUID: v91v0pgQSPuX+Fq0VXxZsA==
X-CSE-MsgGUID: +rfcSeU7RbCbasF2ovn66g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="250296903"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 08:55:10 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 18 Jun 2026 08:55:10 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 18 Jun 2026 08:55:10 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.23) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 18 Jun 2026 08:55:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8DZ6qT2ABHn9DtKBoB3JsA9AAMoqG9I18YkUrzrKYnmPhYmrxE41SoiTMaa7QNpo6V9ixEEvovtFvJlwZ7OKAlHYhpO7bVYt9M/a6RyGoPcTRq1mJHxQ3NHAnPol8U0AkTxg6VTa0GI3eM/UUd0R1jsraPbOcZEP2flXBjjrxe5XXzfzIXQBX41UPXUn1P5iLnsYBW5zipaT2GpjZQ2whBqsvWqEwUGoa+O2Bmc8I11Roob9xFwp43BvlnVx1PmX21VDmEVXGkiJ8VRhR4fB/vt/FjC1BTGAZAAJUJBDpm+cG2v+UicfyjaPfql3mtiEnag8vZ/vsG0gT7eBrClkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDlCJWFwx5uZbmkW6lpFMyPaRPHY7i/r5mSG7aYnkek=;
 b=YkIn6rhFZfj6WdUTn0vUI1gdt8kQQoE3LCKTPsb7qVvbmfKEoE7KsuZvpDuzCBsj5+Li+wDnwu3kUppF+UYR/G3sV9zhaKI0uc3xY1Ne1+f1GLUxYWNQmwlHRo1NzNigFyf5vYysbfoGWrU39Psac2HA0m5EchzvjhfpKsukfY4Us2xAJW9Ld1v2czc0Yd5tHqN+lYc8bfkRfFaTNjFpB46EOjIjsTQlMdkwj0D/FN7pwYS/pbPVnmzZijo27I+zi78ZjQiVZeBQA6mEBO1VzUjJOU/euctpnxCV1oQQMf9otKyISyUH4M9GvqdQ0DvitY/b2i22uVXr+wuO8P3sxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6967.namprd11.prod.outlook.com (2603:10b6:806:2bb::15)
 by DM3PR11MB8713.namprd11.prod.outlook.com (2603:10b6:0:45::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 15:55:08 +0000
Received: from SA1PR11MB6967.namprd11.prod.outlook.com
 ([fe80::36a9:3aca:a63e:c8f4]) by SA1PR11MB6967.namprd11.prod.outlook.com
 ([fe80::36a9:3aca:a63e:c8f4%4]) with mapi id 15.21.0139.011; Thu, 18 Jun 2026
 15:55:07 +0000
Message-ID: <a2c08300-d999-4c76-b75b-db9548abfbe6@intel.com>
Date: Thu, 18 Jun 2026 17:55:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: Intel: avs: Fix d0ix reference count leak on
 set_params error path
To: WenTao Liang <vulab@iscas.ac.cn>
CC: <pierre-louis.bossart@linux.dev>, <amadeuszx.slawinski@linux.intel.com>,
	<songxiebing@kylinos.cn>, <verhaegen@google.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, <liam.r.girdwood@linux.intel.com>,
	<peter.ujfalusi@linux.intel.com>, <yung-chuan.liao@linux.intel.com>,
	<kai.vehmanen@linux.intel.com>, <broonie@kernel.org>, <perex@perex.cz>,
	<tiwai@suse.com>
References: <20260612032256.23504-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20260612032256.23504-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0006.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::18) To SA1PR11MB6967.namprd11.prod.outlook.com
 (2603:10b6:806:2bb::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6967:EE_|DM3PR11MB8713:EE_
X-MS-Office365-Filtering-Correlation-Id: 76fda2bb-e27a-426f-6329-08decd51f81d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: CS2QFW3JTlUD0VxON7CQeMcxRYyk5UsUupBenUZ1HIWR+c46DgZKFQmd3yC7eFO1ME6jw+mBY//8CA+D8rmXR2xu1JU7G00eDM5T9YlYexh3eDYc/ujVgfD3Let2jEggn+Mk5LqaQ3lN35xr/KZl3eVFdmmyo1WuD+aOpfVIs0edKATICemVjMP6lXq08ohPeXQMpoyFZ5FE7TWrG/ddMBN497wH0aLKpCK9/QCRk2rX0YK6wEKEf6ZpAWTr8AWeTyUa1W6uNV6g5O0YPlo4v45GWfBkq8h3O1XVQM8qGrgM2DjkRlJwNHoOxhOaLXnhHXTbuof4owLjXMxKaCiYTISE+CvlAuX9d2xKr+xr5xTw+M0n8s7KVLyndOimBT9+QDrs2u6HjxwcPp73XGhbXcAuMvp86BzUKTnBl88j3hC6p+cVYOMgk6bbrrH1YyoWlPIX73/78h9EMA2eiZ9iGyPzY60TeB6IV8ocZLhdxLuCqnPQ1XMzK1WsEEJ9n4SFhc7JP5DC16MHlCvlyqqH955mqEBriygNrUN72BQ7mYw0PA42/cZMDQtQWCog33ofOAN5YV8BjRjniB+Zu4eUGC480a81IeGMCKNYfTIf4LpE1yH4DSNpcGPZMTJegXBee1YPBoxiVJdX8UnG61AZyBSQAfLP8p5eNdxDxjJHuTsFPevOgAuqYl5xNUiS3HcC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6967.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODAvSnU2dTJCbEFOUW9JY3U3dldPSldpaTVkRlpQTHZNVDVqd2I0Y1FNeHZa?=
 =?utf-8?B?Mm0yZ1FxRUIyekZYMXBWeWF5SmpHQktqeVNBVUlzUHR1SjEzL1BTbHZoKzhB?=
 =?utf-8?B?WW4rTHk5WkdKNmRLN042aktGQW92bEZPdXNVUkNkbE1ydkRnM3BWUk5JVEFX?=
 =?utf-8?B?VzUxWlZpOXNRcXovbkpIZk1GWU1BV2VEY09MUXZpdzRkVXRqKzBuOTNKZkhh?=
 =?utf-8?B?MXlJaFM4SWhMbVZRSXdiY0pQVCtXdkhTekUxcVFRdVg5UTZscmNYQWE3b1Zv?=
 =?utf-8?B?Sm5DWVE0YVJzT1lUQ2YraHBrU3J0UXR5Z2F0RU1IYzljUkx6M3FFZFViZnZO?=
 =?utf-8?B?TVFJWlZOVitTKzg5YlpiVFFzSEtvdFljWnVocDJORUpNWEJybUFoVzMzamg4?=
 =?utf-8?B?a29LMk03N1gwV2FxY3BtYnFGenNuZ0VhM1lYZTJqQWc3cEdVZmJPUmRqMFBK?=
 =?utf-8?B?TkFmbllMbk1pbzR3dHlqY1RQSlBmVXpUR2VYaDNjcXNVQ1g3Q1FTb1p5ZmRT?=
 =?utf-8?B?K3RoVEI5NTRpQ1JFSlYrbER2ZjdxVUZveEtVSExUUkdBUFR0Y2M1S3haUG80?=
 =?utf-8?B?VW95S1Mrc20vbWxRMGdvcENIMlB0Z2hDaGJwb0lKMEdvWTAxUXBPN3ZvYUt4?=
 =?utf-8?B?Y0x0U20yS0t6Rmdic3JVOC93RlVxOHdTU0pKYzhGQy8xeFdUWVI1UnhOVlNK?=
 =?utf-8?B?Y1FaNE9wcEZJU3pBQVczWGVHTGNQOUVOWXMwNlVsalYzdFl2SWtoWVpYeWdz?=
 =?utf-8?B?V21ZUWc3L3pxWXdVU2hoYmlWMG9zRVFya1BOVlB0ZWQ5V0VJVjhUYzBLMUNE?=
 =?utf-8?B?dkJaVHluZXpENW45WlhZbFlTQnRJemhzOThXYWZEUE1tQ1NuVWJQK29saXlZ?=
 =?utf-8?B?Y25HcDBvYnBvNUJJSERwK3V5SkZ0QjZSdkxGUDE0MktsN04zSndVTXEwZTBM?=
 =?utf-8?B?QUFZWFRsR1VSMUdvVVMzUk5oU01yclh2Qk5aRFo2MzIyZlZ0c2JRNkpzMzEv?=
 =?utf-8?B?S0paM2NwYUxveEtub2MvMFQwZTZNNy9GeXk2L1NYam9XZkorRWQ2ZkJLRitw?=
 =?utf-8?B?RVZmcWdJQXZlQURSU2JpQkYxQW9QRDljS251azFSWk9zUDQrZFZuVU5raHdH?=
 =?utf-8?B?NjBXVXlpOW1hVk5kNzhFaWpBRk9PbUU0UHh5R01TZ2s4Skc1Tm9HUktldGhL?=
 =?utf-8?B?YkhwTllINTBVQTRXbWdvVWlOZ1U1aFVsZERuL3BTVk9VMkY3N0ZqSkRMTmZi?=
 =?utf-8?B?Y0ExY1VpR1p1M1lGUkI4bnR6Q3g4b244U2V4QjBvMnBPZWlhTG9USUZlUUpP?=
 =?utf-8?B?eXZxV1JJQW8razh5TE12VTNkZ1d1T3pvZElXTlp6cUR3VTk4SUkrRWw4VGhl?=
 =?utf-8?B?blpSUmxqZWtlOWQ2azJISlBKb2tsMWJWU1ZGQlNxUG9oUFpuSkNLL2duSDFi?=
 =?utf-8?B?dXBndXVXM2ExMWRnRkxTTFdySmYwRkp0SlkzSjF5ZlJoYmtpR2hIcFBaNm5p?=
 =?utf-8?B?OVdBTHNoNGI4M0oxY2RIWVE4RUJQeExKKytudnU2dVJSakMxVXlPWnJXVytD?=
 =?utf-8?B?ZDhhZWZTZkNrV0xwamNBem96YWpiR092WmhhSHc3WWo1WHRKWGJ5cStOMkVJ?=
 =?utf-8?B?LzhRbnRqODlJL09Ycjd3SDZZZHU1UURUN3Bjc0JRYWZrS1MxR09BUGtRQkpV?=
 =?utf-8?B?VFFDTUNXWTBkOFBEN3ovQkx5NllGcldLdGVJa0Y4bDZNeG9Oam5EejhIUkxv?=
 =?utf-8?B?dWpUbm9MN0xNeEh4MVhkUk9OZ2hORlcwbEx2Y3g3RGxpa2xVbXZCZmNJQ3JP?=
 =?utf-8?B?V0JmTUlYZTdkK1N1NnBVaFhHMDJkY25MVmxqSDRySS9DVnVnaXZVUXVPM0t1?=
 =?utf-8?B?NVpEVlZYczhiN3ZldmFkVmp6b1VPNGVkTmNZaHl3TmxYNlNnTWE5U0xIQnN1?=
 =?utf-8?B?NUtZek9QSERJZERvOGZIRjllUzV0QzRNb0RZaE1mZkN4SFpKcGpPeXdQV3Y0?=
 =?utf-8?B?cmJLSmZ6Q0NUZVI3M2VjSElUTk40T0lRTWw1c0h1b09TSm5iemZpVy9PamhH?=
 =?utf-8?B?TDZZRWdFZEgxdHQyck4yTmF4UU43YmFjWnJJaC91MHdCb0plR2MxSVJUcE0y?=
 =?utf-8?B?T0VuUnFSQ3VGYWc2RThpRGs5VUZRaGUzYytxeHYwL1FOMUdqTzBodmFsZm5R?=
 =?utf-8?B?WE5lWEtpRk9scUhpcFVFUDZSbzFYaXdUc1ZhWjhIMHE5OTlzT2dRaXhMZWkx?=
 =?utf-8?B?azNWR3QveUQ0ZE5BQ3IweGRhbjBrZzNYSVVsWmh1QnhUUE5nV1dDaDFsWW9M?=
 =?utf-8?B?MUdPY2hodlBacmtsOTJjMlF6b3J5T05aZnN1OXFjM3gvTEFUTzdGZVBGcDE2?=
 =?utf-8?Q?U1V3WdFkqqSdvFUg=3D?=
X-Exchange-RoutingPolicyChecked: V5X2yHoyQFqFr0ek8YmNw4l4Lbza2/BCVMjNM+OikPbOsbPLVEPt+5LC2zs8/W4IGQ7+KoAp4/CG4OdgENidFAIEwirW0gOfnuBFMuwuV1eisaOK63HIVV2ZAfYR4JJCGP/HmltlpO+ADe2cHFOAcZ4XrQWmcXoOQkNevsrPgB07ceqUAhtoz7tS3VxNWn4qdrXvWayTRKsjUrBXz3NRDyl7fufd4CApsl+Z8tb6ytdjyfiHwiCiBXn9wGOZ8H+pmz83/Vl29/hbkD3nTMOXwbi9tyNkrOBZCpJlZ+TgKat7hz9Inh3vnaxFvfqHGhsWL5lDS255QaSpgrm6whn/Iw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 76fda2bb-e27a-426f-6329-08decd51f81d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6967.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 15:55:07.4589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDHC6N2MOk6zIHfO7IQCJtnzrqjvznB2m6d6M3hALrUJeVWpCzT9C6X/QAFSiROq2l3aWet9NtNN+UYY4euqKcL/DFal7fgPrBnNZPzxMuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8713
X-OriginatorOrg: intel.com

On 6/12/2026 5:22 AM, WenTao Liang wrote:
> In avs_probe_compr_set_params(), avs_dsp_disable_d0ix() is called when
> no probe streams are active. This function atomically increments the
> d0ix_disable_depth counter before attempting the hardware power state
> transition. If the transition (avs_dsp_set_d0ix()) fails, the function
> returns an error but the counter remains elevated.
> 
> The caller does not balance the counter on this error path, causing a
> reference count leak that permanently prevents the DSP from entering
> d0ix.
> 
> Fix the leak by calling avs_dsp_enable_d0ix() to balance the previous
> disable call before returning the error, mirroring the existing cleanup
> pattern used when avs_dsp_init_probe() fails.

Hi,

When using AI assistance to generate a commit message the strict kernel 
rules still apply.  Please plainly answer _why_ the change is made, no 
need to write a novel.  The last last two paragraphs could be simply 
dropped.

See Documentation/process for a number of helpful guides both for 
writing doc manually and with assistance.

> Cc: stable@vger.kernel.org
> Fixes: 700462f55493 ("ASoC: Intel: avs: Probe compress operations")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
>   sound/soc/intel/avs/probes.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/avs/probes.c b/sound/soc/intel/avs/probes.c
> index 099119ad28b3..01d9421cf9ab 100644
> --- a/sound/soc/intel/avs/probes.c
> +++ b/sound/soc/intel/avs/probes.c
> @@ -162,8 +162,10 @@ static int avs_probe_compr_set_params(struct snd_compr_stream *cstream,
>   
>   		/* D0ix not allowed during probing. */
>   		ret = avs_dsp_disable_d0ix(adev);
> -		if (ret)
> +		if (ret) {
> +			avs_dsp_enable_d0ix(adev);

Things are not that simple with D0IX - D0-substates.  In short, if 
SET_D0IX IPC-message fails, the recommendation is to forgo the process 
entirely, see comments in avs_dsp_set_d0ix() and avs_dsp_get_core(). 
Blind enable - no.

I could see avs_dsp_disable_d0ix() receiving an update that takes care 
of lowering ->d0ix_disable_depth in case of non-IPC failure, if you're 
willing to follow up.

>   			return ret;
> +		}
>   
>   		node_id.vindex = hdac_stream(host_stream)->stream_tag - 1;
>   		node_id.dma_type = AVS_DMA_HDA_HOST_INPUT;

