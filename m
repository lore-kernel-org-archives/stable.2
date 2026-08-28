Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260C8233945;
	Fri, 28 Aug 2026 04:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787892288; cv=fail; b=WhRNY7xeBueh2pJnTnnvGiQ/FR637bo1f5IO//kZ9Y5k1S78ZfrI02BYMtqVpucz/gd6VisafkDbN942JGDX1TeOKC0Zu09TV/YJRuUWx9b6EFRwV0xU3iNyG7HCMvk9EpRjwrdYv8uN9OanW3P1kbHkDgxtK2OLIJhiFKuHWR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787892288; c=relaxed/simple;
	bh=LxFzjPAWZOWZ6oTzOAJqkAI5PWq3UG1EvvJtFcmB5s4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nwgtphrpGTbkxvIzIY7sxOwG+CqA2bB1DrCMqn3UUX4Nx7Jk6Eq3VEmd34pOTZbtbKkmbxe9i6E+7iGl6+zuoMfQs3xG+GeYFEyylgvz8wcV6+JHP19qtiH7g1W9+Cx/XsxNYY3nVJdEPR3jn52r4+tJv529mZGTP7DWvHLeXxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JG7VuYOH; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JG7VuYOH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787892286; x=1819428286;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LxFzjPAWZOWZ6oTzOAJqkAI5PWq3UG1EvvJtFcmB5s4=;
  b=JG7VuYOH+o8opYtl6/2ig+9Js48P8MmfOzKRpsXVYJ2QwwxxEqHLOtHS
   ODeu2tqfM6hwLXqBBznEsFRMyznB47r4G084m7NGmZKN6QnIKoccmeuly
   X2AFqm/O50AZUDHCMOyqE6WDLNLSoFtRvoG8QDdcxjgR98JndoZj5k2jm
   mnRkJBPSDLRBFLgjZk8QLcnAWOYPOOqU3TCfUVc2JjlBBQPE2cddL9SI8
   3xelQpcA2EePc9rCK4t4wMEeVynK3cKWse++4PZ2LGtjIoOCEaFWlYQDR
   hS7d/BAgZDOVyMzUahJdNK7mjgkQITObz6WjS6M3So+R8K3t4Hm8g9AMq
   A==;
X-CSE-ConnectionGUID: byi3o93VQzKvvn4EAF1Q7Q==
X-CSE-MsgGUID: PUqmjYZnTB+87TEk10FluQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88422389"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="88422389"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 21:44:46 -0700
X-CSE-ConnectionGUID: jLqRRIEUS0urh1cU7VINRQ==
X-CSE-MsgGUID: 7FUL7C6tT6SGJMrRzKma9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="270019534"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 21:44:45 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 21:44:45 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 27 Aug 2026 21:44:45 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.63) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 21:44:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMgKO6ondq7XF7rMW4IrYyXdRaWopLzdUkg5/yqFnSq5knOBATiwNNdky4xu6ZTjVn85+qKaCohL+dH9032BHeqP8Nkm9RYqm17tGJKnwBDjevpQJLcw66lkcOYNoGRuZHiCqd+Hq4oCuSJsISvDXaAGkr4U0pJ+tpvTFzp7uWcIVk6pyHgWx9B0pgCMuqMXzAtEkjmsIbq7Gx7YCR1OuWFMJ3NCipfhrhf7g+nN9TJ8pEO9gwQymkfp+k4oB90dqAmDqCr2hmA/xNasU7N/fRs8fSMFX/R3B8NrL7qJhvWpt15QzU6bTQtP01nJNIEzpPRHLKkPBtlrBS8dKO9cjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOeBQGZ2GY/BcJazP3JpVZ6EnBFLLM/p6uQi2qrgo3U=;
 b=qnT30cfxRtCOz4Y8EUmGqXFCs1YQp08iIfMCHgsqRbazMSGlnJzVrRDpChyaI+544kxzmFBctYyS0/HDQB8A388QTuqG/H2tT3ttDgOucC0IIVfE+DjqMk9dp1WJs7x8EnnpcDGQH2LwRsd4xaMbWg76xaxw/NmTmdJ6pNDBeqhukaq3zh7399k7J1znnT/i9coCo+6MSOZUl3HboL9buPrbkybvJM4Z7ZmyfaiL2bBgm9SotgGbzAb2QcHROsk4mx4c7Gr7iVAA8qJ6gzdhHkNITJgjBSXYQuAnQ2uzn+asQMEqhqGt1lf+7sGduMoNZ+VGasp9UuGff1xIUxof1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by IA3PPF1805EFE45.namprd11.prod.outlook.com (2603:10b6:20f:fc04::ce) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 04:44:43 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 04:44:43 +0000
Date: Thu, 27 Aug 2026 21:44:40 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
CC: Hui Su <sh_def@163.com>, <akpm@linux-foundation.org>,
	<balbirs@nvidia.com>, <ziy@nvidia.com>, <joshua.hahnjy@gmail.com>,
	<rakie.kim@sk.com>, <byungchul@sk.com>, <gourry@gourry.net>,
	<ying.huang@linux.alibaba.com>, <apopple@nvidia.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2] mm/migrate_device: avoid out-of-bounds writes for
 compound folios
Message-ID: <apESOAPVzggWmbcJ@gsse-cloud1.jf.intel.com>
References: <20260817120758.669807-3-sh_def@163.com>
 <4ead5df7-f000-4087-83e4-13aae036e0b7@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4ead5df7-f000-4087-83e4-13aae036e0b7@kernel.org>
X-ClientProxiedBy: SJ0PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::25) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|IA3PPF1805EFE45:EE_
X-MS-Office365-Filtering-Correlation-Id: 645b62b1-14c0-4243-f4fd-08df04bf13f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|7416014|10067099003|6133799003|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: tvKIfNBETvlSVAFAxO/zLXePLXgtFeG3MfQJdw7h0R7YVHhupQ15APQw/Zshy0ai2bl/f/uIsTLVYWSQXw7O4/LpQPSsn5JfAFfo7wA8j3DWbmqx77/FUJEoboZEAhMKOCaSIXREnNuArO64/1oEPpQLGGEBGBMyZDnUVGbAPsapB05rKHGKjh9JRE+/hpGs5gG9xiHHsVoIvRPHu9wfCdlzlEHjt6H+205zHiwwX9gIbbsfe15EKi05In+c+LxGaTixEn5fyBAIFFLOhXCkGEtlVkBSBpoj4IV0p3Yqb5SjTbZOEGJHJEIi8/pib4m9pSnMWtmPs5gDQgCr2/PDHe9E+EB8LkUYzlM6aTg7X96NaMr2ksgOJZe1s8znfihyGRfaH6Me93EYWpOU+cU1L19znc2g7dluG5cq3N49+f5I+jUjw29JKpGom7ag6h3uBxiUUS0XohBoMY2hzJZSTzJF4J7lwSRrjgx/b7rFzANeEGcZKB+W16ceLNAShiS5ZqoWrmY7j830e6aThKdXWkw6ZHFiY3fNWWzOrEdMzCCC8Gb4y7kGUZjK2t8FPbZ+IU4OG9Jmjb9I4YnBMtjd0Na8FgDOrZiP8bY4jtpOa9KyWxmjM74gompuXKuHT8X+7Dgv0nHS4Mg76Oe2PvCk1VmX1MJqbKJFbanHN9el3VI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(7416014)(10067099003)(6133799003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M7jIhjkHiiwJ1xMnnQ5CGGwXuxpe4dIINhSHOZVIZWAtEsNt1wFIM3Kx5hXU?=
 =?us-ascii?Q?kijo1zSyFY50PVxmBiJW0Y5mxau3QbC2PSVX6KMbmxiruUtRP4MvmE8m3o91?=
 =?us-ascii?Q?1n8BLxGmuevvRv2BPyJuNg8+mvGBy4Xb/pPztPz9JU23xXRoTrWTIsNBXYWX?=
 =?us-ascii?Q?ICfRsfDQ1C6xW9N0TFID5qjwyRbvTQxks8xhem16Py3EovQM1uUA4QSp/N8I?=
 =?us-ascii?Q?Y1n4zG69TpUlN2FxxO3+4MDr7FdVAijlo0C70daEtfFxZnR7r1+56NnfCe2+?=
 =?us-ascii?Q?+UiRS42H13vWZFjwGV9euns4iLXcoeDWagjtli0B0muTiNxnslA4ud9QonX1?=
 =?us-ascii?Q?C4yP1ba2/UOUwCT7R8ON8k0nh7bFbkojWQkE6NwXbeprkyZkzW8k/HcAl0GR?=
 =?us-ascii?Q?pEGJbEuvaahZbMv1KNX4EnL8BuomVcNNXJyb/Cpcn7GjKUkyXaSclhD+vh2j?=
 =?us-ascii?Q?s9j0Wa+V5Q3PYz8D+LMRtN5SbYVz2sSS4VXKkbzyNiLDPuJTcgtmJjRcnz3c?=
 =?us-ascii?Q?9XaROcmqf4pIx3ais0B5ZaEYK3hSSMvcOdjT9EcbIGEP5dI+50G/yOU+zM0k?=
 =?us-ascii?Q?m64H7YCm4cGrNAfwA82Y0raOlYrnx1lOyoITfto0u3AINGkXOxaGMlYa9AtX?=
 =?us-ascii?Q?qCmncii5edo3PX5znGG3pGH2sRWWjccT7xmkEbpKlhGCOTqwMavZSJ0zFYyK?=
 =?us-ascii?Q?yEF5yKhb76alPbLWpSH7wSFT+9EeA1aXHPdMsB+3BsRxFOdXGTetWz5rQMjZ?=
 =?us-ascii?Q?6cg4bbjzQlkpFKVVQ4vNg3etR80c7gP4xBHmiekwAYgxbICrn6eCRlifnA5I?=
 =?us-ascii?Q?DSbJYPO69Py7U0M9Wj7wcBPMrzxSIRo4HsbjmjjFLCBTciPk30zzWdzGd4+q?=
 =?us-ascii?Q?HD8j6X71+Endic/g7TsB6akbtj/wqZkY8JNlncZ+KJEVMf2DZ9kJev0Bw+y+?=
 =?us-ascii?Q?6B5/lpcvhZslTdUADZpvypd1LjG3i9jUAbpU/DAM96OGbQkI4L4kcBGkdugc?=
 =?us-ascii?Q?sBFVx9aNJ9uxzdYfw9J0qO/PPwSQzbIDhpgA57y3ZePSzcVkjk2bVp49JdwK?=
 =?us-ascii?Q?aTiUq1GGVUqMHz565SS52nhTLkVOacPUxBZvaUQvg6qODmIprFfqw/IRY+UE?=
 =?us-ascii?Q?RZ2+HPe/6fjtajbLoxr1JpwQC7IgMBHflR8X0aK2/PwwwBE0IxMPfw1vXoWn?=
 =?us-ascii?Q?bfG8cnW0oopSq1ri0A+C2rEQKDA8jxwdyLZO30O+aKxJTT3/kusPHSijBR8p?=
 =?us-ascii?Q?oUMhMwnB8nG0tHm7sOueInajEKyF4DSn24xmMKTbHud6Bb1/VIU0uYGyd8B7?=
 =?us-ascii?Q?G+7BEfOdusu4AXXAQJ7rJokC/q7CGcDwtDSBUIB+T33IkdhpvauMxKkDNv31?=
 =?us-ascii?Q?znVpmGbKSZIVibNMMqPItIsxWCy6e56fGIRBGud9B/f+e79R0pvFn+V2jol8?=
 =?us-ascii?Q?Fy5N2VoVBUzK0JYxHTCf4S4I/eq30veq6dw2lDw/TdXD6Y5s5ci1YdjPzzze?=
 =?us-ascii?Q?Wfo2E4OKRdGhFKeoQjoIRAnfwaf0c1Av5DtgXLDz+ujARY5/DseHya9Smale?=
 =?us-ascii?Q?mEqjT1K0Fqm02djA6N4GNnPQvRYQ51kuoa37c8p/l9j7UcckAcVI5ZSV3O8w?=
 =?us-ascii?Q?bH58P2A0E3rTQANgYYhxUcBT81JJFVJQlYcepjoV/gACgYX1uK97iuwEebov?=
 =?us-ascii?Q?aZPWCRX0EIT+LhZ80bFtapf/NyMOV5wJn169ZpV/MXSEH72ScUQUuEigqCAT?=
 =?us-ascii?Q?sEI/IEubvw=3D=3D?=
X-Exchange-RoutingPolicyChecked: NqE2IzeuYAbuxThHEwi0mRkew5YuQBNZ2zH1vZa6qr0cA06tYvgiinh20zwsezzkLqKrH9eWQwWVpUtpTHSit3y71QLXaHciuJAevOnGOFzZLI/LfcQxqsWjDzbT834X34a4BZF6KsuJR5Ato/EzV7z2tvlSAlNP56+1yrOYy1K6tPya3HnWFfsaSme4PcTw7ljQqQNxTFAJispgyXBi0/GqPaObW0iR2fI4xyUKbo+iR81jCkG0q8UEQec9HiGELIm3saR83DZlFmI/YO1XAZiNVQDcq+ohsLu3R4TbkxXZK39rY3Q3AFpFc53IZ7B36NYg58oWbImiE0B84CcqbQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 645b62b1-14c0-4243-f4fd-08df04bf13f8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 04:44:43.2805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8u8nmbD/lea+26iHzUyMqFZs2E8gYjjcgdLUeKM2tPTyuIoPH4T6yzOsGFNxSv1ePkg6qB/NkuET8IdVtllf+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PPF1805EFE45
X-OriginatorOrg: intel.com

On Thu, Aug 27, 2026 at 05:14:40PM +0200, David Hildenbrand (Arm) wrote:
> On 8/17/26 14:08, Hui Su wrote:
> > migrate_device_range() and migrate_device_pfns() clear the entries
> > following a compound folio so that the PFN arrays retain their
> > page-granular representation.
> > 
> > If a compound folio extends beyond the end of the caller-provided range,
> > the loops clear all following folio entries without limiting them to the
> > number of slots remaining in the npages-sized array, causing an
> > out-of-bounds write.
> > 
> > Do not proceed with a compound folio if its page-granular representation
> > does not fit entirely in the remaining PFN array. If this happens, drop
> > any reference and lock acquired for the folio, clear the remaining
> > entries, and stop collecting.
> > 
> > Observed with a KASAN x86 QEMU kernel using the HMM
> > migrate_anon_huge_zero selftest. Closing /dev/hmm_dmirror0 after
> > migrating an anonymous huge page to device memory exercises:
> > 
> >   dmirror_fops_release()
> >     -> dmirror_device_evict_chunk()
> >       -> migrate_device_range()
> > 
> > Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hui Su <sh_def@163.com>
> > ---
> > Changes in v2:
> > - Do not partially represent a compound folio when it does not fit in
> >   the remaining PFN array.
> > - Drop any reference and lock acquired for that folio, clear the
> >   remaining entries, and stop collecting, as suggested by Balbir Singh.
> > 
> > v1: https://lore.kernel.org/lkml/20260817074350.442493-2-sh_def@163.com/
> > 
> >  mm/migrate_device.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> > index 908d2d4ec43a..69b8d0660bab 100644
> > --- a/mm/migrate_device.c
> > +++ b/mm/migrate_device.c
> > @@ -1400,6 +1400,15 @@ int migrate_device_range(unsigned long *src_pfns, unsigned long start,
> >  
> >  		src_pfns[i] = migrate_device_pfn_lock(pfn);
> >  		nr = folio_nr_pages(folio);
> > +		if (nr > npages - i) {
> > +			if (src_pfns[i] & MIGRATE_PFN_MIGRATE) {
> > +				folio_unlock(folio);
> > +				folio_put(folio);
> > +			}
> > +			memset(&src_pfns[i], 0,
> > +			       (npages - i) * sizeof(*src_pfns));
> > +			break;
> > +		}
> >  		if (nr > 1) {
> >  			src_pfns[i] |= MIGRATE_PFN_COMPOUND;
> >  			for (j = 1; j < nr; j++)
> > @@ -1434,6 +1443,15 @@ int migrate_device_pfns(unsigned long *src_pfns, unsigned long npages)
> >  
> >  		src_pfns[i] = migrate_device_pfn_lock(src_pfns[i]);
> >  		nr = folio_nr_pages(folio);
> > +		if (nr > npages - i) {
> > +			if (src_pfns[i] & MIGRATE_PFN_MIGRATE) {
> > +				folio_unlock(folio);
> > +				folio_put(folio);
> > +			}
> > +			memset(&src_pfns[i], 0,
> > +			       (npages - i) * sizeof(*src_pfns));
> > +			break;
> > +		}
> >  		if (nr > 1) {
> >  			src_pfns[i] |= MIGRATE_PFN_COMPOUND;
> >  			for (j = 1; j < nr; j++)
> 
> The code duplication here makes me angry. :) And using a memset on one branch but
> not on the other is weird.
> 
> But is this the right fix or rather what
> 
> 	https://lore.kernel.org/r/20260805231041.3791771-3-matthew.brost@intel.com 
> 

I'm not sure my patch is right now that I think about, or if this patch
is right, or your suggestion either :).

> tried? That fix would also need a cleanup but seems code-wise simpler. A cleanup could look like:
> 
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index 762c5cee8fecc..480bf59bc2425 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -1419,10 +1419,9 @@ int migrate_device_range(unsigned long *src_pfns, unsigned long start,
>         for (pfn = start, i = 0; i < npages; pfn++, i++) {
>                 struct page *page = pfn_to_page(pfn);
>                 struct folio *folio = page_folio(page);
> -               unsigned int nr = 1;
> +               unsigned int nr = min(folio_nr_pages(folio), npages - i);
>  
>                 src_pfns[i] = migrate_device_pfn_lock(pfn);
> -               nr = folio_nr_pages(folio);
>                 if (nr > 1) {
>                         src_pfns[i] |= MIGRATE_PFN_COMPOUND;
>                         for (j = 1; j < nr; j++)
> @@ -1453,10 +1452,9 @@ int migrate_device_pfns(unsigned long *src_pfns, unsigned long npages)
>         for (i = 0; i < npages; i++) {
>                 struct page *page = pfn_to_page(src_pfns[i]);
>                 struct folio *folio = page_folio(page);
> -               unsigned int nr = 1;
> +               unsigned int nr = min(folio_nr_pages(folio), npages - i);

I think the semantics of both these function should be that if a user
passes in a PFN array and one of the PFNs exceeds the `npages` limit,
that is a misuse of this function and we should unwind and return an
error. The caller is providing the PFNs and should therefore know the
backing page alignment, so `npages` should always end exactly on a page
boundary. The sole caller of migrate_device_pfns function is
`drm_gpusvm/pagemap`, which certainly adheres to this requirement.

The two callers of migrate_device_range, also seemly adheres to this
requirement.

Matt

>  
>                 src_pfns[i] = migrate_device_pfn_lock(src_pfns[i]);
> -               nr = folio_nr_pages(folio);
>                 if (nr > 1) {
>                         src_pfns[i] |= MIGRATE_PFN_COMPOUND;
>                         for (j = 1; j < nr; j++)
> 
> 
> And as a further cleanup, we'd better de-duplicate that code and possibly use a
> memset for clearing, getting rid of j entirely.
> 
> 
> 
> -- 
> Cheers,
> 
> David
