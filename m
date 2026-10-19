Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D9B4848BE
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 06:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392976; cv=none; b=usJ0vY6ge/wxw5FyX2W1Pm34VRD33LbN/X63pGc8Vjgwy9cwX/CXZWbFVDaicN9tgU6n9pGq74ykDd0tyxyfkBJcs6W3lIDpolByNWOOEjPCljuYsqMjhcFL+5gcsLxE2gq3QvWQY229ZSFZie/1VTHU0TdYFlzzlEj23au+0eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392976; c=relaxed/simple;
	bh=M1tBQqzBGiCpQaTKxk2z3UZV5Za8hjx2LmCMzlbWuaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fUItph4GGK9U7tlTIcMrIYZ0GoOBDLAB6dL0OEqErN1v66cVJjs2Tr3HIe/Elixajtr/x69FHY5I/kcPGRvXPGEbz8RUcyMNvby+HJhqhiGdKkm2DGaCqhPAKwdJH/ylwbbUCJAR11NOplkoy18fUy/cjoLvAOlT/IInEwDs5NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-9908346255fso1476054241.1
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 23:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792392974; x=1792997774;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e1sVMAfuH6WXhZbotLQobiSRzr1r+7aDu2aCsNTstok=;
        b=I5zdstNphBfoZOH15yFhVTvkE6UDMOd2zEQbhGR9h8dxaQnwjEALO4HcS9QrrQbkaW
         /p132F6PxR3HU43I0/Mrdh7wcDbZKrK6IKUxACxgFIa4UOHYaItvrwXkEaY8rT9g+5qX
         6Y2aS8MbZ7lL1lOnC5odEw+fk+xD9+oiWN/K89CTP5OMfb7+pttrAfk7e/T02JH12OjP
         2GavS4rnD7goxPX0RebbmYoh8sLU7lmJLcoPx52X4kmGxuMgLKMJ+GfY2wr9X7tzTIfd
         twhvsZdW49nl7b8wJvF6psaBjcL/0ICd4ZRdORuwCcjNhNKrGqVN/jWObN8jljrL6GMm
         d39A==
X-Forwarded-Encrypted: i=1; AKwUvBzmksJCiP+EImrgNaj8FDcZD7xrmJOqjJgeTmVpVm0PZo4fB9vscKyJamqPEmNipr5kT81L7c0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBYYpPf41BkTCm7zme0RSHgsed660lNu/vuLREvd6839kzG6ar
	XW9vmcmC/dQwnCFTSmbYPEDR/SGovgfV/ivTPk/z123K2u2wnqIzRQRzHr+SiK1O
X-Gm-Gg: AYBFou1N0Tn70OAOFE0+2Y8bMSNF7FdtD+A6aR/0579STZUwkCDGfvIXrF65DhaZobE
	kZTM2qZnJYsowm8OZnNZQZawbc8hHPj0dV+v+7UhJlKrkbnURkSFrWCF/xo128bFC2bbO5eBYY5
	sbIek82rX9oG7yiVl6t94JtAtJ+dk2+ZMUcB97XHrYj/QcdKoDdRWlQOvqs2ww1ZeSEvF1RxbOv
	s4KL/A3mLJhnCGK5ala6+DNehn3BF1KWrY3XtwEU4e5+e9VOtbRFwOmiigywFjFrkXr9TNU0CEe
	JYqVVqQdU+XzuaLPiIxDauR/xLQs9b+/s3CfPvO4EufmSkvN1b3b8mkrkNS3dnPgZa/uWWQ7Y6b
	xx7A0uftJI8DDygihqOLUbIRwehGs6TIV1JPdCK5kbL3DMlqqJYGMtd/N4R4rrbgfDoNO1cNvBs
	bbkY80/zOWp93IwzZAoYI8mMMt6DRBVnKH0VQYj2DmSgctCsha23/nfpG0t9gdrgsPXeLycAqT+
	JMXf+bc43ittvXSPHR6QBkFXyryWWrDjbGb
X-Received: by 2002:a05:6102:61d6:20b0:7bc:58ff:2cc0 with SMTP id ada2fe7eead31-7cc1816d248mr1765053137.22.1792392974035;
        Sun, 18 Oct 2026 23:56:14 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-990835f457esm7589475241.8.2026.10.18.23.56.12
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 23:56:12 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9909e82513fso1126047241.0
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 23:56:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxDOZa2kZNw5GLmh8EeoknT1KnEVhVzd+WiZnmh0NucQnRSyx+hCofrzOxi0xFzZLdrId6ZRcs=@vger.kernel.org
X-Received: by 2002:a05:6102:312e:b0:7aa:d0a9:c5aa with SMTP id
 ada2fe7eead31-7cc18121fa2mr2108461137.18.1792392972220; Sun, 18 Oct 2026
 23:56:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261018161042.3298045-1-sahaj123.sc@gmail.com>
In-Reply-To: <20261018161042.3298045-1-sahaj123.sc@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 19 Oct 2026 08:56:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXdB+1zib0AtA5zoJ0UeZR4TYeUSiP2w1DEHZ=1yKGYBA@mail.gmail.com>
X-Gm-Features: AclHuK9VSv0QigMKGBrmgQqHURXBQJfLZxnvzcmSGSBGel5gQdO-OSfdEC31cxs
Message-ID: <CAMuHMdXdB+1zib0AtA5zoJ0UeZR4TYeUSiP2w1DEHZ=1yKGYBA@mail.gmail.com>
Subject: Re: [PATCH] gpio: pca953x: Preserve wakeup accounting on parent IRQ failure
To: Sahaj Chaudhari <sahaj123.sc@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulfh@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 18 Oct 2026 at 18:10, Sahaj Chaudhari <sahaj123.sc@gmail.com> wrote:
> pca953x_irq_set_wake() updates wakeup_path before asking the parent
> IRQ controller to change its wake state. If irq_set_irq_wake() fails,
> the IRQ core rolls back its wake state but the driver's counter remains
> changed.
>
> A failed enable can therefore leave the expander marked as part of the
> wakeup path when no child IRQ has successfully enabled wakeup. A failed
> disable can make the driver stop retaining power even though wakeup is
> still enabled. The suspend and resume paths use this counter to decide
> whether to disable or enable the regulator.
>
> Update wakeup_path only after the parent operation succeeds, leaving it
> unchanged on error.
>
> Fixes: f70fbc15bae2 ("gpio: pca953x: Configure wake-up path when wake-up is enabled")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sahaj Chaudhari <sahaj123.sc@gmail.com>

My bad...
Fixes: f70fbc15bae2c89f ("gpio: pca953x: Configure wake-up path when
wake-up is enabled")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
