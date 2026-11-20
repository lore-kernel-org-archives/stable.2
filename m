Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795167995;
	b=VqVjOxCfIwnCBxewHZgls/wQ3Ue0+eF4Rj8VAHMX6SO3ocVy2R2e3K6U1s9maH/P4A8H
	 1qGzBI8NXXFCzFFFQMvXJJ7oSIqRMNtFWqsPT+8+hmgQhOtkq+TZ+GAdG9EeKurK8QK0q
	 gkPTShkAe1jgMhfTb2gmcMf3X3+PabsefzcyhCy8Ej9/US53Bf9Tkg6bbYGm9p8vB1ot2
	 fFdLnpcXrrOIZO3MTDfyiPK/W17Zsxs5tVsieDsnEbp0ZwlB01pJl/AgCd7IfnuypG6MV
	 /h3t+m7INutZZmr9/GW2I1hAcQzN6X5/iO64Q9WWXiiLJucMB9CVjoop7i5FJXWJpCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795167995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=GcjNI9PrNL1HjMpwoI+gV5DtiJeXajBxIpVqEj/uHtE=;
	b=BIy1Hs1ltn7imslSZ42IL1o1Hqza/q+Fc2RoVXA5F9tNFxtqO6+AHzHZEjYWrzMKRLZx
	 Q6guQ6MMNe7lzJgyIJsCEWvB+RZfozXDd0UeB2HerVLee4zFbSSWcQAgyI9TbWGWqGaVz
	 QIMXmivtJV7ViHPlCG0q9LhFIR41BNh1Z6DoAHjbJM9VdN1OJhPdPdlO0B0KrsTlkbmJ4
	 6TTZWeB7altx9BFfYnM2Sx3BlYeNSOekChoD+SJ3ZkUdVVbFiYL7Kotev9uwyxfB6qiUZ
	 Y8JVaX3Z9BVld/RgcESPJisdv54Wd6uBarK9JAOit3db6/Fzgkmh2obcrta/YVDcazQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="LBRy/uaz";
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F14606A325
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 09:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28F14606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LBRy/uaz
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-49a92144733so308106f8f.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 01:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795167993; x=1795772793; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GcjNI9PrNL1HjMpwoI+gV5DtiJeXajBxIpVqEj/uHtE=;
        b=LBRy/uaz9mbmJhIx0EYumM8ld+NtVsEO2eRS/sKVugx1eyxecKXEvUNjzzWGC2NkA9
         MLAIvCBghed8pMQfkOrRY/bPIU+kqNvVWMSYnIv+rP06o1lBKbhd2TbY15szSY/ogT93
         balH8PGnHSWozYYn5itxtpf+Pa8SZIQl1FSNCUnshR/xUdGZ4NdBlLrLlKWou8M9Ifg5
         Ol89LktOsaGfAfEecLfy3DZZV7f4CbIGk2KLrOyUcBrebqim10zib0Lfk67kIGJikXM2
         K2lpFbYkeOs900nnMnXNjcxlDfRIAjO7zVhkxx5xEV5cl/Q3K/xjto/o8AeVmmBvpXDr
         dtig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795167993; x=1795772793;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GcjNI9PrNL1HjMpwoI+gV5DtiJeXajBxIpVqEj/uHtE=;
        b=uoiih7BZ2kEyKgOfZakKmvIgOtoeiNuQcLinzLdCR9DWscYul94LPpRb7P/Mj0ar6w
         D4P9s9Sdute8UtThGjW5xGf2ZlkPV4AIZJdduCtEtD9bYnFM7LMbu++D1SsUP9Oac2ge
         h+PwVa9yC4WPwxVQTp53KfqTH7KVX6T/wcyksg4Bsx2R5pLnuFz8LkWcv6b5rk8ao0I9
         DBeJsbd0BSPgeNJz1PUjZvoiFcGS7BUrLPdC0qvYGmyBtLnEkjSh4PvFSkl2FavxxNaP
         E7+fp17AZ8ZU3pQFgkCp+1klRGU7PX5qeo1mIIXn1eL99+Ry8xl0H4mffr9Xh3+DdcLP
         cITA==
X-Forwarded-Encrypted: i=1; AL+hErEm1crzBBH72xF2QHhKx+71Dm4eSeyClcfb1TRsfxVuWS+DvdWk/VcE93t4yfjMNm7tE8yhr0o=@vger.kernel.org
X-Gm-Message-State: APuU4Z9McqNG+qbvKHeLZOx5c7imEnN+RfcFdqXpz6jbRl84J1nHj5hs
	6EMo45X9VxUupD0WqT3Glzcub3h2sYJNG6aPfxtnBeArbzscbUXoEIY/
X-Gm-Gg: AZFdTZeYtktIFvM+FsikbUdkCWfif28vyrpB49ZZtf1pj+n3J9GxQMDaFOAwG9M1ynP
	fMQ56YmZ8LaR6SV2a0ddj4AAswoeaw8aBQStHtb7x95+ckepTBA6OvKAweb+YiZ3L4CtmfXXG0D
	FnIJlMdwriF4NDO51g7e6S6CIQ3ikUDbyiSpXXtXA56Bg+s+MtGOsAfVB1kQwRnaTyx/quU+NsZ
	0DMEcMXSterCP5rndRPR0R8zApclMpnA/0X6XrH/Jr/gpcnD5jKSpjbuPLIYbIv1YVIWvQ8VzVe
	0+/oI+q3GkCOHFNSjkFN+A5pIbf9lCBsAT1y12NpJhJOmyLKOoU7FFxiZjdI4f+/xYgoT0F/G0E
	+3GwZ2mEF5nwaDsQo4MMIOCRzY4U3F6aYQAm6p55QrpKjk1pZ3goUl2asC3wXl4+v2yEzbxdTab
	PFAKD7C6sv5JzJCgAqY6UcaChPtXbIP4wlrEKhrCEfI+/I94O/q1FXhmQKxC0RujUcKC38cWDD+
	P+ahUkG5PLhi7HaQlzuJplKhtzge5i8ITWs+hEi4dcJemAISe/Hcf7D6oObY9+YEVL4kPrvGz8n
	iWNgvsUkfgcoFg9Uy419K3HoYT7pFl5oVhYwTkfORNan2vceFk0VXFNuw4OYlxsrGw==
X-Received: by 2002:a05:6000:2c10:b0:4a8:a1fe:ea94 with SMTP id ffacd0b85a97d-4abacfea54fmr4924872f8f.3.1795167993308;
        Fri, 20 Nov 2026 01:46:33 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a68048esm4551779f8f.29.2026.11.20.01.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 01:46:33 -0800 (PST)
Date: Fri, 20 Nov 2026 09:46:27 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: x86@kernel.org, puwen@hygon.cn, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 linux-kernel@vger.kernel.org, yangzhen@hygon.cn, dengqiming@hygon.cn,
 stable@vger.kernel.org
Subject: Re: [PATCH] x86/cpu/hygon: Work around XSAVES Erratum 1386
Message-ID: <20261120094627.513b216e@pumpkin>
In-Reply-To: <20261028235712.383977-1-zhang_wei@open-hieco.net>
References: <20261028235712.383977-1-zhang_wei@open-hieco.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Oct 2026 07:57:12 +0800
Tina Zhang <zhang_wei@open-hieco.net> wrote:

> The XSAVES malfunction described in AMD Erratum 1386 also affects
> certain Hygon Family 18h processors. Under specific conditions, XSAVES
> may fail to save XMM register state, allowing stale register values to
> reappear after the state is restored.
> 
> None of the affected processors enumerate supervisor XSAVE state
> components. XSAVEC is therefore equivalent for their enabled state
> components and is not affected by the erratum.

Would it just make sense to use XSAVES unless there are bits set in XSS
MSR that the kernel might need to request be saved?

That is 'use XSAVES unless you need to use XSAVEC'.
Then you don't have to worry about cpu models and microcode versions.

David

> 
> Family 18h models 00h through 06h and model 10h are affected. Other
> Family 18h models contain the fix in hardware.
> 
> For the following model and stepping combinations, the minimum
> microcode revisions containing the fix are:
> 
>   Model  Stepping  Microcode
>   04h    0         0x9040000f
>   04h    1         0x9041000f
>   06h    0         0x9060000f
>   06h    1         0x9061000f
>   10h    0         0x91000004
> 
> These are the only known steppings for those models.
> 
> Disable XSAVES on affected processors unless a matching model and
> stepping entry identifies a sufficiently recent microcode revision
> containing the fix. This allows the x86 FPU code to use XSAVEC
> instead.
...
