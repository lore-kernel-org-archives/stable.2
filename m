Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429FF3403F7
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 11:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784634440; cv=none; b=YfjAwMF0W2fYZPcQU03pA8t1I13fNi9PJoqo3esaCW/ijlxeLnqniItemgKM/74E43iQzkC5DaknFOHXCeRyHH/+B0MGliNWPH/NuD6ucBpuN9bwY0q4b7HB67qHlPzNDCTz1By9L6QbyXPPOY6VN42A1hWJHR6HvIFl/+fijI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784634440; c=relaxed/simple;
	bh=iu2008KtTD6wYz2FqtsfzcK/MYVkN/IBbDovKW9lajQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J5mY+LTxgLjmvjPp1EoRvbntgmgq2lGNDPtlerth4taPqRASVmcgUlMorsMIA6ZaB5+n6dC+W+uM3wsTBflmDbAXIWC5tigPpveZAg8XKo1RqtQcABcbWhQqbIvUnZf687mIlqE0Bu1OFK2INE58hwkoqtAn+Hz4mPll6vCO2nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iT1arrRD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iT1arrRD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21281F000E9;
	Tue, 21 Jul 2026 11:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784634439;
	bh=SJHAP7klLEoMhjzewv4T7lofXfU8p3UkLBv6dqHza/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iT1arrRD0aA1ohDIDjOkRbm9uK9YNdBTccKLL+d41roNVpRp1HPs7i+4e24zw54r5
	 zXHy8Ne6XL+MKi7fN9GPYVXMq4EO0jhQXmKkbd6APVB5pR8S1RG4TVL7fNFyc6TAFr
	 iwL8jM3I/DJRkWXIBtM6O2vXfMtSfTfDES2u0dlLya1HAmp9WQfvvnSPIZ3JyGuDdE
	 CejHDEr7iOXmrvWAkQ2UisykysIdSUAGtaGPsVUff3uKUexlgWOlIwVcLyaJ4oruOy
	 EYKk/waBZKtc260bQeglQ0/nORQAzQCHpJx8/2DGxTrQcQ59CaJMhc7lly6N4WwhR8
	 Rsh1abEemJmJg==
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
Subject: [PATCH 6.6.y] mm: do file ownership checks with the proper mount idmap
Date: Tue, 21 Jul 2026 07:47:16 -0400
Message-ID: <20260721114716.3688887-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071511-chastise-overplay-bd0a@gregkh>
References: <2026071511-chastise-overplay-bd0a@gregkh>
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
[ dropped const from file_owner_or_capable()'s parameter since 6.6's file_mnt_idmap() takes a non-const struct file * ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/fs.h | 5 +++++
 mm/filemap.c       | 2 +-
 mm/madvise.c       | 3 +--
 mm/mincore.c       | 3 +--
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5a897ee50f29cf..e6b2e2749e3791 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2481,6 +2481,11 @@ static inline struct mnt_idmap *file_mnt_idmap(struct file *file)
 	return mnt_idmap(file->f_path.mnt);
 }
 
+static inline bool file_owner_or_capable(struct file *file)
+{
+	return inode_owner_or_capable(file_mnt_idmap(file), file_inode(file));
+}
+
 /**
  * is_idmapped_mnt - check whether a mount is mapped
  * @mnt: the mount to check
diff --git a/mm/filemap.c b/mm/filemap.c
index 7416868d044913..5a340cad44ed41 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4314,7 +4314,7 @@ static inline bool can_do_cachestat(struct file *f)
 {
 	if (f->f_mode & FMODE_WRITE)
 		return true;
-	if (inode_owner_or_capable(file_mnt_idmap(f), file_inode(f)))
+	if (file_owner_or_capable(f))
 		return true;
 	return file_permission(f, MAY_WRITE) == 0;
 }
diff --git a/mm/madvise.c b/mm/madvise.c
index 3d6370d3199f31..73ea053c9003ab 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -334,8 +334,7 @@ static inline bool can_do_file_pageout(struct vm_area_struct *vma)
 	 * otherwise we'd be including shared non-exclusive mappings, which
 	 * opens a side channel.
 	 */
-	return inode_owner_or_capable(&nop_mnt_idmap,
-				      file_inode(vma->vm_file)) ||
+	return file_owner_or_capable(vma->vm_file) ||
 	       file_permission(vma->vm_file, MAY_WRITE) == 0;
 }
 
diff --git a/mm/mincore.c b/mm/mincore.c
index dad3622cc963e8..2a55eed792b647 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -167,8 +167,7 @@ static inline bool can_do_mincore(struct vm_area_struct *vma)
 	 * for writing; otherwise we'd be including shared non-exclusive
 	 * mappings, which opens a side channel.
 	 */
-	return inode_owner_or_capable(&nop_mnt_idmap,
-				      file_inode(vma->vm_file)) ||
+	return file_owner_or_capable(vma->vm_file) ||
 	       file_permission(vma->vm_file, MAY_WRITE) == 0;
 }
 
-- 
2.53.0

