Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9CA3FE34E;
	Thu, 11 Jun 2026 13:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182965; cv=none; b=uVkvUw9fKOo7VKsT4AUxgygMAMx2+SCxkqTejNcSKy87Nk/AFd99xwzz9VDUjFvYPDRUZo2bcNsyEStVL4LZgrUrs8GMLd7O7gBDOc1qsLgpTNLgDYRW/koJ4gnsmx6jLN5ozbQf2V2OXFlAb8OSNnf5KExHXQBMgF/yWRo00G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182965; c=relaxed/simple;
	bh=DxYhPaIpTVbPtGSNW4Ybwc7C+jL5GYj4fCSm8YKQqmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ogsgi1nnrSc9DTV19QfEHrhMp0aKy62dNHImfe18YF+0Q6DwcR6XAcZ6yoorZ/7gr9VY8xizJgMtVK1SFmBACYz89XdYGWvs2d3lk+LWpXF/YWvVy214dRJSAZrIlmBno33BG+/niu/DwWFhA7myTUtHCrOyqI0wnENnOJaLtYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.76])
	by APP-05 (Coremail) with SMTP id zQCowABXr9LhsSpqKSUWEw--.526S2;
	Thu, 11 Jun 2026 21:02:26 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: gregkh@linuxfoundation.org
Cc: stern@rowland.harvard.edu,
	mathias.nyman@linux.intel.com,
	khtsai@google.com,
	thorsten.blum@linux.dev,
	kees@kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] usb: hub: fix refcount leak in usb_new_device()
Date: Thu, 11 Jun 2026 21:02:23 +0800
Message-ID: <20260611130223.80884-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXr9LhsSpqKSUWEw--.526S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw47Jr4fWw1xGFy5Jr47urg_yoW8WF1Dpr
	WFqFZ0yayxWw12yw1DZFnYvFy5u3yay395Cry0g3yj9w1fX348try8AryYq3W8Ar95AF12
	qay7tw47uFy8GFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUQZ2fUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAUPA2oqh3iCIgAAsa

If usb_new_device() fails after pm_runtime_get_noresume() has
been called, it does not release the corresponding reference.
In the successful path, the reference is properly dropped via
pm_runtime_put_sync_autosuspend().  However, when an error
occurs during enumeration (e.g. usb_enumerate_device() failure)
or device registration (e.g. device_add() failure), the function
jumps to the "fail" label.  That error cleanup path only disables
runtime PM and marks the device as suspended, never putting the
usage count back.  This results in a permanent imbalance of
power.usage_count, preventing future runtime PM state transitions
and proper device cleanup.

Fix the leak by adding a pm_runtime_put_noidle() call before
pm_runtime_disable() in the fail error path, which releases the
reference without queuing any suspend work and appropriately
matches the pm_runtime_get

Cc: stable@vger.kernel.org
Fixes: 9bbdf1e0afe7 ("USB: convert to the runtime PM framework")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/usb/core/hub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 24960ba9caa9..05f1a4267aec 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2731,6 +2731,7 @@ int usb_new_device(struct usb_device *udev)
 	device_del(&udev->dev);
 fail:
 	usb_set_device_state(udev, USB_STATE_NOTATTACHED);
+	pm_runtime_put_noidle(&udev->dev);
 	pm_runtime_disable(&udev->dev);
 	pm_runtime_set_suspended(&udev->dev);
 	return err;
-- 
2.50.1 (Apple Git-155)

