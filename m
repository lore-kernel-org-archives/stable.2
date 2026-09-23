Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D3C3C0635;
	Wed, 23 Sep 2026 07:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790149782; cv=none; b=uXJwQQ7goSkviT/8YcAoUJW8tWfxrTkkp4ax4MwDaotZxKAvb/O6ICii1/HlUaUf4h1lgm3Xoxm0QTVebhs4a/0azxDD8glwLRsReUdowDxPXf474593b3uSIH6CurxtnNGTVtqb0qYH9eBwNlkDdamuwY4N2IQz2X/kwKsT5dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790149782; c=relaxed/simple;
	bh=m/cEceOzCnDodbXJi1kYlQoLj5ukhZwRLEOl76ErlNE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EcXF0clRBrxvDlz+kT44y14wUHFQNukFVeDHJO33G/jqREtGEgEsZ7WMlNiOeXPOYLZpzJadtHnZCZPX6L6lMBJg3T7F2YJCiqm63VUqAxgwHvVh4knBntb0GeGa6RW+tMvj0X7N561dSAROTERhHJa9qAYXBzz1MdaiaSqSa4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wAHAYWEhLNq6vwwAQ--.6303S3;
	Wed, 23 Sep 2026 15:49:25 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app4 (Coremail) with SMTP id zi_KCgAnezODhLNq65_OAw--.39044S2;
	Wed, 23 Sep 2026 15:49:23 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-usb@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	stable@vger.kernel.org,
	Song Li <songl@zju.edu.cn>
Subject: [PATCH] usb: typec: ucsi: yoga-c630: unregister EC notifier before UCSI teardown
Date: Wed, 23 Sep 2026 07:48:28 +0000
Message-Id: <20260923074828.489562-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgAnezODhLNq65_OAw--.39044S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?7bhr7wXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnXz+g1OQfMo27QHy5TwQyZwE/vSQZ160CDmmYAs9ddiCPQNmRWzJkHDvskmO3z+yVcoJ
	pDGAI6upKb0vpIyZY2Op9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7tw45XF1rtrWUCw1DXry5Awc_yoW5JF4Dpr
	nIkaykGrW0qF45Ww45u3W5JFy5AF97JFWUZ347W348Krs8Jas7ua97AFy5ZFy5Ar1DCF47
	tw45K3y5Z398A3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU86c_DUUUUU==

Both yoga_c630_ucsi_remove() and the probe error path call
ucsi_unregister() while the EC notifier is still registered.
ucsi_unregister() frees the connector array, so an EC event (USB, HPD or
UCSI) arriving before yoga_c630_ec_unregister_notify() makes
yoga_c630_ucsi_notify() run on freed memory: typec_set_orientation() on the
freed port and ucsi_connector_change() queuing work in the freed connector
array. USB and HPD events do not depend on the UCSI notification-enable
state, so the disable command ucsi_unregister() sends to the EC does not
close this window.

Fix this by unregistering the EC notifier before ucsi_unregister() in both
paths, restoring the teardown ordering from before the error and remove
paths were reworked. blocking_notifier_chain_unregister() waits for a
running callback, so once it returns the EC interrupt thread can no longer
reach the UCSI instance and ucsi_unregister() can tear the connectors down
undisturbed.

The callback is also the only external source that requeues the connector
work, so the cancel_work_sync() calls in ucsi_unregister() can no longer
race with a new connector-change event.

This issue was found by an in-house static analysis tool.

Fixes: 168c3896f32e ("usb: typec: ucsi: yoga-c630: fix error and remove paths")
Cc: stable@vger.kernel.org
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/usb/typec/ucsi/ucsi_yoga_c630.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_yoga_c630.c b/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
index 1be18d1..59738dc 100644
--- a/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
+++ b/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
@@ -296,7 +296,9 @@ static int yoga_c630_ucsi_probe(struct auxiliary_device *adev,
 	return 0;
 
 err_ucsi_unregister:
+	yoga_c630_ec_unregister_notify(uec->ec, &uec->nb);
 	ucsi_unregister(uec->ucsi);
+	goto err_destroy;
 
 err_unregister:
 	yoga_c630_ec_unregister_notify(uec->ec, &uec->nb);
@@ -311,8 +313,8 @@ static void yoga_c630_ucsi_remove(struct auxiliary_device *adev)
 {
 	struct yoga_c630_ucsi *uec = auxiliary_get_drvdata(adev);
 
-	ucsi_unregister(uec->ucsi);
 	yoga_c630_ec_unregister_notify(uec->ec, &uec->nb);
+	ucsi_unregister(uec->ucsi);
 	ucsi_destroy(uec->ucsi);
 }
 

