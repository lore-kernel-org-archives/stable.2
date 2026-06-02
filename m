Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C4034EEEE;
	Tue,  2 Jun 2026 06:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381985; cv=none; b=pfgQ+wgm5oDZIhWzmkGIG3J33UPsFQ2EdBnktkNiDE5EWU/ejtLfeav8Cd3P0NFzkMEcG5HA66YRxSWhelfT/DCDS6OVZZGepZVi7rJLV2CxzSUD+K3aOhXSEOGbMyQ/uCQFM75oNGAJhdaEOhtb1wsvV3xVs5k8KfLFzlpxIc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381985; c=relaxed/simple;
	bh=qz05PwTA4HuRNr4ARk6c3VjCwvFC+bW1NTje/WkmVPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BvJz7l+XPceKqvavKiQPqnLlZXk7+QBiEMhN7rfvxToMRCPjhONjcU/LG9inRFmgCjEK9Asd1g62qbMZxxV/S8HqnnnSW5WRmqyhum8ReAQopkE9l6u2Um76ReAZ9ekOhss3NxJH0QUqwxlHYWZn3Q/aS+K3eMQsV58/cQXyDeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=W8P52rqU; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="W8P52rqU"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8C9A176C;
	Mon,  1 Jun 2026 23:32:51 -0700 (PDT)
Received: from [10.164.19.28] (unknown [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 342E33F632;
	Mon,  1 Jun 2026 23:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780381976; bh=qz05PwTA4HuRNr4ARk6c3VjCwvFC+bW1NTje/WkmVPQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W8P52rqULy8EgMCv3VoHG/oPcN8xzFRTm0MMO+8epoLD09z1j5dUEPlnncU3kRwVu
	 meLb8U698TNe/FRFV0Os10F+xaUpB8p6DhZVBOSnFtbGb2r2bal+bxG9WlhJfvwd6L
	 cPAYBN6mNWM0vhQCfBAe1vL9kyhq4pdOA/ckIRWA=
Message-ID: <0ab810b9-8644-4562-8218-c9a1d4ddd423@arm.com>
Date: Tue, 2 Jun 2026 12:02:47 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] fs/proc/task_mmu: fix make_uffd_wp_huge_pte()
 prot-update race
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Lorenzo Stoakes <ljs@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 David Hildenbrand <david@kernel.org>, stable@vger.kernel.org,
 Sashiko AI review <sashiko-bot@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
 Muhammad Usama Anjum <usama.anjum@arm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
 linux-fsdevel@vger.kernel.org
References: <20260529172331.356655-1-kas@kernel.org>
 <20260529172331.356655-2-kas@kernel.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20260529172331.356655-2-kas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29/05/26 10:53 pm, Kiryl Shutsemau (Meta) wrote:
> make_uffd_wp_huge_pte() arms the UFFD_WP bit on a present HugeTLB PTE by
> calling huge_ptep_modify_prot_commit() with a ptent snapshot that was
> fetched without the corresponding huge_ptep_modify_prot_start(). The
> start helper is what atomically clears the entry so the kernel-owned
> snapshot stays consistent until the commit; without it, the hardware
> may set Dirty or Accessed in the live PTE between the original read
> and the commit, and huge_ptep_modify_prot_commit() (whose generic
> implementation just calls set_huge_pte_at()) then writes the stale
> snapshot back over the live hardware bits, losing the update.
> 
> The non-hugetlb sibling make_uffd_wp_pte() does this correctly via
> ptep_modify_prot_start() / ptep_modify_prot_commit(). Mirror that
> pattern for the present-PTE branch. The migration case stays as-is --
> migration entries are non-present, so there's no hardware update to
> race against.
> 
> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> ---

LGTM

Reviewed-by: Dev Jain <dev.jain@arm.com>


>  fs/proc/task_mmu.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 1e3a15bf46f4..e21a38ac745b 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -2610,12 +2610,16 @@ static void make_uffd_wp_huge_pte(struct vm_area_struct *vma,
>  	if (softleaf_is_hwpoison(entry) || softleaf_is_marker(entry))
>  		return;
>  
> -	if (softleaf_is_migration(entry))
> +	if (softleaf_is_migration(entry)) {
>  		set_huge_pte_at(vma->vm_mm, addr, ptep,
>  				pte_swp_mkuffd_wp(ptent), psize);
> -	else
> -		huge_ptep_modify_prot_commit(vma, addr, ptep, ptent,
> -					     huge_pte_mkuffd_wp(ptent));
> +	} else {
> +		pte_t old_pte, new_pte;
> +
> +		old_pte = huge_ptep_modify_prot_start(vma, addr, ptep);
> +		new_pte = huge_pte_mkuffd_wp(old_pte);
> +		huge_ptep_modify_prot_commit(vma, addr, ptep, old_pte, new_pte);
> +	}
>  }
>  #endif /* CONFIG_HUGETLB_PAGE */
>  

