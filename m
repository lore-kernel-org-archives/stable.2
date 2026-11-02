Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613147;
	b=ljo0Yag96jeFrtigak+fvxFQKJw3RzSjstH6QXPjQaxACxGt/W2siz7hv0Lk+u/SfcWU
	 igQYUGbvV7mVQ7lmiqWbBOYoy0jrnTpgevIq28J+re2F+y/j9DWxDVRELo0rvjK63bm3+
	 ahrHIXnSblcr0z17XDUV9vTX9lXptIxsam6Nrg+BHF/GUfp6dFanktwEJxyHvwf5qL+Yi
	 owEpcXHUdNA7vZQb7wTD5Gq6Lk4epC4BbNbNl38S3t0grgmGVvT9DzYH2Y08rG1oGQZ32
	 gaCTAHVvqIrqu8mWygDBiDsRn38PU0HrkU7a9ORvyJ2CW1M9u8doieZqKjDETQZ20hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613147;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=0J0BmS8+dLS8Lnfxixm46w2lRSFsoL6zql/BE+pRkys=;
	b=nUDYbSzWxy4HD81yhjRm7XzqtEl1Ru0hQ/qFaEpXB5NEYN5qcEJdjMq3avtYVk2NwQT8
	 52ojbtq5giQHJCV/5kP4hsdpEMX59UjiCBXDoS37DMUjUiB/89tOFLfDXDy7BnInH2b9+
	 IisDfhi8cPLyCmlugISf2RawZQp3A9OFL5qWJ3BuehmG4pt1G8cS5Pcr/O7izYpMwCGrV
	 ny4zEXoS4QpcH3u8KaOLj/hkiPL0ySk3v1i/IQjwiiYrpljZ6Kp757oUm5M43qGDsYQw7
	 k1U0z/IctAfhAhECLU63Wtmqk8fMmjC3oVerjGnyuHbBGgwUUK4ZaNY2ZxLdp9t9wWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fBzi8KrU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F6C606A329;
	Mon,  2 Nov 2026 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fBzi8KrU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2F31F000C1;
	Mon,  2 Nov 2026 09:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793613146;
	bh=0J0BmS8+dLS8Lnfxixm46w2lRSFsoL6zql/BE+pRkys=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fBzi8KrUITMMy/FxZ//4IX3xaa7J4BrBosrQDqYydu5b3QpyBV7XxvUVgYG2jH1kM
	 vdkb8jj1+YPi1tX4nep3zJIWBXYu562KFQpFWBXDQB5yn7RZbwFbPLSgcjVrpJuBIn
	 bu3snGE6mWq0oQOHlVwfbpUaKGj7CksNuW8S4ql0b+E8T1xO7cYrUldJPpIvE5q3Bi
	 E6l0KO/EeUHDNsAokeSzu6nEi0iETqU1q8l410eOMLHIZz0qP1Q1AImeCXojDk4Ghs
	 TRfVKR1ZXEtz4UsP8nlAdKDVUQIBJXHpzsFh/xLGUrij5yWqGnjOOmsyzubjjy6pq7
	 lnOjSSuVRIlxA==
Subject: Re: [PATCH net v2] bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, edumazet@kernel.org, bpf@vger.kernel.org,
 bot+bpf-ci@kernel.org, daniel@iogearbox.net, ast@kernel.org,
 dsahern@gmail.com, kafai@fb.com, martin.lau@linux.dev,
 john.fastabend@gmail.com, sdf@fomichev.me, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jiri@resnulli.us, victor@mojatatu.com, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, stable@vger.kernel.org
Date: Mon, 02 Nov 2026 09:52:24 +0000
Message-ID: <179361314430.3131.5109011406127069679@kernel.org>
In-Reply-To:
 <bpf_redirect_neigh_short_linear.v2.r0.20261028080316-1@mojatatu.com>
References:
 <bpf_redirect_neigh_short_linear.v2.r0.20261028080316-1@mojatatu.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 (1) · Medium: 1 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new netns_load_egress_bpf() calls inside
  test_tc_redirect_neigh() leave the test thread in the test runner's…
- [Low] No selftest runs the new rejection branch in
  __bpf_redirect_neigh() (skb_mac_header_len(skb) < ETH_HLEN ||…

Pre-existing issues:
- [High] The patch closes the ETH_HLEN pull BUG only in
  __bpf_redirect_neigh().
- [Medium] __bpf_redirect_neigh() now linearizes only ETH_HLEN bytes,
  then does skb_pull(ETH_HLEN) and skb_reset_network_header(), and…

--

bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()

This commit hardens __bpf_redirect_neigh() before it reads and pulls the
Ethernet header. The MAC header length (network_header - mac_header) must
now be at least ETH_HLEN, and pskb_may_pull() must make the header linear.
It also adds tc egress coverage to the tc_redirect_neigh selftest.

Link: https://lore.kernel.org/all/2a0f5ff1d8db81b07fc4b344b8e68e3505fcbf36f72a471d1678b2f1cecd881b@mail.kernel.org/
Link: https://lore.kernel.org/netdev/20261027082604.1485903-1-edumazet@kernel.org/

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 70dc621672f2e..4925f3e355d46 100644
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
> +	if (unlikely(skb_mac_header_len(skb) < ETH_HLEN ||
> +		     !pskb_may_pull(skb, ETH_HLEN)))
> +		goto out;

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. Still,
the skb from the commit message's own reproducer looks like it can BUG
through the sibling redirect paths. Is that expected?

After vlan pop_eth and bpf_skb_change_head(skb, 1, 0) on the nonlinear
AF_PACKET skb, len is 8193, data_len is 8192, and one L2 byte is linear.
__bpf_redirect_common() only checks:

net/core/filter.c:__bpf_redirect_common() {
    ...
	if (unlikely(skb->mac_header >= skb->network_header || skb->len == 0)) {
    ...
}

so the 1-byte MAC header gets through there. With BPF_F_INGRESS:

bpf_redirect(BPF_F_INGRESS)
  __bpf_rx_skb()
    dev_forward_skb_nomtu()
      __dev_forward_skb2()
        eth_type_trans()
          eth_skb_pull_mac()
            skb_pull_inline(skb, ETH_HLEN)
              __skb_pull() -> BUG()

Without BPF_F_INGRESS the path is:

__bpf_tx_skb()
  dev_queue_xmit(lo)
    loopback_xmit()
      eth_type_trans()

veth goes through __dev_forward_skb() and ends the same way.
bpf_clone_redirect() takes the same __bpf_redirect() path. On lo, a plain
TC_ACT_OK instead of bpf_redirect_neigh() also reaches
loopback_xmit()->eth_type_trans().

In each case the 14 <= 8193 length check passes. __skb_pull() then leaves
len at 8179, which is below data_len (8192), and hits BUG().

The commit message calls this a follow-up to Eric's short link-layer
header fixes. This tree has no pskb_may_pull() in eth_type_trans() or
eth_skb_pull_mac(), and bpf_skb_change_head() still accepts a header
shorter than ETH_HLEN.

Should one of those two places be hardened as well? Otherwise stable
backporters may assume this change fully closes the reproducer.

> +	ethh = eth_hdr(skb);
>  	bpf_push_mac_rcsum(skb);
>  	if (is_multicast_ether_addr(ethh->h_dest))
>  		goto out;

[Severity: Medium]
This isn't a bug introduced by this patch, but only ETH_HLEN bytes are
made linear here. After skb_pull(skb, sizeof(*ethh)) and
skb_reset_network_header(), can the L3 header sit entirely in frags?

__bpf_redirect_neigh_v4() reads the header directly from skb->data:

net/core/filter.c:__bpf_redirect_neigh_v4() {
	const struct iphdr *ip4h = ip_hdr(skb);
    ...
			.flowi4_dscp  = ip4h_dscp(ip4h),
			.flowi4_oif   = dev->ifindex,
			.flowi4_proto = ip4h->protocol,
			.daddr	      = ip4h->daddr,
			.saddr	      = ip4h->saddr,
    ...
}

__bpf_redirect_neigh_v6() does the same with ipv6_hdr(skb) for flowinfo,
nexthdr, saddr and daddr. When the route has no gateway,
bpf_out_neigh_v4()->ip_neigh_for_gw() reads ip_hdr(skb)->daddr again.

Take an AF_PACKET SOCK_RAW frame where prepad + len >= PAGE_SIZE.
packet_snd() and packet_alloc_skb() make only hard_header_len (14) bytes
linear. The frame passes both new checks, and skb_pull(14) leaves
skb_headlen() == 0.

Wouldn't the 20 or 40 byte L3 reads then come from past skb->tail, from
the tailroom or skb_shared_info? Those bytes would become the flowi4 or
flowi6 keys and drive the neighbour lookup. No pop_eth or change_head is
needed, just bpf_redirect_neigh() on such a packet.

Would a pskb_may_pull() of sizeof(struct iphdr) or sizeof(struct ipv6hdr)
before calling the v4/v6 helpers be appropriate?

> diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
> index af8968b89ad7c..829f84fb64a30 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
> @@ -407,6 +407,26 @@ static int netns_load_bpf(const struct bpf_program *src_prog,
>  	return -1;
>  }
>  
> +static int netns_load_egress_bpf(const struct bpf_program *prog,
> +				 const char *ns, int ifindex)
> +{
> +	LIBBPF_OPTS(bpf_tc_hook, qdisc);
> +	struct nstoken *nstoken;
> +	int err;
> +
> +	nstoken = open_netns(ns);
> +	if (!ASSERT_OK_PTR(nstoken, "setns egress"))
> +		return -1;
> +
> +	QDISC_CLSACT_CREATE(&qdisc, ifindex);
> +	XGRESS_FILTER_ADD(&qdisc, BPF_TC_EGRESS, prog, 0);
> +	close_netns(nstoken);
> +	return 0;

[ ... ]

> @@ -1055,6 +1075,12 @@ static void test_tc_redirect_neigh(struct netns_setup_result *setup_result)
>  			   skel->progs.tc_chk, setup_result))
>  		goto done;
>  
> +	if (netns_load_egress_bpf(skel->progs.tc_egress, NS_SRC,
> +				  setup_result->ifindex_src) ||
> +	    netns_load_egress_bpf(skel->progs.tc_egress, NS_DST,
> +				  setup_result->ifindex_dst))
> +		goto done;
> +
>  	if (!ASSERT_OK(set_forwarding(false), "disable forwarding"))
>  		goto done;

[Severity: Medium]
Is the test thread still in NS_FWD when set_forwarding(false) runs here?

test_tc_redirect() runs the tests in a separate pthread. open_netns()
saves the original namespace with:

tools/testing/selftests/bpf/network_helpers.c:open_netns() {
    ...
	token->orig_netns_fd = open("/proc/self/ns/net", O_RDONLY);
    ...
}

/proc/self resolves to the thread-group leader. So the saved fd points to
the runner's root netns, not NS_FWD, which the worker entered at the top
of test_tc_redirect_neigh().

The close_netns() calls in netns_load_egress_bpf() therefore setns() the
worker back into the root netns. set_forwarding(false) then writes the
ipv4 and ipv6 forwarding sysctls, and those resolve through
current->nsproxy->net_ns.

Would this turn off forwarding in the host namespace and leave NS_FWD
unchanged? Nothing restores the setting afterwards. The test would also no
longer check redirect_neigh with forwarding disabled in NS_FWD.

test_tc_redirect_peer_ing() already has the same pattern via
netns_attach_nk(). Any of these would avoid it:

- attach the egress programs before entering NS_FWD
- re-enter NS_FWD before calling set_forwarding()
- have open_netns() save /proc/thread-self/ns/net

> diff --git a/tools/testing/selftests/bpf/progs/test_tc_neigh.c b/tools/testing/selftests/bpf/progs/test_tc_neigh.c
> index de15155f2609f..e0b6c14a3935e 100644
> --- a/tools/testing/selftests/bpf/progs/test_tc_neigh.c
> +++ b/tools/testing/selftests/bpf/progs/test_tc_neigh.c
> @@ -133,4 +133,14 @@ int tc_src(struct __sk_buff *skb)
>  	return bpf_redirect_neigh(IFINDEX_DST, NULL, 0, 0);
>  }
>  
> +SEC("tc")
> +int tc_egress(struct __sk_buff *skb)
> +{
> +	if (skb->mark)
> +		return TC_ACT_OK;
> +
> +	skb->mark = 1;
> +	return bpf_redirect_neigh(skb->ifindex, NULL, 0, 0);
> +}

[Severity: Low]
This isn't a bug, but does any packet in this test reach the new rejection
branch in __bpf_redirect_neigh()?

This program sees ordinary locally generated TCP/ICMP packets at veth
egress. __dev_queue_xmit() has already reset mac_header there, so
skb_mac_header_len() is 14 and the header is linear. These packets pass
both the old and the new checks, so removing the new check would go
unnoticed.

tc_redirect_neigh is also registered only for veth:

	RUN_TEST(tc_redirect_neigh, MODE_VETH);

so the netkit case mentioned in the changelog is not exercised.

Would a negative test be worth adding? For example,
bpf_skb_change_head(skb, 1, 0) on a nonlinear skb followed by
bpf_redirect_neigh(), expecting a drop.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/bpf_redirect_neigh_short_linear.v2.r0.20261028080316-1%40mojatatu.com
