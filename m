Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794548391;
	b=KdyJgZGDBzJNbqMxKLZkThd1XcsKMffx8jZra12n9oBwssMsJD2gH2Cad/Iuu1ngo+S3
	 DpgnwEvGEVq/uzJo4SofpG9aM5BXE9paRPOKcTtKcBiDgUL2kx59d6q9gNN1APRC9WXSO
	 0iFyHqu8gf5PKQK6ctkvNULlyRGWq66BfVmXrjXZNh6V2f5ayvNvBc+31ByqkURJ1FVYo
	 ZmhKBYVhXOKZduiSwM8imlw1wkjAbl2ITOQ+XY1i//klcYY14PexX6eWc6oOmkui+K897
	 vG4ls3B2kiAkGCQdBqM5Qm3IUIPYYt4M8CGbj2ixkP7sqofVs7BihMGGhLA2GWP3GgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794548391;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=MLrmlNGp9hXCiWV6hUp8+jx/5lwfA9JbymC0IwYnPhE=;
	b=DWK4L1JSU98OVBbm+/BuqQLBFQhdZE/gv2RyPvYSuSc5jBsoYISlP+IdNiWl/fbXvBrs
	 Xzs04nn2GHXTNUf98p0TByEf7S50EARTCssP5s92i23zhTff8z8bBY6+7e2KRbUSpOdhI
	 iD/oC2nEuYOg301itHDkzMLuQX1UWxr21z78iHwl6Dw3VAC7jDmFSzoW1uCKynlJvrpgj
	 ZruZOpqkE4fxMCJlqa1Eqe2Cvdnr2bSft+hsLESnKjjg8FJ+rccyuRNkY9MGy+pppk3Xu
	 lENO10Uq+GTdXxaHtZZo0K/lTChEsNlxKmqDnPdIz70jwPcVEc9/nJw5Q2cPcrGn/jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oh5wPJLa;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86B3606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 05:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C86B3606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oh5wPJLa
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36dbde64409so965125eec.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 21:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794548390; x=1795153190; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MLrmlNGp9hXCiWV6hUp8+jx/5lwfA9JbymC0IwYnPhE=;
        b=oh5wPJLaagbyJyKOYBAuotMRSAH06GN+KO6+qs/fbimUELrgotcY3XGGG9YMI8IzGY
         GNEBPUBXNCVaupGLqs6DyodDSR0sMl5Arr6REDqD2vxXUyqgNdPhKVk6lBBqqUsJ74N2
         +wXNbKMeJQmteVX4zbCE7dq1mlMygBba39y36tBGXrpR84WhRwoyoVjUl0PZUvyxVPpL
         XDYqYZDFG4l6/SsVThD56I3MxEJvOuSUlnGtffggWSyLzuOt6Ypc2ruQtyTcS966hD8G
         iqmjf6PcAftLCMjoaJ1QitkAas10qOE6Ot2pzg4WWh0uPbSUBfkHgccbKat6en8CNlG+
         dYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794548390; x=1795153190;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MLrmlNGp9hXCiWV6hUp8+jx/5lwfA9JbymC0IwYnPhE=;
        b=sQHPF6KbFrf2i1g1BPAjwHQP4jARlwQEc64oW4HBV5iKoZ+lOscyUKCbBNtcjMBERx
         +MbeqGbsE6UvAD1n/LBMwx+a+OXviBoDqplFJBKKCQpXXct9SyxgpfMYfYEumBwDR1u2
         cSWzvM0cPmOjJK1tiY49K/Sp3dzRaRwFqf5OIm0HrnXnzQM7bEbEZtR8mmeRJcyMk4GD
         LsNboL5Tu50OwFSOc8aG3XrCLAqKGSI8UTMvz/dB1sQnS8uLEALLRuQApEKFjwL2gZvx
         0wxjzGzcbHv9VNtxnmoUr4uZDpTvxhWvvYA7LL0eE0suMBbJhqi50nBuEPqxvXoJ63MQ
         vPmA==
X-Forwarded-Encrypted: i=1; AL+hErFcP43sQqLUs6U2dLjm2xhH8kRig/bW4BEae5SP5Z9mTcdBvWu3tUfK7ppo/VnRqkbVSpjPeMQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+lZX0DW/CJighoIne2ThZYv7FpOZRvIHEuFUH7cU7U/8W9X6B6
	UzivqehWFTmZRj3ROAR4CJzLV0YiELSTgWwXhyE4bT8u/K/Te//WSemh
X-Gm-Gg: AYBFou0lUC7ACsMC0RfpeWLwyKL3MakIu7fyZ48AJnRZXrD/Oeq0/ctrXjkg4bWMdif
	6HhUgHnAZWdTJEdmSv05dMoXA4+aiAKg/e+8HlwgpRmM6Kv8s/qsqZnMDVydkFn/TfQJvflvazY
	IAABayY3msTTnW4Xyf0dZmqo0fH3JI3Bw988FApo/MBWogdzqQm013ivvm04H0nD0VKhJZCG6qt
	xDok8gGVSKVqGEjI2G5EE34JxLFYlF6JxNxVkNetDUQQ1opr5RwrG9FCMvpi1kZgr+97+nI4ecj
	VpR0zro+nyDluJIdfBIiqv/NwOiIrL2P9GCKBLbxCfNjHJrAhO/IgknEPyVbOU7othOoJ+5DImq
	XXaMNyTZLqvnGwhbgk0cdh/TCI98XQGY86vxZ9cHrQZjjHld1k6WbU+YqEEZy0lWj5FuMy6GT8h
	ckUUx5sK0/LFpa4GhQeu3GTSdY2XzSpu3YID62ArKc3TLRu0JuUFkxTGGfA8FhES1HN9vSzL0Lp
	e6N/AtizhFXtY2D3onpSpP0jZC4fb3PbdgOrHo+aFnnkC2mJZsVhDAfzrRjhGgr11h3vjTEw45P
	VOib7NUqzt4trJtTZNmRPxD7lt3teGOTZfPgvYtK4DGop3DU2CyIjL1XKhPRUkNX1VpIJTw=
X-Received: by 2002:a05:693c:87d0:20b0:372:3bad:c861 with SMTP id 5a478bee46e88-379680ccd5amr1351913eec.41.1794548389777;
        Thu, 12 Nov 2026 21:39:49 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:48f1:7a0b:9bfb:4205])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379559189e8sm3785444eec.11.2026.11.12.21.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 21:39:49 -0800 (PST)
Date: Thu, 12 Nov 2026 21:39:48 -0800
Message-ID: <5252f18157db7e26e27dd3ae2acb5b39@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Gideon Heinz <gideonheinz02@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	=?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	Hans de Goede <hansg@kernel.org>,
	Edwin Velds <e.velds@gmail.com>,
	Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 00/33] HID: logitech-hidpp: G920 force-feedback fixes, rework, and cleanups
In-Reply-To: <CAPb1+K2NSGzvp5b8_CfRrDK2trD74+pCi_a+OYV4cza++DP=8w@mail.gmail.com>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com> <CAPb1+K2BxnfQ7VUQ15td5f9pVhn-ARSM9EjfOU8WuW72o+cvPg@mail.gmail.com> <2f722967b6db0692d4dd4164aff39b62@gmail.com> <CAPb1+K1J2F-=cJF_+Z+RkA+9uLD8-15m3hDv71DSPG47XLJttw@mail.gmail.com> <CAPb1+K1pr7wtp-CCE4x4i4HzVkGfpiyXRBdqWJ-fmJpx_-pfqA@mail.gmail.com> <CAPb1+K1mmyvipXSx96-j-+zgxeTztLNfYYTuERw0Ykf5WDv9sg@mail.gmail.com> <CAPb1+K2NSGzvp5b8_CfRrDK2trD74+pCi_a+OYV4cza++DP=8w@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Gideon,

On Thu, Nov 12, 2026 at 03:50:37PM +0100, Gideon Heinz wrote:
> Hi Dmitry,
>
> One more result, this time the combination you asked for: your input
> core patch in the kernel, plus the v2 series without patch 22/33 as
> the driver.
>
> Setup: CachyOS 7.3.4 kernel with only your "Input: destroy
> force-feedback device on input unregistration" patch built in. On top
> of that, hid-logitech-hidpp built out of tree against the 7.3.4
> headers from your v2 base (630059a5a632) with patches 1-21 and 23-33
> (7.3.4 already has a different G920 init fix, so I could not apply the
> series to the in-tree driver directly).
>
> Same reproduction: fftest holding the G920 event node at the effect
> prompt, rmmod hid_logitech_hidpp, then exiting fftest. Result: rmmod
> returns in 98 ms, there are no "Failed to send command to device!"
> lines at all, no hung task warning, and fftest exits normally with the
> machine staying up. For comparison, your input patch with the stock
> 7.3.4 driver took about 3 minutes and printed 12 failures, as in my
> previous mail.
>
> If you would like me to add a Tested-by for the combination (input
> patch + series without 22/33), please say so.

Thank you again for all the thorough testing and for verifying both the
input core patch and the updated hid-logitech-hidpp series!

I have added your Tested-by to the input core patch and will merge it
through the input tree myself. I will also give Benjamin and Jiri a
chance to take a look at the hid-logitech-hidpp series, and with your
permission I will add your Tested-by to those patches as well if I need
to respin them (and drop patch 22/33 in favor of the input core change).

Thanks.

-- 
Dmitry
