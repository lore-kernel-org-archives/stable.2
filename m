Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817947;
	b=BFpytN1Ommi07MJCdaFGHr5PCmNBljjpHhub9+zg7HyyDX1guy9f3eVBKjUbR5Yp9Eaj
	 vfRKfk0ap0odyViBzgYsCdBKZI8KEjUgA81qR+qrQo1tIFunxsfavhOeF2SIKMYb9/taE
	 wcAa+K5c/WDgezPH+NSw8zsTPYoGbCb6ueHNJP3OSlhoKK/B9E1YByGR7RuSD68+GuiZw
	 PrgzNm9cQVQvegKoWYqKxrqzCHuOtSrbXOQbui9UTnffXghmJUKvtcUEOFzzwxBQGRNit
	 u4rmQnhhEaTD9fKs0ZHKAj6UDuet2Ldw/dPqUQY25SfiJ+XvwzDUNwt7VhtP2Bz1Gew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817947;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5jBNIeVN5XdbR1Hrlv39MgpAIZ3C/3isZgY1B6s9aw0=;
	b=X8T+RvmvTGX/j1CZaBlDzrSDLKc/aUa55ZZaGTo1UoLEgaWoUR/obgQBEukyFkv0pqDO
	 zF5WEKmZLKnARWnLpO9ireFWzqHd8VM1w0Kx04l2RyltZIwHywa63WDQjl2xJq/ZDhHQl
	 +srhOpzYVOueyUmDVQNcxYpah31QxfIaBbHKyDd7qsUixdgBDTlyzasiXFHcEMCCij1Wq
	 fzR0aDHIxvXTUsJWXJIl4QEi8V0Bm8OnlKYZhw/Rap8y940tVg4HXY2HTtz+pITFfSY4U
	 Fww7m/cVdBN2MwDlDES1DkcXtQ4ugtMROzximw6tG0qAfHfpRHxFtWXZ3KDC87U1jeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jQkl36mN;
	arc=none smtp.remote-ip=209.85.160.52
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC68606A329
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDC68606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jQkl36mN
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4911df1e196so705263fac.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817946; x=1794422746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5jBNIeVN5XdbR1Hrlv39MgpAIZ3C/3isZgY1B6s9aw0=;
        b=jQkl36mNS1t9mSR/Gw1fAmef3ilf/mImXVomm+aCc6SvcMqbFa14Loitv1pEIbcmq0
         kA+rnmvEQpPLJWppB+QtXXjPCfx5X8R0iMUe8n5D4S6mtFoRNUYo9cyVZL8oKNhQST16
         UQ1kOWjLsOGT8/f9rflZn7EVUP66Jutck7Hfv0MRoR1gp2Ot+tUAJb1hHz7/mtYWuEik
         jtY0iE5w5KFSSNG4JAWfmln5hHxwUtKxmCdfZ9rJ5yiqh9BJcdNic+f+yKevKNY9JZZZ
         tL/JGOWjM7SC7GB2Xw8CzdL6GviHt2pltX3nNUgiubuNnDR534uUOnlJPXRbnViGdA+2
         vCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817946; x=1794422746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5jBNIeVN5XdbR1Hrlv39MgpAIZ3C/3isZgY1B6s9aw0=;
        b=eXgBNbbNKaZlQTN1+L8HG3WZI9aHJvuFlz5PX6W2jk1gLij6idzuAzF3aayETamMta
         VNlfGeBz4DLZ36P/08Kp5LSAuZdWo0oGvXHLYd+NnsGCzYLiOOLY6FpnRWohCrRtVv8r
         GG+mEB/y61u3UYJEFYkVURtzwBIQMM0SgLMe2n6co53o30QKBSMIrIlBQls2IVlRvzrM
         dz8SIwX6NvZ+vIYh3bjcIQzYLJwEt2vRoE5FLJ9sB/hG9dKysm0HTc5Cbau0c5cidVt1
         q7CQcJ9pYA7w1tJzewuwDZoWDQQZxWUevUtoAMqtUgrd78jQZ0wRerdGsa2P/1CTYyMA
         /RVw==
X-Gm-Message-State: APuU4Z9QtkwMxv9uKO/NOmta/KbbYM5gpa8OrtBveoOiXo1k8WxM9uFm
	JN+h2lQLC2MinJwY3nXdREF3O9qMlchjESs/4Za+kuVyigXEefRXZt/5IV0nX1d/xq7yI1mBydU
	lh8zG6wo=
X-Gm-Gg: AYBFou2R0R3cCkJ55jvY+u9wnks8EPdnYYpADy7m3Dcz3Yj2iud3rV7lAJWENfobHW7
	QQev/Hbn+wWu1TFI/ApRbqQB7TAKNezLsh4nnFLMCnrysF73qTQJWeOubo0jpvisZbTVuirkHn6
	H2WYQW7kQAkrpHSdQFRu82TtOeOj0NwsGKXtX3dZYbDbLTB0vi0xpWTrRO+ERbIKpkfUY4V5Sls
	G3V0Yi8PcOAGK/Kp1lFzGbOMUp/ggOkw++xvJj0o5P+NVZnWP+mdvcEpO6Xuevm/tPLE1izNfhG
	JqGKVm4X0FP6dtiwuX0XfJszqZSK8gdNSA5iaSYuva12m+6UdwCBPWW2uKC/GFbNhtSilinlV/t
	W7HN0uFIs2tKxThMXPIz86Hs2bf6x9Dqz8RWEw3cgEOt2aIYcmj6RWQ2EnP8LBj2BXYsvCGkR1M
	l4inP5kSxhrVSLZl3UCyd1kesUXAHgX7cjxTNVeHiWZ1/K4Y49GYH+O2csNBO/2f7y5XHR8M8ZT
	yRM6TEmp4idPCH0wkJ44wfolRwqwkpLOwAQGjAbAwLcmja8ys9k8XyeKuHvfjtG6cajGIJHELSc
	weeKj4b4vUHGII8lVRgfYle0gM+ANJD3MWuephjkq60kGCLXT3iK+z6W4iwhCGTGfM+xZ9/fNA=
	=
X-Received: by 2002:a05:6870:a2ca:b0:494:ad56:c418 with SMTP id 586e51a60fabf-4a90778103cmr11205190fac.50.1793817945524;
        Wed, 04 Nov 2026 10:45:45 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea4903e9sm2590963fac.3.2026.11.04.10.45.43
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:45:43 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 7.3.y 16/16] io_uring/net: fix multishot recv length limit accounting
Date: Wed,  4 Nov 2026 11:44:47 -0700
Message-ID: <20261104184447.516768-17-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184447.516768-1-axboe@kernel.dk>
References: <20261104184447.516768-1-axboe@kernel.dk>
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

Commit 3e3aebb7570ccdde5cc49c9bfc8fd3a436b71b0c upstream.

io_recv_finish() debits sr->mshot_total_len with min_t(int, sel->val,
sr->mshot_total_len).  sel->val is the cumulative byte count of the
request: on a bundle retry the receive path adds sr->done_io back to the
return value, and the bundle branch in io_recv_finish() recovers the new
bytes with this_ret = sel->val - sr->done_io.  The debit therefore uses
the wrong value after a bundle retry, and the int cast truncates a limit
above INT_MAX.

For an IORING_OP_RECV multishot request with optlen above INT_MAX, the
limit becomes negative when cast to int, so the first completion debits
the entire limit and ends the multishot with IORING_RECV_MSHOT_DONE
while the socket still holds data that covers the limit.  With 120 bytes
queued, a 64-byte buffer and optlen 0x80000000, the first 64-byte CQE
lacks IORING_CQE_F_MORE and 56 bytes remain unread; the same setup with
optlen 0x7fffffff posts 64 and 56 bytes with F_MORE.

After a bundle retry, the bytes already debited for the previous
attempts are debited again, so the limit is exhausted early.  With 1400
bytes queued, optlen 1000 and buffers of 600, 100, 100, 50, 50 and 200
bytes, the first attempt delivers 700 bytes and retries; the second
delivers 200 more, but the debit accounts for 900 and finishes the
request with a terminal 900-byte CQE while 500 bytes remain unread.  The
limit could have been reached.

Debit only the bytes received by this invocation, sel->val -
sr->done_io, and compare as unsigned so a limit above INT_MAX is
accounted correctly. Non-bundle multishot requests keep sr->done_io at
zero, so their accounting is unchanged.

Fixes: 0ebc9a7ecf6a ("io_uring/net: Support multishot receive len cap")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
Link: https://patch.msgid.link/179328314078.648427.10086632105828535293@gmail.com
[axboe: fix-up near-by incorrect comment while in there]
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/net.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/io_uring/net.c b/io_uring/net.c
index b62f21df42f2..4b36883e101b 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -881,12 +881,15 @@ static inline bool io_recv_finish(struct io_kiocb *req,
 		cflags |= IORING_CQE_F_SOCK_NONEMPTY;
 
 	if (sel->val > 0 && sr->flags & IORING_RECV_MSHOT_LIM) {
+		unsigned int this_len = sel->val - sr->done_io;
+
 		/*
-		 * If sr->len hits zero, the limit has been reached. Mark
-		 * mshot as finished, and flag MSHOT_DONE as well to prevent
-		 * a potential bundle from being retried.
+		 * If sr->mshot_total_len hits zero, the limit has been reached.
+		 * Mark mshot as finished, and flag MSHOT_DONE as well to
+		 * prevent a potential bundle from being retried.
 		 */
-		sr->mshot_total_len -= min_t(int, sel->val, sr->mshot_total_len);
+		sr->mshot_total_len -= min_t(unsigned int, this_len,
+					     sr->mshot_total_len);
 		if (!sr->mshot_total_len) {
 			sr->flags |= IORING_RECV_MSHOT_DONE;
 			mshot_finished = true;
-- 
2.56.0

