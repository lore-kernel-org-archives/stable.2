Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068231;
	b=omLG7bROnRpste18C8c2KtMy3s7+5tN/MP8nxGNyyT6BCJ/o+vqCdr51Us+ELzZHpyw+
	 eOxyfE550g6jmPcFea4M2QGMihSXQej9MHYC2g7d/oNXXL6c36k5gXy3DAzAEyvLmgV49
	 05PQYzNJ3dnjLNS0WfOzuT/8qNwdjmVRTr4RRcG/7c/n6BYxp+McO9d7sOoR4zOjzrRPu
	 JD4qIE209g4Fo0Kssu3ONvZ70juRogwMpvG0188FJ6zl9t+Z2ZV3LRcduQuB0Vzajizm3
	 9J129ByuPFKXYFU9Epf0v/Lo+K0KnT5dPl1eJhhufmK6pGI1ZnjpHQPCR7/akNUPfWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068231;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rUSAeTIF9ZOW1puXcPMb8JJmlhYZ5bO2XTu9Hyof7M0=;
	b=P069KlYXCQjtxP1kO/PYfZ3TNr+3QyFxhZ9r/rHD8OnDvoDvcGow4f62/Xuvhfu6Azvv
	 8y+rO5gf3hKDEuvKJoy/wVsxVjZaaEDGwLDFyuhcU/RQD3/XddvlIBhgCK2bpsx/BUUWm
	 IaqNIN9BxKm9PlW9IvAbo+6tE0EKYIfMlBOrYlF7TJQDCKf/n78AYinfRNqXxDMVnlpkA
	 DKB41f7eZxWfumZpvFOUyBeWS6p8jD8qhtMXQGUZRqAHnZfvxEE0pTUHw0wUma88kG2bB
	 o1dkUhVShBIZJxWeKWKvnWMEikdAmoyLdg6z9X6EP//7ARncg4XhLMgc9dUj8gzDpTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Lp2H3UjI;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51656606D83F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51656606D83F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Lp2H3UjI
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ae691283ecso307540a91.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068231; x=1794673031; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rUSAeTIF9ZOW1puXcPMb8JJmlhYZ5bO2XTu9Hyof7M0=;
        b=Lp2H3UjIZGP9hW/dF/33j4WxihCIc1Yvd82HUCbSrXwavO2wkPPXgpTmF1bSsHYvzA
         lzjgb8wZVAyZQA/8qjDuo9GddVFzo/Yp/v3paJ5yQVPQzJUuG4giRqS1VoEZHIMBgugG
         C2IkAJL1Sb9U+0rVig3jvFpbf6QxErzMUPAE4hJW9PGOMBl08TZE0H9icoRBfYZmMDyD
         NQ1c8uG2wZ9bhaORSFvWaBC2X1uMUEzEj1NY6N+rUm2ju1MACv4gwEIIPZgQBOc3lFIG
         Taxuv9quW+BPk505Fxi1rl3BQqSXk6Kjdrrm/C11gYMTRXL76FNBLza6ZqDcix5RZkpa
         sS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068231; x=1794673031;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rUSAeTIF9ZOW1puXcPMb8JJmlhYZ5bO2XTu9Hyof7M0=;
        b=loDxE86vvY+CykOz2kDIGlLNcSJU9uZIQhm8kprfLgF6ATQdiyzE5sn5i6i6CfI9c8
         UGlxEsj6e3mUji1OfRCAUJMcK9WNXRzeaCfX/SNNWsx4W8q2qSqQoi6Vg3WVNJE5eCqP
         YPWnEYdbIt5u5uTC74X+EnkbALlitR+CuPFsIQRMcoMK0BYFP5iqi7tDKc4Y43krDa9v
         L5JhvKuBlJ8tYcB3odiT5ztZ7NRYAUfZcOI1IGWf5UXJW0MEe/6Q3FuMjsBtG9/K2VVx
         UgDz5/ExitCumPPTqwoRi1EWX95XqmCI1mc5004FE+eeqq/GVS/i62JugEtencP1U8NZ
         lFGg==
X-Gm-Message-State: APuU4Z+WJ2jBh6EDbismHwtF56lI275hyQDmbbjZIEPfdThMDQoBScaJ
	LmgYmcGEWYWeVy2NWEmtxtCZEt0I0jRCNWjtcJycqk8r+l8UsoBHsnRVdmZrDWsJ4iJj58xqFT7
	T7RJ2pR4=
X-Gm-Gg: AYBFou395gyJpMECp6PlNBZwTGkKovWoKfTRSi/scOUKE8TKucajERhAzquDiohsfMX
	ZZrYEUDfN6fb1ZmzjQxZBL+hQvN1JQnh+Z6taP/D6H2dciHmApvjRYaCBTrJFegJPmTkO6OpLU6
	h7AdzuX+6DAfAWbMsDAGuOJ76h2ov9KqanhHW4fk8LI0TAYQmVrPg/kBHdk9J1xTZ8uoEK70QwJ
	nT7c+bFchM/tTVl6PByBAPUkC5oTuwUyxsDgFfrSvUTFJcRxyJwX7fQPdkoBdfskRw3DsHSG1uB
	VtOacFpE3OIgpsawtpu1DgJJDTcjiNKAoJAOca22m/M8r3bFCPjv2k8uTcFhcHxtPI1rmcJcMJe
	YCroKe1nYfMubI2bVtF+wHFgcZJ55pPb6PBNQqIuVb/xrQ+AWZVETACDnyy2eMoOEOHSV+vkXpv
	LWsYvUKIgQTNI1v6Fwuqc4DG9NVtM5DbaIsvhvjp2hjnOHa/1q7xbm2q7EirENyv0aHsvKCo2dU
	dP2zsw9A76ZW2NydW+Pbm7iDKbZxmUfpOfHkbcFO25xeL1DPu5n6gRd5cBANPpndA5bWLsq3GCl
	G/v8voFkfGN2ywpT9/Vffz29T5Ne82kMC1IeVqCLRUu1atfjro9+UtbKGMHTwK4fX1h7vcpA/h/
	sDnt3B71kNMd6+muNGAEt
X-Received: by 2002:a17:90b:420f:b0:3b1:d40:2c4e with SMTP id 98e67ed59e1d1-3b10d403c6fmr863237a91.0.1794068230747;
        Sat, 07 Nov 2026 08:17:10 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1058a7b29sm3732962a91.10.2026.11.07.08.17.09
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:17:09 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 7.3.y 8/9] io_uring/poll: don't poll a writer for urgent data
Date: Sat,  7 Nov 2026 09:16:55 -0700
Message-ID: <20261107161656.2500790-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107161656.2500790-1-axboe@kernel.dk>
References: <20261107161656.2500790-1-axboe@kernel.dk>
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

Commit edeac4546a71b6c1db4ba006a2dbf7c863f54e9a upstream.

io_arm_poll_handler() starts the mask of every async poll with EPOLLPRI,
for a reader and a writer alike. A TCP socket reports EPOLLPRI for as
long as urgent data sits unread, so once the peer has sent a byte with
MSG_OOB, the async poll of a send that waits for buffer space is ready
on every re-arm. The request spins through task_work and
__io_arm_poll_handler() until APOLL_MAX_RETRY is used up and io-wq takes
it, the same spin that EPOLLRDHUP caused for a half-closed peer.

While it spins, the request is neither in the poll hash nor in io-wq. A
cancel issued right after the send gets -ENOENT and the send stays
pending, until a later cancel finds it in io-wq.

Only add EPOLLPRI for polls that want to read. Urgent data is an event
for a recv, not for a writer.

Fixes: d7718a9d25a6 ("io_uring: use poll driven retry for files that support it")
Reported-by: Lukáš Lalinský <lukas@lalinsky.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/poll.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/io_uring/poll.c b/io_uring/poll.c
index 9703a2fdfb44..fc1800c7097b 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -739,7 +739,7 @@ int io_arm_apoll(struct io_kiocb *req, unsigned issue_flags, __poll_t mask)
 int io_arm_poll_handler(struct io_kiocb *req, unsigned issue_flags)
 {
 	const struct io_issue_def *def = &io_issue_defs[req->opcode];
-	__poll_t mask = POLLPRI | POLLERR;
+	__poll_t mask = EPOLLERR;
 
 	if (!def->pollin && !def->pollout)
 		return IO_APOLL_ABORTED;
@@ -747,7 +747,8 @@ int io_arm_poll_handler(struct io_kiocb *req, unsigned issue_flags)
 		return IO_APOLL_ABORTED;
 
 	if (def->pollin) {
-		mask |= EPOLLIN | EPOLLRDNORM;
+		/* urgent data is an event for a reader only */
+		mask |= EPOLLIN | EPOLLRDNORM | EPOLLPRI;
 
 		/* If reading from MSG_ERRQUEUE using recvmsg, ignore POLLIN */
 		if (req->flags & REQ_F_CLEAR_POLLIN)
-- 
2.56.0

