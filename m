Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817915;
	b=cHYzCNyuplqe16c2biYfcrK9Nu/lyglgt8ZgUUca6om6+ee1kPUHJtohFiwoI+YqzolA
	 Tbrq+/SoW3by4td5ZRI0Fuh9noH36ZUdG7CPbRhd53K0ojbRW9UiSwzrfcVwEAFlEL1RJ
	 KA3UFXSNAjS94STZA/dVCYXEBJU1fDe+6mzhopwgKzbribF1LQomgw2B6IdfattneNbBb
	 a39cfGANqHZ7uP2MyopXK40JmpNNn/XuOancKU0BXJTqVW8fm9mfY7htiv6JvI/HPFs7g
	 /oQpOFgKuDkTtzCAqySrQ1p3ZIAckakkiqJ3WQaH4G618pFcRRfLLfdl2ptamNDDa9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817915;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=u1qzKLk50EzNX2TmcZW1BLpBrT4v5gOfVsKHgBTUbgs=;
	b=XVxRALjeJWWyp+eMSe6IjsoFJaNQmUeSEBOXUUJnIhypkohBuFpIArkmsg6SKvtlIybF
	 ezg6MqKaoG6Gn+eTREWMDxDOZxR6S9srMS9/GeCoYMH7JfD2oyzlkmCI17VfLNUO4fB/z
	 5q9Agr7nYRzs3hq92eXvKZFNkXwBrfMRl/+6zg17w1tislUERXBkCZJyOwODKEkUw4+RC
	 PHLErp0FSksIloREQQViJM5vsPDAkHQJeBgkL7RMt5M4pQ5bhK+UJ696FXymPTusGLgxZ
	 qUgkxlwLsBmuGord4XtS7YOFrOaS3n6Mbg5IuYqjru9OzI2njRNEDZhyQpKfIdkPCCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	arc=none smtp.remote-ip=209.85.160.49
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32B5606A32E
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E32B5606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4911df1e196so704807fac.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817912; x=1794422712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u1qzKLk50EzNX2TmcZW1BLpBrT4v5gOfVsKHgBTUbgs=;
        b=hjFrrFI9cA5Hnwf9hvtlTD6ucX1XXB3MbhhOUW97CbocFOn4diZDrPv5X1nAVDv7+O
         z5B0J2yXvwCcl21YDyZsD6WEy3CSn4eav30MK4M6CrWZk02kghe0VndvO7NkEsGvpiM7
         5ZzWwBufiMzGhO0KPv5u7EuU/ZlERzrvRyNgpNqtDoABd1Nj+Rz0DeLJXaKU/wyEW0lK
         plL+KJDm4X2XLW3NO51b/32VKRPKGb6da1XQbhzFIoEpoU8UbynTHfGnxkaeHDJ66DEp
         U+BLhClos17VwxKEtfm4MAekM2e+KoUG2/Z08nT2CuOdo/shbVK2eLXeo5S5I+bcegBn
         oGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817912; x=1794422712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=u1qzKLk50EzNX2TmcZW1BLpBrT4v5gOfVsKHgBTUbgs=;
        b=RG5t+kfI5yiB7b2j6E1MrYQhfiljtHvDT/hvdXxKxNLFuiFDMaHglavpKevty0v6kQ
         uhrXW3olIguW5oWvQO4l2QWbqxEGNQx3VnDyQO9eMEfbIuI2ndlFgmF7I3e610gTdBzb
         IF1pnQpwS1aljWWbCZGrm1KgUB6bd4MS5o0O8lIo+U5up5me5Qx4bzWiHyAIq6XT9fst
         WKfWM27eoFYd5LJLb7O7rZTvExEA/6MbW/LjWEkrIxMMedbpUQFivym6sfIPtO13Hkal
         BinnkB12nkwwY/Yn/m9bz1S8c1z5ZdpvdCC5aCeunu10EB6DJXx1h1dawbFH8ARMTQaN
         n9jg==
X-Gm-Message-State: APuU4Z+w6JAb7DArap/IYqWXduJ0oRzeSeGFlpO002wYEo0TitVKEuKE
	EkmBouVHS0ZPAGXGYRY0YlwxbhcA4Y2zIP1otxM23jjLyPU5+TCUOp/8VtiHpnlM84LhJTN63d+
	BIMYZFFY=
X-Gm-Gg: AYBFou1aqLTtohqQIujcIxxR+YjN9VYPpbwrMtAMJHHTnUf+uQMFKxePKIj3gvhHfAC
	6603PGhgB6IMARVVgz1KJX4YgGPexvCuyr+Xl7cBKsrbILBv3tH3i1QWQNfqPgw7/3d4FDFtTf4
	sYcSD1OKQ3c9wxrz3yc0cYN01ymj7567Mvl5baYYKS+Qn21408z0RzBNhC5oefzsqF2bVz0ZLlA
	TUh5IJJnXOsIomx68lDNXB2lBVFkkwzYKQUbfABTaCMXQKJoCEtv2QHYbr9aiOS1Xz3sgTVsWKA
	I1GVPB1XFj0OrTmtMWZKUO0a+4SYkYyVRpvGE2f9Zyh8Y5B171yHfffXvIj04/bCEFrGqeKugxC
	jGIGfczEZAmqKrONLOdxP/M0zs6MIjtdxpZyPatuA3yQWINGazO5Btk2u9RlDh3EpEcM8vzcWBB
	8qdMmB6lN6ZWCn7UFcodZYoW9XMr0VJqPld4a9NwJoadlJ/h3iEvp2IBW8XY6h/7BceZDdEv62e
	L/CgJVdSnLX9yNsocY1MBomZhbqu362dZLrdSxlNHytA5bEkWJ3UCHinJH4ohpimY1Osu1/Uo6K
	HuhMsCIz3HDl+KUCa/HeTsg90XJ6Fy+0zHxOvdtsRbqLxqrQksE7IzsU9jbAhSxG5P05RdrtWA=
	=
X-Received: by 2002:a05:6870:1d14:b0:448:9d5b:6393 with SMTP id 586e51a60fabf-4a907605bb5mr12049646fac.14.1793817911744;
        Wed, 04 Nov 2026 10:45:11 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea4903e9sm2590963fac.3.2026.11.04.10.45.06
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:45:06 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 7.3.y 06/16] io_uring: keep the drain active when a deferred drain request is started
Date: Wed,  4 Nov 2026 11:44:37 -0700
Message-ID: <20261104184447.516768-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184447.516768-1-axboe@kernel.dk>
References: <20261104184447.516768-1-axboe@kernel.dk>
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

Commit 2295613cd3713beffc8665e956135a5d48dfc208 upstream.

ecb6817b769f ends the drain when the dispatched drain request has posted
its CQE and nothing else is deferred. But the deferred list is processed
in between, and if the request it starts is itself a drain request, the
drain is over before that one has even run. A request submitted after
that point then runs ahead of it:

  1. P0 in flight, D1 and D2 (both IOSQE_IO_DRAIN) deferred behind it
  2. P0 completes, D1 is started
  3. D1 completes, drain_done is set, D2 is started, the list is empty
  4. IO_RING_F_DRAIN_ACTIVE is cleared with D2 still in flight

Anything submitted now bypasses the drain. The same happens with D2 as
the head of a link, as those aren't tracked in ->drain_req at all.

Have io_queue_deferred() report whether it started a drain request, and
don't end the drain if it did. Starting non-drain requests and ending it
is still fine, they were only waiting on the drain request that just
completed.

Fixes: ecb6817b769f ("io_uring: end the drain when the drain request completes")
Reported-by: Karl Mehltretter <kmehltretter@gmail.com>
Link: https://lore.kernel.org/io-uring/20261027043323.98916-1-kmehltretter@gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/io_uring.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 3d715536df72..dd6ad02d0e89 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -474,9 +474,9 @@ unsigned io_linked_nr(struct io_kiocb *req)
 	return nr;
 }
 
-static __cold noinline void io_queue_deferred(struct io_ring_ctx *ctx)
+static __cold noinline bool io_queue_deferred(struct io_ring_ctx *ctx)
 {
-	bool drain_seen = false, first = true;
+	bool drain_seen = false, first = true, drain_queued = false;
 
 	lockdep_assert_held(&ctx->uring_lock);
 	__io_req_caches_free(ctx);
@@ -490,17 +490,21 @@ static __cold noinline void io_queue_deferred(struct io_ring_ctx *ctx)
 
 		drain_seen |= de->req->flags & REQ_F_IO_DRAIN;
 		if ((drain_seen || first) && ctx->nr_req_allocated != ctx->nr_drained)
-			return;
+			return drain_queued;
 
 		list_del_init(&de->list);
 		ctx->nr_drained -= io_linked_nr(de->req);
-		/* it runs alone, track its completion unless it's a link */
-		if ((de->req->flags & REQ_F_IO_DRAIN) && !de->req->link)
-			ctx->drain_req = de->req;
+		if (de->req->flags & REQ_F_IO_DRAIN) {
+			drain_queued = true;
+			/* it runs alone, track its completion unless it's a link */
+			if (!de->req->link)
+				ctx->drain_req = de->req;
+		}
 		io_req_task_queue(de->req);
 		kfree(de);
 		first = false;
 	}
+	return drain_queued;
 }
 
 void __io_commit_cqring_flush(struct io_ring_ctx *ctx)
@@ -1227,7 +1231,9 @@ void __io_submit_flush_completions(struct io_ring_ctx *ctx)
 	}
 
 	if (unlikely(ctx->int_flags & IO_RING_F_DRAIN_ACTIVE)) {
-		io_queue_deferred(ctx);
+		/* a drain request started from the list keeps the drain going */
+		if (io_queue_deferred(ctx))
+			drain_done = false;
 		if (drain_done && list_empty(&ctx->defer_list))
 			ctx->int_flags &= ~IO_RING_F_DRAIN_ACTIVE;
 	}
-- 
2.56.0

