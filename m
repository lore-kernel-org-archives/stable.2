Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2902DEA95;
	Sun, 30 Aug 2026 04:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788063317; cv=none; b=hbH3KEM8OCPZdqEa34fH/MVZl12yjbdVKzELFCwXttBxAL3HtUDsC0/Uw+L1TKje0fcB0QvNv8zh7crG1zj3mttSs16gu/OhkVNciEiJ49wLCY9/u41VAWLbJzEMVPqbr8tUM0CfJmm0yjfM3iLpHFFyNRK26g8NFjBhARsdNbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788063317; c=relaxed/simple;
	bh=1Slrpu0/W2297HicE0nNqKWHU6tK6ipZnF3iGnlqOOg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SBrnF4eqeq1VwwUS6nyvFQCeYBnIrfJQC9hPP5s9UcHYhkn5mZjYhDrFV1+1imQKDOk2bdvd4xgRBZJxBWrv4xgeZkVWrsAiRcnVwDxft+SpdSxeY/CW8SNX4qCPQVuGlvT6U/5/o813GlNJpa0dZURckOeReu63XltWff+kegw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=P09NtGdR; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="P09NtGdR"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4bd289912;
	Sun, 30 Aug 2026 12:15:04 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: arnaud.pouliquen@foss.st.com
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn
Subject: [PATCH] ASoC: sti: initialize player IRQ lock before requesting IRQ
Date: Sun, 30 Aug 2026 12:14:55 +0800
Message-Id: <20260830041455.2099799-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa050e0ca6703a1kunma75a983ced4ed
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSxlNVhpJHU1OTUxJTkpOT1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=P09NtGdRmaR1/jMG2eQT6uAp6GY+D0K+HHb7Dm/4QqVQP557vgDt6lIjxAmqp6hIMmpXNDuaIWPwTB0a2Ug3z+6WkBrGedUnK8nXnNKsJM9GuQixodN187KercS/ky3eRaWpbnANjp5P8Gp0fKu8v4bQlBlLWHxDSeS8AtXDB4k=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=TfV/nRX1JnDtWbpDUiiqIbYcOf43zkru5r5P036e9Ww=;
	h=date:mime-version:subject:message-id:from;

uni_player_init() registers the shared IRQ before initializing
player->irq_lock. A pending interrupt can invoke the handler while
the lock is still uninitialized.

Initialize the IRQ lock before registering the handler so the interrupt
path always sees valid lock state.

Fixes: d05d862ead8e ("ASoC: STI: Fix null ptr deference in IRQ handler")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 sound/soc/sti/uniperif_player.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index e4b9799ad..3537dd209 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -1095,6 +1095,8 @@ int uni_player_init(struct platform_device *pdev,
 		}
 	}
 
+	spin_lock_init(&player->irq_lock);
+
 	ret = devm_request_irq(&pdev->dev, player->irq,
 			       uni_player_irq_handler, IRQF_SHARED,
 			       dev_name(&pdev->dev), player);
@@ -1104,8 +1106,6 @@ int uni_player_init(struct platform_device *pdev,
 	}
 
 	mutex_init(&player->ctrl_lock);
-	spin_lock_init(&player->irq_lock);
-
 	/* Ensure that disabled by default */
 	SET_UNIPERIF_CONFIG_BACK_STALL_REQ_DISABLE(player);
 	SET_UNIPERIF_CTRL_ROUNDING_OFF(player);
-- 
2.34.1
