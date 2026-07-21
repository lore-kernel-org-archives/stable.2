Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E5938399A
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784653988; cv=none; b=pGgNWRMvGQHtwWUq3uVOg9C6bgLCSFOFWQynuO3kfNYAP6KIBIvl/iiOX1qWR/55E/cPcPpYAeY3t+R9WRofayI/jtJoAw99xoyKy3LSKm/dv3omxotgQuhsH98hFh4c8HxpRr9YBzfugzSz495n2qBtg1U6sIA2WJz/236WkM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784653988; c=relaxed/simple;
	bh=dpWNt6AvLSvXlhXhG6vkLFopcNKY30ZDqXHHCOU9n7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6QYQYQSgR+pNBXmyU4G7cfoAm/dpCBUTWdxdip0Ifc31ZTF5C006IGxbD6Iq7XHa0EwJE2VSV3eugJMjUG8oewzX5EWu07xa+hJRNyOXaUZ6W7BRqdIFtWkTAjhBIgcVnTMWCzZg31691sspC6dCm2V6uV9P3GBkwR7RCAKpdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8plI2oB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8plI2oB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA61B1F00A3A;
	Tue, 21 Jul 2026 17:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784653987;
	bh=Ry09ICTEopii93NkzILJAN1L6Yl/Cufz/AIo3v5Fn8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M8plI2oBZL5M2ejgZ4jqBjp0Ft6CGBQ6EwnDHxBc0DLPPYF0x/BPd/PEnOkMbOKHP
	 DE/JBfN/ydASBASjODufAmlpQHfB2oQ5z6pPkoq2NPM0RY8wvWlRycn4iImO4m525N
	 eWToH9mVEIuVSqg9tyKbNWfMEb8imcLQczILDXg90TUypNHuMpFC9iLw8q0sEG/PJs
	 8TNc/yL+AQSBjY36EV9HbvlYKwk8Z1f/sCsBDQfK7hIpQ0yYrY9O86GMDEwoKACaqJ
	 qnlmJkMlkI3Q5wTqkX8DhdB96yzzy0wAX+5tZwDktV3YvceylvYJ5zM9F1OTLBS3In
	 BNrIKVV7NBB6g==
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
Subject: [PATCH 5.15.y] mm: do file ownership checks with the proper mount idmap
Date: Tue, 21 Jul 2026 13:13:04 -0400
Message-ID: <20260721171304.107883-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071536-chirpy-unmindful-fd3a@gregkh>
References: <2026071536-chirpy-unmindful-fd3a@gregkh>
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
index 72a956d243c2e8..5b85d4e7321994 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2743,6 +2743,11 @@ static inline struct user_namespace *file_mnt_user_ns(struct file *file)
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
index ef9382f7762481..367220e1fe52af 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -544,8 +544,7 @@ static inline bool can_do_pageout(struct vm_area_struct *vma)
 	 * otherwise we'd be including shared non-exclusive mappings, which
 	 * opens a side channel.
 	 */
-	return inode_owner_or_capable(&init_user_ns,
-				      file_inode(vma->vm_file)) ||
+	return file_owner_or_capable(vma->vm_file) ||
 	       file_permission(vma->vm_file, MAY_WRITE) == 0;
 }
 
diff --git a/mm/mincore.c b/mm/mincore.c
index 9122676b54d67c..889d84477a7708 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -166,8 +166,7 @@ static inline bool can_do_mincore(struct vm_area_struct *vma)
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

