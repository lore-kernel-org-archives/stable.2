Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794360890;
	b=JSsizU/zmjDGIPdWRWylWtjaN/kPE3lmKHlfSj2ubKVGIF3dZ0CHZ8Vr/bCD42PHzrOb
	 6yk0h+kyOvkcJ0rC801oQWZln/Xn9RBOjToiLS15uoDTXWj9+1FHqgfBV74rYK0toHhhe
	 IEh2n4ido28ofNeyKmqARG5y+LdekGNBCpNIBPE0xPnCC+shSord1t/sJ0kpqA38gMDVY
	 RHQ1Zg0JgjOpcJyESojYEh94qziaXfL5yXi3qDlOUqy6eiBscEouIKiyBD0FWEpBhJSJ7
	 eDHb6AsuPfVjI9fz6Pfd246TC7Ipfv9RtqCOXefukPwJilrZxrWQFxCDR8uIbCbbbHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794360890;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=u6/s6LN52rfvbAsAmwwOjb9ryLMXcNKk98FuUPse1nY=;
	b=VRSvLocnOOhKcuaF9OJzMFfpQpIpp7tJV4aUZGKiYEGFAEfpDkavYTOC5vT6D+uTlmol
	 8vY+wGR10cBtNf+mb4stMakwLjEPjXSw5OF9SGB/l+hxvd5jdLGbA4rf46nzG1RcKDab6
	 K96AaxunybiLxSjmnIJYKnY6bMwJ+TI/pQixgQRu0c6Qn1NWbeQEMgBQZTYhNfEa8h+cM
	 sGtATbXawV07AB31tDZH2VPIpJhaWjpaCLP/6G3JlOnx4VT3OSCulDC0Qmwpchkfqbce0
	 oQf78ZwXOORSyxoRY0X7T3v5UDkaLBCokKtQ5YXTA3N82P1GXuAJ9VkuReIp+f5IedA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GSHoDgPZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86906606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GSHoDgPZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CA21F0089F;
	Wed, 11 Nov 2026 01:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794360890;
	bh=u6/s6LN52rfvbAsAmwwOjb9ryLMXcNKk98FuUPse1nY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GSHoDgPZAWtcSjrSG+meBU48fA517SkuvjSYUT93wVysdtmst+cGOJnAfKFxbJGLn
	 6DsJKcPc62Id3b4Wk7Iuew7Qg3gaz8CLK2MdgeTE+CWQKVbbmloGyjHPlsdbpnyTko
	 dN+ZsmiwcKC/lFVBwPqIHZEJ/AyiyMV8uZilzBD0zHuQCh8ktSmD8KenAaador1Iap
	 rnm5Ql/jkGBV8pBasZF3miXdhzO/MjXh/LB6FK8iUnjEio9t7xSf4/XtPQU1C5JadK
	 9vBkqts8tCrGet1xWmuq3SqqR4zEcwohvdCzrmWyra+ri2dPAYPgpd5U2pxNHQp17A
	 E9xejaqfq89BQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] fs/ntfs3: validate EA entry layout against ef->size in ntfs_read_ea
Date: Tue, 10 Nov 2026 20:34:46 -0500
Message-ID: <20261111013418.395574-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052729-failed-6.12-351817226fbf@kernel.org>
References: <20261107052729-failed-6.12-351817226fbf@kernel.org>
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
index ee69f3447597b..cbfc544482b9c 100644
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

