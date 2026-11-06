Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793961949;
	b=XLO3abr8j3N9FANPl/S3urAWiLk0fvUfbW/nDg5VK3oi6cIzdPDmJlPbCyJ2jOBKVQfs
	 lrKrzHwJOh0MKc3mI6Dp45qjzKb7XkNgatgZZQ6JlqInSKUxZHsxnMGCgP3vV0YV3TWXj
	 T2cBpaEFpg48vMCl0iGzf7j5yS4NVVd57XJsE4gH3DTdy3HAhEwzfTUG0pDzVv+mNnZgB
	 zH1VT08KJHlI+T6yuwJ1LsSnDWdmVf4t+VEAkmV2nv9emjeBctrYaF51C1RwBOHuGHGgn
	 bun8yhN40r01+zsxSnN1o7e7+D3aWgDXZv0Btb5t6UGlovnEoqn3p6uy0hQ1Z84WS/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793961949;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=HN5AaMS/rppxH/Zhw9oaxqCW5S4c47gXtmjruB8wFZg=;
	b=lvi48wnpG9frjp7+hasQssV5phk/2ZQHjL4vEnLt8hYqUtAehg7iDryT0ZDLh1D42w0A
	 ZbM7y7MfRKtnyjrsXGkKPAs8kF87+ShIfxLnmcmaEgkgoc1Q+0lxVi7FQXQr6C5gdEcAy
	 Q9O1r3sGtFRClS1pTWJxfMYFfeFadc1hUycFEPYzkZ6ZkHiSKmlsgHVhWrCgpbB3dtCqk
	 NTz9ENUST9GJMes85q59GOo/Q4s0eyk/c8k2lw210nPdTQdWBk7EeuuqYnSHjNBLRJtge
	 ZJkdGzqCjIq1klAgwFDhZBOwrXqOtllKzfWvk16l4K7KD+GFUT9Il7Iy16mqa5EVvBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OTasAjEP;
	arc=none smtp.remote-ip=209.85.128.72
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3298A606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 10:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3298A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OTasAjEP
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a35e1d2dddso5292565e9.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 02:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793961947; x=1794566747; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HN5AaMS/rppxH/Zhw9oaxqCW5S4c47gXtmjruB8wFZg=;
        b=OTasAjEPeGXtupZOOCs1qNI8vILfSJnL29kF+3v1xWFUc4596sfnXP01SWPa72696e
         lWJEs5WbGSUlAQb/1/ooH6+Kn1119gggd74652NyTLbGfelkA2am7Bykmj7qQtBce6Nq
         FqJJGQnyo+Nn0M1UbhwSXY6ZvY8cW3UXvGYC1d1pPIY8LYWkS1sMuvzpynm0by2m1eGX
         Rp9GTEDmVbQwb0bMwSGDRmkqIvDxGucb1a6yOsR5zQ6knQDBkikPe1mKYRwzPUqhyuqm
         3877XBVqwOVcLIjdar6wZTbfIrIsDD7UVV4n0wTl1a0GKLSY2mN248MIc+1ZUjMMUkJ7
         OmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793961947; x=1794566747;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HN5AaMS/rppxH/Zhw9oaxqCW5S4c47gXtmjruB8wFZg=;
        b=t3uDUGjCn0KxWZ0IUY4WNA80GpOPlWLGh7U2O81LBcHAd/OlaWK1J/nyOJXHxsTDLT
         EbHQASE3pXZ06W8jBSm/HE/HpvJWR34f0FvKBfkQAb+i+JU8r5wzkmBdyZIgmOPAAUr4
         TdhEwEICwacKJ1xuWJHT4AriTsdtVhy9YzsAMwZaJsRDSdDc6JSmeVwqeCjDKA4nXKJ7
         LuxspueTkC1Zo7BrMAZ7Huk/domvLcD9dB8yNHT3xx5d92i6vyxjZsh7IqJDqp3kBUAe
         smYTeZXFwcjlsrX3DybPVsiZGH0ayiBoZPR1t/hqNvKdHgQXnLZUtmRcgUC9TDe2viik
         9jIA==
X-Forwarded-Encrypted: i=1; AKwUvBwp/FoH0pric0fuTkCSPJDZfUWYNGwcKOb66ZkOrJoJoG2lFJVjSqyfGTob3b7EwIES8sdN+t4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+M8J8QuYNVHAAty0QZjjB5HnrLyWjZ14Nd12eJZtnKjNdWBB0l
	PO/uVRxfHt6T7sKZXQESgjrQmJZOhf7wvopLMN38zhw+h8ISb1s1p4hcEXEf+c+WhQhoWKfkfDH
	+bT1hctXistZ6LLEwyA==
X-Received: from wmbe22.prod.google.com ([2002:a05:600c:5916:b0:4a1:f80d:2f25])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d05:b0:4a1:f7f4:7cf1 with SMTP id 5b1f17b1804b1-4b6de4a6221mr32102195e9.11.1793961947324;
 Fri, 06 Nov 2026 02:45:47 -0800 (PST)
Date: Fri,  6 Nov 2026 10:45:46 +0000
In-Reply-To: <20261106070701.89282-1-ojeda@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261104211103.174756107@linuxfoundation.org> <20261106070701.89282-1-ojeda@kernel.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261106104546.2297581-1-aliceryhl@google.com>
Subject: Re: [PATCH 6.18 0699/1005] rust: bitmap: restrict bitmap length to at
 most i32::MAX
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Burak Emir <burak.emir@gmail.com>, Eliot Courtney <ecourtney@nvidia.com>, patches@lists.linux.dev, 
	stable@vger.kernel.org, Yury Norov <ynorov@nvidia.com>, 
	Yury Norov <yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, Nov 06, 2026 at 08:07:01AM +0100, Miguel Ojeda wrote:
> On Wed, 04 Nov 2026 16:07:12 -0500 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >
> > +/// This also matches [`BitmapVec::MAX_LEN`].
> 
> This is a broken intra-doc link -- it can be fixed with a trivial
> one-liner I just sent here:
> 
>   https://lore.kernel.org/stable/20261106063745.87864-1-ojeda@kernel.org/
> 
> But another option (cleaner but a bigger change) is to cherry-pick:
> 
>   f5535d78e126 ("rust: bitmap: add MAX_LEN and MAX_INLINE_LEN constants")

Both options (the one-liner fix or cherry-picking f5535d78e126) look good to
me.

Alice
