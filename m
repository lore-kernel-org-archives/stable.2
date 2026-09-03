Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614924AF9F7
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443190; cv=none; b=bZh+8Ro9z8B+XDXfykutyL8mDypBaj2Sncu8Zo7l8tYbXcpSpIjQRuoR4NCF1S7Sty/gMo0nUbSP8BgO7S6Clk3WZkoV1MAiXqEFz0TAIQgl3EN9DRTjsLZ6lV/ik6//nKZyN+5bLe939QeiFxWLhdDXlFS6A1OkHmIwbTDHCaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443190; c=relaxed/simple;
	bh=FmhdFp2SRheIy+pqxETlXcg+dtWNc2r+fxQsLXdVUKo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kQmZzvugzBatAhXQ6f0/V+cmepR3CbHdOCKRNp0Sy5sP/VzQbyUj5LYh+UIkugweyzxqGqqrcbQsHyu7E6g4xYqdRcqdCwbwA652mr3ZoOlTHRuIwqcC0v8a29RyY9NwXG5F8/IaDsPxfHS6YOT4+/B5CiZGdg8KH2AlkGQXSiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S4Clruab; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S4Clruab"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38931F00A3E;
	Thu,  3 Sep 2026 13:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788443177;
	bh=5kQbf5kEaq6lZscaVAsP3JrucgB4/0nYd1Q/ibPDwbw=;
	h=Subject:To:Cc:From:Date;
	b=S4ClruabUYOEHE4yvpiiSi1JynX9FxF7ZMeAMUsaxpQ7pRTay8H6BVEsq5qi8JZxL
	 nQICosVPbsB/PqmBFZ4AvyNSbum51b8kGU+iTDNwX0im0xqeqDtydpdNvEK6Z/ekLB
	 fmV6kPHoWqvr5xLicboYFEJCTU0vbEZmyD5qib4s=
Subject: FAILED: patch "[PATCH] ceph: force a cap message when a deferred revoke can't be" failed to apply to 6.6-stable tree
To: max.kellermann@ionos.com,amarkuze@redhat.com,idryomov@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:21:49 +0200
Message-ID: <2026090349-casualty-awhile-c7a6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 8fdf946445732c2bcd685abc8bd0e509d2ebc158
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090349-casualty-awhile-c7a6@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8fdf946445732c2bcd685abc8bd0e509d2ebc158 Mon Sep 17 00:00:00 2001
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 18 Aug 2026 20:40:05 +0200
Subject: [PATCH] ceph: force a cap message when a deferred revoke can't be
 acked immediately

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

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 539a24965afe..bcb04c6cb92c 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -987,6 +987,27 @@ int __ceph_caps_revoking_other(struct ceph_inode_info *ci,
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
@@ -1431,6 +1452,9 @@ static void __prep_cap(struct cap_msg_args *arg, struct ceph_inode_info *ci,
 	cap->implemented &= cap->issued | used;
 	cap->mds_wanted = want;
 
+	if ((ci->i_ceph_flags & CEPH_I_FLUSH_FORCE) != 0 && !__ceph_is_any_revoking(ci))
+		clear_bit(CEPH_I_FLUSH_FORCE_BIT, &ci->i_ceph_flags);
+
 	arg->session = cap->session;
 	arg->ino = ceph_vino(inode).ino;
 	arg->cid = cap->cap_id;
@@ -2048,6 +2072,14 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
 
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
@@ -3774,13 +3806,30 @@ static void handle_cap_grant(struct inode *inode,
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
+			set_bit(CEPH_I_FLUSH_FORCE_BIT, &ci->i_ceph_flags);
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
index 0020ccd0f974..72d4e30304dc 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -709,6 +709,10 @@ static inline struct inode *ceph_find_inode(struct super_block *sb,
 #define CEPH_I_ASYNC_CREATE_BIT		(12) /* async create in flight for this */
 #define CEPH_I_SHUTDOWN_BIT		(13) /* inode is no longer usable */
 #define CEPH_I_ASYNC_CHECK_CAPS_BIT	(14) /* check caps after async creating finishes */
+#define CEPH_I_FLUSH_FORCE_BIT		(15) /* a revoke's response was deferred;
+					      * force a cap message to the MDS once
+					      * the deferred work completes
+					      */
 
 #define CEPH_I_DIR_ORDERED		(1 << CEPH_I_DIR_ORDERED_BIT)
 #define CEPH_I_FLUSH			(1 << CEPH_I_FLUSH_BIT)
@@ -721,6 +725,7 @@ static inline struct inode *ceph_find_inode(struct super_block *sb,
 #define CEPH_I_ODIRECT			(1 << CEPH_I_ODIRECT_BIT)
 #define CEPH_I_ASYNC_CREATE		(1 << CEPH_I_ASYNC_CREATE_BIT)
 #define CEPH_I_SHUTDOWN			(1 << CEPH_I_SHUTDOWN_BIT)
+#define CEPH_I_FLUSH_FORCE		(1 << CEPH_I_FLUSH_FORCE_BIT)
 
 /*
  * Masks of ceph inode work.

