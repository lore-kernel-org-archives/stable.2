Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ADB2DF153;
	Wed, 24 Jun 2026 11:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782301722; cv=none; b=jkjjM93U/xlIkjkkPMOwZNOgcGCe/+WSHxch+xJqrZtc5XETL5os+euLX20c/a1NeTD+CoXvg8ab1GIc2A2dpvvzVQaDsrqbh1jxqiywPBZ92EbjRnSjzLF+vr20MgI7vyhWkxrnkK14VcinuzQowzH3ost8ZPvgroB3v8mx+eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782301722; c=relaxed/simple;
	bh=Tb+d2AAtLwTqkgvKXoUk3ISGmsbGCps99DXhFcY4tik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TX/ggXJ2YWTTZAmrMETIujDdxxiQFRy2im8kAca3YatIEJxF11QBJ2y0RRabgJLAuRxmgJwqmo8rLxhniS93erjaohNaBuyCEOwcfpR3StmB+TaWEW84I4IIGrc4FM3kEeTzT7+e0e4k0xTyarLSRbv1W8eNw11qIP2nBindlr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=RzcORzDA; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="RzcORzDA"
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 188ED6057B;
	Wed, 24 Jun 2026 13:48:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1782301711;
	bh=5EJ4tt0BF14PyUb1G8s5DQNcfkPtXwzrKk/jyjeL05k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RzcORzDAnE8unbh+no/SvQkRTf9ugPpAbvfTtE7jF8cRTX54p5fmV9rv0v6w6FGBY
	 oDb9OIleW+MoQhxD/TK0E47Y03d94dk9/0ghrgZoaJcCNKjMPxpDz7sxlDxzXEEHJv
	 jKQr3BGXhW+H+QtYicDIRIgC+UXyui61xv1w20N8UaiibZdPX4IXbikRjarUoFXI+R
	 iqqMqjaZBZg/t4SSR6+FrF3DDaGJycqJ+JzJC1M+KUMPlnL9XoxjMjlWvf6p++e9ia
	 kc2NhyEs4I3PQzO307hxePimRRuHIIOpSYry8zG9cbl8Ui+Xe5CkweXPZWIIDxeEV6
	 aW7kTdto/ipNg==
Date: Wed, 24 Jun 2026 13:48:28 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Alexander Martyniuk <alexevgmart@gmail.com>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	Jakub Kicinski <kuba@kernel.org>, Patrick McHardy <kaber@trash.net>,
	netfilter-devel@vger.kernel, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH 5.10] netfilter: nf_log: validate MAC header was set
 before dumping it
Message-ID: <ajvEDFOlP7Bqb-3j@chamomile>
References: <20260624140117.19799-1-alexevgmart@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260624140117.19799-1-alexevgmart@gmail.com>

Hi,

Thanks but why only 5.10?

On Wed, Jun 24, 2026 at 02:01:15PM +0000, Alexander Martyniuk wrote:
> From: Xiang Mei <xmei5@asu.edu>
> 
> commit a84b6fedbc97078788be78dbdd7517d143ad1a77 upstream
> 
> The fallback path of dump_mac_header() guards the MAC header access
> only with "skb->mac_header != skb->network_header", without checking
> skb_mac_header_was_set(). When the MAC header is unset, mac_header is
> 0xffff, so the test passes and skb_mac_header(skb) returns
> skb->head + 0xffff, ~64 KiB past the buffer; the loop then reads
> dev->hard_header_len bytes out of bounds into the kernel log.
> 
> This is reachable via the netdev logger: nf_log_unknown_packet() calls
> dump_mac_header() unconditionally, and an skb sent through AF_PACKET
> with PACKET_QDISC_BYPASS reaches the egress hook with mac_header still
> unset (__dev_queue_xmit(), which would reset it, is bypassed).
> 
> Add the skb_mac_header_was_set() check the ARPHRD_ETHER path already
> uses, and replace the open-coded MAC header length test with
> skb_mac_header_len(). Only skbs with an unset MAC header are affected;
> valid ones are dumped as before.
> 
>  BUG: KASAN: slab-out-of-bounds in dump_mac_header (net/netfilter/nf_log_syslog.c:831)
>  Read of size 1 at addr ffff88800ea49d3f by task exploit/148
>  Call Trace:
>   kasan_report (mm/kasan/report.c:595)
>   dump_mac_header (net/netfilter/nf_log_syslog.c:831)
>   nf_log_netdev_packet (net/netfilter/nf_log_syslog.c:938 net/netfilter/nf_log_syslog.c:963)
>   nf_log_packet (net/netfilter/nf_log.c:260)
>   nft_log_eval (net/netfilter/nft_log.c:60)
>   nft_do_chain (net/netfilter/nf_tables_core.c:285)
>   nft_do_chain_netdev (net/netfilter/nft_chain_filter.c:307)
>   nf_hook_slow (net/netfilter/core.c:619)
>   nf_hook_direct_egress (net/packet/af_packet.c:257)
>   packet_xmit (net/packet/af_packet.c:280)
>   packet_sendmsg (net/packet/af_packet.c:3114)
>   __sys_sendto (net/socket.c:2265)
> 
> Fixes: 7eb9282cd0ef ("netfilter: ipt_LOG/ip6t_LOG: add option to print decoded MAC header")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
> ---
> Backport fix for CVE-2026-52942
>  net/ipv4/netfilter/nf_log_ipv4.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/netfilter/nf_log_ipv4.c b/net/ipv4/netfilter/nf_log_ipv4.c
> index d07583fac8f8..d6164e8e2c73 100644
> --- a/net/ipv4/netfilter/nf_log_ipv4.c
> +++ b/net/ipv4/netfilter/nf_log_ipv4.c
> @@ -296,8 +296,8 @@ static void dump_ipv4_mac_header(struct nf_log_buf *m,
>  
>  fallback:
>  	nf_log_buf_add(m, "MAC=");
> -	if (dev->hard_header_len &&
> -	    skb->mac_header != skb->network_header) {
> +	if (dev->hard_header_len && skb_mac_header_was_set(skb) &&
> +	    skb_mac_header_len(skb) != 0) {
>  		const unsigned char *p = skb_mac_header(skb);
>  		unsigned int i;
>  
> -- 
> 2.43.0
> 
