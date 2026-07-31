Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D522318121;
	Fri, 31 Jul 2026 02:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785464486; cv=none; b=km2XBliQYiAsCWvKnjCbfdLxRvHJL0lHTjWNzVqCgIhlDUnLKvOxGdh0dyNjzeVvW9cqZoQDWrYJdp/8ZAm0knR6ra+5Jb8Pzr8xdLbjfHgJynGLi6jCnz2pMuY0ozdYlqDcpq+qB9jhNSz5Kt6hV6vLlTEViesCcHSNRXTDMrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785464486; c=relaxed/simple;
	bh=7LaM6hGzKUCUT2Tp6oALb5MO2CH/V7rbICfdfbUTYEA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k8AvU/KGl0Ht1YowViIdcuXSOGJcr7BG8O9Ya4mp7v50uOHMjjLf/N0UbSrxn4gRfGfHXvG49OMgczf1BRdWDZKrv0sHvh0DDLUCGYJ+MNE9tYxlSkKNcEZ6HANrrXP+t7ex5wJI+EJL/coX3qX35BeWjHNNd6qlSracLxUYHi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wA3ITeRBmxqawpSAA--.3444S3;
	Fri, 31 Jul 2026 10:21:06 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with SMTP id zC_KCgDHEcaNBmxqaSdjAw--.43748S2;
	Fri, 31 Jul 2026 10:21:01 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: linux-pm@vger.kernel.org
Cc: sre@kernel.org,
	andersson@kernel.org,
	neil.armstrong@linaro.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH] power: supply: qcom_battmgr: fix use-after-free of battmgr on remove
Date: Fri, 31 Jul 2026 02:20:06 +0000
Message-Id: <20260731022006.317192-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgDHEcaNBmxqaSdjAw--.43748S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?c5bTJQXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI0taF0N0kZZZ0tR6irGjEFRcKWeojhCgW6dpE3YRGCeJXm+
	Nr3uGInxBeApWKp/hlSp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7AFW5AF4xJF4DCr4DAFWxXwc_yoW8uF48pa
	s3tF9I9ry5ZFZxXa4jyr47AFyfGw4qkry3Gry7Wa40vrnIyr18XFW5KF10vFy5Jrs7ta12
	y39Iqr98WF4fCwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
	JbIYCTnIWIevJa73UjIFyTuYvjxU7gAwDUUUU

qcom_battmgr_pdr_notify() queues enable_work when the PMIC GLINK service
comes up. The worker recovers battmgr through container_of() and issues a
firmware request.

The driver has no remove callback, so a pending or running enable_work can
access battmgr after devres frees it. The PMIC GLINK client stays on the
client list until its devres release action, so a PDR notification can
also queue the work while remove is running.

Add a remove callback that disables and drains enable_work before devres
release. Unlike cancel_work_sync(), disable_work_sync() also blocks a later
PDR notification from queueing the work. Store battmgr with
auxiliary_set_drvdata() in probe so remove can retrieve it.

This issue was found by an in-house static analysis tool.

Fixes: 29e8142b5623 ("power: supply: Introduce Qualcomm PMIC GLINK power supply")
Cc: stable@vger.kernel.org # v6.10+
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/power/supply/qcom_battmgr.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 490137a23d..f8c3efd2c9 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -1638,6 +1638,8 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
 	if (!battmgr)
 		return -ENOMEM;
 
+	auxiliary_set_drvdata(adev, battmgr);
+
 	battmgr->dev = dev;
 
 	psy_cfg.drv_data = battmgr;
@@ -1729,9 +1731,17 @@ static const struct auxiliary_device_id qcom_battmgr_id_table[] = {
 };
 MODULE_DEVICE_TABLE(auxiliary, qcom_battmgr_id_table);
 
+static void qcom_battmgr_remove(struct auxiliary_device *adev)
+{
+	struct qcom_battmgr *battmgr = auxiliary_get_drvdata(adev);
+
+	disable_work_sync(&battmgr->enable_work);
+}
+
 static struct auxiliary_driver qcom_battmgr_driver = {
 	.name = "pmic_glink_power_supply",
 	.probe = qcom_battmgr_probe,
+	.remove = qcom_battmgr_remove,
 	.id_table = qcom_battmgr_id_table,
 };
 
-- 
2.34.1

