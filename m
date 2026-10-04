Received: from mail-dl2-f40.google.com (mail-dl2-f40.google.com [74.125.229.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E013BBFC2
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 16:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791131180; cv=none; b=mUe85qE8C+IvT+T1XLf4Gt2d7R0lT5GAevy0HlBQWUpfXTzJpStVkqy7ZdPWtaRNRBOKp2YCnjgZEWJ4Y46lNquO3pr90c2kf0BhNF/pdTYbswb8XxNTVF3M3Uiam+S2wSSEVMRaOsXjUce5uuuyrKm3iTrCf/CI1K24qxzoLsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791131180; c=relaxed/simple;
	bh=Rj63DgR20oiwFDDc12/4Ve6f46BYY+nTaOfWOvX5CNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qfCNS1oclld2KwRBrs73dqzCVcGfrFXie05/2EK3CZqrKeFg44Eqa+T2lHq/23t4FhksDVsHGe/VHJe07aHywBajcKEMQ+9RVIIqX+bMQ+rkiqs+mIJIASAu4P5NgaukwAAkMIGHntDt7CyAgRVL3nLUdDSQwG1uYzRXvQkfe5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qvk0aRfI; arc=none smtp.client-ip=74.125.229.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qvk0aRfI"
Received: by mail-dl2-f40.google.com with SMTP id a92af1059eb24-151af368f59so35995c88.1
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 09:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791131178; x=1791735978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yikDAY6J+GlEGObfqqnaCvM3+Krl2SbWGorcnJKWLX8=;
        b=Qvk0aRfI4PS08pt2e3It3JwW7TiU0iMUNWzS377Mu/KEYZV9SMV4l71WT/RgjPR1pQ
         cp7ubkA4aUGQoZbK2ZaKqjVIzLXkEaao0NpxuoViDazWZUCms/r2y6+jYMsS+/rMdEgS
         WXs6Umj0r8GsAjWETon/uol3URFCG/q/HYNhESfkxZ6Am/GW+ZLp8nmT5UvhQUfWbO4j
         XuTdgKrNmdmG1kMWLasUtS83TtdHI5IKJKeIcVAxPlITmyDdJvqxAOKf9shQVty7skdq
         ixak08g3IwEHpRX6iZb9Juzjz2XEipv23z9G9RsrRM3zzACu3TtqoIhef8oNVb+ZNOpQ
         I/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791131178; x=1791735978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yikDAY6J+GlEGObfqqnaCvM3+Krl2SbWGorcnJKWLX8=;
        b=a0XCzB35Md2ebHfmiZ59B7TbznGOOuaB/nfF4Qp64PzwwX9GM0i0NcPqbs1nXPlNs+
         yh3s2OnwiIS+0rzTx2cCM4YfmLM0ANdZARBl0prwk8Pkldmvfzf1zJpgOzTer1+4kDa1
         2uUAcksbTEhsA9dxrdddXEiSdRk1JrLTiSpyKIE9uM6t5iFpbDPbBJwieoBmxJfh2vEB
         SWuTBC2/ivupvmXwxuobI6jNf3/tdgkdnZjrADazkOjCHUujKHN2Jy3gIItBcXLV51Lo
         h2ODEEpXqGzu7/jTE+BVsq9oC0kWQEf+k0/laT6pc+aZJd+GwaVADaI5lj7vqM/CHOGP
         VUvg==
X-Forwarded-Encrypted: i=1; AKwUvBzH0eXG45WnxKxA9ckjgkbqMMHz1sR6TnhSHXIL4bDS8bio24Pzd/nc5RK+vn37vcF+KoytvN8=@vger.kernel.org
X-Gm-Message-State: AFuF++kGhNyjsaWXN0zrEGzZhWYYVwAe6bW7PtuKnx4wuM4PLPRTWllz
	XZY+LlO4uoO74QmbBVZYnwRFNQYgXuyqd2Qsf8S8VwKyiGcMt2yTNoj1hfKsb58xMUlaeg==
X-Gm-Gg: AYBFou25wik3jOrhskD3BG0M0J4sRfTYd4z+2BqKmwx8Wy8DclCPpIOwumPhPK2QHeU
	OydtPg7tXny97VlwH38/hBMGnAiLTGMAAE0MwUU+6FH//97gGy171Ktbi68kE5IP0DgOMBF2hMT
	K7V977n4xxFVd5mgnRcaRiAtNpHpFCqUo2LYC47ylpf+r/NsswQuDJ5afFV8LP8hhfG6sUNYEij
	VrI7pBbZTsNi5sgfUos8p06yxu0p0bNfue0uskcWppKt2ijkSYTcFK2NgP1Ky7sWkbDzzUU1jf3
	/GH+RXz+SVdKXqaRfXVok5iXjVi22dUEsMMYDhF40jzWJo3XN0sOYTuEO3+kRzknGSXMYG+0Ie2
	c1b1ONJWpQH8t83JXS3Nka/Gdk/bSMM6X3xmNNKzmT+E4p8g6/eCkeppXeJi7xeQ5Alp5/J292f
	ZM77dEEr2UZ78vlipKE+9ie/naS/X7vlu1KRnWMPLIMrqJ+vk4Jr8FDnNwAYCYrH19vNYxfVvDn
	GGyQ6hPrge5Tx8YLq7bmcE5UKv4g7NtL5RB8pw6mfaX9+xvN3aeF23pVUiNdz4ElpBk+g==
X-Received: by 2002:a05:7022:b047:20b0:14b:edb2:c3bc with SMTP id a92af1059eb24-14f5625d203mr17992869c88.0.1791131177596;
        Sun, 04 Oct 2026 09:26:17 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-151fcec9f1dsm15511885c88.16.2026.10.04.09.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 09:26:17 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: Fix command skb lifetime during scan setup
Date: Mon,  5 Oct 2026 00:26:12 +0800
Message-ID: <20261004162612.3968831-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 net/bluetooth/hci_core.c |  4 ++++
 net/bluetooth/hci_sync.c | 10 +++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

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
 
-- 
2.43.0

