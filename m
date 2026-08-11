Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBCA3B6BFA;
	Tue, 11 Aug 2026 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462406; cv=none; b=BBj97nS3lZ91ES2zTbPnATTGQoC1quH8MoEFJOZiiJZMUx26k7OU5P53EgbiCDeKrF+dhI2LLOKUBsSmLDN3Kgc/bn1/zoqcMj7gzCueB7v4jbjg0e3whIsGoznl1NmRkX3lP0lueBrAw9qmcHVxKOetYlU6Nn2g4XP3QGKjgcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462406; c=relaxed/simple;
	bh=Ani0hyGmCJGaqxrPmXmnyKjxsRejVuS2hFDgorsnmfU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=T/DKgfVrP3NlwGS4T0zLfSIKhffgX/jNsGUwsO+z/Hj4Jfq8jFGFVXTUSFms57Kch+tHcSTT5i1ag36YsD/nglPLv+J+vN8tDAVPfLZrBFl3NbYTuFMQE4zN4I1TSJbpXiqn6lYeEdctlo80SQngNc7FL2xgGRlBfaJVw3yGZss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=DaOzcA4d; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="DaOzcA4d"
Received: by dvalin.narfation.org (Postfix) id E374F20241;
	Tue, 11 Aug 2026 15:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786462393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8EaiKlbpCQVAvrexAqV7FKKO4XBVCQ96a5UJP4GhPLE=;
	b=DaOzcA4dN4lDtT6zpv1yBE6l+QU0pn+X46m8vZMg1bbbn8U63A4UvBodaEIv/lVPaIgBj3
	jFrnngabblkcfyt/qSGJTqetkpvIFhzINeocZ/EnOBezAtjNdQWrJ60Ut3hmNG6nUgydmT
	FAi7fwPUG5cTOXYTFKDp1bdQ85b1GHY=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net v2] batman-adv: reject unrepresentable multicast
 TVLV offsets
From: Sven Eckelmann <sven@narfation.org>
To: David Lee <david.lee@trailofbits.com>
Cc: marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com, 
 sven@narfation.org, Kyle Zeng <kylebot@openai.com>, davem@davemloft.net, 
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
 Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>, 
 netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260810145754.828936-1-david.lee@trailofbits.com>
References: <20260810145754.828936-1-david.lee@trailofbits.com>
Date: Tue, 11 Aug 2026 17:32:59 +0200
Message-Id: <178646237968.2022359.8997893163921377425.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2745; i=sven@narfation.org;
 h=from:subject:message-id; bh=Ani0hyGmCJGaqxrPmXmnyKjxsRejVuS2hFDgorsnmfU=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnVDlubdYv021hWftyTbfPI+Fgax42ix4ZzptXpd3i2J
 P63mjG9o5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCR1WaMDLvvvX61bWtO0Y4N
 cYeVpvKu+B10dkHz5vfR2iuNOo5ZJiky/Hd5senGz9y7vYcW9FmKPM2Mmad17sIsr80n99m8vMV
 hNZ8ZAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF

> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h                                                                                                                                                                
> index 22eda1d54a0e8..dbeceaf5c3b39 100644                                                                                                                                                                                   
> --- a/include/linux/skbuff.h                                                                                                                                                                                                
> +++ b/include/linux/skbuff.h                                                                                                                                                                                                
> @@ -3126,6 +3126,32 @@ static inline void skb_set_transport_header(struct sk_buff *skb
> [...]
> +static inline bool __must_check
> +skb_set_transport_header_careful(struct sk_buff *skb, const int offset)
> +{
> +	long transport_offset = skb->data - skb->head + offset;
> +
> +	if (unlikely(transport_offset !=
> +		     (typeof(skb->transport_header))transport_offset))
> +		return false;
> +
> +	if (unlikely(transport_offset ==
> +		     (typeof(skb->transport_header))~0U))
> +		return false;
> +
> +	skb->transport_header = transport_offset;
> +	return true;
> +}
> +

I personally don't like the way the lines are broken down. The 80 character
limit was replaced by a 100 character limit since commit bdc48fa11e46
("checkpatch/coding-style: deprecate 80-column warning"). And it seems like
there are already multiple lines in this file which are longer than 80
characters. So it should be possible not to add a line break right after a
comparison operator.

But I leave the judgement about this part to the netdev maintainers.

> diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
> index de907c07fa154..93492d393c347 100644
> --- a/net/batman-adv/tvlv.c
> +++ b/net/batman-adv/tvlv.c
> @@ -438,8 +438,11 @@ static int batadv_tvlv_call_handler(struct batadv_priv *bat_priv,
>  			return NET_RX_SUCCESS;
>  
>  		tvlv_offset = (unsigned char *)tvlv_value - skb->data;
> +		if (!skb_set_transport_header_careful(skb,
> +						      tvlv_offset + tvlv_value_len))
> +			return -EINVAL;
> +
>  		skb_set_network_header(skb, tvlv_offset);
> -		skb_set_transport_header(skb, tvlv_offset + tvlv_value_len);
>  
>  		return tvlv_handler->mcast_handler(bat_priv, skb);
>  	}

For the batman-adv part:

Acked-by: Sven Eckelmann <sven@narfation.org>

-- 
Sven Eckelmann <sven@narfation.org>
