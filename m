Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8606630E838;
	Thu,  3 Sep 2026 04:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788408639; cv=none; b=Hvvk0cy5atJS1I4ODzdohuam1dLSu+SICu3ueCWJzhmiNTr0Mza4afl8yj1LswVHodfG+7lus7xBOU78BZJGWgSfsFNutwpnILPPez7ct1EYSUhfLrrHnRmD3JJkrITQcskxq2WFdm7kxoLBVqqpP4sYQbyyAGKJhWCyIB+W+bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788408639; c=relaxed/simple;
	bh=KNd+nd9Vh/3BA6bvemAo2iC2v8uZdp1XUSsdpTZOtbI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GE9C9f5D3Z6VsPPh1qciTPqkPYcHf/rBu6uEe0IajJIiP96IhRi94caol3A2VpwuMGeZDhWw3wbfSSvv7vK7FeP+Zgjb/FzqKAXnxKm0NnBky36+TlXJCdEWXhveo3VE7FMiJeq1tj+pIvF8dIqIvLXFd4Cl14b91/S4h6wPCzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=iLrCPn6Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iLrCPn6Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A4F1F000E9;
	Thu,  3 Sep 2026 04:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1788408638;
	bh=dL2GJG9/VEyZC05fJEAiBzLjrdjvGGpM9qesuwNO/8A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iLrCPn6YZCAlBAwXZwTAIdv0FOoVgaIvXkp85YUvAtva/DcWv+UfPMmZ1f1Qeel/M
	 E3o716U1yotV0GGqCyL/NVfk4KWFdUrX2QxXClXlgsc4i8GDaPIrQtztSq6ciJ1Qwf
	 Msb3J6OsTV+BEs5F70tk9Ku135lnzQZSNKAjACYA=
Date: Wed, 2 Sep 2026 21:10:36 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Vernon Yang <vernon2gm@gmail.com>
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, david@kernel.org, hpa@zytor.com,
 rmclure@linux.ibm.com, andrew+kernel@donnellan.id.au,
 pasha.tatashin@soleen.com, kas@kernel.org, tj@kernel.org, rppt@kernel.org,
 rick.p.edgecombe@intel.com, yu-cheng.yu@intel.com, orsonpeters@gmail.com,
 linux-kernel@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org, Vernon
 Yang <yanglincheng@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] x86/mm: Fix pmd_modify() dropping the dirty bit
Message-Id: <20260902211036.8184c6e5535669bd73c71fd0@linux-foundation.org>
In-Reply-To: <20260903031608.1194238-1-vernon2gm@gmail.com>
References: <20260903031608.1194238-1-vernon2gm@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Sep 2026 11:16:08 +0800 Vernon Yang <vernon2gm@gmail.com> wrote:

> From: Vernon Yang <yanglincheng@kylinos.cn>
> 
> pmd_modify() masks the old value with (_HPAGE_CHG_MASK & ~_PAGE_DIRTY),
> silently discarding the hardware dirty bit.  The subsequent
> pmd_mksaveddirty() call is supposed to transfer _PAGE_DIRTY into
> _PAGE_SAVED_DIRTY when write-protecting, but the dirty bit was already
> stripped from the value, so there is nothing left to transfer.
> 
> Contrast with pte_modify(), which keeps _PAGE_DIRTY_BITS in its mask,
> and pud_modify(), which keeps _HPAGE_CHG_MASK untouched: pmd_modify()
> is the odd one out.  Any pmd_modify() on a writable, dirty PMD loses
> the dirty state.
> 
> One visible consequence is data loss with MADV_FREE on PMD-mapped THP:
> 
>     memset(buf, 0x5A, size);          // PMD-mapped THP, PMD dirty
>     madvise(buf, size, MADV_FREE);    // PMD cleaned but left writable,
>                                       // folio marked lazyfree
>     memset(buf, 0x5A, size);          // hardware sets _PAGE_DIRTY again
>     mprotect(buf, size, PROT_READ);   // pmd_modify() drops the dirty bit
>     mprotect(buf, size, PROT_READ|PROT_WRITE);
>     // ... memory pressure ...
> 
> Reclaim (e.g. under memcg pressure) then finds the lazyfree folio with
> no dirty bit set anywhere and frees it in
> __discard_anon_folio_pmd_locked(), even though the data was rewritten
> after MADV_FREE; subsequent reads fault in fresh zero pages.  NUMA
> hinting alone can trigger the same loss, as do_huge_pmd_numa_page()
> restores the PMD through pmd_modify() as well.
> 
> PMD-mapped file THPs are affected too: mprotect()/NUMA hinting dropping
> the dirty bit means rewritten data is never written back.
> 
> Fix it by keeping _PAGE_DIRTY in the preserved mask, exactly like
> pte_modify() and pud_modify() do.  The existing
> pmd_mksaveddirty()/pmd_clear_saveddirty() pair then performs the
> hardware-dirty <-> saved-dirty transition based on the write bit,
> preserving the shadow-stack encoding rules.

Yeah, this is exactly what I came up with, using chatgpt.

> Closes: https://lore.kernel.org/r/CAJxLxMUGu1-L+O_nAONOwOXnS=cNbNApCWqdthRjd76LThtSPg@mail.gmail.com/

We definitely want a Reported-by: Orson here.  He obviously did a ton
of work on this, and it's the least we can do to thank him.  I'll add it.

> Fixes: bb3aadf7d446 ("x86/mm: Start actually marking _PAGE_SAVED_DIRTY")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>

