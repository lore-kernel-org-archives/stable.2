Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795173654;
	b=qRV8fh6UtxK3rufXAXm6w2SRw4C7c7RzauadzZlqgUHvXj7aU3WMQ6Leir2nxqCLKGLs
	 bN6odKj9pGhWU1yXwpsF/WEIkp1IL361/oz/rUtYdVvjRsf9cbnTZzqTjz2JvXJdIzqRK
	 jOjykJNLTgFvK8WJWWfDyFRV4fn9p+JDY6xnCTqPTwtah6Tc+xvXBikbQqj2W+UvxB3uU
	 0lF+upJqzxvLSETFXoV0Hg5gXpYjS7uM6XqbNqbCNGpHAGHUJIFmzTPeuJvpzoYySzyve
	 JnvbWrDAiaLOYhY2Z9QAiZVTQG/2RYLlL7wm5eIO8p02adj+wSANPMfICzEq40tpSyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795173654;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=UQX9LAKDbJv63O+oyEMBZ5zmGCeTuL/tuyPPcUZ7zkY=;
	b=Y7Yh1FOAdC29/g+aTIDB+6ydzykyQixLm4uT9Li14/ZTnMwj7WLq1alQzBY7GbzqWbVW
	 GveURQpOIHlCqAO5yFVZVos2QECeHENHvbrec/nzXcyoMYTFa0QqscH5avF9X1VR/NbTl
	 UQn200C0jH/+sAqyE8vpZWiKM+geVtIfs1eW576sddqGvL9NG5KnhxUf6nnHkgpVsURMh
	 j+paCVS3b2Z35+bWy82sT1qbS0kx3t0OaOPo+Ls4fpgedWXqzM5qBcza5im4D0fVeO8p/
	 M5Y2Ino3ccGKI83oGkyBQmoZ+mZL4QNXEA0+B70ElgWpAQ3Cwm3KNc0bWgfAfWOrVUQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloud.ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=cloud.ionos.com header.i=@cloud.ionos.com header.a=rsa-sha256 header.s=google header.b=HGhCt+cg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531B2606A331
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 11:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 531B2606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.a=rsa-sha256 header.s=google header.b=HGhCt+cg
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b8b20b2538so949881a12.3
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 03:20:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795173652; cv=none;
        d=google.com; s=arc-20260327;
        b=UDPaZLgRSQteHzhb+K8fwOB71EppWfrUuhsXbjKmNWKJtLt7HcboTPHEjt6Aj0dazQ
         Z+OtvThTcjW0nax7WRGXXrllzOEZSUcDaSb2rcE6dFT52wEP7N5Fghr324XRN5e27GhB
         /7Sw6A3Ad/lnaPP5JO0iZrkB54QzzqERLFmRe0JBxDpisrYPzJu+p6Sbi69HA7vxgqeW
         x2NjQFdMLgqLeiRe/LN6aCHiQYoMpo2Lj3wU0WfHPl97xJVbIF56WOL2AAGE6RYCVEws
         xSt6SB7B3lyB6LBJbiGDyNdVImQbSCCY1axDdgz73X5ywDgXkxJkKdRYz5HNljvKP9lC
         t79Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UQX9LAKDbJv63O+oyEMBZ5zmGCeTuL/tuyPPcUZ7zkY=;
        fh=ofwzwyduGhLtKrQkPbkfwZQi//yF/DF/mP/h7BkWsO8=;
        b=jRb0CbQeUo2e8k5ZgEDhAyuN8/DYT4hqhJjmD+WHysQz2oh7CRl6cHcS3x3+871MO1
         wO2ChUyeSqrUe2ET1y4X4bRaO7Y00YhLn9eb0eOoFmhQG+aFE2PyN83OnWlJFGVVTay1
         jIxo2rTixTjqtYpYPnmdHJys4hULU3WNckBXpRcSPg94qyQSuA7Req9orEUd1u4udBBu
         JtgN7mY95WQZqmwZhqbIJhed/msmBx+Yzon3Xhz8J8La7oW3mckAW181zc419medhvhw
         2d+I5KR+us8Pm8O5wBd2XIJ05FlAxbQVCgtpbfFIWdYSVlfNCpC7FrI4d42zZTjOyZNQ
         yONw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google; t=1795173652; x=1795778452; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UQX9LAKDbJv63O+oyEMBZ5zmGCeTuL/tuyPPcUZ7zkY=;
        b=HGhCt+cgkHkc+fYj57YSXT8KfrPye31SP3vljt5ItUBjXF3Fqo0UyNq75R9e+gAovQ
         IrtVWcmnUlJq+NKn2fDamVFR1PZ5acmH5nkWFsrEeIIFGWddYEWc0NgKW5BvnZYKqeU/
         gczdBt84+rPVxAm4+Za3dVZ5hRCbWYPyc7Ggwz1AvyO0r39Yyyd/QFFaepNZgLcnmByv
         DLzGQM/RUg8Z/1XarC7itZWKS8J+sTUHGy9774gP272p4W82Z+zyRTZltQ/hLx9T7j5a
         bB2drpitti9W1X7N8msti2nogmIiiKGBpk9y7qMSmFZ4y2xJTJYeYnUzApyI0kNYF4Kq
         +pMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795173652; x=1795778452;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UQX9LAKDbJv63O+oyEMBZ5zmGCeTuL/tuyPPcUZ7zkY=;
        b=IMZUireDPGqZtfirfMVN48fmI4dj/mgi/WycWHDAGu0iDuS6scQOwoLLSZKc0W/XxH
         IsiINvR1qmHAQJ2/62mm7AmI86NlZcHJX2sy0aNzZd1vNPZChtBCUZHjkm6QZeCXJT00
         Vt8WdJJSs1hA6BSnVKNYngyjYPxY75EFEdIsn+fc2c78wD/UU3jn6QTDnM0LLT+q20+Q
         h0JtEoI4yRvHJepa76P57Dt5tpTWHHJ7JGPJyBROKPngCyEhCM0SVGde3VtyiODw72Vo
         ioLM94HTKh+b7BbKyB9NyNj/vui/lYsfn42h9dLW3uGjhy3pwTzjndqtJ3IzBp3CrR6+
         Dmaw==
X-Forwarded-Encrypted: i=1; AL+hErGDkSIHBcoWyR/5wNwG19NXZX8Vc7ADP3nBnc2ZnMYfAmjWDln52uLtvvO51hPfetwyjQ05Gak=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2cAZf5NYrJlmYCjgL0UMUXwXh1hAIwG6G5XVy2v04p79RfO3Z
	OpAYtVPZzT8wkMHiUzwnBuYnZiiA6gG8smVJM+pcCoDpK8zxKKEBi4J51SnrJa6NdNvLlrP+Tdi
	n2MQOQNsJjIk0qU3uhHcNKCMtxivYzTRhhQ0wiHT/SQ==
X-Gm-Gg: AZFdTZf+MNMksd6km9aXbjlc1gwqyGiEfQIvfFhzWp+DQDcca5s/DVlIWCfmAmQFMbR
	ucDz1jU0l64swPBGGVilgQcmoXgia7qDWFE3DvoVtJVAKQmkN8E3Ctp9ztQJpZlU4hRlikpQCr5
	PjEMSmXD6HQjw0dVBM+orQj2hCM7cDIV/hUJnNmLPqXdIEeeWIPmOzByTP/4xj+iZiYUtnqHKAo
	XbeKw9+scE//eHNE3Dney1Dn+wjuPX19yAYs6K/WSlcoil+uBx0xyjPcneTY9ej3bfzRu4FjDPy
	CAGfn+h4sMWmZwaN03gyjvv2X/S6NfTRIrRvYZKDcBXDNVr+hr+2GitoCj1x82Sh93mOLwgNZWI
	m0SbVkMwAAaL193kCbv2FP4hopLoq61H3SY7hSXjP7pip5J4lFSeqXV90d6qBnVNEgeeV8lHKXW
	dCzVtG8GIJS3D9Y1MAN5Lem2pvMflvoxpPMLs73o+mzoEjgYSvJ1p0MlKk6+W6RW62j8M1Iyfvu
	SqW8x3SslzUvmJxkvlXmvh7aT30l/EklvY5WthryIDfXiHby15DP0SF+ro=
X-Received: by 2002:aa7:d351:0:b0:6b4:86e1:cc67 with SMTP id
 4fb4d7f45d1cf-6ba37ea0b91mr1306429a12.27.1795173651526; Fri, 20 Nov 2026
 03:20:51 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260802031350.1468599-1-shuangpeng.kernel@gmail.com>
In-Reply-To: <20260802031350.1468599-1-shuangpeng.kernel@gmail.com>
From: Haris Iqbal <haris.iqbal@cloud.ionos.com>
Date: Fri, 20 Nov 2026 12:20:39 +0100
X-Gm-Features: Aa3M54plvx9H83qo4LJ7Ae2TaDMpFtDwJLUnuLmm5c3StPpYcDm0-SgN5HSqv5Q
Message-ID: <CAJpMwyjS_sCanPxHJAP7d_j4x8m9FQ4a8zq_nCc13jBZdXmVRw@mail.gmail.com>
Subject: Re: [PATCH] rnbd-clt: fix use-after-free on device sysfs creation failure
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Cc: Jack Wang <jinpu.wang@ionos.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 2, 2026 at 5:15=E2=80=AFAM Shuangpeng Bai
<shuangpeng.kernel@gmail.com> wrote:
>
> rnbd_clt_add_dev_kobj() initializes dev->kobj and adds it below the
> gendisk kobject after rnbd_clt_map_device() has returned a live
> rnbd_clt_dev to rnbd_clt_map_device_store().
>
> If kobject_init_and_add() fails, the helper currently calls
> kobject_put() on the embedded kobject. That put can drop the initial
> kobject reference and run rnbd_dev_release(), freeing dev. The caller
> then continues through the normal error path and calls
> rnbd_clt_unmap_device(dev, true, NULL), dereferencing the freed device.
>
> Leave the initialized kobject alive until the normal device teardown has
> completed and rnbd_clt_put_dev() drops the final device reference. Since
> kobject_init_and_add() failure can leave the kobject initialized but not
> present in sysfs, only call kobject_del() from rnbd_destroy_sysfs() when
> state_in_sysfs is set.
>
> Fixes: 581cf833cac4 ("block: rnbd: add .release to rnbd_dev_ktype")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

LGTM!
Acked-by: Md Haris Iqbal <haris.iqbal@ionos.com>

> ---
>  drivers/block/rnbd/rnbd-clt-sysfs.c | 2 +-
>  drivers/block/rnbd/rnbd-clt.c       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnb=
d-clt-sysfs.c
> index eb485e4c12e2..9f5d30659f3d 100644
> --- a/drivers/block/rnbd/rnbd-clt-sysfs.c
> +++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
> @@ -498,7 +498,7 @@ static int rnbd_clt_add_dev_kobj(struct rnbd_clt_dev =
*dev)
>         if (ret) {
>                 rnbd_clt_err(dev, "Failed to create device sysfs dir, err=
: %d\n",
>                               ret);
> -               kobject_put(&dev->kobj);
> +               return ret;
>         }
>         kobject_uevent(gd_kobj, KOBJ_ONLINE);
>
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.=
c
> index 4d6725a0035e..5fe5c7e259b7 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -1658,7 +1658,7 @@ static void rnbd_destroy_sysfs(struct rnbd_clt_dev =
*dev,
>                           const struct attribute *sysfs_self)
>  {
>         rnbd_clt_remove_dev_symlink(dev);
> -       if (dev->kobj.state_initialized) {
> +       if (dev->kobj.state_in_sysfs) {
>                 if (sysfs_self)
>                         /* To avoid deadlock firstly remove itself */
>                         sysfs_remove_file_self(&dev->kobj, sysfs_self);
> --
> 2.43.0
>


--=20

Regards
-Haris
