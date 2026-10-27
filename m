Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793118176;
	b=cjWJ+Q63uzmxw8zOLtZzcHzTP+LJ4FKg+3pXqv8CxxdR5SWvLyr+d7H7cZoF44pvmYlu
	 ujR9/+s+y7NyqAaFqwR07eyfQvLnIeF9BhFYH0MwnVf53XGqfkJCQisjYVGB1y7GM3Lmw
	 QsWJWNNUA86VKFJyOfd4jFR5sQSQTy+b3Y7B68RYOkduCs8KqoPq3E784c+MtqQ0LH2jA
	 TwCg/xrQSYiIVuyrCLYniz9LYJSJm/+Nj2bhM2C/UahCSjgsLoP+nmcBfVW78Qbc97S54
	 53TxZ6NXYZzC+AqZf+VH4RDaHlZV7LYfj0vJ2/582DfXvxsS6C8nZejfGeHAJCOyaSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118176;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=j54dq75J+7uAbhmduFvYuY44W6HJdtNi7cBNY+H2V68=;
	b=Fq5YYRvDnubSrnBDmpSI0NFixjLD9DhPkE7V80T9ERcWl0/8msvfZIdqahR9fz0oQ5j8
	 gBJk9chNoXE0NFXqxmvDgrWgHWPF6t7KpMZ6ZRT14wXAnBO0xVAXuCZDIT6oCYBvm5Yr5
	 5ui13VoAjRKUpdPsWTigJWmxoU4OVNKVA8KGNy3K+EDoujr0KitRXi6QSvnXhJJqr/FBy
	 sT+QzNYg5/1+mmhOKaJDBoDZUPWGe0NT76rq626uTINA3jf+a9AQ3kHuUu9Qz3h9GfkZg
	 gAjyurZdUB33bHBSh5kJLV5egSVg/KjG4N1n9bWEEWVcVdXkmbszBKH4BUZEssO8mWA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dgV9nJRE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C95660A2631
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 16:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C95660A2631
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dgV9nJRE
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8ac8a2ac52bso455467b3.0
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:22:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793118175; cv=none;
        d=google.com; s=arc-20260327;
        b=ULBWeBydtrnuOUlF8QsnNllnWQWsG9ql1yKyXKd6tnFw/3KT56Z+QkTuxcHp4LMMvY
         D246kGzIeGzsD1QVnMQSlhacbMQxe1WcAqZzXorR6YA3zOFJ1oQHxsJLLD44pCviZQrA
         IqM91DvHL0szbd6w/GNdJHckU/Jus+QPStQfvYSAjnznSWBR5LNNjuEJsjWV89Ao57rk
         nM5xp3tgnD8vxXK6RDtDu8UMZWfLQBdxgdFpL6hWjH633PDL/z/znbPYal0cPBcxBR7D
         bmpI+1qbwpZ8E0GwrrZryTwsYYoTxR9z9bIG8yiOD/zQTvUxH5M11b8Y1A752v508sjM
         DmAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=j54dq75J+7uAbhmduFvYuY44W6HJdtNi7cBNY+H2V68=;
        fh=TV+IKsctmmGJuk6KNH+3eEKUsnIUiU3aSR/LNjOVfjg=;
        b=osWd8VikTDwroiOGtsrNeyTuAayxYZ8UutzXay7jlAwG0UiJqEeURUW7P7vk+AKiDL
         6dqaPZL/FeQgGeiGVZ34qjEzIV05zcI/S2cr/I3YdRnG8owyVbdaAvjpdCNPXyxMbvks
         EQ/TLmV/u40A/n+9UFPJpzGw9m7cGdLzL8VGo4qfOat/OzZVnS6i4/x4ICx34DZYb4zI
         GX0wrdtSfi0sJvDA88eEvnXEObCXkv1mWixE1n1ZIUVfC7rWZCn0woOsxdfVddpeV+bK
         15/M/49Q6oT0wV3RgL3XIiGHCW/dz+mr0tHav5rmYu5X0wVP6p/ori9wscla2isgiI4h
         JpsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793118175; x=1793722975; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j54dq75J+7uAbhmduFvYuY44W6HJdtNi7cBNY+H2V68=;
        b=dgV9nJREEGJRJ9QmZnqkErrAe+48xCQlxpl768uv/UFrYOpJ5vGmw1FdZrXRTu2cXN
         xdxn9LTkyvYmnAfpAeId+I87c6foglCe0e7IOk+MUjOI0KWkQ5+6WvOzSkNuiegFa62z
         PgVusNWxO5SqIq2OHRAWlFvaZ4SD4HksuK8nvqBBVkZdxU4f+5hyNawB365EHUmD50SX
         xd1fP9w+WSJT26mMvdN+TZLDrWisKuL/C2T22PkvAWscLcIZmOC/mHidXEnM+pQa+f8E
         GwVzeEnIaj18wcAo07Wb3PNMFzzLUXjv3OQJVqky8xgIUWOBLVSB7oHfumhlX4TLFuuv
         +9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793118175; x=1793722975;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j54dq75J+7uAbhmduFvYuY44W6HJdtNi7cBNY+H2V68=;
        b=bVhBSenzp6MSnH/YTZlblfPGeYJR+8nRaK9PO4UUDJIw7s+j7NZVg0rQaudli6NGF5
         eSm4W02RgAm7PQ5qySKofxolOkKqOOw9jDZjQseWQyUNmVn2IP50MYnrkvY8KLMyQ0w8
         kwroGRpPxkY2IJbGhRiYcfHzZpUchCSecDvBaNFD5BneD79v9IjV9iu7x9dTNO0Z/CdN
         TiBuOAIrTAFg05P7PoBqOnJibdVUsOCD6fTVXAzQ2UPXVqjlEdPn+0DZSCEADZcv55yp
         D/pcaaITvcc5Eg4671tJcUmxADEwFgR1g1CJtpSxhiAh6Sv78+bCIIXtFOENhEq11VID
         TeyQ==
X-Forwarded-Encrypted: i=1; AKwUvBzjXiIDRGSwVjRyYb4/X2ZDm42KnwED9sDy82aGb/GTduwkfM9vZuW5o+BDfDKKQQeJqdwgTbU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIjav/1ZaGlsVT5avph3xz2QO0rJSE8aG1HkTFKKUzftDXpm772
	gKOzUQjLUQzl5Xam0cui/wNuyY0QJS6Zgq2/ajvGt5vgUF2tqgRqETWXwg6t/6YraZcfjNSojC+
	3d3Dr0RWmbghmdN6VmcfcgZtVRNpWyYU=
X-Gm-Gg: AYBFou0l/VgdGLfjRV+xkmkXGdGb48C+vQvys6aYGdj0iwqUE9rBS4q1u5iG5dFOcoH
	a05uJfd/HfvRRToNHFCZVWP+1gBknQh1Et4oUCfxxxIbyDCu5Q4kL+hWiqTSvhgeo0rFK9HG91h
	fgmHa7gtSYT6skPCB1iFDukaB/6Gc1fXHbjCxqa/3Y7wl/i1EX2iPekxYEC+flItaDtP2XinQYx
	2lhff93vm0yCM65yfrl67Vk/6BO7XEZM9lLRsgvLkzuyBkx/Abo80EZCnfeeJ0x6deyxEy5JnyX
	KONBP1011k/8U4U9VL1nzUAhP1K5cLWzeL4jb9GDySSxc1AUShNUdWgiFzGCgXWiBQgj4Zaxoeq
	Y+6f8PxxLINDpW/UoGPXfMrOVNrVXwF5B32jUcA==
X-Received: by 2002:a05:690c:fcc:b0:8a8:316e:5973 with SMTP id
 00721157ae682-8b19c9f0c84mr27894277b3.14.1793118175296; Tue, 27 Oct 2026
 09:22:55 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027032609.119226-1-lgs201920130244@gmail.com> <f342a5e4-82b3-4044-85a3-10cad08595e4@kernel.org>
In-Reply-To: <f342a5e4-82b3-4044-85a3-10cad08595e4@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 28 Oct 2026 00:22:44 +0800
X-Gm-Features: AclHuK_rUH-wQYjXcUxpNAITglYIi677x8p05GEnBtjGRev3n8Z0DOrQJ-qbQ2Q
Message-ID: <CANUHTR-SJTiQvo__wbqosSQV958fkHGY33YTRFor2=EwDTdXPg@mail.gmail.com>
Subject: Re: [PATCH] mfd: twl6040: fix IRQ action memory leaks during teardown
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>, 
	Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, 
	Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, mfd@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Tue, 27 Oct 2026 at 23:33, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 27/10/2026 04:26, Guangshuo Li wrote:
> > twl6040_remove() currently removes the regmap IRQ chip before
> > removing the MFD child devices. This destroys the IRQ mappings
> > before the child drivers can release their interrupt handlers.
> >
> > The parent driver also registers READY and thermal interrupt
> > handlers using devm_request_threaded_irq(). These handlers are
> > normally released by device-managed cleanup after remove returns,
> > when the corresponding IRQ descriptors have already been removed.
> >
> > Consequently, free_irq() cannot find the IRQ descriptors and the
> > allocated struct irqaction objects are not freed. The associated
> > IRQ threads also cannot be stopped through the normal cleanup path.
> >
> > The probe error paths have a similar issue, as they destroy the IRQ
> > chip before the device-managed IRQ handlers are released.
> >
> > Remove the MFD child devices first, then explicitly free the
> > parent's READY and thermal IRQ handlers using devm_free_irq()
> > before removing the regmap IRQ chip.
> >
> > Also update the probe error paths to release successfully requested
> > IRQs before destroying their mappings.
> >
>
> More of postings by bot ignoring any feedback.
>
> Best regards,
> Krzysztof

Thank you for your feedback, and I apologize if our recent submissions
gave the impression that we were ignoring your previous comments.

We did take your earlier suggestions into account and subsequently
submitted a patch series accordingly.

For the more recent patches, however, since they address issues in
different drivers, we thought it would be more appropriate to submit
them separately rather than group them into a single series.

We certainly did not intend to disregard your feedback. We appreciate
your time and guidance, and we will be more careful with our future
submissions.

Thank you for your understanding.

Best regards,
Guangshuo Li
