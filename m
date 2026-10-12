Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE3A282F17
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 01:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791769001; cv=pass; b=YQcaFBfBag5z2HRWsZRCQclV/QggHK0yZjz0yypSLIvWMQwEGXYJwpw7fV+MA2v6vqz4EfZB1bl6uANlGQ2thCtMh6uaJNBscBuZ1GNBTW11ijSNs5j6JghZNCnt9qHgS6YgaczU9K51F7Q4FZDVy4LJG5V43XM8TPypdSgMHv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791769001; c=relaxed/simple;
	bh=k7cEPBY0M9HJpO8NZ1kFN/9ydut0XOF0A6dmljcEM08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jd7obUxQSxeGzOKav98D2Yv4CxEo3aeISAbYY2VKqIffGKv1XZiDpccMaepxgB8TrF2BsCCpxesW0zKALK1nheD2MbCcMXKOYIbAfd9sXlq3a4R2q2MutqqznFIXVqT4M/d57Pz9bmKkYQgO8FQ688U/TG8/LYtkLsYq78Ez3TY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KU165k99; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KU165k99"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b1aa2848d2so1099729a12.3
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 18:36:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791768998; cv=none;
        d=google.com; s=arc-20260327;
        b=V9yvsmHcdB0WwtJyCqTBozXAacoyL+RYD08uUT8KXZE7CdTbKpg/yw5F/Xwts9pyEd
         QHDn2eE7XEDksPztiRm0I07a4SkXebnk4FO1vOt4q9tp/X0g7ojlyfnssmB9VQpRXKMA
         isDi5N/qSZ+Mil7beBZd8JLRmRQW/o8yx+IuhUJLQrS2lgUAgFGuCQtbrmTWzbTnKSA2
         vbltLQ8ZschHwsfvo50k3+sfJHgkJPXonW8mwVexs5xAZ6+wpKPurNpS5+Dk3gzVq38n
         AbXTaDnups8lKkrpnT+n3Ya0Sbhv82KXkAO3YVpm+ybSg/2YAQzOZMGUBYMfYxwK+nn1
         0xqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5SdnfbVL9pFpAWd31O9CWnKNvkrdORI7jh1LOwMsM0M=;
        fh=1zCFxPHhgDRGghAUTQaHQ+gvrpwnSgobgsMzdewLUA0=;
        b=ZBYDI2gFk33DCc/GTCSDqnGx2zyEj6xM2WosadShLgyilOWXAb11WZ1VwIGz8kTkhx
         rIi9RkFk6kh71uMSQM6KAcZqixbvReB4spo+0kkNKO8Z0Ew6N9FANRPajln0m/pR2nh9
         s/c1LIXu5H5I16zn+yh6gyKVsCyi3p2On3imaDgk4yckg6HgADnWDBIy7FkRLZ5xQ3Cv
         i2IRPNuJG9G3Ca/mxOSIQKHN78oSPCdFebGRsR0sa6hLoIYghuVES6cWrZNo8f0HSX8T
         giMchrmxA6GsR6fIuSPkYx08oogDJwv+3XYFr7oTCrUz6bFcQ0nutN6aoIuoT4JGWy3g
         cnqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791768998; x=1792373798; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5SdnfbVL9pFpAWd31O9CWnKNvkrdORI7jh1LOwMsM0M=;
        b=KU165k99OY9xFXdhIcC1vkwr3LFa3mk4ke6QWisDv8FHDeSc2gJLV67Nrlqyzc3U9L
         YgRkJDnldo7/gEjn+hCaDqH1za+JZ26R5U6+obcZ3EQ3FHcGkyuPR/6UThv329g8zGUR
         N0VWXMOPSsuIpvu4UnBgTHPJWDFadPlU1o0wcXvR2LNKtaOvvcP3GWKJlOorkGthfL+m
         LenyqYET+puiFs76+rmTxwYjkYsNI5yJ72vH+S1oEk/o7eG6tAf6gxX5MuFsCKKMdi0P
         AxrfbGBYftMbwouWGQFR4H4AUMwaqpVEhL1gFcoLzP4onT/UUC50lTHnq5KeSGYoE0ox
         EJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791768998; x=1792373798;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5SdnfbVL9pFpAWd31O9CWnKNvkrdORI7jh1LOwMsM0M=;
        b=cCGsye/JftA12EAmXF9AMUt63l5hLgogeeYh5CgpgHRu29sqoOLui/KOUhzqdesRQy
         sCaM5us9BCBofWMaXlscFXu8xywhiqJ/El3LS3hpzFMhq2gU8LiM5wFsB9biwd5xw0ry
         ssn8hzvdTnOkna0V/wCfafKvSLJmU/FEo2ztHb5ENp0PI2vCPfu2rSXP7SVmedFEOEpq
         tqsAZix6yaNFQ+kOnF/gGMLv6s9lTidSC6aHjojvD/J8D6LFqLxc+IvU7TZFw4sYgCu6
         qfT9y11a51CTenMneOM+NSxqvJyqUtOQEfkMl2gBacXS2DGAYBx48E0DizSUY68RUpaY
         lstA==
X-Forwarded-Encrypted: i=1; AKwUvBy0DPlScoHzWxR0MzTI9SKkTahepdPyFJfxmQ4yTfDhNFW4O83RGyVoHcZDSLCeSXa5pHMMIt8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLcRbhZ6RPr1GDusVrH7YLHAbMkc2rXZ1AtaN5U+fDzqUwZ3Vpa
	gng5ONvPa8lWObPKq798c8q1tbqRIN1CCEbnTgKzUXq33v4o08JjC5KeCzP0uiM7jk44EEfSqWA
	n91FiX0KwtdOQ7ziu3WGdWWnDjZcT0BQ=
X-Gm-Gg: AYBFou2/+QalhNKhv7sa2CJkC1u1WbI1Mn94zTfLHzoyzoyUgkf0e9Jk9pJv/knnxGm
	lZmyk/XU055H2Bjeh85GdIq68v+f7+psFyvxsWr0ghwCzNhEN2dWJzE2H6XoeiEnrGCXl6S3b5V
	MBUxd2x8IO4LOZH+XNc7Or4Z+G/evMRyWzv6n4g1Wmx1tGbwvQyqC7MlBbJ39S1uQdFFBL3vXfJ
	jLbJbvvGrqC6AsUUwQXAFleFBK7UIxrCBL1WVSIZZsDTspxMZkNCVTNSdjhJOpi8r37Pd6fUtjD
	2cbVWpeOhmHofv2TbstAPr2gTmZueYlc5YpQAPq0cLePJrj3vMYVa/LG
X-Received: by 2002:a05:6402:4512:b0:6ac:7d0c:2cb8 with SMTP id
 4fb4d7f45d1cf-6b17c26e26cmr7148152a12.30.1791768997999; Sun, 11 Oct 2026
 18:36:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917093923.2145007-1-vulab@iscas.ac.cn>
In-Reply-To: <20260917093923.2145007-1-vulab@iscas.ac.cn>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sun, 11 Oct 2026 20:36:24 -0500
X-Gm-Features: AclHuK8Xsk6vNaWsbsfsc6m-jN-PLUBFBJUyFrXzBO7nFbW8E4MZEEKbb4KwlQY
Message-ID: <CABb+yY2ZnisPFR1mXU-E-KEa6SWz2pKicYMeo13PCeHwpW6oAg@mail.gmail.com>
Subject: Re: [PATCH] mailbox: mtk-cmdq: Fix runtime PM leak in cmdq_mbox_flush()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: angelogioacchino.delregno@collabora.com, bibby.hsieh@mediatek.com, 
	ck.hu@mediatek.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	matthias.bgg@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 4:39=E2=80=AFAM Wentao Liang <vulab@iscas.ac.cn> wr=
ote:
>
> pm_runtime_get_sync() leaves the runtime PM usage counter incremented
> even when it fails, but cmdq_mbox_flush() returns the error without
> dropping it.  The same happens when the GCE thread does not drain in
> time and the function bails out with -EFAULT.
>
> Undo the reference on both error paths.
>
> Fixes: b0524f7c9635 ("mailbox: mediatek: implement flush function")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/mailbox/mtk-cmdq-mailbox.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmd=
q-mailbox.c
> index eadd340f8fee..07a8c2382c93 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -565,8 +565,10 @@ static int cmdq_mbox_flush(struct mbox_chan *chan, u=
nsigned long timeout)
>         int ret;
>
>         ret =3D pm_runtime_get_sync(cmdq->mbox.dev);
> -       if (ret < 0)
> +       if (ret < 0) {
> +               pm_runtime_put_noidle(cmdq->mbox.dev);
>                 return ret;
> +       }
>
>         spin_lock_irqsave(&thread->chan->lock, flags);
>         if (list_empty(&thread->task_busy_list))
> @@ -603,6 +605,9 @@ static int cmdq_mbox_flush(struct mbox_chan *chan, un=
signed long timeout)
>                 dev_err(cmdq->mbox.dev, "Fail to wait GCE thread 0x%x don=
e\n",
>                         (u32)(thread->base - cmdq->base));
>
> +               pm_runtime_mark_last_busy(cmdq->mbox.dev);
> +               pm_runtime_put_autosuspend(cmdq->mbox.dev);
> +
>                 return -EFAULT;
>         }
>         pm_runtime_mark_last_busy(cmdq->mbox.dev);
> --
> 2.34.1
>
Applied to mailbox/for-next

Thanks
Jassi
