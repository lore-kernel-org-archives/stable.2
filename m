Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92B6369D4A;
	Tue,  1 Sep 2026 14:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788274105; cv=none; b=nDA1t3lboTyHSJche0MmdxCy0ygg4dH0Y4mP9Pq6NPIGkiNJK6CE3N6GXm5cpWYK++Da7egUKM6xYH9ALhfI7lfIIruh+LYDKiIpxRw8sDLdrSddQg+8KVqoVZMJSTqSjLMX883RqmfW3wUCcCWPCp8kYxkxN76BzjhBVaQUunU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788274105; c=relaxed/simple;
	bh=aoaQRCLFoRO7q0aD16PZxwYQ47yxsPE9HhPj7qrTizo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ryTSQjchN0kKpivuPbNBa4gxSx8fY8AsJHHCrdeHMImtpd86hzoUCJt4tlqMDCwH39XiCrVt99j4Zaw8Tz1OfzuFt7e3P168s0xjL1cb+YmCafsMPE+EWCL/5hJvXXlzzHQigboN5HNjBwYzmZ3uLvPWdKI0cfuKhMvsHb3SEy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHFCV8k3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHFCV8k3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3260A1F000E9;
	Tue,  1 Sep 2026 14:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788274104;
	bh=tguPn4udisDsykWgz8LV7cIvvILaSUz/I72nsYvlM9E=;
	h=From:To:Cc:Subject:Date;
	b=cHFCV8k37cqjTg3Hw89/0s3yJbFr5lnpp5Dz46AZ1WJXxMMzLDVMui269EogB5DKa
	 4OFkUeURuNEdSYHqBdBf1MOej605+Rr5mhsrM71ZBl7FMKm6+hQhtI/Ar/T4L4O5S3
	 JgyejVKsKe2gp7jR4De/DF7BMbngYNMB7YdQks8SAe9RAiLSFX7NtHj5/UJcesE3sX
	 g07wGzFC0lsZoEAHPuuJ/hZO/FYERgXCDNg3Svoqup5uV/Zbjq2IyoH/iOl/JbjCMP
	 nxSL6H/oQ5wpj37S1ee3cLi+30IhaNNzQUWu8x5iL6R8hnkS/ichzGFJvBzu7+Hiqn
	 RorG6T+ecAukg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Brian Gix <brian.gix@intel.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Jones Lee <joneslee@google.com>
Subject: [PATCH 1/1] Bluetooth: mgmt: Dequeue pending mesh_send_sync entries on cancel
Date: Tue,  1 Sep 2026 14:48:04 +0000
Message-ID: <20260901144805.3941205-1-lee@kernel.org>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jones Lee <joneslee@google.com>

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
Signed-off-by: Jones Lee <joneslee@google.com>
---
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

