Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31A031327A;
	Thu, 20 Aug 2026 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787234079; cv=none; b=VYN4qhQbpEFiM4SjO2zs4OIoC8SNWldIQ1YkR0zgriQ2pnN39VRWFYGVdSl+yQ0NM6QgS4NSzBmies6sGXPBwXbbJLXZTwIp6CnwphKX0GVHp8+AflIOmRehukcVsux70DRxPk8/UNs9lb+BYwKbXjVkuUw/n1hYHyLrop24AUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787234079; c=relaxed/simple;
	bh=EdlHy+FbipDz7p2bONSkEJpzLywLmtVwgsShP5wunkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yt0y53ilq7gdLjFJP8gKp7Ww+LIhHZWUO1tOFHSomK83+0f1FhfNBU2Z9bupiFp0UKWx0b2/Dr+LkvRJJsrZw0m81a6XgBfAAf8Vf4fNSj0+Mxt0v6HTn2T2uMS1FSTvSPKiR2ULHRfZCMd4xZS6K3OSZh1zTHf2FZJ5aFvyzEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wBnEz0UB4dqvAauAA--.5984S3;
	Thu, 20 Aug 2026 21:54:28 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app3 (Coremail) with SMTP id zS_KCgCXgncNB4dq4qKJBA--.53615S3;
	Thu, 20 Aug 2026 21:54:28 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: linux-usb@vger.kernel.org
Cc: bryan.odonoghue@linaro.org,
	heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH v2 1/2] usb: typec: qcom-pmic-typec: disable cc_debounce_dwork on stop
Date: Thu, 20 Aug 2026 13:53:06 +0000
Message-Id: <20260820135307.153773-2-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820135307.153773-1-fanwu01@zju.edu.cn>
References: <20260819161950.77858-1-fanwu01@zju.edu.cn>
 <20260820135307.153773-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgCXgncNB4dq4qKJBA--.53615S3
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?1xpyKQXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnZPoDCNGYdHSfuFmYJL54WNnH1O4G0enPJIj3LGmHDxOgkqcYy6hAI3JzeV6+CAacoqU
	1X3/xAf4+zarVqYB1+2p9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7tw18CFWDtryxCr4kKFyUJwc_yoW8Xw1Dpa
	s8KryDJrykWanFy3sIqF47ZF4UuanrA347G3y0g34ftF4qqw1UtrWUtr109Fy5CFsrJFya
	vr4agFyaya4kWwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8aQ6JUUUUU==

cc_debounce_dwork is queued from the set_cc() and start_toggling()
callbacks, which run from TCPM's kthread worker.  port_stop() returns
before tcpm_unregister_port() destroys that worker.  Flushing the worker
during unregister may therefore run a callback which queues the delayed
work after port_stop() has returned.

The delayed work can then run after devres has freed pmic_typec_port.

Use disable_delayed_work_sync() in port_stop() to cancel a pending
instance and prevent the TCPM callbacks from queueing another one.

This issue was found by an in-house static analysis tool.

Fixes: a4422ff22142 ("usb: typec: qcom: Add Qualcomm PMIC Type-C driver")
Cc: stable@vger.kernel.org # v6.10+
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c | 2 ++
 1 file changed, 2 insertions(+)

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

