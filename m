Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF4950B8A3
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 16:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791907300; cv=none; b=nUntrj8LZZtSfHqNmBTKnoQ65SzhMCJEnabmlwATapuYWpyI3odqIPoRS277Kzw5pDyDAxvgY0ovyXwnlHyeCzAg12Bk9yAKDZXPKkWJc0DULIt/lJHbXr64gS5gu0K9m3QjM2W7CDSzOBAZVRtePFiEYIMtg61pRq/GjP0HD+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791907300; c=relaxed/simple;
	bh=/IwIrsI2sKhrSiZ9urI2Y9TUQKVGjKdCR15x0uL23K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1Eyuni6cftI7MILvhxl+KbDQYJ4hhVbYPt/yTRNMS4KT4lkIWPyM6lgeeOF/apX/1QopkiKSYOaLxr5JHD+l2M/ke6JfzgYasIhKVVGSwZ+bbFiY61MuL7b6Qc1ISKQsdsjLwoBMH3iWpoHMSEM/6ZhpbBTzKvPFERFBU1MimI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mf5V/MiN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mf5V/MiN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404811F00898;
	Tue, 13 Oct 2026 16:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791907298;
	bh=FMfLpkT7FfFXH4LZDPveBzSp4Fml6KKuNsFZT+W4DoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mf5V/MiN/gaL4EhHxkK4SbMIAaTNPFJwvH3dA6FT9pW4gTqZfofaoKzN3ARgMUpMu
	 SJRVuo3D11gqe5lhXvL6ByO1VM4j/VVMCd4y+X5DMT2hlGr26so+ak3bSc8g8UlQ/w
	 sWlrDVTPcs2p1wpfi8QOlnW0uOkpWAx7jPnKAo8n816fawoE8L8r8IpAcRr+vK6JiM
	 gg1WSPDsj3du+p4tpeOpWlUT0/6F7Wx+C54UGz9SSqJmmMs7QFJIqDK0HYOWpVLpqz
	 vSBgV3Q4c7S2F0wnrkupl9hd7/s0jzcIHy/1Cf/s7cJ3a4aNDkG+Q4VL4OdTqwtMMU
	 xweqVY3dMX/+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Wang <peter.wang@mediatek.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/5] scsi: ufs: core: Add debug log for MCQ command timeout
Date: Tue, 13 Oct 2026 12:01:33 -0400
Message-ID: <20261013160048.356245-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013160048.356245-1-sashal@kernel.org>
References: <2026101216-sharpener-discover-cc77@gregkh>
 <20261013160048.356245-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Wang <peter.wang@mediatek.com>

[ Upstream commit 3abe4113e784b4a1135fe0e89828afecbfebf862 ]

It is difficult to debug situations where an MCQ command timeout occurs,
the corresponding CQ tag response is received, but the request is not
completed.  Add a one-line log to indicate when the CQ entry is abnormal.

Signed-off-by: Peter Wang <peter.wang@mediatek.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20260210070837.1820710-3-peter.wang@mediatek.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: 375f3a5691dd ("scsi: ufs: core: Avoid unsafe MMIO reads in ufshcd_mcq_compl_all_cqes_lock()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufs-mcq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 90314980deed1..846d4c3eb3923 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -280,6 +280,8 @@ static void ufshcd_mcq_process_cqe(struct ufs_hba *hba,
 		ufshcd_compl_one_cqe(hba, tag, cqe);
 		/* After processed the cqe, mark it empty (invalid) entry */
 		cqe->command_desc_base_addr = 0;
+	} else {
+		dev_err(hba->dev, "Abnormal CQ entry!\n");
 	}
 }
 
-- 
2.53.0

