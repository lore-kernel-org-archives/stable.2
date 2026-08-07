Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0938A46D2A9
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 10:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786097743; cv=none; b=lOKjgzBviu0QRjZji6DUvXSBOwiRZYPzWEiPxuz9IoqVMk+XOMkkCcxcapAqnL7BGvuONNFaspNxG1d/4e1jxpSKHSGG+dYsXm8EzxptvcwjC/wW78BAQaYulEk2bOMA/xFoBwbQ3bcBr8dq9p/xI97x80tdDcfIU3J97Xi2slk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786097743; c=relaxed/simple;
	bh=kLNvQOI2KWi69kGT4uOy3bq2UCPhytklYAXV/hPhocY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rgharpm+zA8yywfgNKl+/6HxRdpdoRE0Z094nEY+ecSEL1d6BjKyHSNVq2Ui/2ffMpBCDbOlU6q1G+iHCWGCyuCnWt5K9QYqdWjg7P4qsc1OmwVGKMZvcd/+YJOJW3qhI3CDFcpPJ95fqcgfAk/FfMy/e9yiAEuPhA37oZabq8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=GbRxTnV2; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="GbRxTnV2"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ceab75934dso41177185ad.2
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 03:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1786097740; x=1786702540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=33iS9GD+2kf8NxEqo3fmWkVmRcll+fyKNqedyFrk32I=;
        b=GbRxTnV2qxKHa5oWvESnsfUmBcbnwRGk93mkTt4PcpxPypLv09PT2qsbGAOHMF5123
         jMXcaiJkZE80grgqG6GWtPVeKmBqrvX2ulQ/fqcYAPjoGp8jzCeH02I1kPnPN1aNSDwJ
         K5rz8oLB4QffxySHMgILapJ4zkhFbjLfZXFV9OzdO4xlDIqc4qGvJfMLBhqLErjUAva/
         8qtsOQTPXWjKKAE+BP/mGUSgD/qC7GDjYc3tpZn+O5EV1PQhCmUKz91lMHndkbjARxOW
         4//d5sxWg3PW39tAg224HZ75k6s7hB+PCHmW+XbCvPCTQU/r+BG1MUDB59r1egWScbEM
         /aKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786097740; x=1786702540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=33iS9GD+2kf8NxEqo3fmWkVmRcll+fyKNqedyFrk32I=;
        b=mpz4EbV0Al21JOoYN0csghT0Wz4O67lEooSfuFJaMPU66eKJJGqth/m+H+D9u0Ok4Z
         oo5ZLr0hMVF/Gv0zQLXxLy/g/oPk9rSHmX/Q7WbsVdvDVyHszqyyQDGnqLZ2y8t2/Rl/
         N4gO391SqmePbCxQcSxUKSodscEb1qiXJWMhY1h4gpuYgo06Is0esQa2hxX8nmnKMfCL
         +1rvsgzVKjF3jlJ68SD+abVkJwXfyLvADiI8/IsHHIv3gOs+PFSfLdGNC43CBTgyCwg5
         UJ0U47ZOaUdptEae4MpLgKlw2HYDVcYP6IEaZ4BkSJ1G8wlXirKqznGNbSjwbx5GSp9A
         jusA==
X-Forwarded-Encrypted: i=1; AHgh+RozDmiJJ1THB4/Xocvd8MwCJuVKmUZkSx3D62uIaew2S0CjO7qmPbxdqBatBi4GEBY8fZeadqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbNhf4kqIgqr3VRlAXP4CU9eVQKmU4Krnuob5ayYvSV9OKyDdQ
	0rQ43Kxng9IG3US/N45l5erjUeG4t7+FKdsVxdf3fgqWc6WxTVjC5nKaJiO73GvVCNI=
X-Gm-Gg: AR+sD135Mjy/9fIOB2GnjzqPsWsEwM3RCyvqRPd8jxEnlVPhG1IJuHEYZhYBxHA+ugB
	jSveltt1J6EG+EWhehl/OYvOMcACqunq6BMcgf80svcNXvT6SzHwOj7T5ZBmjeUFDtB3JfAT+hS
	0CcSLlNj7iBytZxtLQrR0WZ4WiUTh+ld0Oqe7g6zvXwfmfm5OhwoK3ZTgY7n4l3W7PIi6ajcRpv
	4IZYwEtdp5dYD0iSV/EprTIqSazxlcHXc8YORFH2sQQ2DUgh8eVBWUxbgyEMS1pbvZrttB92i9q
	tVngwEsXamjy4zVQ8+fZU2he5+XcwNi7OtE+MXzmMVM5QF3IpjIIYHJFsyiI6f/bcGzqkTQkavC
	qGtHzULBF3b1W/JVqdf8FB+/SWUDPjDhgXdTxy6y7lZijr8AEc+GuIG9Fnc+vxp+Wd3t7JM8iRn
	Si7moQj+YtfJsJF32xmUPYrspN3ZFZmF6WrpWRYaBYwElMbvnoLL/ntN5PkpkUhlXO+FU600Zac
	zJW3ZyefOPGQ+EVU6flciohVksSZ4+ElOB7ykm2LbE=
X-Received: by 2002:a17:90b:1c0a:b0:38e:ad9d:1161 with SMTP id 98e67ed59e1d1-3903b9eab48mr21056655a91.0.1786097740132;
        Fri, 07 Aug 2026 03:15:40 -0700 (PDT)
Received: from localhost.localdomain ([1.220.41.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085dea04bsm4399162a91.8.2026.08.07.03.15.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 07 Aug 2026 03:15:39 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Brian Gix <brian.gix@intel.com>
Cc: Baul Lee <baul.lee@xbow.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	federico.kirschbaum@xbow.com,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] Bluetooth: MGMT: remove the mesh walk from the socket destructor
Date: Fri,  7 Aug 2026 19:15:27 +0900
Message-ID: <20260807101529.17348-2-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260807101529.17348-1-baul.lee@xbow.com>
References: <20260807101529.17348-1-baul.lee@xbow.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_sock_destruct() calls mgmt_cleanup(), which walks hdev->mesh_pending
on every registered controller looking for entries owned by the socket
being destroyed, and completes the ones it finds.

It can never find one.  mgmt_mesh_add() takes a reference on the owning
socket for every entry it links onto the list and mgmt_mesh_remove()
drops it again, so the socket's reference count cannot reach zero while
one of its entries is there.

The walk still races the list.  mgmt_mesh_next() loads mesh_tx->sk from
every node it passes, including nodes owned by other sockets, while the
cmd_sync worker unlinks and frees nodes of the same list under a
different lock.  mgmt_cleanup() cannot take hdev->lock: it holds
read_lock(&hci_dev_list_lock) across the walk, and hdev->lock sleeps.
It is the one user of hdev->mesh_pending that cannot be brought under
that lock.

Remove mgmt_cleanup() and its caller.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
 include/net/bluetooth/bluetooth.h |  1 -
 net/bluetooth/hci_sock.c          |  1 -
 net/bluetooth/mgmt.c              | 19 -------------------
 3 files changed, 21 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index b624da5026f5..f49cec5f01e6 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -675,7 +675,6 @@ static inline bool iso_inited(void)
 
 int mgmt_init(void);
 void mgmt_exit(void);
-void mgmt_cleanup(struct sock *sk);
 
 void bt_sock_reclassify_lock(struct sock *sk, int proto);
 
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 070ca388f9ac..5073f4fc3289 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -2164,7 +2164,6 @@ static int hci_sock_getsockopt(struct socket *sock, int level, int optname,
 
 static void hci_sock_destruct(struct sock *sk)
 {
-	mgmt_cleanup(sk);
 	skb_queue_purge(&sk->sk_receive_queue);
 	skb_queue_purge(&sk->sk_write_queue);
 	skb_queue_purge(&sk->sk_error_queue);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 860c086011b7..97408904f74b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -10894,22 +10894,3 @@ void mgmt_exit(void)
 {
 	hci_mgmt_chan_unregister(&chan);
 }
-
-void mgmt_cleanup(struct sock *sk)
-{
-	struct mgmt_mesh_tx *mesh_tx;
-	struct hci_dev *hdev;
-
-	read_lock(&hci_dev_list_lock);
-
-	list_for_each_entry(hdev, &hci_dev_list, list) {
-		do {
-			mesh_tx = mgmt_mesh_next(hdev, sk);
-
-			if (mesh_tx)
-				mesh_send_complete(hdev, mesh_tx, true);
-		} while (mesh_tx);
-	}
-
-	read_unlock(&hci_dev_list_lock);
-}
-- 
2.50.1 (Apple Git-155)
