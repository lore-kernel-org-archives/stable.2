Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591862D3A93
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 04:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784001943; cv=none; b=cp7b3yx1fFTWNAPe6J2J92ohvK/QNjy4EdDGZkBoyYJZPHeFhM4CX/3KUIz81QshKwraGXDCosglmQCbpWni4hng+WAnce0jYzzupJu7VevdvFlLInMjtQWX/sorqzNuqDQd1rXpDQpgbq6egVfDvMEDHnJz8dtopKWdBwG65Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784001943; c=relaxed/simple;
	bh=kJVd2a0a5Ihj0Z2mtOZ5kcBg6C07kgVeUpdmYLqXdCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sz2e4QozRnEeGCMJWTppwdSdx39hf04D+Inio4a4QdvR+9bwi1IxEtyXukq/HfP9jILa2/s5vbwfrnJV6sxQUpXzsBb7iZ4xc9cjKXWdKl9lsfMCo3618njrWYxxDKi4K3RNlWksqEskV0RZKxF3dXHjHEDzOSuWACJaRmM6C80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yc/699Fx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yc/699Fx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932541F000E9;
	Tue, 14 Jul 2026 04:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784001942;
	bh=gE2yVaXE5rgZhuXGpuNPTLbsG8SYfme0izaOhrvgMSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yc/699FxALCPG90O86s0CxiGASlEqpP9pjbu98n73dZ5c0iyumhA7aY3MSB/BdWyR
	 bazSgFBkzSFXXmMPGa7AjxvHvMNqOThwjdaYx+flDujLYvylTYgEqTO+qGRX6MLROr
	 EX7yNG4eSAD1Lq1jN+FjvtSK2Xe+dQArVhKVj47TR0Q2PcI3fJ5NM4WGBsA4J+mDKS
	 DQpdAEGgU1dFGXGngXII5l4Qyr+FmgPLQrFyp00UGdfCUQZlDA4vbzsFUv75tQ6V90
	 q2H0SzGG0Q89qmEiGgh975CUAFKDkQEc3y+1E4FgjEe8WZQIZuF2NXop41loXSaY6t
	 5p5rYofTG578g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Danilo Krummrich <dakr@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] firmware_loader: Add cancel helper for async requests
Date: Tue, 14 Jul 2026 00:05:38 -0400
Message-ID: <20260714040539.2433035-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071331-spooky-nuzzle-36ff@gregkh>
References: <2026071331-spooky-nuzzle-36ff@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Cássio Gabriel <cassiogabrielcontato@gmail.com>

[ Upstream commit b9bdd68b8b979c7e9de58b2e7d21e1d7d932c755 ]

request_firmware_nowait() keeps the callback module pinned and holds
a device reference until the firmware work completes.

Callers still have no way to cancel or synchronize the queued callback
before tearing down their driver-private state.

Track scheduled async firmware work in an internal list and add
request_firmware_nowait_cancel(). The helper cancels work matching the
device, callback context and callback function. It cancels work that has
not started yet and waits for an already-running callback to return. If
the request has already completed, it is a no-op.

Keep the existing request_firmware_nowait() lifetime model manual. A
devres-managed variant can be layered on top separately if needed.

Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20260505-alsa-hda-tas2781-fw-callback-teardown-v4-1-e7c4bf930dc8@gmail.com
Stable-dep-of: 5367e2ad14f0 ("ALSA: hda/tas2781: Cancel async firmware request at unbind")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/firmware_loader/main.c | 68 +++++++++++++++++++++++++++--
 include/linux/firmware.h            | 10 +++++
 2 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 6942c62fa59d12..9153a7739878aa 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -1141,6 +1141,7 @@ EXPORT_SYMBOL(release_firmware);
 /* Async support */
 struct firmware_work {
 	struct work_struct work;
+	struct list_head list;
 	struct module *module;
 	const char *name;
 	struct device *device;
@@ -1149,6 +1150,17 @@ struct firmware_work {
 	u32 opt_flags;
 };
 
+static LIST_HEAD(firmware_work_list);
+static DEFINE_SPINLOCK(firmware_work_lock);
+
+static void firmware_work_free(struct firmware_work *fw_work)
+{
+	put_device(fw_work->device); /* taken in request_firmware_nowait() */
+	module_put(fw_work->module);
+	kfree_const(fw_work->name);
+	kfree(fw_work);
+}
+
 static void request_firmware_work_func(struct work_struct *work)
 {
 	struct firmware_work *fw_work;
@@ -1159,11 +1171,15 @@ static void request_firmware_work_func(struct work_struct *work)
 	_request_firmware(&fw, fw_work->name, fw_work->device, NULL, 0, 0,
 			  fw_work->opt_flags);
 	fw_work->cont(fw, fw_work->context);
-	put_device(fw_work->device); /* taken in request_firmware_nowait() */
 
-	module_put(fw_work->module);
-	kfree_const(fw_work->name);
-	kfree(fw_work);
+	spin_lock_irq(&firmware_work_lock);
+	if (!list_empty(&fw_work->list)) {
+		list_del_init(&fw_work->list);
+		spin_unlock_irq(&firmware_work_lock);
+		firmware_work_free(fw_work);
+		return;
+	}
+	spin_unlock_irq(&firmware_work_lock);
 }
 
 
@@ -1173,6 +1189,7 @@ static int _request_firmware_nowait(
 	void (*cont)(const struct firmware *fw, void *context), bool nowarn)
 {
 	struct firmware_work *fw_work;
+	unsigned long flags;
 
 	fw_work = kzalloc(sizeof(struct firmware_work), gfp);
 	if (!fw_work)
@@ -1205,7 +1222,12 @@ static int _request_firmware_nowait(
 
 	get_device(fw_work->device);
 	INIT_WORK(&fw_work->work, request_firmware_work_func);
+
+	spin_lock_irqsave(&firmware_work_lock, flags);
+	list_add_tail(&fw_work->list, &firmware_work_list);
 	schedule_work(&fw_work->work);
+	spin_unlock_irqrestore(&firmware_work_lock, flags);
+
 	return 0;
 }
 
@@ -1268,6 +1290,44 @@ int firmware_request_nowait_nowarn(
 }
 EXPORT_SYMBOL_GPL(firmware_request_nowait_nowarn);
 
+/**
+ * request_firmware_nowait_cancel() - cancel an async firmware request
+ * @device: device for which the firmware is being loaded
+ * @context: context passed to request_firmware_nowait()
+ * @cont: callback passed to request_firmware_nowait()
+ *
+ * Cancel a pending request_firmware_nowait() request for @device, @context
+ * and @cont. If the associated work has already started, this function waits
+ * until the callback has returned. If the callback has already completed, this
+ * function does nothing.
+ *
+ * This function may sleep.
+ */
+void request_firmware_nowait_cancel(struct device *device, void *context,
+				    void (*cont)(const struct firmware *fw,
+						 void *context))
+{
+	struct firmware_work *fw_work = NULL;
+	struct firmware_work *tmp;
+
+	spin_lock_irq(&firmware_work_lock);
+	list_for_each_entry_reverse(tmp, &firmware_work_list, list) {
+		if (tmp->device == device && tmp->context == context &&
+		    tmp->cont == cont) {
+			fw_work = tmp;
+			list_del_init(&fw_work->list);
+			break;
+		}
+	}
+	spin_unlock_irq(&firmware_work_lock);
+
+	if (!fw_work)
+		return;
+	cancel_work_sync(&fw_work->work);
+	firmware_work_free(fw_work);
+}
+EXPORT_SYMBOL_GPL(request_firmware_nowait_cancel);
+
 #ifdef CONFIG_FW_CACHE
 static ASYNC_DOMAIN_EXCLUSIVE(fw_cache_domain);
 
diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index aae1b85ffc10e2..0fa3b027f02f16 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -110,6 +110,9 @@ int request_firmware_nowait(
 	struct module *module, bool uevent,
 	const char *name, struct device *device, gfp_t gfp, void *context,
 	void (*cont)(const struct firmware *fw, void *context));
+void request_firmware_nowait_cancel(struct device *device, void *context,
+				    void (*cont)(const struct firmware *fw,
+						 void *context));
 int request_firmware_direct(const struct firmware **fw, const char *name,
 			    struct device *device);
 int request_firmware_into_buf(const struct firmware **firmware_p,
@@ -157,6 +160,13 @@ static inline int request_firmware_nowait(
 	return -EINVAL;
 }
 
+static inline void request_firmware_nowait_cancel(struct device *device,
+						  void *context,
+						  void (*cont)(const struct firmware *fw,
+							       void *context))
+{
+}
+
 static inline void release_firmware(const struct firmware *fw)
 {
 }
-- 
2.53.0

