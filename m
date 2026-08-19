Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E8A484226;
	Wed, 19 Aug 2026 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787156187; cv=none; b=TS+LZeIKyy9bl2fXFnQ5KPbN9QOSzaW9PZcxLe4fdjeNv9xizwR8GnFMJyg5Yl9gE5mKK4Szmqw0axb2BrNgCN7kFV6k7F8yfrR/4OR2VkJhPwjIVBxpW0yynBzaSeEX9zSb+oc2qteRP4lnk7u3wDVVR8G0LuvEcXUMHiJIpxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787156187; c=relaxed/simple;
	bh=3KLwm+Up/J3dk8GPOsTdWJnJ0mzE3mh9rVfSAgDGrTA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MOvLL0EKG+7CRhqaaUCGNfDPseDtqLplZql6UB30mv0ZrJTx5JN8IreipEXi0HJh88yjD1AGmlTvyJ9UuL7Re5NhAX00b1Pvhm5ASUEjSLgIUTwsGuMx5ebaRlSPr/Pmau/1hRcJ+HC9pjmugAgBzawaxyCTvGeyipRttrliD8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wBXIX3N1oVqpIKpAA--.21275S3;
	Thu, 20 Aug 2026 00:16:15 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app4 (Coremail) with SMTP id zi_KCgBXOzTL1oVqu6xQAw--.24027S2;
	Thu, 20 Aug 2026 00:16:11 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: linux-usb@vger.kernel.org
Cc: bryan.odonoghue@linaro.org,
	heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH] usb: typec: qcom-pmic: cancel reset_work on stop
Date: Wed, 19 Aug 2026 16:14:48 +0000
Message-Id: <20260819161448.76597-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgBXOzTL1oVqu6xQAw--.24027S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?8uUiygXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnXz+g1OQfMo27QHy5TwQyZxCzygzwZIYBFC/9NYw4QCzxm2VirDCk3cu+CdwQaX92QA/
	9p+5Ncu/g/sD0FzsCDKp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7Cw4DuFW3CFWxJr45Kw4UAwc_yoW8JFyxpw
	15JrW2kFyDWFZIv3s8XFsIvF15Wayqyry7A3yjg34SqF1Yq3WjyryjqF109F15CFW3Jry3
	tFW7WFn8Aa45GwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AK
	xVWUJVW8JwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
	JbIYCTnIWIevJa73UjIFyTuYvjxU7gAwDUUUU

pdphy_stop() disables IRQs but leaves reset_work pending.  If the IRQ
handler schedules it just before disable_irq(), the work runs after
remove() frees the struct via devm.

Call cancel_work_sync() after disabling IRQs to close the window.

This issue was found by an in-house static analysis tool.

Fixes: a4422ff22142 ("usb: typec: qcom: Add Qualcomm PMIC Type-C driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
index c8b1463e6..abb9d0321 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
@@ -544,6 +544,8 @@ static void qcom_pmic_typec_pdphy_stop(struct pmic_typec *tcpm)
 	for (i = 0; i < pmic_typec_pdphy->nr_irqs; i++)
 		disable_irq(pmic_typec_pdphy->irq_data[i].irq);
 
+	cancel_work_sync(&pmic_typec_pdphy->reset_work);
+
 	qcom_pmic_typec_pdphy_reset_on(pmic_typec_pdphy);
 
 	regulator_disable(pmic_typec_pdphy->vdd_pdphy);

