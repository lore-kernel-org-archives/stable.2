Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817880;
	b=bzB0WYcFRw+70Mk7Xgnxsr9vSVTEe0u61bDKRbrVW9Q8IwGFVZEh50xMDBb+nLY9uUvl
	 O6Lf6LXZquje1wwV0Xhnvo4wTkrvQrmscSPivQzol2yUXDMCwF069UWYyUCgwHqC/QPgn
	 KujY0R4ALM7Fx5DvEKAiMFd8kcFUSqpDljO3f7tpbMSqOtyJsZVY/3nRphbfNAx6iUQxS
	 SzftO/hKXwOo2ZeuAnOo8FDG7ZzUEL+E2j8+wIfz5rA//72elew4BDGLt2lFmdTUuktsY
	 a5PU88cBmlLtCWM0WePvxC+EFNPCC0ZaFFrbBFLvwuR8T4e/ykxBPQGt7TmraLub36g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817880;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Zg9cDaOUcPVVIlnDKbuThw66w0SAt8rNOpQrBFsKPb0=;
	b=t79AYXAVAOfyFsZqudZL2uykBpmCyfjX8Xznz43XgyHfNxqKy69+NbJO591RQhwRIz/i
	 enSa24dANdGAQxni8thL6WAtcNEsZZ0kE4UJvdI6yhzoJ2BqSyqNMpUTCyFExyoI1tcNO
	 V72RU8hWQHEP2ePPD0VMgUkRpC/T9pHKOCv2SvVQFSxQOgz11QCdfOCEJaux76r3bKaVx
	 cqlDayRN9V5kcfclLdrDiU9NvnoQ8wzKpPczSs8sI/VI1Fxj1xPGIQRhg2xnxBt7HjFDj
	 nJ5uLqnAZPzY68vhCmWQ6kYWh9HUBm+8lDpgUXn3/AKWZuFLnkqYdZ+Iy/YoJWA+2sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=YvcVZr5b;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0FA606A328
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C0FA606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=YvcVZr5b
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7f48c750afcso731454a34.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817879; x=1794422679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Zg9cDaOUcPVVIlnDKbuThw66w0SAt8rNOpQrBFsKPb0=;
        b=YvcVZr5bw2atP6MkiDHOvcwAlvpO3Ahrkn437s7Dwq7tKEgQ748iccNDMMs6FtDXE6
         9Mdbm/cO3yzc2hNh4APzuI8EepHs9BWI5bXmtnZlqqyXZYBINWKunlBcmwOYUwLBDe8I
         8HVErwKqlZpk8aYzXwXYZkhgmUDn1wQckd3TAG0iY9TLcg9MJHStJDLH9Dptkc4enejj
         /+PBLNZVgEzf+v7W+LDG/xVI4zzjftPdJaV5J07DtgxafAd8sCEhqFbpzokhx85IKKB3
         9MhxuWU1WdBi3hpXdNQqJjFDJawmZZ1KysN+xcchKTpipVqWmnY3gOMkNuEIGpTUhUkc
         23MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817879; x=1794422679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Zg9cDaOUcPVVIlnDKbuThw66w0SAt8rNOpQrBFsKPb0=;
        b=mcCitcrNwx3k+k1SgmbGXP1BgmEk9dVb+net+eaAdix+zZ2PfMdtWcAiXNaH3mX7pK
         YLPUXjnE4kx6DZVC7C4DbNo4pju2IPtIDPqKgqG2mDCZttEhzv3yVXvi0w7hTbv/u1ye
         bIdWrm4vnphzt3JKlgKjbhrd7x0aJJ0P+wUL2eKlCFgt2PmJ1ymBM9OjlDuu3mbQ2v48
         BSkWYbKxw/21hDC/c5tO7Yb88RcxwikDKbGc7Ngl0+mlmyBfQBHdVv0d42/N86DHQacv
         p7SHPOsckDjHmKrNHSsXdA7+6h2qzz0MvSU01f4IJwbgRVDVVP/abcViNk92SMEBwLWg
         vVrg==
X-Gm-Message-State: APuU4Z+U/R/4P9PMe+613K00+vB+VB9BND62EJY1J9l2tNnF/lYbRFhV
	XnNKXMklCA9Z94cDdzgGx0G9tg1oHmVvtZ8hgAc2IdZc7xNqaA+VmegW2MA/aNPh70v5/s/rY6y
	me099Wv0=
X-Gm-Gg: AYBFou2kMb5Lqjem8mpBOHTm6g8no8dqokJ61QckvSxUeP1fIizezmpIrlSqe35Ih/c
	9PvSWwCoUYD8PI+bj9TK0v2ozzLd4AHvhRtqucDL6Ln10PLRTAhhE6BoaVRw20DPFoQiOqF/Lug
	nVqeC5FMNCMmq2ybG5fCO0qcxSX/+LJNWCcnl+dpF18iEu0Tq9xkGgLqbEQUFiIrNDi1/5kpz2b
	Zdbi0Xwh3k87BOgoLz5CG7JfvRXsKNW7p8gEbpsP2QvexDkx9vthe9/F9pGxA7no1fnkZjWSb5G
	SbFvxHthZcABgL+02ywfCXl+1FauCcLuIEWkSFU/ZLzg3J4t4eNv3gqEZK5unGSUe22uJe7P3yX
	Mtf2VhjhtWc330h4tvaERB3I9RyLtLbzruOXZzR2m2iOfEN3ueyQusj0qZTq3xoVfPdSDYC0eFn
	zs6mJ89Dak/AshEd24gmSTAUjPPFupkFIEicHT3QKXQfOW1ka5GgAwd732nDd2mjg92kJ1A7bwQ
	pLZRweefGThiPPiSq+DHp71w6jAsZ45zVSmv0Sb2pzkuL/NLIzZp68hRnZflzJigcgkDENTE0Ig
	xB31u89YimDKOsJkhlTu8H1bORocRnz+oaCP1WwHQP8J9ID7jnPxd+wEGHpfIfZBDiEVieg3tw=
	=
X-Received: by 2002:a05:6830:3e03:b0:821:cee2:489e with SMTP id 46e09a7af769-85d3616574amr13431518a34.2.1793817879194;
        Wed, 04 Nov 2026 10:44:39 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85ef3e16ef1sm2540779a34.14.2026.11.04.10.44.28
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:44:29 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y 10/11] io_uring/timeout: count cancelled timeouts in cq_timeouts
Date: Wed,  4 Nov 2026 11:44:11 -0700
Message-ID: <20261104184412.516558-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184412.516558-1-axboe@kernel.dk>
References: <20261104184412.516558-1-axboe@kernel.dk>
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
index dbbb9615ec9e..2637c8bb61a0 100644
--- a/io_uring/timeout.c
+++ b/io_uring/timeout.c
@@ -327,6 +327,9 @@ int io_timeout_cancel(struct io_ring_ctx *ctx, struct io_cancel_data *cd)
 
 	raw_spin_lock_irq(&ctx->timeout_lock);
 	req = io_timeout_extract(ctx, cd);
+	if (!IS_ERR(req))
+		atomic_set(&ctx->cq_timeouts,
+			   atomic_read(&ctx->cq_timeouts) + 1);
 	raw_spin_unlock_irq(&ctx->timeout_lock);
 
 	if (IS_ERR(req))
-- 
2.56.0

