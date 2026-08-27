Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37909448B9A;
	Thu, 27 Aug 2026 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787845228; cv=fail; b=ZAgQsMIpzIZI/izSUt+dmgStiPEd1rEZZpKdq/n+qDuoGkSM6cMikpqkWERL/SZpZ1mlLr2S+l4XKfos1eq8K4jL2YV8DpSyGAVVSzZ9T0pnQ9wT5xVLtiMYMuGqTDQgzLBsscSmCuhXg++8Fq61LWlX8fYkQfBBmiqw3XVe7oM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787845228; c=relaxed/simple;
	bh=CwT/YCOyGM+a+3af7AC0LBs55+z+qgC0C7stFrE2ch0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HO2sbITp1z+vYFQGDEtBk43kzQTa5LWHPBLm7gtTJpMWG6Dz3UXBd4agIFMSpvsEEd4tgZAkunGvCnQUoZCgrgpDiA7Z0yVxhHKz7DGWJLF5X4faqC2ji8+Ao2ZH4uPKlJGRSZdDLghAuvlXlRruE77jUkvo97aJftmfoLYWvBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JaaceRfa; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JaaceRfa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787845226; x=1819381226;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CwT/YCOyGM+a+3af7AC0LBs55+z+qgC0C7stFrE2ch0=;
  b=JaaceRfak1nWpTaxfwUhlGuRmTmPLbKtrZ2Xw5dTuOWyoYROQlJKPGS/
   5n+tO/LjQuJHrS5cb5Phn+Md8kaPWkX20ARmI84OA+r4OBJBWQ3VdNu+o
   nOuJlnG4phsqWhNF+qMOYJuAZT5l6Jl7KzpqlllafUkcRbrzI2zYbC81j
   nTBh1h4ouISYbI+cKWIEhASiXDrci+u9gf/UaDs0p8tHgSXy/Bwj7/2Ux
   eMwvDJ3AnaU6+avSjEseOdRb1LfqYrGo8pMUw/dyF96TsAnMYXu+skE7d
   VjAPjcA+gHKbhHq2cs2egGhYCM5prNxNm6YaUtc4coKAFHKR4pICNhmHV
   w==;
X-CSE-ConnectionGUID: ohA2OiJPQmuo7Av68HoS0Q==
X-CSE-MsgGUID: p+EjiFFKS1aaEWBYL3NVVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="105723049"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="105723049"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 08:40:26 -0700
X-CSE-ConnectionGUID: AeiCIVSxT/W97WMiZ+LQ3g==
X-CSE-MsgGUID: ucVQUWcySeu4KwsqVCG5ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="271708554"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 08:40:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 08:40:25 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 27 Aug 2026 08:40:25 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.52) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 08:40:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MWNGMAw79hr7y/XEoEuxxOjqQ5KxYq8qPUNlrlM0c45z2+WZC0SdFlrBHQU9v/onk/WNv43+5mb84PZcSranIWqJUbFitGyCWk4IZepI8vCpm3dGSvALZ7x2JAxkzT7qx9gSAjYkkbv/2Lwiz/hLtVaE0FjmCMCdc9A7Zm/yFK/InYc3eHjGA8Pwbk9ZuwUr8UTrtijLKFJuwIyzXHAt120mvOFYTk+3BaD70nI4XlU+htyPa8RH7SrmYIdFlwYaK/IVzwKJsvjUKJD/9VR656TmP+8igjSHXL2SAQ/FWMwuAAGiPk6HOiykiJdyJpnL5csdOYFZIfcGDhmySMqsQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqeayHmWZbgH066jjiXhv8F/HZ66DoCSZeZhCWIc1H0=;
 b=xj4TQLATA/qmwBLPkC1JMz1u/AJwJNXwNaF5ElijEGS2OSgAmxpqReTjq6hN5x2HQvWilO04Oua+zot9kLjRQmU2DhkoCN6ulDGu4DpIwI0ZBN8JIFy44vRJt/AJ550UrYDiyy5vJiFLrqtQ1kleG3t7WASAROTKIeUv51ULaMFrpQZR9V2x+Y2io0mOVJWaIKg4ybVqCf/kR7IKJE7QlhN1/oQxKgCroJCqYd6pg5U617JClo6mPSF2nf4tza3Hk4a4drBMpUvB/88KiEQNATQGmbW/kjBs6vqNAiwBSo6RYGG0wyCMNK0xS9Q+h9ij5rvWMuxsH7Nxp1Ds9tqxMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 DS4PR11MB643888.namprd11.prod.outlook.com (2603:10b6:8:53e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Thu, 27 Aug
 2026 15:40:22 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%7]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 15:40:22 +0000
Message-ID: <dca20e1a-1f14-47cf-b154-1979e9248bea@intel.com>
Date: Thu, 27 Aug 2026 08:40:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/build/64: Prevent native builds from generating APX
 instructions
To: Nathan Chancellor <nathan@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, Omar Avelar <omar.avelar@intel.com>,
	<stable@vger.kernel.org>, Miguel Ojeda <ojeda@kernel.org>, "Van De Ven,
 Arjan" <arjan.van.de.ven@intel.com>
References: <20260708211435.402426-1-chang.seok.bae@intel.com>
 <20260712202538.GA1697833@ax162>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20260712202538.GA1697833@ax162>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0175.namprd03.prod.outlook.com
 (2603:10b6:a03:338::30) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|DS4PR11MB643888:EE_
X-MS-Office365-Filtering-Correlation-Id: b013724a-3d00-4c93-5215-08df0451815c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|23010399003|1800799024|376014|10067099003|56012099006|3023799007|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: OSUzCgJC6A248jLDWFrNmZt8xETG/7dL7Lx3+1sttKx+I69cV6McnCKyv5YnW0Gl1Ea0iSaobEMW3A3hWxposg/TxeTV31PZaa+6uHaKClGYJcDuTKH81AXKddZOG4Mh2qvAaqMeCXO/x4yRcoLVAH5gmcODftH6yLpLSdyoubBsNMlztBruy2GU4U645t31fN3c1wVSkw6tqgGZG3BdAFkGpaCQjktw3ltzqGkELruD7CMdwH2o4mUOep8fnxFUzUQNHKBWVc8K20Qsyt6YkRck39bCkwBUFX+pO7kkjaD707wXVhWFIwjXGKsDgLDIgNZq6MMbscAJuIN2V0g6RWgYG86vH20iGImFbrznoVqa38u4K99jxkiBcoM2SBEVDYydse4GibWwsDfGzFQ5j1EhKl9TYLHUKIoyLTSmdR3Se0Nnl+T++ZT6UnJitvZhr7gociaXMPN083ZSt1ruYAEFmTV5PKDIHSRZcYRwg3wnihtt8p52CBJM4Jxu4ZScrIt2jUyHdQP9iltqsmzl7w9cHFkE/G0Dt33TZoo0IyAt+P4XT9e1jlrVemEs8nyYWtjnSwsts7JVlPJ19PRq/+T4z7wPRK3uvScOJQ7s323Jd7OAFOEmz58h/Zt/cPF6duZdb+i3yPbrNfHkTgzUSsjgvG4G9/pvmLJbAzRJ4fg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(23010399003)(1800799024)(376014)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzJodElCZDNCWUtMc0ZqWjdFZ0VmbDdhZERQaExvbUd0OUIvcVRiYjl2dDdm?=
 =?utf-8?B?b2l3TmZ4VUUyb0JVSGpncWpORUFJdTNvbGZGYlpiTXIwc2NibWYrdTRNUGhk?=
 =?utf-8?B?N1phZzBzRER6Y0dIV1dIUEY3OHpRY1FTcTFaWlQyOTJGVTVZbFRMK1RlNTJU?=
 =?utf-8?B?Ynh0STVhWTl1MWtvdmNuUEo1Vm9nTkJVc2ZoY3k5Wk45bnhjMS9TbDQyeGQr?=
 =?utf-8?B?dklOcGUvUDBiYmJpVFBIVWlOd2ozcTZnNjM1bmJseWpkMHU1RGJrZmFZNExj?=
 =?utf-8?B?SEVIbk5qK1hMZWFvRzJuQUVHanNOc0x0bk1XUENBWHRQNWg1RmplT1JRODB3?=
 =?utf-8?B?R2xjeGtVQ0VuR25BcVZFZkUyenN3QnlWaS9LTTVwei9NcFVPL0twZkgvcWJF?=
 =?utf-8?B?V09FV0N3YXBUKzI5aVd1YVNvMDZqbzhTeS9LVnJJc1M4aVkwVTl2a0x5Zklz?=
 =?utf-8?B?azZRS2JnZFc2MzlsaVpnSGUxRFgrT3kyaFZZL3ljUHZaaEJROTRXeDRKVlNp?=
 =?utf-8?B?RGVBcUlsL21zTUhuRUp0Zkt6bmRDS0JzRHZXaEJjVHlyK0haQlpFempPakJH?=
 =?utf-8?B?bVl4dFpIZWZ1QjNJVVZaR1VHNGpDKzNjbDNrVGVxckhleXlrQWx6TWlXcEpF?=
 =?utf-8?B?Qkw3SUhjcGlyVllGeXh0Ti92N3lxK2FEQVZyV1l0MHozb2xpZjdkdWk2Y3J4?=
 =?utf-8?B?b2pURUp6Y2ZqUjFjNGlFajR0RzdaaDhkMzZIdUFidUlldXRqelJwZG9RVXhk?=
 =?utf-8?B?cmYzZFcrRG94ZVJXRXJaZFNaWi9aOTBqTE1hUHBOQmxMRW5uOHFnSlBnekdj?=
 =?utf-8?B?WlgrV2t1eTFDY1JnOVFMQ1BIQkdFcG5qajhkNzZEc0lPSGdJaGRDRDBEcHpj?=
 =?utf-8?B?MGFwKy9ENUZSOVo2b1h1YU00TnhRUXQrL2pzT21BVnpPa21JTVJiaHNEUWJ6?=
 =?utf-8?B?TFgwOEc3L0F0K211a2huYnpKakdQL3F3N0dTRzJkTFhrVWI4eUYzaWdHUkIz?=
 =?utf-8?B?VWplQm9EdlRXYjNBUVRFL0dxT0VycUdKN1ovL0dtOW9JQkJlZ0Q2NnRXbjZV?=
 =?utf-8?B?dWNKK3hOV2pTWkxPSlR0TVU4Q2FZWW1lYmdjdk1UMWhDUVJwaml5enQ2aDh5?=
 =?utf-8?B?aDhUaW93a3hVdzBmNklNVDFKRGFRc1BYVnp1SHhpV1dxZkY1bVVqaHBUR21G?=
 =?utf-8?B?Y1p5cTVOVjV3OEd4YXJRSW9jMU9zVjZuZUU0RWdMTHE3SnJCRWlNeWZFWWph?=
 =?utf-8?B?OUlTSkxJd1EzcUVsQ05uQlVqYjgvUHptTldjMm5CM1RkQ1N5T1BxcFA5YnE1?=
 =?utf-8?B?ZlpSY1A1OU5UYlZuWUlkRGU0RzhubVc3cmlTWTV5T2srRGM1VFRKOGp0Rmsr?=
 =?utf-8?B?T08rNjVuN3B4K3J1V29Qb1JmcUJvSmJKZWNKVjFqLzZWK2MrdDVWMEF3Q2NI?=
 =?utf-8?B?VWJIeG5UdVFuWExaVzY2ejdZZmowMUF5aEhFZDROOG8rb0RoSWVLUGJyd0o5?=
 =?utf-8?B?VWUyWVR6NENCZStSRVJQOEtZTjJJcFFPVjY1TmtQeTdtdmxEMjQ5QUF5Ynl6?=
 =?utf-8?B?TGF4cGJaemtQeEg4VW1IMlQxRGRhbmhsNk1aN2dUSjF2WFA4YkV5NWMyVGJG?=
 =?utf-8?B?eEpXUXhqdHdhV2Y4djJtcGZERC9wUllqcUFtZzVSTlZ0MXpCQk42SG16ZjZL?=
 =?utf-8?B?RG9KRVdjbHE1U3ZrT1hBVEY0SFNrcmZTSlJrNVVLK0ZTWXJpRDFGRTNZL2pW?=
 =?utf-8?B?TWtKVmtOQnhNdjlMYnhtTkREeHNlN3RGNVhkOTYyMUFkWHV4RXI3eEFKU1BM?=
 =?utf-8?B?NUdGSXdIUDNsNzZzMCt5dGYxNXBLT2xsR1BZS1JnM09KbCtueFdralBmN0xL?=
 =?utf-8?B?dDNyNzR6Y1hDOHAzS0JGa0tTYzNLNTR6ek8zRnhUMlFiNVZVa25YcmJTVGlC?=
 =?utf-8?B?SVNCMWJmV0hJdW5PUEhNQmlSZmdDUGNrSDNkSXBZSW5EM3BBcnQrUlVFek8w?=
 =?utf-8?B?aGhtSDdQd0ZsTlRnRVYyVFNIYmFuemlKS09LZFhqWlBJZ0krblNBclVranFt?=
 =?utf-8?B?VDNjWEJocjBkK2JCelVqU25ORHhManhyYWJaVVVNOTRCQ3U3bG9ObHlsZU5B?=
 =?utf-8?B?R1hGWFBDVWtiemdVcWJYemNqV2lMR0tBQ1d1Z1VNUFdGaDA2VUkrRzdIMnVZ?=
 =?utf-8?B?S2l3K3RVZnN0YXdtRDF0dUdXLzRucGp4SGVlTCtiRjFhNmJLWGNGMldZUnF1?=
 =?utf-8?B?WEl5N0JiZFBrWGFWUDZ6WnFZbUN5RWlaS1ZBTGR2bi80bmgvbUZEZUc4WVNX?=
 =?utf-8?B?Qjh6aEZOZG5DYis4VWo1cjdYSC9yTXhyR1licEZuOXE3S3lXNWtDZz09?=
X-Exchange-RoutingPolicyChecked: T+up7sZCUjgYpwzyZGFgq49s9Lbgmm9TD4qMbhvjD893llcJfipmlnBXm8l/iI6HzY5iAqVO4c56JkDTSf1izHSxSm3isRgBF8ouJm7Q6rGvTZjEPAPYW107FgQEOB0RWodd7eWYL1e42UTvAVFvR+aKl51ql6XCROyJZdntpaxJDSWttpL+5oj74rhtddeP+dxUC/OLEtRfyuKtwp60zsE9ipkOKouxfnD/eYNah+0JBI87eo78ZXS0HKg6dZdDUFnUSfNQZiPzcmaMIHByM9SNwzpFZS+RdtBy6P7sNZo3WuuwqBFlI2VuUDBq7YYDRefm1hQA4GYGjll+QQ6LEQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b013724a-3d00-4c93-5215-08df0451815c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 15:40:22.2846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fDvp/4Pl76mpHePML1B3oY+ct6pQjM0tr+RvdVVLMVl0pfXUlC/QhtPvzdBz6C4kfIHL0NM5Gb7LOjchQTZ4ZDoYCWSjVsy4kI9jGPv8tgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB643888
X-OriginatorOrg: intel.com

On 7/12/2026 1:25 PM, Nathan Chancellor wrote:
> 
> Miguel's comment aside:
> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Thanks!

> As the flag is the same between the two compilers, I think it would be
> more readable to do something like:
> 
>    # Do not generate APX instructions as in-kernel use isn't ready
>    # Supported by GCC 14+ and LLVM 18+
>    KBUILD_CFLAGS += $(call cc-option,-mno-apxf)
Yeah, thanks -- I took this for V2.

BTW now I realized that both compilers already support `apx-features=` 
to specify sub-options. Instead of -mno-apxf entirely, 
-mno-apx-features="egpr" can just disable the use of EGPRs.

Thanks,
Chang
