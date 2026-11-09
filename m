Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794211797;
	b=SO+SXPtUFnnrA1X6INgVamfJ+lNgGRN3vVn+zJmPzlwdvP4N5yqSFcAASv8zO7nyezvQ
	 N1ayqjVHDF+EnyhwZz1Vr+TEBcW0mYlPXK/CDE5We19PK+eJFZPnxuBU4z4hvDqXobURu
	 uErfFg+LySgKoos9DHwuJS00zqEM5v7UdkOu6ozvQROPA90K5oBIA2mBHEtOKERW68UaT
	 MK/MkBEEt2xMGGjUJ8qODtbL13l9xjr8gGmYpdyql6A+bkzollARmpiuAnkR5dY4JssPM
	 LjAu2sd0j4SU+qdZqO8bpIdafrGUpCcJ/kyhPjBAus9jwQYrCMsBv6Fmgt0QLvr19wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211797;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ztQlNM7XWz4CEoSo6w0e4xwJ1jm6ckTfoK4mBSuQIVc=;
	b=i9k8tY9xYz3H0Et5G2EJY9RPxIcQVLrH+M27oBT4QoFuB9dIRZ5KXJq7HRFZ9oX5Ssm6
	 e3uXVpEsy08y1EH24Od+ef5shvYVEdCJT8i2gBZYmCVZAX4Kdp80yGzqMq/xygwuZ0Vnf
	 fwswbxTarf5AdDvf7GKsz7FGpvSA1X3t61+k4Q5f/bMwr3Xz/bSveUDgmskOkHkY7YVKi
	 iyViDn5tv4TxOQTzIrKmUXDCYwaLDHLgtDC1Wd4yyI2blLCKazwl/C0fhGky+4p2svVwQ
	 cunHuvYhEobvOY+IShMwH/cA8FRc7x8uNh6J3rLF4mVzutdYKiWMgItlAruhsm6l/Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w8GXBhUy;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF17606A322
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 08:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FF17606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w8GXBhUy
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-36e795af1d4so485192eec.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 00:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794211797; x=1794816597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ztQlNM7XWz4CEoSo6w0e4xwJ1jm6ckTfoK4mBSuQIVc=;
        b=w8GXBhUyTBNA5I6vw+zUjd2EKLqqGh6hy8FxyCgrtCmny5K67D5B6rQE6QFOPd6V4N
         jkFVI2pEKed1G9uE9R5cMCoF7aFqlC5drolEAv/pnK0Sn+YrtT/TmahNNCH7xS71amhe
         ny3d6XQKb0IwhNyheyRIQWiQjjpEc7RyYyTuqp3rK9uv10VIY3HmZjwlCSp9wiQHv1IP
         z97vSRmENuHlBPqfr9QJIMzHAudOH3FpS+2Jj+lYjio3hBZiTRVSqc77fNA6drEW3M5i
         erXP9eQFraE0BVum28c9fHS+chuHjXdAHm0feRXcB+UfgYZ2841XgEv0MlFZVO36LQsS
         Zjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794211797; x=1794816597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ztQlNM7XWz4CEoSo6w0e4xwJ1jm6ckTfoK4mBSuQIVc=;
        b=VFEhF+Pt+PPpRdty6L3zhAdF/Pa2JLTs+wV8PLpfQfrk/J/xVfs/1jNPhPRsZITllE
         dNJqEXptJVlwbxMqfIg4SePY0ZB0vq/TTQBpjsH+n0Ps1vc6blnAmoAq6yR9bX5ADjfx
         0C6KKaNvr+3qqai7cXZxHZiJ10asnxg4jkOP5BxYGeOHc+DFk7I59lVg9DYAAS29Vsu5
         zWMF4XnRJyoN6UA+VRqbqy9uODlRtPqxoqU1zitkVbdTGuNJdS39oPBf3eyV+o74MxZH
         VGfQqsxUXt4BOTJByrHuBiUCFo+eMlimWZW5geEigKJf/8lumQnPx5+/VkxB7ISdRYRM
         SbBg==
X-Forwarded-Encrypted: i=1; AL+hErGQ9iuHhFrGJ0/Iak0FwdAW5YHQnwl0zNaGbqjn5g8IfknXnPGs9BJ5Y7bsoalVnUAu3Q3B7z8=@vger.kernel.org
X-Gm-Message-State: APuU4Z80yD3oouLavGppS9FiwFQuVAEF8qqFobzAoRlSZELSWEtrhbfA
	wegWOfKTZDVBYVaYWOYSlmdqOXJjFiI5RGShLinGNrFN43eWn15LJiKc
X-Gm-Gg: AYBFou0u6XlXQ9FgCX2PzG/XpqhZqdleBs7NJdsQW/Cxsly4gJehQsz15mpHF232sgB
	fQDkqV0znRUOlHX9oeJdcDGmhawdM2EOJE21y+F1PMJGfkXXNzCl2AW89xh1d5MOyT6fwMlgLYg
	Czndmq7jEQ0iy5rOG3VAXZNwdmAoy80T3Oa3z+bkYx2A1lHfkxt/Ei1KsWv8wwfmfMal5G2ryyi
	Og8kTa4Ch/OjSNeSwh6GO5F2u3PcqSgfaq/GhVIBnLEx44c/zGJbOccVvdVGdcKlegq3viyxCsa
	6EpIeNwPGKKH3z5cXZPaXXsQn/YrzFkvZTfo6R3j/EyTdmcBGC4SfnK2vNCC6uRFE8Oh91wlIT1
	LyOVxc/p8K1yA+DzQldfW6RxPoe8fHSewUP3HkQ3qGi9une2Ibnv7vKaXNPKUxIBLhO2SzGp6ou
	CmWvI7mKi6/MQArNlXx84mp4/rdGG0siGYjjFa/XJutGso+T6wNPfSfei8MR2OQDuifDVFIoFgq
	Q1GIBt7+Mn0W+CrWytn0Sqpr+ael00gR6kC3BOBf0oijTXeqfTHDk3SnhoZkCdSMCqEUJGu3DnM
	aW4UOs0JPZbsctrx52/Dv+eLUZxE2lY8SEp2pNI7AIwcsClp
X-Received: by 2002:a05:7300:ce09:b0:372:7af9:bb0d with SMTP id 5a478bee46e88-3727af9cbd5mr5545311eec.19.1794211796529;
        Mon, 09 Nov 2026 00:09:56 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3726039c635sm10835245eec.0.2026.11.09.00.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 00:09:55 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>,
	Zhangfei Gao <zhangfei.gao@marvell.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] dmaengine: mmp_pdma: kill tasklet on channel teardown
Date: Mon,  9 Nov 2026 17:09:44 +0900
Message-ID: <20261109080944.1368218-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hyunjung Ko <hj351016@gmail.com>

The per-channel completion tasklet (dma_do_tasklet) is scheduled from the
channel interrupt handler but is never torn down.  mmp_pdma_remove() frees
the interrupts and unregisters the DMA device, but the channel objects --
and with them the tasklet_struct -- are devm-allocated and are therefore
freed only after .remove() returns.  A tasklet scheduled just before the
interrupt was freed can still be pending at that point, so it runs against
freed memory (use-after-free).

Kill each channel's tasklet after the interrupts have been freed (so none
can be re-scheduled) and before the DMA device is unregistered, mirroring
the teardown fixes applied to other dmaengine drivers.

Fixes: c8acd6aa6bed ("dmaengine: mmp-pdma support")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/dma/mmp_pdma.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 8abd24e..2f0de65 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -1119,6 +1119,7 @@ static void mmp_pdma_remove(struct platform_device *op)
 {
 	struct mmp_pdma_device *pdev = platform_get_drvdata(op);
 	struct mmp_pdma_phy *phy;
+	struct dma_chan *chan;
 	int i, irq = 0, irq_num = 0;
 
 	if (op->dev.of_node)
@@ -1140,6 +1141,14 @@ static void mmp_pdma_remove(struct platform_device *op)
 		}
 	}
 
+	/*
+	 * The interrupts are gone now, so no new work can be scheduled.
+	 * Kill any tasklet that is still pending before the channels are
+	 * freed, otherwise it would run against freed memory.
+	 */
+	list_for_each_entry(chan, &pdev->device.channels, device_node)
+		tasklet_kill(&to_mmp_pdma_chan(chan)->tasklet);
+
 	dma_async_device_unregister(&pdev->device);
 }
 
-- 
2.43.0

