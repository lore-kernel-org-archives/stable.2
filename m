Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7957952F826;
	Mon, 19 Oct 2026 14:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420306; cv=fail; b=nPq75XyfaRbPnZfss3jehDYcOklNyPF2TwAJSWsNOXK64DnaTbW9YjxQ5dnRj3XQI94gC/LktC9mhs8wK5RBdIF/VvS7KOtqdKrTLTLbAR1yc171Up6orC0eKcG1RmUoTNFOV10M5RClIkb+Sy7ZJMNOFMjC2244M/VGecM9y4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420306; c=relaxed/simple;
	bh=BANR31mUIN1FgLnn0YOQf6/Kdq+DP5M2TpydDrPgtmw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ge/hbBOjJp977UvPIocf621Lj4L1m7t620bMFGee3NaYOKDOS+DelE8/Uh9+2X2OVLfkrU9QyY7iZeHA31JxI8NZCzieFwZ1eRoJtBNEvHnsxcNhZvORxchQVI5/kSeCPlf8fYiEzOZi9graDhiux88Td2WLNg+DcPS7hsnTPl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RbUtYh5T; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RbUtYh5T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792420305; x=1823956305;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BANR31mUIN1FgLnn0YOQf6/Kdq+DP5M2TpydDrPgtmw=;
  b=RbUtYh5TBrJy6e6k7cdlau8I0rcPLOeoRrqVIGQlJSQTHXMAWQt6G+0x
   IRnzEXA2vHk57yuMTcrrXoxISUpuVQHSDPKeh+RVMDO01KJkOSUFXGLsD
   EOULGI7jqz5mxTWByHOMDBb6lxTffmnPnZb8f7Rb2QebG3J9YFfY+WL74
   rihY20Qf/oRM/g/TB67v9XVcTePmXRUaLRYOzBnxrE/kRRDuciPDqUU2L
   LhUn64qrEw6GE2oXXo+loU2zH79ejFmjfmFqFPpEkI1uwfFhC7Uu8L78r
   nqGvOqga8feBhGnXjgeph1xAX0QDaKHw5aZh6NMhBCKorQm3sK9OKAcy+
   Q==;
X-CSE-ConnectionGUID: y0suRG9CR2mbfZ0n9eda5A==
X-CSE-MsgGUID: 2CTdpP4LQEmZsFWZz3jCvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1001391"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1001391"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 07:31:44 -0700
X-CSE-ConnectionGUID: jGO7R7CpSgqicbszHagucg==
X-CSE-MsgGUID: 9Obmn0FORC2fd5oZJVr0ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2527861"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 07:31:44 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 07:31:43 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 07:31:43 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.29) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 07:31:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWQUCE4/unV7l/wDjRVzg89MWOdKcrGqn8cF7J3PiJH+utEzkYxMuzKpVOW0Se6wFSByUzfF1SczRmgJfwG3++kLmT8wWuTsEWsDISAkKx1E7Wu5qZM5iSHPBNloFQ5WlR5ZklVdF3epxxEWYVllEA8z7fwqqgPsgBKPcSrYA4sf8oG4QVaE+WhcqePbXCQzP+1ONLkRF0Ta8wKFMsEwR05cj5QYNHZMggALGH7q2tGPesjv5vVorA7HOnFFYIGydGXYfMQ9fyNWYfIvWXcDYfP+HuZrn4bIiKYfmHyiKOzK3TEAiIFz/k7xLFGIOeJMuiWF0Khzhw5NR6R2tae+4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4uXy2tPq6Px5wUywVWWlcBtu2C88Rvq8gAmd3+vGvk=;
 b=GHfUgsPxbMhvo2iHBfj/QcdcZNCo25Sz3iYBWVKBeF4f0f9a7Kp9naoKanF+tQ/cxu9PCI+WAYm4O+FxIFhczB/FrnDA38zwMA6V323Gm887FQUHiC4mKdtXUyOp3LgqEj21LPb7KBlMjv/bpVVdQZfKXfr7TKjbwwF923yFoR59Dia8I1mMo3vRxHe2Be0UHzuR8Fg70xddxrUc9Upr/Ek50E2T6h6MEdRqYGEIYWbLzLPAlmc/KwuNQBSodq9SYkZxdWYFIAUFZmKVMoRi4aBCVYUj/kV/1l8kBiKlixYCNY2ZAeSeJ7lF+aZs90x2p6Us9OyGJAY2/iFgyNtf5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB4645.namprd11.prod.outlook.com (2603:10b6:208:269::20)
 by IA3PR11MB9301.namprd11.prod.outlook.com (2603:10b6:208:573::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 14:31:39 +0000
Received: from MN2PR11MB4645.namprd11.prod.outlook.com
 ([fe80::5cb4:804e:bfb4:dad0]) by MN2PR11MB4645.namprd11.prod.outlook.com
 ([fe80::5cb4:804e:bfb4:dad0%2]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 14:31:39 +0000
Message-ID: <7f5447ed-19d4-4e11-813b-d74489a6a723@intel.com>
Date: Mon, 19 Oct 2026 17:31:25 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v3] e1000e: restore jumbo config after DMoff exit
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Craig I. Hagan"
	<hagan@amazon.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Fabio Sabai
	<sabfabio@amazon.com>, Matt Vollrath <tactii@gmail.com>
References: <b6db5335-cb5c-4a91-b823-1a114fce75a1@gmail.com>
 <20260928210552.13266-1-hagan@amazon.com>
 <IA3PR11MB898645A3712F13CE8E6F0B3CE58C2@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Kadosh, MoriyaX" <moriyax.kadosh@intel.com>
Organization: Intel Israel (74) Limited
In-Reply-To: <IA3PR11MB898645A3712F13CE8E6F0B3CE58C2@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0015.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::7)
 To MN2PR11MB4645.namprd11.prod.outlook.com (2603:10b6:208:269::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB4645:EE_|IA3PR11MB9301:EE_
X-MS-Office365-Filtering-Correlation-Id: b9232fd1-4127-4b6b-89da-08df2dedafaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|261009223027099003|10067099003|56012099006|6133799003|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: vM8N/6Xfc+eeWpfiuBj+Emp/bPghZRyN5Zp6+aHIUUBRe1553c+0QWk3clHscldfnk2FhnyZCM4f1aYpbUgvxEEemm3punirFP6mB8c9hu+51KvO4qPhYhnk2Z+lc0oIr0RL4EJQY09lzVDobVeeUEGl1jcHa1ichh9mM7nSZ5UV3bB3XUj3R4d+gAIbJQa1/S6MSt7svg9U+gBXnq17LJH5OEUCeHiiezr04Pbt036vwkO7KbSe34qsVwtjWYJrSp65zk4FhSgZOdbFXACFednIo4sRWozEDNrnL06IzkMT8tO5cV7MOIBtYHUAABOG1FRJ7ZywJbRUmd68UxSmEUDWbACib+xmTiDEPObiCEwNiIymdR491i1dlUl586vsvNENDW2ja0cKQSI6oXFLnyqS0+k9CP1f3jrunq0GpsnSh5HcZlexD+zXbVPLmKv8SKW6LJrqsbbNbLvxhyYQGY1zGiX+R8r+tYoe96ATKJSdHIvoZ4Vd2I3ZsVchyBRI3NtE9vgtsZSNf6T7rTS5JlA0pw4QNvhcdErq+nxcb2ZA765bF5KMSFWpL4ZE1R6GovpI5jQyxiAVwf67gz6un15x5svGCF8JhCt+BmFK0hGkD7LR5UxFRIMqsFk5VEQz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(261009223027099003)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3dXUW1ibThvOHJUOTY0blUxMWZ4TjEwSGRMaDRaZTUzOU9hMlFFVjBlRFhR?=
 =?utf-8?B?RklYRHdPYmtqcDU4bVB3NXY4Rmp6RU5pSS8wRTRUYUx4bHFVTXlrZjBTbjZr?=
 =?utf-8?B?dERMVFNGQjVyTXk3QmFJS3daUldFMSswR1J4WGppSzJoWlkxQ2FpYUp1VWky?=
 =?utf-8?B?T0syd2piRndnZHh1cDN1VWEzaXpjMGN0TEJUL3F4M2p3anIrbGZhUkw0ZlVy?=
 =?utf-8?B?WWhtTS9WeEtUbC9QYTVKNE5qR2NkeUdESjBaRXB0dVZSWkZWVUFBMFlVNm0w?=
 =?utf-8?B?NG1qWVExUEtwdHdCUFFMVkdhd0tKYW5ac01HeC9EZE9sam1UY2RNNERETXhm?=
 =?utf-8?B?dURkL09OVXp0RkZjVCtWUklyUlRaSy9jQmIwSjB1ay9ZZit3RGx3UUdpeUdW?=
 =?utf-8?B?TXFyV28rTmpNcW5qNmRXNHYvMkh3YVBnVElQa3VHTmU1ZHV3S2Y4OFFJY2lL?=
 =?utf-8?B?QVducTFCK2t0QmRNNGEwYzcxc1FQSFFzRlVLNnp3S2EraUJQZDRjbWFKNjRF?=
 =?utf-8?B?a0p6eU5wZGpPK3NTK2s5U1lRSWRSTkpMS3hSNERkVnczWTdnMlZyTTNlSDhT?=
 =?utf-8?B?VjdDOVNUSXZmRU5CcXhIU0VrdWpyMGVsVGE1TzJvVjBFT2JkcGR0a01MYi9X?=
 =?utf-8?B?QUFhd0UrQmxtY1NJSCtwekVBTHFyaWR6SFpGbk5IeGUzcVJCTWNBOUdHb3FO?=
 =?utf-8?B?MGVMZFFldXE5UGtjZHZ4S093MkxRdkxQaUNqSks2d3NIdlhNTUN0VHU0TWx0?=
 =?utf-8?B?c01uNjNuQldmMXNURCsyQVVZT2ZLN0VWWm9qbXpUUUdpL2MzWnl2L053bkxt?=
 =?utf-8?B?M2ppM1l5NFVhZmpKd013d3ZRYjJEV1NiSUpkYTY2UmVYNkF4UW53MlhwYlFO?=
 =?utf-8?B?Q0FWeGdDa2VvenlSbzQ2djgzbjBPV0RkL2RrVkJ5TmpmZXFtSGZac0J2QmN1?=
 =?utf-8?B?UzVVa0tOcWozSzVXY2xENmlxWlVqUXNvaVJ5ZEhRUnlnVnovMWJQdGUvYjUw?=
 =?utf-8?B?UmtId0ZOSlZsMmRSUGtldUZUaFdydmNENHB0M1pxenp3d3hMR1R0WXQ3Q0ZV?=
 =?utf-8?B?M1ZzcW53WGUwQjB4VXhsYVA1d3I1QUllYUtPbzd1M1VDekRCcXlCUmozRmh4?=
 =?utf-8?B?alhIdzFTM3VJQmpseGV6cXhjRlRDR1BXcGNOQ3l2eC83QWFmR0VSa2RsVkxB?=
 =?utf-8?B?QnBZQklLc3lZRmhpTWl0N1d4UWNmNThmYkpacm5xQlo5NUYrNld2alh4dmV4?=
 =?utf-8?B?MjR6S3VBMGJkd3oxWGxubERiUDgxbThmQnd4cEx5dEoxbEZkN1BjclVwV2U1?=
 =?utf-8?B?cHExM0FTNTVBSU9CY3NRMjVwZHc5NmVyRWU4d3l4aWFLUjVkSlhpbXFLakdJ?=
 =?utf-8?B?Y2Nwbk5OaHVsUlhjMnoyd0IzM2RuaTQ1aVpWMUFqdEdwZ0tyTmtnbjg4QTlU?=
 =?utf-8?B?VGNiVUNtcGJoQjNJM1NXMzN1TmpZZkpNZXpScjI5RENWMDNkVktHL25zL0dC?=
 =?utf-8?B?Tm04ek0ra3ZodjZnaHY3ZEJlU1dNdXhFRTI2VTFiS2xxMXlacC8vT3lnMFFB?=
 =?utf-8?B?T1dGQkcvZFJMb3R2ZGVkb3RTMGVFcVNHUXIxWmthci9GdExzR3VRMjMrVVRN?=
 =?utf-8?B?dnJaWmw2ZjFyemdEdUh5UG92RHlMSWhScGd3WlNWenJTUW5tMmYyWEt3SXpV?=
 =?utf-8?B?bHlqWWMxQ1p4em9YenFLa3lONVlaLzR5c0RzUFhucGtNREY2ejVRYjdtUjcy?=
 =?utf-8?B?U1VuVllNRXI2QmJJbTV2L3hxdHEzdHdNYlV0WXhRNWVGeTVBRXh3bUlrczUv?=
 =?utf-8?B?aGZrd05TSm9Xb1pSRC9pNnJoVFB1NzJEbXJQS0xsLzdxY2xZQ0M2L0xBTnZX?=
 =?utf-8?B?V3ZFS2lsQkFpcldyV2NrS2hUSnVZL2JlZ3dObHhkQ0VPd0pNRHlrRllDQW9M?=
 =?utf-8?B?NUthRndFcUVPTnM2aWcwazByUENjQTE2ZDNkakRNWDMzOGZhbCtMRVBSWk1o?=
 =?utf-8?B?RXNNNkxBVnV5QTgyQ09HQVdXSmJMZURoTjl1SkJCNmY1OC8zR1F6YnR3WEhi?=
 =?utf-8?B?QU1OTnVRUjhHbUZTK1FzK01uRFh4VFpmR2tPZUgxVVNQK3laN0RoQmZHRUE4?=
 =?utf-8?B?TlJmd3BUVklxczVvRGhjRGc4ZkpCbGFRRU9acWZZTkc1OHVsWXFWa3AwdHF0?=
 =?utf-8?B?VFlaZ3JNVmh3cjk1K2o5Wm9EbG1MZ2h0RzlVejZuWUlXOFhrQVlZYXhROVdT?=
 =?utf-8?B?MWZ0ZGtZdG5pWDl1NXJTWXlIMEp2eHRZMkk0MmtSckpPVUI0dmYwNWZwdk9r?=
 =?utf-8?B?dmVaeHc0RjNwbHp2dVZPTVNsZERXS08wWUpBbG0xQzRFaWF5TUpxUT09?=
X-Exchange-RoutingPolicyChecked: O0GSfNkkwwV/zUeUTGpbgMj9BsO56ud2RtcuBTGSw84SbKo17t2j0IloewyfDFOFCsoeMp8yPBeNGqVHp1nT8JYk3JJ161va8wMD79kNgh01I5bh5r+bG/gJ4kmzKMB2nkqqvR4cnf1RqyrH3XEpfA1b0cYh/KZlrvlq4MfYQG2uKSo9WsSw7X5jdH4FKa2pDIZ8BjJrdpbFOa+7XBrXahczBNuHg3d/6yidHIp8uOpn/hxGKVOQFzj9WoTjnzrHqR4IGEXf5t0Ys+xzz7fhW9fDWLTTuh4+U2TIO1gAAuXclx9glmEDohNKlWgVEs6RjLSENzVz6v/QUpCw+M027g==
X-MS-Exchange-CrossTenant-Network-Message-Id: b9232fd1-4127-4b6b-89da-08df2dedafaf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 14:31:39.0482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e9eXVGNUctwaLCuB2dHndooJEeQUZ9CKtd9zzhillTNVv7WpkZlsgIepDEakGcXoXPFyZX24r7r/27v3tH8PLAFJuAOCRg0uOs0q7bYYBm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9301
X-OriginatorOrg: intel.com



On 29/09/2026 10:05, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Craig I. Hagan <hagan@amazon.com>
>> Sent: Monday, September 28, 2026 11:06 PM
>> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
>> Przemyslaw <przemyslaw.kitszel@intel.com>
>> Cc: Andrew Lunn <andrew+netdev@lunn.ch>; David S . Miller
>> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
>> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; intel-
>> wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
>> kernel@vger.kernel.org; stable@vger.kernel.org; Fabio Sabai
>> <sabfabio@amazon.com>; Matt Vollrath <tactii@gmail.com>
>> Subject: [PATCH iwl-net v3] e1000e: restore jumbo config after DMoff
>> exit
>>
>> On an I219 (pch_spt+) at jumbo MTU, after a link partner reset (e.g. a
>> switch reboot) the interface can come back up unable to pass traffic
>> until it is manually reset. Observed on I219-LM (8086:15b7) at MTU
>> 9000.
>>
>> When the MAC exits the DMoff state on link-up, the watchdog resets
>> only the PHY. A bare PHY reset does not re-run the jumbo-frame
>> workaround (e1000_lv_jumbo_workaround_ich8lan), so the jumbo
>> configuration is left unapplied and traffic stalls. This was seen with
>> NIC runtime PM disabled; if runtime PM were enabled, the device should
>> go through a full reset on resume, avoiding this issue.
>>
>> Request a full reset (FLAG_RESTART_NOW) instead of the bare PHY reset
>> when the MAC exits DMoff, so the normal reset path re-applies the
>> jumbo-frame configuration.
>>
>> Fixes: def4ec6dce39 ("e1000e: PCIm function state support")
>> Cc: stable@vger.kernel.org
>> Reported-by: Fabio Sabai <sabfabio@amazon.com>
>> Closes: https://github.com/systemd/systemd/issues/25925
>> Suggested-by: Matt Vollrath <tactii@gmail.com>
>> Reviewed-by: Matt Vollrath <tactii@gmail.com>
>> Tested-by: Matt Vollrath <tactii@gmail.com>
>> Assisted-by: LLM
>> Signed-off-by: Craig I. Hagan <hagan@amazon.com>
>> ---
>> v3: Correct the Fixes: tag to def4ec6dce39 ("e1000e: PCIm function
>>      state support"), which introduced the DMoff-exit bare PHY reset;
>>      2e7256f12cdb only added a pre-condition. This lets stable reach
>>      the affected trees (v5.3+, including 5.4/5.10). Add Reviewed-by/
>>      Tested-by from Matt Vollrath.
>> v2: Rework per review: request a full reset on DMoff exit so the
>>      jumbo-frame workaround is re-applied (root cause identified by
>>      Matt Vollrath); drop the diagnostic e_info. v1:
>>      https://lore.kernel.org/netdev/20260923235832.473-1-
>> hagan@amazon.com/
>>
>>   drivers/net/ethernet/intel/e1000e/netdev.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c
>> b/drivers/net/ethernet/intel/e1000e/netdev.c
>> index 844f31ab3..df7da86a8 100644
>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>> @@ -5264,9 +5264,11 @@ static void e1000_watchdog_task(struct
>> work_struct *work)
>>   					usleep_range(10000, 20000);
>>   					pcim_state = er32(STATUS);
>>
>> -					/* Checking if MAC exited DMoff
>> state */
>> -					if (!(pcim_state &
>> E1000_STATUS_PCIM_STATE))
>> -						e1000_phy_hw_reset(&adapter-
>>> hw);
>> +					/* MAC exited DMoff; do a full
>> reset. */
>> +					if (!(pcim_state &
>> E1000_STATUS_PCIM_STATE)) {
>> +						adapter->flags |=
>> FLAG_RESTART_NOW;
>> +						goto link_up;
>> +					}
>>   				}
>>   			}
>>
>> --
>> 2.47.3
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Moriya Kadosh <moriyax.kadosh@intel.com>

