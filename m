Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F4629DB64;
	Wed,  2 Sep 2026 14:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788359175; cv=none; b=f2G2pyZKQ/fImBWk8gMH9T16N4PwqLUdt7JRRpf7NunXsjsiiWOhDap54QVAEhAd6cgp1F5j42MM4sy/keiIjEwTIKRnKQW9HKSslSyFjO0jq7fK7vGPhcKL2C4QDemr/i+F9YbEyVaWHAuRUkTFzWxUHQqCpg/ioIIYi5rNmgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788359175; c=relaxed/simple;
	bh=WLBuWTB6gtv+379Oep+XiAhk8DV+lPd/5jlpDMLFgfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YcbjvPykvQx903HQ76JHq+wpowOBRwjbgQdCKWp0ZsyygRQSrv3WkJZkYyd9oDBmUkMqIAuRVLfJCZPasQMGkqOsdDKV0YgF0jVudVU0jqn4LHLqH0QzE4DkWd7DG0fQOVrqVAvHNjXOHfL9b/dvNGlmH2LsoM6dJ9JbLGan1Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=KKF8bk19; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="KKF8bk19"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c487cfc0;
	Wed, 2 Sep 2026 22:26:07 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Iwona Winiarska <iwona.winiarska@intel.com>
Cc: Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	linux-aspeed@lists.ozlabs.org,
	openbmc@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] peci: aspeed: Initialize state before requesting IRQ
Date: Wed,  2 Sep 2026 22:26:00 +0800
Message-Id: <20260902142600.3580382-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa062834d9e03a1kunm2177e8e01adc4c
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCShlDVh8fTkhKHk9IH0gZHlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=KKF8bk19ENztW57ojYhZ3fOHVd6TfrO65VlreY5e/zGH8R63SXibz+1hD52XfdiBQEOmmSl+B0x1erwvCUuV8L1sARACXJtB8X83tXJBikjKGw7EeO8+2Xq5uZ7u9qRMdUOafMr8TNGwhZei0FHZInCgqSKU8fq84x7ouLYwvxU=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=7YIOafvXbCcZYfkJxsD9i8XvErNivDNnj0yBlvpAKmg=;
	h=date:mime-version:subject:message-id:from;

The PECI interrupt handler uses the lock and completion object as soon as
the interrupt is delivered. Initialize both before registering the
handler so an early interrupt cannot access uninitialized state.

Fixes: a85e4c52086c ("peci: Add peci-aspeed controller driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/peci/controller/peci-aspeed.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/peci/controller/peci-aspeed.c b/drivers/peci/controller/peci-aspeed.c
index a0c99ecf7..5d7f4f8fd 100644
--- a/drivers/peci/controller/peci-aspeed.c
+++ b/drivers/peci/controller/peci-aspeed.c
@@ -529,14 +529,14 @@ static int aspeed_peci_probe(struct platform_device *pdev)
 	if (priv->irq < 0)
 		return priv->irq;
 
+	init_completion(&priv->xfer_complete);
+	spin_lock_init(&priv->lock);
+
 	ret = devm_request_irq(&pdev->dev, priv->irq, aspeed_peci_irq_handler,
 			       0, "peci-aspeed", priv);
 	if (ret)
 		return ret;
 
-	init_completion(&priv->xfer_complete);
-	spin_lock_init(&priv->lock);
-
 	priv->rst = devm_reset_control_get(&pdev->dev, NULL);
 	if (IS_ERR(priv->rst))
 		return dev_err_probe(priv->dev, PTR_ERR(priv->rst),
-- 
2.34.1

