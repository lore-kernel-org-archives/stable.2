Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795627561;
	b=JRIIgAqC+ybNFAHS3Yrmx5wI5cxeO7X9R2641D6087otjutGwfvgmmY95Lj/aDKFj3jV
	 21as88L4lYCxjn8uEiSAhm0a44tbU8VfON08NACuOlCG8zylewNs+GPPcUqa19mKzPopN
	 ZhUjbKunVjAer78Gu1zVLYKj1NsG5j9rNME7k/ufqFpHagNq86Mqoyd8R/6q5U0YcRflg
	 8135iFEMyd99KjLbrqWtm3k1/fmgm6Rh2QAlVP6Hv8LxARPmYvdLk1/eA9U4lVfZlfkWp
	 T2+n3Fi1bWgVNVwYPPSIVfsTXpQ+V79YIpmPTviucABz4LZDeCN+U+fu+5IIZhNonsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795627561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=0eeo8xLsFVG8280bwD1Dy/maRtfEJTegVNCHlzkxjN0=;
	b=V9t1JOwaNZqKSiFgM2ZfMWynDp145kMjKzf/1ytVvJ3dwKCWLhiMHLNaH2uFDKEPsRgp
	 X79A1BogtKm0JtUoYGXVLntI2JiV6K1wirFloOnN5ZpVMTqVD6LhqMvMRmnwWePScbwLQ
	 SzobOjAsoghlLuf52WQwJQj0c4VlGT114VkvCsFx03h4imJ0j1PKAXsezNoTrYpxTzME2
	 2OpxUipUo4eUlcUYncoVauptUDD2vR+jJbw1i8/DbWAo2ieN5SSd2uVNUds8+OWXu6jue
	 69Wa0UNf62A30a2YcfV4MtTv2y0ayXtyL12DHXP/EIFdqoRG3v8KctwQnxw+1JI5W/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=AhlMVtYQ;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61139606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61139606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=AhlMVtYQ
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-862b98b2e47so2398292a34.2
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795627560; x=1796232360; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0eeo8xLsFVG8280bwD1Dy/maRtfEJTegVNCHlzkxjN0=;
        b=AhlMVtYQtXwuGlojJFFQ/LyFKUKcecQlrArIY2llF9sBnChbckaK+XHwZmzN0lrLtg
         /yMQTJuo3kDRlehpGgDWXpFbWyC6eiTlHe4O2W6KtfyoHIByA2tWKef5nk1gqqKHhNiF
         9Fg6XCeSkKcv3hfQrHpn861yS0paY/ycapDyuK+609lmLtqQAWKMTLNULyEtSUZrijID
         ZmZ1gLNl+DLgd40aGwg7+TS3h1TPwFcjNoN9y1kr5jGn9wZdexmJh9n8zlHf35mXn/Ti
         yRmmXR7TWRHFefvtmDi+PqREAqwXLsAQ31qwEA6l4O5jlCbDT1oJwiW8hlOFRAa7Tqj4
         iWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795627560; x=1796232360;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0eeo8xLsFVG8280bwD1Dy/maRtfEJTegVNCHlzkxjN0=;
        b=FbxVP/s5ymBDicVgu6Wucy1+6eDeHfQshbaCab1D8ZL2LCeAPIynfAOTx4bQeYcpyR
         lLIPgVn2TXfqcnxFvz10cNUyk28gfS0gqEYpR09qjqY8jKW4T/Z0476S9Gg176h/P8xE
         ynhvGttk2/QqrctJSoJljy7lfeAAL3t3RZcWeTPKRkidZ9c6hfNT2sWDOXlTmDrASVu7
         XWnCGq5ke37aHfBX8qCG8jGJM994gRIjLR1pg+fKBMXAIthHsoAPQbkY7vMCLioqgeKy
         Ws2GxIE54saz0bMLzdrPFpteIzObXcDNAxHie2+Y355SEJgtBppe/EJUUgXLL8+2wtIV
         liqA==
X-Forwarded-Encrypted: i=1; AL+hErHmgdBjsGtc0duHZUjiaaodaexpzC22aJwxKzAOcrPR3uzU059uFaSZkdunjnJ+ZnvWRLJa9y4=@vger.kernel.org
X-Gm-Message-State: APuU4Z990zTR1zE6CUTmjEgjWWrZAamKspWTZfTk/OE/dQjV/OHRb5Wj
	AbRAuv/5jsKG1c6KqVCByrTFgm8snhb8pgezFmW++ZAC4hZcbDE76ZUkW+GRbN3oAYo=
X-Gm-Gg: AZFdTZc8LGYAt8kwFxLFDDweT5PtVBGrg3MxJn067IvfoTsyFooVESuoEC89Lv6yQR5
	VHG++Uvrd9mK3a+LFBxE0mH1BHiQNH5qZ1PUFEFouxvQ0nR0fb9+iOIyHoLm8uLGYXzM+QJZpJ+
	QfOjeG6HZ/RGI+Gi26BtTm/kuz9I02woezzYHpg5a+Nrs5DqdGna/xq5zqZZkXsLVeUN01Aog49
	MvywI4Brb3SkVBjiO5ets2iuKLVD5o56rkyl0LxD75JYpt6Z7w4PK4w1d0x4zxP+dxvMOxr+LLy
	uT3VsyCjb8rP2QtYtmLW6WBWm+Lr9qhZRTcFK359suF+POKbKRQQdmTZnWLPjaTcDBlmgVVaGZo
	Vj59EXczZqsK0mRT7fJgonvexp6OrrlSvlqAmtLSJqCgQIwHfT2KrK3+UKwtjS3W/xYUfC3Qc9K
	YV0jl9uY2ZkTY5tEzPUrN+Oujedg7F19OpWwVuBwKV0p2WNcA75160gMZ/vb40QK0DT6R8asztZ
	jl3+1UuHFxijxHGwhYQ884MoERvs+T82Iu8EJDz2OBIo5cCWsu0SVWedWbYE0P8RC8gRrCW0XLt
	xfA8VRSKOD5KlsTl+auCmd+ira3JyI7LddEVDa736gg7PMpxLFQxHatmSy1aKJZrLdgOzNDGfc7
	KWVllnV1ZLEr4NRfXaQopT1284rlDdKmdYA3h2zvQCwxX9xU=
X-Received: by 2002:a05:6830:2e13:b0:822:95ff:43f3 with SMTP id 46e09a7af769-863157b02famr24543779a34.24.1795627557598;
        Wed, 25 Nov 2026 09:25:57 -0800 (PST)
Received: from [192.168.0.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8631682200esm13061193a34.2.2026.11.25.09.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 09:25:56 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Louis Thiery <thiery.louis@gmail.com>
Cc: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261119232935.1708458-1-thiery.louis@gmail.com>
References: <20261119232935.1708458-1-thiery.louis@gmail.com>
Subject: Re: [PATCH] io_uring/net: don't charge the folio offset to
 truesize for managed frags
Message-Id: <179562755579.12696.13061594470426753053.b4-ty@b4>
Date: Wed, 25 Nov 2026 10:25:55 -0700
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 19 Nov 2026 23:29:35 +0000, Louis Thiery wrote:
> Registered buffers backed by huge pages are coalesced into one bvec per
> folio, so bv_offset is relative to the folio, not to a 4K page.
> io_sg_from_iter() adds PAGE_ALIGN(bv_len + bv_offset) to the skb
> truesize, which charges the socket for the whole run-up inside the
> folio. A 64K send from 1.5MB into a 2MB THP folio adds about 1.6MB of
> truesize, and sk_wmem_queued fills long before any real memory is used.
> 
> [...]

Applied, thanks!

[1/1] io_uring/net: don't charge the folio offset to truesize for managed frags
      commit: aaa55c8ff9147b1ce1ba50267aa9f080d469a963

Best regards,
-- 
Jens Axboe



