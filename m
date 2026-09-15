Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DEA368941;
	Tue, 15 Sep 2026 06:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789453676; cv=none; b=k2VIsKsx7KJNQjJunMlJkkQnlwsGyraDwMDaE7ITLV73DapH7NhMDw3yodIFNFmwCsFHIzvLan+wIu6aXGtYUn9BDU4rhRm2r3URw+cjCG5inUrjjhK0f567eoXYbGLZV2e/40J1SjPh1oyCaBI+KJcTSH8UXSwF1XHEnIvGjzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789453676; c=relaxed/simple;
	bh=6oQ7VChxLbuq0mm9MT6uGsq1gQ+PBCD4mNCPcQceztA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IsI8VzaBy2p8WKyGjdd1iDnNnUNMZXHGLEgN0EY5wYp2AEyemrPvO5ilDLufhZ+ECLEJlcYqQyrOXcMnqFqDATy4zDhMieQK+/rxLIHDJ+4JKmK6I8MjB+MOQRZ5Wd2jtR0//oTNZCyGZZjkh1KS+fKJSq5QsIOBdlfWm7HDHCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 90fb647eb0ce11f19a56ed5b684f684d-20260915
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:f58d4b63-b353-4a19-96e2-c4134d76c77f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:8b3159d36fc1ba374484a0ec910ce4f7,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:-3,I
	P:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
	,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 90fb647eb0ce11f19a56ed5b684f684d-20260915
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1745791178; Tue, 15 Sep 2026 14:27:46 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] ntfs: write back the truncated range before dropping it
Date: Tue, 15 Sep 2026 14:27:41 +0800
Message-Id: <20260915062742.750092-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a truncate, ntfs_setattr_size() drops the page cache beyond the new
size with truncate_setsize() and only then updates the attribute on
disk.  If that update fails, the size is reverted and the data beyond
the new size becomes visible again -- but the pages were already
dropped, and dirty data in them is lost, even though the truncate, the
operation the user asked for, never happened.

Write the range back before dropping it.  If the writeback fails, fail
the truncate with that error and keep the page cache intact; if the
on-disk truncation fails afterwards, the reverted size can be re-read
from disk.

Fixes: 9c87959601e8 ("ntfs: update file operations")
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 fs/ntfs/file.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 007d1614b9ac..1417a76788ed 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -283,12 +283,27 @@ static int ntfs_setattr_size(struct inode *vi, struct iattr *attr)
 		i_size_write(vi, attr->ia_size);
 		pagecache_isize_extended(vi, old_size, attr->ia_size);
 	} else {
+		/*
+		 * The on-disk truncation below can fail, in which case
+		 * the size is reverted and the data beyond the new size
+		 * becomes visible again.  Write that range back first:
+		 * truncate_setsize() drops those pages and dirty data
+		 * cannot be recovered afterwards.
+		 */
+		if (attr->ia_size < old_size) {
+			err = filemap_write_and_wait_range(vi->i_mapping,
+					attr->ia_size, old_size - 1);
+			if (err)
+				goto out_unlock;
+		}
+
 		truncate_setsize(vi, attr->ia_size);
 	}
 
 	err = ntfs_truncate_vfs(vi, attr->ia_size, old_size);
 	if (err)
 		i_size_write(vi, old_size);
+out_unlock:
 	filemap_invalidate_unlock(vi->i_mapping);
 
 	return err;
-- 
2.25.1

