Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793767806;
	b=VljA0dYakcZstHlHJhzFVq0GDYU72WmQsY4FhyKWhsozDAb5TTe/ikR6y8Hn+LP1+x+6
	 2yMkj1NbLnsVeU8ptKBK9Gc6PaUdQGT2+Q1LO9hCMhXQ427tcQVSEz4t3FbzowXynU+Iv
	 yAJN5gkxL5naVEwPuTDdZhLs3OmcKmNBcDCpQkbTT1x0dyTk747ZiwE8EE8ddYtTJpVZe
	 o6QHsm3uEQi5LfEBTKoyd4+4SnPgr65QDTZIausVXmlOLawvLwrRS20sWeTg7v4jzy1SG
	 FcZo3Hj/DXRRIhaSRnj6dyA/lIKnRJzqmPUsmMP0HATeThSjq0jy7IW4AKr6Lxyi9XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793767806;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=cYCBtrpsadv1X4LpLfFu8iV6ymVYbe6naxr0OqIypqg=;
	b=aKzwinOK9gmmrME94hl3tsIa/vf2gTu7zeFb1lP0G1ZAlyfAQHkeDFsPobP9UXol/YRh
	 lDW+ajfBayUWvIljfg+VH7d/Jg8iehycu7SkZMDMvjdo6cELXf2L9w57rCBVLyqwarBbz
	 wu2mQbk3jAcBgiZAI3cLwla0O2rJrvm1O8sgefBc+7MEUcfPkIHkPTax8wyyTxA+0NtBm
	 RWoZJfvqJHF1DjwTiGKjk6DsnN0u4GZOPY18YrOxOCd6LJoq8U8BpS8w65HwLE4mfuXoj
	 dp8Srcp4m+YE8ILAvYXPtybmUIxNRN0qpCUAdeEk+H0XHU6mlY7Gd/02rRdLKTM7fiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Slor8FcR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8871606A31B;
	Wed,  4 Nov 2026 04:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Slor8FcR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2B11F000C1;
	Wed,  4 Nov 2026 04:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793767805;
	bh=cYCBtrpsadv1X4LpLfFu8iV6ymVYbe6naxr0OqIypqg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Slor8FcRelckcsWTqbAkOY0SQRf10f9ntedx6g4R/y7rH9b6Gnvy7ejuNO1bgcxbb
	 +KbNg/jNhvrio1ocXTOz1FJ3A77tZIU0HZ51rc3IWju1YtWnvSAHIC91u4ix2zyv+N
	 6l7IqXZIUFI2dOTJOqGOS3WAci0GA/5Dr7y/LVaNbEGaCglkPaKiAki0hxGr7Qvi1N
	 cfMc/jmC6Fo1ykdXLfUI3+tDzhKbMGyUnAJHsW0n0O/BCZsMzz6Bd+5Q+lV1pRwSmg
	 q8RAb6O/idQo1pH/r5z3cUUJbVpezEGmzjPcb5ROXw6TH8YogdIVqSD71fNJUcPWjp
	 QDsgK9/BwW2Ng==
Subject: Re: [PATCH net] can: j1939: fix skb refcount underflow in session
 teardown paths
From: netdev-bot+sashiko@kernel.org
To: tristmd@gmail.com
Cc: robin@protonic.nl, o.rempel@pengutronix.de, socketcan@hartkopp.net,
 mkl@pengutronix.de, kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 tristan@talencesecurity.com, kuba@kernel.org
Date: Wed, 04 Nov 2026 04:50:04 +0000
Message-ID: <179376780412.488853.11738408007557929503@kernel.org>
In-Reply-To: <20261102155345.1267524-1-tristan@talencesecurity.com>
References: <20261102155345.1267524-1-tristan@talencesecurity.com>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 1 · High: 0 (1) · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] The patch fixes a bug that does not exist, and in doing so
  brings back the skb leak that 8c21c54a53ab fixed.
- [Medium] The commit message says the existing skb_unref() + kfree_skb()
  sequence causes 'a refcount underflow warning on every session…
- [Low] The commit author is 'Tristan Madani <tristmd@gmail.com>', but
  the only Signed-off-by line is 'Tristan Madani…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  j1939_session_skb_drop_old() checks…

--

can: j1939: fix skb refcount underflow in session teardown paths

This patch removes the explicit skb_unref() calls that come before
kfree_skb() in j1939_session_destroy() and j1939_session_skb_drop_old().
The commit message says the extra skb_unref() causes a double decrement
and a refcount underflow on every session teardown.

> j1939_session_destroy() and j1939_session_skb_drop_old() both call
> skb_unref() followed by kfree_skb() on session-queued skbs. Since
> kfree_skb() already handles the refcount decrement internally via
> skb_unref(), the preceding explicit skb_unref() causes a double
> decrement, triggering a refcount underflow warning on every session
> teardown.

[Severity: Medium]
Is this description accurate?

At teardown, queued skbs seem to carry two references. One is the
producer's allocation reference: j1939_sk_alloc_skb() for TX, or
alloc_skb() in j1939_session_fresh_new() for RX. The other is the
skb_get() taken when the skb is queued:

net/can/j1939/transport.c:j1939_session_new() {
    ...
	skb_queue_tail(&session->skb_queue, skb_get(skb));
    ...
}

net/can/j1939/transport.c:j1939_session_skb_queue() {
    ...
	skb_get(skb);
	skb_queue_tail(&session->skb_queue, skb);
}

So skb_unref() takes users from 2 to 1, and kfree_skb() takes it from 1
to 0, with no underflow. Also, when CONFIG_DEBUG_NET=n, skb_unref() at
users == 1 doesn't decrement at all, so it couldn't underflow there
either.

The message has no splat, reproducer, Reported-by or Closes tag for the
warning it describes.

> The extra skb_get() reference taken in j1939_session_skb_queue() needs
> exactly one corresponding release.

Doesn't this leave out the allocation reference, which the session also
owns?

Also, 8c21c54a53ab in the Fixes: tag ("j1939_session_destroy(): fix
memory leak of skbs") was a syzbot leak fix, and it added these exact
skb_unref() calls. Could the message say that this patch effectively
reverts it?

> Fixes: 8c21c54a53ab ("can: j1939: j1939_session_destroy(): fix memory leak of skbs")
> Fixes: 2030043e616c ("can: j1939: fix Use-after-Free, hold skb ref while in use")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>

[Severity: Low]
This isn't a bug, but the Signed-off-by address doesn't match the author
address (tristmd@gmail.com). checkpatch reports this as a
"From:/Signed-off-by: email address mismatch".

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 8fcfd13e5e6f8..3173936bd6f6e 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -277,11 +277,8 @@ static void j1939_session_destroy(struct j1939_session *session)
>  	WARN_ON_ONCE(!list_empty(&session->sk_session_queue_entry));
>  	WARN_ON_ONCE(!list_empty(&session->active_session_list_entry));
>  
> -	while ((skb = skb_dequeue(&session->skb_queue)) != NULL) {
> -		/* drop ref taken in j1939_session_skb_queue() */
> -		skb_unref(skb);
> +	while ((skb = skb_dequeue(&session->skb_queue)) != NULL)
>  		kfree_skb(skb);
> -	}

[Severity: Critical]
Does this leak every skb on session->skb_queue?

Neither producer drops its allocation reference after the skb is queued.
In j1939_sk_send_loop(), the kfree_skb label is only reached when
j1939_tp_send() fails:

net/can/j1939/socket.c:j1939_sk_send_loop() {
    ...
			session = j1939_tp_send(priv, skb, size);
			if (IS_ERR(session)) {
				ret = PTR_ERR(session);
				goto kfree_skb;
			}
    ...
		} else {
			skcb->offset = session->total_queued_size;
			j1939_session_skb_queue(session, skb);
		}
    ...
}

Both j1939_tp_send() and j1939_session_fresh_new() hand that reference
over to the session:

	/* skb is recounted in j1939_session_new() */

Temporary users balance their own references.
j1939_session_skb_get_by_offset() takes skb_get(), and its callers
release it with consume_skb() or kfree_skb().

So users is 2 at teardown, and with this change kfree_skb() only drops
it to 1. The skb has already been dequeued, so nothing is left to free
it.

j1939_session_skb_drop_old() has the same problem. It unlinks do_skb and
now calls kfree_skb() only once.

On TX, the leaked skbs keep their sock_wfree charge on sk_wmem_alloc. The
send buffer would fill up and the socket would never be freed. That
would also pin j1939_priv and the netdev reference. Could
unregister_netdevice then hang?

On RX, any node on the CAN bus can send a TP/ETP RTS or BAM.
j1939_session_fresh_new() then calls alloc_skb(size, GFP_ATOMIC) with a
size the peer chooses. If the data never arrives, the session times out
and is destroyed:

j1939_xtp_rx_rts() -> ... -> j1939_session_fresh_new()  alloc_skb(), users == 1
  j1939_session_new()                                   skb_get(), users == 2
j1939_tp_rxtimer()
  -> j1939_session_put()
    -> j1939_session_destroy()                          kfree_skb(), users == 1

Can a remote peer repeat this until kernel memory runs out?

This patch also carries Cc: stable and undoes 8c21c54a53ab. Wouldn't it
bring that leak back to the stable trees as well?

>  	__j1939_session_drop(session);
>  	netdev_put(session->priv->ndev, &session->priv_dev_tracker);
>  	j1939_priv_put(session->priv);
> @@ -342,8 +339,6 @@ static void j1939_session_skb_drop_old(struct j1939_session *session)
>  
>  	if ((do_skcb->offset + do_skb->len) < offset_start) {

[Severity: High]
This isn't a bug introduced by this patch, but can do_skb be NULL here?

The queue length is checked before skb_queue.lock is taken. The pointer
from skb_peek() isn't checked again after the lock is taken:

	if (skb_queue_len(&session->skb_queue) < 2)
		return;
	...
	spin_lock_irqsave(&session->skb_queue.lock, flags);
	do_skb = skb_peek(&session->skb_queue);
	do_skcb = j1939_skb_to_cb(do_skb);

The only caller, j1939_xtp_rx_cts_one(), holds no per-session lock. It
also updates session->last_cmd only after drop_old returns, so several
CTS handlers running at once can all pass the duplicate check:

	if (session->last_cmd == dat[0]) {
		err = J1939_XTP_ABORT_DUP_SEQ;
		goto out_session_cancel;
	}
	...
	session->pkt.tx_acked = pkt - 1;
	j1939_session_skb_drop_old(session);
	...
	session->last_cmd = dat[0];

CAN RX is not serialized across CPUs. vcan, for example, delivers through
netif_rx() on each sender's CPU.

Take an ETP TX session with two queued segments. Three CTS frames arrive
at the same time, each with a packet number past both segments (pkt is
not checked against pkt.total):

CPU1: passes length check, unlinks skb1
CPU2: passes length check, unlinks skb2
CPU3: passes length check, skb_peek() returns NULL,
      j1939_skb_to_cb(NULL)->offset

Would moving the length check, or a NULL check of skb_peek(), under
skb_queue.lock avoid this oops in softirq context?

>  		__skb_unlink(do_skb, &session->skb_queue);
> -		/* drop ref taken in j1939_session_skb_queue() */
> -		skb_unref(do_skb);
>  		spin_unlock_irqrestore(&session->skb_queue.lock, flags);
>  
>  		kfree_skb(do_skb);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102155345.1267524-1-tristan%40talencesecurity.com
