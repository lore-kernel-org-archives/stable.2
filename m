Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E6F5505CC
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 21:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790112213; cv=none; b=XR5roOWtgglJtiRI2uFA6BZlky6DXI0hSZxp1yWXuIDzpTK9uvk91jfGDDlBXpPxjsjbzO6d68BvZzphK16H0kP6ioIcXkZnC55HIlhfFKWTZVlTNUQJezKEEMXnD3FPHnk/wB5X7XO8neh+zdbMH7auZYXThP6of0tUoYY/vx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790112213; c=relaxed/simple;
	bh=RNYsHy7pLKqWT1W41K15HicHZ4mhHFJdnkhBPnI3Ovs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VO4mGWn2JFdrhMwSDVW9fbjb6w8EXFjvPFoizPb2181pQmFd6O171BBX5cxxTadyI8zHNcSaCc1Kcuk50FBOiEq5mzcfniOLuHI22em2d8a8ud91dykcKBWdQmyLR836myzG2rVqfOP8fNuK9d3miLuiwgdus5urK0X/92MRgKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g561OKtO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g561OKtO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46741F00893;
	Tue, 22 Sep 2026 21:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790112202;
	bh=xnXsuWjIjzOGQhZQ2unj+Hbk3JnWhXAehkd1X0fEO+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g561OKtOQ/6daIr1Y5+iuQaTj9tlsTkN7ZNcnAepZ0fY1f9j/DieOYVUORAZIB5lF
	 kHoou+bSHxsUM1DJKtSxP0mLXs0xh1avqe77xAzWs+3cf1qLFV6dOxqA2Pqxd3/qXy
	 Gs4icq5D285ImUTcoCKDXUWajLCbQtiJOk0+nLYrAUO+zOKuVSlQeRJLEngSVftaYG
	 CVEpmzRyk6g74vAB3ljrjwY94eKCyp1XA2CQU9idA0yCSwsrf097M9HdAiBmQxghU+
	 Ye3Tpo4juyxXpxFBOP5BbOVyVNVCuiFFe32f5NV422/+jyISD8vpksi8p63Cu5ADHg
	 1V6U1dNwiIl+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Sorenson <sorenson@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] smb: client: fix OOB struct field reads in move_smb2_ea_to_cifs()
Date: Tue, 22 Sep 2026 17:23:20 -0400
Message-ID: <20260922212320.751792-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092223-straining-class-bc2a@gregkh>
References: <2026092223-straining-class-bc2a@gregkh>
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
 fs/smb/client/smb2ops.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 3f6b8745667d0..ccbbddea8f386 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -1057,8 +1057,9 @@ move_smb2_ea_to_cifs(char *dst, size_t dst_size,
 	char *name, *value;
 	size_t buf_size = dst_size;
 	size_t name_len, value_len, user_name_len;
+	u32 next_off;
 
-	while (src_size > 0) {
+	while (src_size >= sizeof(*src)) {
 		name_len = (size_t)src->ea_name_length;
 		value_len = (size_t)le16_to_cpu(src->ea_value_length);
 
@@ -1113,14 +1114,21 @@ move_smb2_ea_to_cifs(char *dst, size_t dst_size,
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

