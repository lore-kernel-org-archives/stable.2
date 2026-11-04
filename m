Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.33.167.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793771108;
	b=DiroxIdWmouZzV7sRZzKymas1jQig6LGoZ2WYRf6StFMoUup3d9mXhjKVMunh2s95YCf
	 hGUgksBB+MU3xG+Gc82vhuviSQr11SROKOGiO/Gplb9IzCQ6xN4mOvTlkqn1T/Eqir2RD
	 OrVMAxR5rKc8PMMqLA4FgF9BzgcwlX1a/agGMOZ0xOVKG22brUKyJYiCHczDLt8DYInTD
	 9bD7W3IxurWplEsyrhkieI8BmcPkAli/CP3KT0WB/U2gtVgvrWyTHeGTAYCdMQHenc+aN
	 H4sihmijuUl/NimsIC6GNymY59ouwBgQMTOUPxUTySPfIlKTNg1+3LjNRi/HfNxHgyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793771108;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BKwR6wvLjW+5B9gDrCBFJwkCFubqlk8mVerXTeFaIhI=;
	b=B4391pdGaUzMeNr1DaV34AG+w3gb9+KAqHHyJ6p6YR2Z2Xee4J8zqKBew0nxb3FEGWJK
	 75lRqsteERE3uwsDjo65X/Ig2SdkCiFhhnHOYNBh4a96aKgV9auC/Oo3Lp3Fg/o6qqFDp
	 vdlWz2Ry+05afA15mzLIibLvvLgA9NIq/55w4QQmXWP02iScVWxtwPtMPWcK/gEF2IuRj
	 Gh2rrag15Yyn+RkWG81CXtM2ihvS2EWIcfjZMvrEIg7+6ip5+w+TVSlu+y2PyrwUnMr89
	 OFIIqEqAOnGgiS0uzaxlNdHQ+tz2Cd0gLxHLrMAADjBwBS0DFAzcdF6zoikIz2d8Ybg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=picomail.one;
	spf=pass smtp.mailfrom=picomail.one;
	dkim=fail reason="signature verification failed" header.d=picomail.one header.i=@picomail.one header.a=rsa-sha256 header.s=mail header.b=d+61l2ol;
	arc=none smtp.remote-ip=193.33.167.51
Received: from mail.picomail.one (mail.picomail.one [193.33.167.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE488606A33D;
	Wed,  4 Nov 2026 05:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE488606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picomail.one
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picomail.one
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=picomail.one header.i=@picomail.one header.a=rsa-sha256 header.s=mail header.b=d+61l2ol
From: Jonathan Schmid <kernel@picomail.one>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=picomail.one;
	s=mail; t=1793771106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BKwR6wvLjW+5B9gDrCBFJwkCFubqlk8mVerXTeFaIhI=;
	b=d+61l2olWB0XxVu6JA5e2MrmWLSIq+bNnbeMPLslKEPY1ZTspfAQvV5yFJzSofqHjCbBff
	mXCGliaPjhwBBjptk+6MfeIzxyRhQWqaZdsfNjVzQxsjksWP/ejPSXJhfYjp+KbHqeBHRb
	0BtYB4djvZGMB4LviodqbMtcazVCfJfl31hptHY0JfGDow/frzZxFn4G3geFwKBmuHrc0n
	j5vb+b9DwEam1sOBO1y89b1stcvTK3KBdIBvz+Z9HOFH1su2iz5VAkHFDHyqGZ1/oDOeh5
	Kw+8tjtpZ1tKoelxaoWiEQXFlEqve6wGAQof1evIH98j6rEB/FLd+63byFptmA==
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Schmid <kernel@picomail.one>,
	stable@vger.kernel.org
Subject: [PATCH v2] mmc: core: clear MQRQ_XFER_SINGLE_BLOCK for new requests
Date: Wed,  4 Nov 2026 06:44:12 +0100
Message-ID: <20261104054412.8310-1-kernel@picomail.one>
In-Reply-To: <20261103192345.647483-1-kernel@picomail.one>
References: <20261103192345.647483-1-kernel@picomail.one>
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

mmc_blk_mq_complete_rq() and mmc_blk_cqe_complete_rq() set
MQRQ_XFER_SINGLE_BLOCK in the request PDU when a transfer fails, so the
retry is done one block at a time. Nothing ever clears the flag again.

The PDU belongs to the blk-mq tag and is reused for later requests, while
mmc_mq_queue_rq() only resets ->retries for a new request. Every tag that
has seen a single transfer error therefore keeps issuing single-block
transfers (CMD17/CMD24) for the rest of the uptime.

On an RK3576 board (HS400ES eMMC) with occasional data CRC errors, which
are recovered correctly, sequential direct reads dropped from ~200 MB/s
after boot to 3-10 MB/s within minutes and never recovered. The host
registers showed only CMD17 with a 512 byte block size. With this change
the read throughput stays at ~200 MB/s and writes at 60-90 MB/s while the
data CRC errors continue to be retried.

Reset the flags together with the retry counter when a request is
prepared for the first time. Requeued requests keep RQF_DONTPREP, so the
single-block retry of the failing request itself is unchanged.

Fixes: d34124edffdb ("mmc: block: Use MQRQ_XFER_SINGLE_BLOCK for both read and write recovery")
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Schmid <kernel@picomail.one>
---
v2: use my real name in From and Signed-off-by (Greg)

 drivers/mmc/core/queue.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -301,6 +301,8 @@

 	if (!(req->rq_flags & RQF_DONTPREP)) {
 		req_to_mmc_queue_req(req)->retries = 0;
+		/* the request PDU is reused: don't inherit single-block recovery */
+		req_to_mmc_queue_req(req)->flags = 0;
 		req->rq_flags |= RQF_DONTPREP;
 	}

