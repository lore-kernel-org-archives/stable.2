Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8B747ACD5
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789390426; cv=none; b=aMl+z4B0xqwHjI2vEDNHa5LJ4IB+EYoJxcKBioQ9xZCBVV+KgZ0014RNxr7/vOsaPeNt/0M6g0Y4fJ+xEKcWzu5jQcDlZfSilPr3uHEzCqOts3f2+c9AGKtQgPCUfJiw02VSFNVEqzjJzV6HYnq3+rrl7XzEO7u9r6NYbz/HuiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789390426; c=relaxed/simple;
	bh=QFR4oJCQoT55aHU4M/DQq6HQtEWMLxoilJJqgI/UOQI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kHa2VFwT52m/JgUNQGnbRuvOWKj/LeUkYkC5syRA/9L+QGm0ixt0lBE8IHrUFVkXCxiR7y492cXXMy8F4v0Wx5av/R2hAGeNEHrmDhUr4e1WzM1Hfkdgd/v/JqNBPjlp2whjqdi5LbycH1cnmZz1nRdjkRlHEbJTTLrbKx8xCgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qdWL0Jbn; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdWL0Jbn"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485b1d2874fso611578f8f.0
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 05:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789390422; x=1789995222; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UNtSulrcCSblkD0zfddb8JAGFbCKZWTczcGLRiEHaKU=;
        b=qdWL0JbnDozphQNdlP1muH1HnmyszbEu4UE9OHf6KlfTAqiYdLyrLYWyxQx1KHbqu2
         oZBFmUkXmJIlGwRz43T4Yj1JoPT/bZFNxd2cDsf4YrDmOZ1HcUAJkkJ3qpyWP4SZpvCx
         M/K5hDW64yoCoseFLbn0DIbGqmLJ6M0Cl6kFL3hYt1vIqt36GWk1KWrA899UpCOUMdfj
         i8HWUyIDh272zW7xFEfqXbZkMrsv+8TOSJqLECp0PUZH9GJ850+ldv1pUmv04L0m70U4
         PxP9lNmJuc1tvBYHKNEDAiF/fHFfXJ7ABjkLRWlhXSZKiRupQ2gnRpPiy5DRShHNSeV+
         UYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789390422; x=1789995222;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UNtSulrcCSblkD0zfddb8JAGFbCKZWTczcGLRiEHaKU=;
        b=DieBLd+bFCJywPBMEO72PCSlasNSNr6UZuwNoKVqvVFKU4mkJ55QjUvUsEZcsA7otG
         oblVd2Wqwc5fW9vQPKsH6C9p00sdzQ+/OlWnQ+d9VVb6OWHJbOzbfCYjDC6DsavAal5Y
         mhwe85THOk5LM/bqGqOUARAHwwD0PSpCZEhlAk5Du0hWk/DlPFnO71PhiAxGLkRz6txP
         9dFqNAib9LR0lewtQIBS9psWm7EoNPcOMpiWKKG9V8UM20830lEmbAMBRGnx6HVZS4uj
         VnnrMjpMB7O8wnXcAN4Yc5YWM2qaJvB9CGCP4TTtfF7l9TZOJBMisaCx+dvhOnQhEr8r
         jUwA==
X-Forwarded-Encrypted: i=1; AKwUvBykc9qdGWJQRQXbqsbGtbODxmnH7TtIrWI33svZwajlvwiAjiBIJjzUC2aEiXj26V8OXPsulfA=@vger.kernel.org
X-Gm-Message-State: AFuF++mV0ILo096yjni2Xhw3t2QlHjRl+IxYV4KPdXMu1xHBvh27aNtt
	TfaYi++JO+xE/IePii69Df6vjme85NnWsdrHC2Rdn68fHzSYBPfKLDSw
X-Gm-Gg: AYBFou0hmqb4vvtiTr12znBjo52qaV+I01bHVtAnvl2Ikh7z30aDFTvPpG14qzTWwMH
	B6dyu6sPrICzMPW+5/EWitCHjg7quDJJX6bolbThwgjOjsg+ffUlytuGzIAh6ygm/4ciAteuyzN
	75uxQhpHnEmScr/pu8ANvMYkLjqXwStvEQ4kotpGKrvqgGXwOhaGx1bK4DrU723+s+9vCoZOLL5
	aqwTmQvkm8GJ1hklK6aRuI6XmLTC7SBwYLtFbTN7P0fwtPJKClGONGuazOC+5cM0iVdRfWe3fAJ
	rrwXGSTQa4kCTvsDLzPmeHJMyuRnsMb+HWqvzOF8i9OxkfRFBd7QnaEF/rYM/3jTo404XN8fJgu
	xu+k9PMkqXa4MMwiPq4BPYzNlMd1lRta+Yti6Qg1sg0Nt3hMWf57U7uRZDwNOavyPPaOqJmkIkY
	PHOtO9seqOVRF0liapVbPHiefQiJyEqW9ah6nwfXUOTArCdZt8VjPnOS4iLlNwB8KVj1Lnpo/D0
	V6hDq5S9XH60vmTOB6qi1EmkiVfgPlwpmbK6iKH7aB7lTut1E061U57S25wu6HXxlesiuZGyWaO
	y0wOAlM/ViYKFDsNNImhpIRbEEN0OF6bia8c2rPua4m41I+o1pUVUh2an7qWgG3S9kvQ8q50hbW
	Uwg7vzf2j/rwW3PKmt4RNwYYVtfFqGIyjAQ8v6DuTjb5G2fGT3Cvozn7cGiEsGNwBg9B8O1/H0c
	l/lVVQ
X-Received: by 2002:a05:600d:8490:10b0:49d:1e79:35d6 with SMTP id 5b1f17b1804b1-49e7cf551e6mr4118455e9.14.1789390422542;
        Mon, 14 Sep 2026 05:53:42 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e62231360sm218704995e9.4.2026.09.14.05.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 05:53:42 -0700 (PDT)
Date: Mon, 14 Sep 2026 14:53:39 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Eugen Hristev <ehristev@kernel.org>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: adc: at91-sama5d2: disable autosuspend on remove
Message-ID: <20260914145339.00002f0b@gmail.com>
In-Reply-To: <20260914113422.1689331-1-lgs201920130244@gmail.com>
References: <20260914113422.1689331-1-lgs201920130244@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 19:34:22 +0800
Guangshuo Li <lgs201920130244@gmail.com> wrote:

> at91_adc_probe() enables runtime PM autosuspend with
> pm_runtime_use_autosuspend(). The probe error path correctly undoes
> this setting with pm_runtime_dont_use_autosuspend(), but the normal
> remove path only disables runtime PM.
> 
> The runtime PM API requires pm_runtime_use_autosuspend() to be undone
> with pm_runtime_dont_use_autosuspend() at driver exit unless runtime PM
> was enabled with devm_pm_runtime_enable(). Leaving the autosuspend flag
> set therefore leaves the runtime PM state incompletely cleaned up after
> the driver is unbound.
> 
> Add the missing pm_runtime_dont_use_autosuspend() call to the remove
> path.
> 
> This issue was found by manual code inspection.
> 
> Fixes: 75d7556ac0e4 ("iio: adc: at91-sama5d2_adc: add runtime pm support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index e8a5285bb6d4..e68632e628c7 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -2487,6 +2487,7 @@ static void at91_adc_remove(struct platform_device *pdev)
>  
>  	pm_runtime_disable(st->dev);
>  	pm_runtime_set_suspended(st->dev);
> +	pm_runtime_dont_use_autosuspend(st->dev);
>  	clk_disable_unprepare(st->per_clk);
>  
>  	regulator_disable(st->vref);

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
