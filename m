Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088A0319852
	for <stable@vger.kernel.org>; Sat, 27 Jun 2026 06:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782542913; cv=none; b=UCh19qlv0t6eeAXHJZOIV1IaFVD8gCYl6owma2miKOujuWAH+kb06nCevtUngQPNC5eSQb/oDZc3dfxDoQYz1mBVD4wZQBNYlxKrWfVDperZYAsvnD69ozjq3kDQSh97iQRZ7iy20CKPlDuCS5V8On/9YWUpGLPv9m1dT0N/D50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782542913; c=relaxed/simple;
	bh=+rYfEs2pvBhx7gYc578DZEus3ro6qJzWud0f6V2w20U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i7m8PdbmpctNN4P4G1yGheGI6gfi4i/FZRITDHZqVMUgGthZ7ICnP01Z3dTx7mOzMGUGzV7ZqjuqlxZXoHXX4lpDnuz8/ZvCyQIP6NoZGLL99bfJvvUF8I81vOjb0MZ0meEO4EFlUMxKTvyBqSiJaWqj+e2DUgTehwwHBNcHiU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFm4Ws/5; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFm4Ws/5"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4926d6b177eso6437005e9.1
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 23:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782542910; x=1783147710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rYfEs2pvBhx7gYc578DZEus3ro6qJzWud0f6V2w20U=;
        b=EFm4Ws/5scY0b1v8Z4xmoZAHLhNMqSbVFFsDlQNMiMiIBpeSbw8m5XrZFiSenwhg0q
         IFRxPWXojhf4bh+s0YHVoB9SKZW9ykL2qmeg3041EMLJN6jidDFbAv2ajV49K7b1LWdc
         jZM+DzuCNZhm8xqcx9h8/1/MqLkCrfNHGb7HexUid1vlo3Bcwo4pyuCtITMbZFSjlej0
         tFQ6uWgm59A1eBks/lht6JpCi/BcxDRloYhF0FF8Mq6+NYud1K74SzPqEZjZMRPDcDNn
         QVVTP4Li0Outs7Zsy9eKggnlKpQCYAAD/GLcMELb9D0XFJfRrOqnHQpxGtHEfjw6+fcr
         NurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782542910; x=1783147710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+rYfEs2pvBhx7gYc578DZEus3ro6qJzWud0f6V2w20U=;
        b=ALOrUAcGyksp/J0KsDFz+f0e/nJON+7ELFtnc/6q7TldOFouWOSPQtnDzmr2s79v56
         BRC3xiIAfRHso1VtKOEKCFa61Fuvw5Tpa/Geyf7pQrHYntMLhZIobTlYdzUKj/sqpDxT
         ZH390wUKCyDsdU1DkKX2qNv1lFgTjRiW0kzadZ3Rz5H6jXvLbdPYOyN18Cr2loffL6b+
         h01zChuFWUNKE51zeS54gTW9Fw3+IXauLlGBrAuhdnOAYoxurnDBHRByFhwLvEGhF7gn
         Ucqr3P7+W7QhahdzgqnTooBrUtdAfxKZiZHcZ1GitXBpEq0HhYW9lP3SJmk5qAgw/S3C
         IPnA==
X-Forwarded-Encrypted: i=1; AFNElJ9b40vCOgMbOHRMxza9Xikz8B7sKBMVfoYGTZ+MU4QSfteS32/fINJV6U97a6OnZC8AKMTOfw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX+4nt0NumZmaXy4nNCRxJcHaObVuFrRNOmj41eZ7NW0OpyajL
	Ij+4QuI0qQuIsBWTISCKlGi6kBhZvfn6cJ2u0qaLI+UwH3Jyl7Jr8i19
X-Gm-Gg: AfdE7cnoo3ZAETUFbPAaBipulDhqBlNkR6ac0GvGgEs374Md1Z6+BXU9k6RcWqxMwe7
	kcPa3JylNxe0Vr7vGJj8kG9Zras3amFCHWAtrVpl6Xqcn2qzFlpk2p6S499Rg0zZXlHTAsbcEGn
	dDM3PF9f5lXjGC5Jzd555hHNZWKwHMCTyJuq5xSXwLsjU1upIrgtgJRlktirmbAXJMeS5QgOlNi
	mXpzrd4oHY8lfavkOtcKAMgMEhNo41kZexkLrkOWmKNGjKHMEjbVfpuXNMHlMB4UQlZJqltgStx
	jBF/ZMov3lnYvanemmbbYcuKTBTXsYIl672WDgj/v8eBu8qNWC86GaL8qFi/AjERUYWISNWE/fz
	S4Y8Y6GJ1Q/JXG7dD1kxq8FvcCdlfMixrTpQ7JjJDvwcf4R1kZJc2YoDQVfC8bgCBSDjgmTHnyo
	rnBqlUSEnAjU7Bpi1uFoglTlTv9QbcMC7jZgt7I31J9NSLBCg1Ks+IwSlLJRMoP3Jznw==
X-Received: by 2002:a05:600c:1c17:b0:492:7019:caca with SMTP id 5b1f17b1804b1-4927019cb17mr63681665e9.26.1782542910213;
        Fri, 26 Jun 2026 23:48:30 -0700 (PDT)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46dcbac0c9dsm22289931f8f.19.2026.06.26.23.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 23:48:29 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: daniel.lezcano@kernel.org, tglx@kernel.org,
 Felix Yan <felixonmars@archlinux.org>
Cc: wens@kernel.org, samuel@sholland.org, indrek.kruusa@gmail.com,
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-riscv@lists.infradead.org, Felix Yan <felixonmars@archlinux.org>,
 stable@vger.kernel.org
Subject:
 Re: [PATCH] clocksource/drivers/timer-sun4i: Advertise a real minimum delta
Date: Sat, 27 Jun 2026 08:48:28 +0200
Message-ID: <cyKZfOi8QVGppYlWqaO5QA@gmail.com>
In-Reply-To: <20260624220434.4183732-1-felixonmars@archlinux.org>
References:
 <CA+fTLhgLmTY+exGujKf8OYYQvcEW5X5NJ_5sLq2AYL6zER2c0A@mail.gmail.com>
 <20260624220434.4183732-1-felixonmars@archlinux.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne =C4=8Detrtek, 25. junij 2026 ob 00:04:34 Srednjeevropski poletni =C4=8D=
as je Felix Yan napisal(a):
> sun4i_clkevt_next_event() compensates for the timer stop/start
> synchronization delay by programming evt - TIMER_SYNC_TICKS into the
> hardware interval register. The clockevent device currently advertises
> TIMER_SYNC_TICKS as min_delta_ticks, so the clockevents core is allowed
> to call set_next_event() with evt =3D=3D TIMER_SYNC_TICKS.
>=20
> That programs a zero-tick interval. With oneshot/highres/nohz timer
> operation this can leave the next event stuck, which was observed as a
> boot hang on Allwinner D1 after the clockevents core started reusing
> forced minimum-delta events.
>=20
> Advertise one extra tick instead, so the smallest event accepted by the
> core still programs at least one hardware tick after the synchronization
> compensation.
>=20
> Fixes: 12e1480bcb49 ("clocksource: sun4i: Report the minimum tick that we=
 can program")
> Cc: stable@vger.kernel.org
> Reported-by: Indrek Kruusa <indrek.kruusa@gmail.com>
> Closes: https://lore.kernel.org/linux-riscv/CA+fTLhgLmTY+exGujKf8OYYQvcEW=
5X5NJ_5sLq2AYL6zER2c0A@mail.gmail.com/
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Felix Yan <felixonmars@archlinux.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


