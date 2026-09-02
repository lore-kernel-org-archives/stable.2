Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509E74A5ECA;
	Wed,  2 Sep 2026 15:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363628; cv=none; b=O9YfDS5vXvjK8SCWstRit5f0giR0JknCOIMv1lLlzOZ6yAkEQ3Ny8dJYHZ5htdOaMHP69TTPz5JAL5ptp3AI5qiNmfOGChl0oeCUuF0+iP+QBhVouStJgcgr8vxJAnSP8ADp+k3GWpyx+5Co+v7co5Bj9VcRPyZfhd0vy+DHL74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363628; c=relaxed/simple;
	bh=aczohct9yKCF/gDFNPJuLt57FKa91AhPpXKUrUkE634=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i+Abq9gO9tffojhdCIhsH99TP15SDKQtvZRymIJ7zcA1GQvOLu7BN5Us49EZa3lZOPBk0lrZTKbny/xJqUdWX7pYGwX1izh2/8xWtpIKVrT/cAJx9ScQrHgPQRMWDLRs8X01zNeu2lrSNRBu2j6qSws3VW/2oMZ/M1/dPRho2gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=OMyL4QjC; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="OMyL4QjC"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c49d2c9f;
	Wed, 2 Sep 2026 23:40:11 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-parisc@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] Input: hp_sdc: shut down kicker timer on module exit
Date: Wed,  2 Sep 2026 23:40:04 +0800
Message-Id: <20260902154004.3595416-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa062c71ee203a1kunm0ab02d801b0733
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTUMYVk1KQkNJHkpCGUJLT1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=OMyL4QjCQhjW3/UcsaqVn843K9GAIEDvGzR0z700BCrsIZIkSpurJat61x2xs8lmU2bPbyxzfPf/fmMgyVZjBokgCJrhYRr5JPxcfzBlUyDlp7xlCThdYLSifiwS91gUwQ9fTli3TfiOjCXsA2rzlgshHUClHu1Yq4qpAt2tf00=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=vAakssGCtG39enDgVvStTDDufueg/9BNtNaMgv4i4Wc=;
	h=date:mime-version:subject:message-id:from;

hp_sdc_kicker() rearms hp_sdc.kicker with mod_timer() after scheduling the
tasklet.  The module exit path uses timer_delete_sync().  That waits for a
callback already running but can still leave the timer rearmed.

A callback can therefore leave the timer pending while hp_sdc_exit() tears
down the driver, allowing timer activity to access dismantled driver state.

Use timer_shutdown_sync() for final teardown.  It waits for a running
callback and prevents rearming after module exit begins.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/input/serio/hp_sdc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/serio/hp_sdc.c b/drivers/input/serio/hp_sdc.c
index 1461ef319..ecf5347b6 100644
--- a/drivers/input/serio/hp_sdc.c
+++ b/drivers/input/serio/hp_sdc.c
@@ -981,7 +981,7 @@ static void hp_sdc_exit(void)
 	free_irq(hp_sdc.irq, &hp_sdc);
 	write_unlock_irq(&hp_sdc.lock);
 
-	timer_delete_sync(&hp_sdc.kicker);
+	timer_shutdown_sync(&hp_sdc.kicker);
 
 	tasklet_kill(&hp_sdc.task);
 
-- 
2.34.1

