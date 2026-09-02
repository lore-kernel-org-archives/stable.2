Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8337476CE0
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 11:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788348171; cv=none; b=HFMdBaO26hnwSVRznSCa9U4aW4ky9F307TC+xi3qLCDTaHPEy5IDDTY07vwQun1E5fq0B8xuAwFP20rPaF43Z01KORtrRwNLkkgfzZeZmpBzFLLc8PqAfIcEj5XzoBpriaai6XVh9lvUx4WxsZhKWc79APJloiybwsBiHNfI0dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788348171; c=relaxed/simple;
	bh=t4YvdNfFdDmGiz+1vB8xdWVLlz5kJXbgA2rAszgLxdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CQOR9W4CxugMm1afXGsGi8F9zpgbUUG2c0tTgPOYL1Ziags0AQnFRAadBbE+NDGx7FQfEAO/X9IRCC3ItGOjSbUpyR6f+JVM+BY+zvqIBjH3gpxwdnThflIySXyc0eJ5mmBN08r2Q1eN/Eu196pJLMpdoecKE+UMGraRo0Teao4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dT8l0BZz; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dT8l0BZz"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-853c947bfefso882577b3a.0
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 04:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788348166; x=1788952966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bG2pMm0qwXP8URwYF59N+uYdVu8xUiwyKW9MTQJcAuA=;
        b=dT8l0BZzGNRRUC3/3LtLN9Xir3zTw3FFuh7iT0BXVA9KC0FTjc70+5S6JvvUXRSi5C
         Be8bdplWV8282DZmoPlIcHT+MVVBW05PkeNyi1XIzgjaUsatD+B8qSKXBIUABQxcuOk3
         wNmE1h5PUpSfpB+haBSgUbyJtA7e4zR+6Ant5/FBE7dg/8YrmgvF4iB2Giej9x20fUQk
         HB+fimW4Zy5XIXQyFKydqUSJnZkZbSsGlqXYeTtJCt0yfkWxcSYYc8UDpxcKLcKlB/kJ
         wfPEM3TG3b6xcmkGPentjOXEjdNE/oCjWZGo2wLpYAj4/JfgtQzQ4k0LH/aywZhv64OA
         H33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788348166; x=1788952966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bG2pMm0qwXP8URwYF59N+uYdVu8xUiwyKW9MTQJcAuA=;
        b=ZbBU/540WKz0HnrOO4KxbGOtqqPI8NWyiihH4fluHIYX0ruIhqfXEnzGaDgGMV4zaJ
         BbGbb9te0uREaCAFPzxpFJvgQQR6v3mrqalKjcTw5gie9EprQgkCcl3bEZ05NX0+B4av
         6vMnmkpLwu1CUl/II4sl71nBI5aPC4z90awMh/1IlBBuAzQxh1I7RxwtkxnCf1ojtIHj
         3zgJGC/xSXy8TVadA04dLVDGm7HO7XtlIdBs65twQ0C0I/t44Sx7/1u9ej6stjYQxsR+
         OJrbqHeWiGY5cwqSLCw0Uy7Enl/1av6I3+0c6Kr1l8PLmVOPSzcQ2tUW3S3FGMw7UX8b
         xh8Q==
X-Forwarded-Encrypted: i=1; AKwUvBxz25eblA2CmBkK57N5XXWzQ/7lnePiEijLv4XarCoxCn5MMJcNjxk5/lSVLhnQ1SiA8zm7YYY=@vger.kernel.org
X-Gm-Message-State: AFuF++lPAL/u+CCDhze5VfLIxZgdSbMFTHvQR3Ky0yYnJb5PhBP3kdsi
	cCPKQYfnVjiCAmaSqkkwn61AVtFu6xzbDUjBA2fCWFmgZzPiIQuMqFA+
X-Gm-Gg: AYBFou3cd+i1Dg4j5FEhwoBNLSDRat0W1sinIRYBi4w/jUjEJCjdV9y0znrXOqwvsPs
	sbQS1KXMtAp32BU6sAPe+yPYEKZ3euONv57DFcxdLouNbk2Mv57h+7f3lKUyvwaZnxcMEOC6ZN9
	bOqO3kNA17H/mQoAlz9ImSPlG1XEhPJwEXNeNih+rv6T8VzB6J3LapL9G0mewi9p3RQlKksHyaG
	sgiKdtB2bDxYQvz5ugVqT+RksI0YOy6VZw69FrDF/nn+4nr0+zH92W1DoItLewiDBwyjNE3QQDJ
	FRYMd0BWe5YUeW5CEG8WbER7QCWdFmfPefFCMXeKkCQm13iBexF1UbWu9OvQVB4ylhhdP/KsTwk
	tbvbLbZttUiwUOJb2iJK/FiFvYF10Oo8hmq9WYtYkm2HCz0Am5w8bnhLobq7EmYmpnfgjm9thSC
	XPZePtpqQsltp0gTHIt/jt6QpIkYmY05BCJBDSXffFrvHkE87hX8yXX1rJJALmstan/YSA2Q==
X-Received: by 2002:a05:6a00:178e:b0:84a:2b96:5986 with SMTP id d2e1a72fcca58-85f42e35709mr1863167b3a.8.1788348165513;
        Wed, 02 Sep 2026 04:22:45 -0700 (PDT)
Received: from hnkz-ubuntu-server ([2404:7a80:860:3300:f22f:74ff:feda:3295])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85dc11f8471sm1167571b3a.58.2026.09.02.04.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 04:22:45 -0700 (PDT)
From: Kazuki Hanai <hnkz.64@gmail.com>
To: Bin Liu <bin.liu@mediatek.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Kazuki Hanai <hnkz.64@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Hans Verkuil <hverkuil@kernel.org>,
	Tomasz Figa <tfiga@chromium.org>,
	Xia Jiang <xia.jiang@mediatek.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH] media: mediatek: jpeg: Avoid context access after job finish
Date: Wed,  2 Sep 2026 20:22:28 +0900
Message-ID: <20260902112230.452176-1-hnkz.64@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v4l2_m2m_job_finish() publishes job completion and wakes waiters
before it returns. A concurrent file release can therefore finish
v4l2_m2m_ctx_release() and free the context while the single-core IRQ
handler continues with its tail.

Both handlers only need the device for the matching runtime PM put.
Use the IRQ-owned jpeg pointer instead of dereferencing ctx after
completion has been published. This preserves the get/put pairing and
removes the post-completion context access.

Fixes: 45f13a57d813 ("media: platform: Add jpeg enc feature")
Fixes: 5827e4b14ee7 ("media: platform: Improve power on and power off flow")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
Signed-off-by: Kazuki Hanai <hnkz.64@gmail.com>
---
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
index d147ec4830811..9010e7b1108fa 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
@@ -1574,7 +1574,7 @@ static irqreturn_t mtk_jpeg_enc_done(struct mtk_jpeg_dev *jpeg)
 	v4l2_m2m_buf_done(src_buf, buf_state);
 	v4l2_m2m_buf_done(dst_buf, buf_state);
 	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
-	pm_runtime_put(ctx->jpeg->dev);
+	pm_runtime_put(jpeg->dev);
 	return IRQ_HANDLED;
 }
 
@@ -1855,7 +1855,7 @@ static irqreturn_t mtk_jpeg_dec_irq(int irq, void *priv)
 	v4l2_m2m_buf_done(src_buf, buf_state);
 	v4l2_m2m_buf_done(dst_buf, buf_state);
 	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
-	pm_runtime_put(ctx->jpeg->dev);
+	pm_runtime_put(jpeg->dev);
 	return IRQ_HANDLED;
 }
 
-- 
2.53.0
