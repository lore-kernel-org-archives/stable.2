Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB55A1FBEA6;
	Wed,  2 Sep 2026 01:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788310855; cv=none; b=frs95KJrnY9d18XrUmOj/UVcCvw+sIF4KkdCOfcxyPkOhtdxQUjMe2ikCOMwb8fBvkWpH9ReTSKdhIboddObXuhSusTaJeaQzURrb102Bkj2FYNtx4AUau5mwLPCKDcFrbyUcaTwIIWPSZ5P1LSqraF1FKhKWPrgVxJLJuJC6xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788310855; c=relaxed/simple;
	bh=bmzzdbld4301f/3AgKchLwCvg38RiDFH0dyJJSvV89k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRzcihDbG8fZvv9nd+fN3+5jAO6/Yb6iwr0k0ltDeYJ1+HHcFQG6d+2XKHoCDqyIgakErttXzYqWtzlq+NXtt+aNhozaMIJtlBHmCiodLfipStoHqku+7gS5ZiuXCZ2gYAKmkEl5oNG8CkGmJ8DW9tDNZ4SEaB6v8dcu1IDjOwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pi/s9Ln3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pi/s9Ln3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2801F000E9;
	Wed,  2 Sep 2026 01:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788310853;
	bh=Lu7JmO51EukdXJvBdPRfmDly312e6LsOXdN4+gP9uho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pi/s9Ln3bAIi6J2Sc+gwxDr75CKs4MTNS3OBo/owLH5PfiOUGC6uuAvyPlw8nR7rg
	 cp6fW/qtRRw9aQpFsT8ThwH11VqZg9Bb7rSuAcsXjLAPM0NpU9jy9rPL6dB8g/1lPR
	 Snl1JtTs1bGWnYM0CNTuXmCZq5BTlixRWZPuAJNFO4nHaLpTZGhQ2qEFQkhksB+IcI
	 IhZ1diSEBEyV522pP9UsdU1NVpQXFn7wztDPMtFMY/2nvgSDDXKEpg5KQ41wHVnPGa
	 QhWdP6zoJow1pwZScnlogjvFeNYHo3vVaAyhTHJzHoSe5z1TbxYMJ8EAIVMP1tRz4O
	 Zfdqi8vICjcFA==
From: Jakub Kicinski <kuba@kernel.org>
To: zihanx@nebusec.ai
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	vega@nebusec.ai
Subject: Re: [PATCH net v6 2/2] llc: reject out-of-service state before state lookup
Date: Tue,  1 Sep 2026 18:00:52 -0700
Message-ID: <20260902010052.2297527-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <8fa3c9e6d5dcf328979ed2bdc27817c11a5eff91.1787752861.git.zihanx@nebusec.ai>
References: <8fa3c9e6d5dcf328979ed2bdc27817c11a5eff91.1787752861.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
llc: reject out-of-service state before state lookup

This adds a lower-bound check on llc->state in llc_conn_service() so that a
socket sitting in LLC_CONN_OUT_OF_SVC is rejected before llc_qualify_conn_ev()
indexes llc_conn_state_table[state - 1].  A few questions about the new
check below.

> diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
> index 885a5c33024c3..4a34f240ad2cc 100644
> --- a/net/llc/llc_conn.c
> +++ b/net/llc/llc_conn.c
> @@ -362,7 +362,8 @@ static int llc_conn_service(struct sock *sk, struct sk_buff *skb)
>  	struct llc_sock *llc = llc_sk(sk);
>  	int rc = 1;
>  
> -	if (llc->state > NBR_CONN_STATES)
> +	if (llc->state < LLC_CONN_STATE_ADM ||
> +	    llc->state > NBR_CONN_STATES)
>  		goto out;

[Severity: High]
Does this check actually protect the table access, given that the validated
value is not latched?  llc_qualify_conn_ev() re-reads llc->state twice to do
the indexing:

net/llc/llc_conn.c:llc_qualify_conn_ev() {
	struct llc_conn_state *curr_state =
					&llc_conn_state_table[llc->state - 1];
	...
	for (next_trans = curr_state->transitions +
		llc_find_offset(llc->state - 1, ev->type);
	     (*next_trans)->ev; next_trans++) {
		if (!((*next_trans)->ev)(sk, skb)) {
	...
}

The store that produces state 0 is done with no socket lock at all:

net/llc/llc_conn.c:llc_sk_free() {
	llc->state = LLC_CONN_OUT_OF_SVC;
	/* Stop all (possibly) running timers */
	llc_sk_stop_all_timers(sk, sync);
	...
}

and llc_ui_release() calls it after dropping the socket lock and before the
timers are synchronized:

net/llc/af_llc.c:llc_ui_release() {
	...
		llc_release_incoming_children(sk);
		release_sock(sk);
	...
	llc_sk_free(sk, true);
}

So can this interleaving happen for a socket closed while an ack timer is
still armed (for example a non-blocking connect() left in
LLC_CONN_STATE_SETUP, where llc_send_disc() returns early because sk_state
is not TCP_ESTABLISHED and stops nothing)?

CPU0 (softirq, ack timer)
llc_conn_ack_tmr_cb() -> llc_conn_tmr_common_cb()
	bh_lock_sock(sk);          /* excludes nothing here */
	llc_process_tmr_ev()       /* sees state 2, !sock_owned_by_user() */
	  llc_conn_state_process() -> llc_conn_service()
		reads llc->state == 2, passes the new bound check

CPU1 (close(2))
llc_ui_release() -> release_sock(sk) -> llc_sk_free()
	llc->state = LLC_CONN_OUT_OF_SVC;     /* unlocked store of 0 */

CPU0 continues into llc_qualify_conn_ev()
	&llc_conn_state_table[llc->state - 1]   /* now index -1 */
	llc_find_offset(llc->state - 1, ev->type)
	(*next_trans)->ev(sk, skb)              /* indirect call */

Since bh_lock_sock() in llc_conn_tmr_common_cb() does not exclude a writer
that holds no lock, is the negative index and the indirect call through the
pointer read from before the tables still reachable after this patch?

Would latching the value once, for example

	u8 state = READ_ONCE(llc->state);

and passing that value down to llc_qualify_conn_ev() and llc_find_offset(),
or moving the llc_sk_free() state store under the socket lock, be a better
fit for the problem described in the changelog?

>  	rc = 0;
>  	trans = llc_qualify_conn_ev(sk, skb);

[Severity: Medium]
The goto out here leaves rc at its initial value of 1, which was previously
unreachable for a state of 0.  Where does that 1 end up?

net/llc/llc_conn.c:llc_conn_state_process() {
	rc = llc_conn_service(skb->sk, skb);
	if (unlikely(rc != 0)) {
		printk(KERN_ERR "%s: llc_conn_service failed\n", __func__);
		goto out_skb_put;
	}
	...
}

net/llc/llc_if.c:llc_establish_connection() {
	...
		rc = llc_conn_state_process(sk, skb);
	}
out_put:
	sock_put(sk);
	return rc;
}

net/llc/af_llc.c:llc_ui_connect() {
	rc = llc_establish_connection(sk, llc->dev->dev_addr,
				      addr->sllc_mac, addr->sllc_sap);
	if (rc) {
		sock->state  = SS_UNCONNECTED;
		sk->sk_state = TCP_CLOSE;
		goto out;
	}
	...
out:
	release_sock(sk);
	return rc;
}

Can connect(2) then return +1 to userspace on a socket that was just reset
to SS_UNCONNECTED and TCP_CLOSE?  Callers testing for a negative return
would read that as success.

Is the printk also a concern, since it is not ratelimited and now fires once
per event for a state this patch treats as expected?

The sequence I believe reaches it on a still-hashed socket:

  1. socket(AF_LLC, SOCK_STREAM) + bind() leaves llc->state at
     LLC_CONN_STATE_ADM
  2. a failing connect() leaves state at ADM with llc->daddr set and the
     socket still in the SAP list
  3. any further frame from the peer matches the ADM catch-all transition

net/llc/llc_c_st.c:
static const struct llc_conn_state_trans llc_adm_state_trans_5 = {
	.ev	       = llc_conn_ev_rx_any_frame,
	.next_state    = LLC_CONN_OUT_OF_SVC,
	.ev_qualifiers = NONE,
	.ev_actions    = llc_adm_actions_5,
};

     which sets llc->state to 0
  4. connect(2) again (sock->state is SS_UNCONNECTED, so it is accepted)
     reaches the new reject path

Would it be more consistent to translate out-of-service into -ECONNABORTED
at the llc_if.c entry points?  llc_send_disc() already does an explicit
check:

net/llc/llc_if.c:llc_send_disc() {
	if (sk->sk_type != SOCK_STREAM || sk->sk_state != TCP_ESTABLISHED ||
	    llc_sk(sk)->state == LLC_CONN_STATE_ADM ||
	    llc_sk(sk)->state == LLC_CONN_OUT_OF_SVC)
		goto out;
	...
}

while llc_establish_connection() has no such check.  On a related note, the
kernel-doc for llc_build_and_send_pkt() still documents only 0,
-ECONNABORTED and -EBUSY, although state 0 is filtered there only
incidentally by llc_data_accept_state().

[Severity: Medium]
This isn't a bug introduced by this patch, but while looking at the callers
of llc_conn_service() there is an asymmetry in llc_backlog_rcv() worth
mentioning.  The fallback branch tests the owner socket's state and then
dispatches on it, while llc_conn_state_process() operates on skb->sk:

net/llc/llc_conn.c:llc_backlog_rcv() {
	...
	} else if (likely(llc->state > 1)) {
		rc = llc_conn_rcv(sk, skb);
	} else {
		goto out_kfree_skb;
	}
	...
}

The two branches above it take bh_lock_sock_nested(newsk) before touching a
child, this one does not.  For a listener-owned backlog skb whose skb->sk is
a child, the child's state machine runs without the child's lock, even
though llc_conn_state_process() documents that the socket lock has to be
held.

Every child reachable through this branch appears to have already been
released by llc_release_incoming_sock(), whose state store the new check now
rejects, so this looks defused for the concretely reachable case.  What
remains is the publication order in that function:

net/llc/llc_conn.c:llc_release_incoming_sock() {
	if (atomic_xchg(&llc->incoming_state, LLC_INCOMING_NONE) ==
	    LLC_INCOMING_NONE)
		return;

	WRITE_ONCE(llc->state, LLC_CONN_OUT_OF_SVC);
	...
}

Can a drainer in the fallback branch observe incoming_state as
LLC_INCOMING_NONE while still seeing the child's pre-teardown non-zero
state, and then run the child's state machine concurrently with
llc_release_incoming_sock() on another CPU?  Both fields are read there
without the child's bh lock.  Reaching the branch at all also needs the
listener's own llc->state above 1, which seems possible only through a
listen() followed by connect() on the same socket, since llc_ui_listen()
leaves sock->state at SS_UNCONNECTED and llc_ui_connect() has no TCP_LISTEN
check.  I could not confirm that all of these hold at the same time, so this
may not be reachable in practice.
-- 
pw-bot: cr
