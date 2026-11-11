Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408174;
	b=T+YW/Rns0qMOB0B4Ija3qEcMT6rwHwUPXGkL+AzN4xVmPerwBugo74eLeE+4ZpzuWE9I
	 MSztJgFC1Gud97qJKsqCbBQnqEfSZmRF9394fO6fS5sEuwxLd4nhRP3+7sqY6JKYLM54U
	 IvkT9i95Txf4YCjCR35Dz8dxUlo8RCLxvJQ+4DxDjSzQbbSQwfsgRAkLlupdaknwW34tB
	 lOHSupcvqSBCP3GuQwwjIB2CJhPRnypVCAjvTk09yXUGd0DWMaIHbxAiZmFeNp1YcYnNs
	 V0YIDyK85biXCYYhC4RGdHPjlrZJjH8GKnSX2w7A0aj5i6IEq8tHJQE1ANeaeGpcz7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408174;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=Is2Qw4KwfsCgWxutP7xyosQOwa+vDqMv8BX4qqT0dxI=;
	b=md2MK6HfZIxN9BhTz5UAOQbpZn+7uLpYQZrsC/ozOYIcL4UywTlA+eN36K6ntKbPthEk
	 swFiZXZ5ixnjTq+9C1FSgkKMgol0T7u0E/zstcevJY2xB2eMuHbYVltrCc/buX64jkEuV
	 qMXVjwK9iU6Vi7gWLznOVTcd8XMcv4/5XOSgPt0WCx1SU3i2R4xKovRddxpV1G6FyBUxe
	 UsQkBrz1iKyTfUXf00GI+zf3O5Wvp/J4wjL7urOvI/OnIhBZoqcvq1fhic7u7pxMVhsGZ
	 +KYC8UpJnPlX1+1WUy54a5USXWGKekFahv0oxLUjFBHaUbTg1fWbDqhNNijp53+XxHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=DTjA449H;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492D2606A32A;
	Wed, 11 Nov 2026 14:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 492D2606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=DTjA449H
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jPmTR4mlCz5BNS0;
	Wed, 11 Nov 2026 22:42:51 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794408171;
	bh=IzuiCSP5pU3bvzUwHFnQ1wq0w2ckTj4EwbmRQgtXJyw=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=DTjA449HmBnNWm7D/JJKB9ay7DNFMz82Jnsuoy/GFxzWlzBut3T8FdOKsf7DEjtUK
	 +7GEsprgD4XTwYN+UXB7bwbzKs4r3stLs64utWqTtXob4WesdCPJPlsptp1ia6H9og
	 BGl4Pdz89grcQkeaMZwq9PWcV9X7RCBxRC2AONCIP/a62WLNy7iQMFdLCXztHUtvET
	 csJ4Qxt06HJpdQsdDAVAA5SiOoeF0Kp6jq1Uply/9KVC6YcW28PizUg51B71xhprog
	 b1C0qy9Ql9wULtX7StY81L2aQ8Og0RfoVbbLF1ruRfCCB+j1r6nAElSUaEKdU1WYlF
	 LWW/vMQ+fibFQ==
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 6ABEgjjl064559;
	Wed, 11 Nov 2026 22:42:45 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 11 Nov 2026 22:42:47 +0800 (CST)
X-Zmail-TransId: 2afa6af47ee7701-7a5d3
X-Mailer: Zmail v1.0
Message-ID: <20261111224247129g0VbfWdGlwDMhBpChnT-8@zte.com.cn>
In-Reply-To: <20261111224134934XG6vMtntrNJQL1ztj7imr@zte.com.cn>
References: 20261111224134934XG6vMtntrNJQL1ztj7imr@zte.com.cn
Date: Wed, 11 Nov 2026 22:42:47 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDIvMl0gbnZtZXQ6IHVzZSBvdmVyZmxvdy1zYWZlIHJhbmdlIGNoZWNrcyBpbiB0aGUgZmlsZSBiYWNrZW5k?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6ABEgjjl064559
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 11 Nov 2026 22:42:51 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF47EEB.000/4jPmTR4mlCz5BNS0

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

Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with the loop transport
and a 4 MiB file-backed namespace.

A Write with SLBA = 2^52 + 1 and a 4 KiB block size yields a byte
offset that wraps to 0x1000 and passes the size check:

  unpatched                            patched
  ret=0 (write accepted at 0x1000)     ret=24705 (Capacity Exceeded)
  drivers/nvme/target/io-cmd-file.c |   41 +++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 695963dd932e..d59dbf61b1b0 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -125,17 +125,22 @@ static bool nvmet_file_execute_io(struct nvmet_req *req, int ki_flags)
 	size_t len = 0, total_len = 0;
 	ssize_t ret = 0;
 	loff_t pos;
+	u64 pos64;
 	int i;
 	struct scatterlist *sg;
 
 	if (req->f.mpool_alloc && nr_bvec > NVMET_MAX_MPOOL_BVEC)
 		is_sync = true;
 
-	pos = le64_to_cpu(req->cmd->rw.slba) << req->ns->blksize_shift;
-	if (unlikely(pos + req->transfer_len > req->ns->size)) {
+	if (unlikely(check_shl_overflow(le64_to_cpu(req->cmd->rw.slba),
+					req->ns->blksize_shift,
+					&pos64) ||
+		     pos64 > req->ns->size ||
+		     req->transfer_len > req->ns->size - pos64)) {
 		ret = -ENOSPC;
 		goto complete;
 	}
+	pos = pos64;
 
 	memset(&req->f.iocb, 0, sizeof(struct kiocb));
 	for_each_sg(req->sg, sg, req->sg_cnt, i) {
@@ -269,6 +274,16 @@ static void nvmet_file_execute_flush(struct nvmet_req *req)
 	queue_work(nvmet_wq, &req->f.work);
 }
 
+static bool nvmet_file_check_lba_range(struct nvmet_req *req, u64 slba,
+				       u64 nlb, u64 *offset, u64 *len)
+{
+	if (check_shl_overflow(slba, req->ns->blksize_shift, offset) ||
+	    check_shl_overflow(nlb, req->ns->blksize_shift, len))
+		return false;
+
+	return *offset <= req->ns->size && *len <= req->ns->size - *offset;
+}
+
 static void nvmet_file_execute_discard(struct nvmet_req *req)
 {
 	int mode = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
@@ -279,19 +294,22 @@ static void nvmet_file_execute_discard(struct nvmet_req *req)
 	int i;
 
 	for (i = 0; i <= le32_to_cpu(req->cmd->dsm.nr); i++) {
+		u64 offset64, len64;
+
 		status = nvmet_copy_from_sgl(req, i * sizeof(range), &range,
 					sizeof(range));
 		if (status)
 			break;
 
-		offset = le64_to_cpu(range.slba) << req->ns->blksize_shift;
-		len = le32_to_cpu(range.nlb);
-		len <<= req->ns->blksize_shift;
-		if (offset + len > req->ns->size) {
+		if (!nvmet_file_check_lba_range(req, le64_to_cpu(range.slba),
+						le32_to_cpu(range.nlb),
+						&offset64, &len64)) {
 			req->error_slba = le64_to_cpu(range.slba);
 			status = errno_to_nvme_status(req, -ENOSPC);
 			break;
 		}
+		offset = offset64;
+		len = len64;
 
 		ret = vfs_fallocate(req->ns->file, mode, offset, len);
 		if (ret && ret != -EOPNOTSUPP) {
@@ -336,16 +354,17 @@ static void nvmet_file_write_zeroes_work(struct work_struct *w)
 	int mode = FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE;
 	loff_t offset;
 	loff_t len;
+	u64 offset64, len64;
 	int ret;
 
-	offset = le64_to_cpu(write_zeroes->slba) << req->ns->blksize_shift;
-	len = (((sector_t)le16_to_cpu(write_zeroes->length) + 1) <<
-			req->ns->blksize_shift);
-
-	if (unlikely(offset + len > req->ns->size)) {
+	if (!nvmet_file_check_lba_range(req, le64_to_cpu(write_zeroes->slba),
+					(u64)le16_to_cpu(write_zeroes->length) + 1,
+					&offset64, &len64)) {
 		nvmet_req_complete(req, errno_to_nvme_status(req, -ENOSPC));
 		return;
 	}
+	offset = offset64;
+	len = len64;
 
 	ret = vfs_fallocate(req->ns->file, mode, offset, len);
 	nvmet_req_complete(req, ret < 0 ? errno_to_nvme_status(req, ret) : 0);
