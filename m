Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F55A3D0934
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790767398; cv=none; b=tezXlwZ/qrPefrZN91q5ocWtIbXt5qSvMdK80AAtl9RxmTC+h4RqE++ltIgyQd68YHXZ8GM62yoN0sjEffnb/iSRWKnFq1SCRtQ0Faiisv5teGAD/DyMhzmUk9E2LjbkYG5JRLx4qRIYcpj71fbFR45js4jd8JInati6vb/PlNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790767398; c=relaxed/simple;
	bh=nXYmygXfW+ggCNykgpuZ3WYarsVEqnrd6hS+jb0VA5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GhsLF8Y7cknFxsV+aXSmmbrdq8IqLk8fxf6+gqBuBd5ngWUixhVBBgLt3AycYEkqv1DYyuAsnNuCVmNLbDnqpf/kOhkA9TIthPE3+68/whrC+4u0iQYRpeTjicV7QKPUtr7tMQM71RXOhoSySFbN7xmQC85cwWr2O8/mCssGDls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mR1RG8Oi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mR1RG8Oi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C5D1F000FF;
	Wed, 30 Sep 2026 11:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790767396;
	bh=TKfzxBz5UIqzpjCgHj8NPxvc618QbpjnFkGdYVuyDpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mR1RG8OiTZkm8p+KHrXA/y8U6Bb9RZimzjNNWMpkPTXCXDkDyP3hWgC4TuoOppf3y
	 M47rTAFA6pl238Q5ir8ThbVbF+gVaN4Euck27P+5j/JKa+KWM+ny87s47y+yEMwD9P
	 0XRFNhgKaRkWCIYE6zMx3H9izUANpABVWrJpmO0hk+T12qiNu6GXpjvZ3ZnIyrhyV9
	 L4ZWmxfgVDxbfWDr8gHHpdCNrwrpRmVyJ9qhK98nNryZ6U+SLqWSRj0PEpFbx83TNQ
	 yYWsB40bGV+danvLxlLfdcMOXPO9RI1uNGGz2ux6cNoNZU+1bYULxfC658qkZOxZeQ
	 oI6xlrnZ5LXBA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>,
	David Arinzon <darinzon@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] net: ena: Remove autopolling mode
Date: Wed, 30 Sep 2026 07:23:13 -0400
Message-ID: <20260930112314.1216332-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092919-snitch-prompter-ea9f@gregkh>
References: <2026092919-snitch-prompter-ea9f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

[ Upstream commit b356b9170815f822394667010d478d53901ff581 ]

This manually reverts
commit a4e262cde3cd ("net: ena: allow automatic fallback to polling mode")

which is unused.

(I did it manually because there are other minor comment
and function changes surrounding it).
Build tested only.

Suggested-by: David Arinzon <darinzon@amazon.com>
Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Link: https://patch.msgid.link/20241103194149.293456-1-linux@treblig.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 9476b4468862 ("net: ena: fix MMIO read buffer leak on probe failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_com.c | 25 +++++------------------
 drivers/net/ethernet/amazon/ena/ena_com.h | 14 -------------
 2 files changed, 5 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index 276f6a8631fb1..a7b98c0b5f285 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -763,25 +763,16 @@ static int ena_com_wait_and_process_admin_cq_interrupts(struct ena_comp_ctx *com
 
 		if (comp_ctx->status == ENA_CMD_COMPLETED) {
 			netdev_err(admin_queue->ena_dev->net_device,
-				   "The ena device sent a completion but the driver didn't receive a MSI-X interrupt (cmd %d), autopolling mode is %s\n",
-				   comp_ctx->cmd_opcode, admin_queue->auto_polling ? "ON" : "OFF");
-			/* Check if fallback to polling is enabled */
-			if (admin_queue->auto_polling)
-				admin_queue->polling = true;
+				   "The ena device sent a completion but the driver didn't receive a MSI-X interrupt (cmd %d)\n",
+				   comp_ctx->cmd_opcode);
 		} else {
 			netdev_err(admin_queue->ena_dev->net_device,
 				   "The ena device didn't send a completion for the admin cmd %d status %d\n",
 				   comp_ctx->cmd_opcode, comp_ctx->status);
 		}
-		/* Check if shifted to polling mode.
-		 * This will happen if there is a completion without an interrupt
-		 * and autopolling mode is enabled. Continuing normal execution in such case
-		 */
-		if (!admin_queue->polling) {
-			admin_queue->running_state = false;
-			ret = -ETIME;
-			goto err;
-		}
+		admin_queue->running_state = false;
+		ret = -ETIME;
+		goto err;
 	}
 
 	ret = ena_com_comp_status_to_errno(admin_queue, comp_ctx->comp_status);
@@ -1658,12 +1649,6 @@ void ena_com_set_admin_polling_mode(struct ena_com_dev *ena_dev, bool polling)
 	ena_dev->admin_queue.polling = polling;
 }
 
-void ena_com_set_admin_auto_polling_mode(struct ena_com_dev *ena_dev,
-					 bool polling)
-{
-	ena_dev->admin_queue.auto_polling = polling;
-}
-
 int ena_com_mmio_reg_read_request_init(struct ena_com_dev *ena_dev)
 {
 	struct ena_com_mmio_read *mmio_read = &ena_dev->mmio_read;
diff --git a/drivers/net/ethernet/amazon/ena/ena_com.h b/drivers/net/ethernet/amazon/ena/ena_com.h
index 3c5081d9d25d6..bb33fe209eec0 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.h
+++ b/drivers/net/ethernet/amazon/ena/ena_com.h
@@ -227,9 +227,6 @@ struct ena_com_admin_queue {
 	/* Indicate if the admin queue should poll for completion */
 	bool polling;
 
-	/* Define if fallback to polling mode should occur */
-	bool auto_polling;
-
 	u16 curr_cmd_id;
 
 	/* Indicate that the ena was initialized and can
@@ -484,17 +481,6 @@ bool ena_com_get_admin_running_state(struct ena_com_dev *ena_dev);
  */
 void ena_com_set_admin_polling_mode(struct ena_com_dev *ena_dev, bool polling);
 
-/* ena_com_set_admin_auto_polling_mode - Enable autoswitch to polling mode
- * @ena_dev: ENA communication layer struct
- * @polling: Enable/Disable polling mode
- *
- * Set the autopolling mode.
- * If autopolling is on:
- * In case of missing interrupt when data is available switch to polling.
- */
-void ena_com_set_admin_auto_polling_mode(struct ena_com_dev *ena_dev,
-					 bool polling);
-
 /* ena_com_admin_q_comp_intr_handler - admin queue interrupt handler
  * @ena_dev: ENA communication layer struct
  *
-- 
2.53.0

