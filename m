Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15808310763
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 20:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785617597; cv=none; b=lNr2jYmKGnVybAL/z+eDN84fJYXIoDMMEmi4Xat9TvUPysuy+59ECdDub7sY6xuhNWIuTcQK7xkypIMZVlSGpalYfAcP52gP2SK4YxeuKYBSBqtYngkiOLZuOtZxR9+KG9eldwRr8OYH9c6ohBFtFk4i0UTh2U91gOpxrxwAwhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785617597; c=relaxed/simple;
	bh=dK6o0Q/obrwoWi9xABYcRVb/E/bhl6I7IPIxG8HEFfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IsvcOVEyvqzjJzLQUcayHUGtP9ggdsWnl5TMbrOpIoEgyqI7F7I7NxS8YLS2OkreD7IyglVchD/zT3CGd/tvTCaZ0Nt9bUYQeHPYQSvm9GLqN5xYPeEr/y64jDLQSNfJGMf/lb67eR1R3QTrisMTKrXemL5WHiUerVwEak0aDEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iD44l97y; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iD44l97y"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f84023916so2199048f8f.3
        for <stable@vger.kernel.org>; Sat, 01 Aug 2026 13:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785617594; x=1786222394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OJKqmH8LLrrmklRKr4uQ8cBGv4eP4F7/njSPphfYAjU=;
        b=iD44l97yncgV+SYwSILMnmb+Xufhi12wfIcalER9leHYSYIMU0V4G8N/mKQ++cv52f
         WGtZWO/TEEJxyCF+wqw4ivf/WPATwUQgvBraJ+JucZ/wcc/GrqH9qmCSA9Wkwfvliyhi
         6j5ba1q8w7OmtYHUFX/vRz1kU7bnClENBMcdKpFMgtuabCaQubpEyIq1tFxwHOIuJCpj
         zSRhO6Bkm3+DuCBYew8uZS1H9aHCQGpqqGFmnq5cyN0aS48htY9ZoE4nDYfCm6fch+rR
         2dSgHtIpwAZUYEtePjKSLocM+bQ4M0V0HQAB4T8VUuhpv6tY6V7FzKocD76Jd8Axmdyk
         Lnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785617594; x=1786222394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OJKqmH8LLrrmklRKr4uQ8cBGv4eP4F7/njSPphfYAjU=;
        b=ND7//Z33lLUQCPuXUKFncS0F0ncxwZnROUdaDIwwaDnq0AQdV4bUXCeb1sEw2ssocE
         YpsqSit6UZ0IwubYz41N25mZt3nkr4qSJLm3n/N+Lo0yaMxAJDDWz7IKykJ9DoG8vajz
         1dU56DMMnDsr0tfT9zAdE1VB9qw1bjbyOlgyiRvBqJzt66zMHMFLYJwFCwUzggrKXAXT
         uNdMY16bqEtlSdY7OP/ErvYY8UeU2izGBsM9fhlt1T3EysZgYK5kir7PIIvjOFHs1yzV
         lF63WIPVLg/mLfrHgkt9py1jBSZFqn8QUnqCnMoq0kQQdIrSQ9zWsf+ewqt251OMIRvu
         oVpw==
X-Forwarded-Encrypted: i=1; AHgh+RpV+vGt9RH4mmjMUShsX55WWPHrHVwWHDll/tSZ8AVilHOV6L1pgUEGwDM2haBAYgLC++XOilk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnEcuAx/6E++m00Zmmi0ovjlqoHsLFxpqSBHtuGKPy3965BWFA
	LZ9rmoKUhkt2o5OffC6voxjHzBjOi5itEyWpXCmxc/RNOlgFEbbZ2RFI
X-Gm-Gg: AR+sD12YXrnzVH2aB2ny/8op7T2CC7V7mZtRAhC1sLAfhZpYKGWTpO8FrJafBkeqDCm
	qrIqPT6b++1nwOMqhBX+Got2NvjgRdzgLgBVaHGhlXJWY9ZteuxQHRxcqK1jxyJLcO3TiC4ZHTr
	yTU+BibN8cmhTfbSuKFMkqvlvjkXyc2BBGqBlmVKF/hM8gSXTTL4FddeKvuB2n+zKTVE58G1R+m
	865l6BQiwnkbC6+SetJO/SMwMwMyutMyvFtFJF7UaaoXWFdeld2pDdotOgGqxl+5wOnU4e8/2bg
	V+I7LEqwy67Mq3mOwfdb43+Iz2Orl0z/cImCRLJIWLHDYPD6uiLKX81DqqvlgD/t2/N0Fim1fKQ
	NUPP5SIOnMMDonWW9RDocFdG4H582C0FF2GZBhfUivAocn/Q3KhSfuFrOB9g56s8dMRcHBAOLg7
	2Y0VgH3FZ/oDY58ndm7dke3dHKa8rikiyIqVfuXLA2te2gRWysy1q+mqvtQZdWry/jTsznIIAAD
	sdME3Y+QqmTZ8i9aOo+a3CxzZaxkoh/hjLoFdCXCzA/lkAP
X-Received: by 2002:a5d:6246:0:b0:47e:81aa:3832 with SMTP id ffacd0b85a97d-47fd72c76d1mr8250736f8f.16.1785617594067;
        Sat, 01 Aug 2026 13:53:14 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41cfdc6sm17900061f8f.8.2026.08.01.13.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 13:53:13 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: dan.scally@ideasonboard.com,
	jacopo.mondi@ideasonboard.com,
	mchehab@kernel.org,
	nayden.kanchev@arm.com,
	hverkuil+cisco@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: mali-c55: Fix frame sequence numbers on dual-pipe hardware
Date: Sat,  1 Aug 2026 21:53:11 +0100
Message-ID: <20260801205311.386692-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The single frame_sequence counter in struct mali_c55_isp is incremented
in mali_c55_set_plane_done(), which runs once per completed buffer per
capture device rather than once per frame. Hardware fitted with the
downscale pipe always hits this: mali_c55_pipeline_ready() refuses to
start the ISP unless both the full-resolution and the downscale queues
are streaming, so the counter advances twice per frame.

Each video node then reports sequence numbers 0, 2, 4, ..., which
userspace reads as a dropped frame between every pair of frames, and the
two pipes never number the same frame alike, contrary to
Documentation/admin-guide/media/mali-c55.rst. The V4L2_EVENT_FRAME_SYNC
event and the statistics and parameters buffers only read the counter,
so their sequence numbers stop identifying a frame too.

Increment the counter once per frame, when the ISP start interrupt is
handled, and let mali_c55_set_plane_done() only read it. Initialise it
to UINT_MAX so the first increment yields sequence zero. Hardware
without the downscale pipe keeps the numbering it had before.

Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/media/platform/arm/mali-c55/mali-c55-capture.c | 2 +-
 drivers/media/platform/arm/mali-c55/mali-c55-core.c    | 1 +
 drivers/media/platform/arm/mali-c55/mali-c55-isp.c     | 3 ++-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-capture.c b/drivers/media/platform/arm/mali-c55/mali-c55-capture.c
index ff01553026fb..7e1190d7fffc 100644
--- a/drivers/media/platform/arm/mali-c55/mali-c55-capture.c
+++ b/drivers/media/platform/arm/mali-c55/mali-c55-capture.c
@@ -476,7 +476,7 @@ void mali_c55_set_plane_done(struct mali_c55_cap_dev *cap_dev,
 
 	/* If the other plane is also done... */
 	buf->vb.vb2_buf.timestamp = ktime_get_boottime_ns();
-	buf->vb.sequence = isp->frame_sequence++;
+	buf->vb.sequence = isp->frame_sequence;
 	vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
 }
 
diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-core.c b/drivers/media/platform/arm/mali-c55/mali-c55-core.c
index fb81141d1653..be562156b295 100644
--- a/drivers/media/platform/arm/mali-c55/mali-c55-core.c
+++ b/drivers/media/platform/arm/mali-c55/mali-c55-core.c
@@ -573,6 +573,7 @@ static irqreturn_t mali_c55_isr(int irq, void *context)
 	for_each_set_bit(i, &interrupt_status, MALI_C55_NUM_IRQ_BITS) {
 		switch (i) {
 		case MALI_C55_IRQ_ISP_START:
+			mali_c55->isp.frame_sequence++;
 			mali_c55_isp_queue_event_sof(mali_c55);
 
 			mali_c55_set_next_buffer(&mali_c55->cap_devs[MALI_C55_CAP_DEV_FR]);
diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-isp.c b/drivers/media/platform/arm/mali-c55/mali-c55-isp.c
index e128adf6ee37..39178f6a1bd6 100644
--- a/drivers/media/platform/arm/mali-c55/mali-c55-isp.c
+++ b/drivers/media/platform/arm/mali-c55/mali-c55-isp.c
@@ -342,7 +342,8 @@ static int mali_c55_isp_enable_streams(struct v4l2_subdev *sd,
 
 	src_sd = media_entity_to_v4l2_subdev(isp->remote_src->entity);
 
-	isp->frame_sequence = 0;
+	/* first pre-increment at SOF yields sequence 0 */
+	isp->frame_sequence = UINT_MAX;
 	ret = mali_c55_isp_start(mali_c55, state);
 	if (ret) {
 		dev_err(mali_c55->dev, "Failed to start ISP\n");
-- 
2.53.0

