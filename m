Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795256338;
	b=Zuvn1I6zLvhGheBSpl+qRMyQouVj3Av1iq3nhiQZg5QYpjtO29hSkKkiEI9ZrjXOncY0
	 cXFk0txo7Ov6gBTCMijS6EtUAklAaUDw9DgdPd4kMJpcZxb9qJsqgaFI1alWW4rzmA3Br
	 nOfvyRp74CP2QuMDzKoHPL8EhwS5RQdgrrMb5/4IrFbwd5+cfvzO0iViia8VC9D0aS9bC
	 6HQPHxfYrdmoXFphWmCSzr9FWp94t64xYee0R31BNlyYoxjmQ7ZUvosFk1N+xB53EC88a
	 Y/pvEJ9fjLcsDp/4uxWWY8O0iEcWCUo83dK1Rg0JTuRt/4grHJrKyisL0ZTKKY34FIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795256338;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=dzaf2Z9uO/Z26dmJHQt/rzIG6OfXFllTIg41OzeeRLo=;
	b=wlitkqBXQXHcPUiu4phVxh4QXkh6l+ZRJC/0I5aj1wup/ySws/INTHTuxqQ7YQdrYtbV
	 bujZcKziZe7LB6z2xKiWYBJJrK39e94F0ECCl1OlJ4LiZJo5FsVSmav7TlTQXtgx4ZfqX
	 mFeoQeUQjv7tlCiZbOmymiiiCGgOP+nszRnl2lT5r0pXGIgxnPdCs2M5d7w2XGAqdQ/1k
	 f8oia+i9CjBLhwudeyGUk0dDHl7kPkcfOiUjwksAwtdr2TmDwW1gAsvPxHjjGuv5omuJ4
	 beNQ3u9GHK9MacW5jr5ylbC1h0uhcCHtQEwiF9NJhJv1dYeK/t/j8MMsJhz035b+W2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I7SAFHvG;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82F4606A32C
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 10:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D82F4606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I7SAFHvG
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8b29b83fdf1so876984b3a.2
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 02:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795256337; x=1795861137; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dzaf2Z9uO/Z26dmJHQt/rzIG6OfXFllTIg41OzeeRLo=;
        b=I7SAFHvGEVCBm0J5+m2y3jr0xvZhrbLgb4JRfF5d3AbR4l4CiID2rJ89wQRPDk+qLQ
         sbfn/BHHtEHxluv7Oiy01POHFJHNfub1xMCy9gqy3cNW/p1yHeeamx02bImhk9EmdlfP
         mYolBA5Z2JOA++5xz640eA6IYLpaP8IGf98w8WCs7s/ZVI4NYEksZ5A+/mtSZURniLIW
         2qHV+msb0HIo0O0wLdQ6Fc0l2XHKnWptHD+bIzDbTheHAyVUpe/vopLup81FlXNrQ/Hc
         9YbijY8H8HakzFA+TxSKVEhce6qnA6g3cymuYVuyN8kataqFn7drgaB7aX4LYWoe9QBd
         qpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795256337; x=1795861137;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dzaf2Z9uO/Z26dmJHQt/rzIG6OfXFllTIg41OzeeRLo=;
        b=2TfNf+8Vf4VfC05GuT9L9qJb5U+bi6IuOXYARg5STGIYnuW5xmJpgFgmF+HJ/9rkmP
         pMPwIMYjLppzCWN/MJtQK4MC/Aw3LI4S3Mi4GaEQFpyxeKweacR6gVQZ/M1f5jRmq0hy
         MYNxVQSoeIrlnNT2by+Y39MwCFAwXGCA+ST/wGaRLT3JSwbnH1q2unJ44NcVK3BkDvFL
         XoVjv8fZfvDrwH0O1BjjO3WKn606Ydhsh84wXRtXStCGzYYBn067QZDQ3Ai0jnWZ5aRe
         8vlgjIqHbCuDwenBvJ4SjMr0wGD1A2pHveOOMtrjle5jFZ6CS17jow1RYAx8ZGrllgze
         vNng==
X-Forwarded-Encrypted: i=1; AL+hErGcpqcG3Vj4fgPh2OQnwetyAM3YzZkOg23Ayq4tozxZm5LWZkRfY67oaNm6rRk5ShmRvtpqnEM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+2bfhQulV6Io9XuTOCBi+R83D3nZ/HtY4K92qRC+oyxE8LNUOU
	rDDGWMTl5E/Z2ja3IHFfOKQPotN2uNlCz8IQGRyP1EeC5UkcUwl3Uhlv+YxT8k7R
X-Gm-Gg: AZFdTZfGkWU8lTRgV6lNm8d9ilwVv/OiBhQB/r1s4lobXBWx6zc/pcAuCrJEDWT6nnA
	exG+xmPLKT01xPry0NAUsJUcJAupEov9DlDRe1MBjG1+bVYQ+HjYX821v2JD+hW7KaX2ouYCzmK
	doRWlsPd0uJYFeXn55cuhfYQDMs9URNYmaxeBYacGwCpJEk4yCDKDeAXQ0P2el4SvxPRNzz2BG0
	z8DWjdsrkEk6hiHY6ifyne7dRz2ddOTdhynh4xvtDhfcnpEVYpsV68ZphEXcTbLyvEMcPD9KSbT
	v6AxDfpxEwLBUvZe7RzV3krsfLl2w+UMDEbqLZW0c3GhkEN01B1y8B+HjbTlERwd18zseSqmu/3
	EwJIU5mJLrDeu15j6L9Yyjjm5Qk5H+Q96xgPEBZslygFQFqXWQuzwN/bb/E3b/xjklOqCYWMm0H
	9zDFFem2lFPnExi1FBxh7xmn8iE/uquwU1OjoD6Z6t9NqfSqJJsGhVnN2TEN1YRqiLtXIIZuUli
	uG6yHQtkJFuWsmpX/Qaf20pnPLKkaDhmQKh0SX+bCLTRAjs4visGTjxRarm5BEHXE6Td5Mon188
	i/VgsN/ZbwI6JkS9XO8dGNV+t8qvWbclj89ImTz+lXlq/89W+isvBx3IOQDqDspfFIJeQWUrEVB
	unarGF5Q2A/OmdfpQna4VF3cJP9DwKA==
X-Received: by 2002:a05:6a00:2da7:b0:898:e7e7:c0df with SMTP id d2e1a72fcca58-8c87cf2ad15mr4832985b3a.45.1795256336951;
        Sat, 21 Nov 2026 02:18:56 -0800 (PST)
Received: from reply.eml (awork078078.netvigator.com. [203.198.250.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077bff6sm2701360b3a.3.2026.11.21.02.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 02:18:55 -0800 (PST)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: Ignat Korchagin <ignat@linux.win>
Cc: linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
 David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Rusty Russell <rusty@rustcorp.com.au>, stable@vger.kernel.org,
 Vega <vega@nebusec.ai>, Ren Wei <weir@nebusec.ai>, xuyq21@lenovo.com
Subject:
 Re: [PATCH v4] KEYS: Account for asymmetric key payload data in the quota
Date: Sat, 21 Nov 2026 18:18:41 +0800
Message-ID: <20261121181841.58673-reply-xuyuqiabc@gmail.com>
In-Reply-To:
 <CAOs+rJWf5JEMD7UC-4YS2ayAX5f2SUgr5s9DCwmWXExBhqaEJA@mail.gmail.com>
References: <20261026024840.23482-1-xuyuqiabc@gmail.com>
 <CAOs+rJWf5JEMD7UC-4YS2ayAX5f2SUgr5s9DCwmWXExBhqaEJA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Ignat,

Thanks for the review.

> SInce we touch PKCS8 as well, missing a relevant "Fixes:"

You are right. v5 adds:

Fixes: 3c58b2362ba8 ("KEYS: Implement PKCS#8 RSA Private Key parser [ver #2]")

> While today indeed only the asymmetric keys hit this I wonder if the
> fix is better to be in key_payload_reserve(). Something like a fail if
> key->quotelen + delta > USHRT_MAX. That fixes all current and future
> key types.

Agreed. v5 adds that guard to key_payload_reserve(), so every key type is
covered. The asymmetric parsers still charge the actual retained payload
and keep their early rejection before the payload is installed.

The common check also covers keyring link accounting and big_key
updates, which use the same field: a charge that would exceed USHRT_MAX
bytes now fails instead of wrapping the counter.

v5 is now sent as a separate patch.

Thanks,
Yuqi

