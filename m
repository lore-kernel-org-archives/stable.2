Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795770839;
	b=PNIdyFhtWvk7Kb5E2VklpawMVSWAayU3T6v5O4BIlhewoA478HxxxxH3eOskftsJ46kn
	 oGbDqPATUj0aNMW9eGEvEnJAnVzlIkWM8esdG/7y2IgdwdComGWuC5HF1j5owto3WMeLS
	 38teUnLSXvInbvKRWACkpOzs1ffXa+X6hS5kNsvhl9E2hjL2/woRY0OjKIhQIYH1Gmnig
	 /ZUcs5NvLLM1iVNcsPtbP+BIK6dFKWfIJe7Q/9415hV9y/CWbBFji9E0cP3WBwfiw6t/8
	 eUl46vmR80XZnD07DdNW+vDWoKjvF3gyxwfF4M0YqHIWR+67VRGsWwkNHrQ3+fH6lWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795770839;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=x2Rh4c/4J+pnoNGHPrrKjUF2LgrC1+eSfFkYwdsOQ7w=;
	b=LFsCYg8NEl+moI36HPemlMIXhs8a5PPHtwy/rO33nsNgJXMRqrtsxV1mKgHAbKV0WfXM
	 tp7tZeuFOQ41cpW+r34fiuN01ss1JKXwcaL4nABT9P5MRV0ljS+dhgTPWyFd45YWxhIQQ
	 cDyTYPKIxtXICrOh3Is+Tcd8K4sJKo9w9e1eLkze/48ZXG3CBlcP+rvwEF+2hEPf3dXOp
	 txIqMKVtLh//sn4Arqft1W5xad/fvPdn5/qZ0cgKGFTu4YP90Zj0xvavaNxzOLag3zR8V
	 wiTUyzAhtif9MFrTwwJYOw3SDG6zEhOsVjry1pIjri7fAd/NncLzs4HW6Njjdk9cjwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GEFeoT2C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF47606A327;
	Fri, 27 Nov 2026 09:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GEFeoT2C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924071F00932;
	Fri, 27 Nov 2026 09:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795770839;
	bh=x2Rh4c/4J+pnoNGHPrrKjUF2LgrC1+eSfFkYwdsOQ7w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GEFeoT2COrZyGbCVQTlFdXm9TrXUaWKdtRXAPtFCaVHRcE6wHTf8uAM4dRxuNBULn
	 HSSCVWU0m+9vCyFqzRkHYtu5aQ+dzhXn+QiNCyjEhjg1V1zb7w8PXNgrqlAmXeih5L
	 mnu4spdwTpEQy7cb7Qaa+tcKbJ3Zcqj57os94wnj+dX6ldmVXTWEfIfQdwlVUv1f/1
	 3/mawGTpreEXcL3CP9ZW6FQE3mgmkGoLfhmkvDQpmmCruTxuFQBt3BTqBSIbwUukUU
	 IuBLgGkW2PkLx1/IBsHvEN7QumjxmZKRe9eJwv/MGeuyCXfSjZjxxqnJDksjVAPEtG
	 TyL81e4FxNuNA==
Subject:
 Re: [PATCH net] openvswitch: reject negative L2 length in ovs_fragment()
From: netdev-bot+sashiko@kernel.org
To: ljp1205831794@gmail.com
Cc: aconole@redhat.com, echaudro@redhat.com, i.maximets@ovn.org,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, jbenc@redhat.com, netdev@vger.kernel.org,
 dev@openvswitch.org, jiapenglin@tencent.com, stable@vger.kernel.org,
 corvus@tencent.com
Date: Fri, 27 Nov 2026 09:13:58 +0000
Message-ID: <179577083811.3135.5534472542080696587@kernel.org>
In-Reply-To: <20261126083218.55429-1-ljp1205831794@gmail.com>
References: <20261126083218.55429-1-ljp1205831794@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch makes ovs_fragment()
  (net/openvswitch/actions.c:791-792) reject only…
- [Low] The new `skb_network_offset(skb) < 0` case in ovs_fragment()
  (actions.c:791-795) reuses OVS_DROP_FRAG_L2_TOO_LONG and the log text…

--

openvswitch: reject negative L2 length in ovs_fragment()

This patch makes ovs_fragment() drop MPLS packets whose inner network
header sits before skb->data. Before the patch, a negative offset passed
the MAX_L2_LEN check and reached a huge memcpy() in prepare_frag(). Such
packets are now dropped with OVS_DROP_FRAG_L2_TOO_LONG.

> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> index 12e339cbf7912..9c19fe8676a7a 100644
> --- a/net/openvswitch/actions.c
> +++ b/net/openvswitch/actions.c
> @@ -788,7 +788,8 @@ static void ovs_fragment(struct net *net, struct vport *vport,
>  		skb->network_header = skb->inner_network_header;
>  	}
>  
> -	if (skb_network_offset(skb) > MAX_L2_LEN) {
> +	if (skb_network_offset(skb) > MAX_L2_LEN ||
> +	    skb_network_offset(skb) < 0) {

[Severity: Medium]
Is a lower bound of 0 strong enough here?

In the eth_p_mpls() branch, orig_network_offset is where the label stack
starts. A real inner network header is always at least
orig_network_offset + MPLS_HLEN past skb->data. So any offset in
[0, orig_network_offset) would come from the same stale
inner_network_header that the commit message blames on POP_MPLS.

Each excess skb_mpls_pop() moves skb->data forward but does not touch
inner_network_header:

net/core/skbuff.c:skb_mpls_pop() {
    ...
	__skb_pull(skb, MPLS_HLEN);
	skb_reset_mac_header(skb);
	skb_set_network_header(skb, mac_len);
    ...
}

On an L3 port (mac_len 0), one excess pop gives -4. That matches the
0xfffffffc in the KASAN report, and the new check catches it.

On an Ethernet port (mac_len 14), the same pops would give 10, then 6,
then 2. The offset only goes negative after the fourth pop. Offsets 10,
6 and 2 all pass the new check.

With an offset of 10, prepare_frag() saves a short L2 header and pulls
10 bytes:

	data->network_offset = orig_network_offset;
	...
	data->l2_len = hlen;
	memcpy(&data->l2_data, skb->data, hlen);

ip_do_fragment() or ip6_fragment() would then parse a fake L3 header
from the bytes that the memmove() in skb_mpls_pop() left behind. For
IPv4 those bytes are the last two bytes of the source MAC followed by
the 0x8847 ethertype, so iph->ihl would come from the source MAC.

ip_frag_next() then copies iph->ihl * 4 bytes with
skb_copy_from_linear_data() and does not check skb_headlen(). Stale
buffer bytes might leak if the fake ihl is larger than the linear area.
That part is speculative.

On output, ovs_vport_output() pushes back only data->l2_len (10) bytes
but sets the network header at data->network_offset (14):

	skb_push(skb, data->l2_len);
	memcpy(skb->data, &data->l2_data, data->l2_len);
	...
	if (eth_p_mpls(skb->protocol)) {
		skb->inner_network_header = skb->network_header;
		skb_set_network_header(skb, data->network_offset);
		skb_reset_mac_len(skb);
	}

It isn't clear whether this over-pop vector can actually be reached in
this tree. The commit message does not describe it.

__ovs_nla_copy_actions() resets eth_type when mpls_label_count reaches
0, which rejects a simple push_mpls followed by two pop_mpls(0x8847)
under an IPv4 flow key.

An MPLS flow key with a masked label count can over-pop through the
u32 underflow. However, key->eth.type is then MPLS at runtime, so
ovs_fragment() takes the WARN branch instead of reaching
prepare_frag().

A path that carries the stale state across recirculation looks blocked
by the skb_mpls_pop() change that clears inner_protocol when popping to
a non-MPLS ethertype (commit 78a86d75a70e1e).

If the vector the commit relies on does exist for Ethernet ports, would
it be safer to check this inside the eth_p_mpls() branch instead:

	skb_network_offset(skb) < orig_network_offset + MPLS_HLEN

using signed offsets? Valid traffic would not be affected.

>  		OVS_NLERR(1, "L2 header too long to fragment");
>  		reason = OVS_DROP_FRAG_L2_TOO_LONG;

[Severity: Low]
This isn't a bug, but the new negative offset case reuses the "L2 header
too long to fragment" message and OVS_DROP_FRAG_L2_TOO_LONG. A negative
offset means the L2 length is invalid, not too long.

Drop monitor and the kfree_skb tracepoint will show the
OVS_DROP_FRAG_L2_TOO_LONG name from net/openvswitch/drop.h for this
case. Reusing the reason makes sense for a stable fix. Could the log
text say something like "invalid L2 header length" instead?

>  		goto err;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261126083218.55429-1-ljp1205831794%40gmail.com
