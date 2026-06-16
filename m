Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2FD26ED5D
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 07:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781596198; cv=none; b=c962q6nbpqhqAfaT0MzMm7earfF/apWxDR/jHsi3A4jPOe+AA9eFoBUfxIbPuOOFbfs/Jo42JDq3V2y3+ZDxk2zOmoYn3D97Y42tm5uRrtsn014FGKSPMi+UpIYrSu5fE0rgKxsjGV95SQt1a2pzs8QIpKIOAGvPLlP1e6lqnfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781596198; c=relaxed/simple;
	bh=oGgWXj8gVkwv4KfYrvvS3qIYC4JcwZ6jY8+B1j5PPsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IyDtk16a+g5IXSx4lVlXx4OUiIZr4cZ8Dq7veEqfryTjBYacuLN6+qt0zjwNnApdsxFiQVgaQI2q8BC5fQj+PCOSQdq0uAab/A15mFkZmMo1/kkwcWCwmA3HqwyeGAjA3wbFm0C78ICTMrGwog8IY+2BeJEESN7800PgWRWsjto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=Hbq4baE1; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="Hbq4baE1"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490ac357c55so40568135e9.1
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 00:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1781596195; x=1782200995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fw23X1FwjGe46vUwZBuX/t+y72XuixGwM1Rny5Zyri0=;
        b=Hbq4baE1sojA5KfF2v9P4S/RZKlCxdihiJtCWddYFA0auWHnJbyRxUxcPqN9rb2clK
         20se9FlIa+hDI7eGLi4rbLbW61TINhJjp0HXHgWi0vt8xqRokcbf+qZathlDa7d/vcpd
         YOav13yFcxSJ16xe7R0OZ1SUh9NJxfkAq+/+fRMmPzkLMDs0W+5TlreAn4OfiL8cVht9
         BtgQXhLxaexPDXwGdeq7FbEafeliFrUTXtsvhjSfduwqaMIETMJWFcsjCO+MfkF04RIS
         pw+GLBo6EBLuLlQczfZSkenEimlx3NjnxIWhtD01yb+VmLkM9XDoeQRwMelDBLpUEOZF
         DmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781596195; x=1782200995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fw23X1FwjGe46vUwZBuX/t+y72XuixGwM1Rny5Zyri0=;
        b=MFMzg8R2UkB0ernoAWi6qts+ZDxQyJENKXQcQD6w1xjJqLYPDcGAz2K8E8KnLNqJCR
         Usl2xgK3CvYZsdzF6jxrcWf1ZP/aTc5+NqAikpiUzgyjs+yTztbPvznxPS7M4BZEjhOJ
         UMkxZo4Tc/sPYhKS7j2fl8dJQhw8Dm6P3+wOQfNxy532lKZJBWrYmkWdGSotKs2TszZ+
         aIEyxChxRR2JSPpUrDkg+Lr1OgaGCFh8/3c9dmqphhFA7+Ky06FQDqoJZwgrLFnEhrg6
         TtG4lHYgHLjuzWQBve9wHr/kZujp1cth9SFNBA3ato/9PjHTQiJbd48C+urNde2kBfft
         gc8g==
X-Forwarded-Encrypted: i=1; AFNElJ8EfRYJgW7niJvGR4t+/GsI/3N+gtZeYJG3h5U87zrr8WElV3Eq0PfOFbGQrn8ZWizj2X7M6GU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQCUBMXiFBpzsieTTEEAueV639FJ3SbM9iPzU+4neJQVdCS5HY
	qin+Nn5xkZx2rlEamuk231jFzuZDy7A7Jx2DP3BFqmmeEuTJuaTex5rphxqZr5n/ha5l
X-Gm-Gg: Acq92OHZJPf3juGaaGEvyeuIsM+IkkEu8+y0AMhWlrucPsva4dhOVBaY4VWEKu3arh4
	UGMIidg++tSCTw4jdr7XJYxGm9rca6GDqOoRLpjxGgNbK7mRTorqKdtCDDtM5BfzG1zf5WmdFpE
	mELOLSGdp8cq+TvYV23W11YrQGCHPlJS0MkWxYFnQAbivKmjJk5nuYeWdM8xEEyRj2Qm6Fa96i5
	OZwJk3nRqbyEEEpqfEAVOcqcjdmockCVJXMXwoRJEC+Xy45OnK5I23XJRidyGbagMejlQlHN1Jg
	BYCwRe+//PGkBtM061zPDZdZwB758O3pX4wpuU5iNGjIAD9VJlPJvO3g6ET/4ru/k0cBCk1q2Jj
	dBjXhjYggJhuPEP/gyhNPYcKkjuqXdAirtw10B5cl5u7E5egRLH+zS/gpXR46DX1QDQqXs0hTvg
	VzMh+7rwHh3X7wysP+vSypmfA7hZeFpcPBeIJQf4rhfHlHFttmvF8J0yaszPqqE78JPfW5OoGZH
	9okl6tMU09agCn3ZuPbeYlkmX5O/xztVf8BBO5w55gCjmV1WiKzRvIs
X-Received: by 2002:a05:600c:6286:b0:490:b355:9c70 with SMTP id 5b1f17b1804b1-4922ff93b2cmr36681535e9.11.1781596194984;
        Tue, 16 Jun 2026 00:49:54 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f20e77asm44475179f8f.0.2026.06.16.00.49.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 16 Jun 2026 00:49:54 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: neil.armstrong@linaro.org,
	mchehab@kernel.org,
	gregkh@linuxfoundation.org,
	khilman@baylibre.com
Cc: jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com,
	hverkuil@kernel.org,
	linux-media@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>,
	stable@vger.kernel.org
Subject: [PATCH v2] media: meson: vdec: fix use-after-free of decode work in stop/close path
Date: Tue, 16 Jun 2026 09:49:52 +0200
Message-ID: <20260616074952.93076-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ESPARSER worker (esparser_queue_all_src(), scheduled via
sess->esparser_queue_work) dereferences sess->m2m_ctx and accesses the
ESPARSER/DOS registers. On the stop_streaming()/release() paths the
buffers and, on close, the m2m context are torn down while this worker
may still be pending or running, leading to a use-after-free of the
freed session state.

vdec_poweroff() previously only called vdec_ops->stop() and disabled the
clocks; it never synchronized against the worker. Two problems follow:

  - The decode (VDEC) interrupt is threaded
    (devm_request_threaded_irq(.., vdec_isr, vdec_threaded_isr, ..)) and
    its threaded handler re-arms the worker through amvdec_dst_buf_done()
    -> schedule_work(&sess->esparser_queue_work). A handler that is still
    in flight can therefore queue the worker again after teardown has
    begun.

  - The worker touches ESPARSER/DOS registers, so it must not run after
    the clocks have been disabled.

Quiesce everything in vdec_poweroff(), in order, before disabling the
clocks: vdec_ops->stop() masks the VDEC interrupt in hardware so no new
IRQ can be raised; synchronize_irq() on the VDEC line then drains any
threaded handler still in flight (the only context that re-arms the
worker); cancel_work_sync() finally cancels/waits for the worker. After
this nothing can re-arm the work, and the worker can no longer run with
clocks disabled or against a freed m2m context.

Only the VDEC interrupt is synchronized: the ESPARSER interrupt handler
(esparser_isr()) only acknowledges the start-code-found status and wakes
the internal wait queue used by esparser_write_data(); it never touches
the session or schedules the worker, so it cannot re-arm it.

stop_streaming()/release() run under the video device lock, not under
sess->lock (the mutex the worker takes), so cancel_work_sync() here
cannot deadlock against the worker.

The VDEC IRQ number is now stored in struct amvdec_core so it is
available to synchronize_irq() at teardown.

Fixes: 3e7f51bd9607 ("media: meson: add v4l2 m2m video decoder driver")
Cc: stable@vger.kernel.org
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v2: also synchronize_irq() before cancelling the work, so a delayed
    threaded IRQ cannot re-arm it after cancel_work_sync() (raised by
    automated review). Only the VDEC IRQ is synchronized, as the
    ESPARSER IRQ handler does not touch the session or schedule the work.
v1: https://lore.kernel.org/linux-media/20260615140529.52653-1-doruk@0sec.ai/

 drivers/staging/media/meson/vdec/vdec.c | 21 +++++++++++++++++++++
 drivers/staging/media/meson/vdec/vdec.h |  3 +++
 2 files changed, 24 insertions(+)

diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/media/meson/vdec/vdec.c
index 4b77ec1af5a7..5304987546fa 100644
--- a/drivers/staging/media/meson/vdec/vdec.c
+++ b/drivers/staging/media/meson/vdec/vdec.c
@@ -123,6 +123,25 @@ static void vdec_poweroff(struct amvdec_session *sess)
 		codec_ops->drain(sess);
 
 	vdec_ops->stop(sess);
+
+	/*
+	 * vdec_ops->stop() masks the VDEC interrupt at the hardware level, so
+	 * no new IRQ can be raised past this point. The threaded ISR re-arms
+	 * the ESPARSER worker via amvdec_dst_buf_done() (schedule_work()), so
+	 * drain any in-flight handler before cancelling the worker, otherwise
+	 * a late threaded IRQ could schedule it again after the cancel.
+	 *
+	 * The worker dereferences sess->m2m_ctx and touches the ESPARSER/DOS
+	 * registers, so it must be cancelled while m2m_ctx is still valid and
+	 * the clocks are still enabled, i.e. before the clk_disable below.
+	 *
+	 * This runs from the stop_streaming()/release() paths, which are
+	 * serialized by the video device lock, not by sess->lock (the lock the
+	 * worker takes), so cancel_work_sync() cannot deadlock here.
+	 */
+	synchronize_irq(sess->core->vdec_irq);
+	cancel_work_sync(&sess->esparser_queue_work);
+
 	clk_disable_unprepare(sess->core->dos_clk);
 	clk_disable_unprepare(sess->core->dos_parser_clk);
 }
@@ -1053,6 +1072,8 @@ static int vdec_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	core->vdec_irq = irq;
+
 	ret = esparser_init(pdev, core);
 	if (ret)
 		return ret;
diff --git a/drivers/staging/media/meson/vdec/vdec.h b/drivers/staging/media/meson/vdec/vdec.h
index 7a5d8e871d70..9a50116a2665 100644
--- a/drivers/staging/media/meson/vdec/vdec.h
+++ b/drivers/staging/media/meson/vdec/vdec.h
@@ -66,6 +66,8 @@ struct amvdec_session;
  * @v4l2_dev: v4l2 device
  * @cur_sess: current decoding session
  * @lock: video device lock
+ * @vdec_irq: IRQ line of the VDEC, used to synchronize the threaded ISR
+ *	      against teardown
  */
 struct amvdec_core {
 	void __iomem *dos_base;
@@ -91,6 +93,7 @@ struct amvdec_core {
 
 	struct amvdec_session *cur_sess;
 	struct mutex lock;
+	int vdec_irq;
 };
 
 /**
-- 
2.43.0

