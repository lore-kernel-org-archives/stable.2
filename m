Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDB923AE9B
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 02:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790128987; cv=none; b=P3XOKTp7uE7Dt202+HS45S2a5uVqliHHV0+XYG6+cpvFuM7sAW7nJqkaxh5KygUR4MMg8JSmnaJZxz8AdNzXh/PH3AfIDEikO5mD7t+2B2bAsbdoJ0yWPuw/eN012qWXW/HRa8cKe7WnTmtBiKUkVeRjIjBHSgslv+U5wUkcG+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790128987; c=relaxed/simple;
	bh=Df5WQwuj8+B40+WuzNuNHewW57TwzQyFIna0gm0MFfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZhRlO9xsrkvCg0adlyDwSbID7L20Y3bAj6mEL33yzisaC8/mAdkvMxhRsrP2bunQnP21fAL585hlqKkV2Zq8tcnqPeWeolD1LWIUjmtdOz+JfMwpOt9L+Y5JKL0UNJxyrCrsSJcQi+uz0FA178Y3f9xrpAZpIF8q+cRBcfted3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngGorcAF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngGorcAF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F41F1F000FF;
	Wed, 23 Sep 2026 02:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790128985;
	bh=4qPaXPqnIsSom4qpM4EdfAybM6n4ogkz7y8Jhb1tBv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ngGorcAFNdv6vHf39I6qv41CYTBYbxsqYKmXG1D+YC9pEP3BuTpTSvW4IByGlEVIS
	 OlF3NMncike0IFnqu7+vgXYwbtjY9sw9gbbL34RCXyBqsQ7FYglLpE1JgZK+BwUOle
	 +1yOLWSj6TIxgPiLxigLTaqv41Xrre0zJB/KwYchYC1M9akR7p3DqkEvVBw3JUsx1Y
	 HLJZ4GCR5I24aDpoEnKyXXH8dzgJEbVs/Dx1XJR2NZ+chtIMdbLNm/8NrHua5Df5yz
	 Hl6KQdOAk7M4vxC8KJ0CfP9If5QkQoMYjB9AzaBN80h5QHUCu7U/vRHQguTdq0fZbZ
	 3u1sbkCgvwWbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Sorenson <sorenson@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] smb: client: fix OOB struct field reads in move_smb2_ea_to_cifs()
Date: Tue, 22 Sep 2026 22:03:03 -0400
Message-ID: <20260923020303.894215-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092226-freeload-voltage-f314@gregkh>
References: <2026092226-freeload-voltage-f314@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Sorenson <sorenson@redhat.com>

[ Upstream commit eeb5ef6083e1cefa2ef75041b5597ff228b8d7bb ]

In move_smb2_ea_to_cifs(), the while (src_size > 0) loop condition is
insufficient. It allows iteration to continue even if the remaining
src_size is too small to contain a complete smb2_ea_info structure.
Consequently, reads of ea_name_length and ea_value_length can occur
out-of-bounds.

Fix this by ensuring src_size >= sizeof(*src) before attempting to read
any structure fields. Additionally, reject any next_entry_offset that is
smaller than sizeof(*src) or that would advance the pointer beyond the
available buffer.

Note that for calls where the server returns a malformed EA list, the
error returned to userspace changes from -ENODATA (getxattr) or
-ERANGE (listxattr) to -EIO. This correctly signals a server protocol
error rather than misleadingly indicating "attribute not present" or
"output buffer too small".

Fixes: 95907fea4fd8 ("cifs: Add support for reading attributes on SMB2+")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ Replaced unavailable smb_EIO2() tracing calls with -EIO. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2ops.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 51f8ea0c89065..e0780748f0b65 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -1012,8 +1012,9 @@ move_smb2_ea_to_cifs(char *dst, size_t dst_size,
 	char *name, *value;
 	size_t buf_size = dst_size;
 	size_t name_len, value_len, user_name_len;
+	u32 next_off;
 
-	while (src_size > 0) {
+	while (src_size >= sizeof(*src)) {
 		name_len = (size_t)src->ea_name_length;
 		value_len = (size_t)le16_to_cpu(src->ea_value_length);
 
@@ -1068,14 +1069,21 @@ move_smb2_ea_to_cifs(char *dst, size_t dst_size,
 		if (!src->next_entry_offset)
 			break;
 
-		if (src_size < le32_to_cpu(src->next_entry_offset)) {
-			/* stop before overrun buffer */
-			rc = -ERANGE;
-			break;
+		next_off = le32_to_cpu(src->next_entry_offset);
+		if (next_off < sizeof(*src) || src_size < next_off) {
+			cifs_dbg(FYI, "EA next_entry_offset %u out of range [%zu, %zu]\n",
+				 next_off, sizeof(*src), src_size);
+			rc = -EIO;
+			goto out;
+		}
+		src_size -= next_off;
+		src = (void *)((char *)src + next_off);
+		if (src_size > 0 && src_size < sizeof(*src)) {
+			cifs_dbg(FYI, "EA next_entry_offset %u left truncated entry (%zu bytes)\n",
+				 next_off, src_size);
+			rc = -EIO;
+			goto out;
 		}
-		src_size -= le32_to_cpu(src->next_entry_offset);
-		src = (void *)((char *)src +
-			       le32_to_cpu(src->next_entry_offset));
 	}
 
 	/* didn't find the named attribute */
-- 
2.53.0

