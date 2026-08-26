Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B103B47F9;
	Wed, 26 Aug 2026 08:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787733297; cv=none; b=arrPUk3/UcrZlldBO82xGoLtvvI/hdn5KCxZZ1IHJmb7CihKt0xF1gGjiTHG5imD0XI0Vl0rLcLELeOQKrnghhP2+rz48/MIyP7ZK2/4LQB5BQ8yBDaU8CkeMRzWH952bWRJbfhiOK5E5KPd07iNHcfV25YFEMoSFMLHIAqXWQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787733297; c=relaxed/simple;
	bh=188zkap8NxO3QVQEli9SJmqfg26bUrpEIRyZoVyT+XQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpgVtKOzwU7JW44w4phZY5ehrF8OoyHlqohxv0cxMS4/+ogyDjPKgIu2bOkS/vveBqr1986Qq1YFZpcolBxrrGMQ8thI6c5JL8ZGSGMuYIv24yBZWxVtyRVwz2J4fvo3FKJQwtV8z/UjdWxQ9eEqHLsArZP+j85FNihj7UMgvTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbpVLL9L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbpVLL9L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2CF1F000E9;
	Wed, 26 Aug 2026 08:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787733295;
	bh=uTjZnGlrH3NZg77QQqjzGZVMxtqQ3eBkWXkSOUKclR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cbpVLL9LoX3fW4EIo0RQswz3JvX++OE9EFdifKe0ulo+bGdSKIgqe+BUq5ndi+fRF
	 8lLRMYJcgnal/sCy+VkWrZU7Dcmqh33FYBJFzlFEJShBkC9telw7zpsm1Fs8+o0EaY
	 NL0UIhPhappSg6nTvuSKgTpxY4A8+cbidX0uBGyKjH/dteJ7GrQyL8VJ0athZnhJjU
	 67TKcSykPgHhOKmQ5DVHRX4mj/znd+3M0rfP9KA5a2NaMf3EJEKspVTTRb+m30svNh
	 5M5ejMKo99MQeJEr0iXxsqWMzqakwQS3rog+vxnLJSjBZ06EIlRdRMdxsMnoLPMCum
	 AsIm0SNfsjGUQ==
From: Simon Horman <horms@kernel.org>
To: zihanx@nebusec.ai
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	vega@nebusec.ai
Subject: Re: [PATCH net v5 1/2] llc: fix listener child socket leaks before passive open completes
Date: Wed, 26 Aug 2026 09:34:41 +0100
Message-ID: <20260826083441.307129-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822082354.3109-2-zihanx@nebusec.ai>
References: <20260822082354.3109-2-zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260822082354.3109-2-zihanx@nebusec.ai?part=1
---
llc: fix listener child socket leaks before passive open completes

This restricts passive-open child creation to SABME commands, answers other
listener-directed commands with a directly generated DM response, and adds
an incoming_state lifecycle (PENDING/QUEUED/NONE) so that children which
never reach accept() are unhashed and torn down from a work item.

> diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
> index b0447c33dbf0..7d246d4d281b 100644
> --- a/net/llc/af_llc.c
> +++ b/net/llc/af_llc.c

[ ... ]

> @@ -722,6 +728,7 @@ static int llc_ui_accept(struct socket *sock, struct socket *newsock,
>  		goto frees;
>  	rc = 0;
>  	newsk = skb->sk;
> +	llc_accept_incoming_sock(newsk);
>  	/* attach connection to a new socket. */
>  	llc_ui_sk_init(newsock, newsk);
>  	sock_reset_flag(newsk, SOCK_ZAPPED);

[Severity: High]

llc_accept_incoming_sock() performs the QUEUED to LLC_INCOMING_NONE
transition, and the paired sock_put(llc->incoming_listener), with only the
listener's owner lock held (the lock_sock(sk) at the top of
llc_ui_accept()).

Every other transition site holds the child's slock instead:
bh_lock_sock()/bh_lock_sock_nested(newsk) in llc_conn_handler(),
local_bh_disable() plus bh_lock_sock_nested(newsk) in llc_backlog_rcv(),
and bh_lock_sock_nested(newsk) in llc_release_incoming_children().

Since those two lock sets are disjoint, can a softirq-side release win the
atomic_xchg while accept() sits between skb_dequeue() and the graft?

CPU0 (softirq) llc_conn_handler() or llc_backlog_rcv()
	bh_lock_sock_nested(newsk);
	llc_release_incoming_sock(newsk);  /* xchg -> NONE, work queued */

CPU1 (process) llc_ui_accept()
	newsk = skb->sk;
	llc_accept_incoming_sock(newsk);   /* xchg returns NONE, no fixup */
	llc_ui_sk_init(newsock, newsk);
	newsk->sk_state		= TCP_ESTABLISHED;

llc_accept_incoming_sock() returns void, so llc_ui_accept() has no way to
notice that it lost the transition, and it takes no reference on newsk and
never holds the child's lock.

llc_incoming_sock_work() only waits on lock_sock(listener), which accept()
drops on return, so the final sock_put() pair can land immediately after
newsock->sk has been published to userspace.

Would it work for llc_accept_incoming_sock() to return whether it won the
transition, taken under the child's lock, so accept() can fail instead of
grafting a socket whose teardown is already scheduled?

> diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
> index 260460d50f54..8120ecd46ace 100644
> --- a/net/llc/llc_conn.c
> +++ b/net/llc/llc_conn.c

[ ... ]

> @@ -88,6 +89,11 @@ int llc_conn_state_process(struct sock *sk, struct sk_buff *skb)
>  		 * skb->sk pointing to the newly created struct sock in
>  		 * llc_conn_handler. -acme
>  		 */
> +		if (sk != skb->sk &&
> +		    atomic_read(&llc_sk(skb->sk)->incoming_state) ==
> +		    LLC_INCOMING_PENDING)
> +			atomic_set(&llc_sk(skb->sk)->incoming_state,
> +				   LLC_INCOMING_QUEUED);
>  		skb_get(skb);
>  		skb_queue_tail(&sk->sk_receive_queue, skb);
>  		sk->sk_state_change(sk);

> @@ -765,27 +771,153 @@ static struct sock *llc_create_incoming_sock(struct sock *sk,

[ ... ]

> +static void llc_incoming_sock_work(struct work_struct *work)
> +{
> +	struct llc_sock *llc = container_of(work, struct llc_sock,
> +						    incoming_work);
> +	struct sock *sk = &llc->sk;
> +	struct sock *listener = llc->incoming_listener;
> +
> +	lock_sock(listener);
> +	lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
> +	llc_sk_free(sk, false);
> +	sock_orphan(sk);
> +	release_sock(sk);
> +	llc_sk_stop_all_timers(sk, true);
> +	release_sock(listener);
> +	dev_put(llc->dev);
> +	llc->dev = NULL;
> +	sock_put(sk);
> +	sock_put(listener);
> +}
> +
> +void llc_release_incoming_sock(struct sock *sk)
> +{
> +	struct llc_sock *llc = llc_sk(sk);
> +
> +	if (atomic_xchg(&llc->incoming_state, LLC_INCOMING_NONE) ==
> +	    LLC_INCOMING_NONE)
> +		return;
> +
> +	WRITE_ONCE(llc->state, LLC_CONN_OUT_OF_SVC);
> +	sock_hold(sk);
> +	llc_sap_remove_socket(llc->sap, sk);
> +	schedule_work(&llc->incoming_work);
> +}

[ ... ]

> @@ -813,18 +960,46 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
>  		skb->sk = sk;
>  		skb->destructor = sock_efree;
>  	}
> -	if (!sock_owned_by_user(sk))
> +	if (unlikely(llc_sk(skb->sk)->state < LLC_CONN_STATE_ADM)) {
> +		if (newsk)
> +			llc_release_incoming_sock(newsk);
> +		else if (atomic_read(&llc_sk(sk)->incoming_state) !=
> +			 LLC_INCOMING_NONE)
> +			llc_release_incoming_sock(sk);
> +		goto drop_unlock;
> +	}

[Severity: Critical]

Can this free a child that is already sitting on the listener's accept
queue?

Once llc_conn_state_process() has flipped the child to
LLC_INCOMING_QUEUED, the connection indication skb is on the listener's
sk_receive_queue holding a raw skb->sk pointer to the child;
skb_set_owner_r() takes no socket reference. This gate releases the child
found directly by established lookup whenever incoming_state is not
LLC_INCOMING_NONE, which includes QUEUED children.

A purely remote frame sequence against a listening socket reaches it:

  SABME  -> llc_create_incoming_sock() publishes the child, PENDING
         -> llc_conn_state_process() LLC_CONN_PRIM: QUEUED, skb queued
  DISC   -> __llc_lookup() selects the child, and llc_common_state_trans_4
            in net/llc/llc_c_st.c moves it from NORMAL to
            LLC_CONN_STATE_ADM
  command frame -> llc_adm_state_trans_5 sets LLC_CONN_OUT_OF_SVC
  one more frame -> this gate sees state < LLC_CONN_STATE_ADM and
            incoming_state == LLC_INCOMING_QUEUED

llc_release_incoming_sock() then drops the SAP hash reference through
llc_sap_remove_socket() and schedules llc_incoming_sock_work(), which drops
the llc_sk_free() sock_put plus the explicit sock_put, so the child is
freed. Nothing dequeues or invalidates the indication skb.

Does a later accept() then work on freed memory?

net/llc/af_llc.c:llc_ui_accept() {
	newsk = skb->sk;
	llc_accept_incoming_sock(newsk);
	llc_ui_sk_init(newsock, newsk);
	sock_reset_flag(newsk, SOCK_ZAPPED);
	newsk->sk_state		= TCP_ESTABLISHED;
	...
frees:
	kfree_skb(skb);
}

The trailing kfree_skb() also runs sock_rfree() on that sock, and listener
close in llc_release_incoming_children() reads
llc_sk(newsk)->incoming_state and takes bh_lock_sock_nested(newsk) on the
same pointer.

The QUEUED branch and the retry: block of llc_backlog_rcv() call
llc_release_incoming_sock() on an already-indicated child in the same way.

Should the release paths be limited to LLC_INCOMING_PENDING children, or
should the queued indication skb be removed from the listener's receive
queue as part of the release?

> +	if (!sock_owned_by_user(sk)) {
>  		llc_conn_rcv(sk, skb);
> -	else {
> +		if (newsk &&
> +		    atomic_read(&llc_sk(newsk)->incoming_state) ==
> +		    LLC_INCOMING_PENDING)
> +			llc_release_incoming_sock(newsk);
> +	} else {

[ ... ]

> @@ -852,12 +1027,53 @@ static int llc_backlog_rcv(struct sock *sk, struct sk_buff *skb)

[ ... ]

> +			if (sock_flag(sk, SOCK_DEAD) ||
> +			    sk->sk_state != TCP_LISTEN ||
> +			    llc_sk(newsk)->state < LLC_CONN_STATE_ADM) {
> +				llc_release_incoming_sock(newsk);
> +				bh_unlock_sock(newsk);
> +				local_bh_enable();
> +				goto out_kfree_skb;
> +			}

[ ... ]

> +		} else if (newsk &&
> +			   atomic_read(&llc_sk(newsk)->incoming_state) ==
> +			   LLC_INCOMING_QUEUED) {
> +			local_bh_disable();
> +			bh_lock_sock_nested(newsk);
> +			if (llc_sk(newsk)->state <= LLC_CONN_STATE_ADM) {
> +				llc_release_incoming_sock(newsk);
> +				bh_unlock_sock(newsk);
> +				local_bh_enable();
> +				goto out_kfree_skb;
> +			}
                                            ^^

[Severity: Medium]

Is the <= bound intended here? The PENDING branch just above and the gate
in llc_conn_handler() both use state < LLC_CONN_STATE_ADM, and the v5
changelog describes the new check as an LLC_CONN_OUT_OF_SVC lower bound.

LLC_CONN_STATE_ADM (1) is a live state with its own transition table
(llc_adm_state_transitions), and a queued child legitimately returns to it
after a remote DISC:

net/llc/llc_c_st.c
static const struct llc_conn_state_trans llc_common_state_trans_4 = {
	.ev	       = llc_conn_ev_rx_disc_cmd_pbit_set_x,
	.next_state    = LLC_CONN_STATE_ADM,

So the same frame is dispatched when it arrives on the direct path in
llc_conn_handler(), but here it is dropped and the child is destroyed via
llc_release_incoming_sock(). The retry: block below applies the same
asymmetric bound with state > LLC_CONN_STATE_ADM.

Since llc_qualify_conn_ev() indexes llc_conn_state_table[llc->state - 1],
would excluding only LLC_CONN_OUT_OF_SVC (0) be enough?

[ ... ]
