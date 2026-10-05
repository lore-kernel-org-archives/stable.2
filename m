Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D79472521
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791194699; cv=none; b=gRRde8dDsQHCdkZ4FQdwPrc8Bmk3+9dlG/W1P6B8eI4MNnGeqm+FWfCCEwRjGD14sA/KUZ5hw/TNOUeiEDGB67V3iI9Os5v12S6OjxCExoEy6BuyRK6GfOtdCr2VUJapvO8ttqLGLYDf2QqM7VfsmgnZwHSzSt6lujpfnjJEIEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791194699; c=relaxed/simple;
	bh=V4f/K/Gnk/Z8OVIaq6Zpt4Non3+0kQdnB7k+cIA+TA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aMWc4nUorAy+2rms5wZYICOkW+Q0IVzav2C6FMEjF/ngv11iSzLC3u1ikJBebOqEYDIoqvXezrIHz4PKEz1l3lrhYOM+ddk/t1cFJXkVUZKrCBzkpnLEx4uv3BexQwJMk/WeP1O37knJZg+BUfn3hMDHHdO8uVI9LTRX1Oj9c6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OmrgNyPO; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OmrgNyPO"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DF2811A1176;
	Mon,  5 Oct 2026 10:04:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id ABA5D604FE;
	Mon,  5 Oct 2026 10:04:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BE5EE103306CC;
	Mon,  5 Oct 2026 12:04:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791194690; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=fVpBYsXmVA5NBWB0gWGRojHkpJX3RwWJ3gjajsOdKJQ=;
	b=OmrgNyPOVZj81RVXkuRvREAzl/uvGKvX77+1gse4ENETKgJDi0yPU3TeyxW5cUE4d5fnGe
	A+JKI/vesJDp/T+/9CU0gBjIG929MPwlBm+AHf1vI5k+nu+wMJ9cTBzNqZH5ZfEwa426Zk
	07VUBhv6WTrNjgivEaNiwvwqhjRFAmuR9gdYB3wsGlzHhK8bXNgazui3G2anxYnr8pQen4
	Dc1LFOZk6eusq2yrS6pfli8amYsF35LhGJKr1+5qsIxnE4Xp6EMoCmKTjTHToR8KiyQRZv
	UsuQjjagUB06Nv0oY20AZNymHQyuWZoQHSbmRNwbH622pytvC0/tIta1Ww/+PA==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Mon, 05 Oct 2026 12:04:33 +0200
Subject: [PATCH 5.10.y] loop: Fix use-after-free issues
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-cve-2023-53111-v1-1-d844a2fc5e57@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CMBCE4Vche2ZJt9hKeBXjAeqg6wFNi42E8
 O5WPX6TzL9RQlQk6quNIrImfcwFUlcUbsN8BeulmKyxXoxxHDK4oGXXigh38AOmoz90YqmcnhG
 Tvn/BE7lGTLPS+b+n13hHWL412vcPfgwvjHoAAAA=
X-Change-ID: 20261005-cve-2023-53111-8e6aef764812
To: stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 Dan Schatzberg <schatzberg.dan@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Ming Lei <ming.lei@canonical.com>
Cc: Benjamin Robin <benjamin.robin@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>, 
 Ming Lei <ming.lei@redhat.com>, Jan Kara <jack@suse.cz>, 
 Sasha Levin <sashal@kernel.org>, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791194683; l=2740;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=3J3ULDIaQHTyYc9Lu+HeWPvp/O2decHG7gb4ZyGY2zk=;
 b=YS0cSVRrDOnYT/9q6tL57bC3wcTaTeKvYga7g+yYHHrX8eWerRBWCJImhjj5lacaHX4/987cN
 AIJtZVhEhh2AuUrmJCyyWxt1N/Nz8SCjSA0lQQOq+1aU5ksSRfhHNju
X-Developer-Key: i=miguel.gazquez@bootlin.com; a=ed25519;
 pk=k/2KI9jkmayaF0ghZ8QYUH9Wm/kFHDhl8QoZ0RHbr4w=
X-Last-TLS-Session-Version: TLSv1.3

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit 9b0cb770f5d7b1ff40bea7ca385438ee94570eec ]

do_req_filebacked() calls blk_mq_complete_request() synchronously or
asynchronously when using asynchronous I/O unless memory allocation fails.
Hence, modify loop_handle_cmd() such that it does not dereference 'cmd' nor
'rq' after do_req_filebacked() finished unless we are sure that the request
has not yet been completed. This patch fixes the following kernel crash:

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000054
Call trace:
 css_put.42938+0x1c/0x1ac
 loop_process_work+0xc8c/0xfd4
 loop_rootcg_workfn+0x24/0x34
 process_one_work+0x244/0x558
 worker_thread+0x400/0x8fc
 kthread+0x16c/0x1e0
 ret_from_fork+0x10/0x20

[ Dropped the part fixing c74d40e8b5e2 as this commit isn't included in
5.10. Kept the part fixing bc07c10a3603 ]

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
Fixes: c74d40e8b5e2 ("loop: charge i/o to mem and blk cg")
Fixes: bc07c10a3603 ("block: loop: support DIO & AIO")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20230314182155.80625-1-bvanassche@acm.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>
---
 drivers/block/loop.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 3db4dad0d072..dab31049bd4f 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2032,16 +2032,24 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
 	const bool write = op_is_write(req_op(rq));
 	struct loop_device *lo = rq->q->queuedata;
 	int ret = 0;
+	const bool use_aio = cmd->use_aio;
 
 	if (write && (lo->lo_flags & LO_FLAGS_READ_ONLY)) {
 		ret = -EIO;
 		goto failed;
 	}
 
+	/*
+	 * do_req_filebacked() may call blk_mq_complete_request() synchronously
+	 * or asynchronously if using aio. Hence, do not touch 'cmd' after
+	 * do_req_filebacked() has returned unless we are sure that 'cmd' has
+	 * not yet been completed.
+	 */
 	ret = do_req_filebacked(lo, rq);
+
  failed:
 	/* complete non-aio request */
-	if (!cmd->use_aio || ret) {
+	if (!use_aio || ret) {
 		if (ret == -EOPNOTSUPP)
 			cmd->ret = ret;
 		else

---
base-commit: 587461ddf5d522bfcb50ebd55078c0dac37be496
change-id: 20261005-cve-2023-53111-8e6aef764812

Best regards,
--  
Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>

