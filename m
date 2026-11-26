Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685889;
	b=I1tc4BRz1dUUCi5w3kv3hrNOL1AUNaiuNOw24B0Rg2s9fOmkO7hZskT6ExQwJ+7zFvke
	 VWlR9Crz6tC1Hu2M0Ps0ygtb1c+0OpA3LA6cAqRq5Alf2VBc9RUJuVIBc3zQyYqChfut0
	 +UNhCAS9uHmX048BiQCpcA/BxuXuTQFWkNmLvEjrJibwaWPVsvPE9LhrjNTa/ChoZ5gNY
	 Cufh0bEZyqvl+FikpwH797hnhMl0yfLP7ngJnhfBnFQK1cCV13QkqW/KZP4zMoRDZrwRA
	 IXd9k1KufmUQc6GHEhEFRxkww9xTiN7gDhGdNwy++kKXdPjxx9pW2k/dhyrX6qNbSDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685889;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rsNqaj+bXc/v5pLCFTeTs+S9z83Xe3DxebqgKuXb2Ic=;
	b=P4/wQgPzRe99XzmmBGlGOR2P9fv6jUZUfVGEaRgkUP/fzcuxM1wPqIrEe0FbocDLWltc
	 4VYhPsJ9ow6QC7MVq+qqVX9yAaXGp7cKrgQkG0qgleQtM7oSH4pyQQH1gF0l0W9dZ850P
	 /Wp1lXSwyC5kwEil59yrrwhOcMgS8rsOR/Qmtn7ZkBKgiF9pY3uO6+IJTQPXIojQkBgIj
	 G6eUa1bF9/az4FNJP/4V0KkWR2v5TFZsKNX4+8Of/yEfFXWYrhPQYeK0xZckKPACvY+w8
	 RpWmdD3/FEs7QAJ+sE4vHlcsj4gBEhXo7RADFKvR2AhemzOjJRX0EYnypE5LkjuBcqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fSw66Vwg;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D0D606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 09:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2D0D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fSw66Vwg
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-14394530ec6so272952c88.1
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 01:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795685888; x=1796290688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rsNqaj+bXc/v5pLCFTeTs+S9z83Xe3DxebqgKuXb2Ic=;
        b=fSw66Vwge0QjmaCrydvktO8QXKG8LEluTa1Zb5fBq+5ZOsYGUtfBQssVIInvAtBD5b
         88Qry4se30oJNGuIyCaEyPctUhFLaA6dENbTmM1wna5wk/YOUEkNVAq/7pOk24x4VTqO
         cWsRFFBIFwDlMT1rdpA7CbvF7NJ8jtU1AWJ0UoJDmOq7NWRUpeQUIcihjzJj9n3fimcE
         l8xVUlwqGYGDIJybc5iyPIr+CFqz4TB6f4RAiJjAYxdgTQQgBzVTHUxYmyWqGwyXGs+3
         iLxaR52q4O/AtS4im9iHZgzxPkEW2yUWSmAOJfTYhjqfnmU4Lgg7/siTjDT0PS5oHVly
         Lgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795685888; x=1796290688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rsNqaj+bXc/v5pLCFTeTs+S9z83Xe3DxebqgKuXb2Ic=;
        b=YTsVZwsA+BKHT7Cnv9jGQDWqMJV7LhW1bCdt21Mn6sp4ukdiwvZuHHIEZd3iX68BTK
         ZnjylilwSnyznhDkccuLtLF3j0WsaPNQhToslfJYuarhNWU4Fj5f+g8Zlr0+sH7ONheO
         YS2JbmxU83viXNCym80SVLtZGxXJwUfcCIWAyxzgK3SMBWGh+zFAHdSW3agy5APKsgUM
         Jttd5iANGQSs8hVTojQyEjMGXKlQxeskQ8F6iYK1FdsaB30gxvi2KmGspD7HzGIm/mW7
         LFmnlanvQXfS694A4QLFWfAQTII0UsldXZ3+PTvjJMED5ap6cCb6gvareF7G/AyW6cn5
         Enug==
X-Forwarded-Encrypted: i=1; AL+hErEVO5e+zMtuLbknbvC3205+VP5WV5IYIk7f9xvxHiBajsE2No4XXDmSqcdFQJXV9z52BLItRS0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9NKExbwSnqVJitx+rZmOuDL7Qi5e9yIJiEn6gQyf1z/ZtpOq1Q
	sktXwVgGO5nQVyu0fAf/YEgWrz3I45D7yhc5DBcsn7tWvBaqcy+PDx3FZ/Q/aLQh
X-Gm-Gg: AZFdTZetoCe9cN9WMPuRDfQ9WJVg5z/bRr8huLBPa1+xNhJbbiFTBgylFqVZoPVSYUy
	kPR/KDjR7c8aMFFZT9dHtzZenGX945Au1JdX2tNUmhWPl8AnIgg+Rvr4DXm5/WmbO0Hxg4hH8A/
	yKl7F5mHwhATqrncUqgIAA1hEfdHKck1g5VUoFfQoJXsibcuRjLvAZEwz0PmTEtqLu5hRInJT1y
	Fz7oXro1vledJ/VD0ajUq6sDtlUoQ9DckK75R4mq9Ez7PmJvN0txx3urCe5QEEI26eWbBxpHQIn
	KtNsdMO+ti88kTohovqBmruUgvpMd8p2+67kdeLEdNJ4ZgehuroeU7g2bLAiu4KWP2el8/zpKyu
	twqZL2WMkmyJHI9B7RqEaMlmw7quZetbef/GvQd129qxCkaryFXukYX9hUrPs5s2me1z6vIg5t0
	NHQheWKBLM36G3+5AFMco5NRK24b0ZCHTeJpndD1rbl3tGetWhzYHh2xktmE4b8n4UmrT6XUAB0
	vyqy4Tp5GI4pOedVrTCTJdIy6kXDeGeXzf1d6kgjc0uHlLcKaNR9rbMJf/B2fxFtl57HhG4sdsC
	0PArsYAtgoJ0mrBBcB/FtUWqPFSPSmH7pja3NA4iG534IdI9r8xWLYZCkIUeB2sKPW3Osd9EQTc
	GOZ0jzcyox1pvNA==
X-Received: by 2002:a05:701b:4502:20b0:152:9e88:daaa with SMTP id a92af1059eb24-1b55690040amr20145598c88.36.1795685887798;
        Thu, 26 Nov 2026 01:38:07 -0800 (PST)
Received: from hyeonjun-ThinkPad-X13-Gen-1.. ([124.197.199.8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5568592adsm46845363c88.15.2026.11.26.01.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 01:38:07 -0800 (PST)
From: Hyeonjun Hong <hyeonjunhong330@gmail.com>
To: Coly Li <colyli@fygo.io>,
	Kent Overstreet <kent.overstreet@linux.dev>
Cc: Jens Axboe <axboe@kernel.dk>,
	linux-bcache@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hyeonjun Hong <hyeonjunhong330@gmail.com>,
	Seojin An <love09010224@uos.ac.kr>,
	GEONWOO HAN <gunwoo9643@uos.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH] bcache: fix out-of-bounds write in bch_data_verify()
Date: Thu, 26 Nov 2026 18:36:55 +0900
Message-Id: <20261126093655.393608-1-hyeonjunhong330@gmail.com>
X-Mailer: git-send-email 2.34.1
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

bch_data_verify() sizes its check bio from bio_segments() of the original
read bio, which is an unsigned int.  bio_kmalloc() takes an unsigned short,
so the count is truncated before bio_kmalloc() compares it against
BIO_MAX_INLINE_VECS.  A read bio with 65536 segments is truncated to zero,
passes the limit check and gets a bio with no bio_vec space.  bch_bio_map()
then fills in bio_vecs from bi_size without looking at bi_max_vecs and
writes far beyond the allocation.

A single read bio of this size reaches bcache through an io_uring
registered buffer, which the block layer attaches to the bio without
splitting.  Reading 256 MiB from a cached device with verify enabled on a
KASAN/KFENCE kernel gives:

  BUG: KFENCE: out-of-bounds write in bch_bio_map+0x132/0x420
  Out-of-bounds write at 0x00000000cb5c6057 (132B right of kfence-#252):
   bch_bio_map+0x132/0x420
   bch_data_verify+0x3d2/0xc40
   cached_dev_read_done+0x6d4/0x890
   process_one_work+0xafd/0x1ee0
  kfence-#252: 0x000000008ee01c90-0x000000001f8e8fd6, size=120, cache=kmalloc-128
  allocated by task 12 on cpu 0 at 63.371786s (0.000577s ago):
   bio_kmalloc+0x45/0x80
   bch_data_verify+0x2be/0xc40

followed by a general protection fault and panic.  A 255 MiB read is not
affected because its truncated count still exceeds BIO_MAX_INLINE_VECS and
bio_kmalloc() returns NULL.

The verify path needs CONFIG_BCACHE_DEBUG and the verify attribute to be
set through sysfs.

Check the segment count before it is narrowed and skip verification of
bios that are too large, which is what already happens for every other
count above BIO_MAX_INLINE_VECS.

AI tools assisted the source audit, reproducer construction and patch
drafting.

Fixes: 0f2e6ab851ae ("block: turn the nr_iovecs argument to bio_alloc* into an unsigned short")
Reported-by: Seojin An <love09010224@uos.ac.kr>
Reported-by: GEONWOO HAN <gunwoo9643@uos.ac.kr>
Cc: stable@vger.kernel.org
Signed-off-by: Hyeonjun Hong <hyeonjunhong330@gmail.com>
---
 drivers/md/bcache/debug.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
index 2691a5da3368..fa665b4628b1 100644
--- a/drivers/md/bcache/debug.c
+++ b/drivers/md/bcache/debug.c
@@ -112,6 +112,14 @@ void bch_data_verify(struct cached_dev *dc, struct bio *bio)
 	struct bio_vec bv, cbv;
 	struct bvec_iter iter, citer = { 0 };
 
+	/*
+	 * bio_kmalloc() takes an unsigned short, so a larger segment count
+	 * would be truncated before its own limit check.  Skip verification
+	 * of bios which cannot be represented.
+	 */
+	if (nr_segs > BIO_MAX_INLINE_VECS)
+		return;
+
 	check = bio_kmalloc(nr_segs, GFP_NOIO);
 	if (!check)
 		return;
