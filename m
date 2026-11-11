Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794361626;
	b=Ej9Vrtg0YrrJMNldQagVjocKTDw05acTbebjI5Vj8gw5Ex0RIBYpZEVrt/7UkCkcCbse
	 KnIvnDSTxMmV3zkSOTECDPJZL2QhF3k6ErUo3i1/kppOxeQOjnd/YVHEUYf8rt2VA6iDB
	 iNBsCq2kZjN5AZ5RWtcQFcRQwAfHit7stjUmp+LQVUtQhDkSzhnjFCPbrNz/g6WtB6RpC
	 86naZ6ZmlYzQ39b2ITaNW4s7K0vgpma+zssWY28WiILcFkljdOAbta32rOrGck7o0utVa
	 IIQ8w+u/U9do74ceCZA9+bUWR+Hgv/shlD7j2kyGuK/BqxXE2fCm6prxweY962nAfbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794361626;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nxz/R649IZ/yGS+eJ/YKey2bnJw5KJOCR0AYZFndUio=;
	b=eN3w1maY2F8TPe+aCoDjMISy60JYTuMw4gSXZlBB2O5NB69rxM8E0bcXqVvrVfp9JIib
	 w6Mjd2khX1CedXj+uQAj8KoyRVUKhs9ODlQRE4IPcCV+7DAOo3xN+9mQJWP6YJBx+iazg
	 zE4tpfHGKXPhYpU5UeBBIj/lAw8pDFaA84Nzzr46lN0ozNaSmkOwqI27hpX8QqkLei8UG
	 aNWgVL8FrxyOcD83fJ26ZrcbuK46vnht9I7Z2ncvAoPzgTRgNe9sw8n91cvqoO1ExRZ1v
	 57hhphPwnCW6hzLFN+DejE8V+4ZZ+Qn4kd3teYA2SFegKytlCDIgu2rSTsyf4RoM7jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ejCgmayI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F42F606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ejCgmayI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E081F0089F;
	Wed, 11 Nov 2026 01:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794361626;
	bh=nxz/R649IZ/yGS+eJ/YKey2bnJw5KJOCR0AYZFndUio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ejCgmayIbiDVYqHSExU2JZ2vl/i5ua+X4n/ZOI4JAY53N01YyxoyghzLmkhfmoZ4F
	 JCDZUFIofktt+B+Q9Fe+YGBFKoWqCCRws3qKBbdodoPAWCEraSaIuCx3cLFq0QAY6i
	 l5lrfFMcNQ7AdjlEg78E+g4ORsdFwQBXCcmIaKhEcTriF53z4qTvkHPVKHEzdQNOP5
	 esw79r/y7OzCp6id6s5PvJ9GfOw0zzNwsQZWybX2e8JGvMXuFV2BDEsaXp/NazjH1+
	 GilNFjgn3/w36tYJtx03FZAUEWqK4nxZ0Cfh6Fs4kFx4qEkrv8xRpDtlaNvbyrvRio
	 DX2ksX+lOYhnQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] fs/ntfs3: validate EA entry layout against ef->size in ntfs_read_ea
Date: Tue, 10 Nov 2026 20:47:02 -0500
Message-ID: <20261111014422.420984-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055620-failed-6.1-351817226fbf@kernel.org>
References: <20261107055620-failed-6.1-351817226fbf@kernel.org>
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
index a235050e92098..b3b07322db990 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -164,6 +164,8 @@ static int ntfs_read_ea(struct ntfs_inode *ni, struct EA_FULL **ea,
 			/* ef->size must fit the list and cover the record. */
 			if (ea_size > bytes || ea_size < need)
 				goto out1;
+			if (bytes < offsetof(struct EA_FULL, name))
+				goto out1;
 			continue;
 		}
 
-- 
2.53.0

