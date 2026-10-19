Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8EC4825AC;
	Mon, 19 Oct 2026 05:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792389223; cv=none; b=SdE8Pp68+pIWM8iZSu8BZ9QoUEJOkIAMsP9RINN5LnFJTDvCDbadbLxBHrTG5f97jTPkhxNaWNRravoMC+ILhkm7r9x8lHFYrw+zUWmp1+3A9D3ptV/nu3vkcxMPqbpLtZLvmhj0WaYBZ8PwgpfKBMVQv3GBdCCIm1KzH4WALO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792389223; c=relaxed/simple;
	bh=ieraK7cBVZEsMFvVD0EcLiGEZhvYM4rku4qNKyw0Jyk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gZzgTFxKpZtP5PiSTOcxUXx9uF9Dua10j0rbgKZfp0uE39X/HZFtPjy3OIf8oy4t1fsqJtDgzuYbIY16ixMKtMIly/CQPDhdU06TEdLDqgzo6ec7g9LfieU7pmff2MKdiH7zE5Flf4WDt6zZU149HqrzVFzSB29lpYMIoBpKS5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GMOKiqft; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GMOKiqft"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=bj
	C0C9sNmjVdhV/IrzHeBVtTgO0BbAu7HQvpAPfRZB0=; b=GMOKiqftSRSgHEHprg
	CxAkWAgQa1T8sLq9Ut1q/BxKrsUR0BoGVncEnUKOeolLGnUUZQSXrjnJxRrXUCCM
	+ub2QZ7Ve+5llkpK6PAIpx6sj17E2+yXuKslmtvwzPDRTdix2oZd87MUsjpbOPKu
	Ykus0Kb5RiePTHWqRwg2V/NUQ=
Received: from jbd-ThinkPad-X1-Carbon-Gen-14 (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3H8HQr9VqeNjjBA--.48161S2;
	Mon, 19 Oct 2026 13:51:13 +0800 (CST)
From: Slark Xiao <slark_xiao@163.com>
To: mani@kernel.org,
	jeff.hugo@oss.qualcomm.com,
	krishna.chundru@oss.qualcomm.com
Cc: loic.poulain@oss.qualcomm.com,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] bus: mhi: host: pci_generic: Update the default autosuspend_delay_ms as 5000ms
Date: Mon, 19 Oct 2026 13:51:09 +0800
Message-ID: <20261019055109.49922-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H8HQr9VqeNjjBA--.48161S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr48tF4fXrW7XF1xWFWUtwb_yoW8XryDpa
	yF9F45tr48Zr1UKa4qyr1qq345W3y3Gry2gryvkw1Y9398tw1DKryqvFy3KF10yrZ5WF43
	tF4jgrW5ur10ya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piH7KxUUUUU=
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbC6BEwlGrVr9FMuwAA3r

For some MHI devices in some specific scenario, the default value
of autosuspend_delay_ms may not enough to handle last wake event.
This may lead to some unexpected problems.

Refer to the Qualcomm's Windows settings and we checked this with
Quaclomm over case, Qualcomm recommend us to set this as 5000ms.
Qualcomm also suggests us to update this for all MHI devices.
Since this setting has affected some existed kernel versions, it's
better to be applied to stable version.

Fixes: d3800c1dce24 ("bus: mhi: pci_generic: Add support for runtime PM")
Cc: stable@vger.kernel.org
Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/bus/mhi/host/pci_generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 7193a384cca4..40735beb46cb 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -1483,7 +1483,7 @@ static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	/* Allow runtime suspend only if both PME from D3Hot and M3 are supported */
 	if (pci_pme_capable(pdev, PCI_D3hot) && !(info->no_m3)) {
-		pm_runtime_set_autosuspend_delay(&pdev->dev, 2000);
+		pm_runtime_set_autosuspend_delay(&pdev->dev, 5000);
 		pm_runtime_use_autosuspend(&pdev->dev);
 		pm_runtime_mark_last_busy(&pdev->dev);
 		pm_runtime_put_noidle(&pdev->dev);
-- 
2.53.0

