Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DE7497392;
	Thu, 17 Sep 2026 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789658571; cv=none; b=DFxwmNOX4785/oJ09NDpb99sbyxrbYl/SYInrvSdnFdDHBALzyzGI6KUAcSliMgzZfbiYDI0wDONArydK4hOxl/yePgNlGk/Yy5nSYnvrlCKTs/CuxJxfC5JCPjuIvNC8s17RnAcl0P1uCC9BYl3VVZgOu3ShA4RcMdbnYKteF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789658571; c=relaxed/simple;
	bh=EahuWFjx9wFIrRgh4K2BjyJnsqfwU21KdyA8yyyh+4c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=beedGOGWcHWXU+asFpLiwOwj4bobfXdyNb8VdmGP2BT2z2gHabgdYx1/17OKKYSccppZeV8cN8Uzxz67Ko3zVI+lNjxD2L1/FbuxGrWC+NhyJHu58mXTE3WOUBxoQQIGo8c3loG4I7FcXdNvx5vUddnHAA2SfCWYa95DrhqnIc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADnVD+6BaxqjXODCA--.5729S2;
	Thu, 17 Sep 2026 23:22:34 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	srini@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] slimbus: messaging: Fix runtime PM leak in slim_do_transfer()
Date: Thu, 17 Sep 2026 15:22:34 +0000
Message-Id: <20260917152234.2158902-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADnVD+6BaxqjXODCA--.5729S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr4rAr4kJF1xJFyxZrWDArb_yoWDArg_Cr
	s8JFnrA39xWF17Awn3Jw13ZF9I9a95Xr109FnFvFW3trWUCF45Xr4DXrn8u3srXayUtw13
	Gw1qy39rAr1SgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbS8YjsxI4VWDJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2zVCS5cI20VAGYxC7MxkF
	7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr
	1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6x
	kF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x07UNTmhUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRINA2qr9LYo8QAAsP

slim_do_transfer() takes a runtime PM reference with
pm_runtime_get_sync() before allocating a transaction id.  The
slim_alloc_txn_tid() failure path returns directly, skipping the
slim_xfer_err cleanup that drops this reference.

Jump to slim_xfer_err so the reference is always released.

Fixes: d3062a210930 ("slimbus: messaging: add slim_alloc/free_txn_tid()")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/slimbus/messaging.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index e2dbe4a66b70..ee127ef42046 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -139,7 +139,7 @@ int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn)
 	if (need_tid) {
 		ret = slim_alloc_txn_tid(ctrl, txn);
 		if (ret)
-			return ret;
+			goto slim_xfer_err;
 
 		if (!txn->msg->comp)
 			txn->comp = &done;
-- 
2.34.1

