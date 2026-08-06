Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FBE47DD74
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 15:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031121; cv=fail; b=GlS9rkOt0LmyfN89TdH4Mg+5yhc4GJPi6t2j415zk6l9obiEg+08ebrFpLbv6t1Gs+bmUDG7Z60CFv9eRpApz1WAqUl+rbdnIa2g7qkeXxkfajQBSsFNDsqgPUEY3khwnc67acJ9THuPxDhu0AO0Q13WAcumb29DkArVyt+L6N4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031121; c=relaxed/simple;
	bh=B2EriNfrD915m/8ZAtbzJ2fLyZCMDdKqL4SQ1nei/Bg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cQDexUomh2VT7VdsMVaAfChxpT3Bl+horhNODC+SruyrDz8oP/l5+yo4pWG2NwpCgaSSLp/3xopDwr+d+wjjJN6pTy/Zc1AH4CrXpUkrI8+qQddWobJ2yq9pQfh4Fo+iQXxYcydyXEYA37FT8/kS8q481t3xBEbOGbthHolahxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jOlb9INE; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jOlb9INE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786031119; x=1817567119;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B2EriNfrD915m/8ZAtbzJ2fLyZCMDdKqL4SQ1nei/Bg=;
  b=jOlb9INE7AQZpUfN/bOk7UrwZHn19LCUHxCWa053YEaH9Ej/L/jTKAv6
   LZcJgadNzK7BuxKejOJ/QhwQOY9KRCNThhtVcXpv+tD5BmV41hZ2sEz6M
   8cI3zbReMgQ3nSS5Y3utlxGX6fccoVEcx7cOaxHw6anYbov7AzXp6+Wfs
   uYHGmUya/wA5GCl+tzeavoUVWc6KCboL1qz+goUT+Ac+fghDZvpTe7bX3
   IuzR5cIRGKs2Nf7rLXQpfbzSiUH2wAql5aTUq1hhDcaP/lOVOptAVzdvd
   x88FfHkf4hkLj2TlmJ9RKLuYlKrtCJXiwSWqzc6E1/tchs3R2sJVirKgr
   w==;
X-CSE-ConnectionGUID: LulksbvKR06s1W8Gw6QRgQ==
X-CSE-MsgGUID: KADOS5BsTdeWa0RKtGkg9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="97989944"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="97989944"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 08:45:19 -0700
X-CSE-ConnectionGUID: MgGc30q6QtivnZsBdhTpRQ==
X-CSE-MsgGUID: 5glZJfAhTFWcME7rsfkzVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="261616698"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 08:45:18 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 08:45:17 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 6 Aug 2026 08:45:17 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.5) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 08:45:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lrn3/uH3zYr39KjMI3EueLpnuB5ocwzEHncZ/13Yuc2RQ+FnvncVdbkQr9Dr1DX3vz4dNwwR99r5h2tNQ+reGxNWT2NvY3s7JrkZ3X2V3LhPbKRFK0nGugDZw0nwIz8h7H5IhMJ22oIB2R4CThZynGXo3dqGw358i8FTAVp8XVs3t2uJW35ztBhCidCg/wQENiN2bpiTQfnkccqwRg3oRD7raLdpWzWr8QZqLu/pNxVrwNr6+Vwe+4PJ7Fy6Xazb0TScgcGsxqsHL5BlZCyRO4EpdR+PzefhRHwHvpaQU/o0o1H5eKdvCEysbx8SfN2Gz+zyqXS/s0k6eivWVw1prg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FOwehsQSeUG06mvu83yFbueRr0gLz+ZjsKu0hr5jBg=;
 b=krsYB00FNJY2/FgjytHGFKvti7xfNfH2NKoH+stD7h9tTztXb5zR/fYWgZ5zUp0jDa5egtL0B6mKejuRlEoXn3lT72a8FxL1qDHR9eq5SsM2+pzczTvUXw0Hxfm768SVl9QgyzbXZiXPTattcp9mn2nNYNdaQy1ZmtY4XilmtJkZ15GEkCIC9f4/xwOL5SpVcNqYdlTwc1hIyQdjRGEQ+hohTguAGCqwGateIX2hioXicFr583Cl9Df0XXcKcOIyAUiTnn8GopJXUi2Wd5QyCBvdVdpBED0nU97Pu5t5PBcvM7vtin6kbx+CyzmO5Q2s/3FHN+Db3YEQIlDS6U1TZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB7554.namprd11.prod.outlook.com (2603:10b6:806:315::9)
 by SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 15:45:14 +0000
Received: from SA3PR11MB7554.namprd11.prod.outlook.com
 ([fe80::3ec0:2280:db82:d67b]) by SA3PR11MB7554.namprd11.prod.outlook.com
 ([fe80::3ec0:2280:db82:d67b%5]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 15:45:14 +0000
Message-ID: <ca6f4f3b-9c94-4b24-a8e4-7c351e730429@intel.com>
Date: Thu, 6 Aug 2026 21:15:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915/display: Limit max joined dotclock on pipes
 available
To: Jani Nikula <jani.nikula@intel.com>, <intel-gfx@lists.freedesktop.org>,
	<intel-xe@lists.freedesktop.org>
CC: <stable@vger.kernel.org>
References: <20260806143738.2710312-1-jani.nikula@intel.com>
Content-Language: en-US
From: "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>
In-Reply-To: <20260806143738.2710312-1-jani.nikula@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0214.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::10) To SA3PR11MB7554.namprd11.prod.outlook.com
 (2603:10b6:806:315::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB7554:EE_|SJ2PR11MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fccccd6-fe85-4449-f02d-08def3d1b480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 2Ti51BrTguvFCu+ZZ2NOHPvmcWemKAGD+/IobNQmDWRpnXh33xMjag0ZKAR7iHPlw8pQ0t6ca1y1nuw+9bhrqunpFbzCAzb4saw5zA2dmiI8zbYHlR0g1b+d19j/MYCZ7297meRygz0gwI8tdye8bD/CRCuX0JXXVtKE0jMrJpXnl9rhogTyKVB5qffY5F56qabqWOrJj6+edlYsu4rKl4hHVlCTgCX3K8SyU/Mqf6RdGXtFDVnoMyDzeOCcRm0826qNbxzWIJrqkioytC773cGR1jRmoGWDSsj5ojgRqGALzMEvfmL6UpDfHzDbUUzyGEmF5ZQqKt//VO1jLOoicNonx00gWxSBS7OQhtXyKPeyE79X9gLND3s8y9vJnpGVofsi+SdM4/JJYZymJnG8ZScPeWizbvwqnh8NXX5RBexMKEdNtax2KkZHQ8OgG/i/h+Gw5Q6QTU1hcnPvXYQCLzmzAgBbZ2v5c6PoWxTZQD++YUeC3oa0ZMCZC2/nQJ892ATR/dKze8roYc4QO8Ux+q4TnFlu8ONNgT62tI8kcgJNaybabsQRF8fmuW7Rm6JtQ9DbOtpVnD6MpCZAG4xnLsfwLonV+w7PEpTvD8K0GaJYaD7oMZK84P+f5DLbmTvkoyknT1BWK9gg8vq/rrYQ+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7554.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGcyRUdhU0E4WnRWS0Y0WlZkUmZGSEFPK0hzancrMksrdHdFblJlSkhQVmJP?=
 =?utf-8?B?K1dCcWloQ3kzbm9CM1BVaCtJY2U4ZDVsYktwcHMzdW5DM3NiY3JGOFNYeDND?=
 =?utf-8?B?ZVdVK0YwNFpNZk9qV3c3QUNDOTkwZjc4eWxVdWNFQllxV09ySTVGNjRyTm9z?=
 =?utf-8?B?bkUraytOSkJuTFQ3VUErWFdrRDQzOGxBY1V3eDdzZmN4OHpGNERWc3Q2Y2V3?=
 =?utf-8?B?Tmxnd1N2MWxadjNwWm40SlZTVHA1MkcySm1mdW0xUUlTekxRSHdsdC9nSFlE?=
 =?utf-8?B?bHQ0eXM4TVFha2dlYnN2MjlHUDRuWXg1V3luUzdxKytabHlBRjZrTFRFOEpl?=
 =?utf-8?B?ZWJlYjc3L0M2S3lHSFZGeEw5OE5NMXRwR2VvRksyZEhSOFdaWEdzL2NDS2Nm?=
 =?utf-8?B?eklJTFZ3aVRIL2YzeUMxcXFWNEtOQWdMK1VTWFNmMWpsend0YVNvTlhCZUtO?=
 =?utf-8?B?dWgrQnFaZ0lROXE2emlyeUNMU2xzNkQrUTZ0OE1wNHB3MEhXMGIrOW0zZnVS?=
 =?utf-8?B?SmNEQ3NpaWFSOCtQR3ZtSUp1TVFQQ3RMUDZKVmE0MDFNV1NDUWdsUitKU1RV?=
 =?utf-8?B?WjE3VVN0dFhBd2w2MFN1ZTR5ZlZ3U0lHNWZad3BYQ1FzVkRZYVkydklxVDg0?=
 =?utf-8?B?Q1d2ZzZUZlM4V1hBMFRQVnNCZkZwNVZ4U3A4NDcxcWZIdHoyMyszamlOOElC?=
 =?utf-8?B?eEpOUCtHSVp4cjBvT0YvdXcvVm1Id3dRWWk0a2F0dDBoM0h6TisraTlsd3o0?=
 =?utf-8?B?cUJOTmh3eko4bkNaQldQdFd1MXVXdXdNaGlGY25wdHdnSWc4OGpwL3JCMHBl?=
 =?utf-8?B?SmF1OGZ2ZHlvZkQxeGFVemljVzB2aG9WcXFXdGY1dlRsSnhhVTZuQWZPR0Uw?=
 =?utf-8?B?VExWa2R3aUZrWWZEUWV1dWpPT3hYM2FyYUJjSzFhcEdNdzQvOStOL1ZRSUdx?=
 =?utf-8?B?Vm5LK04rQVk4SDNNMUVqRnpOTk13L1pJSTI2VWlkR1M3NjhPcGxRZTVBZ095?=
 =?utf-8?B?STZHRTk2dG00ZHQza3JodkdEZUFVWVdJWXhsZGhmeHdtVXE0ak5RRWNrYzJB?=
 =?utf-8?B?TUgrZWRGWnFFdEZGMktyOWdUck92VE5HU2xSQTNOT2ZpajY5N1d5d0d1dEFp?=
 =?utf-8?B?VzdURXNvMHFlblpSd3RnQlZxd1dPUFdNOHRYYVVzRW5pSmZqcG1NVFdBdk5w?=
 =?utf-8?B?OHpNZit1WHcvQkppUWRDQ2MvQWV2ZUdSSUdSeUMyYytib2ovdjkraDlYR24w?=
 =?utf-8?B?OG9GR0hsc0V0WlZ2dzhtR3ExbzZKZEVYNnRNUkU5MEJCQkdJR3hpcHY4elYw?=
 =?utf-8?B?VEZpZ3E5cWZxN2tnRzV5aWpXb012QjUrL1hrbFpKVFFGN3RKdDlMRHpjaDUw?=
 =?utf-8?B?dVJzMGtlVktCWXBHQkJjdGo0dmk4QVQzRDB2eVJuYUo1aEFlTlA1aHdhT0NI?=
 =?utf-8?B?ZVpiMkJ0a0Z5TFIzUTVjZDM0WTZld2Rhc3B3TjlMMmpoLy9TU0h1SmdIZzkw?=
 =?utf-8?B?Z2x4MW1sYWNRVGI1N1pEMHZ5WjZJY1pFU0VJY0pPZXNTNHFRYnN4ZWdsMnV0?=
 =?utf-8?B?S2VjTVJPc0lHUWZtaURxK01YRFQ5RUFCQ3BJTWdhcWV6QjZhTHp1RktXWjFM?=
 =?utf-8?B?b2FEejNKR0xJeHVSY0RPUWpBa0RJYTQ2eC9jYWk2N0tXWDc1YWxEaHlUdkRC?=
 =?utf-8?B?RlVHazNSMkxsaVQrRC9nUk5qeWJmSXhGTlpJbkh4V1p0aC9COHNSNXFORlk0?=
 =?utf-8?B?NVlEK2xnSlE0TkNlYUdtbGZabXZ2ekd2K09JQ1ZGTmF6RG5uOTF1WHQ2Ymhx?=
 =?utf-8?B?bU1yM0pxVGNkWlorQXNHbHc2NDlmV3IyczFneWFTaHBnb0xEM2s0NVdIVEZ2?=
 =?utf-8?B?WGU4YnB2RmptcGpZemh6Z3BlVWxKRUtVVXIvdlFVSXZwV1pXZ2Z3UFovbmxD?=
 =?utf-8?B?ZGQ0R3ZGVVZWQWNzdmxJTWpoRkM0c2pjMWJBc2c3NWUrdFhYaldYNjhzQ05U?=
 =?utf-8?B?QlU0V3Z0NllORCt4SUdtaWJ2WnIxZ3pwUFZEY0hlZFB3STl3VXFaVWVKVThL?=
 =?utf-8?B?QUpXa0o5NFcxcHFzYUp5aGFLRzVKbE9iMzU4L3JLYkNTbHpzeXJOQTFkSTQ1?=
 =?utf-8?B?UU8wdGFhVmIzUXZVdnlpZ0RVcUxRWUVPdlJ5S012UWZZdTFNZmFFVE0xNVpa?=
 =?utf-8?B?ZFF6MVhMMEZqVTJ3UWR5NXVvUHpxSVcrMnBpKytEWDlhVE50YXlkZ1hiUmVS?=
 =?utf-8?B?em9mT3Vtc2Nhd1YwWlVtQTNEa3RQM3NFYm5YTDM5eVNmbXdJOW9uVXBnVDgv?=
 =?utf-8?B?cFBBT056SWk5S2FsYTdFdFBQYzRob0NYY2owZk1ERDE3bzRQNU1yY1B3L1Iz?=
 =?utf-8?Q?9L+uzdVsqv45zUj0=3D?=
X-Exchange-RoutingPolicyChecked: iaecto3Ay/27Q8DuxP5U0wsQwalgsBsUWYkBevfWdgaCmyjHtUtiNs1q0YApit/K+pZxyuMCjB0WBAvw1OFDRIs32hlS5Y8J75CUBlBdtq1oIhuStyrBsJN4GDUINhFYU08F0E2/ZQrC9BcGMNuUCnifrHgnfUUYa7jqLctz3dNZQf5vsPI49ogSt3jeH9QzzHRuFHBxZXxm4eIlGx7kfgRvOu08WhTzb8/nJzr5jJkj9SQr7YnV8s00HNR/t41orjGaT7Tn50Zc6LUDTzOpQ5+zAruCJwm9aC6z1icaRcC/uUT14dd/eym1/s4aYztOKwHzI1I37RPbXHA/i5Ucaw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fccccd6-fe85-4449-f02d-08def3d1b480
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7554.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 15:45:14.3184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trFIkiCag5pDpZWMvBq6Be8VNxOXU+aGHDnU4kKo5tcfL/5UAZcyk2NPUuGfcr7YT8EsM8FVRQ4lUPpE1h2DI1anMTnzFl+EdpS0LpDioXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7573
X-OriginatorOrg: intel.com


On 8/6/2026 8:07 PM, Jani Nikula wrote:
> Multiplying the max dotclock based on joiner availability on the
> platform alone does not take into account the actual number of pipes
> (possibly with some fused) available.
>
> Limit the max joined dotclock based on the actual number of pipes
> available.
>
> This is still too optimistic due to other constraints on actual pipes,
> but it reduces some of the false hopes at mode enumeration.
>
> Fixes: f4f8f0eaaafc ("drm/i915/display: Consider ultrajoiner for computing maxdotclock")
> Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> Cc: <stable@vger.kernel.org> # v6.13+
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> ---
>   drivers/gpu/drm/i915/display/intel_display.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
> index 829d7a411dcc..44c5d1dde255 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -8113,9 +8113,10 @@ static int max_dotclock(struct intel_display *display)
>   {
>   	int max_dotclock = display->cdclk.max_dotclk_freq;
>   
> -	if (HAS_ULTRAJOINER(display))
> +	if (HAS_ULTRAJOINER(display) && INTEL_NUM_PIPES(display) >= 4)
>   		max_dotclock *= 4;
> -	else if (HAS_UNCOMPRESSED_JOINER(display) || HAS_BIGJOINER(display))
> +	else if ((HAS_UNCOMPRESSED_JOINER(display) || HAS_BIGJOINER(display)) &&
> +		 INTEL_NUM_PIPES(display) >= 2)

If fused pipes are AC or BD this will still give us 2. Perhaps should 
have a check for atleast 2 consecutive pipes from 
DISPLAY_RUNTIME_INFO(display)->pipe_mask

On the other hand we can have the consecutive pipe check in mode_valid() 
path after for_each_joiner_candidate() is called, which will check 
whether there exists any consecutive pair that can support joiner.

As discussed offline, in any case, we need to fix the compute_config() 
path for SST and MST where we are using the for_each_joiner_candidate() 
to check for a given primary, there exist sufficient consecutive pipes 
to support the joiner candidate.

Regards,

Ankit



Regards,

Ankit

>   		max_dotclock *= 2;
>   
>   	return max_dotclock;
