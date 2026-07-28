Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82C73DDB0D;
	Tue, 28 Jul 2026 07:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785225250; cv=none; b=uCiSZ3+rx0hdJwKC2PfW9BK60Anvbbph019zjz/oYR70+GwR7K/9MZRO+fFCp3uxGWqECTsPOD68tLFY+MqzPD34sY3QOoCypIxYvPXyZ7E24ZeUe95Hrcbe8avDs04ayLgb1CRIEfdQ2mE9ydv+e3+sGz7ZLRZtGhmCyDhhWfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785225250; c=relaxed/simple;
	bh=NCgd1xrt6drrbv+gnJBkRQBQ6dkmAizU9geIt+uu71U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qAeQVLTjIEIt3LjvamCkvjVGfvu2oCaWVFRRbI0T5i2uGnMeIC7/VMIPgr3pXANGIUqcIQuK2o7MJXon3Uzihcnia98jjOEG2FulOtM1BK+5hae6+09hujXIbcCP74aDFOoL5jkB6JoNBY3dy28PLGVhEesy1RXmMB2A+zJFWzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=fjIXB40W; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="fjIXB40W"
Received: from LAPTOP-99KJFSET (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 47d71b6e3;
	Tue, 28 Jul 2026 15:53:56 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: cw00.choi@samsung.com,
	krzk@kernel.org,
	myungjoo.ham@samsung.com
Cc: jianhao.xu@seu.edu.cn,
	linux-kernel@vger.kernel.org,
	Hongyan Xu <getshell@seu.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] extcon: max77693: cancel cable detection work on detach
Date: Tue, 28 Jul 2026 15:53:56 +0800
Message-ID: <20260728075356.426-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fa7b74e1603a1kunmef2953eee6201
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaSkNIVh0aHx1OTUhIT04fGFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSU
	hOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=fjIXB40WpYjtbiYImSIJWqzouA+lFMjrzPZ+1Ve4r10cOczv/MBXh+vG7f1zzl/G8/Rf3z+IoIcZ5zV6iOryVPXIfvrl2lrL/wYvFzvmzYG3KAQt8Rp/cUI3WDU7U99ep08kDQKY53g+lWJQJyfxM9jrtnAYm2+k7FrfhAyq6Lw=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=Atjy07xGqHnjizx2XJizpY1mttkcnnrzu/aQaHx4co8=;
	h=date:mime-version:subject:message-id:from;

max77693_muic_probe() queues wq_detcable after the MUIC has been
initialized. The delayed work uses the driver private data and device
resources, but the driver has no remove callback to cancel it. If the
device is detached before the delayed detection runs, the work can run
after the devm-managed data has started going away.

Initialize the delayed work with devm_delayed_work_autocancel() so the
work is synchronously cancelled during device teardown.

This issue was found by a static analysis tool.

Fixes: db1b9037424b ("extcon: MAX77693: Add extcon-max77693 driver to support Maxim MAX77693 MUIC device")
Cc: stable@vger.kernel.org
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 drivers/extcon/extcon-max77693.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-max77693.c b/drivers/extcon/extcon-max77693.c
index 2c567e0b7b7..2dee37faa09 100644
--- a/drivers/extcon/extcon-max77693.c
+++ b/drivers/extcon/extcon-max77693.c
@@ -1251,7 +1251,11 @@ static int max77693_muic_probe(struct platform_device *pdev)
 	 * After completing the booting of platform, the extcon provider
 	 * driver should notify cable state to upper layer.
 	 */
-	INIT_DELAYED_WORK(&info->wq_detcable, max77693_muic_detect_cable_wq);
+	ret = devm_delayed_work_autocancel(&pdev->dev, &info->wq_detcable,
+					   max77693_muic_detect_cable_wq);
+	if (ret)
+		return ret;
+
 	queue_delayed_work(system_power_efficient_wq, &info->wq_detcable,
 			delay_jiffies);
 
-- 
2.50.1.windows.1
