Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213C62264B0
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 20:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791835677; cv=none; b=tGR64n3JysKJViwMAH6r4I7tXY5iuSc80JRzVe/MvtznAEQMczXI6CJBJRO+r3VV10JwSvHIALZoHJXQvkM0yUeUeBrOs383qGdnKVSfxuApJm5JxLnhI74Q+jjNTp7KveXEFs9oBYQlp+5ZRpi0p9Pn1MH7Srv3Ks7kTZ4Pyns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791835677; c=relaxed/simple;
	bh=hZeN90OHi8JsYAC1LGoWi61Ik6KxYl2x+M733vRSzv4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XAYF/epsEZrsB0riRn4O6dVVCajs+YOyk/xPmPOtfH97qV6bDmoPf7mBAOoBNmY6kgRwZmgnGLuLn+Ge2Ww5pGsB1IwkyBvOvS9/kUYrJ9VQEPe4jPLZylvXVC7kPDZGiU21LpPsqeH2HB/mUEheBhJDNkU68K9bEtCWN/b7fEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b53ufgl2; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b53ufgl2"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbe77d6864dso2340456a12.2
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 13:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791835674; x=1792440474; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2PABba6DbeMdjCfPcszkJEKZ4VosjTV2kGe/Y+FbUHM=;
        b=b53ufgl2WdskXS9CBznnoFjhFibqD/jA6wDteSRw4NIaS3/BA4bnTPLtjJqHGrd0jO
         h3KXE8E/wIK90BqjfEfgopd8h1iTzUwBQF+Eitrt67Dc/qzlk+fJOxYLgqp6NIviRb5A
         Lw8/QnPXxF3AiCedWQQ02vo49a6u6EBCcmj/gqTNfuSS65Q6pZ1NDZweYJniTr58dUCM
         tfULkokXdqAAKwUiAqE1VCDdpiCzr1skYqMCFhheHx72yXbMFwRsKxIk5WLwjizEcMIE
         GYhlOcFVWOfamSDgIeuo7qZo/fT1Dwyzx23ee7HLNTgt01hV0tHf72e4c41mA1TREczL
         kJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791835674; x=1792440474;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2PABba6DbeMdjCfPcszkJEKZ4VosjTV2kGe/Y+FbUHM=;
        b=sfiXXevxFl9qZQ31qpqV1GKNMeZpdW4q8n8+RJPBG8z5gEtm0Tp80zcXQo13If9GAH
         dWZww1Iuu/Pi5kp2nBeExOEU1SPfsLNS2WSVgsnosSpQDPAllTZaIIyWAH1iY69pwu6G
         6dkPiHB3WNZ+YLIhmaEN/6XmbkfyEUBjLAJTuE53ykz8hXH/PGvmAdU3d0xsA9BHKuhL
         SjstBe82J11LGaANOg5nXry/JfEehnpIXaPmMNHOsp1BALAMqo4yu5fYaomWrE8EMi3u
         6LSJoE1fJoartc7CqsrIwmv5MYoPoWCedb3R3GpCRtJRWc6Lbqny8xZaXnBdUrbAoK9/
         USqw==
X-Forwarded-Encrypted: i=1; AKwUvBxDRTlezQIUj0QM608i5pZmBDQllo2vxnksbnuZUhdI2BUVXSrhRipAIS0FRHkbuVnt4VjAdlU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKAwqWq5iN0lg5Xnc7/Mr1/4Z5oGRuU86H/eX5/n8NtQO26T0LR
	bLtHrNHgqPbMwkQpKVteau09YwE9bp1WJO2z4DzDsbNPwEoUukAJKfyH+BTF+CBF7ozoHb4pbwX
	Pp9r6Fw==
X-Received: from pgvi17.prod.google.com ([2002:a65:61b1:0:b0:cd4:ef82:4e33])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:6cc1:10b0:3e1:7746:637c
 with SMTP id adf61e73a8af0-3e17746749bmr4905404637.51.1791835673305; Mon, 12
 Oct 2026 13:07:53 -0700 (PDT)
Date: Mon, 12 Oct 2026 20:07:37 +0000
In-Reply-To: <20261002173844.3537111-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261002173844.3537111-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261012200752.3771786-1-kuniyu@google.com>
Subject: Re: [PATCH net v4] net: pin protocol module before inet socket allocation
From: Kuniyuki Iwashima <kuniyu@google.com>
To: nicoyip.dev@gmail.com
Cc: davem@davemloft.net, edumazet@kernel.org, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Sat,  3 Oct 2026 01:38:44 +0800
> inet_create() and inet6_create() look up the protocol under RCU, then drop
> RCU before using the resulting proto. A concurrent module unload can
> unregister the protosw, wait for the RCU readers, and destroy the proto's
> slab before sk_alloc() uses it. sk_alloc() may sleep, so the RCU read-side
> critical section cannot simply be extended across the allocation.
> 
> The reported failure occurred during concurrent L2TP socket creation and
> module unload:
> 
>   Oops: general protection fault, probably for non-canonical address
>         0xffff1108974182a0
>   KASAN: maybe wild-memory-access in range
>          [0xfff8a844ba0c1500-0xfff8a844ba0c1507]
>   RIP: kmem_cache_alloc_noprof+0x63/0x370
>   Call Trace:
>    sk_prot_alloc+0x74/0x2c0
>    sk_alloc+0x2b/0x6c0
>    inet_create+0x2cd/0xd40
>    __sock_create+0x1c3/0x430
>    __sys_socket+0x116/0x1d0
> 
> Cache the proto and its owner under RCU and acquire a temporary module
> reference before dropping RCU. This prevents normal module unload while
> the proto is in use. sk_prot_alloc() takes the socket's own reference;
> drop the temporary reference on every exit after allocation. Use the
> cached proto for the IPv6 backlog callback as well.
> 
> Use try_module_get() with its existing initialization semantics. SCTP
> creates its kernel control socket during module initialization, so
> rejecting MODULE_STATE_COMING would prevent modular SCTP from loading.
> Failed module initialization can still unwind published protocols despite
> module references; that separate publication/unwind lifetime issue is not
> fixed here.
> 
> Fixes: a79af59efd20 ("[NET]: Fix module reference counts for loadable protocol modules")
> Cc: stable@vger.kernel.org
> Assisted-by: GPT-6-Astra
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
> Changes in v4:
> - Remove the MODULE_STATE_COMING rejection. SCTP creates its kernel control
>   socket from module init and must be allowed to use the published protosw.

You can filter the case by @kern.

sockets created from __init_net functions always have
@kern=true otherwise we cannot tear down netns.


> - Keep the owner cached under RCU and use the cached proto for IPv6 backlog
>   setup, retaining those v3 changes.
> - Scope the module-reference guarantee to normal module unload. The earlier
>   review's initialization-failure unwind concern remains a separate issue;
>   rejecting all initializing modules is not a compatible solution.
> - Rebase onto net/main at a7bfaba4823e.
> 
> v3: https://lore.kernel.org/r/20260904111514.584264-1-nicoyip.dev@gmail.com/
> Review: https://lore.kernel.org/r/178887699602.219967.13594894510710999619@kernel.org/
> v2: https://lore.kernel.org/r/20260825172349.232794-1-nicoyip.dev@gmail.com/
> v1: https://lore.kernel.org/r/20260823171311.3857087-1-nicoyip.dev@gmail.com/
> 
>  net/ipv4/af_inet.c  | 14 +++++++++++---
>  net/ipv6/af_inet6.c | 16 ++++++++++++----
>  2 files changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index 32d006c1a8ee..c956afa65ec4 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -263,6 +263,7 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
>  	struct inet_protosw *answer;
>  	struct inet_sock *inet;
>  	struct proto *answer_prot;
> +	struct module *answer_owner;
>  	unsigned char answer_flags;
>  	int try_loading_module = 0;
>  	int err;
> @@ -322,9 +323,14 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
>  	    !ns_capable(net->user_ns, CAP_NET_RAW))
>  		goto out_rcu_unlock;
>  
> -	sock->ops = answer->ops;
>  	answer_prot = answer->prot;
> +	answer_owner = answer_prot->owner;
>  	answer_flags = answer->flags;
> +	if (!try_module_get(answer_owner)) {
> +		err = -EPROTONOSUPPORT;
> +		goto out_rcu_unlock;
> +	}
> +	sock->ops = answer->ops;
>  	rcu_read_unlock();
>  
>  	WARN_ON(!answer_prot->slab);
> @@ -332,7 +338,7 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
>  	err = -ENOMEM;
>  	sk = sk_alloc(net, PF_INET, GFP_KERNEL, answer_prot, kern);
>  	if (!sk)
> -		goto out;
> +		goto out_module_put;
>  
>  	err = 0;
>  	if (INET_PROTOSW_REUSE & answer_flags)
> @@ -398,6 +404,8 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
>  		if (err)
>  			goto out_sk_release;
>  	}
> +out_module_put:
> +	module_put(answer_owner);
>  out:
>  	return err;
>  out_rcu_unlock:
> @@ -406,7 +414,7 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
>  out_sk_release:
>  	sk_common_release(sk);
>  	sock->sk = NULL;
> -	goto out;
> +	goto out_module_put;
>  }
>  
>  
> diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
> index 282912a11999..9db60af6f38d 100644
> --- a/net/ipv6/af_inet6.c
> +++ b/net/ipv6/af_inet6.c
> @@ -110,6 +110,7 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
>  	struct sock *sk;
>  	struct inet_protosw *answer;
>  	struct proto *answer_prot;
> +	struct module *answer_owner;
>  	unsigned char answer_flags;
>  	int try_loading_module = 0;
>  	int err;
> @@ -167,9 +168,14 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
>  	    !ns_capable(net->user_ns, CAP_NET_RAW))
>  		goto out_rcu_unlock;
>  
> -	sock->ops = answer->ops;
>  	answer_prot = answer->prot;
> +	answer_owner = answer_prot->owner;
>  	answer_flags = answer->flags;
> +	if (!try_module_get(answer_owner)) {
> +		err = -EPROTONOSUPPORT;
> +		goto out_rcu_unlock;
> +	}
> +	sock->ops = answer->ops;
>  	rcu_read_unlock();
>  
>  	WARN_ON(!answer_prot->slab);
> @@ -177,7 +183,7 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
>  	err = -ENOBUFS;
>  	sk = sk_alloc(net, PF_INET6, GFP_KERNEL, answer_prot, kern);
>  	if (!sk)
> -		goto out;
> +		goto out_module_put;
>  
>  	sock_init_data(sock, sk);
>  
> @@ -201,7 +207,7 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
>  	sk->sk_family		= PF_INET6;
>  	sk->sk_protocol		= protocol;
>  
> -	sk->sk_backlog_rcv	= answer->prot->backlog_rcv;
> +	sk->sk_backlog_rcv	= answer_prot->backlog_rcv;
>  
>  	inet_sk(sk)->pinet6 = np = inet6_sk_generic(sk);
>  	np->hop_limit	= -1;
> @@ -251,6 +257,8 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
>  		if (err)
>  			goto out_sk_release;
>  	}
> +out_module_put:
> +	module_put(answer_owner);
>  out:
>  	return err;
>  out_rcu_unlock:
> @@ -259,7 +267,7 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
>  out_sk_release:
>  	sk_common_release(sk);
>  	sock->sk = NULL;
> -	goto out;
> +	goto out_module_put;
>  }
>  
>  int __inet6_bind(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len,
> 
> base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
> -- 
> 2.43.0
