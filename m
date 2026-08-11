Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C15353A7D;
	Tue, 11 Aug 2026 21:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786485478; cv=none; b=GIdRH58cxhaaKDjMukLzd/Jzw+yLRs2XEotntpuxdCG4C/H+eR/C5gKazxVkt9v7UQyUzuUn79NF/Qiq5XwxVeR05dhDZt5rUG4A//9Z5i/TWku5Cd38fxzUSlpkyAJRpbnNMzsq/LBcbDuUDBb/VGzYXOzQL0WRJDQKtx5r3d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786485478; c=relaxed/simple;
	bh=R0HkksI0/LRQrwnV8zLMDyFVrCoKbBkzOxiWyx/R/ZI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oTY7vJclb0HwHJE8mrNJau78WFjMyyRfF/bG9uICzphGnI5fJh08mybDtJ/S/E1PetzVK/czjXiH056S3GOMMqxB35M43G/WLyF1h5/A+vrK1GHoia8LqPACaxEp6/y+GpB09Xe3lSCu0SVgATsI4BUSZQii4X2SLmHSUmS9MMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VmpzmsHA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VmpzmsHA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A721F000E9;
	Tue, 11 Aug 2026 21:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1786485477;
	bh=GyqevDNjsJZverOYk+emEjJn1/V3eS41pms2qKDvjNg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VmpzmsHAmQHSyoV0C7c4aOxavkL7BoFzwFL9KJhsqUwI9BCiNZdC7FQeiW765pIET
	 0UK0pAQ489an6CfMgI7dR9Rs0C0dU6NMYudt/7FYTFPFh+gojk0B+DJv+WwLwiV7de
	 PteOqFh8Jp2Rh3YRv+dFEKPMRhMRaJc94dUa1u6Y=
Date: Tue, 11 Aug 2026 14:57:56 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Max Boone
 <mboone@akamai.com>
Subject: Re: [PATCH v2 1/2] mm/pagewalk: fix stale walk->action escaping
 walk_pmd_range()
Message-Id: <20260811145756.6a9af6f7d3d04c8b00a0f3ee@linux-foundation.org>
In-Reply-To: <anuDYOPa0kTD9bul@v4bel>
References: <20260811161949.3879321-1-imv4bel@gmail.com>
	<20260811161949.3879321-2-imv4bel@gmail.com>
	<20260811123702.f3c60a3573e148c53ad35b97@linux-foundation.org>
	<anuDYOPa0kTD9bul@v4bel>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 05:17:36 +0900 Hyunwoo Kim <imv4bel@gmail.com> wrote:

> On Tue, Aug 11, 2026 at 12:37:02PM -0700, Andrew Morton wrote:
> > On Wed, 12 Aug 2026 01:18:57 +0900 Hyunwoo Kim <imv4bel@gmail.com> wrote:
> > 
> > > If ->pmd_entry() sets walk->action = ACTION_AGAIN, the pmd_none()
> > > check is retried. The PMD entry may be cleared at the point of retry.
> > > 
> > > In this case, if walk->ops->install_pte is not specified, the code
> > > continues to the next PMD entry in the range without resetting
> > > walk->action to ACTION_SUBTREE.
> > > 
> > > This leaves walk->action erroneously set to ACTION_AGAIN, which is
> > > incorrect.
> > > 
> > > This was incorrect but not problematic up until commit 3b89863c3fa4
> > > ("mm/pagewalk: fix race between concurrent split and refault")
> > > which updated walk_pud_range() to check for walk->action ==
> > > ACTION_AGAIN upon walk_pmd_range()'s return, causing the PUD walk
> > > to be retried.
> > > 
> > > In this case this results in duplicate walk callbacks being
> > > invoked, which is erroneous and will break any caller that is not
> > > idempotent with respect to this (and waste time for those which
> > > are).
> > 
> > "break".  Please describe the breakage completely.  It's really the
> > most important information in the whole effort.
> > 
> > IOW, when fixing a bug please describe the userspace-visible runtime
> > effects of that bug.
> > 
> > eg, what were the results of the fuzzer?  
> 
> To be precise, this is an out-of-bounds write.
> 
> > Is there a Link:?  
> 
> This came from a local fuzzer, so there is no Link:

OK, thanks.

> 
> > A stack trace?
> 
> ...
> 
> Should I send a v3 with the changelog fixed? (in 24 hours, I guess?)
> 

That's OK, I pasted it in there.
