Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794347172;
	b=ZEckrWiUQLvcYi3pQ593W1uGS4/5fmCxTZ+mnHeja0l0hY1PeXyADu+EV+kcJIhaoAz8
	 48574q0vLbmmPb9Hqv7gbzm4jCb/wnJ1A40uTDiBixssJNEkCf5qIa2VR8rhi/+x6V3aS
	 7IPJJb5AD547pXY8rlkSru2WhWEVKMD8Nx0s2soEcw1+4sz+vK0wlRcXr6FJr4oqBN0UB
	 z2nrKnbjwL+gSb6TqJCu9/kYdPUCtBK8cYwWsdbBZB1I9LHkb+9mi/urHqYymzlbeEgmn
	 GgWm72W26lg3IgpCA9k+TFGJcQV9BpVw7LXRTMHQNZFJIpI0ipqmZSiqQetOSOXl4DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794347172;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=suDXBp9D788Zmye1TX7h/rdf7Ov8jPXvhOGCJkmZPBE=;
	b=nG65jaVH1QfZqeALGO8eYKsRtRF+LRp7wEAbMjT/dFHTFBew3F8vkVWpH/HA2Mj9T3bX
	 cWGAi1WJ2LsFQxT4FiSF+ieoReRK5hA92qvqgIX8/zyXtgUvKScK8HqM0Eps6+L9Q/rq0
	 UyV4fzbLbBDV/i9NaCoiAYRZ2fXVh3cY3YqxITYwD7QqJVsk7o83nLg5BC1nDzXSMLx80
	 xwQv/R8aKnbEJOYKWX2mNSx/KgqJf7XVMlpYuOeUQdcVh/65neXTuEVspiYvr2/rCnFcL
	 YJoNu9fpnOmCotj/9mIvcsshf3RpHSlp8yxcNisI07OnKaaVW/omIOIj8jdM1NeU8uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K67xWv5K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61FA606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K67xWv5K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5CD1F0089F;
	Tue, 10 Nov 2026 21:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794347171;
	bh=suDXBp9D788Zmye1TX7h/rdf7Ov8jPXvhOGCJkmZPBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K67xWv5KMIUYWZ3azz3QWqcQM/gPg89NCaApMSMYq48kizXkZgQx6b23cZHluitNN
	 qszjsYh/w4qjTPNE2ZucrLvyYRpkCWfIy3kMX7nN3NmqL28rJJ7sbVU+82JvzMec8X
	 +aKHFVmxmYQUQ2uSEWGz2g6hPpEwDsBQkG1DVknehWrWmcTkckFnHwO0rP+GbEcHRC
	 wkjmCHaIrLfE43ZGDYSgaRkaCuWNFLcuQEE5d3rQ8EUrrgZeru9P5KfsgV2EHH1J9l
	 zouPTmi6CIGO4a4JJslrPxi/e0nYR3vhLWEx8sR8EKw955PvIBQRGPKH0kmPSBA1YG
	 PbsruEtxdb5GQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stanley Jhu <stanleyjhu@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Bean Huo <beanhuo@micron.com>,
	Peter Wang <peter.wang@mediatek.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] scsi: ufs: core: Add a helper for clearing hba->outstanding_reqs
Date: Tue, 10 Nov 2026 16:46:09 -0500
Message-ID: <20261110214448.3947782-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055353-failed-6.1-22d14117ec18@kernel.org>
References: <20261107055353-failed-6.1-22d14117ec18@kernel.org>
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

From: Stanley Jhu <stanleyjhu@google.com>

[ Upstream commit 22d14117ec1845a81acb3a5c4be325f7e8332f70 ]

ufshcd_poll() and ufshcd_abort() each have their own copy of the code that
clears bits in hba->outstanding_reqs under hba->outstanding_lock.

Move that code into ufshcd_clear_outstanding_reqs() and its locked variant
__ufshcd_clear_outstanding_reqs(), and use them in both functions. No
functional change.

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/3779e125-9acc-42c8-9489-51b9e3c6716d@acm.org
Suggested-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20261022034443.3034432-3-stanleyjhu@google.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
[ sashal: adjusted context for the existing single-queue UFS implementation ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufshcd.c | 48 +++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index c86f4d226fb3e..24d1321a9b519 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -5435,6 +5435,37 @@ static void ufshcd_clear_polled(struct ufs_hba *hba,
 	}
 }
 
+/*
+ * Return a bitmask of the transfer requests cleared from
+ * @hba->outstanding_reqs.
+ */
+static unsigned long __ufshcd_clear_outstanding_reqs(struct ufs_hba *hba,
+						     unsigned long mask,
+						     bool from_irq)
+	__must_hold(&hba->outstanding_lock)
+{
+	unsigned long completed_reqs = mask & hba->outstanding_reqs;
+
+	if (from_irq) {
+		/* Do not complete polled requests from interrupt context. */
+		ufshcd_clear_polled(hba, &completed_reqs);
+	}
+	hba->outstanding_reqs &= ~completed_reqs;
+
+	return completed_reqs;
+}
+
+/*
+ * Return a bitmask of the transfer requests cleared from
+ * @hba->outstanding_reqs.
+ */
+static unsigned long ufshcd_clear_outstanding_reqs(struct ufs_hba *hba,
+						   unsigned long mask)
+{
+	guard(spinlock_irqsave)(&hba->outstanding_lock);
+	return __ufshcd_clear_outstanding_reqs(hba, mask, false);
+}
+
 /*
  * Returns > 0 if one or more commands have been completed or 0 if no
  * requests have been completed.
@@ -5444,15 +5475,13 @@ static int ufshcd_poll(struct Scsi_Host *shost, unsigned int queue_num)
 	struct ufs_hba *hba = shost_priv(shost);
 	unsigned long completed_reqs, flags;
 	u32 tr_doorbell;
+	bool from_irq;
 
 	spin_lock_irqsave(&hba->outstanding_lock, flags);
 	tr_doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
-	completed_reqs = ~tr_doorbell & hba->outstanding_reqs;
-	if (queue_num == UFSHCD_POLL_FROM_INTERRUPT_CONTEXT) {
-		/* Do not complete polled requests from interrupt context. */
-		ufshcd_clear_polled(hba, &completed_reqs);
-	}
-	hba->outstanding_reqs &= ~completed_reqs;
+	from_irq = queue_num == UFSHCD_POLL_FROM_INTERRUPT_CONTEXT;
+	completed_reqs = __ufshcd_clear_outstanding_reqs(hba, ~tr_doorbell,
+							 from_irq);
 	spin_unlock_irqrestore(&hba->outstanding_lock, flags);
 
 	if (completed_reqs)
@@ -7251,7 +7280,6 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 	struct ufshcd_lrb *lrbp = &hba->lrb[tag];
 	unsigned long flags;
 	int err = FAILED;
-	bool outstanding;
 	u32 reg;
 
 	WARN_ONCE(tag < 0, "Invalid tag %d\n", tag);
@@ -7333,11 +7361,7 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 	 * Clear the corresponding bit from outstanding_reqs since the command
 	 * has been aborted successfully.
 	 */
-	spin_lock_irqsave(&hba->outstanding_lock, flags);
-	outstanding = __test_and_clear_bit(tag, &hba->outstanding_reqs);
-	spin_unlock_irqrestore(&hba->outstanding_lock, flags);
-
-	if (outstanding)
+	if (ufshcd_clear_outstanding_reqs(hba, BIT(tag)))
 		ufshcd_release_scsi_cmd(hba, lrbp);
 
 	err = SUCCESS;
-- 
2.53.0

