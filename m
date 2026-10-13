Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BF037267A
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905490; cv=none; b=jL6ehTN4cqwk9j75KAkrearv4yGBA6haZ6bOu7gpiCB4bTTBvgqejpaUdCuZ/pBzuNUh2KoeNt4IQ6ZMxvHRXDPjm035S9AgQ8fAcexxre5WOK9opyrROtub7QE+nZPaBdQVz9ZVjxXZEcV6C/IJO1Eg8rtELoZ3P4yXXB++10s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905490; c=relaxed/simple;
	bh=CJqIBfAiS5g7kPJR5Gf/DJe/USoFgZj9/euMFq8e4TY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PV1XLNyWSeEOUEzHpNQoxDHhLeGuRnXRULvA7DI/9TIN9PfCzGcpECvPWEmKdXhn5tHGM6Ln63+RE8nilC8S0wyR/7NZrbnlO0whxncEktnq8TU0wEp3tHRKsUCA0AinPjN+t4Tfj9P0bNcO9qR6R+Ha1cT02IGUbXLG9gXMp6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNZw/3qu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNZw/3qu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E0F1F00899;
	Tue, 13 Oct 2026 15:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791905488;
	bh=3iWUW/l3GqiyHFiszAEBsMZ3Z1uu7G+Hab90O4egXhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lNZw/3qud0+La3vst8MzRkmRQKrUkMLySk3Qs4j+byfF3lsauyjr4YC23AwtI/9nu
	 0ckgiHZosN8IVetTPmFqqFS3E3PnmK242Z07U8ZEMLyplM3zn5bFJSdc/GjrUDvP33
	 /I+W0IpNObIAO8fUoSUsCTT12h8ukeZ3eNfMUrpYeXrx4veP5mBzN/+eWrKMUJKVuR
	 66X5umxG7VCe/qoEfXnxYpuQ4jUNt1fCJxJz/eFqBls052qq0E/ut7BFYEuZSKYOj0
	 +0fCaFRd6Bu+QdRL4MO4d1jBx7cHNPQOM8cAO2CgRcF6NknafzSRfXloFhQlvaa/Tj
	 rVydwVyiB/mRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Wang <peter.wang@mediatek.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/4] scsi: ufs: core: Add debug log for MCQ command timeout
Date: Tue, 13 Oct 2026 11:31:24 -0400
Message-ID: <20261013153027.105962-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013153027.105962-1-sashal@kernel.org>
References: <2026101212-headpiece-alto-c398@gregkh>
 <20261013153027.105962-1-sashal@kernel.org>
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
index 8780be79a0f84..632f4522a4d63 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -314,6 +314,8 @@ static void ufshcd_mcq_process_cqe(struct ufs_hba *hba,
 		ufshcd_compl_one_cqe(hba, tag, cqe);
 		/* After processed the cqe, mark it empty (invalid) entry */
 		cqe->command_desc_base_addr = 0;
+	} else {
+		dev_err(hba->dev, "Abnormal CQ entry!\n");
 	}
 }
 
-- 
2.53.0

