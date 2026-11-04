Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817945;
	b=nTNzFqqow31h0KmWjPc1MGulVEGNrZCAQTs4JMHDtNdvj+eUnkWEQKx6K79dsiY2Wmcw
	 /9fJ0hjlzm5+HNGoZMaOI5hDYdHkPsUfPqq5FZnk/Nxrhq+dr/7AI5r5vJBlrvPXR7625
	 zY1qOWxZT6sumCsRII0upQk/o4cffVI08YectBKJX2aR/3HTdZOV2cJGhR2tFOa45PctN
	 1vSs/c1kURqkDrepLgNHfBOAFoy/CIEx0slQVYqda7fj/TIacdgSFRdCuT6pI1YI+BDtm
	 DR0vYiNp6OTYGzw/9gkFVxrdAbMTRiDY5K0cKaFjhZTxpL6jjnVJBZ3qajrGMMmVfrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817945;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UMI3rMDMAqs9wbraQsIeH+h6ZTTropv4bg7TuESiwls=;
	b=STGxRSr/mMKgKU3QgkJGB12ArNFlTMyXC5VwQvBpxYnrGOdKxnFIiFNanTQ2NXh9jT+S
	 kkxfQScfEvi5kK/fmLW1wZhaA5R2E2n6B8CmF5S7nm1UlveyRN/tFBmmRHKjsjkudyEW3
	 6HuMBmUCh8tx69qOC9Gf0HKy2vkPU5P+tofjnm/GoCsWd3jn2WlzjXeeFXcg3ixNKXnM0
	 vz4Pjjw1s89tB0HEMsP0ZcdQ8WgR8+xKLG/q+gAo65hyXhd1aCTs9UApjshK9nnPQEmho
	 5zQRtJC/kqoMJaD7V6R6YDIJVKaZesbO5TJEw8k5QFA35hV0qGkNbUs5qXLMgOepwpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=OrzuMchx;
	arc=none smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6458B606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:45:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6458B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=OrzuMchx
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6fbf1ba31fbso409288eaf.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817943; x=1794422743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UMI3rMDMAqs9wbraQsIeH+h6ZTTropv4bg7TuESiwls=;
        b=OrzuMchxwgb2DaNQy773cCrzIYlL+iVMY2TxUf2TlHGkS4EtvjSMjqn9rUtMFaIF2i
         X9yBadJiqc6rDBZiyi1ZPc4VaSR7lMGeXd7wCOCOcFDVqwaPhUvPZH8tjYURVg0MqHR5
         sS9JJkIak8n+n2h13diAKnHpEa8OYZ55QiMovt+D5TtIcOA9lq28W8U/sxdlreim7Okh
         cwsnLrmJeM+mHgYXvtUBPGrD3x4Grf8i2VJQHYA/b77u6vD8krPXFxIAAbaaeoWsHTGD
         IsSdqFtc8sCi8pulqMfqf2TnSiwiUNtsI4e/eJ0O5X6Q8AK0zQ+Oc65odU+Zk6Z/Uumb
         fSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817943; x=1794422743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UMI3rMDMAqs9wbraQsIeH+h6ZTTropv4bg7TuESiwls=;
        b=kp9sKzJuJiLWjBJ98QugD+CHhU4AVQELiPRH14AUSayjFE3Spbds70j/fVL5u0B57f
         iDoQShl/MHrlQUiCTbb6PXmgL1ue4o+/fIreuacg7AXGxqUgNOGmupydhP73o1tLzUQc
         E1iNdrHr/QxwEWIhgcDopCbKtvME+VZ5AydfEZGcjp1pXJ/Xqp8KgxhtFuXPwRR9leHw
         Z8uX2ygmry85bCMQfGjBbrEtE+WDw5vIV/Fr0DODtdYsiO7ZfdPxZhw/jYX6zhM1AJMU
         4x5zaE8YYqDTshKIWnimnWsBQw/Y+e9aHshFdZt/JyzNOlTlHK7cUsLxO7rdG+v3epQr
         9c+w==
X-Gm-Message-State: APuU4Z/ed0tYzSqZpxVobeqMS0iVu+rVzoQr8uKVCr9c7cE2MoZqWFod
	L4LGkUx4lq5hhEhojPiy8RAjmcEIRt0jESHqnTmCC4zs7f2XK8VYeBk5IZUvWJQK/QBWq/RebKt
	6s/nGq3c=
X-Gm-Gg: AYBFou0/nKG4bhjrk0OntEERIoB8dq7W3MLKmTS6gDcYOs8QVE6IaYqg6MKEz2+4CCm
	GCnQfug9o7SGYIATsbgObydY/ckCjeB01gtZRRGljLz2Ks+EgicFf1ZuVbvtjujTXgaTNYCpnzi
	5mTFHwyOS7fotmY+Lpgmt1Ry1HvFl3cB8ySd6VKn2Emke78n5UpJhnKYFxBcM/WBA3ePQ2WhZeX
	xwwTMPTqr5ILYAAgtWNLYbvf+QanA9SdJoVbYycIbkaAYchNivrMAy2xNnxJO3Jin5lADPbFsSr
	JrDAgat4hFSYIz0+QjT1lGjrWBZXAlzwy0uOsPNrnHgqSzgAh0InIVqF5QKeoxGvCdtYd9KUYty
	MHHcStfzodNraO7x5lah7oxtMgOWaDWNUeWH451SOfnzPw8OxxD0QLsZHkA92//QaDLogWDyDFc
	CTnTgU8q5Bw7qxJumiG74tQ8ujrmqnp/da/Ffsbzmyi9qIoJHAwit6rNpPTH31efKzY7un0G6Im
	IvAx9i3oxvOtvSaZGNHK3uSeGBjShJjT1RNKePf5zbq6l2YMCs4dB2aeFW1zgkZ/GfQKl8KMofv
	aFo1IOc5YH1tsT7Q0YCR78Ah+BsDTVpFXF19CnUgwPuHPOohdU8Xpky78yD04RdPi0ZJA0Qkaw=
	=
X-Received: by 2002:a05:6820:6703:b0:716:cc90:ad45 with SMTP id 006d021491bc7-716cc90cfaemr804542eaf.50.1793817943270;
        Wed, 04 Nov 2026 10:45:43 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea4903e9sm2590963fac.3.2026.11.04.10.45.39
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:45:40 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 7.3.y 15/16] io_uring/timeout: count cancelled timeouts in cq_timeouts
Date: Wed,  4 Nov 2026 11:44:46 -0700
Message-ID: <20261104184447.516768-16-axboe@kernel.dk>
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
---
 io_uring/timeout.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/io_uring/timeout.c b/io_uring/timeout.c
index ca03cb95ad8d..8e7a4bd7e514 100644
--- a/io_uring/timeout.c
+++ b/io_uring/timeout.c
@@ -370,6 +370,9 @@ int io_timeout_cancel(struct io_ring_ctx *ctx, struct io_cancel_data *cd)
 
 	raw_spin_lock_irq(&ctx->timeout_lock);
 	req = io_timeout_extract(ctx, cd);
+	if (!IS_ERR(req))
+		atomic_set(&ctx->cq_timeouts,
+			   atomic_read(&ctx->cq_timeouts) + 1);
 	raw_spin_unlock_irq(&ctx->timeout_lock);
 
 	if (IS_ERR(req))
-- 
2.56.0

