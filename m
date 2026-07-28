Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3B32E06E6
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785252646; cv=none; b=h/cMhPsBcCoOAgWHBH6RU1oK7SbDD8lCafdpO98FqwbznVc925VtY3D/859aC74g+KBqOaeB6V0DoGyLdFL7UHULBn1fmiFK2DG+ypLA0+uOvI8rMzebf/9OE1HLd+CV7NSW/nQK+kdUmo7VvrbiqmeFfHdy/fvixLmz+IqpGlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785252646; c=relaxed/simple;
	bh=E3k2KFJC5Kpsm6RrzIJ+HVsT6arOOMIj3f9XyiLwGyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyrrf71lVQQ447W3B97cGVQPmw7trfwMskd0UgW+/OyOJFrb53cSJz+dChRDEhNuml5NkFxZeDFt4gmIgECP6slfKEme3s3MBQRC/rGMXvuMIPZQBDnQlA75UlsQMBIfKlczemHAGcTES0QUDBPaL/Eqj/r8D4e1ArKSF3MnhkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=O2uZqZfg; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="O2uZqZfg"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84867f07d63so4901185b3a.2
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 08:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1785252644; x=1785857444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8kJyeGI8L3V0IAqYou544rNxKptwzjPjr8r5SGNglkM=;
        b=O2uZqZfgf+sd5fsPlL2h/Xl98ojHJuNivT6paXrqyz+XHEnoJKovfQRt57lSMmqpGa
         EGdh7eQpH2lKnmespmvvhdQWocJDavCxH6E/bX67qjPG+5sh8yBVwJEHhP+QUhQu83u3
         0XIU4WnCByCHMBKAwJ8DQwoHnF7M+QH5FDjMttybkrh0672gce4GzM8r9jaMR8jnwDkt
         bDjzhtoVPUgEdluuM/GMWM5SZUNES4cmdJX5CegTCDGO5TRkAxL032pcx7q/F8fFKXuz
         NOXYCsZ4f1aqslShFMZqdhEM4139/fVmFemA0HuW9YR+RQVGm0uOWlkmfxX5FK9p3+bd
         1tLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785252644; x=1785857444;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8kJyeGI8L3V0IAqYou544rNxKptwzjPjr8r5SGNglkM=;
        b=UEg0BvBeU7XUDvLghBV01+0caaeAphMJMkr1aLyGEv4g6B36uoxVHhSa4ncTqjZO9s
         VDlAbCmeqbq5Oyzq8Fyka97nDcUX0573ewn+c/Zq0Rz88f8Q/2+7z4BbAzeZVtAq76z8
         kft6EOoujzoFeyO2ZGxS2qenDE4FiePxA3RvWIUj4jlQPZG6Bo6wzlVYnpdVs43Tpj/v
         w+c3UWVu+6Od2xjG9XNmt2/vP96+nTaHVy+qlsvQ+mcC3iQOBRsBMsDYSLaLqSf64TaX
         Wt+V4/1B7PtPIzdyWzRTpF4/Qr68ICOkXbZgufdf211o/+EEdxSoHgBZtRPkqT28Hy0S
         MZzQ==
X-Forwarded-Encrypted: i=1; AHgh+RrqYWc5Dmt5eOJnR8aKjfBq7YlFgnmQzS9ZrqpSbEcfuhZZ9YvMZ+qD2IiXnjt/nX8vvhbYw1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN69tSwf7Oxj3hNbJb5mQeee14jbvEy9Cvcc3GEjt0Xlgp57Es
	/X6FgB+Zx/yr96JPtRoUyOkz6+2kwwqDBHXIKEeFaSO2SuIOw86MlGXtBjlvh1W9c9E=
X-Gm-Gg: AR+sD13OM45SwHdQpl9xzIm+e19QdWaXqOx4Icw+ioPdnyaRYeJwQQPSTQdeGA6gwsM
	RDvOjcSw/ttQFE6d3J6MnR9JloVePnRdZa8+z8b2HE63WUOxeEJNqOOU9K+U8mbS2L0jEl3rSxA
	OIZ6+g1BydDNFzuGs2jqRaplTSBo6BOz9rWK8drUIqYQTS7Ha47U2viZAU15kfzqwOsG4tWjfwf
	SmiQafRFs0eeB5DK3DYKJL33TL4r5UflGJBfBet04+axp42j0JaFYwJzhMmHjxS8VCFq8k48h21
	qZ+XFJ4ZicA0ZqN+iWaUojzbvqNdLueMuL9t0LuPel33rIdwuv2F8Bxn5YFsAxNsQQ/gnG0AI+x
	VQ/IMhmM6n4CwMXqVDxXSVqotyotcy3+tsGeHwtpPcvDc3gepQi2sHFn52HY=
X-Received: by 2002:a05:6a00:4c8d:b0:848:8715:c2cd with SMTP id d2e1a72fcca58-84e933add88mr3388843b3a.47.1785252644148;
        Tue, 28 Jul 2026 08:30:44 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:40::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0301b3csm97521b3a.34.2026.07.28.08.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 08:30:43 -0700 (PDT)
Date: Tue, 28 Jul 2026 08:30:42 -0700
From: Joe Damato <joe@dama.to>
To: Jiangshan Yi <yijiangshan@kylinos.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, stefanha@redhat.com,
	mst@redhat.com, will@kernel.org, ralf@mandelbit.com,
	viro@zeniv.linux.org.uk, kuniyu@google.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	13667453960@163.com, stable@vger.kernel.org
Subject: Re: [PATCH] net: datagram: fix integer overflow in
 zerocopy_sg_from_iter
Message-ID: <amjLIvXcwsret4qR@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jiangshan Yi <yijiangshan@kylinos.cn>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, stefanha@redhat.com, mst@redhat.com,
	will@kernel.org, ralf@mandelbit.com, viro@zeniv.linux.org.uk,
	kuniyu@google.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, 13667453960@163.com, stable@vger.kernel.org
References: <20260728064235.337877-1-yijiangshan@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728064235.337877-1-yijiangshan@kylinos.cn>

On Tue, Jul 28, 2026 at 02:42:35PM +0800, Jiangshan Yi wrote:
> zerocopy_sg_from_iter() computes the copy length as:
> 
>   copy = min_t(int, skb_headlen(skb), iov_iter_count(from));
> 
> iov_iter_count() returns size_t.  When it exceeds INT_MAX (e.g. via
> io_uring provided buffers), the int cast wraps negative, wins the min()

idk I looked at the code and it looks to be capped at INT_MAX, so i'm not sure
that the io_uring example could ever happen ?

I think the commit message misstates what is actually possible

> comparison, and the negative copy propagates into
> skb_copy_datagram_from_iter(), which can trigger WARN_ON or corrupt
> data.
> 
> Use min_t(size_t, ...) so the comparison is done in the correct type.
> The result is always <= skb_headlen(skb), which fits in int.
> Fixes: 3a654f975bf9 ("new helpers: skb_copy_datagram_from_iter() and zerocopy_sg_from_iter()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
> ---
>  net/core/datagram.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/datagram.c b/net/core/datagram.c
> index c285c6465923..fd8e17d25a3d 100644
> --- a/net/core/datagram.c
> +++ b/net/core/datagram.c
> @@ -783,7 +783,7 @@ EXPORT_SYMBOL(__zerocopy_sg_from_iter);
>   */
>  int zerocopy_sg_from_iter(struct sk_buff *skb, struct iov_iter *from)
>  {
> -	int copy = min_t(int, skb_headlen(skb), iov_iter_count(from));
> +	int copy = min_t(size_t, skb_headlen(skb), iov_iter_count(from));

I don't get this.

Wouldn't copy need to also be a size_t to be consistent with the general
"idea" of this patch ?

If you leave copy as an int aren't you just shifting the alleged overflow to
the assignment ?

Even if you changed copy to a size_t then.....

>  
>  	/* copy up to skb headlen */
>  	if (skb_copy_datagram_from_iter(skb, 0, from, copy))

this would still be a problem because len here is an int ?

I feel like if you really wanna fix this you would have to use min3 or
something instead of min_t ?

But, I'd probably just leave it and not propose a patch to change this at all.
