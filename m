Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357495;
	b=0qJxdZnA4gg8z6CU7etbf/rIr2s93VVaKmKGII/pdscWb0mALfA9Vz1cpaOZkeygtK0e
	 cX+94/5okEq+QQUbjHAJLtQFsm8nlvc5WjqijIyWHhmy9aIiFd2GtYsNax3Q24QmlEa9i
	 tToQdHJ4X91Y1grZqk46axxxB4zGNP/Pi/eZALxTJ7jTeAKHHGIXFS5QYyjn8LKOdzoQs
	 +P+Fk4aMCvEm/jwDWCWzHlVirn5+idTPv943ZQwwo8E2CPiXQBEZIWYuYR+xLhOdF1Fq8
	 GBxc3rPJsxXryvY5s/GRjazXHqc/Y/iVWSJ10h2xSw9Fru68g8sBKt2ipcubbJUg+mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357495;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=15LJpcCZu4na1Pls3/MD7s1azcWFTMKEKXOtYw7Wz2I=;
	b=iAc65ucj6oiwriatYhWkxAD9Ee3zfPoOU8/4EYqlAK+NsQK3VAgzqJ9cHd2CZ5CBUc/O
	 zBamL6CWmj2Sg5hWIrw++zOTzWxPwF+cGEfcop28bFqC+s3liXUiZBm9iID9E4De7A+nA
	 ai4Zy91dZRyOqCv2tcfjSsneqESIjvffCDm7Bn2HGis/56Bq/VKT1tVzUqbqaxa3pIe2M
	 6CHRymkXOz7ZKOviJw28nGnFxsQQGXwPeJ9L5IBkWoUCopYwHE8E9BZxSY3rklW60PdZZ
	 EWmfdqIMPNbys4zrY6rnwiaWRuun/+IwTh0EZnxzkmgo/g/c01290vU/HhDrw9DuUFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vu0CsuMB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CE660A6F4E;
	Fri, 30 Oct 2026 10:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vu0CsuMB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843591F000C1;
	Fri, 30 Oct 2026 10:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793357495;
	bh=15LJpcCZu4na1Pls3/MD7s1azcWFTMKEKXOtYw7Wz2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vu0CsuMBm4vbGc2q0cWAUVspOVUwgDF0WURIe0PNq3puQBScab97JsJL4gKS/hDSW
	 ZdVYcBJ3Ygt49CdZH8nh0WEDF6jWbX52qIyyAJuW1BcZKgPhp/R/WR5e/5NyYYQtSE
	 WenBPDM3mlZYLXB2Z57ayeXxdzj/kpjR/ZusvL0lF+bPvmk5ZxsuBi+6nK8KKn90AK
	 CfrG3M0Sa+HxDLjExFSGrXj3pk8/iiW2KTDfdQsio7YkFX27NzOXIeyWrfFjPBPwGj
	 i9hdyCujhjLkJVxjP2c4jfyGberVGVYcfajGxwVSGfGX0sNGfEgy+QCxmbSymtOId+
	 4svdzd6ht61JQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Srinivas Kandagatla <srini@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 11/21] soundwire: qcom: Prevent stale broadcast IRQ from completing subsequent command
Date: Fri, 30 Oct 2026 10:46:50 +0000
Message-ID: <20261030104840.3361217-12-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
In-Reply-To: <20261030104840.3361217-1-lee@kernel.org>
References: <20261030104840.3361217-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When wait_for_completion_timeout() expires for a broadcast command in
qcom_swrm_cmd_fifo_wr_cmd(), any late
SWRM_INTERRUPT_STATUS_SPECIAL_CMD_ID_FINISHED interrupt from the
timed-out command can fire concurrently with a subsequent broadcast
command after reinit_completion(&ctrl->broadcast), prematurely
completing the new command.

Clear any pending special command completion interrupt and reinitialise
ctrl->broadcast before issuing a broadcast command under
ctrl->intr_lock, clear the interrupt on timeout, and verify that the
interrupt status bit is still asserted under ctrl->intr_lock before
signalling ctrl->broadcast.

Fixes: ddea6cf7b619 ("soundwire: qcom: update register read/write routine")
Closes: https://sashiko.dev/#/bug/linux-fa1aa3a1-f9c7-4e8a-bdfc-49a559353546
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/soundwire/qcom.c | 44 +++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index cfa3466ff8e1..5432d3795cea 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -554,11 +554,18 @@ static int qcom_swrm_cmd_fifo_wr_cmd(struct qcom_swrm_ctrl *ctrl, u8 cmd_data,
 	if (swrm_wait_for_wr_fifo_avail(ctrl))
 		return SDW_CMD_FAIL_OTHER;
 
-	if (cmd_id == SWR_BROADCAST_CMD_ID)
+	if (cmd_id == SWR_BROADCAST_CMD_ID) {
+		mutex_lock(&ctrl->intr_lock);
+		ctrl->reg_write(ctrl,
+				ctrl->reg_layout[SWRM_REG_INTERRUPT_CLEAR],
+				SWRM_INTERRUPT_STATUS_SPECIAL_CMD_ID_FINISHED);
 		reinit_completion(&ctrl->broadcast);
-
-	/* Its assumed that write is okay as we do not get any status back */
-	ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_CMD_FIFO_WR_CMD], val);
+		ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_CMD_FIFO_WR_CMD], val);
+		mutex_unlock(&ctrl->intr_lock);
+	} else {
+		/* Its assumed that write is okay as we do not get any status back */
+		ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_CMD_FIFO_WR_CMD], val);
+	}
 
 	if (ctrl->version <= SWRM_VERSION_1_3_0)
 		usleep_range(150, 155);
@@ -571,10 +578,16 @@ static int qcom_swrm_cmd_fifo_wr_cmd(struct qcom_swrm_ctrl *ctrl, u8 cmd_data,
 		 */
 		ret = wait_for_completion_timeout(&ctrl->broadcast,
 						  msecs_to_jiffies(TIMEOUT_MS));
-		if (!ret)
+		if (!ret) {
+			mutex_lock(&ctrl->intr_lock);
+			ctrl->reg_write(ctrl,
+					ctrl->reg_layout[SWRM_REG_INTERRUPT_CLEAR],
+					SWRM_INTERRUPT_STATUS_SPECIAL_CMD_ID_FINISHED);
+			mutex_unlock(&ctrl->intr_lock);
 			ret = SDW_CMD_IGNORED;
-		else
+		} else {
 			ret = SDW_CMD_OK;
+		}
 
 	} else {
 		ret = SDW_CMD_OK;
@@ -773,6 +786,22 @@ static irqreturn_t qcom_swrm_wake_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void qcom_swrm_complete_broadcast(struct qcom_swrm_ctrl *ctrl)
+{
+	u32 status;
+
+	guard(mutex)(&ctrl->intr_lock);
+
+	ctrl->reg_read(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_STATUS],
+		       &status);
+	if (status & SWRM_INTERRUPT_STATUS_SPECIAL_CMD_ID_FINISHED) {
+		ctrl->reg_write(ctrl,
+				ctrl->reg_layout[SWRM_REG_INTERRUPT_CLEAR],
+				SWRM_INTERRUPT_STATUS_SPECIAL_CMD_ID_FINISHED);
+		complete(&ctrl->broadcast);
+	}
+}
+
 static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
 {
 	struct qcom_swrm_ctrl *ctrl = dev_id;
@@ -889,7 +918,8 @@ static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
 				mutex_unlock(&ctrl->intr_lock);
 				break;
 			case SWRM_INTERRUPT_STATUS_SPECIAL_CMD_ID_FINISHED:
-				complete(&ctrl->broadcast);
+				qcom_swrm_complete_broadcast(ctrl);
+				intr_sts &= ~SWRM_INTERRUPT_STATUS_SPECIAL_CMD_ID_FINISHED;
 				break;
 			case SWRM_INTERRUPT_STATUS_BUS_RESET_FINISHED_V2:
 				break;
-- 
2.56.0.317.g454f8302e1-goog

