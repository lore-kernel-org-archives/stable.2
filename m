Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E2E528432
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 17:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790702562; cv=pass; b=oqYE7anwcHZjIRqisDLmu03GA1q+LfXB7n7chHindNdn3H5HGF/k0atOddMCxr0mnmBXTFLXFeJK+EaRfSPLl1Q8cmoBV7EpTgxj4WA4Is5gnF3x+vkRbuVNXuKsBiWA6h8X7gf4ntpiirrBwUxs9wSn4bl0DtDnyJHP3nBwxq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790702562; c=relaxed/simple;
	bh=eXyEWE550+ycqkkgf2Pb87Qz+oDiZBp//OZdYRPDZCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZVI/EYpuR+RYYJbg/mhss9CNncICRugy/6Y1BmZZo58lGSVUVWZkI1O9zOyHsQD/tpBFkbYGztHVwmxL6E6KbujYwp7OVZCWOSv8PEUPrKlVW0I4E+2X03ua94ZuS6wjL8zGvFc7YiD6spg6hNQiJ1DEsfej6HsdWp0WkDLuWUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ON5ZjlVC; arc=pass smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ON5ZjlVC"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b8f490bb27so2187315e87.2
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 10:22:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790702558; cv=none;
        d=google.com; s=arc-20260327;
        b=EHSNv9h8MAdidWxhHt4ykkqbPvZgJW7bVTOFgFmxuj/eccs4D2ES6pCWCEoNH1oM0j
         J4rOGhbC4wsG2XKH/9QyzTGv+mtHAbGzqju/HqoY5JGvXXNINyNa5Lo+0w0wIGcs6TxR
         upOGbXOzyYEByR/R6vXw7I1EYefArISxEA6/bl5fkh2YXflBtDQFSXBbKnv2qjfx5PTG
         ikBztjqIxzdvFkf5ceOT27inTtT/tjClex+p5a/GhLltGREm0R3sLSCvgRjiikg5hIeA
         ebcqhryjQ0i79Djt36+LHVUsK2EaHhoLbxf4PCnkfj43fskH/RLpdq6r5crFtMAjux59
         WOdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wC73nxIKsVnxmirOrWNj6owYWyTLWTGRvdPe/YEwMgs=;
        fh=QWPZAKgWTGgXC0JSSUNxwAhXSKLWwLw1r/xxvhy9z6k=;
        b=Gdgt2XUF5OauSGwTsREWedWgOroQNRfxI3sUFnW5LpaeiGS4Bq3hgMXZCexdxL6usT
         AyT5k1Jkk+uK5ehF8cPLNmoiOHLORxsGdFXUH8L8WGzuHGpeMWuW5VKxU7cMkIZMImPh
         HSOtHQWmD+CvgIhaN/aDH3Po/lJUm377aNL1sh1ZqSM3p7Fx+btfLfKLHN90t3dv+Ovc
         /dg0GNx7aC5SRHtC5WdvrqKs8vTWDURRLBPlXGFocrTN5yofcktjBOUcjPeiLA65NQC+
         PbT7aUYJgNDGthsICFAmZ6+j73vi0uLZFNYHcGCHMqYHyq1KV2jHASuRZIgFe4GyEmqZ
         XZBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790702558; x=1791307358; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wC73nxIKsVnxmirOrWNj6owYWyTLWTGRvdPe/YEwMgs=;
        b=ON5ZjlVCqB/TYA5/JG+HIffUcoeWHrUc2YnR4RgoPO6MuTy4TVUSzDWTA8NW4GRVbl
         nygA/N/lNdMooKu58birVRuuHjv/jD9/SPXvlWO+7UtXhImZzyvHwy+EJPKFUiRsVRSB
         JLHTFE4v5Am8GIq0NyugClwC10zo2hQ6+1lPwpGIoqlbOD0k4KdQHogxTBHGk2fBRGzV
         uztfTA53KoFVgec9MCIRtY2KsluAdRAbUVgvc5evHqe2NQZ5+mZdnD/Uu0Lz+HdW9wmy
         fX4Z62p8IhCk+Ssh/y4zZcujA4e6Uw2u9D6PK0Z0479jvsVv2m1NIinONx4GrcxZTPnu
         IqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790702558; x=1791307358;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wC73nxIKsVnxmirOrWNj6owYWyTLWTGRvdPe/YEwMgs=;
        b=krRPbcVdbxq7nB6VH/GR3lQK0qsGwdt8RAm5O/pEWVmXEmTN6dlXGUd4+QZ9K9zVH4
         MGlXITAa0UTjgHpYL1sW42J5DsZ/xDp9M+WbWR8Jq7qPBvYSb6cTGSVwvDfTfAG16O76
         /mvomlMxn724tFADkiXv2T+3bFhFtmFGE/Y7SdTWZ1y17/fH5W9ni0rMCfr0kq+st4JC
         tUD/FQcfbiZmq+zTu5oG7fv5udB26aHLiiBmbjAK3NptcWxtnw5loJFzqNDdLkZ7wCuq
         L57Hug0dqqD6cUU8/5D95aMHA27BNbwQ7Y/9n+L+YhEPfq+Eoe0yKIeOxYX3V5/PErWE
         RwOw==
X-Forwarded-Encrypted: i=1; AKwUvBzJhDbjK4br/7LDmkj1fPtUB0pIqkg/egI1jv36Z6dYvMtroZsReuEb6gLvqsr2RKd51u2cXEU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJhu9AI3NVscN4vInaNNoQ9VNCH803JXuyxPZHQ3oW/aFWXHSE9
	Ikc19vt/XuhDO8fG4Ax2SQ/1vRysNYGGd2B7H6MgRwc3+6pLLDr5Hjs35ma75bfGKf9s6i66HJv
	s6KIfnRtGCQCMesVED09FyYGan+EYJt0=
X-Gm-Gg: AYBFou3dLWVtFBHirUc5Mzyy/4tBwy1RjZlnVqaDk78WuLss3NoHpgCXpitUQlqXkXn
	J6oH4Zl7OecwkwR89hm8e4tzht6VjeW4Eu0iq9WPVZK0vEStpe8oNj1khBgBV9WkkPnhQvHWt6x
	hBSFbsgUvQMudGRv5JyPQ9B9YJDdo8of6xGM+l21H4/+RAIGVM0WMkMYdAKOWYG0Kx4WDIyikY+
	MnLNLWc7T3w7/zTkpAB1w3D5kB3L1C9oFsFrTiysbvlbyeWaRGLPKE1O30EwT8gcAzMPQOQxs/P
	D6g+Hf7fJ3TvxC4P91yHa2WiQDOsDzllwLv+HJ3d/Tg+l6KzyTpQSORLwZHZMbPeW8+LoBaOc67
	PNbD0TIW1YoFRdOak/CDmQgMCT0MsbvNI+D4QWzyD6wlT
X-Received: by 2002:a05:6512:2348:b0:5b8:edb8:fa41 with SMTP id
 2adb3069b0e04-5ba3beca9cbmr77162e87.46.1790702557344; Tue, 29 Sep 2026
 10:22:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926-tegra194-hda-sdo-v1-1-f7a636a07a58@gmail.com> <aruc3qx7izFQYOhC@orome>
In-Reply-To: <aruc3qx7izFQYOhC@orome>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Tue, 29 Sep 2026 12:22:25 -0500
X-Gm-Features: AclHuK9LkfgEQsoTN_f-0RfKykcFSMYOYJZq1Uw5H4JV_On6s3wU6oygXAoVMzw
Message-ID: <CALHNRZ8RLs6mXkYiZ4qRimmf4WzpWpnJ9racWTPH__Op2Nk8kg@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda/tegra: Re-enable SDO workaround for Tegra194
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Thierry Reding <treding@nvidia.com>, linux-sound@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 6:12=E2=80=AFAM Thierry Reding
<thierry.reding@kernel.org> wrote:
>
> On Sat, Sep 26, 2026 at 02:24:19AM -0500, Aaron Kling via B4 Relay wrote:
> > From: Aaron Kling <webgeek1234@gmail.com>
> >
> > This workaround was originally added for Tegra194, but no longer gets
> > applied for it. Commit 615d43540043 ("ALSA: hda/tegra: fix tegra-hda on
> > tegra30 soc") changed the guard to tegra30-hda, which worked because al=
l
> > affected archs had the fallback compatible. However, commit 7f0ea5acfc1=
9
> > ("arm64: tegra: Use correct compatible string for Tegra194 HDA") remove=
d
> > the fallback compatible for Tegra194, causing this to break.
> >
> > Fixes: 7f0ea5acfc19 ("arm64: tegra: Use correct compatible string for T=
egra194 HDA")
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> > ALSA: hda/tegra: Re-enable SDO workaround for Tegra194
> > ---
> >  sound/hda/controllers/tegra.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
>
> Maybe we should move this out of of_device_is_compatible() conditionals
> and into hda_tegra_soc instead. That would make the checks for this a
> lot more consistent and robust.

I received a notification from Takashi Iwai that this has already been
picked up, but it was only sent to me and not the list. Not sure why.
But looking at -next, it's already there. Not sure if you would want
to have that pulled back for updates or do followups later.

Aaron
