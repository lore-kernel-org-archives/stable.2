Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068126;
	b=5D7DiFQP4lh/JOn6R46Sbzv0kRAXM7a9XTADxIfuDp4RDLZF6nc0bHO2YZUgxerGPeML
	 5Wy3CHVj/bI8Cls8th0Y3y+VsdEXCRSl/upwqlb5O9UUgCIwqPclZoeqpfHlgh/cTAhPk
	 PRQfW5MKV/AYnD90hN0i+dbPeRv9jjhC6hEG+c/XBs6nM7nnkqwI97NO5L1YTvPTGP3gx
	 haL1jGCSfpKvVoKPNp6PnIlzjouxqbPtEwIntzmryFu2A0EzjBuaRlW547e+/nO0S0qU4
	 /xF/G4M2aCnQsJdHocO2JCiW2+t7v2K/7skiAsuAwmeyILlfigy565qLaarT2PxW9ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068126;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Yq6Pegfjy+m2MAd4YerUkymvdHdEcw3Vc9n177OvMps=;
	b=mNFNWtGRK0RxNQRYGiP/6vy4cMzpuAaNdAej2ofxjV9bMLlNExU2I+rEddfB2ljjTBZl
	 YpTfFKvo89jA98x51pu8BUvJiMepn89A8TK/Sa6Hvdo4+buDLlzIiPCJzA3TLps08OCzH
	 Ijz2NbH0/Tj70bqEYwjbHnE8OF5+5NxiCqHtKqflrZBLovTllHyv7PlWohqU28YW+1zOr
	 2ZesBR9l6RLfDCG69dtQRCdX93tcsYmsI8ltTikC57uAvaKY7UDtXJi+mkRODoRHlny09
	 qTcYnQKj6lwi2YXAk8YHJMIRG/GNNENZHSDNn/SKfuNSGNkfwVlCIsCY3GrB4zMLfXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VpQFWK+O;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C7E606A333
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1C7E606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VpQFWK+O
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b0ae87069dso743471a91.2
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068125; x=1794672925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Yq6Pegfjy+m2MAd4YerUkymvdHdEcw3Vc9n177OvMps=;
        b=VpQFWK+O6o3RxUKWaCnyVx+1lFwHCm2guzZhpToHdt55TZ1GnynheMN1BFilaObMbN
         QNbZjOtPKrEATC7LubHZuMzIlYkkaQWUSvCi2mxfW5Iz+D2fa2K6ve1Ov0P1sY64Ig2k
         PMtNFYWQ5doxk2ACSZbTm/Q3mi6VW5z8f+/gGD0pA85Bx+3Lj3YFMw3uV5HoNSdVtTkD
         tPqDgPFQTPv5+HLTwZFRJ4nsZUNbbecMgDmapr+vHmPiEtFVcqgG5KZlbcqZKcrDu039
         6lVUAsrQjXvB4rYCgkLPQSbeEVdeEBI/oe82S+OQoCvCBlS0ZnmjcZ3cW1teCK30uoPU
         FNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068125; x=1794672925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Yq6Pegfjy+m2MAd4YerUkymvdHdEcw3Vc9n177OvMps=;
        b=S5crgtiaTQe4SQTTMJDdUONLxS0rUYm0HJvU0nFpfZiZ8/+2BMoh0EYjay1t+qBm2B
         YR8kF+bYjWiyexejNskzCRNkUGCjpZuvfQ0VUVJ7GzhwVNT0jMgV5SaMXuQL47FU3F9e
         UsHwlFCRYWKWfHn1Kc42+57AnUutq8NzNqaOff+5KRdNGzYSKPW/f5JQecrjQpxNX4xq
         vxl8gv1WgV6sR5QJYXFgTg6qaddOdBhsXKnIfoNtj3mv846rQzPeeY93JJMuOr+lY97V
         8cOS5yQhbEFQ2nse03UmSB549hasUBU5bzhEfd9sd/33MoHSmqZkEKF2CnW0TPQO/bzN
         oKsg==
X-Gm-Message-State: APuU4Z8KYYLq71tpjH2Gs0unzR+GwZAzq+rCNOR9U+0lguKml7fQ3/Or
	Cot9/DE7y2YahW1bRF+3IWCEZmGQ4+3HNrKFulm5hNcfuayDPy7RN8FdWEuHaVYHr0T14YHqbgQ
	bAz1z6aA=
X-Gm-Gg: AYBFou3W3+AwDuxyqfZWhHiyC2fI0Ea2Kk+XQO1mlgVUkDdSep+ylOeA9TSnbq//Mg6
	Zdj2pSKHXn3rR69Gm1V6Q+1QKfVyEQb/0pXiAHAqIahjzZWuGSItFREts1Vi0/Td8FS8MMGCsjs
	xrmoxPv6hzWjfRuKO91RqwcMxf1LztisYUcqcCq1vokiFQvf15U11NqvQArQz8/Kj9PFtIS21SQ
	hSUm+VfGiF9txWz4ne1GfBnGSbfwGIuNu0BM5Vle/PLykQrhc08znEzsNiSGj1mq2tObY815T7x
	dblXjbjms9FTOIY3HJoOKeN7krD6iZev7iEben08gO9hSk5lI1Xx9fR++2yjbWZAeE2iO8n+9ZU
	VtBHcfK4PMsdCi+Vv9OI3OJb5RTpYcKobrsa31MMvdoTDO4z8VRdbnGW9AdpOMXudWSIUhH6Wb4
	lNpHHkKzZMDjVLQH6lsZR0wvUtZS493Yon3/WfuHDhf4IHNDSyDBOZKboybcOraL1CIHFMonR/K
	Ww2E8IoP9OOFCPLrxnllALMga5Ng8Y5O3M0FV1eEdZPiFuvCCAfnExtTaa16zGuKrKshUzhxIHl
	7rFQmjpTVYK+aTJgYKMrNq1zod1l1ZWzZambziB6sQp++5TL4e9Iyotqt7LLDLYrdq+NrXHeshk
	=
X-Received: by 2002:a17:90a:c107:b0:3ab:36c4:b4ff with SMTP id 98e67ed59e1d1-3b0db6b8083mr6364518a91.24.1794068124744;
        Sat, 07 Nov 2026 08:15:24 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b10585eac3sm3910188a91.17.2026.11.07.08.15.22
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:15:22 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y 3/7] io_uring/sqpoll: don't set IO_SQ_THREAD_SHOULD_STOP on thread exit
Date: Sat,  7 Nov 2026 09:15:10 -0700
Message-ID: <20261107161514.2499962-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107161514.2499962-1-axboe@kernel.dk>
References: <20261107161514.2499962-1-axboe@kernel.dk>
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
index a9400233053d..dd6f279ef17c 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -23,6 +23,7 @@
 enum {
 	IO_SQ_THREAD_SHOULD_STOP = 0,
 	IO_SQ_THREAD_SHOULD_PARK,
+	IO_SQ_THREAD_EXITING,
 };
 
 void io_sq_thread_unpark(struct io_sq_data *sqd)
@@ -340,9 +341,10 @@ static int io_sq_thread(void *data)
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
@@ -419,7 +421,8 @@ __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
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

