Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47F9447805;
	Sat, 26 Sep 2026 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790430315; cv=none; b=BOY/9k33f3h8tQCrmSkurU5ENSFI/byvq+44R4ApXOxzRgha12e3WWPXvIvQJqzT3XhgVauTGc/qU5F834BcvIdJb2sEch9DfuRjSe27tOrd1Ods99JCy10vKsTw2rW9RpPdqU8e89EbyueMbIvfCqsRdNzCQ+bs2mvvxvfyFBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790430315; c=relaxed/simple;
	bh=qjzyr9oOFCQtbhOYyMevjtzmsQ3/A2ZsxLiMFpms8C4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WFOOCdidPH118dV32uX2LdJMoM6ZMVE41bnryXhfCrsLobm0fkwaEeehGlq5BJfsm4WjQ3E6AzF9rxQYAw+Nou/m57+3bO6ObjcLiF4cHdG5anqh5Z75yLZVqvhrrSJ3hW+G5EigpV5qfmjxMmwfTItr4uz/T5pTJIPKFOn2Ah8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBB2xf2g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBB2xf2g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C941F00893;
	Sat, 26 Sep 2026 13:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790430313;
	bh=Ign46ywl3A+42wbnWlR8papXUt8GTkDpdLGnl922ODM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=IBB2xf2gVplduH5YMQ/SXDg5Q6ywACioB792FhUgDeOmMpYdfV29qg4bma/Z5vSVR
	 2ldlKL94Zu7ILLwrw9Y2M7N4s4Cj7mRxWEBbmmH+frmSpjm6zJ7rQ4HY0/IbVjozWm
	 ZIBRc4YpvGnv+Zzugc1oUTcnBqghhk3DPa2m/GGnLSTI/kcJxUjrggCykzV0k2afE0
	 +UAlUrBFtVX+oiJ6CAm5Cm2xoft6X6Y7KcCgVh4jYrevhJCNxPAvqq1rDcZ0R2HzVN
	 pchw+/xlTZPkiVwytlHFgPzscX/DZeUof9uSyyO3/I2ja0+TzhYJqRmqCCeNekwyCk
	 abbO7LQadClug==
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 26 Sep 2026 15:44:28 +0200
Subject: [PATCH 05/10] namespace: check the target before walking it in
 do_mount_setattr()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-work-mount-fixes-2-v1-5-f357abf3d17b@kernel.org>
References: <20260926-work-mount-fixes-2-v1-0-f357abf3d17b@kernel.org>
In-Reply-To: <20260926-work-mount-fixes-2-v1-0-f357abf3d17b@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2131; i=brauner@kernel.org;
 h=from:subject:message-id; bh=qjzyr9oOFCQtbhOYyMevjtzmsQ3/A2ZsxLiMFpms8C4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtPxPt8F47rI/1ocMj4dYC0eMSfntDVYWue5zzTNrzr
 Pt/gkNJRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERiXBgZ7myo7/63QGxRmsyr
 uxmNO7U/XF3o98unZZl7U0+JtHLGJIa/Iqs+FOpvz11xTt6my06aU/3k9ZdZ2/mz970orktN3bO
 KFQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

When mount_setattr() changes the propagation type to MS_SHARED
do_mount_setattr() takes namespace_sem and calls invent_group_ids()
which walks the whole target tree with next_mnt() and allocates a peer
group id for every mount that doesn't have one.

Whether the caller may touch the target at all is only checked
afterwards under mount_lock. If it may not, cleanup_group_ids() walks
the tree a second time on the way out to free the ids again.

A detached tree that a file descriptor keeps alive, a mount in another
mount namespace or a mount below the root of an anonymous mount
namespace does a bunch of allocation work that is completely useless
because it will fail and revert right after.

Do the right thing and check the target right after taking namespace_sem
instead. A mount leaves its namespace only under namespace_sem so the
mount stays stable. The check under mount_lock stays for the case where
no propagation change is requested and namespace_sem isn't taken.
Callers get the same EINVAL as before.

Fixes: 2a1867219c7b ("fs: add mount_setattr()")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namespace.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index c7e252eb249e..de28fe9058ab 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4976,6 +4976,11 @@ static int do_mount_setattr(const struct path *path, struct mount_kattr *kattr)
 		 * propagation.
 		 */
 		namespace_lock();
+		/* invent_group_ids() walks the tree, only walk a mounted one */
+		if (!anon_ns_root(mnt) && !check_mnt(mnt)) {
+			namespace_unlock();
+			return -EINVAL;
+		}
 		if (kattr->propagation == MS_SHARED) {
 			err = invent_group_ids(mnt, kattr->kflags & MOUNT_KATTR_RECURSE);
 			if (err) {
@@ -4988,6 +4993,7 @@ static int do_mount_setattr(const struct path *path, struct mount_kattr *kattr)
 	err = -EINVAL;
 	lock_mount_hash();
 
+	/* Checked under namespace_sem already if the propagation changes. */
 	if (!anon_ns_root(mnt) && !check_mnt(mnt))
 		goto out;
 

-- 
2.53.0

