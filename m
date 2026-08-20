Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8B5442FDA
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 17:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787247805; cv=pass; b=Hmt2mPvlPXO9Ihv5WTrFJVwf00sw4YJBJ0ljTqzxF5XtATh128wHcwuAOMnlTajUyX4PnGSyFp9K87wso02EMjmm8Vax1VPHMSs+RG52JgdmqYQoAafajLDTia7YxAnR1WuqybMJtAWSSiogm7y7lZoml5xws4iWt+ENdebL6nQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787247805; c=relaxed/simple;
	bh=MQi8gDLxZ00zQxu8L8w6TUjdhk0EmiUxnn8U9Ksso/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7jWNg3UyaN6sUf2ONu3f2zXwrWVF0VHM78TPptUqCcGBrt7hvbhOhg880g1hMewOavHpLVlqU2C4Hz62Db3jcqK+LHE5ModUs0qzQoow/er8ZfYEBFXylW1tqJf3e8Pw4dYSM5PLxuCMq9gA1sJMEgPle59Hhm5eOg+dnfOihc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=eFf/SBTE; arc=pass smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="eFf/SBTE"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-448b69cfc6dso66003fac.3
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 10:43:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787247802; cv=none;
        d=google.com; s=arc-20260327;
        b=qJUHNIwUe5oNq/rxVTRqGcme1bxoWIvzC0FuKLbA6POIaEDCB40sEYaj3/yhtu2G1X
         Bxu68rqPJhD6STAbynmLNV3C5xIRe4qMx/sGhYYxMnncAkF8IK7elaqkBYCwygy96XrS
         Uvb531mzlE+mTyCQDNFOkXbIwO/hp/wlJI4TFYjd4FkCd8aBCqS7c2LkcxTgcd8mZNCx
         eYYLVUo/T3LTMV65nYEFJxB5LQwnTSlIp5KOpoNF4PyHeI0MpCYrEiYqLw5DaFx3eQdz
         dTxQ/zNc7VwdHex/bAv/hym2paZjqfSmvtIlUhFR9P8AFdyJpt8MbGTQPThncrjzcH3B
         B/gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7eL6FQ/USBPX2RQ0Gd6bBRBvrCoiJLr6erKFtCfBdHw=;
        fh=o4t3W0LpiU0EFu2UFBBuvFV0Y1uRxHDu1A9XvemnEoU=;
        b=OzPxcONlLN3f/iv/XITomUu1BqfP25P/dqAAFmRp8l9tSnwCCtp5FQNymLXqQNV2wD
         SA3z5B4H6Dx7N6bKHuFyOZWvyMaHIrheFI71tU98HTBTEmESuK6h5y73m+FM47y7I8/1
         mHgZwfDHBiXTltVbeyqwgiZ2D5nY19Gs5IhGoqYpRXy4iPR2Fpoi29eOmP/ILMPQfa4i
         /GKOf9JMG+Zy41iZ+VSSiucJfznex++XBwRUL3SQa3sK9PBknX8eXCEdIDXUmtAZWs+I
         zDvlN1wglplUHGPKAmdqeEoOmh6jF0Hzfdv2PCgZnaKYVa9QQOr2SEQm2AXZ0eKh2a7H
         mPWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1787247802; x=1787852602; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7eL6FQ/USBPX2RQ0Gd6bBRBvrCoiJLr6erKFtCfBdHw=;
        b=eFf/SBTEj8l731GxDy6oOoKJ4N+lIITJ5ScK6m+N++KHtWMZy5QtbaMVFHruviKkZJ
         BGujtBxO4GtFq2m76uweAnqxHF0tUk3EpRiz4ub7KGB1AJi/7eZUJxiohTNp9ptsP8kt
         N7w/mC3IgRE2qbu7f3wDhbXpm6i9gZC0Skn2YDQsqfQ7RmS+2/67M8rq9642NOauCZMb
         OivKuiAjyDjzftMYsRZcJHEM+8VsQ+K0yaNwfxDkieLN3toD5ycfEqEurGieKYADrgpA
         7aQYNooj6AUpoIpy67qLqnTteIvajo13zDLjEYeTMMSzrv2noJFQ3e/9a8uGs3nIIkRT
         KAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787247802; x=1787852602;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7eL6FQ/USBPX2RQ0Gd6bBRBvrCoiJLr6erKFtCfBdHw=;
        b=jrtGU1zlNznDDiq6PEs459RjweF3jmfBLL2F73vAJRFSmtBfU86S6fhObLJwUwePuC
         2/yVhy1eHlVDSUt7BcFg5FCLp1meTlOLVdtv5Wc2p47mI+pv8bAwRUi32OMO3zIHCEFR
         opOlnxq5iZDFsVxR8EPoQRgiqCKZ65T/JSVs8YiTA0m44jCcbF+zBRETBGu6WkMtVGEm
         HClkfSvTwm3WeAwestWcOqgLwVjVmdqOnY19Vd+eHFnOjUuVZCTJAKfP14eFroikir35
         Fc/2sU3yPJ6ricFoU6Z4stMbwXmq6e4MTwjeZoBE9g2I18fe412Wt4wHUi5Xl2puSkeK
         qE6A==
X-Forwarded-Encrypted: i=1; AHgh+RrIP7yltVu6xmHoYBV21cHYBlvYRhCcBwdWlTa1uddgN8/lnBmO0nAa6aTgAO70QfA4N/B7RFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlUY22pk3iEhJKIKiXDc+iXc36Zn9Zqufxo9swBewWBlyOdkc7
	kk8s5zd3kRg9FNROkhtmrjcMum//J9TD5qb1xYFshSw3SszsqYNg+yOonbk4L6WxS4dAAk4v89S
	xYtGQOQ0wSXQU3LH0nbFN+MYXJvvkdFqB/unE8fkEMHu7CPdXwbCcZLBphQ==
X-Gm-Gg: AR+sD11p13ka2hUelW4U4uqG9mvkGN64nfMJeb4c2zFEaCNNC8bR4b0GLAjGvXZDq0h
	0G/XQId8RRjjDZ2XK1wrGaTkv6Li1aAPx4QQjY1ztl3irRJr7FTTxsYGWEM/LNavYngW44NKurX
	Un9lvyAncy+gSFoJgQyBKtuPQ0wwf50z4NknK6l+k4MkB2N/qAsMSOCDQw+WqqzgTQL6CS9J8UF
	7jbRsfu5QIIRBkDCVxM0SZP0H8tWQPI8MbvBAxHfqp1ff5fKgHZH3qmpePQOu86wBt7d+9pw/fF
	+WccWUhgAJEWbxLy8rbjBXVWVY4c2YgtBoquUcX6WMpdqGeBeCb25rpaINSmJ3bZkPLXMtnll0b
	dOCg08P1kQPU6o1D1TPDR/Ltgqiyowzqvq8AohVnibcQXEdP7Jb8U0il0gdk8
X-Received: by 2002:a05:6870:610e:b0:45e:de9f:e019 with SMTP id
 586e51a60fabf-462f69bebc7mr14233259fac.21.1787247802475; Thu, 20 Aug 2026
 10:43:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820065340.3765457-1-gonglinkai@kylinos.cn>
In-Reply-To: <20260820065340.3765457-1-gonglinkai@kylinos.cn>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 20 Aug 2026 18:43:05 +0100
X-Gm-Features: AcwNN1W2Lre5-E7B9PhxwavzSSjkrGP8rkzlLuGb6eam34DkKNdWQZ4y079Jp24
Message-ID: <CAPY8ntBO5Rk6dEcRc9SgYKpgF6=KBxg7STpLT02whQ8pY-BW0w@mail.gmail.com>
Subject: Re: [PATCH] Input: raspberrypi-ts - reject out-of-range point counts
 and slot IDs
To: Linkai Gong <gonglinkai@kylinos.cn>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>, Rob Herring <robh@kernel.org>, Eric Anholt <eric@anholt.net>, 
	linux-input@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Linkai

On Thu, 20 Aug 2026 at 08:29, Linkai Gong <gonglinkai@kylinos.cn> wrote:
>
> rpi_ts_poll() copies a firmware snapshot and walks regs.point[] using
> num_points. The array has RPI_TS_MAX_SUPPORTED_POINTS entries, and the
> GPU is documented to report 0-10 points (99 invalidates the copy).
>
> A corrupted count would index past that snapshot. Slot IDs are a 4-bit
> field (0-15) while only 10 MT slots are allocated. Drop the whole frame
> instead of clamping, so a bad report cannot update a subset of contacts.

This touch driver is only used with the original Pi DSI display when
used with the legacy, firmware driven, display stack. Raspberry Pi
have considered that display stack deprecated for at least 4 years.
Our guidance is to use the edt-ft5x06 driver alongside the vc4 DRM driver.

TBH I'd support dropping this driver entirely. Will anyone object if I
send a patch to do that?

> Fixes: 0b9f28fed3f7 ("Input: add official Raspberry Pi's touchscreen driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>
> ---
>  drivers/input/touchscreen/raspberrypi-ts.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/input/touchscreen/raspberrypi-ts.c b/drivers/input/touchscreen/raspberrypi-ts.c
> index 841d39a449b3..bd63d95c094b 100644
> --- a/drivers/input/touchscreen/raspberrypi-ts.c
> +++ b/drivers/input/touchscreen/raspberrypi-ts.c
> @@ -78,6 +78,7 @@ static void rpi_ts_poll(struct input_dev *input)
>                  ts->fw_regs_va + offsetof(struct rpi_ts_regs, num_points));
>
>         if (regs.num_points == RPI_TS_NPOINTS_REG_INVALIDATE ||
> +           regs.num_points > RPI_TS_MAX_SUPPORTED_POINTS ||
>             (regs.num_points == 0 && ts->known_ids == 0))
>                 return;
>
> @@ -87,6 +88,9 @@ static void rpi_ts_poll(struct input_dev *input)
>                 touchid = (regs.point[i].yh >> 4) & 0xf;
>                 event_type = (regs.point[i].xh >> 6) & 0x03;
>
> +               if (touchid >= RPI_TS_MAX_SUPPORTED_POINTS)
> +                       return;
> +

Can you just abort here?
If this was with i > 0 then there has already been 1 or more
input_mt_slot(), input_mt_report_slot_state(), and
touchscreen_report_pos() calls which update the device state.
True input_mt_sync_frame() / input_sync() haven't been called to
report the event to userspace, but my gut feel is that the next poll
won't necessarily reset those events in the device state. I'm happy to
be corrected by someone who knows the input subsystem better.

  Dave

>                 modified_ids |= BIT(touchid);
>
>                 if (event_type == RPI_TS_FTS_TOUCH_DOWN ||
> --
> 2.25.1
>
>
