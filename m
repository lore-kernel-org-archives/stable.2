Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794353322;
	b=YLjdnNiuDlwMRpHhAkMzoz5tDs9nePm0oVmNnTzhjPnykvRSk18yGJ9W6B7B6F6TV61o
	 GrrPFAPzZ7hvUBvwT2nt5nlb9ZHYYL0Bnw7dUfYMzMUe/4ASnwf3JEIX+KDEVNRFHcNij
	 ZxkSFLdRqURrQ2tvAKK0yWcbRVcNdC0+jl+pDizuUvkEMzob2x8lbszGCg+B50AaTjxqj
	 IPzlHkDJOPYAOnmzNULlG59EaqdipbfR4HUdOBymClHH/XfupzxDNcI7MPgI/8OqpVokl
	 tImhBkiow2xAuFVCnUaADCC3JdLLHL5xMqVtldcsEXdteuSj1SQGOwtqxzQ0D4UmLIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794353322;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TEY/yufRcWpDpZ1Ielq8gN62LSc24FZGq3pRocTI+AA=;
	b=uQZW0D1OHIeZlyBPdqvvntVKftj+XQkUHJwi7hSRgsPNCYRl8yBuL6RSyf/kAwRM5jZl
	 qQ5rdvbhGyF03FVmncQ79lVJmy8JT4iOvgxr77AP4XWkICyJgxfs7EUGIDY7EhCuoRgSE
	 ebVdWBXl/1ngPS9J6E6Uk/Q2GEoMQNMh6uhZ8FOl7Jz58ioisdeAlyvFUak8x0qJnpGoB
	 zaDpUsNUO/rTqJEO1MpTPUlLumSeVvhRYBaN1hp4Qkxq6dz6STrsZLOIWKruE1dHzPveB
	 tIuVF22T69KTLvqPo4jbRe7x2y96RjR+iJwSOZlQKg30AyDxuP3z6ChbQ9IA7tJX3jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=abJNS8gj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8678606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=abJNS8gj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5911F0093C;
	Tue, 10 Nov 2026 23:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794353321;
	bh=TEY/yufRcWpDpZ1Ielq8gN62LSc24FZGq3pRocTI+AA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=abJNS8gjofavs+OrMb6nFh5Uo+HC/cXIfLnHX1/gDD+dPFiiWsg3NyERXAWGSx7kx
	 SfCsxR1yBd/MXr5pM5XANXo9RCxWPJE6/zOudm6oBM6Co5uX2t0eEHRNX8TFftFnvv
	 L1kFmmnhKVmQ71DLINuU3wkJNQOP9Fd2SzqgZKsYAZorgyq/4o/LLBXfwFYTDbxDW2
	 8Pt0pqCTQmnsjBtkjKlZMy02n0C6PpyN60oOFJzvbIarY7brvhaD6B+wdxw9kYGoUs
	 vsPp7aSDZufgjy4smYCkdPds8T4fIQHIYtSWJ6cvDUr8PFP9UewEvTFV6TBZlBrc4B
	 IgmxdhjAClZYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daeho Jeong <daehojeong@google.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] f2fs: expose resizable_tail feature via sysfs
Date: Tue, 10 Nov 2026 18:28:39 -0500
Message-ID: <20261110232636.128574-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050516-failed-7.3-714f97f477fe@kernel.org>
References: <20261107050516-failed-7.3-714f97f477fe@kernel.org>
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

From: Daeho Jeong <daehojeong@google.com>

[ Upstream commit 714f97f477fe2834ac9e9e66979ae52824b9f914 ]

Userspace has no way to know whether the kernel supports the
resizable_tail_secno mount option before mounting. Passing it to a
kernel without the support fails the mount with -EINVAL, and checking
/sys/fs/f2fs/<disk>/pinned_area_max_secno requires an f2fs instance
to be mounted already.

Export /sys/fs/f2fs/features/resizable_tail so that userspace can check
the support before formatting or mounting a filesystem that relies on
resizable_tail_secno, e.g. a filesystem whose tail is going to be shrunk
online later.

Cc: stable@vger.kernel.org
Fixes: c966d29e01bb ("f2fs: support resizable tail section and unify pinned allocation")
Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ sashal: Placed resizable_tail entries after fserror because metadata_cache is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 2 +-
 fs/f2fs/sysfs.c                         | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 0cebc89799dd1..4f3915948176f 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -271,7 +271,7 @@ Description:	Shows all enabled kernel features.
 		inode_crtime, lost_found, verity, sb_checksum,
 		casefold, readonly, compression, test_dummy_encryption_v2,
 		atomic_write, pin_file, encrypted_casefold, linear_lookup,
-		fserror.
+		fserror, resizable_tail.
 
 What:		/sys/fs/f2fs/<disk>/inject_rate
 Date:		May 2016
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 811e350a14302..5ee12547171cc 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1404,6 +1404,7 @@ F2FS_FEATURE_RO_ATTR(linear_lookup);
 #endif
 F2FS_FEATURE_RO_ATTR(packed_ssa);
 F2FS_FEATURE_RO_ATTR(fserror);
+F2FS_FEATURE_RO_ATTR(resizable_tail);
 
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
 static struct attribute *f2fs_attrs[] = {
@@ -1574,6 +1575,7 @@ static struct attribute *f2fs_feat_attrs[] = {
 #endif
 	BASE_ATTR_LIST(packed_ssa),
 	BASE_ATTR_LIST(fserror),
+	BASE_ATTR_LIST(resizable_tail),
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs_feat);
-- 
2.53.0

