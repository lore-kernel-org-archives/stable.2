Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E183839B8
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 17:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786381372; cv=none; b=Vl8S8C9wu+bV1wpnPFtww388QeZKXhZEHeqFNZQ8NmiwNGS8UEgSQLq95Bvd+ii6Oce3OY+q12I2vjcuRnzZLBuzJOFzE82iO5OHnQHo6muauXaL4P0oGVmC3Ii7QRZB2aupFOLSTeEYsMugOgJtnvXAlLLDbp81b590y6iykUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786381372; c=relaxed/simple;
	bh=5oOEp+Z8TWEm1FMC00+w7WGonIhVFqm3IuNg3fX7YDs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sUX8smf4L/SvZCvi/X05W+NTjf3vq89xaiPcUqq9GgWqGqvwXsBsw4xQmrmEmuGXpqBj8FSp7uRMcnxhR21ETLI/JlxMvY4cUHuYywO1qQ6Q2bt4PeUQaOmP5A51p59cLxu3IKhY+FEwIKxzyUP7Y5fQg3tHGb7LIkUKwDw2yvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hDX2Kw5t; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hDX2Kw5t"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb11535e6a1so1891841a12.0
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 10:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786381371; x=1786986171; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+SYd7rUzqwEwb4heARPv6XiZusWTQQc06FiEkDy9tfU=;
        b=hDX2Kw5tPEIbyiWnx0NNrhVjCUYSQ+Z4K6JFt+hB/a4bLujfOY9ArziG21RY0Mj5oa
         LPq+aia/KGm166b7xqt8l8tWsNabws7NDJeN7sFrDhSDfAOvAGjcg6CAT4yDKaoY9iwT
         x5y42JwkjZ1d+mTNh3Ic7fRFucuzaUwoYU2qPHowVIxF/AUnJiSt43EffLbzYF+ZlSit
         KKokcsAWLCAcm5BoREWBA0NqQAcIg5zCJWYKVyEhEyOOrq0UE1CzvvGS0KZw3BJoJlyq
         8LKl5E4uZ5/r1AaU/4kE+iOWRlyHXCF9+zry+sPLFlWfHtIXuZkmByCzMyhyRePiFZ7C
         X4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786381371; x=1786986171;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+SYd7rUzqwEwb4heARPv6XiZusWTQQc06FiEkDy9tfU=;
        b=E0LBQmu6Q1c4jteeB905kqYrRGa9LcRkrdx5HURvrbAuZ6fUBZbP/olpvBtdEbGGrP
         mCNwk8FKbM86vXZAti3m2/INLc1P3LGg+rklCV6bEGMUja89VG56TuHiTrMIYDunVvYU
         fK262zX90ENojYdsPbklv4uTVsHvB0bqDvn29tVhq0FdW1ORD4wDf8QAi+EPUrtvJEwh
         1KnkgTCz8iCYr8aNWLPPb9diaTCyzalLh3ISCAyBMaTrcJLDshY692Iwl0oC0T4z8ty+
         GOj8hdYwl7Xr+KIjUAuDmDkXnL+byj8VxfCuccxpu+X+lHtmPEv3pt4yLlvW5rI+J3Xh
         7b/A==
X-Forwarded-Encrypted: i=1; AHgh+RoNz6RQOxeGyO+xeKLGwJZAGRtTcTOlaVsdXHE2DIeeuulLvOwa9h6X/aJJWBBENEtmRxp4WxU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhp5Z/0pR1dQxbETmWCGSYNuC0Ge2Anqhc5fizalsq2prJt2pS
	uPR4KHy5Wm5qqshVw381L1zNmKqPDaaiEyOBmy04xr0Thy0512IBuKfgtgIkMZys8pRK61ALJpJ
	fP7uTVw==
X-Received: from pfbkq9.prod.google.com ([2002:a05:6a00:4b09:b0:848:3e69:4b98])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1396:b0:845:eb88:3d74
 with SMTP id d2e1a72fcca58-84f9c9d8504mr2967730b3a.29.1786381370400; Mon, 10
 Aug 2026 10:02:50 -0700 (PDT)
Date: Mon, 10 Aug 2026 17:02:13 +0000
In-Reply-To: <20260809091949.3618191-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260809091949.3618191-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260810170249.3669017-1-kuniyu@google.com>
Subject: Re: [PATCH net] mptcp: upgrade network refcount before socket lock
From: Kuniyuki Iwashima <kuniyu@google.com>
To: runyu.xiao@seu.edu.cn
Cc: davem@davemloft.net, edumazet@google.com, geliang@kernel.org, 
	horms@kernel.org, jianhao.xu@seu.edu.cn, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martineau@kernel.org, matttbe@kernel.org, 
	mptcp@lists.linux.dev, netdev@vger.kernel.org, pabeni@redhat.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Sun,  9 Aug 2026 17:19:49 +0800
> sk_net_refcnt_upgrade() calls get_net_track() with GFP_KERNEL and can enter
> direct reclaim. Calling it while holding the newly created subflow socket
> lock can create a reclaim-to-socket-lock dependency cycle.

I guess this involves NBD, and then it should be false-positive.

It makes lockdep complain about all sleepable memory allocation
under lock_sock() for TCP/AF_UNIX-SOCK_STREAM sockets.

NBD must process TX requests asynchronously to remove the dependency.


> 
> Upgrade the network reference before taking the socket lock. The socket is
> newly created and has not been exposed to other code at this point, so the
> fields changed by sk_net_refcnt_upgrade() are not accessed concurrently.
> The error path still releases the socket normally after the upgrade.
> 
> The PatchProof static-analysis tool detected a GFP_KERNEL allocation while
> the socket lock is held. Manual source review of v7.1.5 and current
> mainline confirmed the lock and allocation ordering.
> 
> A source-level check found `sk_net_refcnt_upgrade()` after
> `lock_sock_nested()` in the original function and before it after this
> change. A POSIX-thread lock-order model made the reclaim lock unavailable
> while the socket lock was held, observed `EBUSY` for the reclaim lock, and
> then completed with the reclaim-first order. The model checks the ordering
> invariant only; it does not execute the kernel MPTCP path. No live lockdep
> MPTCP test or reclaim fault injection was run.
> 
> Fixes: 1d2f3d3c6268 ("mptcp: adjust to use netns refcount tracker")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  net/mptcp/subflow.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index e1f20ff8fdb4..a9f951cc6a0e 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1786,6 +1786,12 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
>  	if (err)
>  		return err;
>  
> +	/* kernel sockets do not by default acquire net ref, but TCP timer
> +	 * needs it.
> +	 * Update ns_tracker to current stack trace and refcounted tracker.
> +	 */
> +	sk_net_refcnt_upgrade(sf->sk);
> +
>  	lock_sock_nested(sf->sk, SINGLE_DEPTH_NESTING);
>  
>  	err = security_mptcp_add_subflow(sk, sf->sk);
> @@ -1795,11 +1801,6 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
>  	/* the newly created socket has to be in the same cgroup as its parent */
>  	mptcp_attach_cgroup(sk, sf->sk);
>  
> -	/* kernel sockets do not by default acquire net ref, but TCP timer
> -	 * needs it.
> -	 * Update ns_tracker to current stack trace and refcounted tracker.
> -	 */
> -	sk_net_refcnt_upgrade(sf->sk);
>  	err = tcp_set_ulp(sf->sk, "mptcp");
>  	if (err)
>  		goto err_free;
> -- 
> 2.34.1
