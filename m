Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CFE399CF0
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731438; cv=pass; b=lZ1tdcwvp3KydjmprZ93ei/LMrrQxBcTAm2BD42+Lz7tISrS/XoR6TlnPxKX6T1re8SGdJ2GcmEcb3LtdkBT1oDIP3lmmHatrgVAgwGKFDutXVoq/C+j9m2omfiV9k9Tthf97lTdwqA+gucK5tTsVYsGfdsVqirhx19YUEPSllE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731438; c=relaxed/simple;
	bh=E527r35PH3U3M7/ba4/IfQXpLEJINpkZTHz2CHClcLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqG4QrvcRbGkkbH0lPNLNctM5p+NP9vD1xaFIjr1TumNH3r4uFQUeRq1NpuzwHN7Rou7upMzX+ysh25TPzYr2tuIwNmex3ffzR6fXcUSnt1hN40YYtFK9wcrMmG6OTt+A353vFoV+7O+p+En//5qaf3cm3ioppARwqcBSsFexVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDn7FSM1; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDn7FSM1"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66d146f04cfso547119d50.0
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 01:03:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787731435; cv=none;
        d=google.com; s=arc-20260327;
        b=iNBKkgahxR685Z21WnpZTRL9nUWj9hLBpbMLZqwpmQUuXRf8Eh7bzvpjItbU8cIcyZ
         3LpuBIQMUY9LpzUVedEp0Zvhk+ssDCoJbtfucrXQQCJw1yw3BIpfKRf+jEwJ80LbnMxf
         msDw6ARnKytQSf4dHPrs4yUHxf8XrsKolF0ztr2/UZDFmozTyOFBZBpa1OIi6c7mD0uy
         6nAQoK/cmir3S3FGOAZhzQdum7gyF9rI2Gxa2RbV1z/35JrpLku2okXZ4yiUCEQjjPru
         xRBOu1bnobSH7c73qtq7KsF3hfCJjI7/jSROM7WsXwPB9W/fKTAd+p+UTlQr92lBryl7
         hhRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=E527r35PH3U3M7/ba4/IfQXpLEJINpkZTHz2CHClcLI=;
        fh=I2yw8vNEWK4UQiVc2gMz9rfu0cs3NlLIOp5zmgUBl/A=;
        b=o00m6N7FkprMEX/6HG26sw7dBIroYtnuJwcEpYq9bBzGiZ4TeIHQtAkOBAPuVvOb6W
         ObtjY32GPJlW32yiDkPRt2Z5LrCDK2KZZx9ZAuY5yQFel+LdNqWVyIhu8eL7P7/OMMVH
         FzytwhrB751Y4E2q/txaqkWPw6Adn4B6IoXO2CJ4t/LWglYiY5ofu8q4NOq1cPMSWjc6
         KzOh3JtnLdqiM8Fwh9aeDgrGTRAgFtgi2HyY2pQ0dxppfVfRBh92ZXznoQEkGH2xFduv
         i9pjEECl/zHAw9SM3Yfh22uwd147c7wkQ81P1PSMG9MpKzckQflqQnf7FK73+7ktxhW4
         ISKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787731435; x=1788336235; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E527r35PH3U3M7/ba4/IfQXpLEJINpkZTHz2CHClcLI=;
        b=bDn7FSM1WZFQFoEKW1nXEJYOJrWzpzcOj/j4Mhgujo+5d2CG5JD3/VaXtDF8tAVIxq
         h290EDcKlb1MabGtlk+chlDFF/eaWBgFTUvtrUGg4gq9ejH8iwWYJB6rPSR6+t65z/V8
         cGJwJBtSjUfW8rEsIEt6rGcRzkyyCHTBkWqa2ww4m8mGvOu3pvWL4koHoRH/MpI1ysiy
         mFCJRSEbbG2K7X/CLlWhDWJN5ZBqntvgwDkpKVPwM8xjSR51JJyJqSID4gfH27n8lZ0A
         2kUqHzmjpWeOFmTn0jfqFG+uy4i9CN8BvkK5puJrPdvYmCHlRUknxQkxVlvrZ8/8GuXF
         HQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787731435; x=1788336235;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E527r35PH3U3M7/ba4/IfQXpLEJINpkZTHz2CHClcLI=;
        b=gj5JhJrkcJtoArZAE+vYKKzFdW4F0d2CEgSjW/VNe2+IF17z3vVXz+0ho3vG14/Dy8
         7PBf3YPHP0yq2tFW52mwz4ITI32pTD1H7xCE1ZWTF4auQcJrmEhAR3WHV+3yS5U738xc
         VOQzABvyHzCifkKDDEYeM8mCILJ7EQb5SW5pq3j0kF6QrT30v5lS872v1Pd08vGuP2ZW
         9a1nW8ir6gcKDHAKu0FvuDUdVjXHpX7J9z5oisYIVwqaXvHS3voay5UgZyLAmrU+5DfY
         g716IGHA2ulAKXbSW36o3QOJkASf0Khd6sL+nR5n/3ZcitzNB/XFgyLjp5+/otYRRVoF
         mmYg==
X-Forwarded-Encrypted: i=1; AHgh+RqQ4d2yxcFU1pIMFNEMDE9nlum1QtgwjAHdzspymy6JMCJGW/vHv/15yO0hKOiJnmpW1r9WYpY=@vger.kernel.org
X-Gm-Message-State: AFuF++n5YcePLZqGXOVUMYsjiGGcZ52NsMc+2RIJdCgrYQkO2Yutfap4
	7nxfyyPACuP02GqhRWgHtRPqZI5noWC7SuQsQXmxzLKxvoLkN+vVHyQCI6vfxRcFLptuC6g7Zim
	VHhjs5qTuF56Hv8eqzV38ciiFlrZok3O8u3n7tLX0mg==
X-Gm-Gg: AR+sD10WswOiLn+zysIEkyW3aA8MGV6d8K3giNZ5NqPzYQKuOJgiyvrbzLR2ddFgtG5
	oxVLPIooBX9o8k2DwDte4Otqm52KGMg366U+QvgajAlLTdFU3iS6DPeokoVDT60mMVuRiLi8yBf
	GTBDrXiyUCnz4heQ2aP+M2JH0cF8Tx/0TvuZlCHknZRDHEaVvtlqSyLNcE9l02I+GLwfIK8PeRP
	uMXxFgtgIyWgQ2OPUUzzu6/K5tHkpBGTpMu7LIteF+kEv0+/+Rn3w/1lK9c40hlh1gvVCbT7Lua
	0Zygrx4EV0KBhv9jhDMI6rb7JBt9P94tYV4rUXjrkLd7iOs=
X-Received: by 2002:a05:690e:2455:b0:667:f3d7:eb35 with SMTP id
 956f58d0204a3-66d257691abmr1344105d50.6.1787731435407; Wed, 26 Aug 2026
 01:03:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808121752.2819486-1-lgs201920130244@gmail.com> <626c4fa0-8e7f-4ef5-a027-b6ae2aa36099@kernel.org>
In-Reply-To: <626c4fa0-8e7f-4ef5-a027-b6ae2aa36099@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 26 Aug 2026 16:03:42 +0800
X-Gm-Features: AcwNN1Vol6DpYyKDV-cri24sXXF_Z7PWR_q7g87D7ApkpF8hGkZUW9sBryzNqjI
Message-ID: <CANUHTR8KWSjBgV0QSAeitKKoLL==fMkpmcrZV6Zv-LBYNz-vew@mail.gmail.com>
Subject: Re: [PATCH] drm/exynos: g2d: fix autosuspend cleanup on probe failure
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Peter Griffin <peter.griffin@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Thu, 20 Aug 2026 at 22:49, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 08/08/2026 14:17, Guangshuo Li wrote:
> > g2d_probe() calls pm_runtime_use_autosuspend(), but its failure path
> > does not call the matching pm_runtime_dont_use_autosuspend() before
> > disabling runtime PM.
> >
> > If the autosuspend delay is set to a negative value while autosuspend
> > is enabled, the runtime PM core increments usage_count to prevent
> > runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> > during cleanup, this reference is not dropped and usage_count remains
> > unbalanced.
> >
> > The documentation for pm_runtime_use_autosuspend() also notes that it
> > is important to undo it with pm_runtime_dont_use_autosuspend() at
> > driver exit time, unless runtime PM was initially enabled with
> > devm_pm_runtime_enable().
> >
> > Add the missing pm_runtime_dont_use_autosuspend() call to the probe
> > failure path before disabling runtime PM.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: d7f1642c90ab ("drm/exynos: add G2D driver")
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
