Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B7B397688
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166207; cv=pass; b=SL17R8wopVAMi6I+yNdNF4SYM5IjvRxVidKlJPDbRDpnnagiHL87yKTFxnQVj4KYi9NRpXy1A2e5HeVfb+zwiavuurzdZfCq6akuyC7D2sn5nWFHlmpipJgE6SdERUXkrGcotSVYKBrugAdxab36nvqq05j8ZnUR5FR/WG3u6E8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166207; c=relaxed/simple;
	bh=KMguZ7AVQEmAtXUkdgP4AMIA4pmOukTAaFsuTXrTTgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KqXa3mPo9yMK/JsPsjwccXV14nodOSHnnlSOWuI4FyE9BcrD/rh01CeozWrbSr3F3RF3R7EqehXI7aLUSeadntpWM+HcT0OlxNMwOjIQBg/HWVz63Nf2abVWrzO1VJEUq53lwLBH7WEBql/c0FgrtWep27XlF02O0HVR7gFF+Og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=EOE57eoe; arc=pass smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="EOE57eoe"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-44c43edfcceso156036fac.3
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 08:30:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785166203; cv=none;
        d=google.com; s=arc-20260327;
        b=hLlhenKZCSFXP0H0tZpQ/GZZdDOKIuN4XyYvyQZzFQvOTHxdx5MZJhWR5iDUxpJTh7
         8mrdqNgZASTO02bV0LNf2/DUK2QFF5FwQX0FIBdVD1TfnDio405ls0LXUxmFpZFyU8m/
         GrQvRpcWLI7QBVuWb7Cr4QrawKvyLXhok2d7WiPWvf2Jo52s439ZY3ZHCMduIq0ah1UB
         ZGhCMkzWYPwD2OJHMHpk4WA0B6DlQTc3RiMkqmHLs1Dhu8LjyEsmDBd3k+yHbS/d9ycm
         HpI9FEX9W+Q3nQSv23iphJVbKQPnOPK/jjMK1M0tB/CuNOB4wzxpvM4lZnboqLQrjPa9
         4mUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2aNw+I7ysKX1IKI/G2FfmFMuAGEfwm/hbtrWFVd8MHA=;
        fh=jK2N/LneKuOMXQNSdbZGjfivmUCv/rn18LqvC7onb8s=;
        b=MGNDc+KS+/wanNrDIDT6OgxRuCMrJzMMsXaMMFLg7kVBew5NULn2pH+4QRSLqhnReh
         rsM15lCJ64PggYso3I1LmPZlRA+H2fKlfJJ1lvhJ9KIWCEXH3aRJZ8o9UHVsFLS/dfGO
         ABkvSw0WaGhlq8xGsVXtd4gagCA4OI6T1kzE8A9a3sNskdbIAtc9bjJRshFu+/v71WIo
         TrPQyhJXimgKKE1XOktgS22UKOvW/1yFO6LpejwFSlYfFwB5ZOnOa8YaZ2S4rTvTQvXK
         14qv/OS3zvwp/lzwms3tGmzZLLeQU0KrCBiYE+Rd4lbQFAyWAwY0py8C2kpEYnkeiHgn
         Ypmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1785166203; x=1785771003; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2aNw+I7ysKX1IKI/G2FfmFMuAGEfwm/hbtrWFVd8MHA=;
        b=EOE57eoeNmD5lt7GvS7wdQruqz1JvXYVkkkKLqR0hJPi0TUCUjWI/NgXgn/TqSt+oY
         ABMajo/tBYw1NC5Z6V5rLR8bb8ye3RMgLYPp+g/+oP+IU07DBoyUBHh29zShovHuAMxo
         sDwymuKe70m3M+vpIYMKDqKHpgERpNsc6l7l3ug+GyZR8obXfFHQ4lo0J5oKnC7oMy+2
         JhS7KZOJZVw1CPdGAKQMxdP5WQ790yVoqfWSUaFmdg7fxCen60Y6CVGZj8Ki8GQRwGtG
         BRJ0eBjm1oj9V5DEniNS5TblGdScpub1YMaNg3T0AXIfS5XU8cASKc8T5m2WvnzPhEeQ
         ECpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785166203; x=1785771003;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2aNw+I7ysKX1IKI/G2FfmFMuAGEfwm/hbtrWFVd8MHA=;
        b=VXKfY/n5M1nOf+Qon+rQz1mqwv9PZ/8hvWZnxRakYzznUL6sqJi4owzADP1V7Ks+db
         +RO9AHwwkIMpxFXReoBSmabhocCc/5Sxy60GasgzwG2oGZiuF0jJ3TK9ZP5IgIBXAbAb
         Ns6N75Iefg4qDxVKTN88gr6gZL84dvqf9xGz7ebdbLtSuXL55IQnPmDCufFywrp+4Cb3
         3QtkdoSUP1oO3Yk0lHBfskaj++MG1LMQ0xQfjW8LsXU6vt9hAYiT2gj7qLDvTGkmEtKX
         kvRUySsTDF6hpHKw0QwL3kghLeoxkU9tcfXCV9nsZ3kZWskkVw7iiZuEZ2O5sDTa1H57
         mjIw==
X-Forwarded-Encrypted: i=1; AHgh+Rp3VdoTS0j0b/bi7RXdzrDu58rpGvKIWPsEU+mUHO29a/jXPMs2UCdO5EmlT84SgMksDoTJC0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaYxcGr+JtxbAPZe1VnvSAQZcqDK9osSshWeeCnmSg0YCr6GeJ
	cid88kp2gcTSVXu2KjsmvMK14gbvDMHIS1Wy7MulW137vHZh/qEurh9oBeZB23yvqOktMYYbhrT
	ZVs7pJ9UvaCXLm+Jn4iiTDhq2NtRCDJ8QVxvuKqZvroS264vBale1E7wL+g==
X-Gm-Gg: AR+sD11vxGew++6FN75/BKdHGo+0bRADcNaJsJhajfDKg7Jq9wUC9rQFxEoA9VWheP9
	MauMd+JYXLSaR+2zSr0WjababSwWe+8AhWyrEPUxIWATh5Y9GRzuDn0M7B4KW7fFpJkxSknOK8g
	pee7Dilfetmb9aQ+DvhxBI/jYwGwOpEmNy3mlmF4MF0L+6H0C4RdASe8g0LJyhCGfNvf3RPX6ui
	XR0Bg1Ny+UCKn65MWaiX6I2WirLlefveTtNSU/kAAmg8Eyn3n/waOzrlq24cw==
X-Received: by 2002:a05:6870:7091:b0:452:112:77bf with SMTP id
 586e51a60fabf-45858d0f099mr420820fac.6.1785166202726; Mon, 27 Jul 2026
 08:30:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726145025.1507383-1-tom.leiming@gmail.com>
In-Reply-To: <20260726145025.1507383-1-tom.leiming@gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 27 Jul 2026 08:29:50 -0700
X-Gm-Features: AUfX_mwXrHK1kp2MH8JecsMREFrjHgs2ZEb-wIDc9x-ApCKJiMQoIb5IjLNQxtA
Message-ID: <CADUfDZr9Rpz6BNrVLtEysJWCgPxb6C-3tj6O6VL0e1ZQWG_wyA@mail.gmail.com>
Subject: Re: [PATCH] ublk: reset kernel-owned dev_info fields in ublk_ctrl_add_dev()
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 26, 2026 at 7:50=E2=80=AFAM Ming Lei <tom.leiming@gmail.com> wr=
ote:
>
> ublk_ctrl_add_dev() memcpy()s the userspace ublksrv_ctrl_dev_info into
> ub->dev_info and then fixes up the fields the driver owns, but misses
> ->state and ->ublksrv_pid.
>
> A device added with ->state =3D UBLK_S_DEV_LIVE passes the
> "->state !=3D UBLK_S_DEV_DEAD" test that ublk_stop_dev_unlocked() uses as=
 its
> proxy for "a disk is attached", while ->ub_disk is still NULL, so DEL_DEV
> right after ADD_DEV oopses in del_gendisk().  UBLK_S_DEV_QUIESCED plus
> UBLK_F_USER_RECOVERY dies one step earlier, in ublk_force_abort_dev().  A
> poisoned ->state also gets START_USER_RECOVERY and the char device
> read/write path onto a device that was never started, and wedges START_DE=
V
> at -EEXIST.  A poisoned ->ublksrv_pid just makes GET_DEV_INFO report an
> unrelated task as the ublk server.
>
> Reset both after the memcpy(), as ublk_detach_disk() does.  Userspace onl=
y
> ever reads these back, so correcting them silently breaks nothing.
>
> ADD_DEV has copied ->state in unsanitized since ublk was merged, but back
> then it was harmless: the gendisk was allocated during ADD_DEV, and both
> teardown and the START_DEV -EEXIST check keyed off disk_live() rather tha=
n
> ->state.  The oops became reachable once the disk allocation moved to
> START_DEV and those checks switched to ->state.
>
> Fixes: 6d9e6dfdf3b2 ("ublk: defer disk allocation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> ---
>  drivers/block/ublk_drv.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 4ca6ec738c93..2a22f9dc1f2f 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -4764,6 +4764,15 @@ static int ublk_ctrl_add_dev(const struct ublksrv_=
ctrl_cmd *header)
>         /* update device id */
>         ub->dev_info.dev_id =3D ub->ub_number;
>
> +       /*
> +        * ->state and ->ublksrv_pid are owned by the driver and only rea=
d back
> +        * by userspace, but they come from the copied-in dev_info, so re=
set
> +        * them. Otherwise a device added with ->state !=3D DEAD looks li=
ve while
> +        * ->ub_disk is still NULL.
> +        */
> +       ub->dev_info.state =3D UBLK_S_DEV_DEAD;
> +       ub->dev_info.ublksrv_pid =3D -1;
> +
>         /*
>          * 64bit flags will be copied back to userspace as feature
>          * negotiation result, so have to clear flags which driver
> --
> 2.55.0
>
