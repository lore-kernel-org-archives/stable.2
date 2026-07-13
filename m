Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383F236F8EF
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 21:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783979996; cv=none; b=HBNintwrmpVZk8XMiJM7Een0U6z339lvpRTGsDPrmYS6tQXFyC+lhQda4vm+3P4MvlopPuPDiIIvSJJIR3yCG6vBeSujFv2jTIJv5zmwupMy82icP8iw1Ms8Nw6CAFeol7IOUB3Q068O4uwwvuTz7Qhhg/7Jhf71259i15hB/jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783979996; c=relaxed/simple;
	bh=H0cwLVGaX4dKbobyhMaQ5PNoidoTkOFDxl0nwbS8RTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mxuTmLFTJhCqIfmUXpP8XKBwESIPF9Jjry50guBPENtxtpX9ONwpTlv3KY+HGL1eSWNEp8uXluR3c65aaPnV5GMrtzXmXgrW/XLDGB2Qi+OSj+y8MvBxWySJ48sE+jqe4eJcKQ1QGcAqBsqRqx4OYRbJX1kYNCwZvwKq3AtUebQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=gbo98aie; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="gbo98aie"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47d70879764so2338690f8f.2
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 14:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783979993; x=1784584793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LI09mRpsYnchiZqtEGapuavy2o/KNyJgShSvZvNJrfM=;
        b=gbo98aie1JDjGGQrq53Qgr6kNjB79h2HNxwfDK3kcW/gQY9m829mnVre4e+iSUTTmS
         +9/79K5xI1BkDa38egSC/ujkMFlQuBH5HEMwGQNqzDKQ0La10TpFG4tvRh6GVZBJ8Rpw
         I7ijbRO6nMXIDQwB4IAF06tdakU20Btj1nvf9z2P0ZOKa4wuX88rFP9m2s2rFJbCHJzl
         pMOLddwOvFbLaySbueHFw1/FDW9ICc1a9YCZGczq1PsuxO9vaGNGzJ2QGTk+uK8CfSgO
         kKEd2Xubbq5oLjrBNRwh0I2Bhx1RCR/7v8BAR/dE4V63169naNmtFhT0Hbkn8nrN3J1q
         jAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783979993; x=1784584793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LI09mRpsYnchiZqtEGapuavy2o/KNyJgShSvZvNJrfM=;
        b=aFM3u6diRFKBZQbbYRQsrgAYzxQhwyti5lVH5RlFoA+t7qI3s3vV/UIvr1dryHmifp
         SkGcIdRuwB4C0wovIT6WkQyIAABfG6GYeaP9rCYau+b3GvE9Y9a4i6aAgPYtzpqASVlf
         td5jr0fWNGn6vVk2TZC4X3EsBwCECpVg6e2ZM8+X5dDf/laNNcP90mWd7OrOeTuJWyuv
         uSws0inbLTbYCbrl8oCbIep1Bfn+NLnjLCd1Wru49e1RLYq4maUAYykeGOxPWq00xUa0
         nYACwlXzPl3fUsobIhwB/eFeFoSBRfYIK2YxJqhideTZIohyvFfAjQyG8TAHBkHGNe6x
         rD1g==
X-Forwarded-Encrypted: i=1; AHgh+RoTEyJkvhIATJajinCC9NuFeQe2wUP38ZxQmQVZi5A2Lzf4VnCabiZZlobPHSwidZyicMH3jOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyotJ8+C31w82GI4Uc/7UoQHzD6TLpEUOP7MJ+K5/pdGhdv8nl
	f3h2/mTW/xatmHoj3xGlKdaHmWCy2aLYzRLxXIBL0nrXVMB+U5vDQe3pf/+hFGpe9FT9
X-Gm-Gg: AfdE7cmoG1fony+yEdhFPJjJN+Frgma3S8+qcmkd/mbglSMBxE++P0izDPysLePNpKX
	nbdmSqk3bPpMDCnvWkMBa423a7mrhIQ5G4kgpkbYvfVhuJp214rjf9BNDMHK29d4SVHHVdWuhbO
	39UFD6dI+fGTFowLs2QNsSEZV8DdvRBzm5cNIQ2MTTRxsrUHGR6selT2VLexcK4fnhenPj4ygs2
	lfExbxU66ljpDE6BRJYR6GEGpF4fA8sJ/fodP7OIptTmYHuGrNZiQkKI7Bfwe9ouwGQgzmuPjt+
	0TTI/Mac021w7bUbMRElwt4+Y/aR8/NHQyOwkSsSFdbA5jLSWLtP6Nvk5aw8aosOYqpbRKhFXxT
	ZP1kIg7Z5GLgcTlLd8WFco5aWr93mG2Oo/8x6rnRtABuGAqzEG67+EPSpLctOXlk6KAkHcukGsk
	zXAb5rggofEQXWllHZbm5pPNsJbs3LP/w9NEPz9v6cUyNlwkK7UFJgxDNyIRws/1EPCU0n1dvwu
	bdKZoF2lLY3zdD6BF6ZaAnOg2W8OqeRx+o=
X-Received: by 2002:a05:6000:26ca:b0:441:1e1e:a050 with SMTP id ffacd0b85a97d-47f2dcb5325mr12237283f8f.16.1783979993692;
        Mon, 13 Jul 2026 14:59:53 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635a63esm2584715f8f.9.2026.07.13.14.59.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 14:59:53 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Nikolai Kondrashov <spbnick@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] HID: uclogic: fix desc_ptr leak in probe error path
Date: Mon, 13 Jul 2026 23:59:50 +0200
Message-ID: <20260713215950.24193-2-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713215950.24193-1-doruk@0sec.ai>
References: <20260713215950.24193-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uclogic_probe() calls uclogic_params_get_desc(), which stores a
kmalloc-allocated replacement report descriptor into drvdata->desc_ptr.
If a later init step (hid_parse() or hid_hw_start()) fails, probe jumps
to the "failure" label, which only runs uclogic_params_cleanup() on
drvdata->params and returns. The device core does not call
uclogic_remove() when probe fails, so the kfree(drvdata->desc_ptr) that
uclogic_remove() normally performs never runs, leaking the descriptor.

drvdata itself is devm-allocated and freed automatically, but desc_ptr
is a plain kmalloc/krealloc buffer and must be freed explicitly. Free it
on the probe error path. The kfree is gated on params_initialized, under
which desc_ptr is either NULL (a no-op) or the allocated descriptor.

Found by 0sec (https://0sec.ai).

Fixes: 9614219e9310 ("HID: uclogic: Extract tablet parameter discovery into a module")
Cc: stable@vger.kernel.org
Assisted-by: 0sec
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/hid/hid-uclogic-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index d74f98efa879..ad9914ed0c71 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -265,8 +265,10 @@ static int uclogic_probe(struct hid_device *hdev,
 	return 0;
 failure:
 	/* Assume "remove" might not be called if "probe" failed */
-	if (params_initialized)
+	if (params_initialized) {
+		kfree(drvdata->desc_ptr);
 		uclogic_params_cleanup(&drvdata->params);
+	}
 	/*
 	 * If hid_hw_start() started I/O and then failed, raw_event may have
 	 * armed the timer; shut it down so it cannot fire on the devm-freed
-- 
2.43.0

