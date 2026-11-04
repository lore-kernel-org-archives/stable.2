Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817833;
	b=QKjPq94RrWgd61Dj8feOFIuZVFcFYKGOlDOYCeMrsoIs04A3FbKDZaqfHwABI6D9w2on
	 9o8SE0nVkMFZpXGqxM7EjL5mih+UbfkcCTH8i9gckGPGf4oxWLWpcLR/Rgc8DWMauOe6a
	 MknTDsKFc2ubvJO0g7Y044fWDACb3b+brZXySvMB/A+dj4ctgqhDrNsQOeT0QXlFEIvtb
	 Y6CNuRLmWiFsYDbpzGb4wt2gXqy93c7pmWwe72f6nLF/wfyCUUVF8HeH9a9O+FNCHsvwd
	 BeFNoqba+DR4HuB10TGw6lGYEUdniAmc0Qbd7TnpVh/IFynQv+s/QIOybvCwODFon2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817833;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aBwQbZTBcE+5vEX+EIhf+kgyy7Q/EWlwgs+L+/bLmaI=;
	b=ZcAQNlitB4Hc9ygadb09gM/u09xP6EnlCyVTO0Gj6FmHLIimkz+THjvilcyQrDGV1yj5
	 Zswudsoq09ZWoE7VK5BtF2zbC3utBF0liN/Tukq0CqpP9X5Wa8Re+UZAYYxboHj94JK1v
	 6Zxp43DdLlXB0lh0UOljWVMNBoS3vqLxywUub1lIFBw0B8DnTTJDOR/xEV7/ycBoJ4yoF
	 eMUFSHCxoIjyUH2CxD2I2xPInqtq7+/bnXuTMpM+WjN6fLDjJE4xDKOtC7KO+DraiW+4w
	 briaYVQbRJrRnqNNf27qhlkg4tmsWmh4IOkup0Rhi98tdeNpU+d9uX0iq1KBJV9y2Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=grwOwoSe;
	arc=none smtp.remote-ip=209.85.160.51
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F0A606D82A
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0F0A606D82A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=grwOwoSe
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-48e9476e26aso431186fac.3
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817832; x=1794422632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aBwQbZTBcE+5vEX+EIhf+kgyy7Q/EWlwgs+L+/bLmaI=;
        b=grwOwoSeWax4QFyLQEopsD8dKZuVl8XNg3dW9DwY0j3ym574n6llGfchwGHvnX7CUV
         o6LXcWS9GOdNUaTxwLAqatxp1xmfC1GEykuuwMYRTrUB1V8EfsS1uRoNPHjaomRpk1fx
         YN6rFxfXoQfS17qhsGX6R93bMD5O8IiDsfUagi6rEVblt41uccMkCYXoaKKCrw8g36LZ
         reaqnmgA9h8b32Y6mKQAhISeK888033o/w8GLiUElkRr6BzCyWQ91m6wo/fpp0LWPmAl
         YP51S9C1yvqkqjZwulfQZsaKXQXHqUMKESwRgiZQ0WnkWUHPdLu6tvZsBNvgfYaTxAqC
         aUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817832; x=1794422632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=aBwQbZTBcE+5vEX+EIhf+kgyy7Q/EWlwgs+L+/bLmaI=;
        b=htsFDf/pU4P/WLI2nmktyiHDoWBpJf8EniwBKNW4+hnU+anwDW2ksgOUym4rJHX1vX
         cEdjSLwZTT9VcV9IVk04jFlv8Vf3gAqFzXm8z0HXUA00CpsNHDU1IUWXAhpfBeLqQLbj
         XQ3fCU/6IiguHqX33W4wB3M8rJS09WcL+fGJJ7S+5dLNMK6loTvONtnG8V8uhquq5O2y
         rIPCQnJBIptXK3POYiI1avUBHmVdCfAtFEtlRki7nbmnZRW1BrdmaN2lKEvj+vjvFxbJ
         psmk/4JZC0QgYYaeRM6lK3ms3M0MalXsY3G2utMW9pdOY3ZVtxVRAaoPvZN4tzjIp0Sl
         4Fng==
X-Gm-Message-State: APuU4Z+gXMEGj3ksCMXZyPkEx1KtGaae66tW/59UulswaXEjHbVp/oBV
	ISqKXB2bFpB1MZSQOGiF+Js/6K7CFQ9BViKvIgBUs1jJ8Tt0M0p+HtRCPH60LIgqV+1t8aBAoWx
	pHRT2KMY=
X-Gm-Gg: AYBFou3T5ntlwqrRlR44VItvbYAFG4oQmt3bZGf7Nh0gZARnH12RWIeIsDFlpnHNESH
	9V9NRVfACA1sXKT+tdA0Ew7Rs7eQeq12oQ94BfY+MwTmRDrD1fmGYXzol6aX8wBf1wuWzGv64ge
	8U1cytUWexOCdjcNRLxIQlpl0eK8eXCFN9VLT4Tv4UDpU9P3UGEASkhUGd2d/8aaGiSGfE4jcr1
	7ahEFeZoQr3c4kC+qjy2XSVkgv9SLjzXFTMsHLhJqQq7Puo1/bGS2kirAJFEHKxDxZ9NImAdKAh
	AeiPSzHyGGMu/pT30+OZ9M9+itRI1/uN7lt6eXR7OOrjWeC2mHKAr6P41LM+ujQYSYecOtk3ORE
	Fg1KIe/NXtjU1Z81lc6K9grhlLVskQ0nauzuoPtZIsUAxYS3d0OYYe0Scyjsy4xoi5gSGh3vGXZ
	RjuGflxBFl9uM0mNYl4az0TowpAnPA4bJ1DU4NZkz4xceMbKtYRt5INqSljy/WBdewWVfKYemOm
	CX7cNw9S866yusWgWD2DSqSV9zjt3XZBcscMTvypLcAsZl700WL36dEtBhE++NqrGoyB3xs+wbr
	n2BgOwKSfnPzSnDmZXoofLWVyvArZxdkhxNBcvRiJog09PYDfwyRV2Ro0QjIG1s5lc1MOIIZFQ=
	=
X-Received: by 2002:a05:6870:21ca:b0:4a6:9798:7733 with SMTP id 586e51a60fabf-4a90772706cmr10789294fac.48.1793817831782;
        Wed, 04 Nov 2026 10:43:51 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea61d382sm2595770fac.13.2026.11.04.10.43.51
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:43:51 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 8/8] io_uring/timeout: count cancelled timeouts in cq_timeouts
Date: Wed,  4 Nov 2026 11:43:41 -0700
Message-ID: <20261104184341.516297-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184341.516297-1-axboe@kernel.dk>
References: <20261104184341.516297-1-axboe@kernel.dk>
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

From: Cheng Yongkang <teel4res@gmail.com>

Commit 1c8b49851543f41fc8bb18bcd1f15cc93d14b530 upstream.

io_timeout_cancel() posts the cancelled timeout's -ECANCELED CQE without
advancing ctx->cq_timeouts.  io_timeout_fn() and io_kill_timeout()
advance it for every timeout CQE they post, and io_flush_timeouts()
computes the number of non-timeout completions as

    seq = cached_cq_tail - cq_timeouts

to compare against each off timeout's target_seq.  The cancelled
timeout's CQE is therefore counted as a regular completion, so every
cancellation makes an already armed off timeout fire one completion
early.

A ring with a keep-alive timeout of off=4 completes it after two NOPs
when one off=100 victim is cancelled through IORING_OP_ASYNC_CANCEL, and
before any NOP when two victims are cancelled.  The cancel CQE should
count, but the cancelled timeouts' -ECANCELED CQEs must not: the
expected counts are three and two NOPs respectively.

Advance cq_timeouts when io_timeout_extract() succeeds, under
timeout_lock and before the -ECANCELED completion is queued, matching
io_timeout_fn() and io_kill_timeout().  The -ENOENT and -EALREADY paths
post no new timeout CQE and keep their accounting.  Both the
ASYNC_CANCEL and the TIMEOUT_REMOVE path go through io_timeout_cancel().

Fixes: bfe68a221905 ("io_uring: off timeouts based only on completions")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
Link: https://patch.msgid.link/179328314078.648427.13761781546953594668@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[axboe: 6.6 uses a regular spinlock for ->timeout_lock]
---
 io_uring/timeout.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/io_uring/timeout.c b/io_uring/timeout.c
index 71f28e92affd..df9ef01ebf19 100644
--- a/io_uring/timeout.c
+++ b/io_uring/timeout.c
@@ -306,6 +306,9 @@ int io_timeout_cancel(struct io_ring_ctx *ctx, struct io_cancel_data *cd)
 
 	spin_lock_irq(&ctx->timeout_lock);
 	req = io_timeout_extract(ctx, cd);
+	if (!IS_ERR(req))
+		atomic_set(&ctx->cq_timeouts,
+			   atomic_read(&ctx->cq_timeouts) + 1);
 	spin_unlock_irq(&ctx->timeout_lock);
 
 	if (IS_ERR(req))
-- 
2.56.0

