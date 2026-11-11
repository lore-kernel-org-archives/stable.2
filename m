Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794360420;
	b=c5tIZuUXMwTZBt3FjsNn/IEHSIeSDZUfff/W6qGVJJ0brbUmVXQWwm2xUBhpiZrGWQcp
	 Hp2wCDCYbZAZwwP2xQasbw2CWiT34DGC+0xr8mIoRjIIgcNEUV7igQMIx4gJbfSuHdnK2
	 S9+lTYUxV5mqvWeoyCq4NvD4MzRV7BLGXFRlNal+qXOmLBlBgnN0K+eB4gisrFOevEIlL
	 FMuPBGRzlljdj3NIpNG+L2OjtghJOdAtg/4yhKtmfmEEF4dPphlIKUhQnLQZQvFINAxXR
	 ZeGJIuBMmMrgeR9G6hIfaEZcseYsak1jJhy9PNKw4JsVdNEjX+IfQ4VoVRK9LBFWQUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794360420;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LF75WM1e0ZZfm9P5CgUGsRJvgXXsVccMYOyhFLNRtfY=;
	b=kG349xqckgVQBltqiC0DvWvfRLNiSV4AGXbKHKgy+2s9gcPXXHQd+Ba5yvPh52bafA/o
	 xdDzPUGKyc58V+xla38DB9ZH9lTl01vhvQmGhTZBBlx+KklVfwFEVHmRFoPAcgmTfq68n
	 AWz/kW+DLgAmsJKrudnZiiVWUuIvOd2OTJaZ6qjpN+uoXSTKE89/kXe4w1PMcV4dpDD5/
	 O6qIYrAmAHPR11Ys5yC3hu0TvjS903Lp69m6Dj4kC1GUHlLoXrz5yQYo+tT5n6ldnp7Y2
	 CTWzsgvwo1EGjAu13atV2NLAixCzMDZYPML/5nj9XcQhfhv90sHQZ82ktI1hvN9Hs9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YoyJmLDp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E6A606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YoyJmLDp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617AD1F0089F;
	Wed, 11 Nov 2026 01:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794360419;
	bh=LF75WM1e0ZZfm9P5CgUGsRJvgXXsVccMYOyhFLNRtfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YoyJmLDpQHsy0i5wPBVxRWiDjIiA+HAMuZ+V/SsTdbPp/I0T5swpyiSfL9Rm/jSn9
	 AyaJ7YYbC4h3bI8GfggzFDziA8PwD5FbAgNW6VlXw8XZoJi3cLGNQ3LAUDDLAUsLVb
	 RFI1Ai0Ep+crxbd9hUpmv2V1nRn+/Eby3ftIu2kAU9l9r54Hh6ouL03OmmzzwParUW
	 i4Lkl8JOYOHzDA0YM5RtuJ2LIN6oxBAam4WKC/4tclIjiDBptU6pFNqL5IGNqO6E/A
	 1XMAQIC+UAcPMcHhCLEOdJS5MJJeC4NdmkDQro4cIBYIDGTr2J1ZFiPgwfWnN5WGro
	 2/LDqfsLlp8ow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/3] fs/ntfs3: validate EA entry layout against ef->size in ntfs_read_ea
Date: Tue, 10 Nov 2026 20:26:56 -0500
Message-ID: <20261111012627.383224-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050557-failed-7.3-351817226fbf@kernel.org>
References: <20261107050557-failed-7.3-351817226fbf@kernel.org>
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
index 594ef6860b93b..9eccd95a718cb 100644
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

