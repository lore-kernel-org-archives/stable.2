Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795623877;
	b=Rfu5LWOHViNSJIBXBGiHCiPAZw6Yx+NywlLpTnz9CjCCLbek9g9QhNf9kJIjHb/saCHC
	 yLdyB6qvvIZc6WCZ9aJCz/EzDJjjx9eEKiC8+GtiTtR0yWUWi7GC/85aC42aHom3/x5zv
	 6pj147RbqZ6LTczPpJOkuaFSayJ0YgCD0tzO9mEYmisO9AgMPfrFQ6M04CDpy/qcTXm9s
	 KMsP5uiLyJbwVC2eDO8J0kdpu96GrIZgrgTPpKDG9Nyx3zGe3gYnUCKUppNm1FpidLEZa
	 +XGRxhi1ePLog+C7GBCJltUm1S9E1/1RM/SlBtWlky9xWgolQdyVV8kK1zNThPydNLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623877;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=oDFTFosBzQG0VfMl98eS0TLW4cOq9rDdBGbG0JR7/Ok=;
	b=u5KlS9peVTpgbm44IWhQV4YrenzztnNfdDvDUJAn3TNQQWR385Z6gO3/XgSmIO2ut1R5
	 9An8ptWnX2GiO8cicb7OhUwoBaJfTnMUlbGLoo3CdWX1OaAu4WbVRU1WS904TGlyHDu2g
	 3ePmtWmGYKeXxUqeF9uMBaRY7OenltU4QLHH0kyYuJ5P9L1uNI3n/FbEyGDIjUa8xPO/H
	 k+w946aC3QoLjDTOXmhFw3OGYw15vyywCQ0zUrqPzZ7IwIH8XVRcUjuP8Vn7H5pbEhkHu
	 9ypM7quFThIKKHG9vLLv4ULYIDA8y5Kk7U6AEYuI64E9eve50dNwQOfJoUkOahedOeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KpfcYpPd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AE1606A323;
	Wed, 25 Nov 2026 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KpfcYpPd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C691F000C4;
	Wed, 25 Nov 2026 16:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795623877;
	bh=oDFTFosBzQG0VfMl98eS0TLW4cOq9rDdBGbG0JR7/Ok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KpfcYpPddVppreFVMWSuxzh9nGhWX+7dReoJZ9KcUE5jydGICOfQskl3gfZqqxpHH
	 6Fzy3ndjRz17PAPx1ekbZqbAdTR01zW9GCmTCU0ufzqEBu4p1h51b8qYisslDkl8BK
	 KVjeDYVEIINSb9NNQFymANGe10JQlPI1Zk+kQnfTaLRXyL2kH7RJmAvEIHF+YLBPkD
	 v2louP04ieiQPC4WDQIoMBy4rrRvggBDiyNsUPzf1+GZx5D7pNB8bxsN8Zxg6EPMn9
	 f8K4Te2WvAsww89xV9AZdedu8Whr7yOJL+rKBsugK3oVNrXvuKusj8bO8745XYh9il
	 MISPUZYq/QqxQ==
Date: Wed, 25 Nov 2026 17:24:34 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Wenwu Hou <hwenwur@gmail.com>, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] tracing/hwlat: Bind the sampler kthread instead of
 setting its affinity
Message-ID: <awcLwio_qyE3d1bL@localhost.localdomain>
References: <20261125084600.2306377-1-hwenwur@gmail.com>
 <awbklFE66PIMKFop@localhost.localdomain>
 <20261125103822.2129a7ec@gandalf.local.home>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261125103822.2129a7ec@gandalf.local.home>

Le Wed, Nov 25, 2026 at 10:38:22AM -0500, Steven Rostedt a écrit :
> On Wed, 25 Nov 2026 14:37:24 +0100
> Frederic Weisbecker <frederic@kernel.org> wrote:
> 
> > >  static int kthread_fn(void *data)
> > >  {
> > > +	unsigned long flags;
> > >  	u64 interval;
> > >  
> > > +	/*
> > > +	 * kthread_bind_mask() sets PF_NO_SETAFFINITY to keep the initial
> > > +	 * affinity from being overridden by kthread_affine_node(). Clear it
> > > +	 * now to allow userspace affinity changes and cgroup migration, but
> > > +	 * keep per-CPU threads bound to their CPUs.
> > > +	 */
> > > +	if (hwlat_data.thread_mode != MODE_PER_CPU) {
> > > +		raw_spin_lock_irqsave(&current->pi_lock, flags);
> > > +		current->flags &= ~PF_NO_SETAFFINITY;
> > > +		raw_spin_unlock_irqrestore(&current->pi_lock, flags);  
> > 
> > This is not pretty but moreover, is it a good idea to let the user override
> > that affinity?
> 
> No, but we used to. Perhaps we should make that not possible instead? :-/

Right, the affinity should only be changed by the kernel if tracing_cpumask is
written. Otherwise it doesn't seem to make sense to let the user play with the
affinity.

-- 
Frederic Weisbecker
SUSE Labs
