Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792923433;
	b=15ghybBwIELWf8/i1TFbAp0FDeNlb2tCzc3lc4tO0haW2AF7ot4FTPEQOIScXqw8xZep
	 ljvDedVyGoFXnlOZ2YMwS7AkeLbqaQz1KfWs1D7yAcpAiQwMyjw1djZqLhxGmYBOvDaFF
	 QuHxRhcpPTYviixmwOzlSHS4AFtWNa1DoRWlSnz5Sx9V5nB9WDkMdvsXwWOCI/2jmQgOU
	 nIJoIyZq8dUnjt/PYucM+DAdToiAEjtYGc9RndWrSTSOOo4M+da1wie0IjJhvfPFoBneD
	 z8Uoc3p/pF84uhTVwEkG8nDQq4TZ15kZm3AluM+G7bMAzCgRMlf7TQHRKGwc51N9FdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792923433;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=p55qrhCyb8bxNriwh0vS71dSvlmsqPiAx/g1ELCZR1w=;
	b=PtlIv12Fifd9YCtfS6Vl+lxzY+fwXdubFOZ75K/4G62dsZXmMDHHcIOlx5jiVlavth8k
	 fxuzY+qE3pdkof0RqelD5bOokhQbEvWKqrT88Vl995eT2hWOqJk+Q4Ywis742yqD5+aCC
	 op0H5kpQta7CmONsGg9SymLyIQVRdFgnyRbQ3mn0VBNWNNZGbg19RYMMwbZeFzrHwWBWZ
	 byBr98dVpwKmPLBnZRUzvTBa7OBh8AgGPCE+HUFDVQqBbLjKYuZM+z7AiTTOYnI3hsea0
	 9k7BSI7Gp2h3LwaUFrzMFULqdTYyZe71ccGunbAl17IAz0ifsU2ZIRih4dKDCq02wmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dicwZ0eT;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67B6606A31D
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 10:17:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A67B6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dicwZ0eT
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48df0fa43c5so1274202f8f.0
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 03:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792923431; x=1793528231; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p55qrhCyb8bxNriwh0vS71dSvlmsqPiAx/g1ELCZR1w=;
        b=dicwZ0eT7zq6YUUFB94I/WXO5NSlGex+hWh0GEVXR44ffPnN3MbpD/WEElftVxleU+
         DOuh7AXK1KJcOgKI15DQCk8hylTYjJ4XHQqisS06cXDne10O0kaP5JgNcOsa6u5DLnMw
         IjZnTxtx/fRmOW7Mx+POEbJH6h5nffujIGdqSYpBm9K8MraGb7luDjNM3rggiyynruVl
         LPyFfYk05E3DaN4m4U3AUwPYRUfyiohPyN7tV1Lq4TJ8ZCr4JYPaoaSstlLTh4s1vIKV
         iGQn+IFoGseKl5dEZyWX5pFIFpjda3YXAGpFMSctygoAk23DtAaJ5nPJ8A13vYsuPCc4
         6DMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792923431; x=1793528231;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p55qrhCyb8bxNriwh0vS71dSvlmsqPiAx/g1ELCZR1w=;
        b=cutrXCNgEqiTqCB/rizdioaAC//Mh3KasxvcfOgIgNCz5XdFISA35v7r7c2rM2CXIx
         HgdeK3x7Tlgly2z+0q17OPHJZDh/aXFbEvlQfGn/fwToQnv8GnnXW5muOk6WOZukhDjL
         TS1lovBgimjp7A+vG6ewNz9XZCfkpLirbZfbSnF2lpCj4n5xh1wVb2HV7PcvQGESNJax
         /EfDm/a31/w8XqFuDVLtxFvU6tPwXcXeQ0jqYeP8E2Y8X+fNi1ZtMNRjZ6TOSxJ6m6vN
         x/9oep6PbVD6+xCT0GPORX/CGq/0eUtydSMDfr7dy3fIynYLl2683VFKDBir6BYpToKA
         4wlw==
X-Forwarded-Encrypted: i=1; AKwUvBwLqoagB925DChx1qJbn5oYVFpihtgQDYEM7BLuuIul0ckcQuQqUpogJzJBP89Ge/mVE5Z89/4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJajSJpt9bJzRnN2cMhEa3qowaH1ZpTnoJZtLTOvo+ObZ2suDee
	N1jcHzbMv+OIcJNR7/xs88Ap34W17v/NnIRRFS3PCg2bthof4y3kXQAg
X-Gm-Gg: AYBFou1yjeJBUExiIzeHC2y0vyDL8omGKC84WcoGvv5ov72Dz+KDftXoq9a5bxLYID8
	AobS42yvsUw66srNkzqTYw6pYQd7WUnjiVxjp8HRHg6rYWi+lKW2Ul+7AOwvliCfaZ2y6bgTEt0
	RpSSj5Np6Yez4TPlDNguqiEF0nzEncqXi1AD4vMUNnFUcySJbmmFCbEhpN2R4O7PpW9Txed1+4T
	NCO0xZcSeODjEf+V98GbymTA8YGItipj1G9KYlAOhK/CQmOlEz5xnC7xPUh5z0H9/IYL/wEqyKR
	IrYD8ij/teiaoOkf7VCKs6dspIfRr5PpMf8NROBMf3Bs336Ei3mWMvYIp0wdx55zZPyEP50HYIa
	FkiQyFaDymDEe4I5J5lGSKGdWt9uZ8/8gVozGEPkByFTXBI2x5xzq0jWOPtmXt/1D2SVAfqKUiX
	xK+4mDTYMPmtd96VoIz9Z+BG2j2j5Vg6aXwWQeMKRPJtTHobY+6LzR99ER3uUeL73AYTU858B5p
	avprnBsUZXQmz2kHSRa0oT6QfolGtjhORAguLGX1wYH4E6axQcgMB0TV2ATt1CeD5WOpEWMdZLP
	84z+giXM1v8gDiAktYpZpNiEPOv7pv8x9VVtoQf/6mSCxlUT7lOk8Q4ez47cA1sMKGp6rU9z0SH
	A9YaMTIwrHsBiY89wgkX11CVJlgK9qh4vfrwTc1pej1bx75r0dJmcweGpZaq7ROWHw+P71f8H/1
	2YqctTgYxswdkA
X-Received: by 2002:a5d:588f:0:b0:48e:eb:56c5 with SMTP id ffacd0b85a97d-48e3ed08f76mr7079445f8f.8.1792923430870;
        Sun, 25 Oct 2026 03:17:10 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ece5e4asm9068776f8f.59.2026.10.25.03.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 03:17:10 -0700 (PDT)
Date: Sun, 25 Oct 2026 11:17:08 +0100
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: David Carlier <devnexen@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Ariana Lazar
 <ariana.lazar@microchip.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: dac: mcp47feb02: reject out-of-range raw values
Message-ID: <20261025111708.233f7fb8@systembl0wer>
In-Reply-To: <20261024214423.865635-1-devnexen@gmail.com>
References: <20261024214423.865635-1-devnexen@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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

On Sat, 24 Oct 2026 22:44:23 +0100
David Carlier <devnexen@gmail.com> wrote:

> mcp47feb02_write_raw() writes the user supplied raw value to the DAC
> register without checking it against the chip resolution. The parts
> are 8, 10 or 12 bit, and the bits above the resolution are not
> implemented, so writing 300 to out_voltage0_raw on an 8-bit part sets
> the output to code 44 instead of failing, and -1 is written as 0xffff.
> 
> The out-of-range value is also cached in dac_data, so it is written
> back on resume and stored to EEPROM by store_eeprom.
> 
> Return -EINVAL for values outside [0, 2^resolution - 1].
> 
> Found by code inspection. Build tested with W=1 (=m and =y) only;
> no hardware was available for runtime testing.

This should go under the ---.

> Fixes: bf394cc80369 ("iio: dac: adding support for Microchip MCP47FEB02")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM

This tag has been deprecated.

Otherwise LGTM.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
