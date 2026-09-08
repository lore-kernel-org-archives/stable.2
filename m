Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2A0238C16
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883479; cv=none; b=IZsxa2Q1i7QeSjRlkAeZL0FgY9k+fbyiqGMsffxb5Ywh0qcNyfQZU48BVVZw1HmfjWtayFpSuXVUMccDpVW6yiY1nmOvr7kuXP1CFVN6glGOY2LoulLhiKSplrkExtT2J3JwM41tnPMDfhcB1k8+1df7bF4HdwteHqpUYVxIrvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883479; c=relaxed/simple;
	bh=gVHwDpb6HBHtyoUlDRtjlp7YtX5g9j3oG6AFmVF0QMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyng2TSjZq+8x6VRPtOORvQFG4uABQAMMHH/uVRAma7DdQE23MHDu4m4cgbsty4I1fdS2fU1GnsbVS5HGOq4eCszIx2KRmpu1WL4tRWHU9EH8xu2ZKwMjaKfZyJ0yjsFSoWvllsJntvUpwQvHW8vvo+cnk5TGOHoahaD5zKnbYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJ8Bws0G; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJ8Bws0G"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3964dfb5b9aso5866728a91.1
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 09:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788883477; x=1789488277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0Tzx5UI34JujonmDJzMPjBkhAE6c2rwa6ggnBzBUQec=;
        b=LJ8Bws0GBV/ub3Kj5tG7v8iCXHMUT86wS+IPOEVoj30052ESJFIUHpiXmkA7sOT3hO
         NZvSOf3l5SoOeGWv/shV4FdvXYACJNfUhpGN6jDk4xEBwmDOqU0gnfF4b17IsS/boewd
         4asf7mZ4iQ0MNFmDBuncx4lR3MAR9VQyxM56/LaqOCYFoarZw/8o/+jG61zIEn1jmklu
         f5MlfQUfpKS92+vAet2OinbuiCgYwNs10Fe/1pMydBr7fMCvb7d/WGJJMKP6C59eKSw7
         gxsZpbFrlaPopZqX5qOTOVA0UEvrRJWVGiSMfUXGt6oCcLUX703lUrbahSlDObSG57GR
         lnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788883477; x=1789488277;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Tzx5UI34JujonmDJzMPjBkhAE6c2rwa6ggnBzBUQec=;
        b=iv5BtuV3OexNe87B2Ncv7ajRkqcY9WYA48XsIkJcv95Ow+KOQgop1NJsIyZFqKfy8M
         k3f+jYyDDc5EK37vWd4a9lns4//w6ykZ0iRHU+6dx4izGVB455EMtepA1cvgH9Q4ztTE
         2FmGr53aCrufM3J88reLuEDiPiO6vyAB2cDf+7Yqn8Jp/d85t+tvkWaiNWWindhgoi8Z
         uIhI/amxS+PKaa07NUpkK9URq6Tkw0n/D7N8GDyQMAZSZngd+0lrNPsZEeEIR8EcjldW
         1erJrMGzEF4LHAKCd7s5n2mSw5Q7L7f8b97aUcgvQ72z2KhWZW9B+wfegN/+tZXwdmBv
         UW6Q==
X-Forwarded-Encrypted: i=1; AKwUvBxiWamsCg/FPE9R5VIvmSDd8xeX72W74xpvGkVA3RkRazDnofyKql/LelU/vhOnFrYn0ZYWKXE=@vger.kernel.org
X-Gm-Message-State: AFuF++nT6C2SzZ0djY9li7GK7OfG2/+WeuuBRAATeVICNhEKeObt5dxT
	jNiC88vzN7YwznLkMjZxtD3n20gaY5T8AAt0GkZapi76Bg01+UnKrSyd
X-Gm-Gg: AYBFou3aKrzJ3YfcFWbtGitdKj4Xf9OvmN1bK6SYBMxieHPZ1wl669g4sKC38NLiLYq
	73GLh62SSjO4F2O14VkSbO3LRUKDeeUeqY7Or7X9gZHJJBcsfQViltg3g7I6wK3YumkTG+3eMKd
	3/tyxUGW90YWgDJDkQgGvulSAzGn2kNiehFnwCA9L0N6lFMmrWcHQro2pUUc0xyFSzwfuSONlyj
	MAzBBmUltMMZtU1JZO4gZlbYTDUqppLsTMtI+B6CtlqOzM8v6V5lvOQ/eC+utYa9c9tIJdWmUk2
	YCLxAfBAmZkoqm5GlAh4JopSB92/jcelU2wwT8FrhcLedrxBI2Yhz2vN2ZmrEdRCdBqI9Ed746c
	Geba/7TBsixSzKhcBfDH/U5tyB8Q/CKCC99Uon/zVhEQdfeEapSAWSz7fWj5uU2P2D3Vpx6b7N2
	DqjN5f2E6u/VIpsNrNMTtMK+ly53xsGNG0W1kIyzxPiPho6aBC8ax1kUM3dkt8ZDT9hRXMx9Akl
	vKLrOE=
X-Received: by 2002:a17:90b:1d52:b0:398:dcef:c040 with SMTP id 98e67ed59e1d1-39b26242a20mr46112186a91.19.1788883476937;
        Tue, 08 Sep 2026 09:04:36 -0700 (PDT)
Received: from kernel ([45.251.35.112])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339bbf1feesm37459495eec.26.2026.09.08.09.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 09:04:36 -0700 (PDT)
Date: Tue, 8 Sep 2026 21:34:28 +0530
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: clabbe@baylibre.com, davem@davemloft.net, skhan@linuxfoundation.org,
	me@brighamcampbell.com, jkoolstra@xs4all.nl,
	linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] crypto: amlogic: Fix IRQ handler return value and
 fallthrough logic
Message-ID: <aqAyDJq37-mCJL-2@kernel>
References: <20260821151243.8125-1-raizudeen.kerneldev@gmail.com>
 <apox0f2D6bYOYOnj@kernel>
 <ap_T2wCesl3whdJV@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap_T2wCesl3whdJV@gondor.apana.org.au>

On Tue, Sep 08, 2026 at 07:22:35PM +1000, Herbert Xu wrote:
> On Fri, Sep 04, 2026 at 08:19:53AM +0530, Mohamad Raizudeen wrote:
> >
> > Just following up on this patch. Please let me know if you have any
> > feedback or if further changes are needed.
> 
> Please repost this patch by itself since it's not really part of a
> series.
> 
> Thanks,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Hi Herbert, 
I have reposted this patch by itself. 

Thanks,
Mohamad Raizudeen
