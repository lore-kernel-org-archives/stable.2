Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296659;
	b=G1l0jpf8EzJ8Do/+4A866rvwWHNzMIgGRIHfxJhs2D7Yzzr9cIRDUCsleJA326m+w3VX
	 jXVordtUpW//xIkBxHxgN6EHxIORUjZ90SdQrJu2sTGoPc73Pc+paVp9+EzhPW6et/4p6
	 1os3x7KdZZ97dMgD5t24ZPh8D1geTN9LafaQBSXxjqY5JC5uk1+qtwfauIU4YC6nnqh1r
	 ZYk4EW+9kX87O36R5KK6nZckoktv+2GN+sBi7DpX3XxosldutE75JB99oJclQvzY8JjNH
	 6Z66iNAC6BYnT5H/oYFuexuUj3P8MvPAeM+SZNjCP0LZZmsJGW8uDv1l2bADngNbyag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296659;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EkcmbvlZ+E706tSiZaTreanvkbCLPYgRbMIyrfNqRro=;
	b=NACFTsCA9qnDf6z8MdW3SASAuijc20BfQecdEsGFlSp5TkJgWTOMu3X6tNrObY+uBIim
	 aGM1jUBhcEbKrhiwhgvmP6148YenJViLdQaGYWl/nCBxsb2gOO5lzZ/OUhexpSoXw6RQ4
	 7SQLo0MPVCP+vNf7Gw5y4igHZcap5w5tan8w7Fi25ek7wa5r2r5SQnVuDte3g5wD+UADv
	 8XJQk8AcvrbfvCkfQ1psPJuEzs9oWKrYUdSOEBmg/LhyToQPbf7/SyFf5bfcIO3HHFI6b
	 f+ON7M3VxGXAD8SKFSqrD2+PI+au/TYvbKRXKPiR/PrvBYV47eYlLpiBSKSJJKdjyRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=HIvAM2Gv;
	arc=none smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A04606A334
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43A04606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=HIvAM2Gv
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-70b875f6f1fso1700234eaf.2
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296658; x=1795901458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EkcmbvlZ+E706tSiZaTreanvkbCLPYgRbMIyrfNqRro=;
        b=HIvAM2GvZJI2ueLJZOECyMWINdrGoYv5KUa0i38WEx9+sXR716fMwKHAlGTZOairiq
         o+eFABSzci2y3KpJPSliDb/McJqNkltsNrCJkOAYDSoNn10t+h6q9j5l3Uni4xFHdhD4
         0jcjaq6ijoL+5OA+koUeNRJuY/SaieZLdHeRElM6fhi+YYCI/42hZq6qgmxg9kM8LwRY
         AhkTcDCxOsr+kHBxsc1YnI0kIH/febjxTLJEtA8jsEG57XeChm+t1e7I2dmPznAuRDQC
         2a5U3sdjfyaD/XEbamFaFOeFmeNYMcX+ZYcv4TwroeZuja8H6QSJg6jdYCGVloRN6O0h
         x0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296658; x=1795901458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EkcmbvlZ+E706tSiZaTreanvkbCLPYgRbMIyrfNqRro=;
        b=EEphx9lZDxG4pYPcxUQnHul38cJZjeOt1qqoQVHCCFwD9GGVdXtkE/mN9nrvrSz7Ck
         jmu0LvvcDXfn9e/6XuxMtftzSQtLrNSNohR+P9JG3XBv/zY2MAKGKvXdFDqKwEkaxt6+
         /rFaq6/TwUFNqXbsdEzhiP67VKM4JNw3r2YwGG6lUR/HN2H2EUkbS0fjA5i32jTLQ59v
         eQRDeCqsNleh4DdEQs4XPQ1nFdhJU4JuRZsHTgLDHgEJm23bRqE3fL0zl1i/B13JFiFs
         1g44yDjKk2PYj5YTQZ7E7MhVqZJsrQlAKlZBUM8mj8RoLlF4xFFQLdKIUFJCQGZEeSNw
         V0cw==
X-Gm-Message-State: APuU4Z88DMaNDUy3zMtx/eipB6ApjEVnqTHHEos3Z3aZJcWGLnMtzTaQ
	cdQ93M2vDgZfZv0hesu0rN5yZgOl1RB2aZfKoKjuyfklDTn/ErXjvNNmrApDrSVyECLngLrruz7
	6X6mFK7Y=
X-Gm-Gg: AZFdTZd/Idxsc5qgAb2RYJwRVkRROYTzQ6uuM5lpnoZqzZAG2wv4A5qMo7gdPtjU9nZ
	mn1UjeLhp7NhgN2+e6mHBuEHu4hzO8WDOm/mhZb4m8uH9RReuuN9CmAJYJMlm46tyuuigUEWxls
	LTHuDZCnth1s10bB3F2OWFhdxMV7x7z1miu4p6Z8vsnS2LtEURcxlsSopNCqZR+AETlSvXqkLZF
	s45unYGr0CEifB44TbJ59w7FjrkPlQbg3uN6/w3VY2DIKk4ETNdgn+zk2Wu+AURt29ZpLVJMi0p
	KpS76szHiCFM+br9lybVB/CpYaPZy++3AYtgCARdMpIsnaqdnlxKsR8HNlIPRtH0yCFv9UfluDE
	i3yqPnZLYy3h30aNLyz9M4DetvlbrB8ixdEyfFOzYSou75saipKodDL8+tGd+6viVJpwB4k2gmG
	esmgMSsmrGJQMWkGAeZKo6l9DKxdDgH0TiPyTh+ms+k6Xan18NUUr+suEUt61cu5rm0c1/paqyn
	tO/BzWpv+qudOCEynUoEfI+VL6aE6iPItTz8JGws7//3rpeFR9RYnnhHBk2+8hsbnd1ziUQyzHz
	E6F8FkHLiyGyUNcEvPfGLDYhrVvAcBJlSK+bUPoBktLBB19wkQHHhSKSag+aNI1D1PrwRA/ofti
	2lvM8LFjlVGGh3fg0+Q991/TwY8r/hOMlOuTC
X-Received: by 2002:a05:6820:a10e:b0:6e1:d890:3825 with SMTP id 006d021491bc7-71b39402c96mr4775405eaf.18.1795296658104;
        Sat, 21 Nov 2026 13:30:58 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b38015c46sm4469155eaf.4.2026.11.21.13.30.56
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:30:57 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 05/19] io_uring/rsrc: keep the old file when a file update fails
Date: Sat, 21 Nov 2026 21:30:35 +0000
Message-ID: <20261121213049.1788332-6-axboe@kernel.dk>
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
[axboe: 6.6 has no rsrc nodes for files, the old file is queued for
removal with io_queue_rsrc_removal(), which can fail. Get and check the
new file first, and only remove the old one once that has succeeded]
---
 io_uring/rsrc.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index ba1dedaaa7c4..0cc498a0673d 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -369,6 +369,7 @@ static int __io_sqe_files_update(struct io_ring_ctx *ctx,
 		return -EINVAL;
 
 	for (done = 0; done < nr_args; done++) {
+		struct file *file = NULL;
 		u64 tag = 0;
 
 		if ((tags && copy_from_user(&tag, &tags[done], sizeof(tag))) ||
@@ -386,17 +387,8 @@ static int __io_sqe_files_update(struct io_ring_ctx *ctx,
 		i = array_index_nospec(up->offset + done, ctx->nr_user_files);
 		file_slot = io_fixed_file_slot(&ctx->file_table, i);
 
-		if (file_slot->file_ptr) {
-			err = io_queue_rsrc_removal(data, i,
-						    io_slot_file(file_slot));
-			if (err)
-				break;
-			file_slot->file_ptr = 0;
-			io_file_bitmap_clear(&ctx->file_table, i);
-		}
 		if (fd != -1) {
-			struct file *file = fget(fd);
-
+			file = fget(fd);
 			if (!file) {
 				err = -EBADF;
 				break;
@@ -409,6 +401,19 @@ static int __io_sqe_files_update(struct io_ring_ctx *ctx,
 				err = -EBADF;
 				break;
 			}
+		}
+		if (file_slot->file_ptr) {
+			err = io_queue_rsrc_removal(data, i,
+						    io_slot_file(file_slot));
+			if (err) {
+				if (file)
+					fput(file);
+				break;
+			}
+			file_slot->file_ptr = 0;
+			io_file_bitmap_clear(&ctx->file_table, i);
+		}
+		if (file) {
 			*io_get_tag_slot(data, i) = tag;
 			io_fixed_file_set(file_slot, file);
 			io_file_bitmap_set(&ctx->file_table, i);
-- 
2.55.0

