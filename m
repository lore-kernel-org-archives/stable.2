Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A5D19CCFA;
	Mon, 22 Jun 2026 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782126120; cv=none; b=f4yxFIi88ATLIDQFEHnyiSkBQFfGAlI0OCzvQq3G8izi6lrEKiJZZfHBWd3NDKpF/sX63zQOFi92+lvInmoyg0gNPBSvYHMpp7tiao8uELsfOVuEazNe0+YfDBIhD69lq2wXBvR1VwbKNOF9k4knl1AcivTBYI8VkZz0LNSKqfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782126120; c=relaxed/simple;
	bh=/cLUoexjT/d0V9rqLT0W+o94nOYwh63F7VN02T6Iv5s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=c0JHPf7Ap5XpALR+wnYY48XNR0RPvPDcXC4PkF9o+nL5Hk994hd+k/KhqXSQ1N3irMi1ankachT843DILtCBIvYWT/mWdoGbOkDVbhVByDLKMOH//fZ7aaeEPnO2CBhnEwsgXDxSl9raVtxzfsgT+lvkDzN6g8p0SSo1TnMMlgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.74.238])
	by APP-03 (Coremail) with SMTP id rQCowABXLJMdFjlqSNeFFQ--.31757S2;
	Mon, 22 Jun 2026 19:01:50 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: xhci: fix runtime PM usage count leak in xhci_port_bw_show()
Date: Mon, 22 Jun 2026 19:01:46 +0800
Message-Id: <20260622110146.35827-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABXLJMdFjlqSNeFFQ--.31757S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr4DuFyDuryftFyrJF1UJrb_yoW8GrWfpa
	n8uF42krZ3Xr4ftrW5Arn7XFyfW3yDtryUArWI9a48ursxG3WayryUCFZ0q3WI9rWDJF15
	tw4vq3y3CF1jyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjuHq7UUUU
	U==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAcGA2o43ZncegAAs+

When xhci_port_bw_show() calls pm_runtime_get_sync() and it fails with
a negative return value, the function returns the error directly without
calling pm_runtime_put_noidle(). This leaks the runtime PM usage count,
preventing the device from ever suspending again.

pm_runtime_get_sync() unconditionally increments dev->power.usage_count
before calling rpm_resume(). If rpm_resume() fails, the usage count is
not decremented — a well-known API pitfall. Add a pm_runtime_put_noidle()
call on the error path to balance the reference.

Cc: stable@vger.kernel.org
Fixes: 59d50e53e070 ("usb: xhci: Add debugfs support for xHCI port bandwidth")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/usb/host/xhci-debugfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-debugfs.c b/drivers/usb/host/xhci-debugfs.c
index d07276192256..2974411f775d 100644
--- a/drivers/usb/host/xhci-debugfs.c
+++ b/drivers/usb/host/xhci-debugfs.c
@@ -679,8 +679,10 @@ static int xhci_port_bw_show(struct xhci_hcd *xhci, u8 dev_speed,
 	struct device			*dev = hcd->self.controller;
 
 	ret = pm_runtime_get_sync(dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(dev);
 		return ret;
+	}
 
 	ctx = xhci_alloc_port_bw_ctx(xhci, 0);
 	if (!ctx) {
-- 
2.39.5 (Apple Git-154)

