Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70B731E856
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 13:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181766; cv=none; b=JySLxNDqC/TlYmHTHZfEKfY9l6KNBQKfi7dyG3QnFaLgdgfYDfCSNxaCoUJJiOxZ86pcX1Q/x9YDzu1RqmXkomivsMI/Hipwpuwfxu11sHFDEGgrfXQIl6M8HIpR06WH/CRg0qWsqnKQO4/ApK4tbEg8dm+XESUyHhQDMfXfZZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181766; c=relaxed/simple;
	bh=wEk/CSduIDy3y77BOhVW/7T7N3x8NruFyaCJSoC/otQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jIzup/LEKVsBOmJtO9IsNXmZfSG4PCwV157k3Phk9nV7fKG94A/MJrGHbsa4ulq7Ir+2k2RhiTErLM0zsCb0ZgQ2WxyntTshRZF5x1N3xYZxouYyUZdSiLio/0tbkaNYCN7ltWxJxpVqJvxlRTYfuW/3cMwp5jrqz1KunxCbOIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1lS+LTN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1lS+LTN"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-499ae1c6471so25056075e9.3
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 06:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788181763; x=1788786563; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AMImnaz5ozXUWY8puoivAmaKF1Q7q8KDEeU/7MhVTEE=;
        b=l1lS+LTNsFDonqNbTGDKjYk4QZMzAuRXQWM4G1flipAOiMQhzkXUphzj2fu1E/vj36
         ar1Vi2xwGaogpdY5tDzRCaqL0hjv3rZxCFpp9MOhQGLE58fGpFIrx6AQSnFzEGhzk3IF
         k7a0gN2dWvtpse4JHSRNLuTnspQ33EpyOSuCA+CWKdZvSTfc3ADQ/Q7GUiO+ishSW5/+
         zSAvFHDLFwzgH5FFfGIvHhpHIET1dlcNwgkvMbu6ccHXjjwwhGDm5puVkat1xxOfvNGz
         TpQ+EIY0ntVt7FoFrSW40oPng5nBvHKKbChQPckjxfJ807RiG6lplufxQlUY2FPyoMWl
         wtgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788181763; x=1788786563;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AMImnaz5ozXUWY8puoivAmaKF1Q7q8KDEeU/7MhVTEE=;
        b=JLGCQINnSoHlZ6R7b1Mo9hOk8Qg/ArtNbs6b86rVMfWcsYjDwYPDKWBCCOc6UO0dGR
         wz3ff9Cv/u+4Vfw5raxda8EqHsv/VOmxwq3MExzmZLG3UjUQFKcz/L9hrn4QfrjnRL1K
         uV069Si+F2a+nwYrzVtuGNajeYwYpcgwdXJ3tfyK46uKe85CzpIcxgObg3ZDeH+CfQQi
         2JOEWmdaGTdmv7CJeezusKS8GnmgDKh3nw5aIsFlFmFEiff28V/5ZbyzABfrxXVXBeHy
         S2V/y9/gPZZxb8aHv1PdNb3smq+UzvYxbxMrPjLvicuibH8PKy0s/j5j0DJn2YJKbk2/
         HT0Q==
X-Forwarded-Encrypted: i=1; AHgh+RoZyJ104DFOBKqQ4uzWMp4Qh4rUBy126MbtKCm4KIYs4ReGJpge+mDuS99vvbPO2IH3iKVByz4=@vger.kernel.org
X-Gm-Message-State: AFuF++kNZ2xmpE6SfMsI9JcJGEg39JGCemBkn2xAR6FpiBTbGIKTazSR
	NYkK26UuhoasovcInG6FLuk3bDoyo1trb2+yPF1/SNjq10TmvvQ8OfTo
X-Gm-Gg: AR+sD11H4jciO/WiIaVm1CVFvLrHa8NLGwHvVbhjAveARxhuhacl3Jgm1ok+xj8dmh9
	kbYp50ERIa87HBKrj0C0zyG50ok9p/hnTX+s+b8xtI79TlN+w1rc+TExtLHSVobZ/E5GwWLdWEp
	T/tWDdpjFM9+pwNJA3yVUa09KOrtVN0mMQTuNnQaPScviA6rc3Xkp3pPkYClqoOQvETGAdhMyFS
	TCT9h9UiO381hR+tDRB8oYDgTlXRv3iCMWqQD7HibY8oAsSPYrC+PtipJzJBT4Gw+ID36Kl7P8K
	dwJ6RsBwNxS9XtqPAyxmR4N7aLzL6y87SUuSF7GFVQpK3NlgtN5dRf0uXXSSwF/Hs6xgjdYIiNR
	sgHpq8YuMobwDhQGGV/dcuMqNpRFmvMLZQ+f7PFeKu772JgH/hDHQDpsc5BFS7RIZLEVuJrCaYH
	9VgN3YKHXBn/Yf8NtbOrEWNjOOgYPKfhDtn3rZPGnIgiV3tLHvIHnsAQZaxs9TfKqQx/Cp7cdrl
	zyIZlXKy1MZ8sGNr044/4eNB8rchP9xkQjBlT6NQef1eIUJ/Q5IrGONir/XGpgd6eZ/r5r+27vA
	m2NRyuy4LCskxnI1YQBM5A2np4sltkpwb3IDTeJY+Q34ILvz1LYARL0vSSmDw2Wo3PTMmwPa3gj
	f6w+PWufPhSisx2Uo7olL0+6bdQ/5KQWDWuBxp1hYEnHXY8gnqtVSYMHeqpVPA/2S3JWZbg==
X-Received: by 2002:a05:600c:3542:b0:499:a5c8:c6f3 with SMTP id 5b1f17b1804b1-49cdc422c19mr9272375e9.3.1788181762855;
        Mon, 31 Aug 2026 06:09:22 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b94dc0f57sm318698485e9.2.2026.08.31.06.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 06:09:22 -0700 (PDT)
Date: Mon, 31 Aug 2026 15:09:19 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger
 <martink@posteo.de>, Sean Nyekjaer <sean@geanix.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Martin Kepplinger
 <martin.kepplinger@theobroma-systems.com>, Christoph Muellner
 <christoph.muellner@theobroma-systems.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v7 7/8] iio: accel: mma8452: Fix use-after-free bug in
 error error path
Message-ID: <20260831150919.000048d7@gmail.com>
In-Reply-To: <20260831-mma8452-open-drain-v7-7-22946812c928@geanix.com>
References: <20260831-mma8452-open-drain-v7-0-22946812c928@geanix.com>
	<20260831-mma8452-open-drain-v7-7-22946812c928@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 14:17:10 +0200
Esben Haabendal <esben@geanix.com> wrote:

> If mma8452_probe() fails in iio_device_register() or later, we could end up
> with runtime suspend callback being called with a now freed device pointer.
> 
> Fixes: 96c0cb2bbfe0 ("iio: mma8452: add support for runtime power management")
> Cc: stable@vger.kernel.org
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
