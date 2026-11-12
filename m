Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450654;
	b=V4epbBNL02ojmHif1ak4K9pNC+9RrYaoyfKxArFsobaqQRInqhl46Gi1kAADUm1z4tr6
	 huAxD2ki9UDnqdI6Qe25MhEqSNev3JMIiWxiWxqn9Cua5qdBp7LLycXSk5gIc6eZWshba
	 /46JbrZtHlz/ikC+uFhW/ku70hKX8s3d2CuTRzFCl762xdRSyZBznJUbbumASwUF05R68
	 AEIQ9k6sZMHaU5Q//nMtpI3oPEyVLpuTQTtD6d+bVlbrHadg4D9x+sPJLJa+QNA1eODJL
	 wn+CmY02CEOffyKJk/dijzMJvMNo85fu594hPjenzrZ7BEyS+hvG8fQSX98tcMuX7dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450654;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gTQZHlCJUjOxYEpdFL/jeCbv156/zSw9VUjF1xBlN98=;
	b=Vy83q+Ewn+47h6Xr/bfekxukCikvhDy+P29/u1TqSO8ZoHjBINNMKNsIFV3mTlPfjKnB
	 ijgBBgcvOqrXR9CL7b1LNgXQogzCxATB2Paccu1c4V+7ESH9xOz5408Bbg3YdcuL667K6
	 9egf07zLi2kpZJfdCLlqB2IKfygdnlAil8eSCVQExIgpi9IObYH/YcusK9US5VBEc5Jj1
	 vnGpVv56uZ4/n1pM0+lU5vuyV6B1WB5pa/CWEQHiis2MMDhg4/s1yNJjOnGMGFboqpxOd
	 6T0l3yISk5RFsUM5T6KvQHMaV9huO6uvuKj3t8B9Dl/cPypnl8b1VoTA5jE+SMCC2AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=OSFUPa2E;
	arc=none smtp.remote-ip=91.218.175.170
Received: from mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C638B606A32E
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C638B606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=OSFUPa2E
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ex0fZxg7xmW+zEI8jmq9pJooKKCHvU2lpCHkYI6HRkQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794450652; v=1; x=1795055452;
 b=OSFUPa2EEV+sd0yk6l6/CC16TrRtTbY/gDvi59PGD4TakWOErwXxR2vqqWK5ajUUJRU6xk2L
 k31A3u/a1M02RtL7sWWV93L2hFIuf2KNB/VcQQoQ46mXEF0sfNwz2qVWPg5nsOcOVmrry3nszEx
 TWY4uUTMU2Q8g9EBiaJTu/QY=
X-Envelope-To: stable@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 8d3da5d7f84c678c;
	Thu, 12 Nov 2026 02:30:39 +0000
X-Mizu-Trace-ID: 8d3da5d7f84c678c
X-Migadu-Flow: FLOW_OUT
Date: Thu, 12 Nov 2026 10:30:27 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
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
Message-ID: <avUjeFUIFJAWbSlt@fedora>
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
>  
> -- 
> 2.56.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
