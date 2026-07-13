Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A0433C182
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 17:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965261; cv=none; b=S+pcjQ0yAjBnr/ra68Yt5J0Y7RJ+fC8BcRC7N6MFzJib0KxQT7JOE2+EUTKyu+PdBBpc39X4HTBBdHnx+4/2r8WKcuGuRaqnZmNuxqnALYZcQw1M20WhDGjSdjQ8ffn5bAAPBMPAgW0F5q/wKo0aPc8ZiDsMNUkp20CSw8U3ILU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965261; c=relaxed/simple;
	bh=/8x+/sj8c43rBjOXg4cS8q1nWgbWzULZaiu5dbO31kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uCmgjw7p3YVUVXvYMzUnRbGFBAe8o7zYMiZWV8+rDqXb+AP66Kbta57HWnql5AbMxJWF71rTHa0Ba0Dy7qR+z1t6sbIVGQ/joH0ZvOK3qF2ARDl3Hr2YovTZ0F2j6arDTLFGy+uhdmxsWaUZwZ/bgW42GyZasV9eq2hlBLpxa4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mj0RZUtx; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mj0RZUtx"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-451a49abd8aso62983fac.3
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 10:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783965259; x=1784570059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZzedxX/pazFMQj4gQD8R56KnEWLF9Jh5wSuFx6cj81g=;
        b=Mj0RZUtxswMN2wWTPeS2jrJgvQnSfrpk2V6W3eH6Z2G4KpESZV+y34X8Mhhv0lxY/m
         uCBTMIw3YXuj+9boFm8oWhB6BVfEsqSHoZjCJQJeqBIJ2qWd4ZuJgJFDP75Pw9lDbdNh
         esa/MUu65MxFMrsRY6FRvsN6J+kB1Hy9thEJfZKykctatRdWEHKgDFOgaxB8rPQsAar8
         kne7FbU0PR0+hjEreB+GjI25siPuOwRgcuP9kUPWOpob4HMPLGrxMm3a5RZKdlxdaTmi
         /9ZC1SuCZNoToIYykvast0SP73l4X4PiJ8mfA6wl7EvY4SfQmuoGAK+w94XRhalnhrlh
         Usmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783965259; x=1784570059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZzedxX/pazFMQj4gQD8R56KnEWLF9Jh5wSuFx6cj81g=;
        b=Jp/LDb1nSmC1k0d3uJ3m1En1Oa5uv4xHWhVMRRtnl4W//oLjvsKBWF/FFQ87Ik6J2s
         0f68zUdAbp+ldNMSNQde+WzREtpzjM4wRtGPdUIdDApxjsqxFChOMFeQUxDvMRNhY3ZD
         Vh06Soj7jJV3O0yw7X2ATRU/RRieF9yA8pkCKt0IvYhp04wWvIdIszdaO1+5BZs5mbK8
         /fGz5Z4IA+ublL/UoD5+3YLhaJ1kwJ2UvJNdbxqHBynO1/ipmKcAlc1cdi1H0nD/pS6C
         ngow2Q40imVQr3njW/qq+q2f4e38FZy/crLSxvGpuPnP8Nhp9uPhbIrtoJ0uHKyqlOT8
         XoAg==
X-Forwarded-Encrypted: i=1; AFNElJ/eaGSkVGi4z6efMHaRZzsO8fK/r1UIp4XerNroMnDCjYRoFurZTMTh2aPRHFyooOy6viKCxNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBDJ0yWmpoONuKoTRJfWTIpRvuw4Assz6Kvqdfws0H9GcAtZ3Z
	MaarzWvgRgnjEVdOVrzuVIaP7oRiXnxdxYhd6z2v+GXsUba/MVlLtRjLKaBMEg==
X-Gm-Gg: AfdE7cnQURdbhqakZi0Nu14n6GGeZnLELrjkqUb1G6k1KykRs+kTa7BnBZZQlM1lVwn
	mhE1nvykwpmd/3xHDNS1xw+pmj8hqX6M51GSCu7Mxo7g1Chd437hkvd845J7Ky9dsdsHbgwS+PP
	mgyQlnIcOwK4xm0gVsIOsqZ3eiC8VU7BoXenI+4L5RBrFZUzG4da4YpwrBHaXAkXEpsF4IdTXI6
	CnT+cMkk11D2YosEykc7aqMFg6230d89Ffw0avs424SiEQin0J734aT6LzPIHdYDFkHSMOzbg2g
	hPHc0EL0HcnLRwvxdQNbSqDe9KWAQNMoBCT4jD8UZFP2beEytiTAy1RynU0Z1G2S5xqEFPdZCrA
	v2oZVtG9QBHtcDUTKmF4iBcm5iPkwYeA/URNlOOlFLxFPaj/t0EAKyB4go/YdqWqreG9Z3mD4xb
	lot60Etgf59GNB5czamai2+5dN1Ke4hH1FSKGE0R4qnu6kfRoIQ+g33jiTZzMYd8VI4dseb9d36
	w==
X-Received: by 2002:a05:6808:151e:b0:479:ead7:2a5b with SMTP id 5614622812f47-4a42ac7c289mr6720427b6e.16.1783965259517;
        Mon, 13 Jul 2026 10:54:19 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1adca6bedsm12664742b6e.8.2026.07.13.10.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 10:54:18 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	bernd@bsbernd.com
Cc: fuse-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v1 1/2] fuse: fix missing barrier when checking io-uring readiness
Date: Mon, 13 Jul 2026 10:53:44 -0700
Message-ID: <20260713175345.2542331-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260713175345.2542331-1-joannelkoong@gmail.com>
References: <20260713175345.2542331-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fuse_block_alloc() reads fch->initialized and then fch->io_uring.
fch->io_uring is set before fch->initialized, ordered by the smp_wmb()
in fuse_chan_set_intialized(), but fuse_block_alloc() has no matching
read barrier between the two loads.

This may lead a CPU to observe fch->initialized=1 but fch->io_uring=0,
and skip the check that blocks request allocation until the io-uring
queues are ready.

Add an smp_rmb() barrier to pair with the smp_wmb() in
fuse_chan_set_initialized() to prevent this.

Fixes: 3393ff964e0f ("fuse: block request allocation until io-uring init is complete")
Cc: stable@vger.kernel.org
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5763a7cd3b37..b70c536d7e25 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -85,7 +85,13 @@ void fuse_chan_set_initialized(struct fuse_chan *fch, struct fuse_chan_param *pa
 
 static bool fuse_block_alloc(struct fuse_chan *fch, bool for_background)
 {
-	return !fch->initialized || (for_background && fch->blocked) ||
+	if (!fch->initialized)
+		return true;
+
+	/* Pairs with smp_wmb() in fuse_chan_set_initialized() */
+	smp_rmb();
+
+	return (for_background && fch->blocked) ||
 	       (fch->io_uring && fch->connected && !fuse_uring_ready(fch));
 }
 
-- 
2.52.0

