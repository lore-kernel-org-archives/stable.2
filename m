Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795840863;
	b=llaIX2ZYOjm46ps+ALHijvujphir79QkscsfKThQ2y0Z3vLFLo5o+aQEdYbPcWUODUUa
	 8vEbjdXTTP0LDTi9z2HqHHFPyYl7DYFpMg+b70ztCy97hkn/YwDXRHX2JyEjXCfIXfyP7
	 6OHh+Eeuwsf0WOl+1FKS9LxW8uz7dcJP8rhFX1R9Vu9g4K1nu6lI6HeFpf8zCljp0za9V
	 7+3peWWZ9fWxtn0bnS4C7RH+FVD72f8mF4wVqrzVe1OTEw/YLSxxHiHQvczr7eqTZGoU2
	 lZb6x6jkxz+Z3uL1BNY41OJOX9R5URQhjGbI7tZoW5QUf25aTbkrJi+02GHwmw5vS+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795840863;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Nv4bBI2nQTnAQa7VVyNNtpM5P6KUCDHBGIEl1IvOK2c=;
	b=b3jysbSnjS83qW+7A0PvbPgFe/smvj1DvV8G17vua72XOxc9q6UYuj9SdjwngX7qEyVI
	 n15959nD7Aojl2w6ARnzo9ptouheIXDpuMhXHbX1mRE0QYqmzjqmJmTkm5jp8vo61dIyL
	 TNMqeuYr7L3SEPeENTnRDSl9mveQh4fQPGjLOEzIFmog8Fro67wWD778RCX0CNlvMtE8s
	 XpE4Cwhxk+n+P1t3YHIKxZPcbrEycULIKWbImi0XswKgFLowRNctvJrGtR1XlIDrPRWpJ
	 2fP5uZ4SG1+Y3vhpQIU1WaAJM/+MBCgpNoQ60+qWRpG3bdNyDcON5ZN6C+Orvi3WfWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WMJTReRx;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868A6606A31C
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 04:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 868A6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WMJTReRx
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cde5a7d79b0so4530664a12.2
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 20:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795840863; x=1796445663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nv4bBI2nQTnAQa7VVyNNtpM5P6KUCDHBGIEl1IvOK2c=;
        b=WMJTReRxElg6TswQ28vwxVENY4/pSeEcf2VP5WDOd7q/uBCt2o6Fe+xX6MMlY5467h
         dWoqhju+SnCv/AQCDfi8nlzfOdHFvH0zPJicaH6ozh2iqZdV3OooEuwB/MbhGskyynyt
         4GDVeDdOCdYQ8d0dpOzWyQh0Cx4e6uQcnGPhQAKvhPs/PzPqpHsJTks+Jy9innDT5bG+
         EMHyhTVvyYb6jshOSu5LeWoHqHDRMwkHZVL1eMx2S/3VDe7ASnfFXbq9wEO5Z3xDeYps
         UCRKUlWZHchYRltALhqP9cDbaYyffdp7+W5Q05kq/QmcxNE3kVPI3UuEAJKqmU7qKrg2
         kpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795840863; x=1796445663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nv4bBI2nQTnAQa7VVyNNtpM5P6KUCDHBGIEl1IvOK2c=;
        b=Kw4bps8+l8gSpjzlDiAB2WDFZwxIlhLMz3Fvmf6bU2xogrLWUIdxjXSAmkSx0TY6Sz
         YfCsB41vq7fRYNoteJGWS6ojvrI6Gxu9Bhy6QNZCy68wijiJ46gtuHVFTW7LZ9pmpgpj
         vtwADHBleYSfMYiANomnQhoDwOLOiflZJjajShNWnU1AuYNVHHpIDn5Pnkgqo38Ytcqd
         fRm1klQdxWCMrrEBEbb4AVIFD6/JFhFsQMjvIKOxUlr7wfAK3lKRX1ilj9xotz0gApDk
         Yx0rFvEARjnjlhKga+JPtbifhSVK9h3QgeKPQsuqy40ErAe+oGuLOKeTHyZIzVrhOf11
         iwrg==
X-Forwarded-Encrypted: i=1; AL+hErE3orRGXEFvESTpC+AlQ0ZdvjR91cMx+bDJ/cY15qmJT1SFUwwXAMtUxtZ7UPDGiTP3Jn6RQ5E=@vger.kernel.org
X-Gm-Message-State: APuU4Z+AxrT4UR8dlc8gSR2739yA9+U2vFKYJIoF96irlr09GL6XThjP
	4g2Fa0Ccsq0yHKORx5/NmJLCIf5EACb1MR8mUjH90HhREDLmoZbNfAH+
X-Gm-Gg: AZFdTZfIEM9NOb3dQ5zFUa/R3tvnzNFDhNhlk1X4udRnsTFGYsQtygzQeJEC2egzmI/
	lKAYBhzvZvxwLpvJfVovXtqhBmKnmxIT+fztBEpUmdzemfo65/knaR13DaOP3L1vVst9uFVi6YG
	BwwoiLHpFXTaymLx6w2eJJJwLi1NX+Ye7IOXtzsX0s0kW/dvpxTThxIPFDsE794K+wnzcNtPbWz
	fq5TDehbi+ei06uUqO3X8+xCJlySQtz2UdZiam/pO3AL2cNJMiovAZPbps52D85oyE7TD1rHaFt
	1gli9amfMLHeFQYb/H+t9iCa0aqQPTTOVdz3zr9sVUTjSl/zYuSVxv3mimEKDToEpNlz3dohL65
	l8RHz80ztd+pENwRz9JOwtn0nYABV00bY+r51C6wkksCioiGLGHYWAsiiAMUGCgbBWUMKu0n/Ro
	Hl1TemCUlWnljdW952NATAua0LnzWaIH7KFixRk2PyINNQLOPSlaZynDmViD+B9GeB0za/tdZBV
	ocb3Eax+ritW4xD7blwfiZ6zU/6IrVtnxEABEyJHSbhE8OUwDOg7vwD9+ExvTrrM8lVZAgnnYgp
	DEIkLUizpTrfseEcVzwPxu6ekwXmKrT2YdvtOwUz7zjJZ6pFxAZYAJxfLFQxyu3w+TXmVZCdcI1
	SeDEJecVyIhil6DTPpAo9wl5dTNpwi4kB+ryVHplAdBoZ3OlMkdDHlRRMtfJ5Ioap74zw/ACU2w
	QC5V3+KSIxhKwEAyr3Ntk4AB8=
X-Received: by 2002:a17:90b:3f0e:b0:3b3:bf8f:9cce with SMTP id 98e67ed59e1d1-3b41c905c98mr26228875a91.35.1795840862811;
        Fri, 27 Nov 2026 20:41:02 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41abb1b66sm42716729a91.1.2026.11.27.20.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 20:41:02 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: Srujana Challa <schalla@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Rosen Penev <rosenp@gmail.com>,
	Arnaud Ebalard <arno@natisbad.org>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Romain Perier <romain.perier@free-electrons.com>,
	stable@vger.kernel.org
Subject: [PATCH 7/8] crypto: cesa - do not step empty hash operations on the non-TDMA path
Date: Fri, 27 Nov 2026 20:40:49 -0800
Message-ID: <20261128044050.722617-8-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261128044050.722617-1-rosenp@gmail.com>
References: <20261128044050.722617-1-rosenp@gmail.com>
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

On engines without TDMA (Orion), mv_cesa_ahash_std_step() trims each
step of a non-final update to whole blocks and leaves the partial tail
for the next request. mv_cesa_ahash_std_process() asks for another step
as long as source bytes are left, so when an update fills its last
SRAM-sized step exactly and fewer than a block's worth of bytes remain,
it steps once more: that step trims its data to nothing and starts a
zero-length MAC operation, which corrupts the hash state. Multi-part
hashes whose update ends that way are wrong, one-shot digests are not
affected.

Once less than a block is left on a non-final request, complete it and
leave the remaining bytes to the cache, as for the last step.

Fixes: f63601fd616a ("crypto: marvell/cesa - add a new driver for Marvell's CESA")
Cc: stable@vger.kernel.org
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/crypto/marvell/cesa/hash.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/marvell/cesa/hash.c b/drivers/crypto/marvell/cesa/hash.c
index 6fcd78427b71..b51315cd01df 100644
--- a/drivers/crypto/marvell/cesa/hash.c
+++ b/drivers/crypto/marvell/cesa/hash.c
@@ -297,10 +297,23 @@ static int mv_cesa_ahash_std_process(struct ahash_request *req, u32 status)
 {
 	struct mv_cesa_ahash_req *creq = ahash_request_ctx(req);
 	struct mv_cesa_ahash_std_req *sreq = &creq->req.std;
+	unsigned int left;
 
-	if (sreq->offset < (req->nbytes - creq->cache_ptr))
+	if (creq->last_req) {
+		if (sreq->offset < (req->nbytes - creq->cache_ptr))
+			return -EINPROGRESS;
+		return 0;
+	}
+
+	/*
+	 * Less than a block left: keep it in the cache for the next request
+	 * rather than stepping a zero-length operation.
+	 */
+	left = req->nbytes - sreq->offset;
+	if (left >= CESA_MAX_HASH_BLOCK_SIZE)
 		return -EINPROGRESS;
 
+	creq->cache_ptr = left;
 	return 0;
 }
 
-- 
2.56.1

