Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384793BED33
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 08:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785139799; cv=none; b=kZstn2wdFIoSFyyLGSttyHvfcohSmQ8adyRyK1p1tKKLbZwCzwYSwcfOwsh6Mci3n0tBzGBfO/dTWPK+AzzW35fNk4BulmOhi0k9Atlfsj5yXxw+O1FN4LlHJk7Ye51yURjg0TFKsVUhHPLUpAfNsHg+L3iah3lTECAaKp5KAdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785139799; c=relaxed/simple;
	bh=IVStQpxupI3++T0v1KlrlNXANhXKt6YSNyYcroSsO04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPxYdJJErYD+iO9LNURa5XKjbGNNq7HIMMI9WCyFyORI+IuZLS2XJ3aKx8nMtzv7RuyNcBt/jZQf1DiVecaOas4oAJivqES/jjG/8Su8n0Qta4vZtTbfoqQKuZxUNSfO8wZzMpsfYbQXo85ypdHRVrhGgSKLGUQY6FmaYqk+q5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s8jhTc9r; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8jhTc9r"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ce98cb8165so26910315ad.1
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 01:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785139797; x=1785744597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RJwzAimVGycrhKNGBvE4w6/5g4VYMwXiGvlwcbR2Rvk=;
        b=s8jhTc9rW2JI30Un6gI+760SbDNLOXjPA7AkUuWuTabKEAD7ue7YBWtb0eUKODfawm
         Gqnr4biGqv+Z+1uOVU7w5IlNxs60HJGob7KnIk64ItN7da5mj4P38esU6au+u9if0pfn
         5r695e0VOZ4DATGuvEmoxP+bhVIOMPWQbJWNIFmoolUgAwfor0wRxsxLu7INddYR79U4
         KyhmzbHFQLAQqXVYo7zmlm4nP8S2PEv3Q6nZ+zjtbHClzZ6bHX2XYBnMMD7s2TN6XzmK
         bDP8aklVHNd17ssC/kkDMmBVGBSTQcpcXcB8yb1tXtboobIRG7SdULDBeliTaMKwKwcu
         Xwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785139797; x=1785744597;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RJwzAimVGycrhKNGBvE4w6/5g4VYMwXiGvlwcbR2Rvk=;
        b=O4m9gU997Cn7eyj+H1jT0JxaPF+598ghDdQ50g1vRXvEp/LwZvXxk2EUEiplEhREiX
         cO2tN1p9HSUqBj/ipPnR+op0AOElBNvpNAQIrI+0PPCPQhHzGU9A12UgmmZRnD/SICrz
         xXU1kTnwjHcy3uYae81DHwxH4yA2XO0GJ+gtKWVk5ao+anmaFVXV/E4SsbkY9wMfCD3M
         hiPNHw6I7iggxHGuXKeBMOouo50v0rC3RGucMAOpOgJzpeHV7BLNlp6mO4bInXnjZjKf
         1ZAjZP+/C8BtPSOnUVxgi9kKm0kwC9Ik8jGlGLp9EInUlKw6QBB41wWNTXh6+DefMGK7
         qqEQ==
X-Forwarded-Encrypted: i=1; AHgh+RpzSInkRBsZqL26w0KQfgCbHa55iyIQfCc2fgQI9sTDrb26dLzH9he9YE1rRN/udBJhZier/Dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmgTjHClFU1MdW6udO3d8YrH8ajipcDGMGCPf2/y9Wn2o6V32L
	04avn6qU7MIAnGVo3ux8mD9DmS0/CjJxdeMr2HQOsOdwt3Ia7LUuJ4sB
X-Gm-Gg: AR+sD13ga75fTHVIpvFe2J7XiHJKIH6G9E7BDoN3+AJ6umwRqd2zl/dpA4bMaarBbYz
	BKQs6RkztZhkxhRrk1d4JwKbPEtyHni0Dh+xwYUmJJkZ2RgtHyKdXVCSQE79//ndNvfF4UlVoaa
	ekWvMsGDB8CV/yG884AGU/zmoiWV1D3Y47ZhZH4AB/UbRPYkrRsXaMUe+lj3SVahmbhbQXooYLA
	nbYY+uki2gUY1l3nqkNovm+tEyGYMT+/Rq2rr62elJgz28qXJuVF71xIotABDRQj1+JPQiXYtWK
	5TZXuU2JmeoqNacSEqLrBIzMqY3YVAjJcOOQdj0FSweIeGLkkovTLTJ1yw6wPCfl0qWFsDK11VW
	jtpq6umFyGu4mujaasmrY/ZrtMo/NATpSupqdeUwvDgXt2JdBJd+I2kmVASjSEgQ1z6Cq5jnR
X-Received: by 2002:a17:903:384d:b0:2cc:bdb9:3c04 with SMTP id d9443c01a7336-2cfd7179882mr86036385ad.17.1785139797422;
        Mon, 27 Jul 2026 01:09:57 -0700 (PDT)
Received: from localhost ([172.216.252.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5e2a78sm31344795ad.26.2026.07.27.01.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 01:09:56 -0700 (PDT)
Date: Mon, 27 Jul 2026 11:09:50 +0300
From: Dan Carpenter <error27@gmail.com>
To: James Kim <james010kim@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	mporter@kernel.crashing.org, alex.bou9@gmail.com,
	dan.carpenter@linaro.org, stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH v2] rapidio: mport_cdev: fix use-after-free in
 dma_req_free()
Message-ID: <amcSTqfuYXUWLVOc@stanley.mountain>
References: <20260615070530.371640-1-james010kim@gmail.com>
 <20260722172135.4fb1e64ce415fb6b8d1d1b59@linux-foundation.org>
 <CAPdMtfdA5OkA06KjsBmAGkfqo=N1vmNF+VtbczNdM9Gk5kaV+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPdMtfdA5OkA06KjsBmAGkfqo=N1vmNF+VtbczNdM9Gk5kaV+A@mail.gmail.com>

On Thu, Jul 23, 2026 at 09:48:41AM +0900, James Kim wrote:
> Hi Andrew,
> 
> Thanks for the review.
> 
> Yes, this path is reachable from userspace through the RapidIO mport
> character-device interface. When the final mapping reference is dropped
> while releasing a DMA request, the subsequent mutex_unlock() may
> dereference freed memory, leading to a kernel crash or a KASAN report.
> 
> I'll send a v3 which:
>  - updates the Fixes tag to the correct commit,
>  - clears req->map while holding md->buf_mutex as suggested, and
>  - clarifies the userspace reachability in the commit message.
> 
> I'll also review the additional Sashiko findings separately rather than
> mixing them into this fix.
> 

These kinds of use after free bugs are hard to detect at runtime unless
you have poisoning enabled.  It's freed and then used immediately so
it would be hard for a race condition to change the memory between the
free and the use.

regards,
dan carpenter

