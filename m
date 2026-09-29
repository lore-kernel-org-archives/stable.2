Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146A63E5A08;
	Tue, 29 Sep 2026 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790698742; cv=fail; b=iu4NB4hKddO2yHJGEoWKrreTtk1ANVqxw+F9J+Wmfx4J+A+1i447o9bf5se8R3cAFa1t9pB/F7u3X0izLGghiTNhZxgZTKRMDWryfouPreMlul2J5Q1sD7SZVEr4TJ1QC4TWNx2S5m3Zcbag9cn/NrmW7B9jdbzAzPm7y7Z9rwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790698742; c=relaxed/simple;
	bh=UmebSsfMUW+uEsUx20RopM9MunFn2pDZyqwkWixDw1o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U1I3Aw1+qyYeCYML/Qi78dcKfebVQanRgkrnH6NhwZMr/0a747j4/fVJpmtF7Z/0+Kv3uLLdjbXIrKYpc37k4LBQO4ENK/Z6gO4OHSo42J4/GqVUtt1qXvCfmYNpppPE46Q/nS7brP6IPNP8pVAyjOMCe4a5b2uKqkpUkWlyksU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=npvkcX09; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="npvkcX09"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790698740; x=1822234740;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UmebSsfMUW+uEsUx20RopM9MunFn2pDZyqwkWixDw1o=;
  b=npvkcX09rmRZdi90HfX/eBRBZekRmSWFRlaPIhcft/uLd+NmVWh7qzvv
   pRKLV9QVc2HYE96Fch53c3Ou3qP707VYU68HiWhYm/r/q2G8WfMsIVMXR
   yNpUM0ZPvfrWNkvSER1bLRsJLw+8jbFVRkFHk0lGuvfe+zBl75HAwg6y0
   7DTm/S2cfmxS+iFT1UcnJUuMRovXrUpeSAVwouwhS23qP17RU3L4S2hp0
   TTwmQhx28eiDv2NBJogsNFNBorV7UBOo8lf1VN52Uw9wf4kIgUwEwwOie
   s7Y8tTZK1kaTPJqse8EXM9flUm8l3HBawDdZcB+iKX33EnELP0mrCyoxV
   w==;
X-CSE-ConnectionGUID: ez3JpX2ySvmOPhgNIOa+eg==
X-CSE-MsgGUID: NcUfb8+tS+ipORe4C9vsXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="91443363"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="91443363"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 09:18:57 -0700
X-CSE-ConnectionGUID: IGnjlwEaRH255NIHb5ZxCQ==
X-CSE-MsgGUID: eug5DvsETV2+OgsvVDawrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="301680729"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 09:18:57 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 09:18:56 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 09:18:56 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.10) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 09:18:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qgUr5hV0C4ZX0KzmZJipfaEYXV/LItOrh06FKZ7+7BrGRCr0X/0w/dxVc0ob7JA+WM5fue5a41FxDXMo3HKAH3n3s1BAzrUY49yAqloaNA0YR6hMvfuZbK535CpNuyGVJx4N6Lu5EQD2jBWh8GZgBzVAwTJ7j1x1t2dvRz/f0Y6/Hi4CKHf6dHD0LvzDX1S43ZnRHOHpcZxx3H1GfGRnrRXLNtQJy7KkPG+Mx10bYFI/pwIU7DgUaMmFB7ECrOidWnF2CYd6mXEgS2nPFyVq6QjyUG95dakU6DLYv4HpDJSAvNBfcescvt+mL3I+kIHXLh6iOXyfbcYJTAECMylD5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jU+GMOfkUosapmqaQw/tP7eHdRa3pRKgDcxpJeHTcJw=;
 b=Nas11f14V5Iya0/voN6UkkK0xfn7V+zcX94iF9vwoO85cxrplJpIZozDDjNpO8BfuLjj4D8GbbK+dddmrP1VcBk4qRW6KfayimH8IBVTdobm2OCasCrn8acgX1vm5McUlaFQbJ7Ws5krqpdIAoCUy4M53hE5MIselEy1Y/uQqOXKFVGLm66CHLjzu+f/hps3+KxBQzVwkzMvaAwJ80vszUsvhKJRJx1oXZthC0DH8r6uwn01yzBiLF8m9Pou6RIzaUlpPnIjBkHvbG6/+tDdgO+VIyrKIldI5M1wOoJYB9ZIZyXS24H2VHPCbpCSHaawEPZNNVy9/LmEa/yA0vzihA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by BL1PR11MB6004.namprd11.prod.outlook.com (2603:10b6:208:390::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 16:18:49 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0451.014; Tue, 29 Sep 2026
 16:18:48 +0000
Message-ID: <ab87c498-b1c3-4d0d-b4ba-57e1826592a8@intel.com>
Date: Tue, 29 Sep 2026 18:18:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 6/6] iavf: cap advertised max_pkt_size at the
 single-buffer HW limit
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@kernel.org>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	Dave Butler <david.butler@appgate.com>, <emil.s.tantilov@intel.com>,
	<luoxuanqiang@kylinos.cn>, <bryan.fraschetti@canonical.com>,
	<tristan@talencesecurity.com>, <tomasz.lichwala@linux.intel.com>,
	<horms@kernel.org>, <stable@vger.kernel.org>, Jacob Keller
	<jacob.e.keller@intel.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>
References: <20260928230429.495442-1-anthony.l.nguyen@intel.com>
 <20260928230429.495442-7-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260928230429.495442-7-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR02CA0005.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::10) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|BL1PR11MB6004:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a0052a-612f-4930-6862-08df1e45579d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|23010399003|22082099003|18002099003|10067099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: OW0D4QFQVtwNrB7ZFiDaKYRPRZgnRTh3QiFyWzcPz+Hu96kGSSoojspQVOeCrtq4yfp/hurGnSFYE5C/FxEKN6jvYy5Lkz9UmSaZS5qyj/RAW5TbJIBqD9V2BbkamBcIjOjywrxrJgnxljUoXIXabGN3n9SsP9rnfsoTk3igDfk/K9PCUBsNfBHpIvyJUAjeZ3vQFOfmC7NvYSTaPWWAyES8xjqfw+Zxe2a8Ro18CzcViDHSv7TEhvLZ4Lx6iK32y/cbnVM4Muf8io7iuvmZMhmZqFk9wTCvPV3ndzzzbCZeBhTzf62xdFPUAoHBUkNODD/T+sdd2oOOSn4gZxKd55NiZuS+USoImyBEECh9tBPLvj4WH5a7MEz2KH9PO9q3HoKoj+IZVXLoOwZMo6IY6gcg32XTTUlYPdwXPbKScY520WlU8rfXh1mNWEtCvSleyYDzUbQ2+/hJ9ZguVbqaDt3+wb8BYlNQez8iQk0viV3HzkytxVr+raZW7/9pfiYVuCzpm6tb5R0A55vwlfnNO9w5l65UpZegbjJSgoIGfM5VNe4YMGUhbl6zXM3qS1acv1AG7M7SPAP7IcgaUv+7DM+zQ9neCybSE3025GdOEZMcrlZixpr2BfU+WJ1Hw8b69smbGdg4nddxFLscSLmT93WUWHKmuwnvpb2Hvg5UASo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(23010399003)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dElrbHE0eHNXYU5FYTlDcVBSdW52cXd6Q2VGMkxuTFFvLzh1czVhSWFvdVBF?=
 =?utf-8?B?d20yKzZmWE40aU82dXphL3BOVHFYb3VKeVZPeWNQcEt6cFdUTWdwdEJRWFZM?=
 =?utf-8?B?YTZPNWxOVDRpNzJ5c3VDeTVuWTZQWjBaQlkxZHFoZTZwNEJTRTRwSkh2QzVq?=
 =?utf-8?B?cVk0TzFOajJKaWk4VU13c3VIemdCZGlLOW0zcVc3bG43ejE1YXc0WDZOMTdp?=
 =?utf-8?B?MDlxQUdnbWN6NzBqMDZ2WjMyR24rZE1NanYzeEtpMW0yekh5Z2J5ZVcyNG8z?=
 =?utf-8?B?UVF4QlRONm9KL3M0aElUdzlYNGtXNGxiNkRPbjJIM2NMWnF6d0t6cjV4TU1K?=
 =?utf-8?B?SmVpZ04wRFFhMzFMZHZqcjJ3M0tkTHBOYWtCenBxTWRTNlZ4YlJYeXY3anZa?=
 =?utf-8?B?eDlqMUxYYitObkVyWEo3WStQekU2MGdXbFZrOGw2NGFlRktMQW9JV0hXb01N?=
 =?utf-8?B?ait2ZGtyU0E5bnV4WlpJVUliTGV1OTFwb1h2MEZkVzlUQVBhclFHQWY0akZL?=
 =?utf-8?B?bDR6OFlaOUpwR0FIQ0lyZmh0QUxtNGY3QUNkOUV0Y2g4S1MyTTA5TWZhWmpy?=
 =?utf-8?B?eHhES1NadUxxdEE2K1VJL3JKOVN5SGxJbnVWVjBvWEVpZzNnaVVrazZLdmMw?=
 =?utf-8?B?TU5QYklVbUNlZXhnQXdpWnljM1I0QnpaaXdPYUVyQnVvbGMwenBrTm9jQVdp?=
 =?utf-8?B?Q3NDaU1BRTdOdlZFNmxoa0FESWJmcG5jTExDTm1xYVBtaStmbTFLV3d3WHlk?=
 =?utf-8?B?QWhaVDNxSCtyU0V1WjFPc0ZRd0RNYnBuV0l2RDRITjZkRVJJeHpyakQ1OENB?=
 =?utf-8?B?SVEyVjg4UlFhSTBMTmJnQXdOem1LMG5SUjVzejJzTS9hWmpyK1JLeERUSGJJ?=
 =?utf-8?B?Q1NiUEZNSXpQTXpsRG83Uk9vZ0RlNWwwcnBPYnNscGdzYkpZQUh5blhheFlC?=
 =?utf-8?B?bjB4aVoxcHhSY1NMVnF0Q0ltWG5hSXJ6SWUvako1eEpwTThGMGxkc3B3cVFQ?=
 =?utf-8?B?U1l6WmVaM0lGcVFiblNWOVpwRTVGY3ovQUZhd0loRkpWL3U1bmxMeWtMa0VT?=
 =?utf-8?B?VzJ0R3l5cDlUU0E0UVJkOE45SnJyOXhFSkNLaXRHd2NVckg0ZVVDVFFjRVpa?=
 =?utf-8?B?a1hZTDNlbEt4TkRSaE96NGZLMGw2M0RnbytPbWNxbEI1TmxqTWZtQ0xxWU9v?=
 =?utf-8?B?a1RxeXZhM1A5ZFdVQXNQcEJueDA4bmE0ZnQyZFhQOUNCbTQwUk9VdW5vbFNQ?=
 =?utf-8?B?UTcvT1g1ZkZTbC9Qazh4UHZsZlhFZ1lhVE5RblRnNE10bFV0MkJudlBwQWEr?=
 =?utf-8?B?YnVnVE1IRUhyR1NVL2hwUS9tb2cwejQ2WnBRL3UwU2t0SnhqbURQV0I5VHJT?=
 =?utf-8?B?bmV5MDViMkw1NmZXK2pxT1BGUnlNWkNPU0dXU3B3N0xqc2t2cXlIc3hOLyti?=
 =?utf-8?B?QU5kcFZnMWs2MjdLMW4yRHpmcW94bHN6bG9aUVZnOG1HdStxblMxdzRJelhy?=
 =?utf-8?B?L2pGbnUreFBhK0FzR0I0eHphYi9VNkYyU3JQWUV2dmxBWjJSSDFtZEphV3Qx?=
 =?utf-8?B?bGtrWVd6bEpQbWZ1OStwcURNR05YTWNOR0JBZEhTVUlNaXR1KzNIMFp5MXhU?=
 =?utf-8?B?enBEYytFaHlKYVFhVTlnNlpzZ0pjdmFReGRnbjU3NVo2Q2JFVmVIUVc4NFUx?=
 =?utf-8?B?ODNVdEltMVFJR2ZaN0JlMlpFQ25UdklzR2FLUDdZbHJTNTA4dWErK21WT1RF?=
 =?utf-8?B?Znp0V256QVpDeElidkcvQ0FCTFZJVWlXdlNXUDBHcy9rZUgwUWRCSTkwcTZt?=
 =?utf-8?B?aXpVdWNsZmVZNWRKYURhbk1SYXVBMlMvcVptSDkvUXdnNXYycDZBVG9vNngv?=
 =?utf-8?B?ejRzTlhUaHR6SUVwTmlWK1RDUUg2MC9CYUpMNFE5ODNSOU1DOFlLN2RtRkkv?=
 =?utf-8?B?U3JQcGZ3TUE4ZUFHbE5CRnZ0YjdnSVdtTzlTLzZORFJkUzkzSGxmNmN6aC9I?=
 =?utf-8?B?OHk4c2RPTS9ONGp0Y25wWFY4eW0xeStJSi8zRDE0dG83RWtETFQza0J3M2xn?=
 =?utf-8?B?VDBXWk10bWJsSjdjOXZ3WUFETDlvVkJBTDRsOHlWTlF4a3hIcUdhUTg3cXMw?=
 =?utf-8?B?YzF6SVRpN3kzM3IvKzRlTloxOFh0bDFaYWVNREdVQ0VnbGx1SksyYVB4MFRU?=
 =?utf-8?B?WHNPQlpzZ2dvbVovbytuSG5xV04yNzRhV0ZsVFNjMGRneTFXbFo0YWJXdjlz?=
 =?utf-8?B?bWR0dTZGekthaGsydzZKSWl4LzgvNk9uUmVHclBrVHMzc1VpTmY1Q1dNVGw1?=
 =?utf-8?B?d2xFeGlvZlBNbnhFL0M4SGUwT0hJVFQ1T0lJM1hVRk9zaUFhalZXUyttbURD?=
 =?utf-8?Q?voDFa3jXPiHlkaPQ=3D?=
X-Exchange-RoutingPolicyChecked: 2SoynH1wtyBzu2+zJ2AGboPuFBO1pwL7T7/ArI9QxzqFdtdjRqNfZXbnrir44TE7Bn+qAlr8va9Q9DSsYKXe177/mKbxaj0Dfe52abE50Zpsxs9BVuWbadWiwFMuOgVMtZTcOh0kQYVInQwmukp6Ayc9v03ikPlZah3kZTqi513lV7MaNA+6i0fMhlGdCUDQh2OUDQPq73MByMbP0WuYd5s7dQjYbv0fKe7emEWHFrEBasGIPAhhQUL/vLMXqqfnHPcVtFuniAnXc8Ej/Lc9+yD4PcOe5uJMVs/z1sV7VyIOEkAYA3Ih+vZQ0QqT2UX5+bSG7hjxgBQHA5POM0RGWQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a0052a-612f-4930-6862-08df1e45579d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 16:18:48.6778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tHg7qyKTogI1jf+yC/EmaG+QqINeutQiVZUz6ySkTXUnB/jvnQPpr5aYuvJ8lrHK4hk/Yqk47RC5hnJ2phiQgqpQ4IwHshZHiY352MXh5D0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6004
X-OriginatorOrg: intel.com

From: Anthony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 28 Sep 2026 16:04:27 -0700

> From: Dave Butler <david.butler@appgate.com>
> 
> Since commit 5fa4caff59f2 ("iavf: switch to Page Pool")
> iavf_configure_queues() advertises max_pkt_size to the PF as:
> 
> 	max_frame = LIBIE_MAX_RX_FRM_LEN(adapter->rx_rings->pp->p.offset);
> 	max_frame = min_not_zero(adapter->vf_res->max_mtu, max_frame);
> 
> LIBIE_MAX_RX_FRM_LEN (16382) is the multi-descriptor scatter/gather frame
> ceiling, not a single-queue value, and it exceeds the E810 MAC frame size
> maximum of 9728. Per the E810 datasheet (613875-009 section 13.2.2.17.1)
> the Tx frame-size register PRTDCB_TDPUC.MAX_TXFRAME has a maximum of
> 0x2600 (9728); larger frames are discarded. The in-tree ice driver encodes
> the same value as ICE_AQ_SET_MAC_FRAME_SIZE_MAX (== LIBIE_MAX_RX_BUF_LEN ==
> 9728), and the VF clamped max_frame to IAVF_MAX_RXBUFFER (9728) before this
> commit.

[...]

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> index ec234cc8bd9d..680a28a739bf 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> @@ -382,6 +382,14 @@ void iavf_configure_queues(struct iavf_adapter *adapter)
>  
>  	max_frame = LIBIE_MAX_RX_FRM_LEN(adapter->rx_rings->pp->p.offset);
>  	max_frame = min_not_zero(adapter->vf_res->max_mtu, max_frame);
> +	/* The PF programs max_pkt_size into the per-queue Rx context "rxmax".
> +	 * LIBIE_MAX_RX_FRM_LEN is the multi-descriptor (S/G) frame ceiling
> +	 * (16382), but that exceeds the E810 max MAC frame size (9728); some
> +	 * PFs reject the out-of-range value with VIRTCHNL_STATUS_ERR_PARAM.
> +	 * Cap it at the single-buffer HW limit (== the MAC frame max),
> +	 * restoring the pre-Page-Pool behaviour.
> +	 */
> +	max_frame = min(max_frame, LIBIE_MAX_RX_BUF_LEN);

Shouldn't we cap it to 9728 instead?>
>  	if (adapter->current_op != VIRTCHNL_OP_UNKNOWN) {
>  		/* bail because we already have a command pending */

Thanks,
Olek
