Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793396853;
	b=QzFp3CcKd2V1HhvsEYHkPe+U74ss84BI+96BzZ1Utb104sujIqIhD/z6XsXManDfKODu
	 P8mohXAj7yi6eTbk5VakJtaTgVEfMHCZmapjUqIALmjxIesROC8atltVvDdXu7tSQ2Hi7
	 pyosl96iWsvX+HjHBAVboJJY3ZEior7rz/sgdWrQ7NJ9UGmFqxROx4WhqO63q5nQqghY6
	 Uoh/ZtLLbPAdgJosz0UtXjXGZHxkm4ltINYX/yuZMzWZJzi9AlzEuHG6tRDEOiv1OOGFh
	 8UYPb4N7ztZByWY3pGKPKazISFZQy62e5TIO7cuQ2ENgL4rCESSiTe3FOUq5OaPYOBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793396853;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=gIM0Lf0RizPpF2lV6gAp9aopG/Lg9g5C4lkrOp+TfwU=;
	b=heWhDYnnlPT9YhSwPQZ1CB3nn8danspPECHwFm49vNsDu+amvrNtb0K/lzklhrNrX5uC
	 vc1KKHvYO1SNChoaUwiuiJK1puOIeeoVGkUugUIl2jFCyfwRw1jICp+NoRWo8BWHOrVA0
	 KMmRwlaBEGz2A1PEFHnH/XiIbRnu+8qm48S3WcT5xJL2S+ukoYVSESCki8Ie8kqoxH7iT
	 NUWTz01KO/g6UEH8DhClszyo70c+c/bx0nTTMItHUa6a88Xd+Mdboz6PBgAkMDsr6f1dK
	 nRmd2uPduDoQYEmiKhTUjEKo88bzp75uL/5xrSV6q8UnQeB8zlEF/JbBhJTHY+9cuTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QwLgp5NI;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6445606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 21:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6445606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QwLgp5NI
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e60f9af6e6so11367735ad.3
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 14:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793396852; x=1794001652; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gIM0Lf0RizPpF2lV6gAp9aopG/Lg9g5C4lkrOp+TfwU=;
        b=QwLgp5NIIMg4AA8/Z8CtU3veu8cREA/NoPqO23FoHKGC2AvsPNQmzks5z8NjAGnG/7
         BD+ScScN5uJUv8ITeksQDGK+fqx3rm7eK5nu5JL35HXr5EeDTZqo8H6lUhoriOU0kp3T
         n4Cr6obn1rdNu4BtmuGD/0gHHQOz/9joE+tLRnTxTz3OpMJ8aym3QAdjy+0zl7O+2L0w
         OcJWym7XY8P4pwpSMytqPjqzLzyaJmqOxy6zVKYr8aq3T+f039sSxExWB+CFDlN8z0yd
         uiAKWbQYezGYKcGlBy2DHE+7yOcvR6xCHyhfPmirxfPFcswd06xFfor8tls/BoU2Rz6I
         NofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793396852; x=1794001652;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gIM0Lf0RizPpF2lV6gAp9aopG/Lg9g5C4lkrOp+TfwU=;
        b=NUSElRWB6BE+z/sDO+NSA/uJsNZ+MRRzuOHFSUNpqEY8jDt3Gwz3lj3v7ZA4zEtUZi
         t+/Hrza2lY7l0JH7hdwaro4GMmC/bngA5WWY+YIFHTrmoQyE4k2Vui7R55uD9siniFP4
         0cOEZZcb0PnL49iUd8mYPsO04jl/w+ygnJWZnb+gSFxYH3E5I1PhxgKL+RnRvcng5l5s
         Xo9AaA1y5ypVjgtIYCSkoes4mMO4nonJ1kU6w6T0h2ddrojSXM7aFCPfsNzVc4HRE9Ao
         5PzQvaRm3G0zq6qnn1YddBor+0wa63GPfvpvp3YRYNge3/bhhGj64olpXd3Y+dDHrDPP
         zmNQ==
X-Forwarded-Encrypted: i=1; AKwUvBzBc++D8+4S4xoLk0Vr9jSm+GtkBO+5zj++AhzsfMjFXVgJBF6Mbe032rVpYiJ6LxjiTA+X9UI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKNCblxkcghZ7xRXvP8zyk9DVJIlLWQNbhL6I5PB6woi2YWiIlE
	x+CWYFRi2dPANyMzlZnuRtjzmSW+AbqaHhzz2CZSpXNW9BxLAteb0LGr
X-Gm-Gg: AYBFou1z/Ohy60z6yyvUP/LVp1mcW47/usbWi0hRBqI4DT9MnhwxZV+kPiqhnZuS81Q
	h++vqHJ/dDxATLAjLQhjTJp/PNvs6w2dQHJKdos0/B0QN6Dz3BBjz/v6nEheI6WSJR1Cumq8yoF
	rETHU6Q+efCEBwcZLwnsWkeDIQRMyVmqPb+1XbhHujNLz3z8aIAGEBCipdnndxFovmUioD72bsZ
	y2+N8wi+m372SfAtSIc4kCn8KSnkXTrNYp6oe3yoIuW+E+Hxn9jElX2HI5qZaXDAawyBjn8uzPl
	f+QRmE08sV30z+qvlsupiQrohdTtqGCj7DPtx0l7M8B5op2VzSfGyemAtk+P+I/6JpjaZ4pmIbj
	bpig6ihnRptG0i++K3B7ZGFXj1JUYCx2Ew0n8wtgrmcr985Hnwf+JqhHBC5o0AYZoKUpLPJUnk3
	FmqbWevNAdNUQ6TBeTRg/B0NcdfcKt6VFX3q0ylxT9PWsYvrcD9ze1FJLbhKdCBlQkimJW9fNgp
	O+5O/ZoCRrQLI3R3bvkpoolfoNrd7rzfYmYXYSvPE7v5ymwoY1cjH+0yw3fKGpQH4ctv5cahx+M
	z1SYmnFBa98Gvymq963ua3o20smmJS4gu/1F6pnzw2Hor324hJyQxDlHb2Apw1mwoYB+GbQfKI8
	mJJdN1La4JkafgsIq2YZXFZV1ixBHZA2p2Q==
X-Received: by 2002:a17:903:144b:b0:2e9:42d8:48d3 with SMTP id d9443c01a7336-2eb364d2529mr35787295ad.36.1793396851935;
        Fri, 30 Oct 2026 14:47:31 -0700 (PDT)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39230bbfsm11775285ad.19.2026.10.30.14.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 14:47:31 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 30 Oct 2026 21:47:30 +0000
Message-Id: <DMII4JGTEUEG.2WRJPT6ODT6J0@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jamal Hadi Salim" <jhs@mojatatu.com>, <netdev@vger.kernel.org>
Cc: "Eric Dumazet" <edumazet@kernel.org>, <bpf@vger.kernel.org>,
 <bot+bpf-ci@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "David
 Ahern" <dsahern@gmail.com>, "Martin KaFai Lau" <kafai@fb.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "David S . Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Jiri Pirko" <jiri@resnulli.us>, "Victor
 Nogueira" <victor@mojatatu.com>, <linux-kselftest@vger.kernel.org>, "Shuah
 Khan" <shuah@kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH net v2] bpf: Fix skb_pull() BUG in
 __bpf_redirect_neigh()
In-Reply-To: <bpf_redirect_neigh_short_linear.v2.r0.20261028080316-1@mojatatu.com>
References: <bpf_redirect_neigh_short_linear.v2.r0.20261028080316-1@mojatatu.com>
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

On Thu, Oct 29, 2026 at 02:36 AM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> Add egress coverage to tc_redirect_neigh: the existing test only attaches
> redirect_neigh at ingress, where mac_len is populated.

This test cannot hit the BUG.
Just drop it and respin as [PATCH bpf v3].

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
> +	ethh = eth_hdr(skb);

ETH_HLEN is not enough.
__bpf_redirect_neigh_v4() and __bpf_redirect_neigh_v6() read ip_hdr()
and ipv6_hdr() right after the pull. Nothing makes these headers linear.
Take the AF_PACKET frame from the commit log without pop_eth and
bpf_skb_change_head():

  packet_snd()                     headlen == 14, IP header in frags
  skb_pull(skb, ETH_HLEN)          headlen == 0
  skb_reset_network_header(skb)    network header == skb->tail
  ip4h->daddr, ip4h->saddr         read past skb->tail

The route lookup runs on garbage.

Eric's skb_network_offset() check also covers
mac_header >= network_header. No need for two checks.

Something like this:

diff --git a/net/core/filter.c b/net/core/filter.c
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2290,10 +2290,14 @@ static int bpf_out_neigh_v6(struct net *net, struct sk_buff *skb,
 static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev,
 				   struct bpf_nh_params *nh)
 {
-	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
 	struct net *net = dev_net(dev);
 	int err, ret = NET_XMIT_DROP;
+	const struct ipv6hdr *ip6h;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ip6h))))
+		goto out_drop;
+	ip6h = ipv6_hdr(skb);
 
 	if (!nh) {
 		struct dst_entry *dst;
 		struct flowi6 fl6 = {
@@ -2399,10 +2403,14 @@ static int bpf_out_neigh_v4(struct net *net, struct sk_buff *skb,
 static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
 				   struct bpf_nh_params *nh)
 {
-	const struct iphdr *ip4h = ip_hdr(skb);
 	struct net *net = dev_net(dev);
 	int err, ret = NET_XMIT_DROP;
+	const struct iphdr *ip4h;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ip4h))))
+		goto out_drop;
+	ip4h = ip_hdr(skb);
 
 	if (!nh) {
 		struct flowi4 fl4 = {
 			.flowi4_flags = FLOWI_FLAG_ANYSRC,
@@ -2451,15 +2459,14 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
 static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_device *dev,
 				struct bpf_nh_params *nh)
 {
-	struct ethhdr *ethh = eth_hdr(skb);
-
-	if (unlikely(skb->mac_header >= skb->network_header))
+	if (unlikely(skb_network_offset(skb) < ETH_HLEN ||
+		     !pskb_may_pull(skb, ETH_HLEN)))
 		goto out;
 	bpf_push_mac_rcsum(skb);
-	if (is_multicast_ether_addr(ethh->h_dest))
+	if (is_multicast_ether_addr(eth_hdr(skb)->h_dest))
 		goto out;
 
-	skb_pull(skb, sizeof(*ethh));
+	skb_pull(skb, ETH_HLEN);
 	skb_unset_mac_header(skb);
 	skb_reset_network_header(skb);
 

pw-bot: cr
