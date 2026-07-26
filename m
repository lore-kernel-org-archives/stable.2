Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0451F942
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 09:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785059689; cv=none; b=mr6+BCOHzOZnuG7I+t4QVOv5/IdSEYgndeefh6rOy1QH/zgedGm1jGs11frIiKBqQ3bZbqryZeWtZwuoAyMbhsB0A0m11k4PDlq45CGI/lpftMquJmQp/fIbvuwoC3o1dojBCXsX6FgmdW1L/r4UwHKazNQ/L2V4m6PDna3JvJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785059689; c=relaxed/simple;
	bh=rbcHdK/P3OVF8/eh2vybnSEQTpy+kF+U44z15ar3am8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svrsoBNnoyMPiGAKlSHwNt2wYcYxYqL6eEPmY5wBGjapfKiGLN9LaotVoi2Rtt8X5Nosisj9OrH0ZcmPIp+j8hkcvFJEW2lDiw38u49uxFLNBYrDb+j8emuHmj7oXhS5EatmrVNM+K3nlKUlCjz+R9C4Vx4j1RJ/DHALzCnR4gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=GGLD9mJy; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="GGLD9mJy"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47de008b020so968722f8f.1
        for <stable@vger.kernel.org>; Sun, 26 Jul 2026 02:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1785059686; x=1785664486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k3FTfklkwW0zKHdhTF5lWXpeNHyu2Or6DzvCzVVGGAM=;
        b=GGLD9mJy6CvS8rzkDUZzogEQtN0DNWU0y/hAIrqqa5wuNt1RPahBd4xkcjThAXaDti
         rFjv3UmbKayeN8RnJ6kGnSsvpdzAFmqPjw+hB8fmgy1R42B0PN4kxX6qBmTwXh3wSczM
         nUGr7lDpDgdzl0fZd7wQxWTeyHWSr9LbJeLdk35g9SY2cl1OtQzGPMHlwiVAmyaFDBFV
         MXArUUkabmBaUS5rr2MEde9Z9Yjp9C8k561i5doV7qV4GMxAJUQwoKBA7t9SSSsCx6fh
         Of05WiK4+4JX2IzBUnXTfEybG6r5MoC3UUdWJTEiLt6n5CxxPN3qZRaD78VECc4T3SXQ
         x2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785059686; x=1785664486;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k3FTfklkwW0zKHdhTF5lWXpeNHyu2Or6DzvCzVVGGAM=;
        b=fBPBY5a/guIsmpgInfBesx+yNh9GoQPYf98+JmrLgK2mVPC/iDu2OrbvgQPcFjGAOO
         VE8ArxPzKmjRohlFgs7WgjZWT9WF63pxznuPmLy7pVlLn73rZGAdDsSRkn7tkSPkWGPB
         mIasp/K/LoupdRxfGaoLcSj/HGCP6YXIUobf+3XlEgQoYEjJFjSAbjeZH2z4iM9bVrQM
         4SdZJWz8RyKb4GGsVuP5Oqf0sUJLSP8/MXucYUKpNbb3dWF9j2GJ8d0qbaXJEnWJ6K0K
         c64r2g9KFvy0DjAMRVuNJSc9pvsf+AFPyryMXeKmxw+9D7Ac9K3jEVgkmSgho6PiXKKA
         BIDg==
X-Forwarded-Encrypted: i=1; AHgh+Rqp2Sh6kHjffm01hBz4PEGSN53OBJyYkf5QNoMyavhK+y/Bnz35cggVRV899cM14R9qqfcRm7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygw8L2KLZ4Ga1hEHkRfz8vHEK3iFk1nyjjBDUZEuTtkQFMjDKE
	7VBwDl8bCtA/LlPH18pPeEQLensg/gwOhit9wa0Oucn9MJ7roLfp7QUYICvXEVjpDFo=
X-Gm-Gg: AR+sD13wSFDnanEo8bnK/oqHO7gg6Bw81Gd2ajSx1tYtRXjq7D9lai6o+izYEpTFAu9
	pFGQIGv7mvmLYrcbPM7Hetwi0GpeSvN3QaMzQD5T4TiA87a9a50nHVZUYw00KDoLbqmOyKlM7tK
	c4p6D/O8texCZKEDeisyCWc55EL8uKT8c1W59NRCpE3S+fPJEVV4Lzz/qhgmG1RWertXAq1Vwe8
	CTGv/mznBO1BQ6N+IcL3hrcnkSCGI088/UvUM3PT2EGD/upoiO/k/Vb5b+cTTn9LckClKypNTLX
	D/XLOWydPyJgMQhoYlM+33BsJuC0VHdl0ApSXTZUHyCPe07O+UE0C+81hRwDoLX8ap9vPhFdcc/
	Fx6HCWShArM8GbK2k09llC4PB+aYBx7hXGt2kO3BRl5wUPRGvyoja3YT9OO/tVYh7/2Oqu7S54A
	==
X-Received: by 2002:a5d:588e:0:b0:47f:8eb0:c825 with SMTP id ffacd0b85a97d-47f9febcb6cmr5567797f8f.24.1785059685740;
        Sun, 26 Jul 2026 02:54:45 -0700 (PDT)
Received: from localhost ([109.160.73.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a5c4sm38834155f8f.8.2026.07.26.02.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 02:54:44 -0700 (PDT)
Date: Sun, 26 Jul 2026 12:54:33 +0300
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Baul Lee <baul.lee@xbow.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org, idosch@nvidia.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, federico.kirschbaum@xbow.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: bridge: mrp: fix uninitialised bytes on the wire
Message-ID: <amXZWTkZK7EYVwbh@penguin>
References: <20260726062518.43774-1-baul.lee@xbow.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260726062518.43774-1-baul.lee@xbow.com>

On Sun, Jul 26, 2026 at 03:25:18PM +0900, Baul Lee wrote:
> br_mrp_alloc_test_skb() builds MRP test frames on an skb from
> dev_alloc_skb(), which does not zero the linear data area.  On the MRA
> ring-role branch the sub-option TLV header is appended with
> 
> 	sub_tlv = skb_put(skb, sizeof(*sub_tlv));
> 	sub_tlv->type = BR_MRP_SUB_TLV_HEADER_TEST_AUTO_MGR;
> 
> leaving sub_tlv->length unwritten, and the two trailing alignment bytes
> are appended with a bare skb_put() that neither writes nor clears them.
> The surrounding oui and sub_opt regions are explicitly memset(0), which
> bounds the exposure to exactly these three bytes.
> 
> Every MRA MRP_Test frame therefore carries three bytes of stale
> page-allocator memory, at frame offsets 65 to 67, to any observer of the
> MRP control traffic.  A capture on a kernel without
> CONFIG_INIT_ON_ALLOC_DEFAULT_ON shows those bytes varying frame to frame
> and, after a page-allocator spray, carrying the sprayed pattern; the
> same reproducer on an otherwise identical CONFIG_INIT_ON_ALLOC_DEFAULT_ON
> kernel leaks nothing, confirming the source is uninitialised allocation
> memory.  Reaching it needs CAP_NET_ADMIN, which is self-satisfiable on a
> stock kernel through unprivileged user and network namespaces.

Drop this entire unnecessary paragraph (slop).

> 
> Assign the sub-option TLV length explicitly, which is 0 as the AUTO_MGR
> sub-TLV carries no payload, and append the alignment padding with
> skb_put_zero().
> 
> Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
> 
> Fixes: f7458934b079 ("net: bridge: mrp: Update the Test frames for MRA")
> Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
> Reported-by: Baul Lee <baul.lee@xbow.com>

You don't need a reported-by tag since you've already signed off
the patch.

> Cc: stable@vger.kernel.org
> Signed-off-by: Baul Lee <baul.lee@xbow.com>
> ---
>  net/bridge/br_mrp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
> index 3f7126a7d720..a5548f475604 100644
> --- a/net/bridge/br_mrp.c
> +++ b/net/bridge/br_mrp.c
> @@ -226,9 +226,10 @@ static struct sk_buff *br_mrp_alloc_test_skb(struct br_mrp *mrp,
>  
>  		sub_tlv = skb_put(skb, sizeof(*sub_tlv));

if you use skb_put_zero here, you can drop the explicit zeroing below,
in fact you can add the MRP_OPT_PADDING as well and move the comment
above it then drop the second skb_put_zero entirely

>  		sub_tlv->type = BR_MRP_SUB_TLV_HEADER_TEST_AUTO_MGR;
> +		sub_tlv->length = 0x0;
>  
>  		/* 32 bit alligment shall be ensured therefore add 2 bytes */
> -		skb_put(skb, MRP_OPT_PADDING);
> +		skb_put_zero(skb, MRP_OPT_PADDING);
>  	}
>  
>  	br_mrp_skb_tlv(skb, BR_MRP_TLV_HEADER_END, 0x0);
> -- 
> 2.50.1 (Apple Git-155)
> 
