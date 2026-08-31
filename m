Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9238396561
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 21:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210612; cv=none; b=njWhNrwo3IuN+7FXyGGZH+sIMhs/UN4YOnODBqRZw/fkME0/rJltN7kHFKB50UwTagNYEhqpb6Ll1Hk4f3voY0qSXAmPyrnZz/uNEjzTxYFCZfe/5fcDIY/wyNi6n8bsfWr1HqtkuQS+DBiWUiqGB0MS3hKHZ/dZuA5vqre07+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210612; c=relaxed/simple;
	bh=dV+lI+xTPtc/xsTiTvsWXMWvrQVPoBthe/yenB6nzIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LEIGcwrndnq4uxmo5yuTvG40VvshtdwljI21PZHXzDn10ybm5TY80QkTzhE9DTa9SXoiTREFobeEBdfqV5+PRDNewHHoctoQeUunOgjFcamFXHpgftDW+HanMUKQmfTTQvL/VAVFi3INb/+YKcy+E+pGZKdd+av/bN3EHwsDik4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQXxIQlW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQXxIQlW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B1B1F00A3F;
	Mon, 31 Aug 2026 21:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788210610;
	bh=+Ayu85s7NPHpiB0MqdbaUqVp4g5v+VNNPoAzChU8Knw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GQXxIQlWEC6NQn1BVX1+t/H3A0GFnm4zbE4k4DkQjVaF2BffjPNeEiqVpgm6AW78m
	 aYMx2ZfMYSyuzaA8YFNInFTiUoMgmSoRzXRDOmTXGzcmTGuFVf96SuvZ3hWnP/pRUo
	 qAPv6b3/G5YgQPEG7vFnyPVZLJB7K2zHpuOfgb/BUpWGbLeP+wkRXKFhShK0z7xHvg
	 XcLmo2F8wGFscMTnBj/3KNkRNzo1xR5yZOEak0/Ap8+1b3rVqlYNp0QA996KmRwUxh
	 Ynog4ryw+3Ydm+zsl3NzYI1lHF8eSAaRmhY//SV4wFvky56uD3n72XTn+AnwgPT80b
	 J1oNiB9OraNnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Jeff Layton <jlayton@kernel.org>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 3/6] fuse-uring: use enum types for header copying
Date: Mon, 31 Aug 2026 17:10:02 -0400
Message-ID: <20260831211005.1798781-3-sashal@kernel.org>
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

[ Upstream commit b2bbd7dcd2433e29b7e9a726aaa9571a78fa8d5f ]

Use enum types to identify which part of the header needs to be copied.
This improves the interface and will simplify both kernel-space and
user-space header addresses copying when buffer rings are added.

Reviewed-by: Bernd Schubert <bschubert@ddn.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Baokun Li <libaokun@linux.alibaba.com>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Stable-dep-of: fd10f40af314 ("fuse: copy request headers via a stack buffer for io-uring")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/dev_uring.c | 66 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 53 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 6468a72de6644..1a223d3361591 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -31,6 +31,15 @@ struct fuse_uring_pdu {
 
 static const struct fuse_iqueue_ops fuse_io_uring_ops;
 
+enum fuse_uring_header_type {
+	/* struct fuse_in_header / struct fuse_out_header */
+	FUSE_URING_HEADER_IN_OUT,
+	/* per op code header */
+	FUSE_URING_HEADER_OP,
+	/* struct fuse_uring_ent_in_out header */
+	FUSE_URING_HEADER_RING_ENT,
+};
+
 static void uring_cmd_set_ring_ent(struct io_uring_cmd *cmd,
 				   struct fuse_ring_ent *ring_ent)
 {
@@ -575,10 +584,33 @@ static int fuse_uring_out_header_has_err(struct fuse_out_header *oh,
 	return err;
 }
 
-static __always_inline int copy_header_to_ring(void __user *ring,
-					       const void *header,
-					       size_t header_size)
+static int ring_header_type_offset(enum fuse_uring_header_type type)
 {
+	switch (type) {
+	case FUSE_URING_HEADER_IN_OUT:
+		return 0;
+	case FUSE_URING_HEADER_OP:
+		return offsetof(struct fuse_uring_req_header, op_in);
+	case FUSE_URING_HEADER_RING_ENT:
+		return offsetof(struct fuse_uring_req_header, ring_ent_in_out);
+	default:
+		WARN_ONCE(1, "Invalid header type: %d\n", type);
+		return -EINVAL;
+	}
+}
+
+static int copy_header_to_ring(struct fuse_ring_ent *ent,
+			       enum fuse_uring_header_type type,
+			       const void *header, size_t header_size)
+{
+	int offset = ring_header_type_offset(type);
+	void __user *ring;
+
+	if (offset < 0)
+		return offset;
+
+	ring = (void __user *)ent->headers + offset;
+
 	if (copy_to_user(ring, header, header_size)) {
 		pr_info_ratelimited("Copying header to ring failed.\n");
 		return -EFAULT;
@@ -587,10 +619,18 @@ static __always_inline int copy_header_to_ring(void __user *ring,
 	return 0;
 }
 
-static __always_inline int copy_header_from_ring(void *header,
-						 const void __user *ring,
-						 size_t header_size)
+static int copy_header_from_ring(struct fuse_ring_ent *ent,
+				 enum fuse_uring_header_type type, void *header,
+				 size_t header_size)
 {
+	int offset = ring_header_type_offset(type);
+	const void __user *ring;
+
+	if (offset < 0)
+		return offset;
+
+	ring = (void __user *)ent->headers + offset;
+
 	if (copy_from_user(header, ring, header_size)) {
 		pr_info_ratelimited("Copying header from ring failed.\n");
 		return -EFAULT;
@@ -609,8 +649,8 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 	int err;
 	struct fuse_uring_ent_in_out ring_in_out;
 
-	err = copy_header_from_ring(&ring_in_out, &ent->headers->ring_ent_in_out,
-				    sizeof(ring_in_out));
+	err = copy_header_from_ring(ent, FUSE_URING_HEADER_RING_ENT,
+				    &ring_in_out, sizeof(ring_in_out));
 	if (err)
 		return err;
 
@@ -661,7 +701,7 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 		 * Some op code have that as zero size.
 		 */
 		if (args->in_args[0].size > 0) {
-			err = copy_header_to_ring(&ent->headers->op_in,
+			err = copy_header_to_ring(ent, FUSE_URING_HEADER_OP,
 						  in_args->value,
 						  in_args->size);
 			if (err)
@@ -681,8 +721,8 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 	}
 
 	ent_in_out.payload_sz = cs.ring.copied_sz;
-	return copy_header_to_ring(&ent->headers->ring_ent_in_out, &ent_in_out,
-				   sizeof(ent_in_out));
+	return copy_header_to_ring(ent, FUSE_URING_HEADER_RING_ENT,
+				   &ent_in_out, sizeof(ent_in_out));
 }
 
 static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
@@ -711,7 +751,7 @@ static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
 	}
 
 	/* copy fuse_in_header */
-	return copy_header_to_ring(&ent->headers->in_out, &req->in.h,
+	return copy_header_to_ring(ent, FUSE_URING_HEADER_IN_OUT, &req->in.h,
 				   sizeof(req->in.h));
 }
 
@@ -848,7 +888,7 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
 	struct fuse_conn *fc = ring->fc;
 	ssize_t err = -EFAULT;
 
-	if (copy_header_from_ring(&req->out.h, &ent->headers->in_out,
+	if (copy_header_from_ring(ent, FUSE_URING_HEADER_IN_OUT, &req->out.h,
 				  sizeof(req->out.h)))
 		goto out;
 
-- 
2.53.0

