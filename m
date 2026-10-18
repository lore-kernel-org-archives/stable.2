Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BB93D903B
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 22:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792364085; cv=none; b=s0PIN22Zll/rI6z1B3FqbcUhVNJcrWq15yWblgwEjo1T+EseQUA2XfFALxY0hclNIIy0kJ959xpEfwBEjH+/DJv6YRFOQOaKoMb+8PlYUgrUq5h63JURQDl3rzXzwU10nhoKChLfntpuS63OAqRX6YY3bqRjG4SLo5BXn/jKTM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792364085; c=relaxed/simple;
	bh=dxv1b+vccQom33ZO/mh8/OtjYdeB819yqMvj1KaVDSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CeCGmyyPVTfO9g4Wt0PzmuW/aWSDECqunGJk7p33AJTH27hAPjW3E5ipnuenL22WhfLjyNLzhDBr4J75em8prPrSv3bwa22nrO37AQurhjGaps2lAMmQhZadVvxESmNgO4w+bFqNDzOS0OrdEW8WdnXRiQW5L9AUL82qdFiJKMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9UFF3pa; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9UFF3pa"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a19cba5c14so16417905e9.3
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 15:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792364080; x=1792968880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h7FhAoYW9emh+NxVgMk3Jx+hbwPHLY+KSUNSM3vjf6o=;
        b=N9UFF3paw/RZqW/u5CGOMk2WWNl5VOq0RitO5k7dFs6nPpqbdsiYdH392WS4BPUHSV
         wMrhNFQRFnoVW3WPtuvvnsWbSaGGJN264eZiudhijxnQIrxyoJbhF7hXlEg18hWCTkPc
         kax0SVsUIK3Gs/A8DJHwHE234ZzMbUnteS6Tui3RE7eFdBz1cw7oNYpx0YTsignsmGa9
         oqsE7kvHEExPftLt+z8BxE4FyOFkzLuiBxwvSNVisu9Rzgr31L4nn6LAIbmJBvuIVkcu
         bKbiGOx16XUBKK9iIV8RnXUtvpp1bIkIgZX5SKr1nCq1i4T/3ZjnQA3OY/JPvudT08NE
         zFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792364080; x=1792968880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h7FhAoYW9emh+NxVgMk3Jx+hbwPHLY+KSUNSM3vjf6o=;
        b=EuN/jQ/4QjrG3hfcmoATNlJCMkF7FnNpW0ed2hEBAf4TqFEr+yJsyeCwfWQF39SfIN
         NGhMD9EioLiTtULbCym2KumoHbb0T6Mjdi0uuROO+BTLHNU3glDbJwTXvTcwANqXuFg3
         asKfYdLjESeM5zqWj24bOU55m4f7MYmfzNQTvqJW6yqGtuKHuVVuKHTpbAwcrAYTi+JJ
         Rbw5nYBlVeAk9zQ5kilGMWXaJrsgZ1Z1O49w48YCKy4TflbePQbWTr+Xq6PVnPU6U528
         Bo7fPxndH6jJ7/blARUT9ZAS+8shuP0sHV9COBIPG52BiBDpw5f29RiN++x/an7KHWmj
         YIEQ==
X-Forwarded-Encrypted: i=1; AKwUvBw71kfSB/TcvUjfJYcNyDVMVR1VQbZJbnrcu3nWC1f0SLSEQw8AaoXxWCAd6T1pT1Q+RsBQUtU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJJ1kzkcA8lADzPU/ON78jn9jptQObtB2cRkOf2hur6mF0AVqrx
	NNKRQi8fA0CxbzfiQhSVHpn7hC/hcskMEKV70S3BrJ908odN667N6BQ=
X-Gm-Gg: AYBFou3APwZrw2AAHng+9o5sT03CMS+2TXTDKnB6FwQeXHIe1CdIUXLUkuT+SH2IS9G
	tq0erCNLr57quTZtEX9iug0uRkDDqej1PExDwv0oHigUeKEgp57U4EKzlq4whrH+PHuzy0H+5lf
	dkgV0+Bjb7txmjOBXPqhglMbFJmwu6CYtRi045xw6QzwVF6zr3RMEBQ8QcO9n4Gps1gQm3cPuY7
	bkuEpv9s/DoGZ+KNZ5LIV4vblD0Oryj8i3PWSZNr8NTBSq12qZ016HiY+udbI4wGT7X73qoxe5A
	0S10RpDjhzdYAZ5aie5G+XYUHTStPPZSYFZPblj7FlDORLEx3TSMt66vJh32uYQf5ahCcqpRrpS
	IrLRsyvpfI9DEA2hN5b7qmVE//F9sO9ut/j/pQkGyJ8jGIVHO9M+2idOpWy/oCAAIfJkwl0kGfn
	+UCfbz3oXTnlYQG5jBl5go/0b5+DV29vw1qnk593w=
X-Received: by 2002:a05:600c:3b17:b0:4a1:7c7d:8881 with SMTP id 5b1f17b1804b1-4a1d76139ffmr130244235e9.13.1792364080102;
        Sun, 18 Oct 2026 15:54:40 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1e19ad17esm42257355e9.3.2026.10.18.15.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 15:54:39 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH 1/3] media: cx231xx: validate minimum transfer length in video handlers
Date: Sun, 18 Oct 2026 22:54:35 +0000
Message-ID: <20261018225437.2655311-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261018225437.2655311-1-tristmd@gmail.com>
References: <20261018225437.2655311-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

cx231xx_isoc_copy() and cx231xx_bulk_copy() both save the last 4
bytes of the transfer buffer via memcpy(dma_q->partial_buf,
p_buffer + buffer_size - 4, 4).  When the transfer length is less
than 4, the subtraction wraps to a large value and the memcpy reads
from an unintended memory offset.

Add a minimum length check to both handlers before processing.

Fixes: 64fbf4445526 ("[media] cx231xx: Added support for Carraera, Shelby, RDx_253S and VIDEO_GRABBER")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/media/usb/cx231xx/cx231xx-video.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/usb/cx231xx/cx231xx-video.c b/drivers/media/usb/cx231xx/cx231xx-video.c
index 70aa99fead278..76776cd6e5691 100644
--- a/drivers/media/usb/cx231xx/cx231xx-video.c
+++ b/drivers/media/usb/cx231xx/cx231xx-video.c
@@ -303,6 +303,9 @@ static inline int cx231xx_isoc_copy(struct cx231xx *dev, struct urb *urb)
 		buffer_size = urb->iso_frame_desc[i].actual_length;
 		bytes_parsed = 0;
 
+		if (buffer_size < 4)
+			continue;
+
 		if (dma_q->is_partial_line) {
 			/* Handle the case of a partial line */
 			sav_eav = dma_q->last_sav;
@@ -382,6 +385,9 @@ static inline int cx231xx_bulk_copy(struct cx231xx *dev, struct urb *urb)
 		buffer_size = urb->actual_length;
 		bytes_parsed = 0;
 
+		if (buffer_size < 4)
+			return 0;
+
 		if (dma_q->is_partial_line) {
 			/* Handle the case of a partial line */
 			sav_eav = dma_q->last_sav;
-- 
2.47.3

