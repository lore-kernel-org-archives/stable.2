Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70223FBB5E
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 11:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786965478; cv=none; b=SXc4CL/x2L8n8mEA0c6E1xySR3Ouv0rTMudtO1/+uNFe+/khHQ6wuXRt8ONdnqssiQtZsNex24M/nCLwYe+yJZ1dwP2L7w7YgfUMx3fGussm5B2NZ6fEDqet9lFlCenBglrp/Qn0YHQnczTxjxWdPPFlYmDOvHcyOaQZQeyf62g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786965478; c=relaxed/simple;
	bh=AayGtOQDKtX9pm0ZEeABQelkCQowJyXQKLwBThQ68+k=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Date; b=SVPxRKtm2FkjZg97K95jqV6EYqHi/2MQZyoVZA5XxjiITP7fd1C8Wp9+t/afiXQXikpICBPiuMVL7N72R1X/I2WmEd6Zi2CXXj/bctpUUKMu2aD0M9u5R3McxjS74AZsE0mKCADAMEIk+WkY1s7dm29NKtNX3i2/HRh3QdHq82w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OEVDAfQM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lkyPCwBk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OEVDAfQM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lkyPCwBk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786965474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iHaC1wb6A4UB6rpudHDIMeHC+iY8LxyInz0ILy0oT4A=;
	b=OEVDAfQMqJTokoDqjTmiexpv/gzfADgayW2jOCLi+ai0LIp7x5LGe+hMxkN2VG3fGIUMpP
	CHgGnP4l+xhrPCbIhIn0TZovo9ZkJpctoYZ7mQEv3QF//cf0h1WcGN96SCPQYLpVTuJILb
	5DkuVQvbqwsow6bhJgcnmWPdKCEP20k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-Nh2gYmHROA2evqLNl4jiwA-1; Mon, 17 Aug 2026 07:17:53 -0400
X-MC-Unique: Nh2gYmHROA2evqLNl4jiwA-1
X-Mimecast-MFC-AGG-ID: Nh2gYmHROA2evqLNl4jiwA_1786965472
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-499574e98a1so20992765e9.3
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 04:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786965472; x=1787570272; darn=vger.kernel.org;
        h=date:content-transfer-encoding:content-type:mime-version
         :organization:references:in-reply-to:message-id:subject:cc:to:from
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iHaC1wb6A4UB6rpudHDIMeHC+iY8LxyInz0ILy0oT4A=;
        b=lkyPCwBkdwlGI2lgzvhc/68VXSGfuRoT+rAsu/EvJrlViIyzARZfwK5RbYqJMEpo+4
         mbDWBl1QIKmAZbBPWNQFXUfUDgqRhEDk8EnrVAAYUOyZcNHGdIYEbwP0MeCPhpv3lx1e
         4X0hScitwRLMDK2yRl4Stq7IQBidSEquaLoRGA9PohdgzCS6eNa/ZEt5ChZ0+C/oFDDS
         OI+LmUWIsL4K1BeuXDs1eswBuUmMut3st4s7JuuOuHum29HMSxFUZ1kjgTVyDhUyI0UG
         9BEAgWPfbVl2hH8Mt+qKLsaso21VJ9KbjsaS/5pxO7lRvXu3wFugMiXL3+CHfXhcVeir
         iLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786965472; x=1787570272;
        h=date:content-transfer-encoding:content-type:mime-version
         :organization:references:in-reply-to:message-id:subject:cc:to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iHaC1wb6A4UB6rpudHDIMeHC+iY8LxyInz0ILy0oT4A=;
        b=TjQUsuLbBmY4o/SAJjlLMHDYz3nKjLqi6Q8dANoBMgXwCKFEGDkqfZ/HxcKpMnttut
         JY8eMPXPaBbKa6Y6uw15Io1qups3Sxs9Rk/JczOUzozxqZMrKkx/FwMPVpWSXcKpafQI
         lCbimo5RKx7krMZTSrbeYW0v/AapH5Fz3y8/JTSl2QLxr2/89MAo6EGsBBOOHZwjxt7l
         Gzo/Gz0Ojt+WlpwPeorWHT7NTvYaZ17L3D+QUzOPqoy4l2pNilxKSooAf5q44fJV1i93
         h0oPN3STHx51S9fqlg9KlC95QuBUPc5N9ZFwl4MESRP2mRvmFEjaR6B4nb4VckDeGkvF
         DC6Q==
X-Forwarded-Encrypted: i=1; AHgh+RpYdyCtJY3n1a51PpsGv01afQtNpPPfQ9ExfBhTQTXKrRgWcdRwUe3LKMl+T2t/90jUHIp0gUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS/Z/P/AozAb6PXmbprUddaiEQWA2qLU7ALJdn4swE8S75ARh6
	UmfzrFwS9OERV4f5sJSHreVUSx86U43/NNrdbwSvJY1j8JpI8AUGPOhjkKCP8sBVQNr8YB8VJ/a
	E0x71AqZ4unVjxW8Ckb+f8SXu5+b/B3J3zSEWpeHU75cZWdcoAjrn6+OGCw==
X-Gm-Gg: AR+sD10aVo45Nl6+VCVD186yUYuLKHCmM7XP/CBzeaG3esQK1u84xCVEWc5u+mDFo46
	7dnGUgUw/pI2H7ukdYWixupRCwOjm3V9F9zxz64R2a4GAOpEySP6i11+TjMoqmFJtnTjD8oi663
	P34iu3zdv5R9iokPrAFgDjHELiUfJDSm4/xkzJzeaQcLfd6S/HI38AYCKoair/vYMx+IeNI30Ai
	qhprs9honZ4IAesYOhdFeMejEzIj3EInsnYHOXr6DI4YtL9ZKxhkbtR0tzVuXivtHhBQdN1uswV
	h8inv2S1/sRKXmX3Y7odJ1Pl9Cqh+WgLFvWtwBrQds5zUhNLAU8JuFC4wB0ejyP2ABeTisLWglj
	QFaeYv5aL2LpQi0zhoumKZV1uKpGk
X-Received: by 2002:a05:600c:2185:b0:496:bffb:fb7b with SMTP id 5b1f17b1804b1-4998797cc60mr279142025e9.10.1786965472208;
        Mon, 17 Aug 2026 04:17:52 -0700 (PDT)
X-Received: by 2002:a05:600c:2185:b0:496:bffb:fb7b with SMTP id 5b1f17b1804b1-4998797cc60mr279141055e9.10.1786965471771;
        Mon, 17 Aug 2026 04:17:51 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999d0876b8sm44870005e9.8.2026.08.17.04.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 04:17:51 -0700 (PDT)
From: Stefano Brivio <sbrivio@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 Taehee Yoo <ap420073@gmail.com>, netfilter-devel@vger.kernel.org, Pablo
 Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil
 Sutter <phil@nwl.cc>, stable@vger.kernel.org
Subject: Re: [PATCH 6/6] netfilter: nft_set_pipapo_avx2: add missing
 vzeroupper
Message-ID: <20260817131749.6e1408bb@elisabeth>
In-Reply-To: <20260815205750.169336-7-ebiggers@kernel.org>
References: <20260815205750.169336-1-ebiggers@kernel.org>
	<20260815205750.169336-7-ebiggers@kernel.org>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Mon, 17 Aug 2026 13:17:50 +0200 (CEST)

On Sat, 15 Aug 2026 13:57:50 -0700
Eric Biggers <ebiggers@kernel.org> wrote:

> Since pipapo_get_avx2() uses YMM registers, execute vzeroupper before
> returning from it.  This is needed to avoid degrading the performance of
> any later SSE code that may happen to be executed.
> 
> Fixes: 7400b063969b ("nft_set_pipapo: Introduce AVX2-based lookup implementation")
> Cc: stable@vger.kernel.org
> Cc: Florian Westphal <fw@strlen.de>
> Cc: Stefano Brivio <sbrivio@redhat.com>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>

-- 
Stefano

