Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96BE47533F;
	Wed, 14 Oct 2026 08:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966704; cv=none; b=b4VTCHN707zq54EEXi0m7aNPG6xh+/s6770xNEAI6XDILi3hQ1hQhXlStqSF17tHIYMxoJhggcWRtRa7n58ATWU3f0df9p/lzTutNV6x7Sw7zOM3TaBJUvJRKjg5ZUOlGLngQDJYOTSrK9o88CTc1uYpiguOeedcuj2vZAbEEfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966704; c=relaxed/simple;
	bh=C8W9JgVIYssovpPEU0zGJaK4UFyFY6BOZNGPv8+7rHA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eEHxMGCq4zRKDL59W2je1b4HdvaLJlzByV1Cs3K+E5Eib16NX7DnYu8ktqMP64n9SaoZp515KPespKgxscSuDGqNSJTfAxfixuZ/EPgj1rU08e6Qz1FQPrGahwo+cKH6/bxMVE7wFdxovAsLfYp8gEGi/uihJIR32u5i37d2tGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0gcTCzY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0gcTCzY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3221F000FF;
	Wed, 14 Oct 2026 08:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791966702;
	bh=nP5271TdDq5mtSWPhA6h1o7lRTe2O9XyNw7JqWW1dGA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=h0gcTCzYZ/zfuU0RH/BpssNUvTwHnnutT7XZrodgJOy7CRSU5ddaaoVdO8mM+SD2k
	 E0qmta3BF8qawVSOlwa3U3la4tLXkZStoifLpi8B5dZwdB9rxFBvVn2yEled+knD5z
	 Didc8MU7tygKYAm38Y1xnOdpJ4UjkpoO9FVO7sw3DBGpa2BlEdr1G9H+5XgQcYa9Dr
	 SC5Tbl5jjeMYh7IJFaWDxTQXKCkpNqY8VnKJsbKgbR4oHZTx+wyo1/aO+IU+VBYdXI
	 xqdC1XuKQ/dhp3QU0JhAuqkffZ5YtH7h1mOmvRWdk9v8FlXFOI5qyq08N39HqINLvm
	 EtOAFb9cGYf1A==
Subject:
 Re: [PATCH net v5] net: pin protocol module before inet socket allocation
From: netdev-bot+sashiko@kernel.org
To: nicoyip.dev@gmail.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, kuniyu@google.com, horms@kernel.org, fmancera@suse.de,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 14 Oct 2026 08:31:41 +0000
Message-ID: <179196670122.434549.312785395247126647@kernel.org>
In-Reply-To: <20261013075604.868273-1-nicoyip.dev@gmail.com>
References: <20261013075604.868273-1-nicoyip.dev@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch closes the failed-module-init lifetime race only for
  userspace sockets.
- [Medium] A userspace socket() call can now fail with -EPROTONOSUPPORT
  even though the protocol module is loading successfully.

--

net: pin protocol module before inet socket allocation

This patch takes a temporary module reference on the protocol owner in
inet_create() and inet6_create() before dropping RCU, so a concurrent
module unload cannot destroy the proto slab before sk_alloc() uses it. It
also rejects userspace socket creation while the owner module is still
MODULE_STATE_COMING, and exempts kernel sockets from that check.

> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index 14ce01092fda6..5c02022c6c182 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c

[ ... ]

> @@ -322,9 +323,15 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
>  	    !ns_capable(net->user_ns, CAP_NET_RAW))
>  		goto out_rcu_unlock;
>  
> -	sock->ops = answer->ops;
>  	answer_prot = answer->prot;
> +	answer_owner = answer_prot->owner;
>  	answer_flags = answer->flags;
> +	if ((!kern && answer_owner && module_is_coming(answer_owner)) ||
> +	    !try_module_get(answer_owner)) {
> +		err = -EPROTONOSUPPORT;
> +		goto out_rcu_unlock;
> +	}

[Severity: Medium]
Can a userspace socket() call now fail with -EPROTONOSUPPORT while the
protocol module is loading and will finish successfully?

do_init_module() sets MODULE_STATE_LIVE only after mod->init() returns.
Anything published from inside init is therefore seen as COMING until
then.

Before this patch, the only check was try_module_get(prot->owner) in
sk_prot_alloc(). module_is_live() only rejects MODULE_STATE_GOING, so that
check succeeds for COMING modules and the socket was created.

For SCTP, sctp_init() publishes the protosw early and does more work after
that:

net/sctp/protocol.c:sctp_init() {
    ...
	status = sctp_v4_protosw_init();
    ...
	status = sctp_v6_protosw_init();
    ...
	status = register_pernet_subsys(&sctp_ctrlsock_ops);
    ...
}

register_pernet_subsys() creates a control socket in every netns.
sctp_v4_add_protocol(), sctp_v6_add_protocol() and sctp_offload_init()
come after it. So the window gets longer as the number of network
namespaces grows.

Suppose a daemon calls socket(AF_INET, SOCK_STREAM, IPPROTO_SCTP) while
modules-load.d, or another socket() autoload, is loading sctp. It would
now get EPROTONOSUPPORT, and applications usually read that as "protocol
not supported" and do not retry.

A second concurrent autoloader can hit this too. If its request_module()
returns while the module is still COMING, the retried lookup finds the
protosw and this check then fails the call.

Would it work to drop RCU, wait on module_wq until the owner leaves
MODULE_STATE_COMING, and then retry the lookup, instead of returning an
error straight away? inet6_create() in net/ipv6/af_inet6.c has the same
check.

[Severity: High]
Does the !kern short-circuit leave the failed-init case open for kernel
sockets created by other subsystems?

The commit message justifies the exemption with SCTP's own per-netns
control sockets. Those are destroyed by sctp_init()'s unwind through
unregister_pernet_subsys(&sctp_ctrlsock_ops). However, every kern caller
skips the COMING check, and try_module_get() succeeds on a COMING module.

DLM, for example, creates SCTP sockets with kern set:

fs/dlm/lowcomms.c:dlm_connect() {
    ...
	result = sock_create_kern(&init_net, dlm_local_addr[0].ss_family,
				  SOCK_STREAM, dlm_proto_ops->proto, &sock);
    ...
}

The DLM listen path does the same.

Consider this sequence:

1. sctp is COMING, and sctp_v4_protosw_init() has already published
   sctp_stream_protosw.

2. DLM's sock_create_kern() reaches inet_create() with kern=1 and skips
   the COMING check. try_module_get() succeeds, and sk_alloc() allocates
   from sctp_prot.slab.

3. A later step in sctp_init() fails, for example ENOMEM in
   register_pernet_subsys(&sctp_ctrlsock_ops), or a failure in
   sctp_v4_add_protocol() or sctp_v6_add_protocol(). The unwind runs:

	err_register_ctrlsock:
		sctp_v6_protosw_exit();
	err_v6_protosw_init:
		sctp_v4_protosw_exit();

   This reaches proto_unregister(&sctp_prot), which calls
   kmem_cache_destroy(prot->slab) while the DLM socket is still allocated
   in that cache.

4. The failure path in do_init_module() sets MODULE_STATE_GOING and calls
   synchronize_rcu() and module_put(). It then calls free_module()
   regardless of the remaining refcount.

After that, does the DLM socket's sk->sk_prot point into freed module
memory? If so, the next sendmsg, close or release on it would be a
use-after-free.

Neither the temporary reference added here nor the one taken in
sk_prot_alloc() stops free_module() on that failure path.

The underlying race is older than this patch. But the commit message
lists failed module initialization as a case this patch handles, and the
kern exemption keeps it reachable. Should the COMING rejection also apply
to kern sockets that the owning module did not create itself? The same
question applies to inet6_create().

> +	sock->ops = answer->ops;
>  	rcu_read_unlock();
>  
>  	WARN_ON(!answer_prot->slab);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013075604.868273-1-nicoyip.dev%40gmail.com
