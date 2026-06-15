Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F083F661D
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781532335; cv=none; b=av7/SYZ39IUCI1ooHko50q04yZPY3lbX7pA3+0+Zkw2s7GnWE2d3zByVIS+/Sek+6H/GNdgI1AGVAGy1gB3XNfsidokNiuHRw52AccprHCHBzlwYAqbrg4JbJSvi2WbEo4oBJmM7DeLJRFkY7XmWeamsPXr+mKLZzdEeCvSqsfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781532335; c=relaxed/simple;
	bh=wNlRLgc+VfgMCDRAIjUgYi0AoA49S8oofmEjD+i/wcM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BU3xjU8YHmcHn7BnvMiVXqvZTgXenJrXFcNE/kKFsIPvWHy4XgKpayeX1/bpvR3zmAzvwf8rppm154Efjz9ueO3TqW25QlcRNb+/444qbrE+6TDVu/VcsFEYGdjB+8o/0o3r8jnymyQTuAlsW4eGV83rKeE12RIqkT46SvTdcl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=ZWOerHzS; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="ZWOerHzS"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45efa80e0afso2693004f8f.2
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 07:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1781532332; x=1782137132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6MN3j+7e1dFG2jfIP/6dw1N/4Etu3I0/uUny4h6HJVI=;
        b=ZWOerHzSZ938gXKvVOH4NC1cgH1XBk5z17+ek9oivHagntLg0w7XazcPwzCv+B25D8
         rlI4yzMl+u2NLsEikki7kUhMGLCLyeoODNyOHoFr5c6tufbF1QpW0t+kOGefTK70Wcow
         AG04xN8tTYWURz4pZk1c59Y+8P7sUuKEEb0wPthZIXTHBl8aJk4oI9WStlyziqTeaPmq
         wxwLcOdHtEg8gKBOSI8S93m1VjrDxRWG7AxMt6QNvTit5FmkbqttONtfLubxOHT7RUJ3
         e/Yp3k1eT+Fr21yUjFWXNs9SZwYEKl6tnS3n6+lqMxSzmwnoaqWZEcqZc5mhkcEyduaD
         6H3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781532332; x=1782137132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MN3j+7e1dFG2jfIP/6dw1N/4Etu3I0/uUny4h6HJVI=;
        b=ZXaSkmTGqH2BbfDytPUc1m0hkBnD+cPNuEFhD0iEEcNgoLxElhUmpUfIY/7/n+GqFv
         AbRJYDPXaJcQU12nKWgWCMs/ZxLnMgUv5Yn+/iv8F4J7xaojGuBccXr2bOT1SiRK/Ktt
         2SJvXmzfyofMYHfAZQ65co3ZgKfE/JABG1gff92LoVomwzqBqPk/fqDDe6LnICaOYi6I
         zrEnshPnpx5RFi4ZVbUyqgfrVOH9Rbkt3/oiFUiwPe2TJ/NXzhPqDF9ucDEYttkHBjXQ
         8aqpL7wrYsvfCPbXJQIkY+XNdfNhE7zIH4VtIOiN1xcsqsgN1fli9ui0ZuKMHjO9qTUi
         K2NA==
X-Forwarded-Encrypted: i=1; AFNElJ9ftucGkTQeCjJ6X2mNMi+5jE3db/cnIUkoUOCTKK4OU7bml/g/BdHBE4W27jCSuRvhnemmPHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf2lRIWH1M5Bo7SxW8Dni+Pk8ytsiVwh4XrdE8OMZw3FHsz+HN
	g24dwZUu6RAKi9MoDJ6rVQ+IYJ9RgHeE22GLXMQroU9fv7ge1EYqaFJld5a630jrbbmY
X-Gm-Gg: Acq92OEjOJ9XCifeXdfUzhyUo/I7QyEjSPqKYMspnRAC0rx2fulH+ITfpmyCsVhGEMh
	qdPQcrbMzU2XuG3QsXV5sV79Vs/imDieHfj/TZqlokmRVxzWbwteepHFiJwupKFGVs7ez1Q9b7B
	kbG/mfbn7y1K1LCauO0BQvPOzh+LWGBNhVpFpsLGQ7u4brTZOe/C9N25TYEcI12SmDARcy8aQR0
	8peespDbtCtPQwy0klcaqranIk36ll0s0USZuy7jeb6BmBXatvxHI6WLYdNgiguECz9//iIGbHa
	N63aK8BoyRVA06q7ooln4C68Z4I3WxWbqT774x83ecKEVphfConqqqvOBldcnVBq5gbdO5g64Sw
	t1OpySZ6V3bGqJ2KikJB4R/hnv3zN99lHaFlxp8MET+C5dc5Z7p9mIFYJSAmvATfl8zepylNALF
	R8ovlCdESR91rMbxAgT0cqDrAqOUfpfhN23HftX8N2wdvjsNJmzHJEQfC1kswFrHp4n9G4E+LhD
	NIwkBKAF76lS6/4chN20CkzvHqHwGv5G1dLfB5s7jxfvg==
X-Received: by 2002:a05:6000:1844:b0:439:c18f:5aaf with SMTP id ffacd0b85a97d-4606dbf15f5mr21550537f8f.34.1781532332022;
        Mon, 15 Jun 2026 07:05:32 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f3basm33177359f8f.12.2026.06.15.07.05.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Jun 2026 07:05:31 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: neil.armstrong@linaro.org,
	mchehab@kernel.org,
	gregkh@linuxfoundation.org,
	khilman@baylibre.com
Cc: jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com,
	mjourdan@baylibre.com,
	hverkuil@kernel.org,
	linux-media@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>,
	stable@vger.kernel.org
Subject: [PATCH] media: meson: vdec: fix use-after-free of decode work in stop/close path
Date: Mon, 15 Jun 2026 16:05:29 +0200
Message-ID: <20260615140529.52653-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vdec_close() calls v4l2_m2m_ctx_release() and then kfree(sess) without
ever cancelling sess->esparser_queue_work. The worker
esparser_queue_all_src() takes sess->lock and walks the source buffers
of sess->m2m_ctx, so if it is still pending or running when the session
is torn down it dereferences freed memory.

The work is (re-)armed from several places, including amvdec_buf_done(),
which runs from the decode-completion/IRQ path. That makes the obvious
fixes insufficient:

  - v4l2_m2m_ctx_release() frees m2m_ctx (and runs stop_streaming via
    vb2_queue_release()), but never cancels the work. Cancelling in
    vdec_close() after v4l2_m2m_ctx_release() would wait on a worker that
    may already be dereferencing the now-freed m2m_ctx.

  - Cancelling in vdec_close() before v4l2_m2m_ctx_release() keeps
    m2m_ctx valid, but the hardware is still live, so amvdec_buf_done()
    can re-arm the work right after the cancel, reintroducing the UAF.

Cancel the work in vdec_stop_streaming() instead, right after
vdec_poweroff() has quiesced the hardware (so its IRQ can no longer
re-arm the work) and while sess->m2m_ctx is still valid. Because
v4l2_m2m_ctx_release() always tears the queues down through
vb2_queue_release() -> __vb2_queue_cancel() -> stop_streaming, this
single cancel covers both the STREAMOFF and the close paths.

This does not deadlock: the queue lock (sess->lock, shared by both vb2
queues) is taken by the worker, but neither the STREAMOFF path
(video_ioctl2 serialises on vdev->lock == core->lock, and
v4l2_m2m_streamoff() calls the lockless vb2_streamoff()) nor the close
path (vb2_queue_release()) holds sess->lock when stop_streaming runs, so
cancel_work_sync() can safely wait for the worker.

Fixes: 3e7f51bd9607 ("media: meson: add v4l2 m2m video decoder driver")
Cc: stable@vger.kernel.org
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/staging/media/meson/vdec/vdec.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/media/meson/vdec/vdec.c
index 4b77ec1af5a7..42822064cf8d 100644
--- a/drivers/staging/media/meson/vdec/vdec.c
+++ b/drivers/staging/media/meson/vdec/vdec.c
@@ -419,6 +419,16 @@ static void vdec_stop_streaming(struct vb2_queue *q)
 		sess->status = STATUS_STOPPED;
 	}
 
+	/*
+	 * The esparser_queue_work worker dereferences sess->m2m_ctx and
+	 * sess->lock. The hardware (and its IRQ, which re-arms the work via
+	 * amvdec_buf_done()) has been quiesced by vdec_poweroff() above, so
+	 * no new work can be scheduled past this point. m2m_ctx is still
+	 * valid here. Wait for any in-flight worker to finish before the
+	 * buffers and (on the close path) m2m_ctx are torn down.
+	 */
+	cancel_work_sync(&sess->esparser_queue_work);
+
 	if (q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
 		while ((buf = v4l2_m2m_src_buf_remove(sess->m2m_ctx)))
 			v4l2_m2m_buf_done(buf, VB2_BUF_STATE_ERROR);
-- 
2.43.0

