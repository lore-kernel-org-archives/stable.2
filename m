Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBED36A342
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791197955; cv=none; b=Kw9oaKSRr/IbZqGA6adhT7vvdDRcu0t50IkwEK896St/UvlyScCgyXUrPbzEIM/pxQZb82hG9pKiZCL/WalOLKrSaFZ7GGfofyf+A6gParUECjP1sFXRvJ01h1b4l9/RiveDHraT9Rx2+SASc5RFq/qWUZurnV0g7y4yoHITf1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791197955; c=relaxed/simple;
	bh=3PJSV19eeEAnbZH73Gz9pUkv7UbDioNYSLqPIa8tZ48=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=e8zBF7qY0y4un5kz/36w23QhRXv1qfCneNNdBmXmJwWTs8v5fWOZsDeEG9Co7up453jZqI4CEhvM3CTFo73fkbU6fNun448+tbHvf6oIqUxn76Gve/FVr8TKo1TuFvJ6KGgQ1OkYhlLc+dB9NCIzRHNJKW/9Qw6LzYrDBaZmWAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=12i4NjT1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="12i4NjT1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F50A1F000FF;
	Mon,  5 Oct 2026 10:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791197954;
	bh=HEavGFoTeZrt2MyXPEcMjZqxkHngAGNjI8a5nhMqP44=;
	h=Subject:To:Cc:From:Date;
	b=12i4NjT1W0UvT6h7IEKbbtEUvHdq7OCkiB/uhtVdVFIaRciiL4uSCKHQI1CPyVJ9F
	 BGuKbXt8QF3I3sYVUBXGGQ1gbsOw1vZ8+ljHXBeKLIOcgthNNlhQbx/jw15Sr5Uyst
	 IuBqnX1ciyqWCfUPkcZprE2vOsdrW9v+Sn+Ejths=
Subject: FAILED: patch "[PATCH] Bluetooth: hci_sync: Fix inquiry cache use-after-free" failed to apply to 6.1-stable tree
To: nicoyip.dev@gmail.com,luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 12:54:41 +0200
Message-ID: <2026100541-valid-olive-13c3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8ed67535fdff40ca652bcd4ac7da68d11d01bd34
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100541-valid-olive-13c3@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8ed67535fdff40ca652bcd4ac7da68d11d01bd34 Mon Sep 17 00:00:00 2001
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Sun, 27 Sep 2026 01:28:31 +0800
Subject: [PATCH] Bluetooth: hci_sync: Fix inquiry cache use-after-free

The sync command worker holds hdev->req_lock, but inquiry-cache updates
and flushes use hdev->lock. Both hci_acl_create_conn_sync() and
hci_stop_discovery_sync() look up entries and read their fields without
taking hdev->lock.

After either lookup returns, a concurrent HCIINQUIRY ioctl can acquire
hdev->lock and flush the cache, freeing the entry. The worker then reads
the freed entry while preparing a create-connection or remote-name-cancel
command. The list traversal also races with cache updates and removal.

KASAN reported these accesses:

  BUG: KASAN: slab-use-after-free in hci_acl_create_conn_sync+0x5f1/0x650
  Workqueue: hci0 hci_cmd_sync_work
  Call Trace:
   hci_acl_create_conn_sync+0x5f1/0x650
   hci_cmd_sync_work+0x13c/0x290

  Allocated by task 90:
   hci_inquiry_cache_update+0x3e6/0x7d0
   hci_inquiry_result_evt+0x3cb/0x560

  Freed by task 93:
   hci_inquiry_cache_flush+0x111/0x2b0
   hci_inquiry+0x2f2/0x780
   hci_sock_ioctl+0x269/0x5f0

  BUG: KASAN: slab-use-after-free in hci_stop_discovery_sync+0x3b1/0x3c0
  Workqueue: hci0 hci_cmd_sync_work
  Call Trace:
   hci_stop_discovery_sync+0x3b1/0x3c0
   hci_cmd_sync_work+0x173/0x300

  Allocated by task 86:
   hci_inquiry_cache_update+0x483/0x940
   hci_inquiry_result_evt+0x3cb/0x560

  Freed by task 91:
   hci_inquiry_cache_flush+0x13e/0x2f0
   hci_inquiry+0x2f2/0x780
   hci_sock_ioctl+0x269/0x5f0

Hold hdev->lock across each lookup and all reads from its result. Copy the
remote address before unlocking so discovery cancellation does not retain
a cache entry pointer. Release the lock before sending synchronous HCI
commands, since their completion handlers may need the same lock.

Fixes: cf75ad8b41d2 ("Bluetooth: hci_sync: Convert MGMT_SET_POWERED")
Fixes: 45340097ce6e ("Bluetooth: hci_conn: Only do ACL connections sequentially")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index e41fc1427d34..c01c8b58d9e8 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5770,6 +5770,7 @@ int hci_stop_discovery_sync(struct hci_dev *hdev)
 {
 	struct discovery_state *d = &hdev->discovery;
 	struct inquiry_entry *e;
+	bdaddr_t addr;
 	int err;
 
 	bt_dev_dbg(hdev, "state %u", hdev->discovery.state);
@@ -5805,15 +5806,21 @@ int hci_stop_discovery_sync(struct hci_dev *hdev)
 		return 0;
 
 	if (d->state == DISCOVERY_RESOLVING || d->state == DISCOVERY_STOPPING) {
+		hci_dev_lock(hdev);
 		e = hci_inquiry_cache_lookup_resolve(hdev, BDADDR_ANY,
 						     NAME_PENDING);
-		if (!e)
+		if (!e) {
+			hci_dev_unlock(hdev);
 			return 0;
+		}
+
+		bacpy(&addr, &e->data.bdaddr);
+		hci_dev_unlock(hdev);
 
 		/* Ignore cancel errors since it should interfere with stopping
 		 * of the discovery.
 		 */
-		hci_remote_name_cancel_sync(hdev, &e->data.bdaddr);
+		hci_remote_name_cancel_sync(hdev, &addr);
 	}
 
 	return 0;
@@ -7242,6 +7249,7 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
 	bacpy(&cp.bdaddr, &conn->dst);
 	cp.pscan_rep_mode = 0x02;
 
+	hci_dev_lock(hdev);
 	ie = hci_inquiry_cache_lookup(hdev, &conn->dst);
 	if (ie) {
 		if (inquiry_entry_age(ie) <= INQUIRY_ENTRY_AGE_MAX) {
@@ -7253,6 +7261,7 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
 
 		memcpy(conn->dev_class, ie->data.dev_class, 3);
 	}
+	hci_dev_unlock(hdev);
 
 	cp.pkt_type = cpu_to_le16(conn->pkt_type);
 	if (lmp_rswitch_capable(hdev) && !(hdev->link_mode & HCI_LM_MASTER))

