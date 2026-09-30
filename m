Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E02E3BD24A;
	Wed, 30 Sep 2026 06:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751075; cv=fail; b=mD70S81eYb9NDE/E4/zHtgezPe5JhRs+ccSQpzSmSUnKT8PzdH1i861avcQTVgN4xIxzI+2tpj+7IjKHNFwhvXRMalNsaUfSMmLIy1ntwDokquqHxcsdsmLZq3XUy0d5nCGwfuJy8d841QpIaCJzoDm1A9c3BgiceTINWvB0ENw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751075; c=relaxed/simple;
	bh=C8dxjJr7oe7O2LxRT7oRP3KPItvYQGzCtOLVWQiTjnI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TUMQHXCpwpLqAmpufjh5Ck2e9s1kWiOPIkaj4QvrXdV05DFHXcq64oPlkZiMZZSQSFwXHAFVUwcO0gqC8DzTU/CvWs7youWqVy2dZBWyQWe3axLujZ9AKIJjq8tV+NKK1kNmt59BAjkU/ScVcVjhDisLqD8lftVgfltj8q2IW4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MMht/9Qz; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MMht/9Qz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790751069; x=1822287069;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C8dxjJr7oe7O2LxRT7oRP3KPItvYQGzCtOLVWQiTjnI=;
  b=MMht/9Qz3HbJCISvPjlQHFcgOHU1x8Yl9QQGP6tTtB7n+VSxnRPhZ0Ue
   AVzX7HAzLfzRnr5gVi0IqQMXHfEfxswEbGjzQ+Qmt3ZhyubBmDALAdgZ4
   9j09QKBn0aITATPyeO5vxapeq8a/NNPqcFKZnsuW2mIL/wHRwEFQ8r5bK
   vkWkeag1gkXA904vxLBknri7OSmDsOsTy83XjT7jJE2HUubekcN/0RR+1
   0IDU/rfc/t56FdPaj2My6JJOzcrptI+7FVuMiUglf1CqL/8eGpzyf+Otc
   TRlEPOs/83okosvXz2tTouwFDAnC8/UCVLKAdGz4THbVDvlmylmWpYlzH
   w==;
X-CSE-ConnectionGUID: gfxcbiKXRnq3FmP/7ECvbQ==
X-CSE-MsgGUID: RU/yovyeQvqA5W0oYx25kQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90245886"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="90245886"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 23:51:05 -0700
X-CSE-ConnectionGUID: i8SQXmO0SW2U7Wx3xL+Z6Q==
X-CSE-MsgGUID: edBcROdzRMq7JfXcTJlI5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="278948870"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 23:51:05 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 29 Sep 2026 23:51:04 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 29 Sep 2026 23:51:04 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.65) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 23:51:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YfHimMBolqQO55AEhpIdGAuaXYQM40PAMpKrVbv7jqK5CblRS+k4nZHa1mtNpjZjFraV+4vFO2+QDdrJ0oE/RRSK2AYJPF7yoNxn7yK1WHrkkk61+jNPModG1Y4Shc2ZzSh3C1Ep/Q4uqQ32vJWSV0EqUbJpI+SI09Ntn4NDH3ZlbgJoJ7Q7VarVFkpf3+YF94h37aBn7B9VhmS9yT9PeD4KF1zAaIwUGI9hol18myCr2EkVpf9awEcf/hQexXEo2j6bIhw9rRUlNHFOUpMIqzbbp9Op+gxF6WPTwNZmflooKBZ4wfJTrb78p8bmF1PJK2jTFGFNN0eqVs0DIaVzJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mVm29waTdS8Kzx5T//OCdDMQh4unFu63KZTNL6rbl0=;
 b=NQsYuxKRNPAEtWvYFBLRButrkzIlHSKxATfHzHapIpA4CU4uxJadPkf+RfkX+Q8msUbYEwSTa7ZH1BFae/m5w5Ieb/mmGkPeA40ZBNgA65I3Sso4Aszg4G2AoY4rwa2damDr7u7mhohCXPTO7CMA11y9D0hD3orXoDVqM+Rh5LKj75avUwdwrtEg5rQ11WKMqFT3hUNZ90UjPve0MSm95Xkx/Dc0gW9Up958wmPJ3P4njzIkGqaEf013dmVg1/RJKrg0X3EeHEaUbzlkjPPQmUsGTFeXl2Sk7U53A9LhpXPD3FJZFmotDh8so/vQKSxo5ptN871VAuRQXIcn+bq44A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 DS0PR11MB7557.namprd11.prod.outlook.com (2603:10b6:8:14d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.26; Wed, 30 Sep 2026 06:50:56 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%7]) with mapi id 15.21.0451.026; Wed, 30 Sep 2026
 06:50:55 +0000
Message-ID: <e3cba491-9fdb-4907-9843-c427c96c3237@intel.com>
Date: Tue, 29 Sep 2026 23:50:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fpu: Free dynamic fpstate on exec()
To: Guixiong Wei <weiguixiong@bytedance.com>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H
 . Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20260929151013.81562-2-weiguixiong@bytedance.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20260929151013.81562-2-weiguixiong@bytedance.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0143.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::28) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|DS0PR11MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: d91a2c5e-6605-4398-f591-08df1ebf2cca
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|5023799004|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: TsIUvJrXRXQ4V33+D5rntLPzGbwGEfEKLzBqmZYb7f5tzilnj9lz/uySSqRNhUXMitfaS7o6tb3JAv4rND2/clzq5boSovu3LJKvt0ViYqNCMZvLaw8KYFPkDX1/3WUc1Ng8VapI3ruyuDetmYFjdh0c7qOFEpt9hDnK/1zilwMjOeyD20TKdINHzN7sRqBpqnJEYB+YnnEMiOV/fGUfiRlh4RTRyhR7/rihAE1kSEastKf9Hbr052kb6i36lSR2arEAglBgTvDiG0sXb6DUe2gfvhJknqj2E/rK5d/Yz5H5X29KutC1dCa1hL4q/JVXWoGpTSWcKoP5dGkWq2FH+OuHq5hv4rDtNgTNBabHEXK9fD0KBt6kXOpGOxspRgqzp8WMXvVch9ypqVJda9iYb9/20qWZRVERzIdkZVuO6W3Wx9EIPWTXAJ4L9PIwrg2XfGnIM+Lbz9hERJm8X5IX+F/9rG+J9GRXyEcznbiqUSYMzhN20kD7nm2UPI9HuxfCrAPDWTXAxhtqaUOBsuWKKkYsdiwMHB3D+La42c/JUdHfEesjrQWaWifurMjeogcAHythKjhfuI9Wrro6umcx2B4rnpMcryjwTaPApeCLiYgdiHh0BgdHq8gW/S8LevVKuYw4NJ+Lzmg1Ev8+fk+YJKLBT0Ea3IkPMlnqHyenlIs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(5023799004)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3lEbElXUnNMUHBPdUovUExHa21EZWR6d2g3cGM0ZWJpRDlWRXlEbE4xSU51?=
 =?utf-8?B?c1J0d2hQbE8yaWFPMDJPY04wRHo4SmJNaS8vbk5iMkZIdDQ2ZHJVd08vQWl5?=
 =?utf-8?B?alUyQ0FUUlVsU2pNNTRoSmNkWkJUSjJxUFpwOVE4WFR3UlFYQnZvdU1QaGgx?=
 =?utf-8?B?Y3h6TUpXNURpMVlsRzRIcFZmODZicWxHRC9OSCtYQUVySGlVdTYvNUZyRFNM?=
 =?utf-8?B?b0YwaWVwNUVmOWRzWDFNeHpNaUtYSzVmM0EvT0F3aTNyTFBvTVZzVTIzWmZS?=
 =?utf-8?B?Mm9Wd2tIWWR3cDBwOTVJQkF0bEpNUERLQ2QwSGFzVCtSVlhBQTU4bDFPaXlu?=
 =?utf-8?B?Yi9RbzY0eno2U29uV1ZDbWR2OXErUkdGUC9qRnhkWmRVVzcwNUx2dzVhaFVi?=
 =?utf-8?B?Sk0rR01ueDhZU01GNWtUL0xhVHo1WHpUMGtxK0R1RWw1WjFoeUZ6U0tXWkhv?=
 =?utf-8?B?bWxxS1NaN2dNVmFQTjl0TUhDRkJ3R2hnbHdkL2EvOWRMOFdNSUhMWlZmWUZB?=
 =?utf-8?B?eUYyZkNXcjU5QUFsZ1hSUStzTVFVM29xdXJERU5kdDRaV254ZTBXcDJpTjRv?=
 =?utf-8?B?UUdmWDBKdm9oUzNjL1JSTUVnZEpUWUE3ckxhVmF0VzZUWlQ0ZjBTa1A5a1Fh?=
 =?utf-8?B?aVlrWllrQmdvendSRG40ZjA5U2cxZndLVVZMcVl6dG82N3pPdW12YnhtbkVF?=
 =?utf-8?B?Z1IzZW0rODFrNnlxcWFmVGtlRm0yU1BPeVpYMFVOZVBHTVM3WGJMZGlrWUpa?=
 =?utf-8?B?bm1obGJHNTVPdTVObkhMaUFWQmNUNXhZbnh1Q1ZUU3AyZ2h0WUNIQitJZ0Vs?=
 =?utf-8?B?eXRFYkNsUUEvaXh6V3dEdjkwd0VDSUtUSnlxbDZVR1dOT3pGUmt1VGp4WERx?=
 =?utf-8?B?bzhxVVJvQ29CR0xaZDZCMWxVL01VOWJOWTdIVEVKYVZWcDJRNTNwZ2MzR2c0?=
 =?utf-8?B?cktoZHJvMnNMZ1p3ZjJFK2V6dnRQdHFCUndHM2xRWW9wMHU0MGpYUlpSMnNa?=
 =?utf-8?B?MDZ0WWxDSDVOUVhrK3RBdDBBRkJaNjdsWDRMSVlXdlNjZzBCdEV3bmlsbDhV?=
 =?utf-8?B?SWtzZ2w5Z29pbEVOYSsvclYrWVJ6UzkveC9UUG5kRXFoWTNaR3ZVdGZ6d2ZU?=
 =?utf-8?B?NnVhay9oQUpQazlLR0xVaXBuN1Jmb1lBTDRMSTN1RGNRWDBleFlVNmFxaEVm?=
 =?utf-8?B?UStZT0VZdFFyVXg2bzgzMjl0cG5ady9aQUFiYlZNYjlsSCtMZ0tYS1FidWF6?=
 =?utf-8?B?eGFRc2lVR2dQYklHMzNzT2IxbHJyaUUwNElTamlDb013K1A3RmtFaTNpcUI2?=
 =?utf-8?B?Zjl1eVg4amMrUDcraDlHRDE0VEc1bCt6M29LSHhxSnRId2JNSVp1UkpGRlV1?=
 =?utf-8?B?Y3k2ZkdFelp4RHpKd0E4ZFE5alpsWDgxekcxbmtOQjJTeXhQTkFQbXdVcHFS?=
 =?utf-8?B?SjBOcGhNcW5RWTFnbnVOd2VOeTBlVEk4cHJzRXNvdEdFNmN4RDdOMkRtRWVz?=
 =?utf-8?B?OWhJcnJaL0Z0cXZRQmwyZWYyY2k5TllxMjA2YmNBL1pQV0UyUFdRbDZsUzhQ?=
 =?utf-8?B?ZjhrZUhxSGJ0ZVNCVzZHazRCeTNuQWZmTTc5YklMYUhmWVpWTnV4cG9jaVpj?=
 =?utf-8?B?cy9rZCtUS09McU00cWhiYXEyR3VQNEVPSWpSWG4zU2pSN3NBRUpPQzUrWnor?=
 =?utf-8?B?S2pmNmNZb0RrMFk5WG1JbjZkUGlpaFZhbFVNblBzUUJGd0F0RkdBUVFpdTRY?=
 =?utf-8?B?WGhsdThUMlg3akgzRnMxU0xSRTRpQ2xSMG9aa0Y4VHg5eW00SlhKOWV4eC90?=
 =?utf-8?B?WUcrOXZab0NOZk52b1BRZit4L0V5WUZ3QXZ4RzYwcyswaHNONzhRdlVQK25D?=
 =?utf-8?B?MHd2bnNzeWh6UVZZajRBRk1KL3RJYWMyOEdkcVBJdFRidzBpRWVVU3ZLNWNz?=
 =?utf-8?B?UFc0bjZvYTN6ZXc5Y0pXSlljU0hrSklNUTBIODVYUG1ET3FrUmM2dk1PaWJZ?=
 =?utf-8?B?cURaVUsvdTFtdE5NdjBVMTVYTndKNHBPeVRqY3JlMmpaWXpCTXcwcXJIWWJo?=
 =?utf-8?B?dWhEczNpcHZNRUlOeDF2L1poL0IyYmlQSjhybjFRUlJGdkVRb0xhWm9HTXlm?=
 =?utf-8?B?RXQyUEorVkZLK3k2RjVuUVBDTzh2VWNkencreitZbGIyL1Fybk44U1dqVTFp?=
 =?utf-8?B?MmJheDdqaGMzU2VpbFhLdWhRbnNpUzFIRDl1RkM5ZGwxYklyUlI5cEhPaHBh?=
 =?utf-8?B?YnNhUElHeU01N09SVEI3ZjJXbk5TUm1sOW8rcTdaME0rR2R0dlB2NmVja3ox?=
 =?utf-8?B?Q2FsNjcydU5iTFExRHF2VWNIN0EwR21DVG8ycXNIOUJjMmFNald3QT09?=
X-Exchange-RoutingPolicyChecked: olijRAFXqnEBiiaiCD1SI+oa+PM6eQp7YRmuDIbw3LuTW2NNeJDcxsjbhReDjtROtB1CNVL6nub8lnE/S9LPcP/xXKMppJQCOAZ9nvCxBY5jh64LolKMyVGaba2mMaCNYySVh5k8vQQcTTgdOIcf87tmRPKBjhwcg6SiIn2XU+J6KFbTggIPHDL567rVn6m+pku1Cv7t5qtN9TEpY5BWjAPI6MitvWl5jpLJI7eRrFK7/Y2FClDeMse8cLaNwZhDVwtzap4+dnvoRsL9VrMHNGOnS76HWZyPX0kRx4C6q50qLeY8caEfhmR6l9QD+BiI1U0KAZVQIakOcJ/lcbySoQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d91a2c5e-6605-4398-f591-08df1ebf2cca
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 06:50:55.1446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XkmUzEeOpLZYY6oauTNCSHzO8MQijDyN/xpwsdxnqLr+O+HYkKeGakNG2TYBlKvKjTY5F/fcbmylfv6e1dl9VO8n8e92uCzOy0tC8A1t59g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7557
X-OriginatorOrg: intel.com

On 9/29/2026 8:10 AM, Guixiong Wei wrote:
> The fpstate embedded in struct fpu only accommodates the default
> xfeatures. When a task first uses a dynamically enabled xfeature,
> fpstate_realloc() installs a larger fpstate allocated with vzalloc().
> 
> fpu_flush_thread() resets fpu->fpstate to the embedded fpstate on exec()
> without freeing the dynamically allocated one. Once the pointer is
> overwritten, arch_release_task_struct() cannot free the allocation when
> the task exits.

Thanks for the finding and fixing this. I see Dave has given good 
suggestions. I think you can follow those into a revision.

...

> On an AMX-capable system, 1000 iterations of requesting XTILEDATA
> permission, executing TILEZERO and calling execve() on the same image
> left 1000 16 KiB allocations attributed to __xfd_enable_feature() in
> /proc/vmallocinfo. None remained after this change.

I would be interested in turning this into a selftest if possible. It 
would be great if you could.

Otherwise, I wrote a case (using XRSTOR instead) and then saw that 
amount from fpstate_relloac() in vmallocinfo:

   Caller/Module                            Difference
   ---------------------------------------------------
   fpstate_realloc.constprop.0 (pages=3)    +16384000
   ...

BTW, just curious if it happens with real-world applications. The 
permission is revoked on exec(), that is a very edge of the TMUL use if 
so. Is it a case running another application right after matrix 
multiplications?

Thanks,
Chang
