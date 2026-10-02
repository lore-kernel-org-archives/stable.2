Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B7A29346F;
	Fri,  2 Oct 2026 02:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790909843; cv=none; b=sapKY0qf/Pa3P8+CLz1rLwLeHBn6RyHFjD0/TrYRpcJEpH+OTUq9GaUIP+Gy3UydpEsyhRVAQh2H0Gfx8xOQL5Ul1EP2j0OTOlUjJmmPlcBLxUwqo+lD4qrL2xKQfPOVPOrLWFEEhJVPYp3G7mrs3tBgWagKmYNuVKr4IrosR6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790909843; c=relaxed/simple;
	bh=OVO4czZn0m3ji8Pr0MNvmKCDP2HovUJgnLurH241Hzw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SNqDT+jItdIEcAGYmuKOyuSRMi1pO9AbvauqTlyld4+td2s5UYXEPpTd++rIdRficDk5jFhgEdKuXkRBdiRoedRv2uJ2+sP7URUL3WZtQolv2qiXVOA3Y0svIX3pgtaP09iFbrJcQiXyPKJTH8m8EJPN/ygSEza6Ftybbq6zMzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtCXfKD6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtCXfKD6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6021F000FF;
	Fri,  2 Oct 2026 02:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790909842;
	bh=7OnHaYO4YfHoZJtlJrBk6mUFl4QSkni2NDxgVKqLcX0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mtCXfKD6CdiKUHpPKXcNqZpD3qMbnN58/QdsQ33Im3gCnysW/LwUj3HaX5vEO8Kdg
	 GNEEo1UysfksxEh+wkmUyqv/LbkDGt5Rl5FoTUIIkfGVXMy4eDa9xdOO/Y2xBhKUKz
	 /eIFM4MPwAPoAT+yF7bQfBKWPL3u2HiyxoHLVimPBVUvtWbnmIlxca+vEToCc7S470
	 Sz1at6cadqsnUrIEGyt5U9wfUajwAut7/zgTUCTdHbhG/czL5EUE0eRp9O6gCwQl6F
	 gxMl00P2549rCKjtTJEk04wPb51KcJpAQCuZtSLOW+saBpcK4lxdujPe1bfEiH2QiM
	 SAnK5SNegR6Ow==
Subject: Re: [PATCH net] tipc: protect received keys from concurrent flush
From: netdev-bot+sashiko@kernel.org
To: Jeremy.Jean@oss.cyber.gouv.fr
Cc: jmaloy@redhat.com, tung.quang.nguyen@est.tech, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, kuba@kernel.org
Date: Fri, 02 Oct 2026 02:57:21 +0000
Message-ID: <179090984112.434549.12939052372850275600@kernel.org>
In-Reply-To: <20260930115708.349540-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260930115708.349540-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch fixes the rx->skey UAF/double-free, but the flush it
  protects can now be silently undone.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but an RX delayed
  work can re-arm after netns teardown has flushed it and then fire on a…

--

tipc: protect received keys from concurrent flush

This patch adds an skey_in_use flag to struct tipc_crypto. The RX worker
sets it under rx->lock while it attaches rx->skey, and
tipc_crypto_key_flush() skips freeing the key while the flag is set. The
goal is to close a KASAN-reported use-after-free and double-free that
happens when key exchange races with key flush.

> diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
> index 4409bdb70fe98..eab2a66e22333 100644
> --- a/net/tipc/crypto.c
> +++ b/net/tipc/crypto.c

[ ... ]

> @@ -1214,8 +1216,11 @@ void tipc_crypto_key_flush(struct tipc_crypto *c)
>  		rx = c;
>  		tx = tipc_net(rx->net)->crypto_tx;
>  		if (cancel_delayed_work(&rx->work)) {
> -			kfree_sensitive(rx->skey);
> -			rx->skey = NULL;
> +			/* A previous invocation may still be using the key. */
> +			if (!rx->skey_in_use) {
> +				kfree_sensitive(rx->skey);
> +				rx->skey = NULL;
> +			}
>  			atomic_xchg(&rx->key_distr, 0);
>  			tipc_node_put(rx->node);
>  		}

[Severity: Medium]
With this skip, can the still-running worker undo the flush after it
returns?

Nothing tells the in-flight tipc_crypto_work_rx() that a flush happened,
so this sequence looks possible:

CPU1 (tipc_crypto_work_rx)            CPU2
spin_lock_bh(&rx->lock);
rx->skey_in_use = true;
spin_unlock_bh(&rx->lock);
                                      tipc_crypto_key_synch()
                                        re-queues rx->work
                                      tipc_crypto_key_flush()
                                        cancel_delayed_work() == true
                                        skips kfree, rx->skey stays set
                                        c->flags = 0;
                                        tipc_crypto_key_set_state(c, 0, 0, 0);
                                        tipc_crypto_key_detach() on all keys
                                        spin_unlock_bh(&c->lock);
tipc_crypto_key_init(rx, rx->skey, ...)
  tipc_crypto_key_attach()
    tipc_aead_rcu_replace(c->aead[new_key], aead, &c->lock);
    c->working = 1;
    c->nokey = 0;

In this case the TIPC_NL_KEY_FLUSH handler (__tipc_nl_node_flush_key())
returns 0. The peer's AEAD is still installed at key_next(0) and the RX
crypto is re-enabled.

There is also the retry path. Suppose tipc_crypto_key_attach() had already
returned -EBUSY, or tipc_aead_init() had returned -ENOMEM, before the
flush. The worker then keeps rx->skey, clears skey_in_use and re-queues
itself. queue_delayed_work() succeeds because the flush cancelled the
pending instance, so the pre-flush key gets attached about 5 seconds
later.

Until that happens, tipc_crypto_key_rcv() rejects new keys from the peer
because the stale rx->skey is still non-NULL:

	if (unlikely(rx->skey || (key_gen == rx->key_gen && rx->key.keys))) {
		pr_err("%s: key existed <%p>, gen %d vs %d\n", rx->name,

tipc_crypto_rcv() also counts the stale rx->skey when it computes
rx->nokey:

	rx->nokey = !(rx->skey ||

Before this patch, the cancel_delayed_work() == true case freed and
cleared rx->skey (with the use-after-free), so the retry had nothing to
attach. With this patch, that case behaves like the existing
cancel_delayed_work() == false case: the flush does not revoke the key
that is in flight. The commit message doesn't mention this.

Would a flushed or generation marker help? The worker would re-check it
under rx->lock before attaching or re-queueing, and free the key if a
flush had happened. That keeps the use-after-free fix and still honours
the flush.

> @@ -2371,7 +2376,10 @@ static void tipc_crypto_work_rx(struct work_struct *work)
>  	}
>  
>  	/* Case 2: Attach a pending received session key from peer if any */
> +	spin_lock_bh(&rx->lock);
>  	if (rx->skey) {
> +		rx->skey_in_use = true;
> +		spin_unlock_bh(&rx->lock);
>  		rc = tipc_crypto_key_init(rx, rx->skey, rx->skey_mode, false);
>  		if (unlikely(rc < 0))
>  			pr_warn("%s: unable to attach received skey, err %d\n",
> @@ -2381,14 +2389,18 @@ static void tipc_crypto_work_rx(struct work_struct *work)
>  		case -ENOMEM:
>  			/* Resched the key attaching */
>  			resched = true;
> +			spin_lock_bh(&rx->lock);
>  			break;
>  		default:
>  			synchronize_rcu();
> +			spin_lock_bh(&rx->lock);
>  			kfree_sensitive(rx->skey);
>  			rx->skey = NULL;
>  			break;
>  		}
> +		rx->skey_in_use = false;
>  	}
> +	spin_unlock_bh(&rx->lock);
>  
>  	if (resched && queue_delayed_work(tx->wq, &rx->work, delay))
>  		return;

[Severity: High]
This is a pre-existing issue and wasn't introduced by this patch. Since
the new skey_in_use skip hands the key to this running worker, can this
re-queue happen after netns teardown and then fire on a destroyed
workqueue?

The netns exit path flushes the RX crypto like this:

tipc_exit_net()
  tipc_net_stop()
    tipc_node_stop()
      tipc_node_delete()
        tipc_node_delete_from_list()
          tipc_crypto_key_flush(node->crypto_rx)

tipc_crypto_key_flush() holds c->lock, so it can only use the non-sync
cancel_delayed_work(). That does nothing to a tipc_crypto_work_rx() that
is already running.

That worker always sets resched = true after Case 1 key distribution. It
also sets it on the Case 2 -EBUSY/-ENOMEM path. Because the work is not
pending, queue_delayed_work(tx->wq, &rx->work, delay) then succeeds, and
the worker returns still holding its tipc_node reference.

After that, tipc_exit_net() calls tipc_crypto_stop() on the TX crypto,
which only sync-cancels the TX work:

	if (is_tx(c)) {
		c->rekeying_intv = 0;
		cancel_delayed_work_sync(&c->work);
		destroy_workqueue(c->wq);
	}

The destroy_workqueue() documentation says delayed work must be cancelled
before calling it. When the re-armed RX timer fires,
delayed_work_timer_fn()->__queue_work() would use the freed tx->wq. Then
tipc_crypto_work_rx() would dereference tipc_net(rx->net)->crypto_tx of
the torn-down netns.

The node reference held by the re-armed work is also never dropped. Would
that leak the tipc_node, its crypto_rx, and any rx->skey that the
skey_in_use skip left for the worker?

A remote peer can drive Case 1 by sending rx_nokey, which reaches
tipc_crypto_key_synch().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930115708.349540-2-Jeremy.Jean%40oss.cyber.gouv.fr
