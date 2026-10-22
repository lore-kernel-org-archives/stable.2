Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792709165;
	b=1A1KaTa7Ikl/VVyRVxt7X479weaF4qnfJeRJ1vJVgcSlMYVJsUlwG8DNQm9+8Lgoa9af
	 yKYwiUjm7Pf8Z9bXYU8s+VHKyWY1RhRsAe/9ubdcxabiIVCYIXgCmICeknBBvr6D+Y89i
	 ih//IYdhS7m/K/08A+GIk5slMk537yGUNJ0OPOUTjXh1tAsnER0lXXaXfGvqsMylwc3eK
	 mxykrijz6Na3fgF4l58O3kHN/9hNErhcs7RIl3q2mGQEOi2D4WgYW4kOiKuWmLVv5KBBd
	 sAOAipOJBAcBBpyv2pF2U3v4yHAgoM8HWVyy9qfH+Ffd2A/Gwy5XvdiDUS/TNala2kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792709165;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HoKMCMIEOuQRvmFg1MKoSAiVhiPRLTOb5ID30V5fri4=;
	b=5eH5KSpUl8vMp8J9ywLUhPeQwCdmnhI9ZuG3WTeUWpdrMCojaRz3fK2uZELFRnBONL0d
	 MgqWWofZsxwpgb+B81wUw/6r0+7NnfaQKMw51izLHVVga/R4CeemNDjyNBXQxkApgfAKs
	 a7BeW49HIEQkfz3ZSYZjONX6BUdJuRgsjRtLVajWjWbj2r0d9Oq5K+pWfox57+iRLkr2c
	 Iu0mmdARDUYjavVUzcEfLJwPO0n0NH6MkF45oi1HZlhgo0OKfaJypBZlA+1Q21J3Bvag/
	 iWMs1efVdYlidbPYzZQk/gxeHyg+UAg0XWOvKJBREzLUEhuzFEkslbCLncjJNm+uSOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jqX3FuxA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E40606A31D
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 22:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jqX3FuxA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CAEB1F01828;
	Thu, 22 Oct 2026 22:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792709165;
	bh=HoKMCMIEOuQRvmFg1MKoSAiVhiPRLTOb5ID30V5fri4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jqX3FuxAVcKHzMa4Ip8LzKBKkqGz5ZD85rgWcdUojXgoPRlbeRG+SpJLfKU7W3u7b
	 YOm/WIksnGyqr5a3d0UNIdKxmtGVf6GCMoDM416oxKT36dNHIvqAC51cUKhWFHwrLO
	 n1ufUjdfzayrzOtiZvpyuAiG4qsrW7kBVEMuXcfZoAoUCv0EuwSvDijPG3cX70DBS3
	 5ePfYfdNI7EMV5YRJSckfanq+/8dnt7WaF1mxMYSdWLMbMaJle9W2FSup429HApPVP
	 eT1b7Y7MWZi4eLL4mmKhRS9BY3v9QgRz2WKxxWoBsM8nBCg4Xl1ICTTtTCuDKAaCM/
	 PJVd8GSNAjTPg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/3] ntfs: move attribute payload before shrinking its record
Date: Thu, 22 Oct 2026 18:46:01 -0400
Message-ID: <20261022224435.2159674-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022224435.2159674-1-sashal@kernel.org>
References: <2026102234-sector-enjoyably-8d59@gregkh>
 <20261022224435.2159674-1-sashal@kernel.org>
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

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 0ab6dc1ac4601c8d79e5448a024daed6b0c5ef64 ]

ntfs_new_attr_flags() resizes the non-resident attribute record before
moving its name and mapping pairs to their shorter-header offsets when
compression or sparse state is cleared.

Shrinking the record first moves the following attribute over the tail of
the old record. The subsequent memmove() therefore copies bytes from that
following attribute instead of the old mapping pairs. Re-enabling
compression on an empty file persists those bytes as a malformed mapping
pairs array, which ntfsck reports as a missing or invalid run length.

Move the payload before shrinking the record, while retaining the existing
resize-before-move ordering when growing it.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Stable-dep-of: acb1095fd2db ("ntfs: fix memmove overlap in ntfs_new_attr_flags")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs/ea.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/fs/ntfs/ea.c b/fs/ntfs/ea.c
index 7f51c261ef3e7..dc0a70041d788 100644
--- a/fs/ntfs/ea.c
+++ b/fs/ntfs/ea.c
@@ -631,7 +631,7 @@ static int ntfs_new_attr_flags(struct ntfs_inode *ni, __le32 fattr)
 	struct attr_record *a;
 	__le16 new_aflags;
 	u16 old_name_ofs, old_mp_ofs;
-	int mp_size, mp_ofs, name_ofs, arec_size, err;
+	int mp_size, mp_ofs, name_ofs, old_arec_size, arec_size, err;
 
 	m = map_mft_record(ni);
 	if (IS_ERR(m))
@@ -726,6 +726,19 @@ static int ntfs_new_attr_flags(struct ntfs_inode *ni, __le32 fattr)
 
 	mp_ofs = (name_ofs + a->name_length * sizeof(__le16) + 7) & ~7;
 	arec_size = (mp_ofs + mp_size + 7) & ~7;
+	old_arec_size = le32_to_cpu(a->length);
+
+	/*
+	 * Move payloads before shrinking the record.  Otherwise resizing moves
+	 * the following attribute over the old payload before it can be copied.
+	 */
+	if (arec_size < old_arec_size) {
+		if (a->name_length && name_ofs != old_name_ofs)
+			memmove((u8 *)a + name_ofs, (u8 *)a + old_name_ofs,
+				a->name_length * sizeof(__le16));
+		if (mp_ofs != old_mp_ofs)
+			memmove((u8 *)a + mp_ofs, (u8 *)a + old_mp_ofs, mp_size);
+	}
 
 	err = ntfs_attr_record_resize(ctx->mrec, a, arec_size);
 	if (unlikely(err))
@@ -736,18 +749,12 @@ static int ntfs_new_attr_flags(struct ntfs_inode *ni, __le32 fattr)
 	 * shrinks by the compressed_size field. Update the in-record payload layout
 	 * to match the new offsets before exposing the new mapping_pairs_offset.
 	 */
-	if (name_ofs > old_name_ofs) {
+	if (arec_size > old_arec_size) {
 		if (mp_ofs != old_mp_ofs)
 			memmove((u8 *)a + mp_ofs, (u8 *)a + old_mp_ofs, mp_size);
 		if (a->name_length)
 			memmove((u8 *)a + name_ofs, (u8 *)a + old_name_ofs,
 				a->name_length * sizeof(__le16));
-	} else {
-		if (a->name_length && name_ofs != old_name_ofs)
-			memmove((u8 *)a + name_ofs, (u8 *)a + old_name_ofs,
-				a->name_length * sizeof(__le16));
-		if (mp_ofs != old_mp_ofs)
-			memmove((u8 *)a + mp_ofs, (u8 *)a + old_mp_ofs, mp_size);
 	}
 
 	if (new_aflags & (ATTR_IS_SPARSE | ATTR_IS_COMPRESSED)) {
-- 
2.53.0

