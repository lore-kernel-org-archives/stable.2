Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A882395254
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 21:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210614; cv=none; b=BOpzu1h02HCjcPGebPbCrQ0KW8N3wSUizGyXA6lkIcjsQcHSbFAB33UeQF2v0gkaC3Cd3qdlIXdNVI0qwjEgZlq2SQ9phC8fTE/UvaeuClLPkOOC4UEBMbhXrGTJ9Vg5uKfGGlrGd/w8VGDuFJID2QxVvUhDAIoAQi4d5/JcDcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210614; c=relaxed/simple;
	bh=jvCqY698teq1MRexjhXTV6w736KDcktQ1kqIz5k/St4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBDIha6rvvzc7TynG14oxKVHxHh0RZXvcIz7sKkBz35m57ACt8aPZWGQmVOvL7SxUqy4J5i0mOXNiiG86rvhkT2KaVkCs+VYTEyiMpwQ8vSLyyPXlWPiG3AsJPfayCvMl9ywezTrh4Qe7qYyPk43U4s0RRtmN1ho4YYeKVVbmC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ns1FuL8W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ns1FuL8W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2ACF1F00A3E;
	Mon, 31 Aug 2026 21:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788210612;
	bh=rnJQowKz+kemia9rcljYMBhHT65j812QXERK+r4/B9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ns1FuL8W1KiE4TRIFnyATH6kEFhetwMCJweX+42zR5bAnrIh1R/D7MJy7CxyRWTAO
	 9vTV/WiYlHC9gf5PDZ3fDzKicl7+eQzRuVcGh49pbKMABQf1QfUXsLFONDnnr6LnTW
	 1UVr9lsi8f18yqGXT2HBEVKuGADqzYu0zCPCtpQ+hloR/1z8J113h5IK639VxMD16y
	 GzgQZq+TsVNjt0ml8rkZ+IDre9lVW0tbmN4bIVsu5S6ondMq+fLU7G7cABTIUnFXE3
	 V+/aJXtmFENzcBiryA5AOamya6LbmHe+rWfxUJ+U/myNfaVpZrA8/CI/PEH8qiF4tF
	 wX1/5vG0BikkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	Jeff Layton <jlayton@kernel.org>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 5/6] fuse-uring: use named constants for io-uring iovec indices
Date: Mon, 31 Aug 2026 17:10:04 -0400
Message-ID: <20260831211005.1798781-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831211005.1798781-1-sashal@kernel.org>
References: <2026083141-whacking-derby-c87d@gregkh>
 <20260831211005.1798781-1-sashal@kernel.org>
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
index 3fc4c4e6f9e3c..c40cb2194598f 100644
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
@@ -1100,8 +1101,8 @@ static int fuse_uring_do_register(struct fuse_ring_ent *ent,
 }
 
 /*
- * sqe->addr is a ptr to an iovec array, iov[0] has the headers, iov[1]
- * the payload
+ * sqe->addr is a ptr to an iovec array, iov[FUSE_URING_IOV_HEADERS] has the
+ * headers, iov[FUSE_URING_IOV_PAYLOAD] the payload
  */
 static int fuse_uring_get_iovec_from_sqe(const struct io_uring_sqe *sqe,
 					 struct iovec iov[FUSE_URING_IOV_SEGS])
@@ -1131,8 +1132,8 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *cmd,
 {
 	struct fuse_ring *ring = queue->ring;
 	struct fuse_ring_ent *ent;
-	size_t payload_size;
 	struct iovec iov[FUSE_URING_IOV_SEGS];
+	struct iovec *headers, *payload;
 	int err;
 
 	err = fuse_uring_get_iovec_from_sqe(cmd->sqe, iov);
@@ -1143,15 +1144,16 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *cmd,
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
 
@@ -1163,8 +1165,8 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *cmd,
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

