Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F843175A6B;
	Sun,  6 Sep 2026 12:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788698891; cv=none; b=TY0HAEjP1hDXZkzryx9jbbyUJJnlP2ukeHu/8nx4KTWFKRF1S99Ao62JEUfJ5ZFfgrK3NZY8ztiEEmT2cFu4PKzMxKvtxU6lhtuBHZgz7m7g6SfPKbQoQ+LVay9QnfCL2ov+ww+AhfA8RewiG/gvoRKV76T1100Vd1ZtTPJz770=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788698891; c=relaxed/simple;
	bh=qNnJ+CyVQtg7WGnmsvxEwu4McQ6tTM6/AT+Meo2m80o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KxVZVZ+sEQNUWV+Mvlndy+6Q4K8ns59x5DRKTX2NwZNXS0QuGp+huvgJIcPbeLWpG58UfVnEsUOQWpqpnuWrnSMCKl8gvGr0rPkBOJ6k/PxhZEmZkGZF77nCEXH7N1TgmbnJcCbw51uCIYrv6l+ageiQFA88H25uABrZs7Ft5BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epSBKlLV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epSBKlLV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1023E1F00A3D;
	Sun,  6 Sep 2026 12:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788698889;
	bh=qlzyjLTXVxtvE1/SR0PT+QHKFXrGJPn22HUNbELfNRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=epSBKlLVzJZteWTRO6bpFVKiGspN2pdLKBmTfe4WgtZhuAsohPucCq1AZo4IwCv57
	 ++Y8xd30xHG9W/RZcofSCa7An0BCPpVyW35784ApvyGMKGmbKqyUjuiuG/FF8v+q+b
	 8TU4fyuG/rqJIK/0gUWlQrFRMCOGF5TbxbD6vTVazh1AAm/aaMVsge5Sj7IMaafY+K
	 AtnkPpvaHw4fMs20fe6b2ZIV6KkaqK+gp9n5hOobE2K8axSZYyjL6JHVo66sD7FQgE
	 d46Z6ZIlbGrebzNd0r8lbods1MMYExPTV6hHRD3r424em7YtK78nA160fKNFvDWoyQ
	 GGu1wxxWilAxw==
From: Simon Horman <horms@kernel.org>
To: zihanx@nebusec.ai
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	vega@nebusec.ai
Subject: Re: [PATCH net v7 1/1] llc: fix listener child socket leaks before passive open completes
Date: Sun,  6 Sep 2026 13:45:04 +0100
Message-ID: <20260906124504.230137-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <0b8964c9cd294898c9657fd34c9d04cec77782eb.1788414881.git.zihanx@nebusec.ai>
References: <0b8964c9cd294898c9657fd34c9d04cec77782eb.1788414881.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/0b8964c9cd294898c9657fd34c9d04cec77782eb.1788414881.git.zihanx@nebusec.ai?part=1
---
llc: fix listener child socket leaks before passive open completes

This restricts passive-open child creation to SABME commands, answers other
listener-directed commands with a DM response generated from the packet
source address, and adds an incoming_state / incoming_children lifecycle so
children that never reach accept() are released on drop, backlog failure and
listener close.  llc_sk_free() gains a sync argument and the final child
teardown moves to a work item.

Some questions below about the new locking and reference accounting.

> diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
> index b0447c33dbf0..e8054809cf0c 100644
> --- a/net/llc/af_llc.c
> +++ b/net/llc/af_llc.c

[ ... ]

> @@ -722,6 +729,17 @@ static int llc_ui_accept(struct socket *sock, struct socket *newsock,
>  		goto frees;
>  	rc = 0;
>  	newsk = skb->sk;
> +	lock_sock_nested(newsk, SINGLE_DEPTH_NESTING);
> +	if (llc_sk(newsk)->state < LLC_CONN_STATE_ADM ||
> +	    !llc_accept_incoming_sock(newsk)) {
> +		if (atomic_read(&llc_sk(newsk)->incoming_state) !=
> +		    LLC_INCOMING_NONE)
> +			llc_release_incoming_sock(newsk);
> +		release_sock(newsk);
> +		sock_put(newsk);
> +		rc = -ECONNABORTED;
> +		goto frees;
> +	}

[Severity: High]
Can this lock_sock_nested() block on the lock_sock(sk) that llc_ui_accept()
already holds?  There is no test that skb->sk is a distinct child.

A connection indication can end up on a socket's own receive queue with
skb->sk == sk.  After bind(), llc->daddr is all zero, so a SABME whose
h_source is 00:00:00:00:00:00 and whose SSAP masks to 0 matches
llc_estab_match():

net/llc/llc_conn.c:llc_estab_match() {
	...
		llc->daddr.lsap == daddr->lsap &&
		ether_addr_equal(llc->laddr.mac, laddr->mac) &&
		ether_addr_equal(llc->daddr.mac, daddr->mac);
}

__llc_lookup_established() returns that socket, so llc_conn_handler() takes
the non-listener branch and sets skb->sk = sk.

llc_adm_state_trans_2 (action llc_conn_ac_conn_ind) then sets
ind_prim = LLC_CONN_PRIM, and llc_conn_state_process() queues the skb on
sk->sk_receive_queue with skb->sk == sk.  llc_ui_listen() does not drain
sk_receive_queue, so the socket can enter TCP_LISTEN with that skb queued.

accept() dequeues it, the !skb->sk test does not fire, newsk == sk, and
lock_sock_nested() waits in __lock_sock() for a lock this task owns.

For such an skb the conditional hold added in llc_conn_state_process() was
never taken (sk != skb->sk is false there), so is the sock_put(newsk) on the
abort path, and on the success path below, also unbalanced?

>  	/* attach connection to a new socket. */
>  	llc_ui_sk_init(newsock, newsk);
>  	sock_reset_flag(newsk, SOCK_ZAPPED);
> @@ -737,6 +755,8 @@ static int llc_ui_accept(struct socket *sock, struct socket *newsock,
>  	sk_acceptq_removed(sk);
>  	dprintk("%s: ok success on %02X, client on %02X\n", __func__,
>  		llc_sk(sk)->addr.sllc_sap, newllc->daddr.lsap);
> +	release_sock(newsk);
> +	sock_put(newsk);
>  frees:
>  	kfree_skb(skb);
>  out:

> diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
> index 260460d50f54..092625e28b3b 100644
> --- a/net/llc/llc_conn.c
> +++ b/net/llc/llc_conn.c

[ ... ]

> @@ -88,6 +89,13 @@ int llc_conn_state_process(struct sock *sk, struct sk_buff *skb)
>  		 * skb->sk pointing to the newly created struct sock in
>  		 * llc_conn_handler. -acme
>  		 */
> +		if (sk != skb->sk &&
> +		    atomic_read(&llc_sk(skb->sk)->incoming_state) ==
> +		    LLC_INCOMING_PENDING) {
> +			sock_hold(skb->sk);
> +			atomic_set(&llc_sk(skb->sk)->incoming_state,
> +				   LLC_INCOMING_QUEUED);
> +		}
>  		skb_get(skb);
>  		skb_queue_tail(&sk->sk_receive_queue, skb);
>  		sk->sk_state_change(sk);

[ ... ]

> @@ -765,27 +773,196 @@ static struct sock *llc_create_incoming_sock(struct sock *sk,

[ ... ]

> +static void llc_incoming_sock_work(struct work_struct *work)
> +{
> +	struct llc_sock *llc = container_of(work, struct llc_sock,
> +					    incoming_work);
> +	struct sock *listener = llc->incoming_listener;
> +	struct sock *sk = &llc->sk;
> +
> +	lock_sock(sk);
> +	llc_sk_stop_all_timers(sk, false);
> +	sock_orphan(sk);
> +	release_sock(sk);
> +	llc_sk_stop_all_timers(sk, true);
> +	dev_put(llc->dev);
> +	llc->dev = NULL;
> +	llc_sk_free(sk, false);
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
> +	spin_lock_bh(&llc->sap->sk_lock);
> +	list_del_init(&llc->incoming_node);
> +	spin_unlock_bh(&llc->sap->sk_lock);
> +	sock_hold(sk);
> +	llc_sap_remove_socket(llc->sap, sk);
> +	schedule_work(&llc->incoming_work);
> +}
> +
> +bool llc_accept_incoming_sock(struct sock *sk)
> +{
> +	struct llc_sock *llc = llc_sk(sk);
> +
> +	if (atomic_cmpxchg(&llc->incoming_state, LLC_INCOMING_QUEUED,
> +			   LLC_INCOMING_NONE) != LLC_INCOMING_QUEUED)
> +		return false;
> +
> +	spin_lock_bh(&llc->sap->sk_lock);
> +	list_del_init(&llc->incoming_node);
> +	spin_unlock_bh(&llc->sap->sk_lock);
> +	sock_put(llc->incoming_listener);
> +	return true;
> +}
> +
> +void llc_release_incoming_children(struct sock *sk)
> +{
> +	struct llc_sock *llc = llc_sk(sk);
> +	struct sk_buff *skb;
> +
> +	local_bh_disable();
> +	while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
> +		struct sock *newsk = skb->sk;
> +
> +		if (newsk && newsk != sk) {
> +			int incoming_state;
> +
> +			bh_lock_sock_nested(newsk);
> +			incoming_state =
> +				atomic_read(&llc_sk(newsk)->incoming_state);
> +			if (incoming_state != LLC_INCOMING_NONE) {
> +				llc_release_incoming_sock(newsk);
> +				if (incoming_state == LLC_INCOMING_QUEUED)
> +					sock_put(newsk);
> +			}
> +			bh_unlock_sock(newsk);
> +		}
> +		kfree_skb(skb);
> +	}
> +	if (llc->sap) {
> +		spin_lock(&llc->sap->sk_lock);
> +		while (!list_empty(&llc->incoming_children)) {
> +			struct llc_sock *child;
> +			struct sock *newsk;
> +
> +			child = list_first_entry(&llc->incoming_children,
> +						 struct llc_sock,
> +						 incoming_node);
> +			list_del_init(&child->incoming_node);
> +			newsk = &child->sk;
> +			sock_hold(newsk);
> +			spin_unlock(&llc->sap->sk_lock);
> +
> +			bh_lock_sock_nested(newsk);
> +			if (atomic_read(&child->incoming_state) !=
> +			    LLC_INCOMING_NONE)
> +				llc_release_incoming_sock(newsk);
> +			bh_unlock_sock(newsk);
> +			sock_put(newsk);
> +			spin_lock(&llc->sap->sk_lock);
> +		}
> +		spin_unlock(&llc->sap->sk_lock);
> +	}
> +	local_bh_enable();
> +}

[Severity: High]
The receive-queue loop above drops the accept-queue reference explicitly:

			if (incoming_state != LLC_INCOMING_NONE) {
				llc_release_incoming_sock(newsk);
				if (incoming_state == LLC_INCOMING_QUEUED)
					sock_put(newsk);
			}

The incoming_children walk releases children whose incoming_state is
!= LLC_INCOMING_NONE, which includes LLC_INCOMING_QUEUED, but the only
sock_put() there balances the walk's own sock_hold().

Counting the references of a QUEUED child: llc_release_incoming_sock() adds
one hold, and llc_incoming_sock_work() drops two (llc_sk_free()'s sock_put()
plus its own), so the hold taken in llc_conn_state_process() has to be
dropped by the caller.  Does a QUEUED child that reaches this walk leak its
struct llc_sock?

A path that gets a QUEUED child onto this walk:

llc_ui_connect() has no TCP_LISTEN guard, so the listener can be moved to
TCP_SYN_SENT/TCP_CLOSE.  llc_ui_recvmsg() only refuses sk_state ==
TCP_LISTEN, so after that it treats the pending connection indication as
stream data:

net/llc/af_llc.c:llc_ui_recvmsg() {
	...
		skb_unlink(skb, &sk->sk_receive_queue);
		kfree_skb(skb);
}

That drops only the skb reference; the child stays QUEUED on
incoming_children, and close() then reaches the walk above.

[ ... ]

> @@ -813,18 +1010,49 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
>  		skb->sk = sk;
>  		skb->destructor = sock_efree;
>  	}
> -	if (!sock_owned_by_user(sk))
> +	if (unlikely(llc_sk(skb->sk)->state < LLC_CONN_STATE_ADM)) {
> +		if (newsk) {
> +			if (atomic_read(&llc_sk(newsk)->incoming_state) ==
> +			    LLC_INCOMING_PENDING)
> +				llc_release_incoming_sock(newsk);
> +		} else if (atomic_read(&llc_sk(sk)->incoming_state) ==
> +			   LLC_INCOMING_PENDING) {
> +			llc_release_incoming_sock(sk);
> +		}
> +		goto drop_unlock;
> +	}

[Severity: Medium]
This out-of-service lower bound is not described anywhere in the commit
message body, and the v7 changelog says the work was removed from the
series:

  "Drop the companion LLC_CONN_OUT_OF_SVC bounds patch due to overlap with
   Kees Cook's net-next series"
  "That series also covers ... rejecting out-of-service states before table
   lookup"

Five copies of the check are still here though: this one in
llc_conn_handler(), three in llc_backlog_rcv(), and one in llc_ui_accept().

In the non-listener branch just above, skb->sk is the ordinary looked-up
socket, so this changes behaviour for every socket on the direct receive
path, and in llc_ui_accept() it converts an otherwise successful accept()
into -ECONNABORTED.  Should the message describe the new semantics, or
should these checks be dropped as the changelog states?

>  	if (!sock_owned_by_user(sk)) {
>  		llc_conn_rcv(sk, skb);
> -	else {
> +		if (newsk &&
> +		    atomic_read(&llc_sk(newsk)->incoming_state) ==
> +		    LLC_INCOMING_PENDING)
> +			llc_release_incoming_sock(newsk);
> +	} else {
>  		dprintk("%s: adding to backlog...\n", __func__);
>  		llc_set_backlog_type(skb, LLC_PACKET);
> -		if (sk_add_backlog(sk, skb, READ_ONCE(sk->sk_rcvbuf)))
> +		if (sk_add_backlog(sk, skb, READ_ONCE(sk->sk_rcvbuf))) {
> +			if (newsk && !newsk_lookup_ref)
> +				llc_release_incoming_sock(newsk);
>  			goto drop_unlock;
> +		}
>  	}

[ ... ]

> @@ -852,12 +1080,52 @@ static int llc_backlog_rcv(struct sock *sk, struct sk_buff *skb)
>  {
>  	int rc = 0;
>  	struct llc_sock *llc = llc_sk(sk);
> +	struct sock *newsk = skb->sk;
>  
>  	if (likely(llc_backlog_type(skb) == LLC_PACKET)) {
> -		if (likely(llc->state > 1)) /* not closed */
> +		if (newsk &&
> +		    atomic_read(&llc_sk(newsk)->incoming_state) ==
> +		    LLC_INCOMING_PENDING) {
> +			local_bh_disable();
> +			bh_lock_sock_nested(newsk);
> +			if (atomic_read(&llc_sk(newsk)->incoming_state) !=
> +			    LLC_INCOMING_PENDING) {
> +				bh_unlock_sock(newsk);
> +				local_bh_enable();
> +				goto retry;
> +			}
> +			if (sock_flag(sk, SOCK_DEAD) ||
> +			    sk->sk_state != TCP_LISTEN ||
> +			    llc_sk(newsk)->state < LLC_CONN_STATE_ADM) {
> +				llc_release_incoming_sock(newsk);
> +				bh_unlock_sock(newsk);
> +				local_bh_enable();
> +				goto out_kfree_skb;
> +			}
>  			rc = llc_conn_rcv(sk, skb);
> -		else
> +			if (atomic_read(&llc_sk(newsk)->incoming_state) ==
> +			    LLC_INCOMING_PENDING)
> +				llc_release_incoming_sock(newsk);
> +			bh_unlock_sock(newsk);
> +			local_bh_enable();
> +		} else if (newsk &&
> +			   atomic_read(&llc_sk(newsk)->incoming_state) ==
> +			   LLC_INCOMING_QUEUED) {
> +			local_bh_disable();
> +			bh_lock_sock_nested(newsk);
> +			if (llc_sk(newsk)->state < LLC_CONN_STATE_ADM) {

[Severity: Medium]
Two different "socket is usable" boundaries now live in this one function.
LLC_CONN_OUT_OF_SVC is 0 and LLC_CONN_STATE_ADM is 1, so the new checks
dispatch a socket in ADM while the legacy branch a few lines below,
llc->state > 1 /* not closed */, drops the same frame as closed.  Which
boundary is intended for a child in ADM?

The same permissive bound is reused in llc_ui_accept().  A peer DISC returns
a connected child to ADM:

net/llc/llc_c_st.c:
static const struct llc_conn_state_trans llc_common_state_trans_4 = {
	.ev	       = llc_conn_ev_rx_disc_cmd_pbit_set_x,
	.next_state    = LLC_CONN_STATE_ADM,

The LLC_DISC_PRIM handling in llc_conn_state_process() is gated on
sk_state == TCP_ESTABLISHED, which a pre-accept child is not, so the queued
indication stays in the accept queue.  accept() then passes
state >= LLC_CONN_STATE_ADM and sets newsk->sk_state = TCP_ESTABLISHED and
newsock->state = SS_CONNECTED for a connection that is already down.

Should the boundary instead be the data-capable states used by
llc_data_accept_state(), that is NORMAL/BUSY/REJ?

> +				bh_unlock_sock(newsk);
> +				local_bh_enable();
> +				goto out_kfree_skb;
> +			}
> +			rc = llc_conn_rcv(newsk, skb);

[Severity: Medium]
Here sk and skb->sk are both the unaccepted child, but the LLC_CONN_PRIM
branch of llc_conn_state_process() assumes sk is the listener owning the
accept queue and skb->sk is the child, which is what the new
sk != skb->sk bookkeeping encodes.

With three frames queued on the listener backlog while the listener is
user-owned:

  f1 SABME -> PENDING branch -> LLC_CONN_PRIM -> child becomes QUEUED
  f2 DISC   -> QUEUED branch  -> child returns to LLC_CONN_STATE_ADM
  f3 SABME  -> QUEUED branch  -> llc_conn_rcv(child, f3)

For f3, llc_adm_state_trans_2 / llc_conn_ac_conn_ind sets
ind_prim = LLC_CONN_PRIM, and since sk == skb->sk the indication is queued
on the child's own sk_receive_queue with no sock_hold() and no state
transition.

Does that lose the indication for accept(), and leave a raw SABME frame on
the child's receive queue where llc_ui_recvmsg() would later hand its bytes
to userspace as stream data?

> +			bh_unlock_sock(newsk);
> +			local_bh_enable();
> +		} else if (likely(llc->state > 1)) {
> +			rc = llc_conn_rcv(sk, skb);

[Severity: High]
This fallback branch checks the listener's llc->state, but llc_conn_rcv()
runs the state machine on skb->sk, which can be a child that has already
been put out of service:

net/llc/llc_conn.c:llc_release_incoming_sock() {
	WRITE_ONCE(llc->state, LLC_CONN_OUT_OF_SVC);
	...
	schedule_work(&llc->incoming_work);
}

After that the child's incoming_state is LLC_INCOMING_NONE, so neither new
branch above matches and its backlogged skbs land here, with no child lock
held.  llc_ui_release() releases the children before the backlog is drained:

net/llc/af_llc.c:llc_ui_release() {
		llc_sap_remove_socket(llc->sap, sk);
		llc_release_incoming_children(sk);
		release_sock(sk);
}

llc_conn_service() only rejects llc->state > NBR_CONN_STATES, so state 0
reaches:

net/llc/llc_conn.c:llc_qualify_conn_ev() {
	struct llc_conn_state *curr_state =
					&llc_conn_state_table[llc->state - 1];

Can this index llc_conn_state_table[] and llc_offset_table[][] at -1 and
then dereference the resulting curr_state->transitions?

Reaching this branch needs the listener's own llc->state to be > 1, which a
bound socket that received a matching SABME before listen() satisfies, since
llc_ui_listen() does not reset llc->state.

Separately, is running llc_conn_rcv() on that child safe against
llc_incoming_sock_work(), which concurrently does sock_orphan(),
dev_put(llc->dev), llc->dev = NULL and llc_sk_free(sk, false) with no
serialization against this path?

> +		} else {
>  			goto out_kfree_skb;
> +		}
>  	} else if (llc_backlog_type(skb) == LLC_EVENT) {
>  		/* timer expiration event */
>  		if (likely(llc->state > 1))  /* not closed */

[ ... ]
