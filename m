Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA2D4219E7
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 18:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785437710; cv=pass; b=bhqdpid3gmZuisSbHaixBuHZeule6OcbBhtPM2EGK94Z0Zvst9qpI5YZUu09rEecTj+vVOwVyqDeNnOz5q/1NGR535Y4ksNMJx+cURiqk4ogjiaamklv8ItUVPBgFJ0xN7Jlqyhth4q3DZ9Z4GCOVyLGhc5EgbZNPymMN4hC1Jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785437710; c=relaxed/simple;
	bh=5YXmCpAaOk6QqxLkbcXfgNTAO2qfKu1DivCGNjzW1Hk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dLNX1ZTVs4xLVn1MRD5QiqM/QtmuQuP93vFsbWNVnZrpug5JICAA0wY7PY7DVdFTr5iQhq7trpgYJCx9EsrXVncngnKHQaPTK/q85AH59S3Eyb2j+RAkXLa/t4P0l1UGo6cZop6DKPMoNW0npf7vm8Y319RH8y0BW/TnVLIalOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkxjuprI; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkxjuprI"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-698aece3d7eso29746a12.1
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 11:55:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785437701; cv=none;
        d=google.com; s=arc-20260327;
        b=aSMwmcHjZBjLxk4tyzQrSM6O41S5wCpwn6ebywV2OnTNPkISLfPnGBm1smt6LsOyvF
         M6mA7HedDinDJVJ3hVz7V8Yo0VCCkj3b+s3/TvOw3xy4sLYSHTQn8uYj9HFGn0f6sx1C
         pPGUyNEsWtQDndu/S2EFXK9saDkw7cv69rzgRZg/iNUd3TA0qGSlQG3pV8Cvznu4irm8
         9dWWc3xI/kACSoEh78YVYOOwoq7e0qWeqOHQbp7rhWdfoDwqY7OIr385pPco1QixmU+p
         xnwD2B/LTDKaB5GiqwO1TJnLPKDUGf17rK4HW2Phs6JFfACkeOWGpZaPV2VnhFEmseCc
         Iznw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=5YXmCpAaOk6QqxLkbcXfgNTAO2qfKu1DivCGNjzW1Hk=;
        fh=DejekihbkBvOWkPuWmPkRN+24UYxbb471eFJ+v+c2NM=;
        b=VxFBR1pwc17rzrBnKQwAMkq8RKgY7b+Eos751UGrDVRWI/019x2dYaSjZ5bhCM1ARh
         gQnWyxpaBN4KcLm/nGl11QywVZQhSi3Mokbtz4emUTaV8yOWFuTOKxnoGctfeZmisBV5
         A2PMukYjz7qMH4Bscn2+C1ZS/0xNX0aNNC4gC4VbCTZvtiZwqckMvcGeIqMEuvN1AsnX
         FwDWgtOsfSRIfMCwHiPNAY2Awr0Gr/QQGYY/LV/YytoKOuM7xKVHRuJvmD17n6OcaOFE
         JiZ8eS0TYDNBPe64Gmx01sRq0s8OLil7UxfbAzHLWU9wjdDdP9KsOlcajtewd4r4RTzc
         egbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785437701; x=1786042501; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5YXmCpAaOk6QqxLkbcXfgNTAO2qfKu1DivCGNjzW1Hk=;
        b=DkxjuprIVabGM0Pmd9TNb4byitvThIHjYVVvEeLbQ8xKafvCXMcvQ9KS8zpdgKsWSt
         ejg2DdTv1u4LKROoCAFrM0+KcLyJ49585Vkbc1I7OYe3C5ufasNcyBzSgzBml9PYzKFc
         UbHedi866vi46oBoc7ZBbxJrBowZoXAHxYPIMOoMosgW5qIQKuV3W2HlmmalzYjN+qsM
         v120GNqWsoL8qOoImjNbqtMbgnL8ncq3hIXTdihZPz4QAU0F03+hVY0Tw9tYYJiKMqmc
         5+OouL2K1CZYHEZM9kEGGsuXvABg+WpoVGSD2/Z2hz5MHtnutmR1yyCAMacM5KnHz6u/
         EYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785437701; x=1786042501;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5YXmCpAaOk6QqxLkbcXfgNTAO2qfKu1DivCGNjzW1Hk=;
        b=au59jDT3XAkUct3q9Vjpxito3wplbuYBbGYsMOd9pmuvL3sNyaz4aEjWQRbuf2IwLG
         GhN5KtX+utBrqaJoWfJdWF1UzGaog/BGomMTTaKd8K1GPq1tGJdZ5wlPemVBdXVSn4n0
         g/79BMaGKrgK7ALx/cw9HHT1H8Jpwomu3guiMd6gg6fCckiZQmReP1jEWTWuYqHlPmmI
         hVniUXDvEis8HzHjS2K4d0w60NekYxxD2iDv86brtWgVp73xcIlAAxH/S7IQcePocpqv
         u9RZEC6OUh3CAg3RRPVrTQSAgozryUdAfpom3fmnhCSM1IIQyS3obBrYEC+QIQYUZx4s
         1vvA==
X-Forwarded-Encrypted: i=1; AHgh+Rp6sWoS6z817db7bO8NxalwIHuBa86roQfRCkvEgeS7oUZt+5lRSWkpMqLhUYwSRbrdDJ71EiE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+yagD6Fe4ESFDdOm43FdhBgJn9+ZGaom/GKT3l0CnoZBqZMDb
	Nwb9bIbzpThVumDFBsQ+xbP17F11h7MGGE+Z7arfLZ5AUvUsJGOys6kjxqCaxcSQ23CHMSzoaHs
	DJmmwAC4dHqgMKAV6Ry/tZI0ga84qVvU=
X-Gm-Gg: AR+sD11vM+5PndUtT4z+zS5jDkbj1jdAEOqn0l0OEf51l4IACUo9ozDH61dnXnee0dR
	6RuasuEgYXN1rHrHlOdjK1QKmygx6cWhg3CpHCUc2Q9Fxmx9BeZv+QUDzul6tEE7WsjPp4D6O2y
	Vxs7eVsWMUM7TQiXXbk68EypgxFV8JWS0DMEu6qu7msEnIt9o4QLbJEWatcSxTVfT8lXluJpdr5
	/oBuVBERPUk7fzLNgPZNgjPSr440Z/OjLKvGSBo9IWrODONKnryzF+T8jv+BU3HSNBrLBMU1y1x
	td6qxmG/qpHteFvZqQ839wIi1J5cQuNzQTWEkWa9EY7h8innqjlvjl8Z+5i0zA5X0qMDDR3oxFU
	cgv2oejr0zctHgbiVg1lljK3bIVUAeAMN4dlmrgZZQCiVmjd8rkOecSgopLU=
X-Received: by 2002:a05:6402:2805:b0:69e:1246:a86a with SMTP id
 4fb4d7f45d1cf-6a090cbeb64mr779286a12.0.1785437700643; Thu, 30 Jul 2026
 11:55:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?7J206rec66+8?= <fyonglkm@gmail.com>
Date: Fri, 31 Jul 2026 03:54:47 +0900
X-Gm-Features: AUfX_mxRSKjjiZPlc1kaCHXfAg1QgCrse_BpBVLA3MojYAUdSflKJIFh2zzYrJk
Message-ID: <CAPLyb-a7bWCq0GzyOcztLm3-7H0GOP64JynosfO9k+yHy7diPw@mail.gmail.com>
Subject: [PATCH] io_uring: preserve task restrictions across exec
To: io-uring@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Per-task restrictions apply to all rings created by a task. Once
installed, they should not be dropped across exec. For a task that has
used io_uring, the exec cancellation path calls __io_uring_free().
This frees both the task context and the per-task restriction, so a
ring created after exec is unrestricted. Split task context cleanup
into io_uring_free_tctx(), and use it from the exec cancellation path.
Keep __io_uring_free() for final task cleanup, where both the context
and restriction are released. Fixes: ed82f35b926b ("io_uring: allow
registration of per-task restrictions") Cc: stable@vger.kernel.org #
7.1+ Signed-off-by: Kyumin Lee <fyonglkm@gmail.com> ---
io_uring/cancel.c | 2 +- io_uring/tctx.c | 7 ++++++- io_uring/tctx.h |
1 + 3 files changed, 8 insertions(+), 2 deletions(-) diff --git
a/io_uring/cancel.c b/io_uring/cancel.c index
8c6fa6f367e4f..7d7820eab878b 100644 --- a/io_uring/cancel.c +++
b/io_uring/cancel.c @@ -660,6 +660,6 @@ __cold void
io_uring_cancel_generic(bool cancel_all, struct io_sq_data *sqd) */
atomic_dec(&tctx->in_cancel); /* for exec all current's requests
should be gone, kill tctx */ - __io_uring_free(current); +
io_uring_free_tctx(current); } } diff --git a/io_uring/tctx.c
b/io_uring/tctx.c index cc3bf2b3bdbc9..466b7300e208e 100644 ---
a/io_uring/tctx.c +++ b/io_uring/tctx.c @@ -43,7 +43,7 @@ static
struct io_wq *io_init_wq_offload(struct io_ring_ctx *ctx, return
io_wq_create(concurrency, &data); } -void __io_uring_free(struct
task_struct *tsk) +void io_uring_free_tctx(struct task_struct *tsk) {
struct io_uring_task *tctx = tsk->io_uring; struct io_tctx_node *node;
@@ -67,6 +67,11 @@ void __io_uring_free(struct task_struct *tsk)
kfree(tctx); tsk->io_uring = NULL; } +} + +void __io_uring_free(struct
task_struct *tsk) +{ + io_uring_free_tctx(tsk); if
(tsk->io_uring_restrict) { io_put_bpf_filters(tsk->io_uring_restrict);
kfree(tsk->io_uring_restrict); diff --git a/io_uring/tctx.h
b/io_uring/tctx.h index 2310d2a0c46d9..76ad1ad4594ef 100644 ---
a/io_uring/tctx.h +++ b/io_uring/tctx.h @@ -12,6 +12,7 @@ void
io_uring_del_tctx_node(unsigned long index); int
__io_uring_add_tctx_node(struct io_ring_ctx *ctx); int
__io_uring_add_tctx_node_from_submit(struct io_ring_ctx *ctx); void
io_uring_clean_tctx(struct io_uring_task *tctx); +void
io_uring_free_tctx(struct task_struct *tsk); void
io_uring_unreg_ringfd(void); int io_ringfd_register(struct io_ring_ctx
*ctx, void __user *__arg,
