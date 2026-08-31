Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9644B37DEBF
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 22:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788214812; cv=none; b=C4LD9Fb7TFpjSjND7Ebt3t0qW32yuRLC1fX0mWhol5MFN2cAdTx8uvFi2+kWvudt1X7BxK+Sd6imEYqmyML5is/uDRHZkLpumh484UMepGMkjHAcz2btXZCpf8Nb0RCiPXIYIp0Afk3QnmOZ5UQtl9OdhAxGCGtuisarBVToCyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788214812; c=relaxed/simple;
	bh=z/FtwztOSuJdPK0bTnV/eng+WVs7jvUln2NPp2JiHkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2/NDF9VLq5NbqBEOhgsFzMGIEx43ROfoqTygbeGABmhbWNlE7Y79U/oi0reTzVlXjk56TJt80ho7/Tmfm/j1VJnjQ0QUpK48PI9YuUh6Wd2zHBzDKB9t0xTAyTCgcGtsY+v6viJ5krh/jR96obY7GATgsbXCzRcURrpHN3eBYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnQh2g3K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnQh2g3K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7D81F00ACA;
	Mon, 31 Aug 2026 22:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788214811;
	bh=pbdsYzlG5kcBLfdlXE4Rl9KLtxyDg5ixWRSQZVBCOMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YnQh2g3KK4VXqW7G2mEZ8y55fHLaFTR5uRfgbMLUSoJoiAgaiDFLpnyAy9lv4jfg0
	 mou1b/jbf8qV4mSwMGbAdaA09RtyO3zEskl99av6GI7R2904tlvmiYOdpNvPIcSQm1
	 TsPoqzdWbQiQPqNEkl20DARVf+IPT3pNm2bC2oqT0zJGwOEz32a+Hr30N/UXacg9I4
	 ygyfpewyisLaa8IXg9ah6uDXPiYH5j93sfcI6+3rr/sRfA3QHZq4BUoJlBryvONCoy
	 /lROlBy+d8902oYNc5WwZ6WG93KoxIsFTIYb4bfqV4cAAbxOyC+M92PeeO57f1PY4l
	 C+LRGjOtJEH0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	Jeff Layton <jlayton@kernel.org>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 5/6] fuse-uring: use named constants for io-uring iovec indices
Date: Mon, 31 Aug 2026 18:20:03 -0400
Message-ID: <20260831222004.1858878-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831222004.1858878-1-sashal@kernel.org>
References: <2026083142-defile-crewmate-74f2@gregkh>
 <20260831222004.1858878-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joanne Koong <joannelkoong@gmail.com>

[ Upstream commit 8bbb2ad1f687633a991839bd3efae04ccfb29e19 ]

Replace magic indices 0 and 1 for the iovec array with named constants
FUSE_URING_IOV_HEADERS and FUSE_URING_IOV_PAYLOAD. This makes the usages
self-documenting and prepares for buffer ring support which will also
reference these iovec slots by index.

Reviewed-by: Bernd Schubert <bernd@bsbernd.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Baokun Li <libaokun@linux.alibaba.com>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Stable-dep-of: fd10f40af314 ("fuse: copy request headers via a stack buffer for io-uring")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/dev_uring.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 52e7580ec88fd..95c23c3499e78 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -18,7 +18,8 @@ MODULE_PARM_DESC(enable_uring,
 		 "Enable userspace communication through io-uring");
 
 #define FUSE_URING_IOV_SEGS 2 /* header and payload */
-
+#define FUSE_URING_IOV_HEADERS 0
+#define FUSE_URING_IOV_PAYLOAD 1
 
 bool fuse_uring_enabled(void)
 {
@@ -1103,8 +1104,8 @@ static int fuse_uring_do_register(struct fuse_ring_ent *ent,
 }
 
 /*
- * sqe->addr is a ptr to an iovec array, iov[0] has the headers, iov[1]
- * the payload
+ * sqe->addr is a ptr to an iovec array, iov[FUSE_URING_IOV_HEADERS] has the
+ * headers, iov[FUSE_URING_IOV_PAYLOAD] the payload
  */
 static int fuse_uring_get_iovec_from_sqe(const struct io_uring_sqe *sqe,
 					 struct iovec iov[FUSE_URING_IOV_SEGS])
@@ -1134,8 +1135,8 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *cmd,
 {
 	struct fuse_ring *ring = queue->ring;
 	struct fuse_ring_ent *ent;
-	size_t payload_size;
 	struct iovec iov[FUSE_URING_IOV_SEGS];
+	struct iovec *headers, *payload;
 	int err;
 
 	err = fuse_uring_get_iovec_from_sqe(cmd->sqe, iov);
@@ -1146,15 +1147,16 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *cmd,
 	}
 
 	err = -EINVAL;
-	if (iov[0].iov_len < sizeof(struct fuse_uring_req_header)) {
-		pr_info_ratelimited("Invalid header len %zu\n", iov[0].iov_len);
+	headers = &iov[FUSE_URING_IOV_HEADERS];
+	if (headers->iov_len < sizeof(struct fuse_uring_req_header)) {
+		pr_info_ratelimited("Invalid header len %zu\n", headers->iov_len);
 		return ERR_PTR(err);
 	}
 
-	payload_size = iov[1].iov_len;
-	if (payload_size < ring->max_payload_sz) {
+	payload = &iov[FUSE_URING_IOV_PAYLOAD];
+	if (payload->iov_len < ring->max_payload_sz) {
 		pr_info_ratelimited("Invalid req payload len %zu\n",
-				    payload_size);
+				    payload->iov_len);
 		return ERR_PTR(err);
 	}
 
@@ -1166,8 +1168,8 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *cmd,
 	INIT_LIST_HEAD(&ent->list);
 
 	ent->queue = queue;
-	ent->headers = iov[0].iov_base;
-	ent->payload = iov[1].iov_base;
+	ent->headers = headers->iov_base;
+	ent->payload = payload->iov_base;
 
 	atomic_inc(&ring->queue_refs);
 	return ent;
-- 
2.53.0

