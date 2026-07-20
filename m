Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C909F42A176
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557553; cv=none; b=DR+apBJfSYNHQ9su38uTYdRH4vSMu2brAy0/ubbFvf2WXAd4OpqqoOYS95i27NTls5KIZh5hu9xXZZKTAY/lWgGX7R3LPtlK/KVx4ew7pyRXgPW+M1QJ2yxA4lccOegcuZ+6fn68tszErqNbSsLjsv8VWnW/Nqvo/D3F4Txs6n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557553; c=relaxed/simple;
	bh=g/sGZsww3m13piLl+SXK5ffffy4MCyTBXNMBs1xTeTA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tBAt2nA+ya3+vpIHEL7mthjFZDkjOBDPpqd4Ii2LItwuycMhX7lmpVpI/MnHqESGtCLcjXlragzNq8RcoeB3rDN87JWgzz1+F2sPxj4y4FvbPsORHzSL48Kn0hgAc9gK2YtI32OptbIGd5QigKdBonhhZZ2IkyX135zon4MjGUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fpCkKkHu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fpCkKkHu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1EB01F000E9;
	Mon, 20 Jul 2026 14:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784557551;
	bh=2PyjQZxiujv+I9NO+U1WIpQ3yv02ZscQRaKUJoPlPWc=;
	h=Subject:To:Cc:From:Date;
	b=fpCkKkHuGLh3r3rB2z+4MA7+b3VaMia+dNilHbS7RzEXKVZEtG6L45TJ/VhrTjA0d
	 t/C69/+PlxfqKiOdBgPCc+0BqunQAwjondlOYuO8ND1irZjJZiaQU28hvVMMCOK9vj
	 +Jf4BBp/ia/c1TH+HxL0ltUybU5H83pxemHCy9PA=
Subject: FAILED: patch "[PATCH] fs/ntfs3: bound copy_lcns dp->page_lcns[] index in analysis" failed to apply to 5.15-stable tree
To: michael.bommarito@gmail.com,20260502154252.164586-1-jhapavitra98@gmail.com,almaz.alexandrovich@paragon-software.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 16:25:42 +0200
Message-ID: <2026072042-litter-retold-6915@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 5e7b598660cfa8e5af172cf4c65cffc126333307
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072042-litter-retold-6915@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5e7b598660cfa8e5af172cf4c65cffc126333307 Mon Sep 17 00:00:00 2001
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Fri, 15 May 2026 12:34:05 -0400
Subject: [PATCH] fs/ntfs3: bound copy_lcns dp->page_lcns[] index in analysis
 pass

In log_replay()'s analysis pass, after find_dp() returns a
valid DIR_PAGE_ENTRY for the (target_attr, target_vcn) tuple,
the copy_lcns block walks lrh->lcns_follow further entries:

	t16 = le16_to_cpu(lrh->lcns_follow);
	for (i = 0; i < t16; i++) {
	    size_t j = (size_t)(le64_to_cpu(lrh->target_vcn) -
	                        le64_to_cpu(dp->vcn));
	    dp->page_lcns[j + i] = lrh->page_lcns[i];
	}

find_dp() only validates that target_vcn falls within
[dp->vcn, dp->vcn + dp->lcns_follow), i.e., that the FIRST
cluster is covered.  The walk through the further entries is
not bounded against dp->lcns_follow.  For a malformed LRH
where target_vcn = dp->vcn + dp->lcns_follow - 1 and
lrh->lcns_follow > 1, the i > 0 writes overflow the dp's
allocated page_lcns[] array.

Add the missing j + lrh->lcns_follow <= dp->lcns_follow guard.

Reproduced under UML+KASAN on mainline 8d90b09e6741 as a
slab-out-of-bounds write of size 8 from log_replay+0x68d4 on
the mount path.

This is distinct from Pavitra Jha's 2026-05-02 patch
("fs/ntfs3: validate lcns_follow in log_replay conversion",
<20260502154252.164586-1-jhapavitra98@gmail.com>) which
addresses the separate version-0 dirty-page-table conversion
path's memmove(&dp->vcn, ...) call.  The two fixes are
complementary; both should land.

Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
[almaz.alexandrovich@paragon-software.com: clang-formatted the changes,
fixed conflicts]
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 2bd8754ef26d..81a305d4bcf2 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -3394,8 +3394,8 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
 
 		if (run_get_highest_vcn(le64_to_cpu(attr->nres.svcn),
 					attr_run(attr),
-				        le32_to_cpu(attr->size) - 
-				                le16_to_cpu(attr->nres.run_off),	
+					le32_to_cpu(attr->size) -
+						le16_to_cpu(attr->nres.run_off),
 					&t64)) {
 			goto dirty_vol;
 		}
@@ -4585,22 +4585,34 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 		 * whole routine a loop, case Lcns do not fit below.
 		 */
 		t16 = le16_to_cpu(lrh->lcns_follow);
-                t32 = le32_to_cpu(dp->lcns_follow);
-                if (le64_to_cpu(lrh->target_vcn) < le64_to_cpu(dp->vcn)) {
-                        err = -EINVAL;
-                        goto out;
-                }
+		t32 = le32_to_cpu(dp->lcns_follow);
+		if (le64_to_cpu(lrh->target_vcn) < le64_to_cpu(dp->vcn)) {
+			err = -EINVAL;
+			goto out;
+		}
 
-                for (i = 0; i < t16; i++) {
-                        size_t j = (size_t)(le64_to_cpu(lrh->target_vcn) -
-                                            le64_to_cpu(dp->vcn));
-                        if (j >= t32 || i >= t32 - j) {
-                                err = -EINVAL;
-                                goto out;
-                        }
-                        dp->page_lcns[j + i] = lrh->page_lcns[i];
-                }
+		/*
+         * find_dp() only validates that target_vcn is the first
+         * cluster covered by dp.  The walk through lrh->lcns_follow
+         * further entries must stay within the allocated
+         * dp->page_lcns[] array, which is sized by dp->lcns_follow.
+         */
+		if (le64_to_cpu(lrh->target_vcn) - le64_to_cpu(dp->vcn) + t16 >
+		    le32_to_cpu(dp->lcns_follow)) {
+			err = -EINVAL;
+			log->set_dirty = true;
+			goto out;
+		}
 
+		for (i = 0; i < t16; i++) {
+			size_t j = (size_t)(le64_to_cpu(lrh->target_vcn) -
+					    le64_to_cpu(dp->vcn));
+			if (j >= t32 || i >= t32 - j) {
+				err = -EINVAL;
+				goto out;
+			}
+			dp->page_lcns[j + i] = lrh->page_lcns[i];
+		}
 		goto next_log_record_analyze;
 
 	case DeleteDirtyClusters: {

