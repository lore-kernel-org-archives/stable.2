Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793176721;
	b=jU82OLwRKGj/TgQLsNi49WwY6mAyv3dmcLr6+eWbOxDvT6izwCdZtqCb88qcUvtcICC0
	 lGWfFcDSNCLe7zSKo/p37y5kmXVWWq6R1BU2DX2y755xk6Z6boucFKO0cNqqz6XNZLV2L
	 Kp9z0JcioMTB0+16PFFV2CgYcTVzMC6gOBZpZJgdbQQPgnHnNcX38dLgEh/HpDw4zAym0
	 OpUyVRYWAJ0CTkulA3dVFallXdjbycptLO3D7uwPZItBbv7x/2G0pDTK3mNXL6q7nxEJ2
	 sX1/gEdUzTDJ2sRSHN0yE5P13vvJe8qrK6JaI8PE4I/PZQXueid8AnFwAH9U7k5Yb1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793176721;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=1gywZxlpWGndBQM7MP3+EjDp0EUbAB/bK9OtVP3toZs=;
	b=iefXug9XVBoazJmLd9mDgVjQUo3i6MOeqXbcCCAKXFZ89je6M1lJEJEBxZV7pn3y+M4i
	 QHSURKgL8c+Y82agO7NiTSQD4cfjK7sQej/kc8ZUp/fslpvDH7H4gC9nyoyHqAT0rLn2Q
	 lY0MgBgxvsCDV13tSdGoBXDSaMCYISmUqDdeDbcdKEK+NKDnQT3u877lmVziU4lo2MQyK
	 Iuk6fdpkki9+jOyBseEeyb7jQ9UZYbIDNcqAph5IB5pbAIuvsGmWSTi1z9s4AnodfudtL
	 xvYlO7xOOhHYEP6XDbmuaXK6QKOy1CNeF+HKRpjyK7BhX7F4M/8p/3+itkZgPhXTTUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZNH2nnkV;
	arc=fail smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E959606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 08:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E959606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZNH2nnkV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793176719; x=1824712719;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QQ9T0vs9AgXGjxHnwXirBz7/zHG+RX7vILqzcvjQe3o=;
  b=ZNH2nnkVTD4dDRn37bPUc5+DpMuIjDNPUNz6EGe7qnjLxpUc8AqWttyM
   V6uA9KrXjWsN2LallUgihi8k1UIyeyNymtlh2Rcq4gPH756y+kk5l5Kza
   HW44ywT1MCzlOz+fe/bE1ivwLKQxjdmZr+12UkthR/kg21Ls9tDDWkmcd
   ZFoU+PrlfbNvklpGYLjodq8JAYhZ6XMHOEQjrGMUCrhCUQrgfo7XyHFJ5
   giwI9MMsh0Al2FKrUnoRQb7jpeP0W12Sxjh/Geqf7YZtGuJa6Vg61gZyR
   jm2GFUlsqmaKtIM3BcIHe3IVyF6TsXnN02eu6ImDiToaoSGroY4JSWd4h
   Q==;
X-CSE-ConnectionGUID: L+oAe4uBT8+Iqkd3rDrJBw==
X-CSE-MsgGUID: ahf+nPqVQnO7r/V5ovvQYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1878113"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1878113"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 01:38:39 -0700
X-CSE-ConnectionGUID: O5IMUajwRECybc0oL7CGdQ==
X-CSE-MsgGUID: 9kbWB+6iSk6/bPCfmj1/iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4763861"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 01:38:40 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 01:38:38 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 01:38:38 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.43) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 01:38:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ijw+jOLbmQ+MB0L7nge1YgWKRRlXeBHPkxab1UFF5vrJstsDfPRFG34oJWBhEfm5vbqBJsrzlIVEVcqEYXtVgciWDe606D+cvxTCJ177NWoEQ9BxgqqK/lLI2m1zkqu77dyH6eQUp2iQSGBiyMXtVQtHJh9Y5dYjPHHQRASu7yHtiMi3IOCvDeqVNeLxnAgnnmEb+5p/NbMX19fotD7+G1dRkdt/apWVqzd/3qFpNPHHvoOyF1Zg1pkgLsrgc2OaU63i08dwEMkX+3ah4XOFdC/vIs8+70QSpAxAbnGkRFovmu0FlJ99BLqKGj7tU/QrMjonVdBNSiygNDVEGxFdIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gywZxlpWGndBQM7MP3+EjDp0EUbAB/bK9OtVP3toZs=;
 b=Vg/ygnMtoLIl0NLwI3UCJpCGb0B2bntcfo4eFB6XTawMtml3iqjxxDwGJ5xbP98jQyR82K1UGSniAjXhgdg+1EAvFxY95wiWv1y/liUdqm6punBU5nFe/3HigP7mgjnKcZfKtTyqYAfFQgKHW7DJqbwQpoLtnaPmOkJXnTTJ7tJoch+soA5wL2grV7yRlk0awTTrmxEj337nU9aWLd0T6uEd+dfPBTbWv/jcoT+LZvAroFaUjx8YXfpav4SdpdPCtgUUDYyT2tqzw70sKJNeOa7pZut6BNi7NIVXL1Q5nU0aTPNgY4hJChJNggrrdfU7FgnNzrWgbW2lmcDgo0GAsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5035.namprd11.prod.outlook.com (2603:10b6:806:116::21)
 by PH7PR11MB5793.namprd11.prod.outlook.com (2603:10b6:510:13a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 08:38:29 +0000
Received: from SA2PR11MB5035.namprd11.prod.outlook.com
 ([fe80::9418:cd60:8ece:69c3]) by SA2PR11MB5035.namprd11.prod.outlook.com
 ([fe80::9418:cd60:8ece:69c3%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 08:38:29 +0000
Message-ID: <94c3c16c-50ce-444c-985f-0fc0fb009242@intel.com>
Date: Wed, 28 Oct 2026 14:08:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] drm/i915/display: Disable pipe joiner on WCL
To: Vidya Srinivas <vidya.srinivas@intel.com>,
	<intel-gfx@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>,
	<uma.shankar@intel.com>, <jani.nikula@linux.intel.com>, Charlton Lin
	<charlton.lin@intel.com>
References: <20261007072334.1801956-1-vidya.srinivas@intel.com>
 <20261028070404.1913843-1-vidya.srinivas@intel.com>
 <20261028070404.1913843-3-vidya.srinivas@intel.com>
Content-Language: en-GB
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <20261028070404.1913843-3-vidya.srinivas@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::15) To SA2PR11MB5035.namprd11.prod.outlook.com
 (2603:10b6:806:116::21)
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
X-MS-TrafficTypeDiagnostic: SA2PR11MB5035:EE_|PH7PR11MB5793:EE_
X-MS-Office365-Filtering-Correlation-Id: 80753207-b4bb-46a3-bcfa-08df34ced74e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|4143699003|11063799006|261009223027099003|56012099006|10067099003|261021121427099003|261021123027099003|261022075727099003|18002099003|261026121527099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: Q78eo37C6eYTxKG1I5jHjZHZ/C5SWEUnrnLdop9K6jJpfRyqssRTWaXbxlui4sib592+p/goc50lcjbhPuGMpyZ0h5EsGT3WX2yyv/JoPIS6Bwi0hpHmlUCPkXQKWYHGgvInUmcjgHplmvGl/t9WCSiVVX/UvLelfJirmbb6xNdAgjh/lUsTB4c+7KDC5WjwsHxJF0wpqJHDhGwvRNvKpSPoS0TpLeux3xQ8zeJe92YPtugDzdUIMAlCbBz/YrBUYQBFQ9/yhnkLZqk4WC7/hKVrlGTb/7ckcp8KtCmF0aTgG2QMBcqqvZ2AaXYMUC7PQEeKtaVISfogbwO8dTwBC2AQRQydlw2Q3AX74W91HUsfJsK/tggxmOEPog3zn0UCC/ZC68AGm+mQ3XTG4nF7Y4N3TDWxqpjHE69RSnF5bf/f3uaUkO//RAklgAo8hBITMNI6R5OsVY/fqzWu9saC0wHSYTHFyb5cQATakBszoIeKtp0SSkUWi3SBAyjYO+KuvK+O9fiavzzYU7Hlor/Spz0Tty9ssbe+edCtIAxFuENZ7u8RgPlNTVdCZG+FdGz4AS3gMOey58euwT3m+1DpP4Fbcdv7HKSxQ/OVaxx7280679DFm+Lfv6GZhRF3t1eSlDMI7jEbTnfL+GrqoZAH/VW3vQqTdQt+aInd5g8opXk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5035.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(4143699003)(11063799006)(261009223027099003)(56012099006)(10067099003)(261021121427099003)(261021123027099003)(261022075727099003)(18002099003)(261026121527099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0xSOUErYnFvMGRzTUQ3SDdGMHJ6bTZsR2xORDhLNXFSWTd6cjl0SlMxSG10?=
 =?utf-8?B?czRpeEd1emM3VS9MM3BwZU1UcDZ5dU04eGE1WVByNmQwdmU2MDlsdlJ3UzR4?=
 =?utf-8?B?R0MyWDg4Wkwvc21ySDRRTTBCa0JZVzJZY2ErMGRVOE9yOXQyclFvTzcwRzFr?=
 =?utf-8?B?MGZiUXpTa1FjZTNUbnA3TjRZMlJ5Q2NReHBxZ2JkTlhYaGplUG91SEJGWmtY?=
 =?utf-8?B?ZU1GNTRLbUhZdk92L3FLakNVMUsvVUVvWVpzbTRhbWIreVZnNVErNWEwS2VX?=
 =?utf-8?B?ZDhpWEdQOEw4WUoyTDlpSURJVmpmM2FMLzM3RkhxYWZtSnFzMTQrSzYvODVn?=
 =?utf-8?B?aUlra1BleHdQY0tBYUlUNHVLYStqeU50K2ZpK2t0QlpIOWFCTHNNMk85M1RU?=
 =?utf-8?B?c2RNNlVBSU15ZTdPV05CZ2QrWWlUVm5zZEJNVU9BWk5ML1hCd0hLQiszWVlN?=
 =?utf-8?B?MTNuQkpUd21wL3gzaFpORkVkcXhNUzljTk54TmVjY2VVZzhUek9SbEJoQ3g5?=
 =?utf-8?B?eFNiM0NyTEhKRXRSN1ViZWpsaXBVelFxdkU2RncxdlpKUm5hYXJYdjhZK2hG?=
 =?utf-8?B?YUlrR2VDWTNnVVRjcXIrNUpFQTg4NVQyNXhEUHFRamV3Z2JJZDNlOUVWc3FS?=
 =?utf-8?B?VjlacG15MW1kRnJTZE8xdUhnWkVLeDV0OTJqLzFrN1pEVzA0NEY3eW1pKzdX?=
 =?utf-8?B?bXJsU1BwY2o2MnhJdjFwVFkvSE9CL3JKc0ZjMVl4a1ZsZEpleXhscVMzeDRv?=
 =?utf-8?B?bXNvT085WFI0dGtudUIrUWpqMDA3MG13WjduT21MRXk0VFc2SWNXV1VmcDdJ?=
 =?utf-8?B?UTdCN3ZRSEFGZFRvRDYxc25TeDQ2Sk5jMm9IOStOSUxvQU9hTHhFUlJVY09D?=
 =?utf-8?B?TjM5NFRJUkE1ajBUaW9uVTdzYmtKQzFtV3VpU2VwcGc0UTEyWTB6NWRWTEJN?=
 =?utf-8?B?VmR3VDg3clFUdlZDZlpEVjlUQ2E0RXFDYWRwQ2pvU3ltYTBmNkMydWJJK1BC?=
 =?utf-8?B?L282WmxZVUhYT3orV0s1NjBRVXJqNEJJOVRTOGg4VTg4bTZxZE04cjBIZ0cv?=
 =?utf-8?B?UkMxK2hKVTBJVmNYcmMzK2NMWTBBb1FTbUVDZ1dSeU1HVkdnTFRWM3RXRnpC?=
 =?utf-8?B?OTVPZ01LcjYzd1dIRGJHbUw4enFIdHJ5SlBCWEx3Z0hGSGJsQWloazV4eDdO?=
 =?utf-8?B?amJONG43Ym92ZTdMWitXQS9XNTQ4UWdVTnVMQzZqamxqTkhMVTd3L05sbDk5?=
 =?utf-8?B?QXN6bUUrcjd1bDJPeS9pSlRaaXFZV3QyUkpiWnUwTWhEdjNCZVFCS0J2MmJH?=
 =?utf-8?B?V24xOU1qaGhpTlRQbHpMLytVKzIrVERLSHFLL0JXdlgrTkI0cmx0NmkySkFU?=
 =?utf-8?B?alp2Qjg1Yk1iaDJrVWlvZUdMdTNmNmJ0eVJTdnFSNHVvdzYzcEdzbW9zM2JJ?=
 =?utf-8?B?VTVBR3MyRDcyNkJsS3h2cHJWVXBrcXBlZGMwTzZaUDZrbldFakhDeWtFaXFQ?=
 =?utf-8?B?dnVLeWhYS2cvT2JlTTNwWno5S1NjWDBTbGhUazA5R1A5YzJDZUUvVjk5elBZ?=
 =?utf-8?B?RnhzaVRQVFhJTStZOHhoQTdyQ0IvQlByZjVONkE1aGppT1hOMXZVaUo5a1Ex?=
 =?utf-8?B?NGs0ZHl5TUw2YzdPbWR2VTI2VERzSWhwRU9kNkZwMUplQW83aDQ4Y3FDa0dE?=
 =?utf-8?B?amZWZjRHcTdGVWxPVGVHckRtdkwrb3hvMENxNCtFZlJJZUw4cUx5YUx6TXFp?=
 =?utf-8?B?VHgxcENkOHFZbnloc2FpRGRCRGpyWDBnU3BXSnBQZDlpM1BJQzh1L2ZUS0pX?=
 =?utf-8?B?SURxTVJETCsvQzBQVEY1SjRRYWtUaStnQS93bGZaczlUS2Q2WG5CU3EvMjV2?=
 =?utf-8?B?TDBPZTIxSE9nWmtQZzYvSVI0R2dkWVlxUjZsWTd3aWZPS25CN05qVzd5SlZl?=
 =?utf-8?B?UVBhT3RuRVYwSkhjVVJkS1Zua0xvSzhlOFRiZlpFa1ZabFVGZ0hpemZFRjZE?=
 =?utf-8?B?ck4wemd5bEUwaWNpODlNSXRmbzliY1d6dUluWk5RZ05hcytUbUJDQWNBS1VD?=
 =?utf-8?B?dUNhZGRwUldzYXpPS0RyTWxvbDBGUGFEWUFkVXhLd3ZxT1ovMW9hMVNMVi9j?=
 =?utf-8?B?UW9oSGtRcTloTFl1Nmg2TWZ1SkJmalAzUGNBZXI2T3hQZjdIQktjTUVKaWZL?=
 =?utf-8?B?UTMwZ01yclRObnp5eGV4WmVIaHdqTnNqU2tnZktwK3U4czdIaHBmcWQyYjhR?=
 =?utf-8?B?a1JJMFI5NmIxcTVxRXYzRERiZ21xOE9oWWFVeHhHMmM2VWJDZVdlWDNUYVQ0?=
 =?utf-8?B?WWZOcXN2ZVY0TkQxUWErNFZiYm5SaDlnVlA5SjNKdXhHZ3NlQSt2QVdwMGYr?=
 =?utf-8?Q?08qTD3YmWHsCz4rE=3D?=
X-Exchange-RoutingPolicyChecked: PVqOBfodAvO1UxkyHU9u5Cr+cFb2k94gMy7Cs6iyhHjsKyEiJ6RxL0hYMKvjVE4dsYBbeTb8CqVsMeHTF/OqHiDteDd/C/t5diOzP+6z8ny0uIWx89iWZJsDOgsKLpFYAFlRHYiUMMyI/zBMgO3ZZbHjubc8oSR9edVSDG9Gcif0Ic6OulBC2E2FW9F6q1iktz6071y/9csV7yqmEBV1e+rSKg+GikVuraokAZcHLzsQmGugTVDCqg0IR/MThzn+P3Zuydl4xNc3HDNx57RxCDaV9WockhvJuBj5E8/E0Pki4YRlKqYUsIeVRI/EEuvCCzBSEgk/3r98PMb/Vj/sGw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 80753207-b4bb-46a3-bcfa-08df34ced74e
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5035.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 08:38:29.5646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V4w7YKUzmp+S90oadfxj6L695VwnKmrzKIlTo23idM554D6p7nTRPGynrW6BdHP7quzgxJSCsDEjvOZmiWBtQEjNwg0krjXwyk8T2vaYuKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5793
X-OriginatorOrg: intel.com



On 10/28/2026 12:34 PM, Vidya Srinivas wrote:
> Pipe joining is not supported in the WCL display configuration.
> Report no joiner support on WCL so that modes which would require
> joining are rejected, matching the 4k 60Hz maximum resolution
> documented for the platform.
> 
> v2: Rebase onto latest upstream
> v3: Fix up the commit message
> v4: Split the scaler and joiner changes into separate patches (Jani)
> 
> Bspec: 74286
> Cc: stable@vger.kernel.org

Won't we need a Fixes tag to tell where this change need to go to?

> Suggested-by: Charlton Lin <charlton.lin@intel.com>
> Reviewed-by: Uma Shankar <uma.shankar@intel.com>
> Signed-off-by: Vidya Srinivas <vidya.srinivas@intel.com>
> ---
>   drivers/gpu/drm/i915/display/intel_dp.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index 00e02e019d25..ef164a797618 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -485,9 +485,9 @@ bool intel_dp_has_joiner(struct intel_dp *intel_dp)
>   			return false;
>   	}
>   
> -	return DISPLAY_VER(display) >= 12 ||
> +	return ((DISPLAY_VER(display) >= 12 && DISPLAY_VERx100(display) != 3002) ||
>   		(DISPLAY_VER(display) == 11 &&
> -		 encoder->port != PORT_A);
> +		 encoder->port != PORT_A));
>   }
>   
>   static int dg2_max_source_rate(struct intel_dp *intel_dp)

