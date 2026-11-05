Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793843049;
	b=Uy/q5hMP8h+M/5NNDOyZiRxjditMLnB9xFRQQFToULCsiavRJjkPYhjBMKZsp31z8g0x
	 zF7zkK1L3bQaPzPK4St5GR3satNvBqT3jSDV4RQ8mMu+6hCz/ywAZdY7l1PD/1b8pUhe3
	 EnvDXbY6ZUSq0RbhCdYfHjFYazy78HzN15wHhNVdkZEMU+PSYtJAZJ7Y17R/LRpsoXXRQ
	 qvi2lpDynsV0k8+JFMD8+QreOcvIZYtjYU9qXZkxVig2o9BqrEVQlpvNNKcMzDZsnQCPM
	 NLtY+sMuroQBueVvabWe1y0Xs/7xmlTuEc5+nLmQhPj0zbq2giBUqJ57CuoNCzqzdSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793843049;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=48fhyPC/y+c8FJusEcnheL0b5UlugtkX/uQTSOjVLxQ=;
	b=Rwtp7+qTthi8lOyq6fldu+n++8jJ8Gqy5kHida7fPiSa6JJYwzSxXa2jIW5zKnIzGvEa
	 0qZP61p81qpjrORan6R1a+CBv/7XghJ0V/8m+GQapCxCMM9sbkOBG2j2nQQVesFrPBbnH
	 vCbPvZrvAOrL/AhAPdV9l7+36lgGMsZrPeS2Xo+NY5WN3RPLOCxsLjgqiWKl0djHwKv0K
	 eL9MRdwSv+fH5pl+NPbYy80cMInQnK2omBUNIbzUR99ooxr0GAnx0DG34KsCqRMTLahKu
	 O3Vgwe/o5G6xC+nZFOYOHA6uw4alvpop5gX0IYjPRD+oINLqLjP//IccgJA2D2A5pGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C9DkfzPH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3656A606A31B;
	Thu,  5 Nov 2026 01:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C9DkfzPH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F611F000C1;
	Thu,  5 Nov 2026 01:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793843048;
	bh=48fhyPC/y+c8FJusEcnheL0b5UlugtkX/uQTSOjVLxQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=C9DkfzPH4+QOF8iSJRtvwJRnu2ZulxzE7FHXcSvx5hJaM1MdmIo68jJZPqhk9Haed
	 7WmgrbLbgJpt2i6seTWX/S5VqKqP5ZR7F7VqOtMO81rc5IMtFyjHqiNSc+HS6Q71G7
	 V4og7KGDsjpL/w84CTSjUSu/ETzvqvwq35qQDuulFIRYlmjHF2zdfiNxy8GsOsvjBT
	 U/5V2tyeBA8XnRt5VNKRHDtDwd/3/pdk4lXjpto7dszSSrryjrts5jgGvUaVLjiP09
	 dvHpQ6M+6ZwYdvrEy0LFYMrRkGXztCRujcIqazgcfliiyz53cajISwtQytzQSWv2wn
	 PEv3osPWfWYSw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7EC56CE0B0B; Wed,  4 Nov 2026 17:44:08 -0800 (PST)
Date: Wed, 4 Nov 2026 17:44:08 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] srcu: Add list_splice_init_srcu()
Message-ID: <dfae041c-e597-45b0-a0ba-197ee7820e86@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261104-bug-nvme-remove-ns-srcu-v2-0-feb64ecb96ca@gmail.com>
 <20261104-bug-nvme-remove-ns-srcu-v2-1-feb64ecb96ca@gmail.com>
 <9f8c94ff-29e3-4ea5-b9ec-b04b2bc21b1c@paulmck-laptop>
 <20261105012242.623962-1-odys.yuan@gmail.com>
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
In-Reply-To: <20261105012242.623962-1-odys.yuan@gmail.com>

On Wed, Nov 04, 2026 at 08:22:42PM -0500, Qiliang Yuan wrote:
> On Wed, Nov 04, 2026 at 09:14:12AM -0800, Paul E. McKenney wrote:
> > I am not inalterably opposed to adding a list_splice_init_srcu(),
> > especially if quite a few more users show up, but here is what I was
> > expecting people to do:
> >
> > 	static void synchronize_my_srcu(void)
> > 	{
> > 		synchronize_srcu(&my_srcu);
> > 	}
> >
> > 	...
> >
> > 	list_splice_init_rcu(l, h, synchronize_my_srcu);
> >
> > We need at least six uses of the above idiom to break even on the line
> > of code required for introducing a list_splice_init_srcu().
> 
> That works for a global srcu_struct, but nvme has one per controller,
> next to the list it protects:
> 
> 	struct nvme_ctrl {
> 		...
> 		struct list_head namespaces;
> 		struct mutex namespaces_lock;
> 		struct srcu_struct srcu;
> 		...
> 	};
> 
> nvme_init_ctrl() calls init_srcu_struct(&ctrl->srcu) for every
> controller, and readers walk the list under that controller's srcu,
> e.g. nvme_wait_freeze():
> 
> 	srcu_idx = srcu_read_lock(&ctrl->srcu);
> 	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
> 				 srcu_read_lock_held(&ctrl->srcu))
> 		blk_mq_freeze_queue_wait(ns->queue);
> 	srcu_read_unlock(&ctrl->srcu, srcu_idx);
> 
> nvme_remove_namespaces() thus has to wait on the srcu of the controller
> being deleted, which a sync function that takes no argument can't get
> at.
> 
> So the choice here is between list_splice_init_srcu(), as Christoph
> suggested on v1, and open-coding the splice in nvme_remove_namespaces()
> as v1 did. Which would you prefer?

Sigh!  I hereby withdraw all objections to list_splice_init_srcu(),
and thank you for bearing with me.

(Yes, you could squirrel away a pointer to the srcu_struct structure
in the task_struct structure or some such, but that cure is worse than
the disease.)

							Thanx, Paul
