Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.47.207.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793336659;
	b=pk/y+l2PMDpliX3VqhlscQFG5XxlSXCmpkXer/TrXgnixVBGeoMO6DFfKW/V+YdkdvXs
	 TLFnh/uinCCNcCgjImdcZtVNhDjfnQbxplDKIW7cTAEflCfE/igNNgUXmmLhfd/q1LZA/
	 gWgZ+nvNyT7py25Ia4QavTYk+O0UUwS7yvY7M/8kJARvLdyLn7WDFD2OFySuF90TYx70P
	 qGBTOpEk6MjPoYvpOisYQMaKv0JYXCJmWSVAtC05jZyeTm/8j14PeZcZuJXqgsDfsLxYh
	 Y/vtbr9wK2sMRMmjZiQKzoB/e/APS7ZeqLEUuuO23nBlXtJV6f57STyi3VfnCJz+1Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793336659;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Received:Received:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Smtpcorp-Track:Feedback-ID:
	 X-Report-Abuse;
	bh=Wbl/xuEn0Kwx8i0cp0FlXtd52MgQLMm91QNASCMIyoY=;
	b=BO96CiqlALCfMClEfRvUNEGUvI3ZDB8DEd2rWhzweMytYpOg1nRzGs3JGv9iOVcAmoAm
	 tJ3VP+ZP9SRWYMRfu5eDKgOD1/qCNRYpIF3Q81CHgCvSz7bAJXTJL7Wn0MKlTcNMjLirV
	 0bT7N8l5N4wmFSiDdtSdZZSg66e2d49OVsOuFQYEohyVgtuhDeAiSp1qnGSfCINuOwySs
	 uCXEpgTYo7TZmwbKw1JGlWaY4eNbN+2IbC0o7irTPa1jTUUp118kMY6Txh58z7Fqc2TPQ
	 lv/7WDJule3J/nVqSI7Vj0utgyG7VzGhnIFHkMxgRs8kFAWILN8ikQbocuYJP0Hs9zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shangen.org;
	spf=pass smtp.mailfrom=em879706.shangen.org;
	dkim=fail reason="unknown key version" header.d=smtpservice.net header.i=@smtpservice.net header.a=rsa-sha256 header.s=miusa0.a1-4.dyn header.b=AnlcDApq;
	dkim=pass header.d=shangen.org header.i=@shangen.org header.a=rsa-sha256 header.s=s879706 header.b=Dzld56n6;
	arc=none smtp.remote-ip=103.47.207.181
Received: from a2i949.smtp2go.com (a2i949.smtp2go.com [103.47.207.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B1D606A326
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 05:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8B1D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shangen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em879706.shangen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" header.d=smtpservice.net header.i=@smtpservice.net header.a=rsa-sha256 header.s=miusa0.a1-4.dyn header.b=AnlcDApq;
	dkim=pass (2048-bit key, unprotected) header.d=shangen.org header.i=@shangen.org header.a=rsa-sha256 header.s=s879706 header.b=Dzld56n6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=miusa0.a1-4.dyn; x=1793337558; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=Wbl/xuEn0Kwx8i0cp0FlXtd52MgQLMm91QNASCMIyoY=; b=AnlcDApqs1m7Lqa1Z/1wZwNxTh
	9DwqjXvFtEdAysPr/XeFe/khmw00Bap3HCol1KsJ6D9tACPsXrAQhszsPk1LKI/YC5qKcjH3u6Y44
	8ySIIelkdr6xM3LjCK5PP8N1WAyHfvZCgqym4zXdJtU3DA49Lv1dskhk+wA7GZ4ymQzsItWJ4eP2y
	yLWGP7/mDez6+0rc6Y8uqcuZocX5gkKC4imGaGgiPlIzVixC2yKNXyBn/j0ZM1adNY9o0Q+N07qQ+
	vfKFDlsJgHY3qPl+KITAxrdJWHjjqqnEEzMpfBg0oPdtwd2tIBb60G3HPiUaspMeQsYnnIY7C8qY5
	+UpMgSGg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shangen.org;
 i=@shangen.org; q=dns/txt; s=s879706; t=1793336658; h=from : subject :
 to : message-id : date;
 bh=Wbl/xuEn0Kwx8i0cp0FlXtd52MgQLMm91QNASCMIyoY=;
 b=Dzld56n6jOQ/UeDZWNp71kBnRa7mjgo0rUUhFQFgAkvtAk2cocXTctUmgJp119cDm2Vdy
 m6u8p/euwdxeeBYB78Cp9gDwosDNY994fx3xOY2IbY2R7KnZCGNrJ/efB8SjDZZFrXOToTz
 YpulkvlJ1/K6BTk2+sjzjFhHPPQLs9ZQKa2PcYmDoyyYvEiNadgHDFzsQ4Vi4rdQVoeePRD
 3AN4e55WscWKXgNnS7VK/Ghq5ckdOD3UybOB3t3P23wBeZcLBV161Cfk6j8P4hBG0ESwCPo
 VM2ee3EybCU0hCL/WKqJLFp0p0VJEsTmjz6txo4DjObp3yky1eQ7hEKqwCyg==
Received: from [10.143.42.182] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <sim@shangen.org>)
 id 1xMemT-gL4QLv-P3; Fri, 30 Oct 2026 05:03:57 +0000
Received: from [10.195.244.224] (helo=sse-laptop.lan)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256:X25519)
 (Exim 4.100.1) (envelope-from <sim@shangen.org>)
 id 1xMemT-FnQW0hPtGB2-hP6T; Fri, 30 Oct 2026 05:03:57 +0000
From: Shang En Sim <sim@shangen.org>
To: Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org
Cc: Shang En Sim <sim@shangen.org>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 2/2] io_uring/poll: cancel all matching requests in one pass
Date: Fri, 30 Oct 2026 00:03:17 -0500
Message-ID: <20261030050319.1448530-3-sim@shangen.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030050319.1448530-1-sim@shangen.org>
References: <20261030050319.1448530-1-sim@shangen.org>
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
X-Smtpcorp-Track: ix0a79k6eswc.FeeTDFtGtWnc.2fvjXAoDzZa
Feedback-ID: 879706m:879706aL5FzMA:879706sz-CVcCaXL
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

With IORING_ASYNC_CANCEL_ALL, __io_async_cancel() calls io_try_cancel()
until nothing is found, and io_poll_cancel() cancels one request per
call, starting each lookup at the beginning of the hash. A cancelled
request stays hashed until its task work runs, so every lookup walks
past the ones already cancelled. Cancelling K of N pending polls visits
about K*N/2 requests in one io_uring_enter(), with uring_lock held.

A single CANCEL_FD|ALL on 80000 polls on one eventfd takes 17.06s,
0.02s with this change. With voluntary preemption the soft lockup
watchdog fires:

  watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [repro:100]
  RIP: 0010:io_cancel_req_match+0x19/0xa0
   io_poll_cancel+0x73/0x170
   io_try_cancel+0x7b/0xf0
   __io_async_cancel+0x41/0x110

Walk the hash once and cancel every match, as io_cancel_remove() does
for futex and waitid. Cancel by user_data only needs its own bucket.
__io_async_cancel() still loops until nothing is found, so a request
that io-wq parks in the poll hash meanwhile is still cancelled.

A cancel that matches one request now walks the whole hash twice instead
of stopping at the match.

Cc: stable@vger.kernel.org
Fixes: 8e29da69fead ("io_uring: add support for IORING_ASYNC_CANCEL_ALL")
Signed-off-by: Shang En Sim <sim@shangen.org>
---
 io_uring/cancel.c |  2 +-
 io_uring/poll.c   | 39 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/io_uring/cancel.c b/io_uring/cancel.c
index 50a65fbc6ff0..e3d9fe8fc982 100644
--- a/io_uring/cancel.c
+++ b/io_uring/cancel.c
@@ -198,7 +198,7 @@ static int __io_async_cancel(struct io_cancel_data *cd,
 			break;
 		if (!all)
 			return ret;
-		/* futex and waitid return how many they cancelled */
+		/* poll, futex and waitid return how many they cancelled */
 		nr += max(ret, 1);
 	} while (1);
 
diff --git a/io_uring/poll.c b/io_uring/poll.c
index 4f04bda42f7f..9b73b0d88a0e 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -827,12 +827,47 @@ static int io_poll_disarm(struct io_kiocb *req)
 	return 0;
 }
 
+/*
+ * Cancel every request matching @cd in one pass. Cancelled requests stay
+ * hashed until their task work runs, so finding them one at a time would
+ * walk past all the earlier ones on each lookup.
+ */
+static int io_poll_cancel_all(struct io_ring_ctx *ctx, struct io_cancel_data *cd)
+{
+	unsigned int nr_buckets = 1U << ctx->cancel_table.hash_bits;
+	unsigned int i = 0;
+	struct hlist_node *tmp;
+	struct io_kiocb *req;
+	int nr = 0;
+
+	if (!(cd->flags & (IORING_ASYNC_CANCEL_FD | IORING_ASYNC_CANCEL_OP |
+			   IORING_ASYNC_CANCEL_ANY))) {
+		/* keyed by user_data, so only one bucket can match */
+		i = hash_long(cd->data, ctx->cancel_table.hash_bits);
+		nr_buckets = i + 1;
+	}
+
+	for (; i < nr_buckets; i++) {
+		struct io_hash_bucket *hb = &ctx->cancel_table.hbs[i];
+
+		hlist_for_each_entry_safe(req, tmp, &hb->list, hash_node) {
+			if (!io_cancel_req_match(req, cd))
+				continue;
+			io_poll_cancel_req(req);
+			nr++;
+		}
+	}
+	return nr ?: -ENOENT;
+}
+
 static int __io_poll_cancel(struct io_ring_ctx *ctx, struct io_cancel_data *cd)
 {
 	struct io_kiocb *req;
 
-	if (cd->flags & (IORING_ASYNC_CANCEL_FD | IORING_ASYNC_CANCEL_OP |
-			 IORING_ASYNC_CANCEL_ANY))
+	if (cd->flags & (IORING_ASYNC_CANCEL_ALL | IORING_ASYNC_CANCEL_ANY))
+		return io_poll_cancel_all(ctx, cd);
+
+	if (cd->flags & (IORING_ASYNC_CANCEL_FD | IORING_ASYNC_CANCEL_OP))
 		req = io_poll_file_find(ctx, cd);
 	else
 		req = io_poll_find(ctx, false, cd);
-- 
2.56.0

