Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA483EC2F8
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 07:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784015453; cv=none; b=Xvamt02oVTqpFCdDpRA3y/0bS0cAwr+/goYY174r+uVnVjFvjvp62SajQYBywJT+1KVcJYZYDRqEfxJpcbOCX5Sa6tTr8PXLtp4ekxHDjeyj7Kq2NrLY6e5nIk5Fq8acjPI5SKewSGKNojrfJ4+yYFTkS6Gk1gScj84eZcnoT00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784015453; c=relaxed/simple;
	bh=iq8Kc5+SBapLqwF6ORCrQ5sCq4FaCemr05ZMk3EEWBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=azckhstba8qx3yvUCagSsWDCtQS+Cnm1XnJZ9QSUTB/rzabM8ZZEmbFVm3xxvwhJDrGMx/URyjk5+KtFZjGwkVgz3Lfu8yKc2mCuCzjyQPXZMFj6KwV5xiEOO1SPV4KQscB+71h1C+geWuErPevlNUfo0YXnBOXGeqntjHho2yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5bf959b820cso373705e0c.3
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 00:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784015451; x=1784620251;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yavgJsn42/mg7FbRzuzYhczZGQV3Jism9aLSRgEzMNU=;
        b=OGmAqBDDAmGe/wyUIKlxqc/1ZXjZNpOF0z25dRzeSsO7RIyCnR1G9ih4KaipIDFoEN
         MpkHfjzpALQpZ270NDX9ITNG4/M570kXdWiczZwYKdLnboMEGObKJKL5O0rJlaslnoQr
         3dsPWWulMbiiQbE/yJpQux+HTlsxIzOC2RdYz6yBgg7k0ZwqCLckVQUlgzZEn+u1LoWB
         z+3muaiedHaA5xkscxQdYvvx5lgODfJIdzthuYk4pgcdsMLixAHV/K6vq6/IR76LLknO
         cF3U2kzauCHALRf9jzQ6iXh8w7cm+rqXPJgU0qLgeAq1paFp18EtKyWpLOrbLPH1hc9+
         je7A==
X-Forwarded-Encrypted: i=1; AHgh+RoD8LQ22X80pYOOPDL5x6jQsQALsAfEaj4auv4zx7uJB/EW4O/D0wi9CGJ+T7B5wvhLU/6xp64=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMyQTVKzjK8TAA1ACA4X6sawABzo3bhsXpZr5gDh/ajsI1Myf4
	8oPZJKLeW1u92BkHBn1A37eU9+03awnk5a2DLhM0XFMIbLVgESw6WwwMrX9WWt2rekw=
X-Gm-Gg: AfdE7ckNGxX6f9hziG0i7jWfdeJbY07fqxbcP/mJu9GzrB7XLRDgXw5aSdUaIvcNvk+
	dCOU3ZFW+O0qfsYtOT7uZb5zvm4sKxBzcQgxpaQgJVp9D0mwYzCMuWdLZ3Bb6MM9CduvDQK0Guo
	RkVpIeKJgDbHF72Jbck8jLqku8guGpzJAXYcVoFywbfqNkZn1ZKzC9X0uAr5IPQrzTOsLHlNJ/s
	ZSbzGDJIiFS3ov+6wE5NO2/XOn6mU0jjcGzqa0mWRQQ/7gKTtt2S6pcoV31FQ7xwUfD/Ngrsutv
	bGL3b6A415QVEaZYnnNojXZNCev+xCe/SUu7gqH4c6cGicNfg6qN04YCMKkH0R1CHkGZ7mbw7Ai
	HTTyXJJcLmWQs8CFSqH5oa2CWjokzDLomqKQZKZurUO28QuP1AdeARXKNE6IWmMHVb5zkirKN2M
	4xTUmHBlIQ4Rik/TkiIU/28izkKorYrD5RHdmIcaBK6XlzPBX99w==
X-Received: by 2002:a05:6122:6e13:b0:5bf:8c77:e89a with SMTP id 71dfb90a1353d-5bfbf0a9d24mr7009359e0c.2.1784015450947;
        Tue, 14 Jul 2026 00:50:50 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c110f6e64dsm991645e0c.17.2026.07.14.00.50.50
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 00:50:50 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-969524c1a63so428831241.0
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 00:50:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoabM7DXNciVjzNjzV7zEeCjcU+LOF2wwMF0AQT73Oi1e9DMpO1mJ1v2YJXMn4qZVKjbhc81i0=@vger.kernel.org
X-Received: by 2002:a05:6102:1608:b0:739:15ef:cdfb with SMTP id
 ada2fe7eead31-74533b84395mr8279731137.5.1784015450565; Tue, 14 Jul 2026
 00:50:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710160450.64967-1-marek.vasut+renesas@mailbox.org>
 <CAMuHMdUQJ8mzUi0birB5f1KnCMX_QufHTgYB7AW=d3ZoFer+Yg@mail.gmail.com> <1d0d4074-90ca-4b33-9bd3-ff27aa0fd4d4@mailbox.org>
In-Reply-To: <1d0d4074-90ca-4b33-9bd3-ff27aa0fd4d4@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 Jul 2026 09:50:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWNcbMxONo=PaHqJnD1EErc8AzYLf0MceD+vt9UhmsVfQ@mail.gmail.com>
X-Gm-Features: AUfX_mxwFeauCKqv0YVOv7ObJuQMatx6kqMpuGapev3XA_vc1zBsK6ZaiEApGuY
Message-ID: <CAMuHMdWNcbMxONo=PaHqJnD1EErc8AzYLf0MceD+vt9UhmsVfQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: renesas: ironhide: Describe inline ECC carveouts
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

On Tue, 14 Jul 2026 at 01:27, Marek Vasut <marek.vasut@mailbox.org> wrote:
> On 7/13/26 11:11 AM, Geert Uytterhoeven wrote:
> >> +               ecc@1e66660000 {
> >> +                       reg = <0x1e 0x66660000 0x0 0x999a0000>;
> >> +                       no-map;
> >> +               };
> >
> > Given all DB[0-7]FSDRAMECCAREA00 registers on Ironhide contain
> > 0x0000cccc (md.l e98[0-3][7f]450 1), I think the last 3 regions should
> > start at offset 0xcccc0000 instead of 0x66660000, too.
> > As a bonus, we get 4.8 GiB back ;-)
> I asked about that part internally already, and yes, it does take away a
> lot of DRAM. I think it is safer to reserve more DRAM and have a stable
> system than reserve less DRAM and deal with potential stability issues.
> I also think we can always update the reserved memory nodes in the
> future and shrink them to make more DRAM available, once we know that it
> is safe to do so.

Agreed
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-fixes for v7.2.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
