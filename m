Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997AA47ECD9
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 13:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789132081; cv=none; b=q5VGYv8cZMhoyBjI+0PAkO0XYlDvDV6p4sbwwASSY+FibRdWwLZBtXJCxTrIhXI4nWI6Pvjuy2623ClsOrSFBD1RuVmkRuec2xqWsT3iKHYLoHnxE27mlopriNISLsbCj1vqo2n5m6Xfc+idA0JumdUfv2cKVyIqiBzg0eUflZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789132081; c=relaxed/simple;
	bh=pOG3tmNen7f/3lTfNuzjJDyak1NmH9YJ7gzqicQs5oE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g3PoiRAPEyTs9vwTZQnexhsHiOBEacYzVtee+i0QHvdnVobXbS6cF6QUNkK/wXCE4wmr3SqjDFHk3wIHFnEHEUZZB8ww5egL4Ujux3lj+JeD/TSOGHpXBMubPCgjQN3N5hFvoBtAAOPahieRF+K1prK6C70NF4PxcXPov87mYUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=oTYryE7z; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="oTYryE7z"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843cedd129so542778f8f.0
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 06:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789132076; x=1789736876; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FjoAmWwMqjNrukHJpUAIw9xx0LKAxeIKQlZUt5PjQgU=;
        b=oTYryE7z+49Fd9fNiKAuBvckLgaBbwrwloodrGV1Yzh7HI6FlfC8U4cM6l+fQ/35JW
         A+ku56oldB+y2IHvbQ/+74jYlNwKHEedxsnd3KMGxYTVOOn9HTm+VPas0sosSt7ySy/r
         WStHKyniUgnHh3T38y44YqDVkVanS7OdepWgoxa5c5c5oGsUWRsFnaO1DCRKEzcXGeu4
         56WXsmc+jjEfFajc8AkmvxkrS6rA5k35I+nD01mkji67JnXO+jmftl2W76PP9aRjxWrG
         BtM21Xn0lJctTlCpTfx+RDoS5uEC9NVVlbV1rgkRZcW8reR7YRLLCqPPPr3w0a2SOBXX
         I7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789132076; x=1789736876;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FjoAmWwMqjNrukHJpUAIw9xx0LKAxeIKQlZUt5PjQgU=;
        b=OkuWWNHzN1PWo48ZqWZPevJ2wzNvAJFALfcrn3lX+AylM0vIqvI5+DRCi39rDSE7L4
         SnyXvmq3VBiM9Wy7xyI5UphSVgn6eM0VdcaLZHQliLkmk19Pb9cD8obfsV6V7tUY8d6e
         h+l0lugQ6vIe/STd8kDzL3nixIFvqKuWJQLmtb7ZEi52l2rQ7iohaZzRFyG/XMwP+uL3
         TPMGQMa7dcT65fD7kUZeMirYz0BouxthcbCYe0c4hgfAYhXTmXxRLfWFDWtj4+u748xc
         rSftEMIvpQFadEV4YcdxrFCo024CqGsvSluuLHsU50IooOrrRycsW56oBwBqpVN3eYsP
         /wZw==
X-Forwarded-Encrypted: i=1; AKwUvBxv48jd3On5ZFnBd39out2NrMC0N2WBq1s8LQ5SASc4bW24S01MoWfJfSeEN2GfupKuzNcDsv8=@vger.kernel.org
X-Gm-Message-State: AFuF++lTAaP/3UIt2EN0egOVIXcz2TziVG87jE3k0p4UByih/n++RJtx
	x23og2tSYy9TbEzLoCELJL1ur4eKx9F0ZG6jx7mmiHAA/6ehqsneJIyxvH4Lbco88Kc=
X-Gm-Gg: AYBFou2pZC4/sF2wy7a+WMCu4JQghC0BKVCT01ZTSoxez9Yk/v0kYD8MWicgsujdxyK
	EJ5TLn3nRmgr2/FyidA0lvaZhGmFP+wiYEPnyGn7fm4Q02DKGakCsBfZFy8wa7dIWNO4SijbT27
	9CHcbLu1lB1Jnkq5pSQOuhPfpr4Ch7P3+2dPf4X/Ip2VNwJL0qTV6cVqLfbvQIMo3iWJ8yvQoY+
	oKupk7b1b8mEcqZxsgj7m2qmKobICrCrmm8EK/JZU3PqYPLU5souXJVEqYJCioF5nODArcneceL
	G3oXTH5i+QVxVYPk9JRgDjEWIgeTtIvlGUj3l/k8KYj6UxmHLdCHggmJSTeurRmuJ46M/DTf7LT
	xbtDeHHdTwvmGOivGCxv+W/3nEzYauGD9W58G++FXeUKkKWajPv00NC6SW0swLqtUffmhWFSVcZ
	Aj7BVICImepvtVnxHc5W1JQqOLNtWhbyNXx8KI5T5/sIIPgUoMHUbYd882D7EVnFeZs3IFr0XHp
	woDbqJhkWEarYK12KlnOhx/ChIm
X-Received: by 2002:a05:6000:454f:b0:485:acfd:4fa2 with SMTP id ffacd0b85a97d-486eb35833cmr6218006f8f.28.1789132076602;
        Fri, 11 Sep 2026 06:07:56 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb350686sm6121441f8f.27.2026.09.11.06.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 06:07:55 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 6.12.y] clk: meson: align gxbb_32k_clk_sel number of
 parents with actual count
In-Reply-To: <daily-reply-0030-re-clk-meson-gxbb-6-12@kernel.org>
References: <20260910072139.313775-1-jbrunet@baylibre.com>
 <daily-reply-0030-re-clk-meson-gxbb-6-12@kernel.org>
Date: Fri, 11 Sep 2026 15:07:54 +0200
Message-ID: <1jik4c6imt.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On ven. 11 sept. 2026 at 07:20, Sasha Levin <sashal@kernel.org> wrote:

>> The following out-of-bounds read has been observed by Christian on a
>> GXBB WeTek Hub:
>
> Queued for 6.12, thanks.

Hello Sasha,

In those instance where exact same backport applies to multiple versions
how do you prefer to handle things ?

* Just replying 5 times as I did ?
* Just reply once with a note explaining that it applies to other version ?

Thanks
Cheers

>
> -- 
> Thanks,
> Sasha
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

-- 
Jerome
