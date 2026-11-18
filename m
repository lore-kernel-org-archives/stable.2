Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795033124;
	b=YtTs6nC3H3JPImU9pUi51IAYCHMbMobQKDXQd5EYF4DN4RvJFIa/xZWMu2mr9ogCudsD
	 xPKggMnxabkZes42K5IQHH4IlSjNU6V0kZh4mJwzRPpeCDEG6tV/jLHCk3x1UDQmbuJz3
	 I1A4/c36+9gISBsQmtiJgYSM1t0F+FpEJFeHsHEqrEDq2bdtDc3Fi8MxyaonafPviVob6
	 RjGVZoLK06V4Je1CWpJqp3KNjm1pFuS8tnKPKSIT2yE7fIwasZtM/colyTi1AeVzld99q
	 Y4MINqNQsnyiv+FRDMWyYF8sJL40hzInrvCf9IrbDvgYFjSzTaN/XKmaHKpQNlU+cXw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795033124;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 From:Subject:To:CC:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=FCKU0EB/25yxt12yRtIZGs+U8XplEsYA+kAH0NdvS00=;
	b=NaObQFhLnWlyEYfgdjyfgBov9UZf36IQiMG7k96i4Fm6fa8UtTnV2rO4MXiDDc/1Tzrs
	 eObSf6jnupKac4KGm4j9/GWGf6/EOT8uLXjfG/S+l1OrvEaeRx2snz6dvsNSgtAKPoxRx
	 TTEzBCvt7RHTYzVu+8ukPF7eBjNx9IGZipSj1v59At6KG7XAq2KMer+gKbjR5ng5a+EWz
	 bD7ySG2gMhT5H21FyYQd7lXxv3czUkZJe5M7Je8aSchew48Bqfoh+f6NJKmodh7Mu9/OR
	 RBzV1+zKVJkGfydL2XKk18cPxb4xNarLuXR4kV0kjpe2GRUqPitozv5Go3aar9/biSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="ItT/IlFT";
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=gJ3G9HLE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D5F606A31C;
	Wed, 18 Nov 2026 20:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6D5F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ItT/IlFT;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=gJ3G9HLE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795033124; x=1826569124;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Hj22G2+vpynbRVRJyrZrJTBJKEmMuKwnUdlMTNM//io=;
  b=ItT/IlFTfg0u1IdKSsPa3qIJB+WovMYgYhItgjMiquWV4xnDJW9/M3js
   YYizkUSUaKcXfazJA6FflIOBilwrI2HoI6izhKq6T/J1eukOEP+RsW6F5
   +Ukl7pzxUwF80kjer16xSFtUb7D5rP78tG1hqnjXg0P9VGjyhskKQt/x6
   S8AYmsW/vEyP/ykAHsqvTbBobloN3ov8Lpq78mfN1cwyUzC5mEwWa/nWF
   Gn/1CW5CFYlsezVqX7ngkF8JQTRFew6YwGklZrDwEqiwquQvEHWkUuP11
   eaHRbHAlFnF1PuGZtTqJdvhBPUlaAwT4habt3Gv9q7GPgb2xaiFliUMr+
   A==;
X-CSE-ConnectionGUID: ZrwKZNRiQxyb6CiRlAKX1w==
X-CSE-MsgGUID: DJA6Dzx1SseYk9toyOVt1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3781539"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3781539"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 12:18:43 -0800
X-CSE-ConnectionGUID: LL7la25oTniEUGvJAtEVmA==
X-CSE-MsgGUID: tBiGntkARuObm15loPD+ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10567398"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 12:18:43 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 12:18:42 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 12:18:42 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.36) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 12:18:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hitiOBNJfEVXbRTTO7qEeooCj/HBkjK77h4kpAWV8OI25OVirqC7otXwmXLgP5pk0F+6CwYvbqYqusiavVH4K6F3PBj9Ygx6C+AJf/QO53Ng90/GDfdzvAkLoQH4xYV5oAvFIJsta49b6FTSDUhrjVkXU/iOIzf/n1M7Alf8EfpjeVWe04x/f2LLsvJS0oTj1nxhHKKC9OrGGXWquioGd3WdJkmvh/+Xp6tAmJ5T1e7aZpig2EscaIpVEgv4BPXXcH7K9iroEUjJBmPf/YTbh+dh8cbMtfvVZuk+XVV+XfFXYS7nSG43Ub0mSR6p/aOBr8waUqf4jNc0YJMm6d5uZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCKU0EB/25yxt12yRtIZGs+U8XplEsYA+kAH0NdvS00=;
 b=Axo3daqPgS1OgZB8878soWj1o/N4HOwU+FR9hpOVde5jg5+9DiR3GT8TrW58dbB8j5gmvtOx/rrlNj4DzXsqhErvDb1eg/RpTM8TabEmR3sDgukNuJcLJXFY3t0Tuk1beF5tuuGlAStLm3U4d9tL/Yhe4IaigwXfXqYeYhalKFcqcpocf/fEhMHK055vk9/R9cDgmzOYHkj08YUEZbazcF6AT2vszsx4rb/5wbvd8j0TFY/Xx0uJlgkM0TimueCCeGlb13XFKHwCyLy0wL+O4H6Pwf0sWkd9ffak8wWHyrLH37RYUy7Rkpannlc2S+HWUBE9cJXEz+HN0RUz85M1ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCKU0EB/25yxt12yRtIZGs+U8XplEsYA+kAH0NdvS00=;
 b=gJ3G9HLEI46SL+osgwnHDep5HaxoCu6koBsYm545yH42BBmkGkY4I8AbHggToIw3tPNg/NUbIQrBwJdZL0RBWvM9+WIcdf7m+LipLqd9b6dNQ4ByvELpossIQpOxPEaJYLMFSB3bQ0x4JVtD0rOLzeMID+G4f4vyzznPlP9gG/o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB819107.namprd11.prod.outlook.com
 (2603:10b6:806:518::11) by SA2PR11MB5098.namprd11.prod.outlook.com
 (2603:10b6:806:11c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 20:18:34 +0000
Received: from SA3PR11MB819107.namprd11.prod.outlook.com
 ([fe80::e8cf:3b9e:d98:ee2]) by SA3PR11MB819107.namprd11.prod.outlook.com
 ([fe80::e8cf:3b9e:d98:ee2%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 20:18:34 +0000
Message-ID: <cd394662-51ba-4f12-940f-f861bcda52ad@intel.com>
Date: Wed, 18 Nov 2026 12:18:31 -0800
User-Agent: Mozilla Thunderbird
From: "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH] x86/fpu: Fix PKRU state saving for coredump
To: <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <christina.joos@intel.com>,
	<stephan.rohr@intel.com>, <stable@vger.kernel.org>
References: <20261015210545.48208-1-chang.seok.bae@intel.com>
Content-Language: en-US
In-Reply-To: <20261015210545.48208-1-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0090.namprd03.prod.outlook.com
 (2603:10b6:a03:331::35) To SA3PR11MB819107.namprd11.prod.outlook.com
 (2603:10b6:806:518::11)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB819107:EE_|SA2PR11MB5098:EE_
X-MS-Office365-Filtering-Correlation-Id: 30d4307d-4e33-41da-1722-08df45b11ede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|56012099006|11063799006|261022075727099003|261021121427099003|261102123227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: NHmKSnz8ZnuU165IhiGQbgas9LkI/WA48q0TH0Q6n2VRwHkg9hyAxtatRbiLn5I40Rnfa64pS+CLuN8TXxABoA3rHwYHjBiAvPGV0tvNmwt8+mUsxSFront2PoP6r0TiEvW6YK6B3NZ7su0YuvSV+VaTosAlsV83utWaHhJMGzALpzIx9lfxljITF7eP+Xg1mi7aOPPlzjtK69fHuI26RUQlKhMbeEOAcylMGVT8swl7WhWvElGN7SlV2W37fj3ipix749uAqk4OYgkpBe/LhSuRu1i0rZUYUcO3Vbqzo26r8LoX6Pq3nCI+EfLobM2zsyLCSDDOfo4Yz+SWAYdBYkTw6+fcpLjew4Nyp0BsAizNg/PWwUvVFxYTP2Gzstse3v4WNYrm21PDX4NGbJb4Ff9B0SIfJmXjV7JwblX7mQ+3hyQunFKR/eZthhNQ1T8P7dH42jYKO9RE/v5/BIRrl/vz6i8+aVG4yWft0maVOmv/5NougxJre1pZNG0ocQM7JZ1WEjtDpuHi/ZM30BbXzBdubpQEp9SF4Lwdh4Km0v8fU4VheblxaOFykJAvJtrKETYB7puf6+WUs63fIN6d2dS3J0ubsaOYUCzm6JMatgngu6S0OphYigb/hIDSw8AU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB819107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(261022075727099003)(261021121427099003)(261102123227099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUFyYWxuRGNIdjIzUzdIbWN0SzJzRzJqeWh3UmRGblJFVkgrMno2RlpKZXFG?=
 =?utf-8?B?Z1o0STZDQWVVMjNiVUhkZUJWVy9VUWZESmx6c05WNXp2a3NFVnlTTmdobHNQ?=
 =?utf-8?B?cSt3VXU3Tjg1M1hQMkQ2Rll5QWhpNFBMMGtCOXpsL3p5ZXR4MjJlNFkzaWFq?=
 =?utf-8?B?NWZrNllrTUQ0d1VPdnRPWTRDUEpXRlk1MEJLaThKNEpMSDBWZ3MzSTVsVVRi?=
 =?utf-8?B?cUdhUW9LNjJVT3hQRzFzTE4rbzU0KzJHU1IwMFRNZ0VUL0VySXFPb3FCQWIw?=
 =?utf-8?B?d05RZ1BkV1BNRjFzdGkwdEdMZWVwNVpPMUhLQm9oSU9OS2ZyYlAwVUJjU1g2?=
 =?utf-8?B?L2RLUmR5SnNGMFJGZVhvSndIRkxTdkZJcXZXbHQxWWdXblBKazVqY29ibXdV?=
 =?utf-8?B?U3dxWHNZQkZsZHYvaCtrTWRVS2RwR1lNcXd3ZGF0aTgvQTh3WExrNVNOMnEr?=
 =?utf-8?B?Nnd3amRpWDhNTEVhQzFOVDc4U1E0Mk9xdlRuSUF6VHd1bzY0Y1h2UkgvSi9T?=
 =?utf-8?B?YkFTRWtXTWkxWW8xeGpYWnpJQkdGRHp1ODU0MGpXN0N4S2lOcnd5V2tNa0NM?=
 =?utf-8?B?dU9uS0pmbmh3TVVWZkQrQlA5TElsaDJGdENGaGpncEJJL1hQS2NWeE9wc3ZI?=
 =?utf-8?B?V1ozSVZhN0UwN0Iza3BLcTRCQUhabjQxSUwrcm5TcDE2cDBzZnRxem1tdDZ2?=
 =?utf-8?B?OXV1RXFXL2FRbmtRY0c4bG90YW9YV2dQUzZ3dHBzcDVjalpPUm9FcENzMWpz?=
 =?utf-8?B?QlcrZGpzM1drL0NiSTdidGROeFdOOHNKUkJXQ3g1MW8zS29yMk5oQ0NCTW5S?=
 =?utf-8?B?SUtDYUwydTA3VG5EaUFaa0hPM2pIYVlnckdSdldDVlFrb0FOS1VJVnhlNW5S?=
 =?utf-8?B?Znp0bmEwdlZBcStKYTB2T0wxTlFCYzIrOG5IeHpER3FiWHVrcThIRmR3TzFa?=
 =?utf-8?B?dnMrclBhL1djUzAxbWNmRm04b1VKaXFnVlNKeVVkYVhsMm9iRjU0SEQwR1I2?=
 =?utf-8?B?aldqUWF5TEZXcUF6UFNuU2oxTEg4ZkZOcDJpVTZBNzRJZDZpZC91VEI3eTZX?=
 =?utf-8?B?VDhLNk1tOHZzNzR3YXdSNzhuWStPZVc5djdZNktCeDdPOFlMU1RHOGdjVi81?=
 =?utf-8?B?c09kV3ZQWkVydjJQUWtmRzF1enRjTlVITENLVEc5cVB6TUFrRkVXRFJuVnJG?=
 =?utf-8?B?S3ZzZkpObkNaVWNhSXpnbG1aT1BwU04rcTFGMmxxcGw5YVRJbEEydHhGbEw3?=
 =?utf-8?B?MkNSemJWTUszWWllaVB0cGtCT2lVOFNwQjFQR3psbjBXT0FLbGpoT2xILzND?=
 =?utf-8?B?MVZvYmQ0K1I4WWd2ZjA0V2w3Ykh5czdKQ1U3L2NmK1A0dTZUYmxTVXhkQVl5?=
 =?utf-8?B?NkdJaE93WFQ2dTB0TlZSSjJ6NUc1a3EzNVgwVm1kVXJSbGR4cmRDbnFBOExy?=
 =?utf-8?B?eTJ1c09ERFJ4YU5PbzVlR2RCMWlJMjdDRlFkalAzcVN1dzlNdGh4ZmZBRFFS?=
 =?utf-8?B?aFhmNk5tazgwMUgzVk9aYWkxcTNESHc0czg5cUdKSCt3OStxc094YmVsT1RZ?=
 =?utf-8?B?Z1BGRTM2L1RVdVRIZERDWEtkSklBUHBrTTBjOWxSZmhkOHNGcXpQaDhMcUo2?=
 =?utf-8?B?OHA2YmRQSW5nOGxVSGVhRmpZM0pCR2FaZFpMMWxJYkg0NHZZbEdUT1ZJRjBx?=
 =?utf-8?B?RWJRVzlpa3NsaXRkY0ZFMDlRZzZwaTExZVZQK2t6bDg2SERqSGtRK3B1anpX?=
 =?utf-8?B?aG9WK0NjZ3dxZUlwaVBhbWdHYmYxekV4WTFselVSbE1sMEJFRE5ZWTZQaG9t?=
 =?utf-8?B?Vko0cHhRVW9MM05QMDlZb0NHWFczYTBtRko3TXBIUlhkM2lYNDVpSDA5VUhz?=
 =?utf-8?B?cFRrSThhV283WkpQQ0RBdTZ2Slp5RGF3TUtnVk1PekZrblN3N29CUTZZeldH?=
 =?utf-8?B?SkUzaXlRdGFYNnd4RzJxcFA0aGxUYy85S21GRVdRTDlaQ1VFWm03L1pmeXNw?=
 =?utf-8?B?SE9HOGRwb1NiY3ZxRkhkSXhsVWtyNlVNVEt2b2wrWGYybmk1S2ZjQzVxNGVV?=
 =?utf-8?B?eWFVK1VZSGtYYWhEcTBPN3JWVnJLUGpPdSt3Q0c3R3ZXQVF0MzROTUtuNTFv?=
 =?utf-8?B?Q0F1RVFUY2dkdjZ4eFpKZ2JUNjdHRXI3SEVHMS9jUjd2cWlScHZ0NVo1UXNk?=
 =?utf-8?B?VXU4K29mTGtsaDhPc01qQ20wTysvK281My9XQW8yYUhxd2RCbzhOK2E5ZS8x?=
 =?utf-8?B?T3FhZXNYN0IrY3hPTCs5a1pvUUJ2VmdqSTJpREd3VE1WOGl4VDg0UVhkWnJu?=
 =?utf-8?B?ZVgxRUoxUitvUmpTdDYzTmFCd0p5aUo5RUduMWtmd1k0RnVtS1FEdz09?=
X-Exchange-RoutingPolicyChecked: 3tyNgrh64H+tKMR+f2C3r6CS7qyuDlCEkUDuoISfREYocE6V7SMbn/YuOzUYAhnWOQNodf+O8qgfC2KocrRiv4r6ljsCKiTBI/l4Cbj8at/W+2MB+8BE3guiHQhZIxd0FEt/s3/4wKPnzGRzk87t3241gSv5qf8o5rLOPodVdgOsioNBKbB2aN2ibZtbs3uNDNWLbazE+ai5DzBa2qQtX3O6guDkqQlGZnIaGiC6YoFC0b8rCcA6x6el7sNMfy52Jul5VxcJvJ58TvJH2s3zsAPSUUn+Zr5Qdo0rLayRjnwPkMGIXOhkwdhEOUYdVTGj+Ejh7SreuMz3YFm0fMgFjg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d4307d-4e33-41da-1722-08df45b11ede
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB819107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 20:18:34.1021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3V3ArwjwDhuT1PW9EUK2FFNGeqrkeTTerTnLmWa1CN+Wy/0Qfm/zZiiH4bHIg0YUZ7rVBtGfhUXB+DzaCHGMGBfDnZgJBhlf0NfV9G8RmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5098
X-OriginatorOrg: intel.com

On 10/15/2026 2:05 PM, Chang S. Bae wrote:
> 
> The existing ptrace selftests cover most of this path but not completely,
> e.g. not checking back from a corefile. So it may worth adding coredump
> tests for XSTATEs in general. I'd follow up on this separately.

Here is, and there the test for the fix as well:
https://lore.kernel.org/20261110031603.698635-6-chang.seok.bae@intel.com

Thanks,
Chang
