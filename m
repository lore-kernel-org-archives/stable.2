Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279938;
	b=vVoW1n+/+B3Zzbd41CrAAqdmFr1LXHQkihha6Ad1SCbSJb2VGvZaUZp70ft+vsSxxfTc
	 RratQ1onD9ZcadANWPL9Xl8bDEBJ67iTMdmNvFwX83+4VvQMlZ40j7ol3rVTG578f3hse
	 Rsj9DUYyxG+DLjXYadSopsC2tZCkJFbh123b9OWAt3/Ef49tOdN+7MR0kyHZTon+N6EQ3
	 /CCP+lRqIcPicxYR3vFauyGVXCDY+94zugbkqyoBv5g47OVkVH5D4DkIi8gLJR4LDs9YQ
	 t5Oz18k1YypjDZP3kzsDDRtfqqlXvCWIdrJyjJbRYZh2pp3EI6IM1pMq+sOeRpFW62w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279938;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=i1aKEkTKMZ2nOK8MAnNOUMvTOEnNWjW5ohh0lOfpqt0=;
	b=5bax9A6RENKJtgVr2rmaxRIU/qMGhboG9MMSqTaRODn076XFUxNR5NcXAdIvIkitSNVv
	 EAjEqjcqw9BEplGRP/JZ9PPoYZoR1qzsb51LbdUAi3HuFX/m4VC4/mgdB6/U51C9/SYwf
	 ddWO/ThozuZK/zDTr1m29kGIkL1MCzBaelv8+Si4RfqaqAse3FjjoOGEEbACDT49cyYR+
	 OH2fg+n8pXCOlclSvHhtoS6QShSikzca855f+52fnynI/9OEF5NRsVnI/DPfVdNviCb+w
	 TczlCa9G0FzG7yTeuMwMajVKQDCUqaswvO8FvkH1MxoQK0JMjiFwRP9NApWccvY4JIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fLVbIApa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6955F606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fLVbIApa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B4A1F0089F;
	Tue, 10 Nov 2026 03:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279938;
	bh=i1aKEkTKMZ2nOK8MAnNOUMvTOEnNWjW5ohh0lOfpqt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fLVbIApaUOhhjBK10tk28vZvpOrk2lUh0rl6DQ1ftp7G2V/ZjQYJPOD4zzaftUmb1
	 zSNO+4XdK3idiYkal39VSW8s/Ve81zasSJqVXOvrdEa+856ichN1zKwiK7pljtbGeN
	 FaEZe1+qJwmpOQNW9f8ukP0aJ5XCpYEzPLbb+TChPHRfMqkODMC1PfGBzp+LwCI40z
	 9AZ2XeIZSzIsS6rXIVXQWHgEwft2V+GMRoyUy5leXdU5pD5rt6WfiiZj8lag94OvTX
	 L9xeXO3zbUdL/v5AXqKCBnsm0A0ENEdDF2yOcZaUyEaTdfpfFEHkvxh0eT09bRVgMi
	 JdeYgCDI6wMdQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] media: redrat3: Error path leaves device in transmitting state
Date: Mon,  9 Nov 2026 22:05:36 -0500
Message-ID: <20261110030525.112272-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051623-failed-6.12-8024d5e84531@kernel.org>
References: <20261107051623-failed-6.12-8024d5e84531@kernel.org>
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

