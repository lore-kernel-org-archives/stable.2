Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068151;
	b=nCcNFD4Y8I7Jq94DP0T4OECs8cmyJHef55Z8p5WmM3iM3qk0b7mZaryRySJMtNbmZRIA
	 vEpkC9biS0TNcfWbKvIpMwNuac0s8c4yQysed6OXTLvQ8cownBn+6sZ6F1jYFj+1VuWvs
	 FKt0/062Pq06wNw29M//NIDVIhdtKWX4a4MxBbo64LgBwxiwstTaAg4XeN0J5v+Hx2ypk
	 5RKbpbR7FME6GDRDeyJQRL/UpZ9OJi5NUaKlF5z1UYVL0OWDsF4y9/MzqSXm05ZdzP6yB
	 RFKI4oY/VI2sMkX9cbnWP4rT5tuQKPAHKAd34fd8zRZ7XgVb8frctk+96ntGFLlZq9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068151;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aJfEKKuByXkZCwaCN7GqCvIyNEawEyIvcC5wyaBtZdk=;
	b=tdPK+IrQl3eOvJmn2Tp74OVezNALtLvUkaQcTd9+nuBe4U8ohI47RX9MtDsHn5Uxjg0I
	 ZPNYxBr7h3+wYhHtrW1mx7jEP/o4jtqcBBtpW/qK7vDKDyrZtFS+nLBROXEuxzxLlB/mr
	 EupSXxociH0TYZolJFnsOWGxSvwVoXaP1PUTHEW4dsnReTJx8/pIjJXpmjqdCgHIZUper
	 yf1Tez4OM2TMW6SrrMGscWVMctsrCSAwtd7VPSNPv5QMgSMLPWyxYvDkvpZHvS7K7iDwa
	 6F7XtLN1d6T+emAWMxxc4+QkbpxyuJ8U+Z6G4GVy6dRPJwWMvqEqQuViYNQpxH0QOGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=se3iMPZm;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ADD606D3E0
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21ADD606D3E0
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=se3iMPZm
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e9d1114320so13714375ad.3
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068150; x=1794672950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aJfEKKuByXkZCwaCN7GqCvIyNEawEyIvcC5wyaBtZdk=;
        b=se3iMPZm8awAjhSHbwaXeo6qFa5ElzccAAvYqMNTDb4YxrsEPSPWvTOmAWznGDtxZl
         RK8DRs3YxKr72K8xeMRflbafE0xXOBH7QwIvCJ9jhaVR/Ik7honLVHZnSNeKUMWePA7D
         pOGdX6CjW0ecLuyVnI1YNfmvKJur/8WynRRcVjc68drjmX3fVRR5m1SSAJHyBTbDNPYN
         w5bVLZka9lMHODmKmSd2E3eLloP9nooE+MSKiKQ724YF+qU2ITNhHcigLzCTGWBIKFWi
         FVkNp9Ats9VlHiaol4Quuw6H2355vbLNt8KPSUxRKEVauvtVxCNGXzUIcpZ9E27HVyT8
         vWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068150; x=1794672950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=aJfEKKuByXkZCwaCN7GqCvIyNEawEyIvcC5wyaBtZdk=;
        b=rMvbyiHHKzCn1/AR26SMBXx5MlkZksiOD03e+IoLSKUFqunzvkBKdPLfQle7/Nrm4A
         HStQGctCxcOhklL0a1G/6Dz0KLvBY3NMs4c0H60kns9lVYeR7PfS4yoKyQOUmQ1IyBXI
         kze6FZSqC/8hqAF0n/hoPFwubjQUD5Mn4H7p0GYqDkt/1iW+fDhE6XukFSL9QTafQrsj
         XBtAsqNenDbyt43VFu2hxZNuYa7EmiEREM2L8aHK0PArhaGiq86yvI9A60PGbLTHs4Tz
         vAjGugSQpCDcMM+C1AmXIkz9Egopfba6K+m5VS8AMQVfCA3hr+8gmU6qpm6BNyugE96U
         ABIQ==
X-Gm-Message-State: APuU4Z8TCypBhN9bXm9whrDjZto6puF5D+v8hD183rsZDpfIy9RccE5P
	a6XT3l9iDEiEHPJ+6zMd/Rnyy0wjC+28OO/U6+ClzdXrPlPPWP1DWuBYcFC6k3NZwvkLMNKYkNH
	ccjtlXQA=
X-Gm-Gg: AYBFou3dy7mCC+qecvuwp/uaAnhofp9bpoHKfEEfD5DbuuaCua/49HKrqopFZPJrt9G
	Hk8NecvrTZlt1tnR9iEaSEsV2qLqR1dI7tHujGWUXhrw7c1GFSjHzx6+TGHz2eksfgMy9HNEh0X
	qo/zSHwhOLJey7djMWiSOlRLK2d7XKlhqSbr27f2UBhWc7nxv2XLbx916CMgP/vhMpQvQPxuTrp
	9vu0iFz8UwlRtKHvHv+AJYNVsVqQiL36n5368mlf1Ns+qtAscp4D4A+hsp7bPtdKSuwyc+188oA
	2d4cHvVJLWkQfLjyHR09AnC9aSGxoQf1or1WlpzkW6OC8Zgb6xSRQERqIXIHKA3O3AU8yYi0I3Y
	0thw/egKAFkALe8rTZKENVaCG+n2whzCbm5KQD+THoNQbUt6PJ7nwykTwxrxapsxXC7eES9iQwo
	1jTjimUHa6h947zXCXu9UgBt87a377ns55dcLid1w9gykeQg+WP/bDAfv6bQzQtuIIKZz62yu3I
	i+Q/l4/ggikYCJjUTuejAkwBzP5d9b71XCuUxwF3TIzGSTYdV8sk9M+SRnj/C2MQgL2VtqKqkQI
	EqxT+Zqx8tqlXQV1GfltVs+wkg9dlKO7HUtjxklsNgirPmNNCdTwZWEtu1MD0QmlXlCO2iAKGm7
	5
X-Received: by 2002:a17:902:ec86:b0:2ed:1cf0:4cda with SMTP id d9443c01a7336-2ed412fc4eamr65108805ad.8.1794068150371;
        Sat, 07 Nov 2026 08:15:50 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d5f234sm13144985ad.46.2026.11.07.08.15.48
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:15:49 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 3/7] io_uring/sqpoll: don't set IO_SQ_THREAD_SHOULD_STOP on thread exit
Date: Sat,  7 Nov 2026 09:15:38 -0700
Message-ID: <20261107161542.2500190-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107161542.2500190-1-axboe@kernel.dk>
References: <20261107161542.2500190-1-axboe@kernel.dk>
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

From: Shuai Liu <847807867@qq.com>

Commit fca3ff9e2eee7d285585daf51942e0b5e2be354a upstream.

io_sq_thread_stop() carries a WARN_ON_ONCE() asserting that
IO_SQ_THREAD_SHOULD_STOP isn't set yet, i.e. that stopping the SQPOLL
thread is never attempted twice. Since commit 22d9db9fd64a
("io_uring/sqpoll: don't attach to a thread that is canceling"), the
SQPOLL thread itself sets that bit on its way out, so that
io_sq_offload_create() won't attach a new ring to a thread that is
canceling.

When the thread exits on a fatal signal, the bit is thus set before the
ring teardown gets to io_sq_thread_stop(), which now triggers the
warning on every such exit:

  WARNING: io_uring/sqpoll.c:88 at io_sq_thread_stop
  Workqueue: iou_exit io_ring_exit_work
  Call Trace:
   io_put_sq_data
   io_sq_thread_finish
   io_ring_ctx_free
   io_ring_exit_work

Introduce a separate IO_SQ_THREAD_EXITING bit for the thread marking
itself as on its way out, and check it in io_sq_offload_create() along
with IO_SQ_THREAD_SHOULD_STOP. IO_SQ_THREAD_SHOULD_STOP regains its
original meaning, "a stop has been requested", and the WARN_ON_ONCE()
holds again.

Reproduced with an SQPOLL ring and an immediate fatal signal: the
warning fires on v7.3.0+ (22d9db9fd64a present) and is gone with this
change.

Reported-by: syzbot+675af112519ca34f5502@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=675af112519ca34f5502
Fixes: 22d9db9fd64a ("io_uring/sqpoll: don't attach to a thread that is canceling")
Signed-off-by: Shuai Liu <847807867@qq.com>
Link: https://patch.msgid.link/tencent_BB08960D79E0261B5C1EB1E589787734E907@qq.com
[axboe: trim excessive comment]
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/sqpoll.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index d0f4f05397b1..75065de8d7d3 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -23,6 +23,7 @@
 enum {
 	IO_SQ_THREAD_SHOULD_STOP = 0,
 	IO_SQ_THREAD_SHOULD_PARK,
+	IO_SQ_THREAD_EXITING,
 };
 
 void io_sq_thread_unpark(struct io_sq_data *sqd)
@@ -348,9 +349,10 @@ static int io_sq_thread(void *data)
 	/*
 	 * Cancelation drops sqd->lock while it waits, and a ring could attach
 	 * to a thread that is on its way out. A fatal signal doesn't set the
-	 * bit, so set it here for io_sq_offload_create() to see.
+	 * stop bit, so mark the thread as exiting here for
+	 * io_sq_offload_create() to see.
 	 */
-	set_bit(IO_SQ_THREAD_SHOULD_STOP, &sqd->state);
+	set_bit(IO_SQ_THREAD_EXITING, &sqd->state);
 	io_uring_cancel_generic(true, sqd);
 	sqd->thread = NULL;
 	list_for_each_entry(ctx, &sqd->ctx_list, sqd_list)
@@ -426,7 +428,8 @@ __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
 		/* don't attach to a dying SQPOLL thread, would be racy */
 		ret = 0;
 		if (attached && (!sqd->thread ||
-		    test_bit(IO_SQ_THREAD_SHOULD_STOP, &sqd->state)))
+		    test_bit(IO_SQ_THREAD_SHOULD_STOP, &sqd->state) ||
+		    test_bit(IO_SQ_THREAD_EXITING, &sqd->state)))
 			ret = -ENXIO;
 		io_sq_thread_unpark(sqd);
 
-- 
2.56.0

