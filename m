Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793182783;
	b=BWr3nMxa3Av1SnOizsrV5a+wpWOOKxFQ8Vv0WUSNGt0/eM92zvuuajXAHd8uhZH8Fpdr
	 SEK0zC/iRH95o8Z0znUyKtboHX1SOekNWZqGS38crlxXf6BxXvISBNsy5/YKPUstgEiof
	 d9GJbW9tV3wxTVcXveLphAkVGRC2hzvjqBGwL4tdEazeYh3/VV/Z373RPizFPxE373TEJ
	 wapqfzpIHooG00rgp0ECy4av6UplGlEjTyPNhhE1WSHrY5Q31vULOhMzLePc6gFeej89U
	 ghKClI8Hh7Xhbhk4gM6YXhyM+9amUu+08sLDvEVkvnH4imypHIYRb10U+pGDmG7IKbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793182783;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=P0LBJo2VbqsEvkmMMPt6dVLvdqBYzTvslPWjGjbCJkU=;
	b=wE/OPmw1ggyIdtiUE1xqYPhJGwfKxPYmgiZpLDN7RRY9UP0xASgMvynZJr87gI8uGCRv
	 AkLA1zFfJYpqZD8AxwFpZF0tC/s3fzOCmQ0CmLN29WLdpcHk413w4hpX7tM88n34tkWAa
	 sf8DvtHq50zS64abmaWlYWiPhxWyLiVf0kwOsgTovzZKPVVnb2yq2f9j/ZCXsubCURCZS
	 9/4wwMk/y+OWU2ZbOELJ18ZER4t9CWQAq85v+91Aa9/TIzOCTjt0N65pgYGWhZ9h0gX8I
	 /M6LP5vR0EQPom45h4vUGR5bxxl9ESrLvWWJOXTXsUS8hYd/4M045y+qNhrVaCOjxvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XK21YGB2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28412606A31A;
	Wed, 28 Oct 2026 10:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XK21YGB2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6A81F01828;
	Wed, 28 Oct 2026 10:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793182782;
	bh=P0LBJo2VbqsEvkmMMPt6dVLvdqBYzTvslPWjGjbCJkU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=XK21YGB20iZcPTso2nm0Xo9s7LFoDqVtDtI8fSzdvTCQ0++HJQ6CNngwCPSZnVGJK
	 imwJZiHlZ3OOyKBgjCrY2MPocQpc1r6oNOKtEChWV14wDll5jznHSlQXGuubMQnVQO
	 UxSthCbEpN1UYyWkmaj6g4wBrsFDtLvqj/Sc1dJl1PLVWSIptkgGzEYbB6aTQXv3Up
	 0ga30VfzF02BRNVH0YJKK3Tq0KeRkTNiO2DhMb5RiaOSRk05hf81e8RGehxRvfqvJf
	 WpLezqyR01a53UycNyKUlgVL8AgU+SinGHx5gQlmyOP7JB8DrgEo8DD60ygYTBX+8B
	 Ll96Vi7/jcjbg==
Content-Type: multipart/mixed; boundary="===============7754228893917277764=="
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <2a0f5ff1d8db81b07fc4b344b8e68e3505fcbf36f72a471d1678b2f1cecd881b@mail.kernel.org>
In-Reply-To: <bpf_redirect_neigh_short_linear.v1.r0.20261028033717-1@mojatatu.com>
References: <bpf_redirect_neigh_short_linear.v1.r0.20261028033717-1@mojatatu.com>
Subject: Re: [PATCH net] bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()
From: bot+bpf-ci@kernel.org
To: jhs@mojatatu.com,netdev@vger.kernel.org
Cc: jhs@mojatatu.com,edumazet@kernel.org,bpf@vger.kernel.org,stable@vger.kernel.org,daniel@iogearbox.net,ast@kernel.org,dsahern@gmail.com,kafai@fb.com,martin.lau@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,davem@davemloft.net,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,jiri@resnulli.us,victor@mojatatu.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 28 Oct 2026 10:19:42 +0000 (UTC)

--===============7754228893917277764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()

TL;DR: The new skb->mac_len < ETH_HLEN check in __bpf_redirect_neigh() may
wrongly drop valid packets on tc egress and netkit, where mac_len is often 0;
a regression that would reach stable.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index b7ac145b68b1..95a8a728a71d 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c

[ ... ]

> @@ -2451,10 +2451,14 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
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

Does the new skb->mac_len < ETH_HLEN test drop valid packets on tc egress
and netkit?

skb->mac_len is only set on the receive path, where
__netif_receive_skb_core() calls skb_reset_mac_len().  The transmit path
only calls skb_reset_mac_header() in __dev_queue_xmit(), and nothing in
ip_finish_output2(), neigh_output(), eth_header(), sch_handle_egress(),
tcx_run(), cls_bpf_classify() (egress branch), netkit_xmit() or
netkit_prep_forward() writes mac_len.

A packet built by a local socket starts with mac_len == 0, because
skbuff_clear() zeroes everything before 'tail', and skb_clone() (used by TCP
transmit) copies that 0.

For example, with tc egress and a locally generated IPv4/IPv6 packet:

ip_finish_output2()
  neigh_output()
    dev_queue_xmit()
      __dev_queue_xmit()          <- skb_reset_mac_header() only
        sch_handle_egress()
          tc_run() / tcx_run()
            prog returns bpf_redirect_neigh() = TC_ACT_REDIRECT
              skb_do_redirect()
                __bpf_redirect_neigh()

Here mac_header < network_header passes, because an Ethernet header was
pushed, but mac_len == 0 < ETH_HLEN, so the skb goes to 'out', gets
kfree_skb() and -ENOTSUPP is returned.

The same happens with netkit:

netkit_xmit()
  netkit_run()
    NETKIT_REDIRECT
      skb_do_redirect()
        __bpf_redirect_neigh()

with mac_len still 0.  Netkit programs are BPF_PROG_TYPE_SCHED_CLS, and
tc_cls_act_func_proto() allows BPF_FUNC_redirect_neigh.  Forwarded traffic
that arrived on a layer 3 device (mac_len 0 on receive) and leaves through
an Ethernet device's tc egress would be dropped as well.

Before this patch these paths worked, since the Ethernet header is linear
(dev_hard_header() pushes it into the head) and skb_pull(skb, ETH_HLEN) was
fine.  bpf_out_neigh_v4/v6() calling sock_confirm_neigh(skb, neigh) also
suggests the helper is meant to handle locally generated skbs.

Elsewhere the kernel already treats mac_len as unreliable at egress.
act_mirred uses:

    mac_len = at_ingress ? skb->mac_len : skb_network_offset(skb);

and act_mpls uses skb_network_offset(skb) when not at ingress.

The bpf_redirect_neigh selftests (test_tc_neigh, test_tc_neigh_fib,
test_tc_dtime) all attach at tc ingress, where mac_len is valid, so they
would not catch this.

Would testing the real MAC header length work instead, for example
skb_mac_header_len(skb) < ETH_HLEN (network_header - mac_header), or
skb_network_offset(skb) < ETH_HLEN with skb->data at the MAC header here?

That would still reject the 1-byte header from the commit message (pop_eth
followed by bpf_skb_change_head(skb, 1, 0)) without dropping egress and
netkit traffic.  Since the patch carries Cc: stable, this regression would
also reach stable kernels.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40666397744
--===============7754228893917277764==--
