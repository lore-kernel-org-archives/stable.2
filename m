Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFE1381E94
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787334041; cv=none; b=i3EuWOQuhHM+h1Gz3UlmENg7eQGnfor3UIIwsLU3VfvXhancWTWBvDWi8bAtkNdqVdR6p7aDpISAjiY+0l+PWShp/QcmPHeG9BdcvtE5dpzl7tHMh7Kp6q8hepGLqqqcuSbJYSpzLx8BXfbulT1A9AcH4PadbQ17VQho8DbE4f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787334041; c=relaxed/simple;
	bh=P1Xq0UzEM0t7r9IEf/5mikKYu1zHCHI9UGwb3zHVBPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QjY0io04yL5kOZXy/lI9iOY0+/K4iUiNvDlY7WM3XRIDrNa+A7eDeJx01jrte3w1fJ8xbFOPg6id9cTmFG01cmEodETna4UHAWTIvr0oG0bANGTgt9nVKSj4BInGUMUd6T8BuIXddp2i6JBJsWcdxpe3zQk8ViCWh99DxdxD9lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q67+dL98; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q67+dL98"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-81c7245eebcso1180667b3.1
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 10:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787334031; x=1787938831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V5c3s5X8AAUMms2euYSrBnscwrovVDKGX5JSFjmzAWQ=;
        b=q67+dL98sKimy1YcBHXReoiLM5qVek4eiXOK2wduJlhtCtLb+KWhvj+gYBkSMBCAfC
         WT+9YnPllhMxTljztgEJaaqDS06Bwkxm2JMNCYp4KMd+3K4p5DamaOBDorq4EUHbig+E
         Gm92Lfg2XQsx3sHmeBpN6QOjY5fkOJkvY78r4DXByS6lyCNePJghFEbpsVX7XOFrwAta
         xSzlGEUAaqYL+wHI+wAziKWPh/ZYrK/s5pWhu1v99EvWAGXqdH7nibArYVrqZ51Ie8kG
         n7UrJ2VA7ZgLJ5uzzcFmTq7sJRaIl/Oysvdc2snDPSCtfrreUwvWEl9obuhg2aXwAJ6z
         aEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787334031; x=1787938831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V5c3s5X8AAUMms2euYSrBnscwrovVDKGX5JSFjmzAWQ=;
        b=HmNs5c+pKhon6zWvLR0fQMOYanzdfLCLB3l9w0Ik8AIDzbPkvba3A2p7Uk9TbREteJ
         MzaForAs6qg5nw/h/IbiFMsQdX4kJle8F17Xm66Me2+EsDLyjoKEcJ94/vVu+3iop/3S
         Z7D1dY40ufmPvTtonNolmp1G0W8Ml78KD+4MgS5NJEofJEbD7vDlTUsexIfrxfj3PCyR
         aj9Xds9/fRfMJufS2VCqCYUqL/Wjd//T0VtDvZZMsgoSNMASg4UIsupHKzyD2jLV6GC4
         cazgK38evtvNvbQZQVWPbfVNJ9eAzLg/DQcZhTtEwQznwEeOVmk2TM+jgoOW8RdNqRmY
         nZ0w==
X-Forwarded-Encrypted: i=1; AHgh+RrOPeOnXMdtD06hxKz18qf5y0Nnl/D8TUjfiX6ePaJoa2X88VGS+f+VgHy/kbG6NYSaeOf6KRI=@vger.kernel.org
X-Gm-Message-State: AFuF++k+bK6D2D3twotHBaQxnxwOi3sAEkwsHFXKGJeqIMYU87uIso9x
	LcQJBLSrbhgKKrrTiQjZ2HVAIwrAflt9T1SFh/oSMtMZDILYMBgWIYq8y4kcfQ9/5qkQ6g==
X-Gm-Gg: AR+sD13H5UI/EvEU/iGufc+JlRW8FrhLWOpdx3vsM1ULfGnr3ZcSf4Os3nTZPH+Twvz
	jb1VinIstUjetNZWRnu+R5kNthj7HBVBq4o2bOFs5iCsxIKdkB/rfCmCNEK6itwPjNBQdUK0XV3
	N0RPbtP7X1kVcrQGVhXUbebJ/7Los6Hvw82n8fm4P2rhQ42/iIEPvx1wTF0C5ALj1pj3/1ddRA0
	88VC/vsxSPIJuTWtxlp3aRYwsBvkCTkbmtXtEmo15HFX12u//p5ZmPamK+mV0AfPq2X1YyfKrHA
	kHT6HWOO3XJrsRwTfzbgMAD7du25kKqau9c1NkUWHkecm0bQGLZ8/9oyvmiV0KRwXESzsf4qwIc
	PP+QsjS4EvQ0SyY0iSfpjhx/D+O/fuSEMfkeYIZp9e4I3yV3IXh+uW8/T6kutCrLq6yj6VFoTg8
	QSXIPOKB57qekpXSCJHOh1KXgTmy942db/XLBqNrznBcpGxU5NEf/2xuymZlIGwd5IKpHNWEuGD
	XL7k9PS71lLwyXj7BHcXXkNWdKZuBEN+tRvfuvrruMN3ohErCwN4gk=
X-Received: by 2002:a05:690c:e013:20b0:81f:49e1:1f15 with SMTP id 00721157ae682-849ea01a334mr26664027b3.0.1787334031357;
        Fri, 21 Aug 2026 10:40:31 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84511abc153sm45081607b3.4.2026.08.21.10.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 10:40:30 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Johan Hedberg <johan.hedberg@intel.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: Fix reject-list lookup UAF
Date: Sat, 22 Aug 2026 01:40:22 +0800
Message-ID: <20260821174022.3033729-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2cap_recv_frame() walks hdev->reject_list while holding conn->lock,
but reject-list updates are serialized by hdev->lock. Consequently,
block_device() or unblock_device() can mutate and free the current list
entry while the receive path is examining it.

The following interleaving causes the use-after-free:

  l2cap_recv_frame()             unblock_device()
  fetch reject-list entry
                                  hci_dev_lock()
                                  list_del()
                                  kfree()
                                  hci_dev_unlock()
  read entry->bdaddr_type

KASAN reported:

  BUG: KASAN: slab-use-after-free in hci_bdaddr_list_lookup
  Read of size 1 by task kworker/u17:1/88
  Workqueue: hci0 hci_rx_work
  Call Trace:
   hci_bdaddr_list_lookup+0xee/0x100
   l2cap_recv_frame+0x8a4/0x8e50
   l2cap_recv_acldata+0xa64/0xd40
   hci_rx_work+0x4ca/0x730

  Allocated by task 92:
   hci_bdaddr_list_add+0x12a/0x300
   block_device+0x94/0x1a0
   hci_sock_sendmsg+0x1033/0x1ea0

  Freed by task 92:
   hci_bdaddr_list_del+0x182/0x230
   unblock_device+0xa0/0x1b0
   hci_sock_sendmsg+0x1033/0x1ea0

Taking hdev->lock from l2cap_recv_frame() would invert the established
hdev->lock to conn->lock order. Instead, walk the reject list under RCU,
publish and remove address-list entries with the RCU list primitives, and
defer their freeing until readers have left their critical sections.

The address-list helpers are shared with other lists. RCU publication
and deferred freeing preserve their existing locked lookup and matching
behavior while making reject-list traversal safe without changing lock
order.

Fixes: e493150e3639 ("Bluetooth: Centralize looking up blocked devices to l2cap_recv_frame")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/bluetooth/hci_core.c   | 10 +++++-----
 net/bluetooth/l2cap_core.c | 23 ++++++++++++++++++++---
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 509c820a693d..69bcc820d22d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2055,8 +2055,8 @@ void hci_bdaddr_list_clear(struct list_head *bdaddr_list)
 	struct bdaddr_list *b, *n;
 
 	list_for_each_entry_safe(b, n, bdaddr_list, list) {
-		list_del(&b->list);
-		kfree(b);
+		list_del_rcu(&b->list);
+		kfree_rcu_mightsleep(b);
 	}
 }
 
@@ -2077,7 +2077,7 @@ int hci_bdaddr_list_add(struct list_head *list, bdaddr_t *bdaddr, u8 type)
 	bacpy(&entry->bdaddr, bdaddr);
 	entry->bdaddr_type = type;
 
-	list_add(&entry->list, list);
+	list_add_rcu(&entry->list, list);
 
 	return 0;
 }
@@ -2148,8 +2148,8 @@ int hci_bdaddr_list_del(struct list_head *list, bdaddr_t *bdaddr, u8 type)
 	if (!entry)
 		return -ENOENT;
 
-	list_del(&entry->list);
-	kfree(entry);
+	list_del_rcu(&entry->list);
+	kfree_rcu_mightsleep(entry);
 
 	return 0;
 }
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ee459dd411f5..f2e741b25cfd 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7077,6 +7077,25 @@ static void l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm,
 	kfree_skb(skb);
 }
 
+static bool l2cap_is_rejected(struct hci_conn *hcon)
+{
+	struct bdaddr_list *b;
+	u8 type;
+
+	type = bdaddr_dst_type(hcon);
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(b, &hcon->hdev->reject_list, list) {
+		if (!bacmp(&b->bdaddr, &hcon->dst) && b->bdaddr_type == type) {
+			rcu_read_unlock();
+			return true;
+		}
+	}
+	rcu_read_unlock();
+
+	return false;
+}
+
 static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct l2cap_hdr *lh = (void *) skb->data;
@@ -7102,9 +7121,7 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 	/* Since we can't actively block incoming LE connections we must
 	 * at least ensure that we ignore incoming data from them.
 	 */
-	if (hcon->type == LE_LINK &&
-	    hci_bdaddr_list_lookup(&hcon->hdev->reject_list, &hcon->dst,
-				   bdaddr_dst_type(hcon))) {
+	if (hcon->type == LE_LINK && l2cap_is_rejected(hcon)) {
 		kfree_skb(skb);
 		return;
 	}
-- 
2.43.0

