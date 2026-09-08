Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CFE36C5AE;
	Tue,  8 Sep 2026 06:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788847416; cv=none; b=h1ebSuN2g2QFp/Y3fWFoJ5l5mBvk56wzCXGg2QBh4GXRlMp0QudukECcWuT3kpJnvCsX7T9Hh+1C/B/Y92RwWpGxN3ylEEk7ZhJEW+9OF0TpU63EFmsuDfsVJXDuw2W0PU2FpNQyZTlqTg11GbA8VuSxr40TtLJAgE2llrC7NW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788847416; c=relaxed/simple;
	bh=FEGg/yge3/bv0kPODPSrijoXWKCkOyWT9bOflSG5Fd0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qjg0pJ6HxNkZXsMvIY9EZBfNo0VkumvWG5KGETiQh8d8S6Iz1EMd2w3v5cOZMq0lC7wCmGpQaWGtUXAUsrR/oSC/3VBUAv7V4qdxd3hwDXUw3DpiLiAs22mJtIk46o2cbNAW8DV3poJaycZDwb6MVmHYPVQI7nkeOYyvkx5GO94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wA3QTwtpZ9qaZr9AA--.23070S3;
	Tue, 08 Sep 2026 14:03:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app1 (Coremail) with SMTP id yy_KCgDno5sqpZ9qYIhkBA--.47634S2;
	Tue, 08 Sep 2026 14:03:22 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	Song Li <songl@zju.edu.cn>
Subject: [PATCH] usb: typec: ucsi: glink: fix use-after-free of ucsi on remove
Date: Tue,  8 Sep 2026 06:02:15 +0000
Message-Id: <20260908060216.616045-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgDno5sqpZ9qYIhkBA--.47634S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?TIc+6wXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnVCjTgEH9dVomQuWcozCBBGF9bCWC1gB8KVe0tFmhEz5s5PPKZpIO5gV3ViKdGX0A5n8
	UpFgvmLcPr4gVFZcYCXN5RPxYw6l01w8CbPzC/8w
X-Coremail-Antispam: 1Uk129KBj93XoW7Cw4UuFyfZFyrCr47AF4UKFX_yoW8Kw1rp3
	sI93yrtrWjqw42gw4DWayaqFy8uFZ3J3yUA347W3yxKrs8Gr1q93yktFyagF15CrWkCF12
	yr4Yq3y5Cr45AagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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

The pmic_glink client is released by the devres cleanup, which runs
after pmic_glink_ucsi_remove() has returned, so its notification
callbacks can queue work until then. Work that runs after
ucsi_unregister() has been called touches freed state: it dereferences
the connector array that ucsi_unregister() freed, or registers and
unregisters the instance a second time.

Disable both work items with disable_work_sync() before unregistering,
and unregister only if the instance is still registered.

This issue was found by an in-house static analysis tool.

Fixes: 62b5412b1f4a ("usb: typec: ucsi: add PMIC Glink UCSI driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Link: https://lore.kernel.org/r/20260227190430.889-1-nathan.c.rebello@gmail.com
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/usb/typec/ucsi/ucsi_glink.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 12e07b9fe..1db0c88d8 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -362,6 +362,10 @@ static void pmic_glink_ucsi_destroy(void *data)
 {
 	struct pmic_glink_ucsi *ucsi = data;
 
+	/* Drain the work items before ucsi_destroy() frees the ucsi instance */
+	cancel_work_sync(&ucsi->notify_work);
+	cancel_work_sync(&ucsi->register_work);
+
 	/* Protect to make sure we're not in a middle of a transaction from a glink callback */
 	mutex_lock(&ucsi->lock);
 	ucsi_destroy(ucsi->ucsi);
@@ -467,8 +471,15 @@ static void pmic_glink_ucsi_remove(struct auxiliary_device *adev)
 {
 	struct pmic_glink_ucsi *ucsi = dev_get_drvdata(&adev->dev);
 
-	/* Unregister first to stop having read & writes */
-	ucsi_unregister(ucsi->ucsi);
+	/* Callbacks can queue work until devres releases the client */
+	disable_work_sync(&ucsi->notify_work);
+	disable_work_sync(&ucsi->register_work);
+
+	/* register_work may have unregistered the instance already */
+	if (ucsi->ucsi_registered) {
+		ucsi->ucsi_registered = false;
+		ucsi_unregister(ucsi->ucsi);
+	}
 }
 
 static const struct auxiliary_device_id pmic_glink_ucsi_id_table[] = {

