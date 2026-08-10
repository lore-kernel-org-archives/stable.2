Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E9B3B0AE6
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 23:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786405894; cv=none; b=NzOkHH7lp/aWDbHxP205poSkCwPL1cCmv3FAyp5vc86vYaVcKO/A2TSTZYT2SKO27V1SkTzZW+v95i41so3mQTXcTdFsVWiesqoo7dzKhOrkBBl2vJEXhFoNN7RJTUpO/mt+Faz8bOA9D1JXPjwnOJxiJ3oYlfQHs/jZZaUb/ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786405894; c=relaxed/simple;
	bh=kNvMQbwHzoaAJErWk3W2YpbuMWlSiD63Kbgneotx0og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hqTXXSXuDr44RKzDKCyaBLnMaQGCAfwRSrENZ+QqkFcDIwtNWPlIrWTP8bWlH2uBZScL/KUrojb548KkAcptlJk2Q4REljFl0oiY6NbSFYZ8PcyZzD4KZSrT1dFGhVSmj4LsB2CLPx60Pr0r9cB2xH7LQM4VVKJzo8VKeOF0lbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsTovC9M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsTovC9M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7957B1F00A3A;
	Mon, 10 Aug 2026 23:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786405892;
	bh=cjj4zZ+p7G+mK1c9ejcChKzkvdBzNxFbAzr9M2Rg0xo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hsTovC9Mx5KmCrn1FzwpPkSAbQezDpcYLSQaqbJzziUwu9Yq4VY/7bojUKOciRpt4
	 6938iSYDzvS1ggFpIFI01XbKI2avZSyiulYw2Qe6K2mZ3zEcJGg4IRgjjVVTnL4dqH
	 fEiBVENHFmAieoSl1CBRgIDq08Us1mm7dVyGDFH5rOeSx+Dk6ygetpSgbFjE58hIXQ
	 9dSBcDvPUMReeBE+agJc7EmOn99rwjju4NzqJ0kT6Y9Et7JlRAr84C+npbJrFoYEtN
	 817SKvdkRmn3MO16TtYfs8mJLlkRWrjqIJppAiTZO5V50bL2RxQVh2jOxojEPkWp6O
	 xCdBs490wutDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/6] Bluetooth: hci_sync: Introduce hci_cmd_sync_run/hci_cmd_sync_run_once
Date: Mon, 10 Aug 2026 19:51:25 -0400
Message-ID: <20260810235129.3217516-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810235129.3217516-1-sashal@kernel.org>
References: <2026080548-angelfish-scored-d506@gregkh>
 <20260810235129.3217516-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit c898f6d7b093bd71e66569cd6797c87d4056f44b ]

This introduces hci_cmd_sync_run/hci_cmd_sync_run_once which acts like
hci_cmd_sync_queue/hci_cmd_sync_queue_once but runs immediately when
already on hdev->cmd_sync_work context.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: d0a7b48ad092 ("Bluetooth: mgmt: fix UAF in pair command cancellation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/hci_sync.h |  4 +++
 net/bluetooth/hci_sync.c         | 42 ++++++++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index a68ddf5c02286..012ac6db29fd7 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -69,6 +69,10 @@ hci_cmd_sync_lookup_entry(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 			  void *data, hci_cmd_sync_work_destroy_t destroy);
 int hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 			    void *data, hci_cmd_sync_work_destroy_t destroy);
+int hci_cmd_sync_run(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+		     void *data, hci_cmd_sync_work_destroy_t destroy);
+int hci_cmd_sync_run_once(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+			  void *data, hci_cmd_sync_work_destroy_t destroy);
 void hci_cmd_sync_cancel_entry(struct hci_dev *hdev,
 			       struct hci_cmd_sync_work_entry *entry);
 bool hci_cmd_sync_dequeue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index ed20541347b6c..1c33a9dca1cf4 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -108,7 +108,7 @@ static void hci_cmd_sync_add(struct hci_request *req, u16 opcode, u32 plen,
 	skb_queue_tail(&req->cmd_q, skb);
 }
 
-static int hci_cmd_sync_run(struct hci_request *req)
+static int hci_req_sync_run(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
 	struct sk_buff *skb;
@@ -165,7 +165,7 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 
 	hdev->req_status = HCI_REQ_PEND;
 
-	err = hci_cmd_sync_run(&req);
+	err = hci_req_sync_run(&req);
 	if (err < 0)
 		return ERR_PTR(err);
 
@@ -805,6 +805,44 @@ int hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 }
 EXPORT_SYMBOL(hci_cmd_sync_queue_once);
 
+/* Run HCI command:
+ *
+ * - hdev must be running
+ * - if on cmd_sync_work then run immediately otherwise queue
+ */
+int hci_cmd_sync_run(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+		     void *data, hci_cmd_sync_work_destroy_t destroy)
+{
+	/* Only queue command if hdev is running which means it had been opened
+	 * and is either on init phase or is already up.
+	 */
+	if (!test_bit(HCI_RUNNING, &hdev->flags))
+		return -ENETDOWN;
+
+	/* If on cmd_sync_work then run immediately otherwise queue */
+	if (current_work() == &hdev->cmd_sync_work)
+		return func(hdev, data);
+
+	return hci_cmd_sync_submit(hdev, func, data, destroy);
+}
+EXPORT_SYMBOL(hci_cmd_sync_run);
+
+/* Run HCI command entry once:
+ *
+ * - Lookup if an entry already exist and only if it doesn't creates a new entry
+ *   and run it.
+ * - if on cmd_sync_work then run immediately otherwise queue
+ */
+int hci_cmd_sync_run_once(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+			  void *data, hci_cmd_sync_work_destroy_t destroy)
+{
+	if (hci_cmd_sync_lookup_entry(hdev, func, data, destroy))
+		return 0;
+
+	return hci_cmd_sync_run(hdev, func, data, destroy);
+}
+EXPORT_SYMBOL(hci_cmd_sync_run_once);
+
 /* Lookup HCI command entry:
  *
  * - Return first entry that matches by function callback or data or
-- 
2.53.0

