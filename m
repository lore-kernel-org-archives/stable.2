Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279383;
	b=LEH6TXk0y0IcrUXtHbDG21Tz/+pwIMkYvjaibUkotYbr0cysOTScCFpxhKPHBpzJqO78
	 q5Fm0zNOgzJ7TcMHbZaIvRfZuyPAINF7cqc82BMAOYdM1hVAMWEuq/6eUGi2z/VM03EbL
	 TIQXiJgpPnWrF9I1HSExx7GV64ml6C4cV173AumdWElzcqnEbZFVCES5Acoip8/bCzdn+
	 wo4pjxpjfYY7330ajqVXl16Pya35fY6OiOtEuE/QQuif8rBSDzts+ozovoKP3Z6xKe37T
	 PZzlNcYnkfXooiwKJBTv70KugaSai/cBAlxR+eaUOnmAS/nuwmRWjHUo2fF146AWQmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279383;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ocWND8PDJTC4OHBm9+DkYuWE/3l02/AlysT19s7hRgE=;
	b=fk7j9KPtS7K3+x9VeCBT6Z7AuS2eHDD8hLOffGCfmA0cN4Xhx4tVhWEsSqovj0Xt0Ee4
	 sq0VijARhluQhBcQvP3TSWiFNk8l+YWW8F64sSug+QS0nrVJ6yUZ6ARd0FcDQb3L9F+C9
	 vOEfBBNK90tGxlYmNPuBb2X3lBRXXDhvX03y8zgcBnG/Gia/5YQuki8ajcDiLVONw2ji0
	 SUNoO5HBjEb6BAT1655c9m2hIkPnRsJKtK8ANn9/bhrzVU0Lej2oVXeSAPRgwtuI+wChf
	 iFNLc2ioRZD9apQffimoONSsxAjBvYlld/QPiFmvRMBjwD7XPweuDOa68vv7qIU/rJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cpTyZsZZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B295606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 02:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cpTyZsZZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4A51F0089F;
	Tue, 10 Nov 2026 02:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279383;
	bh=ocWND8PDJTC4OHBm9+DkYuWE/3l02/AlysT19s7hRgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cpTyZsZZsMkjsKM+UMT7Gu7YyVOhPM/PTmBpgzgYTAxO+uWgpQbphhhKSADYi32kX
	 p6IYPRYOnrQFSbiQVckPDiH5dfip1BBq78fLLTeUz5PAf0niCpzvKx3Kcd3P8/e1Fy
	 PEg5a2X7bCbXAefhwUYapOkn/KdIodxYi5FWGAFjY6NvXUYnDnKDv2SIsIovPb/V3u
	 9h4tAreuIoiRtsGLLKu1J23L+1JO51Gcq/JCAc9u2mSJavlCUdWRRN5gvPtizmJdYw
	 LhtZJP7oI/mYNzMjU67R6kxquxKV3ecPVSSlPUDYLXgf8MkKAMpADe7k2Z1ns3xCmL
	 IQw4jwjMQnsEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] media: redrat3: Error path leaves device in transmitting state
Date: Mon,  9 Nov 2026 21:56:20 -0500
Message-ID: <20261110025611.3827885-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050608-failed-6.18-8024d5e84531@kernel.org>
References: <20261107050608-failed-6.18-8024d5e84531@kernel.org>
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
[ sashal: Adjusted allocation context to retain existing kcalloc() and kzalloc() calls instead of kzalloc_objs() and kzalloc_obj(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/redrat3.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/media/rc/redrat3.c b/drivers/media/rc/redrat3.c
index c9a5c030f7726..080207aa888ce 100644
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

