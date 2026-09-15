Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36329472084;
	Tue, 15 Sep 2026 09:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789465950; cv=none; b=DkPDhjCn85wLuX/6g3ag6yQZhy9o3pXL22DHdcmKNR9c5KjFuDS6kVogtp7/JBRi21G7zI+EATTWrDbt+IJBPGY6RIrwAiHiD8j7qUngsmykhXXgMtsnwT03dEQzVYSSLoN2Vru5C1X3Pea8f92J/evIW0QPunVJojEILH9uWEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789465950; c=relaxed/simple;
	bh=MIwagPDqD2vprIMEyWjeh2E4J/x0/0hIbqlHGtdB9Yc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=N/bKbxG/JFJjU4T/4//EpkHRNzAyxRzIYWoG7a3dk7bWkvjhDHOhKR5AC6kjGA0omIJ1M02Zlm7Y/F/pj7tpCef3hOKrdSN0n4G4+fl8Ah1EUX5ww9P0DseO5uOPm33Gw13smYVse1WlHAEKGAlyn8FCkoENTzfCFI3UlbbHE+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wC3oH5GFalqnIYWAQ--.1237S3;
	Tue, 15 Sep 2026 17:52:07 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app1 (Coremail) with SMTP id yy_KCgAHnKZEFalqmZWCBA--.58449S2;
	Tue, 15 Sep 2026 17:52:04 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: mripard@kernel.org
Cc: dave.stevenson@raspberrypi.com,
	mcanal@igalia.com,
	kernel-list@raspberrypi.com,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	eric@anholt.net,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH v2] drm/vc4: drain the hangcheck timer and works on V3D unbind
Date: Tue, 15 Sep 2026 09:51:03 +0000
Message-Id: <20260915095103.156007-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgAHnKZEFalqmZWCBA--.58449S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?GZTLGAXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnVCjTgEH9dVomQuWcozCBBGUbBEboUFAL4E/QfBxwz1UIjDBc2PaDGv0BxEDX8Pd2V7p
	Ht855YS2FQHSRv2QNCGp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxWF4UCw1fCFWkGw4UuF1kXrc_yoW5Xr4kpF
	s8CayYgrZ5JFW5twnrXF1xZF95Ja1rtFy7Cry29w43Crn3AryrtF90ka4YgFZrJaykWr43
	XFs7t3909FyrZ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU85l1PUUUUU==

Nothing stops the hangcheck timer that submitted jobs arm, or the
job_done_work that the render-done interrupt queues, at teardown:
vc4_irq_disable() cancels only overflow_mem_work, and vc4_gem_destroy()
runs from the drm-managed release, after vc4_v3d_unbind() has already
uninstalled the V3D interrupt and cleared vc4->v3d. A timer still armed
by then reads V3D registers through the NULL vc4->v3d pointer, and the
late callbacks run on the vc4_dev embedding them after it has been
freed.

Drain them in vc4_v3d_unbind(): shut the timer down and cancel
reset_work before the interrupt is taken down, because its
vc4_irq_reset() re-enables it, then flush job_done_work so that
completions queued at teardown still release their jobs.

This issue was found by an in-house static analysis tool.

Fixes: d5b1a78a772f ("drm/vc4: Add support for drawing 3D frames.")
Cc: stable@vger.kernel.org # 6.2+
Link: https://lore.kernel.org/r/20260909053509.657074-1-fanwu01@zju.edu.cn
Assisted-by: Codex:gpt-5.6
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
Changes in v2 (Maíra Canal, Sashiko review):

- Drop the VC4_GEN_4 guards: vc4_v3d_unbind() only runs on GEN4.
- State why reset_work must stop before the interrupt is taken down
  instead of describing the calls.
- Flush job_done_work instead of cancelling it, so completions queued
  at teardown still release their jobs.
- Relax the stable floor to 6.2+ now that vc4->gen is not referenced.
 drivers/gpu/drm/vc4/vc4_v3d.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index f32410420d3e..3f9f43074122 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -9,6 +9,7 @@
 #include <linux/component.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/timer.h>
 
 #include <drm/drm_print.h>
 
@@ -497,8 +498,15 @@ static void vc4_v3d_unbind(struct device *dev, struct device *master,
 	struct drm_device *drm = data;
 	struct vc4_dev *vc4 = to_vc4_dev(drm);
 
+	/* A straggler vc4_irq_reset() re-enables the interrupt. */
+	timer_shutdown_sync(&vc4->hangcheck.timer);
+	cancel_work_sync(&vc4->hangcheck.reset_work);
+
 	vc4_irq_uninstall(drm);
 
+	/* Flush rather than cancel, so queued completions release their jobs. */
+	flush_work(&vc4->job_done_work);
+
 	/* Disable the binner's overflow memory address, so the next
 	 * driver probe (if any) doesn't try to reuse our old
 	 * allocation.

