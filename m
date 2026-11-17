Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794918481;
	b=q7yGZcM6oIFf/nrLNw7dg+gxpkBvDM1RQLocMqOt9/2EMJpaIvuOWdoUSn/pDPEj0YIN
	 5rewXUs9obHVJNZ7qeOxOMv4oqI1WMjxtycTSWWuyNOOKzfrhFwnWk1czdHlp8E5No4JZ
	 b8LoPUA95IR4qpxkMvh7PtnwEzNZ1h+7TAUBIcD4Az9Nepngh+sTVzXv7pQ1REWeAsQIB
	 LNrSyBRPyV/d0ZFlIN+Sl2crj3+9JOIoT3I/VP1qOnSX1SotQxS+Q3rr9OQsZ3tZvyj8W
	 fhFw2IF0eeYEbCXFnbMxtr2cSEm9a0Qu5b87NrSm4qfgjDtIlm+HJJyEHh8TYIkm+zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794918481;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=KM2AxC661JUFDMgbgS/j/UEBdUL+WXU1AFM74ye9SbA=;
	b=jYLjuhRRBZubGKgkyxh28KOeKFggxZlBEObVOsv/3DO/oiLacnMnXOE596QqQsckEd26
	 52IcrmhyZ/MOaVXkBdxyOeK/7loqjR8RQKcPqEkxrH4Nb8xXACbXhu3YJfRovHQJg2JGE
	 d+ZOTnlfzMgMPRpgvHMC9ovsQIYpwA3VI4WHkJhGFRL7DaZsdRCo7jew2Pe8dhAa1s/mD
	 1uH58ChE2jtgFskbdpKc89C4SwgVe2bGbqzYiOpBNFe75fU4u1IP8+aUpIp4UA1bN1+uC
	 Ev/zWFHIRL3Mgn/j0C6g8D9VfZaqlVO5gacep7GVQ4W8pqjtZHZCgRjaSV84WOx3FJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZML8WhTO;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB84606A31C;
	Tue, 17 Nov 2026 12:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BB84606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZML8WhTO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794918481; x=1826454481;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ndTg7sq8BTwzV5ZIdQVv8vLbR7ewI5Azcqn8dK7UYzM=;
  b=ZML8WhTOAU/dlBE/sCKro4TTQb/f/u4BOolO4Kwj3zNZXuA/OKhosCwb
   U0shKDV6YPQZLMcvrFX4PVXAIbpr8u4g4KfuAlK+XGOzGxdMOWIfuR/rd
   9f15GtY7Cy2A5B5A3uzvikqk2XYuuUGvI1LEUxDN/dzHCfanlKq5RAtBk
   IhbaiZU5BihXT735u1NaBZVCqhDIPREuKY6BTbJTOdrVBXtAjtSB5rH00
   DD1hVbWh9vDgEW30CiIUreRw1mwwukj8G5vPoyjxJrFDZPLj9s16a2DBr
   jM1jxGZVTV1P55RM/X2gJrkBNqfha1JtDam+IFSn8571o2xwPWG9aG12K
   g==;
X-CSE-ConnectionGUID: WMyT5GfXTaeh4d4yXLBbhQ==
X-CSE-MsgGUID: IvKS52KsQwqp0x5ZdHOywA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3708464"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3708464"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 04:28:00 -0800
X-CSE-ConnectionGUID: NXh2zuLfQMCZt8jrPFWneA==
X-CSE-MsgGUID: hloi4fbTT666ZNmxD62qgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="10225051"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 17 Nov 2026 04:27:57 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xTIHy-00000001BTZ-3Fww;
	Tue, 17 Nov 2026 12:27:54 +0000
Date: Tue, 17 Nov 2026 20:27:32 +0800
From: kernel test robot <lkp@intel.com>
To: xu.xin@linux.dev, David Hildenbrand <david@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Donet Tom <donettom@linux.ibm.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, Xu Xin <xu.xin@linux.dev>,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/ksm: do not inherit ksm_zero_pages counter or PTE
 markers on fork
Message-ID: <202611172040.LO8S0kBo-lkp@intel.com>
References: <20261117081821.7211-1-xu.xin@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117081821.7211-1-xu.xin@linux.dev>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/xu-xin-linux-dev/mm-ksm-do-not-inherit-ksm_zero_pages-counter-or-PTE-markers-on-fork/20261117-161821
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20261117081821.7211-1-xu.xin%40linux.dev
patch subject: [PATCH] mm/ksm: do not inherit ksm_zero_pages counter or PTE markers on fork
config: hexagon-allnoconfig (https://download.01.org/0day-ci/archive/20261117/202611172040.LO8S0kBo-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project a69be15ed58ed48738a69ec4c7d0f3e8c7dbe4ce)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261117/202611172040.LO8S0kBo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611172040.LO8S0kBo-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/memory.c:1168:6: error: call to undeclared function 'is_ksm_zero_pte'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1168 |         if (is_ksm_zero_pte(pte))
         |             ^
   1 error generated.


vim +/is_ksm_zero_pte +1168 mm/memory.c

  1123	
  1124	static __always_inline void __copy_present_ptes(struct vm_area_struct *dst_vma,
  1125			struct vm_area_struct *src_vma, pte_t *dst_pte, pte_t *src_pte,
  1126			pte_t pte, unsigned long addr, int nr)
  1127	{
  1128		struct mm_struct *src_mm = src_vma->vm_mm;
  1129		bool writable;
  1130	
  1131		/*
  1132		 * Snapshot writability before the RWP-disarm rewrite below: when the
  1133		 * child is not RWP-armed, pte_modify(pte, dst_vma->vm_page_prot) can
  1134		 * silently drop _PAGE_RW from a resolved (no-marker) writable PTE,
  1135		 * so a later pte_write(pte) check would skip the COW wrprotect and
  1136		 * leave the parent writable over a folio shared with the child.
  1137		 */
  1138		writable = pte_write(pte);
  1139	
  1140		/*
  1141		 * Child is not RWP-armed: restore accessible protection so the
  1142		 * inherited PAGE_NONE does not cost a fault on first read. Gate on
  1143		 * pte_uffd(pte) so unrelated PAGE_NONE markers (e.g. NUMA balancing)
  1144		 * are not normalised away.
  1145		 */
  1146		if (!userfaultfd_protected(dst_vma)) {
  1147			if (userfaultfd_rwp(src_vma) && pte_uffd(pte))
  1148				pte = pte_modify(pte, dst_vma->vm_page_prot);
  1149			pte = pte_clear_uffd(pte);
  1150		}
  1151	
  1152		/* If it's a COW mapping, write protect it both processes. */
  1153		if (vma_is_cow_mapping(src_vma) && writable) {
  1154			wrprotect_ptes(src_mm, addr, src_pte, nr);
  1155			pte = pte_wrprotect(pte);
  1156		}
  1157	
  1158		/* If it's a shared mapping, mark it clean in the child. */
  1159		if (src_vma->vm_flags & VM_SHARED)
  1160			pte = pte_mkclean(pte);
  1161		pte = pte_mkold(pte);
  1162	
  1163		/*
  1164		 * Clear the dirty-bit marker on KSM-placed zero-page PTEs in the
  1165		 * child so inherited mappings are not accounted against the child or
  1166		 * unshared by MADV_UNMERGEABLE.  Special PTEs always have nr == 1.
  1167		 */
> 1168		if (is_ksm_zero_pte(pte))
  1169			pte = pte_mkclean(pte);
  1170	
  1171		set_ptes(dst_vma->vm_mm, addr, dst_pte, pte, nr);
  1172	}
  1173	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
