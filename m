Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5811031E840
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789312178; cv=pass; b=mxLgPjKfrB/1Wf7ixliVguJ3/xdWNK++KLOmc0zPPf7u2VY1DWTRmwstlcUI0nc4C3ypo/2HvyJmVgvzMP4EzVT6pu8EO4dmWaAT7CPF4bTkZ4bOAZj2H5Mnb0z7EpgtSjqaKHCoLuNJ6KFGCgO7UjmAeUDyfTqyEfGEKpXynfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789312178; c=relaxed/simple;
	bh=6mFuurljPX4icUeSSuxhnmYjx7ggtb2P7Q8jZv2FjKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gC/t51gWBW7Rts3NwAFb1+kFbo37U56MFtLhuJXc4cRYfG9WHjCS84xDhRE74l3otUaZnzqfT8qKy4Sd9uU8sYaBOGlVir+MiiSTrdefxrOIEkHr1hrHF6+FAcPnHw82AaBxk/Ii/i0KBHHdoz70qfujyFtaWZGhUtl798WAbU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njctwVTo; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njctwVTo"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-399026951a2so349150a91.2
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 08:09:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789312177; cv=none;
        d=google.com; s=arc-20260327;
        b=fpZAwYntPTCbJzs30D4n+5gicQzjSj/C4/vlSJJJTVy0sjZgnzIHSLpzQJCG5OZgOD
         pAutGju9Fw0SXAsLJ0O/FkIAz2C42DY+BKnCnls7Y4RfHKs+GxqzoJL98sVYYv0hEnPO
         7/ot7ofI63kKSB1NDE5oXo84IYJlkeQkOBallhhn5LFu6MG2sv0oUW/RgNNRBqQuWxWB
         MfmHtO7slKGhhgrb2ysGvK/y29uOHfvky1Tcf1FG81E32buHmTc1ZEVgsiJlTMjSTDU/
         qBC/6PTNeXhS3dAuJDEwiqmog1DawlD5Fwdf+IgsVbycvUyHg30Ew/lRmIgRtIaw+EcU
         tXfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MHdelo62IoLAZ62QrJnv/AKdJJRSQm0JYdG8GL2JCRQ=;
        fh=oMxQE66TlEzFyd7h93eBKspaWp1ZOY4ZDz3xE0giAvw=;
        b=fkKtS+lLphwOAmGlsu71+Cl035zPDL6MunMkJ1yDyOS+AjwRZg6EnQccevJyYeEpC2
         4L1XKlPy2cax5av6Q8ncTvMvMxXg3Jy75XH1K3B5G82CvE0qeyzfvByVZrJ1SBifJGS+
         Tf7aFzJmSIjKam8T9sa9SMKoKPhgLRhUfVQ+HVmBSxz6W3+qYgupn+YpZXM83dVPZlFR
         b0ZrZqiNyzhYKiHWUeZjA7wsZ/kaxlo7h6vaun7dXfrdJcC8T4j1/B9AZJ7YoozQShcn
         zFjdHdcPuW0PxyiIRwSPAd1WT7nwGhwJ+MOzYDZI1YRLGIuKZy4j2rpLW6jAKKrsEaow
         jZ7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789312177; x=1789916977; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MHdelo62IoLAZ62QrJnv/AKdJJRSQm0JYdG8GL2JCRQ=;
        b=njctwVToN6941jkzY+EPAlgBHVkYkAvyc1UKsLX7Gpu8We7oWHXABsQXI8ZydEqEpX
         N76rUrNGUHevF5ohCSvKLx3SpZp6ztXdp3bQHJz8y06yjEkYpd02IT+yuM81OCnCEPxT
         PfuV0o+HEVGNeqTeqawGo83DLVwzBuOC+0fILEHLPky5LfDoRNPFAmjC6elPnxqU8vv9
         fIocFluKYR/1JwsgTFY+QuhkLD7d405xBMK3TwRaiDMFzxApbRuMmEfC8FPnyj0Ir7n+
         uiuGG1bZw31zGkOUq3mE9p9zyk3B0ZrJ4GkWxELrwcEBCM+ZMAVEN9qYYiz/osD7wsJB
         hGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789312177; x=1789916977;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MHdelo62IoLAZ62QrJnv/AKdJJRSQm0JYdG8GL2JCRQ=;
        b=rsCJLvADUZV5DxXFXtFSsbLJLsaePvbzbg3dkP0QlDqA9LrckGnCgPu7BKepRxVWmH
         WSuhyFyOh4ejoPy+fMXGXmrLGBKmcV3MzwMPTqYSf4eAGqgHaIlgdB9+vUzOHzc1EQ7W
         QZA69RQAzDkze2vLXZCbmsIMnEw9bTG7LVr4bE0FecS+NhgnHLpjEWimOXrwOXP0vec/
         jbI85Sf2ZmdpOUbkq4JfpUs5Q+vE6G40XD+RrYM0ZWvpBxYhuFgiCZjORty/aISPbp1e
         VPEkcftfb4phLIhwLYPPzbemCf1Alw7rwN8LHwHRn25qVrOfAzADON2oFQeCJ+fRY1aE
         MDwg==
X-Gm-Message-State: AFuF++ltaUSkP+sLxkwCiZoq0BpcJdo+DVOokuvRDkP1R7RuXnjqG/X3
	EOyz4Kf5NcTryH1yorXRX+hTwnWYEUkbK7fml9STnQqkSZpejF5fCGTrqji+XL66Nl2W0Kj14Bg
	lT7Ndlc1hZdHgbObByrKqQZf0I586lqo=
X-Gm-Gg: AYBFou2lnpqGJZaORkONrDD/x6OwgJiJZz8aTOKFLwxNeVrjD5ZfHKr6QTjguZKbS5S
	EsmfZmJKdpiZDy6oCY9lok01uLvu9p2SSOWUgl4fWM0C61vm+jiUeYALhhLTcSaFETsws11yOdi
	p+h/Dhp4KpubTFFHWMDUMa9iDXdOCpJu/Hw4m61Wo6tUfy3T0C/gibBoESGf90Tzb7YXxNUzhtL
	7pFlMZyzl2r0qy3BhyLo1vaoTmLJyYVal3gsJhFW6TjYs0NWjT7Xg/xCilzkI9fqNIrVAVc3gNJ
	w58cGGXg15HMiNV1IaunLCosd+wlX7xp0hdkNlTtRVWsjDwr2STn2EUozMamlsfllOsQ8Tdbjqw
	BVrUGCSb8lCZAvyY2dpmDczxas/RTbkaP0HQBI1lWosEr2RBNeNW5BbwwmNL77RwxaYMSxMz+Yd
	KFnYWvp21R4+osWSXbYVEU/zEu0oPGswTjDGN4ypMrJw0lq4kcFrw=
X-Received: by 2002:a17:90b:5605:b0:390:3936:8760 with SMTP id
 98e67ed59e1d1-39d9b99eb0bmr13862044a91.0.1789312176607; Sun, 13 Sep 2026
 08:09:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260912065516.948645775@linuxfoundation.org> <20260912065531.127040984@linuxfoundation.org>
In-Reply-To: <20260912065531.127040984@linuxfoundation.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 13 Sep 2026 17:09:23 +0200
X-Gm-Features: AcwNN1W7V8fpp-JOiHk7mjvYf6ZP2l5Wo-7SLaXie7gHW4e_0T_-vGqsRI72fQo
Message-ID: <CANiq72m7L0E7kjJA8hS2mzJSCV6CeFNc_+8jtre0hD953js3jQ@mail.gmail.com>
Subject: Re: [PATCH 5.10 611/798] scripts/tags.sh: Prevent binary files
 appearing in cscope.files
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Sergei Litvin <litvindev@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Nicolas Schier <n.schier@fritz.com>, Nicolas Schier <nsc@kernel.org>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 9:59=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 5.10-stable review patch.  If anyone has any objections, please let me kn=
ow.
>
> ------------------
>
> From: Sergei Litvin <litvindev@gmail.com>
>
> [ Upstream commit a9b93c34625a27bed5dc0f80ee2a359ceb955172 ]
>
> When executing the command `make COMPILED_SOURCE=3D1 cscope`, the resulti=
ng
> `cscope.files` file contains filenames with the extensions *.rlib, *.rmet=
a,
> and *.so.
>
> To fix this, modify the regular expression in the `all_compiled_sources()=
`
> function so that only files with the extensions *.h, *.c, *.S, and *.rs a=
re
> accepted.
>
> The issue has been introduced by commit 4f491bb6ea2a ("scripts/tags.sh:
> collect compiled source precisely") which implemented the parsing of
> compiled sources from *.cmd files instead of using the "find" command.
>
> Fixes: 4f491bb6ea2a ("scripts/tags.sh: collect compiled source precisely"=
)
> Signed-off-by: Sergei Litvin <litvindev@gmail.com>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> Tested-by: Nicolas Schier <n.schier@fritz.com>
> Reviewed-by: Nicolas Schier <n.schier@fritz.com>
> Link: https://patch.msgid.link/20260714083331.69482-1-litvindev@gmail.com
> [nsc: cleaned-up commit message line breaks and removed cc trailers]
> Signed-off-by: Nicolas Schier <nsc@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Before 6.1 there was no Rust, so in principle this may not be needed
(at least for the `*.rlib`, `*.rmeta` and the Rust `*.so`s from proc
macros), but it shouldn't hurt.

Cheers,
Miguel
