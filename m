Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817851;
	b=MSnyVUiMrfLsPy2rbu+1ln1QL4IQ0iVk/wOwG4j3JC9X/E9qoL4doZ44Zz8D5TE5INrF
	 0McRHh7ZCrA4ko0x3FXt3ltZZtdr1yoP2rt32tEKHV0Z3BedFuKF3xsSX4gzRLxgW4S6u
	 wj/MHcWYxltkieH+fuUnZts4po1Y0kcbtso452pyXPb3nE1gSivP1PraYjzC6JkQjJocf
	 u4PUZtMQTqB/ubTWefrvMMUstoVznon4w5prr7/pvHVoKi+2HX61Vw0WpU4KeOcK3/qMN
	 iteEcQ1TOgUdfwB5BlWXJlm4G0TnJGylY/+NFg0D4PbzXkf7ei6tjXBPjn/iqOszUlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817851;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=I9fTh8j8oHjo1yliEcGRWme5kLuAAYHBlBhK2f8zQNk=;
	b=XPDMotmDkVwSmoWyYkxpxQSVtPYMhwpwbz2XZzTs+lgNEQtVjjsj6aJwJ1xZ9+cYRWRZ
	 7APT5BREfOZLUTLFa+x14jVro/nmLKtf+q9C58TPgslCiKsSUlo9+konInaFg9kmOwxD9
	 4Cdmvviin12BwQDNS6YFibc4RZKA07su1UYGr85Yx3UPyIDmZ/KDMA4B50wUXeNjLQlF/
	 RPI8Z1cuekR/OB3EtXfVfT+gFZIr48xMivzNDgUMsgnwMeNt1uE5D7W6yQMeeNUBvKChH
	 BDptC55bEGaSXrM/w6AitwPzibyBR/ic5sLPS5QiV9V7zlokoZqHSwwbGwPrsqU2nJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=szYMNPTs;
	arc=none smtp.remote-ip=209.85.167.172
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC63606A339
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AC63606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=szYMNPTs
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4f699fe49b3so847560b6e.3
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817850; x=1794422650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=I9fTh8j8oHjo1yliEcGRWme5kLuAAYHBlBhK2f8zQNk=;
        b=szYMNPTsuLq25wb/A++C0OAPz+ooNEU2uliKKbh0pIcPd99bO+kCCc7fY+r1NZ11sc
         xce7+dtYJlpMAzdUEj9G8uu9b8K68kv3EWYH6qClFJFII0NgXq0yEG6MVwZW0xZgqQTK
         i8cKbUY0BCEJ6Jfsot+OiSvuBgt/t4UqkUTLERe3lDYiwT4+Lrn3vsyU5jSux5voB+Fh
         cMxENLUFIDy6pmxv/7iGhi6apE3yrFdkypDziIAgzcMeItZo0nEzCMSzAvKohTpG+ulT
         zqYXE7dqpHgpgbr7FAeZuQlX0TJzT8ZQ5nBjrXXc8pLjZxBN5GueG7OUHpTFx6puwLvV
         8huQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817850; x=1794422650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=I9fTh8j8oHjo1yliEcGRWme5kLuAAYHBlBhK2f8zQNk=;
        b=ybQtKeeg+hgjta/Lp+VbNlyS/7teZJuZB+FVZY6hwghA3gDGtUEEVvGgWksRoHCwwi
         jLp9H2FBDTzvxJx9JOGkgSEqPSl+BUDuB4caI9edfwlNZWYcoUkfNb9X3ZKCQrVm+xLt
         AJ21Kbg5zo3x/TdJWJ/FZmrtomXgcujmV6BxNLyUcK8Q1KTH+/aZp9HHEEsPSlA4prN+
         3zRI1UboOuL8pAWFyc/+5fVyWqDQeurs1p6usqOx5n5wu2fkTrT4PpvU9Q7BOxiTV2ja
         ppRGq2cBUJr3CA2emt6k1+pdjOqbHPm7Wstwr7soYx+DsQZ2tGUeE8oCtqc2TJSvb4gV
         qyqQ==
X-Gm-Message-State: APuU4Z8Tbl/BvybfCQ439TMRWsy6K2S9wt5ut+AQaEJW+C2yodkMIBo8
	rHbprP5XNHN2JpYXsCQ21mpOvQ48LzTD0PXq4OCItG2O/f1JoJ2FVGZ4GVQCdu9RG+xKbdL91Fh
	Bf2EFbZs=
X-Gm-Gg: AYBFou2jOVV6GY6pX3GsYmvOGrT0qRlfqVGgOSZHt6Y9QOfHlV74/tdqr0p30/1J1yL
	/iSceY2eOiHAmC4WfVW1ttTycK/AYcWX2RId5ywYRdKMQXFgA/KZ8ltNWXAC3NZNo7i3EBtQI7O
	ED0nxx16MXtT4yUYuFhQI/P+XH6TGoHcSXNsQdaY94lbVsJUiOkFyYzB9tRwE61gZLtBy2P5lcH
	6FPZY7De6BW49PolJeCJayEJfoGPn+r9Utf1yO9G5iyFsKmkqSJ1ycc53N9BmIaIgBnQcBAZJxE
	LMEdNs8czX6Q/2JgYAzDakGa1BO53EzgAB4xMTALqwlKPoQLsVAcxa1W8uuIva3Uu24SCbMJHFt
	XBgqZvbisP16meVj28OI+RC51+DjP5ZUuBs+jZa0c4wT+n+9DS6doT8dp9gDa24+xLvAFdLlyb8
	zCfUC/3bNnizvNABYANFCzUnxZfZm9Y4DZuZvDQMGU8wMtMpWt39Vg39iTfXuFhG7EZB5TdNVyl
	BUYJr0ax2nlZc+LXztxuB/+u90B0/970/H9JzyY8SAmSq8lGQS2OQPI9ums7gMzk0rXQ9GHd/pZ
	eHmcA3njX+MDEWH2azRZwWyW4x3kyUcFk95gEn5Q365ARKRJnVA+sP/dbqb0cUhQ7Ts9OkUAig=
	=
X-Received: by 2002:a05:6808:11c6:b0:539:c292:8b04 with SMTP id 5614622812f47-5640d92c946mr12046797b6e.8.1793817850211;
        Wed, 04 Nov 2026 10:44:10 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9fdfa53sm2199007b6e.15.2026.11.04.10.44.08
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:44:09 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y 9/9] io_uring/timeout: count cancelled timeouts in cq_timeouts
Date: Wed,  4 Nov 2026 11:43:53 -0700
Message-ID: <20261104184353.516403-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184353.516403-1-axboe@kernel.dk>
References: <20261104184353.516403-1-axboe@kernel.dk>
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
[axboe: 6.12 uses a regular spinlock for ->timeout_lock]
---
 io_uring/timeout.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/io_uring/timeout.c b/io_uring/timeout.c
index ef215accd284..d71b0fdbb066 100644
--- a/io_uring/timeout.c
+++ b/io_uring/timeout.c
@@ -303,6 +303,9 @@ int io_timeout_cancel(struct io_ring_ctx *ctx, struct io_cancel_data *cd)
 
 	spin_lock_irq(&ctx->timeout_lock);
 	req = io_timeout_extract(ctx, cd);
+	if (!IS_ERR(req))
+		atomic_set(&ctx->cq_timeouts,
+			   atomic_read(&ctx->cq_timeouts) + 1);
 	spin_unlock_irq(&ctx->timeout_lock);
 
 	if (IS_ERR(req))
-- 
2.56.0

