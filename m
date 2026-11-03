Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725413;
	b=DS5BxMKi1gRjEqxBpUSXcCTYgTed5pAclKLz/tYPy/GwJWVsykV4NgL1LG9YvvYLpJVD
	 o5IKVqCN7sUq6A7zRzwK5ecVDmxrFZ0cMOHukhrqaI75Tmc5G9ilifG9VhGlkJtkCb7CP
	 KwpVtsS/HADoqujP9YMMqCtYtWfL846p5raIrVX4Do6d48eXXhjN5DVn3kn76308y0bmw
	 87t3QZUyRcdMniZ9vxEKnZXyRIT/8eRu58pHnAf7GkepRvUyoixCXvLCxfErhpvLquA0Q
	 Ci+LejJzNx+RjRGkGoL2HHS+qpDb8mhdLuqh73gzLCPewUjJ7IPmm4VETino0JubY6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725413;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6L9NBlqLAFWNy3HZS1HFDZqPwJ7Og5guOFwtNnVfQfw=;
	b=sym/PUf/QTrel/mTmMu+RIZLkkNngtVRJyFWfsd3+AL2AIj86h2O4o7iF81UtExEKi1z
	 9dKJsgM2rD88HjsQ/9ER/N+ZvHSispFWHR2l6d7kf37exzMdzYp7cySwNvogHCzuReb2R
	 DxgE4BzhMqJulbkYvJMnMbMYWBtKbVlD51jlIk5ciwNGC7BHCvvTsNtXfPqX67LEAeGqO
	 D10+5Av9XQ+EPU6+E29OmwDn/77rDvKfLq1OQ1dtFhNOHn0M2PegRTDusxy6u5N28QgiH
	 WfVFEGSXNZXrqjwY9JM28XvIuPJv7kELs+4BmDj91k0+DVaAKRmMnBcY9PZ5p5UtI4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="b2/sGK+4";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B97606A329
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b2/sGK+4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7101F00A02;
	Tue,  3 Nov 2026 17:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793725413;
	bh=6L9NBlqLAFWNy3HZS1HFDZqPwJ7Og5guOFwtNnVfQfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b2/sGK+4FabIpjapSqZH8atc6V6hECFnQtsFTkIs2HdrurcrGszRab+Jd2wBgAFT3
	 TlQ7aCxzj6Gz2So+G020zPrpfGBVi/WIx1JhX5QeE6FxxU3KLRy69OGOj7xvgyeiqv
	 V1VY5YEMeLeGnJhA99xaFQtZYv0M3Sf0Fn3njkY9FywUyHDC/yjQkbHT6g2U818rWG
	 98pO4YZSerxwDbSHKDQWFVPov02JfkwCE8+rr9xDCa7KDiCxz7ghP/8OW52sKdPASW
	 tWKGGs+njk0MiapkWI+BxZ2X1yJyHsQA3XCjCP8m4+RCgDXWVisFPpd+4Ez9QhBG8i
	 Qsfo/LMKsdkQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 4/4] ksmbd: fix app-instance non-durable supersede session UAF
Date: Tue,  3 Nov 2026 12:03:28 -0500
Message-ID: <20261103170318.645584-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103170318.645584-1-sashal@kernel.org>
References: <2026110310-spool-turban-3d3a@gregkh>
 <20261103170318.645584-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ian Bridges <icb@fastmail.org>

[ Upstream commit f728cfee6929057087c303d07d7a6a7c61196b48 ]

ksmbd_close_fd_app_instance_id() supersedes a prior open that has the
same AppInstanceId. It reaches that open's session through opinfo->sess.
This pointer is not refcounted.

Session teardown detaches durable handles before it frees the session.
It does not detach a non-durable open. That open still points at the
session through opinfo->sess after the session is freed. Another session
can supersede the open at the same time. The supersede then takes a
write lock through the stale pointer, in the freed session's file table.

  BUG: KASAN: slab-use-after-free in _raw_write_lock+0x71/0xd0
  Call Trace:
   _raw_write_lock+0x71/0xd0
   ksmbd_close_fd_app_instance_id+0xd9/0x670 [ksmbd]
   smb2_open+0x3e10/0xd910 [ksmbd]
  Freed by task 212:
   ksmbd_session_destroy+0x38d/0x480 [ksmbd]

Fix this by looking the session up by opinfo->session_id. The lookup
returns a reference, as smb2_break_collect_channels() does. Recheck that
opinfo->sess still points at it before using it.

Do the lookup without m_lock held. destroy_previous_session() takes
m_lock under the session table lock, and taking them in the other order
here would deadlock.

Fixes: 16c30649709d ("ksmbd: handle durable v2 app instance id")
Cc: stable@vger.kernel.org # e0386cd6498b: ksmbd: validate AppInstanceId takeover target
Signed-off-by: Ian Bridges <icb@fastmail.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/vfs_cache.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index a2051dfb47d91..5f1442c103d81 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -1054,7 +1054,9 @@ int ksmbd_close_fd_app_instance_id(struct ksmbd_work *work,
 				 struct ksmbd_file *fp, bool *closed)
 {
 	struct ksmbd_file_table *ft;
+	struct ksmbd_session *sess;
 	struct oplock_info *opinfo;
+	u64 session_id;
 	int n_to_drop = 0;
 
 	*closed = false;
@@ -1067,10 +1069,35 @@ int ksmbd_close_fd_app_instance_id(struct ksmbd_work *work,
 		up_read(&fp->f_ci->m_lock);
 		goto out;
 	}
+	/*
+	 * opinfo->sess is not refcounted, and m_lock does not keep it alive.
+	 * The owner can be torn down while we hold only a reference to fp.
+	 * Look the owner up by id to take a real reference instead.
+	 */
+	session_id = opinfo->session_id;
+	up_read(&fp->f_ci->m_lock);
 
-	ft = &opinfo->sess->file_table;
+	/* destroy_previous_session() takes m_lock under sessions_table_lock. */
+	sess = ksmbd_session_lookup_slowpath(session_id);
+	if (!sess)
+		goto out;
+
+	down_read(&fp->f_ci->m_lock);
+	if (opinfo->sess != sess) {
+		up_read(&fp->f_ci->m_lock);
+		ksmbd_user_session_put(sess);
+		goto out;
+	}
+	ft = &sess->file_table;
 	write_lock(&ft->lock);
-	if (fp->f_state == FP_INITED && has_file_id(fp->volatile_id) &&
+	/*
+	 * The table may already be detached by destroy_previous_session().
+	 * A new session could also reuse the old id and address and pass the
+	 * check above. Only remove fp if this table still publishes it.
+	 */
+	if (ft->idr && fp->f_state == FP_INITED &&
+	    has_file_id(fp->volatile_id) &&
+	    idr_find(ft->idr, fp->volatile_id) == fp &&
 	    ksmbd_app_instance_id_matches(work, fp)) {
 		idr_remove(ft->idr, fp->volatile_id);
 		fp->volatile_id = KSMBD_NO_FID;
@@ -1078,6 +1105,7 @@ int ksmbd_close_fd_app_instance_id(struct ksmbd_work *work,
 	}
 	write_unlock(&ft->lock);
 	up_read(&fp->f_ci->m_lock);
+	ksmbd_user_session_put(sess);
 	opinfo_put(opinfo);
 	opinfo = NULL;
 
-- 
2.53.0

