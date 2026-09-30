Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C3139E17C;
	Wed, 30 Sep 2026 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760499; cv=none; b=r5IwekKBQlbT0iRkQPi4OgaNLNld7Kl557EnbKkqv2TyKcgtGak61eT4RK/DKt6F/4xFyWwDG6FB4lL9ve1cwO1Ra9xu96KbyQOmp7OEllaACmyxXmdP4FEq0w0JgbtUw8E5HAkmo78ZUhGIQ65ikL2tzFnkhVNdefR3M0YnVR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760499; c=relaxed/simple;
	bh=Mzb59GhMFFnHJhKBKEpRat/tDE7AWzFkNb5M7FjWO9E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WOROD39L87Heoh2V7Y8YXb1UwZqJet4e/kJCnLMR/X39PrF9f1lP6WImIv1Ns/WuJC8buVYl8HkcQYYNRQmI1sbpq7zfZZwYqiWqFPD8ZdBqQS5Tvv6Xsgt8gpftoZ6uVC2eYb+qxrc2SHz+DQK9TlIHXADCdGo+HaQTW2axvHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Mpxx/oXI; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Mpxx/oXI"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4fa1ab3a0;
	Wed, 30 Sep 2026 17:28:12 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jeffrey Huang <huangjw@broadcom.com>,
	Eddie Wai <eddie.wai@broadcom.com>,
	Prashant Sreedharan <prashant@broadcom.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] bnxt: prevent timer rearming during teardown
Date: Wed, 30 Sep 2026 17:28:06 +0800
Message-Id: <20260930092806.2977763-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0f1a49f2303a1kunmdba71fac27677d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDQxhIVk4ZHhhLT05NTU5LGFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Mpxx/oXITWkmTM2fTQ00ZWhonJdrc7OgEoKT32YGvHdU0mTXtVcAMaOYdxUY94Zi+eh3PHoT1zgKDF9x1GHJOilMeM/DBxEraKMRrm7e400hAxrp4idB3nK/QHc9mdqktG1EylZyN82FiJ2nvX640+z2hawd3OPFUlyd8x/VFVM=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=eVdOK0WzdLj4gAVVLttL2pagUYIRqRXoU9ctPHbEkRo=;
	h=date:mime-version:subject:message-id:from;

bnxt_timer() checks the interface state before processing timer work, but
the final mod_timer() at bnxt_restart_timer is unconditional. If teardown
clears BNXT_STATE_OPEN while the callback is running, the callback can
rearm the timer after __bnxt_close_nic() has started deleting it.

Check BNXT_STATE_OPEN again before rearming so teardown prevents a callback
already in progress from starting another timer period.

Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d59bcca73..8a2e9e200 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14484,7 +14484,8 @@ static void bnxt_timer(struct timer_list *t)
 		bnxt_queue_sp_work(bp, BNXT_RING_COAL_NOW_SP_EVENT);
 
 bnxt_restart_timer:
-	mod_timer(&bp->timer, jiffies + bp->current_interval);
+	if (test_bit(BNXT_STATE_OPEN, &bp->state))
+		mod_timer(&bp->timer, jiffies + bp->current_interval);
 }
 
 static void bnxt_lock_sp(struct bnxt *bp)
-- 
2.34.1
