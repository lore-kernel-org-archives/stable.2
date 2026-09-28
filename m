Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76237449B33;
	Mon, 28 Sep 2026 09:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790589058; cv=none; b=pT9iV9z3zJewS0vVRWzzk/XQ3u4CnZX818C5PfUTy1zWDMmRYeGd5eaMdH3mDg202Mv09aCOBSYXxpl/M8U80IHTa0mzfHk1Uh+Ts3qM3uoz06VsTcLVUFx13Hz50ZdHTjNQQrEwCtdgJOoUjrBiwX/vOqCtrE0oatGrIeebCqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790589058; c=relaxed/simple;
	bh=tRjGfk5sAIV4MixjfBHinItrtx5gyKrzkW9vkMZnI1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l/KnkZRjVCS/10OUkHj5Pdbvx58EMovfiLzbqpZHh9yYcuy8ldL5eNAdKcAeUk5/+a51H71d2ndEGNEHs5J6mbCAstNhYsvSxbGp6JvMmv1COAvLEyEZKaeVd7U3jetQkcrcB7TDE5E4LuiCi2lXYn95GpfoUQOO+Bs4DZ05qtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPCsBlXy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPCsBlXy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58AC71F000FF;
	Mon, 28 Sep 2026 09:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790589057;
	bh=OikbOdOfQc9uSsZ38pWP0YMhgGOHi8+L5MsE0jBLjuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jPCsBlXyFBndZaVTJAFYjb+YcgnWBBfNGGyCtMH33fhQpiTUJe6xDIuzV3os9l7aL
	 KcYlqtN2bskaLydeMeWD98qUnnoKlJzWSnb4U4yUxcZRMIfceRe5EWEarX6utaAdD7
	 58f/74JZm+POcGAZrDVMzZOird0AxsZ1at70+KEzKuwTzAe2QvYGH4LLsZb02rNbEw
	 +hztTmST38yINrcbnG6VJh93nqgueYhJ3E2bRorw7JUf2OL5T0us01dPRIpEnVDd1O
	 AK5FlUJ+4DtNOadG/0OC6MKHMhNpBKNmL1Q7cFxKaPzWgW1dmbC2WUvRSv08JYr45s
	 dZsCDmiDQp4yw==
From: Simon Horman <horms@kernel.org>
To: zihanx@nebusec.ai
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	root@tr0jan.top
Subject: Re: [PATCH net v12 1/1] llc: fix listener child socket leaks
Date: Mon, 28 Sep 2026 10:49:44 +0100
Message-ID: <20260928094944.815915-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2af9949fc349d17b53db432893abb4d2e97932ce.1790255682.git.zihanx@nebusec.ai>
References: <2af9949fc349d17b53db432893abb4d2e97932ce.1790255682.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email says "I'm forwarding this as it looks legit and the forwarding
bot trigger seems to have timed out."
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/2af9949fc349d17b53db432893abb4d2e97932ce.1790255682.git.zihanx@nebusec.ai?part=1
---
llc: fix listener child socket leaks

This patch reworks LLC listener passive-open handling. Child sockets
created on SABME are now freed when setup fails or when the connection
indication is dropped before accept(). Only SABME creates children, the
listener sends DM responses for other commands, pending indications count
against the accept backlog, and skb->dev is held for packets deferred to
the socket backlog.

> diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
> index 260460d50f54c..77044720f12ff 100644
> --- a/net/llc/llc_conn.c
> +++ b/net/llc/llc_conn.c

[ ... ]

> @@ -90,6 +91,8 @@ int llc_conn_state_process(struct sock *sk, struct sk_buff *skb)
>  		 */
>  		skb_get(skb);
>  		skb_queue_tail(&sk->sk_receive_queue, skb);
> +		if (sk->sk_state == TCP_LISTEN)
> +			sk_acceptq_added(sk);
>  		sk->sk_state_change(sk);
>  		break;

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. It is
in the same area the commit message describes, though. Can a remote peer
grow an unaccepted child's sk_receive_queue without bound here?

The child stays hashed while its indication waits in the listener's
queue. Suppose the peer sends DISC, which moves the child from NORMAL back
to ADM, and then sends SABME again. llc_conn_handler() finds the child
and takes the non-listener branch:

    skb_orphan(skb);
    sock_hold(sk);
    skb->sk = sk;
    skb->destructor = sock_efree;

llc_conn_rcv(child) then handles ADM + SABME, which issues another
connection indication. This case queues it on the child's own
sk_receive_queue with no rmem or sk_rcvbuf check. The child is not
TCP_LISTEN, so sk_acceptq_added() does not apply either. Each queued skb
also holds a reference on the child.

The new sk_acceptq_is_full() check in llc_conn_rcv_sabme() limits how
many children are created. It does not limit how many indications build
up on one child, and that memory stays pinned until the application
accepts or closes the listener.

[ ... ]

> @@ -765,14 +768,124 @@ static struct sock *llc_create_incoming_sock(struct sock *sk,

[ ... ]

> +static int llc_conn_rcv_sabme(struct sock *sk, struct sk_buff *skb,
> +			      struct llc_addr *saddr,
> +			      struct llc_addr *daddr)
> +{
> +	struct sock *newsk;
> +	int rc;
> +
> +	if (sk_acceptq_is_full(sk))
> +		goto drop;

[Severity: Medium]
Can sk_ack_backlog underflow, so that this check drops every SABME from
then on?

The counter only goes up in llc_conn_state_process() when sk_state is
TCP_LISTEN at queue time. Other code resets it without looking at what is
still queued:

net/llc/af_llc.c:llc_ui_listen() {
    ...
    if (sk->sk_state != TCP_LISTEN) {
        sk->sk_ack_backlog = 0;
        sk->sk_state       = TCP_LISTEN;
    }
    ...
}

llc_ui_connect() only rejects SS_CONNECTING. A listener with indications
still in sk_receive_queue can therefore call connect(), and a DM or
timeout then leaves it in TCP_CLOSE / SS_UNCONNECTED.

A second listen() resets sk_ack_backlog to 0 while the old indications
are still queued. Each accept() of one of those indications then calls
sk_acceptq_removed() unconditionally in llc_ui_accept().

The u32 counter wraps to 0xFFFFFFFF and sk_acceptq_is_full() stays true.
Later listen() calls do not reset the counter because sk_state is already
TCP_LISTEN. Is every new SABME then silently dropped here?

> +
> +	local_bh_disable();
> +	newsk = llc_create_incoming_sock(sk, skb->dev, saddr, daddr);

[ ... ]

> @@ -786,6 +899,10 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
>  		goto drop;
>  
>  	bh_lock_sock(sk);
> +	if (unlikely(llc_sk_unhashed(sk)))
> +		goto drop_unlock;
> +	if (unlikely(llc_sk(sk)->state == LLC_CONN_OUT_OF_SVC))
> +		goto drop_unlock;
>  	/*
>  	 * This has to be done here and not at the upper layer ->accept
>  	 * method because of the way the PROCOM state machine works:

[Severity: Low]
This isn't a bug, but two comments still say the child is created in
llc_conn_handler(): this one, and the one in the LLC_CONN_PRIM case of
llc_conn_state_process() ("the newly created struct sock in
llc_conn_handler").

After this patch the child is only created in llc_conn_rcv_sabme(). When
the listener is owned by the user, that happens later from
llc_backlog_rcv(). Should both comments be updated?

> @@ -795,11 +912,14 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
>  	 * in the newly created struct sock private area. -acme
>  	 */
>  	if (unlikely(sk->sk_state == TCP_LISTEN)) {
> -		struct sock *newsk = llc_create_incoming_sock(sk, skb->dev,
> -							      &saddr, &daddr);
> -		if (!newsk)
> +		if (llc_conn_ev_rx_sabme_cmd_pbit_set_x(sk, skb)) {
> +			llc_listener_send_dm(sap, sk, skb, &saddr);
>  			goto drop_unlock;
> -		skb_set_owner_r(skb, newsk);
> +		}
> +		if (!sock_owned_by_user(sk)) {
> +			llc_conn_rcv_sabme(sk, skb, &saddr, &daddr);
> +			goto out;
> +		}
>  	} else {
>  		/*
>  		 * Can't be skb_set_owner_r, this will be done at the
> @@ -813,13 +933,16 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
>  		skb->sk = sk;
>  		skb->destructor = sock_efree;
>  	}
> -	if (!sock_owned_by_user(sk))
> -		llc_conn_rcv(sk, skb);
> -	else {
> +	if (sock_owned_by_user(sk)) {
>  		dprintk("%s: adding to backlog...\n", __func__);
>  		llc_set_backlog_type(skb, LLC_PACKET);
> +		/* The backlog can outlive the RCU protection of skb->dev. */
> +		backlog_dev = skb->dev;
> +		netdev_hold(backlog_dev, NULL, GFP_ATOMIC);
>  		if (sk_add_backlog(sk, skb, READ_ONCE(sk->sk_rcvbuf)))
>  			goto drop_unlock;

[Severity: Critical]
Can a listener SABME get into the backlog here with a foreign skb->sk
still attached?

Before this patch, the TCP_LISTEN branch always called
skb_set_owner_r(skb, newsk), and that orphans the skb first.

Now, when the listener is owned by the user, the SABME skips both
skb_set_owner_r() and the skb_orphan() in the else branch. It goes
straight to sk_add_backlog().

llc_rcv() only calls skb_share_check(). A frame sent locally over veth
from an AF_PACKET or AF_LLC socket can therefore still carry the sender's
skb->sk and its sock_wfree destructor.

If the listener leaves TCP_LISTEN before the backlog drains,
llc_backlog_rcv() takes the non-listener branch:

    } else if (unlikely(llc->state <= 1 || !skb->sk)) {
        goto out_kfree_skb;
    }
    rc = llc_conn_rcv(sk, skb);

The !skb->sk test is supposed to drop these ownerless deferred SABMEs,
but the foreign skb->sk gets past it. llc_conn_state_process() then runs
the state machine on llc_sk(skb->sk), which is the sender's socket. This
path holds no reference on that socket, and it may not be an LLC socket
at all.

One way to leave TCP_LISTEN while the lock is owned is llc_ui_connect().
It does not reject listeners and it sets sk_state = TCP_SYN_SENT. At that
point llc->state is SETUP, which is greater than 1. The backlog is then
drained in llc_ui_wait_for_conn() or in release_sock().

Should the skb be orphaned before it is backlogged in the listener case?

[ ... ]

> @@ -852,12 +976,33 @@ static int llc_backlog_rcv(struct sock *sk, struct sk_buff *skb)
>  {
>  	int rc = 0;
>  	struct llc_sock *llc = llc_sk(sk);
> +	struct net_device *dev = NULL;
>  
>  	if (likely(llc_backlog_type(skb) == LLC_PACKET)) {
> -		if (likely(llc->state > 1)) /* not closed */
> -			rc = llc_conn_rcv(sk, skb);
> -		else
> +		/* Drop the reference acquired before the skb entered the backlog. */
> +		dev = skb->dev;
> +		if (unlikely(sk->sk_state == TCP_LISTEN)) {

[ ... ]

> +			llc_pdu_decode_sa(skb, saddr.mac);
> +			llc_pdu_decode_ssap(skb, &saddr.lsap);
> +			llc_pdu_decode_da(skb, daddr.mac);
> +			llc_pdu_decode_dsap(skb, &daddr.lsap);
> +			rc = llc_conn_rcv_sabme(sk, skb, &saddr, &daddr);

[Severity: Medium]
Could this create two children for the same tuple?

While the listener is owned, llc_conn_handler() backlogs SABMEs without
creating a child. A retransmitted or duplicate SABME from the same peer
can arrive before release_sock(). It finds no child in __llc_lookup(),
resolves to the listener, and is backlogged as well.

When the backlog drains, each SABME reaches llc_conn_rcv_sabme(). That
function only checks sk_acceptq_is_full() before
llc_create_incoming_sock() hashes a new child. The established tuple is
not looked up again.

Both children reach NORMAL, send UA and queue an accept indication.
sk_nulls_add_node_rcu() adds at the head, so only the newest child gets
traffic.

The older child is still accepted by userspace but never receives frames.
Its sends, and its DISC on close, use the same tuple as the peer's single
connection.

Before this patch, getting here needed two CPUs racing on the listener
slock. With this patch, hitting the owned-listener window at all seems to
be enough.

> +			goto out;
> +		} else if (unlikely(llc->state <= 1 || !skb->sk)) {
>  			goto out_kfree_skb;
> +		}
> +		rc = llc_conn_rcv(sk, skb);

[ ... ]
