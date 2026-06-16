Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F76744DB85
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625342; cv=none; b=sqSib9+08RUaWRH7PLJ/pCgeV2YvQYEJ9U2th73nw+Am6E/mxIvy78GX4a+bO43EYmw+cfYzpPD7WZhFjR47WSa1Sed8jHSswdbg40U9Zc/mpKmRfa2FoDAkLahKlAick61z8a7a9OFolEjeQTWtL53wqsYAGLwDhlfksQIZN5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625342; c=relaxed/simple;
	bh=ZOCEAo4uYh59DYxn4PBFRbJ4dH4MsgnqkXK8QLRwmgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jvIjnlGKZfLkfuYhbqcjsJNzpH0zMLqDExZNu1GCavFaspoFeVINxGhiRCXXyAeTSGUaeX8HNFM4iI0Hig+RcRtqYQhk0OYYcmbdrEJeOoKl+GxVBH35mKw8Di5CsekuNwoCXf+X5LEuEGDxTTu4iF6s9F3R0ie2U2qdIOSgVHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvmRaB/+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvmRaB/+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B591F00AC4;
	Tue, 16 Jun 2026 15:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781625341;
	bh=hzuMoNy7yI800Rm+uitke5e+1y8lPaknYS5yt1d7lvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GvmRaB/+on0tsZJNcQ78eeS5TToaYZ4sI6iLX7GSJsEQLqsQI3CzrvKuWSMrw8uYl
	 ndMd0ucknENcpzuSdtKKDuTxnsRkRnMlnZENN3s6v2T7wfe8T9rObF7wUUwU6y5jkn
	 98ZTOakAUPOW9CiKdmdVoSfN55rYn11rbk+/K4tGqg9v+C/4ajwRvWDHfvmHeyqI5x
	 94ARdV/daQ44Dm1L3Td93bCbaJqDE6ugqtyKFpts9t3zOm3uHnMzWgnVbAiyCXSeMu
	 Xd7smZKliCkC6luMqipJon+FdD7t6uq1tMJ1dlBnVEyR5DGZ4WIVBZTY0QXaVPhFqF
	 JRrFRiiYgZreg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kyle Meyer <kyle.meyer@hpe.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] bnxt_en: Fix NULL pointer dereference
Date: Tue, 16 Jun 2026 11:55:38 -0400
Message-ID: <20260616155538.3323509-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616155538.3323509-1-sashal@kernel.org>
References: <2026061544-stony-launder-1952@gregkh>
 <20260616155538.3323509-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Meyer <kyle.meyer@hpe.com>

[ Upstream commit d930276f2cddd0b7294cac7a8fe7b877f6d9e08d ]

PCIe errors detected by a Root Port or Downstream Port cause error
recovery services to run on all subordinate devices regardless of
administrative state.

The .error_detected() callback, bnxt_io_error_detected(), disables
and synchronizes IRQs via bnxt_disable_int_sync(), which calls
bnxt_cp_num_to_irq_num() to map completion rings to IRQs using
bp->bnapi.

Since bp->bnapi is allocated on NIC open and freed on NIC close, PCIe
error recovery on a closed NIC can dereference a NULL pointer.

Check if bp->bnapi is NULL before disabling and synchronizing IRQs.

Fixes: e5811b8c09df ("bnxt_en: Add IRQ remapping logic.")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Link: https://patch.msgid.link/aiNM1CY2-StPilxW@hpe.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index ff14c44b8f2bb3..6dd41040252974 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4382,7 +4382,7 @@ static void bnxt_disable_int_sync(struct bnxt *bp)
 {
 	int i;
 
-	if (!bp->irq_tbl)
+	if (!bp->irq_tbl || !bp->bnapi)
 		return;
 
 	atomic_inc(&bp->intr_sem);
-- 
2.53.0

