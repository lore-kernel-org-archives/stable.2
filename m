Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A23489894;
	Wed, 19 Aug 2026 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787156490; cv=none; b=j4ii69pmVQKQJ9SvAMj1LZT0WTGYlqV5OsnkUg2VyKUkt/0PclBNybxsm+DQIlSuQqwo4MW9EC81AZikin6xQgzbgjDyy4NGc5EzyxxYl5HgI3MNRjuLFj6JLDF5CA0Ow9aw8UNgFOhGQcahnCJgnHpo8I6Go0MErxGBPWcosjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787156490; c=relaxed/simple;
	bh=PpZFtuIoTKyDwxjHax5jjMkVxp4w90jeEEsNoliWSa0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PlmOJZCgu407UEHAw1IT7iTw9maMJJ3o0GbxQKl48RA2dh+LrtC/wA0KumYZRoR2iAqvgOUx2zfA2mmpoWJjuKbBmMm9ziOA1SSQmanYLrmsVLJMv141HVBJhZ/ELX89Ogp/VmhrnImjWi9NG7c0UEgW22OLRMq3BdLPK0GkOhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wCHUX3_14VqJoapAA--.2143S3;
	Thu, 20 Aug 2026 00:21:19 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app4 (Coremail) with SMTP id zi_KCgBXijH+14VqXrFQAw--.34652S2;
	Thu, 20 Aug 2026 00:21:18 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: linux-usb@vger.kernel.org
Cc: bryan.odonoghue@linaro.org,
	heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH] usb: typec: qcom-pmic-typec: disable cc_debounce_dwork on stop
Date: Wed, 19 Aug 2026 16:19:50 +0000
Message-Id: <20260819161950.77858-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgBXijH+14VqXrFQAw--.34652S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?75XOIgXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnXz+g1OQfMo27QHy5TwQyZw9aOy/B7Vzi9F2BqiMai8zX9QFBDONEy5cQTGhGfC78tFp
	zTnTfYHlKbj98dYeW/XN5RPxYw6l01w8CbPzC/8w
X-Coremail-Antispam: 1Uk129KBj93XoWxWFyfGw1UtF18AFyDCw1Utwc_yoW5GryDpa
	98trZrGrykGa9rXr9xtFsFvF4jga17Ar9rJ3y2g343tF1qqw1jyrWUtFyI9F15CFWxJFy3
	tr43XFy3A3Z8WFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AK
	xVWUJVW8JwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
	JbIYCTnIWIevJa73UjIFyTuYvjxU7rcfUUUUU

cc_debounce_dwork lives on the system workqueue but is armed from
tcpm callbacks (set_cc/start_toggling).  Those callbacks run on tcpm's
kthread worker which is only destroyed by tcpm_unregister_port(), after
port_stop() has already returned, opening a potential race window where
tcpm's worker flush re-arms the work.

Use disable_delayed_work_sync() in port_stop() to cancel any pending
instance and prevent future schedule_delayed_work() calls from
succeeding.  Also unwind a failed port_start() through port_stop(),
which otherwise jumps straight to tcpm_unregister_port() and leaves
the same window open after a failed probe.

This issue was found by an in-house static analysis tool.

Fixes: a4422ff22142 ("usb: typec: qcom: Add Qualcomm PMIC Type-C driver")
Cc: stable@vger.kernel.org # v6.10+
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c      | 3 +--
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c | 2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
index 35320f89d..f42c9e65f 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
@@ -101,7 +101,7 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
 
 	ret = tcpm->port_start(tcpm, tcpm->tcpm_port);
 	if (ret)
-		goto port_unregister;
+		goto port_stop;
 
 	ret = tcpm->pdphy_start(tcpm, tcpm->tcpm_port);
 	if (ret)
@@ -117,7 +117,6 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
 	tcpm->pdphy_stop(tcpm);
 port_stop:
 	tcpm->port_stop(tcpm);
-port_unregister:
 	tcpm_unregister_port(tcpm->tcpm_port);
 fwnode_remove:
 	fwnode_handle_put(tcpm->tcpc.fwnode);
diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
index 429bd42a0..fdc379fc4 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
@@ -694,6 +694,8 @@ static void qcom_pmic_typec_port_stop(struct pmic_typec *tcpm)
 
 	for (i = 0; i < pmic_typec_port->nr_irqs; i++)
 		disable_irq(pmic_typec_port->irq_data[i].irq);
+
+	disable_delayed_work_sync(&pmic_typec_port->cc_debounce_dwork);
 }
 
 int qcom_pmic_typec_port_probe(struct platform_device *pdev,

