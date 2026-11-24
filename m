Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.143.211.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513329;
	b=OD3LRa9iGuiyo66PuJ/z60wAv22MN2+d3Ee1MzWjLt9Ti8ccbQ2lu7HMWAAOSexXXIq3
	 Gr7wML9jMEgYORQphruCvmWKDQmBkqD+rJZdjzG1OZWGxCD+cXGSeeQPriOac8PeQdl2L
	 V6iwL9d7rIgRLXyMxtj04a/LHsT/74S9kTj8wpVp5a+dVqhtPidvO/dGl2hdTC+7+CtDg
	 6AardLMyWSGHmHHgSftEc4N1zyj8MD57lWE16fhEUlRBrTJpcjxxA/K7xek5Crqvcdl/X
	 dhGGlLztBPeLGsX3wPWhaedMBbrN9uSJd/nYRn7J6Q864lxUcFt7UUmFLmyOrkpgmDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513329;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding;
	bh=BL1Fu2R9fiyvgELYNd9ojOSDl2hj2PjbPXVKos5gdQg=;
	b=mFX9ehIx2mE5+wxuJOAHw6jTld/gHjOndmZGq/umyMUCcqlgaetxDHma/O9r23+6SDsx
	 wk0OSb/Cjpbapsax7wZmdIIgvKwq2Bq2P4Ho9VnAJXoRDah96BUgJbmGDT7goFLD3kq8j
	 3OTr6z122eeyYZH1+W/AuRrEb1VcqXhNpKbeFM5JgdAS9Bx7OUY/qqm7G0IsxvlzYsgE4
	 WgLQn1TymLFDBD3SCuMgKWh9/BAojsti0fy8aPKwQssUcSDzp5gVSZOnZKQKiYlN+iV6/
	 dqHcIJgdWI8fNpuscFDmRV4IXcIeZVUCCCreGcmhdvvaje1mcgYND+pSS+L0KllIq5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=swemel.ru;
	spf=pass smtp.mailfrom=swemel.ru;
	dkim=pass header.d=swemel.ru header.i=@swemel.ru header.a=rsa-sha256 header.s=mail header.b=eXOnVbKf;
	arc=none smtp.remote-ip=95.143.211.150
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8D4606A683;
	Tue, 24 Nov 2026 09:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A8D4606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=swemel.ru header.i=@swemel.ru header.a=rsa-sha256 header.s=mail header.b=eXOnVbKf
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1795513308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BL1Fu2R9fiyvgELYNd9ojOSDl2hj2PjbPXVKos5gdQg=;
	b=eXOnVbKf7nCIPhtfBrWs3le29qisGyC5izuUuGJADf8ds7LQfFUgHi0ixwjoCDSAkysqTI
	8wX9ohfJKnkt3dlkEO7plZJS91CmYatWgMf1XKNKxWkl4hFz0Sg6o+2w22pstwY5neJHh/
	dlUYN+4noh05QObNeFVd/SZHxkrblAI=
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Matthew Schwartz <matthew.schwartz@linux.dev>,
	Sasha Levin <sashal@kernel.org>,
	Florian Maillard <florian.maillard@mailoo.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Wei WANG <wei_wang@realsil.com.cn>,
	Samuel Ortiz <sameo@linux.intel.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Yang Yingliang <yangyingliang@huawei.com>
Subject: [PATCH 5.10] mmc: rtsx_pci: fix return value check of mmc_add_host()
Date: Tue, 24 Nov 2026 12:41:46 +0300
Message-ID: <20261124094148.96655-1-arefev@swemel.ru>
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

From: Yang Yingliang <yangyingliang@huawei.com>

commit 0c87db77423a282b3b38b8a6daf057b822680516 upstream.

mmc_add_host() may return error, if we ignore its return value, the memory
that allocated in mmc_alloc_host() will be leaked and it will lead a kernel
crash because of deleting not added device in the remove path.

So fix this by checking the return value and calling mmc_free_host() in the
error path, beside, runtime PM also needs be disabled.

Fixes: ff984e57d36e ("mmc: Add realtek pcie sdmmc host driver")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Link: https://lore.kernel.org/r/20221101063023.1664968-6-yangyingliang@huawei.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[Denis Arefev: adapted for 5.10: the pm_runtime_dont_use_autosuspend() and
pm_runtime_disable() calls present in the upstream commit are not
included, since runtime PM support was never added to the rtsx_pci_sdmmc
driver in this tree (the probe/remove path has no pm_runtime calls).]
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index f0e9a7667994..161bc5b98ed6 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -1439,6 +1439,7 @@ static int rtsx_pci_sdmmc_drv_probe(struct platform_device *pdev)
 	struct realtek_pci_sdmmc *host;
 	struct rtsx_pcr *pcr;
 	struct pcr_handle *handle = pdev->dev.platform_data;
+	int ret;
 
 	if (!handle)
 		return -ENXIO;
@@ -1469,7 +1470,11 @@ static int rtsx_pci_sdmmc_drv_probe(struct platform_device *pdev)
 
 	realtek_init_host(host);
 
-	mmc_add_host(mmc);
+	ret = mmc_add_host(mmc);
+	if (ret) {
+		mmc_free_host(mmc);
+		return ret;
+	}
 
 	return 0;
 }
-- 
2.43.0

