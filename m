Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CBC3815CF
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787732002; cv=pass; b=cwJZzaUxcQCpIFN7dpnNeJ9/k+F6MAIf7ByG0xJYcPI4oTBqSp70nfnOM+PYYD9rMLuIa6/buQyzY1LD5dekVa11posVTKAHrVP+rUnQGZUKirBzgHxSWcsai+7SaESKggOYavGpjQQwtcrWANY6R04dQ0G0JpDNrWxCqfYbgMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787732002; c=relaxed/simple;
	bh=kck+Ig5YyZCjZzHtHO6ZDi0MVEFY6EL3ocVztwAac4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F8V4N69Knjjg/369gq8nuQG8SU/5dHKI4Ds6c3CDX86VlECggU0YDVWbz5B2GBsCv0MQQZ/j8/Wuyyw78Y4L7uPh8/PfGgbmrSEZNpy/evua/hAf0jGdqtXRuyfokBh+iFvQZcnlJy+ADJZ1frbMvGwJTBV7GaSefNFhtnej3wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZYVZ1zR; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZYVZ1zR"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66c70f05859so1115604d50.1
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 01:13:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787732000; cv=none;
        d=google.com; s=arc-20260327;
        b=MjEDwaOnnT9Sm7Y85jlmm4O4yWBfFrAH/BxjQVYGbpMv2yMC57nsgsFt+x3A1fbhev
         ydSp0uzroi7Nx15WfMB0hSuhjDA5Kjnt7FqM2bUjbWY67V+MB+SOaTzsJta7BPe8/nlU
         CwJQVEWcPB+ssP4010LLtNDJLewOAoW7U10JAJy1zvQWPpfBBpH+czSUuPjaAA4RgSGE
         E1MIGMbnVtGUMb/oOKSsQ+UeM5v2S5U1R5+jp3H8cG1Qg0UfpIwFeWcDnOEcBs3wlczF
         X8/l4+TvyuiUm6iRk/6uie02OerlvqSBI/D5jG4MPn+9xzC6FiAGv69iSCuo6ZjltAmE
         i1gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kck+Ig5YyZCjZzHtHO6ZDi0MVEFY6EL3ocVztwAac4Q=;
        fh=bLsQ7fSH14mU2Qy8Du+zSQjHn7rQTKtLx89bWA8Mg4Q=;
        b=Wbw1u9tikafMo2LnVkGMq+GxUNHGu0e4Byn/Vc5MpnJriQgwXhOJj28KoWwA+SoCJ6
         nAT6oSfgqC5RI+swufP4RmpWzo5vMnZi+UcLkDrHQHz+a/e6PTqA3x4T4lXS9vMkfm+z
         zAfFA6KhQ5sB2lgl2ucUzb7MwOoVYCriadrxHGYJPs17vCTDEcAEl9bpnX2L/vEuhAtL
         lsVNPjQkuVb4wWUtuaMknUExvcuz1LNvgFg4029g/+UsKsh579JrV1uwvi8dFgXFQu2m
         ygu0HjFvmaRlkiEL03McxxipvjBoG48EP6NRiqCh444Jye98qN5HOLY6aFF0j/nwWo8X
         DzKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787732000; x=1788336800; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kck+Ig5YyZCjZzHtHO6ZDi0MVEFY6EL3ocVztwAac4Q=;
        b=cZYVZ1zRUDsKML6dMLMXnGJg9GRRBmaOK1T0OAQYuW3Ljr7JSamKFzJ+8isPYBE8Oa
         D/j+htkDMQeNCHmrnOJ2zwyXZw4jyGKUL9XmP1FohXS3xuesgXODCPlBlcspdt4Kw+/n
         5IqR/R2cIJ9GLavAkCUlF4V5Vk/pkm6FeVkjM6KVjbVdAUGRDHjBNOB8vHzHx5Egw7xD
         4ASF+1pPReh+zbvlE4xrDX3iFJH6lIwUeqhSQEfrcclvZLAAxJqAIaiba64bWwOegJ0M
         EYBOhGClHkZBpwvpIL2q6WKEutFOQ3dN+dUibXXqijR6kbpazoxrWZq6uFV35/QLgImJ
         jTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787732000; x=1788336800;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kck+Ig5YyZCjZzHtHO6ZDi0MVEFY6EL3ocVztwAac4Q=;
        b=oNCORv6kprnraD4/HWjxJVK+lO4NGI/qjG+XSdTbX3zzcP9dBlCkI5LrIVUXabP5hI
         ylbJMWyWH++1lhHCoSP2ICx6Ta7hjdRuh/9ggBjwNU+zDmxArLqEnZSnfTzf8c3QTPCN
         X3H43fr347CH/Q55+jqGfXeVG0TCo4MV8o3ae7CbTDpYS6MzurkGsfH19pmMPC0yYUm5
         BxNwBxOmwAYAjwvOy6dDaaj0oZL61TLLT3NlLCb7hwbJMGHy7wx9n269OJzYfNuOWgSW
         dJ2vc9b1lV5tQ4xoKvmgnn2PqX5mZKs8YqtIbX3huu6GzVhFdkcCD0WnTit5oNdV9o7f
         dHiQ==
X-Forwarded-Encrypted: i=1; AHgh+RqkMVaYsM+SG4/7pvTfe1ZlJXlbVERfsLWOXs1yOykapqJ74yZs3J7YVIE1wwbtANWnoNIGt9s=@vger.kernel.org
X-Gm-Message-State: AFuF++mh4Iumn6L37clZ4h0lRawpKJC/iiTPQtrAzPdJ9aqLsefbwup6
	4Dnd7NcZHO+yFu8X3jDFwI1gs+8Dlsddap0bThPJGe+EJYSIhmfGLivL/nIwlXVYRP7PSMBpzJL
	3p7kK/6owTBhOWQ7mkgsFTHANsAqqJZc=
X-Gm-Gg: AR+sD12QTQNrhXz7KPKMWiJU02qC8aKgGvWEoUAnH4gI90in6Sp8oOsqDL16nBqhQJf
	8JnKbOx0BpOMGbXx4UOpw7BdxMCB/yN+ecN30lV5RzFucm9/6SpwmHXg1UuOXSQnGSNVmQNKRQW
	+2j94Z4k69OOFqLqQyDAjcWwZJZ/+tftbbITzdkMJLF/RX5szMNdHz+gpFQ44/+GLZlYjcny/Ym
	rZBYNAgR3LiwnjNUrFEvdMzWpt0I6OJNgK9xH4OrAzUKwZFKuuAJgtLlRGygHvPwgLrxtNi11hs
	d3nVtopWI12Nbcqny2o+k97fposecugdtZ0OUjgGR4SPU2g=
X-Received: by 2002:a05:690e:249b:b0:66c:e866:c4cf with SMTP id
 956f58d0204a3-66d257afd3cmr1372322d50.31.1787732000271; Wed, 26 Aug 2026
 01:13:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808125953.2842241-1-lgs201920130244@gmail.com> <5174855b-fe2f-4a6f-8390-959e9d624cf1@kernel.org>
In-Reply-To: <5174855b-fe2f-4a6f-8390-959e9d624cf1@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 26 Aug 2026 16:13:07 +0800
X-Gm-Features: AcwNN1U3dbQoVXJ8NkGWFYebcVrAhiWh0QN8QowH-mZ_7LABkMoZbkQnxy1lirs
Message-ID: <CANUHTR8c2+LPRWOPwD=_dG8WqFyuTCg++BZFQ37gzgoEKh-hnA@mail.gmail.com>
Subject: Re: [PATCH] drm/lima: fix autosuspend cleanup during teardown
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Qiang Yu <yuq825@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Vasily Khoruzhick <anarsoul@gmail.com>, dri-devel@lists.freedesktop.org, 
	lima@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Thu, 20 Aug 2026 at 22:50, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 08/08/2026 14:59, Guangshuo Li wrote:
> > lima_pdev_probe() calls pm_runtime_use_autosuspend(), but its failure
> > path does not call the matching pm_runtime_dont_use_autosuspend()
> > before disabling runtime PM. The remove path has the same issue.
> >
> > In particular, lima_pdev_remove() explicitly sets the autosuspend
> > delay to -1 while autosuspend is still enabled. A negative autosuspend
> > delay can increase usage_count to prevent runtime suspend. Without
> > calling pm_runtime_dont_use_autosuspend(), this reference is not
> > dropped before runtime PM is disabled, leaving usage_count unbalanced.
> >
> > The documentation for pm_runtime_use_autosuspend() also notes that it
> > is important to undo it with pm_runtime_dont_use_autosuspend() at
> > driver exit time, unless runtime PM was initially enabled with
> > devm_pm_runtime_enable().
> >
> > Add the missing pm_runtime_dont_use_autosuspend() calls to the probe
> > failure and remove paths.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: 50de2e9ebbc0 ("drm/lima: enable runtime pm")
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
