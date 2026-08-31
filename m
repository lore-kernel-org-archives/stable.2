Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D0839A815
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 22:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788214809; cv=none; b=tmmH0+gnklsT/90tVsPkqANa5y+LlHPxuWimU0EnZw7zIOb4smDP3d3p73+ZSonvqjyQXNzrVD5WRH5xDyaAWiL0yv60ZZZ+TgR6WgLTmWZ2fxtzcP2+v2gHYTXfADsCkuMyHW1RA7dmPBNsQy5mKxw10yt6UxIL6IXn2yjNSYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788214809; c=relaxed/simple;
	bh=f1MGVPcOLfxRNQc124bXpr3wVKlXk+FCF0vCiiU9oFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YCgAsGCnXwgxiXBKsIbmMMqJ3opMVGIu7ujtOzbS76nfoIw5Uw1cBkHbb6QFujK+4Piy23VkSSO4cDlJizn8hsSzX0P9bxBQj3Hbf8Jd2OL8BLUUJiYvMrVn0InEqubbWqTFbQZEACbtmAE2ejnM+77flNuNYivDk1hZOR8Dx/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gk6zK2SP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gk6zK2SP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81AB1F00A3E;
	Mon, 31 Aug 2026 22:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788214808;
	bh=GY9DLbCkpNljSCLJV9qABh6kmTdWG5768cT+cohVkYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gk6zK2SPoI68pi7fF88xgtwFFNGZjQ2ggOIkA9Z8UdvI1XpLTA+NfBpEH8/2gHvRT
	 61GSR1vyThmjiEZC8AlmWb0OOLgLDcLaVI4YVtfyFR/jKPQQBZQh2Fzs27KV2PpPpG
	 Mx1PpQKXZK/Z9MnLn6G3CZITLL5qXjKcXSEdhyEu3yY8ztggWu2rm5LYif9T0AY7hc
	 nbr9kefNRECWwjqtmwF99w6d/zuyEKh4Lh9VrI95pAUtHl1NZVi1OrMUE/V0/id7A3
	 cEyn4Oit29ecrCkc6SpaM2+Q5+HvoWqpPg3oFdE/YKuIa7Taekym9aOnCaklZPUHK9
	 /dfoAgqAKn19g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Jeff Layton <jlayton@kernel.org>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/6] fuse-uring: refactor io-uring header copying from ring
Date: Mon, 31 Aug 2026 18:20:00 -0400
Message-ID: <20260831222004.1858878-2-sashal@kernel.org>
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
index e4c912c4f5e56..2c02292eb1471 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -591,6 +591,18 @@ static __always_inline int copy_header_to_ring(void __user *ring,
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
@@ -601,10 +613,10 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
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
@@ -840,8 +852,8 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
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

