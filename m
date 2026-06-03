Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3BA3D6CC2;
	Wed,  3 Jun 2026 02:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780452652; cv=none; b=lnK5Zep2YXnLGVLV32IDtLcKaaBkyn2oDSt6Ac/iNCOJq4ObViE5SsFX5lVbLGC2zNJRV3pRwx7tjzpv6iZ+zjF1iIUQES6X/FBLaaE85xdxXSKITX1tmecJCHRsp8WbEMFrQ/bsm5NAZLa28GTAXVszU9A5yQaJUbz7mv0c81g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780452652; c=relaxed/simple;
	bh=GA1ac7NuTO4GpjDs79h2L90K3Sk+9Y04MR7qwVCMw+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jPbwF6C7RJzspSWYJ3Z7aZqu0IK4yQKSQLgO/oEfYGdnLZvpNxI+lcT+UJ6cyNyxlu5yyL5+9CI3K3yiGxBwG+06F+HxssbyC05XhmYYEaMn25ByCDDwJvOtep7XvovMIE7pAw+d6uCf0MgRvdjBfwsUzsc77LtJqj6gKZWaF2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowACnSNEmjR9q4lF8AA--.127S2;
	Wed, 03 Jun 2026 10:10:46 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] block/fops: fix refcount underflow in __blkdev_direct_IO()
Date: Wed,  3 Jun 2026 02:10:35 +0000
Message-Id: <20260603021035.3690601-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACnSNEmjR9q4lF8AA--.127S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZF4DKF4xJFyDAFyUCr1DGFg_yoWfKrc_Gr
	n5Cas5uayUXF4ak3Way3W5ZFZ7uw18ur1I9rnrKFZrtF15ta13CFnaqrZ5Ar18uFW0gasx
	G39rXFW7tw43CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU6Hq
	cUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgsHA2ofeSkijwABsA

__blkdev_direct_IO() calls bio_get() and bio_put() around
I/O operations, but if the I/O fails, the error path may call
bio_put() twice, causing a refcount underflow.

Fix this by moving the bio_put() call from the error path into
the cleanup section that is only executed once, regardless of
whether the I/O succeeded or failed.

Fixes: 3d8b5a22d404 ("block: add support to pass user meta buffer")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 block/fops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index bb6642b45937..4dd1e40c7d4e 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -286,6 +286,8 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	bio_release_pages(bio, false);
 	bio_clear_flag(bio, BIO_REFFED);
 	bio_put(bio);
+	if (bio == &dio->bio)
+		bio_put(bio);
 	blk_finish_plug(&plug);
 	return ret;
 }
-- 
2.34.1

