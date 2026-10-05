Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1425B4A3D28;
	Mon,  5 Oct 2026 19:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791229660; cv=fail; b=XnN5tGZPBNK4/W2dflpWpgOGLNcGiYSSxwEe0XGMUFPDxhVYMDWIRPPdF2ff88xOkwDeEQUFFu1jLquX3Ji4vtVS1oNf+pQ4UhGNx6qVbiyxt7BBnA3KFvvpNpB+zgf7eWChwS5ohXdbVGt+sqtTfTETvCuakx8QdW2zytoKdcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791229660; c=relaxed/simple;
	bh=coTOanIBkquont9Gnz8OGgMd0brvvCMVBrUxheUOB2E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XX4HCaaNcnNt0UCPLsoTCyW23InoDR3es7iyhxHN0XkX81JaUB8ehSYu+VSi60FPTGkT6HjwC3KHmhp59G9eH8o9rj0DtugZ3LT1RUsDBIrx/Zp/pSj/DUHvpr/WaiZ5sVOWJ/JTWkKPprgOP4OsC+Pihxs2+l5Ghhl83pBFKVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TJGD5g3K; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TJGD5g3K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791229659; x=1822765659;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=coTOanIBkquont9Gnz8OGgMd0brvvCMVBrUxheUOB2E=;
  b=TJGD5g3KJ6KEFL8n+eBNlMJQGefr1DtqUgzdJVM+TfSJjdhwBeB1CGcp
   jhaSPBkIb/bqn5k021lrNcsn3oW+TwilO3KKa8uWBb1EtcOVbU9eNi3OL
   Ig4NNr4QH4zsoPFRv+RjR3lnOjyh7zghfBPaKVZg9lJyTkT+sJ9ICbBcK
   dXU7kstVwSZQtqQEOLJ8FuEdIsnsgXKtNcGFKmiv3rQql2U38BEzWlLr3
   YL6EYxb9hlXZVqdBMRG3uwtVMkMWs59zNT0W5H95woDjR4mLD0zMNvr/v
   ldAccVDuL49R5fwie/YRTFdnaRNs+CLGyzjECABgu88aPG0jAR0DU17ji
   A==;
X-CSE-ConnectionGUID: Il9VQ3biTtCod5uAPwx5xA==
X-CSE-MsgGUID: pOwu7rs0TnK2/o47z8gW8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="109400450"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="109400450"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 12:47:38 -0700
X-CSE-ConnectionGUID: elfy5YiDTKudmVYzPFJMdA==
X-CSE-MsgGUID: lTXbI0+tR3CsQ6ev+Ekysw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="314909693"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 12:47:38 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 12:47:37 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 12:47:37 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.46) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 12:47:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UepvHNFLeBygQo9ybFO2eeW7KbAw2D0foZjQicSU0PTR47dMbgK6KRNJtv/BQ9eOZm0hT7wteNbcXWHKrl2PFNFo+TPCktWNQjMlHj9zTFc8nXSVsuyJ+XuN+INZpGTDpgUdXHRAsowuNhD7q4xhXITqbZD9lI1FHI/RVuPi9LNAebBijfpdQ5gvByasIYyxmR8kjc+061NQTQ8PR32xhgUS17N/QnId72wHa8Xl9sryTArYX6igaNah7dnVKAgSCfHu3Q+kbLkT2rWy7MnJbxoLMVFoEczFtqdqvvphrQCHDyok4tl3NIgarY4YZoOEDFSbj1FHm8bH6S8FYMfChg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vvq9ZBfsCk3llnG+DspgzudhP790+erP0w9YRWyrHw=;
 b=ZVEhuXNLAFHK+mGrH1Yymcil5Wi+/y/q+383hQhensn0Sp80xYHGqsG3GGuxDAHFjxw1/3cXfHgpydIh65sPr5xB72CAjyXDrzNE6SRAzs7m65oSV89w046JaU2bbhX8hHSv5kuFLqGU74mO0DuMIUP3TL3HK/yKw2Hc6mhTmsqRgw5s/qABzbkuoXuY29iWpT+YZ+y/9P4Z7lkRbvysWOt0Sedu3EWHxluHK9sorCFZpE2yQyPZ6c8x7F5VDXCfmlyUw21S0N9DsS/0sFA2mhycTIo8Ujv8x5fd2W57UzPdKpmzRTuMy79jf5MwWnni7J4lv0sm1csYpr824b0S7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB4645.namprd11.prod.outlook.com (2603:10b6:208:269::20)
 by SJ5PPF06F7EC6B5.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::807) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 19:47:33 +0000
Received: from MN2PR11MB4645.namprd11.prod.outlook.com
 ([fe80::5cb4:804e:bfb4:dad0]) by MN2PR11MB4645.namprd11.prod.outlook.com
 ([fe80::5cb4:804e:bfb4:dad0%2]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 19:47:30 +0000
Message-ID: <eb7e99ce-358b-47a4-a67b-ed0bb55201b4@intel.com>
Date: Mon, 5 Oct 2026 22:47:24 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 1/2] e1000e: fix Rx skb DMA map error sentinel
To: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>, Matt Vollrath
	<tactii@gmail.com>, <intel-wired-lan@lists.osuosl.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <stable@vger.kernel.org>
References: <20260913171555.89537-1-tactii@gmail.com>
 <20260913171555.89537-2-tactii@gmail.com>
 <c217a3a9-12c4-4c10-bf74-a21bf27df08b@intel.com>
Content-Language: en-US
From: "Kadosh, MoriyaX" <moriyax.kadosh@intel.com>
Organization: Intel Israel (74) Limited
In-Reply-To: <c217a3a9-12c4-4c10-bf74-a21bf27df08b@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0029.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::19) To MN2PR11MB4645.namprd11.prod.outlook.com
 (2603:10b6:208:269::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB4645:EE_|SJ5PPF06F7EC6B5:EE_
X-MS-Office365-Filtering-Correlation-Id: 97ea160f-c0fd-4967-823f-08df23197dba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|6133799003|18002099003|22082099003|10067099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: wdYvjxUKJb0rTke0WLnRRGJ3MxdSpXyqL13Lzsp1mpywWm3Gn9jB8m6YwIA7S5q5k9Z5E/dMKjmTHnA3W4+LQgpIBxpwxKxq9QFJoAXLCZeps0nmrZaY49Sypgxt1qWjjDruW4t5pEV7oqOSyuD158b0rSe/fiimM36dGO1XX/fOONsmLywydE/pIhrTPQdTD8YzLiButHuO60g7VVlnJCDYyFwbMJkRGHZ1F7e5EtXOg+G6F+QXjysEKXN/GVAxdSVPyO0OObgCsdqocnvnGuOvA6vHttYS2grmb2QGR/fpb1d6JHvubEq55bKtuhDXkHx1lJ73lRtCvszHJ5XO4XUh+TwWqOynM7tdi++O8mp895vGwgAUBSTLIovfNFY6vG1gRx2otjUuJzM+w9x3RlAMZum8kH9VZgpC1BzDxMFwLK64Ua/Wp66dYEa29t9+Av8I+uWBP+VIDqi+dG+aWxEr4fSNgE7aq2QCwpKNxl4H6DWpew4ZWyyb+cmmfcujxZ2x088qkgB8RfDtyYH1pnLhKnDmHGnLKPJbxiI/LenvXh4o4S1k8CLYOpU0WQWu5lW6Uybk1nuY36K/XaR5RvIC9xkzaOX5W0bct5/6wudHVGUxahJCnIz7VLzVDxx2Ha25+yAfRhSfcKxvKYrwB7tnAjkue5rdf2rLuYsYrnc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WndUK2VZWklha3hBUHBHUWh0OGJJVUc5KzVhVzFEMDRjek9sMEUvbHhJM2NP?=
 =?utf-8?B?b1VIOTBFSGpvRUlmL2xPQTdpSXBsalBtbDZRazlJUlJXVXo1dzJxOCtoSEs2?=
 =?utf-8?B?S1NDckVOVlV4elNEQUI0cEduVEI3WkRVTzR1VkpESFloWmEwbk5vejNEdHpQ?=
 =?utf-8?B?TlpiTU0ybG5tYWZ1REY0RGdzalZMcm1KOXZWVlY4OUUrUkEvakVVbUQweWlY?=
 =?utf-8?B?MVNSUDlTWUlJVFNKRDBSNFQwdzRxaUc3UWp1bE5oY3FyazhVc1VmZVNJdmF6?=
 =?utf-8?B?VTY1c003aGowL2JiaDJ0eFpYdGV5TWY0aUlDM1pOc29pRGpDQkFoM2x5ZU1a?=
 =?utf-8?B?MDdaUndxcUwyNllZZ2VXYjl2bGN4bVpkV09TZnNaM09nUVJqZkhOaTZZMkNI?=
 =?utf-8?B?NnpPU0ZwVVhmTFVzMnVNLzRKaE1HblVLVDM2dDI4a09IWW9ZcnBXMFY3akR1?=
 =?utf-8?B?QldNMFVVdmlzOEFRWkIrZ24xSW9LVExPbDNnUXRGWTFjbmFycXZEWFBhbWQv?=
 =?utf-8?B?cEY2a0p5QUVrbVJOVzJmdzJKeXhDcUI3MTl6bmN0a25aTmoyUFlDMXhvc1FC?=
 =?utf-8?B?ZXJMa3ZrZWc4alZKSjl1ZzFteXRqSnc2eHhzcVJ0MFFkWmdIbHVSak54ckpw?=
 =?utf-8?B?UVFWNFp6cjZWR0ZFKzFWZVFiSHk4cFo4TU9UcVlheld2eEVHdm8vanYxeGRZ?=
 =?utf-8?B?QUNpdWlZcHdxcUVxWGlSZnYrRXpkK0plZUFOMEVzc2c0ZXpZSDdQWlR5YTVZ?=
 =?utf-8?B?RnhsbDdQT2w2Z2hHMDVQSFU5eVN0MEJqVDA1WWhhL0JEWDhjK0tzLzlybDRT?=
 =?utf-8?B?bHRyU2oyZ2RoWE1OUmc0RVI5bGV6cGhhSnZEQUIwbjM4UUtGQnBNcEkzZ21F?=
 =?utf-8?B?MU1heWEvWGErOEF5VnlkclRrVWlvZ1gvWGFpUEcwQ0EzV290VU0wQzlVT0Z4?=
 =?utf-8?B?SFZ1enNZaHJ0aFRZeGN2S3IxMzhSWFBBdk1OcVp3bkFyTTRYSTJKMitrNE81?=
 =?utf-8?B?OGY3aXUrNUM2bTVtMlNYZlkwZGI3ZkZnU3V5T3ZUMStzaUpkQlZneVdQcmpw?=
 =?utf-8?B?emI0YjFTSk1YeHgrd3ZxREczMEtLcnIwcmNpaEJRK3FYZGdqdlBVbHVVbjhr?=
 =?utf-8?B?ODVPT2RPK3N5dEg3SGl0M2IzdS9GZ3FSZlR3T3RNQVExOEYyRy94R1VjcWx0?=
 =?utf-8?B?cm5MOHZneXpRYzNnUDJvT1RjZysralZ4OHpHbm10N3lNLytVQXFlNG9Jek5D?=
 =?utf-8?B?K0E5dVgreXVhQTlMYlNCQlRmVjFJNzZiWUhya0xyYk5DYTJhV0xXUnRBRFZa?=
 =?utf-8?B?SjBGYTcvSG0yMVd5NW9hZ1Boc0oreitkOE5nWEJhZmhoRjh2T2JhRzB6c2x3?=
 =?utf-8?B?VFNPVHpoRHVlS2pvZTlubmxDMmU2OTc4UFM1TFlNQ1ZLa0dXWHJVd0w0YmhD?=
 =?utf-8?B?dHVUNVhqL1dJWGFVRXRiTUtaMHVDRU9DWUlxNGx2cjl0bjVwLzhXRXlwM3dT?=
 =?utf-8?B?MWIySWNHUVJYQjU4Y3hIWVlSMFdmOGhpenpoUFNka2FkYW5PRWdTcnVNL1lk?=
 =?utf-8?B?ZkNoOXBaQzNETkVzbjkzcFRhdmlqQTdnZWxzei8vZ2F5VFBZaHk3SHRIL3Ey?=
 =?utf-8?B?Zk1MQzE5d3ZMbmlzSzkxbDRFOU15bWpIVEVtL0tZRWRrQjFPK1Q5eDdERjVP?=
 =?utf-8?B?ZzNidytnSUVRZEt5UHpCNUEya05SS1Y5M0VtVjRyV2xFYWFKUVVYTys3d3Yy?=
 =?utf-8?B?eXdDWDA2anl4c0lHWGwxRmlZaGpmMHd5VGloOXFJUDhSbGtNczl5QmlGRkNH?=
 =?utf-8?B?cisrckxXUldYaVJPSkVHTnVwblJlSWg3U0NzTlhxd3hFSlR0ZkYwQkd1cnoz?=
 =?utf-8?B?V1BEV2U0TGhlWWx3MXg0NmNHVk45S1I0ajFhZ3pSa1JxVHlTNlNwcStLSml0?=
 =?utf-8?B?aEVPeEZGVWFjYWFEeVh2bHRlbDJtbUVEMmRlMWZ1SzUzRFVjMzRXc3JDUlVi?=
 =?utf-8?B?Q2ptcFpSOXNvckZLQ0VaR3djeXJhdnNYUTlZV0hGY2hEYTBwN0krcnpBMlM1?=
 =?utf-8?B?OG51U2xHWVpVQ3JhT1JoRkQ5ZHNKbWo4YkZzaWI2Q3p3Vkw5VGticWlrZWVH?=
 =?utf-8?B?azZwM1NFckNKTExVdGV6dkJMRjdNVDczTmxvVlZCbTVkVWxmVkRIVWRUVnNx?=
 =?utf-8?B?QU80VWY0YUVodXVuWmJvUmxmMTFTYXRWaEcwVXZCaEp1SUFSaENlVytBc3Vl?=
 =?utf-8?B?Tlg5K1VhdnA3d1pWWE9VS0V6dEI2NmlqWmU5WXAvRkJ3SFNONFZ2enVnSE5R?=
 =?utf-8?B?Ujk0NUlhdnQ2aGcrTUMrUTZGamNJNHlNdDN1TENpWHhGdUdhNGN6dz09?=
X-Exchange-RoutingPolicyChecked: qX6g3ZvwjMggygo5RP8Dmu9QwLoqcJ+bfYjA8FWw2AyensbsFWALbNtzI8DqBdiMH4s8HJurNAxhj4ZBXNL9D3o8RNwSWHyIMn3kbMfNQyuiD5Fd+opfZoq4TgQheDf1f2cjaUVBAO9LuX5iTtXmJzXFsY/gSG0dnlO+bPMRfFQ7tio9FxY1sppU5zJ+hXMXPE6ECh5MlhdSx6IIG+PBrXStUoN2eFuE9skmDj4pKtfSn3m853FuPaKOtxt3VNlNrf6mpPldDTxzi2CCUBaozaIZvYUXBsLfZAppt/6/PpufulC8CwqshwndQ2YzlKpmP5OhLlo7w+d8b4n58a4f5A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ea160f-c0fd-4967-823f-08df23197dba
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 19:47:30.1270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FBmiuijyc9vMYX5aAQT46ck29SJSfoGzkskz4TsPBpMHKOXRmam0VdAsE3dZ9oeI7jDt5Q+NoAsFfJ052ChiW/xxyCKX2xa32J+lk3c5008=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF06F7EC6B5
X-OriginatorOrg: intel.com



On 05/10/2026 21:11, Ruinskiy, Dima wrote:
> On 13/09/2026 20:15, Matt Vollrath wrote:
>> Upon encountering a DMA_MAPPING_ERROR during skb allocation and mapping,
>> the driver would leave DMA_MAPPING_ERROR in the buffer_info->dma field.
>> This would lead several buffer_info->dma == 0 conditions down unwanted
>> paths:
>>
>> * In e1000_alloc_jumbo_rx_buffers(), it would not re-attempt the failed
>>    mapping and instead write DMA_MAPPING_ERROR to the h/w descriptor on
>>    the next allocation call. On cleaning or teardown it would attempt to
>>    dma_unmap_page() DMA_MAPPING_ERROR. This case would only be
>>    reachable at MTU > 1518 and page size > 16K.
>> * In e1000_clean_rx_ring(), it would attempt to dma_unmap_page/single()
>>    DMA_MAPPING_ERROR (unless cleaned by the jumbo path first). This case
>>    would be reachable at any combination of MTU and page size.
>>
>> Use buffer_info->dma = 0 as the sentinel for "DMA is not mapped." Set it
>> immediately upon detecting the failure.
>>
>> The map error value was 0 on some platforms (including most common x86)
>> until error values were unified to DMA_MAPPING_ERROR in v4.20/v5.0.
>> Since then the error handling in this driver has been incorrect on all
>> platforms.
>>
>> Signed-off-by: Matt Vollrath <tactii@gmail.com>
>> Suggested-by: Jakub Kicinski <kuba@kernel.org>
>> Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver 
>> (currently for ICH9 devices only)")
>> Cc: stable@vger.kernel.org
>> ---
>> v2:
>> * Add history blurb to description.
>> ---
>>   drivers/net/ethernet/intel/e1000e/netdev.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ 
>> ethernet/intel/e1000e/netdev.c
>> index 844f31ab37ad..26f45ee8c7e7 100644
>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>> @@ -691,6 +691,7 @@ static void e1000_alloc_rx_buffers(struct 
>> e1000_ring *rx_ring,
>>                             adapter->rx_buffer_len,
>>                             DMA_FROM_DEVICE);
>>           if (dma_mapping_error(&pdev->dev, buffer_info->dma)) {
>> +            buffer_info->dma = 0;
>>               dev_err(&pdev->dev, "Rx DMA map failed\n");
>>               adapter->rx_dma_failed++;
>>               break;
>> @@ -791,6 +792,7 @@ static void e1000_alloc_rx_buffers_ps(struct 
>> e1000_ring *rx_ring,
>>                             adapter->rx_ps_bsize0,
>>                             DMA_FROM_DEVICE);
>>           if (dma_mapping_error(&pdev->dev, buffer_info->dma)) {
>> +            buffer_info->dma = 0;
>>               dev_err(&pdev->dev, "Rx DMA map failed\n");
>>               adapter->rx_dma_failed++;
>>               /* cleanup skb */
>> @@ -877,6 +879,7 @@ static void e1000_alloc_jumbo_rx_buffers(struct 
>> e1000_ring *rx_ring,
>>                               PAGE_SIZE,
>>                               DMA_FROM_DEVICE);
>>               if (dma_mapping_error(&pdev->dev, buffer_info->dma)) {
>> +                buffer_info->dma = 0;
>>                   adapter->alloc_rx_buff_failed++;
>>                   break;
>>               }
>>
>> base-commit: 78445023439506ebd83b86d40b1e428a3b309d4a
> Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Tested-by: Moriya Kadosh <moriyax.kadosh@intel.com>
