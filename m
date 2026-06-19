Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537EF31D72E;
	Fri, 19 Jun 2026 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781855200; cv=none; b=mgY8JVwxOhOV7VYiC11Ue0nSm9opfwIfAZbynPYlDa+tFcOyelMeIIhXcdG5ibsFWoA0e8Xfy+bIkyAf2UuFOvCOhbu9ITIFjXbrF24PIB9PHC61X/mjpoh2EIDxwd0K2a//6VUv8vg+eEG7UDUsZaK0xUPlY3IpWbOKHBFgBDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781855200; c=relaxed/simple;
	bh=SwybE9etRyWULXr7u3d3jRRntm8RyRdrdLg4GDactR4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VnKgJ9toLZ9Mr4+5+8JrFZIaRNZ6O5g6anHTW3Oo6q/UseTvOa+ACHkElCKqQDq1bAAAKPXzq78IVOMY0O58CwHsNDm036q+iTx4ae39y+VhPtqyFZSs9RlScuJVdIL/JiK+3kZnwMeunWA2VI5xKNBxznmrIVpQExlpWzlWB9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=nBLPtfBJ; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="nBLPtfBJ"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4301623ac;
	Fri, 19 Jun 2026 15:31:11 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Gertjan van Wingerde <gwingerde@gmail.com>,
	"John W . Linville" <linville@tuxdriver.com>,
	Ivo van Doorn <IvDoorn@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH wireless] wifi: rt2x00: avoid full teardown before work setup in probe
Date: Fri, 19 Jun 2026 15:31:04 +0800
Message-Id: <20260619073104.1809161-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9edeca774403a1kunmb402b5fdc3d79
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTxlDVkxOTR1DSE9OSkhPQ1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pOTE5VSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=nBLPtfBJ5nNpkTJE8GgYb3Hx1BSRHovA/k+6zDw3DTo8z4G3zmIncHT0876uDVE5uP9PKdIIWvpHrJxVeFXpRA1WuIlWrMYoJ89VUV2ZpSrot/VjJ3F7SHieZ8/USRj0PDMnhwmPSIfl5rlBLgvnlvsJqEfHTbTt/pcT+gvLCk4=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=E61SJuWNDiLWu79QDYcwv8gLBsDMmqgIXWvfr9Q/IZw=;
	h=date:mime-version:subject:message-id:from;

rt2x00lib_probe_dev() uses the full rt2x00lib_remove_dev() teardown for
all probe failures. However, drv_data allocation and workqueue allocation
can fail before intf_work, autowakeup_work and sleep_work have been
initialized.

Do not enter the full remove path until the probe has reached the point
where those work items are set up. Return directly for drv_data allocation
failure, and use a small early cleanup path for workqueue allocation
failure.

This issue was found by our static analysis tool and then confirmed by
manual review of rt2x00lib_probe_dev() and rt2x00lib_remove_dev(). The
early probe exits should not call a common teardown path that assumes the
later work setup has already completed.

A QEMU PoC forced alloc_ordered_workqueue() to fail before the work
initializers are reached. The resulting fail path entered
rt2x00lib_remove_dev(), and DEBUG_OBJECTS reported invalid work drains with
rt2x00lib_probe_dev() and rt2x00lib_remove_dev() in the stack.

Fixes: 1ebbc48520a0 ("rt2x00: Introduce concept of driver data in struct rt2x00_dev.")
Fixes: 0439f5367c8d ("rt2x00: Move TX/RX work into dedicated workqueue")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
index f8a6f9c968a1..847b64e586f6 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
@@ -1382,7 +1382,7 @@ int rt2x00lib_probe_dev(struct rt2x00_dev *rt2x00dev)
 			                      GFP_KERNEL);
 		if (!rt2x00dev->drv_data) {
 			retval = -ENOMEM;
-			goto exit;
+			return retval;
 		}
 	}
 
@@ -1416,7 +1416,7 @@ int rt2x00lib_probe_dev(struct rt2x00_dev *rt2x00dev)
 	    alloc_ordered_workqueue("%s", 0, wiphy_name(rt2x00dev->hw->wiphy));
 	if (!rt2x00dev->workqueue) {
 		retval = -ENOMEM;
-		goto exit;
+		goto exit_free_drv_data;
 	}
 
 	INIT_WORK(&rt2x00dev->intf_work, rt2x00lib_intf_scheduled);
@@ -1488,6 +1488,14 @@ int rt2x00lib_probe_dev(struct rt2x00_dev *rt2x00dev)
 exit:
 	rt2x00lib_remove_dev(rt2x00dev);
 
+	return retval;
+
+exit_free_drv_data:
+	clear_bit(DEVICE_STATE_PRESENT, &rt2x00dev->flags);
+
+	kfree(rt2x00dev->drv_data);
+	rt2x00dev->drv_data = NULL;
+
 	return retval;
 }
 EXPORT_SYMBOL_GPL(rt2x00lib_probe_dev);
-- 
2.34.1

