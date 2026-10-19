Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78A53DEADB;
	Mon, 19 Oct 2026 11:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792408546; cv=fail; b=T5aaVPBsLuOmJjn8t4ti6wCjfLQJC6ec9a2x+qXrf0NdBq7MkcRcoek8QApaadkYN+cvGw7tOlz8VG3bT2P75cfcIvlehfSSZR0oudrHm2hMfHL5kTb/exLec59Vc2OAADMhjT4UFo+ekAV2aA0JMtAYfbTcvza0o9n9SCdZU5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792408546; c=relaxed/simple;
	bh=QOTaO7AV8ponzQQYBdcFwITZZ1CXB5J+CtL5uVF823o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VOfhjZ6b2tCJggjevDcFySPs1aXYIJ3gztxEUQ1HMt5BK+PVMykYfekkB2DXzA0zOB7Sa0FVGzRyWjz2nd9U89TpuO6XOD1I69lvmVEdpK0jL5HdAzeGEkb4zoKtVFeiyn/eGit1xuiKMNo35A95uCHWJ7jBPUTVZTwDlWyYYoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ljgAoQ2T; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ljgAoQ2T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792408543; x=1823944543;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QOTaO7AV8ponzQQYBdcFwITZZ1CXB5J+CtL5uVF823o=;
  b=ljgAoQ2TmJKLJYYR44bqatz3pWcv1xUCi/MFjnVme6j5BRY2GzP2cMTB
   QYWjqOWd7ZDHYSqr6xmre26mKEO2DZTYXWlBCss2ltWZrUZxVhcF9+y09
   +9FDCyApENZdS6a6kvNZ7fsNdX4QO+K+C+IFTcbnlfMj0ah99B6ix2qlz
   CHGwKBeBf1ikfwBodQl4UyZv0aWhmtwALdVs2384q9fTmyiwxOFOeQ//q
   plWm3BaREDhLQrvnbK+7W7LIYoU0AbbGJfuhMQgMhrrJLqTaQ3+HZFPvz
   kIiqT9RlZB7WLyIU1rNT4v14xgG0PCTawzX8H1JPg6Y54eDARxSJxDCxz
   g==;
X-CSE-ConnectionGUID: tBw/dvMWTe6uJeAXebGCLg==
X-CSE-MsgGUID: HSRTsfZCS36zf90UlXJN4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="991192"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="991192"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 04:15:42 -0700
X-CSE-ConnectionGUID: 3CuIGQPwRfm6vAXcKcprig==
X-CSE-MsgGUID: +X+3vkGFSgmuVokDvEXM7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2872202"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 04:15:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 04:15:41 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 04:15:41 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.30) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 04:15:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yH54islXYGEcTGvNMsBfZg1XzIT7RP44/hfSGQy5jYpSMX/ig8W8g0QBNc0pFpuEc6Wc22FsLOW1vAAynRBWmQaaaX9Y/sZjZX5uJHtqfJZcqL7eSl3Fv7TQgTfeQbkmMvd/yer3Uv1F3du03CbnGEk9g9V/Oxig8IOKxTpyyC2YsbvG2LrZc+FojlT4NgQf/k4S3+ch+2OS5fVxHCyGZsOeXf9gRciU4keOjZoNYcQCLUUlyPUu1k8hd32aQJB22ryvdSnNMlfsBQ98UsnZwfBXILcYprwPqZpjBrp4tF2FX1ZRQ9K+ssJxW7MyGdUUYaD8ocqY1e7iDY4aWtqpNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuxsvQPmnjOh6vZ5/EvDpNG5sEwiruAWwUWJVdSRDQQ=;
 b=nZdPxT9+3t7kLE443Nvhp2zmv4xhfMKMMogFmViVisvyovtJQTqctJSdwjFJ9oGQ4hmduKf9eJS5C5dp0+rnGvmxigWU+YUWI9PByNTXUWKvi7J1HytHh4gpGZQD8dz4hcbLS5fO+Ee24Z3bsYMGTts/cNm8O1WmH03pZne5myGRYEk5M+w7qayNZ161kHRNUOzJ4q6X1UvyJ6YTdVAjtEIo/IzYHXut1Bq276+QiTmZpJYaJjy5fCCr4ML97zQpVIHPdex+whngP4xPhoVyEHpgj6QkA4jtSWD2YAnKwGiTliVsXq70Io7rJPsAR4k9GjQmf00z41Y6n6ZYR+CDzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by BL3PR11MB6385.namprd11.prod.outlook.com (2603:10b6:208:3b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Mon, 19 Oct
 2026 11:15:39 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 11:15:39 +0000
Message-ID: <2b6b01f4-3796-47d5-9f5f-8c548ced2840@intel.com>
Date: Mon, 19 Oct 2026 13:20:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ice: fix Tx hang dump using stale tx_buf[0].skb
To: <choiniere.vincent@hydroquebec.com>, <intel-wired-lan@lists.osuosl.org>
CC: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Michal Kubiak
	<michal.kubiak@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	"Eric Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20261016-ice-tx-hang-dump-v1-1-3df0f5979a51@hydroquebec.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20261016-ice-tx-hang-dump-v1-1-3df0f5979a51@hydroquebec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0013.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::16) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|BL3PR11MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: c28b8723-37e3-4197-a8fb-08df2dd24e0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|260925021911599003|56012099006|11063799006|261009223027099003|260925021311599003|18002099003|22082099003|10067099003|6133799003|13003099007|260925022911599003;
X-Microsoft-Antispam-Message-Info: hf9/E6kTFR9gc/gIURtV79SEsoq0v+4kkP9MzuhqEL+w/7AfjSTCBAGM/QCsiAMAWv7Me+IqjFXc6SV+duJ7wsiDzM4F+6lfb6MyNGZIWJiCselz5LEYl9WaS4G8Tvpa6Jl9tjuO3GNtBcFMZjKaUet7+Epx7GDS4xA0a36vaUlni2Q63jNHTC4yxxGrGsWXOmDFUN64To1cfgwDtlgJMGn8w1JB0pZHdDMGlFsn7eRwYMgI/PafwnGEY/BMJpSkjj2e32VcMHaYlIeQYVVmg/i9mSuLyt9PlbaePs+wk7tPbr9tZnM6Sd7SLwSXXI8h15LnH8l2L/GlN0hYImrgyfX/MfpHdmA6bv87tk3JYj6QyVl61wzlqDFNHzAV69UW9xGsa3/heQYinQOxIyTjY+I4RkFFDpXm4hFABu28OOAReAQmniF7bun88esqMh6ABAiDW1cxw4XkCNqTgzXc0IeaqLTEDHqt15WAJvFzo1vM5s53CihwMn3mG05gKk7nBF1OPXQswuuPIjsmch/mbgvarqjiPa3LgnZJOlxBrQWdQ7XtFM7zcjpwwDSkNEqvFpVCXuwKQsVsyd9kYGCvIHrR/8ryMeSaaoCUKTm4Gp1mLfQHgyHRxNAbPYyKCP8u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(260925021911599003)(56012099006)(11063799006)(261009223027099003)(260925021311599003)(18002099003)(22082099003)(10067099003)(6133799003)(13003099007)(260925022911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGxmb2VhM1I1dTZWUjhiSVlVZGFRdThvVW13dnZUM0VHNFNtV3RzVUd1ZFN3?=
 =?utf-8?B?eEJqaFVia1RRS3BVQTh3ZEpxY1VzQURUTWtRcUxTR2w4MGdyY0xWNGNuZ05u?=
 =?utf-8?B?ZDlRcEJUaEpEWVVvSnB0dHhDWmFHc1pPWHBhM3RnY21KOWNTaTdwQ1BUZkVa?=
 =?utf-8?B?c3VBbkVQT3FNTC9OZGxiYjN0N2FSdk5VWUlqRDQ2NXVqV0dnbkxSOUxrRXZt?=
 =?utf-8?B?ZERqbks5UkkzNk5EM0RBZk85VDdzd1k5bFI4Yk9YT21EL3Z6c2VSZjFKampT?=
 =?utf-8?B?aUdpOTRWMTZNWnVFbHNtcFErNS8zUVBzdWMxRFRMVlpiU1JiSlA1MmlZQzB1?=
 =?utf-8?B?MTQ5MUFzUWZnS3p3MDFMZDd1eFVOTUtSVEJ6cXVVcnkvYUZSM3BnWDMrMVdH?=
 =?utf-8?B?akM4QmtsMHdEeUg4ZWhTSW82R3pjYXJ5YndldHVnUWxyWnl2TXpjTXZNM2xq?=
 =?utf-8?B?dC9QVHFVdXFBMGFmZCtTeWFHYmt0U0lqVjl2NDFydWt3VWUwZVZKa1E0dlVU?=
 =?utf-8?B?QUF3bDFrZk13OFlzT3B5N0x6Y0s4bFJ2eTI5cWZCTFFmTFRzRkJUd3NxY1RB?=
 =?utf-8?B?UnF6K2dzZHNnTTN3V1dTZDRyc1kzbVBQWnYzMU9hNzhBenRBU1BJemFZUy9q?=
 =?utf-8?B?S29iazkzRVN5ZHd4bEdRTFJlNzhwQjBFeFE4aTJUcFBlWnUwMjVxazA4WEZj?=
 =?utf-8?B?ZjVqeXJjVTdCNTgyU0YzOFpicE9rNjNoTUFHZCsvNXZqZXRxTmFZVllQL0Nm?=
 =?utf-8?B?L3BVVmJvQ21CYmZ0QkxCVmxBSE0xUUxsMTlRSXhWWDRnb0JObGRiK0YwQzNx?=
 =?utf-8?B?TzQzOWkrWEo4L21HNE5VblpjNVo0dDZRSU5ML09EQnFnWEVkM2V6L2I3KzdM?=
 =?utf-8?B?T2RpZ0cxZ0pFWk96WE9iV3pMTnNjMldEL0c0L0xVNXdUMHJNODB0T0t4d042?=
 =?utf-8?B?R0s2QU1HYUEydmpUbzV0cFd2NE9KK1JIRHVrdHpGRUdPbEsrdWNhcU1MWGNO?=
 =?utf-8?B?RCtvcjNTaWJzV1BGOWlLQWJET2xRUy9kaHBKeU1pWWs3NkRVZ1dQQjZKdXEz?=
 =?utf-8?B?NjJ0OGcxYnBacXNyYlFLUC84STVUWFQ4ZmlNR1RHS25VNDI5ZTZGWkJpYW9H?=
 =?utf-8?B?L01nMXU2ZVBpYU5sK2ZJaEpwakFlRndaQnBBdVNnTXZUKzFOaHFSdTg3dC9u?=
 =?utf-8?B?dUI0VDdIWVg0c2ZhTHNtRGJWUzY1UXRzb2FGcGRIRHppcVo2bTg1cHVlU2dx?=
 =?utf-8?B?NWVmOThibUZaMUMvcXZ3UURZK2FZU3kwOVFoak1xYlF0RE94cmRwTUJVSnhp?=
 =?utf-8?B?MTJtRGJPY0ZHNVhvUGdRMTZCTWlnaUNGZUJtR092UlRyWmE3NUJpWVFvU281?=
 =?utf-8?B?TVRVTE5WZW0vNlZaMEU4dzBmbGlJRTZHNmE1cGZjeDVWcm5KZlB4eWh5MGhE?=
 =?utf-8?B?ZllFb0huUnRoUVZFRk52NXJqY2d5SlFMYk9yU00yOVJodlZLUU5zYXAraDZt?=
 =?utf-8?B?S3c2UnZQR3V2YjNKM2RpdktTOEdhbW9GaUpsZUM5cy9wRHJPK1BidTJydkNU?=
 =?utf-8?B?R2xFc2ZLTld1Y1NZQjZxNDBrRTc5OE5rS0hEd3hDTWtWK3VYekpjNTN4STZt?=
 =?utf-8?B?emE5SUR0OENBOVhnek05M1hJK0RLWGFoaStWWjNoby9CblQ1K1EwejVZYTFo?=
 =?utf-8?B?aHg2OHRXc1hEOWVtczJIT3MzVFRMNDR5RzhiTWcyakk3SEt6Yk14WWFUSm9E?=
 =?utf-8?B?OHZPRnZ3Y3B3TTVwTG02ZVpueklHMi9iOEovVkMwQlZOeEtyL0s0SGNhMnEx?=
 =?utf-8?B?and1NnM0QkMzOG9OOW52Q2RpR0lONVdSVkhRVXVnbDA5VWlPUzlOR1dVc3hS?=
 =?utf-8?B?TGtGcXhkREtrK3ZVbE8vR2lWTXpkT0ZvL2N3L2E1ak96S1NkQ29hZE1KOWdz?=
 =?utf-8?B?Tk1ZbE5YSWRDZlZJWGg0M243MVdpb2dqMnMyMnBjTGt3OTJjWmIyYkdRSzBj?=
 =?utf-8?B?NndER0FsQ253bW90c0FYLzlIb0tkYlpUZHZoc21ELzJCWFJiZWV3SFBhUGpF?=
 =?utf-8?B?ZVlsTnlyNEtqK2kwQXQ2OUNyRHg2a2t6VXM3WVI3LzFGNVZWQ1Nvcm4wa1BU?=
 =?utf-8?B?VWdyZ205SDZKMUV4Um9FNkh4REJGUVpZNHdvVkkrSWw0OEJ3a1ROYS8wQ3NT?=
 =?utf-8?B?ZDkrRUx5cUErY2Y2MmRIeVh6bEdQcjRqWkRCYko5Wk5uczRKWGY5WTVTWk1I?=
 =?utf-8?B?WGUrai9LUncwcXdtcjBsa2dHVkpUV2c5OS9DdmhWM3VoN2p3bEtYQkxvZldH?=
 =?utf-8?B?djZIS3FTb2VyM29lZlUvRFJScnJEemhhZFFxSjliRnU0aWl4THRRc2ZOc1cz?=
 =?utf-8?Q?Ej1l29V1GpTXhJjA=3D?=
X-Exchange-RoutingPolicyChecked: ZeMkjMwsWh4zf8Dx/0qxSHw4aGYCEfGZWAI1nFG9VZFK1Azm/lJzdKGnjaxh2JpWQiaK0Boic7d9l4ux+wH9IWyaPUYfqWHKB3KmpDBjHrGW2zohT4Xz0vCCKnFMXzzUrNfuQaL/X5Csh/Tyx4IeypSxMUz/r1TfPANhqJak749YdBIQ4P5fiA262vwP6ou1PW3xqVcHAjgZfAO51PqH3rnAgTiWlPk25PqJVJ3IFRFUmNtnXNEeRbkI5ZuT3f6F53muCnDvs2w7B/OB7DANtN7YjCMEuUuqBGyg7s7LEBrSR4xlHbJeDcfPhQohfMxdZWutMugzj4ibf9Mnt52qXQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c28b8723-37e3-4197-a8fb-08df2dd24e0d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 11:15:38.9785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zbYOEjK0KmAuQ8Cu11X1+GVcY8TVV7nks5tZNYJUtLfLa54YLZUcjpcT8pmFMJTwkd5TgQJDxhrs7ZhWIOfAmJ9tp3ybmn+SyxgnOr49cb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6385
X-OriginatorOrg: intel.com

On 10/16/26 15:08, Vincent Choiniere via B4 Relay wrote:
> From: Vincent Choiniere <choiniere.vincent@hydroquebec.com>
> 
> ice_tx_hang_reporter_dump() always reads tx_ring->tx_buf[0].skb,
> regardless of next_to_clean. The Tx cleanup path frees the skb and
> marks the buffer empty without clearing the skb pointer, so slot 0 can
> hold a stale pointer. A NULL check alone does not cover this, and
> devlink_fmsg_dump_skb() can fault on the freed skb.
> 
> Read tx_buf[next_to_clean] instead, use its skb only if the buffer type
> is ICE_TX_BUF_SKB, and skip the skb dump otherwise.
> 
> Observed on an E810 PF passed through to a KVM guest (Ubuntu 7.0.0-14,
> PREEMPT_RT, local scheduler patch): a delayed queue IRQ led to a Tx
> timeout and a page fault in devlink_fmsg_dump_skb():
> 
>   BUG: unable to handle page fault for address: 0000000004cd0c11
>   Workqueue: ice ice_service_task [ice]
>   RIP: devlink_fmsg_dump_skb+0x2d8/0x5d0
>   Call Trace:
>    ice_tx_hang_reporter_dump+0x1ce/0x210 [ice]
>    devlink_health_do_dump+0xcc/0x190
>    devlink_health_report+0x1d7/0x260
>    ice_report_tx_hang+0x7d/0xa0 [ice]
> 
> With this change and auto_dump enabled, starving a queue IRQ thread
> reproduced the Tx timeout; the dump contained the test packet, no Oops
> occurred and the PF recovered.
> 
> Fixes: 2a82874a3b7b ("ice: add Tx hang devlink health reporter")
> Link: https://lore.kernel.org/all/20260327072332.130320-1-aleksandr.loktionov@intel.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Vincent Choiniere <choiniere.vincent@hydroquebec.com>
> ---
> This complements the NULL check in [1]. With only that check, a non-NULL
> but stale tx_buf[0].skb is still dereferenced by devlink_fmsg_dump_skb().
> I have only reproduced the crash on an Ubuntu 7.0.0-14 kernel with
> PREEMPT_RT and a local scheduler patch, and the skb lifetime against
> concurrent Tx cleanup still needs review. Feedback welcome.
> 
> In my case next_to_clean was 0xfc while the reporter read slot 0.
> Upstream v7.0, v7.2 and current net main (191aa4154) all read
> tx_buf[0].skb unconditionally. Before this change, recovery stayed
> stuck until reboot.
> 
> [1] https://lore.kernel.org/all/20260327072332.130320-1-aleksandr.loktionov@intel.com/

thank you, looks better than simple null check
please add some more null checks as asked by sashiko, then:

Acked-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>


> ---
>   drivers/net/ethernet/intel/ice/devlink/health.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/devlink/health.c b/drivers/net/ethernet/intel/ice/devlink/health.c
> index 8e9a8a817..059859c36 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/health.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/health.c
> @@ -390,12 +390,15 @@ static int ice_tx_hang_reporter_dump(struct devlink_health_reporter *reporter,
>   				     struct netlink_ext_ack *extack)
>   {
>   	struct ice_tx_hang_event *event = priv_ctx;
> -	struct sk_buff *skb;
> +	struct sk_buff *skb = NULL;
> +	struct ice_tx_buf *tx_buf;
>   
>   	if (!event)
>   		return 0;
>   
> -	skb = event->tx_ring->tx_buf->skb;
> +	tx_buf = &event->tx_ring->tx_buf[event->next_to_clean];
> +	if (tx_buf->type == ICE_TX_BUF_SKB)
> +		skb = tx_buf->skb;
>   	devlink_fmsg_obj_nest_start(fmsg);
>   	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, head);
>   	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, intr);
> @@ -409,7 +412,8 @@ static int ice_tx_hang_reporter_dump(struct devlink_health_reporter *reporter,
>   	ice_fmsg_put_ptr(fmsg, "skb-ptr", skb);
>   	devlink_fmsg_binary_pair_put(fmsg, "desc", event->tx_ring->desc,
>   				     event->tx_ring->count * sizeof(struct ice_tx_desc));
> -	devlink_fmsg_dump_skb(fmsg, skb);
> +	if (skb)
> +		devlink_fmsg_dump_skb(fmsg, skb);
>   	devlink_fmsg_obj_nest_end(fmsg);
>   
>   	return 0;
> 
> ---
> base-commit: 191aa41548b2d2b6af534a6d5cf84a552435c74c
> change-id: 20261016-ice-tx-hang-dump-e46b4ed483d6
> 
> Best regards,
> --
> Vincent Choiniere <choiniere.vincent@hydroquebec.com>
> 
> 

