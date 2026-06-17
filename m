Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E70B2C11F9
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 00:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781656818; cv=none; b=b8T0P/RZUVcpUa0uZxxhiam8aA+ZKld0om7VZp+T87ROW0K3Whzll7HXyspuU0Ztl+LREGjc/MJ6tLajED5eqM+ZtyKUZByYzTkTd0HkpQd3KeiabmfxzpTJqeunuy4idq9TY0AJ0HXeqmWJKtrMeagfGkbAajjVM1oTSpVgFkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781656818; c=relaxed/simple;
	bh=AmEqrFgwVvBOCXxC9qxqTkY4QEcjXvas6ceI+HWMDmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kFeHB0QdY0EB9BrjpMBZe/hiIhybS4zFdddexcttBlSNbW8yZwXja8vLclrSq/dhsZtjot5RV6W+yOOsmx0mWl+J80RzXAH63nIrkO2PEFpssbR/W4UMh9HJGhpOWFYk1GqjpPvg7s8neYj4sgyky6bjXvuTrAjSk2FGm17EVFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjmCrLO3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjmCrLO3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453851F00AC4
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 00:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781656816;
	bh=nsPimvOxFtNpOsrcCdC4WZqlfbRzu95KX1Bfdk2/Wx0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fjmCrLO3zbAroMhw9rZ3qKRetjFLhR5TLTnehcYYd1ttflKewxORMDBP18zJy1vLE
	 kGlrB/DYFYMJoTbLhIRFle9oZrJw9ryG00rbfgEU9rBYBD5uGA6O8eVhNc9IG/GlGR
	 BpR0N6tyICgTUdoVHJgpf9KxETMgMNYr+nTKb2ZZRVhhgvmcayvFh/QQWY17M0WUQu
	 W8Solnx3sSpaecaZJpyRMN5ijnxCVlXzGW8PuPqIcKfeXRnYfbX4MtJf8pdQdby+nM
	 zRJ9LJLMhk7VAmt+cH7qf7fTAXLfsDyqJT6prcWIR28JyiWl8K3Ov3ct2hJnWCRcLB
	 bznjnPwl5B7GQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3966388b388so4030731fa.1
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 17:40:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8sFLGOvfC+IvfkJx/pV1tyD6Jxck3tL0l9dFoLCOYcoIzvIlCSbm0H5VBv1PtTCebqOsNVQUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw52RI6XLfWuDxeFsGVD7j6CGGahasWMRr1d3c1nTjiphnHK2iz
	qIkxN0AOkvUt/n3ff9huyepG5mi+FUmnD75qxgSFDbyt86FLxu4hofgylCBnApcpU7hrXo+tBvy
	Sd5s/dm1+VyUlwBYXl7xwiBy11l/pPDg=
X-Received: by 2002:a2e:be08:0:b0:38b:dd55:b71 with SMTP id
 38308e7fff4ca-3996a322bd5mr2098101fa.20.1781656814764; Tue, 16 Jun 2026
 17:40:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616111224.152140-1-senozhatsky@chromium.org> <20260616111224.152140-2-senozhatsky@chromium.org>
In-Reply-To: <20260616111224.152140-2-senozhatsky@chromium.org>
From: Sean Wang <sean.wang@kernel.org>
Date: Tue, 16 Jun 2026 19:40:01 -0500
X-Gmail-Original-Message-ID: <CAGp9LzpCMGr2hyVJRMehs_BD4Rk6mS2jAifWuCgBaANdqgtvqA@mail.gmail.com>
X-Gm-Features: AVVi8CePh02iDBIiYBUKoKLWcbC8GIPcYK15HYAKhoj7Eq4e84wo6CwYl-6iRWo
Message-ID: <CAGp9LzpCMGr2hyVJRMehs_BD4Rk6mS2jAifWuCgBaANdqgtvqA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Bluetooth: btmtksdio: correct btmtksdio_txrx_work()
 loop timeout check
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Mark-yw Chen <mark-yw.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Tomasz Figa <tfiga@chromium.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 16, 2026 at 6:15=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> The btmtksdio_txrx_work() loop is expected to be terminated if running
> for longer than 5*HZ.  However the timeout check is reversed:
> time_is_before_jiffies(old_jiffies + 5*HZ) evaluates to true when
> old_jiffies + 5*HZ is in the past i.e. when a timeout has occurred.
> Using OR with time_is_before_jiffies(txrx_timeout) means that:
> - before the 5-second timeout: the condition is `int_status || false`,
>   so it loops as long as there are pending interrupts.
> - after the 5-second timeout: the condition becomes `int_status || true`,
>   which is always true.
>
> Fix loop termination condition to actually enforce a 5*HZ timeout.
>
> Fixes: 26270bc189ea4 ("Bluetooth: btmtksdio: move interrupt service to wo=
rk")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  drivers/bluetooth/btmtksdio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.=
c
> index 5b0fab7b89b5..c6f80c419e90 100644
> --- a/drivers/bluetooth/btmtksdio.c
> +++ b/drivers/bluetooth/btmtksdio.c
> @@ -620,7 +620,7 @@ static void btmtksdio_txrx_work(struct work_struct *w=
ork)
>                         if (btmtksdio_rx_packet(bdev, rx_size) < 0)
>                                 bdev->hdev->stat.err_rx++;
>                 }
> -       } while (int_status || time_is_before_jiffies(txrx_timeout));
> +       } while (int_status && time_is_after_jiffies(txrx_timeout));
>

This patch has already been merged, so I think the series should be
respun based on the latest code.

>         /* Enable interrupt */
>         if (bdev->func->irq_handler)
> --
> 2.54.0.1136.gdb2ca164c4-goog
>
>
