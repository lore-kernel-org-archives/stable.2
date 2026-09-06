Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040C936197A
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788714216; cv=none; b=tPRerdA+zwpgH1gydcEIIxMourBaz7ylvKPXS4+O0b7d9wemnoVdGWJLlsBDyiF0j7q56HvPqbGP5wtJXtO6VKdVhEWp0ubH4ERXZdf7Lhd8xWriZaXvpVkjDfkFI7DlE6Eve3lLvAV+F+JyR7kjW+dQ/R7wk7wkqwUhdjMbBG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788714216; c=relaxed/simple;
	bh=l8skvFNz1gc90XTYtf5R7zKMCUYxOW2HuBWKbtKFwP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPcX8BYAHnIn0cxBfiTT/EE7F8SAKaYSgrGeenJNqH6rX8+LzJqVWGTO0qSzJJBYJ1z5y9amp8aqRS1qtQ/psOirzOx97vw1a/tiITx7obIdMAaAX6BfYSDqQXUNWnMOUSVPthZX8Abm4XCYcz186yBwRgIJrM+8tfzhEUWPDW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9JnVhdo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9JnVhdo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14E61F00A3A;
	Sun,  6 Sep 2026 17:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788714214;
	bh=nZK8flxTVoxW2EvEZFTnNDZW4xAnDUBeQUzq7ELfcns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y9JnVhdob/moK4jfOo2Z7dFK9GBewVT/XfUxTWVA4x8Ahoad/SbYKDbqKgKswUx27
	 G9uPo7fzqwZkpidUjUtv37aeeeWuMvdCHncZc0yaAKxcSd6dviTIgrHrSocsbyZgRD
	 JCQxQ/QBIqP/JmLC2Y8v0lAI8zx8JfyMZETBBYfnPY87NQD9pE9XIOCZypRvU4fysS
	 ZO6Z7ndfTgIq5IK8YrjER+mqiOECaHrk4t7q3GbLVuh7nlFBDATkzpl2KsGFUkL3DL
	 E1ZXV1Tq9rYh6/gD6nM+K8tnjBpcs/o2kqFElK8mCYriZfUjI10n+xsCW2uwI2l5Yw
	 pzHN86nXlKYMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiubo Li <xiubli@redhat.com>,
	Patrick Donnelly <pdonnell@redhat.com>,
	Milind Changire <mchangir@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] ceph: pass the mdsc to several helpers
Date: Sun,  6 Sep 2026 13:03:31 -0400
Message-ID: <20260906170332.1640271-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090357-gangly-scapegoat-ae91@gregkh>
References: <2026090357-gangly-scapegoat-ae91@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xiubo Li <xiubli@redhat.com>

[ Upstream commit 197b7d792d6aead2e30d4b2c054ffabae2ed73dc ]

We will use the 'mdsc' to get the global_id in the following commits.

Link: https://tracker.ceph.com/issues/61590
Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Patrick Donnelly <pdonnell@redhat.com>
Reviewed-by: Milind Changire <mchangir@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

[ sashal: Reduced backport -- upstream 197b7d792d6ae touches 10 file(s), this
  backport carries 2. Not backported here:
  fs/ceph/caps.c
  fs/ceph/debugfs.c
  fs/ceph/dir.c
  fs/ceph/file.c
  fs/ceph/mdsmap.c
  fs/ceph/snap.c
  fs/ceph/super.h
  include/linux/ceph/mdsmap.h
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 4bd3158bd624 ("ceph: cap delegated inode count in ceph_parse_deleg_inos()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/mds_client.c | 41 +++++++++++++++++++++++++++++------------
 fs/ceph/mds_client.h |  1 +
 2 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 165a0ec892acc..997f6ff621a0c 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -425,31 +425,33 @@ static int parse_reply_info_filelock(void **p, void *end,
 static int ceph_parse_deleg_inos(void **p, void *end,
 				 struct ceph_mds_session *s)
 {
+	struct ceph_client *cl = s->s_mdsc->fsc->client;
 	u32 sets;
 
 	ceph_decode_32_safe(p, end, sets, bad);
-	dout("got %u sets of delegated inodes\n", sets);
+	doutc(cl, "got %u sets of delegated inodes\n", sets);
 	while (sets--) {
-		u64 start, len, ino;
+		u64 start, len;
 
 		ceph_decode_64_safe(p, end, start, bad);
 		ceph_decode_64_safe(p, end, len, bad);
 
 		/* Don't accept a delegation of system inodes */
 		if (start < CEPH_INO_SYSTEM_BASE) {
-			pr_warn_ratelimited("ceph: ignoring reserved inode range delegation (start=0x%llx len=0x%llx)\n",
-					start, len);
+			pr_warn_ratelimited_client(cl,
+				"ignoring reserved inode range delegation (start=0x%llx len=0x%llx)\n",
+				start, len);
 			continue;
 		}
 		while (len--) {
-			int err = xa_insert(&s->s_delegated_inos, ino = start++,
+			int err = xa_insert(&s->s_delegated_inos, start++,
 					    DELEGATED_INO_AVAILABLE,
 					    GFP_KERNEL);
 			if (!err) {
-				dout("added delegated inode 0x%llx\n",
-				     start - 1);
+				doutc(cl, "added delegated inode 0x%llx\n", start - 1);
 			} else if (err == -EBUSY) {
-				pr_warn("ceph: MDS delegated inode 0x%llx more than once.\n",
+				pr_warn_client(cl,
+					"MDS delegated inode 0x%llx more than once.\n",
 					start - 1);
 			} else {
 				return err;
@@ -757,12 +759,13 @@ static struct ceph_mds_session *register_session(struct ceph_mds_client *mdsc,
 	INIT_LIST_HEAD(&s->s_caps);
 	s->s_nr_caps = 0;
 	refcount_set(&s->s_ref, 1);
-	INIT_LIST_HEAD(&s->s_waiting);
-	INIT_LIST_HEAD(&s->s_unsafe);
-	xa_init(&s->s_delegated_inos);
 	s->s_num_cap_releases = 0;
 	s->s_cap_reconnect = 0;
 	s->s_cap_iterator = NULL;
+	INIT_LIST_HEAD(&s->s_waiting);
+	INIT_LIST_HEAD(&s->s_unsafe);
+	xa_init(&s->s_delegated_inos);
+	atomic_set(&s->s_num_deleg_inos, 0);
 	INIT_LIST_HEAD(&s->s_cap_releases);
 	INIT_WORK(&s->s_cap_release_work, ceph_cap_release_work);
 
@@ -3984,6 +3987,7 @@ static int encode_snap_realms(struct ceph_mds_client *mdsc,
 static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 			       struct ceph_mds_session *session)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_msg *reply;
 	int mds = session->s_mds;
 	int err = -ENOMEM;
@@ -4002,9 +4006,22 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 	if (!reply)
 		goto fail_nomsg;
 
+	mutex_lock(&session->s_mutex);
+
+	/* Serialized by s_mutex against concurrent ceph_get_deleg_ino(). */
 	xa_destroy(&session->s_delegated_inos);
+	atomic_set(&session->s_num_deleg_inos, 0);
+	if (session->s_state == CEPH_MDS_SESSION_CLOSED ||
+	    session->s_state == CEPH_MDS_SESSION_REJECTED) {
+		pr_info_client(cl, "mds%d skipping reconnect, session %s\n",
+			       mds,
+			       ceph_session_state_name(session->s_state));
+		mutex_unlock(&session->s_mutex);
+		ceph_msg_put(reply);
+		ceph_pagelist_release(recon_state.pagelist);
+		return;
+	}
 
-	mutex_lock(&session->s_mutex);
 	session->s_state = CEPH_MDS_SESSION_RECONNECTING;
 	session->s_seq = 0;
 
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index b1939f9162284..847f04424be3c 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -210,6 +210,7 @@ struct ceph_mds_session {
 	struct list_head  s_waiting;  /* waiting requests */
 	struct list_head  s_unsafe;   /* unsafe requests */
 	struct xarray	  s_delegated_inos;
+	atomic_t	  s_num_deleg_inos;
 };
 
 /*
-- 
2.53.0

