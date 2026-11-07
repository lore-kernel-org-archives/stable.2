Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045918;
	b=f92x0lhrYXLOFa9reiBq+pY1eLlH9s574X3smBgEpt3qYLJM3VD2s4BIuIHxzp12iyOU
	 LUPZHPAZLM6Bw9XCJVZOmbNHHMrxfwX7OayodPjUo11/VA+Tcwc1VUHJ/pERJIyX2H4iI
	 h/fhH0LTdCcMRkYkDSVPwNEhS9TK05IbGA4m1PYVEAS0lfAUxaOTBPuM7qhe3doYcT7xI
	 KznLzR1u3AGuu9+4vFQDyh6TwcEq3o6f++eANyyu6lnameDQ14V5Ay7S7N8x+t7wj9azY
	 HxXIS7Dx0/zMDSgbbVyZuNddrPMhhlF7sAFZqmgtG8Ap6o8LK0tE6xYhZkUf6k3iGUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045918;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ys1i9eh49U6C4QKrorjn2EElkt2SFhGE7kV4mgLqpCw=;
	b=ibwcG9ivxmodSVq0Ct9hhZqPAI5xnmDkkr67nojBD9P0th1IUprSRheFkMNdk0TnBQAE
	 Wa09sKc2oIQiYM7wtvY3sPkSUtyUthpsRe7kNqLbuihTsPd/bvEGddBt+Xa70jnjiVdfz
	 3bkjZnEzBCMyFtiVZPFXleop/LTp0vt5sjvWLJYSBfI0jokgNTd4AhTImKUZJ6ufsfMyZ
	 2a6C6+o7PMVrFTvaqsZDKvxlsFGiGxpUIGgvfVRrqbeo1A/BYxWb3ajcuz0QMNUODs8RO
	 KJ5KwZvd/FFxcWRV06KZPUbW/wmu4x+af1XJnN9UCG3SK9BHP1L083QlfMpHMlO9GQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MfWVoFMA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAC2606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MfWVoFMA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36511F0089F;
	Sat,  7 Nov 2026 10:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045918;
	bh=ys1i9eh49U6C4QKrorjn2EElkt2SFhGE7kV4mgLqpCw=;
	h=From:To:Cc:Subject:Date;
	b=MfWVoFMAZwjqVz2UysxqPl8VvOfMPnMiiIZsCl+NvFWQc8GbO+m9ESMPul3DMKzK/
	 Wz3Zby8yvukrcyrHrWgJ3Vpu3ay9YPBZNOy82ZDinCzm333dpnTBbvklZ1sco/E68O
	 uOf2nQulvs2OaNyhIXfoPlnZyJ5jNrhTOYCgWKkMwUvhbwqDMadx1EzBBkc7u7Wb/a
	 P1qGZsZeHBxY0SOgZLUpK/5AUn7zi6Y61N/zJYvr6/tZeJERehc0+dlJJIkHFR6hKE
	 vC2GEtl/ZZFWMv9+aHiXHhW9/t6+UA8r0kBP4mBBiTv1ns4YaCEgyH36j+EajQ1aNA
	 xu58VBrpIOKDw==
From: Sasha Levin <sashal@kernel.org>
To: daehojeong@google.com,
	chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: expose resizable_tail feature via sysfs" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:05:16 -0500
Message-ID: <20261107050516-failed-7.3-714f97f477fe@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 714f97f477fe2834ac9e9e66979ae52824b9f914
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050516-failed-7.3-714f97f477fe@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 714f97f477fe2834ac9e9e66979ae52824b9f914 Mon Sep 17 00:00:00 2001
From: Daeho Jeong <daehojeong@google.com>
Date: Wed, 14 Oct 2026 15:21:38 +0000
Subject: [PATCH] f2fs: expose resizable_tail feature via sysfs

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
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 2 +-
 fs/f2fs/sysfs.c                         | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 0d8ef1fafc1fd..e7e968c6df922 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -271,7 +271,7 @@ Description:	Shows all enabled kernel features.
 		inode_crtime, lost_found, verity, sb_checksum,
 		casefold, readonly, compression, test_dummy_encryption_v2,
 		atomic_write, pin_file, encrypted_casefold, linear_lookup,
-		fserror, metadata_cache.
+		fserror, metadata_cache, resizable_tail.
 
 What:		/sys/fs/f2fs/<disk>/inject_rate
 Date:		May 2016
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 32dfd564094bc..430356e500afd 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1427,6 +1427,7 @@ F2FS_FEATURE_RO_ATTR(linear_lookup);
 F2FS_FEATURE_RO_ATTR(packed_ssa);
 F2FS_FEATURE_RO_ATTR(fserror);
 F2FS_FEATURE_RO_ATTR(metadata_cache);
+F2FS_FEATURE_RO_ATTR(resizable_tail);
 
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
 static struct attribute *f2fs_attrs[] = {
@@ -1602,6 +1603,7 @@ static struct attribute *f2fs_feat_attrs[] = {
 	BASE_ATTR_LIST(packed_ssa),
 	BASE_ATTR_LIST(fserror),
 	BASE_ATTR_LIST(metadata_cache),
+	BASE_ATTR_LIST(resizable_tail),
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs_feat);
-- 
2.53.0




