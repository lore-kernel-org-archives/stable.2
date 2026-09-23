Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3177EDF59
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 01:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790128571; cv=none; b=aHE2qEtv7wioyPWdqEApyMSqUfiCUpkFOAO2I0lCBF1lMZvP4zYtGpJGxJLvMGcw9B+8k6QFel3fQR3CcTtfVuhJmrdjGcuUP52zsI1CMxXgpH96IssIGI/5qug7GzXkJeBul4XI+5hwaaEca4s5NL+OUPucVZA1b77vzZNJQr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790128571; c=relaxed/simple;
	bh=15vx4n4NZOlkO9HRBScjac+uyl775yDPCdQCXKANVk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dth28LOXsePakLTg+s990GlpefQ23VDfgBVhtk3PsgbQAZf5FWqel3yEB2PCFEIya/d3r3nKRiAQBbgycg3N21p4xBoc9iEtoHBAvithvxOhee1lGVfF3jpoH9Sescxjf1I/OBH2U4fmbfilA1Gv/Nuk3tOVFf2+YY979tmDBaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTrPHJTe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTrPHJTe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A251F000FF;
	Wed, 23 Sep 2026 01:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790128570;
	bh=JcGQ1KfzyM+xwIBzqdZepZR6pttdd/Mq76RRSNICr9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WTrPHJTeMJLhSCJ2pIGXMFt6q7WpKEr3mRF34KxjiVtkBBFQq3U8J9LYIUTM1YR+z
	 J1WtLHIRmI45EbW47L0lXecS3acyAI+HDJA0gFgPLfwlak7txHwb9aZe3YhjfNEbrV
	 YAaZy3DfcSqhTxff3T6kpeAftbt42gYSqVzJ21/6+eCxOA/FU6ofgK3/bRGN5eNHeA
	 WJtUJV8xDFdNxtFj/T7vAQz3PaBRAXxmh7FqWiRMwdv/ZJtCVybz8EwbTpoP+sR4MG
	 xwttjUirugLIbDFrh/Lx/AHZaydLy+gn5R4C56UVPOd2rlVTcrfozovtmhMpwzZKqn
	 kNQ7iIzu8Dtxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Sorenson <sorenson@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: fix OOB struct field reads in move_smb2_ea_to_cifs()
Date: Tue, 22 Sep 2026 21:56:07 -0400
Message-ID: <20260923015607.891503-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092225-saint-twisting-29cc@gregkh>
References: <2026092225-saint-twisting-29cc@gregkh>
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
index 3aaa45375d8ba..3123f644a1585 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -1115,8 +1115,9 @@ move_smb2_ea_to_cifs(char *dst, size_t dst_size,
 	char *name, *value;
 	size_t buf_size = dst_size;
 	size_t name_len, value_len, user_name_len;
+	u32 next_off;
 
-	while (src_size > 0) {
+	while (src_size >= sizeof(*src)) {
 		name_len = (size_t)src->ea_name_length;
 		value_len = (size_t)le16_to_cpu(src->ea_value_length);
 
@@ -1171,14 +1172,21 @@ move_smb2_ea_to_cifs(char *dst, size_t dst_size,
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

