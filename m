Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D129E43E9FC
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791197947; cv=none; b=m3pJgvRsoloVeBhZAgijPK2ceT3pYel+NWfEN8D/pQCX1Z5CdXqFsCtn72JLhLcH9kCKdLwwMsHKtgLBIBm/C/dxPumf4FAeiZ1k9B2UiPsZEUDM9v1LYcQ1HCNkFnIWD/ttBzJp/GZgLXCewh5RPM9f9Wb977g/nZ3aLVc8oFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791197947; c=relaxed/simple;
	bh=cJdv2ZA12Ly2mbwk82+z8OoINFy7nbHVxFUTCEtiK1I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VA4y5YyAdpor4iXAfI2ACGOiY6KjWT8tEgDLoWs0lB/+9yTRaz0UZ+YVD47ToY7OoF7awORSQJT2ehru9yPJdjEdkxrnTCVLWSt3ZH6kxR8RzY9obB4LCf4Fc4bGc7f++4gI88WjKvC03TMD6TCNRvceE5rMQYNErZJ2Z4kJlS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MRfbqSLP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MRfbqSLP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08DCC1F000FF;
	Mon,  5 Oct 2026 10:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791197945;
	bh=kQIeZQAlV7m2sgWIPTHq8hq0MEoL0YusPMH6kcn8JXs=;
	h=Subject:To:Cc:From:Date;
	b=MRfbqSLP/UJj8Yo6wI0VGY3UPuEEN4SW4E5KnIrl4c4ldPnbi6osAtCS54PBz2mmy
	 ghNI7XkYteproijc5Ld+tSfx3aufAtRCYHQZbnw+LTmUkN+TAdemJTEaEdG+LyFjDI
	 0xItzOCY28BJlODEx4TiHdfCO2kSKzuHbJ2JdilE=
Subject: FAILED: patch "[PATCH] Bluetooth: Serialize SMP remote OOB data access" failed to apply to 6.6-stable tree
To: nicoyip.dev@gmail.com,luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 12:53:42 +0200
Message-ID: <2026100542-breezy-handwrite-680e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 81a2345f1984f0b36d3226571bc196316a01b648
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100542-breezy-handwrite-680e@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 81a2345f1984f0b36d3226571bc196316a01b648 Mon Sep 17 00:00:00 2001
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Sun, 27 Sep 2026 14:42:50 +0800
Subject: [PATCH] Bluetooth: Serialize SMP remote OOB data access

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

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ca77ad0d9393..fa2a367731b5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -562,6 +562,7 @@ struct hci_dev {
 	struct list_head	link_keys;
 	struct list_head	long_term_keys;
 	struct list_head	identity_resolving_keys;
+	struct mutex		remote_oob_lock;
 	struct list_head	remote_oob_data;
 	struct list_head	le_accept_list;
 	struct list_head	le_resolv_list;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5d1cdb1e7d8b..bc662e24a8e4 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1489,8 +1489,10 @@ int hci_remove_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
 
 	BT_DBG("%s removing %pMR (%u)", hdev->name, bdaddr, bdaddr_type);
 
+	mutex_lock(&hdev->remote_oob_lock);
 	list_del(&data->list);
 	kfree(data);
+	mutex_unlock(&hdev->remote_oob_lock);
 
 	return 0;
 }
@@ -1499,10 +1501,12 @@ void hci_remote_oob_data_clear(struct hci_dev *hdev)
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
@@ -1511,11 +1515,14 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
 {
 	struct oob_data *data;
 
+	mutex_lock(&hdev->remote_oob_lock);
 	data = hci_find_remote_oob_data(hdev, bdaddr, bdaddr_type);
 	if (!data) {
 		data = kmalloc_obj(*data);
-		if (!data)
+		if (!data) {
+			mutex_unlock(&hdev->remote_oob_lock);
 			return -ENOMEM;
+		}
 
 		bacpy(&data->bdaddr, bdaddr);
 		data->bdaddr_type = bdaddr_type;
@@ -1548,6 +1555,8 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
 
 	BT_DBG("%s for %pMR", hdev->name, bdaddr);
 
+	mutex_unlock(&hdev->remote_oob_lock);
+
 	return 0;
 }
 
@@ -2485,6 +2494,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	mutex_init(&hdev->lock);
 	mutex_init(&hdev->req_lock);
 	mutex_init(&hdev->mgmt_pending_lock);
+	mutex_init(&hdev->remote_oob_lock);
 
 	ida_init(&hdev->unset_handle_ida);
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index d23f9d0729c4..2df303f6a38f 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -662,6 +662,7 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 		else
 			bdaddr_type = BDADDR_LE_RANDOM;
 
+		mutex_lock(&hdev->remote_oob_lock);
 		oob_data = hci_find_remote_oob_data(hdev, &hcon->dst,
 						    bdaddr_type);
 		if (oob_data && oob_data->present) {
@@ -672,6 +673,7 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 			SMP_DBG("OOB Remote Confirmation: %16phN", smp->pcnf);
 			SMP_DBG("OOB Remote Random: %16phN", smp->rr);
 		}
+		mutex_unlock(&hdev->remote_oob_lock);
 
 	} else {
 		authreq &= ~SMP_AUTH_SC;

