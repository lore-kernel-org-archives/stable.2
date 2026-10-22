Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792709165;
	b=pGqs+8oD0aPjD7sBWlrT58UIbZ+Fm9yRDShiKhJ9r5ayBGUd6sNhC7F9sjk4aM5epceG
	 p3SgHJ/cODiBgcNqCbMa49wfHGL+DgHrS6O/0WuLT25IYG0ft4EvXlnDz7wabPL6nnoYu
	 QMeYhNY1ShSFHCeipyEBWatGQyOX8Wb/pmWt4Y48s4ZY/EOcJmtbTtqrY/oRbRoAvPWtC
	 g2slsw6IwPnYeNbQclVsR6M5/DQjh3C0uXmEUtJQnQlswoYYFS/7Gv3Bp+FWB0NXx5y1o
	 zH0ULL5RhcmgeXSecekt7EhntcC9Kga4pLjcKAnogQsohBEynr5ZHz0mE7R1S7Nfuyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792709165;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+C5PIR98H13TR2rU9GiG/7yCqcWIwzY54uO1bXPMuxA=;
	b=iSdRN+YAWyVY352JsmtrikCBIRK9US3EMv+jS1WS8ruNTh97b/ZIfV8r+Xwvvqp21VhA
	 wodwIBhWnQ2SXzPtrx527O8qnO3hi+gJEB7RD1E5Tv+5Hb55ciR8t9tm1X30gKfSpEk3K
	 H6b6i7gmeYwr6aDSlLH+Oe2iAJyYtpXsrFteAad6IU1Z7AZ9y+RATDAVe0Pq7BYUdE9y/
	 XNYeQzueu2dbygsexm3EnBpnLUM0SFZ2uttdUKfN+Zbe73U3AsExj5x+Nb1WjsP8Ibo13
	 DTMWHsdIQSF4ssjou1RyCSk7dQP2dkXjjYo35DI2NFMqCT3vKTkM/k/+RZScNqmUdYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bSC72PeP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6139606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 22:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bSC72PeP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80CA1F01825;
	Thu, 22 Oct 2026 22:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792709164;
	bh=+C5PIR98H13TR2rU9GiG/7yCqcWIwzY54uO1bXPMuxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bSC72PePwO6kLwgWauWbn5iRW9YERGJZp42W9CNi+pcvzzh1kDu6LuHNEvCI0+4YE
	 lmGI9++/eadVgjqne3XSg3IXMZEiT7fdtdzCgpK8PofZLF+PBiYP6HmlsZW9vce0NH
	 3St8gnArtIgtG47v2TlEG+k4yub4FGyN39H15Cu1bu3lMfWnQsnFIZ+hovoFKHiGDt
	 tOb6/ypXxVXZDQn4Gc3JM0lZC0Ql2PND/XZE+1qFVG4OPushRZQDeddMqaI3NUpkiv
	 M76ZmDCZjdRir9bCIpE5uAXKeB6Z0Psy/fuyL7SwYHIDa+Q2ya0TMeAUPnIm//Gimg
	 YzS6V1nAM/WNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/3] ntfs: fix resident conversion in ntfs_new_attr_flags
Date: Thu, 22 Oct 2026 18:46:00 -0400
Message-ID: <20261022224435.2159674-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102234-sector-enjoyably-8d59@gregkh>
References: <2026102234-sector-enjoyably-8d59@gregkh>
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

From: Hyunchul Lee <hyc.lee@gmail.com>

[ Upstream commit 7ed0028126b5a19f278183abbae2b3166d3ca9ac ]

When setting sparse/compressed flags on a resident attribute, the
function skipped the resident-to-non-resident conversion and
terminated.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Stable-dep-of: acb1095fd2db ("ntfs: fix memmove overlap in ntfs_new_attr_flags")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs/ea.c | 94 ++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 72 insertions(+), 22 deletions(-)

diff --git a/fs/ntfs/ea.c b/fs/ntfs/ea.c
index 223844782fe07..7f51c261ef3e7 100644
--- a/fs/ntfs/ea.c
+++ b/fs/ntfs/ea.c
@@ -630,6 +630,7 @@ static int ntfs_new_attr_flags(struct ntfs_inode *ni, __le32 fattr)
 	struct mft_record *m;
 	struct attr_record *a;
 	__le16 new_aflags;
+	u16 old_name_ofs, old_mp_ofs;
 	int mp_size, mp_ofs, name_ofs, arec_size, err;
 
 	m = map_mft_record(ni);
@@ -662,8 +663,10 @@ static int ntfs_new_attr_flags(struct ntfs_inode *ni, __le32 fattr)
 	else
 		new_aflags &= ~ATTR_IS_COMPRESSED;
 
-	if (new_aflags == a->flags)
-		return 0;
+	if (new_aflags == a->flags) {
+		err = 0;
+		goto err_out;
+	}
 
 	if ((new_aflags & (ATTR_IS_SPARSE | ATTR_IS_COMPRESSED)) ==
 			  (ATTR_IS_SPARSE | ATTR_IS_COMPRESSED)) {
@@ -672,15 +675,40 @@ static int ntfs_new_attr_flags(struct ntfs_inode *ni, __le32 fattr)
 		goto err_out;
 	}
 
-	if (!a->non_resident)
-		goto out;
+	if (!a->non_resident) {
+		if (!(new_aflags & (ATTR_IS_SPARSE | ATTR_IS_COMPRESSED)))
+			return 0;
 
-	if (a->data.non_resident.data_size) {
-		pr_err("Can't change sparsed/compressed for non-empty file\n");
-		err = -EOPNOTSUPP;
-		goto err_out;
+		if (le32_to_cpu(a->data.resident.value_length)) {
+			pr_err("Can't change sparse/compressed for non-empty file");
+			err = -EOPNOTSUPP;
+			goto err_out;
+		}
+
+		err = ntfs_attr_make_non_resident(ni, 0);
+		if (err)
+			goto err_out;
+
+		ntfs_attr_reinit_search_ctx(ctx);
+		err = ntfs_attr_lookup(ni->type, ni->name,
+				ni->name_len, CASE_SENSITIVE,
+				0, NULL, 0, ctx);
+		if (err) {
+			err = -EINVAL;
+			goto err_out;
+		}
+		a = ctx->attr;
+	} else {
+		if (a->data.non_resident.data_size) {
+			pr_err("Can't change sparsed/compressed for non-empty file");
+			err = -EOPNOTSUPP;
+			goto err_out;
+		}
 	}
 
+	old_name_ofs = le16_to_cpu(a->name_offset);
+	old_mp_ofs = le16_to_cpu(a->data.non_resident.mapping_pairs_offset);
+
 	if (new_aflags & (ATTR_IS_SPARSE | ATTR_IS_COMPRESSED))
 		name_ofs = (offsetof(struct attr_record,
 				     data.non_resident.compressed_size) +
@@ -703,6 +731,25 @@ static int ntfs_new_attr_flags(struct ntfs_inode *ni, __le32 fattr)
 	if (unlikely(err))
 		goto err_out;
 
+	/*
+	 * When compressed/sparse state changes, the non-resident header grows or
+	 * shrinks by the compressed_size field. Update the in-record payload layout
+	 * to match the new offsets before exposing the new mapping_pairs_offset.
+	 */
+	if (name_ofs > old_name_ofs) {
+		if (mp_ofs != old_mp_ofs)
+			memmove((u8 *)a + mp_ofs, (u8 *)a + old_mp_ofs, mp_size);
+		if (a->name_length)
+			memmove((u8 *)a + name_ofs, (u8 *)a + old_name_ofs,
+				a->name_length * sizeof(__le16));
+	} else {
+		if (a->name_length && name_ofs != old_name_ofs)
+			memmove((u8 *)a + name_ofs, (u8 *)a + old_name_ofs,
+				a->name_length * sizeof(__le16));
+		if (mp_ofs != old_mp_ofs)
+			memmove((u8 *)a + mp_ofs, (u8 *)a + old_mp_ofs, mp_size);
+	}
+
 	if (new_aflags & (ATTR_IS_SPARSE | ATTR_IS_COMPRESSED)) {
 		a->data.non_resident.compression_unit = 0;
 		if (new_aflags & ATTR_IS_COMPRESSED || ni->vol->major_ver < 3)
@@ -723,28 +770,31 @@ static int ntfs_new_attr_flags(struct ntfs_inode *ni, __le32 fattr)
 			ni->itype.compressed.block_size_bits = 0;
 			ni->itype.compressed.block_clusters = 0;
 		}
-
-		if (new_aflags & ATTR_IS_SPARSE) {
-			NInoSetSparse(ni);
-			ni->flags |= FILE_ATTR_SPARSE_FILE;
-		}
-
-		if (new_aflags & ATTR_IS_COMPRESSED) {
-			NInoSetCompressed(ni);
-			ni->flags |= FILE_ATTR_COMPRESSED;
-		}
 	} else {
-		ni->flags &= ~(FILE_ATTR_SPARSE_FILE | FILE_ATTR_COMPRESSED);
 		a->data.non_resident.compression_unit = 0;
-		NInoClearSparse(ni);
-		NInoClearCompressed(ni);
 	}
 
 	a->name_offset = cpu_to_le16(name_ofs);
 	a->data.non_resident.mapping_pairs_offset = cpu_to_le16(mp_ofs);
 
-out:
 	a->flags = new_aflags;
+
+	if (new_aflags & ATTR_IS_SPARSE) {
+		NInoSetSparse(ni);
+		ni->flags |= FILE_ATTR_SPARSE_FILE;
+	} else {
+		NInoClearSparse(ni);
+		ni->flags &= ~FILE_ATTR_SPARSE_FILE;
+	}
+
+	if (new_aflags & ATTR_IS_COMPRESSED) {
+		NInoSetCompressed(ni);
+		ni->flags |= FILE_ATTR_COMPRESSED;
+	} else {
+		NInoClearCompressed(ni);
+		ni->flags &= ~FILE_ATTR_COMPRESSED;
+	}
+
 	mark_mft_record_dirty(ctx->ntfs_ino);
 err_out:
 	if (ctx)
-- 
2.53.0

