Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AFB42E8C3;
	Mon,  6 Jul 2026 09:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329942; cv=none; b=EgW3si8Ix2zpKh8hP9fvdGX5jIVLAtutQMvL4HNM2UYtp5qS+5Zz8Ny4ncpQ46+u80xug0nWMK8sekgsYVtq+n+aNg1KHIZ24NAT85sc2PsujgqS0fLOybL/GJmufmKAox0fzY2kP80G6TN6sTi2brIE2K+nn3RQHTjVg2Td39E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329942; c=relaxed/simple;
	bh=oX9WETQOyx4gVg0QqDgUg3+OjmlyEij+PtEV7bjYag8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PCvCCRWWAREkNRglloZuY3CFlv3ZPY0ySZmfPXvalCWT0p/bXHnAve5flYaNaHPEzpI9wkBOmlSuTZPopwnynAbTrFAlscuNi8kR1+djBHCkX7i6S1prHwxWDiWWZ8Hwoqxore5Jtia2ABLraVkTgxkZyVntsOCiTsi7yHM3g3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wDn7Y15dEtqAAIQAA--.33661S3;
	Mon, 06 Jul 2026 17:25:14 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with SMTP id zC_KCgDnedB4dEtqDXerAg--.31302S2;
	Mon, 06 Jul 2026 17:25:13 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	siqueira@igalia.com
Cc: christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH] drm/amd/display: fix HDCP workqueue use-after-free on destroy
Date: Mon,  6 Jul 2026 09:24:17 +0000
Message-Id: <20260706092417.2953792-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgDnedB4dEtqDXerAg--.31302S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?o7C8BQXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI2KiIDLa9WFUwdtQdIEU+kwD3GirGJwGulw8JYi1tJvFfDk
	Bk6TRM1NX2wUkQdVYG6p9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxXFW7ZFWkWr47tF4kKr4ftFc_yoW5tw4Dpr
	4YqryYyw4UAr42q3srXF1kWF98K3ZYvFW0kr4xCw4av3yrGr13tw1rJFy2grW7WFWDua1a
	vF4UX39rZryq9rcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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

hdcp_destroy() cancels callback_dwork, watchdog_timer_dwork and
property_validate_dwork, but leaves cpirq_work and property_update_work
queued. These works are queued with schedule_work(), recover struct
hdcp_workqueue through container_of(), and dereference it. If either work
runs after hdcp_destroy() frees hdcp_work, it can trigger a
use-after-free.

The HDCP callbacks also call process_output(), which can requeue the HDCP
works: it always queues property_validate_dwork and may queue
callback_dwork or watchdog_timer_dwork depending on the state-machine
output. A simple cancel sequence can therefore miss work requeued by
another callback.

Set a teardown flag under hdcp_work->mutex before draining the works.
The callbacks already hold this mutex while calling process_output(), so
once teardown is set they can no longer requeue work. Then cancel
cpirq_work, the delayed works, and property_update_work before freeing
hdcp_work.

This bug was found by static analysis.

Fixes: a193ed2094ba ("drm/amd/display: Create amdgpu_dm_hdcp")
Fixes: da3fd7ac0bcf ("drm/amd/display: Update CP property based on HW query")
Cc: stable@vger.kernel.org
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 15 +++++++++++++++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 4c164ae4a4f9..2be763049b9e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -164,6 +164,9 @@ void process_output(struct hdcp_workqueue *hdcp_work)
 {
 	struct mod_hdcp_output output = hdcp_work->output;
 
+	if (hdcp_work->teardown)
+		return;
+
 	if (output.callback_stop)
 		cancel_delayed_work(&hdcp_work->callback_dwork);
 
@@ -487,9 +490,21 @@ void hdcp_destroy(struct kobject *kobj, struct hdcp_workqueue *hdcp_work)
 	int i = 0;
 
 	for (i = 0; i < hdcp_work->max_link; i++) {
+		/*
+		 * process_output() can requeue the HDCP works. Set teardown
+		 * under the callback mutex first so no callback can requeue
+		 * work after destroy starts, then drain any work already
+		 * queued.
+		 */
+		mutex_lock(&hdcp_work[i].mutex);
+		hdcp_work[i].teardown = true;
+		mutex_unlock(&hdcp_work[i].mutex);
+
+		cancel_work_sync(&hdcp_work[i].cpirq_work);
 		cancel_delayed_work_sync(&hdcp_work[i].callback_dwork);
 		cancel_delayed_work_sync(&hdcp_work[i].watchdog_timer_dwork);
 		cancel_delayed_work_sync(&hdcp_work[i].property_validate_dwork);
+		cancel_work_sync(&hdcp_work[i].property_update_work);
 	}
 
 	sysfs_remove_bin_file(kobj, &hdcp_work[0].attr);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
index 90b18c450ca6..2313434b57c0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
@@ -54,6 +54,8 @@ struct hdcp_workqueue {
 	struct amdgpu_dm_connector *aconnector[AMDGPU_DM_MAX_DISPLAY_INDEX];
 	struct mutex mutex;
 
+	bool teardown;
+
 	struct mod_hdcp hdcp;
 	struct mod_hdcp_output output;
 	struct mod_hdcp_display display;
-- 
2.34.1

