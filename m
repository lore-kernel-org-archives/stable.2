Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDAE3B95F9
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 22:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788214808; cv=none; b=Wuc6VLYVT/ezlS3txW2GAkDc/l0JlYPw0XmDUiL/VmSwByUDYOMoOznXdxxjDZBVnLjn5zDQ6RtTWxxbLVBH4GzxjJAe8kj0y02Ar7zRZD2F4WSLpsgbvOAVPfexfgNm5bM+X1ulqyAsBs6Rko4drqgygkjdeR98KE3OG1//NQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788214808; c=relaxed/simple;
	bh=scF/pcTJMotZ0YVF8TeHvIt/Pv+GTd6Lrqv6KYzcso0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mj6VHYUAEP0hfzjt+wAPasxjkhxdOo37Gz+LdFweVGRMqPXxApQdeBz20fMSRwhdPVRvjLSIVfbQKpKrgtARhhGO6Z0+Q0R22n2S7txQoSerFACJpfMO+Beswt+J8RHNhOJ0ZRXJIfoSpcdArYMqNCkcGtel6qnvzhQtlO5/iF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cv1H1GHM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cv1H1GHM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F67F1F00ACA;
	Mon, 31 Aug 2026 22:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788214807;
	bh=Cb2UyESVotiXE0Fk4ogImosgEFJ8PQY9OlFsFcfGMmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cv1H1GHML0FK0Si/8wAGEmiFIo4D3XfJPRlKkQNxq/wNywdWV0JWpgpXR0HiU9kkv
	 pE4j7LviaTP0E4H8uebti5dNrZa8Sm7q7SOyYexWGeArEv7g0RG+bay78b3Tl5Kkp+
	 a9+RkB3/PuJeX84i53pZpZiYl3QvUkINieGN7FqLX8CJYuK8r4/UZzQU8Mgw2k9ZzL
	 gYQKmiZ/9DwAhkoQtp/zC8bYeDtyVvHW5nrK62Z83a/NR09Jubs9QkWO+BhDAzNwYF
	 v8b59lc6cSbyXhat6ry0m1IoMGhsVN+XeCTcigkE++vJiO41JvcpX56D6WFA5RmSPT
	 fW9SuQU1vIYQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Jeff Layton <jlayton@kernel.org>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/6] fuse-uring: refactor io-uring header copying to ring
Date: Mon, 31 Aug 2026 18:19:59 -0400
Message-ID: <20260831222004.1858878-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083142-defile-crewmate-74f2@gregkh>
References: <2026083142-defile-crewmate-74f2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joanne Koong <joannelkoong@gmail.com>

[ Upstream commit 6582f8a06698403dccf8a01b7eef176b2c6dd7ff ]

Move header copying to ring logic into a new copy_header_to_ring()
function. This makes the copy_to_user() logic more clear and centralizes
error handling / rate-limited logging.

Reviewed-by: Bernd Schubert <bschubert@ddn.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Baokun Li <libaokun@linux.alibaba.com>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Stable-dep-of: fd10f40af314 ("fuse: copy request headers via a stack buffer for io-uring")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/dev_uring.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 6f74c345080f4..e4c912c4f5e56 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -579,6 +579,18 @@ static int fuse_uring_out_header_has_err(struct fuse_out_header *oh,
 	return err;
 }
 
+static __always_inline int copy_header_to_ring(void __user *ring,
+					       const void *header,
+					       size_t header_size)
+{
+	if (copy_to_user(ring, header, header_size)) {
+		pr_info_ratelimited("Copying header to ring failed.\n");
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
 static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 				     struct fuse_req *req,
 				     struct fuse_ring_ent *ent)
@@ -641,13 +653,11 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 		 * Some op code have that as zero size.
 		 */
 		if (args->in_args[0].size > 0) {
-			err = copy_to_user(&ent->headers->op_in, in_args->value,
-					   in_args->size);
-			if (err) {
-				pr_info_ratelimited(
-					"Copying the header failed.\n");
-				return -EFAULT;
-			}
+			err = copy_header_to_ring(&ent->headers->op_in,
+						  in_args->value,
+						  in_args->size);
+			if (err)
+				return err;
 		}
 		in_args++;
 		num_args--;
@@ -663,9 +673,8 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 	}
 
 	ent_in_out.payload_sz = cs.ring.copied_sz;
-	err = copy_to_user(&ent->headers->ring_ent_in_out, &ent_in_out,
-			   sizeof(ent_in_out));
-	return err ? -EFAULT : 0;
+	return copy_header_to_ring(&ent->headers->ring_ent_in_out, &ent_in_out,
+				   sizeof(ent_in_out));
 }
 
 static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
@@ -694,14 +703,8 @@ static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
 	}
 
 	/* copy fuse_in_header */
-	err = copy_to_user(&ent->headers->in_out, &req->in.h,
-			   sizeof(req->in.h));
-	if (err) {
-		err = -EFAULT;
-		return err;
-	}
-
-	return 0;
+	return copy_header_to_ring(&ent->headers->in_out, &req->in.h,
+				   sizeof(req->in.h));
 }
 
 static int fuse_uring_prepare_send(struct fuse_ring_ent *ent,
-- 
2.53.0

