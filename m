Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859F946A606
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 15:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784648917; cv=none; b=fOmK0Z4BG5VnQWJcessDRyNHObCnGYNia2c8OX9aMWLxNXNmeU0f+r9lu3R6s65exy78CsiFyXWAeZB9fJigP9P3gqIkx5+kOdauii+JucK6zHBEMshYFoj2yWFBBKtCWgXDTbNTprBY60LCPKfNmS+Bqlip5djRx4V70pgAecI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784648917; c=relaxed/simple;
	bh=9YVny3jj8G3vvONCxCBtL9NP8xiFTtwyn8k7H27Zavo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4J1wjGe2O8VZPFCHvPI/L+48juLGMJ9NRj++rlCTvchRCp4x3YrOhZTK7D14Mvlg9WXlxl31VvZZcyqO4lTYvG0W5nTytnrZu1cWIl/NxlvPdeGTLgT2mKj+PdpBmhRd9jiPvsVIKylI5TVoOxP33DPbfm0pdXWItn6K5lp/dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noFMYLjL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noFMYLjL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2101E1F000E9;
	Tue, 21 Jul 2026 15:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784648916;
	bh=WqX54hRsefShspL4175TV4GTs6vXKXYaD6f9sd4s1+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=noFMYLjLYNhHFDP1etxBBGeRmKbzomZJF6ZxibrWuUHjtkjbpXE4G57SKSL3gLtux
	 iaGaaNG4jusePZEMktTyD2eHd5lwvIOTwPyBrggWt9ReGeuKbmyI7gcaDghQiNq5GQ
	 tHTCwH+41qex/i5XNr8RGmwcdi6I9yOiWCPm7dpmE138ttQqrsEfROQ12y51rQDI6g
	 PZ0uLf9zguV0vwcKZ8MlUvUW0givbOX0cZtSPFfX4qmu3B0IUn4qqvmyuAQuZR95B+
	 EqJJnEdwzX0iBF52mYbPOUdNlfCw45LNES+q+LA4BJimG9EkbURiyGKFiy9+8vmHkN
	 /S6cD+dOV5k/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pedro Falcato <pfalcato@suse.de>,
	Jan Kara <jack@suse.cz>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jann Horn <jannh@google.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm: do file ownership checks with the proper mount idmap
Date: Tue, 21 Jul 2026 11:48:33 -0400
Message-ID: <20260721154833.4004864-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071536-clobber-subdivide-b287@gregkh>
References: <2026071536-clobber-subdivide-b287@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pedro Falcato <pfalcato@suse.de>

[ Upstream commit e187bc02f8fa4226d62814592cf064ee4557c470 ]

Ever since idmapped mounts were introduced, inode ownership checks (for
side-channel protection) in mincore() and madvise(MADV_PAGEOUT) were done
against the nop_mnt_idmap, which completely ignores the file's mount's
idmap.  This results in odd edgecases like:

1) mount/bind-mount with an idmap userA:userB:1
2) userB runs an owner_or_capable() check on file that is owned by userA
on-disk/in-memory, but owned by userB after idmap translation
3) owner_or_capable() mysteriously fails as the correct idmap wasn't supplied

In the case of mincore/madvise MADV_PAGEOUT, this is usually benign,
because file_permission(file, MAY_WRITE) will probably succeed, as it uses
the proper idmap internally, but it does not need to be the case on e.g a
0444 file where even the owner itself doesn't have permissions to write to
it.

Since this is clearly not trivial to get right, introduce a
file_owner_or_capable() that can carry the correct semantics, and switch
the various users in mm to it.

The issue was found by manual code inspection & an off-list discussion
with Jan Kara.

Link: https://lore.kernel.org/20260625153853.913949-1-pfalcato@suse.de
Fixes: 9caccd41541a ("fs: introduce MOUNT_ATTR_IDMAP")
Signed-off-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jann Horn <jannh@google.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/fs.h | 5 +++++
 mm/madvise.c       | 3 +--
 mm/mincore.c       | 3 +--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 02c83cd07d4f20..aa54f17ea132ca 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2811,6 +2811,11 @@ static inline struct user_namespace *file_mnt_user_ns(struct file *file)
 	return mnt_user_ns(file->f_path.mnt);
 }
 
+static inline bool file_owner_or_capable(struct file *file)
+{
+	return inode_owner_or_capable(file_mnt_user_ns(file), file_inode(file));
+}
+
 /**
  * is_idmapped_mnt - check whether a mount is mapped
  * @mnt: the mount to check
diff --git a/mm/madvise.c b/mm/madvise.c
index 06c5adcaec5955..d24df19d54743f 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -565,8 +565,7 @@ static inline bool can_do_pageout(struct vm_area_struct *vma)
 	 * otherwise we'd be including shared non-exclusive mappings, which
 	 * opens a side channel.
 	 */
-	return inode_owner_or_capable(&init_user_ns,
-				      file_inode(vma->vm_file)) ||
+	return file_owner_or_capable(vma->vm_file) ||
 	       file_permission(vma->vm_file, MAY_WRITE) == 0;
 }
 
diff --git a/mm/mincore.c b/mm/mincore.c
index 1eb6aac88d8450..47e89cf37062e9 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -168,8 +168,7 @@ static inline bool can_do_mincore(struct vm_area_struct *vma)
 	 * for writing; otherwise we'd be including shared non-exclusive
 	 * mappings, which opens a side channel.
 	 */
-	return inode_owner_or_capable(&init_user_ns,
-				      file_inode(vma->vm_file)) ||
+	return file_owner_or_capable(vma->vm_file) ||
 	       file_permission(vma->vm_file, MAY_WRITE) == 0;
 }
 
-- 
2.53.0

