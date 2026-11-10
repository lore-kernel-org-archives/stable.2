Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794281193;
	b=T3oNENX7Ey4cUcPreKhEtIAAgVHvp2jpSZlQmwd6f/TbTKduCR2DLIwOt81q7yRg47CA
	 RUBCH8XD1RgiURGwLIrHlupy8Grwh5vus2J2nfHGQwYa0Lkg30TNsu7j6pGNv6GHJNpX/
	 b2BC9b5pSusZVq43wtrHjGnFw6kCfqTapEsoNLST/JKyC6JFyuqF9eXEJgMcBRUuMJ/Lv
	 QklBtETwtlsIdEEShrwSOKoF8F5xDj3WsYLonvjIoh5ilWWilElPWLDGmzKLtlWpnJQ8/
	 HQR7LbOH2D94LWI8Asis/O1ecxpraCgDCeKx5aXx7gX5+UEe9aTM0EGTKMVd1noRVdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794281193;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Gw4ngtjzDx+Wqj7UMYuMZoLRKuX3luQ1IiC3EF1ktgA=;
	b=VK6Xy94agsLmhD+k3asKzhFNBtAYDn69eick5g7bT72/sQO0sDybk7FS7Ocbmtn92hMS
	 mnSK4gSMb6jcJ5slu/9haUK0eh5+r9EXthWyHSSv4Wm+qhz9OJSsYtfsDXRpkhfhkZsLR
	 gXyAq+UWOx7yeaSOjQXvCfZpNI0AxyT1+sm4x9N0lufIERuaQeYlWIQILC9pHC9gCFJO5
	 KE3VANQqPOOi2VZvM0NMtwnFaH1l6UY5WeWhERtrr5u5HEW3C8k97jB9zjD0NoddeRlvZ
	 piexe12gBPOrwIih09ZKZmvqhUaK9TWu5lgiFiROLB54U7HN0Zc3A+jKHe87lmiTbtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UT7fl5dt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BAB606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UT7fl5dt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9ECB1F0089F;
	Tue, 10 Nov 2026 03:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794281193;
	bh=Gw4ngtjzDx+Wqj7UMYuMZoLRKuX3luQ1IiC3EF1ktgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UT7fl5dtkmXaDSiFWMZUMGIVmKvkb553e+iF0rF3+LsH0MC3rgf/rkd3PRFPbu99a
	 Saa0OwS7GSk2JmpbyT5FTeTXgIRaZd3etr7nqS1Yqn0g2R4TAU2yKFUYHNiSF6wb0D
	 DShhwmgbGid0WFtfrD7sCr8QwYEM/wIV/hNIW9969qF7ajBIk9qRJbOHqlJ40nUerc
	 ZHwkL63lpGtTXiVZRdSOXeMC8WIkvrIGnTpK0xpnAB4HFTJ4HyUJ4RDTrvuDPhMczc
	 byd2ZBxpoIWetkYB726UXutnXBihpoGvuk2ozOHWh7Y4hSaxRqBEoeidWmaHEgMKx5
	 9i4L+mKiTEMQQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] media: redrat3: Error path leaves device in transmitting state
Date: Mon,  9 Nov 2026 22:26:31 -0500
Message-ID: <20261110032615.217201-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055718-failed-5.15-8024d5e84531@kernel.org>
References: <20261107055718-failed-5.15-8024d5e84531@kernel.org>
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
[ sashal: Adjusted allocation context for kcalloc() instead of kzalloc_objs(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/redrat3.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/media/rc/redrat3.c b/drivers/media/rc/redrat3.c
index e0a59a2b0f995..f095ad8d74370 100644
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

