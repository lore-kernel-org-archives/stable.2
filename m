Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EE02941A
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 00:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791245417; cv=none; b=bS7DsI9q+QjfsJ1U+eSfVtnVqtPJqEUx0ggjxN6uOhwdgUYQu1fHx3Tiwd3sWJ/wVooFzD1gbZCPckux7qRhlCVwKY41JCQ6Wuo7MnNc7W8GscNAtarva0zd4f+NNqnj7DKtYcA0mCEZBIRmLdkVgC5Kzak3QQ5Z4ZIyALbNmWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791245417; c=relaxed/simple;
	bh=qqmpErNBhTM2LJmL3U54ic4WSenIkmosxw4M7bm7ID0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uyBOSBXIDiEiuUwCyxENwW/g4qCkNBQ3G15LuQ8IA2CBumbNYbfSSbBY6MuNJ6bESkxEav9B5d9YEvY2CgYnsqY25lmtvcXFw4kTyNmrvfIfi6dgwZKQLxjmeIOvUbmW170t8e5j/FP4JweCo01aITTW+WsjiXiZ9ZowBdEOKro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GseXlJqi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GseXlJqi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F9D1F000FF;
	Tue,  6 Oct 2026 00:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791245416;
	bh=mgQV0yIIh1cDHUGTLn0hJVwR2Yc9WigRWSufHoqCmig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GseXlJqi9pGNCIGoN1edmEWNhQCES3TG+VUsIjgw2I0eCC9zSTy5H2BGpRUoQ9wAZ
	 1HHHrTTeM6/CqXRNhcZmb/xeI1OYpp41EeCm+YNyeWpzWh9gFLhOSu0N/EHVdYPDin
	 Zj93g+VMSAgJsIKb8ntjMbpW8blS7V0PE6HUjXaSDA/hiSIxQjXqohGkvbv3yf4PgF
	 juoN/M81sD3bjsTTZ+w152jOFGrKfrEO5OXBwOnGE2UW7KfMQ/+zzti/m+7N23orKx
	 yA98CFovl3V/KC4WxtBZ8BYrOdctsJWzriWpa0Cv2zZHf1UXsTD9dK1nS0EzCG1l7Q
	 Lpl2LaAypbwCA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chengfeng Ye <nicoyip.dev@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] Bluetooth: Serialize SMP remote OOB data access
Date: Mon,  5 Oct 2026 20:10:12 -0400
Message-ID: <20261006000909.3554920-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100541-spotted-comma-6552@gregkh>
References: <2026100541-spotted-comma-6552@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengfeng Ye <nicoyip.dev@gmail.com>

[ Upstream commit 81a2345f1984f0b36d3226571bc196316a01b648 ]

build_pairing_cmd() looks up remote OOB data and copies its contents
without holding hdev->lock, which serializes the list's writers. After
SMP finds an entry, a concurrent management Remove Remote OOB Data
command can unlink and free it before SMP reads its present flag or
copies its random and confirmation values. Removal can also invalidate
an entry while the lookup is still traversing the list.

KASAN reported:

  BUG: KASAN: slab-use-after-free in build_pairing_cmd+0x948/0x9b0
  Call Trace:
   build_pairing_cmd+0x948/0x9b0
   smp_recv_cb+0x459f/0x8110
   l2cap_recv_frame+0xf14/0x9190
   l2cap_recv_acldata+0xa64/0xd40
   hci_rx_work+0x4ca/0x730

  Allocated by task 87:
   hci_add_remote_oob_data+0x11d/0x530
   add_remote_oob_data+0x282/0x400
   hci_sock_sendmsg+0x1033/0x1ea0

  Freed by task 93:
   hci_remote_oob_data_clear+0x108/0x1c0
   remove_remote_oob_data+0x198/0x220
   hci_sock_sendmsg+0x1033/0x1ea0

Taking hdev->lock in build_pairing_cmd() would recurse for callers that
already hold it and invert the device-to-L2CAP lock order on the receive
path. Add a per-device remote_oob_lock instead, held across the SMP
lookup and copies and by the add, remove and clear helpers. Cover
initialization and in-place updates as well, so SMP cannot read partially
initialized or updated OOB values. Release the mutex on allocation
failure, preserving the existing error return.

The new critical sections acquire no device, connection or channel locks.
Writers retain their existing hdev->lock protection, which continues to
serialize the other readers without changing their locking or behavior.

Link: https://lore.kernel.org/r/00660cd3-7d71-13a4-f617-229e6defb701@gmail.com
Fixes: 02b05bd8b0a6 ("Bluetooth: Set SMP OOB flag if OOB data is available")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[ sashal: Retained kmalloc(sizeof(*data), GFP_KERNEL) instead of kmalloc_obj(*data). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 12 +++++++++++-
 net/bluetooth/smp.c              |  2 ++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c43c06a1b78e9..4dc8e6c39c01e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -563,6 +563,7 @@ struct hci_dev {
 	struct list_head	link_keys;
 	struct list_head	long_term_keys;
 	struct list_head	identity_resolving_keys;
+	struct mutex		remote_oob_lock;
 	struct list_head	remote_oob_data;
 	struct list_head	le_accept_list;
 	struct list_head	le_resolv_list;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6a2078fc283c5..90287b7b62a4a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1525,8 +1525,10 @@ int hci_remove_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
 
 	BT_DBG("%s removing %pMR (%u)", hdev->name, bdaddr, bdaddr_type);
 
+	mutex_lock(&hdev->remote_oob_lock);
 	list_del(&data->list);
 	kfree(data);
+	mutex_unlock(&hdev->remote_oob_lock);
 
 	return 0;
 }
@@ -1535,10 +1537,12 @@ void hci_remote_oob_data_clear(struct hci_dev *hdev)
 {
 	struct oob_data *data, *n;
 
+	mutex_lock(&hdev->remote_oob_lock);
 	list_for_each_entry_safe(data, n, &hdev->remote_oob_data, list) {
 		list_del(&data->list);
 		kfree(data);
 	}
+	mutex_unlock(&hdev->remote_oob_lock);
 }
 
 int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
@@ -1547,11 +1551,14 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
 {
 	struct oob_data *data;
 
+	mutex_lock(&hdev->remote_oob_lock);
 	data = hci_find_remote_oob_data(hdev, bdaddr, bdaddr_type);
 	if (!data) {
 		data = kmalloc(sizeof(*data), GFP_KERNEL);
-		if (!data)
+		if (!data) {
+			mutex_unlock(&hdev->remote_oob_lock);
 			return -ENOMEM;
+		}
 
 		bacpy(&data->bdaddr, bdaddr);
 		data->bdaddr_type = bdaddr_type;
@@ -1584,6 +1591,8 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
 
 	BT_DBG("%s for %pMR", hdev->name, bdaddr);
 
+	mutex_unlock(&hdev->remote_oob_lock);
+
 	return 0;
 }
 
@@ -2521,6 +2530,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	mutex_init(&hdev->lock);
 	mutex_init(&hdev->req_lock);
 	mutex_init(&hdev->mgmt_pending_lock);
+	mutex_init(&hdev->remote_oob_lock);
 
 	ida_init(&hdev->unset_handle_ida);
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 51e0545a9e240..81bf67af87fcb 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -683,6 +683,7 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 		else
 			bdaddr_type = BDADDR_LE_RANDOM;
 
+		mutex_lock(&hdev->remote_oob_lock);
 		oob_data = hci_find_remote_oob_data(hdev, &hcon->dst,
 						    bdaddr_type);
 		if (oob_data && oob_data->present) {
@@ -693,6 +694,7 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 			SMP_DBG("OOB Remote Confirmation: %16phN", smp->pcnf);
 			SMP_DBG("OOB Remote Random: %16phN", smp->rr);
 		}
+		mutex_unlock(&hdev->remote_oob_lock);
 
 	} else {
 		authreq &= ~SMP_AUTH_SC;
-- 
2.53.0

