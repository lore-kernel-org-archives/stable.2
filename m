Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793843206;
	b=WD/SJ3v1yLnMAp/FeN1tMPxH6ut2zLg5Z2UtbZVLF4gQ/lWut1UtR2SFl1uHA0vEBTAp
	 dh9DTS4HR88JIlEhyaEQCsvXzF05c+yl2+R5tmUJkSYz7bS2NowG0ltq8fFPTI7gCu4mm
	 FqH41c2oAwSoAhThJLFY4vfk0e82wRFsJFWgf/4DEU9hpaizyGMhNnbNMYwzpmougVhaT
	 yue1ve45pIxdvGnFIOpwckx4LQszh9v9jvZIHi4c9Rf47u7uZeiY2SQ0qH1IlQ4UBlA0s
	 ePqPH0/01cKcH16lLJ0AdNGyfACmcoLx9KG8u9F8Fqq+11lvenq4B0TGHPrw1TvWd4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793843206;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=vzblkOvjx9ASJ3j79izeEunNnmRUxxFuazx+mrXhEWc=;
	b=foHFG8hzvQlULh8V/W0fEFMmBwh45cpQIc0eGJjRkLedLihM8CDp/htKDyGzdr9rKkSt
	 6QWw0V1G/T8oCEtSaRrH0AFNESn73Bskqs5jomZkJr2wDedIwDMsuQUcKLZMjnYuysYF4
	 B8qchtrV0f7CEXW2w/FVXhK0vhL2vFI7EzugMx8fvMj2mfrA6gfW27DzZDDUcJzriJX+U
	 uH5Vvg58BtLF3CP2lXgl+UzFGRgufXXMPScGIg73J+gzVQVus2m13xbfj3CSavmkSXDmj
	 earCDPyBxmc0DF7qDV/PnhE+W4SkwfyHTczPFyCIjZ3/0qFa/8UBEbvt0lECnnGLqUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UZNWd8YS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5925A606A326;
	Thu,  5 Nov 2026 01:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UZNWd8YS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1343D1F0093A;
	Thu,  5 Nov 2026 01:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793843206;
	bh=vzblkOvjx9ASJ3j79izeEunNnmRUxxFuazx+mrXhEWc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=UZNWd8YSARAred/fa/MLSDj/SgK/FWf3Qo5OvzIEmcAGruna0cpdFi4MsJQaonLA1
	 gJ+Xz3fETCxZey2Rj3CGUo1JMsCgOk58FT4WmRSFIq8aeuAtTCf/uJXTS2Ad8DsYyv
	 P0CZKFCE9MYj5g8yCvU+8D2/SMyHgdd2ho4T0W9yATREQ7pCTkmpggbB0bg2Atmgux
	 3il5Rreld193n+3PC0AUs87n2xsp4DSnrUX6WC4XtkNjFBNUG4MX1q9FjI7h5toPMs
	 xLoSLfhBLIHTCDXaRUlK69dcJlp1nH2Vv8UlMke16+iKtuVbccMrnaO/LpUYm1VWBA
	 ZB5c8P3650mjg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D0D63CE0B0B; Wed,  4 Nov 2026 17:46:45 -0800 (PST)
Date: Wed, 4 Nov 2026 17:46:45 -0800
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
Message-ID: <5b0e7c55-72b1-410a-982c-a62138b9e44c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261104-bug-nvme-remove-ns-srcu-v2-0-feb64ecb96ca@gmail.com>
 <20261104-bug-nvme-remove-ns-srcu-v2-1-feb64ecb96ca@gmail.com>
 <9f8c94ff-29e3-4ea5-b9ec-b04b2bc21b1c@paulmck-laptop>
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
In-Reply-To: <9f8c94ff-29e3-4ea5-b9ec-b04b2bc21b1c@paulmck-laptop>

On Wed, Nov 04, 2026 at 09:14:13AM -0800, Paul E. McKenney wrote:
> On Wed, Nov 04, 2026 at 01:30:39AM -0500, Qiliang Yuan wrote:
> > list_splice_init_rcu() makes a list look empty to new readers, waits for
> > the current ones with the given sync function, and only then links the
> > entries into the new list. The sync function takes no argument, so it
> > can wait for RCU readers but not for the readers of an srcu_struct.
> > 
> > Passing synchronize_rcu() for a list read under SRCU still builds, but
> > leaves SRCU readers on the entries while the last one's next pointer is
> > moved onto the new list head. nvme_remove_namespaces() does this today.
> > 
> > Add list_splice_init_srcu(), which waits for the readers of the given
> > srcu_struct instead.
> > 
> > Cc: stable@vger.kernel.org
> > Suggested-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
> 
> I am not inalterably opposed to adding a list_splice_init_srcu(),
> especially if quite a few more users show up, but here is what I was
> expecting people to do:
> 
> 	static void synchronize_my_srcu(void)
> 	{
> 		synchronize_srcu(&my_srcu);
> 	}
> 
> 	...
> 
> 	list_splice_init_rcu(l, h, synchronize_my_srcu);
> 
> We need at least six uses of the above idiom to break even on the line
> of code required for introducing a list_splice_init_srcu().

Given Qiliang's response:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

							Thanx, Paul

> > ---
> >  include/linux/srcu.h | 36 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> > 
> > diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> > index 1a8a465a5650d..d4dcaeb83e2b6 100644
> > --- a/include/linux/srcu.h
> > +++ b/include/linux/srcu.h
> > @@ -18,6 +18,7 @@
> >  
> >  #include <linux/mutex.h>
> >  #include <linux/rcupdate.h>
> > +#include <linux/rculist.h>
> >  #include <linux/workqueue.h>
> >  #include <linux/rcu_segcblist.h>
> >  
> > @@ -118,6 +119,41 @@ void cleanup_srcu_struct(struct srcu_struct *ssp);
> >  void synchronize_srcu(struct srcu_struct *ssp);
> >  void synchronize_srcu_atomic(struct srcu_struct *ssp);
> >  
> > +/**
> > + * list_splice_init_srcu - splice an SRCU-protected list into an existing list
> > + * @list:	the SRCU-protected list to splice
> > + * @head:	the place in the existing list to splice the first list into
> > + * @ssp:	the srcu_struct that readers of @list use
> > + *
> > + * Like list_splice_init_rcu(), but wait for the SRCU readers of @list
> > + * instead of RCU ones, so that none of them can follow a next pointer
> > + * onto @head.
> > + *
> > + * Note that this function blocks, and that the caller must prevent any
> > + * other updates to @list.
> > + */
> > +static inline void list_splice_init_srcu(struct list_head *list,
> > +					 struct list_head *head,
> > +					 struct srcu_struct *ssp)
> > +{
> > +	struct list_head *first = list->next;
> > +	struct list_head *last = list->prev;
> > +	struct list_head *next = head->next;
> > +
> > +	if (list_empty(list))
> > +		return;
> > +
> > +	INIT_LIST_HEAD_RCU(list);
> > +	synchronize_srcu(ssp);
> > +	ASSERT_EXCLUSIVE_ACCESS(*first);
> > +	ASSERT_EXCLUSIVE_ACCESS(*last);
> > +
> > +	last->next = next;
> > +	rcu_assign_pointer(list_next_rcu(head), first);
> > +	first->prev = head;
> > +	next->prev = last;
> > +}
> > +
> >  #define SRCU_GET_STATE_COMPLETED 0x1
> >  
> >  /**
> > 
> > -- 
> > 2.43.0
> > 
