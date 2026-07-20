Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285203C4B9A;
	Mon, 20 Jul 2026 07:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784533203; cv=fail; b=SLwUteqSYN44/2x7zpBDnTC+5ithQbB2z480KQDq+IqGejeKdQtD3w2oeSuSHWJuPXUzxTX0545xOkEZuL/ff8i4sIQj4BVEEMvHaqYdwTP8hcKT+2EpzLHqsCkcL/p5LK/68pSUKUx94/ZDoN/wL+PBA0NvqGLM4kYTZ+zypp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784533203; c=relaxed/simple;
	bh=TRiB9M2MpfofpMiiTkchGiTlx/DDjDSK8QoLVmnE1co=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NUJoD0f9JGdvOvVKCfh1LgbpZqNeTdyJzPIZpGQSlO/GPz/L4e8J7M9JABW7Uxu5UjnZjt/dT65VduQyHBT4+OznxhpJ7kt1RZ5+5CfemvwZi5eiLOyLJF1iDRt6/dgyG/tjpM0wYhk+wvzC5FF73wJSwOHG/3t1OK/tpxmFUbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fWEgY4Q9; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fWEgY4Q9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784533200; x=1816069200;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TRiB9M2MpfofpMiiTkchGiTlx/DDjDSK8QoLVmnE1co=;
  b=fWEgY4Q9sSoPey12voODqSqUQYDkHPOnr9uXb71v/jjuRFvU4zh4lald
   HQOnXF43HyVN8FN63GjZAAUeSYJru8N8HJHaaU/CtNqgVHi5o6nCes20q
   FfhLXfwZU/0Y4zg6TDuJLfyUIn7y6mmU+6FSlNrwv0pI/hU2+s6p+QoC0
   FbxazbE9g+rilAKAQ5Gk/iXvqsEupXQQAK+2We0xMPPxDTTAqZ42dKwvs
   6Acz+eVEpLTLFlFyZMabpfCUJYDrvhvy8iqw+5KgPECSliViGOIQB5iWx
   cMxD4m6vUK0AIkio+jlqoZ5Sj/OnChaJQlkUXcuY8rPYXbIelMXkP4OIF
   A==;
X-CSE-ConnectionGUID: b8fuNSkcRHqbe+flCd4kjQ==
X-CSE-MsgGUID: zUuKzy9oQa6QuGQ8WhkCKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="102654416"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="102654416"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 00:39:58 -0700
X-CSE-ConnectionGUID: Eep6tNHCTReLQt1ts59zhg==
X-CSE-MsgGUID: jn/HzyTUSvGFyek9S6ffGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="280661204"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 00:39:58 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 00:39:30 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 00:39:30 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.4) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 00:39:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bumMOvGYDdjpza5wWasBjUk1iSt7UeLVIvl8hW7ura2Un9UnDylRad1Sko1Oe1Qi3TTiuQh6gNkhg5cDbwIa7Lh6rBpiPeDNKi7nFoE+Cbp4auGxuaIJ6vDcOxmhaxib8bVaHJVdxJWFZluxJzIYMTJxU2gKUYUpwVMTuucMbubRK452bVn3zxtJ0b8n/3XmpvNcSRotSUtmnOyvaKti+SNdL2r09cMCKGiw0I/0npXO9g1n4eZMsQ7gQ7lh4W6YdeG0EaMP1SJcIsyNfMBYTMXAXlZJ3z3vE/kLXv2JtTETczULCGGW6QTjKn8NaWdWFwaAIIc8m2JRwU6AyJNnFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v72roHPe7xlDea8c77tYjYzNo3TEcXJj51EEVu26PuY=;
 b=lsHwKOJLQB7QV04raqmoq34R/t4Ca6sdYLNKyMk7o2hzP/haIIAr19t1APRvqiPcpaNiWYUk0jh4ri39S7UDRJntOMUrp/UAVggOJcxuuPGqAJ1ozQ5hHGO181u5Je6ofgtGc9k1rWuVqBD1t/Hs1QAwO0i0QWhakU2VVcBEMdVZ4CKmzRASfNMk0Jt3lChvBckbfkB8QaEmJtYo6R1nKSInkaSFubz2H2lduk2DWF0eak3qXJD5xDR5ApkOZh2Cu1h6AYlrdq+Uh3ckuJ8WXZ44JTOEmE55MnHRQV3gFMX14BHYBgsRA0b9V10DBvokdCEpzasZSWo3iWbRWdPqCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV4PR11MB9514.namprd11.prod.outlook.com (2603:10b6:408:2e0::10)
 by CYXPR11MB8755.namprd11.prod.outlook.com (2603:10b6:930:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 07:39:06 +0000
Received: from LV4PR11MB9514.namprd11.prod.outlook.com
 ([fe80::79a5:106b:2126:a7fa]) by LV4PR11MB9514.namprd11.prod.outlook.com
 ([fe80::79a5:106b:2126:a7fa%5]) with mapi id 15.21.0223.011; Mon, 20 Jul 2026
 07:39:05 +0000
Message-ID: <c477f099-c365-496a-bb5c-ae8d27d7916f@intel.com>
Date: Mon, 20 Jul 2026 10:39:00 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net] igc: remove napi_synchronize() in
 igc_down()
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, David Carlier
	<devnexen@gmail.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<aleksandr.loktionov@intel.com>, <advoretsky@gmail.com>,
	<stable@vger.kernel.org>
References: <20260712132242.223254-1-devnexen@gmail.com>
 <alSzCokS7scCoza7@boxer>
Content-Language: en-US
From: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
In-Reply-To: <alSzCokS7scCoza7@boxer>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0026.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::13) To LV4PR11MB9514.namprd11.prod.outlook.com
 (2603:10b6:408:2e0::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV4PR11MB9514:EE_|CYXPR11MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: 21272b39-1fa5-41ad-153e-08dee631f9f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: kD0uONYDkuP9/4cDqY5H7YRNrfRCSoeAND5dF/xmz1kduxknC3X95v7wNuWyNpvjsAX8UOkekmV/hRXB3oahWt/jUDxMMlT3AD21/jMIQNsC+pcqMhC187542Tog/PoL/sSoeTaq+YPKSX0EFnhQjBy5O+/Vr5nreB1/lv1/0sDT6ysCCFnkgKwjVk5RN49GKpymgfiYYVJ5/GVm9P3tiuk+gk9x8Q/HJyNnLo2jiOhbxMdq1SMEC5lVdiGxlKqknxkLqz66JbYPGmj8KQgMfc2Q1bmsV31yT8Axtncjxmyy3+dBiyW+sMUdAEleK6CNiVgZhZRtn8aWsmdqLv0O/WbE/xDl0GazeNC00MFcIVgPym5g2XMKGj4Xvi2Zx8rHbJ8eB36oi38aDp6IWKkNib9fyPRQLTOMs1j41c0wR7Zky10AjZ/6EtgAHUBA/MN9bxF2glp3rjoW1Y+T0AU+5jTTMHN5KnD+zxmK0c7ZEO6ge8rzNHnK2B3q1Cxotav14w52vV14WV8AXcQawuDxoTOwb7lrV3zCtg7p3V2f/nAUxSt8waD08tLuJCF8OjP2FKSju/LC7Ts6FAkxhgPCJUmsPN38+xazCY0fhydn3eTG53mInr0Zi0ukh5k1bbL8m4OWQHYf4YnGIUB2P1+6EX78NHxNz6U6S930AO6aPY8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV4PR11MB9514.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkJRS3FWaWdvNnpLYm56Y0lybzRmNG1Yb2pjekpjT3FJdDRTQnZZanM0c0JG?=
 =?utf-8?B?cTNmN1RKUWZDTi9VZjczZ25IUGpNalZUaHBqTUVLLzZESWhQVFlDcmxLSWdT?=
 =?utf-8?B?eG9YenB2Lzg5VW9kaEEwcXJsSUtrYVhYcDdJSlRJV29USjlSSisxb256Yisx?=
 =?utf-8?B?dVkzRHFLZjRCblVaQ3FjcDFHUm94QldUSHRiMUlxeWRUYWdTSWZHaU8wSm1I?=
 =?utf-8?B?TmVJdVVGR3oyQ2tSTnBsWUVGNloxL1hIRXVrMVA5UUlVQjJGUzlYd2wvbU1n?=
 =?utf-8?B?UlRCYWd2bmxBMFZzUkxvNFFUWVQ1dDVXcXh0VjdJN1JpcnlsanNkaElxZVJG?=
 =?utf-8?B?Y3IvZXUvZFp3bXhCOGViMXQyVXB4SnE0aWZPNHU1dDM0SGdaWDVkcGoxZ2Uv?=
 =?utf-8?B?b2ljbXZjNkdZSGdTUzY3TzdpUkF4clhsV3BzTG5hbVRaQnlqK2s1czNqUjc1?=
 =?utf-8?B?OURva0VkdkYyaEVtd3hHTWFEQitUNE9UVG03THVPYlNaZ0lkTFZJcGMrMlgr?=
 =?utf-8?B?dEUzYzIyY1gwNlNBVS9RVlpwK0grbTQvZ056Z2lsQ25oRGpIdEcyNUkvSnZj?=
 =?utf-8?B?VUlMdGZoWXVZUWI2anlseXVtTE9mdHJrT2t3K1F4S002ZEZZazRBTUkvR1px?=
 =?utf-8?B?dkdPWEN3R3UzZm1YaFoyT0phRnI3N1l6MHVGUVNPMDBjMklucWJ4RFZmWVp1?=
 =?utf-8?B?YXFaUjVCa240RkV6Zm8yeFRlbGtESUJuZGg5bzQybVgybUhZVC9rdXpHWVpt?=
 =?utf-8?B?NXhISzQ2emVrWjZCclpwNDRrNURjN0d0SFBGL1FNdjJEOENLZ2JyNWJOektB?=
 =?utf-8?B?UzRhUXhhM0lnaWgrbGhFc0Zqbm40YlNicy9aQm8vZnlka2kxVVlONkRWdnRo?=
 =?utf-8?B?eVFqdXNrWWNZUjJiWE9YblpHNWY0aC9Bb09YL2tJd0llMDFvN3ZBSzR1NWV3?=
 =?utf-8?B?UXJKZUhhUHVXOWVKSzVtY1dKN2o2WDR1c1VTeXhDbERPU2sxVzlzS0VuZmV5?=
 =?utf-8?B?MTJ5UWZ6TEQ1dXNISmRaeTFnYzNUSkNZeWl4OTZUd2lMNGt2ZUlHQnpVTDVy?=
 =?utf-8?B?RXJ4MzJvQ2Q3VlVvenFuOVExZS9sb1BEdlpZcXBMZjJaUUNKYmJ4S0Z6Z1kx?=
 =?utf-8?B?ZnM5VEtZMmdSSGI1Z1cvd25VNmZmV0hvbGU1Ujh4dWVZbUdodjRCTk54czFT?=
 =?utf-8?B?Q3JCdktFWHM0Y2QvYTlZMHpJaDVQU1RXaFpxQkNHeWlUMU9MYmlkWEwzNzYv?=
 =?utf-8?B?VFFNd3Z6UGtQdGlrS2pCa3JtY1RTUlJMdUh0cTdIQXVJMFUyYkpxRVhyNHEz?=
 =?utf-8?B?UHg3elEycjlrSE5Eb1E3UnZENWdQM1Q1VHc0LzNKL2o5bDByL1hZeG81L1dE?=
 =?utf-8?B?alhXUmtIRVEyLytVR0p1QmY4dlJaVm16aE5SSktBTklDS1M1YTlsWHBJaVRD?=
 =?utf-8?B?NUVXTlh4YUdLWThwTlRqVWJrUXZkRndLZXBYNzZWRFJPSG5KWEdUSFdqY0ht?=
 =?utf-8?B?cDNYbXlTY0pLZTNVK1l1UC84aGlPdlFVVzQ4ZTVyaEQrWHFUMFhNUVRGdXVI?=
 =?utf-8?B?ZFdCNkR1ejFjR0JCOGxqSmdmaUVuYWgvb0d6YVRBbUhKK29McXhyMXdPMjky?=
 =?utf-8?B?eXpZOEs3dFpDMUVvWmZramV0V2V5Qk5sK0d3MVk2SWNUZ21ncXJ5Ni8vQXQr?=
 =?utf-8?B?OGRaUUhsMWJtWGdIdnFhRXRhTDBRYmRaWVd6Y2hhRFJUSkFESXNyTnpYNUk1?=
 =?utf-8?B?czZ2VkV3TnFlK1dISDBrTll1THlzTnYrbkUweC9uVFU0MjVwbFREN0pYWkhO?=
 =?utf-8?B?RUFka3EzWUZSSnhvT3hPUU80ejdqV09tK3JGVjJMTHhXcFI0Wjc3SUl1NzUz?=
 =?utf-8?B?VFIzdklJeU5nSFJuTi9Va2JpQWZ1Mm5hQXlZZm8zRGplTTYzRndTVG1UcGc2?=
 =?utf-8?B?K29UVFR6ZTZpd0dJNWtZVldWY3Q5YlVzK0I5ZDQ0UW5WcVJBOVVzRmlUSDZk?=
 =?utf-8?B?NGtPZGhEWWNKOXVHVUVWYXdhWlJ6UmMwbmtJV1AvZGs1QTRWcmEvaCtTS3Fs?=
 =?utf-8?B?VVhEMWE4MFJYc0NSNGZZSDV5LzZGWlIyN0NraFk0R0dPWDJQZXFLNzZRdGFP?=
 =?utf-8?B?NmRETzR5OEM5cytjenNvQm5laFVsWDZDU2E4WWw0TTRib1B3enJUcXZ0SldR?=
 =?utf-8?B?NnROSmpXZHZ0NWpxcXVGc0VweUZHSDRhQ1VSbUNpcExvWVg2T0ZjVVVkb0Np?=
 =?utf-8?B?aXA3WG5lU2I0c3RhWFhQSmtnbGtHV3gyQ0xnMzZLaVNOV2k1Y0hKYTlmQ0xZ?=
 =?utf-8?B?SWJVM1MvNWNwZzB2ejV6Z0wvYjVDSW52NDJLY3FVdmp4Rk5UV1ZXZz09?=
X-Exchange-RoutingPolicyChecked: bZ0FFICALVxEZONJVpC8yBBPCPx8g69b8VZQbyI7rQrFJernxM7AOw6ta/E0G1IqMaLvU0bipQePMNmhH0I+hsx9bzZ89vK1c4GQEbDeEVr/bqcWeUVaZ32hiAWZ6vg/1bNWjkT42oiGPWi+29kHKe+zL06jwDOOXoUQ+NR7Ee5/V4sghtAZ74/mPfjcF7jas1M2HwNEmnZPB4dfEEUEWujQjspmrO1wl8MHssIVe8/9bjO31aBO3BvP58q+bbXxJfLCxpp0v1O+5pt9DFGe85zSl5UXjJvxeWEXW4As1yg7RlTQF6VK8cFvyR65D4LH+PBdd3RFBhZCp7q8mXm1TQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 21272b39-1fa5-41ad-153e-08dee631f9f4
X-MS-Exchange-CrossTenant-AuthSource: LV4PR11MB9514.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 07:39:05.6326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mvWSvV7ibYHKokQIvuno8TAEVpegtc8O5hpv1HYlWGGMjR9x/qisbL0Kcjn8czibjq04IuKvwz0b/28oib2DKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8755
X-OriginatorOrg: intel.com

On 13/07/2026 12:42, Maciej Fijalkowski wrote:
> On Sun, Jul 12, 2026 at 02:22:42PM +0100, David Carlier wrote:
>> When an AF_XDP zero-copy application is killed abruptly, the XSK pool is
>> torn down but NAPI keeps polling. igc_clean_rx_irq_zc() then returns the
>> full budget on every poll, so napi_complete_done() never clears
>> NAPI_STATE_SCHED.
>>
>> igc_down() calls napi_synchronize() before napi_disable(), so it spins
>> forever waiting for that bit and the interface never goes down. Drop the
>> napi_synchronize() and let napi_disable() do the job -- it sets
>> NAPI_STATE_DISABLE, which forces the stuck poll to complete. Reorder it
>> ahead of igc_set_queue_napi() so the NAPI mapping is cleared only after
>> polling has stopped, matching the recent igb fix b1e067240379.
>>
>> Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
>> Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: David Carlier <devnexen@gmail.com>
> 
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> This is a mirror of what Alex Dvoretsky did on igb, correct? Did you
> reproduce the same issue on your side or is it a blind shot at this
> driver?
> 
> Regardless, I think it's a correct thing to do, but some clarification
> would be nice.
> 
>> ---
>>   drivers/net/ethernet/intel/igc/igc_main.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
>> index 2c9e2dfd8499..b3883a5a7d7a 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>> @@ -5352,9 +5352,8 @@ void igc_down(struct igc_adapter *adapter)
>>   
>>   	for (i = 0; i < adapter->num_q_vectors; i++) {
>>   		if (adapter->q_vector[i]) {
>> -			napi_synchronize(&adapter->q_vector[i]->napi);
>> -			igc_set_queue_napi(adapter, i, NULL);
>>   			napi_disable(&adapter->q_vector[i]->napi);
>> +			igc_set_queue_napi(adapter, i, NULL);
>>   		}
>>   	}
>>   
>> -- 
>> 2.53.0
>>
Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
