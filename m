Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E36B26ED37;
	Sat, 10 Oct 2026 05:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791610507; cv=none; b=IPc1l1xxPk7SznHw3ovWnv6dRiQXj/jk0Buz1FfUr19D7si1VErbWiBl3fe2OYr+V6jEtHAJsDaQiVbw45r9wW+FrQdSgvz9hkaaeRPtzukChKYxUpEzPXERoxbgTaFH2Zw8XvmwrjvXRHIizsMRztixHgZ2WM9ZkVTGQ8MvYqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791610507; c=relaxed/simple;
	bh=ZQDwxtggjEdB4DnE5Fo8yTwuShoD9K6UqEbpF93ZvGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnSr/yyFeH+suhck/U+/zWBrrg/pv3JI5r+RyGFQid8aPwZyDZlcujn4bBaspjePN0y/9Vp0+XXeTjA/wy/aTctqxCUcSJlK2A55yE2ALkNZ+BR9u2VoPZ1UN9PI7ZWtvTtDsyIKe7c1mWYcmeri0jY4ZRM/Q5l6crqfcGSYEtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jLFi7gv+; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jLFi7gv+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791610503; x=1823146503;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZQDwxtggjEdB4DnE5Fo8yTwuShoD9K6UqEbpF93ZvGA=;
  b=jLFi7gv+MpfnwQWXNixeEaZAHuDBKnR0QUhFPTUucFb2gAjMg6mvT7Fm
   qBLBv37H3cwcjeqDRb7hK3G4YfKaNYJMRF7KV4FOfI3egypTemscD+BHA
   /zOw5aCCBHpn6fSsmloVrbTKvYBV/seeRdlitE/zOtHIKcj8C5hQEqfRQ
   4G5HibL2RXBtsr6y/LHcnCYgtANGp0axrNMjM0uI8T/glqV4fbPr60sCS
   VdE/5DNYdwTjAl+EE3jJL7WLQnJJM2HX2outUBHVcB+gzi+i2oDov0IEv
   JIt1kqA0XsBEiMerssn2vM5nsUcEWrnYXM4HLEnnRhxAyTqfAXkGtCVlU
   w==;
X-CSE-ConnectionGUID: niEB62R7RM6IJ2JZletgBQ==
X-CSE-MsgGUID: /UPu85ovQX+6KBJg1S5l0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="399620"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="399620"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 22:35:02 -0700
X-CSE-ConnectionGUID: FFuVsC+YT+ayZAsUpNlXUQ==
X-CSE-MsgGUID: oqITX/OdQpOR5wgdC8WQgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="459731"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 09 Oct 2026 22:35:02 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xFPjW-000000006Xj-2vwY;
	Sat, 10 Oct 2026 05:34:58 +0000
Date: Sat, 10 Oct 2026 13:34:52 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, SimonP <simonp.git@mailbox.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] KVM: x86/mmu: Cope with the SS bit being set in #NPF
 exit codes
Message-ID: <202610101512.fYgKYoD8-lkp@intel.com>
References: <20261009130450.361690-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009130450.361690-1-pbonzini@redhat.com>

Hi Paolo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kvm/queue]
[also build test WARNING on kvm/next mst-vhost/linux-next linus/master v7.3-rc6 next-20261008]
[cannot apply to kvm/linux-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Paolo-Bonzini/KVM-x86-mmu-Cope-with-the-SS-bit-being-set-in-NPF-exit-codes/20261009-150450
base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git queue
patch link:    https://lore.kernel.org/r/20261009130450.361690-1-pbonzini%40redhat.com
patch subject: [PATCH] KVM: x86/mmu: Cope with the SS bit being set in #NPF exit codes
config: x86_64-randconfig-1016-20261010 (https://download.01.org/0day-ci/archive/20261010/202610101512.fYgKYoD8-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261010/202610101512.fYgKYoD8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610101512.fYgKYoD8-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/x86/kvm/mmu/mmu.c:5413:
   arch/x86/kvm/mmu/paging_tmpl.h: In function 'ept_walk_addr_generic':
>> arch/x86/kvm/mmu/paging_tmpl.h:331:19: warning: unused variable 'user_fault' [-Wunused-variable]
     331 |         const int user_fault  = access & PFERR_USER_MASK;
         |                   ^~~~~~~~~~
   In file included from arch/x86/kvm/mmu/mmu.c:5417:
   arch/x86/kvm/mmu/paging_tmpl.h: In function 'paging64_walk_addr_generic':
>> arch/x86/kvm/mmu/paging_tmpl.h:331:19: warning: unused variable 'user_fault' [-Wunused-variable]
     331 |         const int user_fault  = access & PFERR_USER_MASK;
         |                   ^~~~~~~~~~
   In file included from arch/x86/kvm/mmu/mmu.c:5421:
   arch/x86/kvm/mmu/paging_tmpl.h: In function 'paging32_walk_addr_generic':
>> arch/x86/kvm/mmu/paging_tmpl.h:331:19: warning: unused variable 'user_fault' [-Wunused-variable]
     331 |         const int user_fault  = access & PFERR_USER_MASK;
         |                   ^~~~~~~~~~


vim +/user_fault +331 arch/x86/kvm/mmu/paging_tmpl.h

be94f6b71067df4 arch/x86/kvm/paging_tmpl.h     Huaitong Han        2016-03-22  282  
ac889bdd23df1ee arch/x86/kvm/mmu/paging_tmpl.h Paolo Bonzini       2026-05-10  283  static inline bool FNAME(is_last_gpte)(struct kvm_pagewalk *w,
7cd138db5cae0da arch/x86/kvm/mmu/paging_tmpl.h Sean Christopherson 2021-06-22  284  				       unsigned int level, unsigned int gpte)
7cd138db5cae0da arch/x86/kvm/mmu/paging_tmpl.h Sean Christopherson 2021-06-22  285  {
7cd138db5cae0da arch/x86/kvm/mmu/paging_tmpl.h Sean Christopherson 2021-06-22  286  	/*
7cd138db5cae0da arch/x86/kvm/mmu/paging_tmpl.h Sean Christopherson 2021-06-22  287  	 * For EPT and PAE paging (both variants), bit 7 is either reserved at
7cd138db5cae0da arch/x86/kvm/mmu/paging_tmpl.h Sean Christopherson 2021-06-22  288  	 * all level or indicates a huge page (ignoring CR3/EPTP).  In either
7cd138db5cae0da arch/x86/kvm/mmu/paging_tmpl.h Sean Christopherson 2021-06-22  289  	 * case, bit 7 being set terminates the walk.
7cd138db5cae0da arch/x86/kvm/mmu/paging_tmpl.h Sean Christopherson 2021-06-22  290  	 */
7cd138db5cae0da arch/x86/kvm/mmu/paging_tmpl.h Sean Christopherson 2021-06-22  291  #if PTTYPE == 32
7cd138db5cae0da arch/x86/kvm/mmu/paging_tmpl.h Sean Christopherson 2021-06-22  292  	/*
7cd138db5cae0da arch/x86/kvm/mmu/paging_tmpl.h Sean Christopherson 2021-06-22  293  	 * 32-bit paging requires special handling because bit 7 is ignored if
7cd138db5cae0da arch/x86/kvm/mmu/paging_tmpl.h Sean Christopherson 2021-06-22  294  	 * CR4.PSE=0, not reserved.  Clear bit 7 in the gpte if the level is
7cd138db5cae0da arch/x86/kvm/mmu/paging_tmpl.h Sean Christopherson 2021-06-22  295  	 * greater than the last level for which bit 7 is the PAGE_SIZE bit.
7cd138db5cae0da arch/x86/kvm/mmu/paging_tmpl.h Sean Christopherson 2021-06-22  296  	 *
7cd138db5cae0da arch/x86/kvm/mmu/paging_tmpl.h Sean Christopherson 2021-06-22  297  	 * The RHS has bit 7 set iff level < (2 + PSE).  If it is clear, bit 7
7cd138db5cae0da arch/x86/kvm/mmu/paging_tmpl.h Sean Christopherson 2021-06-22  298  	 * is not reserved and does not indicate a large page at this level,
7cd138db5cae0da arch/x86/kvm/mmu/paging_tmpl.h Sean Christopherson 2021-06-22  299  	 * so clear PT_PAGE_SIZE_MASK in gpte if that is the case.
7cd138db5cae0da arch/x86/kvm/mmu/paging_tmpl.h Sean Christopherson 2021-06-22  300  	 */
d869ff104efb1f2 arch/x86/kvm/mmu/paging_tmpl.h Paolo Bonzini       2026-05-11  301  	gpte &= level - (PT32_ROOT_LEVEL + w->cpu_role.ext.cr4_pse);
7cd138db5cae0da arch/x86/kvm/mmu/paging_tmpl.h Sean Christopherson 2021-06-22  302  #endif
7cd138db5cae0da arch/x86/kvm/mmu/paging_tmpl.h Sean Christopherson 2021-06-22  303  	/*
7cd138db5cae0da arch/x86/kvm/mmu/paging_tmpl.h Sean Christopherson 2021-06-22  304  	 * PG_LEVEL_4K always terminates.  The RHS has bit 7 set
7cd138db5cae0da arch/x86/kvm/mmu/paging_tmpl.h Sean Christopherson 2021-06-22  305  	 * iff level <= PG_LEVEL_4K, which for our purpose means
7cd138db5cae0da arch/x86/kvm/mmu/paging_tmpl.h Sean Christopherson 2021-06-22  306  	 * level == PG_LEVEL_4K; set PT_PAGE_SIZE_MASK in gpte then.
7cd138db5cae0da arch/x86/kvm/mmu/paging_tmpl.h Sean Christopherson 2021-06-22  307  	 */
7cd138db5cae0da arch/x86/kvm/mmu/paging_tmpl.h Sean Christopherson 2021-06-22  308  	gpte |= level - PG_LEVEL_4K - 1;
7cd138db5cae0da arch/x86/kvm/mmu/paging_tmpl.h Sean Christopherson 2021-06-22  309  
7cd138db5cae0da arch/x86/kvm/mmu/paging_tmpl.h Sean Christopherson 2021-06-22  310  	return gpte & PT_PAGE_SIZE_MASK;
7cd138db5cae0da arch/x86/kvm/mmu/paging_tmpl.h Sean Christopherson 2021-06-22  311  }
ac79c978f173586 drivers/kvm/paging_tmpl.h      Avi Kivity          2007-01-05  312  /*
736c291c9f36b07 arch/x86/kvm/mmu/paging_tmpl.h Sean Christopherson 2019-12-06  313   * Fetch a guest pte for a guest virtual address, or for an L2's GPA.
ac79c978f173586 drivers/kvm/paging_tmpl.h      Avi Kivity          2007-01-05  314   */
1e301feb079e8ee arch/x86/kvm/paging_tmpl.h     Joerg Roedel        2010-09-10  315  static int FNAME(walk_addr_generic)(struct guest_walker *walker,
ac889bdd23df1ee arch/x86/kvm/mmu/paging_tmpl.h Paolo Bonzini       2026-05-10  316  				    struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
5b22bbe717d9b96 arch/x86/kvm/mmu/paging_tmpl.h Lai Jiangshan       2022-03-11  317  				    gpa_t addr, u64 access)
6aa8b732ca01c3d drivers/kvm/paging_tmpl.h      Avi Kivity          2006-12-10  318  {
8cbc70696f149e4 arch/x86/kvm/paging_tmpl.h     Avi Kivity          2012-09-16  319  	int ret;
42bf3f0a1f5a25b drivers/kvm/paging_tmpl.h      Avi Kivity          2007-10-17  320  	pt_element_t pte;
3f649ab728cda80 arch/x86/kvm/mmu/paging_tmpl.h Kees Cook           2020-06-03  321  	pt_element_t __user *ptep_user;
cea0f0e7ea54753 drivers/kvm/paging_tmpl.h      Avi Kivity          2007-01-05  322  	gfn_t table_gfn;
0780516a18f87e8 arch/x86/kvm/paging_tmpl.h     Paolo Bonzini       2017-05-11  323  	u64 pt_access, pte_access;
0780516a18f87e8 arch/x86/kvm/paging_tmpl.h     Paolo Bonzini       2017-05-11  324  	unsigned index, accessed_dirty, pte_pkey;
5b22bbe717d9b96 arch/x86/kvm/mmu/paging_tmpl.h Lai Jiangshan       2022-03-11  325  	u64 nested_access;
42bf3f0a1f5a25b drivers/kvm/paging_tmpl.h      Avi Kivity          2007-10-17  326  	gpa_t pte_gpa;
86407bcb5c8320a arch/x86/kvm/paging_tmpl.h     Paolo Bonzini       2017-03-30  327  	bool have_ad;
134291bf3cb434a arch/x86/kvm/paging_tmpl.h     Takuya Yoshikawa    2011-07-01  328  	int offset;
0780516a18f87e8 arch/x86/kvm/paging_tmpl.h     Paolo Bonzini       2017-05-11  329  	u64 walk_nx_mask = 0;
134291bf3cb434a arch/x86/kvm/paging_tmpl.h     Takuya Yoshikawa    2011-07-01  330  	const int write_fault = access & PFERR_WRITE_MASK;
134291bf3cb434a arch/x86/kvm/paging_tmpl.h     Takuya Yoshikawa    2011-07-01 @331  	const int user_fault  = access & PFERR_USER_MASK;
134291bf3cb434a arch/x86/kvm/paging_tmpl.h     Takuya Yoshikawa    2011-07-01  332  	const int fetch_fault = access & PFERR_FETCH_MASK;
bb24edbb673f6f3 arch/x86/kvm/mmu/paging_tmpl.h Kevin Cheng         2026-05-22  333  	/*
bb24edbb673f6f3 arch/x86/kvm/mmu/paging_tmpl.h Kevin Cheng         2026-05-22  334  	 * Note! Track the error_code that's common to legacy shadow paging
bb24edbb673f6f3 arch/x86/kvm/mmu/paging_tmpl.h Kevin Cheng         2026-05-22  335  	 * and NPT shadow paging as a u16 to guard against unintentionally
bb24edbb673f6f3 arch/x86/kvm/mmu/paging_tmpl.h Kevin Cheng         2026-05-22  336  	 * setting any of bits 63:16.  Architecturally, the #PF error code is
bb24edbb673f6f3 arch/x86/kvm/mmu/paging_tmpl.h Kevin Cheng         2026-05-22  337  	 * 32 bits, and Intel CPUs don't support settings bits 31:16.
bb24edbb673f6f3 arch/x86/kvm/mmu/paging_tmpl.h Kevin Cheng         2026-05-22  338  	 */
134291bf3cb434a arch/x86/kvm/paging_tmpl.h     Takuya Yoshikawa    2011-07-01  339  	u16 errcode = 0;
13d22b6aebb000a arch/x86/kvm/paging_tmpl.h     Avi Kivity          2012-09-12  340  	gpa_t real_gpa;
13d22b6aebb000a arch/x86/kvm/paging_tmpl.h     Avi Kivity          2012-09-12  341  	gfn_t gfn;
6aa8b732ca01c3d drivers/kvm/paging_tmpl.h      Avi Kivity          2006-12-10  342  
6fbc277053836a4 arch/x86/kvm/paging_tmpl.h     Xiao Guangrong      2012-06-20  343  	trace_kvm_mmu_pagetable_walk(addr, access);
92c1c1e85bdd72b arch/x86/kvm/paging_tmpl.h     Takuya Yoshikawa    2011-07-01  344  retry_walk:
d869ff104efb1f2 arch/x86/kvm/mmu/paging_tmpl.h Paolo Bonzini       2026-05-11  345  	walker->level = w->cpu_role.base.level;
d9af9341707f67c arch/x86/kvm/mmu/paging_tmpl.h Paolo Bonzini       2026-04-05  346  	pte           = kvm_mmu_get_guest_pgd(vcpu, w);
d869ff104efb1f2 arch/x86/kvm/mmu/paging_tmpl.h Paolo Bonzini       2026-05-11  347  	have_ad       = PT_HAVE_ACCESSED_DIRTY(w);
1e301feb079e8ee arch/x86/kvm/paging_tmpl.h     Joerg Roedel        2010-09-10  348  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
