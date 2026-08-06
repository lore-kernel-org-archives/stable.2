Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8632D2FE060;
	Thu,  6 Aug 2026 04:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785989101; cv=fail; b=cFWM9aNkzz3Bsvb1YFMt2wvSZObIDlm2IBV49j3QXP9UcKWk6g+0uiWhWl5WGfQSdeA19YlhN74CzPFeozhGLx+SRGa7QjJifQEOoUsIGz8Cw/RTDbHSYOCoMPbwIo1mBshcZ9LxvJt/q6pnuIIkD5wkMJ9Gt8iM1a0DWPrQNgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785989101; c=relaxed/simple;
	bh=mIaRClkDFZnWplQ3uAvEIQAwAEuCz+a6Sk6X2S4bWmg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Unb674gJj3QTtTgvcfp/FxqPdf5MoZD50hOfhEd9ijHDz2fVK7/woAao8mh+F2ZlBRj/CSDn/TzdZM210oAaSmmXXZlzJ+X8r4wUxpyHsTKeFF657wS/mvs0rJOT+CR9vAjlQ4wZ7nJJIvw7B93R/yIyS50rZU7eDO0KRGSD0GU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mnc4XUQS; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mnc4XUQS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785989099; x=1817525099;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mIaRClkDFZnWplQ3uAvEIQAwAEuCz+a6Sk6X2S4bWmg=;
  b=mnc4XUQSeRHM49DW+hfK+EMULBlwoWVLNIhyvqY71EaL1oVK/YTR3tQx
   FIKNmK0dQ7pSc4oM6zljViSYv0znp/YtR7nloGKJ1IzVCn177I0JwfTEU
   I+30xmVr8WmFkmbno7E1zFHnybByErdeq+zP1mm81Rw1T47LRTQi6IrFe
   yGDZUVQzGVXEcUjryj/fFJijN/vzm0+P3jOnz7TyLHoUq8Dlidn5HjQwI
   ktYu0ETC9akQQMPUpI/kzPFMZlYjoDUtk7XIosFcmYejfcsPM+CEtAjym
   X/btxYRTJ/8t6xO13xkfjYTXOLa8BM/+CmxeyBDvaoRHXGnruzgRmIWug
   w==;
X-CSE-ConnectionGUID: dVDdtetnRZ6S+L6hqf5PCw==
X-CSE-MsgGUID: kJC3lCVZQs23Wvb0qp63bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="90247658"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="90247658"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 21:04:58 -0700
X-CSE-ConnectionGUID: QTqVAFz+Q2y0xfoacbGjjA==
X-CSE-MsgGUID: QCUbdKc8QN+FLNyzNg/+hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="255737876"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 21:04:57 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 21:04:57 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 5 Aug 2026 21:04:57 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.51) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 21:04:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQUC+lxwTgWZ2Ur0cZ6JXh8Afv70MazqCKP9PfPUDC9LygQ9QkiYqBlM4QPPI1K9KXSU7J/0iQhYb4nX41h/47jeU227zykH7AjnndaWxLmAObWpgNaWo5QVg2EXQYLbCs8h+O08/cYBUDDoKTUr6cNF71xQCRDqX7Qx5B0BnBZVaGbwItwY7NwsKmxWi9sHGG7pID5g7k+/wqk869Vl+s3pE/dhF4Ir+1UINCQ2oPyin1PXufvlIKqEBV5zN4CsyJJBR8XUa5kIg8QKLmYY4Y1Yq/V6qnt5+akkdAWqJ8otWsymKnR+y1ZSzJI6bNb/c2eukUxQtLp8nTyxTABcgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FoU4bWvrBgbETxh/xnDZKPxXBSbOza0AqDPzV7hn9Tg=;
 b=iefl+0mxdjHdN9jJOoFmQ0L0SojxSD0Hst3pxQo7bPkpt109f4eArrRNne3FYp/yGsv+RmvZCn4WKF2VXvUEl+fKyL9oV0nkH3AR0/SK1br+JajtpMXi1CfsVtheAfSNdIv0XHWOI9Wmtuo+hskl/YDHrP1rlUqNOA2Ue99Tb/UNU/7SPLHID+xmGmtuWxApBb+fu+bQEQDEsq7qOeLFqR8m/t5/WRIheYSZw3Rng08LtAKP/Ux7VOlBxPEo2MpeOgvMbnmZ5OhMC4KR005UWKcUUR/v7HwofSNsfngllj1120tAWq0lp8sro/N9QK/sUh0KyR4KK51pYiJ+no0p+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH0PR11MB4886.namprd11.prod.outlook.com (2603:10b6:510:33::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 04:04:54 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 04:04:54 +0000
Date: Wed, 5 Aug 2026 21:04:51 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Baul Lee <baul.lee@xbow.com>
CC: <christian.koenig@amd.com>, <ray.huang@amd.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
	<matthew.auld@intel.com>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <federico.kirschbaum@xbow.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/ttm: clamp the prefault window to the buffer object
Message-ID: <anQH45cRIFOA/X3w@gsse-cloud1.jf.intel.com>
References: <20260806034356.43681-1-baul.lee@xbow.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260806034356.43681-1-baul.lee@xbow.com>
X-ClientProxiedBy: MW4PR04CA0340.namprd04.prod.outlook.com
 (2603:10b6:303:8a::15) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH0PR11MB4886:EE_
X-MS-Office365-Filtering-Correlation-Id: dd5fdcf4-9def-4a92-eb3e-08def36fded0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|56012099006|5023799004|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZtasFZyikzXcAAAg7oWVpS4EIESlvcuxE4DfVmneDPrcBvF326xlXYXVUaUXYS38/PzGXAD8ksY5tBwve7mnKWtzXMSnOe6lHCdqmRhSZUGgAdi+aXP2wAHWaBqA1jJ3zMa0vRUK0S/IxVkeGVclw4TE8rBLu00XetyG6t/O35HqGLISlvJ+gRDIowztPyGQTpk2mESF2WkBGOPt0nkS7QZxiEeGBi1yfAH9rAKChbA27Twd5Src4PKrsVFVbvLX5IQ2jRf9Nk7gibJw8VqREicQaoeSumvjry+/O7pLN7iiAbs7EVoOaTrieiXnl9rH2fYoRqXSwRkIuFL+gtvA9FruFzSCstSOlr0SSiXRFEaGXuOJTglvW4nKI1RQyn7GeWkA2ga1+rXUz+D7dbFWeSOjev5VIyiRZDgJFFD0xJ9PtsoXSa4zidil1332g2GkReZcZQiZEv1jUKyjQ+udZf67YuvBuNS/stLgCE7HjXCR+y6WBjO9bsxPyeGvFDCezdXhZhsRkzzTs0O0T4o20Wy78wHRdKCnOIaFUm2ebhgL2Zx3UfE5HqTVN9GrVC1cK2xGi+giSodBcXamRUM6oRvSaeW8DXzknHVKUxYd/KJBZUnECWiVgtA9WPZixsHcS63eyTTJs1vyNF4k1Mdm4WSzdzuc5TA0eGPWv7WiuUo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(56012099006)(5023799004)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eFLkeJlYvMNzO/7vYtiNs/PkQVq4sREtKwZGpOdu66KZbaBw4TIyBd/h1Hq6?=
 =?us-ascii?Q?snlCkpJhrlJ6inov1HK2kL1is0Ku7D0SMzm6Cr5yhtQfz6z2k4blYbpSzu/h?=
 =?us-ascii?Q?STwAJO9UCjH02UxfM+VPjCYvroNcMKQQJ8vlj0z78gp6Bad/7thhHBKo3vLd?=
 =?us-ascii?Q?uBJHOUbHtPz6zAqpBDaX5P+oIYTuYJzIh89PvQAS9tmK0uhNMQckGkTriYF+?=
 =?us-ascii?Q?oYyP2mzJgt98lOxK3pRbMat1cVCCqpcetrWSedPTEqWF/qhirnCB8Uu7rs1V?=
 =?us-ascii?Q?Db12P7FLgcJZ7PgW1GDd0vjoDPeNvmWnmwuFsC+dujwMCfU2Gf4/suUneJwN?=
 =?us-ascii?Q?Vqi55oaavo4JD8+hsLhYz+lzTMzaKlv/p8UXEZnFaZVMJP4lDe8tK+g/tq3w?=
 =?us-ascii?Q?wm1Sg2EN+9DFR6Ca2kFq3tThuLHQ0psH1kPjRBTo4eZNX8LHVNPUuwr9bp5o?=
 =?us-ascii?Q?W5IXc3BNYDrJuNfTL/tNmkw8+6T8kbqmh9rUkdj7HfbbvkvNLiUCzYuD0WvX?=
 =?us-ascii?Q?+d2vBhyTFlZDqsll/iYp2+ERW+90mO9F4JZ0ZgWHVZGdvpk5TYDdN++VDHzv?=
 =?us-ascii?Q?8ZPNIEKSsC8+JnxxOVow3+bK1wKzx231W8S6jhPH+5FSvHJfD5bkaMKf8WoC?=
 =?us-ascii?Q?HzkCogdxEIMkcDzPVxj3/breBCWN8sg0zCcjDWfqhrB+dXbUU4nRPTvTJpCr?=
 =?us-ascii?Q?wKr11tWEcUOgnPatncbLRoLFZ7pkuq9jvYmhGjmiIJc9G1EFVstwLDTgP+Cd?=
 =?us-ascii?Q?IVaQrWdo5BtiIBxVEjGKAPGAUpmB/guKGJlN5rTQOruHVhcpOF9evl48P24z?=
 =?us-ascii?Q?bQ8FI733SY+1QTBVSvc2ddV02VYe5S+Su3X7Hw4cPSIWYlsNpMBAmV1Rpxwx?=
 =?us-ascii?Q?oDCNz4cnS+Uu5N2vOi28+j7y8hXgT4rFYUXSqAUvENMvqvHG6PMhpEGnZdtN?=
 =?us-ascii?Q?c7ulTm6vp2vy+EQpvOBAtazQLl8eI8qfH2Aa0f6n9SKJC6dKKdCWibz+YUTz?=
 =?us-ascii?Q?yccEnS62KW0CGfkdd+PqoZdq3fRDTmij+LtC3daetjxkoAOR1j6kb6+SoqZ7?=
 =?us-ascii?Q?0od5fa0T1PjF74eDUu0zfxKZDH00ofrrPwoBZeu6trcN6LEONocEok/NT9SK?=
 =?us-ascii?Q?icPuBi2iVN7b+ZnNFSCC0BDb0wuD5nQbmaSE0zrAwMxbm3pvq5jyMaZY801z?=
 =?us-ascii?Q?UnXYpjmerSJ+S7eFlQ/X9KnXNL3gqcZga7FcxmMNg9jBSS2UcMBcxaxnV8cj?=
 =?us-ascii?Q?mtAoIPeomaVbOOCgNe8df3XoyhPjA//D/H2f0rmEc4JuYgE1sawMqcc+pbFb?=
 =?us-ascii?Q?SYItidfvbvMEewGlLoBpjIgbFFccsJu3cz0c4bF4OKWQbj68Aw5fFZqmkrrl?=
 =?us-ascii?Q?zkVDO+yOURffvV7lvakM/XPHp7d6t4dlPbDP54V6qoQHAbL+V5A2Os1eo9fQ?=
 =?us-ascii?Q?Tpr7J2D9GuDnmasI3QmcA0c4FtfCmKH1Zz/4vSWGiWSHKZ6AGMKmc3BoO5It?=
 =?us-ascii?Q?fxPdpf84fcxJt24PDHxQKeV0LReaY7/Ae52++PKhMb4G9mldKk16l55M5lda?=
 =?us-ascii?Q?eLmZPVP6eRaaMTShHFmeuKeSAls42Z7O0iQwHvtGIN630YApZbb+m27KObtn?=
 =?us-ascii?Q?d9NiZv1L9Tirr7bkMZfv6fZd6uAFKnwBrZQxffXYNGGCTIGOeDLh6AmawvOR?=
 =?us-ascii?Q?1x6GZD5ZdSGpefnqARW+s+L4CGhUGu8AyS6Ab3Jbuu5xwlM7QSAdkJXlWfmV?=
 =?us-ascii?Q?8wxQ7DM/nuX1f2NnnC3l8I5OxtVyhqE=3D?=
X-Exchange-RoutingPolicyChecked: Da4s8smPguR7/pGbG8Uizxj5um1zs2elF+WLp2fqjCal9A2ELhlqIHG+/vYKNRvUlKGvtrz08bWeIaCUVV9H+I3PeqObvmBNWBimRz2Ajq7818jiRyzY0KkSlr22A9YAN1h5bKU7NhqkzBs//21ibyfl86Aj7qkpqsQMgiErTPuprrkfJijICZV5t2/odeXwWRGNLKuA59gjdQwxx4rqk7iMUB9Fj4U7uTtGxPdTmSxQUjGnIwTAfN78nilVOMycvpzNFSftMaPUPCWGvVD5yZw4aeiTeBLa1rNW3/k0Yu9Wlk6D4epKWUBoPBVM6HpkxfhJ44yaq8LN9BscUCohqQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5fdcf4-9def-4a92-eb3e-08def36fded0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 04:04:54.0085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHg6yf4gckB/rAv5huUCdoXoAA4sQhgvTImgkGcegAtJZLYw1KdfLCNurysAKy08i6XJGjfB7Bvbr+qcdADxFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4886
X-OriginatorOrg: intel.com

On Thu, Aug 06, 2026 at 12:43:56PM +0900, Baul Lee wrote:
> ttm_bo_vm_fault_reserved() derives two page indices from the caller's
> mmap(2) arguments and bounds only one of them:
> 
> 	page_offset = ((address - vma->vm_start) >> PAGE_SHIFT) +
> 		vma->vm_pgoff - drm_vma_node_start(&bo->base.vma_node);
> 	page_last = vma_pages(vma) + vma->vm_pgoff -
> 		drm_vma_node_start(&bo->base.vma_node);
> 
> 	if (unlikely(page_offset >= PFN_UP(bo->base.size)))
> 		return VM_FAULT_SIGBUS;
> 
> bo->base.size appears once in the function, bounding page_offset on
> entry.  page_last comes straight from vma_pages(vma) and is the loop
> terminator:
> 
> 	if (unlikely(++page_offset >= page_last))
> 		break;
> 
> so the object size never bounds it.  For an object of N pages, a fault
> on the last in-object page passes the entry test with page_offset
> N - 1, and the prefault loop then walks N..N+14, reading
> ttm->pages[page_offset] or
> ttm_bo_io_mem_pfn(bo, page_offset) and installing each frame with
> vmf_insert_pfn_prot().
> 
> page_last exceeds the object whenever the VMA is longer than it.
> drm_gem_mmap_obj() rejects that on the DRM node, but the fbdev path
> reaches the object function through drm_gem_prime_mmap(), which does
> not.  It is also exceeded by a mapping no longer than the object taken
> at a nonzero file offset, so the handler needs its own bound.
> 
> With a 128-page object mapped 192 pages long, one read fault at index
> N - 1 leaves the fifteen frames after the object readable through the
> mapping; on a fresh mapping, reading index N without first faulting
> N - 1 is SIGBUS.  For a system-memory placement the page array is
> over-read as well:
> 
>   BUG: KASAN: slab-out-of-bounds in ttm_bo_vm_fault_reserved+0x248/0x57c
>   Read of size 8 at addr ffff0000078aac00 by task e1/219
>    __asan_load8+0x84/0xb0
>    ttm_bo_vm_fault_reserved+0x248/0x57c
>    ttm_bo_vm_fault+0xe4/0x140
>    __do_fault+0x6c/0x2f0
> 
> Clamp page_last to the object.
> 
> Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

You are going to want an Assisted-by tag here as XBOW is an AI tool?

> 
> Fixes: ba4e7d973dd0 ("drm: Add the TTM GPU memory manager subsystem.")

This won't apply to ba4e7d973dd0. More below.

> Cc: stable@vger.kernel.org
> Signed-off-by: Baul Lee <baul.lee@xbow.com>
> ---
>  drivers/gpu/drm/ttm/ttm_bo_vm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> index a80510489c45..14ebf6ee3c47 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> @@ -212,6 +212,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>  		vma->vm_pgoff - drm_vma_node_start(&bo->base.vma_node);
>  	page_last = vma_pages(vma) + vma->vm_pgoff -
>  		drm_vma_node_start(&bo->base.vma_node);
> +	page_last = min_t(unsigned long, page_last, PFN_UP(bo->base.size));

This looks correct but maybe to make backporting easier all the way to
ba4e7d973dd0, we do this instead...

diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index a80510489c45..3529371a37d5 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -274,7 +274,8 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
                }

                address += PAGE_SIZE;
-               if (unlikely(++page_offset >= page_last))
+               if (unlikely(++page_offset >= page_last ||
+                            page_offset >= PFN_UP(bo->base.size)))
                        break;
        }
        return ret;

The above code git blame show this line was last modified in
ba4e7d973dd0.

Then in non-fixes patch, do it like you have it here.

Matt

>  
>  	if (unlikely(page_offset >= PFN_UP(bo->base.size)))
>  		return VM_FAULT_SIGBUS;
> -- 
> 2.50.1 (Apple Git-155)
