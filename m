Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438806;
	b=fqNWCb67G03E4ndqktMmKU1FgQOKfSVuqJIYEusKR9h0RLQ0Y7G/jyuq//Px7SMFWUpK
	 +P1QSfahBKjGxPjpBAAenn1+vMeBryq/7/ILePoTOoXPNDB33zYOorUwB4PHGHxOJT/OB
	 VH2qAE5I8EIfuLu9W1aUSCfcSSZKdU/BBn6Onk8Zmx4JTL+7VhWqQqGDJp+QEKKR08HMf
	 rI5j5uhLR8vnJS5C8vKVAJDMI0XdsEXiYvT6Sg9OqB4bX2e/0Szhaa/VwjkUz6yMS5JZJ
	 n5NrrTEUYioYc4IvNgOyCYMM+x9xG8hp8kIAH77WlVR2P2oDSFNfcpXI+e/WOIL6PAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438806;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ris3QWLmc7HvsNDZRsNd/dDw2RW9wx1ktOr8I+ii8Q8=;
	b=geWy6KUyQQgAxGnmEDQaAbMNd0FuYapWNSyQzwwhp9gFgsA4KYYAMS0Qo5F7HLTo2CYG
	 SmEdTGwiSNYD+0bPlPeIJp2oqWM2hSFsLq3V5U5ZQ1cnVLA/NwkZwA4k9UQwDgBFArrFy
	 Em1PapxLE0h8G9Vyh/TNv5bVfTeQ/PrfzvOeT5CaonHEXoKzm3OSRSICy7S720AJtWoCy
	 PjihGNicez3UFXcwp7WqZIru8gVxAAJ1SeupdY/a49HQoWCL0mvyhlHIZ2l96ut12c2cf
	 TGLLhCY/GB8sD18JsnZUUQYWFZN2xNccEC0srCJwAgDw2TNUy0n9wkjwDojDO8MxjXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AV9N0OCt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B92606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AV9N0OCt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211901F00A05;
	Wed, 11 Nov 2026 23:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794438805;
	bh=ris3QWLmc7HvsNDZRsNd/dDw2RW9wx1ktOr8I+ii8Q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AV9N0OCtNVq8Sxy1rdiBV8AHU+cllquq9LcC0skyATkUMokArdOxDtCkZmFGzcph9
	 QCY6vciCe+7PaIE3uq/IMYKZ+I8qjjWSBytUxFg5Ymra3oKWYttsK8zBvNNGr7JPlS
	 Bt4ihMG7D3ykSUINE30uife1ckK8j2Uih6pjroSfQntgYjIBYX58h9X4Ffwz0/5GeF
	 +UFl0vWjzSlcoWT8zgJ5/G5AthcqTLMwaFmGZojO8ezvkzAcXaXwdYRkUPZgGZBGyc
	 0uw7RsuIsJQdtJeRQaAHsr0U0M69Ki9+cSc9cC4untw2nN42p6CmLu7DVbTBo0wrMq
	 lUOh1erqxEj+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stanley Jhu <stanleyjhu@google.com>,
	Bean Huo <beanhuo@micron.com>,
	Peter Wang <peter.wang@mediatek.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] scsi: ufs: core: Remove an always-false WARN_ONCE()
Date: Wed, 11 Nov 2026 18:13:23 -0500
Message-ID: <20261111231311.408864-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061101-failed-5.15-cd37a69c367b@kernel.org>
References: <20261107061101-failed-5.15-cd37a69c367b@kernel.org>
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

[ Upstream commit cd37a69c367b6a5f685db0ac7d01f08545081a30 ]

The WARN_ONCE() in ufshcd_poll() can never fire. completed_reqs is set to
~tr_doorbell & hba->outstanding_reqs on the line above, and
hba->outstanding_reqs cannot change in between because ufshcd_poll() holds
hba->outstanding_lock. So completed_reqs & ~hba->outstanding_reqs is always
zero. Remove it. No functional change.

Cc: stable@vger.kernel.org
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
Link: https://patch.msgid.link/20261022034443.3034432-2-stanleyjhu@google.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
[ sashal: adapted ufshcd_poll() context to the equivalent code in ufshcd_transfer_req_compl() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ufshcd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 39e2fb416ec29..1a33618c43285 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -5322,9 +5322,6 @@ static irqreturn_t ufshcd_transfer_req_compl(struct ufs_hba *hba,
 	spin_lock_irqsave(&hba->outstanding_lock, flags);
 	tr_doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
 	completed_reqs = ~tr_doorbell & hba->outstanding_reqs;
-	WARN_ONCE(completed_reqs & ~hba->outstanding_reqs,
-		  "completed: %#lx; outstanding: %#lx\n", completed_reqs,
-		  hba->outstanding_reqs);
 	hba->outstanding_reqs &= ~completed_reqs;
 	spin_unlock_irqrestore(&hba->outstanding_lock, flags);
 
-- 
2.53.0

