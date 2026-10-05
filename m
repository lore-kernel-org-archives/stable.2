Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1EA46D092
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791197967; cv=none; b=P3wWOk3iN+qkBBpHBUILDyBCrzxas4IBTOikjUc6QRHK6XjYtwFgYxuKW6A/Uzyxb8oWiY1ymdjcccRKwWMQX9kMDej5pTT16HB+gCvFNvPK0auoqsjnLQ+5TnkqTs0kmFkM6fiKIybOFeCxtQ1aaevCBrsTLSItSFw+Glz7b3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791197967; c=relaxed/simple;
	bh=byoWAlepoBdh0SdARTA6Jo9AjYump2cMvRd4Ocn2eaM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=s/hldk4rmLnp3joSy1mppZr+ALrWqutvrxx8hDuwEs5yeSrshM5ikykgc07JONVxDbAFGQtMgGZYcus+lHOWN4Elq/kqe3ssxtZ3LGYv2YIF3k99kVpuP5U53R+vBKHy4B8l0ERVLVaF+T3iGeD8OXKEP6g7aBuNYX3ek/iLOvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bu+/rJ62; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bu+/rJ62"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253FB1F000FF;
	Mon,  5 Oct 2026 10:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791197965;
	bh=8kGHUR7rw5nQCcgMpPl8i33KEm4dxYQoIo7RYF36eA0=;
	h=Subject:To:Cc:From:Date;
	b=bu+/rJ62Fo3ee96w/8UxPIoUcDM1ZiiyG6BOjsIr+tPPXNOxZxBM9Gwsu0sNiG8T7
	 lz1p4CJJczQSwiq6OXUV/5Mn2Vo0ob+0zarn0J63N18rSzDByfr2d+Zf0BVQfTHHYR
	 10H1wxTLGz92fu4W56oOis7iTz6dbJmofGxlecTI=
Subject: FAILED: patch "[PATCH] Bluetooth: hci_core: Serialize SCO and ISO scheduling with" failed to apply to 5.10-stable tree
To: nicoyip.dev@gmail.com,luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 12:56:11 +0200
Message-ID: <2026100511-sympathy-unretired-4d67@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 848a7a91c7f03675d3bd8db6f7721cbf9cb50e21
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100511-sympathy-unretired-4d67@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 848a7a91c7f03675d3bd8db6f7721cbf9cb50e21 Mon Sep 17 00:00:00 2001
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Sun, 27 Sep 2026 01:04:03 +0800
Subject: [PATCH] Bluetooth: hci_core: Serialize SCO and ISO scheduling with
 teardown

hci_low_sent() selects a connection under RCU but drops the read lock
before calculating its quota and returning it to the scheduler. The
connection is then used without lifetime protection by hci_sched_iso()
and hci_sched_sco().

After the TX worker drops the RCU read lock, hci_abort_conn_sync() on
hdev->req_workqueue can remove the connection from the hash, complete
synchronize_rcu(), purge its queues and release it. The TX worker on
hdev->workqueue can then access the freed connection in hci_quote_sent()
or while dequeuing packets and updating conn->sent.

KASAN reported:

  BUG: KASAN: slab-use-after-free in hci_low_sent+0x730/0x840
  Workqueue: hci0 hci_tx_work
  Call Trace:
   hci_low_sent+0x730/0x840
   hci_sched_iso+0x25e/0x4d0
   hci_tx_work+0x239/0xcb0

  Allocated by task 93:
   __hci_conn_add+0x16f/0x1b40
   hci_bind_bis+0x782/0x17b0
   hci_connect_bis+0xa0/0x510
   iso_sock_connect+0x589/0x1050

  Freed by task 88:
   kfree+0x131/0x3c0
   device_release+0xc8/0x240
   kobject_put+0x14d/0x280
   hci_conn_del+0x55a/0xe80
   hci_disconnect_sync+0x156/0x180
   hci_abort_conn_sync+0x3e7/0x940
   hci_cmd_sync_work+0x13c/0x290

Hold hci_dev_lock() across connection selection and transmission in both
SCO and ISO scheduling, serializing them with connection teardown. This
also prevents queuing completion timestamps after the connection queues
have been purged. Extending RCU across transmission would be unsafe
because the transmit path can sleep. Keep the ISO timeout check outside
the mutex since hci_link_tx_to() takes it itself.

The preceding channel fix already holds this mutex in the ACL and LE
schedulers, which call the SCO scheduler between packets. Move the SCO
body to __hci_sched_sco(), assert that its caller holds the mutex, and
use it directly from these locked paths. Keep a locking hci_sched_sco()
wrapper for the direct calls from hci_tx_work(). This avoids recursively
acquiring the device mutex while preserving the scheduling order.

Remove the obsolete claim that connection removal disables TX.

Fixes: bf4c63252490 ("Bluetooth: convert conn hash to RCU")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a92ab4db4676..2076689eb302 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3418,9 +3418,6 @@ static struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type,
 	struct hci_conn *conn = NULL, *c;
 	unsigned int num = 0, min = ~0;
 
-	/* We don't have to lock device here. Connections are always
-	 * added and removed with TX task disabled. */
-
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
@@ -3625,13 +3622,15 @@ static void __check_timeout(struct hci_dev *hdev, unsigned int cnt, u8 type)
 }
 
 /* Schedule SCO */
-static void hci_sched_sco(struct hci_dev *hdev, __u8 type)
+static void __hci_sched_sco(struct hci_dev *hdev, __u8 type)
 {
 	struct hci_conn *conn;
 	struct sk_buff *skb;
 	int quote, *cnt;
 	unsigned int pkts = hdev->sco_pkts;
 
+	lockdep_assert_held(&hdev->lock);
+
 	bt_dev_dbg(hdev, "type %u", type);
 
 	if (!hci_conn_num(hdev, type) || !pkts)
@@ -3666,6 +3665,13 @@ static void hci_sched_sco(struct hci_dev *hdev, __u8 type)
 		queue_work(hdev->workqueue, &hdev->tx_work);
 }
 
+static void hci_sched_sco(struct hci_dev *hdev, __u8 type)
+{
+	hci_dev_lock(hdev);
+	__hci_sched_sco(hdev, type);
+	hci_dev_unlock(hdev);
+}
+
 static void hci_sched_acl_pkt(struct hci_dev *hdev)
 {
 	unsigned int cnt = hdev->acl_cnt;
@@ -3701,8 +3707,8 @@ static void hci_sched_acl_pkt(struct hci_dev *hdev)
 			chan->conn->sent++;
 
 			/* Send pending SCO packets right away */
-			hci_sched_sco(hdev, SCO_LINK);
-			hci_sched_sco(hdev, ESCO_LINK);
+			__hci_sched_sco(hdev, SCO_LINK);
+			__hci_sched_sco(hdev, ESCO_LINK);
 		}
 	}
 
@@ -3761,8 +3767,8 @@ static void hci_sched_le(struct hci_dev *hdev)
 			chan->conn->sent++;
 
 			/* Send pending SCO packets right away */
-			hci_sched_sco(hdev, SCO_LINK);
-			hci_sched_sco(hdev, ESCO_LINK);
+			__hci_sched_sco(hdev, SCO_LINK);
+			__hci_sched_sco(hdev, ESCO_LINK);
 		}
 	}
 
@@ -3788,6 +3794,8 @@ static void hci_sched_iso(struct hci_dev *hdev, __u8 type)
 
 	__check_timeout(hdev, *cnt, type);
 
+	hci_dev_lock(hdev);
+
 	while (*cnt && (conn = hci_low_sent(hdev, type, &quote))) {
 		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
 			BT_DBG("skb %p len %d", skb, skb->len);
@@ -3801,6 +3809,8 @@ static void hci_sched_iso(struct hci_dev *hdev, __u8 type)
 			(*cnt)--;
 		}
 	}
+
+	hci_dev_unlock(hdev);
 }
 
 static void hci_tx_work(struct work_struct *work)

