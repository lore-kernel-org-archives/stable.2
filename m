Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B161236C0AB
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 21:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783979997; cv=none; b=ahOTY1lbdKg67mVZVveKsxm6Se+xk9+jEj7+YenXvaQpgeBPaZXELToYhYTSJo/2TJ5Ele+b2T2AZeEXou8OsApXdJ0LACCOs1rvbm50m1Z1kCLxE9DuaLvSB7PsVoLe3CPyzIPL7IWTrrp8N0pNBz1tvyFeOjlza5befFbV8tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783979997; c=relaxed/simple;
	bh=v3Z0OcIqKbNS7Ql2czcz/92okPIx5idf7ktDBvk6Vuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c4D2gj3mF+MAm7xWtruBXnZsjUqiexByPqVgZuA77juHVu3Fg1DntU2cZ3Mzk+rsJM9GVGL+DG9FFIKj/qvV78DL4yUtmFT1YcU0R+zoGEd9QZTW9CNahc7lAlXkOgdM1lGYs+wUiIHjMfm39pstgWHfQHGUaLZU3+maM5dJClA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=Jb9wKmyN; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="Jb9wKmyN"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493bc8fda98so2452825e9.0
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 14:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783979993; x=1784584793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ozUQUJeqe9DZGBHibEEkam6Vr/TczHQ5MXdbtGwigeo=;
        b=Jb9wKmyN48+TPIOCsgcG8KyOJ5WfbmcWEw6Rjx+Yvp6Y/lUkXSTfcRwRpRq2h3/G3j
         Z6deVMRYfXSqlBwFeMNV9rb7wMak48/AM5yIFPWNpSrK5qDo/QVMUX8hwQU2bp8WNFKU
         hg3i5R0hWSGx5jowZK9EAV0Q2iczfYow+BoqZLVpa3KjbznMQW3kU8eT2Udp92JL99x1
         uQQrt/xcbiiy17zLzjOlJgopY2UP8lPCw/EL8QH/xuEK+IS5x6hT+u5NIkLKNXDwH7lw
         0l4VOPqRG9wsVUxIpEC2LxPFmuexxtm6deN1iLo8QVvA7eEwrpYhrKAsHChTGLf76bpD
         +1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783979993; x=1784584793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ozUQUJeqe9DZGBHibEEkam6Vr/TczHQ5MXdbtGwigeo=;
        b=g9FpRQ993R8EzCqLYRRpcmdVZUgNUP4ElhNdFtCrtJsuLavvBSfTK2hJlwGlY0WrJE
         zhdW1K1CNAEeu6TpuFPcVzpP2KCxyWQzFPA/0CjI6WAnNefWQyUbsWI+j+cOzLQsAnFf
         /QF/olTY3otV8zya/eJg7qXZEbSoUtwmnqSYTExpsjH7P6EejY7vg9ISuQ2FGA/9LkTC
         MgJksey1ANHUbrfcfedUUIE1i8BlDugNcJ32TGpVC76obxfmueg7qkTmcXgWxNHK5x5Y
         DJ4fCPm3hgGioqB7AWQ4VIzHO1TYCu78wXg1enCudSjHhAnNnq792Zo8CN7SZb178fbF
         IP6g==
X-Forwarded-Encrypted: i=1; AHgh+RphRgnEmlPxkft0rWZWC/S3ahHGgSX4dBQO58NpgUH2Dg2oHtDLaP6DuiNkdC9d+9tXZSV4uqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFgV59SOeOnspSxUY/Zse0g+gesFeL0nt77DpMBbi8Bv7/Zxfz
	EMJO4q43+SPdAz3EgHncuFEHMnB/luHE50UwrcZQyb8Ff6ggpwq9GUVivKKe+mOQFmdP
X-Gm-Gg: AfdE7clSqDBmHu0zsspezUt4yHGvZb7h4QEg/uGJEgcbOiX9g1fm/RR7kIwDD6ODt9T
	3R8F9MGWinJmzSYjlzA/sJhFXQqDEd7UBZvuzGyleAm9opS37MlQF8s3Wy0SIm309m5HvNQ42ZS
	dPycUFmstXUH4pX593S+n0lgZ8DqPudNW6vaoUsB8b0CtzzmdsgA1W+9HvoKDbULoPMas5zdIdS
	mVaRJSPWkQBGKhABJa26xdpPtV5/EzPrMKuW8H9jlxmuDfH29Dg+clDcDsCDqPmEZJrytgEhXXp
	i860OtR32jy4wEQVK8PHn4G8YSpMJtMgDKC6e5ty6Ltj3yBY/FCrng4f/OJjbWoUaqCJm1zzAVZ
	8sW0fMM0Q1DEoSm7N7Ae5lbVlXG329C7AIzngjuuwzvqL6W1I6YvBrvtRCotR8xKcP5YIIvlkzB
	xkjA5nz2T9iHBXF0yqHTDGtNg6iaB4wuyZg+yCiFXMYDvAwor7GwQvuxl/y3oCaOIbzdJmSfzSS
	jqBj9Z/7QC8usPzNRVBSa624LHsgBAsSKc=
X-Received: by 2002:a05:600c:6989:b0:493:bfbf:1da4 with SMTP id 5b1f17b1804b1-493f881de65mr105429795e9.22.1783979992654;
        Mon, 13 Jul 2026 14:59:52 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635a63esm2584715f8f.9.2026.07.13.14.59.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 14:59:52 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Nikolai Kondrashov <spbnick@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] HID: uclogic: fix UAF on inrange_timer at teardown and probe error
Date: Mon, 13 Jul 2026 23:59:49 +0200
Message-ID: <20260713215950.24193-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
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

Found by 0sec (https://0sec.ai).

Fixes: 01309e29eb95 ("HID: uclogic: Support in-range reporting emulation")
Cc: stable@vger.kernel.org
Assisted-by: 0sec
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v3: resend as a 2-patch series. 1/2 is the v2 timer fix, unchanged. 2/2 adds
    the desc_ptr leak fix in the probe error path, flagged by the Sashiko AI
    review on v2. No functional change to this patch since v2.
v2: shut the timer down on the probe error path too, and clarify in the commit
    message why uclogic differs from the letsketch precedent (pen_input is
    freed inside hid_hw_stop(), so the timer must be shut down before it).

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

