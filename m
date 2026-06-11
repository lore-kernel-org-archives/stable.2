Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4517219CD1D
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 21:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781213326; cv=pass; b=eD4uNsaeeJqvrGbi3SO+b+Dyn/q4jW9D3RjKrDZbH2FicTFw2LvRID4IrZUMA3XyBWnrQ+Q2ab2uPQ+m7w9NkUL0tm6Kj+UwEEgMzMRNHMa+pDIzeTqx5MgvnygCDPEOfIZ+3/PjNz1Gl9nOKRjcPcv+y0SszPyHQFwoYqdlskU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781213326; c=relaxed/simple;
	bh=JG0UY0hvctnnEYPQF9ZNiBocNFE2TPO4VyqhkwRG92g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XTfyAACXH8R1Sbbt5o1s7qqYuZkKRAg3ux9LK8T65b93xg3XqT9UQBmKx9gy58DvdvygrHbqwUM+/3/RyyTzM6libufwhVqsLg+5NNLQBk5XIgG8D9LYOjOWxU/LSy3t7Nz3ort/l90OW2zvrAHPjXa3ENbPNytMoKq5ZCTqqNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxKLmXbz; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxKLmXbz"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-396aacc5bcfso2866581fa.3
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 14:28:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781213322; cv=none;
        d=google.com; s=arc-20240605;
        b=iP3s84wU1koDjZhKiNBjgMiOk1EYz6rQ0yC+6IwCkdRmJ3C/VKQd7aRHFXJUbGOfjT
         SwA24D6N0bWgDzlxhykvfFMgYy+s4C2qPhCFU2aIGoRf+dJqeelX2Kgc4uExoeKPJbYZ
         mUF6NJ58XCfn60knfu7TuTvKFg6R7VyPz2qSW3KpR4ebGxvejqqzMVdNE7H5jsA3SOoK
         3wP3p1474/GwM6Q+HUuEDKyauU5/VGgsK5frWLliGZQGMGs8zlw4ohVRAK8PeN6kEheq
         sUJUrgGxj995UY5AwhUs6ldd6GBNkCdEy7kJb0HvhiSZjAneGxhsBSM/rUFQrkqmYypW
         CCkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kSiS9b/TUc41z1o4dQeNRT9cctSComdBL7vLtn1IdDE=;
        fh=lXwxGxrQ65epqb9RuyE3aAmz6EVqBh5biIqpIqvxNeQ=;
        b=fennjAIOrNay3e7A95RHHb2+skP75uyoudzfuhYvrDAyd/F63Dd8IQQgCHvRfkrnjR
         UZ9oFZC+VJ45BmP2mua55Ijy+OWgkPBP/RfvEcvPiKAPx71WeL684uVMq1SkzcysRm0x
         SwFlA57A7kO3Pg1x68sGv/4AQP8fFqwyMMgblAXM6Gy+2MthdktmoSNW+gPG9fZ/ut2w
         yphlYoWjIwu7tCTqnCloU7c4xUsS49vePPLCeZ0X6zb8JqkGRz6JGgs08CvSIh1HbLno
         ihq9kp24taOM3sKxX2eFPBQf1s5+uXcgFYlF3Y3zOyQ+tICMOl9ZI0yw9PUzSYWn31nD
         Nvnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781213322; x=1781818122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSiS9b/TUc41z1o4dQeNRT9cctSComdBL7vLtn1IdDE=;
        b=QxKLmXbzSrkfMbSN7IcFxO/glPZNelMpCBHTyFR/1Qx9lK0WYKcQTHifBw4NuJ29r+
         dlbIe4A/VwmiMmYc2PX6SmZp/4520tClKBuvInjVtTkKGAmjZrtuZLnRvX9J+rF6uF1w
         8c0AoR2gdrmjzSvgmu/++jpXZKnhdr2GXGATaI5anogSch/t5UVAp1lB088kZAmhCvhf
         qqLSjZBpdCO7NuAnQxVvhys4HF1ZfVljnx+hAzD3wpNnujQIgGK0WPepKXNmkBeAtbll
         xW9801Er2jeIp9X2DsG7PE7YX9+u7wy6nVqCdLEOOULI/2fyuKabIAvcvE3HLg56n+c5
         bnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781213322; x=1781818122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kSiS9b/TUc41z1o4dQeNRT9cctSComdBL7vLtn1IdDE=;
        b=mx6vNp/DbmX8A2TGnywlRhCLKQNGLvWkbYwpZn8rK2Ulx4YPEOq9m5bWjg2RDHA+R9
         CgvM4k5vnCwna12rA8idRi4x/SQuQY86ocBmx/m3iaFtI+2V9tpvB96kaw4mosuyCN8q
         NUuZQuKNMo4wkO3lk6U2xgIca26iN+JeZjSXd9ADHQuSrWYAAEj5da8apHbQRjTW0cOi
         cQL2akBufQjMprDEfm47V1p9NFdW4t23OS1WjQClaB/ZxPRzd91CRIqkWcycf3qjI4uf
         WRiurkJnXAqngLabmcdXMDh376m+DyuYBlThNqmSSmzwX6L7QFaRet1H5ImxuuHTNKxh
         M8uw==
X-Forwarded-Encrypted: i=1; AFNElJ/l9vbF6t+O++/zYtauVNUfpSei0lfYcmWb2OLhZfmA5DMGpRY2Qvy9CJw55Z2bhaNo+wC3O40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz3nRNWDkxa8y8oH3f1S9Gi4tTDy0jtDnfRhqRZYCR5lq57Lps
	3DOhppumjPMxNHEB9zloxF7a7KPTUFhYf2xX3qBlt0eyZp7OM5/JsLCme79GWskKFbLjpQMiqoK
	aF3z6u7Jiq5fRZs4SZPptDNweo9a+gzY=
X-Gm-Gg: Acq92OHYIoual06mLAQWWAH/bWVXoN1kdGU+eeKNnEFJhcfelpjlkYLWeudVveqD1kP
	K6K99s/Brhlbs8Hwa9wcVxD5YN+s509sVhCiJmW6cPq9FxrBSfS5cnpIrQ5APnO+VjsriLsTQHJ
	2TjAHry+QTR0PIAdGl3uU+USTXKAT0mD2az3YneQrARZBWMDKIvK6jizGQ+Et3dG3Fv77u0xM1/
	ONxmZ1mRpTfkP2SWLZKcdql+8I39ipzipmSgG0XxoXzjiEljBfaeKzQVTK/tlZ7KLYroSi/suPM
	6l8mjIJa
X-Received: by 2002:a05:651c:2107:b0:38e:d3ec:4f87 with SMTP id
 38308e7fff4ca-3992b27b888mr126891fa.21.1781213322252; Thu, 11 Jun 2026
 14:28:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611151848.2573316-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260611151848.2573316-1-runyu.xiao@seu.edu.cn>
From: Steve deRosier <derosier@gmail.com>
Date: Thu, 11 Jun 2026 14:28:04 -0700
X-Gm-Features: AVVi8CcdEwJqkM5Tqp2QM09ml7ba32VLHw3QbyaKpzeUkeRS1S1Zxfwfe-iE90c
Message-ID: <CALLGbRKs0ETDKNQXyCEJniGMj3htJgYmNn55_upcwjvS+0poyg@mail.gmail.com>
Subject: Re: [PATCH] wifi: libertas_tf: kill shared URB before resubmitting it
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: linux-wireless@vger.kernel.org, libertas-dev@lists.infradead.org, 
	linville@tuxdriver.com, luisca@cozybit.com, linux-kernel@vger.kernel.org, 
	jianhao.xu@seu.edu.cn, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 8:19=E2=80=AFAM Runyu Xiao <runyu.xiao@seu.edu.cn> =
wrote:
>
> libertas_tf's usb_tx_block() reuses a shared send URB and immediately
> does usb_fill_bulk_urb() plus usb_submit_urb() on it. Depending on the
> caller, that shared carrier is either cardp->tx_urb or cardp->cmd_urb.
> There is no patch-local usb_kill_urb() before reuse, and the file-local
> completion path provides no busy flag, completion, or other ownership
> handoff that would make active reuse safe.
>
> A running system can reach this through if_usb_host_to_card() for normal
> data or command traffic, if_usb_issue_boot_command() for firmware boot
> commands, and if_usb_send_fw_pkt() for firmware download packets. Those
> paths all feed back into the same helper, so a second submission can
> refill and resubmit an URB while the previous transfer is still active.
>
> The issue was found by our static analysis tool and manually audited on
> Linux v6.18.21. It was further validated with a focused QEMU no-device KC=
SAN
> harness, which reproduced active reuse of both shared carriers:
> cardp->tx_urb through if_usb_host_to_card(), and cardp->cmd_urb through
> if_usb_issue_boot_command() and if_usb_send_fw_pkt().
>
> Call usb_kill_urb(urb) after selecting the shared target URB and before
> refilling it, so both tx_urb and cmd_urb are quiesced before reuse.
>
> Fixes: c305a19a0d0a ("libertas_tf: usb specific functions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  drivers/net/wireless/marvell/libertas_tf/if_usb.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/wireless/marvell/libertas_tf/if_usb.c b/drivers/=
net/wireless/marvell/libertas_tf/if_usb.c
> index 5662a244f82a..7542956d3c47 100644
> --- a/drivers/net/wireless/marvell/libertas_tf/if_usb.c
> +++ b/drivers/net/wireless/marvell/libertas_tf/if_usb.c
> @@ -387,6 +387,8 @@ static int usb_tx_block(struct if_usb_card *cardp, ui=
nt8_t *payload,
>         else
>                 urb =3D cardp->cmd_urb;
>
> +       usb_kill_urb(urb);
> +
>         usb_fill_bulk_urb(urb, cardp->udev,
>                           usb_sndbulkpipe(cardp->udev,
>                                           cardp->ep_out),
> --
> 2.34.1

So, If I'm reading this right, you've basically compile checked and
such on this, but you haven't actually tried this on real hardware. If
you had, you'd have noticed it splats all over the place.
`usb_kill_urb()` can not be called from within an atomic context and 3
of the 5 contexts where this is called are atomic.

You've gone and fixed a very unlikely but theoretical race condition
in a way that causes actual real damage.

This is targeting an old Marvell 8388 which is a 802.11b/g chip. With
a custom thin-firmware created by Cozybit for OLPC and AFAIK only ever
used on those units. While I appreciate the "fix it for sake of
correctness" (if indeed this would fix it, which clearly it doesn't),
I'm not sure what the value proposition is for fixing something that
basically isn't used anymore.

Anyway, this is a hard NACK.

- Steve
