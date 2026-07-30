Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0FF441041
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 15:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785425269; cv=none; b=mFKW/slCXvFW3ustf+Rt6aK7qLFORo2g42TgpnRa7NWwQxxpLkV/YoyLPANm1SRZBvv61D1wyJ/2WRsgTbN+Fq/0ZJc8IrVu7VilFA4SaDT5fzCyIFjUEgTtCAUjyBppvBstt+9xEC3nvYyDCknrgOe4RrDLnqweST2QSJFCOpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785425269; c=relaxed/simple;
	bh=d5RXFfVRX5p3oscQXB9FNGQJzjxxqOI0ZyUQ/yhbbX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufVGwsNf6E+0DhZzsv0WnDDusUUhLiJYl3AMLOEF/PaaXDOOtgyrrzpYoM6dwHa3BtVgcQ2qfmY7+GiVYEGD858EXUL0FcDha0tA0Nf6VtIdVBUrGhNDpVb+F6KQAkf1Zr+9YkSkpb6GZ3I37wPb8eLF4H4wgI1FvvpAyuS3qIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=MvUYPrTR; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="MvUYPrTR"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49548e01d02so10578655e9.0
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 08:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1785425264; x=1786030064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nzJUatZRCgVEofo3LM1zenQhlJFklBY9WtRFTuod4dQ=;
        b=MvUYPrTRlUzfqhGO2lvbt+DzpOn3ZZ9R4BWLe3W386eVczuQ5jyFZYWflnlgJjiOcR
         SMbwCzv6Ap6noHsptRWREdy0iDN5UjtZ+Jv5Au2VasahB3UTot8Dwu1JAagLBlPjTR9m
         DX4OZThyja3k403hIVqCCjLHcE2dkAh65yLbCFZsxLI4A139S6MnFzpsrOT5rY2yOhQl
         K5bgvN03sIPLtSMygse2btmEwDDyZSY9LOkmXFUowJyHkI32+Ng5pvcyNcnTugCCPHo6
         LgXVymOwrinsKiUoKw8QNSvafvSU7V9c/uAcpRCSQ/ArLuhNewhUjHQ/jOYn6fRWlOv0
         reew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785425264; x=1786030064;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nzJUatZRCgVEofo3LM1zenQhlJFklBY9WtRFTuod4dQ=;
        b=p6WirOCmED5T1PbyFrgteDKlidhHs6lEEm9ln0ykWAHby/54yELc/Jk8SJ+j61WnqW
         /7wXAo12CTE9CTOkoYApd+wSL8Pzh31pHjobw3+8hS6bEh10S/lymUJvUmhZ9nfSpV5Z
         CnERIzIMRg33DSXeMWuN0FjCjlh9uj2Jw8ZqgwFqrZMYWZ8m9Zn2u5bW9gBqnO/vcDMb
         STyoZT8ao5+AKhWshrfFIw0ILKnQOmPG2skHecJl2rYK7hgrVQRfiFooXCrT9nHwmT5V
         42fI3aNvQVMqfUF6mMT4UWnXY8EUxLHEooxNX/dF/aLfbZNaDSEpSuDswI9zJcovA40z
         cxng==
X-Forwarded-Encrypted: i=1; AHgh+RqNNX3N/pVgZ75Fl35jl/IuvV5CddS401PTOl7L7eAb+pP7TFGpHGlcqkVO4Ee1artTjHF3bOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVQfsb4jO2JpIJ5fIyFcvftRRtknUlc1oVcmJSwq7b91S0GxmW
	fmaV+yjvNWIzcBxRynitmAOnNnfGJti2S7+OzkrHZJ6rF5dDhtwEmjQk0iltjVz3dVA=
X-Gm-Gg: AR+sD129FwRkDIimTbHhGWYDvFPBe9KOTyBFj9W3032cGNiZpBKpvXtA+znBlfJ7YuK
	mhq5RGhVWrWdKOp8oLui6MuMLFd6JwxVlmX2f4PnZK3vv5RjyEBqoeQu8TFgfLGJmTc02TTBDgS
	mJbyZcg8l6Mbma0sUIdhRIAnpw24IzCIi6xU9aytO9jHSHpIAeosnXbGSwx2+nvlP+y0Y/N3mtb
	AlfU8I42BJQqtGFoufL+XomjamhP/ZmtBFZRjSLULO94HmsFsw7qmzNbwkkDWJNxWjgPOcXs6aV
	+7aWMRBq/XAi9do1//yfAaK8FD3+QptnVEQ53JAgh/s6H+MyK/D+31EmpcPLe9DNPy3kJbaqQLB
	Ia71fQWZTbZamiz8PtHZ1xVM3Js6eD9Vc4fd7BLBkPY/N+efL35eawp88de/ZOCP5HeKoGSNdgL
	ndlN9HON80EprVOTLSa6kdTRjLcnWFkYq7fpU9yUHITpUGpRj3ZSbGuwo=
X-Received: by 2002:a7b:cc89:0:b0:495:6f6b:fb75 with SMTP id 5b1f17b1804b1-49800ebba08mr29432035e9.38.1785425264161;
        Thu, 30 Jul 2026 08:27:44 -0700 (PDT)
Received: from localhost ([109.160.74.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498011fd5fesm62954505e9.7.2026.07.30.08.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 08:27:43 -0700 (PDT)
Date: Thu, 30 Jul 2026 18:27:41 +0300
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Baul Lee <baul.lee@xbow.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: bridge: mrp: fix uninitialised bytes on the
 wire
Message-ID: <amttbcdZkuWVSdLE@penguin>
References: <20260726062518.43774-1-baul.lee@xbow.com>
 <20260729131941.10254-1-baul.lee@xbow.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729131941.10254-1-baul.lee@xbow.com>

On Wed, Jul 29, 2026 at 10:19:41PM +0900, Baul Lee wrote:
> br_mrp_alloc_test_skb() builds MRP test frames on an skb from
> dev_alloc_skb(), which does not clear the linear data area.  On the MRA
> ring-role branch the sub-option TLV header is appended with
> 
> 	sub_tlv = skb_put(skb, sizeof(*sub_tlv));
> 	sub_tlv->type = BR_MRP_SUB_TLV_HEADER_TEST_AUTO_MGR;
> 
> so sub_tlv->length is never written, and the two trailing alignment bytes
> are appended with a bare skb_put() that does not clear them either.  The
> neighbouring oui and sub_opt regions are explicitly zeroed, so three
> uninitialised bytes are left in every MRA MRP_Test frame that goes out.
> 
> Put the sub-option TLV header and the alignment padding in a single
> skb_put_zero(), which clears both.  The AUTO_MGR sub-TLV carries no
> payload, so the zeroed length field is already the value it should have.
> 
> Fixes: f7458934b079 ("net: bridge: mrp: Update the Test frames for MRA")
> Suggested-by: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Baul Lee <baul.lee@xbow.com>
> ---
> v2:
>  - fold the alignment padding into a single skb_put_zero() for the
>    sub-option TLV header, dropping the explicit length assignment and the
>    second skb_put() (Nikolay Aleksandrov)
>  - drop the paragraph about observing the leak, and the Reported-by tags
> 
> Link to v1: https://lore.kernel.org/netdev/20260726062518.43774-1-baul.lee@xbow.com/
> 
>  net/bridge/br_mrp.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
> index 179d2470b..ef16d0703 100644
> --- a/net/bridge/br_mrp.c
> +++ b/net/bridge/br_mrp.c
> @@ -224,11 +224,9 @@ static struct sk_buff *br_mrp_alloc_test_skb(struct br_mrp *mrp,
>  		sub_opt = skb_put(skb, sizeof(*sub_opt));
>  		memset(sub_opt, 0x0, sizeof(*sub_opt));
>  
> -		sub_tlv = skb_put(skb, sizeof(*sub_tlv));
> -		sub_tlv->type = BR_MRP_SUB_TLV_HEADER_TEST_AUTO_MGR;
> -
>  		/* 32 bit alligment shall be ensured therefore add 2 bytes */
> -		skb_put(skb, MRP_OPT_PADDING);
> +		sub_tlv = skb_put_zero(skb, sizeof(*sub_tlv) + MRP_OPT_PADDING);
> +		sub_tlv->type = BR_MRP_SUB_TLV_HEADER_TEST_AUTO_MGR;
>  	}
>  
>  	br_mrp_skb_tlv(skb, BR_MRP_TLV_HEADER_END, 0x0);
> -- 
> 2.53.0
> 

You should not send patches as replies, they should be sent on
their own. Aside from that the patch looks good to me:

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
