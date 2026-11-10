Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794326864;
	b=CVNGka46bsQEexwy6LlASCk0YTsYvTCBVnnCqhwrCP/dYIwh8trHfKLFZFMXjdORyheQ
	 taVF2n1JqIKWLOKqpoBQ1ZiUPRJNZS5/QMMk48xwnnRKZyOedtWDvK9SCT85sRQmBWe0E
	 riT702CedeEPaZiYFQgzGJoVP486yqgZUFLszNuRG6PeCWKkDhUbhvNca1EBJXg2DVfg9
	 XndMHaia8Sx71mI3+ZXhH8tJspb0bnsbZd031IR060dB4V37U3+5kqs17QjnT53Ok05M9
	 r4WlQnff5VN7hEoFKo8Vuqx2WKWwNvL/gfI1IklOm48CgzvGzWq6/Q8lnY+YtSzoRrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326864;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9flqUZOwueLOxmjiIAlHkIGtXu+DmePHgg99ofPQG+I=;
	b=v01Fqk7uHuwRhMW5rUe71ngrL7c+pSOZHWN6P1F8toqYaK59tkY7KcyNcII4Mn/a5HIn
	 4Lvx1s5aWoHNKFc4ep0IxgsRBYhUjIki0PjPR5K5qx8PgtYEucRK3UlkMiA+NNdSTQESt
	 Zk9X+BATc2z1RbkDtFt2ftGOm/BK0H8y7lDVAtRk6+Y6EYwjyb8fzJSuLvTTdDUVxTGId
	 uLhnLC3WJ8ICeggdxU7ldDbdJXHp3LAi7PE0wM8V5XxW0I06p+wajJx4s30PTFamdVC8k
	 WmqywF2fGdkGiHpBu6NcZ16nRR7hC6daJR5dlp/BGM3+0IoArIsAvYX9Ej49iuB6xRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eKbNk4N0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF009606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eKbNk4N0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190231F008A1;
	Tue, 10 Nov 2026 16:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794326863;
	bh=9flqUZOwueLOxmjiIAlHkIGtXu+DmePHgg99ofPQG+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eKbNk4N01A6UXpbIC5jhFXxle+T4YHJli1JeJ3WkcrEzXC9LbFXvLXBRDigbqt9m9
	 RNEZKbgkyDT2oMXtHbPbkwlR1r69cXcgFk26/mtXjPqITdVT5lD0qQ8kcgICOCUJiT
	 MqTR25VLMN+zD/CDd7ay6gBLXzcyMhkgCHjUU4AgLWJquf7/WMYgW1T359Caw49diL
	 U94i1wEjcReJ3wAf1U6mmdJ368FppKSIl49r5K15PeobOZe5ZiH65YKFcw13RUgKrk
	 vu/wHsg+XRvj5KYCmNRh6mKqVRqWpzlmBVkSKUtVGdp0zTL036zGMba0+FbNt7RWhG
	 LqaVS7Kz/7UIQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Claire Chang <tientzu@chromium.org>,
	Alain Michaud <alainm@chromium.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] Bluetooth: Move force_bredr_smp debugfs into hci_debugfs_create_bredr
Date: Tue, 10 Nov 2026 11:07:39 -0500
Message-ID: <20261110160710.2356064-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062317-failed-5.10-2a3e2287877b@kernel.org>
References: <20261107062317-failed-5.10-2a3e2287877b@kernel.org>
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

From: Claire Chang <tientzu@chromium.org>

[ Upstream commit 82493316507a720b6faa2ec23971c0ca89c6dcb0 ]

Avoid multiple attempts to create the debugfs entry, force_bredr_smp,
by moving it from the SMP registration to the BR/EDR controller init
section. hci_debugfs_create_bredr is only called when HCI_SETUP and
HCI_CONFIG is not set.

Signed-off-by: Claire Chang <tientzu@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Stable-dep-of: 2a3e2287877b ("Bluetooth: hci_debugfs: Pin module for debugfs file operations")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_debugfs.c | 50 +++++++++++++++++++++++++++++++++++++
 net/bluetooth/smp.c         | 44 ++------------------------------
 net/bluetooth/smp.h         |  2 ++
 3 files changed, 54 insertions(+), 42 deletions(-)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index a1f6e6c9dd4f3..1192280031685 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -498,6 +498,45 @@ static int auto_accept_delay_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(auto_accept_delay_fops, auto_accept_delay_get,
 			auto_accept_delay_set, "%llu\n");
 
+static ssize_t force_bredr_smp_read(struct file *file,
+				    char __user *user_buf,
+				    size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	char buf[3];
+
+	buf[0] = hci_dev_test_flag(hdev, HCI_FORCE_BREDR_SMP) ? 'Y' : 'N';
+	buf[1] = '\n';
+	buf[2] = '\0';
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static ssize_t force_bredr_smp_write(struct file *file,
+				     const char __user *user_buf,
+				     size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	bool enable;
+	int err;
+
+	err = kstrtobool_from_user(user_buf, count, &enable);
+	if (err)
+		return err;
+
+	err = smp_force_bredr(hdev, enable);
+	if (err)
+		return err;
+
+	return count;
+}
+
+static const struct file_operations force_bredr_smp_fops = {
+	.open		= simple_open,
+	.read		= force_bredr_smp_read,
+	.write		= force_bredr_smp_write,
+	.llseek		= default_llseek,
+};
+
 static int idle_timeout_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
@@ -597,6 +636,17 @@ void hci_debugfs_create_bredr(struct hci_dev *hdev)
 	debugfs_create_file("voice_setting", 0444, hdev->debugfs, hdev,
 			    &voice_setting_fops);
 
+	/* If the controller does not support BR/EDR Secure Connections
+	 * feature, then the BR/EDR SMP channel shall not be present.
+	 *
+	 * To test this with Bluetooth 4.0 controllers, create a debugfs
+	 * switch that allows forcing BR/EDR SMP support and accepting
+	 * cross-transport pairing on non-AES encrypted connections.
+	 */
+	if (!lmp_sc_capable(hdev))
+		debugfs_create_file("force_bredr_smp", 0644, hdev->debugfs,
+				    hdev, &force_bredr_smp_fops);
+
 	if (lmp_ssp_capable(hdev)) {
 		debugfs_create_file("ssp_debug_mode", 0444, hdev->debugfs,
 				    hdev, &ssp_debug_mode_fops);
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 5466b1f1add9e..eefc9aa479f08 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3388,31 +3388,8 @@ static void smp_del_chan(struct l2cap_chan *chan)
 	l2cap_chan_put(chan);
 }
 
-static ssize_t force_bredr_smp_read(struct file *file,
-				    char __user *user_buf,
-				    size_t count, loff_t *ppos)
+int smp_force_bredr(struct hci_dev *hdev, bool enable)
 {
-	struct hci_dev *hdev = file->private_data;
-	char buf[3];
-
-	buf[0] = hci_dev_test_flag(hdev, HCI_FORCE_BREDR_SMP) ? 'Y': 'N';
-	buf[1] = '\n';
-	buf[2] = '\0';
-	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
-}
-
-static ssize_t force_bredr_smp_write(struct file *file,
-				     const char __user *user_buf,
-				     size_t count, loff_t *ppos)
-{
-	struct hci_dev *hdev = file->private_data;
-	bool enable;
-	int err;
-
-	err = kstrtobool_from_user(user_buf, count, &enable);
-	if (err)
-		return err;
-
 	if (enable == hci_dev_test_flag(hdev, HCI_FORCE_BREDR_SMP))
 		return -EALREADY;
 
@@ -3434,16 +3411,9 @@ static ssize_t force_bredr_smp_write(struct file *file,
 
 	hci_dev_change_flag(hdev, HCI_FORCE_BREDR_SMP);
 
-	return count;
+	return 0;
 }
 
-static const struct file_operations force_bredr_smp_fops = {
-	.open		= simple_open,
-	.read		= force_bredr_smp_read,
-	.write		= force_bredr_smp_write,
-	.llseek		= default_llseek,
-};
-
 int smp_register(struct hci_dev *hdev)
 {
 	struct l2cap_chan *chan;
@@ -3468,17 +3438,7 @@ int smp_register(struct hci_dev *hdev)
 
 	hdev->smp_data = chan;
 
-	/* If the controller does not support BR/EDR Secure Connections
-	 * feature, then the BR/EDR SMP channel shall not be present.
-	 *
-	 * To test this with Bluetooth 4.0 controllers, create a debugfs
-	 * switch that allows forcing BR/EDR SMP support and accepting
-	 * cross-transport pairing on non-AES encrypted connections.
-	 */
 	if (!lmp_sc_capable(hdev)) {
-		debugfs_create_file("force_bredr_smp", 0644, hdev->debugfs,
-				    hdev, &force_bredr_smp_fops);
-
 		/* Flag can be already set here (due to power toggle) */
 		if (!hci_dev_test_flag(hdev, HCI_FORCE_BREDR_SMP))
 			return 0;
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index bad594642a53d..c5da53dfab04f 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -194,6 +194,8 @@ bool smp_irk_matches(struct hci_dev *hdev, const u8 irk[16],
 int smp_generate_rpa(struct hci_dev *hdev, const u8 irk[16], bdaddr_t *rpa);
 int smp_generate_oob(struct hci_dev *hdev, u8 hash[16], u8 rand[16]);
 
+int smp_force_bredr(struct hci_dev *hdev, bool enable);
+
 int smp_register(struct hci_dev *hdev);
 void smp_unregister(struct hci_dev *hdev);
 
-- 
2.53.0

