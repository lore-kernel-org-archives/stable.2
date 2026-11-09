Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794222309;
	b=I899nSuJFdcch/pH/bkMPgvcMvjWjOtxpLR1fvuJYw8rWLa5IcpZ97PoMABckW9/r4Lv
	 PR8vCNg3yyewvq/fYQ6N5oGA1hlC/p6GmJoxZ7+jznoLkyud/rXsEfBwdFIeI3XfIaDgj
	 0QbTNgapG415Zt0NZM8zdKnhQ9T8U7bpcETk38bD0L4pBW9KfGHDYfd0DppKMqkrZcffr
	 r3AsMa0ieSduDeFffdlOKLg/DCmclu/+FwU/xPjnacyzHaAJF2suwZODsfgiZUy4Tlq8u
	 TZ5Mqw4ucwd13pjjE26A5r5cQWKYptO8GmOQDCHlMNfUJewiQiHT5T8bjMI3bh/rq0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794222309;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=gruXRLrwC50Q+01zYBAKobujyZnt2WH+acLyGLcBGqA=;
	b=YDyNli0nfU4OYmZqxmkC+MDAbaPIiBDNhO7gSloi8YNZzy+TzO+WbtJmrqayR1D8nUDG
	 MUeQMR71VuWnTGVTOgZtaJzXw7oBFc+sZIHEgKG1/WO+8TLp3V8zuFgELexN63SBVatI+
	 bAVDNYdTipDQhcyJQ90mqz0a0Fd5nAvOVJ0pMrvRrLxwremZp02dpKsV9cscd6gFy8Ekv
	 SDkR0h8zq0Vrvmd8EElsh/c3GjrW3fcAJE1qMflJxcsfuyhGjIEX+/6sjQQ+EHqOIDG91
	 GI9nyBZttSMquMwURCAT5XVYtav5iIy6FQnc/asWw5I5pYMkRCAPLMIej1bbAsIqw9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=NSykZstp;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF3D606A321
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 11:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EF3D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=NSykZstp
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso638417f8f.2
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 03:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794222308; x=1794827108; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gruXRLrwC50Q+01zYBAKobujyZnt2WH+acLyGLcBGqA=;
        b=NSykZstp9oTiKUgFJ3UzxLehU62aPWxwFq90PnmqrOYywES4i4AcOzHYZySAY1pVwq
         vwmj6DHH3dVkrhVibCHxQeVt+OxzQ5uX7hZAH05pO/IwWLrsGoc9ifYl79A1NCVf6A17
         IoynvVz/C3YGak6RNV2fLBOpdZMypVS2K47ZFJrlTWQ990UhOgQWQ3c1ir05/s+hZJS3
         HRJISrQT5YoW7RzT89EFMH7RBi6fKBzrKxwQ+L19Ps9oopbaBFlubCxu8MnCwlhIeiLj
         RJjHDHMDIim/9IDvZQ4j4IwWOOMgf0O00+xYtIM6x+s2hBymV3bGjwWA1h8Kw2d4rg5B
         TqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794222308; x=1794827108;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gruXRLrwC50Q+01zYBAKobujyZnt2WH+acLyGLcBGqA=;
        b=mYel7Oh49TK4V4+puEivfqrqLf+9gkA5aiysw+/eWQfDDCicSQWtzPeZ3PdkAJAzUI
         U/8c3Ro6TSURNu1Jxy9hBm5uhS4j4eHVEVWU834YMFq46wg4XpJX62LR4xsf27/5qtY5
         UuWcIrUKCVQyBgVQwMP7URoDbu5SJp/06hWIQQWD8NGAFQw5qPLC3zAVf+Xxy2N5y4Jd
         PgB1GtsjcwUydcFVshCaCJYCSuBFA3jkOsNhwnzFUyiT356XZFWMaIwrn2B/KIdYFYCZ
         aXKl1K9pKv0qIGbgUVbDDc4ZTl8xewUqhPDyQg3Z2zF4auI9mtwSIhhqdcJ6c57P/Yn0
         lsEw==
X-Forwarded-Encrypted: i=1; AL+hErEPvhCn/NJH8ldv8w3pAvrh8X0Qaz4EOqF8NR2M3J+7M1dbeIbNq0BF0fXN8drqjdXUtPxw1X8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ULwtw0IApqavIrLsEn5R/ntyYzUaaoZYvftByW9uoudKHp95c
	R1C1uK7dHZD7YT/ESd9S1I4y7gZZiHI+jKK/0UYNK7EDnuVLFNZ5tKjNEyk+ByFz2oE=
X-Gm-Gg: AYBFou1e3MjRBGauoWj3kNZQfb2/WNdDX+UutlNDCASQDTeC+I3eTqUlSdS8KcRLRPJ
	X6j3ai3MYUIiKZuyjVyZlVzVC0w8JBbp9SsHcCMBvmch7YAeaTsYQAmyiJhysuC9c4hXsE7R7yp
	xc3zYdtN0o/ZO9dA1y6at/Vku8YxzDxaWeKkdD8qL9Zjyq2DYmguR1u8Eq0gIl3d8JIQgPCzban
	KvXHwUWjbl2rR8/SOn68NtGNFQnivUWd10gJIJrRdL1FcEnS/C45X88YP9VlcC2wvpdCX5Ky1cV
	AhzmYW65momY36wCoBFivTI8xgFTBZqQxBRmlqIbSkVXVMoUsoxT8UYtZrNainnmNvpyu8jDv4C
	inREgGF/lrkeRPKUYhc8APE9Z1TpcXGQtuKZVTMyg8SRbS/xjR/hVKbnXe6E+5/SgqK5Z3RaxLb
	0MnWXbfKY3MrsEw7NiU8PT2reZ0Q5ZoYiu4Huk42TngAXi8XhoGUaHDYH9Cn0Zj8GJksZz3P3ol
	+/zfOnpZC7TQoUdDzZkTsZ4vse3Eh3MDlyLk1GDoqELh4CL1e6wTApEIi/vCdIfueA2/S6LKHlR
	UjV++I8XCUuhDEh5LYdHQBysOGzNxEE6w6EMrQS6BUo=
X-Received: by 2002:a05:6000:2501:b0:48d:f460:2c62 with SMTP id ffacd0b85a97d-4958c0beec1mr7604586f8f.33.1794222307486;
        Mon, 09 Nov 2026 03:05:07 -0800 (PST)
Received: from arrakeen-2.home ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49596f9ab09sm8970489f8f.28.2026.11.09.03.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 03:05:04 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Nicolas Belin <nbelin@baylibre.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Shigeaki Asai <y-asai.0816@docomonet.jp>
Cc: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, John Williams <porschemad911@gmail.com>
In-Reply-To: <20261004-meson-gamma-v1-1-6347558e2bb3@docomonet.jp>
References: <20261004-meson-gamma-v1-1-6347558e2bb3@docomonet.jp>
Subject: Re: [PATCH] drm/meson: encoder_dsi: load ENCL gamma table while
 ENCL is disabled
Message-Id: <179422230388.1497673.3746542387809770384.b4-ty@b4>
Date: Mon, 09 Nov 2026 12:05:03 +0100
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

Hi,

On Sun, 04 Oct 2026 23:50:17 +0900, Shigeaki Asai wrote:
> meson_encoder_dsi_atomic_enable() programmed the ENCL gamma LUT right
> after meson_venc_mipi_dsi_mode_set(), i.e. while the ENCL timing
> generator was already running (ENCL_VIDEO_EN=1). Writing the LUT
> during active video stalls the hardware: L_GAMMA_CNTL_PORT
> WR_RDY/ADR_RDY deassert and the ENCL line counter (ENCL_INFO_READ)
> freezes, so every remaining write times out (~8s total at boot) and
> the panel ends up with a corrupted gamma table (wrong colors).
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)

[1/1] drm/meson: encoder_dsi: load ENCL gamma table while ENCL is disabled
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/0cb7f6d9e4b1d0a411b628ccf78695ad41c66570

-- 
Neil

