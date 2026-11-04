Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817818;
	b=pHDZ9R+C6fX+HwOUqJW5OboKBFwAn1tDfjysm1eED3oc2SK92vnDAU2diqufqK/msRdn
	 53u65Hy/op3c0o8KghenmDM+KNp0VMXr01VSC6n/efa+Rx9BcFNqMBix6yYoKQhwRpeeL
	 7dSmUGw3KOWL0YXzcLVKJ5DccoJT1fz8YE9lmkuOK23cWfaUCGbYTRsBWgSQTy8Jqvf5e
	 XKzJSh2ekQnTcOxHN2LxjE1RwIEI9QFiwXyMK6vbhe33PD7WhlVMW4O2vIyX0ak5iAp87
	 oeSh5PoXm1OkgcrLne4T87VRd7Zxrqbwz2j9yvhbT9mVvqzZT1b4W/u+Om59Daf74lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817818;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HFqvQCjkWLCkWEL7OZmWZNk1ERFDJw308onkpSlI4XE=;
	b=AVorYOoJxGiOq2rhfe8GSx6r1h7+57KKge/0leZjT7yuJu4PDiJTv58nOJ7Mqk3rQVb7
	 mYdj7IbK+PdGAI8Ki/EgVLkfou+5iJp9xEsSVLk8bCyfxgLLn4CWtJ2ac0dlEwau2VPnb
	 brWSZiBbUCY8QZZnbngEeZbuVmbQ2uZSz2R1f3PQ8ZNRVGdkIlf6E4tqynXh6x3mcowrp
	 W0grYMMSi/QtaRGbJRjceQCJhufQQ+QbeKrxbzTcIiDxM6tFkWTljEOrnWnntP+r7QYgM
	 tBHoosJGm+Y7Pr3bMlK5l70nieOUJUwevOrYE6aqgC9TN0rsvMCf5Z0nxvAacyOG3ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=W2U3IWO5;
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3694606D80A
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3694606D80A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=W2U3IWO5
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-8439fe796ebso586101a34.3
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817817; x=1794422617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HFqvQCjkWLCkWEL7OZmWZNk1ERFDJw308onkpSlI4XE=;
        b=W2U3IWO5n0apnl3NKAqV4vf7K60vh1d9bkiZ7yvd/iwAKOaK6qMfBeHr4uasu/iKjr
         TTJwNyosfn0tTz01HfzctdGCil15bESE8ubxCNmwAyfIxs+QfHIhS408epZf+Be9pYJc
         7yoeJ1st0XEzO1+ijRmI3NBA+/yREutUciMxUyvwRq257E666Gu790+eln9hQimQjdBV
         usz/YANTmErRNp8U/jLDWiKyfyyddJnYmUk8Ywnl0jSgD9BUuc8GaC8+6cIk22eZuc4O
         aJ6iVAXLtNpEEJyLiLg+KQDyuXNDX9mSqXDZyhE9J4c/PdCCjADKwIb5hMAOAD0yoxZV
         E+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817817; x=1794422617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HFqvQCjkWLCkWEL7OZmWZNk1ERFDJw308onkpSlI4XE=;
        b=IrDCe4qHRz77DZL5n+ovjhARN03ZllAZb1xOa/kGJkdELGGXYprBng+c5asMie7jyG
         Bo+i7r8y6nogUoMaW/t/dEG8nwaeniv9eTL4P2qO6yWHLmz7YIQcDVpx2hwhynN4EFAL
         TufaLWfPHU7Knh7aE8delK6Mepi7l5crxPC7sIt/mXjQfTdIEeHL56bJpCla+jZB2A2M
         XVEKP6q8q7WsrsRyTFa0aIluCVJLN/2G90zaTxK6D8dYBM7TY66yANsic+QGzWKxMKBE
         rBgyHaeVvpvmKGVhepOuGWEqk3aNgJqGN4nRFhtQXemGh6RF2GAqIgxL2RfTvSd3X5ua
         uHgA==
X-Gm-Message-State: APuU4Z94vvQy1NCkt0A1edXnu8zmJR4giV52cR3kN/BiPAIfwRBPYAB5
	pZBzIoVWtNQFNmnIfE3fsgbUXV7HwHE4f+UvENZ7aWv0Nxx+WcYwdnx76hhM6dKQJQrTLrPfj7T
	l6tWlvLM=
X-Gm-Gg: AYBFou1NflWrWXxbEORdw4sqwwA9W79q5tjtsGZ2tatcYt2FNZ7G1EOL+H87wWgIWTC
	Hyoa9pWA7XqYpgpKyfTkN971mgLCupXzswKpPuDQNiG2yyOTadoOLnRk9zB6cMJw7MOaDlBHv97
	fhFkLym7dLUANWUEQGhgTsZB8NYAlqo2Iz83O+/XZrK3af5KrbzdQlUEiXkDG89kD1BYDXWFfDS
	MTIRvPO+TcN2gz0jTmbYUyXR+ynb+PD71k0vXHhJXtElFO3CY3aiQ3DNZlbGeWGWWXvPobGfvdD
	cf1OAAKvoPevBttqh9eGkXwiWs+ttpcMPtJJ2d6DyjC9wUAsXAZI783ul0K1X1RuXCdSs5Pg80U
	o7N3xLcXGC7fewNuaYNTau42rSDHxN5B/55Jhmha19UxoQrkuaVo8IiCTobDLLKMKGCpybh99ax
	UciD1Bed+IlXIi4z71xaSreyQasDCFX42FR//scmMPPEOpSNmfrjs2V8uukSUMswa9R4o+/zjai
	EdYGfKfox2S3PSoWrS7pzJ6Lc9qpG/FYfnET5QhN27Yw1EuvKDRyX1ZqFCcW+H3qBpVNLCX8/ic
	GpIGNzcJmlPI+gLNzQnQLkvXTFg5quOhjLJk4tzY9VQmanTu2VtL9m8ZwT2XljqcjTPxtzJcbg=
	=
X-Received: by 2002:a05:6830:680c:b0:81a:9522:f00f with SMTP id 46e09a7af769-85d364e1379mr10821622a34.6.1793817816965;
        Wed, 04 Nov 2026 10:43:36 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85ef3d74959sm2578834a34.5.2026.11.04.10.43.36
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:43:36 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y 6/8] io_uring: free XArray nodes left by a failed store
Date: Wed,  4 Nov 2026 11:43:26 -0700
Message-ID: <20261104184328.516206-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184328.516206-1-axboe@kernel.dk>
References: <20261104184328.516206-1-axboe@kernel.dk>
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

From: Chris Mason <mason@kernel.org>

Commit 51bab09b7ca1a9a6dd9303a3b7ee346f8128c963 upstream.

A failed xa_store() can leave nodes without entries in the tree, and
erasing every entry doesn't free those. An XArray needs xa_destroy()
before it goes away, even an empty one. That was dropped for tctx->xa in
commit ca6484cd308a ("io_uring: no need to call xa_destroy() on empty
xarray") over a lockdep report from freeing the tctx in softirq context,
and ctx->personalities never had it.

Now that the nodes are charged, a store can fail at memory.max and the
leaked nodes stay charged. Call xa_destroy() in io_uring_clean_tctx(),
which the task runs itself in process context before the tctx is freed,
in the error path of __io_uring_add_tctx_node(), and for
ctx->personalities in io_ring_ctx_free().

Fixes: ca6484cd308a ("io_uring: no need to call xa_destroy() on empty xarray")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[axboe: 6.1 installs the tctx before adding the node and has no error
path that frees it, drop that hunk. There's no ctx->hpage_acct either]
---
 io_uring/io_uring.c | 1 +
 io_uring/tctx.c     | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index dc4ff66ac64f..3392218887d9 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2797,6 +2797,7 @@ static __cold void io_ring_ctx_free(struct io_ring_ctx *ctx)
 	kfree(ctx->dummy_ubuf);
 	kfree(ctx->io_bl);
 	xa_destroy(&ctx->io_bl_xa);
+	xa_destroy(&ctx->personalities);
 	kfree(ctx);
 }
 
diff --git a/io_uring/tctx.c b/io_uring/tctx.c
index d2da97d86f44..f94ff56fe874 100644
--- a/io_uring/tctx.c
+++ b/io_uring/tctx.c
@@ -197,6 +197,8 @@ __cold void io_uring_clean_tctx(struct io_uring_task *tctx)
 		io_uring_del_tctx_node(index);
 		cond_resched();
 	}
+	/* A failed xa_store() leaves nodes with no entry behind. */
+	xa_destroy(&tctx->xa);
 	if (wq) {
 		/*
 		 * Must be after io_uring_del_tctx_node() (removes nodes under
-- 
2.56.0

