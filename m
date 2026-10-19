Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC26A50EC15
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419264; cv=none; b=d/1pFJ1pLHGz63X78S7sEG54WSPuxASn4PsDCXwwX6/7ZcUCp8QHaELx+31TngaxLkwhj6Q/JM7753ymvyQxmE4gpbi6ygg7Ne1oRiwTUCkfL8fb2Yy7KZ0q/n+kFFGzveZGBW8tx8euGstxUUF2D1pBSEq113R/b6AOK7eK91A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419264; c=relaxed/simple;
	bh=z/uufzOKyhdC0SjTvaevqnoNwnyGbdyLeYjrkpbtR/E=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NYk2dBCdTgOzuttSanEyi16QkoV2vRNoN5Jv23qHs2OQ0w9fVCOiMBS5CxoqmrDFJIupUNYKoIThSj04dZkn7oLf1T2aph/OLiaqukX7UeY0AUHqogUp03IExPI+h6AEy5AyFOpZD50JNI4LLGlhghnGDA061wAHOVpMBGinvm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBUHhcuQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBUHhcuQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A9D1F000C9
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 14:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792419263;
	bh=z/uufzOKyhdC0SjTvaevqnoNwnyGbdyLeYjrkpbtR/E=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=lBUHhcuQ1STY21Ac1q2PUTzl/4AVgeJXFxkITlHi37DiWe+2JlOfLrEsENA9BRdni
	 N7hB2BPfsAIjthXNjNAV4zEXD9FGYlMbjOM69FIxSjF1JBoqeV8oYXJe5MXXeuhgug
	 4nLLfvUTB9OfoI1OWwrHYOmD1/vo9oXS5eeUurPFHDK/aYA59zPiMyjSZFl1ydE6WU
	 pDw+WQs2itn4ovf02s6pLG5moZR2IcnD2vmj1Dv+p7O+Q/i9DF467GjIuE4kxhUyfz
	 TZlTYpNro3cdc9rSm+fxwqtAQRX/zqU8HcWJi9n5ia8FZ0T47nyjIECcMgf9+IjKqb
	 OsMVWocR7bY0Q==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3ab3dd9681fso8524511fa.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 07:14:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxR76X3pxNpuXc33jA65pDEZT4AkLwmlBWkK6VeXovwjPNT6RdZR6WbWWeXGnMqzxfJMhciBYk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLKN21EbVkg9XS9Ccy6irCsrIsZef8krLx6o49h83JeqZL7clPr
	mj6Ca2vYAsO6Xp7A6IemmatZ9+6YhbEgZy3FEbPQGwh3dy7DNsWnjruwL58od1fC1UPDmysjrTJ
	BobtgBTIwNKaYAveyEUB5m/Akzzqw7oHn8DX/9I5t/Q==
X-Received: by 2002:a2e:b8d5:0:b0:3ab:2d6a:1a1c with SMTP id
 38308e7fff4ca-3ab2d6a1c38mr16436591fa.12.1792419262054; Mon, 19 Oct 2026
 07:14:22 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 10:14:20 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 10:14:20 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <atX8mpg19_WkIa27@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261018-vlv-dsi-owned-gpios-v1-1-3ca18bcda670@gmail.com>
 <atXp2NSPKZUPj8sq@ashevche-desk.local> <CAL-Wm=O-Gr3CuvCn8iSQceQMhu=LGFz0SPhmWeFL=RiVnoprdw@mail.gmail.com>
 <atX8mpg19_WkIa27@ashevche-desk.local>
Date: Mon, 19 Oct 2026 10:14:20 -0400
X-Gmail-Original-Message-ID: <CAMRc=Mcrt8JVEUKLw+k_Duidi2Yuf=j61ViidR=aiUnjE5TZUQ@mail.gmail.com>
X-Gm-Features: AclHuK8c9Lee5KOPnjoOwLwBKEDawbnB4l1kQfS7VfHTiarAnxS_Er4MQ7HyRIQ
Message-ID: <CAMRc=Mcrt8JVEUKLw+k_Duidi2Yuf=j61ViidR=aiUnjE5TZUQ@mail.gmail.com>
Subject: Re: [PATCH] drm/i915/dsi: Use owned panel/backlight GPIOs in VLV MIPI sequences
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	intel-gfx@lists.freedesktop.org, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Hans de Goede <hansg@kernel.org>, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Michael Anderson <mwwa919@gmail.com>, Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Oct 2026 13:18:50 +0200, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> said:
> +Cc: Bart (as GPIOLIB maintainer and author of the reset-gpio rework).
>
> On Mon, Oct 19, 2026 at 07:03:57AM -0400, Michael Anderson wrote:
>> Thanks for looking at this. I'd like to make sure I understand before
>> doing a v2.
>>
>> Here both users of pin 10 are i915 itself: intel_dsi_vbt_gpio_init()
>> takes it as the "backlight" enable GPIO (soc_panel_gpio_table,
>> PPS_BLC_SOC), and the VBT MIPI sequences on this tablet then toggle the
>> same pin as the panel reset (low in ASSERT_RESET, high-low-high in
>> DEASSERT_RESET). Do you mean describing pin 10 with a software-node
>> "reset-gpios" reference and having both paths go through
>> reset_control_*(), or something else?
>>
>> One concern: the VBT drives explicit pulses on the pin, and shared reset
>> controls are refcounted, so a pulse from one path wouldn't reach the line
>> while the other holds it deasserted. Would an exclusive reset obtained
>> once by i915 and used by both paths work instead, or am I missing how
>> reset-gpio handles this?
>
> But then it sounds like the request-by-demand?
> Bart, any ideas how to address this case?
>

Yeah. If you need a more complex sequence than what refcounted reset-gpio or
gpio-shared-proxy can provide (for instance a timed pulse) then you probably
need to look at implementing a power sequencer using drivers/power/sequencing/.

Bart
