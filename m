Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97794A33E1;
	Wed,  2 Sep 2026 15:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788362601; cv=none; b=Ejhqn7taHWDi0iZFo6/jILk4tLd+PJW2j2Axcfrs9bgIjsSEMjyRAqiCR9mTnYEwbyX5NWlumutJwD0PoG29ftSY/6kfg7EgtYxyZ/+7oNkb+a0GtJC26ZG3KV/loPSQMnc70PYZPruqsCESoKrvRw3n23bw8RCnaNCqUuYXDfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788362601; c=relaxed/simple;
	bh=ftISuHemVJPa7Oz5ov0k1Y7KpSgbAU6HFXGXmsSoBD8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AMvlncZ7pevH+zwU4e4OS0RLn/DX37qq5mlcPYCJcSF1gHe+Oq/u3rSuIiJB+pLr0WvAQFEQypri4csSWcWBMWLHFY+uSRfaJ1oX47+v4KWVxb00Kwrp1pnJ8WckPDnb6ENa6PSeztQjdpeufftP7UW5YrLNz1Ts8GoYUBbx++E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=TImTtoJU; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="TImTtoJU"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c491061c;
	Wed, 2 Sep 2026 23:23:03 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>,
	Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Iwona Winiarska <iwona.winiarska@intel.com>,
	openbmc@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] peci: npcm: Initialize state before requesting IRQ
Date: Wed,  2 Sep 2026 23:22:56 +0800
Message-Id: <20260902152256.3591658-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa062b76f3003a1kunm3e6bdf361afe3e
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHklDVkhDTEJNQhlIT0NPQlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=TImTtoJUXiD1qTIb0D6iXCOpnHCKrriXBqCjbhTmkXPj2AKqLzPqNheF1lXNn/qCdftmsxAbaMN9ybSXEZ9s4m7Euy9H8+9706e6atCkSRRvCzV2LJrrqwo50Iwy31S93bu+Iuc00RjMqefRtE1ZRqviwiG8k0T4+XsVgzjRpxc=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=TRS6pZD0gWBW+I2u01vpUsFWHU2ENnJgfpVpPwcSxGw=;
	h=date:mime-version:subject:message-id:from;

The PECI interrupt handler uses the lock and completion object as soon as
the interrupt is delivered. Initialize both before registering the
handler so an early interrupt cannot access uninitialized state.

Fixes: 3e16184a1bd8 ("peci: Add peci-npcm controller driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/peci/controller/peci-npcm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/peci/controller/peci-npcm.c b/drivers/peci/controller/peci-npcm.c
index 931868991..3cc4e959a 100644
--- a/drivers/peci/controller/peci-npcm.c
+++ b/drivers/peci/controller/peci-npcm.c
@@ -253,14 +253,14 @@ static int npcm_peci_probe(struct platform_device *pdev)
 	if (priv->irq < 0)
 		return priv->irq;
 
+	init_completion(&priv->xfer_complete);
+	spin_lock_init(&priv->lock);
+
 	ret = devm_request_irq(&pdev->dev, priv->irq, npcm_peci_irq_handler,
 			       0, "peci-npcm-irq", priv);
 	if (ret)
 		return ret;
 
-	init_completion(&priv->xfer_complete);
-	spin_lock_init(&priv->lock);
-
 	ret = npcm_peci_init_ctrl(priv);
 	if (ret)
 		return ret;
-- 
2.34.1
