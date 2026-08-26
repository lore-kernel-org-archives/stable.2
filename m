Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405F73AD52A
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731989; cv=pass; b=VqjgzM9sBXB0Ce70Jy2gyUA3rrbRKtjDi5gvkUx31S1END8xG4tGgnODaSuModpfvYcA0DITB4g9wMrL03oFGVYVK5UHNjSP1CSuwV58y3n7EPoa10n/OFOR/3fEWk8bO0QQcTdgfQ4mQhfeTOIlP5jtlOoCOLQnN7+cFY1DKJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731989; c=relaxed/simple;
	bh=DP/2gqU3fyId2g2cAS1ww7m2xwj996soZxme+tkBNoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TykgfbHicpA2CF9XHu3FtNy1S/rE6uOfo4TbTVXLdR9bBK5SVcNQ2HggKGQOv9VewanTKSbN8Fs5WnFx/6kXbzUZsL5nd9XqQY2F4pJjqt6nR/QyLTpDS4/P/0YPscb1tsNrOpDOw7UMe/VfiOeCrOxxJOpOCdsYElKt6UY9Ipg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHOFZ7If; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHOFZ7If"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-66c70d73210so989959d50.0
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 01:13:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787731987; cv=none;
        d=google.com; s=arc-20260327;
        b=Uin/IXOhdTPpdFlKAM6GnH7YstcHzxPrr2j4WqI8fTqSIhbvbnEeN98Eq4qKNgdk/K
         jyThcnG4zKBfITgE0rubQHo7qPfL+8OFJM4M/wXHOtZh1op8LRjLibECy2OFvuWj0QK/
         Mymfe55nMPmlNDRZRIRDXXjOg0kTFqWe/qtShvMqoTo3pft7q399M7IcKHpriS8svvKy
         S7zBwtqrWkYwesMi5t6EkjWBGKdCvmBK2/nFp/j4I/d1bPR4Fy7i/gSPoLpvguih7ZP9
         rjZXHfcpFlcPS6wIyk8DO7LYUoJSOu5rKXYPW85nInSEEoBrCjj27RDdtEsGOIRsBqz2
         IhLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DP/2gqU3fyId2g2cAS1ww7m2xwj996soZxme+tkBNoQ=;
        fh=sSuwkgT9Ht8S95dzhHQTCTReTZWcc2nVPIBsX+kg924=;
        b=TFfOE/IKdMG2ne3K+Y4fgXFqbcjyCdzhX8Z+iSWMU2ch0aqsZaAvXmEsU8B7fDHF1Q
         AWNTAC0UWECU4aTERogg+tG8ogESjgNqhGsfo7Rz3qCP8fS1ja7fFqtIsrEwg8oAXHiv
         Rv3abQwKkVIjgktXZ8hyAY/oCLlmjNt6yddgSZd+DuUebIPyLeb40MICv68dIP7neS+p
         RnC7mzxFi7l9eUHhuvZvDCULK1qD+cwLLbYAdpLgSLCloL3BwCFxJQz0+I7Sy+EDN6Sv
         qy4pkv8vuJYPd0FUV4xt3CdnArWQz7w3qy2tO5t+8dagvzUxH0gr5ljBFbmJuqtfk5j7
         qcrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787731987; x=1788336787; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DP/2gqU3fyId2g2cAS1ww7m2xwj996soZxme+tkBNoQ=;
        b=HHOFZ7IfS6zQdN2e2BwiGcV5yfkupKzSerCPU4d8fmgVrK0ivCb8lwEGYzuT1kZEUT
         meAkg3WnPpsUKbfsU1oygT3g4PgzawlJhIV9YhWcqx9XTj4YciucBZ9YKdp/vX65l/Go
         pJ//sHzh21MJ9j5SDB58drAT87j16rnDw3Rvm0Koe8YAYAlsrkbzG+xZLTnbj4MpSj9r
         wq7ZVf9ygEjtW/jtgvhjXqnEGwtiJqN/5JIdwM8XJ1Z5vtNDwxXDFle78efOPr31sONd
         1LtUBdN415tYqxpH/CrMtpyMzE6OCxcmhupPsNDSHHzRiK2onoyihYUfRJyBKI/MnzHu
         7ojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787731987; x=1788336787;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DP/2gqU3fyId2g2cAS1ww7m2xwj996soZxme+tkBNoQ=;
        b=T6X4zx1PDQlQi8iuJKf9zasITC9tkmohRiEPLU/2H6U2O7eXqZtu0wlbV9WSHWJc2V
         rU0ItE8cX3aUg3PSSs4v7xqDVBB5Oev0igLHFWI0Ray9/C3AasYU9UL0JnPzHtBappYn
         ZgmNScwuDSmrda+othiDGm2f1aQ8RnVailZpgml5zDFurnTXQ2WyNeEPn3qV5shrtYy4
         NUa4hxNew8ie9tac/Lea3le9qfN0izqrPHTSpbKU8cnEGoR5pOnKStrNVB3rR0/LU1gW
         XiXhGAlzvFtPFVKYi6Ski6RQGGSwqpOyAB2MB9rLUE2+tPxRCEWWP8NEMweoeyzfonWa
         e8sg==
X-Forwarded-Encrypted: i=1; AHgh+Rp13XZQ6Ha2Ud8bYhaDIffYJzfHSoh9pGs7lxaClFSh1odYQm1Gdec9tcN92O1w7wDNDicvC/c=@vger.kernel.org
X-Gm-Message-State: AFuF++nWv44QSvvcpvxFQaT0zXyqthf3vuknPK9fd/28IvOia9spQUpZ
	ntFifOykW7SdsAZUR3+WbB/RvidzWKuk0EnKCu1KETM+vEhmTmEXRispmtuxO+P3nGvhqDUg15t
	m/PIbb/AiXdzoi9VKCtmyFyyFO2ZLJpI=
X-Gm-Gg: AR+sD13pKYfQLruxnfz+kZ9b0u0p/AS2rFTQEQarOKZirnRNF2sNLL8T5q9sQH4IL/x
	VOv8v2wEs9pDRArXcu61weB33jI/M0ili4Fw7Uf0PrQ3Cj1u/QMqpkTchi5Il/ORaBXeAqeJaUX
	Yx9ejXD7/eiRwxkfKYXjiySliFcQ0yMZyKSoj8hkS56dyHQ9QqXbIAWxibVjlUnrqgrSo2kFd1P
	QjQ9y25PC8m6w5ArijAlJbPYJyIXCqPZAf9dO9kCaN7jZdwRGjM/UtEpsdX1hh1BImIxbhqk2bh
	1DsQAaHDcS5wvip/8eI8HJPTDmBzzkMNZFYLkPhetIwVQzCj
X-Received: by 2002:a53:c643:0:b0:66c:486c:aa07 with SMTP id
 956f58d0204a3-66d257632b5mr1226829d50.35.1787731987131; Wed, 26 Aug 2026
 01:13:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808142217.2893936-1-lgs201920130244@gmail.com> <400c3d0a-97ca-4c76-909c-0c09d534cd41@kernel.org>
In-Reply-To: <400c3d0a-97ca-4c76-909c-0c09d534cd41@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 26 Aug 2026 16:12:55 +0800
X-Gm-Features: AcwNN1WiakOYjCu3-MZaTlXfcEIIF1SEVa43x_3CROHSyWNzCBcShiqF2n9BY7s
Message-ID: <CANUHTR_Sr49S5JwGE_wzTFed6weW_8MMo8o+20vf=bZE3Xhc-w@mail.gmail.com>
Subject: Re: [PATCH] drm/tegra: gr3d: fix autosuspend cleanup during teardown
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Thierry Reding <thierry.reding@kernel.org>, Mikko Perttunen <mperttunen@nvidia.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jonathan Hunter <jonathanh@nvidia.com>, dri-devel@lists.freedesktop.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Thu, 20 Aug 2026 at 22:50, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 08/08/2026 16:22, Guangshuo Li wrote:
> > gr3d_probe() calls pm_runtime_use_autosuspend(), but gr3d_remove()
> > does not call the matching pm_runtime_dont_use_autosuspend() during
> > teardown.
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
> > Fixes: 62fa0a985e2c ("drm/tegra: Enable runtime PM during probe")
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
