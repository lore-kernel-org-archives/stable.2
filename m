Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302B37081A;
	Sun, 20 Sep 2026 04:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789878937; cv=none; b=bEN+FmfoTZPYAzuSDG8VvaoN1xBl9PGmoc246PooY/QylEHXoZ67NO2srodwspGlUKEESKfs81hh0UnJyfuqUOAY0UE3jL+hYUyQfmcECOa8MNcmuhUlN2i9GSc4ZAf+LtuZQGG4BBFMHvo+sk1leLaOxlb+a9/92dYs8wRbXio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789878937; c=relaxed/simple;
	bh=X9452GZOsoxH71+dDIbUWi5SCjE3A8OTF91wvag1CYs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LKWdDF6wN/XGuuNGvUjQh+4psh0y6WOyNy2KrIIxCcIEF65B/D7kZY7+XH7J2uQrwE+AdmryChSyVx2VxJoRqt3kMtxqYDYXXn+98CTcMqf329s1u6LRZ0PUxEGUl5dIx2rncqUWgcpQ70S77e0yICTSw+9Z5riL4zbcMvMK4ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blm+E5F6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blm+E5F6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BD51F000FF;
	Sun, 20 Sep 2026 04:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789878935;
	bh=REtQQFeFLxxgvb61TQxQg3pfZz8pkUCj+S64puRpRlM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=blm+E5F6uBWFsmbblEZtWPaqsR1k34UMnuF8IjXCGL7bS0WBm+tb0CZEdt5IBx38A
	 1cTPv0fNIf1T+Pifs3A+RJ7NoeX/0dn6w5j7KBDxSr/dvljpItbFTix3gMivXjjV9s
	 i/JHJM1//DPDIwaFOnGaGdlvqqiwlTyrXtz59EYXUjqc0uKxGwRy+ldgw5YcMCnfh2
	 qaTYYpYi5pQ3GLxLojVr4KaNER/2REoWgpIx9MaJiLohjJKqEF/XJfnjamYm2j0OOY
	 LWfWNhIZvo9u32hcxecZDN5+CawxDpjuzrkOpazzIyH3osrZlzFA6LYfQhAHcqec2k
	 ct3JSmzEZMlvA==
Subject: Re: [PATCH net] bpf: lwt: clear stale IP control block after pushing
 an encap header
From: netdev-bot+sashiko@kernel.org
To: xmei5@asu.edu
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 co+ff13a35f73bb7891@bugs.sh, stable@vger.kernel.org
Date: Sun, 20 Sep 2026 04:35:34 +0000
Message-ID: <178987893476.2160803.2740674038834651129@kernel.org>
In-Reply-To: <20260916041102.1914333-1-xmei5@asu.edu>
References: <20260916041102.1914333-1-xmei5@asu.edu>
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
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete IPv4 control-block sanitization in
  bpf_lwt_push_ip_encap() (net/core/lwt_bpf.c:652-653): only…
- [High] The new IPCB/IP6CB reset in bpf_lwt_push_ip_encap()
  (net/core/lwt_bpf.c:652-663) is executed from inside the BPF program…
- [Medium] bpf: type confusion in bpf_lwt_push_ip_encap drops VRF
  association

--

bpf: lwt: clear stale IP control block after pushing an encap header

This adds control block sanitization to bpf_lwt_push_ip_encap() after the
encapsulation header is pushed and the network header is reset, clearing
IPCB(skb)->opt for IPv4 and the whole IP6CB for IPv6 (keeping iif, nhoff
and IP6SKB_L3SLAVE). It is aimed at a KASAN stack out-of-bounds write in
__ip_options_echo() reached through ip_forward() -> icmp_send().

> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> index da49364ec63de..17be476b57172 100644
> --- a/net/core/lwt_bpf.c
> +++ b/net/core/lwt_bpf.c
> @@ -649,6 +649,18 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
>  	if (ingress)
>  		skb_postpush_rcsum(skb, iph, len);
>  	skb_reset_network_header(skb);
> +	if (ipv4) {
> +		memset(&(IPCB(skb)->opt), 0, sizeof(IPCB(skb)->opt));
> +	} else {

[Severity: High]
Why does the IPv4 branch only clear IPCB(skb)->opt instead of the whole
inet_skb_parm?  struct inet_skb_parm has more inner-packet state after
opt:

include/net/ip.h:
struct inet_skb_parm {
	int			iif;
	struct ip_options	opt;		/* Compiled IP options */
	u16			flags;
	...
	u16			frag_max_size;
};

flags and frag_max_size were computed for the inner packet and are then
read against the newly pushed outer header:

  - ip_forward() does

	if (IPCB(skb)->flags & IPSKB_DOREDIRECT && !opt->srr &&
	    !skb_sec_path(skb))
		ip_rt_send_redirect(skb);

    so a stale IPSKB_DOREDIRECT from __mkroute_input() makes the redirect
    be built from the new outer ip_hdr(skb).

  - ip_exceeds_mtu() does

	if (unlikely(IPCB(skb)->frag_max_size > mtu))
		return true;

    and __ip_finish_output() does

	if (skb->len > mtu || IPCB(skb)->frag_max_size)
		return ip_fragment(net, sk, skb, mtu, ip_finish_output2);

    so a frag_max_size left over from ip_frag_reasm() steers the outer
    packet into fragmentation or an ICMP FRAG_NEEDED drop.

  - xfrm4_policy_check(NULL, XFRM_POLICY_FWD, skb) in ip_forward()
    reaches __xfrm_check_dev_nopolicy(), which does

	return IPCB(skb)->flags & IPSKB_NOPOLICY;

    so a stale IPSKB_NOPOLICY bit skips the IPsec forward policy check
    for the re-routed outer flow.

Can the cross-family case make this worse?  For an inner IPv6 packet with
a pushed outer IPv4 header (program returns BPF_LWT_REROUTE, so
bpf_lwt_input_reroute() -> ip_route_input_noref() -> dst_input() ->
ip_forward()), IPCB->flags sits at skb->cb[20..21], which aliases
inet6_skb_parm's frag_max_size/srhoff (layout depends on
CONFIG_IPV6_MIP6).  Does that turn an IPv6 reassembly size into an
arbitrary IPSKB_* bitmask, including IPSKB_REROUTED, which makes
__ip_finish_output() skip NF_INET_POST_ROUTING?

Both precedents cited in the commit message do a full clear:

net/ipv4/ip_tunnel_core.c:iptunnel_xmit()
	memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
	IPCB(skb)->flags = ipcb_flags;

net/ipv6/seg6_local.c (commit 44930446dde4)
		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
		IPCB(skb)->iif = iif;
		if (l3slave)
			IPCB(skb)->flags |= IPSKB_L3SLAVE;

Would it make sense to mirror that here, since the IPv6 branch below
already follows the pattern?

> +		bool l3slave = ipv6_l3mdev_skb(IP6CB(skb)->flags);
> +		int iif = IP6CB(skb)->iif;
> +
> +		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
> +		IP6CB(skb)->iif = iif;
> +		IP6CB(skb)->nhoff = offsetof(struct ipv6hdr, nexthdr);
> +		if (l3slave)
> +			IP6CB(skb)->flags |= IP6SKB_L3SLAVE;
> +	}

[Severity: Medium]
Which family does ipv4 actually describe here?  It is derived from
iph->version of the header being pushed (hdr), i.e. the *outer*
encapsulation, while the control block that is being sanitized still
belongs to the *inner*, already-received packet.  For a cross-family
encap the two disagree, and this branch then reads and rewrites the cb
through the wrong union member.

Concretely, for an inner IPv4 packet with an outer IPv6 header pushed
(ipv4 == false), l3slave is computed from IP6CB(skb)->flags, which lives
at skb->cb[16..17].  That range aliases the tail of IPCB(skb)->opt: opt
starts at cb[4], so cb[16] is ip_options' bitfield byte
(is_strictroute..ts_needaddr) and cb[17] is opt.router_alert.  The flag
this code is trying to preserve, IPSKB_L3SLAVE, is BIT(7) of
IPCB(skb)->flags at cb[20], which is not read at all.  In practice bit 6
of the aliased u16 is always zero (little-endian: it is padding after the
six option bits; big-endian: it is bit 6 of router_alert, which
ip_options_compile() sets to an in-header offset below 64), so l3slave
evaluates to false unconditionally.  The following memset() then covers
sizeof(struct inet6_skb_parm) == 24 bytes (int iif forces the size up),
which includes IPCB(skb)->flags at cb[20], so the genuine IPSKB_L3SLAVE
bit of the inner packet is cleared and never restored.

The effect is that an lwt-bpf encap route inside a VRF silently loses the
l3mdev association: the ipv6_l3mdev_skb() / IPSKB_L3SLAVE consumers
further down the receive and socket-lookup paths see a packet that did
not arrive on an enslaved device.  Note also that iif survives only by
coincidence, because struct inet_skb_parm and struct inet6_skb_parm both
place iif at offset 0, and that the IP6CB(skb)->nhoff store at cb[14..15]
lands on opt.rr/opt.ts for the same reason - correctness by aliasing is
not something we want to depend on in a stable backport.

Shouldn't the choice of which control block to clear and which bits to
carry over be keyed on the family of the packet already on the skb
(e.g. skb->protocol, sampled before it is overwritten with ETH_P_IP /
ETH_P_IPV6 further down) rather than on the header being pushed?  And
when the families differ, how do you want to translate the preserved
state - map IPSKB_L3SLAVE to IP6SKB_L3SLAVE (and vice versa) along with
iif, or just clear both blocks and accept the loss?  Please spell that
out, since with CONFIG_NET_L3_MASTER_DEV=n ipv6_l3mdev_skb() is a
constant false and no test will notice the difference.

[Severity: High]
Is this reset still in effect by the time the packet reaches ip_forward()?

bpf_lwt_push_ip_encap() is only reachable from inside the running BPF
program, via bpf_lwt_in_push_encap()/bpf_lwt_xmit_push_encap() in
net/core/filter.c:

	case BPF_LWT_ENCAP_IP:
		return bpf_push_ip_encap(skb, hdr, len, true /* ingress */);

and the program is invoked from run_lwt_bpf() as:

	bpf_compute_data_pointers(skb);
	ret = bpf_prog_run_save_cb(lwt->prog, skb);

__bpf_prog_run_save_cb() in include/linux/filter.h does:

	if (unlikely(prog->cb_access)) {
		memcpy(cb_saved, cb_data, sizeof(cb_saved));
		memset(cb_data, 0, sizeof(cb_saved));
	}

	res = bpf_prog_run(prog, skb);

	if (unlikely(prog->cb_access))
		memcpy(cb_data, cb_saved, sizeof(cb_saved));

cb_data is bpf_skb_cb(skb) == qdisc_skb_cb(skb)->data, i.e. skb->cb+8 for
BPF_SKB_CB_LEN == 20 bytes, so skb->cb[8..27].

Does that range cover exactly the fields this patch is trying to clear?
struct inet_skb_parm puts opt at cb[4], and struct ip_options is:

include/net/inet_sock.h:
struct ip_options {
	__be32		faddr;
	__be32		nexthop;
	unsigned char	optlen;
	unsigned char	srr;
	unsigned char	rr;
	unsigned char	ts;

so optlen/srr/rr/ts land at cb[12..15], inside the saved-and-restored
window, and only opt.faddr at cb[4..7] stays cleared.  The IPv6 branch has
the same problem: srcrt/dst1/lastopt/nhoff/flags occupy cb[8..17], so the
newly assigned nhoff and the IP6SKB_L3SLAVE bit are also discarded.

Is prog->cb_access reachable for lwt programs?  lwt_is_valid_access()
allows it:

		case bpf_ctx_range_till(struct __sk_buff, cb[0], cb[4]):
			break;

and bpf_convert_ctx_access(), used by lwt_in/out/xmit_verifier_ops, sets:

	case offsetof(struct __sk_buff, cb[0]) ...
	     offsetofend(struct __sk_buff, cb[4]) - 1:
		...
		prog->cb_access = 1;

So for any lwt-bpf program that reads or writes cb[], the restore puts
opt.optlen and opt.rr back to the inner-header-relative values, and

net/ipv4/ip_options.c:__ip_options_echo() {
	sptr = skb_network_header(skb);
	...
	memcpy(dptr, sptr+sopt->rr, optlen);
}

runs with those stale offsets again.  Neither bpf_input() nor
bpf_lwt_input_reroute()/bpf_lwt_xmit_reroute() redo the clearing after
run_lwt_bpf() returns.  Would doing this after the program run instead
close the hole for cb-accessing programs?

A second effect of clearing inside the program run: the memset covers the
program's live __sk_buff->cb scratch area (cb[0..2] for the IPv4 branch,
and cb[0..3] for the IPv6 branch since IP6CB spans cb[0..23]).  Is that
change of behavior intended for programs that stash data in cb across a
bpf_lwt_push_encap() call?

Would it be worth adding a regression test with an encapsulating lwt
program that also accesses cb[]?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916041102.1914333-1-xmei5%40asu.edu
