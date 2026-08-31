Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697D837E2E6
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 21:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210609; cv=none; b=DH93YAJv+vcaXrgYPzib8U1q6QdvAOLYo64Y8vkatGlu6qQVSF7C2aE4IUfFu9RufrKU7v2jHz59Uv8zgmO0tf/v/O3r/trIM8D4C3jTcUEYt97MTAb4L6zRwZ1nf4Yut41hi5+uqbzu3xNFBm1U8rK+5ca6GSM5NxdHRp5cJnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210609; c=relaxed/simple;
	bh=msHkUfvYwkJ595dUpFoSt9hHwlK1vNtp8raPB0cA6xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7JZwaLC234BjHfG4TOGzt4JXuvUNiBQuBmtHlu/VUD8qSHvJAJHy4AycLeeiDb/Nvc+36K9HfZ3k+i8nxfRiJ61faoMwsZ/wFJ0wyiUj+0F4lZIrKgCbIGevPtuQ7RGHRD3BG7yHYHQ3pFRF5B9pjrP00274DMuzUrayMBIdN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KErAzA73; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KErAzA73"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634E91F000E9;
	Mon, 31 Aug 2026 21:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788210608;
	bh=n5n6PvuZ+0SYgJadjpL6MPFVILynuTdFRT+zhMAGydc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KErAzA73kR9R5DRIdBNcIRqvan5hn4yaUnXqnorix9/tjqChHj3Y6vldnOJMtN/h7
	 CJoK8hm2LCPGYef4NwFUZlli13acSGQxfJMr5rOEg4mCEq2HuurbEmV3BPwRR/Kjz7
	 e+63PczO3d9y8PU7wn4YlmXJoG3mFAW2jUo4CVrsT7LqWR7gJEKytLPyzx/2rxj4R+
	 dO4LQsmTFjdZX8UeyxYcieXFEi6aZB97yAqw7q25NiEDNiXD5Dqdqf/rQrA7SvhGKU
	 f66TGgMa483HkQOwX+AFDNK+q6T9y7FtfvGH+dE1GjRJNCS5Zq8NmZhI+5jw12mE/a
	 VfvviOFIIlf/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Jeff Layton <jlayton@kernel.org>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 1/6] fuse-uring: refactor io-uring header copying to ring
Date: Mon, 31 Aug 2026 17:10:00 -0400
Message-ID: <20260831211005.1798781-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083141-whacking-derby-c87d@gregkh>
References: <2026083141-whacking-derby-c87d@gregkh>
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
index 8155c35cf56ae..df19a580c200a 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -575,6 +575,18 @@ static int fuse_uring_out_header_has_err(struct fuse_out_header *oh,
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
@@ -637,13 +649,11 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
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
@@ -659,9 +669,8 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 	}
 
 	ent_in_out.payload_sz = cs.ring.copied_sz;
-	err = copy_to_user(&ent->headers->ring_ent_in_out, &ent_in_out,
-			   sizeof(ent_in_out));
-	return err ? -EFAULT : 0;
+	return copy_header_to_ring(&ent->headers->ring_ent_in_out, &ent_in_out,
+				   sizeof(ent_in_out));
 }
 
 static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
@@ -690,14 +699,8 @@ static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
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

