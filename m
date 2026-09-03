Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA27486623
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443338; cv=fail; b=Bw/ynNYn3KhzdqRifk3PdT2cdOqzrY9YiNMKy/DWXr6BzOz+VgPSIWDOhQPNXP9r7+NaswR1cwG9IOsVbqk07ngHwgvNf2lYwBIiuJm4NUdrKHfGsC26mXQcQgBiY+4sKexDjlbpMHPrb38R+uqymJP4d+O1DkklV1T1/DYCqCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443338; c=relaxed/simple;
	bh=0kKQoPtdxImmPTaM+zuPoZmIq5pmerqFJoDBcW59ZVg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wp5Mk/STcif777ZKKKNIEQ6nYXePF3p2l/nPGsrtHT+T/WVLXnaL+Qb6N1vggrDemAdOyuGYVasx4efZiSuaA4SUlicQGX0q+WYUICmmDTpgAcQ3GNZlPvNDehikDdQvN4/leKBcDSgVKh3YHWZ0O6NJA97syJTTfON6QaBRL2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZzgXXy3E; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZzgXXy3E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788443333; x=1819979333;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0kKQoPtdxImmPTaM+zuPoZmIq5pmerqFJoDBcW59ZVg=;
  b=ZzgXXy3EEA2/LULYWEIhp23dBXR9apkv8yF4LyREMqbY3dlp+4xdIUip
   bAwA3FW9TSuwYXUSDSJ2/JpaAQRnCt9OGq9DkzwivZGwg0II2trn8HvSW
   /1oMz+dJT3TvL1i4j4CO2wBXZgxKHbIN5qvgfzAkX0Un26NZMSFwP9ozq
   nSUmtx6dFLmtJBTjyFBJuD49cwNSIQlWai+yXdUK9ZHj88kqwJIJRNI77
   opnZeDcklhy7CSpgwP12gefsT766FuzepUOwv1vZbBtg+JFptKYxmZN6G
   CFWIB3XXAphgiuvFEofoiFNNwo2fKblNLoOU7dzZSV6qBKkYTXAexD3ey
   A==;
X-CSE-ConnectionGUID: RaH4aAUNToWJxeD9rf0P7w==
X-CSE-MsgGUID: mQ5KuCXRQ1W8Bi91UUJ2/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="88948914"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="88948914"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 06:48:50 -0700
X-CSE-ConnectionGUID: imt0zwXtRhCVo+8IzEAJEQ==
X-CSE-MsgGUID: B/ypni62StC2O+KLEy3Kig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="273879716"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 06:48:50 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 06:48:49 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 06:48:49 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.47) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 06:48:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uv+6OKbeu6goT5mWuwG8cStRSr6qZfpwo8roD9R7ydmUgHvCALOxuH/qrjnxPHLzmWtjy7vr6upNoACYU5xfrZ4uNeYWFISDktYWoELNszRrghJqAB1bwvxLsxVVg40MDQa4GYgQ/JELzRcKtTjtkubCy10nmWoZ+lwTOkExTL9ZgIutWkFyxt3e+ya28AjtWKCQc00VQVE8Fgs0F8XSBwYyzzplVpq3ePdkDFWRd7Egf6hltHXQIfoUEezqgbS8x8fBX9B0lb9I5/4LlXns3KfG4JN7fuviri3hpRKrt8yO0Qz877la+UN/f1P+uavDZvz7DjSz2NAj9lhIUfdKfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPoJZoB/WhFu8pv9oVnwTCE2AWn8caoeG3fkKp5cxnU=;
 b=vEJL6NNFhZ5ZiIYJqQkEqsOQroUqMk058eUY0NA7ZcBHB7gZ59KpNFF+blopk59ZqZ4BfwBOFBBMKEuekCy5DVqt6GC3P2oQncDVE0mZjQX9z6wmTQVsnULF0t/inciKgv7EzTlUZ0vzszFOk7FK8OXDIb3pm2kPVHJTGiXT+GsSX/XcMDRqwrRlBDkIVbzQQetWbYXFvdwdHulGRgMg2fg+dFApLqirhzGyHbbY3XVijeCbICuMJZbU7Ov4FVNgatmRS0vYn/u8VafHRLX5tINkFNoY/V/apmjZdvzUxsIhydh9fFZ3CNhWz1YW6Zp4MxXynxF+EkRXr1B+51atFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB7554.namprd11.prod.outlook.com (2603:10b6:806:315::9)
 by SJ1PR11MB6276.namprd11.prod.outlook.com (2603:10b6:a03:455::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 13:48:46 +0000
Received: from SA3PR11MB7554.namprd11.prod.outlook.com
 ([fe80::3ec0:2280:db82:d67b]) by SA3PR11MB7554.namprd11.prod.outlook.com
 ([fe80::3ec0:2280:db82:d67b%5]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 13:48:45 +0000
Message-ID: <f649d0c2-d833-41bf-96de-d13865595d0c@intel.com>
Date: Thu, 3 Sep 2026 19:18:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915/alpm: Fix swapped wake lines in LOBF late config
To: Animesh Manna <animesh.manna@intel.com>,
	<intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>
CC: <jouni.hogander@intel.com>, <stable@vger.kernel.org>
References: <20260825055239.3455987-1-animesh.manna@intel.com>
Content-Language: en-US
From: "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>
In-Reply-To: <20260825055239.3455987-1-animesh.manna@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0060.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::9) To SA3PR11MB7554.namprd11.prod.outlook.com
 (2603:10b6:806:315::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB7554:EE_|SJ1PR11MB6276:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d314f67-1ac7-4e36-b002-08df09c212cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|22082099003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: +VcneJ3fGo0BScs1V3yhISQg7XQaz579cQAlFgpq2HaysMfTCMGmuOwiuaeI9jDo67budGXRliAYFzJtYh+BehTayLvR7wI7UPcQQiyBJcvU4SGFTJA05EPSiK2R17zIZ6G3Bxhb/TZTlQfzR7+9UKqsGhyoRddJdHYFtHYxQyC99Z3/pUGUE2noT1hZWUpbmGGZH71wbMnf1HhWvKbDrj6bPjQ1wSyKKJ/ozB5MmU6T3ioTYNqDwjvCVtbIPNJVcqrpRWpaVjWLn4yB7FR83RsDodN3a8eCW/yOgD/+y+DOzTkiSxG9fXsepUBz0i9dI9Rsur48UJyWXqhyDAypcoWW924SVgTPeTvJtl+n1ll4X2XUDddy0NqB36Mqm55FTe//v3sPy6c/Z6JuBLgFiJTphmUcEGHyRPQhAwjZnCh/pk80IEihsFtxUZ5T4XYqzJ/EvV6mSa5vNrW2mjpMo/erCXN4sqz6Y1bOAPRQ66XuYae5vm6ZENh1Lqe0ybUjLo6pVLZhigwTI9h0IViKX76fbmeCrYn3VbmPyF6vX/nAG7AgTCXS5VluNHoKgMWY3/dA++HA7AZBbaC9EmfFoprDSY95sETVLPNn6g8d3rVi8Yht4+lFBNt3hrENfhBDxjMUOfxlEa/EAgLW0hxMoKWTn1P3nKUS+dnFCietJFM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7554.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUJZODdTSjhCUEdYOFF4ZjdkcktqR25MYkFnOWlPQXBrZXkrRHJrZCtZZWtR?=
 =?utf-8?B?cS8zeUp4alZPNkJEem12VFVZcXl2WDdKSVpxZkV6QS9kc0RwSHlCSktmT1ZT?=
 =?utf-8?B?WWxaSiszd29vYnl3ampUbnBwdUprQXN3V3dVMFhTNjBRSjJnODZqTkdmTnBo?=
 =?utf-8?B?SVJycGJNZ2VIb3hGcU0vdktHS3hqNi9hOUZXRHR1VnVpa0J5RjNRZ2tiMWI2?=
 =?utf-8?B?UHYvbFU0Sk50dlZub1B3Yi8wbWhnektnRkN4V3llUU16ampKMXdzSkNhcnR4?=
 =?utf-8?B?VXh6alEybktCOVE5MkdqOXNYTWNwQllCcW9Za005dVlXdnVHVXJMOG9DSGM2?=
 =?utf-8?B?OG5pdWF1UDhsV0syTVZCTmxlelh6ODhQWllUZzFqVXBpaGxSRHpnL1RmemRR?=
 =?utf-8?B?Q0xnM3ZULzBoQlJITGNWeFpIVFp1ZDYzdjJTNE9NdTU2RjJMb3NRd3pUS1Bo?=
 =?utf-8?B?UTlQc09BanFmTVdvSkJaTkxBTmpDd3l4akZqTDlBOXYxc2tVdTJFcmFnN25Y?=
 =?utf-8?B?WjVZd0pEVzZjbXhkaHVUeFo5L1l5QWY2T3MybXJKVjRlNGpkQUxXOHM1OEc2?=
 =?utf-8?B?dm5Od1BQY0ZUQnB2aUpKTDJ5ZjlYNGtVbTBFRWFtNmNHV0p1ZUx2b2NEUnpQ?=
 =?utf-8?B?Qmh3UE1NT3E0YmZQcGxLaUdhYjRCQlJjdWNBK0ZJNFFYNmQwQWxRUWJzczBS?=
 =?utf-8?B?a3dQQnMvNks3QTFRbHJvN29McGRrYlpGeExhTmtneWhNbnpjTHUxV1o0ekMv?=
 =?utf-8?B?blVqeTBabzhkcWw2VVNUZnVVWkZUeTU3MnNxQkxtWXVYVUZwdlEva3gyc2FO?=
 =?utf-8?B?S3F5YkZGSnJwUmtWby9XdVdSZWxPbTR2ZVR2TkJCelRUN2VRRFh0YXp0K0xR?=
 =?utf-8?B?OEZHTWZzTkRoMmZsRms5eGsrUk0wWHNudzMycEZWcmQzWjdQbXBKTGVYMEZW?=
 =?utf-8?B?NzI1cHY1REhvYWxJN1lNT2dPWDRUcU4vMFBFZko1RDhFcENLdGJMZ1FWTGtF?=
 =?utf-8?B?d2hQNFZ3QXR2Zy9sbStTTGdSaGpWTTF0UU9rT0xaRVYwZjZxbzN6dGpqVzhP?=
 =?utf-8?B?Wks5dG1hdG9rS1MxU2JXNktkMFEwWVJTcmJuZkp1S0x2N3ptaEJNejNLbDVk?=
 =?utf-8?B?ZVpaNDBudUxvelk4cmhYWTg2czZ2Y2FHRUUxSUkybXVOM0g5bk9WeFh4T0JF?=
 =?utf-8?B?UEk1bzRZZ1BCT0R1KzhTNkJPWmI5YUZjVnUzQ2xXbk1DYlhhTGFRT0RrclNs?=
 =?utf-8?B?bVdkUU9hTXZXemtrUWR4eVg1WHpJYTY4RndacHlqcEJIN1JUT3R2TEhLU0Z0?=
 =?utf-8?B?T1pBMVh0VDdHSnkzSlBjOHF4ZWVRT0pHdnNRSGZUdGEwR2paT3FubjRHMXVu?=
 =?utf-8?B?MG03bzVSbGxxeVQ0R1NTNWRWUlhNdlU2cFNNblZCNUNGSGk3SFNUbENwYTBj?=
 =?utf-8?B?U1NDa2xtK0R3MU9qSW9ibW8yNnpobDBaZFFHY3ZNUVJwZlNvcXNXRHdwY1RG?=
 =?utf-8?B?SXR2RFVGcmRjTHNmekcvUDJCZUdMcjVKbko0WVkvU2lVdEtMNDRwZU14ZVRK?=
 =?utf-8?B?SG9IbnFTeVZwUDlmR3ZPWkNSWko2aE1FWWtDMHBZNmZDYXRTUmtBdDFlMDA2?=
 =?utf-8?B?eDAva3k5b1ppSnU3SGJ2Z0g4dk9xVFBmWGdUcWZGM0pFYWRKbXc2RlJQSmho?=
 =?utf-8?B?VHRXcUlLSEY3dW9IaU5FS3RqZC9VQkwxOFBBak5QQzV2RVc5VWcyMWxneXBh?=
 =?utf-8?B?cWNwWE56ZDVUVWIycGNPY01mbGQ5d0d0TnZSNFoydThpQWhKYlk0dVlVZXha?=
 =?utf-8?B?ZmV3aXV6V080NEtaNEswZnpRdGxKKzZuU0FLWDZMOEJEQk1hY3I3ZDJVTU9Q?=
 =?utf-8?B?TlRTb3orWTRCeW9ob0laMEsxdWx6VzZPd08xV24xbXdXaVdjM1FNTG1ZaUE0?=
 =?utf-8?B?bEZMcWtleU1QTXZncW95SGYvelZlaWRpb3p0c04xL2lwYXdhM01rbDZxOXRF?=
 =?utf-8?B?YTVqRTlzOWRSNkVnTzR1cW1Cbm5vaUhzdEJlLzFRdmp3Wk5zcE5NSStTWGIr?=
 =?utf-8?B?dE1MbHBDYk51MERsaVVJdFdkbW5kT0Y2V05pTnJWWFVqaDJicFhFM293aTE5?=
 =?utf-8?B?U3dGSDN5dTZEa3ZwZFNzZUVFaHkxb0J3T2VReHhydmpUdkhTN3VqeDF5Kys2?=
 =?utf-8?B?dVVrT3g3ckFDaS9Jbnl0Z29vVnFxSHcrek1sYzNUZ1VDTS9BejNOcjdBWE9X?=
 =?utf-8?B?YVB0N0JUSndPYm16SHNnRUh3MXVYVXBUQ0F1ZEdtZlJYbUtpalp6UnNqeHJh?=
 =?utf-8?B?QVhtaytuL0xvcERrc2VvejRxRXh0VUZoSUFjdGh4R21zK1Z2UEt1eDVMTGcz?=
 =?utf-8?Q?b77+GAGR1MUIhQxk=3D?=
X-Exchange-RoutingPolicyChecked: FY2Pl9cpLbWEwut3Va0hJnljQre+uVeRYSzNhBUxwH9rl3OjbYB9DoVB/R8B/5HYLP2zcJUoa0F9onQ+wrELdGY+DKyEk63AhOEq91LvJtGAqvuY2/vUETbPU9Op02Dr+c+KVP7MskPrk6XUuEVToUqNsMFbHRamQzimgn1dvYv18aYszyXlapHPUUxUh+FEXNs7URTofXCYtOx2uBokOj+pCDbbDfkwWhcFkqUbraRQMvJPrh3f3zWlZCAARlqBEvochmgHTfCPmo87MxpH4oexN/JOu5WVbbCjPa+SvafWIxMmIIu5MQjec2QFnG4ZRk7wQYqtXATFp261LFbBdw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d314f67-1ac7-4e36-b002-08df09c212cf
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7554.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 13:48:45.8485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5FNT8lhs2PVccp2YgBRyQTHwWKtzWPtEoX7BOfXwUAYoIXz+wyipJtLSrvyfgMFJAhHTbr9NyleztA1F9wdHX24ZyLlfHkfUKW9aR8NGHd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6276
X-OriginatorOrg: intel.com


On 8/25/2026 11:22 AM, Animesh Manna wrote:
> intel_alpm_lobf_compute_config_late() selected the main-link wake time
> with the two cases inverted: when aux-less wake was supported it used the
> aux-wake io_wake_lines, and otherwise the aux_less_wake_lines. This is the
> opposite of the mapping used in intel_psr_compute_config_late() and of the
> underlying meaning of the two values.
>
> As a result the LOBF enable decision (scl + guardband > first_sdp_position
> + waketime_in_lines) was computed against the wrong wake time, so LOBF
> could be enabled or rejected incorrectly.
>
> Use aux_less_wake_lines when aux-less wake is supported and io_wake_lines
> otherwise, matching the PSR path.
>
> Cc: Jouni Högander <jouni.hogander@intel.com>
> Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com
> Cc: stable@vger.kernel.org
> Fixes: 9090fa44a6d45 ("drm/i915/alpm: Compute LOBF late after guardband is already determined")


I think the fixes should be below commit:

Fixes: 15438b325987 ("drm/i915/alpm: Add compute config for lobf")
Cc: <stable@vger.kernel.org> # v6.11+

Regards,

Ankit

> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Animesh Manna <animesh.manna@intel.com>
> ---
>   drivers/gpu/drm/i915/display/intel_alpm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
> index f1383764b702..559fe6d14c01 100644
> --- a/drivers/gpu/drm/i915/display/intel_alpm.c
> +++ b/drivers/gpu/drm/i915/display/intel_alpm.c
> @@ -314,9 +314,9 @@ void intel_alpm_lobf_compute_config_late(struct intel_dp *intel_dp,
>   	 */
>   	first_sdp_position = adjusted_mode->crtc_vtotal - adjusted_mode->crtc_vsync_start;
>   	if (intel_alpm_aux_less_wake_supported(intel_dp))
> -		waketime_in_lines = crtc_state->alpm_state.io_wake_lines;
> -	else
>   		waketime_in_lines = crtc_state->alpm_state.aux_less_wake_lines;
> +	else
> +		waketime_in_lines = crtc_state->alpm_state.io_wake_lines;
>   
>   	crtc_state->has_lobf = (crtc_state->set_context_latency + crtc_state->vrr.guardband) >
>   			       (first_sdp_position + waketime_in_lines);
