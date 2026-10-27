Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793087587;
	b=l8lWumdlRlSU2KoRbvF5/ljqPGIJK6LJ3AhMkKFzD0SqaEj/33sJH+8JEvDTZ6NtSMxD
	 AdrmpUblTYhGndmmvTABQXlRdKNGaS4AewC4UDJsv9b7wf+BAfUzQUULVqIj1nmVd/1Si
	 0g0p2KLPXry2mqugBHi/TzVdSyqFn10WV8bff5i8ADUgRwRb47sH6lXRLZcQQQY9mjfrI
	 QNyCnLLR5YrMKoWlCiGfn2F6AkkbTWDc0otzjdJcVpNdSpy9qjwUsApc+Dzw51vNzy9On
	 iqAcqWLf+0yOh+MNZ4BzcZ+58BaSpUB6y5OO/0S8KjcROlZVe4XGbRqRAOx7ZZmz1Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793087587;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ncow6dC6njzXXu7ufdlagYld5QtR81SFHe3xp8WHXz0=;
	b=ILyBbZzIoSTfCHo0P3pYJ0ZtXrnOTylIXW5aKmz3yIzC1pd4lbkZkiCFi1Fj/87fDklS
	 ewBaLJZtcCmQWibPB5oOybXaqU0IlgON8jcdJZ3E0L659w1FaZjxS1g7xInUjSSADv8Zt
	 QiZGnkTkq9AFR/QuSepA95E5Hzhp1LwhygkofEBWo7/5RZI8S16Z/nkgzTHFQ2uR9N2D0
	 gPSq31dhE63N7YxJpN584UPig5d/RWsPHyYggEoJGJf34wJcpNCmoLAGWFCCIz8y13IdD
	 4skk9WAvQb1vJb8Zri2vR92axG1tRU87vPi0xuJ6nZ4j1Hco6p0ptzlWvC/ExkodWqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gA+3QMcY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9140606A31A;
	Tue, 27 Oct 2026 07:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gA+3QMcY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54741F01825;
	Tue, 27 Oct 2026 07:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793087586;
	bh=ncow6dC6njzXXu7ufdlagYld5QtR81SFHe3xp8WHXz0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gA+3QMcYGunpp8qEs97x0hj+GghziZhSZhMcpYbjotXLOt73SajsBeKk+ElEhrlQZ
	 Brh3757vexEnAQZmh7AbYTgUSj0wL6x/GQKtwjmnyGIdrwueJ+Xz7+D20yuqHqBg9e
	 qbCt9kW7ymHV7htpGYSQR761ckLOmVBHpuxUiVlMNwEq/4KQdU45qPy36Yzg1keodW
	 kBrYC+j9E8a/L8Sdu5BoOBAYJXh4J0gMuAO0x57W8sCLFvR6pv4BX0pg8gcOUEBgia
	 k20nJWabBVzRj9GnoeFtBG29g6SgWhtCkVm2UUSuUw3w3g0c+QjWCWq8X6GDWihFtI
	 xmmU7CgAzpRNg==
Subject: Re: [PATCH net] seg6: fix tun_src RCU lifetime on namespace teardown
From: netdev-bot+sashiko@kernel.org
To: tristmd@gmail.com
Cc: andrea.mayer@uniroma2.it, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 david.lebrun@uclouvain.be, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 tristan@talencesecurity.com
Date: Tue, 27 Oct 2026 07:53:05 +0000
Message-ID: <179308758546.3134.12594467353635303069@kernel.org>
In-Reply-To: <20261023195234.3524462-1-tristmd@gmail.com>
References: <20261023195234.3524462-1-tristmd@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 1 · High: 0 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] The patch adds a reachable NULL pointer dereference on the
  seg6 datapath during netns teardown.

--

seg6: fix tun_src RCU lifetime on namespace teardown

This patch adds a pre_exit callback to seg6 pernet ops. The callback
saves the per-netns tun_src pointer in a new tun_src_old field and then
clears the RCU pointer. The exit callback frees tun_src_old after the
grace period that runs between pre_exit and exit.

> diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
> index 8c2b156c227a7..670052290e43c 100644
> --- a/net/ipv6/seg6.c
> +++ b/net/ipv6/seg6.c
> @@ -447,18 +447,28 @@ static int __net_init seg6_net_init(struct net *net)
>  	return 0;
>  }
>  
> +static void __net_exit seg6_net_pre_exit(struct net *net)
> +{
> +	struct seg6_pernet_data *sdata = seg6_pernet(net);
> +
> +	/* Save tun_src for exit to free after the RCU grace period. */
> +	sdata->tun_src_old = rcu_dereference_raw(sdata->tun_src);
> +	RCU_INIT_POINTER(sdata->tun_src, NULL);

[Severity: Critical]
Can this cause a NULL pointer dereference in set_tun_src() while the
netns is being torn down?

set_tun_src() in net/ipv6/seg6_iptunnel.c assumes tun_src is never NULL.
If the route has no per-route tunsrc configured (the default), it does:

	rcu_read_lock();
	tun_src = rcu_dereference(sdata->tun_src);

	if (!ipv6_addr_any(tun_src)) {
		memcpy(saddr, tun_src, sizeof(struct in6_addr));

ipv6_addr_any() dereferences its argument in both config variants, so a
NULL tun_src faults there.

In ops_undo_list(), all pre_exit callbacks run first. After that comes
synchronize_rcu_expedited(), then ops_exit_rtnl_list(), then
ops_exit_list(). The netns devices are unregistered later, in
default_device_exit_batch() during the exit phase. That means the dying
netns keeps its registered devices and seg6 lwtunnel routes after
seg6_net_pre_exit() has published NULL.

A packet that arrives in that window, for example from a veth peer in a
live netns or from a physical NIC, would follow:

seg6_input_core() / seg6_output_core()
  -> seg6_do_srh()
    -> seg6_do_srh_encap() / seg6_do_srh_encap_red() / seg6_do_srh_inline()
      -> set_tun_src()
        -> ipv6_addr_any(NULL)

This runs in softirq or xmit context. The grace period does not close
the window, because it only waits for readers that already exist.
Readers that load the pointer after the clear still see NULL.

Before this patch, tun_src was never NULL between init and exit. Would
it be better to leave the pointer in place and keep the kfree() in
seg6_net_exit()? By the time exit runs, a grace period has already
passed.

seg6_genl_get_tunsrc() also passes the pointer to nla_put() without a
NULL check. That path is probably not reachable on a dying netns, since
a genl socket holds a netns reference.

> +}
> +
>  static void __net_exit seg6_net_exit(struct net *net)
>  {
>  	struct seg6_pernet_data *sdata = seg6_pernet(net);
>  
>  	seg6_hmac_net_exit(net);
>  
> -	kfree(rcu_dereference_raw(sdata->tun_src));
> +	kfree(sdata->tun_src_old);
>  	kfree(sdata);
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023195234.3524462-1-tristmd%40gmail.com
