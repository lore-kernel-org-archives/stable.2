Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113D738B12D
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 21:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210613; cv=none; b=eZfEYjjlGAXe3JBMAck6+xoWmSG4oYewsXAyUoYHlihmZ872Ec+0rqHwgvQ62Wbkd35v7l1wK+0luoa1WNXhBYJBzvQeS9zXJWmf0UJjA9uBtWYdDPoIT8hzg56CMDholXrf5QfQEv5NFkSwulzK35GokmaO+dpuTTBHWA8Vrp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210613; c=relaxed/simple;
	bh=IA+DN0o5aP4AwMYtXnbVp4z3DftF92xbTjEHH3SwTvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OcPsdFwt2JyO7HdsOG2ThuIBZluPXHik9IYO3hx1yPL+DPZFWkdDUxZqUu09xtonxJihfA6X6g29Pi8NDPTQ5QavZJDa6y/bR2uFzsJFxCdCxIXokLsl+Zd3iFLPlEtPkXJMDvK0VnuWsPieEX2gTqrEdEUqnr2zTHg6hyqiQW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADfK0SDv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADfK0SDv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922001F000E9;
	Mon, 31 Aug 2026 21:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788210611;
	bh=6WsmbrlFLtSvwj8P3f10QKyxuMzNw6zSLtmvPkGhVk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ADfK0SDvzJ7HCBknlFAkdMg69ry2gTxCTZnVm/2/HdlegrSKt/7fWZnbKvS+swZ8h
	 aN4WlpixLK9XZBQwZtMr8zPHIEHtZte3z1XXpASxiq7KRauFniDhxTQcHC4W1q5gI/
	 fskjNMXHNlh33gAG7iT3c0WDhlpEQQorViExWnrQvSmWnerb0CJhqeoldrIBe232Rs
	 0HCJpflPeOqcXHzXlL4zRPVRi0LSa1mTQd0zKpAm2/C+eftDPgF4czYW/lEac9/Nxr
	 GCZ0JbG/lnpp2IYOKCMuH4KHsjijCbYfrz9kXhkWELrFUuKfoNkDeO+921yf431n9p
	 5/YS2Vhcs0HPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Jeff Layton <jlayton@kernel.org>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 4/6] fuse-uring: refactor setting up copy state for payload copying
Date: Mon, 31 Aug 2026 17:10:03 -0400
Message-ID: <20260831211005.1798781-4-sashal@kernel.org>
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

[ Upstream commit c0f9203732fc70de8d20697270bfe405481eac14 ]

Add a new helper function setup_fuse_copy_state() to contain the logic
for setting up the copy state for payload copying.

Reviewed-by: Bernd Schubert <bschubert@ddn.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Baokun Li <libaokun@linux.alibaba.com>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Stable-dep-of: fd10f40af314 ("fuse: copy request headers via a stack buffer for io-uring")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/dev_uring.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 1a223d3361591..3fc4c4e6f9e3c 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -639,6 +639,27 @@ static int copy_header_from_ring(struct fuse_ring_ent *ent,
 	return 0;
 }
 
+static int setup_fuse_copy_state(struct fuse_copy_state *cs,
+				 struct fuse_ring *ring, struct fuse_req *req,
+				 struct fuse_ring_ent *ent, int dir,
+				 struct iov_iter *iter)
+{
+	int err;
+
+	err = import_ubuf(dir, ent->payload, ring->max_payload_sz, iter);
+	if (err) {
+		pr_info_ratelimited("fuse: Import of user buffer failed\n");
+		return err;
+	}
+
+	fuse_copy_init(cs, dir == ITER_DEST, iter);
+
+	cs->is_uring = true;
+	cs->req = req;
+
+	return 0;
+}
+
 static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 				     struct fuse_req *req,
 				     struct fuse_ring_ent *ent)
@@ -654,15 +675,10 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 	if (err)
 		return err;
 
-	err = import_ubuf(ITER_SOURCE, ent->payload, ring->max_payload_sz,
-			  &iter);
+	err = setup_fuse_copy_state(&cs, ring, req, ent, ITER_SOURCE, &iter);
 	if (err)
 		return err;
 
-	fuse_copy_init(&cs, false, &iter);
-	cs.is_uring = true;
-	cs.req = req;
-
 	err = fuse_copy_out_args(&cs, args, ring_in_out.payload_sz);
 	fuse_copy_finish(&cs);
 	return err;
@@ -685,15 +701,9 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 		.commit_id = req->in.h.unique,
 	};
 
-	err = import_ubuf(ITER_DEST, ent->payload, ring->max_payload_sz, &iter);
-	if (err) {
-		pr_info_ratelimited("fuse: Import of user buffer failed\n");
+	err = setup_fuse_copy_state(&cs, ring, req, ent, ITER_DEST, &iter);
+	if (err)
 		return err;
-	}
-
-	fuse_copy_init(&cs, true, &iter);
-	cs.is_uring = true;
-	cs.req = req;
 
 	if (num_args > 0) {
 		/*
-- 
2.53.0

