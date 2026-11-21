Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296675;
	b=j+yQ7I7BvVq54ahFUEyvLuicVgAJaiN3adOS8fH9OqIPCH+EEUQGsZXqrGPp627GguxG
	 o2E/DHkq5fC2rrCNvYt4X2zw2HVSW6aodPVp8GllVBqZpW8kqaGkWF1YsqdJF2r0Rvaor
	 /ISCWeTn+Xh29+07ogmnTKSud+cGgp/DcLRhAxI/L/Gk/1EpgBT8rE8EXD9BWMDZgDvCH
	 L5vzZ/8hhaz3N783j5xcyt/87kfQC9uwZOXI2NAwItQ+xzVUd+CLELuI0tc+BdxSlHdsb
	 8M+eMXg/Kte4HmzxYr48X0zeMzqHfHHQKh+kecYQdAudkdcCbguEZ9YDf3ZqB/VLFPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296675;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WOSOvk6i9UfjF05LnH6p+0yEMB2u2ArTmUF/Nu2tU2s=;
	b=0+1LL/+YqAcFB0kqISyTk8XNsuI3xsGRegweykyflLXZVce5Qo26MZ+2+2gbzbfj9iB+
	 OiC5H4T6KSu+dbm2XCgBVpkRVQMs3/I0yjrdn8+OTXillZUgARFy8rHVbridKPQLx49ae
	 9UC9uSmK4bx4HoLUhJrpBnRs9lKtSE5wka23/Le+t8uysBvriZ8EVy8wsHvHmpkn/zYOi
	 vBhXNgXEvMwKOvt1MpWN8mu9tDHn3hEq8DBuI4hzuxk8lPWhAfk4Bqg4TgMpVjCTUZsjL
	 /RWqTRLS5gRwJyQNkeciRHn3JMVfH6GOnV4cUh3g6pu+6rkV5OG4fA5dtVWTddprSQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=tQVHc1jU;
	arc=none smtp.remote-ip=209.85.161.48
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76E2606A6BF
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B76E2606A6BF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=tQVHc1jU
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-71ad099391dso959874eaf.3
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296674; x=1795901474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WOSOvk6i9UfjF05LnH6p+0yEMB2u2ArTmUF/Nu2tU2s=;
        b=tQVHc1jU5bPaWXfQiXqARLn3rmP7w/CQSJOoSZTjs8GIAiSGtBllfF2ZNw3U+nkyA7
         66uPBWfJN/hF7YWQ4JV5BjnxIi5SPZ1VHcIe9w1DtvCMlRm8pXiXFYIStBuctqfiDkU+
         ta4p+IV29nyCBCl+TDp5zu5ebjUbmW4YPszb9ICH1yjVwr6W+Gvqzr72c2ztmYrOz92m
         KoDjFCLoSDfNnfahqobWVXApuJ29GsRgJMF81lGEwmn8BDHMY9km6LdD3AgNeRwWARgN
         bINHskVCXWSWniCsmL4ZnowMaoFkXUPv/oU38s2yWcrlW09xT438PhB3EoofK3ml/yPR
         em/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296674; x=1795901474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WOSOvk6i9UfjF05LnH6p+0yEMB2u2ArTmUF/Nu2tU2s=;
        b=dDvQj9PPF/DdSZFq/9W5rNoQ/LwR0w6Lu8TxK6kXxAyGBpHFXwRsLSNVpQCXB7sJ09
         iHHZsLTMEhKKjwZ3PEdQrMgujKn3GRBsghYU3qYzW/R4QcATE4KIf51TWvD0Ro7SmHU2
         oN/yGW+F8fnjjbl654WVCeQpqofLY/z6LfqtMjX7kOIcIUv21X93EWME6HNibODLFuxT
         +jp1VSwrNw8sqUPb3NjqjlciT85+evArxmFIdmrhAw8eHQrxV9ZIO5Sa0M9ZW8MbT9kJ
         Qt3W9rC9NZeDq+T27N4QHhRV+nuB9CgE1dmfMr6vqnvwA7AFNj75Dy33ZIGaZsCoNsmT
         RGfg==
X-Gm-Message-State: APuU4Z99k459OzKuqrQefyOSCyCLFkUpuhz7eBeq+MijkyMFpXOXb5hq
	LONz1XKg4t0HhrKLcRDTFzu/u9CjMIFKlFRQuIwAkTYo9h1wqm7Ks+Lozy7W3wnS6/ATdlAYady
	gpvD2EFg=
X-Gm-Gg: AZFdTZdAxh1dQwCrODgJCZim/mP0+rpRF/ACKuPB1cejKhLknkIZgFuaVyEedXtf7bB
	MjzoZbgTXaCrqomtMYxCvubYQmrytlZ/oZR2T6xgqP9zBxplGaR3XcPhHck4gRmlsXdIYOvnkGz
	8uSw4Km3oWvUr5uWgPEm2zWzkF2eRM2S+bhPY7vX+SnPK/omX/O3X0sxp6A6im8DO7M5876Ubob
	nyCSJkVfwFJBl9VW2EkuNs/iwmbliLwbW/9yIvkXQ+L8B5/FZulkz1DXed1cqX7hnXxoP7lEY6u
	58/LEIg/Th6NhP+TUMC19f3Dc/ld05FqqNbatKXw3gxOHWOpIyjSas0sL+gDFeP3EqkfnYUpsC/
	blRVD/Eyn6twhV8jSt7OG5piSac/TW1/zjDcD85UYXOhN8b4BpM3j99k1o8iJ2pSQk5GOMlq+MI
	/Fqy++lDDvQyNj79CiaOsG6QtYUXKtkIVrtwpvxAgrNHuAvwF6qzG/olFfewuiiDAUA58bTOrpE
	iZ0X6wu8Oj5eN+oTSGL/eBEGB5jJvigTogFtz8Mkmj+BneBFFmjkVgD/k6/gDTVyZKt3/fBaAUC
	FqfOOQ1KO1zWQNt3Wk4KyCmhn8Kib5O6irOjRm7Ey0pEpLL/IWY7cYLU8fbVjr8E5AG06AA/Ov9
	/eUxPNofQfaIBgiyGfEd2jBcczqwsXhSZik2a
X-Received: by 2002:a05:6820:1690:b0:71a:eb96:f714 with SMTP id 006d021491bc7-71b39554e43mr5489003eaf.67.1795296673710;
        Sat, 21 Nov 2026 13:31:13 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b38015c46sm4469155eaf.4.2026.11.21.13.31.12
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:31:13 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 17/19] io_uring/sqpoll: Increase task_work submission batch size
Date: Sat, 21 Nov 2026 21:30:47 +0000
Message-ID: <20261121213049.1788332-18-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121213049.1788332-1-axboe@kernel.dk>
References: <20261121213049.1788332-1-axboe@kernel.dk>
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

From: Gabriel Krisman Bertazi <krisman@suse.de>

Commit 92835cebab120f8a5f023a26a792a2ac3f816c4f upstream.

Our QA team reported a 10%-23%, throughput reduction on an io_uring
sqpoll testcase doing IO to a null_blk, that I traced back to a
reduction of the device submission queue depth utilization. It turns out
that, after commit af5d68f8892f ("io_uring/sqpoll: manage task_work
privately"), we capped the number of task_work entries that can be
completed from a single spin of sqpoll to only 8 entries, before the
sqpoll goes around to (potentially) sleep.  While this cap doesn't drive
the submission side directly, it impacts the completion behavior, which
affects the number of IO queued by fio per sqpoll cycle on the
submission side, and io_uring ends up seeing less ios per sqpoll cycle.
As a result, block layer plugging is less effective, and we see more
time spent inside the block layer in profilings charts, and increased
submission latency measured by fio.

There are other places that have increased overhead once sqpoll sleeps
more often, such as the sqpoll utilization calculation.  But, in this
microbenchmark, those were not representative enough in perf charts, and
their removal didn't yield measurable changes in throughput.  The major
overhead comes from the fact we plug less, and less often, when submitting
to the block layer.

My benchmark is:

fio --ioengine=io_uring --direct=1 --iodepth=128 --runtime=300 --bs=4k \
    --invalidate=1 --time_based  --ramp_time=10 --group_reporting=1 \
    --filename=/dev/nullb0 --name=RandomReads-direct-nullb-sqpoll-4k-1 \
    --rw=randread --numjobs=1 --sqthread_poll

In one machine, tested on top of Linux 6.15-rc1, we have the following
baseline:
  READ: bw=4994MiB/s (5236MB/s), 4994MiB/s-4994MiB/s (5236MB/s-5236MB/s), io=439GiB (471GB), run=90001-90001msec

With this patch:
  READ: bw=5762MiB/s (6042MB/s), 5762MiB/s-5762MiB/s (6042MB/s-6042MB/s), io=506GiB (544GB), run=90001-90001msec

which is a 15% improvement in measured bandwidth.  The average
submission latency is noticeably lowered too.  As measured by
fio:

Baseline:
   lat (usec): min=20, max=241, avg=99.81, stdev=3.38
Patched:
   lat (usec): min=26, max=226, avg=86.48, stdev=4.82

If we look at blktrace, we can also see the plugging behavior is
improved. In the baseline, we end up limited to plugging 8 requests in
the block layer regardless of the device queue depth size, while after
patching we can drive more io, and we manage to utilize the full device
queue.

In the baseline, after a stabilization phase, an ordinary submission
looks like:
  254,0    1    49942     0.016028795  5977  U   N [iou-sqp-5976] 7

After patching, I see consistently more requests per unplug.
  254,0    1     4996     0.001432872  3145  U   N [iou-sqp-3144] 32

Ideally, the cap size would at least be the deep enough to fill the
device queue, but we can't predict that behavior, or assume all IO goes
to a single device, and thus can't guess the ideal batch size.  We also
don't want to let the tw run unbounded, though I'm not sure it would
really be a problem.  Instead, let's just give it a more sensible value
that will allow for more efficient batching.  I've tested with different
cap values, and initially proposed to increase the cap to 1024.  Jens
argued it is too big of a bump and I observed that, with 32, I'm no
longer able to observe this bottleneck in any of my machines.

Fixes: af5d68f8892f ("io_uring/sqpoll: manage task_work privately")
Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
Link: https://lore.kernel.org/r/20250508181203.3785544-1-krisman@suse.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/sqpoll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index bde67560ace8..3d0fbae80938 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -19,7 +19,7 @@
 #include "sqpoll.h"
 
 #define IORING_SQPOLL_CAP_ENTRIES_VALUE 8
-#define IORING_TW_CAP_ENTRIES_VALUE	8
+#define IORING_TW_CAP_ENTRIES_VALUE	32
 
 enum {
 	IO_SQ_THREAD_SHOULD_STOP = 0,
-- 
2.55.0

