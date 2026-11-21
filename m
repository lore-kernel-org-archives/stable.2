Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296709;
	b=GHR2PhalYLtA2tQENIoe3iNlFN0U6mZekASZXjgW7+Mjy4EKacN7HtSfqK1YUwmtyX/Q
	 pOIwMgwwEkJUiqKKIALTUGDOUfg3nx200C3ibQMTyXIR1jbYeApk/6FvGiVIYtAArUysW
	 1Z1cl7rMNgl23W3r84llQccPyvcCSUtc2mb0idyfv0oKoeQtAhoZKISVz+1mClMySIlbq
	 7GEXwmbkTPM+4XjN+mSC0OpSdxW3ds+XEC3OA0p2sFFc2JVfycknP4TQ73dJmI5o5WnuG
	 Yv8NC5dhHTtIMO4GryhOH96K60OHNcFBks1vkhw/QKoBEav3h8x1YM3CrscxrhinpsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296709;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=S0w5dXPuazHtSa4SuPBBlAYoE/LM7rcL3/vygPAs/j0=;
	b=jrSyKyeyC1Wq8v16E7YmQMWGXhjYcoRCUxVEyDvqJAM5P1KQUXdH368T1tNbLW6W1nH/
	 TxSwqblYx0UHO6XuLaPQlQBZAf8iZl6HEt1JXLgkPzx34A4e1SnhNE+RzfxwaOF+q2j1M
	 mb9GkRaVTUpjG3BhTGeIdP+Akk65KXVnhXSngLc8ISu6kgMAC0kbbOulDHuQ6EGXcTvde
	 sSMVJT+ZQ0TdW1I8jiDTvfBfK/DBR316JS6kKHIZF1u8VKjy55l+UqxOn3jj0o+7zPvuH
	 bhXtWzDKFBVuY5+2kk7XyhdwGBGDj4xjgX200aMZg4kK3rVR+ypWbU+qoqIB0VWAs2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=XG8qSZpU;
	arc=none smtp.remote-ip=209.85.161.49
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0291C606A320
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0291C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=XG8qSZpU
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-71ad2c6491fso1746317eaf.0
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296708; x=1795901508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=S0w5dXPuazHtSa4SuPBBlAYoE/LM7rcL3/vygPAs/j0=;
        b=XG8qSZpUDzmsVu3jbcMbSm/gFFbSq40m1ZToI58GBoV4244XD2BPSzmP5+zYUB0yUO
         M0yB76cutni27jVNx7wklB1Hec3wKr3LWbfBQmIXcoRzFPocpv5bMEwLEAhT5/MTBgum
         o0z92169Ip1evNCGS0YCwSvQ8cI3BvOIlMrMM23lfZ4Cg+r/OntYh/W83122PeRw/H3q
         gdqzodSb+Sg3QSYC8sQqfTF97Mvi9zORR/En1a9BXFEOC1nypMuNXoNBzTuYI8PSuFB1
         tueQc/Bot6SRBylfLpFonIkOIMDnp9dHZGcPrPuhCfwE1wd4mx3KSdej0EmilrZClJ95
         5x4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296708; x=1795901508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=S0w5dXPuazHtSa4SuPBBlAYoE/LM7rcL3/vygPAs/j0=;
        b=dXrkDVuipR76ZX5Xr9SyBLsNnJ0Z57vm5sDiSGIpHkkOVf9Vu4Ztlrs8aJ4xZjJbPa
         WQkaAhnhoZf+I3JjPoDh/kt7nzCd8ICsH6wLdHr91pu9gGQAZVwvRtYn1lvmqktpzgOv
         86lowdjpNQh0WFtbfUp8bZ8TWswKpB8A5pqMs3rh3DIWd5AxYSOWyWk6FFGM1zYn9yZ0
         7CS052RL9WmKiOPXcr2bovGOUjYGhUIQrWTpc3W81VeFnQdPQK/dIS8lMxsMML4lfBr/
         HmygcunMMErorNjtkOFuWUwVKrBJ1IlvbC85sErOTbidbCm2BpIJnvs3VTMgt9RvFDDw
         SxoQ==
X-Gm-Message-State: APuU4Z9NgVRNzwvNawBxxEalo6xg6XXUYbV9UVY4/bDQMgS6Opz20vgy
	5ehfwrVYSDfqMmsSNODKnf9rPMF0st5Chx+PEgB5TiRXE0FxgDrIQDaQ85x7W0GjQJjGF7Sxp29
	Zp35Dqjw=
X-Gm-Gg: AZFdTZcXy3+6lI7sHFlYloBsKDEQI9FXodbgjwQtpC5HKFvGbNEYhUdIeFMWjzhoQOb
	rpzh5XnAyV3f8pe5B8un/QEIC++RjQv3ixg0Ur14YMh39SOkUVWivnrjXZnWvZplOmz7E2dYZyt
	aoFI7A7/pPVZiBgbFwKD1bqUeyA4YSltSGolxGkjT2o+AwbMtaKV/8yEYBDkFWBIRLmjpYyMRKV
	jwNv+Q3gzzz8GQpGYkQ2tQpZoXxJhoGdCXEjEJPrswQka4R26Q+hGjaYA39/OkvV1dOENmIPma7
	5m9SU7N4uHdmOwXd86VshaKbRJQf6atXkmG2edZI87yVHfzWTxQNDLeGoQaR0sgZVzOgNCjPxkO
	t8cg3bqpzqUa8JCBiMgdwPtIEddzVkjBgY3XjP2EQYDjKbYCzEM9aPLrWdLh33imSY13PLZvyPv
	lcpVLUXZCbXu8bcDsPJnOCJTaJwy6jm8CqDZVk01lgGPlOBjpI17jKr79VuL3SSsqNCa7AVn0BP
	QCW2ltVczmf3XX74/A55o44dJb8arv0nOAHu4OBgp2z/p0ZwoMB6As6bGaYlNTB4VrnJrVzQ/Bd
	v4FIJy0XrbmfyB2sR4dqlsiopi9cT2W3DSCznrPG+yQhoJ66z09CYXUSmHLCXfY/uiuwvFHlCLF
	v/wq8Zy/BbxX/EzE6no2tAHxlEyDY5a6wHe5HWNciJigOg6JNiY2Ech6tFA==
X-Received: by 2002:a05:6820:5709:10b0:71a:f235:d68e with SMTP id 006d021491bc7-71b395c42admr3287004eaf.34.1795296708050;
        Sat, 21 Nov 2026 13:31:48 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b380e4a6dsm4669694eaf.13.2026.11.21.13.31.46
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:31:47 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y 6/8] io_uring/rsrc: keep the old file when a file update fails
Date: Sat, 21 Nov 2026 21:31:35 +0000
Message-ID: <20261121213137.1789687-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121213137.1789687-1-axboe@kernel.dk>
References: <20261121213137.1789687-1-axboe@kernel.dk>
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
[axboe: 6.18 doesn't clamp the slot index with array_index_nospec() in
this function]
---
 io_uring/rsrc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 7170b3f001d4..36a9bc279e74 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -237,9 +237,6 @@ static int __io_sqe_files_update(struct io_ring_ctx *ctx,
 			continue;
 
 		i = up->offset + done;
-		if (io_reset_rsrc_node(ctx, &ctx->file_table.data, i))
-			io_file_bitmap_clear(&ctx->file_table, i);
-
 		if (fd != -1) {
 			struct file *file = fget(fd);
 			struct io_rsrc_node *node;
@@ -262,11 +259,15 @@ static int __io_sqe_files_update(struct io_ring_ctx *ctx,
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

