Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794281170;
	b=CxSRe1tjHPSezuW4xAyBoImffKmfboCfXdTv1D1g4R5e9fGGrIneanyR9OUWMRIKvUco
	 POBdAlYEq2WXIJXnxHLE/GnbeEiCyQQQ5q6NANgi7V5d0so4p9K/YWQsbfCi9k8M9eTMN
	 zd4rLKCOVfx0PWstkNU1GO1vbt81z6Ul5XA2CKTdLReRQ7JMukdgJNPaFsJA4W4VZumEh
	 ellSpvidu9TFx4GfQwPnBE4uEEfHKbi34J5DCgnW+SJipoaLOcpxh6MOGQUGHjyAYjIAH
	 pzbdoNolJK2T3nGJfwSWCfpsJw27eI8p5VGlDLqAcp2wu0JtMPA4V0fIH24Jm1xiwAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794281170;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kM43ha9MXPZNGPlKfW+q/dVuBIXIN/cO8ItScF1xkdE=;
	b=IOSP/jgAIG/sFb8x3VM2WMECynKAWQsB6a+MpeAcfkOdPNWzcR/3QhHZVLiKwiR9Bhaq
	 8deFWhoLjiVjiRFNg2o+JrLMQtbF8COON4AR3zecEB9A2spQ9jd/E/6d60B+ZOOHqzh6m
	 xwkIdN3o9HDDas20MNhE97ykxQnElRnv8vbhzIyXMqE/V86KGmTl3yErvFPpFWCjhwMit
	 RKhxIYbeSDoVvb9eg4SzPUrxp5fJzUpWMNAyi4YtGCexCVjAdqDQNDv5diCMXi6AHkCk8
	 oZG9AoyhgRBIB7EOue6ij0bMVCXpQbQCToeICIkvtmhrRspB+1BS74D24K6t854o9pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N2CiAuOu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5581A606A33F
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N2CiAuOu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521071F0089F;
	Tue, 10 Nov 2026 03:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794281170;
	bh=kM43ha9MXPZNGPlKfW+q/dVuBIXIN/cO8ItScF1xkdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N2CiAuOu4n6/N3dHQTKfSt5NoCTBnrrTVwUBnoFTleW0J6n187W/W1tY6Hass1ZZT
	 07yU8b74Cf98CF++nG8XL4RyU6sRLlkY2lYkiF8K/WXLQQ0uuqLOgu+Lqt1Rcx22cp
	 bmlhOXc4xaxDZH5rqhpIerp0zFZzXR1/uNHKiaMnSAWEasUtwiUmZysdio97fjuOL6
	 F1t6q9Xm1y9dr2X0QGhB9hUUbv8nt2NeVFP/9wOfnZpGCCeEhsdrrp5vkj+v+yTlqM
	 4W3CmlZ3/KhNgllHElemtuMYqcNOSuZlkWyAYTsKcvvbSXybRcLWUkAKJ0rRGbTr5f
	 /zclKlrUxm1Yw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] media: redrat3: Error path leaves device in transmitting state
Date: Mon,  9 Nov 2026 22:26:07 -0500
Message-ID: <20261110032551.207766-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054054-failed-6.1-8024d5e84531@kernel.org>
References: <20261107054054-failed-6.1-8024d5e84531@kernel.org>
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

From: Sean Young <sean@mess.org>

[ Upstream commit 8024d5e84531d828535365718278f1cf0ce67db0 ]

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
[ sashal: adjusted context for kcalloc() instead of kzalloc_objs() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/redrat3.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/media/rc/redrat3.c b/drivers/media/rc/redrat3.c
index db317c6c62fe7..56b28f98a0ad6 100644
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
 	sample_lens = kcalloc(RR3_DRIVER_MAXLENS,
 			      sizeof(*sample_lens),
 			      GFP_KERNEL);
@@ -796,6 +788,9 @@ static int redrat3_transmit_ir(struct rc_dev *rcdev, unsigned *txbuf,
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

