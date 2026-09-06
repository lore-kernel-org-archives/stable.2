Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE8C33F589
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 14:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788706285; cv=none; b=CacyP7s0qQrPyXJ/dquU5Kv5gWTncK3vn2Ho8YsqTZLnvY6QG5Ju8QGBeuLapu2HN11TbxLki61oq2F/Gc+woQsf8t16o8SMPv5hJp3ilbJab7mnULvx056RkSC3GyQdujm2KCsWAoL+W3dpMqkNzL3LYra3IkxnW/tvhu3Z3Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788706285; c=relaxed/simple;
	bh=+pK9KNnUCG7uN+iCdXcLmf9EihX/QxnmxglAG8DlKL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iXpDYUZvWwHyHvRwfE8crPJioQGbYDAn8hMCZldXQXQBZt8d9PM7AOaoZ07Navl4mRT4EHj87uEB9qiT4H2lqhQaFWqlySrB+3YZSPKvVJ4r5oY2x00+7JIOvS8CYMTE3+kqpbGYkhE5rL/f+7E8WkvKhtllyE/McXNDo+iR+Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOW3QRGx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOW3QRGx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1420D1F00A3A;
	Sun,  6 Sep 2026 14:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788706283;
	bh=EI5Fz6ZglQIOift8ZrsPLKa0nwt7pJRk2GlY7qaPN8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WOW3QRGxE1JDk0y0g3IozUuESuVkd1r7LOKEUYA4/AzTABOS34fSgEsH+3GjIp6tD
	 pAtK5a0Vnsexlm2lgCEUfhG35gOk85+OLaRafLKjdScca4I/gO4YeOyDnZPbeAd7lA
	 YUSI6Lbj2odrvabo3xj48jzjY8lhQv0B3va3C6D5Vsk7vaL8pdwXWlen6QynuF74A3
	 e28wAawz1wgjeX6fnKM+HpCHrOE0qr60hPxqJMrAJ22Cy5EE/Nl/6JN0+8DikhDCl2
	 Kan4u78cMlcTcNYr5eu5xGqHmA1C9xHsr6JDQDmYMmplhd0OtTyncawlA4A+A6FX6O
	 vDDXtCHkYzlag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] ceph: Remove fs/ceph deadcode
Date: Sun,  6 Sep 2026 10:51:20 -0400
Message-ID: <20260906145121.1296715-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090348-battered-gradually-4df1@gregkh>
References: <2026090348-battered-gradually-4df1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

[ Upstream commit 6025b482e48041cd71111ab4f7cc28e0371b2e3e ]

ceph_caps_revoking() has been unused since 2017's commit
3fb99d483e61 ("ceph: nuke startsync op")

ceph_mdsc_open_export_target_sessions() has been unused since 2013's
commit 11df2dfb610d ("ceph: add imported caps when handling cap export message")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Stable-dep-of: 8fdf94644573 ("ceph: force a cap message when a deferred revoke can't be acked immediately")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/caps.c       | 14 --------------
 fs/ceph/mds_client.c |  8 --------
 fs/ceph/mds_client.h |  2 --
 fs/ceph/super.h      |  1 -
 4 files changed, 25 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index b04465ae4ce86..81531179d3573 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -978,20 +978,6 @@ int __ceph_caps_revoking_other(struct ceph_inode_info *ci,
 	return 0;
 }
 
-int ceph_caps_revoking(struct ceph_inode_info *ci, int mask)
-{
-	struct inode *inode = &ci->netfs.inode;
-	struct ceph_client *cl = ceph_inode_to_client(inode);
-	int ret;
-
-	spin_lock(&ci->i_ceph_lock);
-	ret = __ceph_caps_revoking_other(ci, NULL, mask);
-	spin_unlock(&ci->i_ceph_lock);
-	doutc(cl, "%p %llx.%llx %s = %d\n", inode, ceph_vinop(inode),
-	      ceph_cap_string(mask), ret);
-	return ret;
-}
-
 int __ceph_caps_used(struct ceph_inode_info *ci)
 {
 	int used = 0;
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 5f2b70b846e71..1768a952d9383 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1748,14 +1748,6 @@ static void __open_export_target_sessions(struct ceph_mds_client *mdsc,
 	}
 }
 
-void ceph_mdsc_open_export_target_sessions(struct ceph_mds_client *mdsc,
-					   struct ceph_mds_session *session)
-{
-	mutex_lock(&mdsc->mutex);
-	__open_export_target_sessions(mdsc, session);
-	mutex_unlock(&mdsc->mutex);
-}
-
 /*
  * session caps
  */
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 8987d0ff96252..d70cc49c7f875 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -645,8 +645,6 @@ extern void ceph_mdsc_handle_fsmap(struct ceph_mds_client *mdsc,
 
 extern struct ceph_mds_session *
 ceph_mdsc_open_export_target_session(struct ceph_mds_client *mdsc, int target);
-extern void ceph_mdsc_open_export_target_sessions(struct ceph_mds_client *mdsc,
-					  struct ceph_mds_session *session);
 
 extern int ceph_trim_caps(struct ceph_mds_client *mdsc,
 			  struct ceph_mds_session *session,
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index d1defb6a9aefc..bf1401778fd87 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -822,7 +822,6 @@ extern int __ceph_mark_dirty_caps(struct ceph_inode_info *ci, int mask,
 
 extern int __ceph_caps_revoking_other(struct ceph_inode_info *ci,
 				      struct ceph_cap *ocap, int mask);
-extern int ceph_caps_revoking(struct ceph_inode_info *ci, int mask);
 extern int __ceph_caps_used(struct ceph_inode_info *ci);
 
 static inline bool __ceph_is_file_opened(struct ceph_inode_info *ci)
-- 
2.53.0

