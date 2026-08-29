Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CACF2FBE;
	Sat, 29 Aug 2026 00:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787963585; cv=none; b=NNtO/xBSYY7lNnPJPwsuScyCYl3BdPCteuXE+jRWEsx0I8xQnNjQga1By/j2Gxgc2uZFvSanTHeuuWZn4KtveOgmVNGIPYs+I3FY9g6Hl09SK0dTPF3cdsUP/mDGU557Jh/IBOiKy9i3F57UNZbE8zAqkq6l3n7hmmgV092NimM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787963585; c=relaxed/simple;
	bh=t4OKDZ1wCgiyviduCSp8NdpPwSKWHxM1m5mCu/wgp7Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PY+b0SavFvDywBWYp5UQ5grxdtF3Pt/FjrPYpETW6ujwjO5Gq0N+VWTdZFxZKWHXVsH12/k5EwJ9jbMhWADj/5hgu4pExtwhbYkCryQShPOKSbc1auu/q+6oLeG/kZLk7WlBNhbfMKZeMebxEujty5g0VTiNCVVckIJouSi6uWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=nU20J96s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="nU20J96s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB381F000E9;
	Sat, 29 Aug 2026 00:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1787963583;
	bh=Rx5znqdJGkl3U/Uccn0MBlBkR7uBNv5MBWL8vTAd4/g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nU20J96swjtewWfNW6NOEeQ2fgGx2KF8MwoiCZqj+/+UQDopAatdvPYy9TXSMTuqF
	 wRgbp6PJ75bfgfUpmoCMdNnxAdpVOka4FAWn3zJCRtY7dfir6t8303h64kBtwSh+Q+
	 XYCBvqn+3TB4isHKJHpPv7zYQEZd4jrV+95rS/ik=
Date: Fri, 28 Aug 2026 17:33:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: James Houghton <jthoughton@google.com>
Cc: David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 liam@infradead.org, Nico Pache <nico.pache@linux.dev>, Ryan Roberts
 <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
 <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, Usama Arif
 <usama.arif@linux.dev>, Yang Shi <shy828301@gmail.com>, zokeefe@google.com,
 hughd@google.com, Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/khugepaged: Don't install PMDs in
 uffd-minor-registered VMAs
Message-Id: <20260828173302.29778f1bf802a1db932778ad@linux-foundation.org>
In-Reply-To: <20260828222640.1638457-1-jthoughton@google.com>
References: <20260828222640.1638457-1-jthoughton@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Aug 2026 22:26:40 +0000 James Houghton <jthoughton@google.com> wrote:

> Userfaultfd minor faults provides userspace with the ability to manually
> install PTEs with UFFDIO_CONTINUE. Right now, khugepaged collapse can
> map holes in the VMA when a naturally-aligned THP is present without
> explicit action from userspace.
> 
> This is a problem, as it bypasses userfaultfd minor faults that
> userspace is expecting to handle.
> 
> If userspace implements post-copy live migration using userfaultfd minor
> faults, this situation is currently possible:
> 1. The VMA for guest memory is userfaultfd-minor-registered and nothing
>    is mapped in the page tables.
> 2. A stale copy of a page is present in a naturally-aligned THP (from
>    pre-copy live migration).
> 3. khugepaged collapses the mapping of the THP, installs a PMD.
> 4. The VM now has access to the stale contents => VM is broken.
> 5. After installing the correct contents, userspace attempts to map the
>    page with UFFDIO_CONTINUE; it gets EEXIST, indicating that something
>    unexpectedly mapped the page.

Did I read somewhere that this it biting you in a real-life scenario? 
That would use useful info to spell out.

Or is this a theoretical thing?

> The naturally-aligned THP case is the only case where this is a problem.
> khugepaged otherwise requires all PTEs to be present for
> userfaultfd-registered VMAs (i.e., max none PTEs is 0), which is
> correct. This check is essentially bypassed for naturally-aligned THPs.
> 
> No changes are needed for file_backed_vma_is_retractable(), as zapping
> PTEs is safe. Userspace must already handle cases where PTEs are zapped
> without explicit action (e.g. due to reclaim).
> 
> Fixes: 58ac9a8993a1 ("mm/khugepaged: attempt to map file/shmem-backed pte-mapped THPs by pmds")
> Cc: <stable@vger.kernel.org> # 6.1

From the changelog it isn't clear why a -stable backport is proposed? 
I assume the userspace-visible runtime effect is a rare and bogus
-EEXIST from UFFDIO_CONTINUE?

> Suggested-by: Lance Yang <lance.yang@linux.dev>
> Tested-by: Lance Yang <lance.yang@linux.dev>

Wondering what Lance tested.  Was he able to reproduce the bug?

Sashiko might have found another race in there:

	https://sashiko.dev/#/patchset/20260828222640.1638457-1-jthoughton@google.com
