Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6E33F7897
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782481684; cv=none; b=EltcHShLo0nxMTMS0bltedmW1qiC7rcE2jdKGauoLZG4ovhp88qvr3F2vtHlwnIaQacpvWA8zuC2PVzUanIfZ1DeXuZIMUWN6QzGT+BI80Am/fuZsapvFnsTGo4JVwNXCAKw0hDPMkjxEnar86SB4sqQviu2GT1jerBBv2Z7r6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782481684; c=relaxed/simple;
	bh=lvXuicJUDw1XULckticqmeYIQAnOyup782sw+YNV4cs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lZ2wh6qM9OyMEyRin22TTe06Dg2O/2qzl6rEqcLfTdyXK6mpW9IR2I/YZONnnICrpf40cAk/JOsTRMdvvlvZCD0Gb38k9hnKPaipAKRwXY7FzuMMxzkhPWOVoCYTtnNP3jKVpq3hLz3vv96JkR8DpVmCpyeHDwiUulfuI3WEusI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NaMid59G; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaMid59G"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490b211ee6aso6544445e9.3
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 06:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782481681; x=1783086481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oP2B2dV7fW3H14lJ2diBc/sAn3zNx/rIDakhi1Twryw=;
        b=NaMid59GJHDvkwMCZhNgFPsuVKqIo+fAimtuj+Nzs+XX4yLvHFmx9WQ9SgI5Toez3m
         izZT+kb1TZayJGFFcF07pVJEA5i+9onXY3pB0D8JnGX3LYGDLru1py0nUm+CS5z9IDap
         lc3y6ULwYnbDENYOMSAyNuA3bZl62+HIbk8fG7UuF1JHiL3u2byXQ/G06SHunIYuc2IX
         CE3FjjfmM8OI+jf7Ngzgth/vejwYH2StwAat0k8G1jKAVwfeIBtV20gqHUKZ5I0YaNQw
         Kcau+a/RpWaFxHWn6f/DdSvMfy4poc24zsJE8HX0XvXzGfvajuY4IoWvj7BKeDdXbSBN
         9Mxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782481681; x=1783086481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oP2B2dV7fW3H14lJ2diBc/sAn3zNx/rIDakhi1Twryw=;
        b=oggLAM/rY9tZpcA2nPE/Q9++gpZVXaTcdj67O9OzhV3kCS9YWNtRm8obfzimeaBbCl
         3958Yafyk8T0Q203pPnWoBhYs3tcEL7jnVs46Rc3E52UjRywOkKTxqTDwjjYdOf0nMz3
         KfNz8BArvMFY+iTcc4iD9NXJsczYQGnoTzGZaEPPTr10+StI6wCU5rZ8aRpse5Vonqcx
         VMCqt06Of7DRPxMIBBlHACQhXpjB4QYNBrIBiO3XzzeR9haLh6DRvEqi0/mVZ0rmDXbT
         MeRmaO/UY0NyVmQqvfXW/iWYp/KK4N25iloDwY6woIt53tObp7TLzdEBGmyjkUskwuHh
         YrIQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ii/cMDQmyfDpoi3vBa9HXDx96AO8AajSTqVqfvjRjgjrxZjogBR2RM5IlH4m2fzvl5paIOyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWopAVCL2VcQwDHF/jSLgj/atRh5tuXGWt8j1vRMT98fEmqARe
	t0iIE+IsfyN3Edq+cmarl8EwNc28mRZjc0mGk8UkWLBrQfPxV8EabO69
X-Gm-Gg: AfdE7cnMA+PUjvX0SDqE6WkXZx+EVbBjQmf4NBF4WKfVZkoyRkNS/yK20Zl0CBkgyvh
	uWbXJaZ9lcFMJN5r1an8zVzJ48QsdvU6/LQh+Jyu48/51jRR9x0RbI8XcSHcURGM0uUg8rH9G46
	Gw1TW9Pzj/EYwApCGeNiWNHIyhatasLkvWY+CEYD+xqkDrPkgwEy3BAlR3TAYjLl7qLS7wKejnH
	exorcl79kzPbegrOCJCk1uI4YtuQ6YTR1BQxBWr2H+mz0DWzudPUvTWZipg55o4UqSaINnpQT+T
	j3etbng1qqX+LAjEvUq+qFLyBl9vlAzrMEIZBTNK5uRM6I7U4fhcL2LkXf/yEndro059DtzDhcl
	g2cxCTikBW3m2rdevK+gCfGNzbuuaslYsbfmfiBYTHrDGkk2xH8TEVzvyPnBjtr2CdPZn3gfzn5
	NUjhw2gRBkf0br4sLO+Hwhw4pqKUsc9ERu3HVPsBVDKNy5ZPXcSwzNZw==
X-Received: by 2002:a05:600c:350f:b0:492:7083:94bd with SMTP id 5b1f17b1804b1-49270839502mr847625e9.28.1782481680893;
        Fri, 26 Jun 2026 06:48:00 -0700 (PDT)
Received: from localhost.localdomain (IGLD-80-230-60-93.inter.net.il. [80.230.60.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46efd7ee1c7sm7987878f8f.14.2026.06.26.06.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:48:00 -0700 (PDT)
From: Omer Cohen <nevergfx1@gmail.com>
To: tiwai@suse.de,
	broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	security@kernel.org,
	Omer Cohen <nevergfx1@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/6] ALSA: compress: remove illegal state mutation in poll()
Date: Fri, 26 Jun 2026 16:47:04 +0300
Message-Id: <20260626134709.27883-2-nevergfx1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260626134709.27883-1-nevergfx1@gmail.com>
References: <20260626134709.27883-1-nevergfx1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

snd_compr_poll() transitions runtime->state from DRAINING to SETUP
when it observes a drained stream.  This write is unsynchronized with
snd_compress_wait_for_drain(), which reads runtime->state in its
wait_event condition after the device mutex is dropped.

KCSAN flags this on an arm64 system:

  BUG: KCSAN: data-race in snd_compr_poll / snd_compress_wait_for_drain

  write to 0xffff0000c75c8200 of 4 bytes by task 282 on cpu 3:
   snd_compr_poll+0x29c/0x2c8

  read to 0xffff0000c75c8200 of 4 bytes by task 279 on cpu 1:
   snd_compress_wait_for_drain+0xa4/0x270

  value changed: 0x00000005 -> 0x00000001

poll() is a query operation and should not mutate stream state.  The
DRAINING to SETUP transition is already performed by drivers via
snd_compr_drain_notify() when drain actually completes.  The redundant
transition in poll() has been present since the initial compress
offload implementation but only manifests when poll() and drain run
concurrently from different threads.

Remove the state mutation from poll().  When the stream is DRAINING,
report it as ready so userspace can proceed without altering state.

Reproducer (requires any compress offload device, CONFIG_KCSAN=y,
CONFIG_KCSAN_STRICT=y):

  /* 4 threads on the same compress fd, ~2000 iterations to trigger */
  static int compr_fd;

  void *poll_thread(void *arg) {
      struct pollfd pfd = { .fd = compr_fd, .events = POLLOUT };
      while (!stop) poll(&pfd, 1, 10);
      return NULL;
  }
  void *drain_thread(void *arg) {
      while (!stop) ioctl(compr_fd, SNDRV_COMPRESS_DRAIN);
      return NULL;
  }
  void *stop_thread(void *arg) {
      while (!stop) { usleep(500); ioctl(compr_fd, SNDRV_COMPRESS_STOP); }
      return NULL;
  }
  /* main: open compress dev, SET_PARAMS, write data, START,
   * then spawn all 3 threads + repeat setup in a loop.
   * KCSAN fires within seconds. */

  Full reproducer source available on request.

Fixes: b21c60a4edd2 ("ALSA: core: add support for compress_offload")
Cc: stable@vger.kernel.org
Reported-by: Omer Cohen <nevergfx1@gmail.com>
Signed-off-by: Omer Cohen <nevergfx1@gmail.com>
---
 sound/core/compress_offload.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index fd63d219bf86..XXXXXXXXXXXX 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -478,11 +478,8 @@ static __poll_t snd_compr_poll(struct file *f, poll_table *wait)
 	/* check if we have at least one fragment to fill */
 	switch (runtime->state) {
 	case SNDRV_PCM_STATE_DRAINING:
-		/* stream has been woken up after drain is complete
-		 * draining done so set stream state to stopped
-		 */
+		/* drain completed or completing, report ready */
 		retval = snd_compr_get_poll(stream);
-		runtime->state = SNDRV_PCM_STATE_SETUP;
 		break;
 	case SNDRV_PCM_STATE_RUNNING:
 	case SNDRV_PCM_STATE_PREPARED:
--
2.43.0
