Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286114BFE7F
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 10:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789555631; cv=fail; b=fK+JlKOWvgjhbi/63G6gP9cK8n8JhRRAp+2BHN0bbPvXW4Wr6Abhmcsk7a8WDPksOJoX6DCpUSdiZdCzrEHbn+MpXZiM4U2Z8VCOdPnHPjtq275OGrqcSjyytNsjFuXhsiOV+KdyhylGwq2LxaHRwwmx4xttLuTRdG3xWI6LtAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789555631; c=relaxed/simple;
	bh=JdmCA7Xutelk6xxzJJ1g54OSkNPHCABKUDzFGr+L9dg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I+W/v8qzQIv9NzGm0dj/DRhhvFLWldHiScW0VdKEx2mmebIoKX8mn8DCqmJH9U6cJfyco9UFT2IhGje+yQwmLXPA/qDTgOddUUSV1UEIApfUlYoz83CGAGACj4lugQY2YBZwA7Jx+QOpc2qG0TCATAogoupFtctG2T+o57BfJN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dy6juJ/B; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dy6juJ/B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789555615; x=1821091615;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JdmCA7Xutelk6xxzJJ1g54OSkNPHCABKUDzFGr+L9dg=;
  b=dy6juJ/BH3g+8jZ32yhidAi6AympC9uZi+0PIF4yLL951Qsnz4EOMFjH
   KeY6Y0h+eLRKJAO0wp2TnRha1X18XtvV6KIIwwwwYln5sknJkp66DrNKB
   ihSskpHLc4VDFGlMv1gUdXFdUmQzE31JbQIyGAfCzehEXs/7m5QfAkJjf
   KeMikPE2mKSVFgkRohoh301AGesSZ/P3eEAmPuaExFvnn2mfp5AscnnRH
   N9NIEuMaTekMEK1CZcMSVAtqhHHM5Zw7P2S1lOtCe0iYr4bMajJcuKT+J
   qfs/Mb0d5ApoGFdRS0mu+tLozfqUO0pmv9Wl1u1IQPB1xCVoicW80YfYk
   A==;
X-CSE-ConnectionGUID: hMtK/5qVTeOjAQcXVEm+xQ==
X-CSE-MsgGUID: dZzSff82RKuWXUNjT2VpoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89772097"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89772097"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 03:46:50 -0700
X-CSE-ConnectionGUID: fi8TroP0TKWKWl18DFazBw==
X-CSE-MsgGUID: ndXUh1nCRACWqittC3eZkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="273847424"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 03:46:50 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 03:46:49 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 16 Sep 2026 03:46:49 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.68) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 03:46:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDoxiA0ucTSeN0XlQrqsiburcZPKdlDeFDQvZ8k3sFzbAZPsPXieCwWH/jdHexZGUlO3x54DRpMmgW9RNS8c3pnyp/Q3HsY3Bh6k4nNibwgoOZLYtVY9cg99A95cJoHvPmpOYZu30xFsDJtJnu0xn6JkU4M5R1jK4AWemJ8jCz732PvSWr5zmUuy+ADZtVg97D+CkRcUw70cTyR2eLPnookShXINW/4f2Tkf6rdS4wefWtvd3PEa4+2G82/gKjZYjKROzfsbEs4DXN0gdL+EU99l4HcaJhSwYObDrRwlO7A3kT6u/WrRBU+oIXTT9JIcBmoT7LnkKjk7UH1Kup6Q6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RsrWCP2q5bvGBnrdTc3PAuFfpp/8UxHfqmEM8m+C9k=;
 b=acZmkRKhxw30RIGe4ggCjGuZ8P8Ciuol+R9cpqVxdh9P+qmJc05mOJ+8pKk0WB4/4zgbkbFskRHqL9lZ7RoInFsKxXiDUPWqCMfA+G1rq1uE9k8nGtk1xgIr9zD8TuPs/f/7lzVyEVRQhfDEYw6/MmNparYz0tRDoSKiqGY2EZTzSKD6o8yZan+FwbtOaFG8/VsS7EIwaFfT6zXC4UVDMLPv6iYo+lOqfTikISxH+3oybhSrasN/+5DxscuogKP2F7aJs7qOEsEv9TLPan0PlSQeLDFVGm41MG4uAEFrH8hrdaFAcY4DS4qfxoGNqRyCUGqIgtZtcPezOS+tZ1wJ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB148960.namprd11.prod.outlook.com
 (2603:10b6:408:40f::21) by LV3PR11MB8530.namprd11.prod.outlook.com
 (2603:10b6:408:1b8::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 10:46:46 +0000
Received: from LV2PR11MB148960.namprd11.prod.outlook.com
 ([fe80::9761:b20d:6f27:5460]) by LV2PR11MB148960.namprd11.prod.outlook.com
 ([fe80::9761:b20d:6f27:5460%5]) with mapi id 15.21.0406.012; Wed, 16 Sep 2026
 10:46:46 +0000
Message-ID: <c84784c0-0be7-4114-bf41-c668b12fbe46@intel.com>
Date: Wed, 16 Sep 2026 16:16:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915/quirks: Limit eDP rate to HBR2 on HP Pavilion
 Plus 14-ew1
To: "Garg, Nemesa" <nemesa.garg@intel.com>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>
CC: "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
	"ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>,
	"annoycc@gmail.com" <annoycc@gmail.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
References: <20260907034555.2753846-1-ankit.k.nautiyal@intel.com>
 <MW4PR11MB6887DEBC313E13C43433B0BAE3B22@MW4PR11MB6887.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>
In-Reply-To: <MW4PR11MB6887DEBC313E13C43433B0BAE3B22@MW4PR11MB6887.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::14) To LV2PR11MB148960.namprd11.prod.outlook.com
 (2603:10b6:408:40f::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR11MB148960:EE_|LV3PR11MB8530:EE_
X-MS-Office365-Filtering-Correlation-Id: 30c7a560-4c09-4849-32eb-08df13dfcd96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|3023799007|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: P/0rIT5MFiS97jQuNC2yBkjmb3y9GOoxrG9KGvwAA0ys9WROAE9XirA9uBxw3vABcznjM7DJ9DLRPskBkU/KhXo8KVysn3BYm8FZ5/kt6JsIFl2+6mNtpc79ud06YNlHVBgdb/EJLBhxQA8Ek5t7dv0u0OfCEJpkcgDemzWj+VfM6Nu7C4oEutxD3cn1g0PM9sbikkVJWH1+3QoI6bZsNGb8A39ADidY/6LXlAhOj0RMQ96+DEkc/boG/7EsA9l3DfwiV9wPbis83e/uVDJ9io0wGlD+HYT1OTw6lVB+qTjOuWGK0vOtPRSvRaVm09x828OYw/6k80o+VFMKYm+6foqRvOwsmZaJOSiskM6xt+K2Ujg6PmgG7IJ5zx+HKHeSfhjQWI5IxdN7oRHhdx7GPjWIMZ6JZSrfOOuUHLzq1dCsy/OpBmBbPlu2CGVxl9AW/VkhC1VOzVAT6jhgGTowdRm1OGGmT4vUKUaHx4PfcN6VrDnb4lOw7+jXQFTz4dWZOSy/U+vFmNImjD08JOelGdO4otrg2mr2BZWskTPZWkFqqWwsfFFnGDADhuuKea2+YmReYmNDPWtoX8WzPh0+LInBO3y5lkwQ86zNL9MdnxGzm702wfZHJz3AQrACBy6i
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB148960.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(3023799007)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjVLQ0U1azJSOU91UVB4RXdrRW9XeGpnM1hheFdJTDJsaW51TXRhOFpoNFZ0?=
 =?utf-8?B?YVdsaTJLM3NSUUZaK2kyM2J3RDR0T3FxMCtvcFkrU2dLOWRBb0dYdnB1UGpj?=
 =?utf-8?B?NEgzMGtVZnArVkJIVVM4ckRyajBZVGpsaHNFOTVQS1A5VjFjODZPb2RyL3g2?=
 =?utf-8?B?N0xhREl5VmpsS0Y4YUpTQXNyalJLdWRpZ3BkRVBOYU12TFBXOTkwR3hLY3Vw?=
 =?utf-8?B?a0VXSDZSVUR6M01BZ3IxcUJDQVNQVVR2WnBRV3d0UWplQXR6bjI1SytzSnZ3?=
 =?utf-8?B?TU95MkJxSUlQNHE3cXJDMEhtSTVjSTBKSkNHbzRqcENnTTRMSTZEazJSYTZC?=
 =?utf-8?B?OTJRTnFpelpzbXdRc09GNitxRERtRXJ4YVM2Rmh5RHNzS0x6TEFuMkl6VFo1?=
 =?utf-8?B?Y0JXL1MyUG14QktzYkk3djJlZmZJdkhOb2JTSzNIQWFlNm5PSmh2ek1PNEl2?=
 =?utf-8?B?V3BTV2h4Q2pIeXdiTVR1ang4RkxDaHE0OFU2VkQxc1h1eFQvWUhtWEVZSVVx?=
 =?utf-8?B?aGs3ZUZYQkhTOEQ3RStyZlI3T0MvK0ZLakRHMW1mVitjL0JsYTVhRFEvQVhW?=
 =?utf-8?B?RzVnT095Zkw1MUV4NlBQSG5yanRIajFBNFU4RGFTSndML0JLcHNORi8rbmth?=
 =?utf-8?B?YXV2SU93T3JBZGkxNmJsM1JYMStoYWJzYko5anpMbFNHejhva2FkekFoMXN3?=
 =?utf-8?B?T1A4ZVhJNEZLUXkwbm1JdjlZN1VIL2RxL2t1eTg5L3lmQzlOTGJCVXVaYklh?=
 =?utf-8?B?S0FKUDlyK0xaeWdlNTBWS0xLaHdRaEdXMzd4eE40alJsWHBPcmFobkg5dHNI?=
 =?utf-8?B?TWtRdTlSUklMNVp2Vy9YNFZZYkY4UGJqZFBoelhxUFF0OVBjeVUxN0JpaWxs?=
 =?utf-8?B?YmxMOWw1Ukd2N05hUUl3RVZadk9Ra2lCK2w5VC9KdWNlY0FQUWs2czlUaWpH?=
 =?utf-8?B?U2NhM2JDak9ZbExRTkpVRlBPTzlxalZ3cmowa0czQjNIZGt1MmRRaW11SW1E?=
 =?utf-8?B?UFpMaXlqTDE1cFlaVUtMSGZ3bVNaQzd4VnZaRWlRL0tTK0tjelFvK2JOVGsv?=
 =?utf-8?B?R0RnWmlSNThuVm4yTnRsbEVSejdkYUdaRExGUGZKaklpU2x5cDFMelpqNWVZ?=
 =?utf-8?B?MTZmY3NYT1dtZFFaSjh1c3BTcHp1SUhGUUhrMEZ1QlphZHZtQ1BrZld6cFJP?=
 =?utf-8?B?V2VPVEp0VHJQNWQ1bWx0d2RXZTFiRnlGdkMwZXUrQ0N0WWs2Nlp3RzlLNUNv?=
 =?utf-8?B?bzRuSzUzdWk5ZVhqd1dPVzh3SjU1bjFQR09oeVhkY2I1QTFpT2tyZXFYNkl4?=
 =?utf-8?B?cHdMU1g5MEFBNW1UZFE3dDA5UkttSW5aaS9lYmEwMXRMTkZQdEs3TDFpbWdK?=
 =?utf-8?B?NFNlRlc5RkgvekFLYkx4U2M1ZXZqaHhOTlNSMXE1M0ZpNFROODhHaDA4dEs3?=
 =?utf-8?B?NkltSXFkeVQwVGhnUHQzWmdMUmZQTTVBRFFpNzlLbXZ5YjdPbWlzcUwrMDlV?=
 =?utf-8?B?MS9aOE4rRUZrbWwySG1RRVhuNmhwclBKL085eGZJdHozUVpyZHh4dHQ2cldQ?=
 =?utf-8?B?dlJUUmh4V1REQVBEMG1HT1NzYlgzOGNHam5YZVBMZVFkVnNEV0RFMS9HaEg0?=
 =?utf-8?B?clRJdmhNUlZhSThNdlEvQVVKeTBub1pQUnN4cEdYRlZpcEVNTkRXOXQwNjlI?=
 =?utf-8?B?QlZTblZiTFpBVGpDZmRQTHRZMldKM05vbEszdG9adUpzN1VwOUlLZXJTbmcz?=
 =?utf-8?B?Z093ZmVPWE93RnFwV3N6ZW9URjdxcDlRT1BxbnRCZnVxcFlHcGt2TGJBTWlI?=
 =?utf-8?B?ZVhLbWV1S05QTUlEVk5nM1BBRnJHNnFPb2F6elFQT21kNlUxTkNxVDlUQWh6?=
 =?utf-8?B?ZXhlQjJzUTFnZTNwLzR2NFNhYXdaT1d1dE4wS1l6bW9PM2ZWakhLZUNlejB3?=
 =?utf-8?B?MTFQc2JjVmIrVldmNVphRDFrT1NwNDZuRVh0d1hDTkc4SVZ5eGtsdHpGS1hj?=
 =?utf-8?B?eHVSYTRqQnA3dit3WFlTRk40YkpCc282cnpIY2NoZENhWE9tTUl5em1RMzhu?=
 =?utf-8?B?V3Npb1FNVFZjQnFJc1NieWhYamJuRFpkcmtkSnVUbmxJZUphTlcxU1FpSjZ6?=
 =?utf-8?B?QnF1VldUV3lYZmc4eXRoSERITE5HeTRIbWFNRFpPeUJlbHVHVWVJL0FyYUR6?=
 =?utf-8?B?MmNLZWZEYUVIbW8zOWZPRDlZWXRRdWJ4Wmk1djNGNXRFN1QwWVhxcGJCSGc2?=
 =?utf-8?B?VjVFbGYrcDhWQnMzNzNlRlZtWUZESG5wNGI2RGxGWTZ3NzlLOFc1dkFrOE1n?=
 =?utf-8?B?SHdLdjhnWllMM25VQkRETjhTNnA2c1k1T0hIZWZZa1VZZGo2cUtBcHV0cTZP?=
 =?utf-8?Q?uvIxEMJcz/G/FgGs=3D?=
X-Exchange-RoutingPolicyChecked: cdZnBoqMHEUNPx/QWfQZ6bSTXQk7n9GgbRQicCNbowKSSJR63witBCLi0yxhLkdDfDK8R/0+FXf+wAPUiyVBZYl9xF3KSYeKnJ+4Nz8COtFMSv/2we8btAz7cpjr2fzOWZPQWxzYUap/yvggkUrqFf3lXqJKTSzMSJ986FR8Rr5FXvzht5upvoXgYQOqsOPzNo4G8iyY8TN0GEuw87Uqu3fvuuwKde/6yE1J6rSHNLNPKLOdrYKT+E/ZzWQZs5442gD4TQ0+wYU0FXjY8NASsY0UQnE4Yg2UyxJxwt3/3fAPLp52E6M4w8I6s1R5x+kEkFhhEsf54Sf36EsuGtIMmQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c7a560-4c09-4849-32eb-08df13dfcd96
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB148960.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 10:46:46.0688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vdTppXHT4ywxM95SqDO1h6Its2uN2982eS+1eTdRHvj2iDJP8BvnoTspmf0DjlndrZ/jh18tg24nXJSErBqIT7VeQDWyY+x9IvkD6EQs1Dw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8530
X-OriginatorOrg: intel.com


On 9/7/2026 10:46 AM, Garg, Nemesa wrote:
>
>> -----Original Message-----
>> From: Intel-gfx <intel-gfx-bounces@lists.freedesktop.org> On Behalf Of Ankit
>> Nautiyal
>> Sent: Monday, September 7, 2026 9:16 AM
>> To: intel-gfx@lists.freedesktop.org; intel-xe@lists.freedesktop.org
>> Cc: jani.nikula@linux.intel.com; ville.syrjala@linux.intel.com;
>> annoycc@gmail.com; Nautiyal, Ankit K <ankit.k.nautiyal@intel.com>;
>> stable@vger.kernel.org
>> Subject: [PATCH] drm/i915/quirks: Limit eDP rate to HBR2 on HP Pavilion Plus
>> 14-ew1
>>
>> The eDP panel on the HP Pavilion Plus Laptop 14-ew1xxx advertises HBR3
>> while leaving the TPS4 support bit clear. The output however flickers, once
>> link is trained with HBR3.
>>
>> Until commit 8c9006283e4b ("Revert "drm/i915/dp: Reject HBR3 when sink
>> doesn't support TPS4"") such sinks were capped at HBR2 by the TPS4 check
>> which incidentally kept this panel stable. That check was reverted because
>> other panels legitimately need HBR3 without advertising TPS4, and the per-
>> machine QUIRK_EDP_LIMIT_RATE_HBR2 was introduced to handle the
>> affected machines instead.
>>
>> Add the machine to the list of devices that need the
>> QUIRK_EDP_LIMIT_RATE_HBR2.
>>
>> Fixes: 8c9006283e4b ("Revert "drm/i915/dp: Reject HBR3 when sink doesn't
>> support TPS4"")
>> Reported-by: Annoy Cc <annoycc@gmail.com>
>> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16743
>> Cc: <stable@vger.kernel.org> # v6.18+
>> Tested-by: Annoy Cc <annoycc@gmail.com>
>> Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
>> ---
>>   drivers/gpu/drm/i915/display/intel_quirks.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c
>> b/drivers/gpu/drm/i915/display/intel_quirks.c
>> index 33245f44c0d5..7d7db774d8c7 100644
>> --- a/drivers/gpu/drm/i915/display/intel_quirks.c
>> +++ b/drivers/gpu/drm/i915/display/intel_quirks.c
>> @@ -257,6 +257,9 @@ static struct intel_quirk intel_quirks[] = {
>>   	/* Dell XPS 13 7390 2-in-1 */
>>   	{ 0x8a52, 0x1028, 0x08b0, quirk_edp_limit_rate_hbr2 },
>>
>> +	/* HP Pavilion Plus Laptop 14-ew1xxx */
>> +	{ 0x7d55, 0x103c, 0x8c31, quirk_edp_limit_rate_hbr2 },
>> +
> LGTM,
> Reviewed-by: Nemesa Garg <nemesa.garg@intel.com>


Thanks Nemesa for the review, pushed to drm-intel-next.


Regards,

Ankit

>
>>   	/* Xiaomi Book Pro 14 2026 */
>>   	{ 0xb081, 0x1d72, 0x2424, quirk_disable_psr2 },  };
>> --
>> 2.50.1
