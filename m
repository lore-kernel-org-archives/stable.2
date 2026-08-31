Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDB439A079
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 22:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788214811; cv=none; b=iLYfGZlz6OCYSArZ1kub25ywQRi3Tb+iV4HnsgrEqSNO+5Etg3iBul3RT2snNzKRTgwFDCT/G4aeHT2QFkTcElgi3LR+jxABLQ+XfSF4tOHuQVPlmHE0QM9BDOZBGz/XKKOFSCFzIckVGN1n1Y0orGr7QwrL9RSFrHCiciqy520=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788214811; c=relaxed/simple;
	bh=P7QQ3BX+Qj43yH0s0yrXynlN2OqbMhKgzxeiUvi1KOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mRCEyWOPl5w1+5MaqrTOnJq2rC7+YuvT3zgf9K5SE1FfZvEceYdSusLMz98hY7nxTSFtywoa9Ru7xiFXicp+m4YiSQ6RAoiZ1yQWNE79r30wpa3VM4sMG1i4vLvadzkqcW7f8JWb+3bRbxF1Wc7DMnfghz/XSoDFy0Wfg5y/RSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYo+JyKe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYo+JyKe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C101F00A3F;
	Mon, 31 Aug 2026 22:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788214810;
	bh=p00S1wXdRCcsJyvLhGVNKYeUyv8hgD5bG6vf+hvJ4/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oYo+JyKeW9hSJIGfZG0JIzDWt8HlMdlBl0pxpH5jm2QddekOJD0DqA76sXr5uno7h
	 +hyo8Im3SfNDSoslTTg3bRCvLKeWwMsl1JXYRjJpEObTE0XzwtTdEsjsEmOHY6rMBi
	 dS8EXM593mevz8t1elws8mlMUVVpQWdlCF0IG1FdvaxNGRBdi1USvC/P3PEfnwygn8
	 9qrYp3n1W5qYaYKqtgKBPpX2g585q14JxvGvaXcqv7RfGhbRAIswhAb6OVCzFvLtYu
	 rEi01LUQEm/JWV90DFlBu9+kGIQdDX+kQLFjNWCMAk7itehB48AC/TLT3fcMO7TjDP
	 qjFrPfb17r6lA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Jeff Layton <jlayton@kernel.org>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/6] fuse-uring: refactor setting up copy state for payload copying
Date: Mon, 31 Aug 2026 18:20:02 -0400
Message-ID: <20260831222004.1858878-4-sashal@kernel.org>
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
index f3c8f0d8117e1..52e7580ec88fd 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -643,6 +643,27 @@ static int copy_header_from_ring(struct fuse_ring_ent *ent,
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
@@ -658,15 +679,10 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
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
@@ -689,15 +705,9 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
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

