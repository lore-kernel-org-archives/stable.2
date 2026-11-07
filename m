Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047300;
	b=de+OQhVXkSdy4tIui76YTZbPv9c5lRL/hMyp7d3Gco7+RKr/S7vhShPxy0MBqI/PCxuX
	 5YPLSfV9nNdK8puVgxcbZroyjWgzF8hLCeJwPR5mMwJMf0NYU9BWCwd9CMrw69kmfDk2P
	 4boc2Czrwh82yfQ6HPcbtVs9fx0NIKcW+Gj/6r/24no1U+g8ioYWrduSbPxxZ96oaO2Uu
	 MM5a95DvA6WKGvhZXLGCnF7Ha2u770lYWf6hV8Zypnfs9r1NIIiLi+ovr58Vo2jy4Mlgs
	 y9R96UK5G88DqAp7gxS4tJNiCQkrtlB8muxecmm93yM5j/0rtJ6CviyCaqoOXJBkoMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047300;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=LZzjPHKzfBBpwugH+JfvmFL+G9gfAF1ffmEVf4xAj5A=;
	b=dpa+3rknw2WTWpIqA9N3nljZ0PmGsmVGNL/Q4tNHZPutY0mHmEvat0D0FeEQBSqiFr56
	 /wqD3uOlZP+ztQyeKNbB7ojJ1TgUPvBx9euPFclvRiiBWZDHmuvO48+Otfp+RVId3Cse0
	 7k1RUidHQCFOWP9MGdaVPGZZmsGxI3hgA9RDcVGF4Y8z8G4Cw8vWUrRRWrcJ1j4RQFxC2
	 6zbxl9WL9Q3CgISbKYw/VD+vuGyx+a5j1AXauPNop2+C1XYdsLBD1RhzGWeuiX8sdAYBr
	 Jc5TRpt5+0epPso2vzFmlZr61evyH9OQTT3j0STnPRwbqrVQq8JynCZi+zLNo5HszEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LE9xL/1l";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42492606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LE9xL/1l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12BE1F0089F;
	Sat,  7 Nov 2026 10:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047300;
	bh=LZzjPHKzfBBpwugH+JfvmFL+G9gfAF1ffmEVf4xAj5A=;
	h=From:To:Cc:Subject:Date;
	b=LE9xL/1ljTSKimqHsWFusrMHTfh/hTl4uWpWRcu/uBMjqs9Z8xOybT2keDff3Tw5H
	 D89/Tw5bgV5nERp9v58grzrz5EbDCxKV7UcNl97UtPoJT3mL2mn673Ne5O+5lnWlt7
	 hG5u98Wjs2C0sJ081BcCX8VwTrx1Spj2wCnOr8ShwKf26myG8B9NTNXTuO3Idxv1q2
	 B+QR8RC4zGV0qOUXzW4U1BszmRBA+CHtbhnT9Vz3McC+d2OeETwhl0A6bw+xFKYiHC
	 hansLCOWBvQfdBzQFE8qL/NKPQw2jxrQtjlxQyw5a2n4Znnt1c8/e7ZjcVuSHIxm1r
	 dy4DkG58c6FtQ==
From: Sasha Levin <sashal@kernel.org>
To: sean@mess.org,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: redrat3: Error path leaves device in transmitting state" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:28:18 -0500
Message-ID: <20261107052818-failed-6.6-8024d5e84531@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 8024d5e84531d828535365718278f1cf0ce67db0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052818-failed-6.6-8024d5e84531@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




