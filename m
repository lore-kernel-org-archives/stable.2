Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7CB38B7D2;
	Wed, 24 Jun 2026 08:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782288858; cv=none; b=PTo6fSnVUUof5LD9PbBiIhUdPubzW/FOTuZB/TuSCg21YMe9/2XwQG/XRkExOtwLzhjQmEl/K6nlGwSMh3fR+YRtaL7uHUiTY33Mhb5ESdkDHX6998iZGoMpwrXuIOam42dsJwvS5qDB/lOzP/i2y2x9TErtRnJMK8IoGIHCY9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782288858; c=relaxed/simple;
	bh=agZSlcdmIyFNF3Y7UppxaAsp1aATDUaMXrl1sg//2SA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I3FkJB9vchtbxWLaot95Fs+hv/iXsu7RSvzVjKewN6l+5VCudFTQcPb66r0QVnhDz6HkfMmH2xuELCRwu58u3xPCw9Z+K1nYW2MyRiU7YyMRKoH/Ir45USWXuAQ43QNx2ZoSWk8t967Yo9cQ3l585YHkTgFRwEo3YysyAg787R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nBPzQuWj; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nBPzQuWj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=L4
	Z+i8mgBSr9dAGYNiPKOTxiLMCB1EVejne+SF8kCkg=; b=nBPzQuWjA3OSpaJEWy
	wPku2UbqOU3WoxHT9suEWOxKA2KBx1+lQLQJTmDPGYLpLRo6p39UuSCTuX+bO56y
	JFp6kzXeMgnVh/yK6L1N5HLdridYPLhVKs7VXAtHBjsBxshhV7aa+vfGm5rEDpGu
	QAXGIsLi8ttPLbndjEtjiHiwY=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAXY_mOkTtqDfmKEA--.35745S2;
	Wed, 24 Jun 2026 16:13:04 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	bleung@chromium.org,
	abelvesa@kernel.org,
	jthies@google.com,
	myrrhperiwinkle@qtmlabs.xyz,
	pooja.katiyar@intel.com,
	venkat.jayaraman@intel.com,
	yuanhsinte@chromium.org,
	johan@kernel.org,
	quic_linyyuan@quicinc.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: typec: ucsi: destroy work queue on fwnode_usb_role_switch_get() fails
Date: Wed, 24 Jun 2026 16:13:01 +0800
Message-Id: <20260624081301.2866854-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAXY_mOkTtqDfmKEA--.35745S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr17ur48tw4DWF1xJF17Awb_yoWkArb_Wa
	92gr4qqr1DuFyrKw1vy345Zr9Yyw48Z3W7GFs8trs5Ca4jgr1xtr4DZFZ5Aryrua18Aa4D
	WF1UXrWF9r1xWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNOJ5UUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7RDxYGo7kZA3xwAA3M

Call destroy_workqueue() if fwnode_usb_role_switch_get() fails
to destroy the work queue con->wq.

Fixes: 3c162511530c ("usb: typec: ucsi: Wait for the USB role switches")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/usb/typec/ucsi/ucsi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 61cb24ed820f..63303e26929f 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1663,9 +1663,11 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
 
 	cap->fwnode = ucsi_find_fwnode(con);
 	con->usb_role_sw = fwnode_usb_role_switch_get(cap->fwnode);
-	if (IS_ERR(con->usb_role_sw))
+	if (IS_ERR(con->usb_role_sw)) {
+		destroy_workqueue(con->wq);
 		return dev_err_probe(ucsi->dev, PTR_ERR(con->usb_role_sw),
 			"con%d: failed to get usb role switch\n", con->num);
+	}
 
 	/* Delay other interactions with the con until registration is complete */
 	mutex_lock(&con->lock);
-- 
2.25.1

