Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D793B777C
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 08:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791275493; cv=none; b=Ue9FZVXAh/yjK9r9iOPDVy65/OD658miz57fX1wVFDiL1+tbg0WvrhzpwYRJEEn9os4SK6l2hOYGuLC/Qd2qSbOImaWQNpNMNcJZ6G5WwlTPRvIqfxqRAIjUQ/CZW8jJ7qWePILRduypGY7MsSIExWKDFFjt6O0OkyK1er10R2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791275493; c=relaxed/simple;
	bh=1UGTcHUZByNhvauGXEKZFn9Oo9YY93XUiTr+KdGHMMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nmfX8bFBvaV0nDU8w/7T9TqQ9bRu1V+xLDaPvuxdW72aMOhDZsrtqil5jhRqfP7KLns6JCDqfFDbADDIoYzppbwnFQxUpjmF/woISImZttxe8v5bbeQ8qaDsiUzqDElYOObfvprnsb8GWQ5z414/8PfWjzRodRiOMMnucUptwM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpUqw0I9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpUqw0I9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1077D1F00893;
	Tue,  6 Oct 2026 08:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791275492;
	bh=xp5hChYYPZSvKeY3MDjwTHQsOso69qx936EsEuoushQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XpUqw0I9mVulifKqGi5m2wj1yAfCEC2ncBmb8QGOswSCh40Nl+uxBoSR6qmKBSIO/
	 b/rVfV9IDCFviOBoD4nr0gISnu5HYBb+uuWM7ovZr0csI4PiR5bfXbeK3DSkvXpCXD
	 /KneXHuU4htRJmPv1RuS0VBiLxLCIvnKWJ8q+GQActtEYfvUQxG36ndJA4FZlO2+oR
	 Qv6yAORJDs7n3GLx7t3uG9xKaRwgjvS4Z4f/dLVMqNkCH/b2V/gdEV94ZzjBOhQQXK
	 IzLXF0ip42TUjoImkbAcH+w+5xILwyk8NOZ+wJZMLVYyrQO7ViUM702bBlRACoD/d7
	 hLJHkgI9Di54Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chengfeng Ye <nicoyip.dev@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] Bluetooth: hci_sync: Fix inquiry cache use-after-free
Date: Tue,  6 Oct 2026 04:31:24 -0400
Message-ID: <20261006082552.3871603-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006082552.3871603-1-sashal@kernel.org>
References: <2026100541-valid-olive-13c3@gregkh>
 <20261006082552.3871603-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengfeng Ye <nicoyip.dev@gmail.com>

[ Upstream commit 8ed67535fdff40ca652bcd4ac7da68d11d01bd34 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_sync.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index afa38e093479a..5ea2443e3e18c 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5459,6 +5459,7 @@ int hci_stop_discovery_sync(struct hci_dev *hdev)
 {
 	struct discovery_state *d = &hdev->discovery;
 	struct inquiry_entry *e;
+	bdaddr_t addr;
 	int err;
 
 	bt_dev_dbg(hdev, "state %u", hdev->discovery.state);
@@ -5495,15 +5496,21 @@ int hci_stop_discovery_sync(struct hci_dev *hdev)
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
@@ -6741,6 +6748,7 @@ static int __hci_acl_create_connection_sync(struct hci_dev *hdev, void *data)
 	bacpy(&cp.bdaddr, &conn->dst);
 	cp.pscan_rep_mode = 0x02;
 
+	hci_dev_lock(hdev);
 	ie = hci_inquiry_cache_lookup(hdev, &conn->dst);
 	if (ie) {
 		if (inquiry_entry_age(ie) <= INQUIRY_ENTRY_AGE_MAX) {
@@ -6752,6 +6760,7 @@ static int __hci_acl_create_connection_sync(struct hci_dev *hdev, void *data)
 
 		memcpy(conn->dev_class, ie->data.dev_class, 3);
 	}
+	hci_dev_unlock(hdev);
 
 	cp.pkt_type = cpu_to_le16(conn->pkt_type);
 	if (lmp_rswitch_capable(hdev) && !(hdev->link_mode & HCI_LM_MASTER))
-- 
2.53.0

