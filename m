Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07143559CA
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 02:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787106158; cv=pass; b=RmyHCQH4pS2VKy93FhulVrKboiQyIlAcbqo5Qw3FkcpT3dY/Wgfw8+BemP7WH4k2lbWNZqvQIP6HA5hvU/S9+1rHleW4NFXpnnG87uVwNTrXwxJ+vHNmKF2b+mScWcVO2O5RovXTcUkbEvjvasxRyTeRmrtjyP9Yx/P58v7qPb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787106158; c=relaxed/simple;
	bh=5GYdROF3y/KvoZOEokyr7HJNK+G6/Ew2bTh6+vySWoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gb7Mov9vokO2T7eO+TArmWnTckrhRlH/o4ceo2d9uNEN6tjG9n86uM0Pdq2+kuMM90LijNCKRxByxzH0Y2/o9+eCDha1+ZmANTqckYJKZ7sLYEnoui+SGjk7p+uxzBgIC7O0AQMzih6o0C7oC5saqb6XcPDg4m0NirR2FgyD6Ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pgzWhFAi; arc=pass smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pgzWhFAi"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e54f8c051so35048185a.3
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 19:22:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787106155; cv=none;
        d=google.com; s=arc-20260327;
        b=HMqn5/2o6XFWHRCmKCfA1nvb3i+kmldpZOk5Fp0KZUKtFRcpnCztMukZZqWgiLFR9w
         C87st0LbH09sloDgpp86O9bESdkP0jVJ8AaXRX5NEYqBoEvpplPvnGfWmw6M2GNEpcvH
         SD1M0MbBs8yxNuGZD4v0U5naC3YwJfAWMZsxII4QEdzCF0lNzBiek2/DiVxgzpS0PTAc
         QRrlvVZLzs4I1DwlwN2dzEM/6G8gCeB6e1nn1kzW/bYyE+Ls1eSPdleuj1glFYvJLzbn
         psPDZ0uQqF1W4/zWgDfjkrysM3U6wvNJtkm8Kt8r98hN1kxLRpbQKBnYK3BCgXgXLb9S
         FGPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gpRJv4Mp23YkEXUctQWMGQFThMmtk/9orPPH7o5EEeo=;
        fh=CcqqZDVU0sq8Q6xvh+qQuJ36Wp9bmEtD/mwSIeJM04E=;
        b=QoSJaeNRf1hzA7zs0MCEft3hIXXw+bEY9rCOu5vIRhm9n3C9yDgsWrSGYZEXtRsoXe
         3oau/KdTNEllEoRnhVmSvXusqMB1aN/PnD/wpISfttv2i7d1RZYvzWvIN/LM+9JPPM0l
         LMTOQsfw+ZpI3+CLFVKubYHbJlFpy9bO8x9Sp1c8jpZt1HR2+Lu6y0R4Exw4Xrdwdo3C
         dmag5atUCT3kApClIbngr6awe9W7R4KSVS+YoJFdVDwwfcXN+EDMFg7AD3U69BiYSlwv
         PT2t+owbBT+NpowYDxDGnqXroSayWn/1hiRKKN+t+IPT2QDYpz1zJvbBmu7XyzydKAFB
         yx1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787106155; x=1787710955; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gpRJv4Mp23YkEXUctQWMGQFThMmtk/9orPPH7o5EEeo=;
        b=pgzWhFAi1UI/09Sjzanvq+GR+/xD9ynvzM+RkY3oXq6gpjTG/qaPMYOssLp+F3ixME
         rC3jBVQd/ABO7kV4QzBCVmBd9DV14CVpd0OloXO7IEAFgyaK/4vHYmxIi18kBFaA4TnU
         pbtszmCYD/98BSZOqDBX8SIl7a3NUqUDJNFAEWuK3m+J4lLlaokPdm6AEYUtMVDTIGQ2
         rehA9hOUFR/4aa8OlaHTbxgAud28KpHH2+1GMwzydEqdZSiOKUhp5ig8MuHQltISGnms
         y3ylhpFK7uAZe0GVNdFuENqvLGdlab7EABNt1EZuX0b+Hb3rnbw0MMyacrm+SOdSNM/M
         EYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787106155; x=1787710955;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gpRJv4Mp23YkEXUctQWMGQFThMmtk/9orPPH7o5EEeo=;
        b=XD2nP1b3QL9H8SEF8atMDWScKVbnqaOx/N/6HYisBqALWkO8+jjm9OA44M5+LK1497
         7Q6zlweaOHYTgxhIbHfl5sADesOMx/yjct35yfqBvhqB1bucTRaq8RgXq65XmKtxRzVe
         SsM7w5+IBGDcZB4hBOV0I5gmeXcrYmhtcsgP/qx4TQVIVhlDQ8cgjVm+AZGMIq+ItK/p
         6kknPqbHVz/uYv2eOcOe0wLUqCFuXJChgVu+IHopC7nFop+ABIjMA1rw9Lp2RlgItRQ+
         P32wehmGIT1Qv4j7LpifmL6wP4DZBlLCjSjfsZGn7abOP9Jm0MlvuFmHtaQo47cvC6QZ
         Hcvg==
X-Forwarded-Encrypted: i=1; AHgh+Rqd9BTRMfRbdX5GM2UtuOgSbEBI2MkdNlz3YSVFgiLMlABjN7iRWMh99mb3tD7LjcDhi3uyC8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlUegSCjhmkCOS0LAB33NI4xeEyjLcav/KSBO7OS8qoZpShYZi
	DPT4BO/hX7hb/qc/nAlN7856jzOf6KlcQL5jBtbwKFBIaZOhlflS7wcMjAFe2oN+vEAm9w51HgS
	jqqXUdILrJJWqu33gUrkcst6At6m4AiU=
X-Gm-Gg: AR+sD13HRufnYU40tN0D7ytOQ9By4MN/SqIaqxOLdZPngU/eblZ85Q99UwE+QET54nw
	171zpCbSo1c7kT3ZfD+n/ODpxFMFy8muVols2UCqNz5TktG79KIO75n+Wa0KujZKiSHFoJ2qJkd
	FnTLGn6h1RHcXMRy4B4SGwNdv430ADwW/n2oSXD64S172ey2PhM9dtmtYORjHy5iQiOMKnGVCMP
	WgRLxBbOXea1MUmKViAIX1STUSjY4mNhRuYdQ3xb9rzUX9DJFFfmSa3Ri5ENKlYsJy/47Mh4/7x
	xyOKRjGuKCNjGgaWyMYGCzfOFDRn4HDyvRPco2MMzfM0v+0TbGUlGSxD
X-Received: by 2002:a05:620a:1b86:b0:931:3ff3:30b1 with SMTP id
 af79cd13be357-9371e2036dfmr190855685a.4.1787106154920; Tue, 18 Aug 2026
 19:22:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818054709.282196-1-physicalmtea@gmail.com>
In-Reply-To: <20260818054709.282196-1-physicalmtea@gmail.com>
From: Jia Jia <physicalmtea@gmail.com>
Date: Wed, 19 Aug 2026 10:21:57 +0800
X-Gm-Features: AcwNN1WMlM3A0kVn0JUwWoFXgehU9bp1VN0RuZWr2DIeBqxYb0PcrHL0eS72BEQ
Message-ID: <CAJwVaM+D_yyU5E7w415HVwG_eMTrv3V6HiXa6Jc3wboWZJxs-w@mail.gmail.com>
Subject: Re: [PATCH] virtio_console: do not free control-out buffers on remove
To: amit@kernel.org, mst@redhat.com, jasowangio@gmail.com
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, arnd@arndb.de, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> __send_control_msg() publishes &portdev->cpkt as the control-out
> virtqueue cookie. remove_vqs() walks every virtqueue and passes leftover
> cookies to free_buf(), which treats them as struct port_buffer and
> reads sgpages.
>
> If a control message is still on c_ovq when the device is unbound,
> free_buf() reads past the ports_device object.
>
> KASAN reported the use through:
>
>         free_buf
>         remove_vqs
>         virtcons_remove
>         unbind_store
>
> Drain c_ovq without freeing. The packet lives in portdev and is released
> with it.
>
> Fixes: a7a69ec0d8e4 ("virtio_console: free buffers after reset")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> ---
>  drivers/char/virtio_console.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 9a33217c68d9..6e9bf064826e 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1886,10 +1886,24 @@ static void remove_vqs(struct ports_device *portdev)
>
>         virtio_device_for_each_vq(portdev->vdev, vq) {
>                 struct port_buffer *buf;
> +               unsigned int len;
>
> -               flush_bufs(vq, true);
> -               while ((buf = virtqueue_detach_unused_buf(vq)))
> -                       free_buf(buf, true);
> +               /*
> +                * c_ovq cookies are &portdev->cpkt, not port_buffer.
> +                * Detach them but do not free_buf().
> +                */
> +               if (vq == portdev->c_ovq) {

The non-multiport case was not considered here; fixed in PATCH v2.

> +                       spin_lock(&portdev->c_ovq_lock);
> +                       while (virtqueue_get_buf(vq, &len))
> +                               ;
> +                       while (virtqueue_detach_unused_buf(vq))
> +                               ;
> +                       spin_unlock(&portdev->c_ovq_lock);
> +               } else {
> +                       flush_bufs(vq, true);
> +                       while ((buf = virtqueue_detach_unused_buf(vq)))
> +                               free_buf(buf, true);
> +               }
>                 cond_resched();
>         }
>         portdev->vdev->config->del_vqs(portdev->vdev);
> --
> 2.34.1
