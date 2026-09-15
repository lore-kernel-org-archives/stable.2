Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF673115AE
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 01:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789435473; cv=pass; b=lYRehRuuX5Ss2H6R8K9fTxDjtpuWJnOuTmoPMNWGg+bVoP657nPVJ033TNLuZ37O/+UFrLHLKYiep3Pm/hVNkwosNn24pN193b2UawMA7wAu6NJJj3OqSp1Dc+AnzACe6XCGarVD2daFKa7FFT9ZwvdXD3nsBeCMXjPH41ieUhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789435473; c=relaxed/simple;
	bh=dEdzdraQ8e1FJjlgNNKbv0UpkqZqqFvCuPQNVi2/Eds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eXJBkxNpZAVT96BBjB3jh8JbrCCr5rXdrXnFTuHXvC/ktBNxnUut2NtKX1xPGpp8kxaK0DFA8vYxgqWNFCeBj1rOwdDV54Ts3mo/adf93Dt8iXydE3aw+5SMxUx6zT1D3KrRL87h+UrKUbzcKSuzQ31EiBlV5OmaNDtfNjr33z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+ZaIgDX; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+ZaIgDX"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc4aa02a269so3201632a12.2
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 18:24:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789435471; cv=none;
        d=google.com; s=arc-20260327;
        b=Zayar1mNdImpGuAbDzSrY8f51c6SoTk+Ii3t08aWnUfyex2zPnTLPEtvSVssLIsb/B
         V5V/NCh0ifrb7Q02Oxrb82kbuP+1KetP3OVCd7gm7OVx/VSkYBgRaY6CYUJEH29Owf7I
         3zl6fKJFVlDUWD1TWPttxsVaspP/ihXB+GTohRp7r8hS/eut+7e7QKC9e8U8yKblhK2r
         ZwA7rnJfvT3PQJ3sROSSOXqNR4KMBIvyCZMrAS0/XeIFmULpdJukCP4xJHqt/x/FvmAz
         aqm/+wQehGeKZ5prfLpFXM/N6AkM1FXKHoVQtW0T8bILMm7s/cqB7TXpFiPU/ss3RXVE
         Gyyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nj9AuGJ3R4rBf2c5qZk9ZmLjhMDoMpxuJOp7rXF1jN0=;
        fh=esTr6BHEeAdFLmiqNHqYWp+shV899vMaLw7BB+c9U7s=;
        b=KLuPlEYpKdatQGal94Ift46mhKZaJlVZfey0iv6+aYvTytWfuqPnSAwcZyq0OgLFXE
         4OkJHt2ddm9+a5maTdh0PnYn41m2zJrsRjaMN7UyESiTlKOEhtiozY0qU8OnkRr1nxPj
         dHiZzXOasGPf8xWhQs8ZCXoxsK42Xq5VCthLed7pJnqQjkuQiY0eGrEEQHNusV45SLKU
         99vMA2xqwv63yHYBcL6xXXlx/9Xrl+tyPn+y0zQP7g6gIdXW6G0Rs3eFEzZECkBABXKB
         oAbB6VJ/p9GskNN67Zt4lPfneTp5ruqZJXtb+oRPNZR23Mv+ejjok+ANybCT6His8NQj
         I/Mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789435471; x=1790040271; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nj9AuGJ3R4rBf2c5qZk9ZmLjhMDoMpxuJOp7rXF1jN0=;
        b=H+ZaIgDXR1OOh9z9s7gtWQMr+4hsfPs/nWxz6zdZo9NzeJ1qKzAj5/MNvFqdo97axS
         ALap//yKjSjZ2zVD0bqczCGUBlqFTD11RlME6vWd8YR47dTVVZvbCe/7L8VPg9g/CJ/t
         +JdNbTyl58QN4NPGUVWlJ+IBKwZZHoCVQL9jPogegNIVNK1gk3PD07bHXWVfOK4xBW8R
         YyA4AQvOnGQqV2lvVO+iZM3nXDo9x7diQPGqAGAsYcGrucyANK7+47VQ+K5q33v9Uin7
         iaxkBKhaRW2wVnMMnTBzuTvQgg7Fn0Zj57atv1X9cb0y/y7SE7qVZxEbNUZyXIEmRe5l
         Ajsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789435471; x=1790040271;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nj9AuGJ3R4rBf2c5qZk9ZmLjhMDoMpxuJOp7rXF1jN0=;
        b=1q+UiGJgScmS8mhRc+bvuzlDzpQUZPD9aPEqzYfI9jwfGcOdISjiE7sMMxzg3kIXzN
         /3PeMsxUAhsjduypZqEYt+eqZfgBOZSqhcqYXV2VmA86qZ/cqKlrJd8Z0y/hmlKNWXzp
         DPGgG9gjGnFpSIOU7WOlbwubmP+mZ4zuEw6H/fyMJ6tjmO/ze2JtusDJG4ciKpqCS6+c
         bKSbWvlp7pz0TQiPcDwDXMEKDKghkPyfvD2jmZn8ddG+C4ame9NQbBHZiq5KMuNWRSXq
         dZR18mC2+uwGa12XoCCO2VXiPaJXH72kVGKRv2dJLCvXKi5JQ6JAOHQs9b80kU/eamYP
         6nMQ==
X-Forwarded-Encrypted: i=1; AKwUvBxrSRygAgJCa6ij561IBL78Ap8Bl/3JSwo6SX7ug1n1+BtkydQm1KOqQcP885CqtZXkSDbTKDs=@vger.kernel.org
X-Gm-Message-State: AFuF++nI3vk+BdDdp83TWsR+j9jU72rhX7NkhiDqLD/kI8PFGcYrt19H
	vzlwQ3WQtfpiJps7TpuFUbFuw9uE3LGkk33xX6IX0p5nb/wP4a/eRNDStQgYYfhUYxhyevewAXi
	32JSqgqp8VMG6vNtTQfc77Fq0Eac1vA==
X-Gm-Gg: AYBFou0OKpqpJq2DfG2mumPhQFkx0LYSL2wVM2RiTuT3ntKFR7g+kwKMQp4d18kP+Yu
	TO4AdwUWtyRWRACbG8XJvmsQaN2M6R3GKbtspCmR7NhP6G83I0OzSIOsVgysxgCfEpp3HyKKn5N
	8akhQbjspkcYj4iRdUNSStBNUT9XdLNf0Zl6rIhAWc7QNCz1RuouyZOuXo6bl0n2oLn3/AlOT/m
	L2QGGcI25nooNAVyqGinBkLaTYSm+mfJeAZknBcRNbWJX4f+DrtwCjFCHhNVHpUCLJuDUjCnUM0
	/ami+9wPwsWqh2akhnjjxWmVBgSgI2NK97BU53icU3+ao9rw/RAYHIBssbskFAaHMAA4gPNXMty
	AsrgwX64Qa9pmHgY+iv4KLeUCFza5rY9567vTVEQy7cITGSbz530DUO+w8ue30ORBQ9cC
X-Received: by 2002:a05:6a20:ce4a:b0:3cc:92d9:80cb with SMTP id
 adf61e73a8af0-3db4046c09bmr11645431637.12.1789435471071; Mon, 14 Sep 2026
 18:24:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524155735.13865-1-mhun512@gmail.com> <CAMeQTsYVf_YRyuXx2XpBG822N=nMhnRbKnUNRu8OrsSthzrMrg@mail.gmail.com>
In-Reply-To: <CAMeQTsYVf_YRyuXx2XpBG822N=nMhnRbKnUNRu8OrsSthzrMrg@mail.gmail.com>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Mon, 14 Sep 2026 21:24:14 -0400
X-Gm-Features: AcwNN1XGN3vWYnZMelCtuY0mzPxTvaG2W81_3N9COhlxDNULIMfbhXD5Z_s9EoM
Message-ID: <CAGEsz8E6oZRuLS2kXTw6bnYBCAmg_OvLDrhqXBDUC--qV-5x8Q@mail.gmail.com>
Subject: Re: [PATCH] drm/gma500: clean up modeset on backlight init failure
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Patrik,

Thanks for the feedback. I'll address this and submit v2.

Thanks,
Myeonghun

2026=EB=85=84 6=EC=9B=94 1=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 5:50, Pa=
trik Jakobsson <patrik.r.jakobsson@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=
=EC=84=B1:
>
> On Sun, May 24, 2026 at 5:57=E2=80=AFPM Myeonghun Pak <mhun512@gmail.com>=
 wrote:
> >
> > psb_driver_load() initializes KMS polling before it attempts to
> > initialize backlight support. If gma_backlight_init() fails, the
> > function returns directly and skips psb_driver_unload(), leaving
> > drm_kms_helper_poll_fini() uncalled.
> >
> > Use the existing error path so the partially initialized modeset state
> > is unwound before probe fails.
>
> Hi,
> Yes the existing code is faulty but calling psb_driver_unload() to
> unwind the init could call backlight_device_unregister() on an ERR_PTR
> backlight_device which is guaranteed to fail.
>
> The correct fix would be to convert psb_driver_load() to use devm
> and/or goto unwind pattern.
>
> -Patrik
>
> >
> > This issue was identified during our ongoing static-analysis research w=
hile
> > reviewing kernel code.
> >
> > Fixes: 1f90b1232773 ("drm/gma500: Refactor backlight support (v2)")
> > Cc: stable@vger.kernel.org
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > ---
> >  drivers/gpu/drm/gma500/psb_drv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/=
psb_drv.c
> > index 005ab7f535..7218026fe2 100644
> > --- a/drivers/gpu/drm/gma500/psb_drv.c
> > +++ b/drivers/gpu/drm/gma500/psb_drv.c
> > @@ -406,7 +406,7 @@ static int psb_driver_load(struct drm_device *dev, =
unsigned long flags)
> >         drm_connector_list_iter_end(&conn_iter);
> >
> >         if (ret)
> > -               return ret;
> > +               goto out_err;
> >         psb_intel_opregion_enable_asle(dev);
> >
> >         return devm_add_action_or_reset(dev->dev, psb_device_release, d=
ev);
> > --
> > 2.47.1
> >
