Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4C93EB116
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785854384; cv=fail; b=gEAnHW3jPq0jpDTkZAIhisBPujPuFE4HoSqPLyjyVmJJLDtSmu29qPI84S6JY0juAJbT5fOPId+RtpJ609UmRDBvf46g+u5/1st5Sag7azlPFliijDt9ATxrR8RJvG0jcrDYO+gX3zYfwgi/ugs0Fvi0BjTdVYKrEBJAmRzEzYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785854384; c=relaxed/simple;
	bh=QQmv0eEvzYIoZJ9DBFJNghi4zywjejTI2Uop/5Cc6Yk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F3dx52uBR9d+jGr6Mrb8dQuoJJya+Y9Xs+NdAzylimdFswkRMRZ+HJSnDUbIG/D+lFadvD2AbGmoWu007IoVovdACWvLjaaFnbCyS8Tw5AarR5ckPbAUrNOBV1TpVYDve9mqOKnskj4B/Q/EeOBvh4rB0Z7CGifbsK33Kzke9Og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C5Q++HWc; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C5Q++HWc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785854382; x=1817390382;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QQmv0eEvzYIoZJ9DBFJNghi4zywjejTI2Uop/5Cc6Yk=;
  b=C5Q++HWcZDAJeL14g0/fs+M+EThDEo/klbK78go7TY5181vxgVvzd0zU
   QqvRT0oezD7khSgBZxyvpZkJvl9zmN+YED0QG9dzIRZliW4d1Jcn8P3MC
   yr24g99dyZ5Q6qd+9Iv2CZJsWb7tPSwPbOmIaBAJBX3OqMvJ4F/p5V9yo
   aW973qq5lAeIkoW30h3h5O75dxRmDGMUG6suWVbIM53bClUWdXt3rf3gs
   PqCzdVsSqDacDd2tVZaxmmJsc1LhlfrntYVF5xlI+l2pQdQ0V20dDEDkj
   //oYuM8wOMvMvjqTS40zX0cw+eoHnC7YiLbm37VTN81sQ0KMX6nnDRngB
   A==;
X-CSE-ConnectionGUID: EV/9crHoQyat4XtB/+8+XA==
X-CSE-MsgGUID: G8ZdddC1Tum38Fa7vHx6kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="73943920"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="73943920"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 07:39:41 -0700
X-CSE-ConnectionGUID: ldaaSQIfRzaOutdPZj5nsA==
X-CSE-MsgGUID: 6o9q5Nq7QWKo320YS1yIrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="265355749"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 07:39:41 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 07:39:40 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 4 Aug 2026 07:39:40 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.29) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 07:39:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zM6a/hWX/x+AYbsWxK+w3ubQOaub1ECfBbQgh83kmT2Jhw89t7m6bmwMU0T8XzyKBVdgPuKEYfVRrUZeNlYs+d1rUpleaB9MBY51xjNZ/F+qxfL/SDjQz2X1tConOJwuuQwOBxFdk9REt38TT1rhEaLVi3GOd7v4sA/uSNHvyDbTq4On6pkTsSGBL0dkXeqgTD9kMCMymp4NZyJPgBSSO3jLbjUFe5T+8m1lzBLnYeLnagI8/zN51QNXjodfM5KYWSOLxj6AKq4AmNv2SEl+dKwFz+UdoRWGrBrFtmMI3ZAgu1uSMGfBca9mjVXJPTARw7vHORtJsHw7JzWPtRicYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gqcW3Jwcy4gM5KVmkJcaP//DlM7+J0Hl4S4890E/eM=;
 b=bdwC8NJ3XsU52DLG/rtak8PYktHX63edbr6kaDL0HG+aZZmfyDLjXbdf9rFzDLyaIxtLI6W/7w1U+LiqJBYsv7xLxEyYez9QHaI0B+CFtFBOqRVWlu2RCNWCiWnhCTwSyWYXyeBgYQ65K4wBuGE1vl6tNinMojuX2Wy6isDyw2ofSD1D8rLADaPUXBg6PfvbLNinQ7ZIfPmtGeCZBMt3MRWuPD+Q0w4BPIkjej1ubZeueuAINa/isHOMCwKe+C3FPt8uXeIjFYC7lI1bQLLIkE2bE1X5I4vsiVRpuXDhsePwR8WUb3IuGy7z8FmSzjbUcRaGtnD3qhGhchjKInA8sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7636.namprd11.prod.outlook.com (2603:10b6:510:26f::13)
 by PH3PPF25FF87461.namprd11.prod.outlook.com (2603:10b6:518:1::d10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 14:39:38 +0000
Received: from PH0PR11MB7636.namprd11.prod.outlook.com
 ([fe80::d611:6fa9:bc34:46b]) by PH0PR11MB7636.namprd11.prod.outlook.com
 ([fe80::d611:6fa9:bc34:46b%5]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 14:39:37 +0000
Message-ID: <86a66412-dc7d-4a01-85ed-c7bbf7014946@intel.com>
Date: Tue, 4 Aug 2026 20:09:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] drm/i915/3dlut: disable 3D LUT if unsupported
To: =?UTF-8?Q?Micha=C5=82_Grzelak?= <michal.grzelak@intel.com>,
	<intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>
CC: Jani Nikula <jani.nikula@intel.com>, <stable@vger.kernel.org>
References: <20260803214909.3076716-1-michal.grzelak@intel.com>
 <20260803214909.3076716-5-michal.grzelak@intel.com>
Content-Language: en-GB
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <20260803214909.3076716-5-michal.grzelak@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0133.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::7) To PH0PR11MB7636.namprd11.prod.outlook.com
 (2603:10b6:510:26f::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7636:EE_|PH3PPF25FF87461:EE_
X-MS-Office365-Filtering-Correlation-Id: 22da02d9-3b72-4223-3fe8-08def23635cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: N0ahtI4nhWjgPs/+R4incIDeuAxhYWejYpllwCxCsfLqiuuGeASA4WylANhgaIMeERr5Ga0Y09a3jMRpiKMiBQp61PGOK1TGzV/v7VobMev77EXqsfw0z/rpNP+lB6Yud00WOZcrTOrdtZA9evqoKPYFrW7VGuLI93oWt2XS6QMp/gxirkf/d2VWlgnO4EaZwGUz5/ISHeATyq+5I7bKiAcxDsBy9EhFrQhWXuPgSaVaR9eEaAk++PuTXxOGenV1zkf3h1GWoG93OUIE1db/JlJ9myio6PCb9kuYdGSYVIonV4iuI3jQc56DlpCCBH61TBITvFeq5n+Q3JJyna/6qMiHqJMIEDgAmrH3xrNDT3LOn8ZkjOycrIqkURx6t/gxB3he6y5LJGIxcH0cR1DHs/WL9AjW4IFL4U+BdZ7mdysLGJ0kYJy2bFsU6u6sWNs3Ch/qGPYKaFTEDs2hiGo/EVAoRn/aVVT4GNCLF5jnoPoyZtm1M/2RvkaHUYI55K1U/enCOCaukKtUB2b9AzpUKOThaEM7NyAHFkhHY6bgPIC2sbcY+axAzCX7tlB65NSwFclvot5Dlgril4uUNrYdpmDjJYLg20df9DML4uBrxLwsGYsAL5sEwQos8ntvr9R9uslf0iU2zieCQrgFdApOhVrzIoOohpsDDusZHRqSNuU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXZvM3owM3k3dHJnc2l2aldhWlBTMVlSU2FCS2JoQ094U3lJaEtQRTFCZHhv?=
 =?utf-8?B?ZlZxVUVlUlZnZHBCQjNCWkY5T1pmelRrYURQRkpEK3dNc1VjNURJcXRGc3dk?=
 =?utf-8?B?RjAxaW4wemEwZ1Vkb0ZjdGxFMFBwQ3NjVnM1dHFjRk1xSlJ4V0Q5L21Jdld2?=
 =?utf-8?B?RGdtcnJJbXhSeG1sLzc5dk1yUFluVG9GbGpRUkhpYnpiY2wyUHBuY0JiVnhK?=
 =?utf-8?B?cSt2UmloT29IOTQzd0NKSlFxbXVtN0VWWWgzVmJSZTJVcDV1UzlsRGVyai9p?=
 =?utf-8?B?cHUwM3lnM2pjaUpmRWgvRXkwckNBemxtUjNZa0VuamJyZmpYL1pvTWM2ZThS?=
 =?utf-8?B?czNNRG5rVXpNenQyem43dEJtZ25id3hjdVNkdThpQnVZeWZEMklIY2lBemx6?=
 =?utf-8?B?MXJLazJsVk9MYTN3SzYraHRDdlBKOU1DdkVIVnZKU0NxRStlbXJHdHJrR2pZ?=
 =?utf-8?B?cTJIS3A3OHI5TXZnZVQwTlRqNi91bTZROWIxTE5lVmh3Z1l6ZFdmV28rR01z?=
 =?utf-8?B?dlVQV0IwYzFSek5HMkVRYUtuTlRYZlNvMUVpTFFWYnBUWjYwS3pZR0RsVTBZ?=
 =?utf-8?B?Zm9yTCtuSGlRYjkxM3lNSmV3cTZMczVMT0VzUGxDcWN1U0VmQ0RHVTU2WTBK?=
 =?utf-8?B?cnY5MC9hdzhORm8zaGY3TDRqN3o5dXdzcGlTSlE2U1VDU1ZUdDZra2VFaGVE?=
 =?utf-8?B?cEJQdnBEOEdRUXlNRDk4Z1FIS04yb3U2WUJteWpjVjRFSU9CS1lqU05KRG9O?=
 =?utf-8?B?bnJROUtMOWZEeUVLeGIySWZwRGRJSVgxU2tSdkVnbUpJWCs0VkNxdUVScDN0?=
 =?utf-8?B?ZFlDdnlIeFlqbDFpRjhianBVYnpLV2JrbW5yVG55WmVuWDFqYnZpeEVwMThV?=
 =?utf-8?B?RnVqUVVQeVQ1OGxCL1d6enpQbzlOSk5uYmtOTkxBZG1TM2hwbngxWVduNGxx?=
 =?utf-8?B?SHJWdi9JVDV3L21EQ2ZIcEI4VnFBZThUTWtMU2lmV0ZqdXRDV1hMNHg3Z1Bq?=
 =?utf-8?B?dmV3NlNnbkNXamV2RUFXSVBzTENwSGRDZndOUTgrMFB6UGE4RXo5ZGFmc0FB?=
 =?utf-8?B?VFlURUdnZGRsa3UyOHlCU2FJZ1ZFU1NIaUNEYkVMcnhtOVo1U1JqSEdLNFVN?=
 =?utf-8?B?MjUyVlZHUWE5eDAzL1ozZkF2MVhhTlVuSlRyZEloTEVPZm1uS0NoeWZDVW1Z?=
 =?utf-8?B?YzlSSVZ4OGYrcmg0NURQVUswbTZrZ0dEaVJwSFdtUUwyS2FKYkFYNFAvWi8v?=
 =?utf-8?B?RVFndWZMZE1URGxtYXI3bmllbTJTdHFxa2tXZ3h1ZzE5dS9SVlg3eU91bVJh?=
 =?utf-8?B?YlpYUVdlMFhobWdLa0dpN1NkQU8wWlFGc21rRm9NUVVvZGs3RzZ5dUJRRVR1?=
 =?utf-8?B?T3RxYncyMDl6YkdwWG5IcUdaTlE2cHpsTWdsOXZBMFRFdkFrc3NCUmdJKytX?=
 =?utf-8?B?VUhZem9uSDFCb21MUjBBSnhqbFR6akpQSG1KMG42WjFFc29QU1p4ek1EdDNx?=
 =?utf-8?B?WTV6NFozY2F4eFY4a2Z3d2NXS0E2U3hXSU9ubWV3dm4zT0FrT2NCYUEwWDR0?=
 =?utf-8?B?OXRkZmdvQW11ZjhmMzQzbXQxMWkwbVprQ3dEN3FHS2FZRkJJWlowanJ5Q3ZI?=
 =?utf-8?B?OTd5RC9IRDR2cFE4a2J3dnZGODR6aG9STm02cHN0WHlHQWxsbE9uZW9pNHZX?=
 =?utf-8?B?Unp6Z0ZJa2hRSkQwc1oyRmI0Qzh5TXJSc0pHR2gwV0hObjdGY3plUk1MclN5?=
 =?utf-8?B?b2I3cnNIaCtNaitJZldCUm1UcjIzQzcydTZ5Sjlnd0RvMG1LUC9YZWFsbmtu?=
 =?utf-8?B?Y1ZEcEdrQXdGWHJMR3N1Um9kQUFiNmlkVWZFQ2VjNHlpaEhta2hYdGRJMlFT?=
 =?utf-8?B?c0VoL2hzZnFFK3doQldTNmthTkN5NmNjUW50UHlIaEFOMEJLRm8ycnpNRWIz?=
 =?utf-8?B?emc1TG12UzlKZGtZYW1XOHA3Rm1OL3ltRzFxMnliYm14akMvYWIzTTE3eUJl?=
 =?utf-8?B?MzRrWXd1ZWc0NlFNRXB0RFk4eWdQbW1ZMUxFdEhsbGNOTEh2Zzg5MEtoTGpZ?=
 =?utf-8?B?bHpUVk5sd0RqL012VEZCQ2hBT2VPSVlYdUZ4b2d4dDRKekVVV3NZM1VlZXc5?=
 =?utf-8?B?VllTTm8vbnhiTmNXc01tZjJta3ROZVBUNmJUbXFkSzlxL2VBbnMwNklXQUgw?=
 =?utf-8?B?ZjFvZTBVZ3Vmbm1NWVo3SFJMclBESDQweFhuMFNyayt3L2JvalBKU1NiRjg5?=
 =?utf-8?B?ZkNzZ3VWZ1hDYjhoMHBpZ0V2T0lJYVFIUjZOUTJJQXBjbmE5UDg4bnp0bThU?=
 =?utf-8?B?TU5mQzB6bktybWVaTEwvNTREYW5CUy80M09SU1dpbk41ejgvZ2VQaWJsVHMz?=
 =?utf-8?Q?bthZG5qdTF0oyvJY=3D?=
X-Exchange-RoutingPolicyChecked: FzDM3wRfw1ROkC3bilrkEGMEZGB4ocbLi7SRsTWRwhXC9dO56hE1NrS+ZJFwfoYgwWUzV7CBF2r9HsfrZPP8RzKFjj5eb5iD7yRJVlWkm2cjVNiSrALUHJJD5IvU6CY8fNVAUuEJofFtWejcrZHaOFc7aKMCEOqX+zmXw0JUyx+iLjoC6zkm+znVyfDTb1ZDR4tXzHrXPtf4BDaaFPar5G0MpaFtT3ai6eOxTgScdkASiz+BWoG0QHek73X8Yv3a8VBzeB3NjPXnTJztvCOzx0DPmP5rEJwJz/J4JIW/CpuLQy1i2Kv/SdeSQQze4m8ISRZjrtlGCtGRS+2ZYORXGA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 22da02d9-3b72-4223-3fe8-08def23635cf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 14:39:37.9131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UNX3g1aO8/sVVz9ksbIGxwPN00506RV3Ytlzjui5aoT/BDm4BVrNLhJtws9nP2V1Vsr6qYE8j+XWm6S62DLD2HmL8sC9Ctc3+XK7Dbr73M4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF25FF87461
X-OriginatorOrg: intel.com



On 8/4/2026 3:19 AM, Michał Grzelak wrote:
> XE2LPD_DE_CAP_3DLUT_MASK is defined but never used.
> 
> Check DE_CAP with the mask whether 3D LUT is disabled for LNL+. Reset
> has_3dlut if that is the case.
> 
> Bspec: 71161
> Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> Cc: <stable@vger.kernel.org>
> Fixes: 6d181a288e64 ("drm/i915/xe2lpd: update the dsc feature capability")

For this one you can actually add the Fixes tag with 65db7a1f9cf7 
("drm/i915/color: Add 3D LUT to color pipeline"), because this would 
make sense for NVL+ platforms where the CAP bit is used.

As for stable branches, you would need all the patches that adds the 
infrastructure for has_3dlut to land together. Not sure what is the best 
way to do it.

Other than that, changes makes sense.

> Signed-off-by: Michał Grzelak <michal.grzelak@intel.com>
> ---
>   drivers/gpu/drm/i915/display/intel_display_device.c | 4 ++++
>   drivers/gpu/drm/i915/display/intel_display_regs.h   | 1 +
>   2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c b/drivers/gpu/drm/i915/display/intel_display_device.c
> index a2bea5ac59cf..d4e52e627b34 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_device.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_device.c
> @@ -1940,6 +1940,10 @@ static void __intel_display_device_info_runtime_init(struct intel_display *displ
>   	if (DISPLAY_VER(display) >= 20) {
>   		u32 cap = intel_de_read(display, XE2LPD_DE_CAP);
>   
> +		if (REG_FIELD_GET(XE2LPD_DE_CAP_3DLUT_MASK, cap) ==
> +		    XE2LPD_DE_CAP_3DLUT_REMOVED)
> +			display_runtime->has_3dlut = 0;
> +
>   		if (REG_FIELD_GET(XE2LPD_DE_CAP_DSC_MASK, cap) ==
>   		    XE2LPD_DE_CAP_DSC_REMOVED)
>   			display_runtime->has_dsc = 0;
> diff --git a/drivers/gpu/drm/i915/display/intel_display_regs.h b/drivers/gpu/drm/i915/display/intel_display_regs.h
> index 740331ead20a..78b9e6008828 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_regs.h
> +++ b/drivers/gpu/drm/i915/display/intel_display_regs.h
> @@ -1773,6 +1773,7 @@
>   
>   #define XE2LPD_DE_CAP			_MMIO(0x41100)
>   #define   XE2LPD_DE_CAP_3DLUT_MASK	REG_GENMASK(31, 30)
> +#define   XE2LPD_DE_CAP_3DLUT_REMOVED	1
>   #define   XE2LPD_DE_CAP_DSC_MASK	REG_GENMASK(29, 28)
>   #define   XE2LPD_DE_CAP_DSC_REMOVED	1
>   #define   XE2LPD_DE_CAP_SCALER_MASK	REG_GENMASK(27, 26)

