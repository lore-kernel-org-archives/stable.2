Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203943FADE7;
	Thu, 11 Jun 2026 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781184093; cv=none; b=gd3sEm+jsySAdMm7JEuei12fbGFE7w0MwLveMLhW/Fl73yVZRX6rJgtxCN2vxYkJwrrK1lC43Jw8DntPE+u6oyUevnATrcmbq6z0ltY92LRWLzpl7h68f48gPgT/jLEl6zt3CVzc3m77cILT/xvC5N1gbZJMR2xT3mUBfxZrFDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781184093; c=relaxed/simple;
	bh=LGENQiDsf9r0dmhm3a1JUWCqCwB6Upnst3CZgRW1qKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mt8byEQlp51Oy+48usIaP9gwuPzpm9ifoOk7jALbbH6eK2hm5nRIKk8QKW3oEZnOm5zHEbnImEnyk+lOtD94288uc3U14xZ1pURhzBXj1E4aXBdb8Bi6YJbGqCiXT9szco/0QWiRvCpl1/blR8zlvMV4RjieQsTtI/00iZ5NGFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.76])
	by APP-05 (Coremail) with SMTP id zQCowAC3Gt5Stipq9HYWEw--.576S2;
	Thu, 11 Jun 2026 21:21:23 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: mathias.nyman@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] usb: xhci: fix refcount leak in xhci_port_bw_show()
Date: Thu, 11 Jun 2026 21:21:20 +0800
Message-ID: <20260611132120.83185-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAC3Gt5Stipq9HYWEw--.576S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr4DuFyDuryftFyrJF1UJrb_yoW8GrW8pa
	n8WF47CrZ5Xr4ft345Arn7XFyru398tryUA3yI9as5ur45G3WayryUCFZ0q3WI9r9rJF15
	tw4kXFW3AF1jkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUfsqAUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ4PA2oqh4WSVQAAsO

If xhci_port_bw_show() calls pm_runtime_get_sync() and it fails with
a negative return value, the function returns the error directly without
calling pm_runtime_put_sync(). This leaks the runtime PM usage count,
preventing the device from ever suspending again.

pm_runtime_get_sync() unconditionally increments dev->power.usage_count
before calling rpm_resume(). If rpm_resume() fails, the usage count is
not decremented — a well-known API pitfall. Add a pm_runtime_put_sync()
call on the error path to balance the reference.

Cc: stable@vger.kernel.org
Fixes: 59d50e53e070 ("usb: xhci: Add debugfs support for xHCI port bandwidth")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
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
2.50.1 (Apple Git-155)

