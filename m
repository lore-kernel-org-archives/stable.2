Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1071D54FA
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 07:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787038396; cv=none; b=pPdCCABeHhhKj/bkdzyqcxKs4AF11UjFYWzQBeUJFlfKDuuuOy8tix3PcwJe1XSvBWpJoaWBxx7IBFO/WsN2+/Zt3M1qqtLAqHcS0Y95tZBvlZ95ZS183x49RgEBTDSx7ONlmV2sMozEJJvqwa2M7ycVt/MsKzSd9hahlRb9NDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787038396; c=relaxed/simple;
	bh=yXgCy1ZNVXJy5+9cLGZeE5uyn6X/ULoiPOSTm8c6YUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cEcNMxudnU17qVsCQNcYwpd+11Zq7OrpUaO7ZK8UA3PyPQSmWlWoRHEUTlf8eYwmUytQVwWkTScXrNDrTUm3qzNMVogS6UoXl7agYQMtqh14FiAlJbkxnzcnl1nyqFMUwmpBNUC93vxa1u5EZiDjqKx2MZdgtfr1wcBhABjDZ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=omGXeGGH; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omGXeGGH"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e58034d05so3298123a91.2
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 00:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787038394; x=1787643194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/uWawcNhMBUKk6HeN3hgFqps7RI+QPHqIhbrb/vDwOg=;
        b=omGXeGGHNIVr4TSBnze/IEREK9nZDy6QmfMeBoJivBQcQ607dwapdT8HOq39RDtdeY
         StbpV61/c+WRxZ9tztgegXoA8vFj2b1w6ccV1PAj1+oRhf4YpO3umDEGrtr2mGwdx547
         OJEgP78J4XyNy+qBewNVdWEWSkSy1cBta+YywQcmElijr6Hi/D7Gbg5YgopRVo1cYpwP
         vEwR2nl7szCUVtzymiao4UMBUe4TerhY6F0zG68t4gnuM9Wf6OgtopEM6qPrLQEisSyC
         KpQhJorAvFmWh1anSsSrQ2U/gS472ixyN+R/FHgi3d4E6lHN1Sr4FVlRU/exLXcUkqoi
         krNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787038394; x=1787643194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/uWawcNhMBUKk6HeN3hgFqps7RI+QPHqIhbrb/vDwOg=;
        b=qC/zhq2ong8C1TAUiQXOt7ri4+YdN3kL9GX0c16LHBHoB16cm1DdrjOKaKjus3Xrac
         GmNgbjmHcVMBL1UsimEm8sUZbtOKcAMLEm7EjA2tnefuLmEhlxaYPbtw2/554kZhgcut
         9Z+qiq6rO8Gxgfyk0MRbeTTbrsKC6W1rCOr+jU/lLiAcWohmhhv1V907j1tV8+HWEb9s
         oEq9RL2q2P0d697UKVhlr6yYSdMZPU4lLcb+TPfqP6xKhfvkgj8WppkFuqy5taFURxzz
         lspMQ2Jo6q1vzsP7pkd8RlNI1l8RjbIsMzlHwTPqqlfmzNZsEB7y/1xH/FO3UhABenOw
         CNvw==
X-Forwarded-Encrypted: i=1; AHgh+Rq/0/jvRtNvtdPCEbN9QhHtQd0f80lYT+08Bh63wEz0aQX64tFkzvREHnrmI3Bh2MTyFtOCLuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIPn6FGkX1weEHIYKmFFDIHwhvxoJVOvm4DRUcN7IZvXrG1yk9
	Nn1U2lcoNhYOOUnEEFoqFqceMtpyJ1NdWCijOB5PffHTQsJqlvRLqJM/
X-Gm-Gg: AR+sD11IkMVWQQWftPHButaCrwWnSqvDj1ZmdSoTofOzvTtbwKUWTzrPXYjuCdgqyil
	8BvDpNXoYtUlkNq3WdG1Vy5UpL1WIvnRrHBnVDOs7Hmk8uUuKykaSAWtZ5tcqDtv27gAWZDoruc
	rX71b25+EJji2oVKON44zpCVBusMe/lAkTOjAo6J2l+tRE1Q6r6Rv9QHgQhCvrfe25LfXxREzc+
	iyFAphqyZzzuZtO0umPZo6Q6eZhWqHBrRwSPcozTqGNdqYu8RFZgLWsnBbbQ9hug3NWo9IUFn65
	f7ZJsK4xhrANQu3jucksWrr7stKVA9KPW8q21CScduDqcpPJi8mGKKgAUuqtx5q5UuV7y+boo5t
	5/MKes4FiTZ1b2DtZKXCGiFvejWX8/Fey4D2txwM7u+khR/NRlvGKsIvEs7iWXSol8sZGO2wKll
	91j+d02PbLF66b0HvUJwp7qwmSEYOCS0WwyahM/hihH25Jwk4l0sCbqjy77DHW/RxAiVk=
X-Received: by 2002:a17:90b:3941:b0:38d:f5bb:e0f4 with SMTP id 98e67ed59e1d1-3955a3dadfcmr8356105a91.1.1787038394439;
        Tue, 18 Aug 2026 00:33:14 -0700 (PDT)
Received: from localhost ([2402:e280:3e0d:544:91b3:77c4:f31d:d706])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327af7934cbsm3654442eec.6.2026.08.18.00.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 00:33:13 -0700 (PDT)
From: Vaibhav Nagare <nagarevaibhav@gmail.com>
X-Google-Original-From: Vaibhav Nagare <vnagare@redhat.com>
To: horms@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: andrew+netdev@lunn.ch,
	matvey.kovalev@ispras.ru,
	Pavel.Zhigulin@kaspersky.com,
	aelior@marvell.com,
	manishc@marvell.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vaibhav Nagare <vnagare@redhat.com>
Subject: [PATCH net v5] qede: Fix NULL pointer dereference in TPA fragment processing
Date: Tue, 18 Aug 2026 13:03:09 +0530
Message-ID: <20260818073309.2266072-1-vnagare@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Under memory pressure, the qede driver encounters NULL pointer
dereferences when processing TPA continuation fragments.

Commit 8a8633978b84 ("qede: Add build_skb() support.") accidentally
dropped the assignment of tpa_info->buffer.data in qede_tpa_start().

When memory pressure causes an SKB allocation failure in qede_tpa_start(),
the driver sets tpa_start_fail = true and attempts to recycle the physical
page later in qede_tpa_end() via qede_reuse_page(). However, because
buffer.data was left uninitialized (NULL), qede_reuse_page() pushes a
"ghost" BD (valid DMA mapping but NULL data pointer) back into the
active Rx ring.

The next time the hardware uses this ring slot, it passes a NULL page
to qede_fill_frag_skb(), causing a kernel panic.

Example crash from production system:
 BUG: unable to handle kernel NULL pointer dereference at 0x8
 RIP: qede_fill_frag_skb+0x96/0x430 [qede]
 Call Trace:
   qede_rx_int+0xb06/0x1de0
   qede_poll+0x2f4/0x6c0
   __napi_poll+0x2d/0x130

Fix the root cause by restoring the tpa_info->buffer.data assignment
in qede_tpa_start(), ensuring valid pages are correctly tracked and
recycled. Additionally, update the stale comment for
struct qede_agg_info::buffer to reflect its current usage.

Fixes: 8a8633978b84 ("qede: Add build_skb() support.")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Vaibhav Nagare <vnagare@redhat.com>
---
  v5: Addressed AI review feedback from Jakub Kicinski:
    - Dropped redundant fast-path hardening code (NULL checks, early exits, 
      and consume/recycle loop logic) as the root cause fix makes ghost BDs 
      mathematically unreachable.
    - Updated stale struct qede_agg_info::buffer comment in qede.h to 
      reflect its current non-preallocated usage.
    - Corrected commit title formatting in Fixes: tag.
  v4: Fix err: label handling as identified by Jakub Kicinski:
    - Restored tpa_info->buffer.data assignment in qede_tpa_start().
    - Reverted err: label in qede_tpa_end() to use tpa_start_fail flag.
  v3: Addressed AI review feedback:
    - Fixed NULL pointer recycling and array bounds check order.
  v2: Addressed AI review feedback from Simon Horman:
    - Added net_ratelimit() and fixed NULL buffer recycling.
  v1: https://lore.kernel.org/netdev/20260709044704.141507-1-vnagare@redhat.com/

 drivers/net/ethernet/qlogic/qede/qede.h    | 8 ++++----
 drivers/net/ethernet/qlogic/qede/qede_fp.c | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede.h b/drivers/net/ethernet/qlogic/qede/qede.h
index 042a75f34060..0e7a0c2c1765 100644
--- a/drivers/net/ethernet/qlogic/qede/qede.h
+++ b/drivers/net/ethernet/qlogic/qede/qede.h
@@ -303,10 +303,10 @@ enum qede_agg_state {
 };
 
 struct qede_agg_info {
-	/* rx_buf is a data buffer that can be placed / consumed from rx bd
-	 * chain. It has two purposes: We will preallocate the data buffer
-	 * for each aggregation when we open the interface and will place this
-	 * buffer on the rx-bd-ring when we receive TPA_START. We don't want
+	/* buffer is used to retain the Rx consumer descriptor when a TPA
+	 * session starts. If the SKB allocation fails during TPA_START,
+	 * we use this saved buffer to safely recycle the physical page
+	 * back into the rx-bd-ring via qede_reuse_page(). We don't want
 	 * to be in a state where allocation fails, as we can't reuse the
 	 * consumer buffer in the rx-chain since FW may still be writing to it
 	 * (since header needs to be modified for TPA).
diff --git a/drivers/net/ethernet/qlogic/qede/qede_fp.c b/drivers/net/ethernet/qlogic/qede/qede_fp.c
index 33e18bb69774..2d42e51ff992 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_fp.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_fp.c
@@ -845,6 +845,7 @@ static void qede_tpa_start(struct qede_dev *edev,
 					      pad, false);
 	tpa_info->buffer.page_offset = sw_rx_data_cons->page_offset;
 	tpa_info->buffer.mapping = sw_rx_data_cons->mapping;
+	tpa_info->buffer.data = sw_rx_data_cons->data;
 
 	if (unlikely(!tpa_info->skb)) {
 		DP_NOTICE(edev, "Failed to allocate SKB for gro\n");
-- 
2.54.0

