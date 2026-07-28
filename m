Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF6846D0B8;
	Tue, 28 Jul 2026 18:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785264247; cv=none; b=ATr6/jZWDldwTCMDMBTtA/8JUM4pBvRzAGR5By3zj1eecZK2L+WyF3Hfr9LMLrZa1z6WqIEMnzYpVjyk1dnjdEFV2CU73vRhMgmWFFCa0rWOOyT5Vt5mMTgPOBLaIsXQf7N0p7bBaFwWmOy+aBvo3HZKjjl062B7ArkgYzzfngQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785264247; c=relaxed/simple;
	bh=u3gRnuZpS43UDdJKS3z5lFMJhJ+ay6LpC6sc3ylzUeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UC73/zhlH6CwT87tGXHXa92fd15VxHd8au/fB0CnJUAHpv48vDsxcnSCGahQYJ2EsJBiAnEYLH+QLCOHEa+BcWw1kEiQMzA5vvpyDD+/V6GqwyvRlE5L0QH3Nt8UhD7g8JfH3CftH2mblBVC3W6BGB67DPH/auBvTlGvRkw58lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxrR2eRZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxrR2eRZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8271F000E9;
	Tue, 28 Jul 2026 18:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785264245;
	bh=xfyFp2bz//bP18r8X84XYEGNd+LALMUdnZPx/K5GGBI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=SxrR2eRZBV8HpH8bHZWdPRx7yvKuHZbBBiFUq/bqyF0x7DDG4LoK/9SOyZjHLS0qf
	 cez/uSlobEzismbV679B3xd4b1KGfttoSCZOhKkEBxEgpYE3lBSU7oYxo8ZdU++fdy
	 650JFiKebigdydriPz92BT3pMlua+J53cuPdY/VxP5VDoHJ7Naft0xxH5PEFyn18nx
	 CToWCIgxRIL5YkxDTpR4wGnEhLJsDzHNUopAHIelanIXD4uD2dS/FMLndapzJqjKTM
	 isPQoZicTgxI6N1gW+LXbS+QLXS7nJkn4Y5aTj8J/oFaOh3Z9E0jT1DGjRuPwGxyMn
	 Ijurfj+SY44ag==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B2944CE1919; Tue, 28 Jul 2026 11:44:04 -0700 (PDT)
Date: Tue, 28 Jul 2026 11:44:04 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Matt Fleming <matt@readmodwrite.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	stable@vger.kernel.org, kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>
Subject: Re: [PATCH] rcu-tasks: Defer IRQ-disabled callback enqueue to
 irq_work
Message-ID: <6f002779-3607-47d8-af61-a74eeb987e6a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260713101245.3207634-1-matt@readmodwrite.com>
 <amiGJWJ-tzUMYizu@matt-Precision-5490>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amiGJWJ-tzUMYizu@matt-Precision-5490>

On Tue, Jul 28, 2026 at 11:39:33AM +0100, Matt Fleming wrote:
> On Mon, Jul 13, 2026 at 11:12:45AM +0100, Matt Fleming wrote:
> > From: Matt Fleming <mfleming@cloudflare.com>
> > 
> > call_rcu_tasks_generic() can be invoked with IRQs disabled, and on
> > older kernels this exposed an ABBA deadlock against the scheduler
> > runqueue lock via sched_ext's task-storage teardown path:
> > 
> >         CPU 0                           CPU 1
> >         -----                           -----
> > sched_ext_free()
> >   task_rq_lock()
> >     raw_spin_lock(rq->lock)
> >                                       rcu_tasks_one_gp()
> >                                         raw_spin_lock(cbs_gbl_lock)
> >   scx_exit_task()
> >     bpf_task_storage_delete()
> >       call_rcu_tasks_generic()
> >         raw_spin_lock(cbs_gbl_lock)
> >           <blocks>
> >                                         _printk()
> >                                           console_unlock()
> >                                             try_to_wake_up()
> >                                               raw_spin_lock(rq->lock)
> >                                                 <blocks>
> 
> Hey Paul, it looks like this didn't get picked up and now won't apply
> cleanly to your tree. Should I submit a v2?

Apologies for the delay!!!

It turns out that there are "interesting" relationships to certain BPF
programs and the CPU hotplugs being unearthed in the discussions of this
patch's call_rcu() and call_srcu().  Which we *might* be getting to the
bottom of.

And that these affect call_rcu_tasks() as well.  And which are sadly
off-list, otherwise, I would invite you to join in.  :-(

If you would be willing to do a v2, one piece of feedback that does not
depend on the discussions is that RCU Tasks can sometimes have multiple
callback queues, and when that happens, rcu_barrier_tasks_generic()
must drain all of them.

Alternatively, please do feel free to hold off until we get the public
posting of the call_rcu() and call_srcu() deferral patch series.
It will likely provide a helper function that you can use.  To your
credit, your initial definition of the irqsoff local variable within
call_rcu_tasks_generic() is what we seem to be settling on.  It should
also clarify what needs to happen when a CPU goes offline with deferred
callbacks.

Again, please accept my apologies for being slow!

							Thanx, Paul
