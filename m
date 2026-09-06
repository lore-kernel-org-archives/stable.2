Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5305A31714A
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 14:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788704542; cv=none; b=fpt9GTmKyK+IX+BsfzCER9x0ZJHR4EPT89oSeqnlOyDkJctt/pjLGuG/ArDEj4uDtKGP2zPI9djmdjYIfr+fXdoL2CII5jqwoilo+P/1ToNUlaG1e5/5ysEcgXucquW94tIjUGQ968vnogGfOWy2ifN1l5+mmJDnTGCG54gDznQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788704542; c=relaxed/simple;
	bh=R05NHfQj7Gy7YIXDocDz15z1k8DeOU9CCHeG1q7jdY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6H1EPFP7AbWeUTCvr9eBFy1oNRupkHrzi3UVcJ6dvJYWXm5kEBGsV03SnsMQx49JHlA7onOyzQaf1R15+RZ85leve2si8xQundtWnFi87/MllSs7tmesdw+U+iAOsP4dIFjHeh+EjLe62tmoKR2rwdIjvoA8d69yO/EufLMzKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htr99Dxi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htr99Dxi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AEED1F00A3A;
	Sun,  6 Sep 2026 14:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788704541;
	bh=i4k1qSZkaQz5edxc9Y+xNULj9d0eMYv+42XjlScEYHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=htr99DxioPPRWw3zkFR705CLqHToIgaerKrE1kGEx+gALnqsmpfXqTy9bisewxuVv
	 ssPKbKtvOzLRRXPMPgW7bigcPRJavZGvYhvaJwOMjNmOO5khWY4vfp63EWXTDD7yRP
	 1za4NfANkHKHgOrEjggdc7QT7FUl79LIKUraRw5ndA4Zpttk1PHW137t7Ki0sP8J/L
	 UTuTSgk3koTBKJiMca132aifAnQ5hnpqfeWH/wV9Ss5bpVp1MGWc0TGxoGhb5wu+Z/
	 ZcO6EZ60RTNC3r0sb0d0Eye7sIUPcaR8zPoxdByO8EuOVyQJZsfFzytsHFh3IIKclM
	 vflTEBv9qrUHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ceph: force a cap message when a deferred revoke can't be acked immediately
Date: Sun,  6 Sep 2026 10:22:18 -0400
Message-ID: <20260906142219.1129796-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090348-lying-spectacle-efd3@gregkh>
References: <2026090348-lying-spectacle-efd3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Max Kellermann <max.kellermann@ionos.com>

[ Upstream commit 8fdf946445732c2bcd685abc8bd0e509d2ebc158 ]

When the MDS revokes capabilities, handle_cap_grant() normally
guarantees a response by setting `CHECK_CAPS_FLUSH_FORCE` (see
commit 31634d7597d8 ("ceph: force sending a cap update msg back to MDS
for revoke op")), so ceph_check_caps() sends a cap message even if the
client would otherwise decide it has nothing to do.  That guarantee is
skipped whenever the revoke has to be deferred (via revoke_wait):
revoking Fb while dirty data is still buffered (writeback is queued
first) or revoking Fc while pages are cached (async invalidation is
queued first).

In those cases, the ack is left to the deferred completion
(ceph_put_wrbuffer_cap_refs() after writeback, or the invalidate
worker after invalidation); both of which call ceph_check_caps(ci,0)
i.e.  without `CHECK_CAPS_FLUSH_FORCE`.  Nothing gets sent under one
of the following conditions:

- the inode is retaining caps because the file was used recently
  (file_wanted != 0; retain |= CEPH_CAP_ANY)

- the revoked cap is still used because the page was re-cached (e.g. a
  file being re-read)

- the MDS has meanwhile re-granted, so `issued==implemented` and the
  client sees nothing being revoked

The client then never emits the cap message which the MDS is waiting
for.  The MDS blocks on the revoke indefinitely and logs, for minutes
or hours:

  client.NNN isn't responding to mclientcaps(revoke), ino 0x... pending
  pAsxLsXsxFsxcrwb issued pAsxLsXsxFsxcrwb, sent 964.899182 seconds ago

The client-side state at that point shows the full cap set still
issued, nothing in the revoking/flushing sets.  Thus nothing gets
sent.

This patch fixes it by remembering that a forced response is expected.
When a revoke is deferred, set `CEPH_I_FLUSH_FORCE` on the inode.
ceph_check_caps() replays it as `CHECK_CAPS_FLUSH_FORCE`, so whichever
path re-checks the inode next (the writeback/invalidate completion,
the delayed worker, or any other caller) is guaranteed to send a cap
message to the MDS.  __prep_cap() clears the flag once a message is
actually built.

This is the deferred-path counterpart of the existing
`CHECK_CAPS_FLUSH_FORCE` handling; a normal (non-deferred) revoke
still forces the response inline as before.

Cc: stable@vger.kernel.org
Fixes: 31634d7597d8 ("ceph: force sending a cap update msg back to MDS for revoke op")
Fixes: 257e6172ab36 ("ceph: don't let check_caps skip sending responses for revoke msgs")
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Alex Markuze <amarkuze@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
[ adapted named atomic Ceph inode flag operations to lock-protected mask operations ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/caps.c  | 63 +++++++++++++++++++++++++++++++++++++++++++------
 fs/ceph/super.h |  4 ++++
 2 files changed, 60 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 07e3236e0f976..0c62f0c02bcac 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -978,6 +978,27 @@ int __ceph_caps_revoking_other(struct ceph_inode_info *ci,
 	return 0;
 }
 
+/*
+ * Return true if any cap of this inode holds caps which the MDS has
+ * revoked, but which we have not released yet.
+ */
+static bool __ceph_is_any_revoking(const struct ceph_inode_info *ci)
+{
+	const struct rb_node *p;
+
+	lockdep_assert_held(&ci->i_ceph_lock);
+
+	for (p = rb_first(&ci->i_caps); p; p = rb_next(p)) {
+		const struct ceph_cap *cap =
+			rb_entry(p, struct ceph_cap, ci_node);
+
+		if (cap->implemented & ~cap->issued)
+			return true;
+	}
+
+	return false;
+}
+
 int __ceph_caps_used(struct ceph_inode_info *ci)
 {
 	int used = 0;
@@ -1420,6 +1441,9 @@ static void __prep_cap(struct cap_msg_args *arg, struct ceph_cap *cap,
 	cap->implemented &= cap->issued | used;
 	cap->mds_wanted = want;
 
+	if ((ci->i_ceph_flags & CEPH_I_FLUSH_FORCE) != 0 && !__ceph_is_any_revoking(ci))
+		ci->i_ceph_flags &= ~CEPH_I_FLUSH_FORCE;
+
 	arg->session = cap->session;
 	arg->ino = ceph_vino(inode).ino;
 	arg->cid = cap->cap_id;
@@ -2034,6 +2058,14 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
 
 	if (ci->i_ceph_flags & CEPH_I_FLUSH)
 		flags |= CHECK_CAPS_FLUSH;
+	/*
+	 * A revoke whose response was deferred (see handle_cap_grant()) must
+	 * still be acknowledged.  Replay the forced flush here so that even a
+	 * check triggered by writeback/invalidation completion sends a cap
+	 * message to the MDS.
+	 */
+	if (ci->i_ceph_flags & CEPH_I_FLUSH_FORCE)
+		flags |= CHECK_CAPS_FLUSH_FORCE;
 retry:
 	/* Caps wanted by virtue of active open files. */
 	file_wanted = __ceph_caps_file_wanted(ci);
@@ -3753,13 +3785,30 @@ static void handle_cap_grant(struct inode *inode,
 	BUG_ON(cap->issued & ~cap->implemented);
 
 	/* don't let check_caps skip sending a response to MDS for revoke msgs */
-	if (!revoke_wait && le32_to_cpu(grant->op) == CEPH_CAP_OP_REVOKE) {
-		cap->mds_wanted = 0;
-		flags |= CHECK_CAPS_FLUSH_FORCE;
-		if (cap == ci->i_auth_cap)
-			check_caps = 1; /* check auth cap only */
-		else
-			check_caps = 2; /* check all caps */
+	if (le32_to_cpu(grant->op) == CEPH_CAP_OP_REVOKE) {
+		if (revoke_wait) {
+			/*
+			 * We can't ack the revoke yet: the response is deferred
+			 * until the writeback or cache invalidation queued above
+			 * completes.  Set the CEPH_I_FLUSH_FORCE flag to remember
+			 * that a forced cap message is owed so that deferred
+			 * completion (ceph_put_wrbuffer_cap_refs() or the
+			 * invalidate worker, both of which call ceph_check_caps())
+			 * actually sends one, even if by then the revoked caps look
+			 * unused, the inode is retaining caps, or the MDS has
+			 * re-granted them.  Without this, the cap message is never
+			 * sent and the MDS hangs ("isn't responding to
+			 * mclientcaps(revoke)").
+			 */
+			ci->i_ceph_flags |= CEPH_I_FLUSH_FORCE;
+		} else {
+			cap->mds_wanted = 0;
+			flags |= CHECK_CAPS_FLUSH_FORCE;
+			if (cap == ci->i_auth_cap)
+				check_caps = 1; /* check auth cap only */
+			else
+				check_caps = 2; /* check all caps */
+		}
 	}
 
 	if (extra_info->inline_version > 0 &&
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 29a980e22dc26..07d66b2d83ace 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -672,6 +672,10 @@ static inline struct inode *ceph_find_inode(struct super_block *sb,
 #define CEPH_I_SHUTDOWN		(1 << 13) /* inode is no longer usable */
 #define CEPH_I_ASYNC_CHECK_CAPS	(1 << 14) /* check caps immediately after async
 					     creating finishes */
+#define CEPH_I_FLUSH_FORCE	(1 << 15) /* a revoke's response was deferred;
+					   * force a cap message to the MDS once
+					   * the deferred work completes
+					   */
 
 /*
  * Masks of ceph inode work.
-- 
2.53.0

