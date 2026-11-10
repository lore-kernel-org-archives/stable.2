Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311985;
	b=uPgKlzU9gkuG4XkiLINB+Nh5Xb/i5fAuSa11s+7uQC3v9pRjOCFzLRb/th/R+OE8c9JB
	 WuvnPoapsX3n8o8xEQb3G34ebDh/xPRa+r3w0IXWaaW1S3rjBQxatx5vRq52llD/FqMuM
	 kDIEi6hEQ0b+vHJy/+8/hqUQ106a3TRW8LA5+PpUV802XiCp/jaZvwrqdeaMwulKzuAjh
	 f683zBaYR3hSj4WAXRxjSHhQ16cvQSLi22GlulbJCzbFCobSX01VFL3n309+eWlvBYWmv
	 BP0VdVqksNX+4d3ECA3vMSxalCguLwJ0PhPjA8r+9CFkQbm7jbngSnAj5uXA5ze08dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311985;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GAC1DPdHz/Uq7feVXu1Th3/63UwgoaJgCE09ovKZ6x4=;
	b=OQI8tn1lBktyB2Ps/nlhXUIjQf09rZuMjg4gi/F0Ka54bSFftuXPW+uEdzproi2Lq5cE
	 zY2KHju+PYcLbx0nAh5Ob26zRA76TJYm+CMJvCcR8LIH28qVkYUtFhFz3Ej2YY2FjuGMl
	 0R7mq2bpHnOXuo3BD+z9VgNOZSSWyoRnxsCEUbGNoTIhebCsT1BtokgDngK9Wc4nUqFnF
	 SVnHKrLFv9x0nCnCFXy8wcliK05eEYSnLCcdDHo4hwsXCY55Dl/9YH2te3GasPWiL2ETi
	 KZCvkGx5kN49mx/JIxd/Tgl0iBFWaDXNfxAEiVVFmUS5Hc1B7M6xM0EOui2MyoZi7bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a5GAGon4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E03B606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a5GAGon4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B491F0089F;
	Tue, 10 Nov 2026 11:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794311984;
	bh=GAC1DPdHz/Uq7feVXu1Th3/63UwgoaJgCE09ovKZ6x4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a5GAGon4F6i1KcDFgg2o+WxVlDlopsbOZN8fJs0aQ384lx7tOaB+D4ZWAggUOYvPr
	 qaAot3kyY+fIvXtBtQA94y9H8B4FS94RFDlkOxQKpedZfRvzvuF1IYLWRRdSmI/7Vl
	 pBjFiZsq6+e/anIYMkQxgQSv+IxWWMtN+y5FhN092miHcmjkI9ddithL1EBHTpJ3zv
	 skQnjTuBumO1IiyRcl84t8TXiJ7Cfsv5DCMN260IKZuKfQEtKwDsVnJRXpqAO7fYHR
	 UIOMhO4R75o92Cyq4KuAVaKsMmmozug+stcBNNtGcS9v6p9in6FUA0OlvwnBj3t6vF
	 eo9DDKB0cJj8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Punnay Sharma <punnaysharma805@gmail.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] staging: media: av7110: fix sp8870 initialization failure state
Date: Tue, 10 Nov 2026 06:59:43 -0500
Message-ID: <20261110115929.867839-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054120-failed-6.1-30684fa98394@kernel.org>
References: <20261107054120-failed-6.1-30684fa98394@kernel.org>
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

From: Punnay Sharma <punnaysharma805@gmail.com>

[ Upstream commit 30684fa98394bc0eb4362282908612aab7d4dad9 ]

The SP8870 DVB frontend driver prematurely flags the device as
initialized at the very beginning of the sp8870_init() routine, prior
to requesting the firmware (dvb-fe-sp8870.fw) and executing the I2C
upload sequence.

If request_firmware() times out or sp8870_firmware_upload() encounters
an I2C bus error, the function aborts and returns -EIO. However,
because `state->initialised` is already set to 1, all subsequent
invocations of `fe->ops.init()` by the DVB core will immediately return
0 (success) without attempting to load the firmware again. This leaves
the demodulator microcontroller halted and the frontend permanently dead
until the module is forcibly reloaded.

Relocate the `state->initialised = 1` assignment to the end of
sp8870_init(), ensuring the flag is only set after the firmware is
successfully uploaded and the system controller is actually restarted.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Punnay Sharma <punnaysharma805@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
[ sashal: Adjusted patch context to match the relocated driver's existing initialization guard and logging. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/deprecated/saa7146/av7110/sp8870.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/deprecated/saa7146/av7110/sp8870.c b/drivers/staging/media/deprecated/saa7146/av7110/sp8870.c
index f68479e75e462..3e05ef983fafb 100644
--- a/drivers/staging/media/deprecated/saa7146/av7110/sp8870.c
+++ b/drivers/staging/media/deprecated/saa7146/av7110/sp8870.c
@@ -297,7 +297,6 @@ static int sp8870_init (struct dvb_frontend* fe)
 
 	sp8870_wake_up(state);
 	if (state->initialised) return 0;
-	state->initialised = 1;
 
 	dprintk ("%s\n", __func__);
 
@@ -336,6 +335,8 @@ static int sp8870_init (struct dvb_frontend* fe)
 	sp8870_writereg(state, 0x0D00, 0x010);
 	sp8870_writereg(state, 0x0D01, 0x000);
 
+	state->initialised = 1;
+
 	return 0;
 }
 
-- 
2.53.0

