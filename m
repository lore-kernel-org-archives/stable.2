Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7842B2D7;
	Thu, 25 Jun 2026 01:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782350210; cv=none; b=Zrpi5OLoJL/WoYMHGAoSdR3AbNtpG+3FqI/gF9/1z05u2thyRV6hQIimtQ3bbiv5MXF4eW23+sKRvtfyZ+iYtgb7gMeAh1oFKy1lLhiBSl5lCX4uU/xpku2dKusgUxfkClsG9M58pmETOPrncFnkdJYgAtmDCPof4HEy39JiBmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782350210; c=relaxed/simple;
	bh=bWjgzOiss5rncFwrFsXra0zcfyL6qXVwPOqWWql6Pgk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IOdZJMxfrL+cWEfzhKsIs6dtjyOipkBl0VbJyQr1GeU0mxoY6nk9qd70W+AeSzgsWxuIuIhJF1So4cKQMVRkM/zHmfE3KIf6vnyG7BA5DVmmLbp/UE1zKIurc2uEHGcL9rj7evuquA3e469s0K4gxJSgutwMIgrNBsV8j0sS8Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XTPlXxD3; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XTPlXxD3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=GU
	6I1Ll3K1QM1UvrFJ6ycsSbd981EIeymAe7fRZaVAs=; b=XTPlXxD3VG0XITwiIp
	EZYjR4iVOflmRpZqZd5SWJaEOsLnb8DmjtbkIpy4q1vi5Nc6fDvJ8gXcqgWvD2B6
	mljRPuxu3gw/YSOYiTTBIA11s1hYNuGUKlnTG/j9fSc7zIpxxnjbxXBYtYoGmx1M
	mp24LakG5c7sVtM+HGnJWes9U=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3Xwu3gDxqOQ4NEQ--.52354S2;
	Thu, 25 Jun 2026 09:13:29 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	bleung@chromium.org,
	abelvesa@kernel.org,
	myrrhperiwinkle@qtmlabs.xyz,
	jthies@google.com,
	johan@kernel.org,
	pooja.katiyar@intel.com,
	yuanhsinte@chromium.org,
	quic_linyyuan@quicinc.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: typec: ucsi: destroy work queue on fwnode_usb_role_switch_get() fails
Date: Thu, 25 Jun 2026 09:13:26 +0800
Message-Id: <20260625011326.3411572-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgD3Xwu3gDxqOQ4NEQ--.52354S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFWfCrW8Ww43JF4Utr4rAFb_yoW8WF45pr
	Zakw4jqw18JF43WanrK3WDWF1Yg3W8JFy7Jr4Iqw18KrsxJw4DXw18tFyYgF15WFZ7WFnI
	yFWDJrykua4DurJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piyE_tUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7hn3Zmo8gLn91QAA3h

Call destroy_workqueue() if fwnode_usb_role_switch_get() fails
to destroy the work queue con->wq.

Fixes: 3c162511530c ("usb: typec: ucsi: Wait for the USB role switches")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
Changes in v2:
 - Use a common err_destroy_workqueue error path. Thanks, Heikki!
---
 drivers/usb/typec/ucsi/ucsi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 61cb24ed820f..4503661b85d5 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1663,9 +1663,12 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
 
 	cap->fwnode = ucsi_find_fwnode(con);
 	con->usb_role_sw = fwnode_usb_role_switch_get(cap->fwnode);
-	if (IS_ERR(con->usb_role_sw))
-		return dev_err_probe(ucsi->dev, PTR_ERR(con->usb_role_sw),
-			"con%d: failed to get usb role switch\n", con->num);
+	if (IS_ERR(con->usb_role_sw)) {
+		ret = PTR_ERR(con->usb_role_sw);
+		dev_err(ucsi->dev, "con%d: failed to get usb role switch\n",
+			con->num);
+		goto err_destroy_workqueue;
+	}
 
 	/* Delay other interactions with the con until registration is complete */
 	mutex_lock(&con->lock);
@@ -1803,7 +1806,7 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
 	fwnode_handle_put(cap->fwnode);
 out_unlock:
 	mutex_unlock(&con->lock);
-
+err_destroy_workqueue:
 	if (ret && con->wq) {
 		destroy_workqueue(con->wq);
 		con->wq = NULL;
-- 
2.25.1

