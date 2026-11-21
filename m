Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296694;
	b=e/iossOMTI1P9y2kch8q2YynZj1NLDoDppoQxCOucqDbkTxdyRd1Hg6Z0WBTzcDGSIhV
	 /14mik4R6gHiqkFmbIjSjQ7hxFj2IcUBtvel420le4wGUUYMVEN/ymPbXToxNz2Pdlqrh
	 +/K8cO6Y/5nYwxV5H6zFqwef3qH+jDtaK3W8eiW9gVxnZsvwkzBbVJave2XaiCvWe7wL8
	 24L/50JghPCc4c7SJkDtnWLR8+0k+M9G+HBoDcjj5TaKM5lGMRhe1Y88+RXYFWS8rPTnA
	 LJK0coVWRngjI/vKUXmfYZTuez3N0ljvH2glEaZVxkaTmULpFI6qj+uZ9U7PeBKxLYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296694;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BpCRsk70IX7a6WK8yD/1yotqvLl8UVZ/lV53g+yMoIs=;
	b=vtkf3Miuz57e6yBWXRO9ByujfXZmpBy7qRN9iQ7n7pzaHgVw0nLh6MmsVuLsjL1HHYUG
	 VlC6yPBYOZu98lCXfewoDBIpoT4bmGnlJwp2mhtLAuPb0fIABPOR8tfsc3G8Y1Td+POE6
	 JTnC92SQI/0UuoO/lg8PklRHA3x2d0Ych7jAbBopLkO8VGLW3KsKBiBb2D1RTslMcMrIg
	 IT6krp8+hEKcYT6SF6cc3ulKy638tD7CDJ3EV3/ve2nFSJhval3YTIPzyFm9gRIfmnu6q
	 glCkFiyqAv6QrETo4qgkr5YiDmOqef/YaxmE6mMkpBndUiqo26C0yKrXEjNr/fCWWxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=RVuLaI50;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB00606A320
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BB00606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=RVuLaI50
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-8629fc8ad64so1235318a34.1
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296692; x=1795901492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BpCRsk70IX7a6WK8yD/1yotqvLl8UVZ/lV53g+yMoIs=;
        b=RVuLaI50dTSWKo1qXWwGQ+V9bLv5VgdPfIzg3UMgZ5NUm5ZE4XZ2urnC2EK4cNBpVS
         MdjGXPzTXKjhujS/haV8Lme1u63/yXOtn1jdG/t9Ms9wAmqo/+oQYbv3WJFFciuOqyx5
         0RnuIB1XMzCLs6k5XS2QpdlBEKxxE83TP2ljdJ++U1XngIFSM1A4gP876KZxGqZxhn/C
         OqD9TK70vUirBRq0mRNaJbuL8WYKnX9iS3YiZhzOQvwWsZ2IOoFqTyI1qicWKQczJ/k3
         F0uNqSgfYOk3oo+jeG/K6hH4hPnCv8K6GCYfdIR+ytwj5VMFxcf3rwa8x6wec8SI8JGh
         LJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296692; x=1795901492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BpCRsk70IX7a6WK8yD/1yotqvLl8UVZ/lV53g+yMoIs=;
        b=dKJ/Kl2IPccVQeYSwdYjGjaiajOzgk6CnHCfN+E/DO96F51ES49FfQ5pukx0f04UzP
         G/SMtEysVkMECO4uT9i1RfHJnuxf82UT6yEW/2r63lkN77HdoMv3x7KP421ymi1SLiPb
         4QNoMSJLMpyfAF4LQuwzeD39mFHETRmbfZNSegKF4xrwtnGvLL5972QTfbV9aLvadcQK
         VKPtrWPEi7ixPg3afQ1MJ/VSzhqSn4Yvlpeih2PMYF3aOJrsjPD0vk08aJ2ax71lJ+hA
         b4aNbddU/FM52is/+YfS38J7yqnKqsyuE0UknUCQPCOLKzoagaZ6zOWRWETvDBLfGPIk
         dA3g==
X-Gm-Message-State: APuU4Z9eJP8y3aZHwioy03kb7IPf90cqXlcOLLA0EuvQL4f05uW/Gbmj
	nqCYdaedrtaa4KFqjxFWQ8lE6oEiyOylvN2lTj3gkacI1Fq+HJf6v6gjlxr7eErahkgbfO990Xw
	+1UD3iDU=
X-Gm-Gg: AZFdTZfHaWA9JsTLm3igPSFbvFkSO0siRZHosPThuPywKzsQFzNfS/4G/q9wddJ387h
	ZZFZKJBhmYjnyTJkEbsQXH0fOUyzrn5BQCyx4nPsCFpecyRzveBvClIwZ4UGtYlMH4qs3Mm29fS
	x6XlCm2DTTnM7w06F742Ck345wKgZk4kYyKtE35mNYNvsxOqWS4vXRi6/PoKLYq6x83/bPYLEWz
	5fQE2LVaWOLvxUGVVq6KfJwwxIgbLPH7LszAni7FR6mht+1f068VY/FxoTAUT4nBxyX9/f/OPMg
	Y8HRnLm18oQ56avQn0srDz3W0obPZvwaf6m/vu8sBHrJKlc5oiwy8qvQKCAUuNP7xVsp5nKGjQc
	uEpNm750aRnBhQs8Pitt30bgBmTpY4hf+VfmvwJIvbkJnNt+MxbgR1ruoWQ6A+V8Yiy34M/d3YX
	dc2j4733pllQRUzYRqAbcQO8Wd8k6nOl3sQJTfKRaa2E18lcmYS3DXquGdFmXt9BQ9DNinvKH11
	kjOzv2f04SkL7x2F+AJn0joDk5DMtVj5PVItm0howVRfEgpHrtikWE4PUT8fvxVuMqEr81PYmxo
	F4TYqYb+iiGovs9Dr2LbeLwVquM50q6VFL6uviRWAByS13cKWkFVYp9dCsuzQ2jZSaqqZdpCuPB
	Dxw0fkssMddmKe5m3vKAHAtgLtO7TXDD9lpgQ
X-Received: by 2002:a05:6830:2642:b0:844:4959:e840 with SMTP id 46e09a7af769-863158f59ffmr8683450a34.21.1795296692218;
        Sat, 21 Nov 2026 13:31:32 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168f6d33sm4946113a34.18.2026.11.21.13.31.31
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:31:31 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y 7/9] io_uring/rsrc: keep the old file when a file update fails
Date: Sat, 21 Nov 2026 21:31:19 +0000
Message-ID: <20261121213121.1789042-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121213121.1789042-1-axboe@kernel.dk>
References: <20261121213121.1789042-1-axboe@kernel.dk>
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
[axboe: 6.12 has no rsrc nodes for files, the old file is queued for
removal with io_queue_rsrc_removal(), which can fail. Get and check the
new file first, and only remove the old one once that has succeeded]
---
 io_uring/rsrc.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 168c6987435e..5a3f3e4e3fa1 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -348,6 +348,7 @@ static int __io_sqe_files_update(struct io_ring_ctx *ctx,
 		return -EINVAL;
 
 	for (done = 0; done < nr_args; done++) {
+		struct file *file = NULL;
 		u64 tag = 0;
 
 		if ((tags && copy_from_user(&tag, &tags[done], sizeof(tag))) ||
@@ -365,17 +366,8 @@ static int __io_sqe_files_update(struct io_ring_ctx *ctx,
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
@@ -388,6 +380,19 @@ static int __io_sqe_files_update(struct io_ring_ctx *ctx,
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

