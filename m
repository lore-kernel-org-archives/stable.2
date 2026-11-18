Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.125
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794972759;
	b=SX75BIUMQmVgat0CbP37J5QBPZN8CdJctNRRnVHvKfP5O8eh7Iw06focas46jEfOnug9
	 qzzlfsEI+SVNiEqxrSKkrhPAHJXJ27vtW9gcJsiMLKDCkjIAW2s8/G7QM3FFuSkkyn1g3
	 dxOYzcf7mMQyRXxpqSF5tEcCKQGz8tUiZfWiBb4zfWPjASfqbl2u5YI4lbugMm3uNGDIl
	 92UW86ttpKup99tRWvJ6jYepswoTGHl/r/HzckvD6CqAlzfme6OsTNJvUCMRWZKV8NZe2
	 0uDeSxKFNQhjaTbUzS4OE/r5Ul0bceiuydpA3aEj1lneeZVPOSsanuxaqscEyVyFAAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972759;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=JMsEoh9unEObzZlKKNgSl3NBs0hCf3pS2PdnFg6mbtY=;
	b=EY/+oBNlrWL+o+Hz1ARgdrOtIwcymxcgMRKRfaGK5pnQalBbCn3/tO341u6JlCmp6ab9
	 8GSOrtOnhbC9x0AqcPjjTgvbQ93WVwPNzPMWx0CcYsJYPU54VnK1ohEn3XrixpCqmgE4O
	 xPStenR93ZRRBra6mBeAxT7e5iGmbQ3G+efnXhF0OvZbzFmFaZwTOXhSaiHf+A/cCTVkN
	 i43E5i8wIKRZHPgHjVXhpEyN7+eqXYbCPnP6ObU0hs2VZ6h98fDuyTi+m5kKnZEFOt86M
	 tefJ1mViUEZUkduRF0BXugiyDHufLPp8VxPusDeMEEQOSTaVEbLbyLpR5yMXhmagAwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kaihong.com;
	spf=pass smtp.mailfrom=kaihong.com;
	arc=none smtp.remote-ip=115.124.28.125
Received: from out28-125.mail.aliyun.com (out28-125.mail.aliyun.com [115.124.28.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8CE606A325;
	Wed, 18 Nov 2026 03:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D8CE606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaihong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaihong.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0673776|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00507667-0.000490795-0.994433;FP=14242939606164800247|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045038069;MF=wangxiaolei01@kaihong.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.k4Lvy.H_1794972746;
Received: from nj-vm-261.pxvirt.local(mailfrom:wangxiaolei01@kaihong.com fp:SMTPD_---.k4Lvy.H_1794972746 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 18 Nov 2026 11:32:27 +0800
From: Xiaolei Wang <wangxiaolei01@kaihong.com>
To: ulfh@kernel.org,
	cw9316.lee@samsung.com,
	avri.altman@sandisk.com,
	wangxiaolei01@kaihong.com,
	shawn.lin@linux.dev,
	linusw@kernel.org
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] mmc: core: use GFP_NOIO for SD cache flush buffers
Date: Wed, 18 Nov 2026 03:32:25 +0000
Message-Id: <20261118033225.1212442-1-wangxiaolei01@kaihong.com>
X-Mailer: git-send-email 2.34.1
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

sd_flush_cache() is called from mmc_blk_mq_issue_rq()'s REQ_OP_FLUSH
branch, which runs in the block layer dispatch path with the queue usage
counter held.  Both it and sd_write_ext_reg(), which it calls, allocate
a 512-byte buffer with GFP_KERNEL.  Under memory pressure that
allocation enters filesystem reclaim, and reclaim may submit I/O back to
the same request queue, closing a cycle against queue freeze:

      CPU0                              CPU1
      ----                              ----
  lock(&q->q_usage_counter(io));
                              lock(fs_reclaim);
                              lock(&q->q_usage_counter(io));
  lock(&q->elevator_lock);

lockdep reports it on an arm64 Raspberry Pi 5 that boots from an SD
card, with the flush dispatched by blk_mq_requeue_work and the elevator
switch in another thread:

  -> #2 (fs_reclaim):
       fs_reclaim_acquire <- __kmalloc_cache_noprof <- sd_flush_cache
       <- mmc_blk_mq_issue_rq <- mmc_mq_queue_rq
       <- blk_mq_dispatch_rq_list

blk_alloc_queue() declares this ordering explicitly and teaches lockdep
about it:

  /* Teach lockdep about lock ordering (reclaim WRT queue freeze lock). */
  fs_reclaim_acquire(GFP_KERNEL);
  rwsem_acquire_read(&q->io_lockdep_map, 0, 0, _RET_IP_);
  rwsem_release(&q->io_lockdep_map, _RET_IP_);
  fs_reclaim_release(GFP_KERNEL);

Taking q_usage_counter(io) and then entering reclaim is the reverse of
that contract.  GFP_NOIO drops __GFP_FS and __GFP_IO, so neither the
lockdep dependency nor the writeback that could resubmit to this queue
can happen any more.

sd_write_ext_reg() is also called from sd_enable_cache() (probe) and
sd_poweroff_notify() (suspend).  NOIO costs nothing on those paths: the
allocation is order-0 and 512 bytes, and reclaim without writeback is
still available.  Keeping a single gfp flavour in the helper makes its
semantics independent of the caller.

Fixes: 130206a615a9 ("mmc: core: Add support for cache ctrl for SD cards")
Cc: stable@vger.kernel.org
Signed-off-by: Xiaolei Wang <wangxiaolei01@kaihong.com>
---
 drivers/mmc/core/sd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index c763efb10f64..88d0ddfe007a 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1041,7 +1041,7 @@ static int sd_write_ext_reg(struct mmc_card *card, u8 fno, u8 page, u16 offset,
 	struct scatterlist sg;
 	u8 *reg_buf;
 
-	reg_buf = kzalloc(512, GFP_KERNEL);
+	reg_buf = kzalloc(512, GFP_NOIO);
 	if (!reg_buf)
 		return -ENOMEM;
 
@@ -1335,7 +1335,7 @@ static int sd_flush_cache(struct mmc_host *host)
 	if (!sd_cache_enabled(host))
 		return 0;
 
-	reg_buf = kzalloc(512, GFP_KERNEL);
+	reg_buf = kzalloc(512, GFP_NOIO);
 	if (!reg_buf)
 		return -ENOMEM;
 
-- 
2.34.1

