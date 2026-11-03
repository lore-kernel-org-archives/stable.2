Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703373;
	b=BSB0re0okQ5CeC1iHzAwYI0o3Ed8E0JyZl0AtjFNxAlht51wkWZBXcwynPv2NtunYY6r
	 Ty8bgb72vGuG0ChSxxrbvtT+GhYLMGbXmfb0atj5ciNKCAcyHB8Yt/gp/MYRPaJ1HWonX
	 lBeVAANTkgdWsbr9G9rOEhh12/pmGli3lQwcDq3DGm8L1ALmmNl8aQyACOMJmrj7Ga8EO
	 ZCVOuAZT6pCOf2NJ9WNmLtc/bO11+b7TgTxUTNgnGNW9LsTYirimULRo4Q+VPQyfjmjmP
	 cWugcI0hn3m0X0xFzaI4RBqn0TD2TwsA6sWpz83ayJ7wsQFKgzRKGzLbtbKETF8A+uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703373;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=yKR6z/tivkvMCUb5ROAsGb0r4GFzf/k7VChj5fSZuh8=;
	b=kKNfZHX86xi+0WNrGVUmCWjEhsAqOR/sBTr69Hf8Y8tWKj7AD3+QpLfWyZBFmhrr1J+6
	 6MLI2TdRqdO1oPfyEzaqcKFwI7H6uspScoQErXjaTLGPloyVRPFCkotnoRmNPn1/QmjAR
	 zPp3H+8XhosAH44A/1mvTb/bHieqBDFuY+oWQ8eyFjSsESn4J8niL+vAnoRGLGLhqKvZ2
	 M6wl0Ah9XZrD0sXe0D5badIv3i6XdI70lgQyVk33fwiAIRkRiYYWyr1v8C6W+/PmCgvCo
	 vLYMP6HU353MLdOSV8w7uesIPNi97D9vjuhxVM7tNUdu835jakm/WGlhixS3Sq5uWsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=U5XLIyQA;
	arc=none smtp.remote-ip=209.85.167.47
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03818606EEB8
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:56:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03818606EEB8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=U5XLIyQA
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5be4d648aacso3400349e87.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 02:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793703371; x=1794308171; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yKR6z/tivkvMCUb5ROAsGb0r4GFzf/k7VChj5fSZuh8=;
        b=U5XLIyQAQ7xr07tOMX3ePVaRpwIzstaLqVeCqgtBITo/8XqXmzudY8QRelIzK2WVYJ
         gNalBp7TxuO/ON2Df4E4TNztGYb8wkhI9I6pqGpNjxzJFY3YhcNe1Jr6hvABEJWkwMil
         JdLz+vz7iD75uCG/5Y8PskbJQSOXCyYLXZ8zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793703371; x=1794308171;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yKR6z/tivkvMCUb5ROAsGb0r4GFzf/k7VChj5fSZuh8=;
        b=HgGFkpPX+mD7z8jZqK9w0y2e2t9ezH+zG/qnuLTMnBcpxFDZcn8r6M0CvSDhwifXip
         IPJaP77w1W+WFY73Cr5NJrrBDDS7O7wnsVF4Jh+hFBbx04lIgkvDVT6Jv4qPfuWsJwQm
         exUA303FNFGEsVP7iDlc58ximp64N0P5XmUG5rnNLPLF1qhesC1rm6mOZRBRsog4P87B
         B43wS6imU4PI8IQwwwR6RxZJUCvrjr2hfGClcHU70ksYKsWLKID9FDjwZ4BNRJL1DzYI
         U4J30VYOpaAtYZ3jrT1YGiHq8zK1TkFLwmgjzGW/go7+IWiC6J58U0grAQb2DrSBWM2Z
         oyxw==
X-Forwarded-Encrypted: i=1; AKwUvBzd/nownWqZuTBmd9kmA4gnfUR5ZwheMqPbfUnpv4Uh53B4n5A2SWWKGLHF3YN4cxi+iXRreew=@vger.kernel.org
X-Gm-Message-State: APuU4Z8C3DM9OKNc6GE78/Tyxyr4FGlzwaKtTiCrwRfs7OynhM/YK6La
	lo0QBsmndHval9ONEiR1APmlYnxYvDt0gfyJvwYduJ0oC8oEKVwLKu+L0yfv7lRtDw==
X-Gm-Gg: AYBFou3ozfDD4RBovlOP/UVy/vIKr1pWqgSJaue0p0HbyZ5nHH0d/Mb6D3qdM7UILpU
	o5x3ehFis7Xk5VBkb38/dLTUagbwdYi0RGT9dCKnNFTLsPqHRHjBQp1TWbdgxmA7zUzV2dlf7F2
	2PfzMFmkbmv7WwrIrVzqla12hSe8Gphd/Fyrox5Huj6CKnmJi3MsdxMyjKq3fgijCG4hgCqqrQB
	0WEMPp7VnP0MEwraSpALCDaqwZu7ym1QukH45MHPwnBljy1LAfbZY2xKMVKKpOHysY235nRYII+
	fpUn3JDNlmJGi1gAzzEVS26NpSxojwK/WfbCA2HMnIztEK+5+FniFwhQBN6S/NTdAQoa4fFbJu/
	v8fxSBVswkCaeZ+7TG0BSc7dMnPHKTyeAmhRoQH4cZ1C7tfUQeS8RP0xFIflbPcAv1SRjQm8qoA
	14ejHIJ1B1Gd9IcJyf+qsKPXBcMRgpWRStz2VAooFCkOUHSrIQZlaOqdTCaWppa68ATPaKwkps6
	8JUGVt6npzPa2f9lCxhT1p5iApjoJY+JhNXwnE/FWPDo2RKR2aUoajh6AirM4jlqCBFMmTw70NY
	fSSkoHPUK03sytiO+53A9jua8NF199O75e5SoiHDkECu/lnPahat7T83kehv1z68IKf6nCZRCM7
	P9UTpJmwZGw==
X-Received: by 2002:a05:6512:2354:b0:5bf:d6a4:a133 with SMTP id 2adb3069b0e04-5bfd952016cmr4597256e87.3.1793703371356;
        Tue, 03 Nov 2026 02:56:11 -0800 (PST)
Received: from ribalda.c.googlers.com (214.118.88.34.bc.googleusercontent.com. [34.88.118.214])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfe0754779sm2103257e87.82.2026.11.03.02.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 02:56:10 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 03 Nov 2026 10:56:09 +0000
Subject: [PATCH v2 2/2] media: videobuf2: order buffer initialization
 before bufs_bitmap publication
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-vb2-mmap_lock-v2-2-054e11dcd013@chromium.org>
References: <20261103-vb2-mmap_lock-v2-0-054e11dcd013@chromium.org>
In-Reply-To: <20261103-vb2-mmap_lock-v2-0-054e11dcd013@chromium.org>
To: Tomasz Figa <tfiga@chromium.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.3

Stateless mem2mem decoders call vb2_find_buffer() -> vb2_get_buffer()
from .device_run() without holding q->lock or q->mmap_lock, which can
run concurrently with VIDIOC_CREATE_BUFS on a streaming queue.

Both set_bit() and test_bit() are unordered, and mutex_lock(&q->mmap_lock)
is only an acquire barrier. On weakly-ordered architectures such as
arm64, a lockless vb2_get_buffer() caller can observe a newly set bit in
q->bufs_bitmap before the kzalloc() zeroing, buffer initialization, and
q->bufs[] pointer store performed by __vb2_queue_alloc() become visible.

Pair smp_mb__before_atomic() in vb2_queue_publish_buffers() with
test_bit_acquire() in vb2_get_buffer() so that any reader observing a
set bit in q->bufs_bitmap also sees a fully initialized vb2_buffer.

Fixes: a286b0837e13 ("media: core: Add bitmap manage bufs array entries")
Cc: stable@vger.kernel.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/common/videobuf2/videobuf2-core.c | 8 ++++++++
 include/media/videobuf2-core.h                  | 6 +++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 70ef38c3d16a..d0dd4b22b646 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -461,6 +461,14 @@ static void vb2_queue_publish_buffers(struct vb2_queue *q, unsigned int start,
 
 	lockdep_assert_held(&q->mmap_lock);
 
+	/*
+	 * Order the buffer initialization and the q->bufs[] stores done by
+	 * __vb2_queue_alloc() before the bits that publish them. Pairs with
+	 * test_bit_acquire() in vb2_get_buffer(), which is also called
+	 * without q->lock or q->mmap_lock held, e.g. by vb2_find_buffer()
+	 * from a mem2mem .device_run().
+	 */
+	smp_mb__before_atomic();
 	for (i = start; i < start + count; i++) {
 		if (WARN_ON(i >= q->max_num_buffers || !q->bufs[i] ||
 			    test_bit(i, q->bufs_bitmap)))
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index 2e93e6985d5f..20b961da21e0 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -1288,7 +1288,11 @@ static inline struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q,
 	if (index >= q->max_num_buffers)
 		return NULL;
 
-	if (test_bit(index, q->bufs_bitmap))
+	/*
+	 * A set bit guarantees that the buffer is fully initialized, pairs
+	 * with smp_mb__before_atomic() in vb2_queue_publish_buffers().
+	 */
+	if (test_bit_acquire(index, q->bufs_bitmap))
 		return q->bufs[index];
 	return NULL;
 }

-- 
2.56.0.385.gac671c819a-goog

