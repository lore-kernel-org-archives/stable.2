Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4213F253B58
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 08:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783757037; cv=none; b=mUmFjQn5x3apJ4/AwvLepdZd60BG41NbAoqV/2pF5yPT8jmrYCCieu5i3HYP5r7JhhJU/nKDtaMYDnlokDXtxF3vXIwSEjtgwAw0eA1vlNVZinxlomFLlzOhZKkH/hJOchGc74FddJRW5MopOzsdSR+9kypqvdTqVgEC2G9lnmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783757037; c=relaxed/simple;
	bh=ql13UOHrnBdmGaJDsZKTfQSxuOew+yEFAJD0Ih34BZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DL/+rKVhutg7oy7rBwUG2XtLEjMc6UO3vPYm7vvKGyKlmSVpvgUZlNwCGUoY+l093NPuTUiKkXO3C1uz9VqR1YaoEWHCT7nKYYvec7FuFMwNMYyf+G+sXC3eVAUX3yp+kWhUlpXbSVph2MUJVH9qt03dqlaLai5EZ1NIxGoUvKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=dnJ3cZrM; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="dnJ3cZrM"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493bc8fda98so9872035e9.0
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 01:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783757033; x=1784361833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HKkmmaE0aEFKxqkQuCsGPJUCathBrKzfhSwzLLCu+L0=;
        b=dnJ3cZrMCfUxwAA0AUveedMgxugJVSx4g+CaJfdzEOKelok+f7f0PwaBnGj5jqIIQo
         OdbJIu2QgqixLWSAYeju4svEsWeSHXC1oCgIC7a87fsyFsCrJBfsnEfyamCgYGOkEDqV
         4XSthPfzNwX8sgCCmBYNUJgWge5ZtLHqgLg0RHHiLChdt4lLoN38iUnQshGd+y7+3Rzl
         nJYasqwoqlhs7Bz9YuiRwbultSZpAauQceSvKyZYKlNOXb/jHwfPBW2Hpjc7qdlb69bQ
         X7vRgk3PRJLDZujIhFSdHiXqYsXNs52WpjJzYdz4VcD1c1NaKRsOMTcTtooxbhx02/PY
         5GWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783757033; x=1784361833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HKkmmaE0aEFKxqkQuCsGPJUCathBrKzfhSwzLLCu+L0=;
        b=VYWQBy6IRiYmYCD8shkUWA2d7tFPS1fNZ+0nd6znZ3VCBAKH7z9qVJTW99QQQtL6oY
         qSM1PJ7RLC+WVvcQE3r/9H1hhPDwuT0lmdxWV/5d8zNd3yFv3AXer7AcLNBtQdosjrUD
         hKs52Khk000h2g4lFQAivVGcVNkauC2403lI3BWhcpuKzbvvfwJsqTcjOBNrCYL1fojl
         AEIMoXMtZK0R4ic2sEnzy9Nx6c0FyNwt5Hvcbw7ozheTcuekIGNKPBGKyFrD8Tep3zpM
         vhhE/vddP07qe72Oy5tyl0KAo6wKboTrGJTQLbsbiWHBNA6v+j3J4UrtjUrveLRRH+uS
         /hrw==
X-Forwarded-Encrypted: i=1; AHgh+Rq9onOWDlCdEVkpHpgXshQEqeEAtpdFDF30vdSFi8XEzKFmYs+zpgwYWdAtLz1Au+nDYAJKrbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDoPHn/+I1Xjksow+VB9egEXY9KVKhEU+Sc/OV3tSYPT8J592G
	5j2dSvPT2nhKZC3b6/VITnyHdUsgLteAdflfHTG4dUeK3ETExzJtZxddyoh3KIEcY+cg
X-Gm-Gg: AfdE7cnV4nhzdjKezDnP09fBSHeubja1jQnCB1k6lZFNZ1R3KyparoArsHTIYBNPPgF
	sB3jP2yeQ1wG4ENyT2c50XkVM6Y/Mxo/h2XrZSMP2/VHG3+GqPlLKOwjLWQxJvCGZeB4Le5rEWL
	W6gA2nJszv2sio5HIOLiH0RV4oNVf2knlgUuRsh9TCT88hBtR1eZIoRxyDgiqCmawzqJYnrXWw4
	UVF+imoJzXDhq/ju2cp1UA5w+Y8x/leDCFVxWfdpuGekAuvNz0SAxZiTvYADfZx4SdFriRCIjfX
	mlPJux35Bd53ox27qJ8kt3NZnM66GthLsbNoUBHNQQz4yrmn99Ifavw0o0plDKWdQ/xZqDYHFb9
	a0m4NeZvSIQEvmjqPrq+4zE7LRMZaZhLzKWOE7S0+KK+RlgiJ6oVvJwTWP/TEWfha8LRRL1ocDQ
	jb5MasF9tBesr+yLXg5s1pnoZD1Zm4IXMRDNTM28nEoq2knHFtcbEghv2cfloAOlyafw396RNQX
	onW+9CeX8SMVkP+ma1YuHo2g4oepr6LwoE=
X-Received: by 2002:a05:600d:8444:10b0:493:e46a:ab with SMTP id 5b1f17b1804b1-493f8837638mr12182095e9.34.1783757033565;
        Sat, 11 Jul 2026 01:03:53 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2dad65fsm77881195e9.1.2026.07.11.01.03.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Jul 2026 01:03:52 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: spbnick@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: [PATCH v2] HID: uclogic: fix UAF on inrange_timer at teardown and probe error
Date: Sat, 11 Jul 2026 10:03:50 +0200
Message-ID: <20260711080350.81108-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260711073003.71012-1-doruk@0sec.ai>
References: <20260711073003.71012-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uclogic_probe() arms a per-device timer whose callback
uclogic_inrange_timeout() dereferences drvdata->pen_input, and
uclogic_raw_event_pen() re-arms it with a 100 ms timeout on every
in-range pen report.

uclogic_remove() drained the timer with timer_delete_sync() before
hid_hw_stop().  timer_delete_sync() does not block re-arming: a pen
report delivered before hid_hw_stop() kills the URBs can re-arm the timer
after it was drained.  hid_hw_stop() then frees the hidinput pen_input
(via hidinput_disconnect() -> input_unregister_device()), and the pending
timer fires on freed memory.

Use timer_shutdown_sync() instead, still before hid_hw_stop().  It drains
the callback while pen_input is still valid and permanently blocks
re-arming, so an in-flight raw_event cannot revive the timer; hid_hw_stop()
then frees pen_input with the timer already dead.

The probe error path had the same exposure: if hid_hw_start() started I/O
and then failed, raw_event may have armed the timer, which would fire on
the devm-freed drvdata after probe returns.  Shut the timer down there too.

Unlike letsketch, whose input devices are devm-allocated and outlive
hid_hw_stop(), uclogic's pen_input is freed inside hid_hw_stop(), so the
timer must be shut down before it rather than after.

Found by 0sec (https://0sec.ai) using automated source analysis; not
runtime-reproduced.

Fixes: 01309e29eb95 ("HID: uclogic: Support in-range reporting emulation")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v2:
 - Shut the timer down *before* hid_hw_stop() rather than after.  v1
   mirrored the letsketch ordering (hid_hw_stop() first), but uclogic's
   pen_input is the hidinput device freed inside hid_hw_stop(), not a
   devm device that outlives it as in letsketch.  A timer armed just
   before the URBs are killed could still fire on the freed pen_input in
   the window before timer_shutdown_sync() drained it.  Running
   timer_shutdown_sync() before hid_hw_stop() drains the callback while
   pen_input is still valid and blocks re-arming, closing that window.
 - Also shut the timer down on the probe error path.

 drivers/hid/hid-uclogic-core.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index b73f09d26688..d74f98efa879 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -267,6 +267,13 @@ static int uclogic_probe(struct hid_device *hdev,
 	/* Assume "remove" might not be called if "probe" failed */
 	if (params_initialized)
 		uclogic_params_cleanup(&drvdata->params);
+	/*
+	 * If hid_hw_start() started I/O and then failed, raw_event may have
+	 * armed the timer; shut it down so it cannot fire on the devm-freed
+	 * drvdata after probe returns.
+	 */
+	if (drvdata)
+		timer_shutdown_sync(&drvdata->inrange_timer);
 	return rc;
 }
 
@@ -548,7 +555,15 @@ static void uclogic_remove(struct hid_device *hdev)
 {
 	struct uclogic_drvdata *drvdata = hid_get_drvdata(hdev);
 
-	timer_delete_sync(&drvdata->inrange_timer);
+	/*
+	 * timer_delete_sync() does not prevent re-arming, so a pen report
+	 * delivered before hid_hw_stop() kills the URBs could re-arm the
+	 * timer; hid_hw_stop() then frees the hidinput pen_input and the
+	 * pending timer fires on freed memory.  timer_shutdown_sync() drains
+	 * the callback while pen_input is still valid and permanently blocks
+	 * re-arming, so an in-flight raw_event cannot revive it.
+	 */
+	timer_shutdown_sync(&drvdata->inrange_timer);
 	hid_hw_stop(hdev);
 	kfree(drvdata->desc_ptr);
 	uclogic_params_cleanup(&drvdata->params);
-- 
2.43.0

