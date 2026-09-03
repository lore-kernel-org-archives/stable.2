Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADEB4D90B1
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449082; cv=none; b=O+/qwHEpYprk0LZ28BvzypYXuoYbKw4XIasyBsO/4hSjJttvLGEh0oirdxf3/JUqkkrSKP1iuUBapWv1JcCmV3R/wJ85oDUIgHtrpyi1ygE5w4TiovohjJuiEw5UOwUHtUBqKQZpDO1415q76SQ/xkUXW+Ar7VECB1J9G+WPR+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449082; c=relaxed/simple;
	bh=mUXxWvXRKoIp5DzG0lRl3IBL7EEWygOXDPSUFayix7w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HzbxBojkdEpbtBB1zb4PkicCwa7GFNiJAheydeixBtZjNaGq8/GqB5xHt/x3X0nEhtngwDNW1jhN1kiDXhRR6CoUbJre4aBF37HnGBup5E8Y0BCy5jsUMP0kE+KYGZyLNc4+XONdlRmcf3rtcjYXDzeGrMWcfUtVjWM6VuDIhiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F8TxU5ko; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F8TxU5ko"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0201F000E9;
	Thu,  3 Sep 2026 15:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788449080;
	bh=U4W8kOK+uQXss09dulJOw9r7E6aQdMXWvKbQiA9l+M8=;
	h=Subject:To:Cc:From:Date;
	b=F8TxU5koCEj4Ta/oKdHdw1HGDHs/dimn9XAvrjfb+e0QT8bK44r9Be8VCH5IQNNOw
	 jgA43/JXCk1T+6jn+6pS4sVwL4JuyaarqrOE5JmTEHnNFFoQTToQIvLBmAF+xPr52g
	 gal5CIIQA/taLOFmpe6DbS7PWIFezj0kP8NiOYVc=
Subject: FAILED: patch "[PATCH] power: supply: qcom_battmgr: fix use-after-free" failed to apply to 6.12-stable tree
To: fanwu01@zju.edu.cn,sebastian.reichel@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:57:54 +0200
Message-ID: <2026090354-confirm-surface-c832@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 4e40befedfc8ed86f44e1f81df92d13c149c9f8d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090354-confirm-surface-c832@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4e40befedfc8ed86f44e1f81df92d13c149c9f8d Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Sat, 1 Aug 2026 05:19:23 +0000
Subject: [PATCH] power: supply: qcom_battmgr: fix use-after-free

qcom_battmgr_pdr_notify() queues enable_work when the PMIC GLINK service
comes up, and the worker recovers battmgr through container_of() to issue
firmware requests. The PMIC GLINK client stays on the client list until
its devres release action runs, so a PDR notification can keep queueing
the work, and a pending or running worker can access battmgr after devres
frees it.

Make enable_work device-managed with devm_work_autocancel(), registered
before the PMIC GLINK client is allocated. The devres cleanup then
releases the client first, so no further notification can queue the work,
and cancels the work before battmgr is freed.

This issue was found by an in-house static analysis tool.

Fixes: 29e8142b5623 ("power: supply: Introduce Qualcomm PMIC GLINK power supply")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Link: https://patch.msgid.link/20260731022006.317192-1-fanwu01@zju.edu.cn
Link: https://patch.msgid.link/20260801051923.354496-1-fanwu01@zju.edu.cn
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index c76389b2f7e8..91cf39b0083a 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -5,6 +5,7 @@
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #include <linux/auxiliary_bus.h>
+#include <linux/devm-helpers.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/nvmem-consumer.h>
@@ -1648,7 +1649,6 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
 	psy_cfg_supply.supplied_to = qcom_battmgr_battery;
 	psy_cfg_supply.num_supplicants = 1;
 
-	INIT_WORK(&battmgr->enable_work, qcom_battmgr_enable_worker);
 	mutex_init(&battmgr->lock);
 	init_completion(&battmgr->ack);
 
@@ -1711,6 +1711,11 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
 					     "failed to register wireless charing power supply\n");
 	}
 
+	ret = devm_work_autocancel(dev, &battmgr->enable_work,
+				   qcom_battmgr_enable_worker);
+	if (ret)
+		return ret;
+
 	battmgr->client = devm_pmic_glink_client_alloc(dev, PMIC_GLINK_OWNER_BATTMGR,
 						       qcom_battmgr_callback,
 						       qcom_battmgr_pdr_notify,

