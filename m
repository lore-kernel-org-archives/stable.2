Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794741664;
	b=dS2Dsc/cNOa0Km3JtxaLaObZJE//rzql7z3gnNnYGL5hQu5cHVOlLEIu7rI2CyHvdloT
	 vKU8hl8pw+j1KVwW8bhFO/jmhs1oNL22PtyLsqbvcepj1MKPUX0UHyrA7eQh7VMoRkvmZ
	 QvO74fm9SEUxee1PQ35uSw2K95rfWWfd3ATmC1Xx3DNdnhyTtVQYShRl9Q1y5pTpM7DJr
	 BUASZAYC6tBWJfFDJB++jv6vC1VO17wjkwzg5erXYLPlqbY6EoKYfgKqUtVbrr8tFqJa2
	 4SDdps9Cy5j4GMr4Lo9T3dG4IdvkZUyYxiwYxthQDRH5ErZ2trYQ1q3yJ8GIxeQm81w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794741664;
	h=DMARC-Filter:Received:Received:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=zvMxoLGnfRp8tv67Jq4LKWZMseIi6n4cTVWrV6bYWbc=;
	b=ueXLCJsCN9vMHpsDi92caYBb086+It5Y6vNIR4x75QNWqbhq/Xoqr9WZ9+zZMaG50ODC
	 PsZIe2ET+tbIyAYLnLqyVNlr3J8XiHTJJlTZ/6FXVm94DLQ6KKDhstrKx/dH2hFoJPZiN
	 QRRwPPTwiWa09iSK0i1VcFFBZD9WxqWlkq7qfDGvluDif3OKcYkno6MCnZN2Vhr2/b4v4
	 dZaAKIHYJkImrn7gQAes/PDB8D2pkzlNH0oEllFm2HjlGhrRprittZAUqm2scpGf0OnB9
	 knTzm6OCfQ9dkF73a8SK54XNkw9K3X8bqGE43cxhNRO5YXHfWSVDMfk0d3jeEhdYH+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=idosch.org;
	spf=none smtp.mailfrom=idosch.org;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5HHvSaac;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E14606A31E;
	Sun, 15 Nov 2026 11:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44E14606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5HHvSaac
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 3ED72EC0170;
	Sun, 15 Nov 2026 06:21:02 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 15 Nov 2026 06:21:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794741662; x=1794828062; bh=zvMxoLGnfRp8tv67Jq4LKWZMseIi6n4cTVW
	rV6bYWbc=; b=5HHvSaacFfQyShlbT5WKZ2ky52H6HNyVSA8lpIdIA9Cyn/62tDZ
	8QydcnNK2ZSh5po6r+CiFmp8WnEF7+rH4P14vyqkgvz9YFsQQmQoUVIx5SBsCkc5
	iqHeGv+Oxk6ojWdGByvblj1kiuzkNRRVB3u4shdN4hOfmyIafJxmF7mF8tvgQfPw
	F8Xr0Emywln+FIp+V5867oLK2evKldoJcjy0TI3qAvhgUZ952vNGB96OaFM/tMZ+
	K9oUYY6o+9L7bVWmn57P7SK23pjwJTZNZzo2qfjX94kYGwzU2VvFl9WBR1DLzed+
	nE8hfJXgjaJohvQwF7U2C/08W001MrP7MWA==
X-ME-Sender: <xms:nZX5amgxwxCwj_Dr5EhBPzGy_Vjy8JbGqnKrKpGirFVdJ0gMl2boCQ>
    <xme:nZX5agbFxQ7RbvUX56iVxuTnvI1ZVlLNb7-BHDbzn3gXEBHGj4k3FQf8DI2RvC1YM
    W62lqL5mNN_IiktI5bTDNjX4_ll09dplMZPIC10rBSElJEFahk>
X-ME-Received: <xmr:nZX5ammFv571J8salEjiw2C2w8BFalzep2SZrFF-TolQeY3TAaTtrybE>
X-ME-Proxy-Cause: dmFkZTEUg9AShikM2WElaOQw8QsfrZsSnDDjyKJ+vhQ7mihu5UdoMhDaECuZNvQaIBj6/G
    3zODFH303/a3RTn8Uo7Sxrk6mBOm4LoFBeaqEr+4zRHeFUimykUy9sDkB4et0n6Goh9F5O
    +vmyN9QfgxjAbCFtqut3Et71mpOCyVgfZRMzBYKXVovrtFk9DQenBbcSaOydvBMeVicGer
    pRXPyVpas3o7Ivq7o9FNHKeDxypdDXfDuyO4OCuBklVFdRh88RsEs4IfEIfJn5QgkrPxAK
    hLhPisoqDpsrNouYBHds/wHjFT6tWlGyQ0En6Kgytcmb39/FoPojbMbUdS4YX3OJREnqkh
    Ag0joBmiC59blbunpGLW7dp6Z1bncvvSRAaw510cC+HawuHbjI6WDpUnNcFnONmMHNU2zy
    8btBDejU520TDEY2X1hduDYxDhsF2rNd1gbRuLrchJEyQV1WkLXMKXOAs1jhtXwqdFFnOL
    ftBSkfedGQb1WzAr89z/rv+jmqWkeRE6GuaQ+94SAMBxT4J49MIKYK7+Jqv5K3HC8+p7q1
    s2gA1uCv6e+9CgLOtgwI/m9TZzqGTZmbaTKpytwO4pBRnYJE1DBKPUWOoz7B73MznzuTY1
    EADsxCO2yAR8sW8FbrA5XSoDyNstaRmlZ+fjiPA2oxNMprH/QoWzomkAEK0g
X-ME-Proxy: <xmx:nZX5auyhbPA-YnY1Z-9SdtCgWkYBO2fR64LdhwOpsOeFeu8uaT_8TA>
    <xmx:nZX5ak__98NWzudIVK6VVIgvaybGw2nQ3v_uJDPjZa4D_AM_9npLyw>
    <xmx:nZX5apB4TsxkMuw1MeWX8_gRT4Mjmz1G_pC8DoZvPvH8ot6r2Y5swA>
    <xmx:nZX5arpXcDxlWmNuQPdjjPpdi5gFz0YZsCvB8hZLpFZEViCAChQALg>
    <xmx:npX5ao4_-nTj9e87Nx2nf0Zi4xPuTamN0A6KuM5pmXFd834pod5fl98S>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Nov 2026 06:21:00 -0500 (EST)
Date: Sun, 15 Nov 2026 13:20:58 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, bpf@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org,
	co+beaa1ed2d7aaec16@bugs.sh
Subject: Re: [PATCH net] net: initialize ICMP error queue opt_stats
Message-ID: <20261115112058.GA3951124@shredder>
References: <20261111170528.495116-3-bestswngs@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111170528.495116-3-bestswngs@gmail.com>

On Wed, Nov 11, 2026 at 09:05:30AM -0800, Weiming Shi wrote:
> ip_icmp_error() and ipv6_icmp_error() clone a received ICMP skb before
> building its error queue entry.  skb_clone() preserves the complete control
> buffer, while the IP receive paths initialize only the portion aliased by
> sock_exterr_skb::header.  The two functions initialize ee, addr_offset, and
> port, but leave the final byte containing opt_stats and unused untouched.
> A TCX classifier can leave bpf_skb_data_end::data_end across that byte,
> forging opt_stats and making __sock_recv_timestamp() pass skb->len bytes
> from skb->data to put_cmsg().  For a non-linear ICMP skb, this reads beyond
> its linear head.
> 
> Initialize both bitfields in the two clone-based producers.  Do not clear
> the whole sock_exterr_skb because the error receive paths consume the saved
> IP control-buffer header.
> 
>   usercopy: Kernel memory exposure attempt detected from SLUB object
>             'skbuff_small_head' (offset 72, size 59964)!
>   kernel BUG at mm/usercopy.c:102!
>   Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>   RIP: usercopy_abort (mm/usercopy.c:102)
>   Call Trace:
>    __check_heap_object (mm/slub.c:8146)
>    __check_object_size (mm/usercopy.c:258)
>    put_cmsg (net/core/scm.c:276)
>    __sock_recv_timestamp (net/socket.c:1061)
>    ip_recv_error (net/ipv4/ip_sockglue.c:550)
>    udp_recvmsg (net/ipv4/udp.c:2034)
>    inet_recvmsg (net/ipv4/af_inet.c:896)
>    sock_recvmsg (net/socket.c:1159)
>    ____sys_recvmsg (net/socket.c:2918)
>    ___sys_recvmsg (net/socket.c:2961)
>    __sys_recvmsg (net/socket.c:2993)
>    do_syscall_64 (arch/x86/entry/syscall_64.c:94)
>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
>   Kernel panic - not syncing: Fatal exception
> 
> With HARDENED_USERCOPY enabled, the reproducer aborted the unpatched kernel
> on its first packet.  With runtime usercopy checks disabled and KASAN left
> in report mode, the same recvmsg() returned 59,964 control-message data
> bytes sourced past a 704-byte skb head.  Beyond offset 1,024, 58,932 bytes
> differed from the prefilled userspace marker, including 6,288 nonzero
> bytes.  The patched build completed 2,000 packets under both configurations
> without a forged SCM_TIMESTAMPING_OPT_STATS message or sanitizer report.
> Networking selftests were not run.
> 
> Fixes: 4ef1b2869447 ("tcp: mark skbs with SCM_TIMESTAMPING_OPT_STATS")
> Cc: stable@vger.kernel.org
> Reported-by: <co+beaa1ed2d7aaec16@bugs.sh>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> 
> ---
>  net/ipv4/ip_sockglue.c | 2 ++
>  net/ipv6/datagram.c    | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index a55ef327ec93..3ab84a4c31e5 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -429,6 +429,8 @@ void ip_icmp_error(struct sock *sk, struct sk_buff *skb, int err,
>  	serr->addr_offset = (u8 *)&(((struct iphdr *)(icmp_hdr(skb) + 1))->daddr) -
>  				   skb_network_header(skb);
>  	serr->port = port;
> +	serr->opt_stats = 0;
> +	serr->unused = 0;
>  
>  	if (skb_pull(skb, payload - skb->data)) {
>  		if (inet_test_bit(RECVERR_RFC4884, sk))
> diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
> index ca3605acb433..85f646f8d059 100644
> --- a/net/ipv6/datagram.c
> +++ b/net/ipv6/datagram.c
> @@ -330,6 +330,8 @@ void ipv6_icmp_error(struct sock *sk, struct sk_buff *skb, int err,
>  	serr->addr_offset = (u8 *)&(((struct ipv6hdr *)(icmph + 1))->daddr) -
>  				  skb_network_header(skb);
>  	serr->port = port;
> +	serr->opt_stats = 0;
> +	serr->unused = 0;
>  
>  	__skb_pull(skb, payload - skb->data);

How about [1] instead?

Allows us to avoid potential issues in the future.

[1]
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index e06c1f48ecad..096546727c3d 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -419,13 +419,12 @@ void ip_icmp_error(struct sock *sk, struct sk_buff *skb, int err,
 		return;
 
 	serr = SKB_EXT_ERR(skb);
+	memset_after(serr, 0, header);
 	serr->ee.ee_errno = err;
 	serr->ee.ee_origin = SO_EE_ORIGIN_ICMP;
 	serr->ee.ee_type = icmp_hdr(skb)->type;
 	serr->ee.ee_code = icmp_hdr(skb)->code;
-	serr->ee.ee_pad = 0;
 	serr->ee.ee_info = info;
-	serr->ee.ee_data = 0;
 	serr->addr_offset = (u8 *)&(((struct iphdr *)(icmp_hdr(skb) + 1))->daddr) -
 				   skb_network_header(skb);
 	serr->port = port;
diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index ff7a7ffbf983..f932d5a0d618 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -324,13 +324,12 @@ void ipv6_icmp_error(struct sock *sk, struct sk_buff *skb, int err,
 	skb->protocol = htons(ETH_P_IPV6);
 
 	serr = SKB_EXT_ERR(skb);
+	memset_after(serr, 0, header);
 	serr->ee.ee_errno = err;
 	serr->ee.ee_origin = SO_EE_ORIGIN_ICMP6;
 	serr->ee.ee_type = icmph->icmp6_type;
 	serr->ee.ee_code = icmph->icmp6_code;
-	serr->ee.ee_pad = 0;
 	serr->ee.ee_info = info;
-	serr->ee.ee_data = 0;
 	serr->addr_offset = (u8 *)&(((struct ipv6hdr *)(icmph + 1))->daddr) -
 				  skb_network_header(skb);
 	serr->port = port;

