Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794511136;
	b=je40O9FpkGQV7jvDJJbDtv7Ss3ddsBoAl934d9SCiDcmU6w8pVWQenRwRdHpDq1lgb/t
	 Dhr6rqIImbCe8e5S4IIjoFdSE1BfdeO/GFvc3psqnJ6Gcll3y4+3eeAMAbkBM4fn1TP3O
	 V0aAiiEdF1WCZFTN4KxNUnWD1PVsOyoaNNz7RyIFT/aknhHZCDAjWqvVsLxQfNOo4N67M
	 MXZCR9F7Kk+iDoFwCnPIu2nKLa8S1f/lTIvpXoNsCQkZvUFVbyhyouaTLtNHU17ynqOJ7
	 /r3PTMrC0ssBBCrzCKk+HKyohsw8xTJojNfWYehwb0VIc0Gq6dgZyMukRS9prOupFYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511136;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=2xAFYfFMX7vcmoudCw09Hc8H9iGMxUWUhT9MyulLPKI=;
	b=NCiD5GCY3Uxgsn7dzwpJ2GdjRtK1R1POfS1GWwLd4ztsWC1+s6sZhL5LQDcNpmW7eT7L
	 gQZWO+INdSyPqDsRMCW1PfliwNh2ivMJ5x1QisaZdbkqLr3pW593nKGwDhFRTQI7UlfZR
	 cpx5MeNZMkWGCVkrg+a3pztgsubGGOEhJr0/+4gAnlzGbObn1sEnFlEMNCFafSsNGC+ma
	 PjqyFsnt3TAFamUMQXUSRZ9DQsiR8vw6kWZ3ECm8xdmmaV9/wFsP9ehVeuFD6vSCclyWs
	 t4N3PMHI1sSlefTT/rHIuwIzWmdcEsnjfFk7m8QkwWBN+cktz2n7upeNcy9n+qSA7SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=J8T4Slv7;
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E8C606A89D
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 19:18:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27E8C606A89D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=J8T4Slv7
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8b691cf0eeaso203222b3a.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 11:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794511135; x=1795115935; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2xAFYfFMX7vcmoudCw09Hc8H9iGMxUWUhT9MyulLPKI=;
        b=J8T4Slv75b0ghaSYdyZWWnRtHlzAVKGvgmQJoM83dVvU3xYTc7iUKxbr/nZxD59Ubd
         uYgim1HcnivsRZct2sgzbnl+sv3vcF8pFMlSwqxfAvJWteDQprVmzKFllAZPfLBJtmTq
         JgtDWhm4j1ytJQiqKa4P8WnznsdJimF8nMmp/GzOBUmjQA8YpwS9hTnzbIOhy49achAz
         5HJuqJnUpPwPWfuZupP2v2/5+zj5X5dZhRyrcG9lP/9tbhHkXa6DCvBhKede4th4ywm1
         f6YbPR/I2Q6ZNcEX9mcz6f90V4ctGhv6Cc6K8uiBH6JHxGZc4OTHKVPa/g0UW1GM1X4s
         GJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794511135; x=1795115935;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2xAFYfFMX7vcmoudCw09Hc8H9iGMxUWUhT9MyulLPKI=;
        b=KOz9IMxfg6xdooy936bMgYZxeSK8TbJ72ysDG1EVDiec/zfNhs5dW6kQJ4YuKUfHOe
         jUw0DQ9HNFMmpd9L6c5dVBj2aQXZHLB7vG9dlxfLyES2Ycc/Sw3Ujuj0+Xdw265ZOqEi
         ZJBCJhtjlqeha0YkZyx9TfV94tGVvMurjnTdRngCRcEEE6Ozm9M5FiEO+krs4DhViawK
         Xj5UoNvV/gyyFJyb+WpVmQ8FnQa4rjotV5y8WRk+KWy1dL99vaMzE4nb/W4uB2U1rlNZ
         4vw81qwrQxacMXhvZNc/cmQVWBV0aeoIBqmPsyjs2vEiBL+KNDWmVu6an7ClKvw3etO5
         mE/A==
X-Forwarded-Encrypted: i=1; AL+hErFmu0Vs0R5bJx68/6T8cpeZ7grHrpZhvJpGfKQ+2WzCG7tHOLM1CjWkj9NeYuRhhBAvX2onagg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8xB9pa6p+F33LsXJC0uCyECtEHjIkzTzrHvdO+vAk3hxnEIrkI
	9rJy/5nbKAhgcvuWE+VCB2fIWxIy+t7g8Xdd9E5yO56YtK4g6yIpsnK/3EGo2oyTKqnTspRhUmZ
	DBrfaw8E/KA==
X-Received: from pgbdo4.prod.google.com ([2002:a05:6a02:e84:b0:cdb:915a:35b3])
 (user=nkapron job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:66c6:b0:3e1:2502:529c
 with SMTP id adf61e73a8af0-3f7a68a47e9mr143310637.23.1794511135149; Thu, 12
 Nov 2026 11:18:55 -0800 (PST)
Date: Thu, 12 Nov 2026 19:18:50 +0000
In-Reply-To: <20261112160448.41566-3-lui2012qwq@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261112160448.41566-1-lui2012qwq@gmail.com> <20261112160448.41566-3-lui2012qwq@gmail.com>
X-Mailer: b4 0.17-dev
Message-ID: <179451113092.3909038.3452448115018403099.b4-review@b4>
Subject: Re: [PATCH 2/4] usb: musb: dsps: free the VBUS interrupt before the
 child teardown
From: Neill Kapron <nkapron@google.com>
To: Chengyu Liu <lui2012qwq@gmail.com>
Cc: linux-usb@vger.kernel.org, b-liu@ti.com, gregkh@linuxfoundation.org, 
	nkapron@google.com, tony@atomide.com, bigeasy@linutronix.de, balbi@ti.com, 
	shimoda.yoshihiro@renesas.com, robert.jarzmik@free.fr, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 13 Nov 2026 00:04:46 +0800, Chengyu Liu <lui2012qwq@gmail.com> wrote:
> dsps_remove() unregisters the musb child, which deletes
> musb->dev_timer and frees the structure, while the glue's VBUS
> interrupt is devm-managed and only freed after dsps_remove() returns.
> dsps_vbus_threaded_irq() re-arms the timer via dsps_mod_timer(), so
> a VBUS event in between re-arms dev_timer past its deletion and
> otg_timer() runs on freed memory.
> 
> [...]

Reviewed-by: Neill Kapron <nkapron@google.com>

-- 
Neill Kapron <nkapron@google.com>
