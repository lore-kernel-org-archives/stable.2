Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=94.136.29.106
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793196709;
	b=B0yaMXTykCLgf0VEIUJnXAA7SCE6yZtBaxtwL4hkRiHYEuly8l8wNppZW5VKjoqdO+3p
	 mWeZxVb7UqTNofO7yp3yG1NLI90u42Fj/o1Rl9CbQ8UY8ZQ0d6XykGEFIHJ/muIwapJen
	 lrQGPt7V0R7BVBu47w5z6hIENz5lktmIzxOl0jhBEB+IyGYbNjF7O4Zq/U//JZ5ycqYtg
	 05xCwus1rH0hhPQGo0JH4Bg6FmgU3blRcC3WwV4efcwMbZaR4rIg1Wxbp1TvYm7rYjLR5
	 1g+ITaX9Uwp9Whr+zZoVbasQDaDuXXRxSkUEgEzA9qa/v7IEj92f7pAtgHxrrqdZb2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793196709;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent:
	 X-Bm-Milter-Handled:X-Bm-Transport-Timestamp;
	bh=Oas1iDvhjflqMxlRkG543vYH9mLSvNdodcghSDCtqRs=;
	b=XIbori+3vzNr9OobAqGnVnhomwk2ml/0FLbnc3EzNnK+l+UFJkheqoR5R7Z+6RobBGn7
	 UHR1mbjVe+Su1QyeobFcUbTnd3ETKbSJDqa6QBPK62eo3JiSvgk4cBNRKbvI8WcLi1HOW
	 /d7GLVwfp06i84IySu4fUiQks8/cuV4HJNLdo6b+G1B0ZA+AeU3vOWPV5xhqGXmvxqgcF
	 wV01SD7013ufbCEZSyMjwmpGZxz69fNgpsErAuLP2mfkL4odzVzOEl9BUXPTHNoVRTU+j
	 U3iG9rSIH34HNcNy9hdHdntggYJCG07JsxfJiTXCpNFzjqDpNFxKbvKZjC4gc12o3Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=proxmox.com;
	spf=pass smtp.mailfrom=proxmox.com;
	arc=none smtp.remote-ip=94.136.29.106
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E91606A31A;
	Wed, 28 Oct 2026 14:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8E91606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 1AF694383A;
	Wed, 28 Oct 2026 15:11:46 +0100 (CET)
Date: Wed, 28 Oct 2026 15:11:43 +0100
From: Gabriel Goller <g.goller@proxmox.com>
To: Tang Bin <tangbin@cmss.chinamobile.com>
Cc: andrea.mayer@uniroma2.it, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] seg6: fix OOB read in advance_nextseg when segments_left
 is 0
Message-ID: <auIA8TfNYq8XuD_i@luna.proxmox.com>
References: <20261028113141.2111-1-tangbin@cmss.chinamobile.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261028113141.2111-1-tangbin@cmss.chinamobile.com>
User-Agent: NeoMutt/20260504
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1793196704580

On 28.10.2026 19:31, Tang Bin wrote:
> advance_nextseg() decrements srh->segments_left and uses it to index
> srh->segments without checking it is non-zero. seg6_validate_srh() permits
> segments_left == 0, so a packet with SRH segments_left==0 reaching an End*
> action underflows the u8 (255) and reads srh->segments[255] (~4KB out of
> bounds); the read bytes are then used as the new IPv6 destination address
> (info leak) or crash on unmapped memory. The decap path
> (decap_and_validate) already checks segments_left > 0, but the standard
> End/End.X/End.T/End.B6.Encap/End.BPF paths do not. Reject segments_left ==
> 0 before decrementing.
> 
> Fixes: d7a669dd2f8b ("ipv6: sr: add helper functions for seg6local")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  net/ipv6/seg6_local.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
> index 53f7b2452..1d8312467 100644
> --- a/net/ipv6/seg6_local.c
> +++ b/net/ipv6/seg6_local.c
> @@ -310,6 +310,10 @@ static struct ipv6_sr_hdr *advance_nextseg(struct sk_buff *skb,
>  	/* skb_ensure_writable() may change skb pointers; evaluate srh again */
>  	srh = (struct ipv6_sr_hdr *)(skb->data + srhoff);
>  
> +	if (srh->segments_left == 0) {
> +		*reason = SKB_DROP_REASON_NOT_SPECIFIED;
> +		return NULL;
> +	}
>  	srh->segments_left--;
>  	addr = srh->segments + srh->segments_left;
>  	ipv6_hdr(skb)->daddr = *addr;
> -- 
> 2.52.0.windows.1

Can you show a codepath where it is possible to call advance_nextseg() with
srh->segments_left being 0?

End/End.X/End.T/End.B6.Encap/End.BPF behaviors call get_and_validate_srh(),
which calls seg6_get_srh(skb, IP6_FH_F_SKIP_RH), which uses ipv6_find_hdr(),
which skips all the segments_left=0 headers.

Thanks,
Gabriel

