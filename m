Received: from mail-oi2-f43.google.com (mail-oi2-f43.google.com [74.125.231.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96705231832
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 01:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790644902; cv=none; b=GvEiZR99Na9Qo8y7wc+EUwh6hi3seDgM1nJSds1tObnlpiDvNtIu6L4ej/POgVLM0WMLfv/YZsYc0N5E2uVsye9awYnPzAbtVrLqRZNuAdQ+584n9ebfPZByuY/3Na8Yn/mZ0ijBivyeR09/yS+vQoyg9To0OdZOn903RZlkfXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790644902; c=relaxed/simple;
	bh=n0NF20FVc7dFuhkFp5r7/ym4uGaeOxlFX1AIR7oub6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Auamu7NZF7hphCZ2ew6Ntt2XDhVhEIGzqqGsclkkPR6PmQV7pCdB5CfUPuCBwYRr5NmoFnz7RUm/gGNhOQe5cbIb4OtWAe8eP0+tV3Z9StRvBD2tDLMj1Rj9qAPPUkPVEg7AXfR1fJWuco+SklQ27S3wffjc2M9TFOJv60DzOeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3/vhqrA; arc=none smtp.client-ip=74.125.231.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3/vhqrA"
Received: by mail-oi2-f43.google.com with SMTP id 5614622812f47-4cdcfa4d904so611661b6e.0
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 18:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790644899; x=1791249699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EdlWV1UrrswI4TlOFB+Lu4Lt2sreQh/UqmTFUVR9kI0=;
        b=M3/vhqrAC67vr9DJocBiCDDOLHEd1dL5VFv24euU6SzbUQgHu9Hm7maiSoOTskWh63
         rZWQxsASTEzqO3k4BvaPgF2Xh84s7H+TEogi8ngp5zHFIWKRThk1v+JpRo684akO/ylU
         X77lL45SKVMjGibP9BE7y4CWcP8EuACrgLLoaM3PD3nscYWNbN8JkOP2T4Jis5bE70gj
         sd87GW6TJBop8vyf5s4wyiAOhlKp1UBFfeS8oQtuCOw/hR//cIlq8QFZJKhxXfi0CS5j
         WwPytA2b/PdzH3MYweW4JNnU1Z0U+h8+kuUx6STHFB1adQXRN1jCL43LO97zeSY7XxQF
         uIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790644899; x=1791249699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EdlWV1UrrswI4TlOFB+Lu4Lt2sreQh/UqmTFUVR9kI0=;
        b=opxL7yxU+aBGC9T3pfq6F1rB+4Pt1VfNiNk8r9qhYE/8jSfWTTJW/a/peO+wdHFfD3
         tr1c/PYI2kGEyPTktS/uXc78ygPkmVwt9SyX1H4w8KpWkX+jpdtf1SpzlYUir0xLQzjM
         jLTlZoObD4pVx9LfaS8Yrw1J6ohzRRAhCNVSwS6gTW26RMO2HfG1NJHi104hAbflapoK
         STb/REytqj+ALXK0C7ZXzs+snwiB7vM3TC07P+SeHMDnyFkXSsKwpg8ouUB+KyqFICBD
         DdCRimjOTajxq3P5E2PRl0EHq5w+ZxzzaTLn1pcU/lz8kw4K5qgq+sZRHZqvY+wc+ic5
         X/IA==
X-Forwarded-Encrypted: i=1; AKwUvBwq4st7r7ZhaywvsLROGJPbXdNw9xcDNwosb40N915XexWVyNG5+lseIDZKHlJ/xqA03cIS1Jk=@vger.kernel.org
X-Gm-Message-State: AFuF++liDEMA4DedWxs1hwajltDCef8aApmXChDPvhU+NWvMYayr8VwA
	F6vKgGGndDocvqIb21nJihNScboSFMBXePp0TSmVPCyvDiet+qed1NLw
X-Gm-Gg: AYBFou1orUt/xEIEGK/8QDRm/Nj5G3Nu466l5p6FGPApSZ6RKRIWcxjtPFLK5SWxvF6
	+PGP+s6DITh/68VtARs5baRyKU3V6x5JWXvn0phKdamnrHk3oOWAaV2CTq9751kzuaYLjh4ZhwX
	qUaLBnZMvDB3FZjDF2nTnPN2UOpSYO8GGSxsP0EXHP+beYWSz0ATDl7R8yQ2ZeWenDqR4sTl/QO
	glkIBDTkQpx2C61wokpYsUIDwJP5OpcQxhUv2Cq0X8D3Th0Hqc2IIjHbwpKVtG8ALiQ/11SNGx8
	6gepJgoY9UYE2kM71M/KMgqznulGfFehZcHTj6Wi8LbRfv9ziFhTjII1/VWBhTsKI3HD37iOZ4r
	FgndHsPe36NHkeGnwCREMBUHzCPI1ZGXxHMSm+U+ZXUr4DDcy+BmEq4Mutb6Kg6Sgh/C7N7y+/x
	u8lclCIPIdVtLirMWB07HxuD6HFmivq4XCFl5FBdokGhI85LD6hdkKcruIyX+w65RM9f2p6dEtw
	TK2yHHCE+d9nIrjgW5vUY5pUMXEOGvPYgifUgMWRWRGony+qkA=
X-Received: by 2002:a05:6808:c18f:b0:4d6:9133:cff3 with SMTP id 5614622812f47-4edd64228bamr679952b6e.26.1790644899389;
        Mon, 28 Sep 2026 18:21:39 -0700 (PDT)
Received: from archlinux.lan ([136.34.156.120])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ebbc7b9453sm3546338b6e.13.2026.09.28.18.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 18:21:38 -0700 (PDT)
From: Danish Khateeb <danishkhateeb03@gmail.com>
To: William Breathitt Gray <wbg@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danish Khateeb <danishkhateeb03@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] counter: Allow 32-bit tasks to use the character device
Date: Mon, 28 Sep 2026 20:21:38 -0500
Message-ID: <20260929012138.71156-1-danishkhateeb03@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

counter_fops has no .compat_ioctl, so COUNTER_ADD_WATCH_IOCTL,
COUNTER_ENABLE_EVENTS_IOCTL and COUNTER_DISABLE_EVENTS_IOCTL fail with
-ENOTTY for 32-bit tasks on a 64-bit kernel, e.g. armhf userspace on
arm64. Without a watch, such a task gets no events from /dev/counterN.

struct counter_watch has the same layout for 32-bit and 64-bit tasks,
and the other two ioctls take no argument, so compat_ptr_ioctl() is
enough. struct counter_event, which read() returns, has the same layout
too.

Fixes: b6c50affda59 ("counter: Add character device interface")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
---

Notes:
    Tested on x86_64 in QEMU (counter-fixes plus this patch, KASAN and
    lockdep) with interrupt-cnt on a gpio-sim line, toggling the line five
    times per run:
    
    - before: tools/counter/counter_watch_events built with -m32 fails with
      "Error adding watches[0]: Inappropriate ioctl for device", and so do
      the enable and disable ioctls; the 64-bit build gets all five events
    - after: the -m32 build gets the same five events and the same errors
      for an invalid watch and a bad pointer as the 64-bit build
    
    No splats. W=1 builds are clean for arm64 (COMPAT=y, LLVM=1) and for
    i386 (no COMPAT).

 drivers/counter/counter-chrdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-chrdev.c
index 61451ba74ca1..f5bf8e40096b 100644
--- a/drivers/counter/counter-chrdev.c
+++ b/drivers/counter/counter-chrdev.c
@@ -457,6 +457,7 @@ static const struct file_operations counter_fops = {
 	.read = counter_chrdev_read,
 	.poll = counter_chrdev_poll,
 	.unlocked_ioctl = counter_chrdev_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
 	.open = counter_chrdev_open,
 	.release = counter_chrdev_release,
 };

base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
-- 
2.55.0

