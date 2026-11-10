Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325811;
	b=J0eYUE9X/omrEnQbkn7KuGCQvygYGIZctBYZkVL7y0AYQPVj3Ts3OXKAM4qC9MtDfjJW
	 XFwiSZi/eRbG5oM0hyc6QD9+JadTERVIhVt7kxsFRRBP1+eR6JvDNc/b4hdtQGn/N9Do1
	 dSCsxTUS+hsPzHPU+XpWmaxEsfcUzsj/V0PZemFzHQ+zMnA1j6oip1FAQh4eGWVCUmaWd
	 ulsvJk8Tyn3opLNo73XFeUpcdIcdgFwFs6GXQSNBVlYOyM+OnXzwJlusbY+OXLrKU6LcK
	 MCSMUbhyopCnVPTzeG4MSg399oy6UMhl8gzlUhbXnkBO6GReYY+b0WiR/fbMA4ypRww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325811;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=i4AzB4oZfvCEquUkhj34M0VCXbuwbN7+lnDJ7b+s/OY=;
	b=179w6RSnSYG/FWERfKFoT1CUwKLKsLBL/KobkmVz7Wn+i03O0xqsav/4a1b976nYYyCw
	 fVYILUQHN9Zg8isurcEd/lmeZ6kcNangpsylH2iHu28EejV+jzTYlVwoeZ9iUP4bxoSma
	 V0Aq4wQ/n3wwPd9etZPDbzl5JBzeNLVPl8dQruinBVBjSeugJnMC8UEanpZsx5k2wPGQT
	 mzx5/s8idUHyvCcvgNT/hA+QnZELRdgsuM8qiip4W0GtjR8awCLryZ1S6sxlbXsJhHAfE
	 8EypyAuA8wds+cG2o4Cqx0jAoO1amPeOQRNcJZUjwTAyuVxT5zOL/YxiBKOn8xZkhbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cWXOasCr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD29606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cWXOasCr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D391F0089F;
	Tue, 10 Nov 2026 15:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794325811;
	bh=i4AzB4oZfvCEquUkhj34M0VCXbuwbN7+lnDJ7b+s/OY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cWXOasCrr1+3I+aD/5wFPmewF8SPmsNm6TbYN+88lndZM4eXlGADZJsU7Se5tfZs+
	 tHr+H2ILYtGuooy3vh/f6yiKn34B+zX8JJZ+a7KadfyZz1vLNgCe+UpHmf+/6+nj49
	 6ZdLIBt9Gk609TFBQtklrGiTCDNJ0yAfxAA27FZ4WtTo01slsomUVe8q/ba75pt6Mo
	 FfYjhjVOp+eYRJ11HEVAh/ziUKaNMtEVAiFeKvWCdaEh/Kd9VOGwcul+JGPVWA8/A+
	 tQVZ3GTi34WB68oNVnZ6GZ8pcZozGY/zBelu92DMT7LEgg5zoHREhxhT0Vy6bxEgsC
	 I1deTnC117Zow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] Bluetooth: hci_core: Move all debugfs handling to hci_debugfs.c
Date: Tue, 10 Nov 2026 10:50:08 -0500
Message-ID: <20261110154953.2337328-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060625-failed-5.15-2a3e2287877b@kernel.org>
References: <20261107060625-failed-5.15-2a3e2287877b@kernel.org>
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
index c31919623d1b4..170389a36bd9e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -61,130 +61,6 @@ DEFINE_MUTEX(hci_cb_list_lock);
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
index b4ff99a4e5318..be805c87619c7 100644
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

