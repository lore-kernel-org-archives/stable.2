Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543CF31F9BA;
	Thu, 25 Jun 2026 09:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379276; cv=none; b=POS3v9jydhcFMVi2b5+mp21HerDYeZHHYEHNOehJBMEbMTZeRQDi6ZKFgluo0KP2SM0tEinx6WatHYPtxZRZ6kxHjjgQhnBiDpdFynFyuRlLLSTKzFQJS7dFfFr/sQYG1Juo77lYgpidnt97uCy774be6ycDDsDdZCsmOEEFrSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379276; c=relaxed/simple;
	bh=NujA1wfsAVj9+8fMtwK0GLvBLjFpYWx6bls65f4X6Zk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UEjDFnH/AvHGEFhD6yhOusJqZwkWDvaKZjJ6BPBk1tl34MgNcQrNiZVc2BwPlm75vq5r8JVuT3cgX56zJpbSap2X4PNtOhgdJiXjfCMY3VkJORpzrU13nkcfRxH7vNc3MFpAoqwSFCixg3OMZIrB68hnG/4ZK98SjndPfqaLWpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-03 (Coremail) with SMTP id rQCowADnvJME8zxqJgrNFQ--.7731S2;
	Thu, 25 Jun 2026 17:21:09 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] block: Fix dio->ref leak on integrity error in __blkdev_direct_IO()
Date: Thu, 25 Jun 2026 17:21:06 +0800
Message-Id: <20260625092106.47695-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADnvJME8zxqJgrNFQ--.7731S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ArWfWFWxKr4kGF1kWr13twb_yoW8AF4kpr
	45Ka98AFZ5X3WxKF47Aa18ua4SyrZ5G3yDWFWjyw4Sk3s8Xr10vF40yr1YqF18CF93GrW3
	Xrsavw18AFyUAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUehL0UU
	UUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwsJA2o84ARTogAAsF

When __blkdev_direct_IO() splits an I/O across multiple bios and
bio_integrity_map_iter() fails on a non-first bio, the function jumps
to the 'fail' label which frees the current bio without accounting for
the dio->ref increments from previously submitted bios.

The in-flight bios complete normally but their atomic_dec_and_test()
in blkdev_bio_end_io() can never bring dio->ref to zero, leaving the
dio structure (and the first bio it is embedded in) permanently leaked.
For synchronous I/O, the waiter is never woken, causing a hang.

Fix by matching the existing error handling pattern used for
blkdev_iov_iter_get_pages() failure: end the current bio with an error
status and break out of the submission loop. This ensures the normal
completion path properly accounts for all dio->ref references, both
from the current errored bio and from any in-flight bios.

The NOWAIT error path is unaffected as its goto fail only triggers
on the first iteration where no bios have been submitted yet.

Cc: stable@vger.kernel.org
Fixes: 3d8b5a22d404 ("block: add support to pass user meta buffer")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 block/fops.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index bb6642b45937..9f16b995c60c 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -239,8 +239,11 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		}
 		if (iocb->ki_flags & IOCB_HAS_METADATA) {
 			ret = bio_integrity_map_iter(bio, iocb->private);
-			if (unlikely(ret))
-				goto fail;
+			if (unlikely(ret)) {
+				bio->bi_status = errno_to_blk_status(ret);
+				bio_endio(bio);
+				break;
+			}
 		}
 
 		if (is_read) {
-- 
2.39.5 (Apple Git-154)

