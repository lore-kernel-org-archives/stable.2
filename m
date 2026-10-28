Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197654;
	b=UwGobgPArgsf/1Pf/XH25pipbuL+Z5aaitamgw0NjRO/qg69X6KdBEmu6X1h7u1IULPG
	 mEPNq/mnIA5pASiNvWH8KlXWQ8Aqgqupw5IZfArnhJHtFKh9Vw0dh/LeHXecbmMxXYY8u
	 60akQFzNoyn0aceGnQ63FidVgnIa5tcnami0pzBwJOXvhLCuaW8+GMxu5h6BBPLdoLM4A
	 vX5O16rEAqz3HQA5Kt8iuJ5OxhDdB5zBehEc/CdifXKiXZ2a5mCmkGy6CXck5AT3AmPdQ
	 0Eo9zivvFWWSWVDV/hxBR323GsJnfMySODq93I+jiiR9/jADrhn09+apJoHXWKFHjbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197654;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LwivXIOL/bLE0FwSay+t1m6MvKvf0y7TbmImcg4RRU4=;
	b=Q4AxYICy3tvQEIPSbzuUIiclNFHFhkH/6eIzIZQtOeAsvlRt5d4u81Z0nbNiUySDBhOk
	 +ol6gpLX58w6ZzNKxviGFUHJ64HjUEhm6Xeu6nihQQbcOfxb2WbcgPRGOcBVZ9ZvX79qP
	 BHNiirpO2r+1pl68exZVeHwas9tInMQCviQWHjkUI8c14x/m5PHH8C+HeioTqMMxQhm48
	 sLji8A0+e1g75s/4rGTcf6bdiX3sSAAMlxbxhxbhobv3rhIRabq4rdhC4l2R0iHdUroYl
	 7eDpDoKAhR2HuMhwch9q0AzHKpL+lDVFECJPKTst3HXKxj87nUHrifYy7Kvxi6GK1Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZMOsBiX9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C771606A31A;
	Wed, 28 Oct 2026 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZMOsBiX9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A151F01825;
	Wed, 28 Oct 2026 14:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793197653;
	bh=LwivXIOL/bLE0FwSay+t1m6MvKvf0y7TbmImcg4RRU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZMOsBiX9GmoRctDsVY+OLUhIxW9NtvXwvcgyNDPish91vwxuAo87uubbrU7UYKZj0
	 T/BwQqEyMd7g0dws8obmw7BcLrMgqtvBaBgUlRlwoKjxgdhQ9vP4gK4IuNA9SET+rv
	 34yahmT51wLzG7v+uWtpdkvgCzv0Jp4yKU1wT+hvySmgZM7Uxj6Sn28nyxAdinkR4O
	 wrmoXWxe7W3OFaFjbXlub3SvS8+TgQh4YuzCsI739moisx1z47zNqr3pMqH0opC6wC
	 NqXTJcIk5t++GZBsVHIBPf1UDG8h+8WMQgRigU5pZ+761zpSLyYdn9Y/IT1RAP3JRA
	 elJbR4ALUuEBw==
Date: Wed, 28 Oct 2026 14:27:29 +0000
From: Simon Horman <horms@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev, stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>, zdi-disclosures@trendmicro.com
Subject: Re: [PATCH net v2 1/2] net/sched: sch_teql: fix slaves_lock IRQ
 deadlock
Message-ID: <20261028142729.GW257209@horms.kernel.org>
References: <QDISC-Y0BY.v2.r0.20261024060625@mojatatu.com>
 <QDISC-Y0BY.v2.r0.20261024060625-1@mojatatu.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <QDISC-Y0BY.v2.r0.20261024060625-1@mojatatu.com>

On Sat, Oct 24, 2026 at 10:34:14AM -0400, Jamal Hadi Salim wrote:
> This is a followup of commit e5b811fe7931 ("net/sched: sch_teql:
> Introduce slaves_lock to avoid race condition and UAF") as reported by
> Sashiko.
> 
> The issue: master->slaves_lock serializes the master's ring of slave
> qdiscs.  The control paths -- teql_dequeue(), teql_destroy() and
> teql_qdisc_init() -- take it with spin_lock_bh(), while
> teql_master_xmit() (the master's ndo_start_xmit) takes it with plain
> spin_lock().
> 
> netpoll_send_skb() wraps the transmit in local_irq_save(), and
> __netpoll_send_skb() asserts lockdep_assert_irqs_disabled(), so
> teql_master_xmit() reached from netconsole always acquires slaves_lock
> with hard IRQs disabled.  On PREEMPT_RT spinlock_t is an rtmutex, and
> Documentation/locking/locktypes.rst names
> 
> 	local_irq_disable();
> 	spin_lock(&lock);
> 
> as a sequence that breaks there because the rtmutex requires a fully
> preemptible context.  This is reachable without any panic: the nbcon
> printer thread calls netconsole's write_thread() callback on every
> message.  The usual remedy -- folding the IRQ disable into the lock with
> spin_lock_irqsave() -- is unavailable because the local_irq_save() is
> netpoll's, not ours.
> 
> On non-RT the same asymmetry leaves slaves_lock acquirable with hard IRQs
> disabled on one path and held with hard IRQs enabled on another.  That is
> only exploitable during the panic console flush (netconsole is
> CON_NBCON_ATOMIC_UNSAFE, so console_is_usable() admits its write_atomic()
> only from nbcon_atomic_flush_unsafe(), which panic() alone calls), and
> even then an IRQ-saving lock does not help if the holder oopsed inside the
> section or was stopped by panic_other_cpus_shutdown().  So the non-RT half
> is hardening; the PREEMPT_RT half is the bug.
> 
> The Fix: take slaves_lock as a raw spinlock with IRQs saved at every
> site.  Since skb_queue_purge() takes the queue's spinlock_t and may not
> nest inside a raw lock on PREEMPT_RT, move its call in teql_destroy()
> outside the raw section; dat->q is the dying qdisc's own queue and was
> never serialized by slaves_lock, so the move is behaviour-neutral.
> 
> The new critical sections contain only RCU pointer assignments and
> netdev_get_tx_queue(); skb_queue_purge(), netif_wake_queue() and
> dev_reset_queue() are all outside them.  teql_destroy()'s ring walk is
> O(slaves), two pointer loads and a compare per iteration, so even a large
> ring is microseconds with IRQs off.  Keeping the purge conditional rather
> than dropping it outright is the conservative call for a backport.
> 
> Some context: commit 6301f6a34ed8 ("net/sched: sch_teql: move
> rcu_read_lock()/spin_lock() from _bh variants") hardened the parent
> fix; together they addressed the master->slaves resurrection
> use-after-free and the xmit-side BH warning but left the reverse
> direction -- a hard IRQ re-entering xmit while a control path holds the
> lock -- unaddressed.
> 
> Conditions to recreate the bug:
> - CONFIG_PREEMPT_RT, CONFIG_NET_SCH_TEQL, CONFIG_DUMMY and
>   CONFIG_NETCONSOLE.
> - Run `ip link add dev teqlslave0 type dummy`, bring teqlslave0 up, attach
>   it with `tc qdisc add dev teqlslave0 root teql0`, and bring teql0 up.
> - Configure a netconsole target on teql0 with explicit local and remote
>   IP addresses and a remote MAC address, then emit a console message.
>   The nbcon printer thread reaches teql_master_xmit() with hard IRQs
>   disabled by netpoll; taking slaves_lock as a spinlock_t is invalid on
>   PREEMPT_RT. No panic or concurrent qdisc change is required.
> - Reachable by an admin with CAP_NET_ADMIN; teql devices exist only in the
>   initial netns (no per-netns ops), so a user namespace does not suffice.
> 
> Fixes: e5b811fe7931 ("net/sched: sch_teql: Introduce slaves_lock to avoid race condition and UAF")
> Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260630150922.238714-1-jhs%40mojatatu.com
> Link: https://lore.kernel.org/netdev/20260630150922.238714-1-jhs@mojatatu.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Simon Horman <horms@kernel.org>

