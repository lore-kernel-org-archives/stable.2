Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B8442589A;
	Fri,  4 Sep 2026 06:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502793; cv=none; b=t5eLN83/jgQ0giShepOwZR7zelmAiEGaV1Ibp4dia2GU+cbsNJ3Sg3057lDWzHXlvjA4R09yeENqc7dxIwllBb0Ccqre/XIurZge8Es/hTAkUNJr5ZqJBlZdXjcfZBPzlabMU+V/P7FUGnXijGRy95kwQjB+fWEkzBZO9aMoTGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502793; c=relaxed/simple;
	bh=pY8eaE5vNrrmMYQDkPv8itR2+AiEIdrHKNYTuPq0Dww=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nyomPU8NwriDDBUbFT4atNUg+WIoCCTTRVvPoOdmkdX6ZSLVbPbbtE2k6obUrWg7veXBL/SRVEhvXK1bbVM/HuLXWRn7LFANQdVUVZ+1fbuC5MRdF53cyYgK8gA6hBSQ/RiYfLDBK3WkyDvPWZ7TgRfSHngdmy6VbV/1Zh8t/as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=hrGQc5xR; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="hrGQc5xR"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c858fe13;
	Fri, 4 Sep 2026 14:19:45 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Tien Sung Ang <tiensung.ang@altera.com>,
	Jassi Brar <jassisinghbrar@gmail.com>
Cc: Ley Foon Tan <lftan@altera.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] mailbox: altera: shut down RX polling timer on channel teardown
Date: Fri,  4 Sep 2026 14:19:39 +0800
Message-Id: <20260904061939.4039320-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa06b12bf3403a1kunm3777d3672b1a7
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGkhLVhoYHklDH0JISUNDSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=hrGQc5xRMhDJ1Yrq5VDo/yIChdDtyY7QRNMvHh2n2dir0IkaXQiYop57vZBfFH/K1NtE/Ia/5EmEwWQ2v+l+Km1xTOqr1ONg2Cht+H0ufVFEuUPKfcl+ItVvQMmU2Jp+SeYcvqofyrjjogRTlPfZJ87SfQMFPJZc6lLcoh/Ynlw=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=bUMd/QSqPH6ZTZ1nOBmDQQy6dXi2Rqoi8xDUyta1Hew=;
	h=date:mime-version:subject:message-id:from;

The RX polling callback unconditionally rearms the timer after it
processes mailbox data.  altera_mbox_shutdown() uses
timer_delete_sync(), which waits for a running callback but does not
prevent that callback from rearming the timer after the deletion.

Use timer_shutdown_sync() for the final polling teardown so the timer
cannot be queued again while the mailbox channel is being released.
The timer is reinitialized with timer_setup() on a later channel startup,
so polling mode remains reusable.

Fixes: f62092f6d77d ("mailbox: Add Altera mailbox driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

diff --git a/drivers/mailbox/mailbox-altera.c b/drivers/mailbox/mailbox-altera.c
index 17278c257..7cb91413e 100644
--- a/drivers/mailbox/mailbox-altera.c
+++ b/drivers/mailbox/mailbox-altera.c
@@ -270,7 +270,7 @@ static void altera_mbox_shutdown(struct mbox_chan *chan)
 		writel_relaxed(~0, mbox->mbox_base + MAILBOX_INTMASK_REG);
 		free_irq(mbox->irq, chan);
 	} else if (!mbox->is_sender) {
-		timer_delete_sync(&mbox->rxpoll_timer);
+		timer_shutdown_sync(&mbox->rxpoll_timer);
 	}
 }
 
-- 
2.34.1

