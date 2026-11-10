Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280517;
	b=PT91U9oJ0ngXOUEEz6duCZALKwIERV1TAGEcttwXcyr9CAahFpMOJHo60upW/rdt2ll5
	 hvmXs9emZkMR7TDD9dm0cOProsNR39Nw7gwOzEyAwSnQYCkZxtJLungmvJ4I3FXtnJdVB
	 BExXyqjGX/1aFnFZY6AynKq/WPf+SqiVFHZhlR5hWvAlG1qb4TdY6mOjuxo3xfrFYi+Bg
	 /SKVd0uXFLGNCHpmEzjqKe9tML8tmM3H0guvMvf/+5rbgdJR6hzluCbY6IqKfbnNYPdOh
	 ykZZLeJ06Ef4IKzPNMoA/1yB/fQzCUpE+dtQ1CiYgGv6wTw08nVIAVIwHE5zgvVFP1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280517;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pm47RpqTbEVY+iXyfD/eT2OCUBtGuP44o9pD/ldxKwg=;
	b=iZCXbU+L9byKNX81q46RDcLMHlasoESAu2ks2bGPW8+6pdhqPjZc/XLeE80uNbNRtvgQ
	 9XkyKPiPFtRHmE/wcw9nkADGKKZhVM92H9R1Ycri9azhCRfX8sEde/NNIHFIbq39i7aGM
	 ePtdDYPQzn1JHpvQqrz3vRKRLArKf+jB4k2SSIp9V5aKECIeSbWR6N4wpCapNdb6gdhu2
	 xR4cnhhyaJt7xCzk62TnY8oLLzhiW6Ga2LZ4DWP/RnCcj/XBc7kLj810FKpuNej4EwmtK
	 tnT3oUt1meInjQyv6XZQ9O6n4mVfRuxEi3qTg19tndfoGHlGTTdCb9Tav4ndTE8OPmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aRjiUw79;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA828606A919
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aRjiUw79
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56A71F0089F;
	Tue, 10 Nov 2026 03:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794280516;
	bh=pm47RpqTbEVY+iXyfD/eT2OCUBtGuP44o9pD/ldxKwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aRjiUw795vBcakNclwSQDkII4zW5rL3zgX8MXJIHmV0Dz0MXQ9pZ9eeODSJMoVEdL
	 LKExK0IpURXJCLlya6Xeu2v64Ih9vsO+Wk1Br4z05cAVVTcVtxtEb6axLXAyKpdbaZ
	 Ur7285n4Zn3ksoEHx6i2nCnPccL9juiu0bqXK/pAZyef2aCxcxUdDmmvP+08OiZCna
	 MlgfUBzha/9DrjIPzN2BgnUlEfznrVmvS68RavjsC60mzAJOeQpPtE0vGaY6cHXIP1
	 xIJiJND+x43Qzh3XF13CUJtt13PfXI4CiCu0IWr7uXykVCmvyFNqlnpjbN6NCiJf20
	 K9atdPTRu/7wg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] media: redrat3: Error path leaves device in transmitting state
Date: Mon,  9 Nov 2026 22:15:14 -0500
Message-ID: <20261110031502.164815-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052818-failed-6.6-8024d5e84531@kernel.org>
References: <20261107052818-failed-6.6-8024d5e84531@kernel.org>
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
[ sashal: adjusted allocation context for kcalloc() instead of kzalloc_objs() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/redrat3.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/media/rc/redrat3.c b/drivers/media/rc/redrat3.c
index aa9242bc604b0..e7407d1ed9dca 100644
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

