Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296676;
	b=RZIb2LPGJ01goDbui5Ab6bsFfxO58XQ7xSZkWsAgh7U8BFVRU/1yNWv/4M/GcLiGkwj6
	 zAdE1hX/lWtHl3St0j/vNt6qHgZ5GXeGi5EslbRY7ju07FmLRX8o+oWT1Prhy30+dCLJF
	 FlsZoEfudb94Mx1APetyF/pWLg7JxaB+t5GKYmZKb40R5sNSyXhM36lofCVADJCbcauF0
	 e5ZfHZtx1sdhdPHRamURfJSeliZKlgj4GOJ729w+YcTN3V6FlpTUed0ndb3oDxSN76heI
	 GHoW6sWAq2P5ce2IfmqRzh0MVdi1JDR+jq9nAbNItpFxuEJJOz2LiT+lOHhKGERoeag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296676;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=cTzkXr+Eh1oI7gn+QaT6+nPEp4gXiwyAysBKmdBNb+Y=;
	b=fOUTVRl+/OgCoOFlQ2DA9gsXDNs8afKisZ7QD3nddJ7IQLvRLrDIP7/23+pFQAb2HQqi
	 9W9u2qLjni8N+h3rpWdRs9eu5euDyOvw5TtzEGawAPdJeoO1Ab9ipAoDL3Wbqtpwt/MMT
	 6+7VZ9INkHqEoo6FLWBGGd/p1HX/sWaFfQn+1CfXs135Q8zxhFJInHuVfkMW/RxiUa24p
	 8UCpFCW2BMz9t/lknceDkhLYwrWkLTig4kPohfGXYCOk3nChGdr1t/QMo5IgiofLVBn9b
	 BJTHF1yMqjoyFrIeHHWrRp16PKKPpXOww40c81stUgCoJcbvD50GZ+A3oduCNN1GW6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=O86bCy1d;
	arc=none smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC8D606A682
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AC8D606A682
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=O86bCy1d
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6d290b10a35so821371eaf.2
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296675; x=1795901475; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cTzkXr+Eh1oI7gn+QaT6+nPEp4gXiwyAysBKmdBNb+Y=;
        b=O86bCy1duSSsZ+HjYF0hVYUYQnlDfX3GWchyGBCIhQsjgG/LHxFDsAAdHTplKO33cq
         LFtiWITZKCq7cgiYWpPjxrbUebt9IiwFVb9HO4uzp0uiEMoit3s/Rqu82DTELBXmwcaX
         gQxgjs7UOavhx666cj1GjTLaOMKHiYskyeXOLWphf1XzniErpmWaJ/7JRP0JlXgDrrhT
         luayTrh55OVEaJNUPTf3LhKyvEPNRR0oUOaRgVcuzTjmnwVIGp7of9XFbMbiyGTZ80m/
         fBC8YX8gp5xJ1pne6Oa0/9NltorRTF10flhCMZZvh50cSXC+uL8pPVog9WIioy/kY7SQ
         efWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296675; x=1795901475;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cTzkXr+Eh1oI7gn+QaT6+nPEp4gXiwyAysBKmdBNb+Y=;
        b=1D/xiIfljNZEiaZsh606GwASi1Rjv7N8goTEM3Ay9+G7LUQvZ73VpvrVTdSBXITuLi
         V4bYvo/LBKK/9hWcOnDNgoukWwRjS6qgLiZjypu8Uw3mK0YkbSKgRyiOc0NU3NFFpmcu
         vPAQfUWdHVr+wzPhlk/YFQeZMHU2X7TsEqoWsDKH9VODH544pCd6vE5Lqog8Uk+9J50t
         qlr6VAMSUZ5ldRZP0gnqg+FL5lgUERXzgvtG4/SaGgSB0UuddV+naNS/viMJJTa3yK13
         s7faB/gMjSQ/jm9mLNwBzCtoQawUvmTiMVfBYdQx4E1nkANllsrw3httZfSt2ZE5mzdB
         Nr9w==
X-Gm-Message-State: APuU4Z/JZeeltVuhUMgyFFypxZokHOnPuZNn8+qnuuO+AcZHkyrdtPIj
	92r5d/FevR8nbHF1yrAMXClH2HKfKLxasC+Ja7gdsQ/7uqdhPkgQlkMDoiyn/8Vl7z6B8zubxmb
	zlFYGc5E=
X-Gm-Gg: AZFdTZe/GPy+Lx9tnVYj9pE6syLF3fq0/nMuk9U+gPe2rI652J4+w+LZtJQ4JKtQsis
	qTOD0hAZj4h3NIRbwAkGW2+yJfizGoM5xgVJgSWSSJ3EXw2qjuoSqtaRZnMOuX0qMHxYG90hf1X
	qkFB1pAIgosy58VugNH4bvOUthkEPyH0Pmbs3LbHA2jsnHRENWttcfsrIcsJWkgNbu+dQC2d6ec
	BfZM7KTPqeDWiz2H/7RU8/jaD7LuKG29AmfloRsx1IKkdxnbAjIBVJj5X3McwQMqXrCF/2UOpQt
	MWt4Wt6CQC/4bMpUKzPIjT64HiXoCnxhBkwv5YNxXlM0x1eMEMyfgZ/ROUEEX3pk8mguNjlPEer
	AgDbs6Q7o0jV3D2u4cpP5iQJ1pE169kCpBMgTSlnBZXFcV2jyfALw/Tdnz7sjXFpShvk7DY54PT
	Zjb12kYhGWxQ8Ahu1O9VnljmLGtMOtYpwo9TOQIEPkKrXNkuD2VrEq4f0yxo9uOpmDZBjRXWfu5
	OOc7UUHFh7l/H+RUKnj5cHuFIei2z1OaJCqZ42Kk031GRNStmj/uTX0KrUv5vex0+CB/Sl0jGVx
	Kb4qbN/bUBYfSrPKCsZyLZRbumRB5gbT5e79SnaemzGigeagsoMqp6O1sOQ1m9+c/HPLAT2rU8v
	4Zz+e/RTDcesXAqR6aqgbT02BuCZJ3beAshs0
X-Received: by 2002:a05:6820:3397:20b0:71b:121d:632f with SMTP id 006d021491bc7-71b3959e0a0mr3852370eaf.80.1795296675031;
        Sat, 21 Nov 2026 13:31:15 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b38015c46sm4469155eaf.4.2026.11.21.13.31.13
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:31:14 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 18/19] io_uring: fix task_work add use-after-free with SQPOLL
Date: Sat, 21 Nov 2026 21:30:48 +0000
Message-ID: <20261121213049.1788332-19-axboe@kernel.dk>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit a92193c91e8839fe5fc209616ea95465ae4b919d upstream.

For SQPOLL, the sqpoll thread runs task_work off its own list and
doesn't need to be told about it, so it can pop and complete a request
as soon as mpscq_push() has published it. If that was the last request
holding the ring alive, io_ring_exit_work() then frees the ctx, stops
the thread, and with it the tctx, while io_req_normal_work_add() is
still looking at both after the push:

  BUG: KASAN: slab-use-after-free in io_req_normal_work_add+0x439/0x510
  Read of size 4 at addr ff11000000ca0000 by task repro/55
  (...)
  BUG: KASAN: slab-use-after-free in queue_work_on+0x25/0x70
  Write of size 8 at addr ff11000000c3bd00 by task repro/55

Hold an RCU read lock across the add, like io_req_local_work_add() already
does, and have io_ring_exit_work() wait for a grace period for SQPOLL rings
as well before freeing the ctx.

Reported-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Link: https://lore.kernel.org/io-uring/20260924205056.3759980-2-Jeremy.Jean@oss.cyber.gouv.fr/
Fixes: af5d68f8892f ("io_uring/sqpoll: manage task_work privately")
Cc: stable@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[axboe: 6.6 has io_req_normal_work_add() in io_uring.c and adds with
llist_add(), not mpscq_push()]
---
 io_uring/io_uring.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 3108af4514eb..fda288405e44 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1401,6 +1401,9 @@ static void io_req_normal_work_add(struct io_kiocb *req)
 	struct io_uring_task *tctx = req->task->io_uring;
 	struct io_ring_ctx *ctx = req->ctx;
 
+	/* SQPOLL can retire the request on push, see io_ring_exit_work() */
+	guard(rcu)();
+
 	/* task_work already pending, we're done */
 	if (!llist_add(&req->io_task_work.node, &tctx->task_list))
 		return;
@@ -3369,8 +3372,8 @@ static __cold void io_ring_exit_work(struct work_struct *work)
 	spin_lock(&ctx->completion_lock);
 	spin_unlock(&ctx->completion_lock);
 
-	/* pairs with RCU read section in io_req_local_work_add() */
-	if (ctx->flags & IORING_SETUP_DEFER_TASKRUN)
+	/* pairs with the RCU read sections in the task_work add paths */
+	if (ctx->flags & (IORING_SETUP_DEFER_TASKRUN | IORING_SETUP_SQPOLL))
 		synchronize_rcu();
 
 	io_ring_ctx_free(ctx);
-- 
2.55.0

