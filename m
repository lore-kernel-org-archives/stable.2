Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6323D7D88
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 23:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784159718; cv=none; b=FCt2524GNJL1SaxBCxG3i0bzufijg/aqb5niAsViriS661uXtfVVMlXYq5C+urD4XlaWVO1VR9zp2h/0nMTmrh2G4hCFJIswq0/1AvqsuccZQynebijChBiZqbvG67dd9I1OkGd25NnHl4wUGTV5CpCdOOyOHdyAOw4QRl5YU3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784159718; c=relaxed/simple;
	bh=q4YQKDWRv5iiznbGhwcojzUMfGj4UI+o6DKm4M6V0V0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RYkeawqH7Jxkjp3M0FNeiuf7PzoYJW/BMyhd/VgmmFXBBEg0utiIKj29d3WSOFggc64C6GE0SCHdzy++TtUdPXI6gPUB7DEcUZgjrLCCQQ2cvbcqzbuoGdRW53DZXTb/Uy44aujYqQIrvEuBmeg3CEyl1dwErjdNd3kPNPjTC+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ml3ejA0L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ml3ejA0L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260AC1F00AC4;
	Wed, 15 Jul 2026 23:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784159716;
	bh=wWZHK0bZEaLi56b5I4vFP9tLnLe6a5T9PLr6k0OlCl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ml3ejA0LtBASWGY0aa5xu0ptjPnYk3ETPGzZ/WVlQQHSdV26wWZjc/5es4UoTUySb
	 vcleNpLNOdVZKoi7shLfeG30dqj2hZuMlVgNXo5FQSjVLSWErU6X3Xb1O6zS+kch8L
	 kO4RJNLeqLjkbVRSNDS71gigM7bkwyYGzVE9eYbyq1kGvZLBx0ye271Qsj7/gIGWrF
	 XUsmVPfxY/EN+g+Sz8yMBgW+YA9GIN7hlSZbpZOZZZJvgu7u3n9wkHfBH4jLKd8bWc
	 qS8ECwCIV90pW4+6GsylE/36v/HzOnCt/CRWylFxMsGlktNuFIJeUN94QE+JtiN+/0
	 qMgdSkWHs7mfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cen Zhang <zzzccc427@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/4] Bluetooth: hci_sync: annotate data-races around hdev->req_status
Date: Wed, 15 Jul 2026 19:55:11 -0400
Message-ID: <20260715235512.524947-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715235512.524947-1-sashal@kernel.org>
References: <2026071350-agent-mustard-7408@gregkh>
 <20260715235512.524947-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cen Zhang <zzzccc427@gmail.com>

[ Upstream commit b6807cfc195ef99e1ac37b2e1e60df40295daa8c ]

__hci_cmd_sync_sk() sets hdev->req_status under hdev->req_lock:

    hdev->req_status = HCI_REQ_PEND;

However, several other functions read or write hdev->req_status without
holding any lock:

  - hci_send_cmd_sync() reads req_status in hci_cmd_work (workqueue)
  - hci_cmd_sync_complete() reads/writes from HCI event completion
  - hci_cmd_sync_cancel() / hci_cmd_sync_cancel_sync() read/write
  - hci_abort_conn() reads in connection abort path

Since __hci_cmd_sync_sk() runs on hdev->req_workqueue while
hci_send_cmd_sync() runs on hdev->workqueue, these are different
workqueues that can execute concurrently on different CPUs. The plain
C accesses constitute a data race.

Add READ_ONCE()/WRITE_ONCE() annotations on all concurrent accesses
to hdev->req_status to prevent potential compiler optimizations that
could affect correctness (e.g., load fusing in the wait_event
condition or store reordering).

Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: 12917f591cea ("Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_core.c |  2 +-
 net/bluetooth/hci_sync.c | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index bc3230f59975ef..d9bb05f81f50e9 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4060,7 +4060,7 @@ static void hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 		return;
 	}
 
-	if (hci_req_status_pend(hdev) &&
+	if (READ_ONCE(hdev->req_status) == HCI_REQ_PEND &&
 	    !hci_dev_test_and_set_flag(hdev, HCI_CMD_PENDING)) {
 		kfree_skb(hdev->req_skb);
 		hdev->req_skb = skb_clone(hdev->sent_cmd, GFP_KERNEL);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 71a5346c38c1fd..6219c84b171b48 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -25,11 +25,11 @@ static void hci_cmd_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode,
 {
 	bt_dev_dbg(hdev, "result 0x%2.2x", result);
 
-	if (hdev->req_status != HCI_REQ_PEND)
+	if (READ_ONCE(hdev->req_status) != HCI_REQ_PEND)
 		return;
 
 	hdev->req_result = result;
-	hdev->req_status = HCI_REQ_DONE;
+	WRITE_ONCE(hdev->req_status, HCI_REQ_DONE);
 
 	/* Free the request command so it is not used as response */
 	kfree_skb(hdev->req_skb);
@@ -168,20 +168,20 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 
 	hci_cmd_sync_add(&req, opcode, plen, param, event, sk);
 
-	hdev->req_status = HCI_REQ_PEND;
+	WRITE_ONCE(hdev->req_status, HCI_REQ_PEND);
 
 	err = hci_req_sync_run(&req);
 	if (err < 0)
 		return ERR_PTR(err);
 
 	err = wait_event_interruptible_timeout(hdev->req_wait_q,
-					       hdev->req_status != HCI_REQ_PEND,
+					       READ_ONCE(hdev->req_status) != HCI_REQ_PEND,
 					       timeout);
 
 	if (err == -ERESTARTSYS)
 		return ERR_PTR(-EINTR);
 
-	switch (hdev->req_status) {
+	switch (READ_ONCE(hdev->req_status)) {
 	case HCI_REQ_DONE:
 		err = -bt_to_errno(hdev->req_result);
 		break;
@@ -195,7 +195,7 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 		break;
 	}
 
-	hdev->req_status = 0;
+	WRITE_ONCE(hdev->req_status, 0);
 	hdev->req_result = 0;
 	skb = hdev->req_rsp;
 	hdev->req_rsp = NULL;
@@ -689,9 +689,9 @@ void hci_cmd_sync_cancel(struct hci_dev *hdev, int err)
 {
 	bt_dev_dbg(hdev, "err 0x%2.2x", err);
 
-	if (hdev->req_status == HCI_REQ_PEND) {
+	if (READ_ONCE(hdev->req_status) == HCI_REQ_PEND) {
 		hdev->req_result = err;
-		hdev->req_status = HCI_REQ_CANCELED;
+		WRITE_ONCE(hdev->req_status, HCI_REQ_CANCELED);
 
 		queue_work(hdev->workqueue, &hdev->cmd_sync_cancel_work);
 	}
@@ -707,12 +707,12 @@ void hci_cmd_sync_cancel_sync(struct hci_dev *hdev, int err)
 {
 	bt_dev_dbg(hdev, "err 0x%2.2x", err);
 
-	if (hdev->req_status == HCI_REQ_PEND) {
+	if (READ_ONCE(hdev->req_status) == HCI_REQ_PEND) {
 		/* req_result is __u32 so error must be positive to be properly
 		 * propagated.
 		 */
 		hdev->req_result = err < 0 ? -err : err;
-		hdev->req_status = HCI_REQ_CANCELED;
+		WRITE_ONCE(hdev->req_status, HCI_REQ_CANCELED);
 
 		wake_up_interruptible(&hdev->req_wait_q);
 	}
-- 
2.53.0

