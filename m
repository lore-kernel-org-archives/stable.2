Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794991387;
	b=MmRdGN8oKke2Bu6alKd1qu3zgvfJMBOxNVokTf5nGJvaTnPpIbx3W5q/99R0z9oxpOhj
	 kO9KZKVKSFmR2oD0L4q56F8pHyWoTEEvAhxhVSpJzylr9yOW6fuAhlwtXnguelgXqlQPl
	 W6j9NYkdf3MWv8Pd0h4OLAfGGMa2gtzcKGVCK1LJukJ9kuFHwtqviEzYH+22ZKi42oocx
	 c3/IuyvcEFPSp3t59lVLBjuw7/KBjbbfqn6iJGjlq8EdnlrmcfWkBU5skX/o2TP88B9AE
	 EOFZrVS0BBa7xlp4Pd1WLA5HKfGBXa9yt49nRjqgxXkw8Jg4uxqb5f23pUGxvaHX7Iw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991387;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:To:CC:References:Content-Language:From:In-Reply-To:
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
	bh=1sCOk9zp3A/z3IBJVSyn+kyMVv019vbw7/5DTr6BLL0=;
	b=JSqrg2S53bYVW6YpPphLxUQkUWS9BSEgl7z9ftNLGT1GxWd1ntSndM7woq8B9G/0CCVH
	 b9CGnzZPos/21VeCpAsKJ0DIvjfBMz+Rm1zEawEbYieCFKOCFsK9N/wwQvHtEd4lQiiWu
	 CCitU+eIUKp4ILoEJ5MjwtxUjoKk8fPIcQ7KixIC5HsbfMYcYtfPFxkx5PSBvO5Ww9wUE
	 U+eXo54IXPL9cieMyzEbT+aVzkl5FnZs7RS8FdKhoxOr/LXNETBpj7mrYt0CZIjz+vNZc
	 GrCk6JoHSIdhnjBdYMWOeeINWnuGEKmz27g3yZyD1KNwL+rcZTHaSIeCW5vewNngckw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fY7y6zyT;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=N0cOeB5j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AB9606A32F
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 08:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26AB9606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fY7y6zyT;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=N0cOeB5j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794991387; x=1826527387;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=llSFn+5o3/fl7PkGxYj6pKXkNVwyf4XoCAU07Qkrom8=;
  b=fY7y6zyTyZBDprstlvCIuUDScmxq8DHrULbVYQDvYJnR6yUihskNwb/+
   MkKLXItrUeKiQo0dqNGAfA8n6feDMkTf0MGwMFZaBL4zh4xDdDo+I9qmI
   VabPp+sqo1CWTdEbj46KaIITfQLvzhQCV0/itxO3V1rk9M1uwl4XIcywB
   NPX/jTqgncoLzg4rEdivqSXBLnmDz1rzD7TMXaDkVxkZKQnJi7997k9bM
   Hrv3Fh6js0oT/hBNJH8eCoUpa4afZ1TVCIKC16WauLFk0p4hsjEetqEaH
   tdxgXG1qh/gqyiOKneabjEDlt2rmwzAJ5qK282vu4Cv5xZVlRvsQh63QI
   g==;
X-CSE-ConnectionGUID: u0q9RgIqQLqUexcCw62l2Q==
X-CSE-MsgGUID: cwRNIpz7TWSjT2HcCEvoHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3781315"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3781315"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 00:43:05 -0800
X-CSE-ConnectionGUID: 9m11PavUSCaDL8IMdkdG0g==
X-CSE-MsgGUID: S3gSWAltR86GVrv1huD3fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9964142"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 00:43:05 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 00:43:04 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 00:43:04 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.61) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 00:43:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eEX/wb4K25OxKsasvI7xVRI/sHfNYE0VMeVLGVOjv6t7ev8fpK8ru3pGoSNeXpJgtg0boQFtlUAdow/yt1p6HOV+GtUAHw7qmu4GY56XuIKEYQ7xRzWKmCeIsP1k4XhUvnKF2nod+epP8cQ2bIDK1NdlNufJg3jeBAcWqf4ILtP+AoV2mquXf3TUW76LgKDH2husCShef6ZsRfwLmF3FnqwNqy6sECsCiTeUQyCA1DxNYUxUTWOgRMZvSzGFmcqF21NRb6Onp1CMJhiqjV56gDoSoIK4J+RVXKt9goBtKC2fhQEAkFC+H5+x2ih35exfefqTEGISvVg1WmiJHInjEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1sCOk9zp3A/z3IBJVSyn+kyMVv019vbw7/5DTr6BLL0=;
 b=DqJEgl+tiAsvqLQ2d+HMmLAHiuc1sWG1xotujDe1PF10Mffzxrss+K1NNOnqng1ce6zE7cOH3eNWFysdofDFLfkP4pSy1zv/Yj2i9dKJ/KpPjCRL/ITyrRcX1M6still/klgE+swYwaEPKu10AdAKKek7BfDw0ZqLV4sYMlhf7wZhmUnHsorxrhlCjwfvoDkszjMTJsssJW3Lj0Sd7JPKg8z+euCYQralec8JowFutvvdU6OjyOC04AF1O0UR/RE+Czzdss9dvYNWz/E+fkQfJrtKqJDtHw+VDHBonEJH5LedzwaAUzHmogh8oIKOMzCi8QcLfd11KlWMX/1i9BLkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sCOk9zp3A/z3IBJVSyn+kyMVv019vbw7/5DTr6BLL0=;
 b=N0cOeB5jd/wLtXGHvRT7CPpByU7tIrrPDtsF9G6jdiOHrAG/d2kGq5kxo7/tO1pOyxIfyZKQ3RhPy3/sYdFS7Ux5gKlHsumkxZEQwT2uqx0ILGWZhCedjIMe8yGqXf4xpClPgsMd8FmGtTjW80pRHyQGk59SXCUq3ijglpWgIUk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB148960.namprd11.prod.outlook.com
 (2603:10b6:408:40f::21) by MW4PR11MB7008.namprd11.prod.outlook.com
 (2603:10b6:303:227::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 08:42:43 +0000
Received: from LV2PR11MB148960.namprd11.prod.outlook.com
 ([fe80::9761:b20d:6f27:5460]) by LV2PR11MB148960.namprd11.prod.outlook.com
 ([fe80::9761:b20d:6f27:5460%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 08:42:43 +0000
Message-ID: <55f8ef22-9581-416e-a446-59660390818e@intel.com>
Date: Wed, 18 Nov 2026 14:12:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/i915/dip: Write the DIP header last
To: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
	<intel-xe@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>
CC: <stable@vger.kernel.org>, Suraj Kandpal <suraj.kandpal@intel.com>, Xiao Lu
	<xiaolu.xie@intel.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?=
	<ville.syrjala@linux.intel.com>
References: <20261113074849.30768-1-chaitanya.kumar.borah@intel.com>
Content-Language: en-US
From: "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>
In-Reply-To: <20261113074849.30768-1-chaitanya.kumar.borah@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0176.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::11) To LV2PR11MB148960.namprd11.prod.outlook.com
 (2603:10b6:408:40f::21)
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB148960:EE_|MW4PR11MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: 518d54f9-287a-4b57-6325-08df454fe993
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|13003099007|261009223027099003|56012099006|11063799006|260925021311599003|260925021911599003|261026140227099003|260925022911599003|261102123227099003|261028144727099003|261022075727099003|261022115727099003|261021123027099003|261026121527099003|261021121427099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info: hdZk9jejNQVUP3KXZ4hAeHALOtVnB0zD3iSitNheTomgrq0ZVU0bQdayGR3WSli4je3tS5WVZIbD9O5K+V0XU1UGonmFrBPLvIoMDte1X/WxewT7/uU7Fba3T52O01EktIm1eyzPbWdb4DQ9U4ywkS2Kt++saSYB95FpVEN5ItQIKsEzlAnFKAHjZYaLebcem62egwbLXCIUSYU6wwYwZCVyv9+jcwp9XWNN9yECL4gEPW6WneY09dJfIH6TrJIJ2taZjGn8jFrrtdJcc26jvThlv4Rjf1752+klkbla06xbka98aK0IXesiybg6BOxIfbcSqzH8/ZZAdH5KphyLs3poMzx7S6f98t9Oq5/0qkI5XaI9bhFegqTRC3y9+rYmYlHpNfi9zQReLpJjs7xlcvyj94VjYoPiQ/ErAmVaYlxi1Jm3c07wB2jBIQdXwq/riY8IjjOsORt0zxB3W3tA6dUTvTlWlt8GCZItxReLT3NoHxFcNkcC40Mw0wl45CdMQ7Ube4LJUYhjEomSpz6xaFBBCsZj98cRzo92qVKwv99yxEb5ZItDXE6/oBNCdfuI15nELlVolu7iKsPEnMmhwswqaoLpd6a/mxzSnGYLIKc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB148960.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(13003099007)(261009223027099003)(56012099006)(11063799006)(260925021311599003)(260925021911599003)(261026140227099003)(260925022911599003)(261102123227099003)(261028144727099003)(261022075727099003)(261022115727099003)(261021123027099003)(261026121527099003)(261021121427099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1E4ay9MN3FrYnFqdVhaaUhROWpveWRaOS9HZE1HZFJ0cG9YVmVDUFJ2a0Fh?=
 =?utf-8?B?dlIwd2xVYldCSFU0cCtlT2oxclEreWJ3RU5zZXdCM0dRUnZPV3B1QnNSYWtV?=
 =?utf-8?B?SlR6U0xpYWZQdHFJQjA0NjJyeUdaREw5ZEYxSmhkc2xVNDhWQ0d0SEV5ODJL?=
 =?utf-8?B?SDd6Y0VoRDlZMGFzaDRnZlc2ckpKZUtSQjQxNVF1TDdKSDI0RWxvR1ZXZzBC?=
 =?utf-8?B?b25ndndRWmdCazl3T1Rpc25CZENxSmkwMTZZbEt0c05SRTkvZlJZR0JvU21B?=
 =?utf-8?B?T0taTkhTZ1MwSHp1U2Zpb2RsaXJ0QllDa0tIcXZrMWt4UHZBeE1TN2lFWW5D?=
 =?utf-8?B?SjFiRi9pN2RGT3lrTkJ3bzJ5dTJKYTFROUNlYXFGaEh1YlZPOEgxL0JzUTA3?=
 =?utf-8?B?QXZXTUI5aEpKM0Y1YXdQN2xLT0cwMTJBVjJiQlpqMnhPRVpYb3VkT1preXl6?=
 =?utf-8?B?cksrWGFHMkhoWE4xQzlLNFlqelNNYXd5MmpQZ0kxY0treGdlVDBYZUZjdFMw?=
 =?utf-8?B?WnNOdnZ1cFhQbTFNdzdvSGZCeGd2dUFra3l1dnI4OEE0cmRKQWJxK3pTZENR?=
 =?utf-8?B?UDFQN1diYVVjZjQydmUzOFcrSXkzNm41TUdiNjM5OFZnZXZSTDZrdFZFakw0?=
 =?utf-8?B?NzVCcTFGY3g5Zm8vd2RVMW1RUkdZanoybTB5NE5SSUhRRklVeFNOTG84RW5T?=
 =?utf-8?B?SG1JSjNVRllhMUw1cUhqZ1phd0daU24yY1Nwc1Arc1I2cVhseHhmQjFkM2tk?=
 =?utf-8?B?WDdZNXNFZ001WFd0OE5USFJYSlBQcFZ3bm1UV0c3UjUxUUpJTktXVDQvQ1lQ?=
 =?utf-8?B?aklKY3JIclZMLzRtUERMbUQvOCswQ21iUGNIdzEvNzRBSzQ3ajVPUUtiRTNj?=
 =?utf-8?B?VFZIblVNWkdMRXRQMWM4N3FMaWQyVXU5cElLcmJrYVZweWJtZ1ZmNE90eUlI?=
 =?utf-8?B?SUxCQ0U3dVM0bmZKR3pRcnVJQTcwcE1CVlUrK1JSazdQWS9kZGYrem8yTEFq?=
 =?utf-8?B?akVxcTJZbEJMMURZZ1NHY2JqY2I5dnJiZ2h6VnBqd1pnckUxeGRNZlNqRXhU?=
 =?utf-8?B?NGt2L1V1bGFleTdjTmdOSjFYaE9lcE54dVZyRXRnRUdhUmhvMWpNaEJjNnFa?=
 =?utf-8?B?QnVoYkhLY2dMb3lVeG0wT1huOFlmM0hrMFc3ZUtmcFZiSEQ3bzVJY2lCVWZ5?=
 =?utf-8?B?QUNYcnBLdTk2R1pvUzMzZUJvNHJwUUR4T3BJbmFxNWxCRC9YdGFDa1UzUGVR?=
 =?utf-8?B?Ynh2U2Q0QUJhWEVSQ0dtV0hZbE54TStYVWcvL0grWEpTVVFERzk3MXVYbzhK?=
 =?utf-8?B?SWhWSkRyMlg3anF6czYzaS9VbDl1dTVURlF0MVZ0NG5yOE40UDhNVzlaVUs4?=
 =?utf-8?B?eGlRWk5qRm1ZZG1uNU4zVjg4cElXY3I0T1JWRGFxVXBwQzlyMGRzeUtBcks4?=
 =?utf-8?B?RTIwbVVoOUgrWGl5VHV0WUhENUFnMEt0VlJMT09UeGNRVGhybUZmQ1NoSW5j?=
 =?utf-8?B?b1RzU1ZjMExJZmYrS2xsUDRPQWlBTmlORFhUYjMwZlBiVXluQUxlMjJFcVc0?=
 =?utf-8?B?YzdvcS93OWlLYm4vQkNtUlRRZ3NGQzQyditWMmVoMVk0UHNNeC9FQW1iWGl6?=
 =?utf-8?B?d0psNU04MjN0c1JDbHQ1bmJHTW94WElZTU5zRTRwTGpVME1OWHc0Vm1iNFBv?=
 =?utf-8?B?TTRFK3p4ZFRlOFM1Z1VsOStXNnJQWjNZR3NHSGdhTXJUUVBYb3YvYnNIMWxE?=
 =?utf-8?B?dFVtS0loRFVydkJXRkdhcUZIa0NaM2ozMU1CcVl5dGFrMy9MNDhwSjZNSGFr?=
 =?utf-8?B?RkFFdzQ4dytyWTNtb2RUbzl3UlhucDhpNlRlUVYwMUN5TExNRlgrb0ZmSXRQ?=
 =?utf-8?B?cjEwc09HcnZscWFvZVdqVWdRbXJCYk1kVXlyYzNmeENZK0VyeituVEhoNFhh?=
 =?utf-8?B?dUViaElPVzJVWmdDeldDdlhwVmNoYTZONnA5YzFKRzJPcGFmTGtqZEpDdGhr?=
 =?utf-8?B?c0hmZnNsNE9MRW9SNXdYMzEwNTFYZzRUQWVDRlZMOWNVSDZuclgxOVpiMnZ0?=
 =?utf-8?B?M0grVUVQWHRvWEhKSkxFblpHQ3FjSGllSGcwd3FLYTFpeWh6QkRvZW1NdmU4?=
 =?utf-8?B?UnhSMzRpVUVHSElSOUFxNzFxSUl6b2hnTDFNMjNQZElpWmFWbzlsckR4S1VQ?=
 =?utf-8?B?ZVhFR3RwZElqc2ZmMEZncWlRVWNQMWxYTVRJNkpIVXlzenV0Z2VodFV0ek15?=
 =?utf-8?B?NUtyeU9MWStra1hxNGl5RE85NjdyNkd0Y1lZdVo2K2JkZmFQV1YvNDB5S3BQ?=
 =?utf-8?B?c00wM1hlY1Q2S2tzL0ZmOUJ6VndiblkrWWtnZnV6cUozQk1rUFIwTmZzUDdM?=
 =?utf-8?Q?BUx2Vqk+r0vCgbwM=3D?=
X-Exchange-RoutingPolicyChecked: Mae0v9kBEdCv+AqTgFbwExlO/3/ceFunnfDV3CEKkYP9m7nLYdSFkUUiotHKl+CwWio/09PQk5zLCjLXigq0rDud6uEmsenYAB6LgicKkYzpM7aJbHDghmr7MgqJK5hPWR68T66uk1R2zj8gv4Yr5To+BbdRF7qT1rHoPDGW8JSJ/wHFfFfhj53/e5t2DNx0junMIDfVXJVtNwZ++3h6tgMHtN3dGPZbPIiPOfoR1vAWohwxNIeJyRPXEIvLQc879vMyHRmRf5n3xOPsRkDc6LIVmLvcTeTTTl+kggsRVCxp3aZcZzYvAiGUhqovVF3QDVE+FAMXs/xYbOoeuXUBlw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 518d54f9-287a-4b57-6325-08df454fe993
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB148960.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 08:42:43.4178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lZI7Ni/DzxtEPXHlFJ0wE2+DjZZX4qaXrP9cYaq4b4Kh777ArBqg198pZDP6R+NSuvNkFnEtbn2lAxZe01aRde1M2Y26nWKzVXN95/CTXeU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7008
X-OriginatorOrg: intel.com


On 11/13/2026 1:18 PM, Chaitanya Kumar Borah wrote:
> On platforms with SDP transmission line registers, the packets anchored
> to them are double buffered in the transcoder (TC) clock domain. The packet
> registers are in the core display (CD) clock domain and the whole packet is
> clock crossed on the write of the header (dword 0), so Bspec requires the
> data to be programmed first and the header last.
>
> hsw_write_infoframe() writes the header first, so the packet is crossed
> before its payload is in place and the previous payload keeps being sent.
> This hits the AS SDP, and the VSC SDP whenever an AS SDP is enabled, which
> is whenever VRR is possible since commit 6a1712052859 ("drm/i915/dp: Enable
> AS SDP whenever VRR is possible or PR !async"). With CMN_SDP_TL, enabled by
> commit bfa597238073 ("drm/i915/dip: Enable Common SDP Transmission line"),
> it also hits the GMP and VSC SDPs: on NVL, entering HDR on an eDP panel
> leaves the image discoloured and scaled until the headers are rewritten.
>
> Write the payload, including the ECC zero fill, first and the header last
> for all packets. Packets double buffered in the CD domain have no ordering
> requirement and Bspec recommends using the same order for all packets, so
> use it on all platforms.
>
> v2: Always write the header last, without the platform check. (Ville)
>
> Bspec: 75640, 71197, 74384
> Fixes: e1123e617e51 ("drm/i915/vrr: Program EMP_AS_SDP_TL for DP AS SDP")
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/17732
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9746
> Cc: <stable@vger.kernel.org> # v6.17+
> Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> Cc: Suraj Kandpal <suraj.kandpal@intel.com>
> Cc: Xiao Lu <xiaolu.xie@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>


LGTM.

Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>

Thanks Chaitanya and Xiao Lu for finding this out.


As per the discussion in the V1 version 
(https://patchwork.freedesktop.org/patch/768289/) :

Xiao Lu, the VSC_SELECT clearing is a good catch on its own. It can go 
as a separate patch on top of this one.

It may not be needed for the gitlab issue, but seems like a correct 
cleanup to me.

Regards,

Ankit

> ---
>
> Notes:
>      The same ordering change was posted earlier by Xiao Lu
>      (https://patchwork.freedesktop.org/patch/763779/), for xe issue 9693[1].
>      
>      Fixes tag rationale
>      
>      The Fixes tag points at commit e1123e617e51 ("drm/i915/vrr: Program
>      EMP_AS_SDP_TL for DP AS SDP"). The AS SDP has been written header first
>      since it was added by commit 8845021b7331 ("drm/i915/display: Read/Write
>      Adaptive Sync SDP"), but EMP_AS_SDP_TL, which holds the double buffer
>      point and the transmission line of the AS SDP on BMG and LNL+, was only
>      programmed from that commit on. From then on the driver relies on that
>      register to anchor the AS SDP, and the VSC SDP whenever an AS SDP is
>      enabled, and the programming note of the register asks for the packet
>      data first and the header last. The two later commits cited in the commit
>      message only widened the exposure: the first enabled the AS SDP whenever
>      VRR is possible and the second added CMN_SDP_TL for the GMP and VSC SDPs.
>      
>      Alternatives considered:
>       - 6a1712052859 (v7.2): AS SDP on whenever VRR is possible. A PTL report
>         [2] is fixed by reverting it. Narrower than the spec argument, as it
>         only covers v7.2 and later.
>       - bfa597238073 (7.4): CMN_SDP_TL. The NVL regression, verified on
>         hardware, but covered by the older tag as every kernel with it also
>         has e1123e617e51.
>       - 8845021b7331 (v6.10): first header first AS SDP write, but
>         EMP_AS_SDP_TL was not programmed until e1123e617e51, so exposure
>         before it could not be shown.
>      
>      Not verified:
>       - The failure was observed locally on NVL with CMN_SDP_TL (rewriting the
>         GMP and VSC headers makes the panel recover). The AS SDP and the VSC
>         SDP with an AS SDP on BMG, LNL and PTL follow from the Bspec
>         requirement and were not reproduced here.
>       - No reproduction on kernels older than v7.2.
>       - The HDR test on NVL was done with v1, which only differs by the
>         platform check; NVL takes the same path in both versions.
>      
>      [1] https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9693
>      [2] https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9746
>
>   drivers/gpu/drm/i915/display/intel_hdmi.c | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
> index 4ec0db8d93fb..66149aff7993 100644
> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
> @@ -535,18 +535,27 @@ void hsw_write_infoframe(struct intel_encoder *encoder,
>   	val &= ~hsw_infoframe_enable(type);
>   	intel_de_write(display, ctl_reg, val);
>   
> -	for (i = 0; i < len; i += 4) {
> +	/* Program the payload first, the header (dword 0) is written last. */
> +	for (i = 4; i < len; i += 4)
>   		intel_de_write(display,
>   			       hsw_dip_data_reg(display, cpu_transcoder, type, i >> 2),
> -			       *data);
> -		data++;
> -	}
> +			       data[i >> 2]);
>   	/* Write every possible data byte to force correct ECC calculation. */
>   	for (; i < data_size; i += 4)
>   		intel_de_write(display,
>   			       hsw_dip_data_reg(display, cpu_transcoder, type, i >> 2),
>   			       0);
>   
> +	/*
> +	 * Packets double buffered in the transcoder clock domain are clock
> +	 * crossed on the write of the header, so it has to come after the
> +	 * payload. Packets double buffered in the core display clock domain
> +	 * have no ordering requirement, so use the same order for all of them.
> +	 */
> +	intel_de_write(display,
> +		       hsw_dip_data_reg(display, cpu_transcoder, type, 0),
> +		       data[0]);
> +
>   	/* Wa_14013475917 */
>   	if (!(IS_DISPLAY_VER(display, 13, 14) && crtc_state->has_psr &&
>   	      !crtc_state->has_panel_replay && type == DP_SDP_VSC))
