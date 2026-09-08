Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2426F492E55;
	Tue,  8 Sep 2026 23:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788908613; cv=fail; b=lPf6HdeJrhDrB9yPjpfNRg3x9SMvgERFqqkr0HRZMmwGlxjcxlI/55flRdvvAscZmZPSn0UJZCG+4vEyIwxD2I2UJLDvgNFC6su/u0roLPxtGTV+l6XXAoFGL36hyJhJYIWcS+t8Pmhm7vgYhdGNUXn44dmcnWIwIUXcd+b7CRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788908613; c=relaxed/simple;
	bh=9fc78rUmwLz0N5GD62pkwbWS4WtkNwykUc8tyMcwPXc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s31L31eKmElhKqzkZKbYhNaOVSSmLAdmkDfSqAQ9Cajp0yPVXcmPhk5Jn1P0i1qQox5r9cIQe5FEE6WOEJPVmZfHEc5uHOFwHGUi883IXf5ssOBnP+sFX20IumZifPUisjBEUhQEF3NYe5f6jOJMRcBqIb8rRcWK7g7bBR1r7Eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=muXkExU9; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="muXkExU9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788908613; x=1820444613;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9fc78rUmwLz0N5GD62pkwbWS4WtkNwykUc8tyMcwPXc=;
  b=muXkExU9sgXMieKJSPdofuj0ZRMS7qcqI4hQ951nRvwsHo4wAAYWaYlA
   FjV12qAyr1nLSsPWg+2RKERLBm2iV794cSaWYZKukSykxRhO/BI0pNlJK
   QxH1LyE2rRQ5dEdqPOaw3qJwHwSt/5IzR79Qzuu/SlPIAll/jXMee+q7b
   WAjdYPSqGzHzmFKxhESGKSojOhcVhPwWnl3U166z94qvl7Il5L7mOHu0D
   wAnhMRKxPkZRRdhLkVVmhP2LZm9n/1IoebT15Q/5f4AG+qMe7Kwp5ItuL
   C4kkMN/cdfgsW5RkEeqkfe+WH3nwIl7PIcz757IZ6TeFkOJDW7gq00gfz
   Q==;
X-CSE-ConnectionGUID: WlPOfeY4R4y43ZtdNixJ2A==
X-CSE-MsgGUID: xmIR9cS3RjCL5R3vS+q1yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="100484561"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="100484561"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 16:03:32 -0700
X-CSE-ConnectionGUID: 6Er9SWocR36HPv0mH/2RxQ==
X-CSE-MsgGUID: naYnH1NrSHm9GZYUsIpM8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="273091283"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 16:03:31 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 16:03:30 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 16:03:30 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.45) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 16:03:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgoHcnKZRD53f0fDdUo97+NoTLA5RPUKRbKPv7an8R79Si020WSkjLEiSRwFAqvQV7PFWxCtUi0xwSY+JAE0UZx5WUnlP0CGEkFC/LY1voduHpS6+5H+Mme3VdDxuW9z3iqblCsLacGnB2pzK9ITnIeWrF18cCnYufuenX61YSIFqM0mBoXysb870K59pQGL8/w1bqtUXMTdqYlpRoxLL5Dv3HfePbwkaHgmVeLFDGE0h5NbrDI72uWz8qwU7OcgTkr1ATg9HfGW7S/QZuFUptlm+w01mcXYPrD+Wg27PO5/s8YnnRMBt8cjrUEDv3BQdGEwyUcFVSPWWowKPuyDmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubSJenL/dwEokq39sQh7TiHAjG7SYOGzITp+5x6dngw=;
 b=RYoznZ5DjkDVVylQ355kvCHKSWH3VcqAecKM7e5urvURmWTZW+r8D2yaDuN9gjEK/5bYLfDhkENjByEqPFCXb+9ysuNmr/VsXKkTQ1a0bSzURFXhxVxOwqYJCVVGPrNdl91fW9/0hTfwvJBZaxfa/+KnEC9RSFWZHLYxLU8Y13zlAKkHBjg3iUWfC3E6KhzrSCM1eRz1YzzfdMq5D0SIqeuIfzsG9h+r9hGC/vwSMa2Oyelohi7QYzdHho3xUSIYaRzdqoIV+gkFxTs7/yTvW/TAOJsU6vWvaGYIWnlFuX6QgdnKU6SD7qTX+UGsbYmznVD5g1HfW2dPAoqbgQpERQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 PH7PR11MB8455.namprd11.prod.outlook.com (2603:10b6:510:30d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 23:03:26 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%7]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 23:03:26 +0000
Message-ID: <fdbe32b9-2de9-45d5-b3e7-ba031c3e6f00@intel.com>
Date: Tue, 8 Sep 2026 16:03:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] x86/microcode/intel: Reject problematic loading on
 GNR systems
To: Sohil Mehta <sohil.mehta@intel.com>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <andrew.cooper3@citrix.com>,
	<arjan.van.de.ven@intel.com>, <stable@vger.kernel.org>
References: <20260901231634.714144-1-chang.seok.bae@intel.com>
 <20260901231634.714144-2-chang.seok.bae@intel.com>
 <d035139c-6b37-46f3-baff-a27d0f1a082e@intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <d035139c-6b37-46f3-baff-a27d0f1a082e@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0094.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::9) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|PH7PR11MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe4ca05-49cc-4b0e-4938-08df0dfd63a3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: emRzV600QHOW/qu4z77O8plC0rI+YhKv6imkyqxCBnN8Kn312d/sxH2fUvJWtW6G9EvyQnXjf8uQSi7LWxaCHHkigI8cYcHiEA7Y8tCI54Ex/4r99vCgDu5GBRdgexI3tR9RBhAal6UHPj+7RJXno5g8IYDp3PJS0Zs/HEGaB4ko0YZbQnC09kMl2G+Yv1RYoqPAx6eaAlg4qwzOQ6/afRtdpy85KKHMWGeqHCOGjWJXraLgB1XAbZ9ZphuWo/oP2ImN8OVM5LrAK4nfDQgpxCaWpA3cyJjtI0u7QFPrVKMabOJlFwgzZqY7qdGCeZl8xhP3wQSBtprVlS6lZyvmOM3R3TqSeD2Py8xZt4OJHSjGAue+Eu9dnmCt4iYSdXN4nKlYtKHQ/JvSobUwpH87Tbv5OCLjMknz42jvdWdKQBUd+hc0iiOLVe8RbJRPrH2WUaGtMmIVd6BsvUcJAw2MgB96gFKLf5B3WRdfKijNDCTiU4ML1EZ0c+QVEKYLyzFfP6e5xmYZX3467aze7fNtY9xrhegvFp2d78Zj8j7mcLh2tWps3Lqi0jzZLOwwh258ZAwD/Rl9YdPEdrcGf7mIR3j5wvfif3HKCJ+bLSf3xkCC4Wy1g+Fu6fQfg5WSqVfDOXkY6KqRKrmwoAtkNHQ7gkrNmsOzQOIvGnyTau7cMxU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmF6TDFpMjd5ZUtFN1Vja3FCK2RaVG1iUndXQ2I2aWV0SXpQb1dyNEVERDNB?=
 =?utf-8?B?VWY1TFVOTGN5YXVBK2lXdXFKR1IvaUx4dGhkeGZWRStSbFoyMVRqMGFSVXBn?=
 =?utf-8?B?OFF4LzlveXZxeVoxTnBSUnJlS0hlWk9BMmVUUEFoVWVTdXZVdGhILzJlQ2Jj?=
 =?utf-8?B?THNXcE1CV0Q4cFlEdTVXeCszWWdrdzVwd1F0L2pzWW1zbGR3ckM3RUQ4cS9K?=
 =?utf-8?B?anhBUURZYk9PeDNZRjdMWm95YWxMY1dhOFBmemIyMkJPdkQ5Qm45REx3MTNF?=
 =?utf-8?B?RHFHc3pNOVE5WDA1RlBRR2k0MlFqVnB5T0FLUHBmeXpYY0tZOFdsQ2JrRGRB?=
 =?utf-8?B?UTlLaTEzRjdESENKNm1veTJGV2hPZFFIMXkzNTFwSWFOdkdvek5jYXBQcUJE?=
 =?utf-8?B?eFllVDJQM0p5VXNzelF6T0xhVGlhZUFzUlpxaCtaakhUaElkcnZvZ2FXbnlr?=
 =?utf-8?B?SDJTT0RqZVl3eHlWMlVIUkVSVFhhTzg4aVZlMFpSdHhBNjhLcDV3bmJWZDdp?=
 =?utf-8?B?dktpZVllRnhhYnpoaHdRZnI5NFJ6ZnpJZHpzMHZPckFxcDl5M3B2V1hVLzBI?=
 =?utf-8?B?VVo2K3F1eFByelRkdFlnWU9xK1BUak9WVUVhaG9ZWTU3dDNoNkdEVVFiTjhs?=
 =?utf-8?B?UXlKQzAxWFUwbkFmelVMbGpTamhubkd6VE9TbWl2Q0JGMGJKSWZzQ1dvemZZ?=
 =?utf-8?B?UVFtZjZ2VnErWGJxQnRsTGJHZWtWQ0FCeTNLekMvVTA4QkJpQkFIWG1rQkVX?=
 =?utf-8?B?NzFldzZiaDRvS3NLa0lONUF3TmRESjhEZmtMK0FkUU9GUVFPQWk5SExZMVdu?=
 =?utf-8?B?OERUOG9nc0toV3JmRnFaS0dyb3dEZXhCR09sSFd0T3hXRjc0UEh3eDQyOFVj?=
 =?utf-8?B?Uzlud1hpSEs1NDBYWWp3Y3loK0VZUXdNOXl1Q3NGZVlZV2tQajJXaS9xL2hD?=
 =?utf-8?B?VjFnV3hScjdiVFpVYTA3TXhCWVA2QWxRemUvUkNnVFdTSVByWXlWVkRlOTJq?=
 =?utf-8?B?SXFNZzkzUGh0Z3YvR2crTUd5TkRCdWxGRGxLS2M2a3l0bGdGU3l4QjdBT2kv?=
 =?utf-8?B?R0xkWXoydjV4cHhFbXJ6bmFtcFpidGRtd2xJT3VxTnNndW5YYkZxMzNWajBr?=
 =?utf-8?B?dEN2NEh2dDlpMW91YWRXZGxIYmRtd3cvUXd1RGwzZ2VZb1dyYWRiR0k1ZXgz?=
 =?utf-8?B?L2Q0SkxjSi8zTkVFeis1Y3R6ejE4Sk43RnMvMGFpbEg4KzR2Q29YS2Zkd0JZ?=
 =?utf-8?B?WDQrS05wL1FJTzdIV1lIdlNzTzBibER2dlp3SkVKUWdpREJFMVFMZmhwVDdQ?=
 =?utf-8?B?cDhqeStDRXhBYUFURlZ0QlpSamVhcUVsd2FYaWs0WDNSMGdubEhUOEVYdWsr?=
 =?utf-8?B?ZjZNZTVRU1VjYS9wRG5xSGNpS1Q3bWpzOUlBUUlsN3pncEJ5NWdtb0N0WnVt?=
 =?utf-8?B?QWpmYnFnQ1pQYUt5WjI4VnA5cDQ3aEVuSkNSZjJNbGkvQVRvQmZCdTJoeDY5?=
 =?utf-8?B?UkdzWXBpWnAwOFFKVHVTaWpwdmtOUlRQZm1aZjlBNGxjTVVKZUo2NlFBUVJ1?=
 =?utf-8?B?L0VpT0NwbmdQZnlVZDg2V1VnSXd2dzlBUTAxM1BSSnh6R1QreTRxNThKa29C?=
 =?utf-8?B?RUNhSEdPbTFmTmhhY2wwR0lrWWVBbGVNMEZPOTJ0UmNKSWpVVW5QS2I2T0FG?=
 =?utf-8?B?THpEMEF4b1JieUdZNUh2VnVDRHFUZXowSVN2ZE4vQU92SUh4NURHQkRER2J5?=
 =?utf-8?B?UitLajgva0NPNlhIRGdLeVNOMlVQTVZjYzdxNitQRHJLMDN2cEhNb3dYTmlv?=
 =?utf-8?B?M2N5R0htVnZaRStKeU1uZ0FoM3RvZlJLOUNBNEZnSDIveTVwa0RrK1pvbVRq?=
 =?utf-8?B?LzRwSTRlQSt5VVFDQ0ZoeU5EMExpVXU2V0VuQWNNTXVUOVBMNFRyKy9jek90?=
 =?utf-8?B?dXp2c0dxa2s4SjB3cHZPUmhYd3dxQzNqMTlCc1UzZXFPYktDRk4yRWlMYXBx?=
 =?utf-8?B?Z0JFTXdlOW5ITDFJU1J5Vkk4REtZYzd4QVV1WDkzcWp0YUtSNHlJSXRmMTlT?=
 =?utf-8?B?VjYrZUQvMW5JMmxIU3YwV3VzMVJPc1AzbnFuQVBJVUdMRWdnelV0M21iZ1dW?=
 =?utf-8?B?WFkvbG0wR3pOWUIraGdZTzk4dzNkd3pxTUxsTFoyYjFXY3B4VlorMjNWR0FT?=
 =?utf-8?B?VDZQdFBFL1VSY1hmSnZrTEV1aExFdnordW9GdkdMaGxrazRhaXNHUXUyWWds?=
 =?utf-8?B?dDQ2U01Bbng0MEMyYUhCMDZvYVBEOTYvWlFEK3lkeExvbWV4a3IxQjQ4dkx6?=
 =?utf-8?B?Q0FCb3MzNjMvOTdaQ2c4bzkzc0dVUGlkNi9TK1FxM3AwN0MwTElqdz09?=
X-Exchange-RoutingPolicyChecked: g6L0bquVFatV/Gj80Naw1GnOTxmrb96O1sWkoVbjr+x6zma5c2bNtzQkzohA+/xRSzWJ71quv5BaoIEhkuUqy/ykTyRsHU+/oBkbcGWYJVU9xw96Yr7k41PdjyUqaPwvoHC6SV4aFLeNpMu8cflXyRosELuVtHLC2qYjtuy2ATOznfILtDB0ez0V27leINKOJS7Akan+coBwCbkc9jJHc6H9cgR28yoH7MzmRh/RaeOBI3+jffQwN8RnOUR05KirySN0r9Mzv/8nh/Mrj+pnLcipGpqJUIYtbep3kPmqsRdBTJlDORpt/elpHgkne3JOLJvtcOVnIsu/2RTOywCmHg==
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe4ca05-49cc-4b0e-4938-08df0dfd63a3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 23:03:26.3185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNr04wARQ7fESR7yvdoPGaEGZtEMwK1cXxSVyMWOPc7WiIbEpeBqItHDjqE28ZzzbuDlTTGwr6mufEMLOcIibEERbVk1m6f1KcJNiFP0IwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8455
X-OriginatorOrg: intel.com

On 9/2/2026 6:11 AM, Sohil Mehta wrote:
> On 9/1/2026 4:16 PM, Chang S. Bae wrote:
>> Revision 0x1000405 contains internal microcode changes that are required
>> by subsequent revisions to avoid #MC during loading.
> 
> Before going to the solution space, can we add some more
> context/background here?
> 
> For example:
> 
> GNR revision 0x1000405 introduces a breaking change that causes a #MC
> when the OS updates the microcode from any version older than 0x1000405
> to a newer version. This is applicable to late load as well as early
> loading during boot.
> 
> A BIOS or firmware update is required to update the revision to
> 0x1000405 or newer before any OS updates can be safely loaded.
> This dependency ...

Thanks. I ended up taking Dave's version for V2.


>> Prevent loading 0x1000405 or later when the system has not yet been
>> updated to 0x1000405 or later.
> 
> This is a bit confusing. Should it say jumping from any anything older
> than 0x1000405 to anything newer?

I tweaked it in V2 to:
  "Prevent loading 0x1000405 or later unless the running revision is
   already at least 0x1000405."


>> +	if (vfm == INTEL_GRANITERAPIDS_X &&
>> +	    x86_stepping(sig->sig) == 1 &&
>> +	    sig->pf & 0x95 &&
>> +	    sig->rev < 0x1000405 &&
>> +	    rev >= 0x1000405) {
> 
> I don't think we have a helper that can be used here directly. Also,
> this is tagged for stable so adding a new one probably doesn't make sense.
> 
> But, 0x1000405 is repeated way too many times in this function :)
> At a minimum, can we add something like this?
> 
> #define GNR98_UCODE_MIN_REV 	0x1000405
> 
> Maybe add defines for the PF as well?


I saw exactly the same suggestion from AI, but I was not sure much value 
beyond more cosmetic. The revision is a one-off specific to the blocking 
check, so putting the revision value directly instead of a new define.


> 
> 
>> +		if (rev == 0x1000405)
>> +			pr_err_once("Erratum GNR98: 0x1000405 is not loadable.\n");
> 
> 						   ^ revision

Let me add `revision` in the message. Thanks.

> 
> With early load, his is probably one of the first messages that folks
> will see but it will only be displayed on platforms that have the issue
> until they update their microcode. Should we be more verbose here?
> 
> 
>> +		else
>> +			pr_err_once("Erratum GNR98: 0x1000405 is required before 0x%x.\n", rev);
> 
> "Erratum GNR98: revision 0x1000405 is required before revision 0x%x can
> be loaded. \n"
> 
> Should this be 0x1000405 *or later* ? We don't want common users to
> specifically try to find the revision 0x1000405 and load it, right?


For the error messages, `GNR98` needs to be decoded anyway, since the 
full context of the erratum is needed to understand for the next step. 
The message then is intended to point the erratum with a brief 
explanation. So I don't think it is too terse.

> 
> I am wondering what is the use of the if-else? Is that intended to guide
> the late loading users? I think for other users the second message would
> be confusing.

When the incoming revision is exactly 0x1000405, saying "revision 
0x1000405 is required" doesn't make any sense. For the later revisions, 
the second message can explain more directly too. So I split the two cases.

Thanks,
Chang
