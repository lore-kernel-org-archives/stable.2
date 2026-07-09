Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A208A3E0749
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 20:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630526; cv=none; b=ZSUxZI8+5lc4nmDQ37iLdaVe9b51fh0ooNrcIuJLdR0PBin2DjCbxsmcsuXgQMLCMMiyGp5tYE7x5ic1nZYhpxk6ol0ECeuFhJQrqNpneWvK2Ka15h9r0y6HUlo1/KhyuHYKnx+55sMeAijlN6JK5gBIzv6fhiW0RDSoqGIH+Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630526; c=relaxed/simple;
	bh=f4hfh0jLqJeN/mvaGdYufitz68MPvAO1xG5xJREjh7U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NNWY5ehy4SsNlUWO4WmRxRZXiDR6zAdyvYVh47mrKU520W2VV6Fbt8AVtAAtxjcMKdiYr4lCZm1lFwzsVkj1PUp7TMD9e5ka25fZdnO/wjMW9tYPgI9sTtNnjud30deSzWGmneR4Ri2I6wkj5AYLX1eChoeGMR4W5ThMijZPePQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKIa4FxV; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKIa4FxV"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493ce08a75bso719725e9.1
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 13:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783630523; x=1784235323; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V5lZsyucCptJ6ljiEKFYc5mmPt/Mk/DxPPJ2gV8LavY=;
        b=aKIa4FxVTfSpzUXFk2MyKWwClLFrKyyXn5QDsmFlL8XZqxRGhoo2A3XC/qvsQBbdHq
         wkzz32VbLQ2jhvT0LnucU/7bvzylWHZthjzdziHNfriGKd8V+gB4qmmxzOBtrcx+7pI2
         VRuGUQzf5ufG5oITJ5jzNrQ4a7q0hrj1QES6h4r0Z5B9zo1pGllx9+Q1ft88lbylZpcd
         5QRj7y0EbBiihzg4XtF3dBNvg3TYS1H3chDcgLDLKbPqzw88/kKREzt+Nl7bvQGJzX2t
         SSlvAjHvQAMuAAQy0dcVkB6mobCjDF1HX6fHJFJqXCkdy3bYljowwiqSbCCCdiDTxbMz
         CFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630523; x=1784235323;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V5lZsyucCptJ6ljiEKFYc5mmPt/Mk/DxPPJ2gV8LavY=;
        b=gf14fCP2KzxSsEM0feMO5CBeZlTlTnW8J/ydvxaFvnll82mqIWf+y2PY5vaWa95T9J
         cO/IDw1H5BdKSseBCXIaiW8RwDDmwUenodwUuFzij0oH39OUsa26lMeI711JEC10xH1b
         pRxPao1R7o2gHltpv52EPBDLAcxjMmrSPIbhP4kzN37AeApoc2cv7HqfnbfhpeR1GQ6A
         CrEGJs3KSsFpUHpbTHeXxpoZhx83RARYZn1lkRKAqW9lT60+evzxpJcDjSuQwNfnzo8p
         L/xrIFHjF8mWqjkfggWFcWSDtz+KsH4q4ACHdIHaAtN4A89F1ecOXpTkEr94Ofc8yMQ+
         p9Kg==
X-Forwarded-Encrypted: i=1; AHgh+RrqFgkwoCKTiuI6358Tln1FrgV711R1Ki+Zwl3oseraKxw8vfi1KgXjp0KuTCiTXlQlF9HStfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyACKtjbOgSX88UnMA/RaqxO/AU8L0AIAW3MJ3sOJNbLVKh7eSH
	CPD/nF/r3wYPOw6QVPN4ZpcZEPEre1HAlcDyZy3F7fgLqPxmRkIsMv6g
X-Gm-Gg: AfdE7cnWKiI/4375CauduC4+71+0BK+jz+CeEkk9kahlLZnOVsVw0hfzMEjpJSb4j10
	/uQDdG/ZSRg56QxFjXMBM9EmM2ClOP8HvXssTDnyQDC4w+exSESTpPCTeMujhDMYs9RqR6GPpuR
	1wYP9sXnssS4fk8kC+9Hrzth0vwZr90O7NkBCUAjLPnTAzPTE6U5EnCnp1m4yOQLoSp7xzRtY5/
	3riFFq2ogzYrO4cRQtFLQ8ObJoCyxyTDIXf518OVBiYInmbFkzSa/LEbR8TvwLhBVJKp262odq6
	sQOlSpoMpWbuWwtrPbX6MTkRy2hsXh7zkbWE7h3i14sS1GE5Y/2NVR9kLIXw99wrPxiJPhcAK+u
	SuIeNYfXxlk2psI6I1BZTIiz9R5n+o94BJRqvZk91e56BnH0hmtgcGCOzyrgonC+douOCeXzVQk
	fb2xSS09cwmr2haug8+twMrv148GCG+KHS33NWK0qCGN8sIA==
X-Received: by 2002:a05:600c:1d08:b0:493:d2b1:48d2 with SMTP id 5b1f17b1804b1-493e683c717mr83993565e9.2.1783630522756;
        Thu, 09 Jul 2026 13:55:22 -0700 (PDT)
Received: from pumpkin (host-92-21-50-228.as13285.net. [92.21.50.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6f3c42sm87895385e9.1.2026.07.09.13.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 13:55:22 -0700 (PDT)
Date: Thu, 9 Jul 2026 21:55:20 +0100
From: David Laight <david.laight.linux@gmail.com>
To: David CARLIER <devnexen@gmail.com>
Cc: Jacopo Mondi <jacopo.mondi@ideasonboard.com>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, dan.scally@ideasonboard.com,
 mchehab@kernel.org, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] media: mali-c55: Fix unaligned access of AEC histogram
 zone weights
Message-ID: <20260709215520.521f114f@pumpkin>
In-Reply-To: <CA+XhMqzXMMDmtMyev_UuGpn0sU6TKNBDBzO1H-wN96no5h-yXg@mail.gmail.com>
References: <20260702103453.348056-1-devnexen@gmail.com>
	<akd8E5jr722oTm49@zed>
	<20260703221651.41669d55@pumpkin>
	<aks7usxfDajS-W_5@zed>
	<20260706104652.GB66892@killaraus.ideasonboard.com>
	<20260706133956.39a11738@pumpkin>
	<aku6R_EI0kLUqD8e@zed>
	<CA+XhMqz2oTTy2kY_4uqvJRnoXb0am5h6hXnLFM4EPQ7Yb6N-pw@mail.gmail.com>
	<ak9UGtj7-qOvjRmr@zed>
	<CA+XhMqzXMMDmtMyev_UuGpn0sU6TKNBDBzO1H-wN96no5h-yXg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Jul 2026 20:16:51 +0100
David CARLIER <devnexen@gmail.com> wrote:

> > Out of curiosity: why is (u32 *) case a UB ?  
> 
> Alignment, not aliasing. zone_weights is a u8[] at offset 10, so it's
> only 2-byte aligned, and casting that to a u32* (which wants 4) is
> already UB - 6.3.2.3p7 - before you even load through it.
> 
> > the usage of __packed triggers the compiler to emit an 'LDUR'
> > ... implications of using LDUR vs LDR on "unaligned access" ... not
> > 100% clear to me.  
> 
> LDUR vs LDR is only about how the offset is encoded, it's got nothing to
> do with alignment safety. LDR's scaled form needs the immediate to be a
> multiple of the access size, +10 isn't, so gcc can't use it and drops to
> LDUR (unscaled offset). Both happily load from an unaligned address on
> arm64 with SCTLR.A off - LDUR isn't "the unaligned one". The multiple-of-4
> you found is about the immediate field, not the address.
> 
> So on arm64 __packed doesn't buy you a safer load, the plain cast already
> worked.

It stops the compiler using 'ldp' (to load two values) which IIRC will trap.
Although the function call following probably ensures that never happens
in this particular case.

	David

> What it buys you is not lying to the compiler about the alignment
> (so the UB is gone), plus correct codegen on the arches that do trap -
> which is David's point.
> 
> > I would be a bit hesitant in changing the uAPI if there is actually
> > nothing broken ... happy to defer  
> 
> Fair enough, and you're right that nothing's actually broken - it's arm64
> only so it never faults, this is tidy-up not a fix. I don't feel strongly
> either way. Leave the uAPI as is and I'll drop it, or if you'd rather have
> it cleaned up I'll send the packed union (with MALI_C55_MAX_ZONES / 4 like
> David said). Whatever you prefer.
> 
> Cheers

