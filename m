Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098DF389443
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307439; cv=pass; b=O00hTSNZ+6nx8Un2HHHbS4eyBnm0ciykB00/X0pdoQfeHxkdoWKL7BRGE4eDB5LuCpyVGPxFC7BCqzXr51FblEs37X8bFWrBgEBiLHQH0adHR0Y20aF9KfJECcY8UPWsORSNSoE7P2cNX9E498LePfIcxm4rWyzSMz0T244jFho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307439; c=relaxed/simple;
	bh=2NIifJXnxGcW/TsykhsW0xZPyCcMtk1yL/ByEDsw35w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j1sQlgKroPlWWM3A+q4cyk6QSA8SG84A56G7f4OnE/2zP6V1C0UKiDgUx1NRNwYUVhFfkPvpkY4yUA4RLUaPAHkcQgizdshNxw/oX3AzI+YAH9rQj/MeZ5NV66jwvjsVWfgD1bL4SwuWCFxAME6PpHFnvKHCJGTHvYjv/A/8Dhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6pTiXx4; arc=pass smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6pTiXx4"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e6b5c374e5so1083662a34.0
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 02:50:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780307428; cv=none;
        d=google.com; s=arc-20240605;
        b=B9E241c/1ySpxWY49LgeelkOzkhNDKTJj4F2MqjNUvw8AN3QSWNPpFaby/Yi9cAmXD
         9zEry9F8Afzi0zsWbHIOm9IcML0l2cpfQ2JbWQ9JKgz4KlRBbm7CNpELvQhoPKdIGtXT
         I8jIDFrDms1Em4cnBTWGtuX7ks8D+gzQHIQMIuF6ST8LDzrdfmiDCynWgcVCH239FgIX
         QdKCSqoWy211zyNG+UkKmUxywUAVZh4F1Y6z5PlZOwix68S3BXaWjy6DrK9XlOzx0XIp
         8HyJTdswEEWRiEYv/QsNOV2dwuocxnk4BFuWko/cRbbNG4rccQJdYeftFejneqly1yDb
         lnTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bnswxpP7ou+7v1EMFzriHdHW22x/DG+2T+rNmbrQnJY=;
        fh=YmYdVGnFniKnqdKzWE31TiLElK5JC9bI3anlOOhHD/M=;
        b=k467TdI1ZCQv+kivW5uHZ9Mnkb4BIWO+RLDB3MZSIxXq3UbVPFhsf8g9CZP1niIP7T
         8idSa5Z+K8gPfmyp5QSziGx5VZEzybMBDmvmNEDfWZYvU7a3+/uwGInMwBg/Bt6b5MfU
         lgTA/5cvZQ2mlexQC9DY85xMDQ9zBqW3/YFfVM2rN2E78Cno4Y8CKTUvMLd9ARywTu5H
         EBmorb8s4LV2fHXBARUCZwV3DaMx0vD2nvqbQuMcdawydMw79mzc58auYHjvrjUGPNov
         7gOr/CA8dvFCuOBBKm/3a5yDNPjOVJiwJCZQUy4BiyjI3LffiqsYSU7TwHe3dA02MHIR
         etmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780307428; x=1780912228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnswxpP7ou+7v1EMFzriHdHW22x/DG+2T+rNmbrQnJY=;
        b=J6pTiXx4y/pasckejnRzA1PmpFNCVUiEWbjs3TuwR69cMwpaVhIVx3UKgYCNYiVa74
         G2jcZ9Nwx+tdUA3FRtY/qjh7Uz3ytX28xR3UYJ5E8CxJF/d4IgrRsSh2zvZILdTRRw4M
         iWM0ZowZf79PWBu2fK1dJJaSmmHtnK5VnXkfUAiByXjI8YHexmrkVb18v5JONFrSKuMT
         5wHZV+4NvgTDqrlVVcazf8pX3lepMSvTQfZTehLXyLn8I7Eat0gsmq+G8mmu5fg6F9o1
         98XzrX0opZmMU7Ae1JjLDF1poqXTjn/+5VUa2NKQdqE4zJ8Q8VoQdgwa0aSVtcDJbYMV
         unTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780307428; x=1780912228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bnswxpP7ou+7v1EMFzriHdHW22x/DG+2T+rNmbrQnJY=;
        b=n8HW7uj4QuIxIQCOvxDc8t7YqhNOmKTWFdzhWoT1c7nMbzUVAW5X1SnUTjD3YHjIAM
         e7g6v7FNIaXuFhGyOjn619R0dgOuf5VWfC2c/v7zkK5s6Piavta2Bo3qYAU4hf1Sbigh
         xGXQUvSFrQMSvzBq7ho14YpUyNe5rEVPd9YnEFwRawZArJ3qU+iEcV9du8cLoN+LUD7J
         r81jSCDr4p7W6/+NdV3fiy1g4r6ftmRuhf/2xGxz7vb2iQT4D1ysWT9ixZJjbuzdcacH
         +AHDV3r/P54YMKt7fLoeQOzx4sUogZVSkp9l0UmkPsfJigT1sgIUGS19kxtzYAo1lVvO
         BFAQ==
X-Forwarded-Encrypted: i=1; AFNElJ8L7p9gO+0Cop5hGoPxbqZ9gkE5SdPUKToLcl7P7orRtD55YbloeehFe3NpECw4nngyVcGe3TY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyYLlCln6M/uAnRgAJXgMuD9+sdsUE4ntVRWcXZUaxvq3e9R89
	HaEuRH2P/8lGIK7045qoNDAPpBsxcW+R9sD2lwtNn9mnW5zrtJo9qXcKrao6N01RjutS/XUSdXn
	UVctpORdCLPNUtEdzpicwInPyuVi5Et8=
X-Gm-Gg: Acq92OGeD5VyDTrPN1LAAoSg0t/SRsTx6g46R/AEnWtOWXEHtCjG4mpHI2/6Uw+l4I8
	eur9GYlDyz18zE7y75v+rf6DBgC023ep6kVkfAFCLdB0TvAKPM0wWMdYT9oFwqB88e629TenDTr
	CtqZdn6ghRSJ0vB200bTl1hE/F+6dvj2/uddIziHpqwl5gT3eY+3ZvgsBCxQt27dSnWSADsQhgd
	+XSz2LpsmDY6RxhBSZ4TmaYiBpW500SThgf+FOmdTRsWv9E7HFm0i+SF5mpAyH7TZe+Vut6m95z
	QSo7Wj1gGvF1TAuzIw==
X-Received: by 2002:a05:6830:630e:b0:7dc:a51c:9197 with SMTP id
 46e09a7af769-7e6a2f09a9cmr5370526a34.7.1780307427747; Mon, 01 Jun 2026
 02:50:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524155735.13865-1-mhun512@gmail.com>
In-Reply-To: <20260524155735.13865-1-mhun512@gmail.com>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Mon, 1 Jun 2026 11:50:16 +0200
X-Gm-Features: AVHnY4J2P8yeU1a3Iz_kc4BmXJmEswG7u61lK5rEkMW2S9QxXA_I8prY59LNgYw
Message-ID: <CAMeQTsYVf_YRyuXx2XpBG822N=nMhnRbKnUNRu8OrsSthzrMrg@mail.gmail.com>
Subject: Re: [PATCH] drm/gma500: clean up modeset on backlight init failure
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 24, 2026 at 5:57=E2=80=AFPM Myeonghun Pak <mhun512@gmail.com> w=
rote:
>
> psb_driver_load() initializes KMS polling before it attempts to
> initialize backlight support. If gma_backlight_init() fails, the
> function returns directly and skips psb_driver_unload(), leaving
> drm_kms_helper_poll_fini() uncalled.
>
> Use the existing error path so the partially initialized modeset state
> is unwound before probe fails.

Hi,
Yes the existing code is faulty but calling psb_driver_unload() to
unwind the init could call backlight_device_unregister() on an ERR_PTR
backlight_device which is guaranteed to fail.

The correct fix would be to convert psb_driver_load() to use devm
and/or goto unwind pattern.

-Patrik

>
> This issue was identified during our ongoing static-analysis research whi=
le
> reviewing kernel code.
>
> Fixes: 1f90b1232773 ("drm/gma500: Refactor backlight support (v2)")
> Cc: stable@vger.kernel.org
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  drivers/gpu/drm/gma500/psb_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/ps=
b_drv.c
> index 005ab7f535..7218026fe2 100644
> --- a/drivers/gpu/drm/gma500/psb_drv.c
> +++ b/drivers/gpu/drm/gma500/psb_drv.c
> @@ -406,7 +406,7 @@ static int psb_driver_load(struct drm_device *dev, un=
signed long flags)
>         drm_connector_list_iter_end(&conn_iter);
>
>         if (ret)
> -               return ret;
> +               goto out_err;
>         psb_intel_opregion_enable_asle(dev);
>
>         return devm_add_action_or_reset(dev->dev, psb_device_release, dev=
);
> --
> 2.47.1
>
