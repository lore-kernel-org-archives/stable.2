Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049041;
	b=AdJF1QhrdaKzvn1OIPzizQA0q9r7sLpqiGNyS/9fDRXcYJxSWImVeBiZ7KFOdxYKMwQ2
	 fGvehZxdJowtEfjbYb/vXJ6mEhX6BxrfNqyJccWpPo4wYDW4tfyDJHlefvO6gmpzijiCW
	 SEr9a9Ko64AilJNHyvIqCG1aIHMM4xM0ljesQK01ztOj246jrHDvYFbSi3Cxj0l49iNcy
	 fz+qvxM2Kn00ir0tdhUewgi8k4Z1I9k1HdBiLKOagBuCs4s6G27XyX+NXlBkPqCTKeK/s
	 dn9DW8Yuh8A72cLae2ei4DMTSNJpuDDOL6U1zSpDHJlNG58ODUJqSj7fr4C7ojDVbZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049041;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=mxuQ2wYqPN758ePggf64liLw53xMPgIcn9WIZmOpOt8=;
	b=nXvTonQu5AycFMtxzNcN4aGbh3cSS//BDolMm4wh/riFBAK0O6Q/gsiAcUi28oxzwu+L
	 mnQYBbTueZVR0npRrh/ODonL3rmlO8jDp8Yy0aiCWLjAOV4D9+awCFcBa1zf1QapLk/6+
	 +eyjJQSLJK89gRkWYG+maPOYRWTbseDVP65XC93DBZD42W50UZIDN7pNq9ofBfsyYioH+
	 LcfMHCNhMKRRo9dsNqgT737dTRKxNBsnEYScIq6G8Y95jHQ6GoMc+zmKWSOdgnpqtR7Al
	 PFKugG/xRijRs7uGuTAxUlgNdpSzIXxhprgosjDjHtdK0EOD+u6sd6MGkOoaJYh+LLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mrs+sMaP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C00606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mrs+sMaP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD271F0089F;
	Sat,  7 Nov 2026 10:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049040;
	bh=mxuQ2wYqPN758ePggf64liLw53xMPgIcn9WIZmOpOt8=;
	h=From:To:Cc:Subject:Date;
	b=mrs+sMaPFFqtQcC211aa4tYtJ9DxGvEAeQVVbm3I05N90JN2erFuMRKPy+Na5Co1u
	 cXzfx6sLT+iKw94tLSjBnFbTAVcAiK5oQAIRHDn00fgg2+sdZSGhK5chC1cFvMB2SJ
	 VdFitHkpHczVjADnf3K1m8bv5xDbh2VfcGPU/r+0BJTgya6vUpkRxLIVi5IvBLY3Kb
	 S3ymIQfLInZRF6lLtSgka7d2sCMF9PP0J4+aDLnyQMnxrQ45HOudhhIgjhzS7HnnzU
	 G1usX+4nLNLu1YpEX8cUa6Oz4KxZ8e7P/DQQIPwQY5NTVo5jx9lsy/dnrHBmiQchqA
	 ckxNnoOVRxopg==
From: Sasha Levin <sashal@kernel.org>
To: sean@mess.org,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: redrat3: Error path leaves device in transmitting state" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:57:19 -0500
Message-ID: <20261107055718-failed-5.15-8024d5e84531@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 8024d5e84531d828535365718278f1cf0ce67db0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055718-failed-5.15-8024d5e84531@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8024d5e84531d828535365718278f1cf0ce67db0 Mon Sep 17 00:00:00 2001
From: Sean Young <sean@mess.org>
Date: Mon, 13 Jul 2026 13:08:40 +0100
Subject: [PATCH] media: redrat3: Error path leaves device in transmitting
 state

In the allocation failure error path, the transmitting boolean is not
cleared. If this error path is followed the transmitter cannot be
used again until the device is replugged or the module reloaded.

Fix the error path by moving the assignment statement.

Remove the check for the transmitting state in transmit, since rc-core
ensures there is never a reentrant call to the driver transmit function;
the transmit function is always called with dev->lock held.

The transmitting boolean is only used for interpretting firmware errors.

Fixes: fac59136bc22 ("[media] RedRat3: Return directly after a failed kcalloc() in redrat3_transmit_ir()")"
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
Reviewed-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 drivers/media/rc/redrat3.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/media/rc/redrat3.c b/drivers/media/rc/redrat3.c
index 30111deb6013c..b07ff832a938c 100644
--- a/drivers/media/rc/redrat3.c
+++ b/drivers/media/rc/redrat3.c
@@ -773,17 +773,9 @@ static int redrat3_transmit_ir(struct rc_dev *rcdev, unsigned *txbuf,
 	u8 curlencheck = 0;
 	unsigned i, sendbuf_len;
 
-	if (rr3->transmitting) {
-		dev_warn(dev, "%s: transmitter already in use\n", __func__);
-		return -EAGAIN;
-	}
-
 	if (count > RR3_MAX_SIG_SIZE - RR3_TX_TRAILER_LEN)
 		return -EINVAL;
 
-	/* rr3 will disable rc detector on transmit */
-	rr3->transmitting = true;
-
 	sample_lens = kzalloc_objs(*sample_lens, RR3_DRIVER_MAXLENS);
 	if (!sample_lens)
 		return -ENOMEM;
@@ -794,6 +786,9 @@ static int redrat3_transmit_ir(struct rc_dev *rcdev, unsigned *txbuf,
 		goto out;
 	}
 
+	/* rr3 will disable rc detector on transmit */
+	rr3->transmitting = true;
+
 	for (i = 0; i < count; i++) {
 		cur_sample_len = redrat3_us_to_len(txbuf[i]);
 		if (cur_sample_len > 0xffff) {
-- 
2.53.0




