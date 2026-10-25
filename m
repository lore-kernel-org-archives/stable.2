Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792932114;
	b=saQ3/7oaGxLMgTDWr+51yqRUOyq7KPpzQTr9EFOjY0u73/xMk9CQGhzsI2UPZ8C+pAzW
	 J8LVvmaVJ0ePrXJoAeUEPDq0wmBLhRg3kv7crSD4t3f3zzjfO3Xpis92ap5tlh5f5GIxR
	 Fl7E7r/4JAsTfOgE8YZs+ffhDcDD8zKgLfE217CT46XI/arz89dJx+nQSsNCpT9Zj3fnr
	 g2qbYejTzLWCT8B0s7REsmd7BQJte1DfhVKC3INXZbC6APMOpwddWsPDECoZWcpfJLQza
	 JpEYhFCh1j/amKd08YSSIOPgzoiyGEKZ8Vs0OZ8H98duaX7y6DIGPubzI3P9hZb546w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792932114;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=ZUrqx1rvvs6o+dee+0TNtCMY/5xlNRoKRO5LvvKhg7Y=;
	b=STm1uk6V7alc+lN9jLcK8TaFhGz6YtIFDP132FoS74Rcwng33U60RFiV/sQcNKMjQGdi
	 D3DBOBxEgMAKJtsOlGGGXf+WiUCZqamHesZ/AWROx8OWi8fIIIa5Lui6pp/PDpz1g748U
	 v33CfXQPbDUCrxyCNN+RwENNvBkacOLbY1eP9KsnmxysORGUkRhdrGbLrd6Mx5DXX6ucB
	 Iz/ndyqRRvm7sTrXFO+BhRZ9wCeFvNERAY/d3xB6oC+K87JsZuVEMIxqcgZI6IXhF/PPg
	 /rymDaxOT2MfHPu7dBpjIE2ir0KME/Cwks2mA3gecnwAc3WDoh5irOIyACpyAOryJ/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=CgjBCxH1;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542AC606A329;
	Sun, 25 Oct 2026 12:41:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 542AC606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=CgjBCxH1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ZU
	rqx1rvvs6o+dee+0TNtCMY/5xlNRoKRO5LvvKhg7Y=; b=CgjBCxH1/Oc2JfWhDS
	OQiL4Vxzt2QEj/wPgkFG6ex2R86k2uIkiMSHUCroN3mB+1wYgE4ah2i1rBjQOzOm
	6+SezCV1pMmuInJE/CwGhkp/RAqFQqytW6Y8gOd96VvTzU+USTWFcxIafIybCW6L
	4MyFYZpDx6kxlWFJq9jdt2esQ=
Received: from pc.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDnvTzs+N1qxJALCA--.54355S4;
	Sun, 25 Oct 2026 20:41:21 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Eric Biggers <ebiggers@google.com>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 2/5] f2fs: drain in-flight DIO before buffered writes
Date: Sun, 25 Oct 2026 20:41:11 +0800
Message-Id: <20261025124115.3178287-3-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261025124115.3178287-1-yaojiale02@163.com>
References: <20261025124115.3178287-1-yaojiale02@163.com>
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
X-CM-TRANSID:PigvCgDnvTzs+N1qxJALCA--.54355S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrWDGr4rXw1DZF13CF48JFb_yoW8CFykpF
	9xKa45ur97JrZrWrn7Ga1UZ34FgFykJrWfWryUX3WIvw1DGw4Yq3WIyF1a9F1rtFy7Jw42
	gan09FyDW3yjyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joUDJUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8BGMxmrd+PEPUwAA3J

An asynchronous iomap direct write can remain in flight after the inode
lock is released. A buffered write can then dirty page cache before the
direct write completes its post-I/O invalidation, causing the
invalidation to fail and record -EIO in the mapping error sequence.

The pre-write checks can also zero post-EOF page cache while an earlier
direct write is still active.

Wait for in-flight DIO before post-EOF page-cache operations and before
buffered writes. Return -EAGAIN for a NOWAIT write that would need the
blocking post-EOF operation.

Fixes: a1e09b03e6f5 ("f2fs: use iomap for direct I/O")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 fs/f2fs/file.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 0c759cc99054..d3d0ebf2f6c3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -5328,6 +5328,7 @@ static ssize_t f2fs_write_checks(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
+	loff_t end_pos;
 	ssize_t count;
 	int err;
 
@@ -5345,8 +5346,14 @@ static ssize_t f2fs_write_checks(struct kiocb *iocb, struct iov_iter *from)
 	if (err)
 		return err;
 
-	err = f2fs_zero_post_eof_page(inode,
-		iocb->ki_pos + iov_iter_count(from), true, true);
+	end_pos = iocb->ki_pos + iov_iter_count(from);
+	if (end_pos > i_size_read(inode)) {
+		if (iocb->ki_flags & IOCB_NOWAIT)
+			return -EAGAIN;
+		inode_dio_wait(inode);
+	}
+
+	err = f2fs_zero_post_eof_page(inode, end_pos, true, true);
 	if (err)
 		return err;
 	return count;
@@ -5436,6 +5443,8 @@ static ssize_t f2fs_buffered_write_iter(struct kiocb *iocb,
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		return -EOPNOTSUPP;
 
+	inode_dio_wait(inode);
+
 	ret = generic_perform_write(iocb, from);
 
 	if (ret > 0) {
-- 
2.34.1

