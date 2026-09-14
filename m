Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6327A496D56
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 22:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789425145; cv=pass; b=TxkQyUZrX8HlwpKXxwSv5eD75xFOKwgnEgVYJNqcN2mIUJBimwJNwCCKAiOIiJpt78reZB/LlLG2C0oLtbU9I3Fp1VJuOCXwjeloFmlYaAKilI7jKKWFYMWERVw/MPqwHq6Szp9yOX5lE/rNLP8ycwHssN1dax+zS4U8miMNoVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789425145; c=relaxed/simple;
	bh=RquOnyx3oonNy5ot8nKZ+MZokFOsGOyqVbKyPQz73Oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ALHAfxH8uPF5f/MdOeNasgkdqRcWpYrkzwVuNm1rtWzI45zZ+UJYtlaDmd+V5N1OPZ6rkWaJjDjNs6XWPRV7YG+8seCy9YoJyUWxHdxQwuuRvRrE+aC24DuUC957+q8XI3Dug+HeCy6HcHiFEV4MnO6sxFwFsyk+RZOfzFVPGQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhPj5FJm; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhPj5FJm"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c2940d16190so550339566b.3
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 15:32:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789425141; cv=none;
        d=google.com; s=arc-20260327;
        b=sOVewICZxgn54GrdtMnA4ROsgXtj7HMXnTcyYeypw88uPqzgyL6aevpWskJCFnKSOu
         hSDJGX0M7ldng8OfjHTqx1lVye6R/5ICp3Eb17FvhNXBRhQb4aHj6d+xpINpBix8cSbn
         mFs5m6dE5Ki+Aj4EX/HTquOOXM04Bo09LXv1LliBnQOBTfgbLeJCyae+fdMSPOypnXt/
         qvxrOPmBnNjoN9HjbSv4VrHb0PVQ1wZv8yDZayvByc6AJMvTTpUjPW7rSZ4Oz7NM39vQ
         yWN3Y2d1EHK3FhgiTf4Ck0AuYHOS0I7YKsqNAhkIqOQ7GcK86d8I6hjoBy8bbEMTyYaZ
         VIeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RquOnyx3oonNy5ot8nKZ+MZokFOsGOyqVbKyPQz73Oc=;
        fh=orQTKn43xR3nQZxG+1n6aEhNf0u3zj7vCVfFLlMaLQo=;
        b=pALFmFlpaXKdkVa0ZXz71hOzYfx6f+f/LqjaUDdg8BS6YGuf3A/v4F+YAZG+cV/JXM
         2DXufrLxIkpUh68J5PTa9rrlcOPYA5N61E8bPDPk9EEe785jg0+32Dxuisi6WL6TogoQ
         7CI7rldlp0Sf1zRUqAnbKTaFACEcFqkjujM4o2qQuxaFCxo44W/1IHdqvcNjOeghebxV
         ZZsZmYVlG0leBMHiYK2KU9AqaDmAn1W4QTE08V1RoetI8vKIvJME/pZ5/YXlpmeRDAok
         v2wT4DuIF6YSBZaeP6bphbF8GArJTjbCVldjbEZFx9WzVymJU8Hc/5FVqw9dTjQE8VpQ
         YDiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789425141; x=1790029941; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RquOnyx3oonNy5ot8nKZ+MZokFOsGOyqVbKyPQz73Oc=;
        b=IhPj5FJmufRo3u88fDdRaoH72K7ArrJLOpQdJOy/gGKFAzj5XxIsE1+DnLI62xZ7s2
         uZxS/2/4Jsc8ZKgauCEDmblqng8u1BrhRc8LqMNyKOlffq0wYMKglT0CMC+ffE1C9Brb
         xJ1yoBz02BKSOmvwCKhUGzpVRb6ARPoHoJ9ISwKjUnxI4jgd1V6Te8tgCHwE40DO1Sx1
         3XMTIOBOvLnRt+tF8dOZd86zRfx2I8HJHaXccOazmm1PLj1GhbruuPTYa/n1hse7ZA7r
         pJ24yVdyytXwPeykQx+/b2ozLANwCLzRr9QO+UNitQWn7L8SO02rrXi3p/AtybyOyQMe
         vp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789425141; x=1790029941;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RquOnyx3oonNy5ot8nKZ+MZokFOsGOyqVbKyPQz73Oc=;
        b=JtPnZPhKUJnkekO4i7+bPE/w42K/p8uHce0DFsPouzjfT7G5CPC/CXGUTJZv1fNwhN
         xg2JpVu/9PwmuS9maUuEQSkYyCDK4fQGRDUFTAyNf45ThR8LZMWMvNjGgB9Nd9Jkjtd5
         XeO8xh7MlXBxY12hu4sreru9iCA+IXbTxzBXKk0M5bMa7FtAEiIP471amTlK6LuqF4Gb
         i3nal0WmiW6mrdyepyCNKdtbIVFDl94LsaoqOuk2SmTzzLM8/KO8lMkIdB+bueLRGfK5
         i6Za5ozqhvbNxAHLpaOi135Jd5ltwoKtbUAvX23G/6QyyVlA3ZUdxXboH1PzpeWmh2Ts
         rbSQ==
X-Forwarded-Encrypted: i=1; AKwUvBzLTtwACs2EOzxLkjDda224Q+qkJMN1RsTOzTshPuzGRE9ofA6m+/5xDwWP4qpyk82Thbi4wdg=@vger.kernel.org
X-Gm-Message-State: AFuF++lBoF/abZWeVAHjc0v7faaHdpfaQioYtztGW5H0jjAUsdX8c2bZ
	h3GkxxE0d7oLnfxZ1MfOxWiavpBaFQ8g3kAvwBZYXVg/7HpxES8twuv1tX6SIfx4w6otbskOK/J
	QBbw5w7u6H+XeMV+L/whGLrVCKNo6lA==
X-Gm-Gg: AYBFou3PaE+1V35veFzgrtRsF/6p+MSxvJ8ltXFE3AfgspA+OnGksbEJqQd6V0RDNGG
	aEKtgDjLVAX8TnrtZOxEZPDWhTxH5db89nQwaJqEi/1mdpm6a31/c3oqh13/QiZ//bUgDfgS2K4
	5Mffcjlq7SzrfWeFSQuPI2pFqT8Z1H8As0YbJzG0Kb5bxj+GGTyZ4JbZbUuUV8+p+KfM+6JKQi+
	b9+cR+CvFO9XWZUuBc5y7XfpvMZZbt6vsRLbmLGtnc/B5rThoxsBgmxfijIht4LWy2fVBIk0mb9
	g8woDQ3YUS3xrdKyJ6UQXGHRyg7+n5yab2+yWvQjrNR8DJpgXZc7w+g2/M3b2bsq6hrIx2F6bNm
	K6iCUDqWqyGosbd2IF4HiMQ4eWG94Q0zsqMRHwaBW6qZq0mplwUYzDeK53cXVpKl31WaS
X-Received: by 2002:a17:907:8e07:b0:c29:45ad:7afa with SMTP id
 a640c23a62f3a-c29b804bd7dmr277377066b.0.1789425141394; Mon, 14 Sep 2026
 15:32:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913040606.23272-1-mhun512@gmail.com> <RjVH6lTrT_KugcUQV9puWA@nvidia.com>
In-Reply-To: <RjVH6lTrT_KugcUQV9puWA@nvidia.com>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Mon, 14 Sep 2026 18:32:08 -0400
X-Gm-Features: AcwNN1UpzBAoI25V1FSIL5wEhSS0QLs7PqvCPS_cC5XA-rgMX6mik1qtVrFRyMw
Message-ID: <CAGEsz8GawAJyAXbksWUJRhUWR+c8cXbn-AVWfd+kgLwO7ZQmpQ@mail.gmail.com>
Subject: Re: [PATCH] pwm: tegra: Disable runtime PM on cleanup errors
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Dmitry Osipenko <digetx@gmail.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, linux-pwm@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Thanks, Mikko. I'll use devm_pm_runtime_enable() in v2 and retain
cleanup for devices that remain active.

Best regards,
Myeonghun
