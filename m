Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521223E008F
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784190433; cv=pass; b=jpohp6mZIUKZtXdcX1znuApndwSwb8EgfgM0jTkuVjqEZQVnhHVBSSVhWfC2Ghvkn/3WSD1ibK1DTfIfVms0gpr7uXLOSyzYVPHT0m2hTgbgKYT6sol1FKwPHIRZ8vZUtwdQM40O6oDdSCFB+5E0YpNhTWDYlr+u/ZIDYQj8VNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784190433; c=relaxed/simple;
	bh=WFACAylUZ0HP0xKRoQatfOWkwjndONJlJvIWE6oL+4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J2gh/2gxTCunj8FQohIyBtva5nA5C00ryDVA9+bkgmW+ysqjZKgbDhQAVJzziZLje82Xt6Hp7eKOx38gW7cBWr0NOfOoZY85eTT7WPDvwRvLt4eONt3Uc/ssE9b6KdMLarMeuPx0umt5WIDgycvULh4UzFm4+VkccmUAhxGq6jI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6LgO2SW; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6LgO2SW"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-80c5cb9a888so56138437b3.3
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 01:27:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784190430; cv=none;
        d=google.com; s=arc-20260327;
        b=a5S+12QxxFkwIoJRkKOSMFyvfQCEswcaQrwpyhZ0tFmgGkzZmsfXkj9Wiy+kg7eYNK
         K66M65y6p6eirbZAvhRd4KDdo44BA2VMUwo+PIRgyqnva1wBwWC1Ue3w3GXv6LkF3HLK
         ydIyefO6/MtCicK/t1aVcHyR5NS1vwuGO2pojFBPQaXyXdiyINzp8fG88Jw51GOfkyNb
         FgEa4OwSTNQ1s6XT9Orun9TIcaeeIwk/vtL4Kf0/hAVNmVaiwIkzIsGXRxWQzmwMl/6D
         9MgZ0xWW8cJHky2NlQuDJdHqPALIHm3nyZtUHUcChuGgX1KazIDhnulKro35inBWccgO
         58wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vpauZo/tgDqjVS5OsHV+PB/DFoQC8D96R3Vc7c3M6nA=;
        fh=tePmOakVd+0uHuJeSpcnylJLWuKfWH4EzURfkEPwVDk=;
        b=YolZgYsBFVp4p7Xxfn5Ssxz9Jv8eASn76WIEM3ogmMbwb161KnGGusPwsvdjHgNgU5
         nYGxP6FEbiy5fyQZ4lIPr2hpvfe4LuyIPgLwEgTWN/iOTEqeIMnCUowunExi1ZdWe/HM
         PGqQV0HjHhy0PttgXb2gKmd3KiBELE3jJVzAJD8wZxkKgPfos1Fj+yVGqbFv2xZX1Azu
         8SCdQsLO0PzArz38xIlEQ5OJMJWu6R8DtGdGVBo6YPomUFE2/ZyLzkai0wpCi6rsgyKf
         s24S7qdkTAaAjoogs/Dh40NpGCqXSzif6g+7hvNeNDsBa/ZuhdantSumKcUxO0/CRspo
         z7dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784190430; x=1784795230; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vpauZo/tgDqjVS5OsHV+PB/DFoQC8D96R3Vc7c3M6nA=;
        b=W6LgO2SWL5QDpZXmPfGEPy8zyeAJnEvl4LX9VwymExoOUzSiV/6/rkeklopECpqgPe
         Fr+XGjwrkIN/e3DjlWe/z4KVf6fERyGi6ZQaQWHimrF9z2kyKSFN7QQIXoYLI8BP7V09
         mNYs+JhHJUx3/HAprU4I1kTgvXZ5gNJlA+d+0l4t/N0gnNW1bENDXi2VNJKms6VGItaW
         W6OZIo6HeFoqI8EyxzLfjSRSm4IRQ5gFqEYMi3JUYRIqcrSUqlusLUZ8aZrNn5e/Ezef
         guVqcBjLAdcV1MbhJxsXdB+LuSSlZXxokTYSUSH0uWf9xNlrnKqOKVePNNA+Quk1/lCW
         R87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784190430; x=1784795230;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vpauZo/tgDqjVS5OsHV+PB/DFoQC8D96R3Vc7c3M6nA=;
        b=Z24O7gdrV9gX1JBhd+wUCUqVmp7My/Ef3BzfwueFEAO9O4fI6tZGDJ//FvRfIQ81zu
         buzY5uq9Lqdr0IIrjHx/5dT5BtAoSAo8Qsy9SeqYLeZGeYTNvyGXQaHPNr6usm/aqW6J
         JvFWuMFdKEt0D66dlP5u667T0LXheTG/v429nwpgVOR4+QsaTq/sImA1bQueRYO15yIa
         ukm87X5crxI1l53H3xC/+hIyoNnRqAEJqJAT5jLQ5ZRYjJS+5bJOH4e0hp0xxoQhChRe
         k1ennUOiTfxfvsU2C5k0bYbWvTugnXl0219XCkQzKZCCiXSilO1/RsFZj0S83q550+Ja
         hJdw==
X-Forwarded-Encrypted: i=1; AHgh+RqlNlDcVfyMA7auwET/EY5HvmCyRgoHixlRH3FWWvnyR8Q97I8+RfshFuClVOxG9Q1jGxxEt0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2BGW4oIs05x96N87F9Aq20bdU0hWgl0a7TeSFoqYmJ2cojDsQ
	WlyBX5CMd/6zOg10Je2HAtaL9t3M2E/N72KQnrW0eM3xe2qEa8+uQSY5SBXt7ScOM43UVKxmSL7
	oMjx6Uncwjt/b8hHOi564OUNDJvJSoxQ=
X-Gm-Gg: AfdE7cllS8vgUwsHZpt6gBtt+nNRr3c8E0UzvUSAUOLqUR5jx1izJRNs/4wuegVtv54
	UG/Cjd8+GMEroAWMlLQFOaWZV5VnC2mydXR4QsFGXPzXdAdEFvriMHNH1i0rEfDdS29xLhu2Vv3
	b+rkf12e8hnYF9jy8gRCMOX72kUsXRhapkbuJhkb1dMLqNlA5/JNGmkHfQV+NNi/y470sIDgSpQ
	IyxGv3XGAAdRnG+CGANtwjym/AgMQu6wNSv6+TYtnh1W768z6v9vSl15k7cMvx5V6sNFVX66vg5
	0m+KtbIgc7Vf2wgvPoQzl0plA2aBnlrn7O4UUAb2SDcw
X-Received: by 2002:a05:690c:a87:b0:81e:29d9:7b13 with SMTP id
 00721157ae682-81ebfd71f13mr72764147b3.18.1784190430138; Thu, 16 Jul 2026
 01:27:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260712221709.7099-1-gvalkov@gmail.com> <20260715145228.GG56330@francesco-nb>
In-Reply-To: <20260715145228.GG56330@francesco-nb>
From: George Valkov <gvalkov@gmail.com>
Date: Thu, 16 Jul 2026 11:26:54 +0300
X-Gm-Features: AUfX_myObMt8htlBZqgfYKHId75U1l06HsPHA1lkc6D_3sDQZbIgZgIfjRPZ0W4
Message-ID: <CADOrJmYwYs08REP3eSwiTQegcKHFLwW0gpUexhomLDtO91ASMA@mail.gmail.com>
Subject: Re: [PATCH] wifi: mwifiex: fix freeze for 60 seconds caused by request_firmware
To: Francesco Dolcini <francesco@dolcini.it>, johannes.berg@intel.com, 
	Dan Carpenter <error27@gmail.com>
Cc: briannorris@chromium.org, s.kerkmann@pengutronix.de, kees@kernel.org, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Please backport to 6.18 and 6.12, which are used by OpenWrt.
Initially I did not know that I could insert
free text between the commit message and the patch.
I apologise for that. I am still learning how to use git send-mail.

On Wed, 15 Jul 2026 at 17:52, Francesco Dolcini <francesco@dolcini.it> wrote:
>
> On Mon, Jul 13, 2026 at 01:17:09AM +0300, Georgi Valkov wrote:
> > Fix regression in rgpower table loading, caused by using
> > request_firmware(): when the requested firmware does not exist, e.g.
> > nxp/rgpower_WW.bin does not exist on OpenWRT builds for WRT3200ACM,
> > request_firmware() falls back to firmware_fallback_sysfs(), which expects
> > the firmware to be provided by user space using SYSFS. No such utility is
> > provided in this configuration, so the entire system locks up for 60
> > seconds, until the request times out. During this time, no other log
> > messages are observed, and the device does not respond to commands over
> > UART.
> >
> > The request_firmware() call is performed in the following context:
> > current->comm kworker/1:2  in_task 1  irqs_disabled 0  in_atomic 0
> >
> > Fixed by using request_firmware_direct(). This prevents fallback to SYSFS,
> > and avoids delay. The rgpower table is optional. The driver falls back
> > to the device tree power table if the firmware is not present.
> >
> > The error code is printed for debugging and returned to the caller,
> > which only cares for success or failure, so there are no side effects.
> >
> > Fixes: 7b6f16a25806 ("wifi: mwifiex: add rgpower table loading support")
> > Signed-off-by: Georgi Valkov <gvalkov@gmail.com>
>
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
>
