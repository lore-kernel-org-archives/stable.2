Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B51335E1A9
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 00:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784680609; cv=pass; b=oLupr19gfKoyLzJZmtPhLoAMx0HcgO+CIZocDLdQhdFn2B//pNtMAeij5ak8vfyxFxEN0PKQ+ljgctqTxpE7Wyc+zWR9FfZ1kqAQbK/nqs9tOLyKcgNM+FPkWK/WwEhYPV1owXpn7BS3MLZv0gytVIWZv3V76FSOFZbucrNLrY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784680609; c=relaxed/simple;
	bh=VaOjMJW6yROXX2xcZF9AkpALiRyCECcvPnPYKFNeots=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mmmpJehkxYUC0E8ucRL2Z2iGFNwZm9sBMTfyIGZ8p25gmfj6O1cxa2kPIDQmmdkIq+LELuDSc0a7f6fyrNpVUn9+l1JAQoQJe3xosWBHp4IvHJs9FumyJJAYWCXuDN62bIxy99dURKo/KljOFcgKXcGCHZ2gKs3S2co5htVO3YQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rsV+j8tu; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rsV+j8tu"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6682259cae6so6017877d50.3
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 17:36:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784680606; cv=none;
        d=google.com; s=arc-20260327;
        b=SgmDBM1ykIY+g0ai5ixVgfxSM70TQLVCtlAeKsVz6kWeBA9xueIlu2+8usX4Dft5I6
         OFh73xtazVqR5oTgtzArZY8fRR6FVbIHh21gjK8+kv+JENKXZXIh1mPjdP87UTw3A3Vb
         uaRztcugR+QyLKCYnwvQ4FBtWEr0e1R4lMiSa0HVHkDXdUtKjLULDSy3JQ1H4oNafR7m
         skZACH6DDpAnyg8fa6isgMZZ175huRwCKiq+otYzxJChTBR4GbUdfY+3Ab1oqz40zoqb
         uib7K3i0R8Fn4tcNnd+Zk8JKflnRwU9HAOSuS8LeijgsqNapXNYZLTeVRJ1vazLcYXR0
         sSOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UBeGMmiwyg0bk2ViaubAzpdFo7Jnmt+cToLDMxTvYHw=;
        fh=tCql5+U0/fcfybHjhQAygAnc+IE9Wnpf8JOkOHCVdUw=;
        b=URoZlcueIxF8dCTdW2Qf0Ogrc+uBLR04i+aqSK0Fgi58xfbZ19H8Mis+h4tUAaI74J
         +8alsc21Al5qlmOH6ah/t0wfh2Dxns9ucC1cjYjoOmnrt9D/0GMwRUXoz8E6QEfL77Iz
         vln9JcduUo27RbRvUviJlpBpVpnNyvN/6gFTbx3kLu0j70RBC66/CeiQUcaJkSgLQI3x
         ougee6FPPo5u0PaNMvKZSsSjUB6cQMqpAZcJAKyjoVdtLu8zfgLMvlFrJCUlgByCny9E
         EGPjUrh3yjnx0n5YGIIpJaxzr8WWjNQbwMiVl1TgI+mXd3zH8T1Ycj4gEawrGc68WEfO
         uXvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784680606; x=1785285406; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UBeGMmiwyg0bk2ViaubAzpdFo7Jnmt+cToLDMxTvYHw=;
        b=rsV+j8tuG6nlKKBN7EnLdjJiXIU0qiWyOsE92CQXo/E41bpQDM7w8L3LrgETy7lssB
         I+qS3IUfogkiaPtgpxsq6ZyAPt3/NcWh8TJ5tWoF390zS6exfpx7D06+DZqSfQYArODm
         M6KmRQRio+/I9KXonV3XWMTwK8efJzK5u6Z2WGNgKscgz5LIbpZmwtT1cawR10hnT/5D
         lgvyHAbhTdgdM5YmTpIaaeV36yYaLCd5zWloHhEYabEgKkg6h91NIrQvV6YNbzcTXdXz
         aPMbTPCE9aS4y0zlYD+mgo0NonNujZ2uolMHm/l8aI8SHX3tgsg220e50go7LEW3UhRM
         930w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784680606; x=1785285406;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UBeGMmiwyg0bk2ViaubAzpdFo7Jnmt+cToLDMxTvYHw=;
        b=gSime181L/1tMULbmv37BlFVMEgrFEF/ItkP8+DWC6qSxo9dWSN0K3OleaH95BJkNf
         TuEbfsVzuknRQOMZw9QETXdbm5cG7+4dDXwim0bVeA5X+S+VFiOJAg3tJny0/T0X27Gb
         VH7SlIWkGYff6z8XnYUz4LqyVV7/q8HZ+5czwrGcNOCqgLMlem/sNQPDtPPxdC97hGsg
         VrZ65LwjG/HM8F5m3XuKJc1pwyKC+SeF9+UEX5xpVPsPKpaNAKKNOXvzGkgQvMLhgcuN
         WFXKATAHbemnqSpTOg1BsImZaTOcDpoipTG/v3+nqu4vEHRT31C7Lblh6Bspbnjec8qT
         9lHA==
X-Forwarded-Encrypted: i=1; AHgh+Ro7gNoMgB1XpoimW+TCgcQ3AvMHjC9Wj04wlIcQmLdtFXmpZs5z5pnd3NA/dE2yRF8xreVcnnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx06ZZ5gR6svj3s6PzrqIXOOIJhbhjCJDA7NCdLP2IpuKg3TQk4
	taoKAv74kIwut3dPfca7cJpayruHxfHPxU5uBf2bYkO5zH/18ZEUJcAnTui6VJZhvkfOuLyiyJV
	L9dxmepxkKa4OQLxQiqKceVL2KCSWw49f+f90
X-Gm-Gg: AR+sD13itjIJAawI7NbicVRF4oDh4DLR2iTIHfdtWUyrd9MxeJqxpAVIxTxC4y40bFe
	uEB17aa3Fs0F6PW3qo2b7v9IzIwj5oSUarVK2Sv4w9MhQ+6I0LGqaf6Kmd1vXe6p8WHsBDxsZdd
	OnEQoABaochqPpY/klMTqtdljlIS0L6HgOCkRGW3kMKiJPDadPcY7aENqzDVOH36MAg94AAY9XM
	HrsleXofJAez8z3u1X0cYsE6aBpbS9qFY/CvZa3zvHm0bMI2K4DRGWPUzW5zjM=
X-Received: by 2002:a53:a50b:0:b0:664:ae6b:b4a0 with SMTP id
 956f58d0204a3-6683bdfcaaemr4245504d50.85.1784680606085; Tue, 21 Jul 2026
 17:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615070530.371640-1-james010kim@gmail.com>
In-Reply-To: <20260615070530.371640-1-james010kim@gmail.com>
From: James Kim <james010kim@gmail.com>
Date: Wed, 22 Jul 2026 09:36:35 +0900
X-Gm-Features: AUfX_myH1cFXdW2ehLc2ulk_MEha2_Q36VAE8_khV2ASBwvD9CJDCZeo11aA8xk
Message-ID: <CAPdMtfdPmmV-d-kT6KfAD_dP9y2Oc-Z7zStMMLRhRXHC+wn2FA@mail.gmail.com>
Subject: Re: [PATCH v2] rapidio: mport_cdev: fix use-after-free in dma_req_free()
To: linux-kernel@vger.kernel.org
Cc: mporter@kernel.crashing.org, alex.bou9@gmail.com, dan.carpenter@linaro.org, 
	stable@vger.kernel.org, gregkh@linuxfoundation.org, error27@gmail.com, 
	akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This is a gentle ping for this patch, as it has not received any
feedback for some time.

I'm CC'ing Dan Carpenter and Andrew Morton for additional visibility,
as this patch fixes a potential use-after-free in the RapidIO driver.

Any comments or reviews would be greatly appreciated.

Thanks,
James Kim

On Mon, Jun 15, 2026 at 4:08=E2=80=AFPM James Kim <james010kim@gmail.com> w=
rote:
>
> dma_req_free() drops the mapping reference under buf_mutex and then
> dereferences req->map again to unlock the mutex.
>
> If kref_put() drops the last reference, mport_release_mapping() frees
> the mapping, and the subsequent mutex_unlock() dereferences a freed
> object. This is a use-after-free.
>
> Fix this by caching map and md before kref_put() and using the cached
> md for mutex unlocking.
>
> Fixes: 4b0986a36 ("rapidio: add mport character device support")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Kim <james010kim@gmail.com>
> ---
> Changes since v1:
> - Rebased on v7.1.
> - Add Dan Carpenter to Cc for lifetime and use-after-free review.
> - No functional changes.
>
>  drivers/rapidio/devices/rio_mport_cdev.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/d=
evices/rio_mport_cdev.c
> index 009b3b595bbf..9b94c9b2fad0 100644
> --- a/drivers/rapidio/devices/rio_mport_cdev.c
> +++ b/drivers/rapidio/devices/rio_mport_cdev.c
> @@ -564,9 +564,14 @@ static void dma_req_free(struct kref *ref)
>         }
>
>         if (req->map) {
> -               mutex_lock(&req->map->md->buf_mutex);
> -               kref_put(&req->map->ref, mport_release_mapping);
> -               mutex_unlock(&req->map->md->buf_mutex);
> +               struct rio_mport_mapping *map =3D req->map;
> +               struct mport_dev *md =3D map->md;
> +
> +               mutex_lock(&md->buf_mutex);
> +               kref_put(&map->ref, mport_release_mapping);
> +               mutex_unlock(&md->buf_mutex);
> +
> +               req->map =3D NULL;
>         }
>
>         kref_put(&priv->dma_ref, mport_release_dma);
> --
> 2.43.0
>
