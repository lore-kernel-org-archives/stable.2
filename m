Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792877944;
	b=Sm6Ol7n3+6CsUY4qepVmYKW53+WLWlPj0TBEGXd7tWayE+l6QJRGpjtpm1pwNuJx/gY1
	 ZPi48ERAhuMsxf5AMKk4MXQ0McbbAw/treiO8EjdVcDLnq+ttBKRsYIGoHvH5iaAXBV5q
	 PCB8pWPc0F8IDGfuNy8m7hPnw8pdXcd9+5ULzLt0l9DN4BRx2cdwFSts1VJMoUxbPtlNS
	 v+H0ZDmbviTMO10E+lrt03HrEwVI48OdAqYO1yXf7qHlRky00XIieumpSk6MHu5SRfvci
	 9LYvTnXuANfub41VUv1oqFepr3XSqWumzKipY8MoHywkg0fEomm5YW7ThjvrieETcQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792877944;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MWhF1KWrf55vCpf16EXuustcrkVB/1ZS8QurJvWheCo=;
	b=Xy74OCEiXGYR/RGOcqphR4Mscl48WUdnbq+mBloawox7PiUryT5r1mZFtFlntqzej3jY
	 AcCcuBNlYQChDQq1I8+Ef4avZ3bwnn5FzQva7E/6q3Uhf0G+bU7pRhxt8HMYqvLBpJV8u
	 KV0A7rGe68imr+NFyP9/W+yZjFQ3s0U5vRnyIb2jq5Kox4c35PA16Vrf8j5SxvBD/zgdw
	 iUnJpelOeMPZJjGB3SSttBCjZ1go2Sp5XnvwXOXcBy72vQqo5K4BpE54yBlrdZ4Qk+ZkA
	 8lds4ago+tqD3Xj3az3/bGJkaH+ZsQ2mELInjYp+1oocRl/yn4hyl4eVBkJenX8wFLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gS6r+YXC;
	arc=none smtp.remote-ip=209.85.222.52
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93B6606A31B
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 21:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B93B6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gS6r+YXC
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-98c6e050c5dso974834241.0
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 14:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792877942; x=1793482742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MWhF1KWrf55vCpf16EXuustcrkVB/1ZS8QurJvWheCo=;
        b=gS6r+YXCZjw4fHLITryR3Gklt2m0L6X8j1EbqX+DvixHBTUurcoh7fSmTx017YUFJd
         PBvFHiRiauhfDG8NqGSKOgbo+Bb5UfzP5VLNkDjgWLRLbxX/ChtlSUgDzJh4pW0XrHGN
         MiNUV3RXEsqkNSrcrDmV2uMUM3xyPTw12XI4vwYS2LXxOaWzzEkdxjNSB1asqxe17sN3
         KGPQLGHU4naPIDlZk+K3P9SilETLT11fPQu4ZyI71qTioMhyWOM2XnnwlLJUFbRd1HSX
         08OSUyMLN0BpDVnMqzen5AhyPgvgf9yfuMDs6Pji6tdUnp2yuOUOcNGGVVGDcbZ9EKTg
         JBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792877942; x=1793482742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MWhF1KWrf55vCpf16EXuustcrkVB/1ZS8QurJvWheCo=;
        b=hR9nOReMY4lT1CrAu7xJQuclahWWNDWU+T4LA5R536Ttv1SyBTk182iB1XF56hRhdW
         G2oqjKU/r6/8gjKzV8KYn5NbabgNvPK1oulKxrNUC0AxmW9R92UkZlkWKFr9C1vGzo1g
         4XrXzAYYpMkV6VAG1PEmLyRj3EWLxVq/Fae6e6cXn0bhA08WsqwnubJEWYfvVnvLKYSO
         17s2ZMGDwjaO9LEU6bUIV2Ek2g8Idxf8iEfYHT96Q2J7a0NmIz9RYRkmB0T6sjfXfr9B
         HWw/O/BT3aVgTvFCjgw01PTb0OZyUdQvWbVH+AhRZAxEf4P5vluK3j47n8/SqB9mULzE
         YGhw==
X-Forwarded-Encrypted: i=1; AKwUvByViSvYGDc4sMbEWQtKABpNDGqlyw95lPPjqhktc46/SwZl7YwqfYfbTeY3hdgd+gawL+Teyfk=@vger.kernel.org
X-Gm-Message-State: AFq9FYK46y1S8xArc9P03yQvqNe1uxRCvKi9pdMSEnwvhwVW1pY4T/6R
	fJagu6x8oE8JRmO1zfIdKtiDYhb+plo9/CnSJbdPBiXkd/X6DgluvlTf
X-Gm-Gg: AYBFou39fsUgGYh4A+o/inMysFk2ccTK6POlKNOmN3S4gU3XC+QO1rVCrnpRUM3EYhF
	ijuoa4XJHQ21P+JmijCJRhEwe06bDZ4GUdrxLQxoblBoQL/q4W0fQxW3dQoIfxPj+ixUvb6cwHX
	qXL0scjm8chOTj6X7uhVJ7TZX9Ch/CDQBQwu/DyXEZXbRySmBbEE6buyzqRPjd3T3fFodlzpUoW
	jqbBACvxSHS2JVNk9wSTN8ik6AMYtYJmprdw9oj7KaPafx4ALhX8icbg4iviCJyVmcdR1n8CZ3j
	Aiu9a/dEPAYjBozV9kOyxuQdDWNn4wpNFiOur4jqzD0zdaST6aIe+oGyTXLHthWqSiNVXY68le3
	GAxVnTVIrVAtOFD26PglEV55yXtBRUqvyonf7+orx4dnwxIuGq9arM5zaUYM1puGe/XSFNBWPd7
	7jNPKbti/GPNgpmFgFU9uzyDJL/LMTwjRHeMciqQc7f1kI/FrqcJSuHkJQ0YuIylZwOsG21iC3v
	wPZTOcgfh8wSBeKvjQw2rwf7+ebWipGu7qyo5dIf+062caOUfDO7Ol0O5ihHP+X
X-Received: by 2002:a05:6102:b10:b0:7cc:2712:cb0b with SMTP id ada2fe7eead31-7ce5cd41502mr969522137.17.1792877942564;
        Sat, 24 Oct 2026 14:39:02 -0700 (PDT)
Received: from bridge.. ([2804:14d:ba6b:8339:de12:7640:de42:74c])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7ce5e23b13csm3128627137.8.2026.10.24.14.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 14:39:01 -0700 (PDT)
From: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	sgogte@purestorage.com,
	mgurtovoy@nvidia.com,
	israelr@nvidia.com,
	wagi@kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] nvme-rdma: fix NULL metadata_sgl dereference with T10-PI
Date: Sat, 24 Oct 2026 18:37:37 -0300
Message-ID: <20261024213737.506824-1-christian.aurichzm@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Since commit 2a8513091d2f ("nvme-rdma: parallelize I/O queue allocation
and startup") the I/O tag set is allocated before the I/O queues.
nvme_rdma_init_request() only sets req->metadata_sgl if
queue->pi_support is set, but pi_support is only set later by
nvme_rdma_alloc_queue(), so every I/O request is left with a NULL
metadata_sgl.

With an RDMA device that supports integrity and a namespace formatted
with protection information, nvme_rdma_dma_map_req() then dereferences
the NULL pointer on the first integrity I/O, already during the
namespace scan when there is more than one I/O queue.

Queues that a later reconnect adds for the first time have the same
problem.

Check queue_idx and the controller's max_integrity_segments instead,
which is what nvme_rdma_alloc_queue() derives pi_support from.

Fixes: 2a8513091d2f ("nvme-rdma: parallelize I/O queue allocation and startup")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
---
Based on nvme-7.4 (aaedcff90148); also applies to mainline and v7.3.

Found by code reading while looking at the same reorder in nvme-tcp.
Without PI-capable hardware (only mlx5 supports it) I could not
reproduce the oops. On rxe in QEMU, a debug print showed every I/O
request initialized before its queue was allocated, and with the patch
connect, I/O and a reconnect growing the queues from 2 to 4 still work.
A Tested-by from someone with ConnectX and a PI namespace is welcome.

 drivers/nvme/host/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 5b9b540693b5..07216890f75c 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -313,7 +313,7 @@ static int nvme_rdma_init_request(struct blk_mq_tag_set *set,
 		return -ENOMEM;
 
 	/* metadata nvme_rdma_sgl struct is located after command's data SGL */
-	if (queue->pi_support)
+	if (queue_idx && ctrl->ctrl.max_integrity_segments)
 		req->metadata_sgl = (void *)nvme_req(rq) +
 			sizeof(struct nvme_rdma_request) +
 			NVME_RDMA_DATA_SGL_SIZE;
-- 
2.43.0

