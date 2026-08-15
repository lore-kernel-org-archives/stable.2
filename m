Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D87C30D3EF
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 13:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786801159; cv=none; b=T4kaOKTJZz/LDnVMoCsSLKm4/gQFXq12GqJ4a1A+Fi1/oGkpbE7n/ON8MTuoCwjcr40T6OdS4MMMPwTLeikTt2ObP6hGrfmpi0hWnSR67/KSf3E0WtbuU5gfCZ1ZiP/fR2WT8BwCEK20Wsxw/d/d/EB4I0EUS1cR1zDYXggZn5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786801159; c=relaxed/simple;
	bh=nmeIeb4ghsgslzTmI3belGVuT1iKkYhP5Xqo4t9I41Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S4lUizdfg7iAeJDM4a8Ul0wjeYV8pjoUyNrZTchduHUriU9b6TMHyydNRallmcDq91gFSCkmV+GLyIcIZJTILdTHsAVDiAIhuCWT/bW3KvtvdpVemyEC1qpKdS3sog+8Vn1wnUAu1bXrWS6v81sT+IM0kXow3IqDNcmmVNbcqME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5bfb3347dc4so1348325e0c.0
        for <stable@vger.kernel.org>; Sat, 15 Aug 2026 06:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786801156; x=1787405956;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LehA2Ewcs8Da1Bm6VxmTUkZDqNIF6RALTN4HmF4fEVY=;
        b=e2/258HF/nt/sN4mU2WChUptlnq4TKhki39UPGF9uQX4Bn6gTT+Yo5RS3dGfHcvXeh
         2wDsrv6UhQSBXf3fvO0hTgY7ONqqB7l8+hYMkjEVK30BNiSkqG4rLdFoDg0nCcX/R68m
         r4ckoQPuGpcIrwHuuRM8xH20K0Z0w03QJvlsV5VBDuLDR6wqbyWilfXJ+l1gc2b+ryPp
         l9MyAZPFawDJIAuy8sZUo4e5V44WBKfirbCW30mR7YfIvlF5slyLEluFxJgoa2l/JduM
         cvHUh7//kHYOmT/p7f22jHXpwI/9BUvI7VHKUUiUG9wVIRicx2/AnwhOGhMD6PnuDrF6
         nv6A==
X-Forwarded-Encrypted: i=1; AHgh+RpIX1T0ZeEmCvHIGZQh8mVSgRZ6+tb/SKMLaUU5EM/diHokDd1v0RAhUgUbfaaaiGR8YZN1zyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzwWawadu+InDJY+Lt6ApJ9TWBzQ7nZbqRAL6TeIkhseYPeino
	3ivYsPd0n/ZP0ifju6TUg45WRbUGvlHmh29qpH4Nsq62MylYeiBvEtjVj228TH9STQQ=
X-Gm-Gg: AR+sD101XbncfD81bm14bPFGeSgSdakcORUBT2P4v9fonNrTA+DBFjfSJTNt++LyVB8
	OJ2JGnLWLB7PIdHQg7Tvm7kYevmY2XpzJFqxDD+eJ6znRkDx59AHU57rXx1LvQ65o7c7Y8JrjG+
	nzoOVMpkwyYMJtdYkWnXT9Ym8Qr0V/V7KGrMwChNZO2Jvp1jJyluOotXfxZw5QXywoREhsREQdJ
	v3H511iKOXfq5zzkFkQymmNu06UsLJEqf5Xhm0p0VyE45dbVu92uPXeYr478RMk9lo5z9H+beAE
	kUNF/CM1jkgtTTCfwweE3AX19gXbUU1Px2aAIChIgDJH39Pv3sZ2PQXtBt4645XPng4dpMv1Onl
	nLOX1b7nBnx5c/gi8p6bkyQEcAXa6SMcycDSFTxMILGIT4YoLsOBXkG8jNR4TgDs7KWZ/95PB9C
	SnjGfwIe3y9E8TRBZzoPEj0+1IjcbNtQlRwiV9G/ZdCxQeStandTwNCick3SZiYF3hQVwe2YRy9
	oQcD1XJbarOz/hRQbNNeaGsLXI=
X-Received: by 2002:a05:6123:b2:b0:5bd:fc20:1fc3 with SMTP id 71dfb90a1353d-5c591d14f50mr3261891e0c.4.1786801156095;
        Sat, 15 Aug 2026 06:39:16 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c597be30easm1679748e0c.15.2026.08.15.06.39.15
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Aug 2026 06:39:15 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-97622cc1f40so1088228241.3
        for <stable@vger.kernel.org>; Sat, 15 Aug 2026 06:39:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpaJOgo6WVO/wXBJA2jI6NhXGk3uejQaTiFcXtAc4ZDcBDYLFsN4RgbWWcMN2zvUYL6sswK0xY=@vger.kernel.org
X-Received: by 2002:a05:6122:884:b0:5bd:71cf:e97e with SMTP id
 71dfb90a1353d-5c591d14fdbmr2959910e0c.5.1786801155586; Sat, 15 Aug 2026
 06:39:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260815105950.1109-1-getshell@seu.edu.cn>
In-Reply-To: <20260815105950.1109-1-getshell@seu.edu.cn>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 15 Aug 2026 15:39:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXNu2U=Qv5ObE3bs-5+wnVo+4EEXD4oRcjqy1wLVrWjsg@mail.gmail.com>
X-Gm-Features: AcwNN1WmrRl39UXDmasKU4m-yO8EXt6nBW2XwFpVngIAjB3sbSMnsy-lsqg3m5o
Message-ID: <CAMuHMdXNu2U=Qv5ObE3bs-5+wnVo+4EEXD4oRcjqy1wLVrWjsg@mail.gmail.com>
Subject: Re: [PATCH v3] auxdisplay: charlcd: cancel backlight work on
 registration failure
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: Andy Shevchenko <andy@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Jianhao Xu <jianhao.xu@seu.edu.cn>, Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"

On Sat, 15 Aug 2026 at 13:00, Hongyan Xu <getshell@seu.edu.cn> wrote:
> With CONFIG_CHARLCD_BL_FLASH, charlcd_init() schedules bl_work before
> charlcd_register() calls misc_register(). If registration fails, the
> caller frees the charlcd object while delayed work still contains its
> address.
>
> Add charlcd_deinit() to cancel the delayed work and turn the backlight
> off. Use it for both registration rollback and normal unregistration.
>
> Fixes: 39f8ea46724e ("auxdisplay: charlcd: Extract character LCD core from misc/panel")
> Cc: stable@vger.kernel.org
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
> ---
> Changes in v3:
> - Add Cc: stable@vger.kernel.org (Miguel).
>
> Changes in v2:
> - Factor the backlight cleanup into charlcd_deinit() and reuse it from
>   charlcd_unregister() (Andy, Geert).
> - Add the Fixes tag (Andy).

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
