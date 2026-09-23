Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112541E8826;
	Wed, 23 Sep 2026 02:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790131666; cv=none; b=bXUZ/Wzg2Vkni5AZ7n09rYDJCh1C8CtMttOa8ZIaY2L1zhK5bb+7RMYCQuK1pZL1Ecnutf83/j93UiMXvgwzRDqgMPNjc6YhxA0UxQO/cyTyQ60pxOIcod4zyXrMxrFeFboJcpslH8KuqS2AP9ehwtpt554YgGMhwUZxO3mkb6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790131666; c=relaxed/simple;
	bh=J0PoyUVfSo5+Ws6YQikw+r9OfT4Z73lLbkboimSIHOo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e8X4iAxPbMLQARPXSHcPIesek15YuiZxSHmJRYHi+8VNLO0fA8QL5YpfiyWaPAs4k86pxWydkAS/6YghSNAZa5grSPsHRDXWA97ceATv6fYNEdISIvi7DO3ESvl3sgBBAqLpj5/MvvdY0nxnKJYZ4PXjGKps3DCuPasIZyFfdYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wDXKGTEPbNqnRIwAQ--.6652S3;
	Wed, 23 Sep 2026 10:47:33 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app3 (Coremail) with SMTP id zS_KCgD3DnHEPbNqQYFXBQ--.13248S2;
	Wed, 23 Sep 2026 10:47:32 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	Song Li <songl@zju.edu.cn>
Subject: [PATCH] usb: typec: altmodes/displayport: Disable work before dp is freed
Date: Wed, 23 Sep 2026 02:46:37 +0000
Message-Id: <20260923024637.403624-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgD3DnHEPbNqQYFXBQ--.13248S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?IB2FmgXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnZPoDCNGYdHSfuFmYJL54WMGb343dmHnkx7Kq4BDc7b2Ctm2wY5NJsL9hT+RlaB0rUL6
	SW1Trc0gO7qjCzSDMX+p9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxJry5Gw1xtrW5ZrWfKr4fXrc_yoW8WF1Dpr
	1aqr9xKFWkWFZIq3WUZ3yIgF4rW39FyrW3Gry3Kw4fWrn8JF1UXa4rGFZ8ZFy7Cr98AFya
	vFW5Aw45urW5AabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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
	6r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Tv3UUUUUU==

dp_altmode_remove() cancels dp->work with cancel_work_sync(), but the
typec bus clears alt->ops only after ->remove() has returned, so the
dp_altmode_vdm(), dp_cable_altmode_vdm() and dp_altmode_attention()
callbacks can still call schedule_work(&dp->work) after the cancel. dp
is devm-allocated on the partner altmode device and is freed once the
unbind completes; a re-queued dp_altmode_work() may then run on freed
memory.

Fix this by disabling the work instead of only cancelling it.
disable_work_sync() drains an in-flight dp_altmode_work() and keeps the
work item disabled, so the late schedule_work() calls are rejected. The
work is still drained before the plug reference is dropped.

A later probe initializes a new work item, and the remove path holds no
lock that dp_altmode_work() takes, so waiting cannot deadlock.

This issue was found by an in-house static analysis tool.

Fixes: 0e3bb7d6894d ("usb: typec: Add driver for DisplayPort alternate mode")
Cc: stable@vger.kernel.org # v6.10+
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index d96ab106a980..f7b3566d4029 100644
@@ -815,7 +815,7 @@
 {
 	struct dp_altmode *dp = typec_altmode_get_drvdata(alt);
 
-	cancel_work_sync(&dp->work);
+	disable_work_sync(&dp->work);
 	typec_altmode_put_plug(dp->plug_prime);
 
 	if (dp->connector_fwnode) {

