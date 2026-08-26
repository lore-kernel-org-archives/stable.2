Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F27C3B71C5
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731866; cv=pass; b=mn3qYbR6feLiYCrZ+Y+/YOYdGxH8siKP7dv5NI3jK9cbm7ZS5og1u5eiqo24uBQONRyQzYfyVz4lMR+qnCq7z5wMHu+1gHbPnvrCZ1E9vFpIj9YORpW9OtozcwAtEaVqs7M/DwdfMzsoravifrLnOF8tOJRtfR5BRgewPh7X8ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731866; c=relaxed/simple;
	bh=5yyh1VvWI+vaETl8iuGoTVN8P021SyOBwMiKg7S/KSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KjO9IWTyiLGPRsFYlwN5y95+E1OZJbL3aAe/n5rEuirNxT6rrJ3jbOv/gSdD8QhaK+so3IT4YFYUZxWIPloLMSDbpw5Si2RcjnK3X/5X5YZ22mA1SetGN74cy2z83srYTFCtnRlyFx6lZPvgCXgj6HSVsEDoZcZJHIsINt9Ml4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lr+vgW92; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lr+vgW92"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66d1447e2b1so943229d50.0
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 01:11:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787731864; cv=none;
        d=google.com; s=arc-20260327;
        b=jVR/s2wHefwyGRTk8gsnIS7f5ksorrEPDlXN6ncFfZ6z59WmGgP0rBQq2ALumrWG37
         bI54hNep9Ww1KfqWJZzehZ7GSfaMU63I+IfXrnGipLkTa8DBHE+dcw5rYlpH528yhDu4
         pHadAWvrL3vh4gQVbcEaSKg9uMH7n5sBtQVIz90QDtwY7KU/jC1hnDByinKXd5QQmXXX
         s9pKDpmUg/2jS/aWEzn/Quya52k+AiQJWiLzlN53zQwu/TO7eh2AqJc9DMbX1ktVoOTi
         uVjBE+cNYih0/gn/YwkwjGoy7tQRLjxZZFpjFPiURuq4+RwHAInyxjELIFpDnBpQ9WJH
         llEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5yyh1VvWI+vaETl8iuGoTVN8P021SyOBwMiKg7S/KSA=;
        fh=yBpDoncGX6Efj61K00n0U7UF6P226vSeTQy8PLwsHIs=;
        b=bWKWD3Nw5vF2SLI97jRq9PtqRid4tk3z0zRpuhnydLP/ux+1ClkrvoKmGYLL5aJLPM
         8F/d6Qb0o50tm14e/LxmKxz03rl9/1DYsHJXnN2hRA+EQ4yarjgH1A/9m6gwuYur2nEm
         9s6YxzCr2chbY1zcIyLmPezGpF5qQt7QpKUAqR5ypWFohaP9MnIYuEoK+AjzMar0196f
         80AfQOoVMl2ZIOgGl7eqbw3+ctHdiOTYDRCu7Grv1YyjZBPUxpZwqfTPb8CRB/ZCI7bC
         bzIy6m0sT50GjCMLMs0Fu7kYurY4i7X+P4jlWVTrW7+H/uim3DAhWZN3QsZJDSHrICo5
         7wfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787731864; x=1788336664; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5yyh1VvWI+vaETl8iuGoTVN8P021SyOBwMiKg7S/KSA=;
        b=Lr+vgW92ye+oaEzoXzTK8hlpJBNdB1DBQSZTpTpbEMXzPkyUlCY9z0QWXr1rr1H+91
         pyp+5UmX0PHS1vNABd/h5efHbnjiUutDJUOdPLZn4Qi7nUotv59zYK7ZrY9BQqHm/5Bb
         pEL9gEFCvKHoRyCtn1KHWg2qVq/TUrty35g37F9MiWJaR1hEo0FnTMHcFIehu4kogCLD
         zisWIwVVUoZ/paXB+Zqa2WN4fJrYJTtI4NwR8amTFSYLdv+S3/6v2nFgd7/qOOhUwCR1
         Zi+B7r9f8nzmdEzQBUa80jYWEVVe6p65qFhRCUFKMKI9h2ubdMJml7gd6GG+zz3FxVf5
         Qr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787731864; x=1788336664;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5yyh1VvWI+vaETl8iuGoTVN8P021SyOBwMiKg7S/KSA=;
        b=OWG8JTtNCoHApbCzPQV8GLYKbH9B63foYoSZ6FSvvrWMzsggb4AkVO6V+m8Ne2P0Xo
         mk52aF/p1d6zfn6vNzPbBADpekzsOmSGCNDt44qOl5LwChPfexdUx4azYBj9khYkoqbX
         ouWnUK0B4joBLG9dIrNHOh1PEiuy3IDMYGs9126GaIeErjSmnFMNpilOPtQ6bw6/xnOW
         osn9142D3OuzddBCMcxkBpmO/ajJqxv2v2K5BqDtBmkPmWwjKdvNOIHphLhZg7t7B1P/
         v1IuX3qOQZSPv99xxxMEGOe6LEiRu+blLxSeSArM4FIkXARAi40SCcPUyxWcIwGFOZ6C
         H4iA==
X-Forwarded-Encrypted: i=1; AHgh+RqF0MExZPgDQU+oVGsIPxHNFUuehInUhZXo0/x8HY94PAoQ0W4/SpV01Hoqk+fYeVPbyWYUXxo=@vger.kernel.org
X-Gm-Message-State: AFuF++kn0XWb/zSfyX3wnUdhpA7LY/RbkGr/oDWuricO4gQ8I6l+0dg6
	e1OP2VKNFvdt7pM3LXT+ARzAb0GSl2YbFvnxRcuXZi16Fp5UsjQ6PpdRhEJExfl6sIUEY2empFB
	EMJQEYqRMVAjqAB2vkcdF0RQqdh2w5HM=
X-Gm-Gg: AR+sD12007RRg29AwZtQYSWxCsN7AHWQGo8tn+Xm/vSn7mDzXDJgoJ5+3AwNtOwCbhz
	GwehrlT/3i9GfDkm3mhizrywPxf2gLSpRt1XAOxLvtGTF08/ur6mePyMPD/rnd6elGBofV+S7XJ
	yLas2bhRnEN0p0I1EccaVBj8y6go29vGuw4CFqFqTLxc6V62EUnb4NFWuwIrb1WO2fRtBxQo4tn
	li2NiEHPklo43Kry2r3ja7sbrTDl2YNbjiek/lJIUeXv4jVVykCixT9H8HXQFMSqFMnb4bPlMyc
	hyIzPiKwBJtm6hxEHmWVSi2WRjnBXQx1KnlgTM3naXZk7Pk=
X-Received: by 2002:a05:690e:214f:b0:66a:b15e:bb93 with SMTP id
 956f58d0204a3-66d25197bf4mr1276551d50.13.1787731863957; Wed, 26 Aug 2026
 01:11:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808131624.2854412-1-lgs201920130244@gmail.com>
 <e5964398-cc23-440c-8c69-01353b5a5ecc@oss.qualcomm.com> <d85c9ffc-d9a4-4f33-bd63-5cb7a505a840@kernel.org>
In-Reply-To: <d85c9ffc-d9a4-4f33-bd63-5cb7a505a840@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 26 Aug 2026 16:10:51 +0800
X-Gm-Features: AcwNN1X9rQBObyVrmy9DFrGufRcw2p9RUUYyy3KtMY7rqaV5_V0d3WC11PgO3Yo
Message-ID: <CANUHTR8sA2xbXsex1VQu2acL2kZyCHAK6xQk1EKA_Hxv4n12rQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/adreno: fix autosuspend cleanup during teardown
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Jessica Zhang <jesszhan0024@gmail.com>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Mon, 24 Aug 2026 at 14:17, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 18/08/2026 12:40, Konrad Dybcio wrote:
> > On 8/8/26 3:16 PM, Guangshuo Li wrote:
> >> adreno_gpu_init() calls pm_runtime_use_autosuspend(), but
> >> adreno_gpu_cleanup() does not call the matching
> >> pm_runtime_dont_use_autosuspend() during teardown.
> >>
> >> If the autosuspend delay is set to a negative value while autosuspend
> >> is enabled, the runtime PM core increments usage_count to prevent
> >> runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> >> during teardown, this reference is not dropped and usage_count remains
> >> unbalanced.
> >>
> >> The documentation for pm_runtime_use_autosuspend() also notes that it
> >> is important to undo it with pm_runtime_dont_use_autosuspend() at
> >> driver exit time, unless runtime PM was initially enabled with
> >> devm_pm_runtime_enable().
> >>
> >> Add the missing pm_runtime_dont_use_autosuspend() call to
> >> adreno_gpu_cleanup().
> >>
> >> This issue was found by manual code inspection.
> >>
> >> Fixes: eeb754746b14 ("drm/msm/gpu: use pm-runtime")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> >> ---
> >
> > I think we can use devm_pm_runtime_enable() instead, which will take
> > care of cleaning up both the autosuspend and runpm halves
> >
>
> Author here is unresponsive, he was told a few times to send corrections
> for his vast amount of unthreaded patches and there is zero reaction.
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
