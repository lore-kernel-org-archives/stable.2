Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068174;
	b=lJ6fmJMDvxnIN/fOLdBMYox9a2sLVMQlxje+8U0ONsoZ/2iUqG/exnPnhwK5drF6iVLX
	 4yz4s7ltOGDKOxMJVZQQBKtz1zNwEd+LI0DkYvy4NJ+UZOv+zyzA12reibh0NnF3DMhvG
	 RE+rgh7l54f251s3esOWMgEWILtwbt80npojNBPAt6y8kOM0KdnmX+EUn3TpusYxfaRFy
	 mHZ3Go5rT/BjAYayOT4fYjf56bqjO3QFbGOaNQRYmSPrSxpHqdujlD7LW70S3SAY8YRsI
	 jx56wCiImEOcwL3yab1TpCJnvUP57DTtCcJ4HGY/dzSR48OWl6mnKM8l3LPd+zFqzSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068174;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=v3fr6eVrFoNWvtFMxxNns0YuqbAjpsDPSy1ainhd08I=;
	b=r87cVQJzjqB5wm00SH9fF2TRiYGe93wy1eERDHfYrG0mTVxZiKsLiUiXhqu1FZY92pOO
	 fLNWokgV6CJYeA3qKOIv21UpyqtCcR0RgKTS8gRgbsv79XgvZ2KlC+55JjriASngot1XP
	 ZV5/45HJmsXhuqZDFp8GPXNYvGwuXMPsrMUr4zGcvvXout72OiF/t/Jav9F02XiAetQH5
	 upnbBzup0BlXbRqrHvFnI0RVhivWtKGi/j3rSN5jj+QWvy1azkpMe1tL1kC8QpeL4/PFg
	 zSEbVDyAbWF7YWcIVHCMnrDdEbD6ODxJ3orlYG2S2WID0mMC6wD4bBd7WTuN766uMvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ZqhfpJl+;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E11606A331
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28E11606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ZqhfpJl+
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-89f28c3ac7bso603382b3a.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068173; x=1794672973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=v3fr6eVrFoNWvtFMxxNns0YuqbAjpsDPSy1ainhd08I=;
        b=ZqhfpJl+QJMMYrPTIZj63v44HJVLF2uQh7294fn5HbIV2595nRpqsL8/WHk4QHFy+d
         HDPzZ+x3rgTcywAYhC/lvb98ujnYjwY7bg7GxaGIC4ubqvevsHGX7c9o8nuMg8UYnUiC
         SBBdniu/4361W8JGDb+NbXcdYjjtGJpoBUNb19zFsHHh1NhTtX4bN8KSo6KJLElBdiso
         tkCQtZXhHgbzDhUDmeBg1yvSLgaMW1ErnfcVGKzCAnzClFsVAXgGhtTaWWoH/X1/cohX
         kQXNIsJ7Cy4c4rw7hqISZCNVtw81QCJd8SPSRjS9/n6YFmWNmd6sdab7vqvH7Tvbsnrq
         EbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068173; x=1794672973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=v3fr6eVrFoNWvtFMxxNns0YuqbAjpsDPSy1ainhd08I=;
        b=fDtPxQ42f94Z4FQCbD3xHOVgEpSGCa9jMLYjqheTpr0ZkQgHbJcr3FvwOYRwnXDsIc
         aXEcO86sHCxb1v1RDCc3kzVFeNYh9fBSTLOLpT1GnmXCZLFFsa+NbdWEFf6uuFa4Lpbv
         qk7HCDE+tY4WbCY6q6k8xUo8z+7jBl35VCu3nejwYocsePpTarJf+L21ibH0KoxqECnH
         FHNh3K3fS3lZj124r/VkbYRBctD5kzHfryUBwje5OKquXz1pYyqzHLcd8gUQr1YhGZHH
         75wINB8fA0tNt5WhMybXaywbJVUdhSrS+u4H8wsRUbLGrHmvCDx6TWyHFF/NS1mXfqJm
         bEaQ==
X-Gm-Message-State: APuU4Z/3PS5J3mL44lgst/Mgj2puQH0qRFpZEAMps1B6sDwb6NtCrJBm
	rnlitJ9sN2NZzvFIGEggsPx0d4rFaZOVW2kpPLkia8rr9RqVQkgzsyv/Up6iCkjDSawE1Cx6gFh
	d0l/0XZo=
X-Gm-Gg: AYBFou3H8yQ1xgxyhWURKkwsXBHdCc1ee7B2mnvrgpF8FtBLInpKO4dZlwErMcntFD/
	ZsYacLqMjDWSKPTYdnhMb5V6OHML8/KAjKROeF9dC4lVGjxqVjZFZgzSKeuW9jigDUFPuskIkWv
	fqetr+BONsV6houm0D5zgJso0JOU7sWgilrpFQDegjEMZauooZuEkc7n6ZlXWUrzGJihqk4/kke
	MwBTukW5mT0mRQPWMCZzCYUWLFEvP85XCwTLP+qeepg09sOz5ChzcZCpSXLZTW6stWGesH5RqSA
	Ua0W/IrxU+YCqglstNLaH+K3C+QLWq7pmLdsFGGI4wxn8GistscRpx0X0GRRa7cxTjj0Ubvsidn
	DAUr4r5rFuXau6tIWcMu0yQyCCoP8JKTQ4l4tDzR+/qgW3piHwhPGQzMGcClz1kWTrAxQmzmqV6
	O1dZ/9LpqUq6eu2CALGSwMw936eHq/CbMx3D0K/cTwLsmQhYP2d3LoFMzb6Bq7qzK1vt2Trdnxg
	iaS7h9kJbx3U/T+BCvZVAFDqyi9sNzn8X9YcEuiRT3C8YiQrJt2LJe/osNyzODJPfv44i4Sga3F
	Cr33eSsYnBLIWiUAbHDelfdhTgcQQNm/U0NOr34iu1o3V2OvKDRLKergbx2vgskEgtOyI+El314
	=
X-Received: by 2002:a05:6a20:da17:b0:3de:b120:bb88 with SMTP id adf61e73a8af0-3ebb275d9bcmr6237369637.2.1794068173379;
        Sat, 07 Nov 2026 08:16:13 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb7064908fsm1344384a12.7.2026.11.07.08.16.10
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:16:11 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y 2/9] io_uring/sqpoll: don't attach to a thread that is canceling
Date: Sat,  7 Nov 2026 09:15:59 -0700
Message-ID: <20261107161606.2500384-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107161606.2500384-1-axboe@kernel.dk>
References: <20261107161606.2500384-1-axboe@kernel.dk>
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

Commit 22d9db9fd64a493525d692b32c556875b7254665 upstream.

io_sq_offload_create() refuses to attach a ring to an SQPOLL thread
that has already gone, by checking sqd->thread under sqd->lock. Since
the thread drops the lock while io_uring_cancel_generic() waits for its
requests, that check can run while the thread is on its way out and
still see it. The new ring is then added to ctx_list, io_uring_setup()
succeeds, the thread finishes canceling and exits without ever having
looked at the ring, and io_uring_enter() fails with -EOWNERDEAD.

Only a thread that exits on a fatal signal can be caught like this, as
the stop bit is set once the last ring has let go of the sqd, when no fd
is left to attach through. A fatal signal is group wide and attaching
needs the same thread group, so the attacher is on its way out as well.
Still, make the check see it: set the stop bit before canceling,
whatever the reason for the exit, and test it when attaching.

Reported-by: Karl Mehltretter <kmehltretter@gmail.com>
Fixes: cb0306c52ffa ("io_uring/cancel: drop sqd->lock while SQPOLL waits")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/sqpoll.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 696aba6bbf81..6ce73c93a721 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -435,6 +435,12 @@ static int io_sq_thread(void *data)
 	if (retry_list)
 		io_sq_tw(&retry_list, UINT_MAX);
 
+	/*
+	 * Cancelation drops sqd->lock while it waits, and a ring could attach
+	 * to a thread that is on its way out. A fatal signal doesn't set the
+	 * bit, so set it here for io_sq_offload_create() to see.
+	 */
+	set_bit(IO_SQ_THREAD_SHOULD_STOP, &sqd->state);
 	io_uring_cancel_generic(true, sqd);
 	rcu_assign_pointer(sqd->thread, NULL);
 	put_task_struct(current);
@@ -503,7 +509,10 @@ __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
 		list_add(&ctx->sqd_list, &sqd->ctx_list);
 		io_sqd_update_thread_idle(sqd);
 		/* don't attach to a dying SQPOLL thread, would be racy */
-		ret = (attached && !sqd->thread) ? -ENXIO : 0;
+		ret = 0;
+		if (attached && (!sqd->thread ||
+		    test_bit(IO_SQ_THREAD_SHOULD_STOP, &sqd->state)))
+			ret = -ENXIO;
 		io_sq_thread_unpark(sqd);
 
 		if (ret < 0)
-- 
2.56.0

