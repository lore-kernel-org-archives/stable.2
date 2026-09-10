Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9CB2EC54A
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003048; cv=none; b=Cys4d5qWFCNXA4P8KHYdHUe3LoSjNa7/sQRN4Er0wnV1UIR0hrLq1CDuTQM6dJ5IBufZkTYkEuxp1DbX7Zb0phj7R/Oh0BcYhdoy8Mlz0Ikatu245JIvJeyKqEt7henWMqhdjhP0DHPR5e8H0XzMCCCfX1NdyZ0KAu3HZRfp5J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003048; c=relaxed/simple;
	bh=eC3le9qitbPVXclHGMn78ZV0jDXRuxLdKeYJqGUT30k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=soyxzMZX68b23X9wgz+OEsA+/25md896e0qUj8VIiYv8KA3+iW/dH8XZP/uW33P3MsPrOqNFnYJkB8nRDkrjJMTfPlA/GB2Vtky2tENC4Eg1RW7DXiGndz+bfvm9bEPDNbjPY+TMY5ZSz0IPkdbU0BCzv2sbZSxUb7t9llkLdfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vm9plRAa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vm9plRAa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3CD1F00898;
	Thu, 10 Sep 2026 01:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789003038;
	bh=HvcJsU5m55a/5L6uU2J2BOoJw/Q1C8ULryy1Xk/74C0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vm9plRAaw+VCf/sR9prsejD4vSiGCf7xZ+TceAjdXwxfLtCnywxXzy+9QZvPQi1wn
	 j+gpqBuWH+7mQASjEGywnwoX535I0+VVDHtj2anZVFQGXU7o76AbZZMyp0EnXmktnP
	 138jCgfLOZ/PEzVyROZ4kg8ax/e2CZxfU2s0MKVx3GyHXF3+4zyAYV6zjLeWwk+O/X
	 YY1tQoqYLWPs/rqx1cBSLEgIvvEbijxf87Tn8UdSZEwNBuk7lbFEuJWD41YU++/Mn/
	 uVqFIHBAVxIQ8AOyx52aNrYAyVripZR8uZrr0wcdIZo+4OO/UMSyZMK/N/JEQED8R6
	 Y35r1wCT5FqrQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/2] udf: Fix data loss when converting inline inodes to out of line
Date: Wed,  9 Sep 2026 21:17:15 -0400
Message-ID: <20260910011715.3832181-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910011715.3832181-1-sashal@kernel.org>
References: <2026090407-drool-bonehead-8d81@gregkh>
 <20260910011715.3832181-1-sashal@kernel.org>
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
index 074ee35ef3c29..e1fdf9f9c9f50 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -405,6 +405,10 @@ int udf_expand_file_adinicb(struct inode *inode)
 {
 	struct folio *folio;
 	struct udf_inode_info *iinfo = UDF_I(inode);
+	struct udf_map_rq map = {
+		.lblk = 0,
+		.iflags = UDF_MAP_CREATE,
+	};
 	int err;
 
 	WARN_ON_ONCE(!inode_is_locked(inode));
@@ -434,20 +438,27 @@ int udf_expand_file_adinicb(struct inode *inode)
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

