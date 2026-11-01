Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793525532;
	b=souXFDdMs/OXy225xXish9rGM4Zlo9yWJHLuLUdK6PduleC97nr9maFa4YXPv4LnttRg
	 4tDAoNVBauUMakRRStD89vys4INdh2prEFHkSVBvEk2aS7JPevE7nsSGwa35KRjt/6+6r
	 AsP32GLUs1SkFyWDKtjQYYaRyLjEzn4ttsasr0+n3mWaIhahypQ6HHIpUmM0shxUpw+Pt
	 i3jfrAwnkLl+KIRvy74P6fDFrs7FpNY7cRHNDrH1XPoc2XE99cILsroEKnB2sV+r+rsnd
	 xmFx8yrUMBYAmBNvPIjn7St/1BxHXXiEb1D1LViXj/p/SKIiGNBtYLQgUbnGqmC56LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793525532;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=BfOppHSMHd40VVAofaOH1a1+TKTbbwvAtZJDZ0+ZsUM=;
	b=AK8FrXhem0xXNJ38N788dba2V40YuRfKLnvyPnTT3dD7llBghZp3/KFbKSOyLSmpp14f
	 Nnr365juKwW7dg8dsnuDTxPSNUhTJ7e0Iq42/nBOiggDhZhtx70NwV6VbKCVVz1E+C+sS
	 VsJ9AxMUYEASH+BjDnKOVMLvAdtzqCSeTCM5FFnrN4qQV3oDMVuK9+QwNmAlQMfeEYzNz
	 arYAvZGTjC88IWuMNqaJmvthWQw6PnBv+vopWsyS1LJo8tWSbdOpBH91pieB96ZFsm5Om
	 mwKbRS9UyU1KIpXkRvXQ6JiKlnvh/Exx2k3+dU51Q3yJXCcB4Z34nsp7u5BORq1dSjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mG8ODZgs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B77606A324;
	Sun,  1 Nov 2026 09:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mG8ODZgs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026801F000C1;
	Sun,  1 Nov 2026 09:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793525531;
	bh=BfOppHSMHd40VVAofaOH1a1+TKTbbwvAtZJDZ0+ZsUM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mG8ODZgsfE09gOUhcnav6h9O3t75df9ocm+xFngMd3fiWI49HTol93aCLvr+dMToe
	 TRdncPb83nzQ9OCXzKVqRAgvaaf57+gj50phV4BtLGVfusRObTZb5jgFGJdcWZH9y3
	 OQA/wyMAba+iB8ybq9mMul8kAH7wfLjI3ifgkysJGhm4Bhci6H+HoI3nYNbPIgNjpK
	 tSBaWhpovUKX+dHgx3E7Y4CCJ/RqFSgYL/fXLc/lEwVEm06l8bpDMr/YZA3BAcQfKy
	 o0TLobjI3GDoLoJh/PqUFqhCiOjKSBvVecC3VOse0q3E3T2rFuXFlPY6ZJBOvxyens
	 2jodF3+g7FIxw==
Subject: Re: [PATCH net] bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, edumazet@kernel.org, bpf@vger.kernel.org,
 stable@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org,
 dsahern@gmail.com, kafai@fb.com, martin.lau@linux.dev,
 john.fastabend@gmail.com, sdf@fomichev.me, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jiri@resnulli.us, victor@mojatatu.com
Date: Sun, 01 Nov 2026 09:32:09 +0000
Message-ID: <179352552950.3131.18338438529583349627@kernel.org>
In-Reply-To:
 <bpf_redirect_neigh_short_linear.v1.r0.20261028033717-1@mojatatu.com>
References:
 <bpf_redirect_neigh_short_linear.v1.r0.20261028033717-1@mojatatu.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 0 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new `skb->mac_len < ETH_HLEN` test in __bpf_redirect_neigh()
  (net/core/filter.c:2439) breaks bpf_redirect_neigh() for locally…
- [High] The same short-L2 skb from the commit message still hits the
  __skb_pull() BUG if the program calls bpf_redirect() instead of…

Pre-existing issues:
- [Low] Concern: after pulling the Ethernet header,
  __bpf_redirect_neigh_v4()/__bpf_redirect_neigh_v6() read…

--

bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()

This patch adds a check to __bpf_redirect_neigh() that drops skbs whose
mac_len is shorter than ETH_HLEN. It also calls pskb_may_pull() so the
Ethernet header is linear before it is read and pulled. The goal is to
avoid the __skb_pull() BUG that a TC program can trigger with
bpf_skb_change_head(skb, 1, 0) after vlan pop_eth.

Link: https://lore.kernel.org/netdev/20261027082604.1485903-1-edumazet@kernel.org/

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 70dc621672f2e..4d344ec097361 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2432,10 +2432,14 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
>  static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_device *dev,
>  				struct bpf_nh_params *nh)
>  {
> -	struct ethhdr *ethh = eth_hdr(skb);
> +	struct ethhdr *ethh;
>  
>  	if (unlikely(skb->mac_header >= skb->network_header))
>  		goto out;
> +	if (unlikely(skb->mac_len < ETH_HLEN ||
> +		     !pskb_may_pull(skb, ETH_HLEN)))
> +		goto out;

[Severity: High]
Can this check drop valid locally generated packets when
bpf_redirect_neigh() is called from TC egress (clsact or tcx)?

As far as I can tell, skb->mac_len is only set on the receive path, by
skb_reset_mac_len() in __netif_receive_skb_core() and by a few BPF helpers.
The transmit path never sets it. __dev_queue_xmit() only does:

    skb_reset_mac_header(skb);

The IPv4/IPv6 output, neighbour and eth code don't touch mac_len either.
That means a locally created skb still has mac_len == 0 from allocation.
Clones, such as TCP retransmit clones, inherit that 0 through C(mac_len) in
__skb_clone().

Such an skb has a valid 14 byte linear Ethernet header. With this patch it
still takes the goto out path, gets freed, and -ENOTSUPP is returned. The
return value is then ignored in sch_handle_egress():

	case TC_ACT_REDIRECT:
		/* No need to push/pop skb's mac_header here on egress! */
		skb_do_redirect(skb);
		*ret = NET_XMIT_SUCCESS;

So the packet is dropped silently and the sender is told the transmit
succeeded. Forwarded packets still pass the check because the RX path set
mac_len to 14.

Other TC code already avoids mac_len at egress. tcf_mirred_to_dev() does:

		mac_len = at_ingress ? skb->mac_len :
			  skb_network_offset(skb);

and bpf_push_mac_rcsum() only reads mac_len when skb_at_tc_ingress() is
true.

skb->data == mac_header on both paths here. Would checking
skb_network_offset(skb) < ETH_HLEN (or skb_mac_header_len(skb)) work
instead? Another option is to use pskb_may_pull(skb, ETH_HLEN) together
with the mac_header/network_header distance, and not use the cached
mac_len at all.

The existing selftests (test_tc_neigh*.c, test_tc_dtime.c) only call this
helper from ingress, so they would not catch this.

> +	ethh = eth_hdr(skb);
>  	bpf_push_mac_rcsum(skb);
>  	if (is_multicast_ether_addr(ethh->h_dest))
>  		goto out;

[Severity: High]
Can the same short L2 header BUG still be hit through bpf_redirect()?

__bpf_redirect_common() has the same weak check that the commit message
calls insufficient:

net/core/filter.c:__bpf_redirect_common() {
	/* Verify that a link layer header is carried */
	if (unlikely(skb->mac_header >= skb->network_header || skb->len == 0)) {
		kfree_skb(skb);
		return -ERANGE;
	}
	...
}

Take the skb from the commit message (mac_len == 1, one linear byte,
skb->len >= 14). If the program calls bpf_redirect(ifindex, BPF_F_INGRESS)
in place of bpf_redirect_neigh(), the path looks like this:

skb_do_redirect()
  __bpf_redirect()
    __bpf_redirect_common()
      __bpf_rx_skb()
        dev_forward_skb_nomtu()
          __dev_forward_skb2()
            eth_type_trans()
              eth_skb_pull_mac()
                skb_pull_inline(skb, ETH_HLEN)
                  __skb_pull()  -> BUG()

____dev_forward_skb() only calls skb_orphan_frags() and
__is_skb_forwardable(), and neither of those linearizes the skb. Without
BPF_F_INGRESS, the egress path to lo or veth reaches eth_type_trans() in
the driver's xmit routine the same way.

If the linked series from Eric already covers __bpf_redirect_common() or
eth_type_trans(), it would handle this case. In this tree, though, neither
__bpf_redirect_common() nor eth_skb_pull_mac() has such a guard.

Should __bpf_redirect_common() get the same pskb_may_pull(skb, ETH_HLEN)
check?

[Severity: Low]
This is a pre-existing issue and was not introduced by this patch. After
the Ethernet pull, __bpf_redirect_neigh() dispatches on skb->protocol
without checking how much data is left:

	if (skb->protocol == htons(ETH_P_IP))
		return __bpf_redirect_neigh_v4(skb, dev, nh);
	else if (skb->protocol == htons(ETH_P_IPV6))
		return __bpf_redirect_neigh_v6(skb, dev, nh);

__bpf_redirect_neigh_v4() and __bpf_redirect_neigh_v6() then read header
fields to build the flow key, without pskb_may_pull(skb,
sizeof(struct iphdr)) or the ipv6hdr equivalent:

net/core/filter.c:__bpf_redirect_neigh_v4() {
	const struct iphdr *ip4h = ip_hdr(skb);
	...
		.flowi4_proto = ip4h->protocol,
		.daddr	      = ip4h->daddr,
		.saddr	      = ip4h->saddr,
	...
}

If a program trims the skb down to only the L2 header, or the L3 header
sits in frags, can these reads go past skb->tail?

The reads appear to stay inside the head allocation (tailroom plus
skb_shared_info). So the result would be a garbage route/neighbour lookup,
not a memory safety problem.

Would it make sense to add an L3 pskb_may_pull() while hardening this path?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/bpf_redirect_neigh_short_linear.v1.r0.20261028033717-1%40mojatatu.com
