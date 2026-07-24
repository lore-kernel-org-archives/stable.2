Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DD5379EC1;
	Fri, 24 Jul 2026 05:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784870939; cv=none; b=rI5Nkisp2Q3V9hLtYCyFLjFXAp3ojd91MwQ2IZOwkWTnzlN0gTLE4V2Q24UpxJI+WUfhMCnNIGcKmHLdU0sXSTUURfVRoh9uZOFOESEesf8WfT/G9Rpjn90BU5RF0wtjB0fVVCYnG/N5qzpK6y7JLGNWIu/KR3hbENxUDFQFTJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784870939; c=relaxed/simple;
	bh=KhlkVugzlpE2m2Z076VC1k1NZtnRSpmrA3zEGlb/8Us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FEsNHn12FBDCXQwiuOat6aDEUxLhENPfkfTjkehvSG1wfwg3mkrjGjqDiV/6vE+f9yvj5PX8nbtdVZY1Qygx4w1Quznb7GwwbZQLiYWnTUOAC+oCSHUOQq2hKge903wYFpewlgAc5ny5nCjRM/rIPAf0/j22QtLSQ0nrOUkdkRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=N9RYAFaj; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="N9RYAFaj"
Received: from LAPTOP-99KJFSET (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 47691a1b6;
	Fri, 24 Jul 2026 13:28:50 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	arnd@arndb.de
Cc: linusw@kernel.org,
	brgl@kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	getshell@seu.edu.cn
Subject: [RFC PATCH 6.6.y 2/4] misc: ti-st: account published transport users
Date: Fri, 24 Jul 2026 13:28:40 +0800
Message-ID: <20260724052842.1052-3-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260724052842.1052-1-getshell@seu.edu.cn>
References: <20260724052842.1052-1-getshell@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f9299077803a1kunm7e8f9dea24465
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSRpLVh1MGExKQktOQhlPQ1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0
	NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=N9RYAFajBgxwZb3bFT9wIVEjq1B40KqSvs176TDFeynDruYUCjZjb7MgWtt4qgxOJNBxSMR7E4b2eabEGxI2MtL1aCZ5sMDObCq0xS1oukIZdXm7+xTJXJ8T+UedHVE+VJAeSuSWJlLbswNjQzcIyZdEqDrjEHPEUsB7/v5sOkE=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=0b5SmVX8NJaoxGM22f1jTM6RuLAr+x6459/O1As/FZA=;
	h=date:mime-version:subject:message-id:from;

The shared transport entry points obtain a raw core pointer through
st_kim_ref().  Removal needs to stop new lookups and wait for existing
users before freeing that core.

Serialize publication and lookup, count successful lookups, and use a
scope cleanup to release the count on every return path.  This prepares
the removal path to drain the users without a large error-path rewrite.

Fixes: 53618cc1e51e ("Staging: sources for ST core")
Cc: stable@vger.kernel.org
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 drivers/misc/ti-st/st_core.c | 15 +++++++++++----
 drivers/misc/ti-st/st_kim.c  | 29 +++++++++++++++++++++++------
 include/linux/ti_wilink_st.h |  8 ++++++++
 3 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/ti-st/st_core.c b/drivers/misc/ti-st/st_core.c
index b878431..43d2587 100644
--- a/drivers/misc/ti-st/st_core.c
+++ b/drivers/misc/ti-st/st_core.c
@@ -7,6 +7,7 @@
  */
 
 #define pr_fmt(fmt)	"(stc): " fmt
+#include <linux/cleanup.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/tty.h>
@@ -24,6 +25,8 @@
  */
 static void (*st_recv)(void *disc_data, const u8 *ptr, size_t count);
 
+DEFINE_FREE(st_kim, struct st_data_s *, st_kim_put(_T));
+
 /********************************************************************/
 static void add_channel_to_table(struct st_data_s *st_gdata,
 		struct st_proto_s *new_proto)
@@ -522,7 +525,7 @@ void kim_st_list_protocols(struct st_data_s *st_gdata, void *buf)
  */
 long st_register(struct st_proto_s *new_proto)
 {
-	struct st_data_s	*st_gdata;
+	struct st_data_s *st_gdata __free(st_kim) = NULL;
 	long err = 0;
 	unsigned long flags = 0;
 
@@ -640,7 +643,7 @@ long st_unregister(struct st_proto_s *proto)
 {
 	long err = 0;
 	unsigned long flags = 0;
-	struct st_data_s	*st_gdata;
+	struct st_data_s *st_gdata __free(st_kim) = NULL;
 
 	pr_debug("%s: %d ", __func__, proto->chnl_id);
 
@@ -688,7 +691,7 @@ long st_unregister(struct st_proto_s *proto)
  */
 long st_write(struct sk_buff *skb)
 {
-	struct st_data_s *st_gdata;
+	struct st_data_s *st_gdata __free(st_kim) = NULL;
 	long len;
 
 	st_kim_ref(&st_gdata, 0);
@@ -719,10 +722,12 @@ EXPORT_SYMBOL_GPL(st_unregister);
  */
 static int st_tty_open(struct tty_struct *tty)
 {
-	struct st_data_s *st_gdata;
+	struct st_data_s *st_gdata __free(st_kim) = NULL;
 	pr_info("%s ", __func__);
 
 	st_kim_ref(&st_gdata, 0);
+	if (!st_gdata)
+		return -ENODEV;
 	st_gdata->tty = tty;
 	tty->disc_data = st_gdata;
 
@@ -878,6 +883,8 @@ int st_core_init(struct st_data_s **core_data)
 
 	/* Locking used in st_int_enqueue() to avoid multiple execution */
 	spin_lock_init(&st_gdata->lock);
+	atomic_set(&st_gdata->active_users, 0);
+	init_waitqueue_head(&st_gdata->users_wait);
 
 	err = st_ll_init(st_gdata);
 	if (err) {
diff --git a/drivers/misc/ti-st/st_kim.c b/drivers/misc/ti-st/st_kim.c
index ec265a6..11eadc1 100644
--- a/drivers/misc/ti-st/st_kim.c
+++ b/drivers/misc/ti-st/st_kim.c
@@ -23,9 +23,11 @@
 #include <linux/skbuff.h>
 #include <linux/ti_wilink_st.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 
 #define MAX_ST_DEVICES	3	/* Imagine 1 on each UART for now */
 static struct platform_device *st_kim_devices[MAX_ST_DEVICES];
+static DEFINE_MUTEX(st_kim_mutex);
 
 /**********************************************************************/
 /* internal functions */
@@ -671,18 +673,31 @@ void st_kim_ref(struct st_data_s **core_data, int id)
 {
 	struct platform_device	*pdev;
 	struct kim_data_s	*kim_gdata;
+
+	*core_data = NULL;
+	mutex_lock(&st_kim_mutex);
 	/* get kim_gdata reference from platform device */
 	pdev = st_get_plat_device(id);
 	if (!pdev)
-		goto err;
+		goto out;
 	kim_gdata = platform_get_drvdata(pdev);
-	if (!kim_gdata)
-		goto err;
+	if (!kim_gdata || !kim_gdata->core_data ||
+	    kim_gdata->core_data->removing)
+		goto out;
 
+	atomic_inc(&kim_gdata->core_data->active_users);
 	*core_data = kim_gdata->core_data;
-	return;
-err:
-	*core_data = NULL;
+out:
+	mutex_unlock(&st_kim_mutex);
+}
+
+void st_kim_put(struct st_data_s *st_gdata)
+{
+	if (!st_gdata)
+		return;
+
+	if (atomic_dec_and_test(&st_gdata->active_users))
+		wake_up(&st_gdata->users_wait);
 }
 
 DEFINE_SHOW_ATTRIBUTE(version);
@@ -756,7 +771,9 @@ static int kim_probe(struct platform_device *pdev)
 				kim_gdata, &list_fops);
 	if (pdev->id >= 0 && pdev->id < MAX_ST_DEVICES)
 		id = pdev->id;
+	mutex_lock(&st_kim_mutex);
 	st_kim_devices[id] = pdev;
+	mutex_unlock(&st_kim_mutex);
 	return 0;
 
 err_sysfs_group:
diff --git a/include/linux/ti_wilink_st.h b/include/linux/ti_wilink_st.h
index 10642d4..f91300d 100644
--- a/include/linux/ti_wilink_st.h
+++ b/include/linux/ti_wilink_st.h
@@ -13,6 +13,7 @@
 #define TI_WILINK_ST_H
 
 #include <linux/skbuff.h>
+#include <linux/wait.h>
 
 /**
  * enum proto-type - The protocol on WiLink chips which share a
@@ -125,6 +126,9 @@ extern long st_unregister(struct st_proto_s *);
  * @ll_state: the various PM states the chip can be, the states are notified
  *	to us, when the chip sends relevant PM packets(SLEEP_IND, WAKE_IND).
  * @kim_data: reference to the parent encapsulating structure.
+ * @active_users: number of published core users being drained by removal.
+ * @users_wait: wait queue used by removal to drain published core users.
+ * @removing: set once the core is no longer available to new users.
  *
  */
 struct st_data_s {
@@ -144,6 +148,9 @@ struct st_data_s {
 	unsigned char	protos_registered;
 	unsigned long ll_state;
 	void *kim_data;
+	atomic_t active_users;
+	wait_queue_head_t users_wait;
+	bool removing;
 	struct tty_struct *tty;
 	struct work_struct work_write_wakeup;
 };
@@ -179,6 +186,7 @@ void st_core_exit(struct st_data_s *);
 
 /* ask for reference from KIM */
 void st_kim_ref(struct st_data_s **, int);
+void st_kim_put(struct st_data_s *st_gdata);
 
 #define GPS_STUB_TEST
 #ifdef GPS_STUB_TEST
-- 
2.50.1.windows.1

