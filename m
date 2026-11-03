Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695213;
	b=G6rJ9QHbWRrI+LR3bPbIqnM+vm9aPC55fTRabkVyhSJkA+ltvW7eGwFaOpEhDCeXSmhR
	 i4r4GY4o1TNaB+YLvcvQm2lEmopmAfa4K4U9Tqst/GyKtcNm9nRcjTg2oMoayRpJFsTZZ
	 AYpG3Brbj2dyikjbOfXr2UEnS+SlsUFHwLqg+ZelcHwmUY8wg+8MPYzZAGiQm1Xd+/RUY
	 j6HwbVZh0rEUQ6p70jZ0LtfaTGAotcvxAY4hdmbuhmrbwyjch08co8AHM5ylBdPvmiI02
	 qtW9Mmy1V9wmstBCYA5+hyxjoCCLrOZCcosZmV6rmzWdYmohHaIu2vDXs9V9nkg2NAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695213;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=a9yCqBKnWEF+1G5GJ+rwV3M7Y3WdLHInlO9rhMJ5y4c=;
	b=G7tddILH9a91vifmb78+Xv0Vo4I0900KVzjvBaltYiVNVdrawOG7HYGmWHd9axTch3SZ
	 7YVMaxbWGgRqa5Dt1PFvA4LccW1Cncl4leX3Uk0CgOeKWlZ2irhur9pRTmrU6VgnNVZT/
	 XLFu+caAc28QyuR28nh4agA+gdRGzlZ6cmf72sjSFwiS0hLYwiaPzf6ZRlCTl5x0scOTl
	 SBunymQJWkfkahkBGYaAlF2N0PhN9lKj+B6j/JyXdrLcz5cw7KlWttgk3F1On6Xg7aEAi
	 7cGVnhOjOybTe8L88tdAkyioUgM5JU//yJe1Ppfve1OXpXtevejVeB6asABVqHe2MpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=emnUrVjb;
	arc=none smtp.remote-ip=74.125.228.6
Received: from mail-pz2-f6.google.com (mail-pz2-f6.google.com [74.125.228.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E44606A337
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 08:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2E44606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=emnUrVjb
Received: by mail-pz2-f6.google.com with SMTP id 41be03b00d2f7-cd8cb23d52eso1958280a12.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 00:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793695212; x=1794300012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a9yCqBKnWEF+1G5GJ+rwV3M7Y3WdLHInlO9rhMJ5y4c=;
        b=emnUrVjbx+yqVPl8qY0qZedVuqj89xR/f3P2zuxfZyEuk8ohfEMNptICm68/DDqL4j
         SAU1Y0xTV1/1bHY8BTP3Na0vo2NqHkTuaac303hFPN9rN1OqR/WsYukgsvODjYTcjfx5
         1y/+x0IgoOuKztkGTgcKZcC4uV8006pHDdVZRF0oluZrSDzYHMxX0vJpyDtXO0c2ntqN
         DKSWggRJ4cxYY1jkiWW6UdVVghKuaRGyCxKZhaqMbLZr8U7hoSgzWopEIntChbOrBzE2
         zBRH0OxwF6y7iZtuSf7bk9gQEY/13BtRJAu20Vne4JAjHpqvctD9Pc+G8SeE2q1K8qhC
         5FRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793695212; x=1794300012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a9yCqBKnWEF+1G5GJ+rwV3M7Y3WdLHInlO9rhMJ5y4c=;
        b=Z1PsAqH9WlX3yA8SVH6bXJequmGFVWQBzfQaF+U1uwVZuBxMDXN/5wdwIijniOPo9f
         YGCnm+fuJmPQcXxkeLd+WIF1RuUhecECJig+R5bnnOVZCbh/kmdUCpDf8C/pS5RnbN5i
         Bvkfr6LS+btDSQcxOgBgB5X3OZF9wU4GtL+f0YnObrl2YlE6V8QwFBTFdV0p1rwkof05
         MS6BSXFKVGxYdKI2wSthAZo90CQzbyuHlwtDlWJJVSa3IwKhYY3EkemfeWRJUjiZOU6Z
         XO0BFLLrrJdtpVe2tvi1rmHAAvoyqASiQv6aasSzd2k5DValO2+JNgBB21OSG5V6N9gK
         AN8w==
X-Forwarded-Encrypted: i=1; AKwUvBzTz0NO4ZGxArsiOsj05L1y6uCd05d+G6WoPSN/lKgX28RMZ/2leFmCsX3DS0fVNcz3iClgGOE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+nApU0pnz2KcFPmeYS0YQnClElBD8+kZLjPfvi1ePkS3EdDk/L
	yqwP1egYJ5Z0cStivIj/zYJj9ejFxy6E2MrzZZ8dY5dVMlCviMzAzgLz
X-Gm-Gg: AYBFou2FqfZVJdkEFPWDXneZsm7vXoXnemqh4VtYK9NGPiu52LoYTNSvgxA46ZIQHSd
	OBz9mbfQoio6QsELWP6SJ5OtxXtUhr2nmoXd+0n6ZN/B143KtZ0wQSciX/To3VDcBSolXoovGcC
	Ar9Z86k01HgdA4sgzC8QEjYk0FpzRGYRe5v6yTQQNMGA2yRR+b10j0v5X/FOnPrCUtCOSEMlQ0F
	SARAveEe5K6nh0/b1vNH49pKdpt6dgTPECuelwWPTkDGr+XE6yeEj63ML7hpy0N4oYlLe8LqkEG
	Z+J/7DdIfm6iVl6mkmNkQQmxvLCvtYXdG+bjvcxWj/dL3C3kOVNmw1bZdjJ9fNRGXEP+qL4FG45
	EyzoPoNeu4mY69/APNVPQTcOLvHgWtB6FG4FmryevwQSbgW6J4khsBZniy4Js8JlXBubAbRHpED
	EjNuPTYMOYFhD8Mq8nsg4do/pl6qhB5uKLcfHLRvB3LeGZlShZob65YeNyjKwZ8p0eZz17JiFI2
	w97VCsW33CVPhXGjVW1qwlvqxMMZymAAn1VEjEsPkpDwXuKyv/8r9ojop1eUH1PrwemG1DD76Cg
	t874rE5LI450feklTwhVw0Lmz/VaG8E2qvUzmWKQcRazhDpCKFo6mfop
X-Received: by 2002:a05:6a00:a0c:b0:89e:724d:1ae3 with SMTP id d2e1a72fcca58-8a9ba2299e9mr10800761b3a.2.1793695211896;
        Tue, 03 Nov 2026 00:40:11 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad963cfccsm2998833b3a.9.2026.11.03.00.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 00:40:11 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: miklos@szeredi.hu
Cc: fuse-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	joannelkoong@gmail.com,
	jamz@amazon.com,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] fuse: clear the old EOF tail before writeback-cache writes
Date: Tue,  3 Nov 2026 08:34:25 +0000
Message-ID: <20261103083425.55695-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Buffered writeback-cache writes go through iomap_file_buffered_write(),
but do not clear cached data between the old EOF and the write position.
If a shared mapping dirtied the tail of the old EOF page, an extending
write can expose those bytes as file contents instead of zeros. A later
writeback can also send them to the server.

Clear the gap under the existing inode lock before the buffered write.
Use the same page-cache cleanup as fuse_perform_write() does for
write-through writes, leaving the write range itself untouched.

Fixes: 4d99ff8f12eb ("fuse: Turn writeback cache on")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/fuse/file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index d5e1cb53d86a6b35e63ca31b1065068ea5bdb6be..1c43c2f58e0a127004d74f3a28548b20d3d8a013 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1565,6 +1565,11 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		written = direct_write_fallback(iocb, from, written,
 				fuse_perform_write(iocb, from));
 	} else if (writeback) {
+		loff_t old_size = i_size_read(inode);
+
+		if (iocb->ki_pos > old_size)
+			truncate_pagecache_range(inode, old_size, iocb->ki_pos - 1);
+
 		/*
 		 * Use iomap so that we can do granular uptodate reads
 		 * and granular dirty tracking for large folios.

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0
