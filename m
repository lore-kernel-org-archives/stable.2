Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794361153;
	b=PK6nYxEXmwkFV9BBw5u3W+ZlsRRXsO70sXqivnWz+frqY8abYZFDwnW8l6Q3WXYTIw3z
	 V/ISazZ4dsykjwfs6BqMghL0JJrhTONvSkW1kfxymNNLCekJpJiwZLwGUzE9g2w0yEbjr
	 LIizrASr7BUweTIxdhBohsTDlAz435PGIX5JXKSkSD+w0pFc3XemKgCq/8LJtIHt67O5l
	 b2PNzdg7GWdwen0hIblGzO6X+mrEM/3MW4dgEroNmLjdL7JPC4pizOcpJX3A3X0mt60YJ
	 mIvFxNYA/Hm6O7y+SMm7Cd5YVC6goJ89i6jBJAInWs3OyMOMBU2mNsLI8J6RG0KNgGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794361153;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Z6yEtH086fpIhPsgKPuOB1INrxJiGmVHE4vm0yfr0Gk=;
	b=mSeRTQtot8KLaRZYsZ/hotwzSzHO7V+c6rtoW/m9V8OXhowRj+htaYR3Fn0uDPWWjMpL
	 vWdWsPKCjH/aXXeaGhczccbk5KfCoaX0oxhtWgls45ubk1M2Nj+mBzxFH4yr0SW7cOV4T
	 EPalr00FUwVjcFcMU4jZG8XAwmTYk9kckTp0dP3e9x2iHrddZ+r2Az0sQpp3uiWKrPaij
	 0d5tMZ0FMRkI5tPdoz4OIznY5OTh1A2E8TlYcPBiwfIqnfh7iC3YxOfasF0HQwxeLVls/
	 sOwsk3linAwLH/rFljEdxIbYGp0X0PMjOqbwLY76vYQu+qHoapCztwO2zGb4CC6Z+Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ETrgISe+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C0B606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ETrgISe+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2923B1F0089F;
	Wed, 11 Nov 2026 01:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794361152;
	bh=Z6yEtH086fpIhPsgKPuOB1INrxJiGmVHE4vm0yfr0Gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ETrgISe+dSyOhShieBcPcz0oeooJx0n3U1VIRKAHZ6IesqOl9xJeEZkNqfH4khS2C
	 RoI4PUrBZ6mz2Rwu0ANnHqHpbgdFg3uRkAjMv4qrlXVahDtO9VcZ+ntYdtLQ6R1EoG
	 5zokdR5RIR9iqLPU3eeJiwaNh4is+7fSVTKT23WvLqryuRiXCv80LbS6ftAiwQi4Qi
	 40fV5KkyZ5lEeI1Rl3QP0W8t/gxGJarBZ6HLMVYE4uf8r1RN37wT1qcE7CRGc0MgaG
	 J3vzZ3j6SFxXxgKLqUynhjnybsB1BvYKBigePN7b1SVzyVcCGACTNri1v53NQr0fzp
	 WPav/GZm12N1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] fs/ntfs3: validate EA entry layout against ef->size in ntfs_read_ea
Date: Tue, 10 Nov 2026 20:39:08 -0500
Message-ID: <20261111013841.400667-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054019-failed-6.6-351817226fbf@kernel.org>
References: <20261107054019-failed-6.6-351817226fbf@kernel.org>
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
index 30d5b8b53974d..1e4ad309423f5 100644
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

