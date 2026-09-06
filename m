Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3083B3BFE
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 09:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788686677; cv=none; b=VJYJp2MXGWZ+24cA6va6vfhq2CYakBVFKI6AXlBEMTML4aIG4o7v9MMj9wX6O7XAm31HtkCrK6fnIorByBYquyykvGTzCZ1lh5/zVHacsUFfa8u54P7kB/nSZoj+BAiK+0VbHFknaosDmwC65M/Rrc6eaqIOBLGYskjHXQYyhfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788686677; c=relaxed/simple;
	bh=R0d2I2oFbcaISY9HYkvAh+fEqUo/dGsfYd8ObVhTkvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KutgOa789qfQl8tDhNgB5kE6wULQG+zhVF1hcptOIBgxB3JO/KRlEr85e6tI64UL+eQJZC+Mt+OL/yeHN6+4S61Er+wN3SsxoOHCWPdz0+o6BVCmzxouG/IAk4TwJXmsFYYNWxKrC7A/sih/zl4IquRlGMG2cn//P2yM0keD6Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnQSFFXk; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnQSFFXk"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49d036e0e99so5325965e9.1
        for <stable@vger.kernel.org>; Sun, 06 Sep 2026 02:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788686674; x=1789291474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ey8A+s9kaQEFouzsUcbahf9veFscS+cZ76Rl/QxLJxk=;
        b=jnQSFFXkR/0qcrK3lHgwdPUq2hNZM1k/7SFaLadUSy71AQkijIARUM2Y3k2H7+VkOf
         /W0oaWRb6OjC7zvJoaeSCSQfsD+oz51UIHcpohSGuzheP5BHQIpy0/9BeCU1shlZk39e
         RooxDPi6JwbJm9K7cD2ehwXKKx+pB3K1kjkLin+6KC1h8qT+ECs95Jy+PysMc6Wi3+5C
         RM/YWbggagJXvk4qmHTeD5n1CcNEpG/9xT3SPvfUrvwNzInFMy8E96bdwEhIUZjRmt+P
         pO20M5p3uruJt/+l9vVEWuVdZ8Xa7MHFVpis/CDTpuR0nDXrjusffyLjVD8q5b/pQGNs
         7aXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788686674; x=1789291474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ey8A+s9kaQEFouzsUcbahf9veFscS+cZ76Rl/QxLJxk=;
        b=B4DTJKML8xyH3ZahpZTB8al00C10F/8/oHhgBBHNVOLEpWnBVEtRMA6eerw3YzEpdq
         YpgdrwGyz1W946Z3Qo0SCobALOTl385LBbWvMb20ewHQF3GrGCn+Llji5YwPIj2F2A1a
         XJSWLbGSjPm7GLkI5IHvmU1hdkuwNlByi/uIz9uWZmdcn6jY/Nd6hP37eqY2PWvT/G2w
         zzPKJIUqrI7AjCzLXZVRVZ/qDmGi+sG9p6if/26WBjaPrESydYjvLXOIEFa7EPJBr0pj
         0T8vQ/w5/csteDtxcFA4iHHxOhI5lq3e3qDXpdfzCG9GAavjbbsdRfweBGqxr38SuygR
         tDhA==
X-Forwarded-Encrypted: i=1; AKwUvByndLq6deu+LUtbvS5Sknj66HUPYfr+o0RFoQdDqRTkuHCIaJ8bEtEqvSkiew+Oyu+zBjYzvi0=@vger.kernel.org
X-Gm-Message-State: AFuF++lVFBy3WpFSL3rnaLvpI5wfGrOkcsRaUAimOKlgtrQoHQmfRbAF
	1eVyR/nIVQKk73G4xqPSmrADt1E09X+QFIM1gvbBDOGU6MUXsqESWUUo
X-Gm-Gg: AYBFou0fAncliN5gQtiV85ROGgPC1l33L4P+78Btc+Li2vi9tf61fNwgFc0czn1nTiE
	i3gKZGGMRj6fDSQmFUAHXY448iMJHnpckDEC1xDk50vf68elOvakvRiLLSvLgkBbYCtjGtXmFUU
	ByD+Xi3+s5Begdw93bobJI9LYXKxaURlF6WVJVcjGA6rSPh9Gwzbf1LQIHHvY4adkFPrE953NPw
	YcOlvpQbwVcb+79tag5grO6upn1dScHsV6oC6vsYfl2nC6Pe9SRt8XMJvCySKQXGs+oGAL5ltt4
	BukvOOK7TfGp90iMf1pHoWGys+avt+PkM3HBkvxlbTf+zh/ZeiLDOHgH0lEatO+p9suCsxSYiar
	+G5HOFckUQPPz+RG+sVaSInfbKvqVK8d9bxceWQH1D6WXNX+VTRRDTrJjrbuadrXCYVfP3mlvgf
	4wFORA19VEritssluCgvCGPyI8ps81juDD2Sh7vP7vHfujBO+hlSCEMpIHd8HJORS75h032FAJO
	XyEYZoQV0CJaOhPopcBITZfLMu4Mr+4GjNKy7sY+tjfidbB
X-Received: by 2002:a05:600c:37cc:b0:499:ad2e:f7bc with SMTP id 5b1f17b1804b1-49cf823f107mr175775965e9.10.1788686673822;
        Sun, 06 Sep 2026 02:24:33 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf755c22esm216768265e9.0.2026.09.06.02.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 02:24:33 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: linux-media@vger.kernel.org
Cc: dan.scally@ideasonboard.com,
	jacopo.mondi@ideasonboard.com,
	mchehab@kernel.org,
	nayden.kanchev@arm.com,
	hverkuil+cisco@kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH 2/2] media: mali-c55: Check the statistics buffer address before filling
Date: Sun,  6 Sep 2026 10:24:25 +0100
Message-ID: <20260906092429.50046-2-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260906092429.50046-1-devnexen@gmail.com>
References: <20260906092429.50046-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mali_c55_stats_cpu_read() copies the metering registers into the buffer
returned by vb2_plane_vaddr() without checking it. As for the parameters
queue, a DMABUF whose exporter cannot be vmapped yields NULL, and the
memcpy_fromio() then dereferences it from the threaded interrupt
handler.

Report the failure to mali_c55_stats_fill_buffer() and complete the
buffer with VB2_BUF_STATE_ERROR.

Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 .../platform/arm/mali-c55/mali-c55-stats.c     | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-stats.c b/drivers/media/platform/arm/mali-c55/mali-c55-stats.c
index 655e52a5f288..a9c28b090b2a 100644
--- a/drivers/media/platform/arm/mali-c55/mali-c55-stats.c
+++ b/drivers/media/platform/arm/mali-c55/mali-c55-stats.c
@@ -200,9 +200,9 @@ static const struct vb2_ops mali_c55_stats_vb2_ops = {
 	.stop_streaming = mali_c55_stats_stop_streaming,
 };
 
-static void mali_c55_stats_cpu_read(struct mali_c55_stats *stats,
-				    struct mali_c55_stats_buf *buf,
-				    enum mali_c55_config_spaces cfg_space)
+static int mali_c55_stats_cpu_read(struct mali_c55_stats *stats,
+				   struct mali_c55_stats_buf *buf,
+				   enum mali_c55_config_spaces cfg_space)
 {
 	struct mali_c55 *mali_c55 = stats->mali_c55;
 	const void __iomem *src;
@@ -211,12 +211,18 @@ static void mali_c55_stats_cpu_read(struct mali_c55_stats *stats,
 
 	src = mali_c55->base + MALI_C55_REG_1024BIN_HIST;
 	dst = vb2_plane_vaddr(&buf->vb.vb2_buf, 0);
+
+	if (!dst)
+		return -EFAULT;
+
 	memcpy_fromio(dst, src, MALI_C55_1024BIN_HIST_SIZE);
 
 	src = mali_c55->base + metering_space_addrs[cfg_space];
 	dst += MALI_C55_1024BIN_HIST_SIZE;
 	length = sizeof(struct mali_c55_stats_buffer) - MALI_C55_1024BIN_HIST_SIZE;
 	memcpy_fromio(dst, src, length);
+
+	return 0;
 }
 
 void mali_c55_stats_fill_buffer(struct mali_c55 *mali_c55,
@@ -224,6 +230,7 @@ void mali_c55_stats_fill_buffer(struct mali_c55 *mali_c55,
 {
 	struct mali_c55_stats *stats = &mali_c55->stats;
 	struct mali_c55_stats_buf *buf = NULL;
+	int ret;
 
 	spin_lock(&stats->buffers.lock);
 	if (!list_empty(&stats->buffers.queue)) {
@@ -239,8 +246,9 @@ void mali_c55_stats_fill_buffer(struct mali_c55 *mali_c55,
 	buf->vb.sequence = mali_c55->isp.frame_sequence;
 	buf->vb.vb2_buf.timestamp = ktime_get_boottime_ns();
 
-	mali_c55_stats_cpu_read(stats, buf, cfg_space);
-	vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
+	ret = mali_c55_stats_cpu_read(stats, buf, cfg_space);
+	vb2_buffer_done(&buf->vb.vb2_buf,
+			ret ? VB2_BUF_STATE_ERROR : VB2_BUF_STATE_DONE);
 }
 
 void mali_c55_unregister_stats(struct mali_c55 *mali_c55)
-- 
2.55.0

