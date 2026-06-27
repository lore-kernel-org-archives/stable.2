Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B40B394EA6
	for <stable@vger.kernel.org>; Sat, 27 Jun 2026 10:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782556923; cv=none; b=a0Ale+HglEC6y+jwRZOSIiH16q7grlQ+ftr6T0Bga2aeeyfruuZDbxZpyRN/qEpBagIHpVAuopFolviHscEfNtTJs0pwhWwjO8R+zFT/rb4zToR4kXPS2E+LVc8TsZu11DdP3udG1TNZwJxNoKgk3Qb/zET6HOfSRr4T/hAvQmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782556923; c=relaxed/simple;
	bh=heL30jjpIgKlFH12HDVZRJomJ8UlZoalayOP7d3/z9w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tD3Mb+PajjZ7I6pu7WRdjCYcMUHUx4AknLEvadssB1i0Zvl4e0ZPq7ZD8kOZoQo1y3YPDNugMghOXb2oZm04TfZewU2gK/eDzC3c6c42mWT7Z6HmxOm75yNRSLPyZ9cjnCxU5P9PXlXSuyV/T1twwdbHc4mroS6n9q/96iSywIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bV+cH4TY; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bV+cH4TY"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c74383c93cso18348795ad.1
        for <stable@vger.kernel.org>; Sat, 27 Jun 2026 03:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782556921; x=1783161721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=es1/efpOfpgYLHxPT6kXNaqnireppxcIPdUYeiaIehk=;
        b=bV+cH4TYN9iTbqw5f/krrdt0x5SD2Nwf6kcjWRrL+nq7AqaRT/+JG8niIJBHj5igeB
         OJwY2g+GtN9IsRWNYZ+7INug80xCr3MnSFtMNB/+WKvo7D/pouZMacgWhVHRE/5MbvO2
         2WpNzZmSVayYWhhkdyykn/ZYfhgFYAhFiyfLSibD63m4M4Q+xrWErDWq2gbIDiZyq7qB
         qvH85IiFlbqjtX+f/RHAH3jeG8kmGXL7V6msVCEXeZjz2HGBvWLdZXJi8C4AfPDMLMDX
         8CuFlPPY/c2Tk6PtHVa944+QyHFazH0LUaKvE0vKx/n/+vY4i02pChbhl68/o+KmKfys
         q46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782556921; x=1783161721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=es1/efpOfpgYLHxPT6kXNaqnireppxcIPdUYeiaIehk=;
        b=BGHbVMLrlMXIqR0kSdgIhNKcDCHQ2w6h+NzKUntqZZ5s6N9+wZVtq63f40buFKLu7a
         6Tdg0EiEF8WbQDfikg4sA5/XrgkhGlhIl2NHOde8vX3A/N+u4h45rngRR1JwfDzS3PWW
         3nyGLmgd3Q4uyDy6M9Mz8WCjlQNLHjv7HRyBqxggVuB24FLUILtHkQxZMvTvzKPTnclq
         OaV2OZ2DVs+HgjG3LnFF1Bfw5pnoAMzpgSEgWfZgN0pPoh/vza0UFkaMYPpwW55q0Voc
         iPr4pKcU7QrI44do3VQpFjSZ6B8CRMN817pvrOlAoibJdfj9xWyheympUlthbMVJdfSr
         hNgA==
X-Forwarded-Encrypted: i=1; AHgh+RpnBMLZzZYLsypZe8WpulITEr65EJ2mLg33CgyyiGkKph8+RL/+3QNTHekYIRekM1Lb0u0w5+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYkqrE/cEsal68A7viwMMihBPyoNcNN3b36cmKT+VapS7tcM8q
	z2YkdbnGMNVXSBOTlDO+Kx7m3EJtAqEzUaHrPYJzyPquBpJ15m/SaCzZuN4W024F
X-Gm-Gg: AfdE7cnZq0tlmMOmaELSHlSZqGjDIEA1Z8rkwI+nd0adtrYbnDv+ytBx470Nlqj/gJr
	DrGKl7hLDrpTrP5aWNzjxTo8HvPmMlE2brt6n3t0JzpDFFwDERpdj93NCfRiozzHVmF5jUsO5wC
	rsjI5L6EBxtJzodn75OUgMUUwUk8h2vXb4Qa9oAEc/2W7HPfyBZZkmpjxf+jZhs3R3nyPrHm/dK
	0EACK3fWc27hhXDnX54MPfCKAYIXGpGnWLJXrPNPuklZQC0NoR9EF+Yn4mp9p0SVuE13jsmj5S8
	LnmaN0muh9kajLR2DGnRomPEQbIbd3cIAxhs03ZvmAkzz9uEBSyVrxho7O0hM+gyf10pZaLqh+d
	5nFV6R/RbhfJ4EjXcmskPjd06v3QZ2j6CQxS4pYUHmLow4gp7N5MCb9l4ItypSiPA2ELxrvM7Lj
	+H4skAkLo=
X-Received: by 2002:a17:903:37c6:b0:2c0:ab92:584c with SMTP id d9443c01a7336-2c7fc727984mr94341595ad.25.1782556921323;
        Sat, 27 Jun 2026 03:42:01 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f64d08bfsm55388625ad.63.2026.06.27.03.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 03:42:00 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Kees Cook <kees@kernel.org>,
	Mike Christie <michael.christie@oracle.com>,
	Nicholas Bellinger <nab@linux-iscsi.org>,
	Felipe Balbi <balbi@ti.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	zzzccc427@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: gadget: f_tcm: synchronize delayed set_alt with teardown
Date: Sat, 27 Jun 2026 18:41:53 +0800
Message-Id: <20260627104153.3822495-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The f_tcm set_alt() path defers endpoint setup to a work item and
completes the delayed status response from process context. The delayed
work uses f_tcm private state and may complete the setup request after
disconnect or function teardown has already moved on.

Cancel and drain the delayed set_alt work when the function is unbound or
freed. For disable paths, which are reached under the composite device
lock, use a small state machine and a non-sleeping cancellation path
instead of cancel_work_sync(). If the work is already running, mark it
cancelled and let the worker own the cleanup; otherwise tcm_disable() can
cancel the queued work and clean up immediately.

Also serialize the final delayed-status completion with the cancellation
check while holding the composite device lock. This prevents a disconnect
from clearing delayed_status while the worker is about to complete the
control request.

Validation reproduced this kernel report:
BUG: KASAN: slab-use-after-free in tcm_delayed_set_alt+0x6c/0xef0

Call Trace:
 <TASK>
 dump_stack_lvl+0x66/0xa0
 print_report+0xce/0x630
 ? tcm_delayed_set_alt+0x6c/0xef0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __virt_addr_valid+0x188/0x320
 ? tcm_delayed_set_alt+0x6c/0xef0
 kasan_report+0xe0/0x110
 ? tcm_delayed_set_alt+0x6c/0xef0
 tcm_delayed_set_alt+0x6c/0xef0
 ? __pfx_tcm_delayed_set_alt+0x10/0x10
 ? process_one_work+0x4cb/0xb90
 ? rcu_is_watching+0x20/0x50
 ? tcm_delayed_set_alt+0x9/0xef0
 process_one_work+0x4d7/0xb90
 ? __pfx_process_one_work+0x10/0x10
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __list_add_valid_or_report+0x37/0xf0
 ? __pfx_tcm_delayed_set_alt+0x10/0x10
 ? srso_alias_return_thunk+0x5/0xfbef5
 worker_thread+0x2d8/0x570
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x1ad/0x1f0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x3c9/0x540
 ? __pfx_ret_from_fork+0x10/0x10
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __switch_to+0x2e9/0x730
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Allocated by task 544:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 __kasan_kmalloc+0x8f/0xa0
 tcm_alloc+0x68/0x180
 usb_get_function+0x36/0x60
 config_usb_cfg_link+0x125/0x1b0
 configfs_symlink+0x322/0x890
 vfs_symlink+0xc2/0x270
 filename_symlinkat+0x295/0x2f0
 __x64_sys_symlinkat+0x62/0x90
 do_syscall_64+0x115/0x6a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 661:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 kasan_save_free_info+0x3b/0x60
 __kasan_slab_free+0x43/0x70
 kfree+0x2f9/0x530
 config_usb_cfg_unlink+0x173/0x1e0
 configfs_unlink+0x1fa/0x340
 vfs_unlink+0x15c/0x510
 filename_unlinkat+0x2ba/0x450
 __x64_sys_unlinkat+0x63/0x90
 do_syscall_64+0x115/0x6a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: c52661d60f63 ("usb-gadget: Initial merge of target module for UASP + BOT")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.5
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
v2:
Add Cc: stable@vger.kernel.org.
Replace the posted cancel_work()-only disable path with the
workflow-reviewed delayed-set-alt state machine.
Keep tcm_disable() non-sleeping and reserve cancel_work_sync() for
unbind/free teardown paths.

 drivers/usb/gadget/function/f_tcm.c | 192 ++++++++++++++++++++++++----
 drivers/usb/gadget/function/tcm.h   |  13 ++
 2 files changed, 177 insertions(+), 28 deletions(-)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 34d9f49e9987..b3fa5a17fd2d 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -2363,31 +2363,158 @@ static int tcm_bind(struct usb_configuration *c, struct usb_function *f)
 	return -ENOTSUPP;
 }
 
-struct guas_setup_wq {
-	struct work_struct work;
-	struct f_uas *fu;
-	unsigned int alt;
-};
+static void tcm_cleanup_old_alt(struct f_uas *fu)
+{
+	if (fu->flags & USBG_IS_UAS)
+		uasp_cleanup_old_alt(fu);
+	else if (fu->flags & USBG_IS_BOT)
+		bot_cleanup_old_alt(fu);
+	fu->flags = 0;
+}
+
+static void tcm_delayed_set_alt_done(struct f_uas *fu)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&fu->delayed_set_alt_lock, flags);
+	fu->delayed_set_alt_state = USBG_DELAYED_SET_ALT_IDLE;
+	fu->delayed_set_alt_cancel = false;
+	spin_unlock_irqrestore(&fu->delayed_set_alt_lock, flags);
+}
+
+static bool tcm_delayed_set_alt_cancelled(struct f_uas *fu)
+{
+	bool cancelled;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fu->delayed_set_alt_lock, flags);
+	cancelled = fu->delayed_set_alt_cancel;
+	spin_unlock_irqrestore(&fu->delayed_set_alt_lock, flags);
+
+	return cancelled;
+}
+
+static bool tcm_complete_delayed_status(struct f_uas *fu)
+{
+	struct usb_composite_dev *cdev = fu->function.config->cdev;
+	struct usb_request *req = cdev->req;
+	unsigned long cdev_flags;
+	bool cancelled;
+	int ret;
+
+	spin_lock_irqsave(&cdev->lock, cdev_flags);
+	spin_lock(&fu->delayed_set_alt_lock);
+	cancelled = fu->delayed_set_alt_cancel;
+	if (!cancelled) {
+		fu->delayed_set_alt_state = USBG_DELAYED_SET_ALT_IDLE;
+		fu->delayed_set_alt_cancel = false;
+	}
+	spin_unlock(&fu->delayed_set_alt_lock);
+
+	if (cancelled) {
+		spin_unlock_irqrestore(&cdev->lock, cdev_flags);
+		return false;
+	}
+
+	if (cdev->delayed_status == 0) {
+		WARN(cdev, "%s: Unexpected call\n", __func__);
+	} else if (--cdev->delayed_status == 0) {
+		req->length = 0;
+		req->context = cdev;
+		ret = usb_ep_queue(cdev->gadget->ep0, req, GFP_ATOMIC);
+		if (ret == 0) {
+			cdev->setup_pending = true;
+		} else {
+			req->status = 0;
+			req->complete(cdev->gadget->ep0, req);
+		}
+	}
+
+	spin_unlock_irqrestore(&cdev->lock, cdev_flags);
+
+	return true;
+}
+
+static bool tcm_cancel_delayed_set_alt(struct f_uas *fu)
+{
+	bool cleanup = false;
+	bool cancel = false;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fu->delayed_set_alt_lock, flags);
+	switch (fu->delayed_set_alt_state) {
+	case USBG_DELAYED_SET_ALT_IDLE:
+		cleanup = true;
+		break;
+	case USBG_DELAYED_SET_ALT_QUEUED:
+	case USBG_DELAYED_SET_ALT_RUNNING:
+		fu->delayed_set_alt_cancel = true;
+		cancel = true;
+		break;
+	}
+	spin_unlock_irqrestore(&fu->delayed_set_alt_lock, flags);
+
+	if (cancel && cancel_work(&fu->delayed_set_alt)) {
+		spin_lock_irqsave(&fu->delayed_set_alt_lock, flags);
+		if (fu->delayed_set_alt_state == USBG_DELAYED_SET_ALT_QUEUED) {
+			fu->delayed_set_alt_state = USBG_DELAYED_SET_ALT_IDLE;
+			fu->delayed_set_alt_cancel = false;
+			cleanup = true;
+		}
+		spin_unlock_irqrestore(&fu->delayed_set_alt_lock, flags);
+	}
+
+	return cleanup;
+}
+
+static void tcm_cancel_delayed_set_alt_sync(struct f_uas *fu)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&fu->delayed_set_alt_lock, flags);
+	if (fu->delayed_set_alt_state != USBG_DELAYED_SET_ALT_IDLE)
+		fu->delayed_set_alt_cancel = true;
+	spin_unlock_irqrestore(&fu->delayed_set_alt_lock, flags);
+
+	cancel_work_sync(&fu->delayed_set_alt);
+
+	spin_lock_irqsave(&fu->delayed_set_alt_lock, flags);
+	fu->delayed_set_alt_state = USBG_DELAYED_SET_ALT_IDLE;
+	fu->delayed_set_alt_cancel = false;
+	spin_unlock_irqrestore(&fu->delayed_set_alt_lock, flags);
+}
 
 static void tcm_delayed_set_alt(struct work_struct *wq)
 {
-	struct guas_setup_wq *work = container_of(wq, struct guas_setup_wq,
-			work);
-	struct f_uas *fu = work->fu;
-	int alt = work->alt;
+	struct f_uas *fu = container_of(wq, struct f_uas, delayed_set_alt);
+	unsigned long flags;
+	unsigned int alt;
 
-	kfree(work);
+	spin_lock_irqsave(&fu->delayed_set_alt_lock, flags);
+	if (fu->delayed_set_alt_state != USBG_DELAYED_SET_ALT_QUEUED) {
+		spin_unlock_irqrestore(&fu->delayed_set_alt_lock, flags);
+		return;
+	}
+	fu->delayed_set_alt_state = USBG_DELAYED_SET_ALT_RUNNING;
+	alt = fu->delayed_alt;
+	spin_unlock_irqrestore(&fu->delayed_set_alt_lock, flags);
 
-	if (fu->flags & USBG_IS_BOT)
-		bot_cleanup_old_alt(fu);
-	if (fu->flags & USBG_IS_UAS)
-		uasp_cleanup_old_alt(fu);
+	tcm_cleanup_old_alt(fu);
+
+	if (tcm_delayed_set_alt_cancelled(fu))
+		goto out_done;
 
 	if (alt == USB_G_ALT_INT_BBB)
 		bot_set_alt(fu);
 	else if (alt == USB_G_ALT_INT_UAS)
 		uasp_set_alt(fu);
-	usb_composite_setup_continue(fu->function.config->cdev);
+
+	if (tcm_complete_delayed_status(fu))
+		return;
+
+	tcm_cleanup_old_alt(fu);
+out_done:
+	tcm_delayed_set_alt_done(fu);
 }
 
 static int tcm_get_alt(struct usb_function *f, unsigned intf)
@@ -2413,15 +2540,20 @@ static int tcm_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 		return -EOPNOTSUPP;
 
 	if ((alt == USB_G_ALT_INT_BBB) || (alt == USB_G_ALT_INT_UAS)) {
-		struct guas_setup_wq *work;
+		unsigned long flags;
 
-		work = kmalloc_obj(*work, GFP_ATOMIC);
-		if (!work)
-			return -ENOMEM;
-		INIT_WORK(&work->work, tcm_delayed_set_alt);
-		work->fu = fu;
-		work->alt = alt;
-		schedule_work(&work->work);
+		spin_lock_irqsave(&fu->delayed_set_alt_lock, flags);
+		if (fu->delayed_set_alt_state != USBG_DELAYED_SET_ALT_IDLE) {
+			spin_unlock_irqrestore(&fu->delayed_set_alt_lock,
+					       flags);
+			return -EBUSY;
+		}
+		fu->delayed_alt = alt;
+		fu->delayed_set_alt_cancel = false;
+		fu->delayed_set_alt_state = USBG_DELAYED_SET_ALT_QUEUED;
+		spin_unlock_irqrestore(&fu->delayed_set_alt_lock, flags);
+
+		schedule_work(&fu->delayed_set_alt);
 		return USB_GADGET_DELAYED_STATUS;
 	}
 	return -EOPNOTSUPP;
@@ -2431,11 +2563,8 @@ static void tcm_disable(struct usb_function *f)
 {
 	struct f_uas *fu = to_f_uas(f);
 
-	if (fu->flags & USBG_IS_UAS)
-		uasp_cleanup_old_alt(fu);
-	else if (fu->flags & USBG_IS_BOT)
-		bot_cleanup_old_alt(fu);
-	fu->flags = 0;
+	if (tcm_cancel_delayed_set_alt(fu))
+		tcm_cleanup_old_alt(fu);
 }
 
 static int tcm_setup(struct usb_function *f,
@@ -2583,11 +2712,16 @@ static void tcm_free(struct usb_function *f)
 {
 	struct f_uas *tcm = to_f_uas(f);
 
+	tcm_cancel_delayed_set_alt_sync(tcm);
 	kfree(tcm);
 }
 
 static void tcm_unbind(struct usb_configuration *c, struct usb_function *f)
 {
+	struct f_uas *fu = to_f_uas(f);
+
+	tcm_cancel_delayed_set_alt_sync(fu);
+	tcm_cleanup_old_alt(fu);
 	usb_free_all_descriptors(f);
 }
 
@@ -2620,6 +2754,8 @@ static struct usb_function *tcm_alloc(struct usb_function_instance *fi)
 	fu->function.disable = tcm_disable;
 	fu->function.free_func = tcm_free;
 	fu->tpg = tpg_instances[i].tpg;
+	INIT_WORK(&fu->delayed_set_alt, tcm_delayed_set_alt);
+	spin_lock_init(&fu->delayed_set_alt_lock);
 
 	hash_init(fu->stream_hash);
 	mutex_unlock(&tpg_instances_lock);
diff --git a/drivers/usb/gadget/function/tcm.h b/drivers/usb/gadget/function/tcm.h
index 009974d81d66..e1d5a9391612 100644
--- a/drivers/usb/gadget/function/tcm.h
+++ b/drivers/usb/gadget/function/tcm.h
@@ -3,6 +3,7 @@
 #define __TARGET_USB_GADGET_H__
 
 #include <linux/kref.h>
+#include <linux/spinlock.h>
 /* #include <linux/usb/uas.h> */
 #include <linux/hashtable.h>
 #include <linux/usb/composite.h>
@@ -29,6 +30,12 @@ enum {
 
 #define USB_G_DEFAULT_SESSION_TAGS	USBG_NUM_CMDS
 
+enum {
+	USBG_DELAYED_SET_ALT_IDLE = 0,
+	USBG_DELAYED_SET_ALT_QUEUED,
+	USBG_DELAYED_SET_ALT_RUNNING,
+};
+
 struct tcm_usbg_nexus {
 	struct se_session *tvn_se_sess;
 };
@@ -132,6 +139,12 @@ struct f_uas {
 #define USBG_BOT_CMD_PEND	(1 << 4)
 #define USBG_BOT_WEDGED		(1 << 5)
 
+	struct work_struct	delayed_set_alt;
+	spinlock_t		delayed_set_alt_lock; /* protects delayed_set_alt_* */
+	unsigned int		delayed_alt;
+	unsigned int		delayed_set_alt_state;
+	bool			delayed_set_alt_cancel;
+
 	struct usbg_cdb		cmd[USBG_NUM_CMDS];
 	struct usb_ep		*ep_in;
 	struct usb_ep		*ep_out;
-- 
2.43.0

