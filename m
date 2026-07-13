Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ECB363083
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 06:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783924201; cv=none; b=TbkdYcnbUE2Oqi+zZotmQMX5Hoold9a+lmht9bE7tTInUoeO2pqyYyPOM/gqgqX0LYZeps/T0PqjyPAgDN8jm2d6Ut3yXFwSpawR4vW545E1ZBeYNcwVMFD9qwRG2pph7P9nAZO/Zl1s846vnIxD8VtSKANvGql4AjRS91BXpkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783924201; c=relaxed/simple;
	bh=kRUTTcVhnvmtYZozFnyAXrZWq2lZZsmKOrvI3UBccuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dFkEZE42+xQEYiFGvGHehhTvPjuwW6yjXO5r4sl5Zrh0vY81KVyAgcSEiQ0WQbZqc8Bsjptv/UkVfqidFQp2v+6l3JxkLGIuKWmvBTgwKWqHEbJdehL+cF8aIt4t58Yy7jlfomV/fu5MT9W/fGwZiPmo1tbfySPQNgiqzk5xVtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=cXlMWOTR; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="cXlMWOTR"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id BA26B1D4A2;
	Mon, 13 Jul 2026 06:20:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me BA26B1D4A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1783923609; bh=kRUTTcVhnvmtYZozFnyAXrZWq2lZZsmKOrvI3UBccuI=;
	h=From:To:Cc:Subject:Date:From;
	b=cXlMWOTRnnbv+KquEzhknIDhLsORqX3/Y9sF2KT9gBFK+RCY8a8+xJjUn+4zNTBwQ
	 Dqt3kbnaAWDhTVVQv5bq26e0huIvQ4J9tlyN/DXRuVUheiwOCewH+QM4sNUgG13jBT
	 R4KRRl5G9gYYzXWbGkpo7BhPILm4qI88Tf8ouatQ=
Received: from maya.d.snart.me ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id 51S0GpeDVGqjwQIA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Mon, 13 Jul 2026 06:20:07 +0000
From: David Timber <dxdt@dev.snart.me>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
Cc: Andy Wu <Andy.Wu@sony.com>,
	Aoyama Wataru <wataru.aoyama@sony.com>,
	David Timber <dxdt@dev.snart.me>,
	stable@vger.kernel.org
Subject: [PATCH v1] exfat: bail prematurely from exfat_extend_valid_size() upon fatal signal
Date: Mon, 13 Jul 2026 15:19:54 +0900
Message-ID: <20260713061954.19557-1-dxdt@dev.snart.me>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 82a81a7352bcf5f2756ac33d47ee0582737e9a85 upstream.

If a file in an exfat volume has a large (isize - VDL) gap and userspace
write past a large amount of unwritten clusters, write amplification
occurs. Currently there was no way for userspace to cancel this.

As tasks with pending fatal signal receives preferential treatment in
mm/vmscan.c, if the userspace process is killed during the iteration,
the excessive use of pages in block_write may lead to system instability
and OOM killer activating in vain to free up some pages.

Demo:

	truncate -s 16G /mnt/exfat/file
	dd if=/dev/urandom of=/mnt/exfat/file bs=1 count=1 seek=16G &
	kill -KILL $!

To fix this, add the fatal_signal_pending() check in the loop. This
mirrors the behaviour of iomap variant of exfat. Note that the iomap
exfat implementation is unaffected as the check is already present in
iomap_zero_range().

Fixes: 11a347fb6cef ("exfat: change to get file size from DataLength")
Cc: <stable@vger.kernel.org> # 6.18+
Signed-off-by: David Timber <dxdt@dev.snart.me>
---
 fs/exfat/file.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 91e5511945d1..4db6a4b773fd 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -656,6 +656,11 @@ static int exfat_extend_valid_size(struct inode *inode, loff_t new_valid_size)
 		struct folio *folio;
 		unsigned long off;
 
+		if (fatal_signal_pending(current)) {
+			err = -EINTR;
+			goto out;
+		}
+
 		len = PAGE_SIZE - (pos & (PAGE_SIZE - 1));
 		if (pos + len > new_valid_size)
 			len = new_valid_size - pos;
@@ -717,13 +722,20 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 	if (pos > valid_size) {
 		ret = exfat_extend_valid_size(inode, pos);
-		if (ret < 0 && ret != -ENOSPC) {
-			exfat_err(inode->i_sb,
-				"write: fail to zero from %llu to %llu(%zd)",
-				valid_size, pos, ret);
-		}
-		if (ret < 0)
+		if (ret < 0) {
+			/* Do not report trivial errors. */
+			switch (ret) {
+			case -ENOSPC:
+			case -EINTR:
+				break;
+			default:
+				exfat_err(inode->i_sb,
+					"write: fail to zero from %llu to %llu(%zd)",
+					valid_size, pos, ret);
+			}
+
 			goto unlock;
+		}
 	}
 
 	ret = __generic_file_write_iter(iocb, iter);
-- 
2.55.0

