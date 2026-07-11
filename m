Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8593D23D2B1;
	Sat, 11 Jul 2026 23:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783814227; cv=none; b=jEMgxnoAR3yjEYJ+22v4rSXlzFtCmSu6Fer4gH6kgjbY0yGJ8N+tocL7M2DEipB8UKKC0wY7FADR6YXK98Kuo7QEthtE7zLAUwe2XSmQn3f06ljonXAzMTYeD1Bz3pJc/V5UXfXdwwAKSzsIfTIU3uplqwonotwUaORYY1CUJWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783814227; c=relaxed/simple;
	bh=Aj8FUnZpKqQrWDDP0G+micLrUAtdKhV8k/pggfEolKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TznwtQM7I6979YHswwuuLzm6Ansg5Uc4nHjcRbExighWJYBJXqIAjUv7t9nC8Ud0ufITfQUxdU8Ktf8u6TA7v/0HtdNRSZXz0wDRmtJwBPvwfqMXWtjQNUx8LJIwUZ/hqMPhYj+CWhav4fNmucKO0GFv39fTNduZNQTH+RAINhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpfTykPi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpfTykPi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2438F1F000E9;
	Sat, 11 Jul 2026 23:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783814226;
	bh=RoTc3ubU1GUekjrXvQrhpiWw+h5dYYikMu9KV19iKWc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=fpfTykPiFAuTdbvYCoXObmXdRjicnMK0n+tY9xylhUHNdpOYwmu6ymkrMLGbtHTTK
	 ouQyVH8Ib+eWqxqiIDoFfQXj7l66xKkZ12GqcxPfP7OkTApBSsI6g0stoFf2T8Bw6t
	 9otcZfoQlpixeO3+utISvLrJ1x6l7E4PzmLJfrwrGwR9EJYrWWM1KcvBrBMBOR33pF
	 7lerjK6055qGzWSrnHw1Go07Wt3rIoGIdtPmIiDEcjQz9tYpzRkLYV/wOi48HJ1iWF
	 IZALFkyi6DEH4VlRbIPkMj96gUWiyEJFeacFh5N15hFXR1N/VltUTaw8+pDeyucomj
	 fQyvJnt8bTFPg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EFA59CE0806; Sat, 11 Jul 2026 16:57:05 -0700 (PDT)
Date: Sat, 11 Jul 2026 16:57:05 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Matt Fleming <matt@readmodwrite.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	stable@vger.kernel.org, kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>
Subject: Re: [PATCH 6.18.y] rcu-tasks: Defer IRQ-disabled callback enqueue to
 irq_work
Message-ID: <fb7338f4-d2e1-43cf-99e6-a6109751d2f3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260710095359.2643791-1-matt@readmodwrite.com>
 <886c23ff-7dca-4679-9d2b-ca499523853c@paulmck-laptop>
 <alHapJgHNRea7eZz@matt-Precision-5490>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alHapJgHNRea7eZz@matt-Precision-5490>

On Sat, Jul 11, 2026 at 06:56:18AM +0100, Matt Fleming wrote:
> On Fri, Jul 10, 2026 at 11:16:27AM -0700, Paul E. McKenney wrote:
> > 
> > This does look plausible, thank you!  However, it does not apply cleanly
> > to either current mainline or my -rcu tree.
> > 
> > Judging from the subject line, this is against v6.18 rather than current
> > mainline, correct?  If so, would you be willing to forward-port it?
> 
> Yeah, my bad. Since the SRCU code in mainline fixed the original
> deadlock I reported I kept this to 6.18. But I'm happy to forward port
> this patch too.

It would be good in order to avoid similar issues with call_rcu_tasks()
and call_rcu_tasks_rude(), so please do!

							Thanx, Paul
