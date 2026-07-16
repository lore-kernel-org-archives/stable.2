Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025613EC68D;
	Thu, 16 Jul 2026 08:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784190680; cv=fail; b=nJZav7DjlOv91IagZswYT9fyalsFFgBIrWTLF/xqHuxu0HWx+ia5r+RVzydMYrkE7oONEUTntbS9rfulASSf0RHEC4mGmuePS35GFjyTRSCCJD1g7dJjvlhJ+d2VzvwVCUuDVilTSqeAabtLlm8hnn/lEqE1Ec3gxl1YcjFROzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784190680; c=relaxed/simple;
	bh=W9e7649zXhwOOMoQjC5NSJqznDtyDJKOcxa6ml14yWY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b97/GJ6IJlbWdvkXWHm/gxB6ueTCDUxJAxiSBohN+68sqT5EYEjUWCOjRYneA2JwTmRJuzUIly+Q7j3HzhTm2CgIoQgEk6yy3FdvPjMn1QmyzFK/czi+EybHTVJwSAJfiMAZrJ2+cGZ1v6nqmIPhPrBsmTjZwKb/ZVB7gGubDuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gYnLGSab; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gYnLGSab"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784190679; x=1815726679;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W9e7649zXhwOOMoQjC5NSJqznDtyDJKOcxa6ml14yWY=;
  b=gYnLGSablxaq1wg2iGXrlsrnE/5zKx3DHjyqhXuzyWzIolhgrBy42byb
   4QX13ZII3U5yu+IolpTNmntUxiEbRDNJMEDrSgR+Tqiv/pLoVIgW04mYg
   m0peUdqbAmh0F/hQITF+td68Ej7Su1Pgj72MRfxFeaJFGdb5c/ggDFLdL
   IuWQHwnNw/K7noM49TTrlFpTR3Ao2vbHB57wMEc+Q6CF4HT5hr1ZWLRzN
   n9BSKIvTsgGh3coyD5wTxzQ/qIz9H4z/j+KuspMS06ZB/sJ8UFPwQunSw
   QJFa4+ruPM4bZlJ6hPMvvOFkrRC6hIcXJwNHaaTatj+xnZvGzykPb3Zz4
   Q==;
X-CSE-ConnectionGUID: 0twSK5RdT1ivoahKSgZaTg==
X-CSE-MsgGUID: t9DYFpziT5yStScrAWcCUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="102395991"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="102395991"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 01:31:18 -0700
X-CSE-ConnectionGUID: +/EZd1y2TKqFpo+vDfjtSQ==
X-CSE-MsgGUID: xwUl5czESSWTEqY73rmBLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="252455159"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 01:31:17 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 01:31:16 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 16 Jul 2026 01:31:16 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.64) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 01:31:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YGejueMFozzv4laZN6jOnmKSCFt1xh0yHaNgUGd4jBvl2gAUD9UZXLXIOEKkeouNJORNkV2uXEVGxxiB9WMSp6RByi/mKMqXkIxp+gjHG7mRW1IZp9gZ+pWPbDPYPXkI1Cm+CpI+N0cmuczB7qRZhEmA35f8JcTAsrjJY7vrGLWRVpP8Y3X9sjQsiozBCoXKjwkyAQVb6VJWMcQfj6t1Llaa4C8AnCr5lJ4rspZFiX/GPH7+xx5U/gsmyac7LCpz5YMMO1yjznUjvm3jl35901sWiVHNZPGk9ll3FKsVqk4W2PIX0wU5B1NZeXZ+xW3UV+Dn2O4do1IsGt+XVnlOmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQBSDs3JF6wbjieclLI8Qc+b8GmbsvRhcHtGxCdJKrI=;
 b=eE0O+tsmMnjOpxMnEev8dmPAarruKSS0o2yZtYgo04TDHOjtMmobVKs0h1byc64x0XasFobQ5S/5+eBZNa5UnqLklA5xtD2jf50RSG5bdOwL0R3TE3R8l6M7UDAqMy33Kgm6G06nb1WZ1N4Irk+JR8meExYWRCeY9+1RoGiS6j+VDdVYFDYxevmbajUXcsg3kvZstuqdaHS+sowDs7eF6RfuLp7ox7RwSFGEwRkFI6JNhiYBjJqRTxZlP9EJrtdkiMOPTZj/Jd/9QIPda/AaQ99QN+gm56Wgp9zcnLQb5RO/sBpr0AnMtNE7n8nrLxv6KKzYraYOOZ/DMRVasFTNUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6967.namprd11.prod.outlook.com (2603:10b6:806:2bb::15)
 by IA1PR11MB7385.namprd11.prod.outlook.com (2603:10b6:208:423::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 08:31:08 +0000
Received: from SA1PR11MB6967.namprd11.prod.outlook.com
 ([fe80::36a9:3aca:a63e:c8f4]) by SA1PR11MB6967.namprd11.prod.outlook.com
 ([fe80::36a9:3aca:a63e:c8f4%3]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 08:31:08 +0000
Message-ID: <8626c16e-cda3-459a-b8f6-066f9a3bb18f@intel.com>
Date: Thu, 16 Jul 2026 10:31:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ASoC: tas2562: Volume setting fixes
To: Mark Brown <broonie@kernel.org>
CC: Haidar Lee <haidar.lee@adlinktech.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Shenghao Ding
	<shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, Baojun Xu
	<baojun.xu@ti.com>, Sen Wang <sen@ti.com>, Liam Girdwood
	<lgirdwood@gmail.com>
References: <20260715-asoc-tas2562-put-retval-v1-0-97bf467c924e@kernel.org>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20260715-asoc-tas2562-put-retval-v1-0-97bf467c924e@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2PEPF000008B8.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::68c) To SA1PR11MB6967.namprd11.prod.outlook.com
 (2603:10b6:806:2bb::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6967:EE_|IA1PR11MB7385:EE_
X-MS-Office365-Filtering-Correlation-Id: 55255ec0-ea00-4312-f0f5-08dee3149575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4ZkJiKt8oDk2ds2ls/kAI6qd3Etq7XV7XsRUnXyupxcOZHjAZRjRnbEiFyMvB0hMkUc8CX1A0nCotQP8INE27QjodcTm8OBdPZE9GcYip/H+i10F7xim9TjUEVawNt9moeYjKkQLoSytSYwvTGW+VqHTM/7eBEaPcu0jPOHhKr962ghu706GgaiH/dauqBxILxgGTBEH3RyJwRgs/9+8z/e7oKEJ0oHV9s3SW5HG6LfMfo6ccNsTHDRJeCdltVWNoPet8dQioJrXIYbGfDYzTWV5+Oo5qNAuK593MES9waWAm4WJPq3TE2jgaGG1G4EKSdQXjNgl/PzV6DrLURIc7tw8FPwIM3Z7b9FMuKbzBvN109Q+JeOCtD/VWDcQWGRO0HihVoKrx0J0DE1kj8CV96M41Vby/FAGtKvDjKxU9OWwaRUK5d1jg8kKvFesDa1/NMsMDtmYLQNRa1a2MCSFz1h1I1oCu7hYq5z0sax3hm1qH+dPq80IG17THeHpBZnffzIb8JulsG1++G9XR+RUb4NxT1yE1z/pElyu3jlUwINj7ku8eREWx9ejenjS14L5MkvDNMLw3IWucz/k/DKpbQ/rznsI9wK+aelUbud647IXPBqegbVdd8PHr4tvMrikwHSeI05SD4WH5YQL1bfozi13ZTwAUOY94w1GjTobZ5k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6967.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUZaN3U1L2l6Z2JLZG9LbVRXVFkwbEFpK05Vd0VjQzJKQWR4Q0lpMGFNTFpv?=
 =?utf-8?B?WG1ZTkEwVzdPdmRDYXVMd3dlYzRsUG5TK1RlMVdiZG1TazNJenR1OFdRNzda?=
 =?utf-8?B?alJOS0tSS2dYbm5HQW9EM0IxUWxRMU4zQ0RBb01Nd0laU21rWXg5ckozbjlJ?=
 =?utf-8?B?Nm1rVmsrNTZibUtWQ3ZrZmFSN2U2ZU5EY2tIbHJheHM5K01wcE5LSDVKRjBH?=
 =?utf-8?B?ZFBaaFJhbi9ZT1lLRXhqL3dQVnlQZVEvTHpOcXBtMzdyRGlkMkMzdm1WOVFp?=
 =?utf-8?B?SWw0TXVqRWZHU0FxaW9TRytFUm9vS0grR1VnSzRFMVl3MTRqVmFleTZzSEZP?=
 =?utf-8?B?WHhka2g3b1ppa09WVmJYbmwvM2Q3WHViZnVxellZendZRTFRcnZFcUdwUjNy?=
 =?utf-8?B?dmVJRE01Rno1cGlKUEorZmgxM1haM2dXUk9BQS94cnJzWTB1cUdmUTdBWWJX?=
 =?utf-8?B?amlGaVg3Y3h2SCtLcHo2REQ4RFB5SUZWSi9nSmxsd21RR0RnbTc5UzRDY2Rr?=
 =?utf-8?B?eFI0cm9vTGsxNEpLVjFMZGIyOW00TmFLVUVKR2hibER6QzNCWHFtbTNxdnRz?=
 =?utf-8?B?Z2NJT29OeGc0WjZZNlFrNlFNU1FSb2FOc3ZES05ycGVIR3ZoeVM3NERkRkxx?=
 =?utf-8?B?U3d1YjdVTlAydlMybkRscWlhZjE0QUtOVmdqWExiMEJwdCtxc1lwQ3RrMlJl?=
 =?utf-8?B?Y1BUVk1qNkN3K1IwNHNYMHIzNFBWSGpnQW05WkZNaWw3S2doMHE4bmQ4M0ov?=
 =?utf-8?B?TWZLR3lYMmJSbE5QSHd5SGZJV056ZXdKWmd1YmZHeVhiZ1pNTkJpM3VRSVl4?=
 =?utf-8?B?VWJzSWZRYnRJd1h4L1VJUUk3WlpNZVRKZ21OdW9XMGhlMVYxckVCbHBVL1Ft?=
 =?utf-8?B?bW15TzVqTUswdUZkOE9vZFI0cHh0VDZwelhZZ01ELzNZWnJpS0JuM2FOenk2?=
 =?utf-8?B?RWdhdGRmWm91TFVJdThGc1JKZ0JGdC9oSEEvam13UmU0RHRUbmI4RTVOK1pv?=
 =?utf-8?B?cXplUXMrVkp2cXM0YkJ0bkRtdGdsR21aU1dXOFNxL1JHenVvbzhWUUNPZ2dX?=
 =?utf-8?B?UUZKUGpzWVo0ejJvSzl2SzdGRXJBOGNOOCszMjcyTHdUWDEyWk05MWNlemFV?=
 =?utf-8?B?YnhVZUtVS01zWXdRZjErVjd6Nlo5ck1sUWx2NUVTUDBOcHA4ZEZaaXByOUI0?=
 =?utf-8?B?b2tUZzc5QS9odEhEZGg2dzNrckJnNUdqcTlpQUkwMnY4ZTdQYmNvbXFBNHV1?=
 =?utf-8?B?RUxEWkhRcnRueDd2WnQzYWNpc1VQTmNSQTNCMjFzZUtUWnF2b3JORUlLblkw?=
 =?utf-8?B?SHB0YlVkcUoza2hkZGh5N05NMFU2UCtxczR3VFJPSXVnRS83bTROdW5UUVBX?=
 =?utf-8?B?cEFSc1Z4c0Q5aTZvVnRXWXVVZDNjcDI3RGh5cmM4a2J4c28rUzNhVG4wczlN?=
 =?utf-8?B?TkxaOEdMZG13eDRxQWM3ZFZQQkVKSEl5bmZkdTg4SGc3MGt6UEtwck9JaXpD?=
 =?utf-8?B?YjR0SmJabCsybTBvbDhHYWlRc28xZDB2bEVIakphc2VacEJBTEpTQ3R3U0ty?=
 =?utf-8?B?MlBsRXJvNE9BNDFOSlhrNnh1MWM0N2tYY2s1ajRiUnlVNytFanFrcUhKeWx5?=
 =?utf-8?B?M0dnb2dZZ1EzZ0hCaXZDaEJEVTBvcGZFeXlraXBEalNXNDR3am1jUFFtcHdM?=
 =?utf-8?B?SDB1TCs1VmNjZENoQTREZnk5bWJxU2pwTE13L1FRenNaSUJCeHoweVlmV1NJ?=
 =?utf-8?B?N1oyRnVNb01wbDRjVUZVeGZzNEJFTFczdEFmWXg2RnhrdFpSNTE1K21DVDdr?=
 =?utf-8?B?Z1h1QmFVNUNaSnZ0M0xMS2ZZdUJHYmxWbFNrQXhrTFZCRm80cG1vSE14UG1r?=
 =?utf-8?B?cExHUDhtWWZ4U1piWjhxcjRLSDlHNjF1UzdyWG53RmtsaURhMHJWQURZQzhm?=
 =?utf-8?B?T0dTZCtJc011eUczNE1xUlVlS1Z6czRteElJL0hybzdTbWdYRTVUMTJuS2t3?=
 =?utf-8?B?cFl1RmVwa0t0YWRFRFVtdlJVL0IzS08wTEN5TGJ0dm95OHZtRmJrNmRwaHgx?=
 =?utf-8?B?TjRGZkgxMzdsWVg1UXpmYUkyV0wweUNLbi8ydWp4WFNXaG9kdHVGSHJCNmx1?=
 =?utf-8?B?UEhzbHRGeEVNVWxyOCtPTktwMURHMlJBMk1tcmIwa1Vzcm5IZ2Z5bUNYcmxB?=
 =?utf-8?B?WHdmanUyT09nN21rK3RyeDdGNmJBYmVoYXNnVkRxK3h2OFFlbjNlajhHbCtY?=
 =?utf-8?B?TVN4UzhkNW93WnV0eGxUeHBIa3djamwwS1N2WVhqOXE5TzdxRHA3R2R2a1Za?=
 =?utf-8?B?QmZNeVo2UG9zSERvTjgrN09SeUl5YjU2NStuMUNidnpFME9DUHdhdENuTzBI?=
 =?utf-8?Q?qsQX5/beJhryKeok=3D?=
X-Exchange-RoutingPolicyChecked: hSgQGDU5vMQQs0e3xb9/MOb/GpHzi7nfRqngPre5s0ORUiH36Ar/T4M7Cas3K5hTA7GBQYFEHbKDZ6nrerMeaV0c86dVpaVYnMfz0boRaKUNZh2IiYWeC2okDtugBzSinZoLgnR1Qwr8QCAP/hgS2zgzaxjvWB+2Zdgc9a0QhP70jvhi1cEAGY2N83VQ/hjqzGRozB3ZcXrsdWrbTkcAMrzius0FBH7OpK2UKPUgsyUG8I31bYkbvkO4vFZQBEJXDE69IproJ1E1baxRLXYeOfUYU6IHnllVElFJStOvWiZEuK2L293fNR9+0972iiua4IpwJgEkUlaE2qy8Q26R/Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 55255ec0-ea00-4312-f0f5-08dee3149575
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6967.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 08:31:08.1887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYgZMEI7LmDeITdDu8rYJ5BWGAeCIMIO90msTWshZ/qOKS+EKZJ4CDTmRLr3daGAF6GzKC0x6Yds6Qn+En9mjT0hj52G8+1KVGxg7Ta3zpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7385
X-OriginatorOrg: intel.com

On 7/15/2026 10:18 PM, Mark Brown wrote:
> While reviewing another fix for the tas2562 volume control I noticed a
> few issues with the put() operation, this series fixes them.
> 
> It's also a bit weird that the volume control is defined with twice as
> many values as can actually be set, probably the best fix there is to
> regnerate the table of volume values with the intermediate values.
For the series:

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
