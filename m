Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99203C3F4B;
	Wed,  9 Sep 2026 20:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788984788; cv=none; b=CvAfmHbHNzaPvqzfL3g53L4aWeo1p1h9omZjiELC9PTp0cnGrQFmob1E0D1cr0/H/rIZfjl63hfnfQh9MzDBG8UT6zm8FYmOIE+5oohg0hh4FagI32qNGuh+YH9NBZWFjzPN0niqwPPZQRATahTc5YK3kPsp+mxhxS/f2aoc5wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788984788; c=relaxed/simple;
	bh=V+GgSlP8m9eZsYUDYB3PmRKoBSh4/ncBCklgpWvTtzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZxm/5PZCMXT6GhPOYAnUZjtDVlEhBsRyOybseLnzy54fbCKGnCkUVKyxFWW3TBf0zdCH/YhsZDitCCWyGswWwQbEpq2TNI+jONBO/9i6eyA8muccpRsiGMw//HK8M2GRt38d68PvDLW/xJSJdubivwhT8myMgckmc3Q21Ccjac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ysd/kTgA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ysd/kTgA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE741F000FF;
	Wed,  9 Sep 2026 20:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788984779;
	bh=nkCROJGmCSID5J3EY7M78lHWx0S0ZOsvo3WsTjTa2PE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=Ysd/kTgAgLyUrOsMKu6uj6c92r8HOe4mmu5KgvdKGgbuUHS8sjrYbrGofEYKTiPVx
	 xUtHICG9VeB11il5KfTzApgWiMDhYNTCQR/p1tfAzXsQxwKn38pDWcLCmFXphnHCst
	 atPLvH/Y2hQFwhHzDJCBHNUWO8obouQ5v/bSiJC4rLphPzLQTeUr93cUaxZDT2YSRR
	 4OudDUbPP3S+Jk9WF7Ei0lU2inuVYtYS7KplVE93iQ9McLs3/4uFBRopyan2SdTUSj
	 YlKGcGFieO1QmAn/ktA4ObWl7Q5vLMS995+JKQnPl7G9Uj34wBP/7afR5QjSC847we
	 EAubBzM3qBKCg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 04BCFCE086B; Wed,  9 Sep 2026 13:12:59 -0700 (PDT)
Date: Wed, 9 Sep 2026 13:12:58 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Dennis Zhou <dennis@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] writeback: report a Tasks-RCU quiescent state per cgwb
 drain pass
Message-ID: <d49bd6cd-0670-47ba-b8ef-e3e8c0d49830@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260909-cgwb-tasks-rcu-qs-v1-1-967a7754771f@toxicpanda.com>
 <aqGilhgcEd0qaHjI@slm.duckdns.org>
 <16d13239-8911-4597-bfd6-18aa02135137@paulmck-laptop>
 <aqGv7R4LTmlrW6QI@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqGv7R4LTmlrW6QI@slm.duckdns.org>

On Wed, Sep 09, 2026 at 09:13:49AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Wed, Sep 09, 2026 at 12:03:20PM -0700, Paul E. McKenney wrote:
> > > The patch looks fine but this overall seems fragile. cond_resched() was
> > > already marking "stuff that can take too long" but we need to use
> > > cond_resched_tasks_rcu_qs() if it can take *really* long. There gotta be a
> > > way to make this more maintainable. If always doing tasks_rcu_qs from
> > > cond_resched() is too expensive, can it be be gated behind something cheaper
> > > e.g. some tick based test?
> > 
> > This is the business end of cond_resched_tasks_rcu_qs() in preemptible
> > kernels (in which cond_resched() is nothingness):
> > 
> > # define rcu_tasks_classic_qs(t, preempt)				\
> > 	do {								\
> > 		if (!(preempt) && READ_ONCE((t)->rcu_tasks_holdout))	\
> > 			WRITE_ONCE((t)->rcu_tasks_holdout, false);	\
> > 	} while (0)
> > 
> > This is pretty lightweight.  Adding a jiffies check would likely make
> > it more expensive.
> > 
> > Or am I missing your point?
> 
> I found the following thread for why there is a separate variant for
> cond_resched_tasks_rcu_qs():
> 
>   https://lkml.kernel.org/r/20180224151240.0d63a059@vmware.local.home

Well, that was nine years ago.  ;-)

> The rationale was that it'd make cond_resched() expensive, so I assumed it
> was relatively heavy. If it already comes down to a single test, I'm not
> sure having a separate interface makes a lot of sense. There isn't some
> semantical difference between the two, right? Anything which takes long
> enough needs to do the tasks rcu qs, and that is what we mark with
> cond_resched().

And nine years later, I am still good with cond_resched() implying
cond_resched_tasks_rcu_qs().

The people wanting to get rid of cond_resched() might have a different
opinion, though.

							Thanx, Paul
