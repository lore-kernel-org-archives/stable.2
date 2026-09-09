Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16EF3BA236;
	Wed,  9 Sep 2026 20:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788984829; cv=none; b=gt7fKzRQdOmNY0d4rNbCZoq0riBWCPF+chLydkBC89XK9rx/EBA14KRPOnZXWPcFR7OxWNyQneQsQscHADi+MBJVxuZab2GHUY2DCn3/bCpF9AsSXsdBVJ6XAMjIe7z3O/ZmRcxfwbJIQo0qfeNCxi08tDoqINMI0w4xblJ/lO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788984829; c=relaxed/simple;
	bh=w9dYimdKZoRENbfro1IP0xAzH0jL5XQd8wQ6nCnILGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uN/cZymBFVaRD/JutqBVBlcP0s9nyKX+0yGTcd76ff0pK5do8WOpG5fnbqLqLfzsZmgEe9fUQHQs5S9bbhzFdIzfnhfr/1YmUfxB0sxNEQ2XxEpZlpU1xCf7f3F8rfsnh1TWezaq9K6l+dYlbH0L+RLEiS1XI6BdaYZrxF5wQlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juCmX3GX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juCmX3GX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C171F000FF;
	Wed,  9 Sep 2026 20:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788984828;
	bh=MQv84SOaC1a4xRlHxd7KhcwiZ2JQHsHJb8U+J0I2g0I=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=juCmX3GXvi8gIcx9x1MqG0xHSRRFzOMy8j7taPhO0tbXRINSpeYHoyx3DvxXaGnlX
	 wqfo1OeB5lKOS4RDH4yrNYtQ1wVY/vrDlELptYhLFIiiafuhqzwg6j2KqCAVzA5Wzi
	 oy9k45btmuQT+ifPsLG8iPkCIOHZ4jzntrmTDY2Sg9I3VWVQGOotJML075qjZrmTuf
	 +djMyNK12BEtbJTOuA8s2E36bZZGfdsKyYXZzza5W0Z1BZOqjILooMvwlLu5kUPU9e
	 U4mmiccNQi7ixtQFukkHPRKfh7E9+QHCgKUc06cDEpvCDAMjN8KdGxoUBWQNiT/Qn6
	 vHB572M1U95wQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1DE61CE086B; Wed,  9 Sep 2026 13:13:48 -0700 (PDT)
Date: Wed, 9 Sep 2026 13:13:48 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <004abd0b-7ded-4b2d-87ab-7f8fd6f6cc8e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260909-cgwb-tasks-rcu-qs-v1-1-967a7754771f@toxicpanda.com>
 <aqGilhgcEd0qaHjI@slm.duckdns.org>
 <20260909193820.9aac7888ba9d@toxicpanda.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909193820.9aac7888ba9d@toxicpanda.com>

On Wed, Sep 09, 2026 at 07:38:20PM +0000, Josef Bacik wrote:
> On Wed, Sep 09, 2026 at 08:16:54AM -1000, Tejun Heo wrote:
> > On Wed, Sep 09, 2026 at 06:01:07PM +0000, Josef Bacik wrote:
> > > +		do {
> > > +			cond_resched_tasks_rcu_qs();
> > > +		} while (cleanup_offline_cgwb(wb));
> > 
> > The patch looks fine but this overall seems fragile. cond_resched() was
> > already marking "stuff that can take too long" but we need to use
> > cond_resched_tasks_rcu_qs() if it can take *really* long. There gotta be a
> > way to make this more maintainable. If always doing tasks_rcu_qs from
> > cond_resched() is too expensive, can it be be gated behind something cheaper
> > e.g. some tick based test?
> 
> Yeah I agree, it is fragile.  Every long running loop in the kernel that
> only does cond_resched() is a potential multi-minute synchronize_rcu_tasks()
> stall now that cond_resched() is a no-op on the preemption models most
> people actually run, and playing whack-a-mole with
> cond_resched_tasks_rcu_qs() at each site as we trip over them isn't a great
> long term answer.
> 
> I'm working on something more general so we don't have to sprinkle
> cond_resched_tasks_rcu_qs() everywhere, but I expect it to be controversial
> and it's going to take a while to shake out.  In the meantime these are real
> bugs that are taking machines down today, so I'd like to get the targeted
> fixes in and to stable while the broader discussion happens separately.

Looking forward to seeing what you come up with.

							Thanx, Paul
