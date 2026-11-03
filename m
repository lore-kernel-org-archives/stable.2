Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.33.167.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793733843;
	b=aPzr/OUqaU/rWIQP4/i0HlphrhPi/CpNVluYEXjnWZrLZTdFebQd51mVOrOT0gBPek8r
	 GBGk5hp4rICRZtwOkJVPeI5qVmG9r5m0NbIyDhpluavCjy0eHZFoFI8qn49FNrF0R6uyG
	 Rsrs0nuF3tR58fsyw0iGOhxLkYwbCYnLjz4hK3YrwtHCDC0ZS2yyg1Yy1rTPIgWtJ7T3H
	 jG6GSYLLwBKZ3GpkApGpynW3/3Zv3KHxUo2UT6m9z3ILdlScAq7salsXY8AEJHvfG5PMP
	 fJ/lbM3lex3J409EM4y/rzloMk+LHWl4GC/OXw4OeCMTXlDuhuPVESSBUvaB4S5sx3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793733843;
	h=DMARC-Filter:From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding;
	bh=na23XsOI7UH5102ApFoGkPZ37AMnkd6ApxBm18oahbw=;
	b=rxzxL6uri5weMkT03s2VXTgeHhRDd1g1XJ/ry9il3K6xaT2eFpUf2+vk81hstXnsMXSc
	 uev/MNRnKgVP4Fo93hzqHuvJv1VGDpSQqBg4iBFBTIk0I57s//CHsgMdTzduzJtsHi6MR
	 v2FSrUZAfMMb2j5JtgHj1R/PqBRTRZvGFy/RMezHyvw+/dyD3ms5+vyiHaEAizmyRpPB5
	 37eGfSIywKBliCBWAChBP1OOZU+3IxXrV8kCHNpXt+XSWHiOwndsy40hbYg9Ug+AYGbYl
	 TyFrfTagQvKIisGgZ+7kVJ5K0L8gu/+vX7V1aOT/GJQqwsiTLS4LqG16jDTRJgRwVpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=picomail.one;
	spf=pass smtp.mailfrom=picomail.one;
	arc=none smtp.remote-ip=193.33.167.51
Received: from mail.picomail.one (mail.picomail.one [193.33.167.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D133606A31B;
	Tue,  3 Nov 2026 19:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D133606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picomail.one
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picomail.one
From: Fexiven <kernel@picomail.one>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fexiven <kernel@picomail.one>,
	stable@vger.kernel.org
Subject: [PATCH] mmc: core: clear MQRQ_XFER_SINGLE_BLOCK for new requests
Date: Tue,  3 Nov 2026 20:23:45 +0100
Message-ID: <20261103192345.647483-1-kernel@picomail.one>
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
Signed-off-by: Fexiven <kernel@picomail.one>
---
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

