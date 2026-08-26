Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554D53A7F75
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731888; cv=pass; b=ihhw9CZ98HUa+WikjghmrZ5BWL2cmb/taH8KWxtDxv2dK5T/sW01LIrToYHty7KdXume91FwjCFYYkvwZ2C0Eff5QyzU2yLvO4Vogwpa1BRnX0d3fU6quaHKjPddfXiMPOYZNQoavX6ei5jy0IBYs/bese5ZvSFH730inCg3pmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731888; c=relaxed/simple;
	bh=mXxLXyr21mdwImm9P7kpToLiwlq+gHr9hLXXNi9rmnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/WcvMKYMnGJfOPa+o9TkUr2KqrH+n5IBeryzNhUT88cmz36gd/zws26MbQIYa4khyQaZ+WXY7K5vEhRXZpiDsPBEJ+gIORFi9Tmxfn9lbeAL4dTXYNsYfdsdx2fY/aXy+ITh38rup5MeIU4K44R286lr9ukYdVpwACgEnL5X6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMiVLDMm; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMiVLDMm"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66d1663c00dso562077d50.2
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 01:11:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787731886; cv=none;
        d=google.com; s=arc-20260327;
        b=B8hEYFctczq+8EDO0HGNPFs/9cea0DCjegxY2hB2q6D9hK9Q9PnNB5K9iJx6jxqBJC
         8yv7CjR2L7F+MNpmO29zKNmLMznk8N/XXnzeFZ8WU5MTqDoAHEg7LKlKSS8+r5YuL+Jq
         yNquxafyGMMrqg9/cFS0HjO/hCG6TyrZ8sv5+wuEvGvDdxEstuF18hhK82QqCuMhhJnE
         y24N4nDzW3nuX32k8Wc6K8pYCRMFGkvAiBUyjCONdfzlZFpC2pXjqEgcRJkZ3JA2Gua8
         MDcras2Sj4qtD9n0Lwyeac4pEmVqkrk8X5XegXghQDsBbhlMFePUPLuti4EvuioSAI4v
         YGBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mXxLXyr21mdwImm9P7kpToLiwlq+gHr9hLXXNi9rmnI=;
        fh=fQJD9xSa+M4n9/vP2jDjpt2w6PuEOs1IQsyTesheI2U=;
        b=DTGIuSLOtQT0AHQbB36i3PPHnxDdCbf/jRYXG+My/Sf7fRC2CjnsQLNWkET5Re5W5v
         P5ZEE/+pi4Yh9hgJOpGLTjUCwCW6ZDohPNEtOQVfB/MOfctOwGAGYWV316MK/V/aJOWE
         ADD+OlFFYC844MomGEmNBonnudabB9lVtsmS50WnTZzr+/xsHChJS4k9MYbd7nypGsRj
         PXF2GOWqYQMLT654BcsVZI2xZ/PPPvwYMbRQ8v0XaYgwsdxuXgLdivNvOce0WmPeKKHK
         BeO5xPF4Ikfxf4cU1+0mfMypqDB5VzktoxNn4U8yK6tSnFozt8lAOFraycrqcPYYTcCB
         UEDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787731886; x=1788336686; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mXxLXyr21mdwImm9P7kpToLiwlq+gHr9hLXXNi9rmnI=;
        b=mMiVLDMmwbb6Qlsi9CZduOsXPgJsF6H1Uj8j0tv0PiLmvLtVs6pFNTXJrnQfzU7xEr
         V9YtRBFvEEnkv1l7kaC8RidmhmLiS5Muh61UZ8tIuxlUIqo6iI/huUjiAHJXnfzw6TuD
         X5jUcgkNusovlDXnjn7SpNL6Qd3bj+qH41jZxouLN3O8SZj+Q7AjZ63GlKBeGa8JjCQR
         /CdY5joLpje6yQKkDuyI4GYKicovdX4iDGh8j5HGs1RqRXBnOZIu2KT5JP8rw93qyPaf
         MZLa3rp9hRHKlYIO0ylKonXv97wKiShbWTME3uIjM3LlBId374OxX/H3w4ckENgbCSZp
         GM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787731886; x=1788336686;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mXxLXyr21mdwImm9P7kpToLiwlq+gHr9hLXXNi9rmnI=;
        b=ZdHvYKw8M/vpHWVDPsBYRwG87KYGOIHZYYfukpOBMTcihqXDxlncv6Ii/VQrOLCK5Y
         67j/s6MeG2N5NVLfy6GSLpjOqtdPDbBsigUANY7jrixhmcrautR5Kf9LjrB8iJIoI5Gc
         If/S/4txccZmfy3q4GtHyMGjCczOMc5jBwkecz4hvjGjH1EZ0CZRimjK5Bx1yWEsLvOi
         DGrSllql/hNFJAxUq56Y1UIiuit6+v03Vh7U5y52yiMetERZQ42lxb5vqL97g8U+rtsC
         dEryxOqMe0RqyGnoqkuvfZHM6wTghNduCE7bJn2AGMGL+X9bqZ03pRCYafzcDi9eOIhH
         YkHg==
X-Forwarded-Encrypted: i=1; AHgh+RqRb/A8S0J1UJus1eU5+TIdK3zVuG3K+9+ETWR4SPMg0gy3srDMvjfmzwo7qmKo8fOwOunNsAw=@vger.kernel.org
X-Gm-Message-State: AFuF++mhEWoRuoHavdvSlvx36fsknCckMiY1hVpebDbzxCncw61HXYJR
	5MA03KoFiC+uYO/wtdBLCiv2WJWoJlZW3xR3wB4skfP20eXonTsWfePYn07w/V+e2iB7hiYckuq
	f1KELel9YyXFt5mcD9/UgvBXOU1oix9A=
X-Gm-Gg: AR+sD10oTyzNmkgPYdMegYB/dWjlOKM6f0/3/FF3/klOceVIYLtybxNs20Uhe4BQ93W
	TYRPeLLmB+9closDJqrem3qPFjl+kVfakFPnukA9Mn2CPTm46z7R61L5BSctq9RHm4EHvrxPgN4
	02ujqc/y2pcN6nlpg1m2L6EZkTRVtKxNYE/ldv5XdEd4PAlX22DNJV+g5fWpyZI9ex8u6Ksv5DD
	31/w8dAeYewUQ7/TR2Z++Eb2CcTsoxVnCS6Fyh125/7Py9cgyrEY+U1TTt8vyav4EbLJzKpDe1R
	oun7V1vqKcc/85RK8JziQxZajf6s1VqdQqFICz+u016d0zk=
X-Received: by 2002:a53:e9c6:0:b0:66d:273e:1196 with SMTP id
 956f58d0204a3-66d273e1c3fmr963616d50.42.1787731886356; Wed, 26 Aug 2026
 01:11:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808151736.2934050-1-lgs201920130244@gmail.com> <e2b658d5-e846-4ce3-a42f-16f86acbf3e3@kernel.org>
In-Reply-To: <e2b658d5-e846-4ce3-a42f-16f86acbf3e3@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 26 Aug 2026 16:11:14 +0800
X-Gm-Features: AcwNN1UKGI8R9J607Eo1-mfi7Ht697aKEM3_-BNKkot6vLunRSNsSea1sgiMWBk
Message-ID: <CANUHTR-PqW=7k5HmC=qb4LA19qM90OBgnTx_r-p21Lva3zzO=w@mail.gmail.com>
Subject: Re: [PATCH] HID: intel-thc-hid: intel-quickspi: fix autosuspend
 cleanup during teardown
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Even Xu <even.xu@intel.com>, Xinpeng Sun <xinpeng.sun@intel.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Danny D." <d3z.the.dev@gmail.com>, 
	Abhishek Tamboli <abhishektamboli9@gmail.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Thu, 20 Aug 2026 at 22:50, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 08/08/2026 17:17, Guangshuo Li wrote:
> > quickspi_probe() calls pm_runtime_use_autosuspend(), but
> > quickspi_remove() does not call the matching
> > pm_runtime_dont_use_autosuspend() during teardown.
> >
> > If the autosuspend delay is set to a negative value while autosuspend
> > is enabled, the runtime PM core increments usage_count to prevent
> > runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> > during teardown, this reference is not dropped.
> >
> > The documentation for pm_runtime_use_autosuspend() also notes that it
> > is important to undo it with pm_runtime_dont_use_autosuspend() at
> > driver exit time, unless runtime PM was initially enabled with
> > devm_pm_runtime_enable().
> >
> > Add the missing pm_runtime_dont_use_autosuspend() call to the driver
> > remove path.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: 6912aaf3fd24 ("HID: intel-thc-hid: intel-quickspi: Add PM implementation")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
>
> You sent vast amount of patches, all separate, making it very difficult
> to track and respond in efficient way. Do not do that.
>
> Group your work per subsystem.
>
> You were asked to clarify and respond to incorrect fixes statement. I do
> not see how you clarified and responded at all.
>
> Best regards,
> Krzysztof

Sorry about that. I should have replied to the earlier review comments
explicitly, and I also should not have sent so many separate patches.

I will group future patches by subsystem and make sure to respond
clearly to review feedback before resending.

Thanks for pointing this out.

Best regards,
Guangshuo
