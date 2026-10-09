Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFE529ACC6;
	Fri,  9 Oct 2026 04:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791518593; cv=none; b=Bgd0ChMHo+7pWlVqVLlhAu4mHtghQCA/H8/3Z9/xTTtg7uvyJ2sv0kdwUk6tKoznm/+iFIKbd5Esm3D+sBq3tbfdtvSN60ahF1DoSVsPXJny3SMYr3L1C1zVaz5XuWBtse8RN1EQYnmkMsJKViRiKUeJvXIE6aSzOvO7cE/e0AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791518593; c=relaxed/simple;
	bh=mMzqXnnIPwpI8ey5uExH7ZECiKvTm7kVwv+TuUAo54I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KzAiTP6ND2ApP/X0O2JkP4N7cVnLS6zvD5xCvIk00g72qK3XT9fXgv/a5L9zcO9/ebd3medVi17dsD6KzxmdP8zB+7lK1OqA5J/c6HrnEi8Uxi8p0tcXR9XWIPFae+r5GCxl3TE85pxHAkJC7phRcs99clxC2OYoPaPAx4sEe1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=lhorW8/u; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="lhorW8/u"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 506341043;
	Fri, 9 Oct 2026 12:02:53 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] sh: maple: use the matching IRQ cookie
Date: Fri,  9 Oct 2026 12:02:48 +0800
Message-Id: <20261009040248.1136356-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa11ed4030903a1kunm92fc2cac43371f
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZGUIaVklIT0tJTU4fQ0oeHVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=lhorW8/uhNKWp0ScGNxPS1+dSpd94mtQpFW0YSOaQJMmU+/5e7NrMO/DbSY/3mhweiZfTQM5/zpKBm2DxxbVDv/d2c7MYJD4IgLwWZ4dqnnlDOQVgK04Ek2vPuEY/tuAXHiCiG8LFHHg5bLOrN0ncSZN5rvJFm4hofPUUXQKutk=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=YOFlvx96QodutWTmr4/2mAXobVJqLQc8o6ofGk997gw=;
	h=date:mime-version:subject:message-id:from;

The Maple DMA and VBLANK handlers are registered with
&maple_unsupported_device as their dev_id. Passing NULL to free_irq()
cannot find either action, so the handlers remain registered and the
IRQ core warns.

Use the same cookie when freeing both handlers on the error paths.

Fixes: 17be2d2b1c33 ("sh: Add maple bus support for the SEGA Dreamcast.")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/sh/maple/maple.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
index 5585f220e..7df88e00c 100644
--- a/drivers/sh/maple/maple.c
+++ b/drivers/sh/maple/maple.c
@@ -863,10 +863,10 @@ static int __init maple_bus_init(void)
 	kmem_cache_destroy(maple_queue_cache);
 
 cleanup_bothirqs:
-	free_irq(HW_EVENT_VSYNC, 0);
+	free_irq(HW_EVENT_VSYNC, &maple_unsupported_device);
 
 cleanup_irq:
-	free_irq(HW_EVENT_MAPLE_DMA, 0);
+	free_irq(HW_EVENT_MAPLE_DMA, &maple_unsupported_device);
 
 cleanup_dma:
 	free_pages((unsigned long) maple_sendbuf, MAPLE_DMA_PAGES);
-- 
2.34.1
