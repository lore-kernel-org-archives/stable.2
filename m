Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECE63C342B;
	Mon, 28 Sep 2026 07:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581419; cv=none; b=LQ1LDfj+2ytUIyzNLibfvZbFjMLb4UwNNvYAVBnaiHv60VtzX21K4pV1hOy3brX6yN2Z6RWmJzw+2BBFrd9ypb28rDu1PvmdDPPmdBq18mSx0witr3Z7Nng/jPmUMBM1b8RUZ8Yi5HPddiMA5WXTeVnOjXOOAlQmL7f/YGZ20/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581419; c=relaxed/simple;
	bh=v5xkypmjVIwI+h3qsJYOVW2FyoXQyyhdhrWAy4f92Po=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FxbIq+RrWASZtjWl6UGc9Ech+F8h+IOKV9CYIyU326o80/1uam/TIBhc7wmQeuDOH2Kmalo+mBuRgmmuArAuvahAcbTKM7eKXkw2r3DnV6w56PYIV8kxPhAnYj74hgkQI8cBqtlqTfYcDlz4kSLdEPlDmYKi89WrLgbSDeE8Hx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mW0lLWC9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mW0lLWC9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC17E1F000FF;
	Mon, 28 Sep 2026 07:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790581418;
	bh=HrWmya2BbGZvSwijVjwf4Mdm9vx7MdcATLhRM6SO8m4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mW0lLWC92Hqe7B3S+WdkF8UlfU5I6RB4+uHTXcgv6fM5XjlwPMcTqiZZBdRjAplI6
	 h4mGQCBGU2F/q4MAJUlDW+UgKxxBBZ/KcdP7m7SGZLX0URBRPpYlphDlo2wR0pO7wX
	 JYkl1DsoStVdRHKs/ZVHsubihFrYrJjijUjXK07CzY9zMQ50SA8uGpu2axgVrM3uDL
	 DuxD0yRU7V8QWYO1luBLD9hcs934U+J/667xUbHvp1Qq4EzVAJ5QiGhJJyZlFnamew
	 SnKYacceHyy4PAE6toH38LIsy1Rue+JgMZnJDNxcIJWalC1MPCC/tLMoUZfvIqAUTV
	 69tGKG8xPeDJQ==
Subject: Re: [PATCH net v2 2/2] af_unix: skip consumed OOB skb and pull
 consumed bytes in unix_stream_read_skb()
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: kuniyu@amazon.com, edumazet@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 28 Sep 2026 07:43:37 +0000
Message-ID: <179058141737.3145.8100394961059840159@kernel.org>
In-Reply-To: <20260924071629.2683160-3-benquike@gmail.com>
References: <20260924071629.2683160-3-benquike@gmail.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch adds a pskb_pull() call to unix_stream_read_skb()
  (net/unix/af_unix.c:2924-2930).

--

af_unix: skip consumed OOB skb and pull consumed bytes in unix_stream_read_skb()

This patch makes unix_stream_read_skb() free zero-length consumed skbs
(for example an OOB skb already read with recv(MSG_OOB)). It also makes
it pull UNIXCB(skb).consumed bytes before handing the skb to
recv_actor(). The goal is to stop sockmap from re-delivering data that a
normal recv() has already consumed.

> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 0903bd587696..a1c06b9995c7 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c

[ ... ]

> @@ -2913,6 +2921,14 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
>  
>  	mutex_unlock(&u->iolock);
>  
> +	if (UNIXCB(skb).consumed) {
> +		if (!pskb_pull(skb, UNIXCB(skb).consumed)) {
> +			kfree_skb(skb);
> +			return -ENOMEM;
> +		}

[Severity: High]
If pskb_pull() fails here, is the unread part of the stream silently
lost?

unix_stream_sendmsg() often builds non-linear skbs. The normal path uses
sock_alloc_send_pskb(sk, size - data_len, data_len, ...), which caps the
linear head and puts the rest in frags. The MSG_SPLICE_PAGES path uses
sock_alloc_send_pskb(sk, 0, 0, ...), so headlen is 0.

After a partial recv(), unix_stream_read_generic() does:

    UNIXCB(skb).consumed += chunk;

and leaves the skb on the queue. That means consumed can be larger than
skb_headlen(skb), in which case pskb_pull() takes the allocating path:

    pskb_pull()
      pskb_may_pull_reason()
        __pskb_pull_tail(skb, consumed - headlen)
          pskb_expand_head(skb, 0, eat + 128, GFP_ATOMIC)

This is an atomic allocation, possibly high order, sized by the prefix
that was already consumed. On success, that prefix is copied out of the
frags only to be discarded.

If the allocation fails, kfree_skb(skb) frees the whole skb, including
the unix_skb_len(skb) bytes nobody has read yet. By then u->inq_len has
already been reduced:

    WRITE_ONCE(u->inq_len, u->inq_len - unix_skb_len(skb));

The only caller, sk_psock_verdict_data_ready() in net/core/skmsg.c,
only acts on non-negative returns:

    copied = ops->read_skb(sk, sk_psock_verdict_recv);
    if (copied >= 0) {

So the -ENOMEM is dropped: nothing retries, sk_err is not set, and the
skb is already off sk_receive_queue. Before this patch, this spot had no
allocation-failure path.

The commit message says pskb_pull() "safely handles both linear and
non-linear paged skbs". That is true in that it avoids the BUG() in
__skb_pull(), but it can still fail and drop data.

Could the consumed bytes be skipped without allocating instead? Two
options: trim the head and frags in place, as TCP's __pskb_trim_head()
does, or pass an offset to the actor.

> +		UNIXCB(skb).consumed = 0;
> +	}
> +
>  	return recv_actor(sk, skb);
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924071629.2683160-1-benquike%40gmail.com
