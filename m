Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E78D13A244;
	Thu, 30 Jul 2026 01:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785374280; cv=none; b=Y+dEy7At+zgplvTHJHEMPlmS/W9Ju4vJ+F4IKsSafpsTRAsO5CMawHsSStwR5RdbmFMgNpd92Z3gAz/IF7hU5oxQwvXOixpNFsV++I1atNAjt1ZzS6ySisMlvNl5ClBDtQRZuyFOatnFTM5cpoH9UyIbIejgtqqbtk089tHAPtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785374280; c=relaxed/simple;
	bh=pGsRHKzsgX80YcISWaOI/AfQrEt+H45DKjMeO4j0TlE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DiDdVuOtSiFYDmyJIHK7v0wNiJPFzx8EKIZIKR3gx3XRsgEJKRCU7dM24Pzcv7KMbxeOuJNZ3EvNjJQVGs83QD2DyGNDGHI3vQiUL9GzTZnO0+JACgE8A68FqySy/aznLYq6sHaH7SzpvuZAGTRTIWMZQg9Wy5KcC7POOmfL7mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=K+8mJltb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K+8mJltb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ECDE1F000E9;
	Thu, 30 Jul 2026 01:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1785374277;
	bh=Es5KUQVRoUSm8lu4Qgb37wmW7A914LbkwxNQHClT8pk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=K+8mJltbxDSXv6VNjHZdM43LVIaMBfhtxI78uRyVZfV8H3u6oiN02soQZ6k2t6LMt
	 fiwY7umJlE0UUrFeqpFy4+44MzEU31DWXcK58/i++DLHc2s/SiYwdBBduMIcvddtVw
	 0M4lmhanWeJc9UC6EP0La9zwppguhlFJtzNVMnBY=
Date: Wed, 29 Jul 2026 18:17:56 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Hao Jia <jiahao.kernel@gmail.com>, tj@kernel.org, hannes@cmpxchg.org,
 shakeel.butt@linux.dev, mhocko@kernel.org, mkoutny@suse.com,
 nphamcs@gmail.com, chengming.zhou@linux.dev, muchun.song@linux.dev,
 roman.gushchin@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm/zswap: Fix global shrinker when memory cgroup
 is disabled
Message-Id: <20260729181756.a37e0cc7ea3f6013959d1d25@linux-foundation.org>
In-Reply-To: <CAO9r8zNhBCghP8T_98z2p==Cfs_=kamcRN_3ROxaj3R8PN2Qvw@mail.gmail.com>
References: <20260729084206.77793-1-jiahao.kernel@gmail.com>
	<20260729084206.77793-2-jiahao.kernel@gmail.com>
	<20260729155858.c7aabff48166a9bca4d68ac3@linux-foundation.org>
	<CAO9r8zNhBCghP8T_98z2p==Cfs_=kamcRN_3ROxaj3R8PN2Qvw@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 29 Jul 2026 17:30:56 -0700 Yosry Ahmed <yosry@kernel.org> wrote:

> On Wed, Jul 29, 2026 at 3:58 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Wed, 29 Jul 2026 16:42:05 +0800 Hao Jia <jiahao.kernel@gmail.com> wrote:
> >
> > > Zswap writeback when the global pool limit is hit fails when memory
> > > cgroup is disabled. The pool remains full until it is organically
> > > drained by swapins or memory freeing, leading to zswap store failures
> > > and pages bypassing getting written directly to the backing swap device,
> > > causing LRU inversion (hotter pages with higher fault latency).
> > >
> > > This happens because mem_cgroup_iter() always returns NULL when
> > > memory cgroups are disabled. As a result, the global shrinker
> > > shrink_worker() repeatedly takes empty walks. After MAX_RECLAIM_RETRIES
> > > failed attempts, the worker gives up without writing back any pages.
> > >
> > > Therefore, when memory cgroup is disabled, fall through with the !memcg
> > > branch and shrink the root memcg directly.
> > >
> > > With memcg disabled, shrink_memcg() only returns -ENOENT when the root
> > > LRU is empty, which means the total pages are already below thr. In the
> > > absence of heavy concurrent zswap stores, the loop then safely bails out
> > > via the zswap_total_pages() <= thr check; otherwise, it will resume
> > > shrinking the memcg after processing the reschedule check. For any other
> > > return value from shrink_memcg(), the loop is guaranteed to terminate,
> > > either after MAX_RECLAIM_RETRIES failures or once the threshold is met.
> > >
> > > Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
> > > Cc: stable@vger.kernel.org
> >
> > How does this affect users?  What behavior do they observe when it
> > occurs?
> 
> I think the first paragraph sums it up pretty well, especially the
> last sentence "hotter pages with higher fault latency".

How do users observe that?

See, what I'm looking for here is an explanation for why we're
proposing a backport.  How are our users harmed by the current code and
how does this change benefit them?

> >
> > > Closes: https://lore.kernel.org/all/CAO9r8zPVzMKFbCixxD-qgtRrkFxWVrHiZZeLc=eyTPKPVQgX4g@mail.gmail.com
> >
> > hm, that isn't really a bug report and doesn't answer the above
> > question.
> 
> Yeah, it isn't. Probably we should drop "Closes". I assume Hao added
> it because checkpatch annoyingly complains if you add "Reported-by"
> without "Closes", so Hao just linked to the thread where I pointed out
> the bug.

OK.


