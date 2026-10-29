Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793261405;
	b=uc/OHiUf6vjGd7tn4KPjuhk75a2/YxzK319DEWCVZ7u7Pp69suW8zGzxc4G+QmJXq3t6
	 qgtNDma9W5s2Hv+UeQGhXnwae7wja2zMIiAIqmz6rsoRYFKqlAsTfbdeXMcd1BmFosCsS
	 WN6REIISIrO5hoyDDHJvRFfa8cHfWuuGmWWa756H8MPU0X/lSTy6WwbI9Em8Mtp8N061F
	 y4abwVKsXNcokmv46s8nTQKp2icfnpfQltZs/swXyXmwo04dNKkjboIcXnMi67PI3CIE8
	 uFWWfhPW7q/ClmCiqpKa96SiMReus6FybmfsfrPm68ocSpdIqFVAe2v3IS6yPUS1cRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793261405;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=j1N3C4wGR9ui6A1aTKEotaU/WbKyfzJohGbZeH+69Ss=;
	b=5qIg0H+ygbLHkcDDdep7yM+TzRRt+T5S7/Fbz75eoXzoAvKUXU/9TDqMbJZkfgPR5jtS
	 Opc05BHDP36zVkCDn3B7ErZ/3LGaYWWCmgk1uwLkQCRJtaqTkqWDxnrG2t+75QLpC10uL
	 z4yar0JjxJ1NnNmvUQFQKH4Ns/dT0UW0OcqZqEtACldp11eZS+HTExS0NBVvtxd4YKBg7
	 +nYGcukthDw2U8T21H7LEvoZ/VUZswc2wuO16poffLWoDfFfBsbn3283/TIF0LukIpNmg
	 m1xiuya+CxEHkA0k9e96E9kaA2D2hsH7F9yZikZ19rHE0OoXH3ZzyogmSKvLNn1Mxug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B10606A324
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 08:10:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50B10606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5eac319a6c2so1974561e0c.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 01:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793261403; x=1793866203;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j1N3C4wGR9ui6A1aTKEotaU/WbKyfzJohGbZeH+69Ss=;
        b=Sk+tWVgqFA84p3wU9jVAKODfmcyzAqBBQRokz8DTWqCK41oqnW6tN35wAwT49yXu2z
         xYWdHrriCb5quigh9bTBiT3rzmoQTAmMP8zUbTgDzYzq0QH5ykA4cWIDwjwpsdmUgxdB
         RtG8x6r2wgoS+AQ4CxymUVVz51XY1MBtUrT07kHgBeVvHk+Ka460ALFrZNHN5QJYD6A6
         eR61jn4gAExfXme1a7rPcF0ffOrPgmJ2dr4pE3Pmf++pLyvfVssxxQKwYGOG+OuQXOMS
         Vnzh2D87IGxZ8EKCb/BOufnxZ1nvRH4fIkRaTAVZwnLwBUa1hYhTrKRHYU0U2uzCPHfi
         Egxw==
X-Forwarded-Encrypted: i=1; AKwUvBwdN2DZcvXTzSRRp2O203US4OVaMxrF0V7rfMCDVaOgXPOBlS0QRKzZzEM0ZL1SKG0/tSf6Gfc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLq1pxcawmF4knTYTcVOs1ou4j1SGF9YDrPypBgnvKBYOKmr8cb
	zRnBlYK9m159oXfxtkiT75h7G1x8QoHU1tpZlXpsP0Fv1lVhFe4RWGFgY69eb/cy
X-Gm-Gg: AYBFou0RCNelNPLly6ny5Jy17iKunQZoc71+sWVxYzlS8eV/K+GctYVilXvAhjHW5Ju
	+Lq+VvjdxTnCik3DkYJvToCLobn8xPM3Sd/XvUj6ey4Sv44GRyKGMoQDQqoPc1ECYSiDL7KKMv6
	MgN6qJF8NHt93kIkJCzJToImsMYY4Vi5FNs8Of8GWRGSN0d22M+J111J6H89TNWDv85pcbB4k7i
	0YNaUcT4k8F7KQyJbeaVGAqRM1t8PVPB1pcwfKmNWSissfmDe7FPnY47DZGbUIdZVNpVxATQpbu
	YkJBcQB1jLaAMfi9wWGpP46EPLYjQJT4pU8KRYyw+Adtz90gFASXEaHHrgkKF/HVb64GFNx0VZV
	MMUIxEQiIp5Ikl4s4pcOfCyv3nyt59bctASbXKHtLibpZV58zshv23Ot+zlw0nCZoajrafX1CMW
	b8YckPQyHN4ZAHZ3y7iNQ8+O023lnPe5nRzeEHqaVVtrV/1GbGS6v9cv+8hNELdEwfLDwZ+0aGe
	ifqYd7O+bUMo6324suZ1qzdMzCY6DTz5ycAovz7Zw3MwHv/uwo5z1xhz6CZYJ3nGaAY+GvUtTSH
	+HprXQnM7YNDpg5GZ+y/+9zg4iPbt9D+nnf+ucDrejQfMQHkXMTB+gjVvy4SPh4Fn87JZnFrW7w
	lCR0wrUEvbU+T
X-Received: by 2002:a05:6122:2211:b0:5ec:3e18:a8fa with SMTP id 71dfb90a1353d-5ec4cc8d85dmr2406599e0c.20.1793261403188;
        Thu, 29 Oct 2026 01:10:03 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec4f909163sm4579685e0c.7.2026.10.29.01.10.02
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 01:10:02 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-98c78660542so1461352241.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 01:10:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzP5q6Dsw/P5xSQJgNSKlx0Vw7rGIhSjuag58b7tL7BxUGZSRwtbZ+i9toCD/FRADHM2w5Njdc=@vger.kernel.org
X-Received: by 2002:a05:6102:3eca:b0:7c3:f07c:f49c with SMTP id
 ada2fe7eead31-7d03a503c53mr2112556137.11.1793261402712; Thu, 29 Oct 2026
 01:10:02 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027160914.3787276-1-bestswngs@gmail.com>
In-Reply-To: <20261027160914.3787276-1-bestswngs@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 29 Oct 2026 09:09:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUBAFGH-YoF5iTSXuX=tFjXXQhXYyxnT=-XJ6qEGym7PQ@mail.gmail.com>
X-Gm-Features: AclHuK98HJBR5jB_yT7cph-_YLUIP8WBWM3UvHpqvO4YtLNQFtBwwRQ_iZsfTT4
Message-ID: <CAMuHMdUBAFGH-YoF5iTSXuX=tFjXXQhXYyxnT=-XJ6qEGym7PQ@mail.gmail.com>
Subject: Re: [PATCH v3] fbdev: vfb: Validate framebuffer geometry and memory size
To: Weiming Shi <bestswngs@gmail.com>
Cc: Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	co+b0df61d49532b2ee@bugs.sh, Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Weiming,

On Tue, 27 Oct 2026 at 17:16, Weiming Shi <bestswngs@gmail.com> wrote:
> FBIOPUT_VSCREENINFO can supply a virtual width large enough to
> overflow get_line_length()'s int multiplication and bypass the
> video-memory limit, allowing fbcon to write past the framebuffer. The
> offset additions can also wrap, while an excessive videomemorysize
> module parameter can be truncated when PAGE_ALIGN() is assigned to
> unsigned int.
>
> Cap framebuffer geometry at 8192 x 8192 and video memory at 512 MiB,
> keeping the stride, framebuffer-size, and generic fbdev drawing
> calculations within their destination types.
>
> KASAN reports:
>
>   BUG: KASAN: vmalloc-out-of-bounds in sys_fillrect
>     drivers/video/fbdev/core/sysfillrect.c:24
>   Write of size 8 at addr ffa0000001671000 by task poc/198
>   sys_fillrect
>     drivers/video/fbdev/core/sysfillrect.c:24
>   bit_clear_margins
>     drivers/video/fbdev/core/bitblit.c:247
>   fbcon_clear_margins.constprop.0
>     drivers/video/fbdev/core/fbcon.c:1410
>   fbcon_switch
>     drivers/video/fbdev/core/fbcon.c:2261
>   redraw_screen
>     drivers/tty/vt/vt.c:994
>   fbcon_modechanged
>     drivers/video/fbdev/core/fbcon.c:2693
>   fbcon_update_vcs
>     drivers/video/fbdev/core/fbcon.c:2732
>
> Cc: stable@vger.kernel.org
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: <co+b0df61d49532b2ee@bugs.sh>
> Suggested-by: Helge Deller <deller@gmx.de>
> Assisted-by: LLM
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

Thanks for your patch, which is now commit f93dd31db3e23e61 ("fbdev:
vfb: Validate framebuffer geometry and memory size") in fbdev/for-next.

> --- a/drivers/video/fbdev/vfb.c
> +++ b/drivers/video/fbdev/vfb.c
> @@ -31,6 +31,9 @@
>       */
>
>  #define VIDEOMEMSIZE   (1*1024*1024)   /* 1 MB */
> +#define MAX_VIDEOMEMSIZE       (512UL * 1024 * 1024)

Is there any point in having a larger limit than 256 MiB
(i.e. MAX_XRES * MAX_YRES * 32 bpp)?

> +#define MAX_XRES               8192U
> +#define MAX_YRES               8192U
>
>  static void *videomemory;
>  static u_long videomemorysize = VIDEOMEMSIZE;
> @@ -142,6 +145,10 @@ static int vfb_check_var(struct fb_var_screeninfo *var,
>                 var->xres = 1;
>         if (!var->yres)
>                 var->yres = 1;
> +       var->xres = min(var->xres, MAX_XRES);
> +       var->yres = min(var->yres, MAX_YRES);
> +       var->xres_virtual = min(var->xres_virtual, MAX_XRES);
> +       var->yres_virtual = min(var->yres_virtual, MAX_YRES);

This violates fbdev API rounding rules:
  1. If a value doesn't fit, it must be rounded up by the driver,
  2. If a value is too large, -EINVAL must be returned.

>         if (var->xres > var->xres_virtual)
>                 var->xres_virtual = var->xres;
>         if (var->yres > var->yres_virtual)
> @@ -159,6 +166,9 @@ static int vfb_check_var(struct fb_var_screeninfo *var,
>         else
>                 return -EINVAL;
>
> +       var->xoffset = min(var->xoffset, MAX_XRES - var->xres);
> +       var->yoffset = min(var->yoffset, MAX_YRES - var->yres);

Likewise.

> +
>         if (var->xres_virtual < var->xoffset + var->xres)
>                 var->xres_virtual = var->xoffset + var->xres;
>         if (var->yres_virtual < var->yoffset + var->yres)
> @@ -434,9 +444,12 @@ static int __init vfb_setup(char *options)
>  static int vfb_probe(struct platform_device *dev)
>  {
>         struct fb_info *info;
> -       unsigned int size = PAGE_ALIGN(videomemorysize);
> +       unsigned int size;
>         int retval = -ENOMEM;
>
> +       videomemorysize = min(videomemorysize, MAX_VIDEOMEMSIZE);
> +       size = PAGE_ALIGN(videomemorysize);

Perhaps return -EINVAL, too?

> +
>         /*
>          * For real video cards we use ioremap.
>          */

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
