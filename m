Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7506749BD83
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818767; cv=none; b=Fmg/kXoA85ds2LkEe/8Te4OPLUvdy2BFFdiyHwBvfZgzMNpMdHHUhckiLxj/sDLDM/FKilnLaiybcjS2e3B9gNrFuaY0nb1J3wtwROwIo39oUAwkja//M8mvdtFbMOXUH+gnyibxR0ObYUjZmdH/N60jJyICkU53IVZztnAngxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818767; c=relaxed/simple;
	bh=zu7/SJWi5OEARi5wySWhDnCzd+wwJFekJn+tVBdrDMU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=W5NFIbK3vMAIfJRgSbrhiBFqORq+ksALdEFH+FGQ5YUwOqswoHiO78zRzZtX7LHbokWWVk09avgGb7rY5CDHGxQWmBpvXV0DDoOxm6L/pgv0FGRyu62JBFu/2KpC/bEGOxoThmFIGd/b5rS5HkXaHWN3ITi1mITZRrv0IXUJJE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=whXHkqmG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="whXHkqmG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350331F0089B;
	Mon, 12 Oct 2026 15:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791818761;
	bh=h671Ri1dzv7kxxEhrxRj8k+0xCPHCA/GI9re0rkgNS8=;
	h=Subject:To:Cc:From:Date;
	b=whXHkqmGhGbQfatRco7ch2hnQqhxpl4Buqdfb2RCgxFstzhf45a51oqEQTE/oO2xl
	 7/ajhLDPit4pBV0do+GGyXYgBeeXHoDjGI+pVM2JW2tMuzXYuUr2qERAnuztgeUDx2
	 lK4Lrnm37OHQQJXKxAtU8L+6Sd9YKeOJOre6zeco=
Subject: FAILED: patch "[PATCH] Bluetooth: hci_sync: Fix command skb lifetime during scan" failed to apply to 6.12-stable tree
To: nicoyip.dev@gmail.com,luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 17:26:06 +0200
Message-ID: <2026101206-hurray-deftly-6159@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 9af12272061d206af8bc3e40215cb694421ab73a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101206-hurray-deftly-6159@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9af12272061d206af8bc3e40215cb694421ab73a Mon Sep 17 00:00:00 2001
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Mon, 5 Oct 2026 00:26:12 +0800
Subject: [PATCH] Bluetooth: hci_sync: Fix command skb lifetime during scan
 setup

During PA sync scan setup, hci_le_set_ext_scan_param_sync() gets the
address used for the PA_LINK lookup from hci_sent_cmd_data(). The
returned pointer borrows storage from sent_cmd or req_skb, without
holding a reference to either skb.

The scan worker runs on req_workqueue while hci_cmd_work() runs on the
separate device workqueue. After the scan worker loads sent_cmd, the
command worker can free and replace it before hci_sent_cmd_data()
dereferences the skb. The command payload can also be freed between
returning from the helper and comparing the address. The connection
lookup's RCU critical section does not protect the command skb.

KASAN reported:

  BUG: KASAN: slab-use-after-free in hci_sent_cmd_data+0x27c/0x2f0
  Workqueue: hci0 hci_cmd_sync_work
  Call Trace:
   hci_sent_cmd_data+0x27c/0x2f0
   hci_le_set_scan_param_sync+0x43a/0x850
   hci_passive_scan_sync+0xb09/0x1460
   hci_update_passive_scan_sync+0x47c/0x6e0
   hci_le_pa_create_sync+0x200/0xa70
   hci_cmd_sync_work+0x13c/0x290

  Allocated by task 95:
   skb_clone+0x13f/0x340
   hci_cmd_work+0x2a9/0x7e0

  Freed by task 95:
   kmem_cache_free+0xba/0x3a0
   hci_cmd_work+0x29c/0x7e0

Use hdev->lock to serialize the address snapshot with sent_cmd
replacement. Protect req_skb replacement and completion cleanup with
the same lock because the helper falls back to that skb. Copy the
address before releasing the lock and use the copy for the existing
RCU-protected connection lookup. Release the mutex before sending or
waiting for commands, preserving the lookup and completion ordering.

Fixes: 22cbf4f84c00 ("Bluetooth: hci_sync: Use QoS to determine which PHY to scan")
Cc: stable@vger.kernel.org
Assisted-by: GPT-6 Astra
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2076689eb302..74d9865e08c2 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4115,9 +4115,11 @@ static int hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 
 	bt_dev_dbg(hdev, "skb %p", skb);
 
+	hci_dev_lock(hdev);
 	kfree_skb(hdev->sent_cmd);
 
 	hdev->sent_cmd = skb_clone(skb, GFP_KERNEL);
+	hci_dev_unlock(hdev);
 	if (!hdev->sent_cmd) {
 		skb_queue_head(&hdev->cmd_q, skb);
 		queue_work(hdev->workqueue, &hdev->cmd_work);
@@ -4138,8 +4140,10 @@ static int hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (READ_ONCE(hdev->req_status) == HCI_REQ_PEND &&
 	    !hci_dev_test_and_set_flag(hdev, HCI_CMD_PENDING)) {
+		hci_dev_lock(hdev);
 		kfree_skb(hdev->req_skb);
 		hdev->req_skb = skb_get(hdev->sent_cmd);
+		hci_dev_unlock(hdev);
 	}
 
 	return err;
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index c01c8b58d9e8..a92a81846e9d 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -32,8 +32,10 @@ static void hci_cmd_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode,
 	WRITE_ONCE(hdev->req_status, HCI_REQ_DONE);
 
 	/* Free the request command so it is not used as response */
+	hci_dev_lock(hdev);
 	kfree_skb(hdev->req_skb);
 	hdev->req_skb = NULL;
+	hci_dev_unlock(hdev);
 
 	if (skb) {
 		struct sock *sk = hci_skb_sk(skb);
@@ -3064,15 +3066,21 @@ static int hci_le_set_ext_scan_param_sync(struct hci_dev *hdev, u8 type,
 	 */
 	if (hci_dev_test_flag(hdev, HCI_PA_SYNC)) {
 		struct hci_cp_le_add_to_accept_list *sent;
+		bdaddr_t bdaddr;
 
+		hci_dev_lock(hdev);
 		sent = hci_sent_cmd_data(hdev, HCI_OP_LE_ADD_TO_ACCEPT_LIST);
+		if (sent)
+			bacpy(&bdaddr, &sent->bdaddr);
+		hci_dev_unlock(hdev);
+
 		if (sent) {
 			struct hci_conn *conn;
 
 			rcu_read_lock();
 
 			conn = hci_conn_hash_lookup_ba(hdev, PA_LINK,
-						       &sent->bdaddr);
+						       &bdaddr);
 			if (conn) {
 				struct bt_iso_qos *qos = &conn->iso_qos;
 

