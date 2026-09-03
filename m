Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035424B2021;
	Thu,  3 Sep 2026 14:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444688; cv=fail; b=PqFN+kWYeoEdHzbSnNw98vLHZNHwIIwOM9qChsXfqXVKZx4lYaoZ8onfC/BfNkR6nc7wZrHDtzWAkx9D8RdM9KkQMJbFVZLXJP5Dssbh2SC9G/ybSKel8YpZv6CkICo8sY0GCJ83zCYxcccAOks+kFWDZHg6MqIVJOmdqaq9Qao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444688; c=relaxed/simple;
	bh=z6BakXuc+Rj+KQ5G3Sz34YHRaFVXZwRl2f22DWgjk7Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UeFZlF6OFodPEF5IPenXJS8WgKex3Vu5P4UmW4eJKCMC6dhs3j5FHDi7MuiX8T52Ns1DM/sxJV8PvKz1LcaldF8MMqa5UKgc0Yw75sjQ4FW8IRQLZ0mGSfAq3LgIzp2GlSuPInLBPs6PLvCJ5mGWu9joEihMKNNdsFDgzLayKDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lxYaA14u; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lxYaA14u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788444685; x=1819980685;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z6BakXuc+Rj+KQ5G3Sz34YHRaFVXZwRl2f22DWgjk7Q=;
  b=lxYaA14uJlVPuuitVpttLvuXzT61jARrKpusUncQ7oNNlMDeO2LoCQr+
   VmtJ9azQoeOR1ZCDBLTvTsyK94XdMQNlxEn9g62Ag/COpMsfXscQh8Fo2
   7uvwLWEHC2cfkSXMjNTEY82hyhduWpHrPBB6Spzj3t+pW3Fx/NxwHd+Om
   Eh5HwU68tGZjrtHYzAByWt8ttzOk3Ih/2os0xzUYAs43MOi5hxSe84BAA
   LKJsIJZ88U+Z2JVYren8Me4v1IxEiktGvOfmq4NiIVEeLGj9mI0+mf/Ny
   i80ZbUOIIari44W3WiHM5er9APCkSryRH1ByoR9ZG2bLl5DQCWRhsrzfj
   w==;
X-CSE-ConnectionGUID: mlyLthGOSz2Gdajcy38rdA==
X-CSE-MsgGUID: y/XBs5NFTmqM48W49cw6cQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="92796248"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="92796248"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 07:11:20 -0700
X-CSE-ConnectionGUID: f1QDhp3iQLaL8koaqqbYAA==
X-CSE-MsgGUID: smsxI/6MQJSUVSmAg1+NXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="266051481"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 07:11:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 07:11:18 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 07:11:18 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.30) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 07:11:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4j8poVW4ucls/r/isjJ3Jfm9gZ3y3mwn4ZfWFwlCu3rxMP8gSjMlLf7u++mypZRNHO8yeXKJz07FbuilJ44cP2WGe6cAW3IcPHFxQr9SJ/OnNjnVaHeg8FkMm4uIrqn3z7ExjTbVe1CBdIjiW1pr+2YU3dZOOiovmPgmyab23QM9PMpXRCe4aVldNhbEaWmc3SCtl4nIWf+d7tY9bD2WmzGSTa6PQWJFqrrl9YvfOjtYZwGzhZi4LoKb+DxdPhvTyOw0e6ddQ39UkMwaofv1kIyUO62liDWmAzdnVkuNS/kRQcnKiSodHawRFA4U/lr59VFZ0AAi8HRRoCrqntXsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QmRZUriwq4s8gTh2YsvFndIBJWbgng2NIbk0AQjoeg=;
 b=lLmSktzs8tEKXKFw8x0sqdX3HoBMY4mrAU/+MLDUTedCb8BY4uzFqnjaWTvHFzmPP00Xcm4a2IOEUjp3oKGDU9uDQj+084iYKXov4od705kmt/beskAjjy14Dl6WvvSBHXsEmcHjgViw/Gj3dQRwh+itv8/rflH2JdjD5S+h4MDzznf0iX1XJj9gJpSFO6kZhnj/wj7EXbeHiONfoccPPaivb/WfzUwKFqkODBF9R0uirllRyzoLcIHv1NcRKRPWv/28CgoIEXAZdfKhmCnPDRekm7RhNSJD4O6UFi97PqXFIiIZLeWhdty1qTbNCtBcvokIUN1nTNXEu1cYMyxrmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 LVWPR11MB9905.namprd11.prod.outlook.com (2603:10b6:408:3be::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 14:11:04 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%7]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 14:11:03 +0000
Message-ID: <0b7180af-9cd7-4a01-af91-c2b4acac624a@intel.com>
Date: Thu, 3 Sep 2026 07:10:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/build/64: Prevent native builds from generating
 APX instructions
To: Borislav Petkov <bp@alien8.de>, Miguel Ojeda
	<miguel.ojeda.sandonis@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<rust-for-linux@vger.kernel.org>, <tglx@kernel.org>, <mingo@redhat.com>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <ojeda@kernel.org>,
	<nathan@kernel.org>, <boqun@kernel.org>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
	<aliceryhl@google.com>, <tmgross@umich.edu>, <dakr@kernel.org>,
	<daniel.almeida@collabora.com>, <tamird@kernel.org>, <acourbot@nvidia.com>,
	<work@onurozkan.dev>, Omar Avelar <omar.avelar@intel.com>,
	<stable@vger.kernel.org>
References: <20260807151715.7247-1-chang.seok.bae@intel.com>
 <CANiq72=bEB5-GvvroXigiCVtHjGtkhs1ARkk+mDbvjNAR4XKVQ@mail.gmail.com>
 <b00de567-f828-4ad8-a6ab-6ab1c47de68e@intel.com>
 <CANiq72kT7KozY5yXyCFpN7-7rc1Rbw1cLPs-c5AFuKYVu2f4KA@mail.gmail.com>
 <20260903052325.GKapkETZDh2AU8aWNP@fat_crate.local>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20260903052325.GKapkETZDh2AU8aWNP@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0137.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::22) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|LVWPR11MB9905:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e75f477-d1cd-4022-ffa7-08df09c53035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|18002099003|22082099003|56012099006|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 8R1OZuBspTPmAH3/WK/bu0BpiL1Y4/ij9ubJe5gFjvQQNnFdLi8xATDXsPboDAKaBh7ZH/JuMf/2f5vAwlCFs45sfs+IcD4rsbTAW6LeFHBARt5IqPOT+Fgx117Gj0HyLyHkiWbcIFIJIZPqoYMnWGSrsdChX017NF6Y3HfMD2TdTq+XRfAPVO5JvfMqRWwnrKwf8qAusOcJKBrm4Td0hIDnF2CXeaAMhJjljUWI1koasG9SmAn6jYlzs1ZUD9awiEP5ndIBwviA+5K+8Lmh1YVXQzGf4zIuWeTA1dTgMw9dp1gXcMc2Mn9ByvyXO9DyQEPqfB1T2mgV7iZtrGfpcymOxIUELhNBYVDXBgK3dyZlPdQGPyCitJrkIL7K1moJt1FDkA2BYYfTgFphSDKe0llHwR08ibN+hHPYyh68xUpjUaC6OivgnopM1D+Afm4G5m1cRMG0hdXQ7cJtqZmckOgku+03sJlo5Ob6WGnuEmPbg/svzL08RBxzyEsaKhMaoB+1RaUVCD2VplUg1pE9qFjxcvRpfjOWdPOB6ZsHAaPsgbchR2N+EIxoyij60GDUsdKwoH4ACUP4q7dB4KKpOFo8id/jeylQ1e7wK+49pXRwvLrrCzS9sgsR3yHQ3qFTCpnX/ud70DLf6ggfQr4zoDyUmN/K3Z7iJlwF4dtA6jE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(18002099003)(22082099003)(56012099006)(10067099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU11Qk54dEpRQld5ZTdaeFVCVFNvQUozOHErS21jcHFWRkloekE5MXRPYnBJ?=
 =?utf-8?B?Y28rcGtDbEJBalJGSnZoSzQvbXVUeUxULytrS1RmNTVmNlFPckJ5ZDd0cXVT?=
 =?utf-8?B?YTBBc0RTQkI0TnhTc0E2UEUwdHc2Zm5kZnBZcVAvdDBJczVMaXRCazNtR2Ex?=
 =?utf-8?B?bGlMQ1AveWp3aTFNa0hXYjlSVFdaenBVR1ozMTBSMWtIeWtqNjR0K1pEcEZP?=
 =?utf-8?B?a2VObUdnU01NRGV2VkRQK3RFMFFRZmttaENPcmkzT1h4cjNBUENINnNmb1RN?=
 =?utf-8?B?bEVibTBWd1hQVHMyYjd5MlN5L0k3akZpdUp5SmowYUlFYVp5c2JYc1Y5WGxp?=
 =?utf-8?B?bVV2ck1ESXhzN0ZHeWhpTVRTMGNBOUphMWl5VlB4SGF2ZlZWUnNudzU5dHor?=
 =?utf-8?B?THhjKzBsN0JIZm14eU1GcmpNQis1cXJxMEJnT0NuUHl4UnZmU09GV0RXTzlP?=
 =?utf-8?B?ZnVWMWVsUDV3bjkzZnluVVRjcE8xdkJQV2J4ZEhEQVJxUnVESitFd0NpODZo?=
 =?utf-8?B?L3loUzNmM05seVRNcVJhZmVrSVE0QVhoOXVoYktMTko1OG5TQmhvNHZNYkJS?=
 =?utf-8?B?Y0xXTlZLamFvRExsQ3lmTmo1VE1hTDNqZGdKeks1d2lvTVZHR2FCT0o2V0RF?=
 =?utf-8?B?QVdxeEM0R1VuMVJORjAvOG9JVVpZNm5aWUZ4NklrUjl1T2NrZmZQRU56RFR2?=
 =?utf-8?B?MWNZeHYwSmczak1XV0dxSnVRLzRpellyb1dIUWRLeXk4dTA1RHRZVUk4VWxs?=
 =?utf-8?B?VWYva3JtZGFnOGpUUVpZbG1CVGZHMC9YQVEwcEpaVFNnbWN0S1BhalJacVh3?=
 =?utf-8?B?UUIyRkk5bHBzK0NqRjRZUDJMUkxvMFVCbkcwbWpQVlpGcDIwcEdNaVhqMGlF?=
 =?utf-8?B?b1RBVFpyMlNXVk4zalhnK3RoK0VQZGJaYWcxaDE5cTNlMXQ5UXhWbnJ4NGNJ?=
 =?utf-8?B?czZBVjZZYkJEYTFIc1EvZ0pja05iUUpGUU1CdnlFMmc3MkN4QUZiaHhHbW5r?=
 =?utf-8?B?TWlIbUlqZmZEeGJnTWIraE40ZEJrZVhwU1BSNVIySWxmK2VJSW42YzhkOU4w?=
 =?utf-8?B?Mlp3NE5IRzM3S09lOGJNR2x1ZW40NCtQalcrR1REQWdyaHV3N3dWVm5MMXZo?=
 =?utf-8?B?Z2lLbG95aUJIN09tUFg5OFhaMGgyVW9XazkzcENFcmFHWWgvZ2JtTjB2dkFI?=
 =?utf-8?B?Ujk1aUgvQTlUTG1waDZrdnpKQVQ1b0ZFS0ZLZ1FSejJFdTZPb2ZFcFpUcXNS?=
 =?utf-8?B?enZMaGpZOEF3QTVrM3FLZlBteDdUNkZ5U3d6enZFMGJPdEtFa2x6K2g5aCth?=
 =?utf-8?B?Z2dXZ2JMUEtlM2F3eUFJQ1ZMamRxZEtkTzNtT1IrdzJHbXRjTDhxb1hCMlVu?=
 =?utf-8?B?R0NFM05NdkVVK2pyeTRsekJyRkpWUkc2U1JMUmRVUk9USW5nN1MzaElRbWtH?=
 =?utf-8?B?QnB2OC9YcGxlR0MzVktWVFlPTEhKYU5MNmJEYjVzV21RMGo4S2xJSE13MDRa?=
 =?utf-8?B?aFlQa0J4QytQd3RSUzZUS0xtMWVIM01SaFIySzkxMlUra1Z1T05ESExxV2lH?=
 =?utf-8?B?MmF1RGZob25ZWDBObUdDKzZCYS93OGxsZ3BndVpXaUx2cW0zUStSR01YajdI?=
 =?utf-8?B?eU5DWWdldXJiZFNPUnRvc3lDYmlXanAySWYyV3hhUWpzaXdXaTlrWG1wa29s?=
 =?utf-8?B?ZUtmUnFRaFRyZ2tYcGhSd1AvRVdLOUtUOFg4U1huRDFVNGR4bU43ZzJvTjQw?=
 =?utf-8?B?aVR2Z1l5MnBNQ1dreTAvWHBLRDBlOUZnaFJnRXVIMEZ3TkJueFlhY2xCWURv?=
 =?utf-8?B?eXZzYTVORzREd1RUc0hjYUwxVE4rM1c3WlovczBuVW5Qd2dTSVo0MGJ0Vi9o?=
 =?utf-8?B?bUVjZ0Z5UmF4ZTBHdkhadHdpZXRlY1dnQVhVbHpGUzV6L3BzUElmQXdlemJh?=
 =?utf-8?B?UTEweTAzSVlZZmtTZUlNYUF2VDJVRzQyN1FSSlVVQk5xc3ZqcXp6czE2QzQ1?=
 =?utf-8?B?OWNhcWFNb3JZN096bWhaeWlIVzZ4ODQybE9UcFJBcnRMaHlqVlh0UGVPdHBO?=
 =?utf-8?B?YWUwYjZpNVVRL0JSSzUyRE1HVWlmSWV2ek9SdzRteWxNbmhncFpWSEwrV1hP?=
 =?utf-8?B?QWFDeXJ4NEF3UTVIYjhoS0tLaFFuUGFuQ1U2RnNlUkRIeWYzV1pJaFErM3BP?=
 =?utf-8?B?T1dVbkJFTjJIR01za1N1QTlnRVBER1V6SDRjQ3EzcXI2bHJ5U0pSNXdIZkZm?=
 =?utf-8?B?Z1lBSDlYVFZaOHdaTnlsbkpTcDZkaWoralMrRDFvL1pOdnBIeEFEbTY0QUgy?=
 =?utf-8?B?cHFRRkdkUDZ4bUg1SGRuWTdDUDdEVFNCWlptQ0NvWGVGSXNaT3d2Zz09?=
X-Exchange-RoutingPolicyChecked: X0ya0eNZjvWoEiCnHT3SsXNRQ8PDIlqBumMxNs7KOmuMiJnIlmO5wKlwRODCmhtJiYwI+E50p4YF+hW/1aYOUGQ7UhT9oh2SXB048nhLU1n92RzVx33QPT3D/uGOEpC9duHn2F3D4f4fi8gYraL2HDD2GYKleGLMwCANMd+kiBOGyey9FAXvpZA9ZW4KJLHuVMsYNfS9m3+d8g4bOGA2BObc4GdycVDD1Y5YX2pV+q/3Dq0ufBFc53bZr0S1sGkVZRhkurgGo4jym8jSwg9d37mPQ0tBRKh+S2ZE6QKlB+oa9VEkcIXxwQ2+gxgOviJpRAq0vuMTm5cTojHZgtegTA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e75f477-d1cd-4022-ffa7-08df09c53035
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 14:11:03.6732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tix2vUoqxZKproMaRrYTCP2DQRO3r2MyUqHh5a0GHawWVVf9F7iLIBeklGqBtoKqvGSbL3YJf9eDTX/m5GVXY3sCznGrTKBYemnDt+k/Db4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVWPR11MB9905
X-OriginatorOrg: intel.com

On 9/2/2026 10:23 PM, Borislav Petkov wrote:
> 
> I can take a v2 with feedback from this thread integrated.
> 
Thanks for the consideration! But there is one more thing to do:

Recently we found a sub-option in both compilers to disable EGPR use 
only while allowing other APX features. Let me conclude this in V3.

Sorry, I should have commented this here.

Thanks,
Chang
