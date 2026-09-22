Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082612741B6;
	Tue, 22 Sep 2026 05:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790056138; cv=none; b=ORDl37YQIL9ZHpHLSSmpCmBVu6dH0Qohn7zjIl7wFnPRKJiNLsd2LJpKVvGJKdAMhCLdX8pBccmaZHhPA9IhW3orFeRKRVDIag4xZr3l03t50SfwU6z9bUAl4zxVrbeuhaRO17JBydzCmXRMR2ymW8SA5YcHIlOYg0uxRPqN3JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790056138; c=relaxed/simple;
	bh=b01VZ0Vp1qb9nnDhMRxEwmUFW07QDuf2xELoVdmBcvQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZK6eCCAl44Uv7KBiysD3Ec66OzS2ZtBzE4YKknnPjc5l1kE6Kpyvf3bHhw1bhXnjk0iBnohfWk5k1OqDh/2gvHQSenEQwnvZcTEjkbCp2IGcDho7xASTdN4seWf88EMYFUndC8XBEs4yavDvMybIzxRCO70CQDVnswUe5NCWKrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMT39g4d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMT39g4d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B001F000FF;
	Tue, 22 Sep 2026 05:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790056136;
	bh=2G+vPWS/Dr/CNZlR2fFsrRypqIqJxGQg7XWIt7mou2Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fMT39g4dGkgLRv9p0Y35txIv0Wti/Vaxch6Z/3i4OKxCrxKQsSuYJp+I3JIvFEYEF
	 R92ku/MYFSbEuhPH4ZNLb5v3F67XW29bIygzwKeI8+oyDcsVzRG6QF9mix9FCpcRC7
	 JzjKowsdPfbIsosVqQI9B5uk+dnIeXn5AAXk3HgpIV0Dtqi10PAUX+KppSDxdkATLg
	 s8Ac7sZCgjdbxJbFeaNH5wGxYLRngWLyRGkBIMqEkcgZhqu9MHgC+PPDdSWkJZ0jJz
	 aFwXe194OExRGUFIgFgSFy01dXfObppJEpGc0NVDG+zOCXC/xAIzIQf9ZT4omt3X3a
	 pSJeyG3JmUjxw==
Subject: Re: [PATCH net v2 2/2] af_unix: skip consumed OOB skb and pull
 consumed bytes in unix_stream_read_skb()
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: kuniyu@google.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, willemb@google.com,
 mhal@rbox.co, jakub@cloudflare.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 22 Sep 2026 05:48:55 +0000
Message-ID: <179005613539.2160803.10700195733714069280@kernel.org>
In-Reply-To: <20260921054823.1822122-2-benquike@gmail.com>
References: <20260921054823.1822122-2-benquike@gmail.com>
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

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net/unix/af_unix.c, unix_stream_read_skb(): the newly added pull
  block frees the whole SKB and returns -ENOMEM when pskb_pull(skb,…

Pre-existing issues:
- [Medium] Unbalanced u->scm_stat.nr_fds accounting on AF_UNIX skb drop
  paths.

--

af_unix: skip consumed OOB skb and pull consumed bytes in unix_stream_read_skb()

This changes unix_stream_read_skb() to drop zero-length skbs left behind
after an OOB byte was consumed, and to pull UNIXCB(skb).consumed bytes off
a partially consumed skb before handing it to recv_actor().  Without this,
sockmap readers re-deliver bytes that a previous recv() already consumed.

> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 0903bd587696..a1c06b9995c7 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -2885,6 +2885,7 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
>  		return err;
>  
>  	mutex_lock(&u->iolock);
> +again:
>  	spin_lock(&queue->lock);
>  
>  	skb = __skb_dequeue(queue);
> @@ -2894,6 +2895,13 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
>  		return -EAGAIN;
>  	}
>  
> +	if (!unix_skb_len(skb)) {
> +		spin_unlock(&queue->lock);
> +		unix_orphan_scm(sk, skb);
> +		consume_skb(skb);
> +		goto again;
> +	}
> +

[Severity: Medium]
This isn't a bug introduced by this patch, but the new block here uses the
correct pairing (unix_orphan_scm() before consume_skb()) while several
neighbouring free paths for the same class of skb do not, so it highlights
an existing imbalance in u->scm_stat.nr_fds.

scm_stat_del(), reached only from unix_orphan_scm(), is the only place that
does the matching decrement:

net/unix/af_unix.c:scm_stat_del() {
	...
	if (unlikely(fp && fp->count)) {
		atomic_sub(fp->count, &u->scm_stat.nr_fds);
		unix_del_edges(fp);
	}
	...
}

unix_destruct_scm() -> unix_detach_fds() -> unix_destroy_fpl() releases the
files and the GC edges but never touches nr_fds.

The OOB drop branch a few lines below in this same function frees a skb that
may still carry UNIXCB(skb).fp without going through unix_orphan_scm():

	if (skb == u->oob_skb) {
		WRITE_ONCE(u->oob_skb, NULL);
		spin_unlock(&queue->lock);
		mutex_unlock(&u->iolock);

		kfree_skb_reason(skb, SKB_DROP_REASON_UNIX_SKIP_OOB);
		return -EAGAIN;
	}

manage_oob() does the same with a bare consume_skb(read_skb) /
kfree_skb_reason(unread_skb), and unix_stream_recv_urg() frees a zero-length
predecessor with consume_skb(read_skb).

unix_stream_recv_urg() is also what creates the zero-length-with-fds state:
it copies the OOB byte and bumps UNIXCB(oob_skb).consumed without detaching
fds, so the leftover skb can still hold SCM_RIGHTS charged earlier by
scm_stat_add() in queue_oob().

Should those paths also call unix_orphan_scm() so the nr_fds charge reported
as scm_fds: in /proc/<pid>/fdinfo does not stay permanently inflated?

>  	WRITE_ONCE(u->inq_len, u->inq_len - unix_skb_len(skb));
>  
>  #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
> @@ -2913,6 +2921,14 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
>  
>  	mutex_unlock(&u->iolock);
>  
> +	if (UNIXCB(skb).consumed) {
> +		if (!pskb_pull(skb, UNIXCB(skb).consumed)) {
> +			kfree_skb(skb);
> +			return -ENOMEM;
> +		}
> +		UNIXCB(skb).consumed = 0;
> +	}
> +

[Severity: High]
Can this kfree_skb() discard unread stream bytes?

At this point in unix_stream_read_skb() the skb has already been unlinked by
__skb_dequeue(), and u->inq_len has already been reduced:

	WRITE_ONCE(u->inq_len, u->inq_len - unix_skb_len(skb));

so once the skb is freed the remaining unix_skb_len(skb) bytes are neither
recoverable nor still accounted for in the queue length.

The commit message describes pskb_pull() as the way to "safely handle both
linear and non-linear paged skbs", but it can still fail.  For a pull past
the linear head it goes pskb_pull() -> pskb_may_pull() ->
__pskb_pull_tail() -> pskb_expand_head():

net/core/skbuff.c:__pskb_pull_tail() {
	...
	if (eat > 0 || skb_cloned(skb)) {
		if (pskb_expand_head(skb, 0, eat > 0 ? eat + 128 : 0,
				     GFP_ATOMIC))
			return NULL;
	}
	...
}

unix_stream_sendmsg() produces exactly the skbs that reach that branch:

net/unix/af_unix.c:unix_stream_sendmsg() {
	...
		data_len = max_t(int, 0, size - SKB_MAX_HEAD(0));
		data_len = min_t(size_t, size, PAGE_ALIGN(data_len));
		skb = sock_alloc_send_pskb(sk, size - data_len, data_len, ...);
	...
}

MSG_SPLICE_PAGES skbs have skb_headlen() == 0 entirely, so any partial
recv() leaves UNIXCB(skb).consumed beyond the linear head and forces the
fallible path with a GFP_ATOMIC expansion of up to the full frag size.

The return value also does not appear to reach anyone who can retry:

net/core/skmsg.c:sk_psock_verdict_data_ready() {
	...
	copied = ops->read_skb(sk, sk_psock_verdict_recv);
	if (copied >= 0) {
		...
		sk_psock_data_ready(sk, psock);
	}
	...
}

The -ENOMEM is swallowed, sk_psock_data_ready() is skipped for data still
queued behind the dropped skb, and the sockmap consumer sees a hole in an
ordered byte stream with no error reported to userspace.

Would it be better to restore the state on failure, for example
__skb_queue_head() plus adding unix_skb_len(skb) back to u->inq_len, and let
the caller come back later, instead of freeing the skb?

>  	return recv_actor(sk, skb);
>  }
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921054823.1822122-1-benquike%40gmail.com
