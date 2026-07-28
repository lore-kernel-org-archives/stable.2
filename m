Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7006B3890FB;
	Tue, 28 Jul 2026 07:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785225277; cv=none; b=bJAF3iJhLbz2G7W97SWJgDHyK/OlzYrXyHDVKxl1ckRWeIaGxCk+emDdtwc0EmPUKpgVYek5e3YcOk1KhWZQMmCO7+HV2cVbvz0eYVcyn3s9SI6L+U6suXqz+XLsQVJPa8XW0Axmkg5sfe5tW6yxoHLoY+HUk3rFg+8lQqJFXm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785225277; c=relaxed/simple;
	bh=Xvw1FHykudPcsw9j+Kg2uPy4+4QVaUN3prQgHezfYek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LrlY/YrwUKLrtPTTLO9yDosB0q8gnWBixJk9Yd8kbeHjWS8pIOoT2RznFycvbo/tD4+JNE//EtmrY25qYir9j8uNnjxwo+sbPg2pe3cSKZ0NeSvGgXa9sdBNJ8zy+mbpFd0CJgQCn974+Y7MUStYhanqr898ba3TNRluuDsa6w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=FWNQZFFG; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="FWNQZFFG"
Received: from LAPTOP-99KJFSET (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 47d71b6eb;
	Tue, 28 Jul 2026 15:54:28 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: cw00.choi@samsung.com,
	krzk@kernel.org,
	myungjoo.ham@samsung.com
Cc: jianhao.xu@seu.edu.cn,
	linux-kernel@vger.kernel.org,
	Hongyan Xu <getshell@seu.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] extcon: max77843: cancel cable detection work on remove
Date: Tue, 28 Jul 2026 15:54:29 +0800
Message-ID: <20260728075429.838-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fa7b7ccc203a1kunmc885f3ebe6242
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDQ0weVklKGRoeSE9CHktIHlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSU
	hOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=FWNQZFFGjn/mnoArG4C+N2zb4UXgq6wgtv1K2xHZJn+dLF8vCDzreD9P5HfQCIsoMr6KeWJI0IwAoaVI/xIYnjQL/GdQ+zgXGQLY99LLREcixkEuPqOstFMHqixpDdl9pDcZnpbYqpZl+psQBcqr8acxwYyNKuPbA6cQ60qRdDA=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=9vwasNqdyhgGFEi0KNeUv2/GoATM7JQoTCMMJq4wm/Q=;
	h=date:mime-version:subject:message-id:from;

max77843_muic_probe() queues wq_detcable after requesting the MUIC IRQs.
max77843_muic_remove() cancels irq_work, but it leaves the delayed cable
detection work pending while tearing down the MUIC IRQ chip and I2C
client. A delayed work item that runs after remove can dereference the
driver private data and removed resources.

Cancel wq_detcable synchronously at the start of remove, before tearing
down the resources used by the worker.

This issue was found by a static analysis tool.

Fixes: 27a28d32b4f2 ("extcon: max77843: Add max77843 MUIC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 drivers/extcon/extcon-max77843.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/extcon/extcon-max77843.c b/drivers/extcon/extcon-max77843.c
index 2ae9f7f1a67..a052d7a9af0 100644
--- a/drivers/extcon/extcon-max77843.c
+++ b/drivers/extcon/extcon-max77843.c
@@ -933,6 +933,7 @@ static void max77843_muic_remove(struct platform_device *pdev)
 	struct max77843_muic_info *info = platform_get_drvdata(pdev);
 	struct max77693_dev *max77843 = info->max77843;
 
+	cancel_delayed_work_sync(&info->wq_detcable);
 	cancel_work_sync(&info->irq_work);
 	regmap_del_irq_chip(max77843->irq, max77843->irq_data_muic);
 	i2c_unregister_device(max77843->i2c_muic);
-- 
2.50.1.windows.1
