Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFEA2F7F12;
	Wed, 17 Jun 2026 01:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781660417; cv=none; b=Cte5O1hB3NMQNBeSdW9cZKg2QHzNzk4gFm2sTSV6t36Gebi/sAJeCMYOsFny+kIcZ//KHRrmaTj8l39afjw6qWv292vX7QUvy2WhmrCEuRPfV7mvYeOYVaQiyolxDJ+LMYkeYzN4bWEQVOnIY+f3Y/atedRr77rcCm1nCODXnDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781660417; c=relaxed/simple;
	bh=xyVjGMzYJ9KEd8oDTglHCE5Pt/C2/hi8VCe40kyw6Jo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MepxJRZ565q6Paoxtd0SFs+3bbOTzg0PPQkauQHJfKZCl0BPaIrOAVHSBMYQgzmq4f8Wyht2Qy2LbkKJZF34J3WkvJgtCJbCmz8Qx73W7YycVN4Rzt6/IhhsvEcB2S5hpJF1+CvYmZD3mBFZNjnLjmdfuX3kJhB8OLVkHAgCz9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=lRira26v; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="lRira26v"
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 42a9e4c6e;
	Wed, 17 Jun 2026 09:35:02 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: pkshih@realtek.com
Cc: leitao@debian.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	zilin@seu.edu.cn,
	Dawei Feng <dawei.feng@seu.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH wireless] wifi: rtw88: pci: fix resource leak on failed NAPI setup
Date: Wed, 17 Jun 2026 09:35:02 +0800
Message-Id: <20260617013502.114057-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ed337ad8e03a2kunm5578f45264a81
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZGB4aVkJKTkMfHkJMGUxMSVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=lRira26vmv893Speklw2Xlr4MK5Zt3M+5mB5ZPiDnrJgbqmhmkGVCPJLjf5oaHThA3ynUgzT+6CasGyKwV08dqz2lz9BxOS9diM7Gf6bqJc5P+UK5XHw6auW74uyfV3uuhSjr1VmEiymsPaeyppJr/kCdNe1KRHNazw5bHXAqO4=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=yHEXIEjMsEp34e1RjSskAYHeXSb8QxPj24zxwQcSn1U=;
	h=date:mime-version:subject:message-id:from;

rtw_pci_probe() allocates PCI resources through
rtw_pci_setup_resource() before it sets up NAPI. If
rtw_pci_napi_init() fails, the error path jumps straight to
err_pci_declaim and skips rtw_pci_destroy(), leaving the PCI
resources allocated by rtw_pci_setup_resource() behind.

Add a dedicated cleanup label for the NAPI setup failure path so probe
destroys the PCI resources.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing current
mainline kernels. The tool is still under development and is not yet
publicly available. Manual inspection confirms that the bug is still
present in v7.1-rc7.

An x86_64 allyesconfig build showed no new warnings. As we do not have a
suitable rtw88 PCI board to test with, no runtime testing was able to be
performed.

Fixes: d0bcb10e7b94 ("wifi: rtw88: Un-embed dummy device")
Cc: stable@vger.kernel.org
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
---
 drivers/net/wireless/realtek/rtw88/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index bba370ad510c..9eeb6cb31261 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1825,7 +1825,7 @@ int rtw_pci_probe(struct pci_dev *pdev,
 	ret = rtw_pci_napi_init(rtwdev);
 	if (ret) {
 		rtw_err(rtwdev, "failed to setup NAPI\n");
-		goto err_pci_declaim;
+		goto err_destroy_rsrc;
 	}
 
 	ret = rtw_chip_info_setup(rtwdev);
@@ -1857,6 +1857,8 @@ int rtw_pci_probe(struct pci_dev *pdev,
 
 err_destroy_pci:
 	rtw_pci_napi_deinit(rtwdev);
+
+err_destroy_rsrc:
 	rtw_pci_destroy(rtwdev, pdev);
 
 err_pci_declaim:
-- 
2.34.1

