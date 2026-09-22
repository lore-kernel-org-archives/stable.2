Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6860339023F
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 02:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790045837; cv=pass; b=BBevFQm3x8LvWsegYunMD7s3Ezk1AobtPfcUTh8ivyNKx5E2ns4N5LWdEQGfxT4FCdLxhMkboUsZyHgJOIf29+ckJKR/B8ILAh3nlSDsPfXW+gmOYCA+Zl2iMc4v9ZU5VVQArJWTOtDe+yErc9CHxfxQ19XqddC8Shh0Xd5drmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790045837; c=relaxed/simple;
	bh=rSSvhgyRa46p7j/SsA/mJy0NbA+KId9sWY2tpVWSynA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dEyP9T741avBXYE8VBvJEbg0Ya6f2FxtMPVyh4ubM/Q5qJdZ2eyXYDGIDI4CE7hlmzD2tl4miK7ZcaW0KkpUHsEditmRVY6Glg+ijVjLr4CXWqbkIV8kbx8yt4k91qLYdYOyL+CGy63B642QwNBq6f5Nyzn6hPjC9/08DBnXEZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpAjbrQL; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpAjbrQL"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6714595153cso302288d50.0
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 19:57:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790045834; cv=none;
        d=google.com; s=arc-20260327;
        b=GwcieEMGO4E1VrPbWK+rbwk/0lglCZFHfaTyS4b9rhLQrDr1fVes0paMkYnYC3GECT
         dFgMKB80Cr5jC8W5D0kcosGTPHuMz9rVO7ZdHAYI1gY8O7qLEoAraFiMdu7q6dwHelZ6
         PESMhtjjaFsLlxJYZHFezbuhPiLkx6hDGiYolloFRXIBBnllFu0gUiw2viK9JXmkCXaO
         NpN4k+Yw4ZkkEidhCieWe60fIeAct0liops94KPTJs2nyfnqRHGrXpHGRLwq0IlOK5YO
         elJ6X4ucrFGJ3halc6+icr8T984HovLUOGtZA4bITPHqy5xGUwq3nmSu0HBf8REPa5cZ
         xm+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=X2tpzVt+gcVZYhPBgxtL8VLYLcTyyDtnxIRx52+6gIs=;
        fh=MFej4KJq3kufBHdMTq7dDey60HPXO+hXTmfLtQerSxY=;
        b=SVx5CG/33GcCINXauBZOvpLyZm/vBd3+/y/v/gEcmFZ6HL2UEHLSoX7QrpWDlHGhBh
         OZ1NwgAQO6qIPLW3aNA7r9PBHj1Rg7SVtObDRIYGiJ4uF3ohOVobH7BzZiDgVxvxidfX
         4bvz8WqnX67x9rSvOMAPZtd17Q0Q6ZcyeL0q+l3sUUglmoFLx51azEWBtbEBg9eMcG1/
         D9CVBsNZIPP/2m3dMhvupLugUo5ADyXh5LtY7MDwVRYzw1C5vufywPnY8+voTUaTUFJI
         Id8D0mur/FozEv6nhwssxu+S7JNcCDfWypB+6wx6CI6RQT4Ow6FgF/YgcsS/HFW00umO
         Hsqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790045834; x=1790650634; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X2tpzVt+gcVZYhPBgxtL8VLYLcTyyDtnxIRx52+6gIs=;
        b=GpAjbrQLYsRDi9CMshdY8i5LW0w7hYHUuKyEPaP20EppSr9LTcktfvZoQTPcCfY7Ei
         HZyH36RGX3VQS44/ejZd6/yJaWwJj0j4OcaPwc2zMlHJxZl8O8UVwLwLDhTIU6ycMtuH
         EQtYhl/WqjbRnH5wA+EwRfX6j/YmGrHPRb5SyXWPO2JeaAHk1iCHwamhQb4YE9L5XUI9
         iXpFC5jQrbpoR4zXktyv2REmco9XrhmkHRCqNbIOQcCLRc3PLBglojl0BSkK1Oygmr2Y
         Nb6G2WDrfINysnINCDChp0so5s9WskdrJkhysZ5vRQfCX9eUN+OW1N1vSCH0tRfXd8Lr
         iblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790045834; x=1790650634;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=X2tpzVt+gcVZYhPBgxtL8VLYLcTyyDtnxIRx52+6gIs=;
        b=PPhGxy6ZP3bxc+nbW3G7xYbiSfWdoNphWTYDBbA/wMvhOkh/htIv+yV+7WO38gYhu5
         9m9jGQIj31zSUsamaKlh1+0I/jWkwvxUauZgbTjY9af84AGlwUCtz2D0uiARJ7ZrgL44
         WierN2Vk84HMYDz6Oc6DmNT3l+W86+7YKK2+OPMLaMgdR16j28uvUiv25Iu6tEiZUckV
         +6of+wpP7pJODrn+bbQZUhjOohZDDctRFRhzxuIeQtAQxo/sZUGoQc/Z0aAGUDR+7cPU
         /PVZl+P4i5T6+pZAGqeEI/LRnrbid4PrcjZ8jby+25GbyYOoBwRf95I3IjUMdEhP6pjp
         S6vA==
X-Forwarded-Encrypted: i=1; AKwUvBwN8/IEElr7tA+Eoh0DoOWKKQB3iqkqvHwCyLUt3tN5HScjYN3ziWvCd9ltlJGD2sdOw8FAgzE=@vger.kernel.org
X-Gm-Message-State: AFuF++kbU6XFY1K44E05VesTaadE8vjnSN9OHkWJX1UChszlGzyEH3YM
	tgBbkLM836kwGWCM6nzXPFdBh0oYBMhEC1+75ZzIMnP+V0a38slaR0PxVnXk6swP/Ux2IdwbVeY
	/vGls2oKcmF1hWU/MD8MgEG7tUzVZiEI=
X-Gm-Gg: AYBFou3u4lpxpy6Eltc+/lkeuSr2q5k3wMWDlQ68H7gFF5ZYFQ+W0K16AHMN7++VWLy
	vxWjDh2w/EfnG3ExCNKPX40nT8nJZJimrtA2SLVJzqhaFdNxRLYnkBklHE5iVhBb49jhOrdccd/
	qM0JgM+HhfS8HeE/O++1OU1z0j53+vifpqjKdomOnamdheXSf70da4UGv5Q/CL7S20hYCV1p+Uj
	LvrGWLSlLZLC/kBy6AamFcJJZYxmUcyIj7rTt3WRBam/qIJCpEkKiwpNWCkdEootplNY8tuvD0F
	h3toI/1vzfrAP1LtNinup311udx+V6BLfcRH8nTW9nTvTXB/d+QGdWxc5rcGb0PzA+Ea
X-Received: by 2002:a53:ac86:0:b0:66f:c1bc:4068 with SMTP id
 956f58d0204a3-672c2be0931mr690482d50.48.1790045834182; Mon, 21 Sep 2026
 19:57:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920055519.3778269-1-lgs201920130244@gmail.com> <arFJIWgBN0HXl7WQ@quoll>
In-Reply-To: <arFJIWgBN0HXl7WQ@quoll>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 22 Sep 2026 10:57:00 +0800
X-Gm-Features: AcwNN1UbNyIyaIfw0nu4iX2Mqyv044MNcCqL0yukCBjNBRqHXUMBStARMmaPZTw
Message-ID: <CANUHTR8btEz8LVtyepZQscY6JMuMP=TqXsm62UWErTPGrdNOCg@mail.gmail.com>
Subject: Re: [PATCH] EDAC/versalnet: fix memory leak on device registration failure
To: krzk@kernel.org
Cc: Tony Luck <tony.luck@intel.com>, Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

Thank you for your feedback.

On Mon, 21 Sept 2026 at 23:11, <krzk@kernel.org> wrote:
>
>
> On Sun, 20 Sep 2026 13:55:19 +0800, Guangshuo Li wrote:
> > init_one_mc() allocates dev with kzalloc() and registers it with
> > device_register(). If device_register() fails, the device has already
> > been initialized and holds its initial device reference.
> >
> > The current error path eventually frees dev directly with kfree().
> > This bypasses the device release path and can leak driver-core
> > resources associated with the initialized device. The existing
> > versal_edac_release() callback is responsible for freeing dev once the
> > device reference reaches zero.
> >
> > Call put_device() when device_register() fails so the initialized
> > device reference is dropped and versal_edac_release() performs the
> > proper cleanup. Return after freeing mci to avoid falling through to
> > the direct kfree() path, which remains necessary for failures that
> > occur before device_register() is called.
> >
> > The issue was identified by a static analysis tool I developed and
> > confirmed by manual review.
> >
> > Fixes: d5fe2fec6c40 ("EDAC: Add a driver for the AMD Versal NET DDR controller")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/edac/versalnet_edac.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
>
>
> You sent multiple independent patches, to multiple independent
> subsystems. The amount of these patches clearly suggest this was
> AI generated and most likely not tested.
>
> More importantly, you sent all this work without properly organizing
> relevant patches into patchsets. This makes reviewing difficult
> and might cause multiple reviewers to address the same issue.
> Replying to the entire set is impossible and requires handling each
> patch independently, instead of applying or discarding the set.
> Maintainers also won't see the bigger picture of your work. Quite
> worrying.
>
> This is on the verge of hostile patch: bomb us with so many
> contributions, we won't be able to handle them in efficient manner,
> like responding ONCE to ask you to slow down.  Considering all this
> is untested and LLM generated, I have even more doubts whether this
> should be considered for review.
>
> Please read kernel documentation BEFORE posting more work. It will
> explain you how to identify subsystems, how to organize your work per
> subsystem, how to document usage of LLM and how what you should not
> do if this was posted in a good faith.
>
> Best regards,
> Krzysztof
>
>
>

I would like to clarify that these patches were manually reviewed and
audited by us; they were not simply generated and submitted by an LLM.
However, I understand why the recent submission pattern may have given
that impression. We sent too many patches in a short period of time,
and we also failed to respond to some discussions in a timely manner,
which made the situation look worse.

Many of the recent patches, especially the v2 revisions, are
corrections and improvements based on previous review feedback rather
than completely new untested changes. That said, we recognize that the
way we submitted them increased the burden on maintainers and
reviewers.

We apologize for the pressure this caused to the community. We will be
more careful about organizing patches by subsystem, preparing proper
patchsets, and following the kernel contribution guidelines before
sending future work.

Thank you again for pointing this out.

Best regards,
Guangshuo
