Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.190.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794227252;
	b=kw85DJ2/psj1Xin6TXwP0mESRVtE9vlK9iyIKERoTMZolAPbuGCcCs9MTQAh4I6OwBzH
	 xH4E43fDIuuj3lMBKtDQbYoUzI2b0IVNstNjw0f3o1GRNrSDYX4ISWApJcW3eNkulhCWw
	 tyzjU3Vby6uDiF5ZFZX5igPctUCj28LBMsJVGKbp9F2t3TNDqafCOd/3o7TfEYJwyJWU5
	 knTVCRp6WlnoBpgvlTuxpA7EGyxKcmOTvR1x9h3Wn/S9n6/+czyxjwQIEnqtiskfgfR6i
	 KFnxBGxBrTw1h9T94ViGRhU6cKkzEDzH25yIFvLVef735mF7LuHbRne5jKFqnXkVLwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794227252;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Status:X-Spam-Checker-Version;
	bh=0LrPa+4HdZ0VLYI2/otVcGMGqKBTmp+XgDgTt3b5qlg=;
	b=o6gTHUzVV+cz3uGG1w/q6F/SIXilhfqJQekNZWYpDYdyPV1FO92ft4lU3CiqoYaDAEEx
	 vFPmfuU6D2Ka9rTQKT0mUiCCfPAD+PA4OaxyI+RmdI3XELCURHetk0m0LDgiFxmPjP32V
	 kE0dB3iYPVnyYsEET7sYOaS/T+EqVkH4RL0P0YAVKw/qLULT5wwwokSEObdNoh0yhQNGS
	 4MMKLVEdQkRKGwHyYjZuqJ4QgcGIkU2pzAVQo+dg9H9G5uRuUOs4UJ/BA0/YJZasmkCP/
	 9G+9McJ6qFSARwKRKHGMKSxgqkUPA05KwopoyD9kRLoQiBkNWgLxy/NoKTjsDw9rEww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=netfilter.org;
	spf=pass smtp.mailfrom=netfilter.org;
	dkim=pass header.d=netfilter.org header.i=@netfilter.org header.a=rsa-sha256 header.s=2025 header.b=jlPy1Iw2;
	arc=none smtp.remote-ip=217.70.190.124
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id F22B0606D807
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 12:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F22B0606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.a=rsa-sha256 header.s=2025 header.b=jlPy1Iw2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1794227250;
	bh=0LrPa+4HdZ0VLYI2/otVcGMGqKBTmp+XgDgTt3b5qlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jlPy1Iw27tLUi41IgzbJDh4tG0+0hubEB4C5oNU/bDbxcR1rzTu1SpeubiDZzVs9U
	 qhQ4pO2LNyJX1CSWk2MuST/rfQ8EZ8q1553zFqUteMXiGdtEkGBI0LXjAUcafgQdKD
	 W3ohU6wfEVeG9RoLUVns2+YsSgb7aInQtXknzAxAiZVwBuYe9K4HWWkkL6iONeuNw7
	 TIlzR4UhFQbjp8MIKN1rtXi0lIv27ucnG5dQSIX4/LCCFkXcWnCpqM+BPjwRnD97r9
	 khSorp8WSk6lOmRRp7BGjgM82iniSawlkqfdYPNjRNnY3plKdcGW6niiWooRab/jfE
	 gvUifN7WjnPsQ==
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 36F7660058;
	Mon,  9 Nov 2026 13:27:30 +0100 (CET)
Date: Mon, 9 Nov 2026 13:27:28 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Abdifatah Suruur <suruurism@gmail.com>
Cc: stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
	Greg KH <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y 2/2] netfilter: nft_byteorder: initialise the
 marked destination span
Message-ID: <avG8MMa_j7NXIZ5Y@chamomile>
References: <179422696909.5131.4005481731765358036@gmail.com>
 <179422697983.5131.11029262939381173340@gmail.com>
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
In-Reply-To: <179422697983.5131.11029262939381173340@gmail.com>

On Mon, Nov 09, 2026 at 03:22:59PM +0300, Abdifatah Suruur wrote:
> nft_byteorder_eval() writes only priv->len / priv->size whole elements,
> while nft_parse_register_store() marks DIV_ROUND_UP(priv->len, 4) full
> 32-bit words as initialised.  For len/size combinations that do not fill
> the last marked word -- for example size 2 with len 1, which writes no
> element at all -- the control plane still accepts a later load of the
> whole word from another expression.  That load reads stale bytes from
> the struct nft_regs stack slot in nft_do_chain(), which is not
> zero-initialised.
> 
> Zero the span that the control plane marks as initialised before the
> conversion, but only when the source and destination registers differ.
> nft_reg_overlap() allows an in-place conversion (sreg == dreg), and the
> source is already initialised in that case; zeroing it would corrupt
> the value.
> 
> This preserves multi-register support and does not reject any rule, so
> old nftables versions that generate len != size continue to load.  It
> only removes the dependency on some other initialisation of the
> register file.  Builds with CONFIG_INIT_STACK_ALL_ZERO mask the leak,
> but nft_byteorder must not rely on that.
> 
> Fixes: 14fb07130c7d ("netfilter: nf_tables: allow loads only when register is initialized")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
> ---
> 
> diff --git a/net/netfilter/nft_byteorder.c b/net/netfilter/nft_byteorder.c
> --- a/net/netfilter/nft_byteorder.c
> +++ b/net/netfilter/nft_byteorder.c
> @@ -33,6 +33,17 @@ void nft_byteorder_eval(const struct nft_expr *expr,
>  	u16 *s16, *d16;
>  	unsigned int i;
>  
> +	/*
> +	 * nft_parse_register_store() marks DIV_ROUND_UP(priv->len, 4)
> +	 * words as initialised, but this function only writes whole
> +	 * len/size elements.  Zero the marked span so that a later load
> +	 * cannot read uninitialised stack data.  Do not touch it when
> +	 * source and destination are the same register: the source is
> +	 * already initialised and zeroing it would corrupt the value.
> +	 */
> +	if (priv->sreg != priv->dreg)
> +		memset(dst, 0, DIV_ROUND_UP(priv->len, 4) * sizeof(u32));

Yes, this should be fine.

> +
>  	s16 = (void *)src;
>  	d16 = (void *)dst;
>  
> -- 
> 2.53.0
