Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D445B376BF7
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 03:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863017; cv=pass; b=QTbYR1xusqCoVNfQaqmshyOieXIkgZCbYS4vMjBfxp9/E6kkEPOhHHJo+eijXRqaXZmh4kgNn6VOMS2ZBWzdBO2+gKEwl9BqZiD/yJxnAQwJEytTF/VEti6feEXunmDMvdltDDONmolLfcxS3TLjFgNXtq2G8xVNGyGtiFDOMAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863017; c=relaxed/simple;
	bh=MbMgHBJFJm36HYiK0t4H+NweIDkiN83bQwLT2J0xZeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QzRGejIRqrwl0sAhEVlf+6VLR1AqCgTTw/oykI8jiDmHj6dYvwOMcuQOqkMMIwRBzfmXWqrqldeqvTPfjonOM4H9Bku/kXhmOl1TJ5kG+gN/bIfqADg1MGt2HC2bAEpDQ17uy/FQen5X8KMTuShuGILBtOLm0JhiTHnIH/zWkzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0oZisPj; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0oZisPj"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-677af43eed4so2045567d50.0
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 20:43:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791863015; cv=none;
        d=google.com; s=arc-20260327;
        b=I2bQzl7q7HnOHdBY44jIEYIh/ddmw5FVg8htAbEZE/EiIV1YhqmNFTNsBjcbZPHPWy
         jZxryubmF2lXZnWyKmUWVQFNA1vYuWO+WNCGHpOEovtVpOsy5iIaUAZ4uX4zVyQZ0fiv
         Kc59Tfka74xl4SYJNjiBuW7nb8gdnPeUA9eLmkjYl7NcX4wSHv/lJ5Z76UKfM+cMyO/b
         QzKY2+dvFuUTXR+R01i3fEE/BMrLQGaud0GDRvus5doRFizaTtyh3rZyGyxi3wB6/rKa
         w297y0HpGQcyE28zvToymLaUfpnO2EJ2hs83/sPjXina8YKhcZQXaNZZIrCwpIgzvLAs
         FjgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=g1Xe8/t57+Y9BLtJJ1DCvjjCumMN4aWsrAavgy8Razw=;
        fh=XvAv5CiIjh5XTlOi0reyAOmw9XKlkrr2WRe6/FrE7d4=;
        b=l3wftKjgTyWKh6IRnsrXvwUWIS+82HwQ982ycUscWsNJsbQpyeXp/y5wbcopZgCa2K
         0cvxboP6T2fzMadiF+7uz8zaUvjCmC+/Z+JQlnJ3FOIOKM5guKOPhFYzZtsToi2+kv5g
         +gaxI/cHIbVmxqZQAgIskLtSUajmepTirLKu6oHeU6/EpBXwXEkVioNdHAv7qoqnD56v
         8Hmu45EinEFMVdI8Eiof/6OK/nue6CAHRFqi8uHwRV48C7MEoc/1G5gurXYB4kqamQGu
         l9f9RUk6bYlW8WU1oaCPhSXdmqv03UmxfpHjJ5TyLRkR7x6pjEisU7xMM0TlgwdLGJyQ
         wmZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791863015; x=1792467815; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g1Xe8/t57+Y9BLtJJ1DCvjjCumMN4aWsrAavgy8Razw=;
        b=S0oZisPji0I6Jptei97TSSfraRyUPiWhH/2M59f8/P30bUtl14Csg9c7uKlzO3p97B
         BTUWo7TwvAIa6R2pVaMLo1HxAcVzRwffMd98slLS9Zmc4kWhbgx4vz5kjDlTpj/g4azc
         D+Emqny8AfJ8nzEP4fmhrrKP519AkatfNbh81/QnfxPkp7iMf1OqEKfpkxdnlo4LObSR
         zNq5P3LkmGFXfZHJLTgoGaijKJhPxj8Kvs82CODbCpQR3noun1qh6l8T8QyNofQ15CqF
         nOBLTDQg5bW1ywc4SQeN0Oke6AnlxW21tbArXtkXbYLNK4FMJdRotcE5MPaMzRLrslyN
         +lfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791863015; x=1792467815;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=g1Xe8/t57+Y9BLtJJ1DCvjjCumMN4aWsrAavgy8Razw=;
        b=yfckHhUdMFD+lLl8WXKzQHlYXYw9td3rfFoNn7MiKQkGit9GF2/iwrz2OaHQl/VIT1
         Ov/sTEQmWKYtB+IdRS/RevWCUZX+jTFxr/dK9mf1oIk4QYTNfcCCXxUjvr7Eti3dIoTd
         UqK431QRjs7GFKnXSzXQWjy835RHenkYMrM9Cx6uG+k7/VeFj2T3GjNYKnHSAGTLtSS7
         LeBOrTd478qyPaPigCnUGu+v0cHwjqvz5SMY0nKqcOVyHvGmyRvq6aRAiEoqGGs/sDPV
         RtXoBwz3ubVgy35wPQ4HAf651LJbI9adIO7Nw8Z6qMwcoq++EjhcMyDxpogYkT1pNZDT
         CvJA==
X-Forwarded-Encrypted: i=1; AKwUvBylZBmPsuCrlIWDYQh4Juq7LdbdWlAbVmHGj6E+xydntKURPlj/NPkhfqTBsFRtKjeReraMWd4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKkpZPa9q7en7U7xlizQSHJJzDKRZ9HVmZiLjJNd8D1qPzviU8x
	bMOV3w/MokxqH4L+2y05V9Y4iT3DAeuYEnOyd1RC2ZDbfyO9EiWcnXTzPVV4KWNX3MfBLIQXbXs
	Gm5jhHmfCfKUla0xj9AmpQOKNdCotaaVjKAmx
X-Gm-Gg: AYBFou2aXsZGkBZS1T2bZhFNq6KjQebq1HYqzSmDM855J9OEx1yknmg7c4dH4hKyaEu
	taAeDNy3r7sWZvg0M3YfQNabrwx3e5bDKJ/PrSL2zeaOsIZxtGG5KFoOfP4FYH2lPPghs/9iN8J
	fW1c3R4RxukM4/iqqlBrToUI5dyxO2nfFpN1vI7lIZRZrtewW/rpvy3AtVQcSp+uexQWwsHxO1b
	mnAd8AJ0x12NWEMZzge13EjjgO76g0U0elNUBBnCifXVEHiKQAedS0yYykJio5nehzoHi0O61x2
	m3JkwP4KzkBEoRhS1hm3hIxdMalgQgCkBCQqYqAuVVWJXS2TSpEpC8VXsQ==
X-Received: by 2002:a05:690e:4102:b0:677:c605:b736 with SMTP id
 956f58d0204a3-679369ec2dfmr4046021d50.43.1791863014837; Mon, 12 Oct 2026
 20:43:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v3-0-674b907d0652@gmail.com>
 <20260913-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v3-1-674b907d0652@gmail.com>
In-Reply-To: <20260913-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v3-1-674b907d0652@gmail.com>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Tue, 13 Oct 2026 12:43:22 +0900
X-Gm-Features: AclHuK9taASNrgAMmV3Z1NS8TfpfNKzvhhsyrCVDqQveBDVwje9B5oj9wzDDHuo
Message-ID: <CAKbEznugM-HxPxHwZ7RxC2iLC0TDH0qi9649hWATiPYXF+urfw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] drm/imagination: don't gate the runtime PM
 callbacks on drm_dev_enter()
To: Ryan Brue <ryanbrue.dev@gmail.com>
Cc: Alessio Belle <alessio.belle@imgtec.com>, 
	Luigi Santivetti <luigi.santivetti@imgtec.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ryan,

>  int
> @@ -398,33 +397,24 @@ pvr_power_device_resume(struct device *dev)
>         struct platform_device *plat_dev = to_platform_device(dev);
>         struct drm_device *drm_dev = platform_get_drvdata(plat_dev);
>         struct pvr_device *pvr_dev = to_pvr_device(drm_dev);
> -       int idx;
>         int err;
>
> -       if (!drm_dev_enter(drm_dev, &idx))
> -               return -EIO;
> +       if (pvr_dev->lost)
> +               return 0;
>

'lost' looks protected by reset_sem, but it's read here without the
lock. Shouldn't this at least be READ_ONCE()?

>         err = pvr_dev->device_data->pwr_ops->power_on(pvr_dev);
>         if (err)
> -               goto err_drm_dev_exit;
> +               return err;
>
>         if (READ_ONCE(pvr_dev->fw_dev.initialised)) {
>                 err = pvr_power_fw_enable(pvr_dev, true);
> -               if (err)
> -                       goto err_power_off;
> +               if (err) {
> +                       pvr_dev->device_data->pwr_ops->power_off(pvr_dev);
> +                       return err;
> +               }
>         }
>
> -       drm_dev_exit(idx);
> -
>         return 0;
> -
> -err_power_off:
> -       pvr_dev->device_data->pwr_ops->power_off(pvr_dev);
> -
> -err_drm_dev_exit:
> -       drm_dev_exit(idx);
> -
> -       return err;
>  }
>
>  int
>
> --
> 2.55.0
>

-- 
Thanks,
Gyeyoung
