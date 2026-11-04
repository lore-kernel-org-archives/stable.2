Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817866;
	b=H7TbijgmxSZJK+5RTNK4l///K+s//NaWMBFgwvJDzztEzZ1Jf6aqepi+mKfjns8nD/3Z
	 7oRzMNZ6Fj9FfsU4xOijqwUAJ2sJ110qV7I1qToElgl/W5t94w7wLFPpkHQ2NUcUKCbGt
	 DTZ92SjYFxqmRzS3sjclS8WsCXaSKn8vx71wwId0O00fytHUgMiBiYpo3fbcBTIp5XBj6
	 O9ROYgDcP73x5Kx+r1z30mh+bWd5YztTSGtHIDe1/+6fcyd4WZ6DyxDn7fyc29YS5VG6D
	 XGUCbI860/fuKqNqwq73SfC4yGQ57TDQirUvWBmu5uGdut4zjHVMbXGIVTUbF/i6YQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817866;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=deBmE0DzeXTcxUeLKHFlSr/Mj2CbwCAkS4qQWmx0gqI=;
	b=z9yAE2J3WmAfFCytXFf+ww+8AB4AqOOiVXEHRmBOYPSyMMAnRLmkj1hsnGgTyjOlk7Uv
	 mg09FNA0c7I/zLntsmu1/HO6+NI9aJeIpZT+enk8Qs+yTOtOLLtT5G8lY02/V6vcWShgw
	 9CMlwWm4YmAySWF8KPgMGyP8ceKhG9Q+W7YzO49jo4ppoLYvRFwLYpkJesLyydcNJKkv4
	 DxpDSIMM/KYcWvdrKOZQR7faxg1V336LplOBLtJxzaGRfiVxkaMF0A2kP5o0oq1FmMmSB
	 oInbVIXFakCDQJTRSfIXgVVbjLeKGcuUhJSi93c3DnZUYSmIa1bnlEXSj1r2GAm8BSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="BxkZH/lO";
	arc=none smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA94606A32E
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAA94606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=BxkZH/lO
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-85ac281604dso577673a34.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817865; x=1794422665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=deBmE0DzeXTcxUeLKHFlSr/Mj2CbwCAkS4qQWmx0gqI=;
        b=BxkZH/lO3MnPUgbSmgSsitXvTeXgjvqnhcTrjan7Orid1t8X4se82h0ZkQY1vTF2oQ
         CnYnOI/mDHaUu2ZGIu4R202LvIqs9+nMgTdgmInAbBKu7/IQr32fyWAFJwXMnvVwJwcl
         /+wtIq15ZkNQKiAZaya+hhPnArC8q9wqhg1fZhmHEOhhXWm25T9BPEWkiiJPkixmT34V
         XttuCzFxB9E0Xz8ADGj75xl1pZjTK9+K+r8epEvFgZrNp4Zj6N+soMad3G84iZtPNlsf
         0pcCJpHEffpHd43VsiLuwh9yLUPfcK8PAThIkbhQjxT9tjNhgIcGKSqq/maHkqxG+LtG
         7q4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817865; x=1794422665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=deBmE0DzeXTcxUeLKHFlSr/Mj2CbwCAkS4qQWmx0gqI=;
        b=Uzapo8AWrXQm/QXbOS/fubit8lV+r97+V0CF5XryGk8v2ho8ugqz6SAEHzeb0Xl3QI
         OqagM7KEhpOEcp9L28iRty1rzNz+rGpOpURMDpC6V9KoHqvYE7D7DJv8Wa6yF6sljs3a
         JcOoFalYYejCpzshxIS4sulPLhQhCHtE9C3lGYMxib8ZXoEOXB9EShjbBXD5EPMG4ANh
         SXHL+f3Kh5hiY4XyURBAzoJQY1ntPfB4XyphFrSXaScrBcSuA+ER0l6SuAGRkNqS3fDL
         7l5wkAoBL2Yxy8AoAUnMpaldPZKLWcchEaGO+q1gaUqqDqVPPo1BGiM1+Ck2HZI8uO3F
         CnTQ==
X-Gm-Message-State: APuU4Z/58PJHkD2dhNBjM/6Ws6X34YsolKTnPx26BXeZpc605Jf5XC0M
	8DOJOpaw5Q5IMmtwMkJRe/izK9KMrdVBLfTqDvwHWj7xWkOAiEmnkcnpA0T3a4tafkti3sGIHPG
	mxjD0gUk=
X-Gm-Gg: AYBFou1xXPm5Rp9RwZSw7s8dyvtuRvmeoXx/fXqFyfNVSy3aA2MlXsQQNU5qpA7RJnP
	TT4oQbTSL5NnH1wWoWP6ZX/7/EY3zYtjaTb9Y4MFOrC18qAxK4a7iF3a0PbeEp5ui8RySLYTcgx
	uLPyn0/xXxL1nfmOmRCrEwHkQ7EFcoATiOfMGoPA8bBzu7xS1lqiZ8NzivmwB5Ft3pJKxSC0u+V
	GaTPpsz18bu21oS8uJXLAKQqOlwUIxxJ/MOBvwIiMEoOx0+A2q+iD6w68txudh4xkzQoGjtyi8Z
	ZxVT6liBSz6Q45zRjaDT9x4yeXOP8i/ICFVmgwoWsRJnCSiWPMf+PFiJZ8MO7aDHFX+Koc29wMi
	uEzu90a+5yuRq+bpoFWfAYGG6Zw2jq+bpPEleVrDiF/cvk5hZJ2NUpOEX1njQdCDbtw0qpCu69E
	WPTCGKgswXb8/KZHZp2uhOEEDrxFdV/FTJPuN54hB6G81rdNe8qm5gvwHIDHklE+en/xlnYEiGv
	wUKmz0Dx+dtTusq/712z6aGAbih1DlDmW8GToCsX0GcBWmHMsN1ixEDjNRVV1ARrzjqYCNqB42c
	2ylYFnBevemjO2rmnINF7lu8w8B4zD7InMoSX4wT3uVBmJAMklcpu1iXiJzMP5OMWOv3xaGeLA=
	=
X-Received: by 2002:a05:6830:44a5:b0:822:ce5a:4ab with SMTP id 46e09a7af769-85d3652cf15mr13546032a34.26.1793817864843;
        Wed, 04 Nov 2026 10:44:24 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85ef3e16ef1sm2540779a34.14.2026.11.04.10.44.23
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:44:24 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y 07/11] io_uring: free XArray nodes left by a failed store
Date: Wed,  4 Nov 2026 11:44:08 -0700
Message-ID: <20261104184412.516558-8-axboe@kernel.dk>
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
[axboe: 6.18 installs the tctx before adding the node and has no error
path that frees it, drop that hunk. There's no ctx->hpage_acct either]
---
 io_uring/io_uring.c | 1 +
 io_uring/tctx.c     | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index f1cd0e2b5b68..ac097a9ac8c0 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3039,6 +3039,7 @@ static __cold void io_ring_ctx_free(struct io_ring_ctx *ctx)
 	io_napi_free(ctx);
 	kvfree(ctx->cancel_table.hbs);
 	xa_destroy(&ctx->io_bl_xa);
+	xa_destroy(&ctx->personalities);
 	kfree(ctx);
 }
 
diff --git a/io_uring/tctx.c b/io_uring/tctx.c
index bf851ba5ca1a..0e4445d3a83c 100644
--- a/io_uring/tctx.c
+++ b/io_uring/tctx.c
@@ -206,6 +206,8 @@ __cold void io_uring_clean_tctx(struct io_uring_task *tctx)
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

