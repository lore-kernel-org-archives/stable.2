Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4B1396B98
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 22:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788214810; cv=none; b=WKTDVVUSms2oK3PkWjLm6DH83oROz+Rz1gs8wSCGWov6VYyH6ua9wd3wOkqwLRYXlFIOKs3j/GC5RAJu4w/+r55YK2WooggbkFPWswIZVtd9v90ts7vKuaeF3RDdgcz6TQEl5fc3NQR1O+R/j/hyrqoCGzuayfuxZ3m3s6H7KX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788214810; c=relaxed/simple;
	bh=VOKiSEKN6yvFcNEf7GOtF736ThhgzXGIsD03FZY7qaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpRF+xYUIgz7LZ5IpxuI7p1d2LZc2+nHAtyhazW4sqJ4r/X1bYmJ6slZs0zxW0Lxn7on3lRKmD8aymajdWYEKGWBLknvtJTLsJY4Qq8wVo4oyUXZVcvfEX9KNtYB/PWFxTI+inJr5ZAQeTHAkwAQBYt++x80IjcE2vc0f1sWPGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBNOsfcd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBNOsfcd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A5E1F000E9;
	Mon, 31 Aug 2026 22:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788214809;
	bh=PEjt75FCbrEzfIJxrap0y6yTG3mv3tp/gVEIdcdsmoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YBNOsfcdndwn9RCUXWHdpPI1/CMro4UOCtrp5pIRqu0WISIeV8nNZoViVObvWb3YE
	 VzXO+rB8fq5QJ3Fy98E+zO5+AB4P/h/CC1bwKZCUDffBhSoOKrjU6gh/PLy9P+D5kk
	 Ji9yu4dycqMTErLeLCxzFpjRTIoYtp1842xUHrxgg//onDdmunTrk3yzDr6IYoBe3c
	 RV+88O4gAcwdJvkPedBReHZLIftjaf1UCgilnKLZBIz6vjBz/z77tdn3L5NYoA5Wbt
	 SmiN/ySGrLQjfPaaT63uoAEIoqLIVKYt/pC8gKQRtcjyz1bgzb2a12UehLWIrhKNR4
	 1sdnwmdssSIZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Jeff Layton <jlayton@kernel.org>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/6] fuse-uring: use enum types for header copying
Date: Mon, 31 Aug 2026 18:20:01 -0400
Message-ID: <20260831222004.1858878-3-sashal@kernel.org>
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
index 2c02292eb1471..f3c8f0d8117e1 100644
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
@@ -579,10 +588,33 @@ static int fuse_uring_out_header_has_err(struct fuse_out_header *oh,
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
@@ -591,10 +623,18 @@ static __always_inline int copy_header_to_ring(void __user *ring,
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
@@ -613,8 +653,8 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 	int err;
 	struct fuse_uring_ent_in_out ring_in_out;
 
-	err = copy_header_from_ring(&ring_in_out, &ent->headers->ring_ent_in_out,
-				    sizeof(ring_in_out));
+	err = copy_header_from_ring(ent, FUSE_URING_HEADER_RING_ENT,
+				    &ring_in_out, sizeof(ring_in_out));
 	if (err)
 		return err;
 
@@ -665,7 +705,7 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 		 * Some op code have that as zero size.
 		 */
 		if (args->in_args[0].size > 0) {
-			err = copy_header_to_ring(&ent->headers->op_in,
+			err = copy_header_to_ring(ent, FUSE_URING_HEADER_OP,
 						  in_args->value,
 						  in_args->size);
 			if (err)
@@ -685,8 +725,8 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 	}
 
 	ent_in_out.payload_sz = cs.ring.copied_sz;
-	return copy_header_to_ring(&ent->headers->ring_ent_in_out, &ent_in_out,
-				   sizeof(ent_in_out));
+	return copy_header_to_ring(ent, FUSE_URING_HEADER_RING_ENT,
+				   &ent_in_out, sizeof(ent_in_out));
 }
 
 static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
@@ -715,7 +755,7 @@ static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
 	}
 
 	/* copy fuse_in_header */
-	return copy_header_to_ring(&ent->headers->in_out, &req->in.h,
+	return copy_header_to_ring(ent, FUSE_URING_HEADER_IN_OUT, &req->in.h,
 				   sizeof(req->in.h));
 }
 
@@ -852,7 +892,7 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
 	struct fuse_conn *fc = ring->fc;
 	ssize_t err = -EFAULT;
 
-	if (copy_header_from_ring(&req->out.h, &ent->headers->in_out,
+	if (copy_header_from_ring(ent, FUSE_URING_HEADER_IN_OUT, &req->out.h,
 				  sizeof(req->out.h)))
 		goto out;
 
-- 
2.53.0

