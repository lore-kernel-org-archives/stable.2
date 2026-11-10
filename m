Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794326865;
	b=eaBdtQhMAi6j1n6556VFm3QQUvG1u+D0Pb54UpsVfXjYoSkTd+bQAvJ9LREI6C6oW/mG
	 Fhl8ArWxK2ewVSz2p4RsSfmJjQdbsOanLTsKXcoHzsG9nl2GsLpJKVKVph/LoG2Zij0ts
	 5jCfpSY/V3De/z7Uy+zD6AI7J66Ntu1awvW21gnjZKrMqF3sp6z75vyFQFbt/7+45m45s
	 xkdXadhsE2Uixbkj6EU9gkY9wTrPpwRMUoyY+eXm3JdDxidbmeXBfmvoleJ7Ts6cJc9Ya
	 3Q3rZDI8KjriEhaJJdLvF8efOuxajoDOmqocJc1sOgutqpO5Siq7DcBnYeJAdvAPhGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326865;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=C3IisIYH0IHz1zBdF0rTLtjaazqN+S/GvTSmht6iVp0=;
	b=BubAl035wnKUhGbf9YWPVvc79XKEc40DA01ULp60Sabm6Y4MhUVacAJ42euc+AbIziTG
	 FyWPaQjKcCyM0qcz3dCw3rt1gWyOgcK9NT3nF2xFyyb8JjBxM/Y4ysvZWIwUjW+acVL7Q
	 gm5Knr1PGBtzrRZILlGt4gpX8rQ27ldQNB/cNDdejqmIfF4aaT/tlfI0M8LqL/KcDXqg6
	 AjbIMGZu0RKOMhymTFU16n+vBbLVABAU+x0jW5eFY/vT7GwAO4DWOz0sVMtdC0BhLz8oT
	 SPR8Km+iA+F4+QW1MH+/H1ddSGc2nD3o++QzhRc5nkL9nkydUj05JuxUNiedEYYqqKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bDl7Qast;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B1B606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bDl7Qast
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2FE1F008A2;
	Tue, 10 Nov 2026 16:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794326864;
	bh=C3IisIYH0IHz1zBdF0rTLtjaazqN+S/GvTSmht6iVp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bDl7QastAfMDenO9vkP2hrSwGUXuUv/hgW4ztW4C/0P9dbA7jVTWjhXQrvp6MD3TE
	 YwzNAkE3R18CE7++bKKAhsQhgEsFoLg9fnRVxCDyBERUVa3yoQlIINqL2KzVwHZo0T
	 RwUfDYbiO5ODxcoNVcsfGZTyam/9RIlW7SPMxRtEQZ+baAfpIVkbJKE1hnJKlP0zti
	 uC7SDBgK7fV8Kf660q8MlwxzJxAZ/2u7FimCFFX3yZVQ/EjRJtAXiKkLQn1t9ki++Z
	 kUXpDqmXmtKnlSxvq6/fEPwOetGN1KQiz4n5XXISSTOOZLX/5/bEI5p/qIP7/RdCfG
	 fgf+QLOwewIBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] Bluetooth: hci_core: Move all debugfs handling to hci_debugfs.c
Date: Tue, 10 Nov 2026 11:07:40 -0500
Message-ID: <20261110160710.2356064-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110160710.2356064-1-sashal@kernel.org>
References: <20261107062317-failed-5.10-2a3e2287877b@kernel.org>
 <20261110160710.2356064-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 8331dc487fc55963e853b6858af716907717e181 ]

This moves hci_debugfs_create_basic to hci_debugfs.c which is where all
the others debugfs entries are handled.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Stable-dep-of: 2a3e2287877b ("Bluetooth: hci_debugfs: Pin module for debugfs file operations")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_core.c    | 124 ------------------------------------
 net/bluetooth/hci_debugfs.c | 123 +++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_debugfs.h |   5 ++
 3 files changed, 128 insertions(+), 124 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 87ef9fdeb12ec..834cefb43b74e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -60,130 +60,6 @@ DEFINE_MUTEX(hci_cb_list_lock);
 /* HCI ID Numbering */
 static DEFINE_IDA(hci_index_ida);
 
-/* ---- HCI debugfs entries ---- */
-
-static ssize_t dut_mode_read(struct file *file, char __user *user_buf,
-			     size_t count, loff_t *ppos)
-{
-	struct hci_dev *hdev = file->private_data;
-	char buf[3];
-
-	buf[0] = hci_dev_test_flag(hdev, HCI_DUT_MODE) ? 'Y' : 'N';
-	buf[1] = '\n';
-	buf[2] = '\0';
-	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
-}
-
-static ssize_t dut_mode_write(struct file *file, const char __user *user_buf,
-			      size_t count, loff_t *ppos)
-{
-	struct hci_dev *hdev = file->private_data;
-	struct sk_buff *skb;
-	bool enable;
-	int err;
-
-	if (!test_bit(HCI_UP, &hdev->flags))
-		return -ENETDOWN;
-
-	err = kstrtobool_from_user(user_buf, count, &enable);
-	if (err)
-		return err;
-
-	if (enable == hci_dev_test_flag(hdev, HCI_DUT_MODE))
-		return -EALREADY;
-
-	hci_req_sync_lock(hdev);
-	if (enable)
-		skb = __hci_cmd_sync(hdev, HCI_OP_ENABLE_DUT_MODE, 0, NULL,
-				     HCI_CMD_TIMEOUT);
-	else
-		skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL,
-				     HCI_CMD_TIMEOUT);
-	hci_req_sync_unlock(hdev);
-
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	kfree_skb(skb);
-
-	hci_dev_change_flag(hdev, HCI_DUT_MODE);
-
-	return count;
-}
-
-static const struct file_operations dut_mode_fops = {
-	.open		= simple_open,
-	.read		= dut_mode_read,
-	.write		= dut_mode_write,
-	.llseek		= default_llseek,
-};
-
-static ssize_t vendor_diag_read(struct file *file, char __user *user_buf,
-				size_t count, loff_t *ppos)
-{
-	struct hci_dev *hdev = file->private_data;
-	char buf[3];
-
-	buf[0] = hci_dev_test_flag(hdev, HCI_VENDOR_DIAG) ? 'Y' : 'N';
-	buf[1] = '\n';
-	buf[2] = '\0';
-	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
-}
-
-static ssize_t vendor_diag_write(struct file *file, const char __user *user_buf,
-				 size_t count, loff_t *ppos)
-{
-	struct hci_dev *hdev = file->private_data;
-	bool enable;
-	int err;
-
-	err = kstrtobool_from_user(user_buf, count, &enable);
-	if (err)
-		return err;
-
-	/* When the diagnostic flags are not persistent and the transport
-	 * is not active or in user channel operation, then there is no need
-	 * for the vendor callback. Instead just store the desired value and
-	 * the setting will be programmed when the controller gets powered on.
-	 */
-	if (test_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks) &&
-	    (!test_bit(HCI_RUNNING, &hdev->flags) ||
-	     hci_dev_test_flag(hdev, HCI_USER_CHANNEL)))
-		goto done;
-
-	hci_req_sync_lock(hdev);
-	err = hdev->set_diag(hdev, enable);
-	hci_req_sync_unlock(hdev);
-
-	if (err < 0)
-		return err;
-
-done:
-	if (enable)
-		hci_dev_set_flag(hdev, HCI_VENDOR_DIAG);
-	else
-		hci_dev_clear_flag(hdev, HCI_VENDOR_DIAG);
-
-	return count;
-}
-
-static const struct file_operations vendor_diag_fops = {
-	.open		= simple_open,
-	.read		= vendor_diag_read,
-	.write		= vendor_diag_write,
-	.llseek		= default_llseek,
-};
-
-static void hci_debugfs_create_basic(struct hci_dev *hdev)
-{
-	debugfs_create_file("dut_mode", 0644, hdev->debugfs, hdev,
-			    &dut_mode_fops);
-
-	if (hdev->set_diag)
-		debugfs_create_file("vendor_diag", 0644, hdev->debugfs, hdev,
-				    &vendor_diag_fops);
-}
-
 static int hci_reset_req(struct hci_request *req, unsigned long opt)
 {
 	BT_DBG("%s %ld", req->hdev->name, opt);
diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 1192280031685..987a546de3ae1 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -27,6 +27,7 @@
 #include <net/bluetooth/hci_core.h>
 
 #include "smp.h"
+#include "hci_request.h"
 #include "hci_debugfs.h"
 
 #define DEFINE_QUIRK_ATTRIBUTE(__name, __quirk)				      \
@@ -1270,3 +1271,125 @@ void hci_debugfs_create_conn(struct hci_conn *conn)
 	snprintf(name, sizeof(name), "%u", conn->handle);
 	conn->debugfs = debugfs_create_dir(name, hdev->debugfs);
 }
+
+static ssize_t dut_mode_read(struct file *file, char __user *user_buf,
+			     size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	char buf[3];
+
+	buf[0] = hci_dev_test_flag(hdev, HCI_DUT_MODE) ? 'Y' : 'N';
+	buf[1] = '\n';
+	buf[2] = '\0';
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static ssize_t dut_mode_write(struct file *file, const char __user *user_buf,
+			      size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	struct sk_buff *skb;
+	bool enable;
+	int err;
+
+	if (!test_bit(HCI_UP, &hdev->flags))
+		return -ENETDOWN;
+
+	err = kstrtobool_from_user(user_buf, count, &enable);
+	if (err)
+		return err;
+
+	if (enable == hci_dev_test_flag(hdev, HCI_DUT_MODE))
+		return -EALREADY;
+
+	hci_req_sync_lock(hdev);
+	if (enable)
+		skb = __hci_cmd_sync(hdev, HCI_OP_ENABLE_DUT_MODE, 0, NULL,
+				     HCI_CMD_TIMEOUT);
+	else
+		skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL,
+				     HCI_CMD_TIMEOUT);
+	hci_req_sync_unlock(hdev);
+
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	kfree_skb(skb);
+
+	hci_dev_change_flag(hdev, HCI_DUT_MODE);
+
+	return count;
+}
+
+static const struct file_operations dut_mode_fops = {
+	.open		= simple_open,
+	.read		= dut_mode_read,
+	.write		= dut_mode_write,
+	.llseek		= default_llseek,
+};
+
+static ssize_t vendor_diag_read(struct file *file, char __user *user_buf,
+				size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	char buf[3];
+
+	buf[0] = hci_dev_test_flag(hdev, HCI_VENDOR_DIAG) ? 'Y' : 'N';
+	buf[1] = '\n';
+	buf[2] = '\0';
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static ssize_t vendor_diag_write(struct file *file, const char __user *user_buf,
+				 size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	bool enable;
+	int err;
+
+	err = kstrtobool_from_user(user_buf, count, &enable);
+	if (err)
+		return err;
+
+	/* When the diagnostic flags are not persistent and the transport
+	 * is not active or in user channel operation, then there is no need
+	 * for the vendor callback. Instead just store the desired value and
+	 * the setting will be programmed when the controller gets powered on.
+	 */
+	if (test_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks) &&
+	    (!test_bit(HCI_RUNNING, &hdev->flags) ||
+	     hci_dev_test_flag(hdev, HCI_USER_CHANNEL)))
+		goto done;
+
+	hci_req_sync_lock(hdev);
+	err = hdev->set_diag(hdev, enable);
+	hci_req_sync_unlock(hdev);
+
+	if (err < 0)
+		return err;
+
+done:
+	if (enable)
+		hci_dev_set_flag(hdev, HCI_VENDOR_DIAG);
+	else
+		hci_dev_clear_flag(hdev, HCI_VENDOR_DIAG);
+
+	return count;
+}
+
+static const struct file_operations vendor_diag_fops = {
+	.open		= simple_open,
+	.read		= vendor_diag_read,
+	.write		= vendor_diag_write,
+	.llseek		= default_llseek,
+};
+
+void hci_debugfs_create_basic(struct hci_dev *hdev)
+{
+	debugfs_create_file("dut_mode", 0644, hdev->debugfs, hdev,
+			    &dut_mode_fops);
+
+	if (hdev->set_diag)
+		debugfs_create_file("vendor_diag", 0644, hdev->debugfs, hdev,
+				    &vendor_diag_fops);
+}
diff --git a/net/bluetooth/hci_debugfs.h b/net/bluetooth/hci_debugfs.h
index 4444dc8cedc21..9a8a7c93bb12a 100644
--- a/net/bluetooth/hci_debugfs.h
+++ b/net/bluetooth/hci_debugfs.h
@@ -26,6 +26,7 @@ void hci_debugfs_create_common(struct hci_dev *hdev);
 void hci_debugfs_create_bredr(struct hci_dev *hdev);
 void hci_debugfs_create_le(struct hci_dev *hdev);
 void hci_debugfs_create_conn(struct hci_conn *conn);
+void hci_debugfs_create_basic(struct hci_dev *hdev);
 
 #else
 
@@ -45,4 +46,8 @@ static inline void hci_debugfs_create_conn(struct hci_conn *conn)
 {
 }
 
+static inline void hci_debugfs_create_basic(struct hci_dev *hdev)
+{
+}
+
 #endif
-- 
2.53.0

