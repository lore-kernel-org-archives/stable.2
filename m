Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9223AE6E9
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 08:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782289265; cv=none; b=bjWgauEqr6EiBkTjIkl+UR+0QtUVr0HcsZyqKlRUg4zYNRet5VTIO8LquJ5ILkTbp3qkGWIJd34y/qm3d268gjAYGaCfrN0NrGPMlCg54mTe8c5Y1nYUY5U1ovfngTdsRhkWuebHClo6YrLtZM5iReyoy7QVeN8+4F5GQvAjy9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782289265; c=relaxed/simple;
	bh=0PIQXIBwWTblSrwezZsAykJJlzRIu/DvJjLAjGlaniw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/bKJxM/FllTH3Jsn1XUVJOB5HxYmGvtX2dXS9HYbvka7g3w8srEH+FC32wCIKwzZ4Dhkb8xD4/yHq3E5QO9Q4//KLbwTdrrNeoS1t9G3WZPwPljSXntzHwB0EQnqPUc9OFtexyoaaQclmvuZZUJ1ZJAKMiFnGgniNs2/e+XgqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-59ccf81e74bso265704e0c.3
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 01:20:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782289255; x=1782894055;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//lmerhzWsIFojL0vyonPaqb0x3MIW6iIGNJCkIPu7g=;
        b=V+PhSXnfY2h0/FZhu2WPmdxPXlT68W6yb2RJT1gurpPjwuTvYMAJHzbpZJMDBe9U47
         u6kKRouFCmcqezxPY381H+0q0hwrgr7qUl+JdrBZaSmyYLiUNUj3//5qyZXgKDTKSfHz
         G7vCMecEo9O0eGODuAa6u+TSWBVnv2n0Dze1ZNG7cZD6q2a96pUU6GSqP/e6R30NptET
         DdvREdHukiLkCxo2eN5LEG++CMomD4T/gSk7+KLPjITxk3cNqUxVxiyJEWAcqOJoshjc
         qVHQBsZZjE2kV0il4vCr7osek//rwgjrQuIYp5p3DVSZ3nwBJP2x501GuPOKCGqkiMML
         U7fA==
X-Forwarded-Encrypted: i=1; AFNElJ+vDoUzqsCR8PIaFtCL4b2rTrBbA8Fu2Piz/+AQiMGfHnRjBXjAoqGzUgBZmNgfNdTToZ3eo9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt33dUxdwIAbSWY2yf6XCgm/rUJQc5Q70qonlMhxrORieA5A9o
	i0aYTuAac3DthQ7LLBg2h7ezLe7ltptGSTbc1rZKQS6PmCqVaA0Z57v2N6NP6NTd
X-Gm-Gg: AfdE7ckY4lQfhq064jjZTnCKgly2/o3sNJC8BIbc4i30dHtGdNDQ24hntoeqmmjPc0k
	EinT80FhV01zRL4kMlvrVPqt0fCFIdUBqkw5POtFDk3jmf7T/n3J13DxUtCYoy3JfTL43U65fbm
	tFatDB3eUDGKfjFLOu5rL3BcwOFsw5ep80T67M6Bq4M3m1rbSEY9AicRP90MUmopiR0FiWHqC9/
	wBeIbHcftx6JfLbtTwK5EgHYnID/eUCQnPS+94p4JGd8rcDQ6bYr+VHoalerX1rzyDdIt4fiBVQ
	fg5sMsbhT9BthCAsovvYcL3T0qQYPpakkU815MJ1NlGEoBfs4Df35K4pnbukoYkUanfA7IPAckM
	PjVpbjhbeqUTsicmQorDbKbFxWvLxK7H63O3EBSDSHDKSXzFarsfGuHiXQJ/HzL3MlJtL8dDnHm
	6cIqdProw/usxzVV0Ff4xrvjF0BcuqmsY/TEZAvZVPw/83GmrkFA==
X-Received: by 2002:a05:6122:45a1:b0:56e:f876:5626 with SMTP id 71dfb90a1353d-5bc301e3e0fmr2884561e0c.5.1782289254879;
        Wed, 24 Jun 2026 01:20:54 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bbfb89a95dsm11392967e0c.8.2026.06.24.01.20.52
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 01:20:52 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-6c3154fa46dso323591137.0
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 01:20:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/QETeK+9H3OLZYK2xkBZ7Plh1bC6x19UrOIeCiTun4+IjLjhOHb1YbdgJ63a+TiiSq+vv6RKk=@vger.kernel.org
X-Received: by 2002:a05:6102:2d07:b0:6a2:b2a1:f16a with SMTP id
 ada2fe7eead31-72fd549000bmr3729010137.2.1782289251907; Wed, 24 Jun 2026
 01:20:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623043150.1852957-1-haoxiang_li2024@163.com>
In-Reply-To: <20260623043150.1852957-1-haoxiang_li2024@163.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Jun 2026 10:20:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUDQK6SWjGzycqRvENQK1zJqdHuwdpKCsFD2260F-k-ZA@mail.gmail.com>
X-Gm-Features: AVVi8CeHAa5VJZI1MfSYBsTzrC6B4H3d3_kVNWXraHyNt8sFYhSM_6qd7a0mAHQ
Message-ID: <CAMuHMdUDQK6SWjGzycqRvENQK1zJqdHuwdpKCsFD2260F-k-ZA@mail.gmail.com>
Subject: Re: [PATCH] sh: kfr2r09: Fix serial I2C adapter reference leak
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	lethal@linux-sh.org, damm@igel.co.jp, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Haoxiang,

On Tue, 23 Jun 2026 at 23:16, Haoxiang Li <haoxiang_li2024@163.com> wrote:
> kfr2r09_serial_i2c_setup() gets I2C adapter 0 with i2c_get_adapter(),
> but returns without dropping the reference. Release the adapter with
> i2c_put_adapter() before returning from all paths after i2c_get_adapter()
> succeeds.
>
> Fixes: e6d8460aca63 ("sh: Improve kfr2r09 serial port setup code")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

Thanks for your patch!

Before posting (or better: writing) a patch, please check if it has been
posted before:
"[PATCH 0/2] sh: kfr2r09: fix i2c adapter leaks"
https://lore.kernel.org/20260508120601.426115-1-johan@kernel.org/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
