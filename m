Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046585;
	b=wgotztvrST3mGhFJ0sJty88jNzELaTEqM3fbqBaplRWcscnW8dYJtFSlELsByNTBTioK
	 nnwpWMqYxNoI4iEJHnaDkABe2eXEWGzDiLYZPcxPB/dnsOiFUir0cCYpdqWd3M60OiiJO
	 KhkUJsUiLqoD7wrnVNFd6P+0jJbjwupxiRyCzs4Kusw2/0jSZd07gyFWU0aJMs4Hk5/yS
	 nmQ6I2+BVsU9BxUGoJK8pzUcdrK1b+HuC4mXZ20JrKxOXZkq67+VRAZLyoXyfQsQReNRh
	 w25dtKlk7kNLsXeW7Sqsn1BXJb+JhRmcBKa6vPxcURb7xMlJhdjt+0uXZWhsmUSYC5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046585;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=iIwVyWSjHwndqVEiauJNYWCHqLYZWVYxyfBGRt/HcZY=;
	b=SBPOqzTeaDQVIFQR5EcJw+9bABohxZwD5Kghdqo/0dewq3/LKIG32+K8IIutfzAf2ckM
	 We2njxBM602h1DfMyFxC7s/PkNs2MjEAMUGf3eTNh4Iaa9IvqZXUqzb0OGhigLdVDEkTI
	 Y7S0SqTqWYc9UrjuiXmrjLxuaXfR2XDNdRgTlPXgEonBN99g5bS9GGAISo/BCHY1dwP5p
	 ptfg97HUoI5N8t94u+xB0cCwhb+lr/MlUEw6Gbe47NbX+0po+wAEM6Xqi3dTLRel+ndA6
	 Wk/JmA/+PlsvYqyrvYgiQkk7THiWQvLG/KstXGM1b8FwX1jfRch2lrw5tOCVoAJTrWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="M5bey/KE";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B93606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M5bey/KE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81961F008BF;
	Sat,  7 Nov 2026 10:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046585;
	bh=iIwVyWSjHwndqVEiauJNYWCHqLYZWVYxyfBGRt/HcZY=;
	h=From:To:Cc:Subject:Date;
	b=M5bey/KElWMgfv9IneXEdTZ2MT3JrP0rDyku5YQt9oYdEdeE09Tdmeoq8yupB6dPy
	 KW2uG2pq3+oYulpMWXgGifJh3xm6nfa2kFqp7ONrIPrMQyGWdRCXJ0ZFZlmE7CQWgS
	 OJXIo/DOGDzxw7T4K8eMXwj4mtW0JkncogmYJMLpGgbvmdnl4HLPu4IAHbPpqLhSMC
	 MnrVODe31zwbHPMCrUtwU394vSk+4XqkAYAblQWC71037zJd+yBKoifJbrbyq7erp2
	 IkLJ1DkkcZ8HxnAOLbNwit/4HbGGrcmkYvuS0ZwF44ODcS8uQcXV9hvpjv79X8p7oP
	 vb3fcO1I0ed2w==
From: Sasha Levin <sashal@kernel.org>
To: sean@mess.org,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: redrat3: Error path leaves device in transmitting state" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:16:23 -0500
Message-ID: <20261107051623-failed-6.12-8024d5e84531@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 8024d5e84531d828535365718278f1cf0ce67db0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051623-failed-6.12-8024d5e84531@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




