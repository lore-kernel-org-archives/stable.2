Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793812453;
	b=u3c/bVjgRqtUIN1+cCvFXUPWlrWwhyinlyzESGK/qID0TM36rYDpLRTFvlzTWbWJ5i24
	 7tavyyt6HZ9EPbQSIwLjFuzMs/N7CLhgFOUoLoWHiwkGl5vu+NA1FM8giW2fWc2ipcTXo
	 YFOZCk2dgjGPjwpGsDLYQ5JgzXWaON63lbETPsZe03ZSlqXFnnNcspopejdLsQAQDqyVh
	 OzdbIGG5JJK4m8IeB3UZ22Ab28QXt5tC7F8a5SAu8bDSYQBBkHFZ/SFFZgvmKf9xXVZKt
	 B5Qoecaj7TqfPbnjvd1mT9/iIAwRLBibds5b9fwyyxZXriX4hnw5cCPHwe9HP2VH/Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793812453;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=UoFgbUFr390e5Xu0VCDxVTfIqMC+VP5cBukPS2Qt+oc=;
	b=B7+W5dh7dXdCGVIXW3/w99iKV1nQjJUL0rLw4XLikGA07zhmnmR7dbiXNHBBQavQXdSc
	 bILdlRpWOwDtGvUwFKsu/czAyZjTTw0Oodl+SmHW0zL+I+scr2bXG6+NBHuflxjWLFvBo
	 RsF9LusNEUcEtuIRHfeQF+QCSc1hDm5cqnWCMsDukkrAjUJIEf9wHuIzm2syCyyFPzwPR
	 Kah9GIr0yGRYZvn/a184PGPwH4x1Vqi/170Wd8OkszPzCAgl0KNMGJloSxpvOlrgg6a74
	 V1jcVGMxIum5TlcFgSQKO3TEh96O5Q95IBvf2SIlZlnUQLVCpuRbU5/774AP6NsHPrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oQh2M+72;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D653606A31B;
	Wed,  4 Nov 2026 17:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oQh2M+72
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499331F0093A;
	Wed,  4 Nov 2026 17:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793812453;
	bh=UoFgbUFr390e5Xu0VCDxVTfIqMC+VP5cBukPS2Qt+oc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=oQh2M+72G011a64t1DPXJOY1n2qjCueRpbSlNGk381Yw80jocTqJFuwhNo1od1Hpr
	 aAt3mHZXGj4EKpHai9EZCvyS1ifQtjXR9gXvNouxi4xF/T5ASBDOJjXIQ1tGjNp27f
	 zaLEEK2T/X9tvVigRBPwxf43vVqmrwHICQN+k7PMan+PuA/4/wCv+E7rZQjmDpMnYA
	 kvjlwA6h90nrEIuZW/nIYZoIFY09sT7SfbJKXqqaA0Vh+sBwY5vnwyAluPB3VLIQ83
	 1+eMz/zGaa77SNGlqVVv0xnlsUDbag2kLBgrphuLaNfW0r3CUAjqydvCTxH3DJfDHn
	 2PAeDwDzVrO2g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 03788CE091F; Wed,  4 Nov 2026 09:14:13 -0800 (PST)
Date: Wed, 4 Nov 2026 09:14:12 -0800
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
Message-ID: <9f8c94ff-29e3-4ea5-b9ec-b04b2bc21b1c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261104-bug-nvme-remove-ns-srcu-v2-0-feb64ecb96ca@gmail.com>
 <20261104-bug-nvme-remove-ns-srcu-v2-1-feb64ecb96ca@gmail.com>
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
In-Reply-To: <20261104-bug-nvme-remove-ns-srcu-v2-1-feb64ecb96ca@gmail.com>

On Wed, Nov 04, 2026 at 01:30:39AM -0500, Qiliang Yuan wrote:
> list_splice_init_rcu() makes a list look empty to new readers, waits for
> the current ones with the given sync function, and only then links the
> entries into the new list. The sync function takes no argument, so it
> can wait for RCU readers but not for the readers of an srcu_struct.
> 
> Passing synchronize_rcu() for a list read under SRCU still builds, but
> leaves SRCU readers on the entries while the last one's next pointer is
> moved onto the new list head. nvme_remove_namespaces() does this today.
> 
> Add list_splice_init_srcu(), which waits for the readers of the given
> srcu_struct instead.
> 
> Cc: stable@vger.kernel.org
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>

I am not inalterably opposed to adding a list_splice_init_srcu(),
especially if quite a few more users show up, but here is what I was
expecting people to do:

	static void synchronize_my_srcu(void)
	{
		synchronize_srcu(&my_srcu);
	}

	...

	list_splice_init_rcu(l, h, synchronize_my_srcu);

We need at least six uses of the above idiom to break even on the line
of code required for introducing a list_splice_init_srcu().

							Thanx, Paul

> ---
>  include/linux/srcu.h | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index 1a8a465a5650d..d4dcaeb83e2b6 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -18,6 +18,7 @@
>  
>  #include <linux/mutex.h>
>  #include <linux/rcupdate.h>
> +#include <linux/rculist.h>
>  #include <linux/workqueue.h>
>  #include <linux/rcu_segcblist.h>
>  
> @@ -118,6 +119,41 @@ void cleanup_srcu_struct(struct srcu_struct *ssp);
>  void synchronize_srcu(struct srcu_struct *ssp);
>  void synchronize_srcu_atomic(struct srcu_struct *ssp);
>  
> +/**
> + * list_splice_init_srcu - splice an SRCU-protected list into an existing list
> + * @list:	the SRCU-protected list to splice
> + * @head:	the place in the existing list to splice the first list into
> + * @ssp:	the srcu_struct that readers of @list use
> + *
> + * Like list_splice_init_rcu(), but wait for the SRCU readers of @list
> + * instead of RCU ones, so that none of them can follow a next pointer
> + * onto @head.
> + *
> + * Note that this function blocks, and that the caller must prevent any
> + * other updates to @list.
> + */
> +static inline void list_splice_init_srcu(struct list_head *list,
> +					 struct list_head *head,
> +					 struct srcu_struct *ssp)
> +{
> +	struct list_head *first = list->next;
> +	struct list_head *last = list->prev;
> +	struct list_head *next = head->next;
> +
> +	if (list_empty(list))
> +		return;
> +
> +	INIT_LIST_HEAD_RCU(list);
> +	synchronize_srcu(ssp);
> +	ASSERT_EXCLUSIVE_ACCESS(*first);
> +	ASSERT_EXCLUSIVE_ACCESS(*last);
> +
> +	last->next = next;
> +	rcu_assign_pointer(list_next_rcu(head), first);
> +	first->prev = head;
> +	next->prev = last;
> +}
> +
>  #define SRCU_GET_STATE_COMPLETED 0x1
>  
>  /**
> 
> -- 
> 2.43.0
> 
