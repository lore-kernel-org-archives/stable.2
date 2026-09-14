Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB822D2487
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 01:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789349742; cv=none; b=aQ70mDhUruV73c9mVAzwUUwHjJAUV+8Yy689UVJERIA137rTfGhbOe0a6wE3YrUMkbmbQ3jDxUfB8sTOz1vFf8wSO3XhbbyX7OS8/HXXzim3vUn1dI4bpVRNHe4uXncJL+LolbxT/45zK+H4guLepKHDOK8hi9jQi7SjJfeQtPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789349742; c=relaxed/simple;
	bh=diijW0Ngvg6Po2QgZkty5w5YqxHEEtSwUPiFiy5LRb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TeSICHdDBsv2QtbGLnqVZktdIn8ttAy1fS2/2a4G2XuYeDl/6UJlfjXjU3scrljX9IhbBNKWUHM5aNTqM3GLKpOCoiPo+SarMnBRUUv5aH85pJ1GozvXv9VGRjiGPMNIgWuLWUJAglRvAMtEePItsqX9rIOb83/b3WjOlMTK/Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OtYy2Q6L; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OtYy2Q6L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ut
	uoxzxBe+sGr0tbsekknRhfARYkdgj7xxnTUdMXl9E=; b=OtYy2Q6L0zpAtYg0d2
	1iv/wxAhbI2X0dCbx1iCDavK+3WPAaUuC+L6V0lkgpNKBtHq9aHAE6BRIfwKP4J0
	ObXgcxj+lYAjwPmu//9x6q+5KgaPd613+8+APzBAPI4b3rwK6kZGkvP40KsedTmf
	b/f/q+NLo6Pw8+/3bGilTn6SY=
Received: from LSSP.an0.nb (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgC3aiZjT6dqKqQ8Rg--.48667S2;
	Mon, 14 Sep 2026 09:35:33 +0800 (CST)
From: 17706092139@163.com
To: lgs201920130244@gmail.com
Cc: liguanxin <202635561@mail.sdu.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/panel: novatek-nt35950: fix potential use-after-free on attach failure
Date: Mon, 14 Sep 2026 09:35:27 +0800
Message-ID: <20260914013529.749094-1-17706092139@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgC3aiZjT6dqKqQ8Rg--.48667S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFy7trWfAw4rJF17tF1UKFg_yoW8KF48pF
	n7W39Iyr90qF17tF4UAa4DJFy3CF4IgFWFyF4DG3ZxZFsrCFW0yrWIyFW2gry5Kr48A3WY
	vrnFqFy8ua98AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UPR6cUUUUU=
X-CM-SenderInfo: jprxliqwqzjiitz6il2tof0z/xtbC+QVxMGqnT2WsVQAA3j

From: liguanxin <202635561@mail.sdu.edu.cn>

nt35950_probe() registers the panel before attaching it to the DSI
hosts. If mipi_dsi_attach() fails, the probe error path returns without
removing the panel from the DRM panel registry.

The panel is allocated with devm_drm_panel_alloc(), so its storage is
released after probe returns an error. Leaving the panel registered
therefore leaves the global panel list pointing at freed memory, which
can result in a potential use-after-free when the stale entry is later
accessed.

There is an additional cleanup issue for dual-DSI panels. If attaching
DSI0 succeeds but attaching DSI1 fails, the error path unregisters the
secondary DSI device without detaching the already attached DSI0.

The failure sequence is:

  drm_panel_add()
        |
        v
  attach DSI0
        |
        | success
        v
  attach DSI1
        |
        | failure
        v
  probe cleanup
        |
        +-- DSI0 remains attached
        |
        +-- panel remains registered
        |
        v
  probe returns error
        |
        v
  devm panel storage is released
        |
        v
  panel registry contains a dangling pointer

Detach any DSI hosts that were successfully attached before the
failure and remove the panel from the DRM panel registry before
returning the probe error.

This issue was found by manual code inspection.

Fixes: 623a3531e9cf ("drm/panel: Add driver for Novatek NT35950 DSI DriverIC panels")
Cc: stable@vger.kernel.org
Signed-off-by: Guanxin Li <202635561@mail.sdu.edu.cn>
---
 drivers/gpu/drm/panel/panel-novatek-nt35950.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35950.c b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
index d42c7af0d75c..75bd4dbe778b 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35950.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
@@ -610,9 +610,20 @@ static int nt35950_probe(struct mipi_dsi_device *dsi)
 
 		ret = mipi_dsi_attach(nt->dsi[i]);
 		if (ret < 0) {
-			return dev_err_probe(dev, ret,
-					     "Cannot attach to DSI%d host.\n", i);
+			dev_err_probe(dev, ret,
+				      "Cannot attach to DSI%d host.\n", i);
+
+			while (i--)
+				mipi_dsi_detach(nt->dsi[i]);
+
+			if (num_dsis == 2)
+				mipi_dsi_device_unregister(nt->dsi[1]);
+
+			drm_panel_remove(&nt->panel);
+
+			return ret;
 		}
+
 	}
 
 	/* Make sure to set RESX LOW before starting the power-on sequence */
-- 
2.43.0

