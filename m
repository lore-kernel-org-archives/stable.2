Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FF83090D9;
	Thu, 20 Aug 2026 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787234079; cv=none; b=g7yAaUpa6B/sUD+t6YiNBayI1s6PkXAzJhvl1xB8UwcNaobmPmaN0D2rn/d6bepwPW4WxboVRlzW4K1sLP3zAvuzzgHA9b14ZY1aimrXJscG1AyHf1wqOPYTiFfUj8h8Pd41ybZLmQHM6lRKuM1QuE7x1UCfPSkMhs/z+PrHeXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787234079; c=relaxed/simple;
	bh=iKCzlGFLeMFCq7OCjggGfrdEQmecuV+SE5mmdXjFGAY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DMbF+5pn5ZPJACaIhAU5Xx4+MjEr1U5OtwEbapJFZOOJfL9ezZFHQN3PUP/Q19LuVZyRau8+Xh1Zko1wbI3G/FQCsudVCB6mF0e9cQOcLDBJS468u11mv9sZ9pOP/nCTFgQl4ThatbEJjiaYpChNApQtMLaSbXYLqud3D5BH2FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wBnMi4XB4dqxgauAA--.5784S3;
	Thu, 20 Aug 2026 21:54:31 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app3 (Coremail) with SMTP id zS_KCgCXgncNB4dq4qKJBA--.53615S4;
	Thu, 20 Aug 2026 21:54:31 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: linux-usb@vger.kernel.org
Cc: bryan.odonoghue@linaro.org,
	heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH v2 2/2] usb: typec: qcom-pmic-typec: drain cc_debounce_dwork if port_start() fails
Date: Thu, 20 Aug 2026 13:53:07 +0000
Message-Id: <20260820135307.153773-3-fanwu01@zju.edu.cn>
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
X-CM-TRANSID:zS_KCgCXgncNB4dq4qKJBA--.53615S4
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?GBN6GQXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnZPoDCNGYdHSfuFmYJL54WO9OWYw/IHH4hah4IAp2/0egkqcYy6hAI3JzeV6+CAackEF
	Hpu5BHzPtoX0ubM1Nuip9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7Aw48XrW8Gw4xJF1DXw1xXrc_yoW8XF45pa
	s8GrZrCrykGa9Fyr9xJF47ZF45Ww47A347G3y0g34fWFs0qr1Utr4Utry0kFy5CF47XryY
	yr43XFnIva98GagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8TEEUUUUUU==

cc_debounce_dwork can be queued before port_start() fails:
tcpm_register_port() runs first, and its state machine may invoke
set_cc() or start_toggling() from the TCPM worker.  The error path then
calls tcpm_unregister_port(), whose worker flush may queue the delayed
work before devres frees pmic_typec_port.

Disable and drain the delayed work directly at port_start()'s error
exit.  Do not use port_stop() for this path: its IRQs use IRQF_NO_AUTOEN
and are enabled only after a successful port_start().

This issue was found by an in-house static analysis tool.

Fixes: a4422ff22142 ("usb: typec: qcom: Add Qualcomm PMIC Type-C driver")
Cc: stable@vger.kernel.org # v6.10+
Suggested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
index fdc379fc4..53c143364 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
@@ -684,6 +684,9 @@ static int qcom_pmic_typec_port_start(struct pmic_typec *tcpm,
 		enable_irq(pmic_typec_port->irq_data[i].irq);
 
 done:
+	if (ret)
+		disable_delayed_work_sync(&pmic_typec_port->cc_debounce_dwork);
+
 	return ret;
 }
 

