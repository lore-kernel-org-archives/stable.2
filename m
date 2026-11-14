Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794674036;
	b=2LAD12IyPv5kfvG4/7k+AsoEEky5j7dhqgvMXJ0Kar+vgA5IZkXI6CYT5eV8mRmOyY0z
	 wdazVz5SK87M9gbKQl9z7HVl6LVz3ThgJQ1y51LdomonQ5Zeuy/faP2IiIiKkgysq8EdK
	 Uvzush/7Q9JXY+l/Dw8epcp5g32rP4Ej4h5gmvsSjfM93YQO4FxJ4w4aNriBhhBi6o2PK
	 qe2XHmGXsqzlN3Iegb3NitrI8Q7NIAp4qQuRGukmNJ1oujAUVqDj53d6zFO5LsctkrSEy
	 J0+UozZjNKD8lTGERU+hznWodSApych7shUH4bJdZ7urQ5WMVopQluaSeYtQwY2pdPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794674036;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=L9ZradzAwO1zQAENGExoJrWKxMjcauMXjqXObbjyWo4=;
	b=X3jLmy84SDW88DNg4XSTJ5TY14tMIfHQa7SJFjk1rg7UXimknUvIsKpSc4nReiy90xwj
	 WUSUxxBiFUeWBXobi2Bi5w3Ni7FY4RgQjZUaMdX7po0YA8i6kmXeNshcyUtyiX/GrOoWD
	 Fxz62juiyYVqaTwrXjQ3CQyePsSl6LYfgCBt/2+Zq6wxXAAHFrZ/svOXTxrmjgXXT/an0
	 yUKimpulaps4iYCHNiwNkIqBJDdHS3YAdNEmULk8MMbUUPfHevpkP309Ke6+seO3laAog
	 +QkEWxfO4DdqVJOurA7rcUDoAZUYFXds1P+sjVXVTqPURpGTKZOGzEXqw8BKC/ZIaLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=KJNUVcsC;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197DD606A33E;
	Sat, 14 Nov 2026 16:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 197DD606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=KJNUVcsC
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jRfpB603Qz5BNRx;
	Sun, 15 Nov 2026 00:33:54 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794674034;
	bh=bM/vbRRrJY0G3M1hBhy9INv2M4mCgrIGctSPzSG4asA=;
	h=Date:From:To:Cc:Subject;
	b=KJNUVcsC0sHI9IT6ZvwaegDUd7zVRpuL7VFSn1p38AvaHAR89QROWNZuH1X27upOg
	 6lmpCGbaWEwT8qKe/HCp4C+7BFw7G08xOsdiQXBhTTNs/CRRSXuS94LHeS/mSqB30o
	 WYYOy4QMtg9eTGKICFfbW+Rdf9L1BgrmOFuD78vIv+IVYKF9Wh2yai6a1VAx9MJFC3
	 4eWHx//axZI3hyOuLvG5ynA37/uCmO4499T2wd3uoqyKlnh58JOMuVg8YZ/k2RVHqG
	 l2euEg1Ftf/HPGoXENC3iSph9vdCFi+e6Y7vM8qR8bQq+UGWPnbk+CuE4sqiN+0dKJ
	 F3CByr1Misl/w==
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 6AEGXmlo085736;
	Sun, 15 Nov 2026 00:33:48 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 15 Nov 2026 00:33:52 +0800 (CST)
X-Zmail-TransId: 2afb6af88d70444-2841c
X-Mailer: Zmail v1.0
Message-ID: <20261115003352168cE_tyVxSyZV124AM31htL@zte.com.cn>
Date: Sun, 15 Nov 2026 00:33:52 +0800 (CST)
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
To: <tom.leiming@gmail.com>, <linux-block@vger.kernel.org>
Cc: <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSB1YmxrOiBkaXNwYXRjaCB0aGUgbmV4dCBmZXRjaCBhZnRlciBhIGJhdGNoIGZhaWx1cmU=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6AEGXmlo085736
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sun, 15 Nov 2026 00:33:54 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF88D72.000/4jRfpB603Qz5BNRx

From: Shao Mingyin <shao.mingyin@zte.com.cn>

When a batch fetch fails, for example because its provided-buffer group
is empty, ublk_batch_dispatch() removes the failed fetch and returns.
Pending I/O tags stay in evts_fifo even if another fetch with usable
buffers is already queued. With no new I/O or fetch submission to select
it, that fetch and the outstanding block requests cannot make progress.

Claim the next queued fetch under evts_lock before completing and freeing
the failed one, then schedule its dispatch in the proper task context.
Marking it active before dropping the lock also prevents cancellation
from taking it before its task work is queued.

Fixes: a4d883755399 ("ublk: add UBLK_U_IO_FETCH_IO_CMDS for batch I/O processing")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on next-20261105 in an x86_64 QEMU/KVM guest (4 vCPUs, 2 GiB)
with CONFIG_BLK_DEV_UBLK=y and the in-tree kublk batch server. A test-only
userspace change leaves the first fetch's buffer group empty and does
not resubmit that failed fetch. The same server binary is used for both
kernels; there are no test hooks in the driver.

With partition scanning disabled, one 4 KiB O_DIRECT read stalls on the
original kernel after the first fetch returns -ENOBUFS. With the fix,
the already queued second fetch receives the tag and the read completes.
All three independent boots per kernel reproduce this difference. Three
normal-buffer control boots per kernel also complete the read.

 drivers/block/ublk_drv.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 3d322fa1bc83160f51fbd97fb89b17ee94bc1213..6ca62a2ff7453001d005a854f5923e204952adb0 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -835,23 +835,27 @@ static void __ublk_release_fcmd(struct ublk_queue *ubq)
 	WRITE_ONCE(ubq->active_fcmd, NULL);
 }
 
-/*
- * Nothing can move on, so clear ->active_fcmd, and the caller should stop
- * dispatching
- */
-static void ublk_batch_deinit_fetch_buf(struct ublk_queue *ubq,
-					const struct ublk_batch_io_data *data,
-					struct ublk_batch_fetch_cmd *fcmd,
-					int res)
+static struct ublk_batch_fetch_cmd *__ublk_acquire_fcmd(struct ublk_queue *ubq);
+
+/* Remove the failed fetch and claim the next one before dropping its reference. */
+static struct ublk_batch_fetch_cmd *
+ublk_batch_deinit_fetch_buf(struct ublk_queue *ubq,
+			    const struct ublk_batch_io_data *data,
+			    struct ublk_batch_fetch_cmd *fcmd,
+			    int res)
 {
+	struct ublk_batch_fetch_cmd *next_fcmd;
+
 	spin_lock(&ubq->evts_lock);
 	list_del_init(&fcmd->node);
 	WARN_ON_ONCE(fcmd != ubq->active_fcmd);
 	__ublk_release_fcmd(ubq);
+	next_fcmd = __ublk_acquire_fcmd(ubq);
 	spin_unlock(&ubq->evts_lock);
 
 	io_uring_cmd_done(fcmd->cmd, res, data->issue_flags);
 	ublk_batch_free_fcmd(fcmd);
+	return next_fcmd;
 }
 
 static int ublk_batch_fetch_post_cqe(struct ublk_batch_fetch_cmd *fcmd,
@@ -2040,7 +2044,10 @@ again:
 	}
 
 	if (ret < 0) {
-		ublk_batch_deinit_fetch_buf(ubq, data, fcmd, ret);
+		new_fcmd = ublk_batch_deinit_fetch_buf(ubq, data, fcmd, ret);
+		if (new_fcmd)
+			io_uring_cmd_complete_in_task(new_fcmd->cmd,
+						      ublk_batch_tw_cb);
 		return;
 	}
 
-- 
2.43.0
