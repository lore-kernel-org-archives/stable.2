Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794360659;
	b=H6w51shhOMD6vOu0TP6/gBrNa2FQpvYi/hXUFQA4UWUg3lOfcIHfiI68/CvJBhXzTcW1
	 WFetNKNQSVDE1GfNyQjPQvzrIbMZbxdfwULqg8CXp/LPzqSBIGg7fPIBa8Ik5lI3E72XB
	 D6wWbzZLoDJo04py+EfthSkPAJv6NkCxoGKryB0pZ0s8+c9lSpRQ/UB3xYFVfVxhkrQVv
	 cWibzJo8Wr7w+hfSfP9KF4Kc5UhSRjRhcv0fRvvJG2uXuSqFADsdsRbrzlwY+SlnopiQC
	 AfHG2P6wRWdyB0Or+Iwev2I5dIlNcRHk2IxRugyZrYemgYBcJUqVPBYP0DDxMG/+Kaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794360659;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=j3rDMSSsi8X7tG9zheqVZJ/0qpOILdzxmSnY5/XHtxc=;
	b=LnAOySBGFxbB6kAt5SkGnfTeIC+Yuqcnv7IJxLTrD8JkpGQUhNalKknskmQkyMycLxuz
	 /lrvTVuFEQSSRG+nTqHTRixkYcRIuIB3vBZ09T1Dmmhyx4dsXKvwDpjJfPv4HA9VDFySB
	 rEthXsI4ykMGJFNUfypRNa8AtKiH6jZ3W+QwqFck7URWlBgyKb/0MsRXVju4UIUdmlT/k
	 CDln0p03aI1T3//7qZULTRazdVcRPnjB0glUVZt9KbTAwu7VXbxymBZe/1Pjo6dv0ZZOe
	 0lT2oA/1Cobg2iqFEYfmzrCxr8w2ek/17rekgmikAqtSc2rxTYchbzFDlvnDibzC6fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Scm8sp1t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA8B606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Scm8sp1t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292B71F0089F;
	Wed, 11 Nov 2026 01:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794360658;
	bh=j3rDMSSsi8X7tG9zheqVZJ/0qpOILdzxmSnY5/XHtxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Scm8sp1tCb3kbB6SFvwlvYfAx2powxKWIOJSMq0JrMTd49Zj+zsLYYFr2JcQp7IS+
	 UJ3E+rnJSyGVeCoFrXfPmpYRLh2RhOi/ERYwcwjocLP7ikevvQZT28ENypGf8tGarS
	 sE3pKULsQXub0J4y41PQRBxfBLLfAsCz24q43hwwnKPJmrR060//7RH++VXPQqJPAO
	 nXvC2KSUTUar+Q2BEwlNh5+M4qqkSYMDFyL9NPhedbUjR3CBRWnPmqCHUw4hBTE+Uc
	 i5FG6dejtFXKtHmJZdPmQvUwGkCDQbz0YEPMg1Q9XrR8rycArZvn2mYHNHgWpQU/S4
	 L3q7pRiVMAxuQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] fs/ntfs3: validate EA entry layout against ef->size in ntfs_read_ea
Date: Tue, 10 Nov 2026 20:30:54 -0500
Message-ID: <20261111013025.390312-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051533-failed-6.18-351817226fbf@kernel.org>
References: <20261107051533-failed-6.18-351817226fbf@kernel.org>
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

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 01e56820ef52d14a5560fb7c0c6f2f75ef6f9393 ]

In ntfs_read_ea(), the ef->size branch only checks that the declared
entry size fits the remaining buffer; unlike the zero-size branch it
never verifies that the entry's own name and value fit inside ef->size.
A crafted image can thus present an in-bounds ef->size with an arbitrary
elength, which find_ea()/ntfs_get_ea() later use as the memcpy length,
reading past the allocation and leaking adjacent heap memory:

  BUG: KASAN: slab-out-of-bounds in ntfs_get_ea (fs/ntfs3/xattr.c:302)
  Read of size 65535 at addr ffff888010770b0f by task exploit/142
   ...
   __asan_memcpy (mm/kasan/shadow.c:105)
   ntfs_get_ea (fs/ntfs3/xattr.c:302)
   ntfs_getxattr (fs/ntfs3/xattr.c:848)
   __vfs_getxattr (fs/xattr.c:446)
   vfs_getxattr (fs/xattr.c:479)
   do_getxattr (fs/xattr.c:808)
   filename_getxattr (fs/xattr.c:837)
   path_getxattrat (fs/xattr.c:876)
   do_syscall_64 (arch/x86/entry/syscall_64.c:94)
  ...
  The buggy address is located 15 bytes inside of
   allocated 20-byte region, cache kmalloc-32

Validate the name/value layout in the ef->size branch too, bounding it
against ef->size, as the zero-size branch validates it against the
buffer.

Fixes: be71b5cba2e6 ("fs/ntfs3: Add attrib operations")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
[almaz.alexandrovich@paragon-software.com: remove duplicate check of need > ea_size]
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Stable-dep-of: 351817226fbf ("fs/ntfs3: validate the EA value length in ntfs_read_ea()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/xattr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 0dbb410d51dfe..e246263aa3948 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -165,6 +165,8 @@ static int ntfs_read_ea(struct ntfs_inode *ni, struct EA_FULL **ea,
 			/* ef->size must fit the list and cover the record. */
 			if (ea_size > bytes || ea_size < need)
 				goto out1;
+			if (bytes < offsetof(struct EA_FULL, name))
+				goto out1;
 			continue;
 		}
 
-- 
2.53.0

