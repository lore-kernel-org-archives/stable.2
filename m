Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AF5556BA2;
	Tue,  8 Sep 2026 14:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788877012; cv=none; b=dDzZFp1mS7sdA+0sVKryv8Ta3Y6WeV5pdLdFNFSVd/gm5a37TslW8w4rmvyXe+xG/Y4xXy53HwN+qZTBpDKLh42bRMg5L4QtUO40Two1LKiMlulnQSYPz0hrpvXsaTWw0FleTfrwb6lh+hUIDjRvZYCSVXwsi4d1B9NiVkgKlQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788877012; c=relaxed/simple;
	bh=VDRM8K7mCJqWUg8bWEfaw3p5qwPTeCOkvPoV0/Kj36Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BmtZEJAVcL0JNDPoU81XWnwjwVnlJm4EnocxpMI/CSSiNOynwxOgkkr53oQyF05yO3gqN+GqmgA50XeV16/CYCnEMqmzX8TwTPfsunXgwWH9oDgufKzZYqUfdcIfNbivjOAv9Bsm1uNZH5mLjehBS5YNkI2svpg3gbNIj+BKS/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYBOrEMZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYBOrEMZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2821F00A3A;
	Tue,  8 Sep 2026 14:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788876997;
	bh=dDl8k28BkqvUuj5SycjiaptxKSJ1KL7RReFMsthC/x8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WYBOrEMZVYfvRp2bTElT91tWP2w3mjQ3DqLFuy9ywhTGVS7MAdJlnog8r9vzj1oXC
	 HmF8jHs+rv+2Nul3Ff/XZPMj22psFPyOcl/Y1Ekwc+FNi4lW+pYD9ShqpZAIPFKgCm
	 0AybiXqH0NhftgZuaAJhKrR6fl59IjsWePSeFRR90/f2IyFxwcaF4lnqvhsDdHndEy
	 DoEIwN4xwWZT7UW6PWfD8e3lSC0+88c4iZth1xVA3AVC9XrZ1JzmQPHSY0z5KEwHUV
	 G/iVeUwB2ujK1xc/3XbbHBKbE5DMnUi0gBCaw5nVABDS3lj9nERYA5KN4RRonWcXt2
	 aniVxj1iUtl3Q==
Subject:
 Re: [PATCH net v3] net: pin protocol module before inet socket allocation
From: netdev-bot+sashiko@kernel.org
To: nicoyip.dev@gmail.com
Cc: edumazet@google.com, kuniyu@google.com, pabeni@redhat.com,
 willemb@google.com, davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 08 Sep 2026 14:16:36 +0000
Message-ID: <178887699602.219967.13594894510710999619@kernel.org>
In-Reply-To: <20260904111514.584264-1-nicoyip.dev@gmail.com>
References: <20260904111514.584264-1-nicoyip.dev@gmail.com>
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
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 0

- [High] The newly added `module_is_coming(answer_owner)` rejection in
  `inet_create()` (net/ipv4/af_inet.c) and `inet6_create()`…

--

net: pin protocol module before inet socket allocation

The patch caches answer->prot and its owner module while still under
rcu_read_lock() in inet_create() and inet6_create(), rejects an owner that
is in MODULE_STATE_COMING, and otherwise pins the module with
try_module_get() before dropping RCU. The temporary reference is dropped
after sk_alloc() via a new out_module_put label.

Link: https://lore.kernel.org/netdev/20260825172349.232794-1-nicoyip.dev@gmail.com/ [v2]
Link: https://lore.kernel.org/netdev/20260823171311.3857087-1-nicoyip.dev@gmail.com/ [v1]

> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index 32d006c1a8eed..6b87f0b6cc222 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c

[ ... ]

> @@ -322,9 +323,16 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
>  	    !ns_capable(net->user_ns, CAP_NET_RAW))
>  		goto out_rcu_unlock;
>  
> -	sock->ops = answer->ops;
>  	answer_prot = answer->prot;
> +	answer_owner = answer_prot->owner;
>  	answer_flags = answer->flags;
> +	if (answer_owner &&
> +	    (module_is_coming(answer_owner) ||
> +	     !try_module_get(answer_owner))) {
> +		err = -EPROTONOSUPPORT;
> +		goto out_rcu_unlock;
> +	}
> +	sock->ops = answer->ops;
>  	rcu_read_unlock();

[Severity: High]
Can this module_is_coming() rejection break modular protocols that create
a socket for their own protosw from their own module init path?

module_is_coming() is true for the whole duration of the owner module's
init function:

include/linux/module.h:
static inline bool module_is_coming(struct module *mod)
{
        return mod->state == MODULE_STATE_COMING;
}

kernel/module/main.c sets MODULE_STATE_COMING before calling
do_init_module(), and only sets MODULE_STATE_LIVE after mod->init()
returns.

SCTP (CONFIG_IP_SCTP=m) looks like it hits this. sctp_init() publishes the
protosws first and then calls register_pernet_subsys(), which runs the
.init hook immediately for existing net namespaces:

net/sctp/protocol.c:sctp_init() {
	...
	status = sctp_v4_protosw_init();
	...
	status = sctp_v6_protosw_init();
	...
	status = register_pernet_subsys(&sctp_ctrlsock_ops);
	if (status)
		goto err_register_ctrlsock;
	...
}

so sctp_ctrlsock_init() -> sctp_ctl_sock_init() runs inside sctp_init(),
while sctp.ko is still MODULE_STATE_COMING:

net/sctp/protocol.c:sctp_ctl_sock_init() {
	...
	err = inet_ctl_sock_create(&net->sctp.ctl_sock, family,
				   SOCK_SEQPACKET, IPPROTO_SCTP, net);

	/* If IPv6 socket could not be created, try the IPv4 socket */
	if (err < 0 && family == PF_INET6)
		err = inet_ctl_sock_create(&net->sctp.ctl_sock, AF_INET,
					   SOCK_SEQPACKET, IPPROTO_SCTP,
					   net);
	...
}

inet_ctl_sock_create() goes through sock_create_kern() -> __sock_create()
-> inet6_create()/inet_create(), and the new check does not exempt kern
sockets. sctp_prot.owner and sctpv6_prot.owner are THIS_MODULE, which is
non-NULL for a modular build, so both attempts would return
-EPROTONOSUPPORT, sctp_ctrlsock_init() would print "Failed to initialize
the SCTP control sock", register_pernet_subsys() would propagate the
error, and sctp_init() would unwind. Would modprobe sctp then fail
outright?

There is a note about exactly this pattern above module_is_coming():

include/linux/module.h:
/* FIXME: It'd be nice to isolate modules during init, too, so they
   aren't used before they (may) fail.  But presently too much code
   (IDE & SCSI) require entry into the module during init.*/

Separately, for tasks that are not the loading task: once a modular
protocol has published its protosw but has not finished init, a concurrent
socket() finds the protosw, so the existing try_loading_module /
request_module() retry loop is not entered (the lookup succeeded), and the
caller gets -EPROTONOSUPPORT for what is a transient state. Should that
window either succeed or wait rather than returning a user-visible error?

One correction to the reasoning behind this concern: the ipv6 module case
does not apply in this tree. menuconfig IPV6 in net/ipv6/Kconfig is bool
and inet6_init is registered with device_initcall(), so rawv6_prot.owner is
NULL and the answer_owner && test short-circuits. The inet6_create() site
below is still reached by SCTP's first PF_INET6 control-socket attempt,
whose proto owner is the still-coming sctp module.

> diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
> index 282912a119999..1df8b2e7e2437 100644
> --- a/net/ipv6/af_inet6.c
> +++ b/net/ipv6/af_inet6.c

[ ... ]

> @@ -167,9 +168,16 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
>  	    !ns_capable(net->user_ns, CAP_NET_RAW))
>  		goto out_rcu_unlock;
>  
> -	sock->ops = answer->ops;
>  	answer_prot = answer->prot;
> +	answer_owner = answer_prot->owner;
>  	answer_flags = answer->flags;
> +	if (answer_owner &&
> +	    (module_is_coming(answer_owner) ||
> +	     !try_module_get(answer_owner))) {
> +		err = -EPROTONOSUPPORT;
> +		goto out_rcu_unlock;
> +	}
> +	sock->ops = answer->ops;
>  	rcu_read_unlock();

[Severity: High]
Same question here for the IPv6 path: this is the site reached by
sctp_ctl_sock_init()'s first attempt, inet_ctl_sock_create(..., PF_INET6,
SOCK_SEQPACKET, IPPROTO_SCTP, net), where sctpv6_prot.owner is the sctp
module in MODULE_STATE_COMING. Does that attempt now return
-EPROTONOSUPPORT before the AF_INET fallback, which then fails for the same
reason?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904111514.584264-1-nicoyip.dev%40gmail.com
