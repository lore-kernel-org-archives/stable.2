Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC024BFE6F
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 20:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792095510; cv=none; b=np+YiiIqHQgZ/wloAA4tmXQPEV7NM8aEFiXoaNKORWNmEVg1lTnKROSxLsjfJoDbnzRt9MRLEGzj6tonG+vvM7CjErsTI7I0g+PGOuwjamGCRYH7IHy5Jwvi4tUwe86Nl8C7N/7P9TTXG4vzMznFu/qYANYLWxQ7HDgPcubEMiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792095510; c=relaxed/simple;
	bh=jrnECgNo7r0SpTQ7QJjUmrWEuJOPvNiFAXIlOfU9hrY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QIDywhPfy1dA2aawwSNOrJYjmyxwwkxV1Egr4u2KfR3DcfZG3ZJluGaRNz3rUz6+fGz5AwSkLrtDM10lFzlWgal4oUkRO7vMtMEDz1FuqB1czVRVwgw+g7RrX2p30e4o5wMVNGUrRcdIIfQlmewZahR0afXMwX2g0EVGJksRd3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgv7fokC; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgv7fokC"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a018dc1f98so46019545e9.3
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 13:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792095507; x=1792700307; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vQXuJ4chOqvfAgFEMLoAZXCDN0M97boWDwL0KicWGeY=;
        b=hgv7fokCP8byTSMm8RTIcRQEklTOndaeMv3f1zj7PC83ewt2Ldz538gCFUmYVXAmNs
         ns6tzccZFEK4BTw0WWx6zGZyY/yHOnK92Dd6Rfup6dcF+lrk6gPmjAcg4tJJBSjPALOe
         aus114ACbjJmMWHr+GAuaaooWD8q+ugSue4cfaz7UjFqrQhJgsxogTQa1JV2h2h870Td
         3+weRcaLcgjV1u/FUswo6AjFU54HgGUtaM0I2da76AbzHW5QbjhSj9PsVmeHVH2fhOao
         uoDOMDRk8iH18ij5TwayNHDKZjPk8jbTfAErTwPZgiXi8yRqXHA70+2WX5JiuAhADYun
         0HZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792095507; x=1792700307;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vQXuJ4chOqvfAgFEMLoAZXCDN0M97boWDwL0KicWGeY=;
        b=ajbEVH9fVBQyiqNrwq297BGa00o0HqP2G87UlrOkMdtAzSyg0fqfbcMvJ8c8DVDdL5
         6vHlnOxtAJ/+cAeJ6y1VL3pSAYNJCHM2dS5X4oZ/dYrnMagVP2sWIaR4utQK0rUkSZmp
         3b1udodSoyb1R4Nc1zOrhQ66hb1hmWHh1FahFULCxF0/4wVgmu/acGSkYOAbRFc/iTar
         I03xuCKlzXlSadOoO+C74w2LNsEk0yejqg8oKKhxbEjunh6N9TxlA+hfqkuqgEtMlt2j
         TC6d9Gs7MdcoM0ziKHIWShxj10Ny3iFt5o4oq1Hla7v3ia7ZV4GgoiGHFm0RPJ15fUjk
         Ou7g==
X-Forwarded-Encrypted: i=1; AKwUvBzn7gtXCZMSBFmVtaYn69wVIpv2QS6twXcTo9ybFPf7pCav7rpBAGi6vHjwKJ0fJWEQj8p2UvM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKfwv3aHHKKiFB7+1Q9uOtoghr8CUtctLfhaz8APiv1K+Zk+Py9
	gIvAsrjWMlV3oCFw2kJEoNtisgqNqOHnkXZ1GLPOVWPOnka7sBUpM3S3ZRt6BQ==
X-Gm-Gg: AYBFou0epIcFT37ouG54yDHmV2VSSnhiI4+POtRf0mtXHrIX7ZvPMSeK45JWQY+wBLS
	oEcoiXY5NXe9drT18JJ5jR5Rqe1emzvNRw60e2THqUc+BwJ+CYQlql+9uXinaH0WlNpsoUWaPTA
	EYc01rbn07jzUbAIzxJyeyJW7BlO6xlABNixXHQHiJ6d0V2f2pC2Tv/b/W9td6NWPoiIKli71RZ
	HaCdgLOoNaJuH7185rquVKp7QS4DlVARDHGvGp4jcSkWxYTtiEYcP7wVFjzT5yp9IGkF4dsNTdo
	+swi9Ek/LYHRCUjIktVtu98W+y4JQHj53t/WE7cHtsiQJvLY0zn3TutepFyNQGYiXkVTlfezk1H
	ZffD05PrLebJro+ctptA2XsBfKpSQN8KvayYEeOETOaFKORwJapB6EVXOMAQpIdT9WmP6PpxtNY
	x71aXIPxZmHWQq5aDr8yZg42R89i/syA0JoGLckMm4gn76h5RlNGgcsm9wvgHks89L6QymrgjxH
	8NYm8N9P7/UzkyECGT127v9/2lW+Ls77+2rxmXclLn2Lv0lm01D9rJKeZjxVqS4ackseCnAeJ6A
	437kV/xvR4dbmesJtqu1rqstv7uKmiTfe/yQcgPpQ1dpJ7P1pW5wgbw1KKLYbPH1cY/+Ll/6h2g
	pdqKcUcMf1+Ah5yGZ3sW2NmqHhZ0stD4=
X-Received: by 2002:a05:600c:4fcb:b0:4a0:1fe2:d4f1 with SMTP id 5b1f17b1804b1-4a18e4d1686mr398035745e9.28.1792095507004;
        Thu, 15 Oct 2026 13:18:27 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8ab8bb2sm2616625e9.1.2026.10.15.13.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 13:18:26 -0700 (PDT)
Date: Thu, 15 Oct 2026 22:18:18 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Dingisoul <dingiso.kernel@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: gyro: mpu3050: add missing trigger cleanup on
 remove
Message-ID: <20261015221818.09527ff6@systembl0wer>
In-Reply-To: <20261015-mpu3050-fix-v2-1-53f73581e62c@gmail.com>
References: <20261015-mpu3050-fix-v2-1-53f73581e62c@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Oct 2026 21:58:35 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> The mpu3050_trigger_probe() function registers a trigger but
> mpu3050_common_remove() and error paths in mpu3050_common_probe() forget
> to clean it up, causing a use-after-free bug.
> 
> Add the missing iio_trigger_unregister() function. Additionally, change
> the mpu3050_trigger_probe() function to assign trig only after it is
> registered successfully to prevent a null pointer dereference using a
> local struct iio_trigger.
> 
> Reported-by: Dingisoul <dingiso.kernel@gmail.com>
> Closes: https://lore.kernel.org/all/20261010203601.1686148-1-dingiso.kernel@gmail.com/
> Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---

Dingisoul, any chance you can test this?

Q to others: better to leave the driver running in this weird
polling mode as it is now or return on trigger register failure
as Nuno suggests?

Thanks.

-- 
Kind regards,
Joshua Crofts
