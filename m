Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076D430649C;
	Tue,  1 Sep 2026 15:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788277492; cv=none; b=Bd/n5hrnW/5WPqvCYHg+QdxVq3RCoBqmx+SjtBvfbLnloXhntC8mZYtao6nfUv3RKoV9R7z3fTBRUbnXdh0oQb6bMtNTBt79CJ3awYvb1I0jaBeviRgzvLHv/+nJnCB6uKWcNJT2MRDS0X4+VsveEs2GVDd08qXW+AQYUQ62sDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788277492; c=relaxed/simple;
	bh=zkeUpvHYxowjGSjJIdJQCsPLMVgQMKK9RMuE+rzCm4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gP5p6Hkg2WvSWJ+fm7x9WitfLUEnxW9nZZfUgep1JChUF6aHIk9lM8uAuOxAXY5vskciV/rWeiai4BJhJmf7fXzbUgg0L5GillqUCfHCzVfhNRcleAheNzo1W6oWmoERuwi3mbyz20M0XXZYbBndSXCQK+lG4wdrEw01TpSGJSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeXEXa4j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeXEXa4j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480F31F000E9;
	Tue,  1 Sep 2026 15:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788277490;
	bh=1tch/WQKM55fDJLl/Qo+nJxh09lQVygvGYpF+71lhlw=;
	h=From:To:Cc:Subject:Date;
	b=UeXEXa4jC7igD1Axs0IJzp801xgE+3oTQH86Nq7UqVTjqDZbmHUfTadTWU3okLdAy
	 RwqmD5XL4+uTBbqC42K91S/UulW6cwf7Vb7xpvvizCGHmTIZHoXNHpxSBnpUDbC+Le
	 apXAdjBtqPM+6LXeJoUenF1oDSFi1zemsPBsfOnVNAMwmBAJ4tFl0oCqX3828sVs2U
	 ULagZTVagynduPPNYt52wXZaW3LSofmyqofpSQ3bY98hJYCF3izxvu5byeak2WZQuF
	 Ub+fOWLIthFiZ+I3KHwn+9OFOi5VHQAC6PM2pJSuc/mvfnCm/In2yQRhO3tlJho5hq
	 2kq/Dpy7PJiSQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Brian Gix <brian.gix@intel.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 1/1] Bluetooth: mgmt: Dequeue pending mesh_send_sync entries on cancel
Date: Tue,  1 Sep 2026 15:44:26 +0000
Message-ID: <20260901154427.3991920-1-lee@kernel.org>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In send_cancel(), pending mesh_tx objects are removed from the
hdev->mesh_pending list and freed via mesh_send_complete(). However, if
a mesh transmission was already queued onto hdev->cmd_sync_work_list
via mesh_next(), the queued entry retains a raw pointer to mesh_tx.

When hci_cmd_sync_work later processes the entry, it attempts to
execute mesh_send_sync and its destroy callback mesh_send_start_complete
using the already freed mesh_tx pointer, leading to a use-after-free.

Fix this by invoking hci_cmd_sync_dequeue() for mesh_send_sync on the
target mesh_tx before completing it. If the entry is found and dequeued,
its destroy callback will complete and free the object; otherwise,
mesh_send_complete() is called directly.

Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 => v2: Email address switch - no functional change

 net/bluetooth/mgmt.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fd045460e236..f10cf64fb79e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2427,14 +2427,20 @@ static int send_cancel(struct hci_dev *hdev, void *data)
 		do {
 			mesh_tx = mgmt_mesh_next(hdev, cmd->sk);
 
-			if (mesh_tx)
-				mesh_send_complete(hdev, mesh_tx, false);
+			if (mesh_tx) {
+				if (!hci_cmd_sync_dequeue(hdev, mesh_send_sync,
+							  mesh_tx, NULL))
+					mesh_send_complete(hdev, mesh_tx, false);
+			}
 		} while (mesh_tx);
 	} else {
 		mesh_tx = mgmt_mesh_find(hdev, cancel->handle);
 
-		if (mesh_tx && mesh_tx->sk == cmd->sk)
-			mesh_send_complete(hdev, mesh_tx, false);
+		if (mesh_tx && mesh_tx->sk == cmd->sk) {
+			if (!hci_cmd_sync_dequeue(hdev, mesh_send_sync,
+						  mesh_tx, NULL))
+				mesh_send_complete(hdev, mesh_tx, false);
+		}
 	}
 
 	mgmt_cmd_complete(cmd->sk, hdev->id, MGMT_OP_MESH_SEND_CANCEL,
-- 
2.55.0.897.gb25b4bd76c-goog

