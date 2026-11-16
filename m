Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794830207;
	b=SFI2Q22mHL3YuWMrQ2qOjKB6gsLDD9hrtFfi2vuD3xG0E5HDh+Th08hk0TYPniqGvI3x
	 xSBvTqiZNkXcXwcWQKH6f2c4yqDCaotCuqYA/p/PCdPT/tmbso5BwcqHUIIc2PBeXkg8l
	 E8AY5L6tAEGPLKlf7Uxrim9o1IQGNkNDmBR/RzRGIxy2Fv16cAZf3KllMV4jo93pdSkN9
	 7uX+N03tqFACIBizqFlWEF1reSsKmT/KOFbsG5MOcliq4ggPMvhIBpviV+bnNWfBrgKPX
	 1WB1wZf/0hvG/+IEMJwbiyvyqo55kqriP7wbsKU7DcGmWNcc4IK+wcMI3qNyX1gS9Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794830207;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=4YzOvjpkX5tgwdPOk/JXkyZ8MEMVph3AxHjayVExlFU=;
	b=KdVvn+W62PmmGX3j2MuiobmT6I8gD++Bm4QeOpxF7fgO+ZJ4FGUsntjgxcAyhD7Zm5pA
	 lpdSA4PX20iKmYzPR80Q3aSn0EkH7FNz+RZCk7qaQLWo8Xho+nzqkAaMeis3Q04Zv1lF/
	 sKVGXp1+FMdqPrlNjXQNUmDwN5PxiIqQ33Znk7Fhu7nmlKY1NePkuQYfD0YRBO/BOrCnJ
	 NS/TL7JfG+XpKHY1LNSI/lehhed9fP4sA+UAB4ZwBEJRIySNgMYFHgBynwdTUntkoz6Js
	 BABJ/D346TfqT0xAbRwmwV+O3MKq9WcKqeoy8Nyy/LM7Wj3iTpesii/ScjNtUDEMp8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=mhx8kUcA;
	arc=none smtp.remote-ip=209.85.167.52
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568FA606A335
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 11:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 568FA606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=mhx8kUcA
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5c14f7768acso2666615e87.3
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 03:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794830206; x=1795435006; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4YzOvjpkX5tgwdPOk/JXkyZ8MEMVph3AxHjayVExlFU=;
        b=mhx8kUcArckpbQKbKy5DJXbBYFGN7uTiyMJU/GlkpCFH81bsNLyG7jVx4Y0NRhvtUI
         J7OvcuNMvbS6gKfgL4MVJNaIcczH4gmZb5lkmQaK7ph4gzplS8QBRO66hsGz0qdvEOoO
         lXA8Oj2whWfc1UJGWH/U+x1O9hMDp2P2AC3eA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794830206; x=1795435006;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4YzOvjpkX5tgwdPOk/JXkyZ8MEMVph3AxHjayVExlFU=;
        b=MnUplvH2MieoXjhJZpuuduvFPgwdoUcipBJA6CodG1UYPdMs8mSuDPNfwInYp+lRdb
         NPzdg9hCbiyZ7cYnAVusI1UU3X7O5/xiWX/5PKEvHtiecgHEsW+s26YOH4IuyKN4nLFi
         YWe8LL4f+XvjegAAxk4d66FFagVtyDCge+9uhGsWTqA3UXzCHg13ksrAb7Pkau3L4yZT
         wVMF7iZ6p4FVF6MRCufjkMvkNNul+ttuhSoXpeGieb6Fuoc1Fpjm/bTXdX+Tr1/AqsVd
         NEDBojNjuK4HFUIBz/yIVdVLQ/9VBZHw5p7shqmzTZqJfevQnrRvf6hQ8VYKq6CGqekT
         JTgQ==
X-Forwarded-Encrypted: i=1; AL+hErEf0UQ1USrB/yTSOk7A5deDVd0kXvwshZC05dskgaE3Esvmif46huIJpt4lDbicxNIqgTY7dPk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ctpIrIWirO2vOU1sK1Q4I4UM61Wr+GNFhQXtQAZjYi7/IYniG
	4go6mJo+5wC9yyvUGZHlomnuA3LzFScjO/Mc/AAhj/ooCp5V64gqDH0YVdu49339hg==
X-Gm-Gg: AYBFou0SCgp/HaMcwPJxV+1MJ3piBigNyulzNyMimK4CwHDH6UDsWf15tRi/mvWZHCH
	QvjmypvrG3Y2kwQ7HLSLlTJzxrA++MQ/Qy9GRz2BYovys3/tdnT0wrtTe9EONzvkTv58dlztwBV
	mzlHpWH9aS5aUd/4nxbxITeyzn97P6N/tNm7ukVYm7fn8CaoRVaboCaQW+7eht22DS0Joc3Vrou
	xMsA3y+il7ca+ElzP7mJ0SFsUqKg3IHLrttZFYaLBH7piAihrKnGqkBPIzNvCTmkj4wuoS8zBZN
	1ltqRuplAmzJAKpen3aa742SXguNdrvSLC7ebSayW0CRDSgVopJ4ozHZqky+8Zc1kkvAF6qf73C
	W28S7Me9UDXBCGsIyk+8Emh3eltIeVLRZc+0rN0giprruH0qpTDROOt6wx5aAvZRDS+La6h5flM
	fnAZzEtHG15L1RjuAzm6gViDyYj8j/XaJgclV4iwgDHqKRCujIlC9qjcmwCO4Xjt0FQ94JyJtou
	NMQMqDXClL+RZmLLiH0HL5yOmAaM+EpdT2TTiuGoKcI47DmXvvMVswYii2+6wePwKRN4TIX4jGA
	BD+hGL7jXSvoOZJfnVd99l/COXE8AQW4kVOjBR0ctQFZE0IZTJNIiL9GU4kvEVDbAhKbENVEGaQ
	Be5CeBdPaPJKm/BUuO+YtmAHLRhPUnGE=
X-Received: by 2002:a05:6512:108e:b0:5bf:d072:fa3f with SMTP id 2adb3069b0e04-5c1709fa4f2mr3628890e87.54.1794830205715;
        Mon, 16 Nov 2026 03:56:45 -0800 (PST)
Received: from ribalda.c.googlers.com (214.118.88.34.bc.googleusercontent.com. [34.88.118.214])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1712dad7dsm3183754e87.9.2026.11.16.03.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 03:56:45 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 16 Nov 2026 11:56:39 +0000
Subject: [PATCH 3/3] media: uvcvideo: Fix unaligned and OOB access
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
Message-Id: <20261116-uvc-shortmeta-v1-3-487cfe42fa89@chromium.org>
References: <20261116-uvc-shortmeta-v1-0-487cfe42fa89@chromium.org>
In-Reply-To: <20261116-uvc-shortmeta-v1-0-487cfe42fa89@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3

meta->buf and scr point to packed metadata and USB packet memory that do
not need to be aligned to anything. Also, scr + 4 is a 16-bit field, so
reading it as a u32 reads 2 bytes out of bounds.

We use *_unaligned() in the rest of uvc_video_decode_meta(), but not in
the debug print.

Fix this.

Fixes: 088ead255245 ("media: uvcvideo: Add a metadata device node")
Cc: stable@vger.kernel.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index e9be0a627033..3e3296ec5c65 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1532,9 +1532,9 @@ static void uvc_video_decode_meta(struct uvc_streaming *stream,
 		"%s(): t-sys %lluns, SOF %u, len %u, flags 0x%x, PTS %u, STC %u frame SOF %u\n",
 		__func__, ktime_to_ns(time), meta->sof, meta->length,
 		meta->flags,
-		has_pts ? *(u32 *)meta->buf : 0,
-		has_scr ? *(u32 *)scr : 0,
-		has_scr ? *(u32 *)(scr + 4) & 0x7ff : 0);
+		has_pts ? get_unaligned_le32(meta->buf) : 0,
+		has_scr ? get_unaligned_le32(scr) : 0,
+		has_scr ? get_unaligned_le16(scr + 4) & 0x7ff : 0);
 }
 
 /* ------------------------------------------------------------------------

-- 
2.56.0.679.gc527c65306-goog

