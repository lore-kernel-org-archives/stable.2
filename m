Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9DA78F2B
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 00:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459179; cv=fail; b=R1RjHdSX16Po1I2u0bEkYxhGGQuMP9idica39gqtrU+nJxU3j+3eFvZU1Bl0x0vkW/OCKmqZGbLIlHY99GWBGBYtV2FWJYiknwhaTaaMLFvMjb+ZtxY6VUKmBN2BJlZgmlp2FqXRrx6is67GnzMky+fgyJsOEKVg9kefrnRIw+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459179; c=relaxed/simple;
	bh=iYuLZ14TS8C+bQZ0GzLIbPfV2xvs5b16pQap8w49wv8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q8pMq5l/Powg7f//MXRgbAShjR37buUFcHGWyXR3faJZKxK1735mddPoF7a/2ka2DvAyn0D4pN4tGvlI/qpzP6GXt5rnKIC2/HDpb533JiWSSg+bidt2Cv85G3iIgyGAzjYNbrgmT/KUx/zQGvZjPnCclZKKxm/Pwy9wZYajHt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gN5kz6d6; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gN5kz6d6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785459177; x=1816995177;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=iYuLZ14TS8C+bQZ0GzLIbPfV2xvs5b16pQap8w49wv8=;
  b=gN5kz6d6vtulUY5AjvLX+Ek/XQkFxpMqzCQlBfIchC9e+ptrsAbb6snd
   K4WbF6du/lfz/2MRYPBqC0MRMyuef52V3aTOAoBzprz06tLOtdnebZXK/
   ZFmEgUkmJakDunxb4BwEntSn/iMNmFv6AGOBrxTxsMtZNoO/I5XKaawug
   W/Sjog+XaTJEFQIwPH34PsG5tAqqUo19Y/Vb0BZcYh+FWbwwtkiy7rlKU
   kCklnTgq4MQhb8jz2eqhEJ3dCjn+eJblBBGJUrxOdkFtPq6Pb/p54qpno
   ibwHRd0cixkrFPj+7VlmClOYE/go3unN8+KDa3yL8VcwX2Ag34ukvHxaO
   g==;
X-CSE-ConnectionGUID: u+gP0sOMR/uxqFE0qmjghA==
X-CSE-MsgGUID: bsin+ckyQ3iDQ0dBcauEiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="96747734"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="96747734"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 17:52:56 -0700
X-CSE-ConnectionGUID: 1drFYJN4TYqHl5SPJMHqmQ==
X-CSE-MsgGUID: 5mPhQ+vmQYmfVfHarDJvBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="263929717"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 17:52:56 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 17:52:56 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 17:52:56 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.16) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 17:52:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5DhT728rqFqGYfdYFqsaF4TQLiy8lTP/2k1zj+lTh99dOBQYUAJVb1vPwoXWq/HA5NoDHC5nxaufBtbvBrtjbGfxHUMpyEAS6YNzvIxnGoGou8/PBjMxt6T5XAQFLsrRzxjPdI3ckUM4U1HcglXB+LdrNSliWuThT4jA7AX2jKhSPSRJ1ah9wBedOBMrt10E8feyM+2WSGnY1VMo9aT6wSeLXQdDMJOSi3KwBnAVMC5AWCVJjawV/snBAY/hbgkn8M70YKPj2RwXleup2yMgFZlb/rgnLqcZdmAJJr56wG9atgwmYw//Oee4SfnV3ix0W8EpGZhdb5naMRD9TkMMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcwuH8Tg86rATTPM7yZgtJLKAPGFBsY12+gBGWWZTYk=;
 b=RfBG6cCPDMhgGPXGaJJKuZojQhYOvY/wfH4DkQNRzxzpE91z6lfgybAqRkEyinJUNPw8aqtFdVgyb8W6BZAbMRim0XFWbrIL7nCrNnhZKLpdBNhOHrbvSPDBNxjroWVZIr5uk6AA1qxDRRZE7OWAyp3FSQ0w9bS9ueXIxg8wNjefCCSuJdjw01l9Kszh6TR+lUDeABZL+F/TsEGw85cCxDviE6wu+vIK8k0e6gOOWrJlfymebPOMbbJUEgjbDqyjAt5ylBjmb4XZ9cASMaHoxjj1voFx8wUIVvdW9biJff3TtglYX24lYVRGpgzZHKqcHV3TJKVSyIoC6VnuAoTEXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by IA3PR11MB8894.namprd11.prod.outlook.com (2603:10b6:208:574::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 00:52:43 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 00:52:43 +0000
Date: Thu, 30 Jul 2026 17:52:40 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: Jia Yao <jia.yao@intel.com>, <intel-xe@lists.freedesktop.org>,
	<gwan-gyeong.mun@intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] drm/xe/guc_ads: allocate UM queues in VRAM on dGFX
Message-ID: <amvx2Ev7I32jqH1O@gsse-cloud1.jf.intel.com>
References: <20260722053410.2767369-1-jia.yao@intel.com>
 <20260730004735.344627-1-jia.yao@intel.com>
 <20260730004735.344627-3-jia.yao@intel.com>
 <148b38ae-eae7-40d5-837c-fddda1299d9f@intel.com>
 <789a05bc-f33f-41ed-869d-0fbe45ebef09@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <789a05bc-f33f-41ed-869d-0fbe45ebef09@intel.com>
X-ClientProxiedBy: MW4PR03CA0188.namprd03.prod.outlook.com
 (2603:10b6:303:b8::13) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|IA3PR11MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: f4929b54-04b1-4ae7-b5ec-08deee9e0735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: CMmzy50++bHo5pp/Yrktrl+Kj/8WUhUzCPu1I03AJe71Q7TeC3JHZSoZB8mhKhIZIgwU7MRDcd9UQOfXbZjh5yRaOBYfQIZBm6o2YqLoldnHjKCZD4nErCpRPSGtCUKzc/SwodWGbicj3mZCnWbdsaqFxYaEo6S6rGs7yLB89mA4exEcO6HKS4jL+DfrMJHXXavNx0z7hD3OuS852qeKjde3BwDOUThJnI5P1mXssoBCMbStNd9mQEqflfrGFxoPlU0VVWdlO0SU2dxi6GqSYyG6l9IRRrIFTMdx+7yXT3nB7qVl7c5PZw2FY59oh/22on1hUfVrFPlqm+HnFH+/SgVV6lhR6bBxbHc8uOJ59vqkZIcdGWCDc+5BivsBUN2/0fwlSQCokT4QLsGkMW5nNINQHkcKDdPa8Dy7bTN7ymzi6/Zmz/M4fGGS3oDYavovzqdSdENUsmtxsIa8bJKdIUYicESFNjH+W+j2aMsxm38XfmHjNGsE/NYKeulmuOmIJFn0BYC4XvX7QQaI7PdOpZITemsZM37m7n4dLWHRoItQT2bDEiwd3XpdzqCvQccOAYygwogPjVb+Rk7ys9orQuJATI/nienvu78xLGhk8C9VkD/09QJgyBuPtyk1l41klaYKm4IhRSmzXEtsdBmTaSCIoZ/iOn0baO3ezbJaq/o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?e10gOlsNoOkRxepjcVt5JeGM4NAfFuzcM+MbtanhQ41ilEGxXlJnuGLWiq?=
 =?iso-8859-1?Q?uME0vxDDi7IQZ8E8BmQNf4aFK/NoiVDzKfxBy7/fBhJ+llbwfTB5L3nVId?=
 =?iso-8859-1?Q?T0UPJrAYpYKySieEUVCWOmYQf9Kpflyhm0zN9EQVzL2p2EMFpTDcc8/Ts+?=
 =?iso-8859-1?Q?ZoBkscJOHI/LgNOZhOLlvqbyCHwiTzLh1flmrUV3YnKcXDJx6rPt0GgLAb?=
 =?iso-8859-1?Q?ydsqufS6Y8HzThvLDDVpn9Ji4skHxyZXc5nJOPUzkd1qeaGWTZoBT1Dz4w?=
 =?iso-8859-1?Q?l9TzHSM42wswdKUuvS3eDMFKUPompDGIoIzjxHyclwNdag4qAf8Tkb5+wy?=
 =?iso-8859-1?Q?IW36LOCUhtHqd90q2jv8qOEJagDx4ZBCB//BGhKnYt7Een61XPBxN4qPMA?=
 =?iso-8859-1?Q?gfqDO6baO1EYtqYikumPt9xOc7yMuOq2HCA/MFMG2obTGMqIhpHGvU46kD?=
 =?iso-8859-1?Q?BcV/6LioczEou7hzeKynDOubycLRySoWf+VbcbMZ729EOMR3RAQtZbhl1d?=
 =?iso-8859-1?Q?2SDWiT5yBVkf+tP5dDFHcJGhLIoCcVr1UXZ0g9ufFSU9gYCf5eC9BrJx40?=
 =?iso-8859-1?Q?l/GvRO4x694qj6dyozvQg7hIH6c7LQl34mmvx6/d6wuoLM7RAhWpKbZY92?=
 =?iso-8859-1?Q?i0vsXcCfKFWkssB4wV33KylZ36owboVcsg0w/hv0C/Nz8CpShlW7aWwC0t?=
 =?iso-8859-1?Q?HgBmUQ1jQQXnms78JkrWxjmbh9LJcJGNU8zx+WqDrj/fUfCRJIUwvklASI?=
 =?iso-8859-1?Q?is0VGBZlG1gjqBbLNyo5UYqiS+rGYFgz2ueyRVQnNxDS9B6z0aDLEht0fb?=
 =?iso-8859-1?Q?/Ai7Qy0Z9SfNbKjBUQmVFUTA3CUlw083QCnLY7covZY6CoFR+XADVoeenm?=
 =?iso-8859-1?Q?aXzvKBEySo1THlESqpYvXkMDEKy0yFOqZDOuSyWLjAGo8g79bcMPzaZjZU?=
 =?iso-8859-1?Q?sX4zcqXcS1cU0o+5S3caRnIF/pCXR8EEmVJE4/Ekz4890/WcW0/Stgfosx?=
 =?iso-8859-1?Q?qQ53uL20S+mX35bkdcW2EBMI12yfjpOJIlZCpxrr1WhEkbGOi4EozQN2Kg?=
 =?iso-8859-1?Q?9DBOcz8ih0g9QYbHCS8DpL/Fn/eMF7J2VkIwZhw2e5lbf5ELRYE75uiW9t?=
 =?iso-8859-1?Q?HyXQebaHCqhpR6QpTf0fHTyUqIRsp7XRb4+SIAfQdR0uKumxVl2Xkf+lRb?=
 =?iso-8859-1?Q?1pqXGHXRcZ7Lpe0wenUFA1c9pANgUSzBNVnn1KO4F7hy6MXlZMLVZAe+n3?=
 =?iso-8859-1?Q?sOr9s29S6Of+Ite7JqCnhwBtFNjZNkYx4aCSxMkTHuhNcWx00UH3dOzwko?=
 =?iso-8859-1?Q?O3WvvjHlzBsa0o/RLcBCnbfga0NQ24QVnWRTZfpNyYC3afAQPoRU4TbGCz?=
 =?iso-8859-1?Q?nMaf5vZdqhwKXGZ3KmR/YZVrG8ap+ZH9YokjKhon95YrBpNoWfsJwC/aox?=
 =?iso-8859-1?Q?6YaYCzx+K5cGY7lmAIQJ4mccxkoh7ogP3uZbExyEp8N+Lk+WHrPF2RqAVQ?=
 =?iso-8859-1?Q?buOicja6aHnmIzUztXeKbvW2Ah+5kUICH9MyoF1A386pXfn007EPv1pEf9?=
 =?iso-8859-1?Q?ZR9BDgpn8dVzDSGWqi4HnPZVW0kWnwoQTU3obD8v+WbAkxoQ3dCOzbzWn7?=
 =?iso-8859-1?Q?UfZrLWkC0zOGVMxbtJDcG2xzh2dS2ils0YHeve7r8Eau69o+KCoi8X9O2B?=
 =?iso-8859-1?Q?rUyE4+2ypzMYobHAwQjw8yWJ2rUBXjhxkC/N402wseuucL9DnjwxjI28x3?=
 =?iso-8859-1?Q?bDfHFVqsTWuBNlUv4RcJUX4EKe9LG0XAOfgw2gGB9mTu7v8sEoKdWdahTN?=
 =?iso-8859-1?Q?PPh5G6QjoA=3D=3D?=
X-Exchange-RoutingPolicyChecked: fV5ymh2xieTQctcXtHdbPvB+l63F+Ep6R+0Ebn8i6HYVy+ZcDOfqHnrX3A2eeL/G+lR8G48Apz9bXdzsLYfsleWCQYUmpY7MAIS3AFgLbk2JRh636y+KrkiBx8us6v7t566ZEnObUUZkjXothMEK18b4C3ZyMonSF0lEXAj7t/jJ41hpcu4DDwyLZypkLJgrA4A8P1+uCP9k60LNsbwFkC36/EZvl8bp3gPyGeZW/Qm4xQ1O7JIyxjfgXbdgMurSq9kh7D+YFmCOsYUZMTzAqnj8s7XPQcwEojACD9LJB9V6HiqRqnjxHXu68ILeOqctu0IhRK1A5wh0LMm0c8tI6A==
X-MS-Exchange-CrossTenant-Network-Message-Id: f4929b54-04b1-4ae7-b5ec-08deee9e0735
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 00:52:43.1225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HfBB8e0ae3AMnnBTA1iIgWjUOaoQSgJiXiwJIfl26nD36MGOULnddoic/HvEsGZlY+srFudHZF/IPrtCRI0NFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8894
X-OriginatorOrg: intel.com

On Thu, Jul 30, 2026 at 02:12:42PM +0100, Matthew Auld wrote:
> On 30/07/2026 11:51, Matthew Auld wrote:
> > On 30/07/2026 01:47, Jia Yao wrote:
> > > On dGFX the original ADS BO is explicitly migrated to VRAM by
> > > xe_guc_realloc_post_hwconfig() so that xe_bo_main_addr() returns a
> > > real device-physical address (DPA) rather than an IOMMU IOVA.  A
> > > separate SYSTEM BO for the UM queues would not go through that migration
> > > path, so its IOVA would differ from the physical address on systems
> > > where pages are allocated above 4 GB.  GuC/GAM accesses the UM queue
> > > ring via base_dpa (with_dpa=true on pre-Xe3p), so an incorrect DPA
> > > causes all-zero fault descriptors to be forwarded to the driver.
> > 
> > I feel like I don't fully understand the explanation here. Is the issue
> > not just the contig requirement for base_dpa? We now use attempt a best
> > effort approach for system memory, however for dgpu we can go further
> > and use VRAM to guarantee that requirement. If that is all this is doing
> > then commit message can be simplified with something like:
> > 
> > "To fully guarantee the contig requirement for base_dpa, we can instead
> > just use VRAM for the um queue, on dgpu..."
> 
> Or is the issue that this has to always be in VRAM, since there is no bit to
> say whether the DPA is system vs VRAM, like we do for the GGTT pte? On dgpu,
> assumption is that this is then always VRAM, if using DPA? If so, please
> make that clearer in the commit message.
> 

The register interface to program the page fault queues are DPA / VRAM
on dGPU iirc.

Matt

> > 
> > > 
> > > Use XE_BO_FLAG_VRAM_IF_DGFX() for the UM queue BO so that on dGFX the
> > > BO is allocated directly in VRAM and xe_bo_main_addr() returns the
> > > correct DPA without needing a post-hwconfig migration step.
> > > 
> > > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> > > Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> > > Cc: Matthew Auld <matthew.auld@intel.com>
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Jia Yao <jia.yao@intel.com>
> > > ---
> > >   drivers/gpu/drm/xe/xe_guc.c     |  6 ------
> > >   drivers/gpu/drm/xe/xe_guc_ads.c | 11 ++++++-----
> > >   2 files changed, 6 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
> > > index 21cf3edef922..4023700ff2a9 100644
> > > --- a/drivers/gpu/drm/xe/xe_guc.c
> > > +++ b/drivers/gpu/drm/xe/xe_guc.c
> > > @@ -714,12 +714,6 @@ static int xe_guc_realloc_post_hwconfig(struct
> > > xe_guc *guc)
> > >       if (ret)
> > >           return ret;
> > > -    if (guc->ads.um_queue_bo) {
> > > -        ret = xe_managed_bo_reinit_in_vram(xe, tile, &guc-
> > > >ads.um_queue_bo);
> > > -        if (ret)
> > > -            return ret;
> > > -    }
> > > -
> > >       return 0;
> > >   }
> > > diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/
> > > xe_guc_ads.c
> > > index 7f371f9c7268..53636333fb45 100644
> > > --- a/drivers/gpu/drm/xe/xe_guc_ads.c
> > > +++ b/drivers/gpu/drm/xe/xe_guc_ads.c
> > > @@ -409,11 +409,12 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
> > >           size_t um_size = roundup_pow_of_two(GUC_UM_QUEUE_SIZE *
> > >                               GUC_UM_HW_QUEUE_MAX);
> > > -        bo = xe_managed_bo_create_pin_map(xe, tile, um_size,
> > > -                          XE_BO_FLAG_SYSTEM |
> > > -                          XE_BO_FLAG_GGTT |
> > > -                          XE_BO_FLAG_GGTT_INVALIDATE |
> > > -                          XE_BO_FLAG_PINNED_NORESTORE);
> > > +        u32 um_flags = XE_BO_FLAG_VRAM_IF_DGFX(tile) |
> > > +                   XE_BO_FLAG_GGTT |
> > > +                   XE_BO_FLAG_GGTT_INVALIDATE |
> > > +                   XE_BO_FLAG_PINNED_NORESTORE;
> > > +
> > > +        bo = xe_managed_bo_create_pin_map(xe, tile, um_size, um_flags);
> > >           if (IS_ERR(bo))
> > >               return PTR_ERR(bo);
> > 
> 
