Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794743276;
	b=0dcPujgUwrZf9RyxVQW317P+JZwSD9A57ug1ZhHxaZEDS5TQL1GhRlsTq444pYNrIyD8
	 IhX6csvHUZ6avda1TLK09PXGIRlxhKQpC37m1PDj1EzLwrw2NARHhpwIMHYC8pLd9Q+I3
	 iFSR+T3SwjTaBURJSU9Ue/KSVKRdmyeKVVtPpfhJfRiYaUfY+MDD3ZjOlXdUOhHL+A3+g
	 v+zwsdu4nmmjuv+p5EFz50kiei8qLO6OGY57BDF1dLiPA8Wb5d6Q+j0jMOhdhpg6EKukr
	 XJ4iZdc2qSOIlPfSbuIZu+wIs/jHA1VMFcZVr/nLf9vBU5Kejl9JFM8O5W43pLjHpsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794743276;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=jIuQ2XzzPvxfqNg2q/0pDp2CIsPqv3IJ/p3RhjsKioU=;
	b=SdR4Rik4IRbxx5kSBFAjpzkAbU2bC6OD+NkjWuPB+T6QKsF6mdSrxkG3zAw+jzRNCdjl
	 HkNrxmzjdH3DjcK4Lb6fC/GKK1wDfa+fsnB0DkYeFD3iNrCYTpD/AYoXKB1QQ6cwsL3+C
	 gJMi/agqEB1gU0mTWzzqw5B5p12XVmSTe7exOUt9531zD/RtqyxO8e1NhNoMm856R2tmx
	 F7hhms7cSiuaJijgbUbP+gV5Q2YxSv4L4HwZJEQHzeg/whaFKmrSgFgMT2qFTH86X/YAk
	 XKEwUbVuzShy/+Q7BtofHRrltCA5eKc70cErKLv8JDh94o7nW9d8IgOWYffyvhYcUVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seu.edu.cn;
	spf=pass smtp.mailfrom=seu.edu.cn;
	dkim=pass header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=JSU5vpc4;
	arc=none smtp.remote-ip=101.71.155.101
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E73606A33D;
	Sun, 15 Nov 2026 11:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99E73606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=JSU5vpc4
Received: from [192.168.17.1] (unknown [124.79.98.159])
	by smtp.qiye.163.com (Hmail) with ESMTP id 54b7e04d8;
	Sun, 15 Nov 2026 19:47:45 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Ilpo =?utf-8?b?SumQqeeeqHZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Derek J. Clark <derekjohn.clark@gmail.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>, Rong Zhang <i@rong.moe>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH v2 1/2] extcon: synchronize all-connector notifier removal
Date: Sun, 15 Nov 2026 19:47:42 +0800
Message-ID: <179474326273.103840.4798359664806814358@seu.edu.cn>
In-Reply-To: <179474326098.103840.15531040789536968458@seu.edu.cn>
References: <179474326098.103840.15531040789536968458@seu.edu.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-HM-Tid: 0aa1df08e81e03a1kunmbac61c98bf771
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTkkYVk8aTE9KTBkYGklMGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKSU9VTEJVQkNVSk5CWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=JSU5vpc4KiFptaiw1Czv6/2IvXCYaQAgXRhvW95sxMbHL7kEKO8mJFM5bWDCDyAT2A3lK2rzqRO420C+lQ8da2ysqrJVc3u5oJfYyYDWoSu0eYoxrhNx9gqlNxUJVFaEsNTVJULiuMdn0P1s46EiXkQCniBGsUNuisideIup4v4=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=jIuQ2XzzPvxfqNg2q/0pDp2CIsPqv3IJ/p3RhjsKioU=;
	h=date:mime-version:subject:message-id:from;

extcon_sync() invokes the all-connector raw notifier chain after
dropping edev->lock. Unregister unlinks a block under that lock but
does not wait for an in-flight callback, so managed consumers can
release their state while a callback still publishes work.

Use an atomic notifier chain for the all-connector notifications.
Its RCU read section and synchronized unregister provide the
required callback quiescence. Use the notifier implementation's
own writer lock and perform its grace-period wait outside edev's
spinlock. Document callback and unregister context requirements.

The current all-connector consumers defer their operations to work
items and their callbacks do not sleep. Per-ID raw chains retain
their existing behavior: some OMAP callbacks perform regulator
operations and need a separate context-compatible repair.

Found by the author's in-house static analysis tool.

Fixes: 815429b39d94 ("extcon: Add new extcon_register_notifier_all() to monitor all external connectors")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/2ef4ad43-497f-c40f-b18a-f5b75799d95d@linux.intel.com/
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
Signed-off-by: Zehao Gao <gaozehao@iie.ac.cn>
---

Discovery: found by the author's in-house static analysis tool.

 Documentation/driver-api/extcon.rst |  2 +-
 drivers/extcon/extcon.c             | 28 +++++++++-------------------
 drivers/extcon/extcon.h             |  2 +-
 include/linux/extcon.h              |  4 ++++
 4 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/Documentation/driver-api/extcon.rst b/Documentation/driver-api/extcon.rst
index d3217b9..384d743 100644
--- a/Documentation/driver-api/extcon.rst
+++ b/Documentation/driver-api/extcon.rst
@@ -70,7 +70,7 @@ The core structure representing an Extcon device::
         /* Internal data */
         struct device dev;
         unsigned int id;
-        struct raw_notifier_head nh_all;
+        struct atomic_notifier_head nh_all;
         struct raw_notifier_head *nh;
         struct list_head entry;
         int max_supported;
diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 98d85cc..b8d8c2a 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -456,10 +456,10 @@ int extcon_sync(struct extcon_dev *edev, unsigned int id)
 	raw_notifier_call_chain(&edev->nh[index], state, edev);
 
 	/*
-	 * Call functions in a raw notifier chain for the all supported
+	 * Call functions in the atomic notifier chain for all supported
 	 * external connectors.
 	 */
-	raw_notifier_call_chain(&edev->nh_all, state, edev);
+	atomic_notifier_call_chain(&edev->nh_all, state, edev);
 
 	spin_lock_irqsave(&edev->lock, flags);
 	/* This could be in interrupt handler */
@@ -967,6 +967,7 @@ EXPORT_SYMBOL_GPL(extcon_unregister_notifier);
  *
  * Note that this function registers a notifier block in order to receive
  * the state change of all supported external connectors from extcon device.
+ * Callbacks run under the RCU read-side critical section and must not sleep.
  * And the second parameter given to the callback of nb (val) is
  * the current state and the third pameter is the pointer of extcon device.
  *
@@ -975,17 +976,10 @@ EXPORT_SYMBOL_GPL(extcon_unregister_notifier);
 int extcon_register_notifier_all(struct extcon_dev *edev,
 				struct notifier_block *nb)
 {
-	unsigned long flags;
-	int ret;
-
 	if (!edev || !nb)
 		return -EINVAL;
 
-	spin_lock_irqsave(&edev->lock, flags);
-	ret = raw_notifier_chain_register(&edev->nh_all, nb);
-	spin_unlock_irqrestore(&edev->lock, flags);
-
-	return ret;
+	return atomic_notifier_chain_register(&edev->nh_all, nb);
 }
 EXPORT_SYMBOL_GPL(extcon_register_notifier_all);
 
@@ -995,21 +989,17 @@ EXPORT_SYMBOL_GPL(extcon_register_notifier_all);
  * @nb:		a notifier block to be registered
  *
  * Returns 0 if success or error number if fail.
+ *
+ * Waits for in-flight callbacks. Must be called from process context and
+ * outside a notifier callback.
  */
 int extcon_unregister_notifier_all(struct extcon_dev *edev,
 				struct notifier_block *nb)
 {
-	unsigned long flags;
-	int ret;
-
 	if (!edev || !nb)
 		return -EINVAL;
 
-	spin_lock_irqsave(&edev->lock, flags);
-	ret = raw_notifier_chain_unregister(&edev->nh_all, nb);
-	spin_unlock_irqrestore(&edev->lock, flags);
-
-	return ret;
+	return atomic_notifier_chain_unregister(&edev->nh_all, nb);
 }
 EXPORT_SYMBOL_GPL(extcon_unregister_notifier_all);
 
@@ -1300,7 +1290,7 @@ int extcon_dev_register(struct extcon_dev *edev)
 	for (index = 0; index < edev->max_supported; index++)
 		RAW_INIT_NOTIFIER_HEAD(&edev->nh[index]);
 
-	RAW_INIT_NOTIFIER_HEAD(&edev->nh_all);
+	ATOMIC_INIT_NOTIFIER_HEAD(&edev->nh_all);
 
 	dev_set_drvdata(&edev->dev, edev);
 	dev_set_name(&edev->dev, "extcon%d", edev->id);
diff --git a/drivers/extcon/extcon.h b/drivers/extcon/extcon.h
index 9461826..5a3f0c4 100644
--- a/drivers/extcon/extcon.h
+++ b/drivers/extcon/extcon.h
@@ -48,7 +48,7 @@ struct extcon_dev {
 	/* Internal data. Please do not set. */
 	struct device dev;
 	unsigned int id;
-	struct raw_notifier_head nh_all;
+	struct atomic_notifier_head nh_all;
 	struct raw_notifier_head *nh;
 	struct list_head entry;
 	int max_supported;
diff --git a/include/linux/extcon.h b/include/linux/extcon.h
index e596a0a..869bac9 100644
--- a/include/linux/extcon.h
+++ b/include/linux/extcon.h
@@ -209,6 +209,10 @@ void devm_extcon_unregister_notifier(struct device *dev,
 				struct extcon_dev *edev, unsigned int id,
 				struct notifier_block *nb);
 
+/*
+ * All-connector callbacks must not sleep. Unregister waits for callbacks and
+ * must be called from process context, outside a notifier callback.
+ */
 int extcon_register_notifier_all(struct extcon_dev *edev,
 				struct notifier_block *nb);
 int extcon_unregister_notifier_all(struct extcon_dev *edev,
-- 
2.50.1.windows.1
