Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC612C11FE
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 03:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783999986; cv=fail; b=DkmGJ2Lhe3fC8tRanixvXv6yfocvSO52NoXd3AQtOC80m8c36iYxEE8ykNqNPoTWk3FmHuImgkASDaCtok4ETnD+3f2aNPLALt7vZNG1oCJ/xmHICZCEeHfd6LyxD7HM+xcs5ciH5fwnNw2c2N4ZmmTFL7a4Iawmg4HnPihKB+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783999986; c=relaxed/simple;
	bh=ymHHmfGDaFBtT2d/p2n8wO94BDyKp/lssZh5ArPVJEg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gywePx167riOnNkteH5b0wWGlTwPh2bf9AIO+9oBbVqD3H/kUpquR42WJWrTUYYFQ1QOdX3HiDCetMxrZA9lZOf9s+oahyoTQXnVR/7HUtHowiXfepszEU4c3fmKPO9weUSXhX2M+fmVghuJcxJpNRjzgehExRLLjivo5R6DVY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ftbxQQeB; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ftbxQQeB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783999984; x=1815535984;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ymHHmfGDaFBtT2d/p2n8wO94BDyKp/lssZh5ArPVJEg=;
  b=ftbxQQeBdHrn92gv621E6vNGEk/bj+fUJ9p330i93ZZpcJHSO0w4+EGO
   I29mdRlPyjpjZnzdg+wqdtq8pBqKfMIJzKZuZ3kuDNMu/ZUlnz53TmEX8
   kQtg7DlvDLhr4o19Pn7SjiM/+WZqnCJKcWhqLwqMgrQJBw7DiWu5S55Rs
   ag6Kce7aZrZTKHyAIN5KdHamm4dzYt0sAJOaU9+se7dwg80w0kD2cfYLt
   G5r0SUUEvD4vE07ViRyiIDYMGeBH45P25NHV6+9pkOebczAizJvKeYh6s
   P/RjipVXKHqivNRm4G+Ixt83y4rH+Nm80/jq9B9sK0dJxovueSRhDNioL
   w==;
X-CSE-ConnectionGUID: a4hzCET7ThOfzX1ep0ge0Q==
X-CSE-MsgGUID: H2Z1Dhb7SmCv5hNwYXPQeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95981028"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="95981028"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 20:33:03 -0700
X-CSE-ConnectionGUID: S04rUPX9Qa+CIRWvkDfgeA==
X-CSE-MsgGUID: 0cka85bTRyK4etbsiwOo7w==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 20:33:03 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 20:33:02 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 13 Jul 2026 20:33:02 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.29) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 20:33:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvdv0XjJtObMGh+RXh0S6LDzpRIiQtdm11zbwyAKF8r+CBD6DzNphLsCxqImyKBd8rjzKFtyaw7/vJVpA76FkMQJYjBYsxaVEvpb1g1usS/Y89InZuJxNBBbQTn7Z4Ckxm9uhleAM7ifbRzGspea9wl9ekiycZKW9NpDaJqPVgw+4mPS+/pJ4WcWmuy8TwKfrbpcc7xPJcC8oPTx9ymKVeDulxMaMFhrYf7XpH2zKpW8guWqKNC5OzW80FPbzCwlH3GGtK0On6BvJd1yONKzR9/FMMitx69EDUTSTPmz4MZmC4Q1HkgpNBbk8J24CV+uhvdVrKRXomwMfVmdbArz1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bz2MtSA9Mn2X0OmkVniERaXZT7MAH38EurEcrK6mfcQ=;
 b=pfVKbX7L2gouiQgSX5KKdqG4RCkjz+Bx3eARRxso1mr+xgRtw0EsmrG+9mrrG7Y4zalXEyWBIV3Zm73c5LATnnbTJvxroGJqFExbb2WXGTjYJ/g8wwP794FcVDrF3MUmvIP5DSAHT7GRTGyjybS+FjM1X6na6XwhRiY0Qq4Rzl+snz+LhJx1T5M3OgKJslb2w1o/Akwsonow+8l/625p4qbTgI5ByyyvTyKs/lXXOzYgauBVcJ1fK0ZMQGMRkVgj7SlDPuXFekuF67GyqdQJf2ohBCRJCGxN+0FiVR7NTeAiU3WSQdIkkP886GtzfvPEkV7iMZHvkUJLQWQfECtvSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF691668CDD.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::2a) by PH8PR11MB7143.namprd11.prod.outlook.com
 (2603:10b6:510:22d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Tue, 14 Jul
 2026 03:32:58 +0000
Received: from DS4PPF691668CDD.namprd11.prod.outlook.com
 ([fe80::a3b:efa:42d5:e983]) by DS4PPF691668CDD.namprd11.prod.outlook.com
 ([fe80::a3b:efa:42d5:e983%8]) with mapi id 15.21.0181.017; Tue, 14 Jul 2026
 03:32:58 +0000
Message-ID: <f6a7473e-66fa-4151-ba46-3e51d2009582@intel.com>
Date: Tue, 14 Jul 2026 09:02:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe/vm: Reject invalid prefetch region for non-SVM VMA
To: Matthew Brost <matthew.brost@intel.com>, Shuicheng Lin
	<shuicheng.lin@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
References: <20260710021700.3611909-1-shuicheng.lin@intel.com>
 <alVSDlVhQBy59KlF@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: "Ghimiray, Himal Prasad" <himal.prasad.ghimiray@intel.com>
In-Reply-To: <alVSDlVhQBy59KlF@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0021.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:177::13) To DS4PPF691668CDD.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::2a)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF691668CDD:EE_|PH8PR11MB7143:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a8a872a-7803-4aaa-8c56-08dee1589920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|4143699003|5023799004|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 4gR4aag8CfKISg9CUL9SdQsf+QGI7U5icCDWkjz2/TLYbBnpDqZeJlUV5GWQwoWvgCN+fEIRlutI8SLp6rHLQJJH9ujqbYiUry4Cu+s8OilfdUKVqoQJCBYh9qKiY9BdRbVlvWhFfIXzTiduPj/u8OSaBOTCzkQ7JoAJB2B+5pLSc44fjmEuMRN3+QgxAOjZyubSGsDCXPLI7AnjD6fb0CjbR8OU+/Rmpr3JmYSRXscEWHbR2VorqjBvvcf5gjsjvBFadwzITUcz4xdn4K5OeOyT+5Dhhl3jBXiZGgt8vdkzah7fliIs+35IRoH067gFjEAADr1S0DGFQ+1ekLmVtjXSl5osaWmYvWwMxg5Hyv93RAd+fasw8pTu8wjD/3rFwjfknPDvBP5actZGdm+ZgVrg+d/rq1bjD/bSEwGuqdRix+iYIYb8Vf2eIklnHOTY4g/ji00GzLo2hzS0pcPv2dP55jYHkPrr1NlYZkqKWCKUU3USos9xIyqVnli856kRdLoSPccsbJEA8bWZFpiKiqxdEB+DBu4dWLAsD4rwnOPyBFTIGI2Ewi0Mc7lJJ3/uSrcRnjvl9xq1UzY9+XNjZMln31zdpXIq0gDgBIl+xl6U3su6Ty6WYNCsiDkzy8uA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF691668CDD.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(4143699003)(5023799004)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXhHRGo1RDIzSEUvR3YxeFd3Mlg2ZGZ0emIzTDUvb29Cc2FOWmo1RHVlMmFW?=
 =?utf-8?B?djQwbjFiRzlxQVVJUWlxY3VpQkVTNmZTcURVeVdRTHVoVXBRZm43NzBPQTVa?=
 =?utf-8?B?ZUNSamNMRm40UnluOEx5U3NIZkkzSzRoV2tBUmh4NkwwdXczcFE1STBHdXdw?=
 =?utf-8?B?Zmx3dHRZVEpCbWVNdWtEbDlkd1l4U2pXWks2WEJzMUNHRWlMM2tiVnd0aWhH?=
 =?utf-8?B?SWw4VjVKbjFlNU8vT055cDJXK3ZGU0dxdkpEQmRaWmFscE1LNjhvNFNkWjQy?=
 =?utf-8?B?ekl1MitLWVpVRDdBSjlFNzBMblpSang1VlVlODcwV3NFTVdmWDBaNGtNRDBT?=
 =?utf-8?B?USt4UHFOVThSUlY2R2dyZkpsSGZ2Q0V2RGNJZHpKYmJhc0RDQzJ2djg1UTBD?=
 =?utf-8?B?dGc3RVJabmJYakcvckFiQkl1dHZRdDluOEZ0eEZXWEVxS3QxUFdEVDVHVWl3?=
 =?utf-8?B?Z3ZiMEF2aWU0Y0c2bjd3Um5ldkhIQ00rRHl1TjkwbFNyeGNYZGNmY0FQa1Vy?=
 =?utf-8?B?azNCVm8vRUgrY1c1ajc4VHAzTTdWTWQyRCtPOXFhNFVyY0pOaHBwd2tjWkc1?=
 =?utf-8?B?RzhoZ24xQ1NncHowM05sbmNwcXBDd08yTU9lTFBTQjZ6bzZ0d21VbzNkcmwx?=
 =?utf-8?B?SEdTWm1mcnAzdnV0ZzQyNW9ETGVGZm55ZHdLdlQ3cm5TWGZheUlDQjF5SXov?=
 =?utf-8?B?bkd2K3gvb3ltUGhmd2hjdmI2TTNxVFlRbkMrTkJNRWgxQWE3U2ZFaEZyMUo4?=
 =?utf-8?B?a1ZlWGk4Q3p2ZGM1V0NhbXVJTlc3YTdYYXBvL1N3OXRJSEpsN1dVT1NUNUdK?=
 =?utf-8?B?bFZBY0dYT3ltRjdzS1ZEWmFUd1lIQnh0RGdQd3JLVTI5Y3lZbjRkQXhjK1lx?=
 =?utf-8?B?ZUNGVEJyTURHSzZ2Vy9oZmt5RXBzajlJcXFub2tSS0N1VStuWU9BMHdOVzV4?=
 =?utf-8?B?MGkzRTNSMU56L3Bja1JvWkJ4VytIVzBldThTZzFJV2ZmSDBMTU9id01CUWls?=
 =?utf-8?B?WU54aUw1akpKUDRsTGh3VkpwNTRGNHNHb1p5dGEyK1JUZFlBaDViZkFaM01L?=
 =?utf-8?B?Tm9Zd1M1bnBFOUhGVE9QS3F6a3BvTnpxa0ZUL3RwR0llNzRJeDM2dHZiUFls?=
 =?utf-8?B?YVBMZHZPZ0FZOHpDZnk2c0NENzdraW1LRG53UGttVlEzZlh3ZWEzSHI2R3E4?=
 =?utf-8?B?WC9yK1FOL1p3Uk5HYncrNmZiWWtXendqMDBxSGR4VnNOMmZieWs5Q1lXL2Uy?=
 =?utf-8?B?QklJVW5WWWZsS2kvbzVsTm8vNHZkczgra21HSk9lVU1tdmFaWlp6dVUzYW1N?=
 =?utf-8?B?VElqK3FJeUNNTkJSbjFTM3BHMWMxTVovbnJoSTBPNnltYUJqOVg2RFloQTQ5?=
 =?utf-8?B?VGlRYUdiSFo2NjA5NnIySC9vUzBMZ3krV3lSQm9DZG4rTFAwWjUyRlZVNk5O?=
 =?utf-8?B?SWJpTVJzY2dOZ24vTFR0bVFPeTAzK3BHYmorYUZCR3g3b2RNMURtS0NMR2cy?=
 =?utf-8?B?SEdTYitTTVhNYXNPVFRSd2RmdVd1Ty9hSlRVWG5FbVZhMlNROUE2V2p6emlj?=
 =?utf-8?B?eHlwOUwzTWVHTFlzbG5IeTB3QUJVRkk1eENCZlEwOEhUYXJVc1kySUtMOFVz?=
 =?utf-8?B?MWJXeDBmSzJZeVhId04xeC9qSnN5aElPL09TUTN3SjVZdmZtUUpiS3pXa0JW?=
 =?utf-8?B?QTI2aS9LeVhMNysvRmttczRySnl6amprdEpkM045R1V2UGlxQmNzUWZXVmJG?=
 =?utf-8?B?UGl4TFB3eisraTJONnlvejhiOUVwK09WWFAza1BDNzBKcDFyOGxjYjVDY2Mz?=
 =?utf-8?B?QjNzeHArcGpNUTBaN3Z5MEpuRU1zK3VwbWp4Zi9PRVpIUDRaL1V6SVZIT1pH?=
 =?utf-8?B?eUxvelA3aWEwWmpqNFozaWh1KzlpWGRkby9uVnI1WVFoZ2VEOWIrMFZOcGdJ?=
 =?utf-8?B?NlFDQ01VUFIxeUN0QW5hb0FrSGdtUUdmdlhnaU96L2k5MldiZm9Wb0Z0ZmxM?=
 =?utf-8?B?K2RzUDlPTGx3RlhmYkV5eW8rYytydmxQdTV6eXRQWFJic2VMeGVKdEsyNEo2?=
 =?utf-8?B?TmJPZjB2TndMcVlJWDlSZnQzOTV5ZXR3cmtJSHJidVY1YWZBZE9vN1VQaFRx?=
 =?utf-8?B?MFYyeXRWZXd2cWxHdGJhSGdXTGZsVGlpa05sZ0Y5dExSWjUxamEvSEgyYndt?=
 =?utf-8?B?ejVrYldNdzB3NDBnU0hNdXZKZXlRcGRrQ0ZoNnMrMk8ybm9LQ2J2NkNxMkE3?=
 =?utf-8?B?bUM5eXZCQVRCTW5jRWN1OE0yMnJuZERwU0ZkUmVBVU8wU2luWWQ0NjBySi85?=
 =?utf-8?B?b2NLOGo5S2ZLZE5xN3BUZzZQb2hZTXhVQmJZcmk1aXh1MHdtSDlXUUlWL1dK?=
 =?utf-8?Q?NnB4F9GdbrSBlGRs=3D?=
X-Exchange-RoutingPolicyChecked: l/rFOvgdPM2EzJQezx/Ix7NAM6limIYHO1KAebmH+20xYzSi6D+k49haRmG5YjgjXrnLD7VJRXZ7Cf5aK0tivqYUm25xOzjf4nx9V29+HubgfXtH511G1WQnHXwnAdivZvc+z4nQt2DR3u2HtS+6Sh0O+MbQbypXobpCON1IwrQ+Lsw+eQ//D0P4kS8wCeJYem3JUO+h/MPYXdhGJWCTIT5pgs4ijYqfnqwhZ5G4x3N7N7SFcxPKHvEcKo1w5ZUrPWLobyoWQ21wA6fsv3ftd+EmZt7R7nlWpMt5Cx5aC1gipHadCHIbbBIGu5LV9zyM2h8Js/3+KTNtr036WMeZhg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8a872a-7803-4aaa-8c56-08dee1589920
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF691668CDD.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 03:32:57.9799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8h4R4To6er227bnTgvudnJsMIbJDpZiJhVCKnba0PoUf+HHRsUuiNph6CbHjbI/bkuJ1s3KmCAt+JE70jWTrQbKSd8of4OKmfPYbP08nSQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7143
X-OriginatorOrg: intel.com



On 14-07-2026 02:31, Matthew Brost wrote:
> On Fri, Jul 10, 2026 at 02:17:00AM +0000, Shuicheng Lin wrote:
>> DRM_XE_CONSULT_MEM_ADVISE_PREF_LOC (-1) is only valid on a
>> CPU-address-mirror (SVM) VMA. On a regular VMA the value is used as
>> an index into region_to_mem_type[], causing an out-of-bounds access:
>>
>>    UBSAN: array-index-out-of-bounds in drivers/gpu/drm/xe/xe_vm.c:3260:28
>>    index 4294967295 is out of range for type 'u32 [3]'
>>    Call Trace:
>>     __ubsan_handle_out_of_bounds+0xa7/0xf0
>>     vm_bind_ioctl_ops_execute+0x9b0/0x9d0 [xe]
>>     xe_vm_bind_ioctl+0x19f1/0x1b10 [xe]
>>
>> Three related changes:
>>
>> - vm_bind_ioctl_ops_create(): For a non-CPU-address-mirror VMA, reject
>>    both DRM_XE_CONSULT_MEM_ADVISE_PREF_LOC and out-of-range prefetch
>>    regions with -EINVAL. This is the primary fix for the OOB.
>>
>> - op_lock_and_prep(): Tighten the xe_assert() to
>>    'region < ARRAY_SIZE(region_to_mem_type)'. The
>>    DRM_XE_CONSULT_MEM_ADVISE_PREF_LOC exemption is no longer needed
>>    since the value is rejected earlier, and '<=' was an off-by-one
>>    bound (valid indices are 0..ARRAY_SIZE-1).
>>
>> - xe_drm.h: Document the CPU-address-mirror constraint on the
>>    DRM_XE_CONSULT_MEM_ADVISE_PREF_LOC UAPI value.
>>
>> Fixes: c1bb69a2e8e2 ("drm/xe/svm: Consult madvise preferred location in prefetch")
>> Assisted-by: Claude:claude-opus-4.7
>> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> 
> I think Himal at least fixed the memory safety problem later in the
> pipeline here [1]. I'm unsure if he merged that one yet, but I'm
> inclined to say this is a better solution.
> 
> What do you think Himal?

Hi Matt,

IMO -EINVAL isn't the right behaviour here. Rejecting fails the whole 
ioctl and prefetches nothing — including the SVM VMAs in the range that 
were always valid.

AFAIU prefetching a range that covers mixed VMAs is a perfectly valid 
use case. Today:

region 0 (system) works
region 1 (devmem) works
for -1 (CONSULT_MEM_ADVISE_PREF_LOC) we should prefetch each SVM VMA to 
its preferred location, and for a BO VMA try its preferred location 
(which is effectively always local devmem); if the BO has no VRAM 
placement, fall back to PL_TT — but no ioctl failure.

If we do decide -EINVAL is the right way, then we'd effectively be 
telling UMD that range-based prefetch only works with system/devmem, and 
that a CONSULT_MEM_ADVISE_PREF_LOC prefetch range must not contain any 
BO VMAs. That's a much more awkward contract to put on UMD, since a 
range can span both VMA types, so I'm not aligned with the EINVAL approach.

Patch [1] is not merged yet, once you confirm will go ahead with it.

BR
Himal


> 
> Matt
> 
> [1] https://patchwork.freedesktop.org/series/168913/
> 
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
>> ---
>>   drivers/gpu/drm/xe/xe_vm.c | 12 ++++++++++--
>>   include/uapi/drm/xe_drm.h  |  4 +++-
>>   2 files changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
>> index 080c2fff0e95..9430b2be18e4 100644
>> --- a/drivers/gpu/drm/xe/xe_vm.c
>> +++ b/drivers/gpu/drm/xe/xe_vm.c
>> @@ -2495,6 +2495,15 @@ vm_bind_ioctl_ops_create(struct xe_vm *vm, struct xe_vma_ops *vops,
>>   			u32 i;
>>   
>>   			if (!xe_vma_is_cpu_addr_mirror(vma)) {
>> +				if (XE_IOCTL_DBG(vm->xe,
>> +						 prefetch_region ==
>> +						 DRM_XE_CONSULT_MEM_ADVISE_PREF_LOC) ||
>> +				    XE_IOCTL_DBG(vm->xe,
>> +						 prefetch_region >=
>> +						 ARRAY_SIZE(region_to_mem_type))) {
>> +					err = -EINVAL;
>> +					goto unwind_prefetch_ops;
>> +				}
>>   				op->prefetch.region = prefetch_region;
>>   				break;
>>   			}
>> @@ -3236,8 +3245,7 @@ static int op_lock_and_prep(struct drm_exec *exec, struct xe_vm *vm,
>>   
>>   		if (!xe_vma_is_cpu_addr_mirror(vma)) {
>>   			region = op->prefetch.region;
>> -			xe_assert(vm->xe, region == DRM_XE_CONSULT_MEM_ADVISE_PREF_LOC ||
>> -				  region <= ARRAY_SIZE(region_to_mem_type));
>> +			xe_assert(vm->xe, region < ARRAY_SIZE(region_to_mem_type));
>>   		}
>>   
>>   		/*
>> diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
>> index 509202a7b13e..e159c44e380a 100644
>> --- a/include/uapi/drm/xe_drm.h
>> +++ b/include/uapi/drm/xe_drm.h
>> @@ -1075,7 +1075,9 @@ struct drm_xe_vm_destroy {
>>    *
>>    * The @prefetch_mem_region_instance for %DRM_XE_VM_BIND_OP_PREFETCH can also be:
>>    *  - %DRM_XE_CONSULT_MEM_ADVISE_PREF_LOC, which ensures prefetching occurs in
>> - *    the memory region advised by madvise.
>> + *    the memory region advised by madvise. Only valid when the target VMA
>> + *    was created with %DRM_XE_VM_BIND_FLAG_CPU_ADDR_MIRROR; rejected with
>> + *    -EINVAL otherwise.
>>    */
>>   struct drm_xe_vm_bind_op {
>>   	/** @extensions: Pointer to the first extension struct, if any */
>> -- 
>> 2.43.0
>>

