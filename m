Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AE93E49ED;
	Wed, 22 Jul 2026 03:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784692115; cv=none; b=i08CgQziIZDZd+7wHEO8TJBp2biAowOnJwgrrupIW52QhbDQwMroogV2YWYFo4lLgrwiP2AIeYkIuPW7/GOpNr/t9MzhodxobLBKONlpr/oSS3Ibn1ecXQePwZ6HZrmsDpB2H7FATnwrIZ/9/7/BP/J2/TNAO+N2c90dqhFy08c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784692115; c=relaxed/simple;
	bh=UmKuuZQpohVj3w2AFQYD4GmmXRTYcVEHqzEGR4vFDAg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ffwHlriySVSG3O8gZXvn82XZFDSQr2203yqEiI1c0zbltgX7FRyx+eql32aAcDXKPvHQRaGff6IuAYHwEllGxlaD1zibRKt5I58s1aoZ5nFrlq0wED9V7uGEKdDwHNj7L/NefrG4TosRq1syuLt62LVBF8RzQCBkI/RaJ35oawQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wC3kX6JPWBq9fknAA--.20719S3;
	Wed, 22 Jul 2026 11:48:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app4 (Coremail) with SMTP id zi_KCgAnezOIPWBq4Bh_Ag--.62695S2;
	Wed, 22 Jul 2026 11:48:25 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: netdev@vger.kernel.org
Cc: christophe.ricard@gmail.com,
	sameo@linux.intel.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH net] nfc: st-nci: drain se_info timers on remove before NCI teardown
Date: Wed, 22 Jul 2026 03:47:29 +0000
Message-Id: <20260722034729.3254078-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgAnezOIPWBq4Bh_Ag--.62695S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?AUWV8QXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnXz+g1OQfMo27QHy5TwQyZy3SvDuBObN7l4IH2E4HjVYqLqjXqJUj9QcL8TFtcS9ewp/
	OpWml1djgt0NJD2ZrkOp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxArWUZFWftw4xKrW5Cry5Jrc_yoW5XFy3pa
	y5WF1ftr18Cr47CaykAr17WFy5Ja1SkFWUG34xJaySvr45KF4Fq3W0yFWa9FZxJFZ5WF1a
	yw4Fqw15WFyDtagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Tv3UUUUUU==

st_nci_se_init() initializes two se_info timers (bwi_timer and
se_active_timer) in probe, but st_nci_se_deinit(), the teardown helper
that drains both timers, has no caller in drivers/nfc/st-nci/:
st_nci_remove() tears the device down with ndlc_close /
nci_unregister_device / nci_free_device and never reaches it (dead since
the st21nfcb -> st-nci rename). The bwi_timer callback
st_nci_se_wt_timeout() calls nci_hci_send_event(), i.e. it uses the NCI
core. Both callbacks dereference info->se_info, and the bwi_timer callback
also dereferences info->ndlc->ndev.
info is devm_kzalloc()'d, so a timer armed during operation survives
st_nci_remove, fires after the devm release, and dereferences freed
memory (and a half-torn-down NCI core).

Call st_nci_se_deinit(ndev) from st_nci_remove() before
nci_unregister_device(ndev): the bwi callback reaches into the NCI core,
so the timers must be drained while the NCI workqueues still exist.
Convert both drains to timer_shutdown_sync() and drop the bwi_active /
se_active predicate guards. timer_shutdown_sync() is harmless for an
inactive timer and prevents later mod_timer() calls from rearming it, so
any residual HCI work during nci_unregister_device()'s workqueue teardown
cannot rearm a se_info timer.

This issue was found by an in-house static analysis tool.

Fixes: ed06aeefdac3 ("nfc: st-nci: Rename st21nfcb to st-nci")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/nfc/st-nci/core.c | 1 +
 drivers/nfc/st-nci/se.c   | 6 ++----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/nfc/st-nci/core.c b/drivers/nfc/st-nci/core.c
index a367136..57dbc4a 100644
--- a/drivers/nfc/st-nci/core.c
+++ b/drivers/nfc/st-nci/core.c
@@ -166,6 +166,7 @@ void st_nci_remove(struct nci_dev *ndev)
 
 	ndlc_close(info->ndlc);
 
+	st_nci_se_deinit(ndev);
 	nci_unregister_device(ndev);
 	nci_free_device(ndev);
 }
diff --git a/drivers/nfc/st-nci/se.c b/drivers/nfc/st-nci/se.c
index 607ec76..8ab18cb 100644
--- a/drivers/nfc/st-nci/se.c
+++ b/drivers/nfc/st-nci/se.c
@@ -751,10 +751,8 @@ void st_nci_se_deinit(struct nci_dev *ndev)
 {
 	struct st_nci_info *info = nci_get_drvdata(ndev);
 
-	if (info->se_info.bwi_active)
-		timer_delete_sync(&info->se_info.bwi_timer);
-	if (info->se_info.se_active)
-		timer_delete_sync(&info->se_info.se_active_timer);
+	timer_shutdown_sync(&info->se_info.bwi_timer);
+	timer_shutdown_sync(&info->se_info.se_active_timer);
 
 	info->se_info.se_active = false;
 	info->se_info.bwi_active = false;
-- 
2.34.1

