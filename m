Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CCD3B71AC;
	Thu, 17 Sep 2026 18:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789669480; cv=none; b=ApC/C8AudVdWSNTWNGIwu4n8WpJiW6tAp6A8EIY25/r4Yldl4J4WN/RDvae5CA5WVh5scmuhmgFcs89pu3aIpTpmX48V7IWlQmdr+knyek0PeeSte9ktfRJDKAt57zzTZvhG8j71uLHRZsg0z+YNoqh3UiSpbnH8hA2ytY9Ex9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789669480; c=relaxed/simple;
	bh=alJJBEQzJGK6d7ZiBM+7yKn9DCvXjhR9BV6k7r/aXH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jvpr5TotMIPVnPI7PCT40e5ZMi/Y3WTxXyrEt+IebGy5cga7r/MACPP4xP2fOy+qnbzqC1O0Qr6jtMEJjUzgG/9ye+E3xL76o+vqfPCGFw/BqR20AF1JnJdO5sd9h3+aeQjkpPLEPpMKdsG9G+mP04Y7s885e90aPm++wij0Kts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=fWSf5Wdz; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="fWSf5Wdz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=wM3pqh13NsLwdKciE371jMba8zHOqxQ6//xUW1d0wB4=; b=fWSf5Wdz2GXAA+huxrSQMrKZMh
	KK4KrbLlONSAHjH80J1TWdkXoqJcyH0tyVx1mVMDU+Ie0R40Qx0m8wXiUCHcqGtFK6NBSmtrnZbht
	snyVIk+C4/qHN5dfHnURAgUfUdOnQfgOrHgs7LCJL+n2t3PAAoHALYH+DoLXPX39i+SV/QCxS4plX
	FnmEhYxFCgXSB1a0RRQPO6z6XLz7cV78Y/bYy4AEWhRMjgHt0QEpvq06A9ZVSpNqEqT7nA2rudR2m
	zTAohGmAtKs8BhlWfHReGxdd3W0SS/V2wXGUXfSIUwJq7Uonzt0Jawfi/a6mxSrowKbuqvDO3oaJV
	rX3pTi2w==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x7Gme-0005M4-20;
	Thu, 17 Sep 2026 20:24:32 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1x7Gmc-0001AZ-1D;
	Thu, 17 Sep 2026 20:24:31 +0200
Message-ID: <48990076-414c-4196-99b9-86fce41b8054@iogearbox.net>
Date: Thu, 17 Sep 2026 20:24:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bpf: clear stale IPv4 options after LWT encapsulation
To: Weiming Shi <bestswngs@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Peter Oskolkov <posk@google.com>,
 Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
References: <20260916170406.1280954-2-bestswngs@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20260916170406.1280954-2-bestswngs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28126/Thu Sep 17 08:24:16 2026)

On 9/16/26 7:04 PM, Weiming Shi wrote:
> bpf_lwt_push_ip_encap() rebases the network header after prepending an IP
> header, but leaves IPCB(skb)->opt describing the inner IPv4 header.  An
> ingress LWT route can consequently make an ICMP error interpret an
> inner-header byte as an option length and copy 255 bytes into 40 bytes of
> stack storage.  The trace decoded with scripts/decode_stacktrace.sh is:
> 
>    BUG: KASAN: stack-out-of-bounds in __ip_options_echo
>    Write of size 255
>    Call Trace:
>     <IRQ>
>     __asan_memcpy (mm/kasan/shadow.c:106)
>     __ip_options_echo (net/ipv4/ip_options.c:96)
>     __icmp_send (net/ipv4/icmp.c:949)
>     ip_forward (net/ipv4/ip_forward.c:176)
>     lwtunnel_input (net/core/lwtunnel.c:465)
>     ip_rcv (net/ipv4/ip_input.c:612)
>     __netif_receive_skb_one_core (net/core/dev.c:6264)
>     process_backlog (net/core/dev.c:6728)
>     __napi_poll (net/core/dev.c:7787)
>     net_rx_action (net/core/dev.c:8007)
>     handle_softirqs (kernel/softirq.c:645)
>     do_softirq.part.0 (kernel/softirq.c:546)
>     </IRQ>
>     <TASK>
>     __local_bh_enable_ip (kernel/softirq.c:473)
>     __dev_queue_xmit (net/core/dev.c:4961)
>     packet_sendmsg (net/packet/af_packet.c:3143)
>     __sys_sendto (net/socket.c:2281)
>     __x64_sys_sendto (net/socket.c:2288)
>     do_syscall_64 (arch/x86/entry/syscall_64.c:84)
>     entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>     </TASK>
> 
> A helper-only reset can be restored by bpf_prog_run_save_cb(), while a
> program without ctx->cb[] access can clone-redirect the skb before a
> return-only reset.  Track active LWT runs and their control-block family
> in the BPF network context.  When the control block is not BPF scratch
> space, save its original contents and reset it immediately so clones see
> the new-family layout.  After the program returns, restore that snapshot
> when the verdict continues through the original protocol callback, then
> invalidate the stale header metadata.  Verdicts that reroute or redirect
> keep the new-family layout.
> 
> Preserve the state across nested runs and retain the ingress interface and
> L3-slave state when the protocol family changes.
> 
> Cc: stable@vger.kernel.org
> Fixes: 52f278774e79 ("bpf: implement BPF_LWT_ENCAP_IP mode in bpf_lwt_push_encap")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Assisted-by: LLM
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
> v2:
> - Save the incoming protocol control block for programs without ctx->cb[]
>    access.
> - Restore that snapshot before a verdict continues through the original
>    protocol callback, then invalidate the rebased header metadata.
> - Keep the eager new-family reset for clones and final reroute/redirect
>    consumers.
> - Add Cc: stable@vger.kernel.org.
> - Correct the patch author and reporter attribution.
> v1:
> - https://lore.kernel.org/bpf/20260915170147.3943392-2-bestswngs@gmail.com/

Hm, this is way too much fragile churn for a feature which I'm not sure is much
used (?). Can't we just save/restore the skb->cb when the BPF prog runs? Roughly
sth along these lines (untested) :

diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index da49364ec63d..9cf04b44ecc1 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -36,10 +36,24 @@ static inline struct bpf_lwt *bpf_lwt_lwtunnel(struct lwtunnel_state *lwt)
  #define NO_REDIRECT false
  #define CAN_REDIRECT true
  
+static void bpf_lwt_reset_cb(struct sk_buff *skb)
+{
+	if (skb->protocol == htons(ETH_P_IP)) {
+		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+		IPCB(skb)->iif = skb->skb_iif;
+	} else if (skb->protocol == htons(ETH_P_IPV6)) {
+		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
+		IP6CB(skb)->iif = skb->skb_iif;
+		IP6CB(skb)->nhoff = offsetof(struct ipv6hdr, nexthdr);
+	}
+}
+
  static int run_lwt_bpf(struct sk_buff *skb, struct bpf_lwt_prog *lwt,
  		       struct dst_entry *dst, bool can_redirect)
  {
  	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
+	bool encap = skb->encapsulation;
+	u8 cb_saved[BPF_SKB_CB_LEN];
  	int ret;
  
  	/* Disabling BH is needed to protect per-CPU bpf_redirect_info between
@@ -48,7 +62,12 @@ static int run_lwt_bpf(struct sk_buff *skb, struct bpf_lwt_prog *lwt,
  	local_bh_disable();
  	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
  	bpf_compute_data_pointers(skb);
+
+	memcpy(cb_saved, bpf_skb_cb(skb), sizeof(cb_saved));
  	ret = bpf_prog_run_save_cb(lwt->prog, skb);
+	memcpy(bpf_skb_cb(skb), cb_saved, sizeof(cb_saved));
+	if (!encap && skb->encapsulation)
+		bpf_lwt_reset_cb(skb);
  
  	switch (ret) {
  	case BPF_OK:

