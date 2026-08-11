Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD243DD521;
	Tue, 11 Aug 2026 19:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786477024; cv=none; b=bn/ns8H/Hah9Z3Txl00CC1L8SlNLSa4HAQ1pjIxlmrt9FNBVfFdPZ9pc05+g0dYQk7NgoC0YhN/dnH7kQE0hkc9zwWhC5lTZgQB6YOoGIq8NqidHsLNtZcdoxM63fNuo1DSc5ToM5uGQZzteJ7KvJC0Lv6smjbPulfmZl2ZotT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786477024; c=relaxed/simple;
	bh=fGGL3j186nSt+avBKLGd0EdqJIHk6Pza7r4GZh3o564=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=i3qwZ5OiTxZubiRAx372AbEGfuTS3C8LKjPAEKP7tRHcJFlToxdimc7ARrgbuKpO0W24bkzBSmyJZZvKDANkItLGtQAsxW478Qplnx11LdQ++kPDaX5iJ6rRkXDUCdro1DOKMTyV+cv3WwPl/XWrDI+EO7Adbk/dedNuR0AQ+w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZK5z1mIO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZK5z1mIO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB761F000E9;
	Tue, 11 Aug 2026 19:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1786477023;
	bh=JEIV1+Ic2JJ2pbDnh2hSoJgw+LV+nGwdX8sOI5VTTbQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZK5z1mIOs+2tz4ZAf0h1lEU9OS/9Ig0pXVprUHkNmIDefT/MQ8fVSjsIKeoQpOXBQ
	 8P7ZjmBBQLL9XebRiAoxunQq4+2gL7Xz0z3z8D2sFaeuactLIMewkGJgN/Wfqh/AKl
	 RkzVitgTCEZHIN1hh09OMj9vTsV2VglHFmzm1eQI=
Date: Tue, 11 Aug 2026 12:37:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Max Boone
 <mboone@akamai.com>
Subject: Re: [PATCH v2 1/2] mm/pagewalk: fix stale walk->action escaping
 walk_pmd_range()
Message-Id: <20260811123702.f3c60a3573e148c53ad35b97@linux-foundation.org>
In-Reply-To: <20260811161949.3879321-2-imv4bel@gmail.com>
References: <20260811161949.3879321-1-imv4bel@gmail.com>
	<20260811161949.3879321-2-imv4bel@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 01:18:57 +0900 Hyunwoo Kim <imv4bel@gmail.com> wrote:

> If ->pmd_entry() sets walk->action = ACTION_AGAIN, the pmd_none()
> check is retried. The PMD entry may be cleared at the point of retry.
> 
> In this case, if walk->ops->install_pte is not specified, the code
> continues to the next PMD entry in the range without resetting
> walk->action to ACTION_SUBTREE.
> 
> This leaves walk->action erroneously set to ACTION_AGAIN, which is
> incorrect.
> 
> This was incorrect but not problematic up until commit 3b89863c3fa4
> ("mm/pagewalk: fix race between concurrent split and refault")
> which updated walk_pud_range() to check for walk->action ==
> ACTION_AGAIN upon walk_pmd_range()'s return, causing the PUD walk
> to be retried.
> 
> In this case this results in duplicate walk callbacks being
> invoked, which is erroneous and will break any caller that is not
> idempotent with respect to this (and waste time for those which
> are).

"break".  Please describe the breakage completely.  It's really the
most important information in the whole effort.

IOW, when fixing a bug please describe the userspace-visible runtime
effects of that bug.

eg, what were the results of the fuzzer?  Is there a Link:?  A stack
trace?

> A specific example of this breaking things is mincore which walks
> an internal cursor data structure a byte at a time on assumption
> that page table entry callbacks are called only once for each
> entry.
> 
> Fix the problem by resetting walk->action to ACTION_SUBTREE prior
> to the none check.
> 
> The pattern also exists in walk_pud_range() so fix it there too.
> 
> This issue was found through AI-based fuzzing.
> 
> Fixes: 3b89863c3fa4 ("mm/pagewalk: fix race between concurrent split and refault")

It's good to cc the relevant Author(s).

> Cc: stable@vger.kernel.org

We really should tell -stable maintainers (and all other users of
earlier kernels) all about the above things.

>  mm/pagewalk.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

This depends on the above info, but I'd prefer to process the bugfix
promptly and defer consideration of the selftest until the next -rc
cycle.


