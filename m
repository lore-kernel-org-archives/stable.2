Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC064215F42;
	Fri,  4 Sep 2026 00:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788481959; cv=none; b=OSMDQAh8soKX/w13uS0YtTr/t9VtOGU+dyovZdW3OB7+Qn2+1Oay/v+Q7qjsRa4BsJlYOG96x+19TNRo1UZZLyuU3MfEFsTUq1O8b0ytxUvfTLoNs6l0Uouu45roHOgnXaSa3WS00RN8adbabbQwJp/PXN93dF5IONx4zTh7KRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788481959; c=relaxed/simple;
	bh=M//HIzRqDWlwJh/TjD7otWIm5cnVlSDB2nY2IMjxWTs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UJBwnSEoaPK2CuGrSyJjdiQsKTiy4DZYhDtT6uY/ILq3GiG/BGfXFzQ+z5uF/SeHnG2xjmefqhi/CyVfEJBqqOFHl1bnlLS/Kv33zJupEBhKttSdolyCnqQd6liqSV0LI8iqG4/PhYA9uQtFzFFUzhh21NjrsMH2lRteXpuLpAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7f4EW4x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7f4EW4x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7011F000E9;
	Fri,  4 Sep 2026 00:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788481957;
	bh=SXGEDQb1FzFyykcjAztV2IlMDhLXBWPb4STL+eDGpwU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=P7f4EW4xAIuTVq9iQryC5tglVidZpU12Vs9z9epVS2Tj9h1Eds0b5uPhh26f0TQKO
	 A3PcEvK9rf3NxvYRmMSxh5VnDoZBeQme2KQ2IjoVwLPWKHHcrsyQcXwp/HebDmeZrd
	 aFN3qtp6qDYUhW0eSQDMGjx0wSi9tKSnzU88lm67w3GN0s4rZ8wWo5eh8cTWfOHH/S
	 FPK62E9jSRNW0mrTBRv+vKJ0j0gNkncbGQz3IoAb+T0+yC/VHqExkW2kQdPuopR8ea
	 8v6TfJ1zhgoW1obEu6Y0F1C6GUTpMQnjG6MCJ24/scXaFnlZM1R7yW4Qu4rmkwyWac
	 IvgNsXxl2wXWw==
Subject: Re: [PATCH net v4] net: reduce XMIT_RECURSION_LIMIT under KASAN
From: netdev-bot+sashiko@kernel.org
To: tristmd@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, maheshb@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 tristan@talencesecurity.com
Date: Fri, 04 Sep 2026 00:32:36 +0000
Message-ID: <178848195669.4131868.5819360865837330892@kernel.org>
In-Reply-To: <20260902123040.2172805-1-tristmd@gmail.com>
References: <20260902123040.2172805-1-tristmd@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 2 · Low: 0

- [High] The new KASAN value XMIT_RECURSION_LIMIT=4
  (include/linux/netdevice.h:3673) is sized as if…
- [Medium] The reduction is gated on the umbrella symbol CONFIG_KASAN
  (include/linux/netdevice.h:3672), which is also set for…
- [Medium] The patch lowers only XMIT_RECURSION_LIMIT (to 4 under
  CONFIG_KASAN) and leaves IP_TUNNEL_RECURSION_LIMIT at 5…

--

net: reduce XMIT_RECURSION_LIMIT under KASAN

This halves XMIT_RECURSION_LIMIT from 8 to 4 when CONFIG_KASAN is set, on
the grounds that KASAN-inflated stack frames overflow the 32KB KASAN stack
before the existing limit of 8 fires.  The changelog states that a limit of
4 still permits the 5 levels of __dev_queue_xmit nesting used by the VXLAN
symmetric selftests, while a limit of 3 (v2/v3) broke them.

> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 87cafc932e9e6..3ccd1e65bcd9e 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3669,7 +3669,11 @@ struct page_pool_bh {
>  };
>  DECLARE_PER_CPU(struct page_pool_bh, system_page_pool);
>  
> +#ifdef CONFIG_KASAN
> +#define XMIT_RECURSION_LIMIT	4
> +#else
>  #define XMIT_RECURSION_LIMIT	8
> +#endif

[Severity: High]
Is the new value of 4 actually enough for the topology quoted in the
changelog?

The counter compared against XMIT_RECURSION_LIMIT is not a count of
__dev_queue_xmit() nesting only.  dev_xmit_recursion() reads
softnet_data.xmit.recursion, and the tunnel and BPF helpers increment that
same counter:

include/linux/netdevice.h:
	static inline bool dev_xmit_recursion(void)
	{
		return unlikely(__this_cpu_read(softnet_data.xmit.recursion) >
				XMIT_RECURSION_LIMIT);
	}

net/ipv4/ip_tunnel_core.c:iptunnel_xmit() {
	...
	dev_xmit_recursion_inc();
	...
	err = ip_local_out(net, sk, skb);
	...
}

In the vrf -> vlan-svi -> bridge -> vxlan -> veth chain from the changelog,
vxlan_xmit_one() -> udp_tunnel_xmit_skb() -> iptunnel_xmit() adds one
increment between the 4th and the 5th __dev_queue_xmit().  All five devices
are IFF_NO_QUEUE, so each one also takes the check-and-increment branch in
__dev_queue_xmit().  Does the counter therefore reach 5 by the time
__dev_queue_xmit(veth) runs its check, making 5 > 4 true and sending the
packet to recursion_alert:

net/core/dev.c:__dev_queue_xmit() {
	...
recursion_alert:
		net_crit_ratelimited("Dead loop on virtual device %s (net %llu), fix it urgently!\n", ...);
		rc = -ENETDOWN;
	...
}

If so, the 5th level is dropped exactly as with the limit of 3 in v2/v3 that
the changelog says broke vxlan_symmetric/vxlan_asymmetric, and the KASAN
limit would need to be 5 or higher (or a counter dedicated to
__dev_queue_xmit nesting) for the documented worst case to pass.

The same extra unit of the shared budget is consumed by ip6tunnel_xmit() for
IPv6 tunnels, by the lwtunnel output/xmit/input paths, and by
__bpf_tx_skb() -> dev_queue_xmit(), so IPv6 and BPF-redirect variants of
these topologies would lose a level too.

[Severity: Medium]
Should the reduction key on CONFIG_KASAN, or on the KASAN modes that
actually grow stack usage?

CONFIG_KASAN is also set for Hardware Tag-Based KASAN, where neither the
stack size nor the per-frame usage changes:

arch/arm64/include/asm/memory.h:
	#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
	...
	#define KASAN_THREAD_SHIFT	1
	#else
	#define KASAN_THREAD_SHIFT	0
	#endif
	#define MIN_THREAD_SHIFT	(14 + KASAN_THREAD_SHIFT)

lib/Kconfig.kasan:
	config KASAN_STACK
		bool "Stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST
		depends on KASAN_GENERIC || KASAN_SW_TAGS

So an arm64 CONFIG_KASAN_HW_TAGS=y build keeps MIN_THREAD_SHIFT at 14 (the
same 16KB stack as a non-KASAN kernel) and cannot enable stack
instrumentation, yet the transmit recursion budget drops from 8 to 4.  Does
that make dev_xmit_recursion() reject nesting depths that the
identically-sized non-KASAN kernel forwards, dropping packets with
-ENETDOWN / SKB_DROP_REASON_RECURSION_LIMIT via recursion_alert in
__dev_queue_xmit()?  Would gating on CONFIG_KASAN_GENERIC ||
CONFIG_KASAN_SW_TAGS (or CONFIG_KASAN_STACK) be more accurate?

[Severity: Medium]
This change also leaves the tunnel limit and its comment out of sync.

include/net/ip_tunnels.h still says:

	/* Recursion limit for tunnel xmit to detect routing loops.
	 * Unlike XMIT_RECURSION_LIMIT (8) used in the no-qdisc path, tunnel
	 * recursion involves route lookups and full IP output, consuming much
	 * more stack per level, so a lower limit is needed.
	 */
	#define IP_TUNNEL_RECURSION_LIMIT	5

On CONFIG_KASAN builds the quoted value of 8 is no longer correct, and the
documented ordering is inverted since 5 > 4.  Both limits are compared
against the same counter through dev_recursion_level() /
dev_xmit_recursion().  Should the comment be updated, or should
IP_TUNNEL_RECURSION_LIMIT be made KASAN-aware as well?

Related to that: the generic check is only reached in the noqueue branch of
__dev_queue_xmit():

net/core/dev.c:__dev_queue_xmit() {
	...
	q = rcu_dereference_bh(txq->qdisc);
	trace_net_dev_queue(skb);
	if (q->enqueue) {
		rc = __dev_xmit_skb(skb, q, dev, txq);
		goto out;
	}
	...
}

GRE/ipip/sit devices are not IFF_NO_QUEUE, so a routing loop through them is
bounded only by IP_TUNNEL_RECURSION_LIMIT and still gets 6 nested levels of
the heaviest frames (full route lookup plus IP output) on a KASAN kernel.
Does the new limit have any effect on those loops, given that the changelog
describes stack overflow as the problem being closed?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902123040.2172805-1-tristmd%40gmail.com
