Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68386222580;
	Fri, 18 Sep 2026 20:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789764500; cv=none; b=WnjyTs1jJL6DX7TP/JazCsZtsTI2a5o12+Z29ozr3dN1vuR5coU2WsAyjkcUQ6lCebLb+2xF3uIvxDoSDAjoRRJbxMddP+b2LxCX8eusVzMcsK9ODVLplzcuqEQPrH7WXjeyDqr8G2JNSs1JDAJU8f8hQBk6aNbh71ErvqF8VKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789764500; c=relaxed/simple;
	bh=POh5GW85wfXj7ebEI8T7SHI3danecazc0eCvr9IRjDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=haGwSWfqj8J2UaZYiT83Fgc5DeIfX/rjoey026u52MetkK3aBJ13yuQ5rcX9YKI9Rpnp/WClfsFL4BGet43XQ7YnIMG79C91FCVWAW1G0N7tjWY/LYnWV32GhD2sBw6XmdPG149ntthZD3Z0L1xuulwOcZhtVTRveOKWowGZn0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhH1EZxi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhH1EZxi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA90D1F000FF;
	Fri, 18 Sep 2026 20:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789764499;
	bh=F3DLy+3kNg2/wHbf2EqxrOXhPJ3Jfo/SncNlpx7Uc1o=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=XhH1EZxiDYkIZHt9a5/V37pg/Sarp1e3Qe5lMO0l+rbQFqnKHefScnL4wdDDBhxD+
	 1IKmTGM+ZquVGfG6+twDL03GIBz6MYywQDt/asVqrQkDZDOMW515TK21G9TP/djRHE
	 lO30B14/lAhYinNnfOAMgBBYmZzkb1+gk+Xk4Sk42LUyBGxYeN2FGwDn1Al208N+yZ
	 kv/CFzM/vBlqPJwhfQpG6aQKLJx4PRawtNKD51PUgzl+/NGxNDib+NYwqdOFa/YesB
	 G5/9eRJyUXAH2LOBeldllXEe3A9mMn7lxPjLry/5GDH10znpKuID0t8DuufHkHHvGZ
	 Vt3b6oPwrlqwQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C2552CE09DC; Fri, 18 Sep 2026 13:48:18 -0700 (PDT)
Date: Fri, 18 Sep 2026 13:48:18 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Breno Leitao <leitao@debian.org>, Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/shmem: report RCU-tasks quiescent states while
 undoing a range
Message-ID: <bcce9339-92bf-4702-a336-f572e6e1ba7b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260918-shmem-tasks-rcu-v1-1-79acf91a2569@debian.org>
 <20260918123239.8f25b984ca280fcc11ef6e6a@linux-foundation.org>
 <a67e8b91-ebc2-4d3d-b6ea-d221b297fad0@paulmck-laptop>
 <20260918134342.c50423cfe3b2910e899226f2@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918134342.c50423cfe3b2910e899226f2@linux-foundation.org>

On Fri, Sep 18, 2026 at 01:43:42PM -0700, Andrew Morton wrote:
> On Fri, 18 Sep 2026 13:24:53 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > > 
> > > > --- a/mm/shmem.c
> > > > +++ b/mm/shmem.c
> > > > @@ -1367,7 +1367,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
> > > >  		}
> > > >  		folio_batch_remove_exceptionals(&fbatch);
> > > >  		folio_batch_release(&fbatch);
> > > > -		cond_resched();
> > > > +		cond_resched_tasks_rcu_qs();
> > > 
> > > Won't this change remove the cond_resched() function from old kernels
> > > which really want it?
> > 
> > The cond_resched_tasks_rcu_qs() macro implies cond_resched():
> > 
> > 	#define cond_resched_tasks_rcu_qs() \
> > 	do { \
> > 		rcu_tasks_qs(current, false); \
> > 		cond_resched(); \
> > 	} while (0)
> 
> Oh, should've looked.

No problem, and yes, I do know that feeling.  ;-)

							Thanx, Paul

> And it appears to have been this way forever, so
> s/cond_resched/cond_resched_tasks_rcu_qs/ won't break old kernels.
