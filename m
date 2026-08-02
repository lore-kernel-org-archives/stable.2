Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FE326B2DA;
	Sun,  2 Aug 2026 21:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785706367; cv=fail; b=jv0+iwGsvCHbAFGtg6QpAn65zkvwKOHQo/GF/96yJ/OTzkp5qQu5HHSqzXvBYObagUXbogdkuy/4TgCWTWiPpajnMM9oqz/tisgKe+KH+nQzbzcr1UEeh6KKqWA4hXCBiWpT8Zly7PXK289SXINNwELMDr9IpclW4QNxSiDVxc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785706367; c=relaxed/simple;
	bh=tWtAtxKsday8mk15uUOmBUuFfBgVrcjrG5v8ETC64fY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TA3CYSqJH12hLatRYmazMbiVqQ7ezNvqUlLc6bVHTSUOxBnvDhCywsfyOs7hlhsSiavO938QUWPQt9nKR5p9LPUm5C8e+Vh3EjfdNq97GDf1WKKaCQz3aofKnF/v8bPala3BNFeLvEevpT8DoxQ28IA0K4aKKxGtgRz4JYR/vBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OB3adeGe; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OB3adeGe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785706365; x=1817242365;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tWtAtxKsday8mk15uUOmBUuFfBgVrcjrG5v8ETC64fY=;
  b=OB3adeGeJpDXFO6DBdYA1oJOJwXrTbCQNT8swQRiNmUxdyFhcSrce8Od
   EDJFgSJSBLlu8HN7NSPsN0VbMTShJhMsJM5sNDoz3yJ2TMcjnTLrcx8Ik
   A6Vt5S7EnZXX7U/O7QgkgsQMQ0tmbl1PRSPHvzCSVIwnkWgkxaGVc0kry
   9rx1GlikkuBqqS9kGOw/nnInuHGRJw8pnlia5ETe+aAGf4QeENLQwqiJw
   Pt6Xs1A36PZDlg88oFkByGQV9KQSiFmrSuQdl2KMrE7kF3ZVbd/X3x5P2
   fxXjfgeDrrME15Ftme/ZikajRvoimaO6n3B8JqzOVn+5sz/+Bf5ZsYWbL
   Q==;
X-CSE-ConnectionGUID: Y0rDkMfBTN6xgoCXl51Bew==
X-CSE-MsgGUID: cWiSSteYTBucX9LeXJn+iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11863"; a="103788614"
X-IronPort-AV: E=Sophos;i="6.25,201,1779174000"; 
   d="scan'208";a="103788614"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2026 14:32:44 -0700
X-CSE-ConnectionGUID: FOYAYJQ4S8OaT/gvXdU+vQ==
X-CSE-MsgGUID: RYTyy4xrSZmpvMx2ra1ISg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,201,1779174000"; 
   d="scan'208";a="290987480"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2026 14:32:44 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 2 Aug 2026 14:32:43 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Sun, 2 Aug 2026 14:32:43 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.56) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 2 Aug 2026 14:32:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uh3aC5c51QG9OcK9mocCNHj8UphqtWyRM9HKi7WLIoawqcLG8DNuJNcbxyVtPJmDw8vufV0FSDOWptL9Ddn1OyDPeNy77h55F3LgwyrGQ/QZKZx18D5ndpHv/YWlAdvPINAjWfnJMX16HVKaPZPXcKS/3dH3YG0kTfRFelDfZNK62JUuJmmm/euQJutB/XLK5q9Svr3B75FX7yF13LE7svODK34rnLPkf5xTjB2wCJqRoh4yfekP9mE6gkgPM1qZ42MHJe4+VMwXIQXkGXSA8BSA40RpLf8hMKCFAaXFhHDVu6plbBIIsyshgpIVFWe7bdtqnWpapaibUznbjDXgEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTUmP/a7pQor1NJkMLYCOpbjGM5lJnChHQLXViva7I8=;
 b=e0s4j6w5LKVA1tASsKdFql9+/haDFxptFGiAUXABm369hh8KnvsTx6SPlSRSNFOFDiU0kAdOMi0ZaKemxHLg/GMnpaWQSehTi8Qx13WgoALzJ+3V5+ghczIR8o950wgLLH1AxryAGJw4PIWAZo6Iy3konlqPIuRvuhoOFNRIEDRh6a1karG9fQsM606qT7bCV00r0SePfrI3mSo3158v5fanIxqKdvPQR9iFWiE+xinjDK/DeyOa1Xrho0c+DC1UF5Q5BIy4C8yn4VilVuNLxd1ob5Ff/QSgpuaSXJY4L8sIPZ+SNIY1JUE+JZRkm+aiOb62yLcOejn5AtJpBzLnXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 DS4PPF2AD6B04BA.namprd11.prod.outlook.com (2603:10b6:f:fc02::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 21:32:34 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 21:32:34 +0000
Message-ID: <762ba2f6-bfe1-461d-a46d-84f5f368445b@intel.com>
Date: Sun, 2 Aug 2026 14:32:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/build/64: Prevent native builds from generating APX
 instructions
To: David Laight <david.laight.linux@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, Omar Avelar <omar.avelar@intel.com>,
	<stable@vger.kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor
	<nathan@kernel.org>
References: <20260708211435.402426-1-chang.seok.bae@intel.com>
 <20260801124429.45d03af7@pumpkin>
 <2ea83400-a49e-4015-a0bd-926e5a0ef073@intel.com>
 <20260802100808.754400af@pumpkin>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20260802100808.754400af@pumpkin>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::34) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|DS4PPF2AD6B04BA:EE_
X-MS-Office365-Filtering-Correlation-Id: db69d1be-7a12-442d-ef39-08def0dd90c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|3023799007|10067099003|11063799006|4143699003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: bPO4Zz3p4Fph7+TK9aQu2pbsQWvw/xMBWck8SakpYV5UWy/hI8rtcT1yvTe6QWfl2IFB53Isn52PdvyPfA2iRFBrqUsI2ytPyDrl5w5vXIDk4aOqcdTwvVFNCVLVtMZvBF4su9Bgl0wnUJhAFfiQu3C1zDr9XUOOqnXnWW21ZX5gldpLF0sjiZWCiyZ/J1aXXdLHOp2Alr8GhJMZ30nAiqFGafLN/GaYESxxzUoXAN66uxbZO79WwiW24zsvAeopmuEM9NsTMYTLmdGG80pWiJmSe32pD8J1G8gS81WAF+fqvLNBx0UHla7x3k2X/bYBBjIk7JRVW5Xxyi4YpkommplS1Keiox+mJVxdz00aDpHn6qkOJ7AGWqusAZXbo9sCnVDzmz9F3WVm2muXfGI8gsrPRYZUjb+cT1xaYsZroP4BUIctKRz1OuxTTgL9/nP2Soi7j2xEdppPYeqNe/VMnI+3fVvN9zm3A0tD4W6gcH+dvs76lbbie7hR/NZ6SmAZjchCt8Ic9n5k2k/O1ElmfNj4Y07t8wKAt4kDrE5rF9xRbi3+ABbH5V3lK1VgQr2i4HiVdTF9yBmwmZ9Tetp65dHXcesCiPtQXE2/qtDnoJRO+IWKa+fY9nju+DOs1yQ7XbiR4asbXY6LS98hmnDGJl/6VwsDyY0F/Vm38VJaQIQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(3023799007)(10067099003)(11063799006)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0pWUzJlUWZCZndMeDhBWnNIS3ZCUUczNEU2dVlTZG5NKzA4UDc1b3hwb3Yr?=
 =?utf-8?B?QVM1bHg2MUFCNURFWXN2bFFDcFUvQml3dzVuTHpBTm5FVW9mRVJiUmprWkNL?=
 =?utf-8?B?aUtlbGc1TE1sTFNGdW10TWg1dlcxN3U1NU96MFkyaHJUQXV2ZzJuNFRTSTJV?=
 =?utf-8?B?bXRpVnMyR1N4OHhkSVE0RE5hY2g0UXFiR1hualcwODBYMlU3OHhmdjhpcEIv?=
 =?utf-8?B?VzJtc29kVzBFM2syYkhGZTBDVDZMV0dzSVJubG51N2tFZmpaellIaVJXN2VM?=
 =?utf-8?B?VHQ3Q3VYSU5QSkhjYVZMTURKdjFTMGpZOXVJR09RYlV4ODg2ejJ2Q2drWk5h?=
 =?utf-8?B?R3MwUUpnaUJXVno1cjgrMDhxcW9qTGtxV3dTenJnMmhpUktyOFpkbmd1Ukxl?=
 =?utf-8?B?RXhhY0p1Rkcwdi9Db3VhYjBNeFVPaSszUkNSVGIyNHBPZXQ3VVVwNXpVVCtJ?=
 =?utf-8?B?cWtxU1EvNkY5TDlXWjVpNXJyTUJIcDkvWWVmdW1zbjRHMS9BQ3JkaFdvZHc5?=
 =?utf-8?B?VFNlSzB6N2pCUXlqNkJKSGdTZW8xSm05bEJHM3hIWWJwcEFWYXRMc1JzVDBm?=
 =?utf-8?B?TTBUZ1MxVHRRTGNDZFBVSlVlY0dwd0NvRnJIZnBrR2QzQ2hwdnZQcTlUaHF5?=
 =?utf-8?B?K25tNWlmYkZHeHcxTTEwbGJ5NWV3bVhtV0RoZ0FROEhUWG50Z04rSXZWby9M?=
 =?utf-8?B?clptU1lnVVdFQ25RWWlCbVFYMW5IWGpwYWhXTENPVWhiaCttd3pvK1NwMmV1?=
 =?utf-8?B?Zk5UbmUvckVhY3FoeVdobW1valh6SkllK0hnSG9ZaGVqd3J0QXkzWE55dmMx?=
 =?utf-8?B?czJ3UzFKbUFCV1k0MndhUnkyeTBLV1RoQnRjMkZwQ09ILy9aMGdPUGo4YURw?=
 =?utf-8?B?VlRCL1hpMk4vSkwrNmV1clN4Mzd3Uys3RFp2b1dvajQxRGhqek5zNXpwNFov?=
 =?utf-8?B?VGdBRXdORXZaY3o4UmRmYXRMQVNoRnlTcE9OMjlEcHJscjc3a0ZnRGdCZ1RL?=
 =?utf-8?B?NE5mekR5Y01aSTVwaXk5U08rcVh2ck5ua1JsOGhtdzZFVkJzZlRsTFlRTzZ2?=
 =?utf-8?B?c3RWcEFNejdsV25qRkM5b28xMmNnL2RGc2IwdStoaCtrcTk2MjNZYml3dHEw?=
 =?utf-8?B?bzNlVzNLSjBuUjVZUWwzeDJib3dRQlp3N0lQVGNRd0N4S0hETmQxMlVjUDdN?=
 =?utf-8?B?dDVWbWFCZ0w4Ry8rS0VEbmhER3BPcEk2QUZ6eEpocmVoTTFmM3FnVUVSaVd5?=
 =?utf-8?B?N2U4RmZWSWcvR3haREpzKzNKL1JoMDAwWUdqS1F2UUZoNnZtSGFGRlREbmNs?=
 =?utf-8?B?bzFaVy9vSjFpbkIzblZORC9ZUjB3bTJwU0dubEZXUW9kKzlUeE9tS1BCMVdh?=
 =?utf-8?B?OUhhbVFtTDg4cnhzZ1ZoRURZM3VXODdNQjhUOG5mZzgyNGl1UklDQmlhdkVE?=
 =?utf-8?B?enoyQ0RmbUt5R0pYN0g5enlNS3V4b3NaMnVza1hyd3laRFM1V0JMMUlNbjk0?=
 =?utf-8?B?dk1jZWtOczMvZ0Z5UkVhWkhvbk90b0paZkEzajlUOXpFV2FLV1dhWFBldVF4?=
 =?utf-8?B?cldMQ1RyTTNrWE94a2tBeFVsZ3BGYlBYZUMzZkdkSU02Wis5M0VCdHdBTUY2?=
 =?utf-8?B?bkxFbElHVU03clU5L3dOVG82cE8xT1ZXejJIK3hmdWF5ZnJUMFMwcU1vL1VG?=
 =?utf-8?B?Qk14THFmL0hSSWczck9EVWpUazRETWVNaE9ha3JaSmhkaXk2MXo1K2l4Wklw?=
 =?utf-8?B?b1dJNW1LM0NqV2FVM2VHaFR4NVd2cVEvWFhzUS9QZG90Y3JRMVpkTW10cFBM?=
 =?utf-8?B?Y2VucWdMbWUyL0VZalNqZ2NWQUI5bllaVkVIMHZuL2lVZjhzUnowdUx0TktM?=
 =?utf-8?B?OHNYanFCMHFLQy9VSmFNT2Y1bVNPTk0zY05JVnhsQ3RrU2RZM2Jad0xWS1I1?=
 =?utf-8?B?WlZCTHU0TTFPdURvWE9qdm8vSnBOWUFhZERHS01KM2o3V045NHYrRVFDcFBD?=
 =?utf-8?B?K1huTU8vamxDa3ZTR0ZQbHdEK3gxWFNGK3VTaFViQ3c3Sk8vcTh2b1pKazZJ?=
 =?utf-8?B?SmhJMTAxOWJkK1NqeTFDNWY4TkFnZC84cUt0Q2hRK2ttaEhvVDA3dlFmR1lT?=
 =?utf-8?B?MzZnVy9NdFVxdnBFd1c1R2FUUkdOZDJLbDZjK3lPV3AvMS9ZSWlDakxJbFRj?=
 =?utf-8?B?cGZHb1Vpa2padE9Ma1JydGI2cmx0aGM4dXJNRG9BSUZqWmJWWGIxM0t6M043?=
 =?utf-8?B?Z1Q5Qmg4R0ZpcFpyVlBVQ0lOOEdxeWxxQWJkWi9UYWRTbGdON1BVajI3OFk0?=
 =?utf-8?B?NW4veFliNHlXZXNlSDlkUjlOTHVFNnl3dXpIVlBkZFFTak04aHc4UT09?=
X-Exchange-RoutingPolicyChecked: P7G3bKEs6ZwYgaMjKRePG1ap5y6MIPy7WVU1Z7dNCWPJfUuzTqphj077F9YNU3LXq1awWjecU7gq3FgGHJehaDICj0Sa/ogErVkWwCry+r/RZM9LdIkkUNbHM2C3z1ALUvuN/21vBPrt/t5FeVLy3S9aSR8WH2/+0K27zbD+wzAb0MRHu1DBPwreiU2QjK6nqkElRR9eiP0XdTQ+WcSMmxby2V057ccBdVp59z6DA8eLED24BrOzWTHxnV6ojf/n6QWsoh8Xm4E2hBnWA1whSuNryZGY11NFXPaKjA6VYt49/UMgEd45OhEi6d+YTyjoBLg69iWhMgidMDnWxfLXNw==
X-MS-Exchange-CrossTenant-Network-Message-Id: db69d1be-7a12-442d-ef39-08def0dd90c0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 21:32:34.1891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aODkbxqX4xugpO+W6ekuNNQ0xrMrJRfO8KWTiqQA7apZrbM2ca5YkHcsP3r5K8cvwC9KGQuDGds0HOewKRtLLBv1I9TdEvMQfzlXxsdpx0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF2AD6B04BA
X-OriginatorOrg: intel.com

On 8/2/2026 2:08 AM, David Laight wrote:
> 
> Does that mean that this patch is completely unnecessary?
It is necessary. On APX systems running, e.g. Linux kernel v6.16+, with 
the OS enables XCR0.APX, the compiler may consider all 32 registers 
usable and the compiled kernel inadvertently emits APX instructions 
(unconditionally) clobbering those registers. So -mno apxf prevents such 
unintended in-kernel use.

Note that mainline currently supports only userspace APX, where user 
EGPR state is context-switched through the XSAVE mechanism. That alone 
is insufficient to support in-kernel uses. Like the legacy GPRs, EGPRs 
need to be handled on entry paths, and there are still many other things 
to consider before in-kernel usages.

Thanks,
Chang
