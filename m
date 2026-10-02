Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87F2233944
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 17:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790961387; cv=none; b=j1QUSbheVzkJ0IbaepY/Wib71WhvG8sXw2FBPw6jeUF72PsA2i4ZbKdOOkqdotZueEAkKbsBBT6AMAYcnr7pB6152/7j9JqhygcJiCXdzFaqke+iVigFIWVPe3JodZcsBbXsF078z5M8nOuMU7mVzy0tKgFAP6bFHQ+fOFe/QbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790961387; c=relaxed/simple;
	bh=SIl8iJdncWo66RBRLFUUWRqBeM/jYdcoATGGwDn41dg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l9I8oceqfj1a86/ZAgU3PFR6fY6WoAx4Zaxx5mhuvYM5PODsZCAxPZI1cdrnJ4hLlVX5xp5Ofht9svYfKVSMTGPdm3xJY4/9GLAvokBpkHaP8o1LFpObd8LEj8aN7/IaQLvoEI/PXffHZB2IWV76dA6c9dUeIbP+Is0gi431IPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJO+6Som; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJO+6Som"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-1431a73fa1eso690173c88.0
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 10:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790961375; x=1791566175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q0bGJ6qxWie/FezM/vX+M2hisla/Ap1jJ31muz2ald4=;
        b=DJO+6SomkAs+NYKEwthvsH7Cb40XkbiIYDNrkCmhba2+aBKv5k4Mp7bo7TxKoX6iV1
         1BFB5CT6ybELoimWbPVb8XjqvRgMyL1ezgcvUmBQo6f1VYM33tUPt5gMypgSap2TpfoX
         PTK0673XTEGp5wwlXxQV3Ut35FtIyk3xAiPQ+N/zaRrtLo2MijNwyLEXTfwoKUEYJAtX
         4nzT27Y1bz0DTE1Vus3E3r09Qs2LyOBs3OegR1i1FymWWOQ14GDhn9lqisuR/bBxQcHj
         W75IQJ1FE8dZ7uksMN4nQ9KA42rNefrl5AZpB68nJ004LLXAV4cRAexbqMPOS4tjVwox
         VXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790961375; x=1791566175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q0bGJ6qxWie/FezM/vX+M2hisla/Ap1jJ31muz2ald4=;
        b=uu/q2ZeBpS5dHlepe9hlZcmz3+sjKxV4F0QMwqPQmUhFKca/rI8znwIqHT0lfOMUSD
         IBQPfnQA8IB+e3apXVylLkSxnOgehrdXFQ899A9vOSduk9abjoGoSbEye0TqJOoPGPym
         FjSYZa1N/HMEjIQescXw6+GMWxeNwvQpATw4yUSeCL6i+wqIf3wHcye/k1qcSNVdAxbs
         WrLTXlSrEl0ZMruDcADMIvKVamxKk6nFlPYmd8xQCGy1lmp4/8ET3TSAEBf1nP2e9+Ke
         I4NK4H9aNWFhzLYWej+r00vAymb1sl+PUMwfQGbTimANRm5ZWchbiSX5tpgFBcRUrfOG
         i/Zg==
X-Forwarded-Encrypted: i=1; AKwUvBxleEcpFakJqwjytUyx+rSh/6hS1PS4DPYAaU89WvZp5GEFcnfeyo5+w0mpN8/UTWozYr6yykc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJgMt6+FGzBGVYu6MVOFAkv3SfImEGfFUCIQOPz1MmUGtW5YwFX
	RqZS9abR/f0Zv/n9W9qsKETK+dNKhQg8Ihq0RQQJ+xUmTOEEjQpUhsuo
X-Gm-Gg: AYBFou2HkSCfI8WIE4vWOY6Jtl/8IL/rjGN/+EB4igDNVJi0q3RfL5Q72Yj1y/x4kA9
	EXAkdAk0Xma0K2R1GhzoyuTCITmclVXXGR1WshqPhO3KLNBoZF4Ojpg6Yg+M+hnXaE8lWMlTcra
	aXJk0zohxOovolfmRypJaDA5lMfIv63ATnjQ2Nx3cQ8of33VnH/lK2c+SiEKV6zERBYDPl7lp1w
	mCncSX8HF0gieVIpwurOQ/cg/N4M4q1EQnYUb24NlNYXKfZa57e//JqnzfgVJaAeu64H8FOkzCm
	Ciwm8GMhC8s9gRLq5TTDouOVIt88aR01+MTKGX+NE91aWVwk/Tsyv+WSsZ1LBizucesp7lX0o4a
	w7YD4SpxrfO24X/X2CGNrAOfnuNw+LJvBdSx1h6WSrwQ2g9sGpKsNTp3yaM5H4XhEltbrMZqypj
	SgovdNSPIFomgsQzgLH/ZjpCRc4EsQFSRNvuT3qq0ILiUog3MeHQ3DoiesUBLx36lCsFa2EdWRj
	50LgpKpMoPoafYt+/TRdhqALazSEoq8cdJwNbQAokSK1+vN8LQan5xOYtNYcVDkLTcfvA==
X-Received: by 2002:a05:7300:4f1c:b0:34b:101f:cdaf with SMTP id 5a478bee46e88-34f1501d239mr5077707eec.1.1790961374454;
        Fri, 02 Oct 2026 10:16:14 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14f660f1sm7995468eec.13.2026.10.02.10.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 10:16:13 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] Bluetooth: L2CAP: Fix reject-list lookup UAF
Date: Sat,  3 Oct 2026 01:16:03 +0800
Message-ID: <20261002171603.3368121-1-nicoyip.dev@gmail.com>
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
Assisted-by: GPT-6-Astra
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
Changes in v2:
- Rebase onto current bluetooth-next/master, preserving the v1 RCU fix.
- Compare the reported management and mesh failures against the exact
  unpatched CI kernel base; retain test evidence outside the commit log.
- Add the coding-assistant annotation.

Link: https://lore.kernel.org/r/20260821174022.3033729-1-nicoyip.dev@gmail.com/ [v1]

 net/bluetooth/hci_core.c   | 10 +++++-----
 net/bluetooth/l2cap_core.c | 23 ++++++++++++++++++++---
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5df7bd14323f..768a2d6c03e9 100644
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
index 49a998804908..e79ebb89e239 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7318,6 +7318,25 @@ static void l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm,
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
 	__must_hold(&conn->lock)
 {
@@ -7344,9 +7363,7 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
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

