Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CCD31618B
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003267; cv=none; b=jrInbFo2OmVyVwgo3nMnF0jlkyy2HpbNJcMbbkeJhVNHQ1AiwDg/6qlCaJkbW3+rZ3EI5cF9ST8Tp3JpNZOTfzWfmXjkHErumC9YU9PFdV75E0prbzT7NrHGnk8jT9CGUv+W43/8Hr3vvm7ZSfPDCnLK1nb1qtV8+TC9BtWJJNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003267; c=relaxed/simple;
	bh=07K2V86eo+aO+3/jBDxlI54TqtzrGqMnvH8Qkv0qgdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eodCsbJZYcWHEUUmSI9nwZB/Y6HhScvhQ3mykTepafrTdkNMVO92mqFLRIq+URE583+AqUHqQEqNnrqarkdC5mveDf4L5McTqhisj1S2cpRb9W+rfggKVBticlBDbgQR8BDhQF4GyQA5E083TbQ/kKLQQOJapDsDewYNj2LnixE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcH0YgYi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcH0YgYi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7281F00899;
	Thu, 10 Sep 2026 01:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789003265;
	bh=7X306JXqrS34QQj2i4n6C+qC822pYxKi7MGvrtrD6+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GcH0YgYiyMU+bTnp25B96mbluy821wVNbA7qaWTKIbrZEOUYBTAy1vTw6V5Zah0lU
	 /JRHV8dTVn5CLrym1htEwZXB9cKKZ9kp4ll2hc5bAPAU/7fhDBC3xUGS0mzAq4wIFX
	 09EI2g5uCteSt4aZjp4J5UosxJB+EjcVTcbuAKXIewGPSNQ2bYz7vci4SUZVWZ8X/G
	 bKSAC/uJiO86o6URqmmQw6FsYFcVh5s/c5Hhj+2N+oyB+2ZsiDDr0x/ILyhYtBZCyq
	 PHDutuDQOqWlpv1GhdtJH9NaLVzoVyil8w0yDQXKbortd+uqCtD9CAxbxUH6lykSnz
	 9QYIQw5rWaA3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] udf: Fix data loss when converting inline inodes to out of line
Date: Wed,  9 Sep 2026 21:21:03 -0400
Message-ID: <20260910012103.3847731-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910012103.3847731-1-sashal@kernel.org>
References: <2026090408-hardening-frenzied-5de0@gregkh>
 <20260910012103.3847731-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Kara <jack@suse.cz>

[ Upstream commit 62333e480d12ab186f89fe2725b372d12f72d5eb ]

When udf_expand_file_adinicb() converts file from inline format to out
of line, we use filemap_fdatawrite() to writeout the data to the new
blocks. However since 36580ed08776 ("udf: Do not allocate blocks on page
writeback") the writeback actually doesn't allocate the new block and
the folio dirty bit is just silently cleared. Thus unless the file is
written to after the conversion (as it can easily happen in case of
truncate up), the data is just lost. Fix the problem by explicitely
allocating the block underlying the data before starting writeback.

Fixes: 36580ed08776 ("udf: Do not allocate blocks on page writeback")
CC: stable@vger.kernel.org
Link: https://patch.msgid.link/20260730104232.4086759-4-jack@suse.cz
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/udf/inode.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index bed3bc4f4fa2f..271e3f0d1fb10 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -406,6 +406,10 @@ int udf_expand_file_adinicb(struct inode *inode)
 {
 	struct folio *folio;
 	struct udf_inode_info *iinfo = UDF_I(inode);
+	struct udf_map_rq map = {
+		.lblk = 0,
+		.iflags = UDF_MAP_CREATE,
+	};
 	int err;
 
 	WARN_ON_ONCE(!inode_is_locked(inode));
@@ -435,20 +439,27 @@ int udf_expand_file_adinicb(struct inode *inode)
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_SHORT;
 	else
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_LONG;
+	up_write(&iinfo->i_data_sem);
+
+	/* Allocate the block underlying the data */
+	err = udf_map_block(inode, &map);
+	if (err < 0)
+		goto restore;
+
 	folio_mark_dirty(folio);
 	folio_unlock(folio);
-	up_write(&iinfo->i_data_sem);
 	err = filemap_fdatawrite(inode->i_mapping);
 	if (err) {
 		/* Restore everything back so that we don't lose data... */
 		folio_lock(folio);
+restore:
 		down_write(&iinfo->i_data_sem);
 		memcpy_from_folio(iinfo->i_data + iinfo->i_lenEAttr,
 				folio, 0, inode->i_size);
-		folio_unlock(folio);
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_IN_ICB;
 		iinfo->i_lenAlloc = inode->i_size;
 		up_write(&iinfo->i_data_sem);
+		folio_unlock(folio);
 	}
 	folio_put(folio);
 	mark_inode_dirty(inode);
-- 
2.53.0

