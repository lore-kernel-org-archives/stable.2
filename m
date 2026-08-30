Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295802EEE7E;
	Sun, 30 Aug 2026 23:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788134230; cv=none; b=EtcscnJMAcBaG3ofASmbajHDGW1oJlUJkRvISM7uvqIWQzqj1y29uxIrno3PGeVnHUGV+gLZuQEzY/6YcFWGM7mGLMdCbK62IowvQE00uw2UQGPuHy86l49mkH/A6B0iOsaTfjMNycXzdW46gBdMybXwrYM+I7xraiYGIG345H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788134230; c=relaxed/simple;
	bh=BL92vrdyEXmVNPZ4YtKveCenWu1jMpsobZ0ytKzM958=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iyZurSKM6tnoPRcYYxp+HEHiTpQ/N11NnzerppCkzQTs86zDfveQdrM+AIHrG9LcejAlOa+Xn2mAW1IRNg4CypPJvE7x+9HjJMl9H+m7wjEnmyRFm11Y7Tc0bdIJ1VYo0xK/ZRa2x/1Oj9n1VwglQdMVwtDweAXcVZ8y98xVqt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBqqSKXl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBqqSKXl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9851F000E9;
	Sun, 30 Aug 2026 23:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788134228;
	bh=HjzQ9XmA/zxZXcCZPEec92LZbbvtnoHKZuNOgu2Pc/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GBqqSKXl7mztckycwAvvxyaOjpkNiFN2KBbm3ehYJJkffSw2pztu+EIq//1PVYwYP
	 VU7WLDZoiRfY5EHHvJBx1Lv2HX7KtNxFVx3RG0BYh1npwBGbpludwIVvUxcS6Zuqge
	 r7JBt8nUTmUaf4qUYwKJNGUB65FGVfVdmy1M0o9hbdMpW5YHSq4V6wSAxSy6FM5jEM
	 5rjwml1P8X5vN1f/i4IakJo110HCRD8WzWLt1uccaQFoOpS59TySf7ht+P9ZIIWI1r
	 ElpsLjYwJwyhzUfj1xd3Y4+3MuWmT8fWR3vUwZ0owcQpWUX3B5l73ExaD1XIHDIqMX
	 41U5Jqs5dJoCg==
From: Jakub Kicinski <kuba@kernel.org>
To: nicoyip.dev@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	edumazet@google.com,
	kuniyu@google.com,
	pabeni@redhat.com,
	willemb@google.com,
	davem@davemloft.net,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: pin protocol module before inet socket allocation
Date: Sun, 30 Aug 2026 16:57:06 -0700
Message-ID: <20260830235706.746689-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825172349.232794-1-nicoyip.dev@gmail.com>
References: <20260825172349.232794-1-nicoyip.dev@gmail.com>
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
net: pin protocol module before inet socket allocation

inet_create() and inet6_create() look up the inet_protosw under RCU and then
drop RCU before using answer_prot across the sleeping sk_alloc().  The patch
takes try_module_get(answer_prot->owner) while still under RCU and drops the
reference on every path after sk_alloc().

> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index 32d006c1a8eed..88a18ac0e6e42 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -325,6 +325,10 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
>  	sock->ops = answer->ops;
>  	answer_prot = answer->prot;
>  	answer_flags = answer->flags;
> +	if (!try_module_get(answer_prot->owner)) {
> +		err = -EPROTONOSUPPORT;
> +		goto out_rcu_unlock;
> +	}
>  	rcu_read_unlock();
>  
>  	WARN_ON(!answer_prot->slab);

[Severity: High]
Does a plain try_module_get() here cover the case where the protocol module
is still inside its own init and then rolls back?

try_module_get() only gates on module_is_live():

kernel/module/main.c:try_module_get() {
	...
		if (likely(module_is_live(module) &&
			   atomic_inc_not_zero(&module->refcnt) != 0))
	...
}

include/linux/module.h:
/* FIXME: It'd be nice to isolate modules during init, too, so they
   aren't used before they (may) fail. */
static inline bool module_is_live(struct module *mod)
{
	return mod->state != MODULE_STATE_GOING;
}

So the pin succeeds for a module in MODULE_STATE_COMING, i.e. while
do_one_initcall(mod->init) is still running with module_mutex dropped.

Some protocol modules publish the protosw early in init and then destroy the
slab from their init-failure unwind, which does not consult the module
refcount:

net/sctp/protocol.c:sctp_v4_protosw_exit() {
	inet_unregister_protosw(&sctp_stream_protosw);
	inet_unregister_protosw(&sctp_seqpacket_protosw);
	proto_unregister(&sctp_prot);
}

reached from the err_protosw_init label in sctp_init() after
sctp_v4_protosw_init() has already registered the protosw.  net/smc has the
same shape:

net/smc/smc_inet.c:smc_inet_init() {
	...
out_inet6_protosw:
	proto_unregister(&smc_inet6_prot);
out_inet6_prot:
	inet_unregister_protosw(&smc_inet_protosw);
	proto_unregister(&smc_inet_prot);
	...
}

Can the sequence the commit message describes still happen with that?

CPU 0 inet_create                  CPU 1 modprobe sctp (mod->init)
rcu_read_lock()                    sctp_v4_protosw_init()  /* published */
answer_prot = answer->prot
try_module_get()  /* COMING -> ok */
rcu_read_unlock()                  /* later init step fails */
                                   sctp_v4_protosw_exit()
                                     inet_unregister_protosw()
                                       synchronize_net() /* returns at once */
                                     proto_unregister()
                                       kmem_cache_destroy(slab)
WARN_ON(!answer_prot->slab)
sk_alloc() -> kmem_cache_alloc(stale)

The kernel's own helper rejects exactly this state, which suggests a plain
reference is not a lifetime guarantee during init:

kernel/module/main.c:
/*
 * We require a truly strong try_module_get(): 0 means success.
 * Otherwise an error is returned due to ongoing or failed
 * initialization etc.
 */
static inline int strong_try_module_get(struct module *mod)
{
	BUG_ON(mod && mod->state == MODULE_STATE_UNFORMED);
	if (mod && mod->state == MODULE_STATE_COMING)
		return -EBUSY;

Would rejecting owners in MODULE_STATE_COMING (or taking a reference tied to
the protosw/proto lifetime instead of the module refcount) close the residual
window?

> @@ -398,6 +402,8 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
>  		if (err)
>  			goto out_sk_release;
>  	}
> +out_module_put:
> +	module_put(answer_prot->owner);
>  out:
>  	return err;
>  out_rcu_unlock:

[Severity: High]
On the same init-failure path, can module_put(answer_prot->owner) here read
freed memory?

answer_prot lives in the module's .data, and do_init_module() frees the module
image without waiting for foreign references:

kernel/module/main.c:do_init_module() {
	...
fail:
	/* Try to protect us from buggy refcounters. */
	mod->state = MODULE_STATE_GOING;
	synchronize_rcu();
	module_put(mod);
	...
	free_module(mod);
}

That is unlike the delete_module() path, which does the refcount handshake in
try_stop_module()/try_release_module_ref().  So after free_module() runs,
both answer_prot->owner and the sock->ops pointer already stored above refer
to freed module memory.

[ ... ]

> diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
> index 282912a119999..82b390ce3e0cd 100644
> --- a/net/ipv6/af_inet6.c
> +++ b/net/ipv6/af_inet6.c
> @@ -170,6 +170,10 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
>  	sock->ops = answer->ops;
>  	answer_prot = answer->prot;
>  	answer_flags = answer->flags;
> +	if (!try_module_get(answer_prot->owner)) {
> +		err = -EPROTONOSUPPORT;
> +		goto out_rcu_unlock;
> +	}
>  	rcu_read_unlock();
>  
>  	WARN_ON(!answer_prot->slab);

[Severity: High]
inet6_create() has the same exclusion, and it also dereferences the protosw
after RCU is dropped:

	sk->sk_backlog_rcv	= answer->prot->backlog_rcv;

Does the COMING-module case above apply here too, given that sctp and smc
register their IPv6 protosw during init and unwind through
inet_unregister_protosw() + proto_unregister() on failure?

[ ... ]
-- 
pw-bot: cr
