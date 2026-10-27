Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793061103;
	b=YxxjxQZXHpzWvkdZ32+BKDu0dv/be/K5A6q+ilZcV+fWfQxYe+vz2TUllCNPi1ULoQXI
	 VAYqxvrGaaKNyNS4aS3necv2ZocUvxyb9rBfIww+JZrM9yy++OJVC/xWtwWQttBa8GtZj
	 YZ4PuJdKW7vYiXpS+RlMYT+6SQ1sDLOLRGYxIOV+MTzVlgS+8gXsRwbxm2CIXoUjP4MsN
	 7C5J9ZiYR0nlrGKd1PDRWH9WQhwG6RTZnEMtKezbOvp7iVDSRBGnB/TS/7BIt72ZbG8xr
	 khK1ZZkynmqQh6J0owX+JMQZT7lo8wenorBrWsB/APos8ovWsWa4SrPYukFmOLwADxQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793061103;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:From:Subject:To:
	 CC:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=FsNBU7zO9w/o6yg8RnJo/p3oxzTPud8/WffyicgS0u8=;
	b=nM+l80XW+qlk2++ei2hy6nZMDhIHp/IZwcoFgsZPkDiSzjqcJSk7dQmpInIBdZEyP7hg
	 OmiTrLimVw3PG0zIaHbKTwmShaKEEUSitul0EV3j0V/U1a8+ZYeB275G7RX2eaMjiVQ9j
	 GSd5t5hN4sGtdxKesuBA7+ll9tBZx5IeOHdxagxTMSH5Xt+S1zvcFC9SRN2+AGTurwjZY
	 12YIpJHw+L3R8705FwK+Wy0nW3xWg2knlCsRNkJz2AX2fM369v7pGthDNLhUCkY8/Zm6H
	 p/0McIydUGlE08DknanDzYDd0/lPmYCDfhRa1wtwi7ywG5bpJSWIq2C3VVcX9GhluwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fZQPlWyr;
	arc=fail smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF2E606A31A;
	Tue, 27 Oct 2026 00:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EF2E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fZQPlWyr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793061101; x=1824597101;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yBMXEaeUZldXu1X3qBXFF3mVz2Gud0keXGIXOjX1IQM=;
  b=fZQPlWyrTJ2i7LHGSBKxNViKTggsZSEl/zCClLDDUegKJ9RtVd00BnVP
   YfdUG8M1gT36v4ZFHJHzuMZ6akkJSMXQRehyUQJPGd4SnG/UBAyhFed0b
   jmcTiMi8QD5L+aZbXwUa3xC3qP+bGAnI5LydnjoXgyrHqRmGmXxMefYo1
   7XmE42uwl5ubl0l3kPz1HYA03D8LZpZOLajHoCAgq3QGpl/8VtBstBzne
   eFqgoNgH8RqeOsrX2iPQO0orBZZd4IZYBiyL/w7GOgjn5fGcaQYXBKs77
   gIsFqsXRdulsA5xzIj+zaBRxDfFUNeKdhiz/zoUXNIJw5EY5uah7bkru7
   A==;
X-CSE-ConnectionGUID: 5YdpAXqvTie4smxCSPcZZQ==
X-CSE-MsgGUID: +UA3+WXERE6f1Z7+Hyf7hQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1651748"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1651748"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 17:31:40 -0700
X-CSE-ConnectionGUID: NNFE8/PjTX+ZijB7DriKkQ==
X-CSE-MsgGUID: NOpkKd+XQe+LJP3dHAfWWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4265880"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 17:31:40 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 17:31:39 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 26 Oct 2026 17:31:39 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.64) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 17:31:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEPQOm4N0nqouQ42kqYJa7M/x3BVdqPgFEQvKswcxYuSkDH5CmEviv4OK/fnd37IBD1Iowz9J8g8m8CpFw4xYUrVI2P/tuPntVESc/jTvUcTvEBfDfeEVeUn5ZVjFvuPI7P/BeiYUOM7E9sLrtseH/RzHQ/m+3Y4dwhlFataxRRWIv3l3qNWWAP7E0QPNezA0idt3D6Z29PZBx2k55K3juY9AnNAdEUsnJbMBxVJ4H5NfTnYWe1SHrIbNetsJnGNy3o8gYuGD8VzB8xKlovHziAJBOt46628VKoXhf5ydDnTTYvVGsgwxXWJXtI24MKep2NBkIJy6Rz3leSPV5xZgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FsNBU7zO9w/o6yg8RnJo/p3oxzTPud8/WffyicgS0u8=;
 b=nj2Zqs9yOhVNUTDgJU7IAKFMHQAVNYzZ4I+1kU2GKf6js+Tjk+y1sLGCJAOXyCG84bd5bxYG8Fo0eABARdDAT6PABdyJs+CJFeEejHgL7PjxJFdbVegor1Q7AiggwI+XNLwwqSziNdDwgDLO+2iyUwmTDv/r86B+9O0vqIz0rn/uVvMKwPLEbPAuqDv9NlL2AtpQj43J4TvxRPV8Cv/0RJaNIRplX7z3TEHCvckViatrlqjMFHquFKqCSN6YWg4Testz5x04AAd893LGg6IbWaBZAU/fQ6wgl7Jlt4zWQ5JadMw1SElJoybBXpJeYWd/pTly2SEsSS3aNwkXKk83nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.22; Tue, 27 Oct 2026 00:31:35 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%7]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 00:31:35 +0000
Message-ID: <5018e458-9010-40f2-ae93-0f8ce8fa80f8@intel.com>
Date: Mon, 26 Oct 2026 17:31:33 -0700
User-Agent: Mozilla Thunderbird
From: "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH v2 1/2] x86/fpu: Fix memory leak with dynamic fpstate and
 exec()
To: Guixiong Wei <weiguixiong@bytedance.com>
CC: <x86@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <cover.1791428412.git.weiguixiong@bytedance.com>
 <b9277cad5e1098d3e60d5c0f025c58061df10af0.1791428412.git.weiguixiong@bytedance.com>
 <d28dc497-a74b-4c52-bb6c-8b9010f9ee2d@intel.com>
 <89727492-b1d1-4f14-955a-0673ebaee753@intel.com>
 <451788d5e97cba38274e663d2b7952c593e959be.299fa9aa.210c.4b1f.9ab7.7acb67f42a19@bytedance.com>
 <bb50436d-8af6-4420-b626-97f262f6759d@intel.com>
 <451788d5e97cba38274e663d2b7952c593e959be.a7410b9a.6322.4d63.ba47.f773788cbe75@bytedance.com>
Content-Language: en-US
In-Reply-To: <451788d5e97cba38274e663d2b7952c593e959be.a7410b9a.6322.4d63.ba47.f773788cbe75@bytedance.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0011.namprd21.prod.outlook.com
 (2603:10b6:a03:114::21) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|MW3PR11MB4539:EE_
X-MS-Office365-Filtering-Correlation-Id: 8efbe6d1-7754-44fb-a0a5-08df33c1a807
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|261026140227099003|4143699003|11063799006|56012099006|261022105027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: NaQm/vDyKEjf7C07zEh1lJAmjNoMDHwQlzh7GSxIDVeIm+iSd4zWD0lKQYWcILmTtVU8vQe6uNtt9LHbp0eFl44p2VugDRi0eV18Uhn7s7QHaRDekXKPI+rfblCa3KjDj4yv4s+UjoK110Fk6DDSjUHDsGZLZd6YZa2hJz2BJJ9QJIo0yypznqEAfLjmlQDzZU2rHIpl5GAndi7twpotqXgC51XKuYxUK5fYTroD4ZF2DfearKdwM7TnyDUx7GWjf0FkGWePEtfmY77WpL1NuJedNobgfYRbuRJQBftEQoCzuxCtk4SCux9+lFDk1XP38oS3OD4h7QN70NMVcGP0GP6OPbU0QrVIhowmTkGTXTKU+0E66rX/AEZgXwt7m+p1Sy3tSiMrVniuNfHneWVSFrxnvBlki5t4VDnQuK63m5lfaP+Tjup23M+WEHh/eVbRrWACvDoUBTWxP0gt9sdDBoyqSYEI84PoMW3DsM5bF+1AitOefd5753rsrCGaA2XD7rlInwZ/eGGdwFSKPOSeZoL/4Le2go9gI8KvwF0R4ogICcoXLEG+VZ+E7oO2ID3NE+W37aKQPns+W6UdOZdKQ57QOWIaYLvTO7AsuLs9JFXcZ9PFP3Xg0qV4YzUIeetFjbvTqsXKZ3kM0I3dsLP5P7uG1qXnJu0tqc4qA5RRbZY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261026140227099003)(4143699003)(11063799006)(56012099006)(261022105027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1RDWDdQL09teFd3QzhieFBDajZTTVhXK280MmhQbndqNVkrNFY5SUlLYSs0?=
 =?utf-8?B?TCtVVjNxdUMxbVFxOHlZdDNkdE1hVHd4dXpWVDU0U1p2NmJPQWh6MEs2UEcv?=
 =?utf-8?B?dWdCZ0tmell5TFZFQU1NMWRZdm4vUkU2Mk1LRXUwUXJGYVcxQVNJN1VOVUln?=
 =?utf-8?B?N2RtWEltcC8zRVd0VlI1bDhDQUliL0tRc2s3Nkw0dkpFOUkzS1ViTHA5NTJ2?=
 =?utf-8?B?bDNsTXd0aGZOamN3djVnOHhLb2JOWEtaSjZ0NzcrK2hFSFo0dmhoTDhJRnVy?=
 =?utf-8?B?RUx3azIrQmJ4QVdVMTh1bDB0ZEUybnFFNVNQMFZBOEMyZDNCb0pSK0RIaWZs?=
 =?utf-8?B?VnRod2t1NjRvR0NzdlBPNlBlaE9NK1IwVkZZajlOSXlhbkRPbUpjVkozQWIy?=
 =?utf-8?B?d3h1dkhGVXIvcTJpMXI3V21RaWRkQ2JUd011TmN1TXVxWTRxL1RLMVRFV2Q0?=
 =?utf-8?B?bENRNTN6VjhGTEU4d3BGbHdPMVB2cHFnNiszbGtteU93VjVBMXFqOEduRTV1?=
 =?utf-8?B?UjBRUERXM3k1Rlo5bjU3UWdsZ1NBMWdoMWkzTlgyTTZycUI3dzJnWEtQdUR3?=
 =?utf-8?B?cHNXRjR1WS9iUHYvQStlQm14RktWUUNnSGIvR2IxS08zbENFWWlCU3IxOVRL?=
 =?utf-8?B?cmdCVy9DQXJsQ2NyajAvOUdwWFcxNFhGL3ZKb3BadmdNUDVqdWxKdkROR1Vu?=
 =?utf-8?B?dzVqcnEwVmFtY1VSOFZkczdJREFjVFVod294aHc5QURncm9EaVlVSUdwK1Zz?=
 =?utf-8?B?WmQ0cng1Snd6Wk94Q2hWZ3BXWVdhc0VKS2dRaWk3dHE2Z08xZCtGU295d0F3?=
 =?utf-8?B?QjJGOUxnVVBmb2dLa1M1RENXRWRlTXlscjZSU0VacTBUdU9jT05tZlNGZ05T?=
 =?utf-8?B?R0ZCbUJWamI3UThmbERUL2duSjdVTnlEcXRxMmVWYnlVT2tTRE5waVExSU5p?=
 =?utf-8?B?WVdkcEVzeUJoaW9uNmpRRW15bzBUcWFMVkp2LytGenpsd0lvS0JrNGNWOHlP?=
 =?utf-8?B?Tjd5RkJ1Wk1RRis3TzcrZGxvRS9RY2dmVEZYTmwzOGI5K3F3VXVzWWtLdU5r?=
 =?utf-8?B?WVdQVHViMS9hajIyMXVkRytsT0NpOTlDQ0J5QmtGSFpRa0EyOFlnMWhHeHBh?=
 =?utf-8?B?NFo5eVJMK0lzNkhxUGVrbUpVQkh0ZEtaTDV5VWZKazkvQzR4Rm1kejN0MUxJ?=
 =?utf-8?B?VjJkVEJ0QTZCeXBmcm0xbUhOYnY0Z0RZM3NNWjJOOUpreG53Tmd5empsMHBq?=
 =?utf-8?B?NHZEeGpIUWtLVEZ0K1FySDUxZkNucytaSktSUWFaM01PRVRXOUJzRFphU2Ro?=
 =?utf-8?B?cGJVUklEOGM4TFI0YXZIRithYVVvT2lVWlhLYi9yb1ZaSU85YzluUks3eUt3?=
 =?utf-8?B?QW1ieW5wU0tWQWtmdlZGNHovZlF1YVBKV05kdnluNFBJclgyaGdBTWx6WnZF?=
 =?utf-8?B?WmZYZDZRbU1MdjhSMEhSM0FpelQwMHNVbit6NGkyVGxIYnExajZNdnhLTnps?=
 =?utf-8?B?Q2lEVVlGVHl2YTRCQmdDR2dUUjl2UElKUFVibk4yQUlQdWlLR1JqNnNjZWtZ?=
 =?utf-8?B?TVBtRERxRzFyczExUSt2S080SXgzTkJVY1ZBMHcxZlJ1b0hTNVlReTNHZFhG?=
 =?utf-8?B?T0lZYWhHNTl1Umxaa1RKbzNHblR2NW9yTmtORjV1ZlJuU1gvaUxuQW84UVFm?=
 =?utf-8?B?OGd1R1h3Z2QvVTFMbUJUV1Q1dVMxUkt0ZHQ2SFl3RHJKeTZjeGdxbXVJbEVE?=
 =?utf-8?B?N2xaNUQveXRQK3MyY3A0dXZwdk9QYVMyMEVSQ05sR2xWYU53SEFlVlp4SWN3?=
 =?utf-8?B?cjNzb0NJNC9SekRyemVwQ01sVEZ5ejJpbWczRStGdTMwbEY2Q0RzYXlOWVZo?=
 =?utf-8?B?SFNkQzlCNGtPQ3pnRXNWK0dRYmhnbTBoRW9FQVpabTd0UndvdHlLbFRmVW5m?=
 =?utf-8?B?ci90dlQ5eUxaNERmbU5icW15K1ErT3JEczROZDF4Y056Y1lIRkJZVUhGTHcw?=
 =?utf-8?B?bEcyT1liVWpyTWVGS2FpcW1UZlQyMkM5UGtuekhCK29CVTlJdTk5Vzk2N3ZY?=
 =?utf-8?B?RHNKakM5aUgrZ0g3RmI5d3FydStiOWNCb2NnWTRrR1ZGZmNwc01RNlAvSTND?=
 =?utf-8?B?UDFrRS8yakFnYW52L3hHRU9SY3JMS3Y1UXk4VHNaOGpKT3dINzFMU1M4Y3RQ?=
 =?utf-8?B?am5ybkwrN3dISnh6VGQ2blNHUU5RYTFuSmpHUE1BSExqN0kyeUlrRFVnNmgw?=
 =?utf-8?B?TTAwVW9VWWpPVW9YMzdhbGJSZytpYjBBT1ZkdndjUlllalg4TWFBUW9xbFpp?=
 =?utf-8?B?TW5PRzVDK1pEV0Z3NlNkNHQxbU8zWkpvVUpCMUlwMmVQVGpqYnE2UT09?=
X-Exchange-RoutingPolicyChecked: GJ7zOjSn/psKt/oUi90y9bFyei5K6KnxeQ9m79WZR3Wd8uRhIifkHNO1L6xsyjCB+5njz8wm+CK5Ks4MYQBHbW1ANlYWj87e6cPQm+MtUKpVV5QctY99lKyB7qCbIIpjM9oVbnHsH0LXoXW6U5Bc45eZ6NflltkRw++69BkLSeYUamdkddeXCzl66st5EE0gQ8uzm9VBnJdgTiBHGxhPh4FDMYXMHh918KKKImCILFFFveBjhawjyy5aRMxRABKUvgftZmtJN5fMR0UsMG/bk+zJHOzk/40RP/+LtSemWN7DnOK+6POF+BBqlMVK8rGChkPQDjx63moA9DxeiOLCQw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8efbe6d1-7754-44fb-a0a5-08df33c1a807
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 00:31:35.2586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DcYZluI7YXO68Ioa3FdRhsC4C7h23DxYaNKZW0bdbf1c9XbzfA9OwhU+/5yR0POFNhxteUSMQiB6YpHM3KLGY4PQR/NLmuR55Co18oVhlXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4539
X-OriginatorOrg: intel.com

On 10/25/2026 7:10 PM, Guixiong Wei wrote:
> 
> The fix then collapses to two changes in core.c: free the dynamic
> fpstate at the start of fpstate_reset(), and clear dst_fpu->fpstate
> to NULL in fpu_clone() before the reset. xstate.c, api.h and
> process.c stay untouched.
> 
> OK with you?

Yea, I think that could be an option.

Thanks,
Chang
