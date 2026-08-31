Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A137361960
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 21:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210610; cv=none; b=i8v0UZ3SHQEN0KijrD2ykwucMo6+pzUGv+G8d1TxE+zq35ssHoiZa8xZYqrdIa1SD1igzuqd6eDE6FsKiAfi6SQ+6zpPGvWGy2USgA9lPphmDPtssZWUJBYAU/gWfblHTifAOE5phPVnSAZz4JSTd9Gb6wlbtggxyzrKRlHnMz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210610; c=relaxed/simple;
	bh=Y4LG9zQnlnSFoRnn0FrCItHZCOpjq0gbyyuhdkA9rwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5D6M0lKrcftOtWqSkxqs6EVzZSqeyam30bJxXsv8yh4smWUJHSSSDMRWoeuQ/dYw3zIHZ6/NxPqXnLiRbAAwfQZQM7nA4uB7YWn0bJEtpTyV7C9hwnRoUlJ1jo+tBqZjzqrOmQplpPCeCU6qLaTSoAy2iDc8eO4jLREtIJXJQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsxtqOas; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsxtqOas"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B041F00A3D;
	Mon, 31 Aug 2026 21:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788210609;
	bh=zgmG0118shBiUlaJhgFCTgG5C37bOA3woYljB+umWlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UsxtqOas8rK56dPOo+SUdK/owRZzGsfpgakFgGS2iLN8qNr9iwEwVkeubyBf8Gk1l
	 jdaQtluGwQeDx4fviZI+zkqAGkPD1Di9sAQZr4o6fbDGyhUizdW8g8q72MTaGKrbW1
	 gKAmDdTzDj/h1i1gio4KdXlxNQtk5CSg6a7zDnSuEgUGPYPn+cI+W/31KNso6Jd3gL
	 36Z7eIngK9osU0hdU6HB7nJ6QiDHP/b6uaXGtgahP+nhmew+ydb6wAIekD7oy2G+nK
	 xya9XQO61a+kxg/hfaLwxQPt2hFvzTDVI6pGnPuZ/WL+ZGbZ9gQzuM3pNnk53+tvaK
	 DKz2mPaQdGw9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Jeff Layton <jlayton@kernel.org>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 2/6] fuse-uring: refactor io-uring header copying from ring
Date: Mon, 31 Aug 2026 17:10:01 -0400
Message-ID: <20260831211005.1798781-2-sashal@kernel.org>
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

[ Upstream commit ba7d47897fd895533c19af436ca7fc4f6b171238 ]

Move header copying from ring logic into a new copy_header_from_ring()
function. This makes the copy_from_user() logic more clear and
centralizes error handling / rate-limited logging.

Reviewed-by: Bernd Schubert <bschubert@ddn.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Baokun Li <libaokun@linux.alibaba.com>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Stable-dep-of: fd10f40af314 ("fuse: copy request headers via a stack buffer for io-uring")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/dev_uring.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index df19a580c200a..6468a72de6644 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -587,6 +587,18 @@ static __always_inline int copy_header_to_ring(void __user *ring,
 	return 0;
 }
 
+static __always_inline int copy_header_from_ring(void *header,
+						 const void __user *ring,
+						 size_t header_size)
+{
+	if (copy_from_user(header, ring, header_size)) {
+		pr_info_ratelimited("Copying header from ring failed.\n");
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
 static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 				     struct fuse_req *req,
 				     struct fuse_ring_ent *ent)
@@ -597,10 +609,10 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 	int err;
 	struct fuse_uring_ent_in_out ring_in_out;
 
-	err = copy_from_user(&ring_in_out, &ent->headers->ring_ent_in_out,
-			     sizeof(ring_in_out));
+	err = copy_header_from_ring(&ring_in_out, &ent->headers->ring_ent_in_out,
+				    sizeof(ring_in_out));
 	if (err)
-		return -EFAULT;
+		return err;
 
 	err = import_ubuf(ITER_SOURCE, ent->payload, ring->max_payload_sz,
 			  &iter);
@@ -836,8 +848,8 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
 	struct fuse_conn *fc = ring->fc;
 	ssize_t err = -EFAULT;
 
-	if (copy_from_user(&req->out.h, &ent->headers->in_out,
-			   sizeof(req->out.h)))
+	if (copy_header_from_ring(&req->out.h, &ent->headers->in_out,
+				  sizeof(req->out.h)))
 		goto out;
 
 	err = fuse_uring_out_header_has_err(&req->out.h, req, fc);
-- 
2.53.0

