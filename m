Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794674018;
	b=b/G/orZm+BYMoiWU0mnfXEW1+jjjk1yl1ptPPa2JsIWPmJoVgf5xEzfoWHylEDxnMRM+
	 QTQrFANfvaADmxv7DX4kkC3Lo9CQFi4/iQPzw+kw/5pLqFXKJcUUbaUwCnabEbH5ll4/n
	 70nG/cBXFJewlbqU0PMFtcqmpgo3k/BG8b29VXG02ePiLk33pAAM4niBEBb69KYVeTND8
	 nUOX5oiTOnmoFlDcLW7Zsr9JZzR3QES8888AqCMa6jG0upr8bq0YR3Zp3uI5SoReEJzvN
	 5sgND/o7AGjEKWWg4uZRl5Ib5jHXzdaM+ldwq2K+VW/itSkrtR3ZcXpyI6mmmY+uSMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794674018;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=O1ypsRd6FRvicI7GlxnFvXQAIUrzQn7pYeX/tyFhz58=;
	b=tp/ApatIr+0zwCfmZQ19D3FSoyXfwsrFKc3oI4if9m9e4OGq/ThNv+hBSjOFw0CdXlzs
	 CdGYVR0NDWzPkZvI7gArWb2yMIZa9zssqtVuHYqJVV+VykSxB4Q4YdNXT3mii+wMmBJfD
	 4plEveg+mZOyPDZpLRYDmc3ODlwZsBYFNt10M5OE0/8jkkHcw7H0E8z2Vt4YxFKMRZuEv
	 Lzno6Qv/s/VTsTdMJzHcMGt7O9s+/C42UJqg2fQNKIRyJgzWGhefPlaCkkR4Dki0pzeU5
	 xImRP1KYadJMSOqIf564cgA6+7N3ltGsSPLnanQ+TWNHowlkBNQglPsRvUW/R2NaXiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=hhCbeuir;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18009606A327;
	Sat, 14 Nov 2026 16:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18009606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=hhCbeuir
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jRfnj3GZ9z8XrrJ;
	Sun, 15 Nov 2026 00:33:29 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794674009;
	bh=9KKuBsgULhFyR6UGS3Hdz+ySlJV1lthvy6+g/2Qjygk=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=hhCbeuirI/lofoMlskbhwv9eOM5OMtLIuwI63pT028pt0Ewo9QcUcrR+b1cc2QJY1
	 dkx8ZXccN11zKn5SBgPrMyGyRbx4AyYvNAPzztfeBA350xXmn3SfTw4apLRVwin9GT
	 9hpk3bdxHmMotBjiOHhKZ3y0MHKDSV7l7ZC2/MgSO7yaflM3XDB93LWYlJBOJYSbmm
	 ETXEbpRhvWmatZ7t3qp4DUdXs51wZk7OEyNpuJP5RSCLlzaLdFUdKFA+TakBfw67RS
	 IhrThmJXrNe1KNhwjWgBLqWs8oPuZfmtFYLDdDwL2EgPzMEnxrqDAgLXMb9BfNbTnV
	 EkuzeBaXUg3Hg==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 6AEGXMml085601;
	Sun, 15 Nov 2026 00:33:22 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 15 Nov 2026 00:33:25 +0800 (CST)
X-Zmail-TransId: 2afc6af88d55e27-24e03
X-Mailer: Zmail v1.0
Message-ID: <20261115003325701HiO0_fpaadYMDT3t4amep@zte.com.cn>
In-Reply-To: <20261115003324243qi0CFfSksizkJybVkq3QH@zte.com.cn>
References: 20261115003324243qi0CFfSksizkJybVkq3QH@zte.com.cn
Date: Sun, 15 Nov 2026 00:33:25 +0800 (CST)
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
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDEvMl0gejJyYW06IGNvcHkgZXZlcnkgc2VnbWVudCBiZWZvcmUgY29tcGxldGluZyBhIHJlcXVlc3Q=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6AEGXMml085601
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sun, 15 Nov 2026 00:33:29 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF88D59.000/4jRfnj3GZ9z8XrrJ

From: Shao Mingyin <shao.mingyin@zte.com.cn>

z2_queue_rq() copies only blk_rq_cur_bytes() from the first bio and then
completes the entire request. The blk-mq conversion removed the loop
that used __blk_end_request_cur() to advance through each segment.
Multi-segment reads consequently leave data untouched, while writes
silently discard all but the first segment.

Walk all request segments and map each one for the copy. Advance the
buffer within a segment when crossing a Zorro RAM chunk boundary, and
check the size of the whole request against the backing storage before
copying anything.

Fixes: 8535fd6f702a ("z2ram: convert to blk-mq")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Testing:
Built with W=1 using m68k amiga_defconfig. Exercised the actual request
function in a host test program with substitutes for requests, segment
iteration and page mapping. Read and write tests cover one segment,
three segments, and copies crossing a backing chunk boundary. The base
function loses or corrupts data in six of eight scenarios; the fixed
function matches the full-buffer oracle in all eight. The ordinary
single-segment controls pass in both versions. No Amiga hardware test
was performed.

 drivers/block/z2ram.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/block/z2ram.c b/drivers/block/z2ram.c
index b216cba1c3bf2b750aaae59a6793bade44c857bd..15ef92a9744414b9387f4520dc3c7b2f42bebc87 100644
--- a/drivers/block/z2ram.c
+++ b/drivers/block/z2ram.c
@@ -36,6 +36,7 @@
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/pgtable.h>
+#include <linux/highmem.h>
 
 #include <asm/setup.h>
 #include <asm/amigahw.h>
@@ -70,11 +71,12 @@ static blk_status_t z2_queue_rq(struct blk_mq_hw_ctx *hctx,
 {
 	struct request *req = bd->rq;
 	unsigned long start = blk_rq_pos(req) << 9;
-	unsigned long len = blk_rq_cur_bytes(req);
+	struct req_iterator iter;
+	struct bio_vec bv;
 
 	blk_mq_start_request(req);
 
-	if (start + len > z2ram_size) {
+	if (start > z2ram_size || blk_rq_bytes(req) > z2ram_size - start) {
 		pr_err(DEVICE_NAME ": bad access: block=%llu, "
 		       "count=%u\n",
 		       (unsigned long long)blk_rq_pos(req),
@@ -84,20 +86,25 @@ static blk_status_t z2_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	spin_lock_irq(&z2ram_lock);
 
-	while (len) {
-		unsigned long addr = start & Z2RAM_CHUNKMASK;
-		unsigned long size = Z2RAM_CHUNKSIZE - addr;
-		void *buffer = bio_data(req->bio);
-
-		if (len < size)
-			size = len;
-		addr += z2ram_map[start >> Z2RAM_CHUNKSHIFT];
-		if (rq_data_dir(req) == READ)
-			memcpy(buffer, (char *)addr, size);
-		else
-			memcpy((char *)addr, buffer, size);
-		start += size;
-		len -= size;
+	rq_for_each_segment(bv, req, iter) {
+		unsigned long len = bv.bv_len;
+		char *buffer = bvec_kmap_local(&bv);
+		char *ptr = buffer;
+
+		while (len) {
+			unsigned long offset = start & Z2RAM_CHUNKMASK;
+			unsigned long size = min(len, Z2RAM_CHUNKSIZE - offset);
+			unsigned long addr = z2ram_map[start >> Z2RAM_CHUNKSHIFT];
+
+			if (rq_data_dir(req) == READ)
+				memcpy(ptr, (char *)addr + offset, size);
+			else
+				memcpy((char *)addr + offset, ptr, size);
+			start += size;
+			ptr += size;
+			len -= size;
+		}
+		kunmap_local(buffer);
 	}
 
 	spin_unlock_irq(&z2ram_lock);
-- 
2.43.0
