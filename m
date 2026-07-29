Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29474DB575;
	Wed, 29 Jul 2026 15:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338601; cv=none; b=KtXQpdZp/hu29scVCfeVDwrK0tI7s0m9LcX6y8DTWXpKLUp/mhlo3mLs1cF9F91I9Xr35cPn7ViytP6IG1Hb44J5Ul7IMg5v/mzrnJmOHNeKO4fxcip1E7eKIheLMiwlXKqNPRRFhw9l5UpCiIHe8GR7SGJcbZ5D32zOtK/CTIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338601; c=relaxed/simple;
	bh=xyBUi8ODCZ/afB0pcLqTLdSJP3AHZ3pkcnfLTF/XvQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jbWon6SuJcxAj0K93bUBhpZ11aBRLc6YnA3cX9boQNp0HLWhggeJTxDJr4OnFay+V4ILmU+GNyXb0tamMi7LQdhS6QCX7AKcrfae0MyI+aaY6VHEj12EgLn8Eu7E8nfL/Uc5xD3l45/vH5HHfIFxgXxtQi/wETZsZ65PimaFd3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=Qu6Hfxkp; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=Fe4cCiXD; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="Qu6Hfxkp";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="Fe4cCiXD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785338598; bh=xyBUi8ODCZ/afB0pcLqTLdSJP3AHZ3pkcnfLTF/XvQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qu6HfxkpDces+Yicwsvtv5Hsykfrb3FhGLKVULi4TpK4Q99jzxAtLNg2c9LMWDQD0
	 vB02eeD8kvTNAhv5CmhBV9hmURcVeUPcUo2gc+OSB0ILTJ7TvZHQeoiCRftH1Ag+Yd
	 Go8xrSd6iLb33RFMjotYqs3xPel7Xn4tlZp7l/E772vPEhjUx4q7B4N3ww09GgOm6i
	 t2KVFMgOJx7p3CatZjsZPKJs1cqNdN0lH2nY2UZtZfmjQGkdMIpAhPryN1l9DJx1X1
	 gbhw5bs3wLw/zU7TmHVTIwVXC2SxVcFuZf63JEN/bdkt5sgr+kY9+Us2SJrhPjg8ML
	 zSQAxnZhq6t6Q==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id ABA8D4253E; Wed, 29 Jul 2026 16:23:18 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785338597; bh=xyBUi8ODCZ/afB0pcLqTLdSJP3AHZ3pkcnfLTF/XvQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fe4cCiXDySaBFkplLn7JshvEf+6MUuaCM0CLsLdtcG7tBTR4ebh4I+4KV/NdDz26L
	 /CV5k7tAAJwl4ggzxjoEOHGrqcL2BX+YI0Mz2r/3ELkGHv2lNWdRFdC9fGBV2/GcIG
	 nxudmoa1CnEzwXc+RRPvp9lq51/LfHwS3ViK5o8dqcXfIWTNSuFJWwcJodsrZ4ReW0
	 55ly7bLx3nKhOWvLyoNFgBzIQcvDGKWiEZbolxzJRoB+3noVSrDbIugrXkn4CM3k1N
	 t0E4NcUBgRX7dyOioGLo7Z0GPUXKB844p7s6f3jmBC44Vu7iwL+ZDnRa4d/smKxhUO
	 or6VL4qnByjhg==
Received: from maru.local (unknown [62.232.99.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 553D842534;
	Wed, 29 Jul 2026 16:23:17 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 14/15] media: rc: Use after free in ir_raw_event_handle()
Date: Wed, 29 Jul 2026 16:22:52 +0100
Message-ID: <af96e873e8803f4e832e8a1a3546686e39b9cb98.1785338381.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785338381.git.sean@mess.org>
References: <cover.1785338381.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If rc_unregister_device() is called while IR is being processed, then
ir_raw_event_handle() could call wake_up_process(dev->raw->thread)
after kthread_stop(dev->raw->thread). Avoid use after free by using
get_task_struct().

Fixes: dccc0c3ddf8f ("media: rc: fix race between unregister and urb/irq callbacks")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/rc-ir-raw.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/media/rc/rc-ir-raw.c b/drivers/media/rc/rc-ir-raw.c
index 46c50f423798..86de1b26731d 100644
--- a/drivers/media/rc/rc-ir-raw.c
+++ b/drivers/media/rc/rc-ir-raw.c
@@ -630,8 +630,13 @@ int ir_raw_event_register(struct rc_dev *dev)
 
 void ir_raw_event_free(struct rc_dev *dev)
 {
-	kfree(dev->raw);
-	dev->raw = NULL;
+	if (dev->raw) {
+		timer_delete_sync(&dev->raw->edge_handle);
+		if (dev->raw->thread)
+			put_task_struct(dev->raw->thread);
+		kfree(dev->raw);
+		dev->raw = NULL;
+	}
 }
 
 void ir_raw_event_unregister(struct rc_dev *dev)
@@ -641,6 +646,13 @@ void ir_raw_event_unregister(struct rc_dev *dev)
 	if (!dev || !dev->raw)
 		return;
 
+	/*
+	 * After ir_raw_event_unregister() is called, an sync
+	 * call to ir_raw_event_handle() can still arrive. This function
+	 * may call wake_up_process(dev->raw->thread). Ensure this memory
+	 * is not freed by kthread_stop().
+	 */
+	get_task_struct(dev->raw->thread);
 	kthread_stop(dev->raw->thread);
 	timer_delete_sync(&dev->raw->edge_handle);
 
-- 
2.55.0

