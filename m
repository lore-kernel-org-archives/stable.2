Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E003C9429;
	Fri, 28 Aug 2026 06:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787897782; cv=none; b=qzmBtfOZd4wbl7aOUEfLsTo6ylrGSjevmHD1oD4A3bih80WE3PYcrmMSyZSd5IBrYuSAmWemXG1N3u02m45p1cHrPLZXU17vEtCr1m/f2cPGBgZHtdudOOyP2udFH3Yo9N7xOLHVhhsOdSNIB/hq0Uk3xuXYAM2yP/vVPmuYYss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787897782; c=relaxed/simple;
	bh=DWJ30wLWoVajnNOPaxy/O0aOU7mPN/98OXXWAwisxiI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DbKGSJkX+QV35JN8Y22+4dvSpUVJxAKiElUQacuvYy3C425l0yYDdLaY0zWKQPzeQSvLlmejpQWLW5nRpfKNzLA9MqXsio83g4Y6FJwK11i0GRGQYSHfLoVidF8kg7NhbbFJBOCnYUqZryIkICWnmftGLYIOd4b0PpttrqHkj7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f72ca04ea2a711f19a56ed5b684f684d-20260828
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:81e1f6fd-7911-45dd-8e47-bd7da3343c25,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:ad210ab366befcb778d841f078b303ec,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f72ca04ea2a711f19a56ed5b684f684d-20260828
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1622525588; Fri, 28 Aug 2026 14:16:11 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] ntfs: take invalidate_lock in ntfs_setattr_size()
Date: Fri, 28 Aug 2026 14:16:06 +0800
Message-Id: <20260828061607.240845-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_setattr_size() updates i_size and resizes the on-disk attribute
without holding mapping->invalidate_lock.  Page faults take the lock
shared, so a fault racing the resize can resolve a VCN against the
transient runlist state of ntfs_non_resident_attr_expand() and fail
with a spurious SIGBUS, and can interleave with the size-change
epilogue (truncate_pagecache(), i_size_write(),
pagecache_isize_extended()).

Take invalidate_lock exclusively around the whole resize after
inode_dio_wait(), matching the fallocate path and other filesystems
such as xfs, which wraps truncate in its mmaplock (= invalidate_lock).

Fixes: 9c87959601e8 ("ntfs: update file operations")
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 fs/ntfs/file.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 1969e4f444f7..585ab2145797 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -270,18 +270,25 @@ static int ntfs_setattr_size(struct inode *vi, struct iattr *attr)
 		return err;
 
 	inode_dio_wait(vi);
+
+	/*
+	 * Serialize with page faults and pagecache instantiation so that
+	 * readers cannot observe the size change until the attribute
+	 * updates below have completed.
+	 */
+	filemap_invalidate_lock(vi->i_mapping);
 	if (attr->ia_size > old_size) {
 		truncate_pagecache(vi, old_size);
 		i_size_write(vi, attr->ia_size);
 		pagecache_isize_extended(vi, old_size, attr->ia_size);
-	} else
+	} else {
 		truncate_setsize(vi, attr->ia_size);
+	}
 
 	err = ntfs_truncate_vfs(vi, attr->ia_size, old_size);
-	if (err) {
+	if (err)
 		i_size_write(vi, old_size);
-		return err;
-	}
+	filemap_invalidate_unlock(vi->i_mapping);
 
 	return err;
 }
-- 
2.25.1

