Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E151135C188
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344652; cv=none; b=Lb5UQX0Ec4Z5NmO7ge1+eQlXZYzn24p6K2dDUD8d4hKNntAvP9L8pDE835maVtRoXo1ZazJNaRU3d+ouy3gjwDvlGRn1KGhGyOK8gVmXNEBDRumxiJH6075pMPvw/XAEQUgEYpG7+U8iV64C/UKd6hWs5hDRj3mSMyNQoFQPeqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344652; c=relaxed/simple;
	bh=OWdbuqZGyON3UX4CtxDTZKADd9ZkOU1qEt4SHcsfM38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n7Lq1V9xvcddDOkDErZ1fX9dHAjLQXmnDoOTcQo1poOKmpWdcrTWWYdcPiDV4fhB0EzpBqMTAn8LYxj9q1CYiWYRbwsWSyDnhzXBRkOC6QuLqtHWbQdRdYYuk7UF0vroA3uyjNjKF40CgeKzyV9Z6eGwxvK/N03BeAgaMLoX8BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPFWFQEG; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPFWFQEG"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c9d290216d0so36360a12.3
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 10:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785344650; x=1785949450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LXXAnWzfQHkC/bPHJx67PTLMS7OzqrAYYTe9Z3KvAMk=;
        b=TPFWFQEGdfLhorlrvhvWEp6uS3fTjCsVeOr9KgtQ9jNGLLJaZoD10O3IJsHzxqiWUo
         lEsiShGrHOCa05jeBT4TpDVuYKx1VkjUQQiv/sTYPEZqQSbKfhr5AoN0rbIKPs7lTRqt
         3tIzuz4xDXRXEkRyQkGf4rvJ+ydw4V1oTi9IbViKAYpfsZcqC5Gxc06YUMNLT7qg6BSG
         iIJDKzIRVM+Gmemc7r2oukRsKMGpbQRDWILEdyx94ExJ1VyNRCg0KV98WGQCY+pm6fXj
         uqZgdXOlaL2yxcVZyd9uED0C07ZH7WuOrYMacseBIXgvKLzhCZxJX5J6GD+6FsArQTak
         sBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785344650; x=1785949450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LXXAnWzfQHkC/bPHJx67PTLMS7OzqrAYYTe9Z3KvAMk=;
        b=rpT+ofS8lQGIS6zML3JsnU7cui8565pl0jskhSN9t4wB5fLhlb5rf0MQiinHuJcXJI
         DaDzZBiHvUWkZwwODMFeopwjA6+ZosVDoa4I3JlvMQeRLc9l8ggIBxmmoYbsdMQS4SO0
         XqoZCfOf0dMWL2bDJJwDR07oD+WIeb0fu46Q0pyfFCs2BfPckGlCTCmwx+NWv+zMEgs6
         +ToL34A/HUum7P1vWaXcqAiNUdJSC8Mb365AwI1ISkMsFAGa5wU2iBQfXSXc3W4g2jdi
         H/fjs/NJP+kVcbXZ3RRLIl28d8VWMa57k/Jbxe6i/GcZ/z3NI9nx9Wgvnym6Z5HrwPdu
         Pn+g==
X-Forwarded-Encrypted: i=1; AHgh+RpdecI/WIw85TfXKkldKXdxyRlREEcjtDIeC/kmxTGgLFX2IAayaIHvH/KZ98eUurqpMot/JHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKwGwazuuYuvv1zwZoL4WbTn1/3KV+WD521GEzJ3bVEtZYgyUR
	JJujfaReyHMqwhpvBAnrubXfthFNIOJFYa9vR/I1uCyKAPmq2bo3EjZSOK1+PjFb
X-Gm-Gg: AR+sD11vSz/KGUTUsYpnNbqhhjLEnc13Y784Q/O4MH1re2B5EXxKRy+NO26G4OhM2HB
	ed+WWBIneXKPtw/qHG1KeP6ufb33DGTqA+dd6wvpOSaTBrub0vqq+r7Fi9/DHGPzZYBKa4EFEDA
	XUVcRwwjOzzM8YloVqzGB1oCRZeIUx143Pu/xxfZzvVFlfYjh6met0M8ASSVXaJSn9b5qKAx+8i
	DN54s2OmOYST+xX9FYQNeXdJLqNZh2FR5fo5zZXA9aOldqPxIziVqFao+0KLks5ne3ZTN71e2oK
	brVJZ29NQZLs5rFb/UFtwmj7mD78acQ7AObOC35chQrBszKDK+bVsMas39fX8sgCi3DBHnaGau1
	4G5NdeJZtXqsVPRl1gofkvzclaxHJ19FJbPAmRuKa+2a2SaMaAEI9uFXjrALZAJ5uXGd/vJH+An
	l0ow23zQiC+tmAJj8syiC5oxPzsXijM5CJnUdEBRImL5BqXQmtlKs9pHA9rPm4jrJi54s0EQ4zm
	XG0hDcNdpxzzElaU5S5FRpFdu8bMPu2qVmeqzmgckn8+Z/P84Qep8A=
X-Received: by 2002:a17:902:d4ce:b0:2c9:b96a:2855 with SMTP id d9443c01a7336-2d01e844abemr76822285ad.0.1785344650015;
        Wed, 29 Jul 2026 10:04:10 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b670cfsm10858789eec.8.2026.07.29.10.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 10:04:09 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Johan Hedberg <johan.hedberg@intel.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: MGMT: claim pending pairing command before completion
Date: Thu, 30 Jul 2026 01:03:56 +0800
Message-ID: <20260729170356.214966-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

find_pairing() walks the pending command list without mgmt_pending_lock and
returns an unreferenced command.  Its callers then complete and remove the
command after the lookup.  cancel_pair_device() similarly drops the pending
lock after pending_find() and continues to use the returned command.

The HCI device lock does not close this gap because the SMP receive path
does not hold it.  The observed interleaving is:

  CPU 0 (cancel)                 CPU 1 (SMP failure)
  pending_find(cmd)
                                  find_pairing(cmd)
                                  cmd_complete(cmd)
                                  mgmt_pending_remove(cmd)
                                    kfree(cmd)
  cmd_complete(cmd)
  mgmt_pending_remove(cmd)

Thus CPU 0 dereferences and removes a command already freed by CPU 1.  The
same ownership race exists among the other pairing completion callbacks.

Find and unlink the matching pairing command while holding
mgmt_pending_lock, then complete and free the claimed command.  Use
mgmt_pending_valid() when pair_device() already has the exact command.
Keep cancellation limited to the first pending pairing command, as
before, so normal lookup and error behavior remain unchanged.

KASAN reported:

  BUG: KASAN: slab-use-after-free in mgmt_pending_remove+0x292/0x2f0
  Read of size 8 at addr ffff888100340498 by task poc/92

  Call Trace:
   mgmt_pending_remove+0x292/0x2f0
   cancel_pair_device+0x1d1/0x310
   hci_sock_sendmsg+0x1033/0x1ea0

  Allocated by task 86:
   mgmt_pending_new+0xb4/0x260
   mgmt_pending_add+0x1b/0x100
   pair_device+0x51d/0xcc0
   hci_sock_sendmsg+0x1033/0x1ea0

  Freed by task 87:
   kfree+0x131/0x3c0
   mgmt_pending_remove+0x20c/0x2f0
   mgmt_auth_failed+0x31a/0x4d0
   smp_recv_cb+0x4d6/0x8110
   l2cap_recv_frame+0xf14/0x9190
   l2cap_recv_acldata+0xa64/0xd40
   hci_rx_work+0x4ca/0x730

Fixes: f4a407bef20c ("Bluetooth: Wait for SMP key distribution completion when pairing")
Fixes: e1e930f591bf ("Bluetooth: Fix mgmt pairing failure when authentication fails")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/bluetooth/mgmt.c | 53 ++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1db10e0f617f..09cac79ce51b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3514,21 +3514,34 @@ static int set_io_capability(struct sock *sk, struct hci_dev *hdev, void *data,
 				 NULL, 0);
 }
 
-static struct mgmt_pending_cmd *find_pairing(struct hci_conn *conn)
+static struct mgmt_pending_cmd *claim_pairing(struct hci_dev *hdev,
+					      struct hci_conn *conn,
+					      const bdaddr_t *bdaddr)
 {
-	struct hci_dev *hdev = conn->hdev;
 	struct mgmt_pending_cmd *cmd;
+	struct hci_conn *cmd_conn;
+
+	mutex_lock(&hdev->mgmt_pending_lock);
 
 	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
 		if (cmd->opcode != MGMT_OP_PAIR_DEVICE)
 			continue;
 
-		if (cmd->user_data != conn)
+		cmd_conn = cmd->user_data;
+
+		if (conn && cmd_conn != conn)
 			continue;
 
+		if (bdaddr && (!cmd_conn || bacmp(bdaddr, &cmd_conn->dst)))
+			break;
+
+		list_del(&cmd->list);
+		mutex_unlock(&hdev->mgmt_pending_lock);
 		return cmd;
 	}
 
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
 	return NULL;
 }
 
@@ -3566,10 +3579,10 @@ void mgmt_smp_complete(struct hci_conn *conn, bool complete)
 	u8 status = complete ? MGMT_STATUS_SUCCESS : MGMT_STATUS_FAILED;
 	struct mgmt_pending_cmd *cmd;
 
-	cmd = find_pairing(conn);
+	cmd = claim_pairing(conn->hdev, conn, NULL);
 	if (cmd) {
 		cmd->cmd_complete(cmd, status);
-		mgmt_pending_remove(cmd);
+		mgmt_pending_free(cmd);
 	}
 }
 
@@ -3579,14 +3592,14 @@ static void pairing_complete_cb(struct hci_conn *conn, u8 status)
 
 	BT_DBG("status %u", status);
 
-	cmd = find_pairing(conn);
+	cmd = claim_pairing(conn->hdev, conn, NULL);
 	if (!cmd) {
 		BT_DBG("Unable to find a pending command");
 		return;
 	}
 
 	cmd->cmd_complete(cmd, mgmt_status(status));
-	mgmt_pending_remove(cmd);
+	mgmt_pending_free(cmd);
 }
 
 static void le_pairing_complete_cb(struct hci_conn *conn, u8 status)
@@ -3598,14 +3611,14 @@ static void le_pairing_complete_cb(struct hci_conn *conn, u8 status)
 	if (!status)
 		return;
 
-	cmd = find_pairing(conn);
+	cmd = claim_pairing(conn->hdev, conn, NULL);
 	if (!cmd) {
 		BT_DBG("Unable to find a pending command");
 		return;
 	}
 
 	cmd->cmd_complete(cmd, mgmt_status(status));
-	mgmt_pending_remove(cmd);
+	mgmt_pending_free(cmd);
 }
 
 static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
@@ -3729,12 +3742,16 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 	conn->io_capability = cp->io_cap;
+
+	mutex_lock(&hdev->mgmt_pending_lock);
 	cmd->user_data = hci_conn_get(conn);
+	mutex_unlock(&hdev->mgmt_pending_lock);
 
 	if ((conn->state == BT_CONNECTED || conn->state == BT_CONFIG) &&
-	    hci_conn_security(conn, sec_level, auth_type, true)) {
+	    hci_conn_security(conn, sec_level, auth_type, true) &&
+	    mgmt_pending_valid(hdev, cmd)) {
 		cmd->cmd_complete(cmd, 0);
-		mgmt_pending_remove(cmd);
+		mgmt_pending_free(cmd);
 	}
 
 	err = 0;
@@ -3762,7 +3779,7 @@ static int cancel_pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	cmd = pending_find(MGMT_OP_PAIR_DEVICE, hdev);
+	cmd = claim_pairing(hdev, NULL, &addr->bdaddr);
 	if (!cmd) {
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_CANCEL_PAIR_DEVICE,
 				      MGMT_STATUS_INVALID_PARAMS);
@@ -3771,14 +3788,8 @@ static int cancel_pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	conn = cmd->user_data;
 
-	if (bacmp(&addr->bdaddr, &conn->dst) != 0) {
-		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_CANCEL_PAIR_DEVICE,
-				      MGMT_STATUS_INVALID_PARAMS);
-		goto unlock;
-	}
-
 	cmd->cmd_complete(cmd, MGMT_STATUS_CANCELLED);
-	mgmt_pending_remove(cmd);
+	mgmt_pending_free(cmd);
 
 	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_CANCEL_PAIR_DEVICE, 0,
 				addr, sizeof(*addr));
@@ -10137,14 +10148,14 @@ void mgmt_auth_failed(struct hci_conn *conn, u8 hci_status)
 	ev.addr.type = link_to_bdaddr(conn->type, conn->dst_type);
 	ev.status = status;
 
-	cmd = find_pairing(conn);
+	cmd = claim_pairing(conn->hdev, conn, NULL);
 
 	mgmt_event(MGMT_EV_AUTH_FAILED, conn->hdev, &ev, sizeof(ev),
 		    cmd ? cmd->sk : NULL);
 
 	if (cmd) {
 		cmd->cmd_complete(cmd, status);
-		mgmt_pending_remove(cmd);
+		mgmt_pending_free(cmd);
 	}
 }
 
-- 
2.43.0

