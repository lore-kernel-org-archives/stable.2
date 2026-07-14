Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EF1442104;
	Tue, 14 Jul 2026 09:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784022391; cv=none; b=MDotU1dCwdXV5V4bVUa4M4LNYW1MyhsyN0KF8P+thdU6cE2cEEMcglqVj7T/B/74NJnyH8m1GFkKBgYP9/m6VanG951yO2Tpg2FfuOld4Gs+ODQZ6dsEXz1grA2B24TjpBB2+Kd7Z7aqNIik6VjyL8oolOfmbWhT38wB6yhZQuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784022391; c=relaxed/simple;
	bh=LpD3hSsQSbbRZ5CV578jTOwyZ1UkrYEYXFXZr54gADE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TIyz90kSUinPN/qB+7vV+N6b+KcGZCp6CM5q3W5N2gxpZVDU6EsJsPKztRs7hDkRw6BN+A1s3qG6RqN2CQCPsKqOiELAoej6X+qXztWVb+gATXUiAmiggrbw0bRooHNS5HMopVjQBiz3DE3HIZjRGZWNDpVXBZmdvG6fDiSEues=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wAnovxeBVZqeJdMAA--.42304S3;
	Tue, 14 Jul 2026 17:46:07 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with SMTP id zC_KCgBn+tBeBVZq8ZziAg--.53180S2;
	Tue, 14 Jul 2026 17:46:06 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: uninstall the IRQ before freeing the command buffer manager on unload
Date: Tue, 14 Jul 2026 09:45:11 +0000
Message-Id: <20260714094511.2960308-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgBn+tBeBVZq8ZziAg--.53180S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?vdbangXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI1wangcCasbKL4hiewR5cEodUhZ6yUbaMs+LPLxbAYu6MGi
	N6LL0RgrDmJ9zTZyyyj91pEwZzpiCNyjwd4j4xMK
X-Coremail-Antispam: 1Uk129KBj93XoWxZFW3uF4xAryfJr17Wr4kuFX_yoW5Gr1xpr
	W3C3WUKr97JrnFvF9rZa92gFyruws5KFyI9FW2kws3Jw15AryrtryYy3yj9FyDCFZ7tF4Y
	qrW8XFs7uF4FyrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
	W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU85l1PUUUUU==

vmw_driver_unload() frees the command buffer manager before uninstalling
the device IRQ. vmw_release_device_late() -> vmw_cmdbuf_man_destroy()
frees the manager, while the threaded handler vmw_thread_fn(), released
only later by vmw_irq_uninstall() -> free_irq(), dereferences
dev_priv->cman without a NULL guard and is the sole producer of
schedule_work(&man->work), whose worker vmw_cmdbuf_work_func() recovers
the manager via container_of(). dev_priv->cman is never NULLed on the
unload path, so a handler woken in the window between kfree(man) and
free_irq() runs against freed memory and can re-arm man->work after the
manager's cancel_work_sync() has already returned.

Reorder the unload path to drain pending fences, then uninstall the IRQ,
and only then free the manager: free_irq() guarantees the threaded
handler has exited before kfree(man). vmw_fence_fifo_down() is called
explicitly before the IRQ uninstall so its dma_fence waits are signalled
by the still-live threaded handler (vmw_fences_update() in
vmw_thread_fn()); uninstalling the IRQ first could force pending fence
waits to time out at VMW_FENCE_WAIT_TIMEOUT. vmw_release_device_late()
is left unchanged because it is shared with the hibernation path; its
existing call to vmw_fence_fifo_down() runs against an empty fence list
after the explicit drain above.

Fixes: ef369904aaf7 ("drm/vmwgfx: Move irq bottom half processing to threads")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.5
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 599052d07ae88af2f5775f968fe1e7046a3efe4e..dbe02fe8d8571587733d6f002436bf18dac1887a 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -1181,10 +1181,11 @@
 	vmw_devcaps_destroy(dev_priv);
 	vmw_vram_manager_fini(dev_priv);
 	ttm_device_fini(&dev_priv->bdev);
-	vmw_release_device_late(dev_priv);
-	vmw_fence_manager_takedown(dev_priv->fman);
+	vmw_fence_fifo_down(dev_priv->fman);
 	if (dev_priv->capabilities & SVGA_CAP_IRQMASK)
 		vmw_irq_uninstall(&dev_priv->drm);
+	vmw_release_device_late(dev_priv);
+	vmw_fence_manager_takedown(dev_priv->fman);

 	ttm_object_device_release(&dev_priv->tdev);

--
2.39.5

