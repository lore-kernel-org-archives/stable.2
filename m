Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F76342151;
	Fri, 18 Sep 2026 22:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789771324; cv=none; b=ECnZszieKCoxkdm9IewhR50mp46y9s8cvUQYv4jNBO0kC7Qd92JgbAJ9YW++Fsbvgg86Yg7bu8djHzO69prwKp9TmW07DakfnOPq/ALCSwwpog6zJI9F+xx27T6Wr0ChavRJa9PlMpTCoeTX8zn6ufqWEOXdYQN78kyB9D1s06o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789771324; c=relaxed/simple;
	bh=taCVkokG397AHsKxj5bIJQHNAKNa5uUfnZgdmW+2t0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7hW4t4yDs3A3mMRPCK81iXwhN3SVWFi8iVk2Sjwhkm/VzUzglO+fH4IzBMkNela82Az7cX6k0yxELTlWSPTkhBnk4NmwItTfdLRjyiJdaI9sf6mJ6bJzmUSWwolpJYC+zNNTgXhq4pEH/C9NeNXr0lGawl2IC6I/lo2BaBy8QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ia7f2PMi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ia7f2PMi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B921F000FF;
	Fri, 18 Sep 2026 22:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789771322;
	bh=0cEgZDm8Gk5ya1kpYbJTgrx2aGdPyej22ceVS6IllCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ia7f2PMiJrGX6c5uGaYTFfjOhb9XEB+TkzwJKAxkkXT3qxcbyHkmRuRTdgEfz/QAx
	 GkZYXiRnY5dvF0dfTXGME2gjOLDsO7z7UnXL4iPxk376ZUObDVFPOGvFehy73DOdzr
	 Ec7se3RetgVXixuNPfkpOSSPRBGhilJtCP2/VCoI7APFCKnZu2QPK6+EEQgxuHxuz+
	 DtU8KVMFYnXCUYCXgh9dVUmITV6RHA+MWv8iKl+Gk5DJhMvpVGZLnXnxxNtZTMcLwm
	 AfMGAP+Cr3fmjNUEOe/ztzeZgZU0g2cZ88EFgo4LPI8R/gpMvID1r2PpDmVKrvvhwX
	 RkRjpieFohLoA==
From: Jakub Kicinski <kuba@kernel.org>
To: zihanx@nebusec.ai
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	root@tr0jan.top
Subject: Re: [PATCH net v9 1/1] llc: fix listener child socket leak on non-SABME frames
Date: Fri, 18 Sep 2026 15:42:00 -0700
Message-ID: <20260918224200.16334-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <5d2eb4eae5248b37f14ae713a9c0ad1c6f1fedd3.1789216793.git.zihanx@nebusec.ai>
References: <5d2eb4eae5248b37f14ae713a9c0ad1c6f1fedd3.1789216793.git.zihanx@nebusec.ai>
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
llc: fix listener child socket leak on non-SABME frames

This restricts llc_conn_handler() to creating a passive-open child socket
only for SABME commands, answers DISC and other P=1 commands with a DM
response built from the address decoded out of the received frame, and
drops the remaining non-SABME frames without running them through the
listener's ADM state machine.

> diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
> index 260460d50f54c..4c2ca6b842516 100644
> --- a/net/llc/llc_conn.c
> +++ b/net/llc/llc_conn.c

[ ... ]

> @@ -795,11 +825,26 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
>  	 * in the newly created struct sock private area. -acme
>  	 */
>  	if (unlikely(sk->sk_state == TCP_LISTEN)) {
> -		struct sock *newsk = llc_create_incoming_sock(sk, skb->dev,
> -							      &saddr, &daddr);
> -		if (!newsk)
> +		struct sock *newsk;
> +
> +		if (!llc_conn_ev_rx_sabme_cmd_pbit_set_x(sk, skb)) {
> +			newsk = llc_create_incoming_sock(sk, skb->dev, &saddr,
> +							 &daddr);
> +			if (!newsk)
> +				goto drop_unlock;
> +			skb_set_owner_r(skb, newsk);

[Severity: High]

Does the retained SABME path still leak the child struct sock and the
device reference that the changelog describes?

llc_create_incoming_sock() publishes the child and pins the device before
anything has decided the child will ever be handed to accept():

net/llc/llc_conn.c:llc_create_incoming_sock() {
	newllc->dev = dev;
	dev_hold(dev);
	llc_sap_add_socket(llc->sap, newsk);
}

llc_sap_add_socket() also takes llc_sap_hold() and bumps sap->sk_count, so
each unaccepted child holds a struct sock, a SAP reference and a netdev
reference.

There appear to be three paths where none of that is undone.

First, closing the listener.  llc_ui_release() removes only the listener
from the SAP and netdev_put()s only the listener's device, then calls
llc_sk_free(), which only purges the queues:

net/llc/llc_conn.c:llc_sk_free() {
	skb_queue_purge(&sk->sk_receive_queue);
	skb_queue_purge(&sk->sk_write_queue);
	skb_queue_purge(&llc->pdu_unack_q);
}

skb_set_owner_r(skb, newsk) above takes no socket reference, so purging the
listener's receive queue only runs sock_rfree() on the queued indication.
Doesn't the child then stay in the SAP hash with its refcount and its
dev_hold() forever, which is the same leftover /proc/net/llc/socket state
the changelog cites?

Second, the backlog path in this same function.  Once skb_set_owner_r() has
run, the child is already published, and:

	if (sk_add_backlog(sk, skb, READ_ONCE(sk->sk_rcvbuf)))
		goto drop_unlock;

drop_unlock only does kfree_skb() plus sock_put() on the listener.  Should
the freshly published child be unhashed and released here as well?

Third, llc_conn_state_process() bails out before the only handoff to
accept() if the state machine fails:

net/llc/llc_conn.c:llc_conn_state_process() {
	rc = llc_conn_service(skb->sk, skb);
	if (unlikely(rc != 0)) {
		printk(KERN_ERR "%s: llc_conn_service failed\n", __func__);
		goto out_skb_put;
	}

That skips the LLC_CONN_PRIM case that queues the indication on the
listener, and llc_conn_ac_send_ua_rsp_f_set_p() can return -ENOBUFS under
memory pressure, which is exactly the condition a flood creates.  Is the
child reclaimed on that path?

Related question on admission control: is there anything bounding how many
children a flood can create?  llc_ui_listen() stores the limit:

net/llc/af_llc.c:llc_ui_listen() {
	sk->sk_max_ack_backlog = backlog;

but the receive path never consults sk_max_ack_backlog and there is no
sk_acceptq_added() anywhere in net/llc.  The indication skb is charged to
the child by skb_set_owner_r(), not to the listener, so the listener's
sk_rcvbuf does not bound it either.

Given the above, could the following changelog statements be revisited?

    Repeating such frames, for example DISC commands with distinct source
    addresses, can leak struct sock objects and device references and
    eventually exhaust memory.

    The existing SABME child lifecycle is unchanged; this patch addresses
    only the non-SABME path.

If an L2-adjacent sender emits SABME commands rather than DISC commands,
with distinct source MAC/SSAP tuples, doesn't the same unbounded
accumulation of children, queued indications and pinned netdev references
remain reachable, including the pinned device making unregister_netdevice()
wait?  Would a fix that gives the child an owner and a teardown path (a
listener child list, or release-on-drop) plus an accept-queue bound be
needed to close the exhaustion the changelog and the Cc: stable tag refer
to, rather than filtering on frame type alone?

> +		} else {
> +			/* Not a passive-open request. */
> +			if (!llc_conn_ev_rx_disc_cmd_pbit_set_x(sk, skb)) {
> +				u8 f_bit;
> +
> +				llc_pdu_decode_pf_bit(skb, &f_bit);
> +				llc_listener_send_dm(sap, skb, &saddr, f_bit);
> +			} else if (!llc_conn_ev_rx_xxx_cmd_pbit_set_1(sk, skb)) {
> +				llc_listener_send_dm(sap, skb, &saddr, 1);
> +			}
>  			goto drop_unlock;
> -		skb_set_owner_r(skb, newsk);
> +		}
>  	} else {

[ ... ]
