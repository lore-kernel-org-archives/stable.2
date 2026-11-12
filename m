Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492074;
	b=pI5zKTP0ALEhdk+1q5ER9oioXY68AAJ4DGBWvZdm8bTpDNnVx0bZddkrbN7D/k1if7Ps
	 ZWlgCtI403NWGtJUywVbTl0Rf5b0tPB9n9B1KfK8q1cSgRhdAHJ7gIPa6UOoj70+ZaePq
	 oqIWAv/SCwFeBZk/WrFa8v2tACqUawJmaJXod0FVlFsm3xSucc4eaqRtuo586eL47Ed0q
	 bJidwgvUpqpEFEdt8sff6OmGkTnpJWOAwwDq2EyhYvX2Wzd+NUgySjSALKTeyH9vi3qht
	 /Log2GpNKf3EdmdRSS+SrBP/+2vsxHFuSikdYkQgiEcFfDGW8wkqSd6oodsZgFMb7ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492074;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=m794oFJxY0m+FJ1g0fjPeP5sYKwotuC4zOar6dDhflA=;
	b=BOCoJQaiSd09puVaaw1kmjaMgrJZ/CJsxdONcgCZfkG76X6zrPjMlgmAxzWMw2rjPXve
	 VqiJXdN9qxVTx0Lux4gUIgqTPmtLvjI8wcQ4W2YKYsp5ShQ9iPJGnOCxKIhSKR5l0tiY5
	 P4x5eTXydU7I9GiETaIPhigGV9R9Iclj/iKIsSvBexLFviIieczPoyvG29dGqmfgHrD8d
	 5upKQsNmYVhTs6mOAdmptGhw7uPQ5zK1w0JIs5QYcBiceEF2Jlhn9vW4So0SOrBzkIyhI
	 ywXX/LBLpk1DUL5ABuAmODbdZKwwkm3ZpeDqTf5Nu0H2u55dSdEw40omH97rXY+DZEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=aMXOfHyH;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582DF60A261E;
	Thu, 12 Nov 2026 14:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 582DF60A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=aMXOfHyH
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jQMVn06Fsz58fdL;
	Thu, 12 Nov 2026 22:01:05 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794492065;
	bh=pe/DgnYm8uD3TZB4qvRZD+eJYrzD0zGxyXSxMz9yUec=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=aMXOfHyHHhoxOiBIYHMnZ4D8mIxYTDixSaQOFs/WB2FMv4u32zWR/euA3AsWuFojX
	 KVWbaCRjolPoW8E/1XcrvZnau3OACXQI6V7+oou4A5r7YPlkJ/f55qSECMjlf24hN2
	 9YTsLEy/T63fQNsvQBD+oqQzQnDIMawbqDVcTOSpKfwUuqmSzy0z+YqN+dGSQG9ST3
	 3To+IhIjsr0Yaa+VjlsQB5WZPpOQKDzOdYXMxjv5DYMbOjMMfzwxl9TpR8SkLDfGdE
	 aplMX87lfqTGi2zBSGBPTnGiXjfYJFWAIiQQ4u90k9PH5coyDyaHak5B831qmGWdOp
	 KDlvR3ONOp48A==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 6ACE13Ml036818;
	Thu, 12 Nov 2026 22:01:03 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 12 Nov 2026 22:01:06 +0800 (CST)
X-Zmail-TransId: 2afa6af5c6a2955-f60b2
X-Mailer: Zmail v1.0
Message-ID: <20261112220106682vEsVrn_uCY7k7JVslANjN@zte.com.cn>
In-Reply-To: <20261112220058755zQhw_h6UkcVSjRnu478lb@zte.com.cn>
References: 20261112220058755zQhw_h6UkcVSjRnu478lb@zte.com.cn
Date: Thu, 12 Nov 2026 22:01:06 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyIDIvMl0gbnZtZXQ6IHVzZSBvdmVyZmxvdy1zYWZlIHJhbmdlIGNoZWNrcyBpbiB0aGUgZmlsZSBiYWNrZW5k?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6ACE13Ml036818
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 12 Nov 2026 22:01:05 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF5C6A1.000/4jQMVn06Fsz58fdL

From: Shao Mingyin <shao.mingyin@zte.com.cn>

The file backend shifts a host-supplied SLBA to form a byte offset
before checking it against the namespace size. The shift can discard
high bits: with a 4 KiB block size, SLBA 2^52 + 1 becomes offset 4096.
The range check then accepts a command aimed outside the namespace and
the backend accesses data at the wrapped offset.

Reject overflowing LBA-to-byte conversions and check the transfer
length against the remaining namespace size without adding it to the
offset. Apply the checks to reads, writes, discard and write zeroes.

Fixes: 9c891c139894 ("nvmet: check fileio lba range access boundaries")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Changes in v2 (Christoph Hellwig):
- Share nvmet_file_check_lba_range() with read/write and hide pos64
  inside it. Pass byte lengths; check block-to-byte length conversion
  separately for discard and write zeroes. No functional change.
v1: https://lore.kernel.org/all/20261111224247129g0VbfWdGlwDMhBpChnT-8@zte.com.cn/

A userspace test compiled the range helper and the kernel shift-overflow
macro with GCC 13 and UBSAN. Boundary and random inputs matched the v1
checks and a 128-bit arithmetic oracle, including wrapped LBAs, byte and
block lengths, exact-end access and one-byte overruns.

 drivers/nvme/target/io-cmd-file.c | 40 ++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index e95ab1f08cff39b0a1147e53bbd7749a831d29a6..3098b902f51987f3da30dcc3cbb47729f62f7718 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -117,6 +117,19 @@ static void nvmet_file_io_done(struct kiocb *iocb, long ret)
 	nvmet_req_complete(req, status);
 }
 
+static bool nvmet_file_check_lba_range(struct nvmet_req *req, u64 slba,
+				       u64 len, loff_t *pos)
+{
+	u64 pos64;
+
+	if (check_shl_overflow(slba, req->ns->blksize_shift, &pos64) ||
+	    pos64 > req->ns->size || len > req->ns->size - pos64)
+		return false;
+
+	*pos = pos64;
+	return true;
+}
+
 static bool nvmet_file_execute_io(struct nvmet_req *req, int ki_flags)
 {
 	ssize_t nr_bvec = req->sg_cnt;
@@ -131,8 +144,9 @@ static bool nvmet_file_execute_io(struct nvmet_req *req, int ki_flags)
 	if (req->f.mpool_alloc && nr_bvec > NVMET_MAX_MPOOL_BVEC)
 		is_sync = true;
 
-	pos = le64_to_cpu(req->cmd->rw.slba) << req->ns->blksize_shift;
-	if (unlikely(pos + req->transfer_len > req->ns->size)) {
+	if (unlikely(!nvmet_file_check_lba_range(req,
+						 le64_to_cpu(req->cmd->rw.slba),
+						 req->transfer_len, &pos))) {
 		ret = -ENOSPC;
 		goto complete;
 	}
@@ -282,19 +296,22 @@ static void nvmet_file_execute_discard(struct nvmet_req *req)
 	int i;
 
 	for (i = 0; i <= le32_to_cpu(req->cmd->dsm.nr); i++) {
+		u64 len64;
+
 		status = nvmet_copy_from_sgl(req, i * sizeof(range), &range,
 					sizeof(range));
 		if (status)
 			break;
 
-		offset = le64_to_cpu(range.slba) << req->ns->blksize_shift;
-		len = le32_to_cpu(range.nlb);
-		len <<= req->ns->blksize_shift;
-		if (offset + len > req->ns->size) {
+		if (check_shl_overflow((u64)le32_to_cpu(range.nlb),
+				       req->ns->blksize_shift, &len64) ||
+		    !nvmet_file_check_lba_range(req, le64_to_cpu(range.slba),
+					len64, &offset)) {
 			req->error_slba = le64_to_cpu(range.slba);
 			status = errno_to_nvme_status(req, -ENOSPC);
 			break;
 		}
+		len = len64;
 
 		ret = vfs_fallocate(req->ns->file, mode, offset, len);
 		if (ret && ret != -EOPNOTSUPP) {
@@ -339,16 +356,17 @@ static void nvmet_file_write_zeroes_work(struct work_struct *w)
 	int mode = FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE;
 	loff_t offset;
 	loff_t len;
+	u64 len64;
 	int ret;
 
-	offset = le64_to_cpu(write_zeroes->slba) << req->ns->blksize_shift;
-	len = (((sector_t)le16_to_cpu(write_zeroes->length) + 1) <<
-			req->ns->blksize_shift);
-
-	if (unlikely(offset + len > req->ns->size)) {
+	if (check_shl_overflow((u64)le16_to_cpu(write_zeroes->length) + 1,
+			       req->ns->blksize_shift, &len64) ||
+	    !nvmet_file_check_lba_range(req, le64_to_cpu(write_zeroes->slba),
+				len64, &offset)) {
 		nvmet_req_complete(req, errno_to_nvme_status(req, -ENOSPC));
 		return;
 	}
+	len = len64;
 
 	ret = vfs_fallocate(req->ns->file, mode, offset, len);
 	nvmet_req_complete(req, ret < 0 ? errno_to_nvme_status(req, ret) : 0);
