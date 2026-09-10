Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C590345ED8
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003463; cv=none; b=TQ0LyGoEle0UkyuU0w6kF7DkV+O6BttW0a8c5CWUxFYWwry5nlSO3zi71izep6YSHydwCnUGbPZmKAl9OXDqrAMvA+ajRk4BQvWycXojdFc+rkkKmMCvIYM20HRuWsgedG/etvpknGCMNwEkcrYeNMyARuGq4iYU64vXHuN23z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003463; c=relaxed/simple;
	bh=skoqCxt+ybZWrGPynNM2HPzHILYPt1J6Ua9BNkm1CIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NmjmjBElpNjodGjcdqRIoxt/p2dcfRTB0JvdmcuZc3dHf+xC5u/anxi7IFRCRrKBHJrSXSyqlaYRcMiXTO19QwpKgJ85mJt/DAuUCXg5vLoy/uzTL4CZ/FTdBRhxhQDtEVzC9664orfwhoh5e5wdYPoBwZrDo1/4D44XCpLTJzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyP2HF0o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyP2HF0o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C381F00898;
	Thu, 10 Sep 2026 01:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789003461;
	bh=dyNxjZrFfLfmlwfGmkwmoULslkUQMyOxb2Bzxep5/MM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gyP2HF0oQ4wzX4UjtzqbNIjzqWptyaHCrmlqHaFErYt55w3VXZtYIl1c3Y/Kbgf8J
	 69ZE4l1aerf1dJoOl99aEH9dto9pBumoW9IMtw5e9hjEGQPaF9AY6Qxyf1mDFn2Xxd
	 Q3Ga3T+/gmuM2k6uKivMuAhLI55leWXUHVklhJh9ZEafJZeuJSednA9GAEIUOYhrfP
	 wtBFONXMvNF1UfCfWfEpi8v7GBx7e0QKhDMztdeB0QYW86PYikTHhPFdPn2V3YsrCI
	 ytrMPEjOG6lFpxlkK8UtAh5Cb0AQeorI4qPDY3h4zFgPE8fG9a367sqi+Cmct2ySU6
	 tg9n8hvAb4qjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] udf: Fix data loss when converting inline inodes to out of line
Date: Wed,  9 Sep 2026 21:24:19 -0400
Message-ID: <20260910012419.3856710-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910012419.3856710-1-sashal@kernel.org>
References: <2026090408-obliged-concert-25ca@gregkh>
 <20260910012419.3856710-1-sashal@kernel.org>
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
index 6c559c343fc51..402508dd839dd 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -399,6 +399,10 @@ int udf_expand_file_adinicb(struct inode *inode)
 {
 	struct folio *folio;
 	struct udf_inode_info *iinfo = UDF_I(inode);
+	struct udf_map_rq map = {
+		.lblk = 0,
+		.iflags = UDF_MAP_CREATE,
+	};
 	int err;
 
 	WARN_ON_ONCE(!inode_is_locked(inode));
@@ -428,20 +432,27 @@ int udf_expand_file_adinicb(struct inode *inode)
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

