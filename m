Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9EF4CEE7E;
	Mon, 19 Oct 2026 12:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.230.196.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792414485; cv=none; b=L0eQpLiozmm68vyX8nYPcISWDSBxKCtt45xX9vGBphwWgT+8bI4mCMOkRz8bLsXQ29dMgr2Pa9jYdKowmucJOy0TpF4lCvJRXVKgXFO5BPgElHg4SQvwiDkbZyACFJsjTzWPR1kb2ajr+OKYIBsTQ5P1HNp23wMPqzUpaQuxmL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792414485; c=relaxed/simple;
	bh=f7+CSI21ULZAx2MnSdN/FH8vkpUscy4bdliXenRSZew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lfszHrjbJtJxjsGTKY6yu2bS6/KXJbTdaucRcgkcANioVrh8SwM/W0xgtRf7WAg23ZWxRrNtPHDrqWZLDssB+CYuMldy7PN97DBPgPsPp89/IFsADiw2YT1BfYaFS2c2qoCF6S/PwBfcy6NZvpCV5Mqqg5J7f8oJR+jday9LARM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=e0a+KyrJ; arc=none smtp.client-ip=37.230.196.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="e0a+KyrJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1792414475;
	bh=f7+CSI21ULZAx2MnSdN/FH8vkpUscy4bdliXenRSZew=;
	h=From:To:Cc:Subject:Date:From;
	b=e0a+KyrJ7eX71otPcAkU9TVo1GQi+SSevky2jj0fPjJfNBB+EShanapr+CMjN1ScT
	 DzTFKErZZ9fnS5KpvFLd4VBHdRkWNy2yTtVvNlhm29k8tnAmuTIQ/IIwkyrgk0aE5n
	 KOtE7S+d0YIKUO9Za/fu7PxxBs3ureiCgRWz124d4ni6yV/9K5cCub3hHBhmgHKjK5
	 wRRbQWOwylGXSaJhLZZQcGaCoUmCUlGeWsuyARzOIHu/vIhOfYHQpqsyTEaANJtrhd
	 lGcpdPJgLxe3O+3YXJNk7EPWoTi+Mu/Yk6/dqLsW6/XLpIbpskCJdlQjEZ4zDjWKKG
	 DmuxY82kaxFOQ==
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id F413725CFA;
	Mon, 19 Oct 2026 15:54:34 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Mon, 19 Oct 2026 15:54:33 +0300 (MSK)
Received: from DESKTOP-D46TNHI (unknown [10.198.51.9])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4j7b953KqXzq2b;
	Mon, 19 Oct 2026 15:54:33 +0300 (MSK)
From: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	Sasha Levin <sashal@kernel.org>,
	Fan Wu <fanwu01@zju.edu.cn>,
	Ulf Hansson <ulfh@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Luke Wang <ziniu.wang_1@nxp.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10/5.15] mmc: core: Cancel SDIO IRQ work before freeing host
Date: Mon, 19 Oct 2026 15:53:34 +0300
Message-ID: <20261019125335.562-1-mdmitrichenko@astralinux.ru>
X-Mailer: git-send-email 2.54.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 127 0.3.127 0884f7b061fa529b810563f359267cd65d2ec05c, {diag_burst_silent}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;astralinux.ru:7.1.1;new-mail.astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 206791 [Oct 19 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/10/19 08:59:00 #28702808
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Fan Wu <fanwu01@zju.edu.cn>

commit 6feadbecdae60a6324c967f3b1493741083793a3 upstream.

A host controller that uses sdio_signal_irq() schedules host->sdio_irq_work
from its interrupt handler.  That work is only cancelled on the suspend
path (mmc_sdio_suspend()), not on the remove/free path, so a worker armed
just before the controller freed its IRQ can run after
mmc_host_classdev_release() has freed the host and dereference it through
container_of().

Cancel host->sdio_irq_work in mmc_free_host(), like the existing
host->detect drain added by commit 1036f69e2513 ("mmc: core: Cancel
delayed work before releasing host").

This issue was found by an in-house static analysis tool.

Fixes: 682696605c70 ("mmc: sdio: Add API to manage SDIO IRQs from a workqueue")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Signed-off-by: Ulf Hansson <ulfh@kernel.org>
[ mdmitrichenko: sdio_irq_work is still a delayed_work here, it became
  a plain work_struct only with commit 1dd611a9c55f ("mmc: core: Switch
  to basic workqueue API for sdio_irq_work"), so use
  cancel_delayed_work_sync() instead of cancel_work_sync(). ]
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
---
Backport fix for CVE-2026-98213
 drivers/mmc/core/host.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 5598f8490726..994bbc03be2e 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -612,6 +612,7 @@ EXPORT_SYMBOL(mmc_remove_host);
 void mmc_free_host(struct mmc_host *host)
 {
 	cancel_delayed_work_sync(&host->detect);
+	cancel_delayed_work_sync(&host->sdio_irq_work);
 	mmc_pwrseq_free(host);
 	put_device(&host->class_dev);
 }
-- 
2.43.0

