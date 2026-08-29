Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FAD3ABD80
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 18:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788028484; cv=pass; b=cqcnQdTEye/lNh80cEGbM5ITTViyZ2/JCJfS5nim0OnyNHV6KQ/ua6pNGUBHaxNQ0kbTRSdi7V9K3S7ZqTfcbMpSgeXy9p8fZgZmmm/4gCMAlU9qtAp974peGpC9r+kXpek3hA+JUT/NFTzRoG3gWOA0CHlvEa5JQiLBTA5KWPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788028484; c=relaxed/simple;
	bh=tW30C4gOY3Z4+diiNN9rry3cF4JPQrHbh8csErsc7Og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nrx5oLczwpQf5Q0eWzCypsr7MgJDRk68z3l1xpFzXouxYMaGtVgt29CqNAYnDLiv5bDCApxnPb28NpdLbqT/gFTwMq+n2dnJHI8gY6re/RmiYmGjweX/Dx+n95YjzITbMFGRLNOOEariHP6qH0ftmF3ODplCHGjYfA/3ndiEb6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i19xLT0X; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i19xLT0X"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-69c600f76ccso2725579a12.0
        for <stable@vger.kernel.org>; Sat, 29 Aug 2026 11:34:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788028478; cv=none;
        d=google.com; s=arc-20260327;
        b=RmBHz/d4u23d15nAekqcrHTXubApXDsU03VSeUrB5u+Sz3O2mbwlr6jQq2VASuNdsb
         hCz35p7kRTxRn5wqdM7wt1uCYTvmO8nkz3QgDhrEbTSCsQqtTW31UP3Cw7yquC/flMM9
         mmoqggmmoOmeaToQwfNjig5KiwBqXHteqI7IX7zQG5NDkCVMyZgqUfhQ9fePohUNWHiy
         7Y/r3gQoZD1yYxO00rVzYj7+1nd//AUi5J3Ciy5i9yMplUAzLSkbg1V+VDZ7oqpqyi3u
         g0L8X1zVu/I1qhDPQheAJf/usVAhwN+Xuu1WZqGswRV+kVaVn75aj6pCCAyuWSUbkpMJ
         Mhmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GxySuSJTNKHJC/xfEjR8zEsk03gGnur0eoevwy4Hv20=;
        fh=0quejsl8uWNQkQ5qy00iK5XDYCe9pNKduIavMwCsxDM=;
        b=Bczw36WaWvIKs4dZ60NSgZb2AnqnHTptDe0wRz0e8WUOEhQMeCzXcdyq9yEuYWlws8
         33jYVArH26zujbu4DBg1cehr76WkXC8prZjjY5tVmYfofUYcqTPOQ5rr41KWB24WEP93
         fewVHRJ0r9aZ0R9/6EaPd5kl8dHeC/LSEvYV6relfffQck56LqKZDuYs2A964DcCiB6d
         gD22sElJQlpPYHiWRwB8Rz9Gr/l2YH3XJiIyWZLo1X4teDUgBKUdm6hfZ615htDe+9Zv
         wnHf9sKzURMF77FThxJvdRDYXZbR68/vGdg6Mn4xu4NGxn7EAvrm66Xcj30U+8QoHbYw
         Y2uQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788028478; x=1788633278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GxySuSJTNKHJC/xfEjR8zEsk03gGnur0eoevwy4Hv20=;
        b=i19xLT0Xh9BkhSDiSkRINCsSCYVvwrMIGdY9NK18nGcAZUMX/jidc345gCROpBJjsZ
         0mnL/sT02Yi6HuQFaAq6O8uHOv3pFggrdujFZJsKGlpJDbNCOJp9/4it9/D11mH2d3HU
         e2frDE6aTIgWmzA/YmJ/6bKtgaDYZdgM2HtLwj/viWWBepYp4hoVyt7La2+ACXgTIzb6
         tyqo/R88d4rUL97jQiPT/gkxzcFGvVegrv+pk3f8rlpa+ZGUnjtRdZf1yamMir0PyhqH
         c2kyH5gRoW7DWMLf/kBJKRdcpTZ+Ded5eaU+8J1ikT5CaKp6DSNfYcmMG28qA0fsV7r5
         YTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788028478; x=1788633278;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GxySuSJTNKHJC/xfEjR8zEsk03gGnur0eoevwy4Hv20=;
        b=gTsiIbe/rm9SnvqzNf1zWPnO8gy7lhagiRo0OGKfpMSuQAliu7dpI2OMDgC47rS93t
         92YV4yEvk2xfnVrSQMRJqUFKjMfrNy8Uv6KqiuUUXi+VhXeI6XW5wAAs49DL2VMhyOo3
         3vHgN/+j7zL57pS+yMFsTkZT5UmHUv+CaGC6SqCzVYUrGQ6dDAapz2Rqm6gVRWb+B5sE
         xTPagL85OXu3xoA4EjwA1I2Es9v6JpscPSaQMQKv1KCCFeoWO821DUGYXFDOxgHvud2m
         CoBzgDn3ZOZaiK4XY0fwyZr683z29P/EeJQtG/EJQ6gDn7J8APscRFI5kT0k6dO1Lfus
         YhAg==
X-Forwarded-Encrypted: i=1; AKwUvBxBhiuAveitrN4w6CIxuE0hjhzxlnsy5DRJD8UnJl/nlVNz+hDLcnkU7qYw+RqsP2EWfiH2rhE=@vger.kernel.org
X-Gm-Message-State: AFuF++luO6JA2zDGxcA4eoUVW96hbpP8X/j+kmSMnIoSc+yZD61rqcAm
	Lvpb0/OE5wsg8kb74mhhDsxAuG4zzzEQh+Zmle6k70URVxWa2ftAl3Ic0mp5HLPA381wZq0DlVZ
	fsEOQKxsoPbXFozRV7BPIylYSvKNBiwbowyb20B0p0UQH
X-Gm-Gg: AYBFou12VU7iYHmFyfIdtqZW/TI4PuLs9dHWDK9/4wJmxX4w2MB/dteQgPeR4xQ8drI
	WmYlz8ESVF3yNZekKuOT+X+7WHZ7FGtt7EbBnbt/zBsSO0I2ag3PPZ3lumip6HSiKCKRo03U1dI
	wv5sYISDlN/GZyDhsa124JDnTw28cuBEoHV6Zr4hmpYdVlx3C7t91LbJa/eTrLi4kNqkyPy5JHq
	ozhFI3CafHkNMaRULTSD9uVDZCIWR/p8+bFsYHh9TQ/1nLwcBNdUm+Yf1lIX8DEZb13NsYGNLnf
	r/a8vQ/gWKiKU4mArXD2qXj4c+koonOoVKNbEoucc4tV/x1Xqf75THmK/6H9UlcKUVb34NPXiGd
	DMlw=
X-Received: by 2002:a05:6402:5418:b0:698:663d:d7bd with SMTP id
 4fb4d7f45d1cf-6a60d3b384dmr10419034a12.11.1788028478183; Sat, 29 Aug 2026
 11:34:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260829164945.2691317-1-samuel.thibault@ens-lyon.org> <20260829164945.2691317-3-samuel.thibault@ens-lyon.org>
In-Reply-To: <20260829164945.2691317-3-samuel.thibault@ens-lyon.org>
From: Weiming Shi <thebestswings@gmail.com>
Date: Sun, 30 Aug 2026 02:34:01 +0800
X-Gm-Features: AcwNN1V9KtG8SrYpsXXYYxYM1PVbFmhtio5CYS_rfRmw3khsCuCHGO4aE8ypct8
Message-ID: <CANgPUi3PnuhZUPzN-LwyviZAWbCiaZVF549shZ4JoR6GhC7Oig@mail.gmail.com>
Subject: Re: [PATCH 2/2] Fix NULL pointer dereference on VT switch + selection
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, kirk@reisers.ca, 
	w.d.hubbs@gmail.com, co+e5693071d903b832@bugs.sh, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Samuel Thibault <samuel.thibault@ens-lyon.org> =E4=BA=8E2026=E5=B9=B48=E6=
=9C=8830=E6=97=A5=E5=91=A8=E6=97=A5 00:49=E5=86=99=E9=81=93=EF=BC=9A
>
> When selecting/pasting very quickly after VT switch, the tty is not set
> yet, leading to a NULL dereference. We can just abort the operation.
>
> Reported-by: co+e5693071d903b832@bugs.sh
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> Cc: stable@vger.kernel.org
> ---
>  drivers/accessibility/speakup/selection.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/accessibility/speakup/selection.c b/drivers/accessib=
ility/speakup/selection.c
> index 1713ce4e0ba5..a04a7e8c307b 100644
> --- a/drivers/accessibility/speakup/selection.c
> +++ b/drivers/accessibility/speakup/selection.c
> @@ -61,6 +61,9 @@ static struct speakup_selection_work speakup_sel_work =
=3D {
>
>  int speakup_set_selection(struct tty_struct *tty)
>  {
> +       if (!tty)
> +               return -ENODEV;
> +
>         /* we get kref here first in order to avoid a subtle race when
>          * cancelling selection work. getting kref first establishes the
>          * invariant that if speakup_sel_work.tty is not NULL when
> @@ -120,6 +123,9 @@ static struct speakup_selection_work speakup_paste_wo=
rk =3D {
>
>  int speakup_paste_selection(struct tty_struct *tty)
>  {
> +       if (!tty)
> +               return -ENODEV;
> +
>         tty_kref_get(tty);
>         if (cmpxchg(&speakup_paste_work.tty, NULL, tty)) {
>                 tty_kref_put(tty);
> --
> 2.47.3
>
>

Tested-by: Weiming Shi <bestswngs@gmail.com>
