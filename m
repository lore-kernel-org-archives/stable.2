Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF9E33A9FE;
	Sat,  5 Sep 2026 04:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788583380; cv=none; b=G8FFa2dZWqIQuYCPeTSrXD7O/VRvTOJhMZGsak1zltU91J1sHj/4S9e6s658ycQM9fuDoLceuIivl1D8eAwPoyQzOXr86zTSGSyoPKuCsH641Ew337qf/sVUjSmrNrrfuZFPw7fn7QjBPm/EXWkak1KltewHljFBFjWuYQ/1YOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788583380; c=relaxed/simple;
	bh=/5YljNKyIjooUc+uTWJr14JPjbfszcPYpy6hTVubqpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfh6husu6kSFONUqqVs72qNtH6W0IYX/2JBZKSltCU3q7TDMB1MXl9ewLC1ZHhLlSn7TDGF1/ePWB+RxuLE0rEbnHQi9aikAUQ/ovW6VhAy4qYVxzly+fRrBB+YBjSbHBl+Z8CQ9eHhTmm8gdThfzH+3b1sOGfrmOzKfOE6rXEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbxRknt1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbxRknt1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7A71F00A3D;
	Sat,  5 Sep 2026 04:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788583378;
	bh=EhSVYeXRupDic0oXtgt+4PngUaCr1RXhr0JzlxUWENM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RbxRknt1R/z5z7AhVVksu7xAW3ud1SLHt+msPLxCnAMB8/HJ7dRptCz9BnAci+7gf
	 eyyuYRyxjnx+iEg2nWVmC9xLtWhPBrrQdL9vSefP6EFXG07ydfzn1t7L7upwwl3JRy
	 sVck+mxUyYgUf9tc/QY4awjERS5u5eRNXzOVe1ZUEimz7Pzw9KstEt+LTgwKZa7pS5
	 Xs0WI+eLtBO0Q3Br+M5fVZVHG4ZvoXNdSLSlp65hFgvyUkT4Hu7+9jwhkYmqP9VmNw
	 AEy/A9ulxIdXHvICjUzyEUoZHd9jbOa5dtuQHt0/i0Mg6Z/pIP9FYGXfHrmsE+c57s
	 YeO01gA2MrCcA==
Date: Fri, 4 Sep 2026 21:42:53 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-tip-commits@vger.kernel.org, Juergen Gross <jgross@suse.com>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	syzbot@syzkaller.appspotmail.com, Atish Patra <atishp@meta.com>,
	Nikunj A Dadhania <nikunj@amd.com>, stable@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [tip: x86/urgent] x86/mm/pat: Fix effective RW computation in
 lookup_address_in_pgd_attr()
Message-ID: <20260905044253.GA3816371@ax162>
References: <20260813-cpa-fixes-v2-5-39b4ff90f91d@kernel.org>
 <178837401172.3717435.314324339347590321.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178837401172.3717435.314324339347590321.tip-bot2@tip-bot2>

Hi folks,

On Wed, Sep 02, 2026 at 06:33:31PM -0000, tip-bot2 for Mike Rapoport (Microsoft) wrote:
> The following commit has been merged into the x86/urgent branch of tip:
> 
> Commit-ID:     453e7859443446b837d905d6f2983a76c867247d
> Gitweb:        https://git.kernel.org/tip/453e7859443446b837d905d6f2983a76c867247d
> Author:        Mike Rapoport (Microsoft) <rppt@kernel.org>
> AuthorDate:    Thu, 13 Aug 2026 12:01:28 +03:00
> Committer:     Dave Hansen <dave.hansen@linux.intel.com>
> CommitterDate: Tue, 01 Sep 2026 15:03:18 -07:00
> 
> x86/mm/pat: Fix effective RW computation in lookup_address_in_pgd_attr()
> 
> lookup_address_in_pgd_attr() accumulates the effective NX and RW bits of
> the walked page table levels so that verify_rwx() can detect mappings that
> are both writable and executable.
> 
> The RW bits are folded into a bool with
> 
> 	rw &= pXd_flags(*pXd) & _PAGE_RW;
> 
> but _PAGE_RW is 0x2. So consider the accumulation line:
> 
>         rw &= pXd_flags(*pXd) & _PAGE_RW;
> 
> where rw=0x1 and the right side evaluates down to 0x2. It'll end up doing:
> 
>         rw = 0x1 & 0x2
> 
> and rw always ends up 0.
> 
> This way rw becomes false at the first level walked, regardless of the
> actual permissions, and verify_rwx() treats every mapping as non-writable
> and never reports a W^X violation.
> 
> Add double negation to the right side to normalize the _PAGE_RW flag to
> 0 or 1.
> 
> Assisted-by: Copilot:claude-opus-4.8
> Fixes: ceb647b4b529 ("x86/pat: Introduce lookup_address_in_pgd_attr()")
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Juergen Gross <jgross@suse.com>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Tested-by: syzbot@syzkaller.appspotmail.com
> Tested-by: Atish Patra <atishp@meta.com>
> Tested-by: Nikunj A Dadhania <nikunj@amd.com>
> Cc:stable@vger.kernel.org
> Link: https://patch.msgid.link/20260813-cpa-fixes-v2-5-39b4ff90f91d@kernel.org
> ---
>  arch/x86/mm/pat/set_memory.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 4652487..2266609 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -754,7 +754,7 @@ pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned long address,
>  
>  	*level = PG_LEVEL_512G;
>  	*nx |= pgd_flags(*pgd) & _PAGE_NX;
> -	*rw &= pgd_flags(*pgd) & _PAGE_RW;
> +	*rw &= !!(pgd_flags(*pgd) & _PAGE_RW);
>  
>  	p4d = p4d_offset(pgd, address);
>  	if (p4d_none(*p4d))
> @@ -765,7 +765,7 @@ pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned long address,
>  
>  	*level = PG_LEVEL_1G;
>  	*nx |= p4d_flags(*p4d) & _PAGE_NX;
> -	*rw &= p4d_flags(*p4d) & _PAGE_RW;
> +	*rw &= !!(p4d_flags(*p4d) & _PAGE_RW);
>  
>  	pud = pud_offset(p4d, address);
>  	if (pud_none(*pud))
> @@ -776,7 +776,7 @@ pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned long address,
>  
>  	*level = PG_LEVEL_2M;
>  	*nx |= pud_flags(*pud) & _PAGE_NX;
> -	*rw &= pud_flags(*pud) & _PAGE_RW;
> +	*rw &= !!(pud_flags(*pud) & _PAGE_RW);
>  
>  	pmd = pmd_offset(pud, address);
>  	if (pmd_none(*pmd))
> @@ -787,7 +787,7 @@ pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned long address,
>  
>  	*level = PG_LEVEL_4K;
>  	*nx |= pmd_flags(*pmd) & _PAGE_NX;
> -	*rw &= pmd_flags(*pmd) & _PAGE_RW;
> +	*rw &= !!(pmd_flags(*pmd) & _PAGE_RW);
>  
>  	return pte_offset_kernel(pmd, address);
>  }

I just bisected the following warning on a couple of my test machines to
commit 453e78594434 ("x86/mm/pat: Fix effective RW computation in
lookup_address_in_pgd_attr()") in next-20260904.

  [Sep 4 21:36] CPA detected W^X violation: 8000000000000123 -> 0000000000000123 range: 0xffffffffc0400000 - 0xffffffffc0400fff PFN 100e00
  [  +0.000001] WARNING: arch/x86/mm/pat/set_memory.c:722 at __change_page_attr_set_clr+0xde7/0x1290, CPU#0: swapper/0/0
  [  +0.000005] Modules linked in:
  [  +0.000002] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.3.0-rc1-debug-00006-g453e78594434 #1 PREEMPT(full)  2950d432dd3910251071a66f3134fe0875432786
  [  +0.000001] Hardware name: ASUS System Product Name/PRIME Z590M-PLUS, BIOS 1801 12/26/2022
  [  +0.000001] RIP: 0010:__change_page_attr_set_clr+0xdff/0x1290
  [  +0.000002] Code: 80 7c 24 42 00 0f 85 3a 04 00 00 48 8d 3d 19 8d 79 02 49 89 d9 4c 89 e1 4c 89 d2 4c 89 f6 4d 8d 84 24 ff 0f 00 00 4c 89 14 24 <67> 48 0f b9 3a 4c 8b 14 24 48 8b 0d 81 44 bf 01 41 f6 c2 01 0f 85
  [  +0.000001] RSP: 0000:ffffffff87003c60 EFLAGS: 00010246
  [  +0.000002] RAX: 0000000000000002 RBX: 0000000000100e00 RCX: ffffffffc0400000
  [  +0.000000] RDX: 0000000000000123 RSI: 8000000000000123 RDI: ffffffff872e50c0
  [  +0.000001] RBP: 8000000100e00123 R08: ffffffffc0400fff R09: 0000000000100e00
  [  +0.000001] R10: 0000000000000123 R11: 0000000000000001 R12: ffffffffc0400000
  [  +0.000000] R13: 0000000100e00123 R14: 8000000000000123 R15: ffffffff87003d58
  [  +0.000001] FS:  0000000000000000(0000) GS:ffff8ad1777a7000(0000) knlGS:0000000000000000
  [  +0.000001] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [  +0.000001] CR2: ffff8ad0a4201000 CR3: 00000007e3022001 CR4: 0000000000770ef0
  [  +0.000001] PKRU: 55555554
  [  +0.000001] Call Trace:
  [  +0.000001]  <TASK>
  [  +0.000002]  ? _vm_unmap_aliases+0x219/0x280
  [  +0.000003]  change_page_attr_set_clr+0x161/0x250
  [  +0.000002]  ? events_sysfs_show+0x5d/0x80
  [  +0.000002]  set_memory_x+0x39/0x50
  [  +0.000002]  apply_retpolines+0x656/0x6d0
  [  +0.000002]  ? events_sysfs_show+0x5d/0x80
  [  +0.000002]  ? events_sysfs_show+0x6c/0x80
  [  +0.000001]  ? events_sysfs_show+0x62/0x80
  [  +0.000001]  alternative_instructions+0x3c/0xd0
  [  +0.000003]  arch_cpu_finalize_init+0x130/0x190
  [  +0.000003]  start_kernel+0x97d/0xa10
  [  +0.000002]  x86_64_start_reservations+0x24/0x30
  [  +0.000002]  x86_64_start_kernel+0xda/0xe0
  [  +0.000002]  common_startup_64+0x13e/0x151
  [  +0.000003]  </TASK>
  [  +0.000001] ---[ end trace 0000000000000000 ]---

  # bad: [af5f12805e5cefa4fe68d6127c7e1fb78cd5535c] Add linux-next specific files for 20260904
  # good: [421066905cbceca1f78cba5f7d92b4980317ab2b] Merge tag 'probes-fixes-v7.3-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace
  git bisect start 'af5f12805e5cefa4fe68d6127c7e1fb78cd5535c' '421066905cbceca1f78cba5f7d92b4980317ab2b'
  # bad: [7e9b8247e9129fa3803020d3262e2384a0cfc29a] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git
  git bisect bad 7e9b8247e9129fa3803020d3262e2384a0cfc29a
  # bad: [c4faef7e83f9c601c1264c0fad20af0e00b5a52b] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
  git bisect bad c4faef7e83f9c601c1264c0fad20af0e00b5a52b
  # good: [14bd0d1671d1655d33419b60c9c476d0590636dd] Merge branch 'drm-fixes' of https://gitlab.freedesktop.org/drm/kernel.git
  git bisect good 14bd0d1671d1655d33419b60c9c476d0590636dd
  # good: [8d6fa663f11a859304187a70c569ec0617aa2461] Merge https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-unstable into for-next
  git bisect good 8d6fa663f11a859304187a70c569ec0617aa2461
  # bad: [276cefa1ab31a5d4fe5e4446f5e504499cc03320] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/mm/linux.git
  git bisect bad 276cefa1ab31a5d4fe5e4446f5e504499cc03320
  # good: [aad09a60e0012e85b03540a12e1fd1a61646712b] Merge branch 'rust-fixes' of https://github.com/Rust-for-Linux/linux.git
  git bisect good aad09a60e0012e85b03540a12e1fd1a61646712b
  # bad: [586e57cb2f695099a15e72029804a0592e6ad566] Merge branch into tip/master: 'x86/urgent'
  git bisect bad 586e57cb2f695099a15e72029804a0592e6ad566
  # good: [223f1750ff141a7e59b2724b645f348ffdab12e9] Merge branch into tip/master: 'sched/urgent'
  git bisect good 223f1750ff141a7e59b2724b645f348ffdab12e9
  # good: [e679ba0983757e9567aeda97cc35c99241d420ee] x86/alternative: Exclude text poking against change_page_attr()
  git bisect good e679ba0983757e9567aeda97cc35c99241d420ee
  # bad: [453e7859443446b837d905d6f2983a76c867247d] x86/mm/pat: Fix effective RW computation in lookup_address_in_pgd_attr()
  git bisect bad 453e7859443446b837d905d6f2983a76c867247d
  # good: [0e33126d5def407397deaf617559a1a2a7f4b1ae] x86/mm/pat: Allocate split page tables as kernel page tables
  git bisect good 0e33126d5def407397deaf617559a1a2a7f4b1ae
  # first 'bad' commit: [453e7859443446b837d905d6f2983a76c867247d] x86/mm/pat: Fix effective RW computation in lookup_address_in_pgd_attr()

If there is any information I can provide to help debug this, I am happy
to provide it.

-- 
Cheers,
Nathan
