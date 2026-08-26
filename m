Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDB73A7F69
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787732073; cv=pass; b=BdWCzwgt6DqnbICoC3bHqEaZZSDXs2dkYylaoW2XZslxjtB/TZsD5T3DAE5/vuqkVqmWnYeKNaYzJq47whIkDu8P8YxMw+uTgzOAdA1agKiDMtRaO67RPx/thty192BVg6F5iPx6cwCDaKv/kF4kqXvfMXkoE/xZ7/OCWtHI2UU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787732073; c=relaxed/simple;
	bh=R9amIzEFA8q5uB6W0hUHTDML7nWF8S2I9fUZICwpgSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NIgZKbDFhZWXYV2RGizmxpdMHnZlQuGLK8272P4X66Oj5DReErl/jFT4Z2Pp9XpcIl3SLCiL/H7y3qmTjJKSVXSXuw1i59L97/x0fGVBAeanZRkRvc46jjpmSplh3Ylh12ncMSwBxT3EHoo1tJUzh6jYExne3tGRWC6roL0QWrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAU8Xm7l; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAU8Xm7l"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-66c7127a73dso884723d50.2
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 01:14:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787732071; cv=none;
        d=google.com; s=arc-20260327;
        b=ni1AHbzgsRj21i+J1UR4LEx1ileyJEXTBqdU1EgaKJCd+RXl4d04LbuMSSDOp8+klG
         ehGP8hfIujASd2/c+Ry5pyE6pkHQzZBhPRovV/8+Um/F6Z5c8zEjM9e604G+/IZCoiQK
         lg1K2BPgxHsI+OTubYOlENMKRLgmP7CuXnT96XDeAARWHivll9jIVGwUWhNqeNkgh2NE
         a0iPuhrv298iUeRkECbjdbMB70okkE/5KznYxw9fY+Q2KZUpaL9i5nH6tb72drHD9Y0s
         yOYskK8Dbua9+gOu1alddKFIa1lbw7hm8Lv8/Ktp3V6a8wZGrU2S64G7r6brmqqGk4ST
         yxHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=R9amIzEFA8q5uB6W0hUHTDML7nWF8S2I9fUZICwpgSY=;
        fh=0CEfckM5JTwSa9nm+SBQ7pBHLUO8JOMR+Wpx398bJjo=;
        b=AYWzoSOFuDJIs5Xm/eLfrLBZBdYUzC3Ri97jcXuKT/QOnLqYalZgY8XOx1gyii63PJ
         h+XLcN7EhzNJE/wM5RS48NNtNG91CDIEF1d3rgUSNf5lNcnGIaHPkn4Y360aHe2D1JmG
         fR4c0jsZNNrGNEPcc/B8xVbPQZl75Onwci5LpIOhm6KpEc/E2gKkd7vU3kyc3I2pOxTp
         BRlpZOxVB7tZuok/kmvOTOOPJoFZNAsi5hRgTo7B/IPPtaVmElY3xR5xFVWEMk5Fj1n6
         ANEcOMZWvV2d4W1heHciMTR1h10e5eKyEh/D1ffZILlIa/2umNojHw1M7NMLZ8gVMvm0
         o9NA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787732071; x=1788336871; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R9amIzEFA8q5uB6W0hUHTDML7nWF8S2I9fUZICwpgSY=;
        b=CAU8Xm7lzdq1b1qO40sGEQasOMuOPt91pJDd62FxN3OIyDJXcmmUbpIqvRrC4QUuGn
         qpHtR1B2GKXZSckfzUt6vVW62uHCDOiWhJYzqkkZfmE+dyeGYdDSRNqa4LSzULwKgDIW
         pOMwN0VGK4ZNzUemiU9wI+5Y/6N9niw6Lp/r08lgrm6jiY4/2YdVAmBfkA1bcFUMXPna
         kiHzsiJjblwHgLoxzVWQSk6oVBrguHCoE2Sv/tnoR3LyaLyyatub1zPUGFcjvpmT1N/B
         11ihuug8+FLdBTQOpmv2oUvMTU/HXCohtBzpFEINpxiJOJ3Ym6DdftmfGJqXMY78JOyg
         XdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787732071; x=1788336871;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R9amIzEFA8q5uB6W0hUHTDML7nWF8S2I9fUZICwpgSY=;
        b=RVom4TGoO7LbC9E9jUsrNHyvUFFMX/habXOV0pskWgpBZxl5Z9fe8T1po7BrUHRYSV
         gjQ/9uCoRLyDHZmi095ZElOhBbVxIp1vmexyVPsGU1U1G2ZZCPBCHQU8OqkPioSKG0IA
         pMyu1V1TDAJnqeipN4uuSTVXfvvTYlvt+toEWP+bi+D99jcWUGXLMdp+d01Gb8c2ysq6
         99SHU8BKFB+yZpod8XrH/7ZV6xiPF8hjju34qKh2VQMWHswJLya1G89RO/Ceo+cfq7aa
         lotIc5KEH6L13e6cuD3qEXIHRkN+kGGmou4JzvxA8Jl7IdqJx8gkh7IOKHBQLKX/Mit5
         rEHw==
X-Forwarded-Encrypted: i=1; AHgh+RoM3XWEz2YxD3TmLdHuzhCru9cVAUQ8cm9Qj0OqzifF845N4qyLZRYmVB5f8VMRuCBwNBks62I=@vger.kernel.org
X-Gm-Message-State: AFuF++linvo1VetHw2JxVYeV/NttrfO0K8jAE7VbQzsm2NkODlVLiHx5
	NVglVesuwqDhZxsbcPYHptJOuGgOafgQL7yT5jh7NsRRaKAVNiE/9L/ZOBgAOUE4hLazVeqyI9t
	WcXiGSVZwz3ouAnnJTl1G5k1ZyfB0hnk=
X-Gm-Gg: AR+sD11SIRKl/6xDarUqbzgVYvZr8eEtJU6417E5ovW0vTXGMiCEJlrz5MnF/IpcYFp
	eTUw4gtG1YYrQduDcgZMfAmkhWOGs5NcR2IwDLD+ugZYwDw4QAu4bsKdt0iAqsapRq1zY7uvTYN
	tDjqjrRGVu1Y7xDUOdz4ROijjVDpxI6RROpYdbOEV742YHh1EFKe9PPC+8SZf4S7BAZhJmBU4Z3
	KJ/OgMo/7IOYRJgTKbZ2YZ/QVnncHjU4yYXHHMHfv5yN046bJC0ekPJkgBzEvQxZeckRIVgdXCF
	UxtKMPVw/oFj5L4oHDbJ7x++S8fvJcx2EkJhRZHCJaTCW9Y=
X-Received: by 2002:a05:690e:e8a:b0:66c:d6f6:eaef with SMTP id
 956f58d0204a3-66d25694eeamr1750611d50.18.1787732071154; Wed, 26 Aug 2026
 01:14:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812094425.3515179-1-lgs201920130244@gmail.com> <327de6a8-6c67-4328-83a2-bfea332aba7c@kernel.org>
In-Reply-To: <327de6a8-6c67-4328-83a2-bfea332aba7c@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 26 Aug 2026 16:14:19 +0800
X-Gm-Features: AcwNN1WbmUut-7AuuFCqwoZdX5jzcjMrvGCq4xDXrennGXYAL0ALsEP7Epy-Qzg
Message-ID: <CANUHTR9+a8OYmsezZFWMvm+a7DQ980sjiVOjynyjv3ChyPSTLg@mail.gmail.com>
Subject: Re: [PATCH] i2c: qcom-cci: fix autosuspend cleanup
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>, Robert Foss <rfoss@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Todor Tomov <todor.too@gmail.com>, 
	Wolfram Sang <wsa@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Thu, 20 Aug 2026 at 22:01, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 12/08/2026 11:44, Guangshuo Li wrote:
> > cci_probe() calls pm_runtime_use_autosuspend(), but the remove path
> > does not call the matching pm_runtime_dont_use_autosuspend() before
> > disabling runtime PM.
> >
> > If the autosuspend delay is set to a negative value while autosuspend
> > is enabled, the runtime PM core increments usage_count to prevent
> > runtime suspend. Without undoing the autosuspend setting during
> > teardown, this reference is not dropped and usage_count remains
> > unbalanced.
> >
> > Use devm_pm_runtime_set_active_enabled() to manage the runtime PM
> > state. Its managed cleanup disables autosuspend and runtime PM and
> > restores the suspended state on probe failure and driver removal.
> > Remove the now redundant manual runtime PM cleanup.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: e517526195de ("i2c: Add Qualcomm CCI I2C driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
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
