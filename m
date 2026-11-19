Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795092120;
	b=ecstEr6IPow1y3gMgv6+dvpO6spCXgME2FCtdjPWiyIVfT8D2cOBjelTX5faGN4wWA61
	 QzVaaoN+Y7/2620/LNSsV8qUEmwJNL1kG3sYrORSz9mGhtPlgvKZesA7L3D5zx4e04c5l
	 20oKdqD4l5EQZl2biacU276IX4OBRBf2cJSyWdl2CswRWBpjmbctHLDYuOIiCOvwkbfhg
	 PWwAkAw8CHbdPqpaZ9fdZqiwUsHcpZvKqyrdqQAbUkHem7Y3MhDnOkIgDF2+IglN0wV8j
	 IZm+FCTwiOWQ5UdVByaNFS4onGeIHXHfmwesqs2xH6Ejt3J8iJd9AyCA+qOGwhUktHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795092120;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mOE3Rbuw9z95CS+e89nm2qahBlkxcAeUx3ho/7BXMuo=;
	b=IeBIToB1qdv3NWiypZ0v16cmNNldwfcmMq7XSfqAl7UYn1wyLn/Oy6cSOam164YHXXRf
	 1h6himL6qsgRltq39eWIIOn+GKmKZxwFyWXgiiOtE8Kj/ZaHnqnilzYZMui1rDA7NTv/y
	 UpmedYN6lrKfIMcltJm5ZQ9cTosGVwPBYxzJRlNlFa+3I7J9iUMqXSSmdNo219Mt5ZyCM
	 2jMtODDphpaXxuZuG2281xCeYcXc+miilxWRtB46sQXMWMg0tYcOejg6rQqpB4O5pYzK1
	 MOG/NbcghGonfMarsWLZt+IT2cKE0GPYKcHa+7QKFqHdGI8CX61CDzUEOywGWsMLDgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudlinux.com;
	spf=pass smtp.mailfrom=cloudlinux.com;
	dkim=pass header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=Y+hvqyrA;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA7E606A326
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 12:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BA7E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=Y+hvqyrA
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4a3e706b5dfso1399443f8f.2
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 04:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1795092118; x=1795696918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mOE3Rbuw9z95CS+e89nm2qahBlkxcAeUx3ho/7BXMuo=;
        b=Y+hvqyrAvGs1ec1QqlTmDLvfzSnWLZKXPNuQfzHstZzH6CQDJajImBeCM9q8kNfhlC
         mMAu4BmEHpD0TWRgFv0ncKdEXUrid59k9CHQPoHAMYq9YUV1cDOgePkSgyZT3CWwo8mc
         zb315Ys+BB30Y9yA9VQwZiroXOyIPodeVJ4YXiN1Mxs9HizQO9omoJIqcaK66mYpkH3b
         7ClQZBJRXaMrhdPPhMO8lizh0XGQEGU5arOWoQo8pvyFM6INoa4ENeB+tAj8m1VS0C0p
         xB5rgeun8fSdPb49E6voZgYy/s8YPz9GYSlN6SoxpO61zrNHQzMsX96yraVB55dIPoRN
         N78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795092118; x=1795696918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mOE3Rbuw9z95CS+e89nm2qahBlkxcAeUx3ho/7BXMuo=;
        b=MKrRP2jZB/yYztFYVucU4DfZU70q8xa1kteIV+E1nhOWHth8i3rU+1EoOitvdlgtQH
         qis/M2cgSrf+AgYnpORLVFXLDPfnqMFM4hDf33hePxSrseKKvWPk31GYi4JBGgR6phlr
         b8gqrx2o34Jq5IOqVg3vEFLoknsT0W1XuY4iZQtueD/hGyzZrVeW6Yl1wt+SEBLXwdWR
         ukIlLSQOwL2qqoDJvZ+mdCmUYvYVEUbGuoerwgZhLI58Itnxbl49Aqid3RhPKAQ7Occ0
         Y6QojRYS+6Vpk+vkT9bMWBwQX4iDGRt+xxu4pR0/dw6qY8gaVx2ZsZNRHe3fcSmDzbxO
         Nh5Q==
X-Forwarded-Encrypted: i=1; AL+hErGTQ33Le1IuNQ70nim3ZrLJnVfMCpLOwehVQxWJTiP6QEC1c+NDXS5LiutgrznccttP7s+IsP4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8qTYgIh8kd1a5owOKocJQY+xBdbhleK/+W0a5xthdlZJRaVmvT
	j7M7/MAfU6Uox+wSslaZR+9oiLtM1t/eop5H5UQAqjfssr3WKr/mJ5gdk7dEG7DLMotVCz0odW6
	EemnMJEg2Mg==
X-Gm-Gg: AZFdTZfAROB3lC8NntkDRiLI7Zo6hF3jDK105lWabl080b/0OpY5X17oTWkITKPIAyp
	8SJReaKO8A9ct9SrsP8/Ct+Od9DTEyYnzgUKjsrJwO/W/4Mf/tyeQ3yMPNO/7WT4zO0sekNLezq
	diFvzMo1By8Lg8XnbmJWN4tkzqnOZ7F3NgGMwzDexU9BU+tnrz2Q3PKrJmedsUADAnwzvlrk7w0
	LzmtW9RsOKnq9qMsxk/DXemEyFvMvnFRLma1CdPVkIslwAIKRr/FWvJjASoK76ZllE5AnwjXUVf
	pxihd7QJ6XenHq5tN0pWuaFN+ynvPVrqfBSFmUHljYqYU4/xu2u9s+TsL8RF7ug9vwWRjbXpQd+
	G9fQ4nmrbyjT8nH4AkrRyhqTCyWAwJ8/++HIjN4ShrAZq7MOXqXW3VLCQg1UkCWibgjpozY3uDw
	hlOKtLcS0GF3VVMbadn7W+8rztHWgdJeH7lA2Zk9Drws5MJpfyN+Ts5B+7c4IydjaR4BERAmuWK
	f+hKurAeOg1SAVZVzbBnkYpTQH1Mb5U7+UjqMtmll9w/7VsE+xrg8SI1TqY59/D/nSaq47QdvJ2
	Or5WWYn+jqAcNV1N4+49BV5p
X-Received: by 2002:a05:6000:25c6:b0:49d:7e8c:e89c with SMTP id ffacd0b85a97d-4a63d985dc9mr11927185f8f.42.1795092118533;
        Thu, 19 Nov 2026 04:41:58 -0800 (PST)
Received: from dev1.kernelcare.com ([2a01:4f8:172:1c85::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656a28b8esm10787266f8f.50.2026.11.19.04.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 04:41:58 -0800 (PST)
From: Andrey Misiurov <amisiurov@cloudlinux.com>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Cc: linux-rdma@vger.kernel.org,
	Quanye Yang <quanyeyang@proton.me>,
	linux-kernel@vger.kernel.org,
	Andrey Misiurov <amisiurov@cloudlinux.com>,
	stable@vger.kernel.org
Subject: [PATCH] RDMA/ucma: reject a second join of the same multicast address
Date: Thu, 19 Nov 2026 13:41:53 +0100
Message-ID: <20261119124153.1745521-1-amisiurov@cloudlinux.com>
X-Mailer: git-send-email 2.43.7
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ucma_process_join() lets one cm_id join the same multicast address twice,
creating two ucma_multicast objects (A and B) and, via
rdma_join_multicast(), two cma_multicast entries that both point back at
the ucma object.

rdma_leave_multicast() matches a leave only by sockaddr and destroys the
first entry it finds. So LEAVE_MCAST on A destroys B's cma_multicast and
frees ucma object A, while A's cma_multicast stays on the list with a
context pointing at freed memory. The next event for it is a use-after-free:

  BUG: KASAN: slab-use-after-free in ucma_create_uevent+0xb11/0xb70 [rdma_ucm]
  Workqueue: rdma_cm cma_iboe_join_work_handler [rdma_cm]
  Call Trace:
   ucma_create_uevent+0xb11/0xb70 [rdma_ucm]
   ucma_event_handler+0xd5/0xa10 [rdma_ucm]
   cma_cm_event_handler+0x98/0x310 [rdma_cm]
   cma_iboe_join_work_handler+0xac/0x170 [rdma_cm]
   process_scheduled_works+0xb59/0x1890
   worker_thread+0x470/0xe40
   kthread+0x33a/0x450
   ret_from_fork+0x59/0x90
   ret_from_fork_asm+0x1a/0x30

Any user with access to /dev/infiniband/rdma_cm can trigger it.

Reject a second join of an address already joined on the same cm_id. The
incomplete fix 662ade4de9ff ("RDMA/ucma: Serialize join and leave on
copy_to_user failure") left this path open.

Fixes: 662ade4de9ff ("RDMA/ucma: Serialize join and leave on copy_to_user failure")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Misiurov <amisiurov@cloudlinux.com>
---
Found during a backport review.

Reproduced on debian13 6.12.88 debug (KASAN=y) over Soft-RoCE: two joins of
one address on a cm_id, then LEAVE -> the KASAN use-after-free above within
one run. With the fix the second join returns -EADDRINUSE and the run is clean.

 drivers/infiniband/core/ucma.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1509,7 +1509,7 @@
 {
 	struct rdma_ucm_create_id_resp resp;
 	struct ucma_context *ctx;
-	struct ucma_multicast *mc;
+	struct ucma_multicast *mc, *tmp;
 	struct sockaddr *addr;
 	int ret;
 	u8 join_state;
@@ -1544,6 +1544,13 @@
 	memcpy(&mc->addr, addr, cmd->addr_size);
 
 	xa_lock(&multicast_table);
+	/* leave matches by address only; refuse a duplicate */
+	list_for_each_entry(tmp, &ctx->mc_list, list)
+		if (!memcmp(&tmp->addr, addr, cmd->addr_size)) {
+			ret = -EADDRINUSE;
+			goto err_free_mc;
+		}
+
 	if (__xa_alloc(&multicast_table, &mc->id, NULL, xa_limit_32b,
 		     GFP_KERNEL)) {
 		ret = -ENOMEM;
