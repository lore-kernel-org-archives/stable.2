Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296730;
	b=X6kOp+CI10ypMvWZCh3nnVZk5NEz39kua5E9WPG6oWuuJLmlXhF1wlKPRWzEfGXZsFVm
	 BmQUN+RqSPNX1IdtYFiaD5mIQ06vGuvZK+WjoJU5x8oI8+NkmZwppMqTbeTHYkAe9KkB1
	 2eVTZs6EQcQxFCNRDC1X5miRL6izJJuXxZfr70Prvl150f1qLLrNPH1kXN4vME406yXpp
	 n3bN+qFs7JfrpvWhwoOMqhDehZB8nWtkIDE8tixnBFbUyH1Bh1fdzjW9D6eVKwMMxI2vp
	 mRpnROQGeev6DOHntPKe4SJnyXVVuzKamiHGsBecdBToOlMwPozzUCcpxgBUs7bQLJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nRQBfWjekK8Yg4VXZCceRWCJJAQVabbbnAIfHbVCC8o=;
	b=cD24qS/WCVLCvGeFUHT9HWMEcUj5x3K4TFHJHfET/SWCgOurkjUcJ1aKAslqk79nCi03
	 vvoLyAxgtAjubWp6UEFbHsz7hFFPmRuFbix4ygx/N051aark34rMsSEK7LTlbnofbJ0uO
	 penBHEqQXbaGNPEtxePQ0CYOSPwbk05om+CO4cwWuxu8QIKqDAvgOtoBDIYL4pNLhrAfJ
	 IwdxLkrn7+2Jmrxszi+0e+G3awgAA3XIj1ceAsyWTVUs5+J3gBqjM0081uChqILaK8IQX
	 Yl3ZRYtz+078mmE4PnpvfIGVWaoZ2H7VeaRHqCdrrr+dd7GAEs7q6OajCEP2Hx8+Yng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=QLa5sNe4;
	arc=none smtp.remote-ip=209.85.160.45
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D119606A330
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D119606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=QLa5sNe4
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-46556b9e02cso1605441fac.1
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296725; x=1795901525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nRQBfWjekK8Yg4VXZCceRWCJJAQVabbbnAIfHbVCC8o=;
        b=QLa5sNe4UEsFd/sDVD363cYukHNoBY/dp9NWo+zvCv66MCWHTVaNmtk+O6vyT4Pbnb
         0L2hkxzekt1MXDEhD8jC97HctLZDDbQlu7WEgJa5J9sAzSjYNbzz0IeyZjdl02UhEbe3
         XO0ZYG7tlHKjrEnpm1Yu3pl2h9RDeZ4CS2lh0dt9Tjd7OYqNDwMMens7IqMnjKI6Xqk0
         GoHQG7Yol/EB23xSbE5onN3Av6UImMwgh0qXVR1cQ31ydfANsUToc893RG2GE4BJ9Vcr
         +6Shfoik9KtUtDgn02Pu55imdiMaXZp4t3E1UCcBtxFSUSOdTl+tS8oNMKkVwzOuh20H
         Qfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296725; x=1795901525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=nRQBfWjekK8Yg4VXZCceRWCJJAQVabbbnAIfHbVCC8o=;
        b=p/C5cFsID1vaZ3vkpPWuIMP31U+GTsDXK55ESr8FBa4dMRgD92/h+HbQQyWW/NjpPJ
         LBjfjkSUcMn48K8w+z+XCq5PVe00RkAP6k6iwSZF2TXOcvBCSzW0oRjMjKFyfbr0P7l2
         HnMfqMiRrDYIxHNitVG1O3gICuFhLdgDXY0qwJ4gua974NOzHSPODDml+W+/BFBAv2RN
         iO7zWObDajvSaDtEl0AvB2QKIssYrr1k+EAws0YxDZMmol8NqzUipqoMNn2TIURw8aci
         kv9TTuSd2x0WdQaiSgxcheDaP9D9hYVgMYMFkYTnb8PZXb1Z5jaRTzNna6Zer3sLCAeT
         pTrA==
X-Gm-Message-State: APuU4Z/jsdmPF3OyXsgtZF7u9lD9hIPsjctSU0v14MEi/+5d1YzNIP7U
	2WiSxrJqIPbs3qLcvDja6Yy2+1QvuAY7CuVKvpzVSoSOhDW4szYJgXl7Co2pAa56ggVResoJJBh
	z30VVETQ=
X-Gm-Gg: AZFdTZdFNWezBLrW9RaGtvBfZhD6uezT/TqZipQkCYUg/JJDRjjLHtb02THRkHAMVsv
	KTJTX3gom/ANTBGcUtKSgeKGUtPwoR4DXGbxjjYB7Y5BoI3t5WOJRQingZATSGERVQ5aptyfJvd
	N1CVO+ZVjMWcSI4MpBZcVvh2jxTKcvsHV0l3QlPxdV8LTEJpEMQQlV2HSH7wBcxRR/Vqr7kwVEA
	l63Gh8i9iA7iz+ki8uKKv2TL7A+QqNfSn6YnxpgBIDAK/JTMxe75b05YXcFoozNzrbLfLgUvDY0
	nuxHMkPiCNCZ0VmlJasCXYAowkmXFdyPPzliGHCg9q4lDuciCtA/WdHelT3xxz8b3WtCAGPbXYt
	V3QRuQkhiyhyZ7gYlU6i+QY7104rfpjby3MZQyrOfNXV07kLryHoojKMhg9tuNM4XXZZaZfsng7
	uqQzykNYul/m4r1DfOh7SmiIkautmhoGXcOl9RemVipmMEDXpYmgOGgeRU/Bhe/7+/PZbW52xnt
	frsgTi8YZmMruXkUDrSSAsFAqLZTHvcneHbUiCFsLktun4yJA4U8S3mLjDGDgL7a1BWlBiutIkP
	AavM5VDQIWCGmzbSgtADjf1fHSSYmWGzfGxk21h7CsNH8YuZKcZQbASwSI/JN0xBLfJNV1WgaTP
	9SLTAZoKUp9EpGlNW7Mh6jm61C66hj8VkEuNI
X-Received: by 2002:a05:6870:f104:b0:470:e96b:43e2 with SMTP id 586e51a60fabf-4bc83571ae0mr4310288fac.14.1795296725292;
        Sat, 21 Nov 2026 13:32:05 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc55895b9csm6204636fac.0.2026.11.21.13.32.04
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:32:04 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 7.3.y 7/9] io_uring/rsrc: keep the old file when a file update fails
Date: Sat, 21 Nov 2026 21:31:52 +0000
Message-ID: <20261121213154.1790334-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121213154.1790334-1-axboe@kernel.dk>
References: <20261121213154.1790334-1-axboe@kernel.dk>
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

Commit e5a346e4309d720c47fe8331a00068608fad47dd upstream.

__io_sqe_files_update() resets the slot before it calls fget() on the
new fd. If fget() fails, the fd is an io_uring file, or the node
allocation fails, the update stops and reports that entry as not done,
but the old file has already been removed. Later requests that use the
slot fail with -EBADF, and if the old file was registered with a tag,
its tag CQE is posted as if it had been removed on purpose.

Reset the slot only after the new file has been checked and its node
allocated, as io_install_fixed_file() does. Removal with fd == -1 still
resets the slot right away.

Fixes: c3a31e605620 ("io_uring: add support for IORING_REGISTER_FILES_UPDATE")
Cc: stable@vger.kernel.org
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
Link: https://patch.msgid.link/20261116044531.281978-1-teel4res@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/rsrc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index c1ab760c4591..d1ba00390c58 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -330,8 +330,6 @@ static int __io_sqe_files_update(struct io_ring_ctx *ctx,
 		if (i >= ctx->file_table.data.nr)
 			break;
 		i = array_index_nospec(i, ctx->file_table.data.nr);
-		if (io_reset_rsrc_node(ctx, &ctx->file_table.data, i))
-			io_file_bitmap_clear(&ctx->file_table, i);
 
 		if (fd != -1) {
 			struct file *file = fget(fd);
@@ -355,11 +353,15 @@ static int __io_sqe_files_update(struct io_ring_ctx *ctx,
 				fput(file);
 				break;
 			}
+			if (io_reset_rsrc_node(ctx, &ctx->file_table.data, i))
+				io_file_bitmap_clear(&ctx->file_table, i);
 			ctx->file_table.data.nodes[i] = node;
 			if (tag)
 				node->tag = tag;
 			io_fixed_file_set(node, file);
 			io_file_bitmap_set(&ctx->file_table, i);
+		} else if (io_reset_rsrc_node(ctx, &ctx->file_table.data, i)) {
+			io_file_bitmap_clear(&ctx->file_table, i);
 		}
 	}
 	return done ? done : err;
-- 
2.55.0

