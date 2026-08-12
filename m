Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9B736C0C8;
	Wed, 12 Aug 2026 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786536700; cv=fail; b=NFjtRjkLkR4gesVrTrGyWU4UQcmUtw6e6Dmw/DylaJ4YeBKiDByc3HUCfPi6tcm8Se6ncIzXiqQfl+DDPZP2imu+gyRnH1BTg6ItXu0xBLrDFCRuJK1ddHjIU+6gGTaenMir1k0awdCt/TBvWSmTxB81qKlkgpzj/p8xgKPvqq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786536700; c=relaxed/simple;
	bh=8h24SUFmbA9pTKxbli91b7AruPQrEDIk4UImZDUsqxs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pxmFlIWklX9lXo9BUr8EKjQeHyTzo1R0uw3kWBhfGIt0EsQCBNbgYMjqhZJYaA9tEk+AITwBu7H/nFTgR0XO4C8I73lDKlXXycnKFaaK1kPqYG+4AsYXTk7oCs1Z0m+taZ8EAoKNJY/IX0pe2My0iysEw5Mqom9roGiDlRskgnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JBChkQ4J; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JBChkQ4J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786536698; x=1818072698;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8h24SUFmbA9pTKxbli91b7AruPQrEDIk4UImZDUsqxs=;
  b=JBChkQ4JPScryO4Ki2RH9+6rNXPcM20EeVUb05oqUniv23NWqFOBm0dD
   ywKSYjVv9k/tn392/+hkx8LbXqueTXFDY6fT1I4VHgo1QEPxh4joJmjIs
   In95qbZCPlEmEPTqI9yMpxAsOlICaMlr9D3BmmdkizJJRsgvghcY7dm6G
   k3E+orCbKsaWSFos59maqV3wt2ivQf6JlQvEX71d9ylC2Cc+XtZE41Kez
   m8iwQiY4PFYdOh2koHp4d5UPFHYWC0r+tLVgj9uMSnuUsCyFnP2JwUuiW
   2WYfJ1l0AR5LapoHWLjP01nI+rKDRIFiPcs+mZKVFiA6DWl3AkHU0PJEZ
   w==;
X-CSE-ConnectionGUID: TeALu9ViS0+YIjHua/YllQ==
X-CSE-MsgGUID: 8yNiLNkhSpqWJNCfjqFP2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="86045693"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="86045693"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 05:11:37 -0700
X-CSE-ConnectionGUID: FL9anotQQqu+dc0uzitHnA==
X-CSE-MsgGUID: Mk+DH3AhSy+y/YJN5ZXLVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="263157745"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 05:11:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 05:11:36 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 05:11:36 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.51) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 05:11:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0veL/zliiqW+ehao8l8v7f3DsMYWw3Q4tHUS3qHrmQbRX/tkkdjQCFKWzrdcNQXOcM0NNymr0yMj6y1x1lWNjsFnIKtyObuKjmvS4g4ex5fBVBborW82cQiRiTvW3TI8Kk5818Gesb4/ljKB+LEEmcyYumXgOJNoz7+OrZDe0aBJVcTrgj1aeV3cYDwxHsMKem2JDxTWPSo9dACtvtZwFrc9pmADeyWiYDSH5azGMEqVtk6TyfVHmRYBp7YKYS+/BvwCfFU7WvdJJIGMeUyN/e083/T+CEE+whohmzSwsJwIQVnubP5hp+oGrbqFnHYdm88cdeiEoqj3lqanmuomQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKncw6thD+dp1LWT2IP5M2BPXHnr/+uGnJuffnFklmQ=;
 b=d47O8Ri4q8oBkqF9QmdI7B1ZACqOk1RtaBPT6vQ+jD6PkxTQTt7e9gtz/dLH39oqod9UT3gyLxhtlKfY6iylyd5vnkgGrepBTYrAirGi7T0GO1v2nl2r1sf2NQMzcYYResAq4atLWMM1f3HmwE/zqE5CVBPfsPWKZYnT/UC2y2DojK2EjdQiy5Y3KrjT3qjgSl8pdDIzmJfYdutSxr7Mp3V3wpetrLeoPSgg3SQFUPaRN8nBmwW43besaNeM+E/Cupg95o8FSg9mIdt9mc8+zeymbz9hw9xTS/pmyuHpHoe9jfTrFDryZZ4AB0DxsxguFZCIVUtpmoF/JKiY1AkaUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by DM4PR11MB7374.namprd11.prod.outlook.com (2603:10b6:8:102::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Wed, 12 Aug
 2026 12:11:31 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 12:11:31 +0000
Message-ID: <e7808d69-a2ca-4f86-9410-c80ed67977cb@intel.com>
Date: Wed, 12 Aug 2026 14:12:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 06/10] ice: fix stats array overflow via proper
 realloc
To: Jakub Kicinski <kuba@kernel.org>, <anthony.l.nguyen@intel.com>,
	<pabeni@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>, <doruk@0sec.ai>,
	<michal.swiatkowski@linux.intel.com>, <grzegorz.nitka@intel.com>,
	<horms@kernel.org>, <stable@vger.kernel.org>,
	<aleksandr.loktionov@intel.com>, <marcin.szycik@linux.intel.com>, "Jose
 Ignacio Tornos Martinez" <jtornosm@redhat.com>
References: <20260804222205.1580328-7-anthony.l.nguyen@intel.com>
 <20260806172037.2935748-1-kuba@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260806172037.2935748-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0027.eurprd05.prod.outlook.com
 (2603:10a6:803:1::40) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|DM4PR11MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: 18377480-0f6c-4916-be5a-08def86ad85f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|7416014|366016|376014|6133799003|56012099006|18002099003|10067099003|5023799004|11063799006|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info: MTKFB7jcY8iM/WN43uwywbc2+mz9GURmP88ok+5JfvOgCuaADn46RWQPr/F6Ukq+CDL/7R/M33rXpoVd9AbvkzPA610ku+LjJp2gbynSGfCqRjeXyXVc4o8nW6yNzSD+05yHYLK7vgtqhVcHQPB+ZaTPD2b1kRBrT79eXwZjRdxeC0Hd5QGnq+LUDPjs24N2IoIVCKdbeA5KvXUPpNQRaDkNr/5yAKhVkpyCzyULHPXdsWyGA7cUkj/ktAvvSLZdjeoYRnIFOtFZFRPSzwL2PJkBkza6ct7gxHiYs982qXIC31DoQvxecvGtFRrQPPpAbNAoUn1fFSVGi4BVv7xZEauQNciZSawzTljJi7Ajvkc9FhG/mFUR2ErlHEKDcPzAbNHbqSjf3M4NXyYq3sT1yj8S++vZYjKQjNYK28F7crDYPHc9G54YsrHOKl8fjSSv7w4Iqdf/0J4ajE5nzqnBK+NSt9L4awydUPceVxYi5jfcoIzaAyWpTaGJGbVYBdnHamdEnfX11LHzt7s2YFWYLoj/dm/IJJxc1VnjnqMzI2+V5H9R6so7dV3XdmDl3gWGICd1S0RT/TZaRQjGoGEQpmxDPBDpILTCaLrn+0v0r8omaWBqzbmTv9kfGqbYttXuYGO0qDF2yLBMfKURDW1MaWl+khJbyVZS8Safjiauchc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(366016)(376014)(6133799003)(56012099006)(18002099003)(10067099003)(5023799004)(11063799006)(4143699003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dStSUi9nU25uamZOSlVBdEJtUXdKMXEvb2tzb2lpN0RBWVk1aU85WW9zLzBk?=
 =?utf-8?B?bGp5S0lrMjh2cSt5Z29uSGIrcEdCME9hSUtOZ1ZNU2Z4VHd2WmJueTdPcXlk?=
 =?utf-8?B?bnNTaHBDZzY1aFE4UzNmY0p4cGJzRWJ6YnBrTUJ2c2RKZ3NpaHl2a0JSMFF0?=
 =?utf-8?B?eEFjTjZxR2lOS3VvblM0RGhYZFd2azdUTlEyS1pMdnp3WlR5MW1hV2FNbDhX?=
 =?utf-8?B?Z21RMDVwVlM1SlBLYzdkTU1nSE5kTGZZVEwyMHhISXpkTjM4aHVnV21TQmxo?=
 =?utf-8?B?TUZXTEpKdjg4S1IrN0J5ejJwOEhVWGlqYjhaY08rTk43UW5NbVI1NUx1bEFY?=
 =?utf-8?B?WVgrTFhhQUIveHRqSXUvbDc5M1h4VnVVOGpYRGt1U1JxelozQVZwOTFGbXVS?=
 =?utf-8?B?eXZyUjdzL09KTFZtSUZWbThEYjZQYTM4SUxrSkt6NjcxN3g0aDU4aitzWm4z?=
 =?utf-8?B?VkZMN0lDLzV2VE8ybStBdk1SLzduQk0wcm5TcjVKNk90cEdXQTVUbGtlaUpD?=
 =?utf-8?B?WHZLbFYzZS92Z0dJTXlubm5lU1czc3dKQk1IVUEvRjRIN241UWt0Q0U2SGti?=
 =?utf-8?B?ejlrdCtmSFE4YVFFZW91azVSSTVGZnBwRlk0Rk8xc0MxT1RJeVBjSE5Vc0d2?=
 =?utf-8?B?K0FJTmo3M2Jna082R01YWTVUOVlZRUhublpFRktpL28yMWo5N3NPcHcrNm93?=
 =?utf-8?B?dkJVUkhwYlZmQS9kb0pVRnpTVk10UFdrcW1OaHh1bURoZ2c3bURjUCtyNjl6?=
 =?utf-8?B?M0Eyb1BSVTI4dC9tdkViVyt2c1FmVzNsMTd4bk9NMGJYcUQ3VEFjcUpzY3dR?=
 =?utf-8?B?RnpwbTgwRUFpSlQ1eUk4cE15d1hIang0SzFtdFVmZis3RE1Xb2t4U2RGdERH?=
 =?utf-8?B?UGpsbmdWa0lvVjdzeG5PT1JBTEUyNngyZlcwWi8zUW1wMDU2c3plZ1p4c01J?=
 =?utf-8?B?a0sxeUthMHNiQllnSzJ6aDJrcWhJWGt5VU1lNHVIbnBPRHRpK3RHWFRzUXU4?=
 =?utf-8?B?OGFGTTBWaGM4Zm5CekVNYUh5UStRcUFvam1tTWEwaHR4QmNaeEdEdDZrcGJE?=
 =?utf-8?B?Y3Q1Rm8vUTEreHlXL0ZyU2NCdnliN1A1eDgxRnN0OU1URnVveG9Iei96blhk?=
 =?utf-8?B?R2dXdzdzd08xOVFPc3pDNmJWc3BLNy90TjlkUVFaTjBJeGNvVGVkcU90VjNG?=
 =?utf-8?B?dlhMNlY5b052VjRQYkdqOG9obkdycXJNVGYvUktMSHZkNE5YVzV0SUZKN2tE?=
 =?utf-8?B?dnFwOEhlUloxTFJrd3d5NG16WWtPV0MxdUt5bURWajR2RmRnU3NkS2YrL1ZV?=
 =?utf-8?B?QmZUYUxNVkFrOHVwdkhKTGxwRzdCTUdtaUhPcmJycm5CdzB6Z3YxOVBlQk9N?=
 =?utf-8?B?T1BOYWw2YitkTjFhcDR6QWFZR2IyNE9UZlNBQVZNUzdZODg2aTVWR1kzbDRY?=
 =?utf-8?B?TGVHbmxyUkNqdzFxMXhqTkxBaEdBZ1pQZGhuRlhaTEgraE1zNlVBOU9ybmUy?=
 =?utf-8?B?WXZISFZVZFUxdzgzN0x2SHpaOXAzRUhPNkxCTTBmblZiK29XWjgzU3JrMnk3?=
 =?utf-8?B?RnZZTk5OVUh0TTVSeGNCaDg4NkxGQmNNb3B1VlZWamxTRHJYMHMrWlV6REFL?=
 =?utf-8?B?d1VIanlNZWhoUHZXOXFuVXhOM24vT2plczB4ankvd0dOZHAxQUJDVTZadUc2?=
 =?utf-8?B?TTlJTzFMNDVkYjBvZkNWTERpRjB3ZDFwTnJRcUtpd0ttOENPc2Y3bHl2VEdC?=
 =?utf-8?B?djkrT0gydndvRzB2dDBneW54T1JsV2hRZm0rTW1oWVprUndwYkxsNWtCeUZi?=
 =?utf-8?B?K2NsZStRU0owL1dnYm9kUEdSUDhPQWNRQjNtb3IySGdRWWhuVTd5anhuZFND?=
 =?utf-8?B?UlkyL3p6QjYrQ3phOThIa2NYYXhOMk9QMVdaV1dQNGNEOXRzSmYxaitLU0JQ?=
 =?utf-8?B?RHQ2VWtFdWtmb1B5c0hKSHBoZy9laVMrNkF0RnRwR2s5VGpwc0IvWDdMRUNT?=
 =?utf-8?B?RE10Y3Y0Uk8rSUJNWU1oWmxUTEVOWGxNTVlJbHBjZjBYSGFnYXBHUk1HYWli?=
 =?utf-8?B?bnNlVnBIOXA4TitKQ3BwQkJ0QVlqbmNVMnZwV3J4UFBvSHVMMERhMGNoV2NL?=
 =?utf-8?B?ZldFSkJwK1htNTdFM3AzMjlPSVVBb0x1MnNNd0J3OE0xakpEbWNmNGIzS1Rz?=
 =?utf-8?B?bFNERTZjanUwcTBKZUkxcWxXWS84NjZBdW4wYklXYndUMFJlcnh1S25XYWty?=
 =?utf-8?B?NnVyWGp3SmVMc2lMZW1YNy9scG1DUjZjeUdadXRsQkY1OS9jOW1GYUZjVFNy?=
 =?utf-8?B?Y0w2NXhNOTREbVJxU3NXTGNwZC9iVWc0SXEwWXA0ZkROUHhLSEhuS05FYUJQ?=
 =?utf-8?Q?MisYXZkj1zfRbz88=3D?=
X-Exchange-RoutingPolicyChecked: XilUCuuj+5xoxDA/sgJ6coP98WCh5s54GzxWI79CH3gb5HY+OJCUyp0VVz5cxqCY1J6Z+D7S9uCkRlpWifoJIwfPkbVy2+CqAFiVJcGtmqpdIAD6xKa/axBjPDRr8P0dSYM/j10uL5vXZY7Bgm1RNlvavpx8knh3rlsF7vpcusmz1e9hH8G3VfJqDT32luBzsyPjfFazJvrru8sHVg7tNBm/Ri8Z7fBL2cIlTlQEx54VPajsKpUtpiesIR72cgHajlzpJBZ6ecx5qUZIvM83wz1WNVMdh19j35pn82yF0id9zKBwsJb1SoZrGqS1ywevyDA+/4sPcmLWCdQHXCKVMg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 18377480-0f6c-4916-be5a-08def86ad85f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 12:11:31.5721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z5wKk+isqHnTT9Vd3tQe4LxnIY9PO4YrYqI/4eKlFgvSE4EgfKZNUic4m5qIwI8demtFNnI4a22FZDENyWwKxCgmINRmr0CE7zbFeWW6xlQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7374
X-OriginatorOrg: intel.com

On 8/6/26 19:20, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ice: fix stats array overflow via proper realloc


> [Severity: High]
> 
> This isn't a bug introduced by this patch, but can the array still end up
> smaller than what the consumers iterate for a VF VSI?  The replaced

users are able to crash (perhaps due to mis-configuration), I will fix 
that via another revision


could you please apply the first 4 patches of the series by Jose?
those don't require changes
