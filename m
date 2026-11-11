Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794361153;
	b=r6NdUlDHD309ZR08Dfim/FfLsOLDD8PKitzETuCmbNYIUgzVPhXCFZJN0vXN+f23/VDd
	 h8EdA4Gu3VrLcOnbeDawDGYBIKvdg+S1qRR8X/8Y5TlDQKHRYmVyrVAc0+CQoCe4dh9Gq
	 gOLI3DtLmYWtbAd6iA8TKsfc9toCdMhBIsU49PAcAAREsU8TAFBzbMb0s4WvPhjvPw0wt
	 vZjJD5zKjCiBzNkFiAuMVcNZfFpH0LU/huE9H4yCBX6OMqyWGmn7DN635NLbVU5LSZXrB
	 L4Pa2ReqsqSgVU3nx/eByjPGe1nmH16xAQIqc5lvxAZTJQwjyqmVqH/JKIN8CqhAp7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794361153;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VorAujKphfpG8eeS+T+1nFrLZ1Z79Fw87OjenFO1M90=;
	b=wiKn0NVGCC/vxDYJWSWFwfYRRRklkwVCpCaUDiGYO6go7ze7lDtu/Sx/f0Gq4b1mNOtU
	 FYVDVCBP9dmqhGEBDC0PjRzUdd4gTIjiIOXG+6Z51DCs4/VgsAHi98v439suimWSzkN1y
	 SKtWys1n2jkveVup32gwAHJeIPv5xiiibkC1lpJuXF/lGNVsbLTLNEWNMcr/QeDdtJsI1
	 5rmuLu0uGGHxD6ZKwsxTFRJ06fEVfsn3srwUDv8PHI7E7cPlnrlZbgFqj0g8pI/cSYfuz
	 cDcWem/Ud18z4nh29kScyLAJ5YVyg23Kbp4V1Y2ksyrWwuLgSwbayAHtD0FZGCo22Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sgf5vlqY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3916606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sgf5vlqY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AFAD1F0093C;
	Wed, 11 Nov 2026 01:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794361153;
	bh=VorAujKphfpG8eeS+T+1nFrLZ1Z79Fw87OjenFO1M90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sgf5vlqYPUAlFSxwCIfAx3uRaiLvNF7fDkLxMkBHV2MlbiDDFMBE41dsVZX0YSITD
	 HSQDgn1h/UC9SYs5W1t7qbJYdIRBAO4bjD/LkKnJEN6dQEtEEN9KdDX3PJ4UtLbSbN
	 kZ8fbyh2DgrX0GzMC9BW4muvK70yi4gQe5ZdKGBoIqg8nhJh/Izc7AnqKmpUKyz5UO
	 jCEuio6twjksNXs7Pfjlwt7pKzFS+0kWLPvbtJj6X9y6S0X/e1yPwcZRkHji+2Kor7
	 BnyOzEfsMT12L98krfvGFd7pJpp5tolS8HMP2wWUNXmdGMxloxNhYAuk8JMXsX80zB
	 XJqnJ+eHMpjxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] fs/ntfs3: validate that EA entry size covers its name and value
Date: Tue, 10 Nov 2026 20:39:09 -0500
Message-ID: <20261111013841.400667-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111013841.400667-1-sashal@kernel.org>
References: <20261107054019-failed-6.6-351817226fbf@kernel.org>
 <20261111013841.400667-1-sashal@kernel.org>
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

From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

[ Upstream commit 60bd50014cc9a97c5e34a8bddd2bad4d2dc5acb7 ]

ntfs_read_ea() walks the on-disk $EA attribute and checks each EA_FULL
entry for consistency.  For an entry with a non-zero ef->size (the
offset to the next entry) the loop only verifies that this stride fits
in the remaining buffer, and then continues:

	if (ef->size) {
		ea_size = le32_to_cpu(ef->size);
		if (ea_size > bytes)
			goto out1;
		continue;
	}

It never verifies that the entry's own name (ef->name_len) and value
(ef->elength) actually fit inside ef->size.  A later reader trusts
ef->elength unconditionally; ntfs_get_ea() does:

	len = le16_to_cpu(ea->elength);		/* up to 0xffff */
	...
	if (len > size)				/* size is the user buffer */
		return -ERANGE;
	memcpy(buffer, ea->name + ea->name_len + 1, len);

A crafted image with a small but valid ef->size (e.g. 24) and
ef->elength == 0xffff therefore passes validation, and a getxattr()
with a large enough user buffer copies up to 64 KiB starting just past
the short entry -- an out-of-bounds read of the ea_all allocation that
leaks adjacent kernel heap memory to userspace.

  BUG: KASAN: slab-out-of-bounds in ntfs_get_ea+0x2b8/0x3f0
  Read of size 65535 ...
   ntfs_get_ea -> ntfs_getxattr -> vfs_getxattr -> do_getxattr

The zero-ef->size branch already computes the same struct_size() to
derive the stride; mirror that in the non-zero branch and reject the
entry when its declared size cannot hold the name and value.

Fixes: 0e8235d28f3a ("fs/ntfs3: Check fields while reading")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Stable-dep-of: 351817226fbf ("fs/ntfs3: validate the EA value length in ntfs_read_ea()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/xattr.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 1e4ad309423f5..5af61c90cc234 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -167,6 +167,24 @@ static int ntfs_read_ea(struct ntfs_inode *ni, struct EA_FULL **ea,
 				goto out1;
 			if (bytes < offsetof(struct EA_FULL, name))
 				goto out1;
+
+			/* Check if we can use fields ef->name_len and ef->elength. */
+			if (bytes < offsetof(struct EA_FULL, name))
+				goto out1;
+
+			/*
+			 * The declared entry size (ef->size) must be large
+			 * enough to hold the name and value.  Otherwise a later
+			 * reader such as ntfs_get_ea() copies ef->elength bytes
+			 * starting past the entry, reading out of bounds of the
+			 * ea buffer and leaking adjacent heap memory to
+			 * userspace via getxattr().
+			 */
+			if (struct_size(ef, name,
+					1 + ef->name_len +
+						le16_to_cpu(ef->elength)) >
+			    ea_size)
+				goto out1;
 			continue;
 		}
 
-- 
2.53.0

