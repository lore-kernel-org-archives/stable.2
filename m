Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794036420;
	b=f9SGzsjf9PkwzQi1oGVs+2ShCCDbDK9vJ+n28JaRGijnPTaEVVsXpvgOtJPxktLgj+5o
	 4d5vjkmpnmtDem/Sj5Amz07W36G8Z6HPc8fr09lzXcX0IVWK6j+CYIUebdCy1D4vAtRLE
	 k5dUu9P1jNMGMJUbe2sdfst+gPGLaNWHwPJ4+OwyoEFB4H+XUgdT50gQXAcVp6CRslGV/
	 D1ejbDjeLHWTPvHGo8eHaUETgHlsfScmRCC/tZx9DeBGFAPbOzwwuXbi5Yin1PvGTHxFm
	 w4IGWAvTUwy+kkcY/uQFa1TsaBnht0EU+VSaps0uxIuZkyqh60NBgPnmoYyHX+UzX5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794036420;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PSwvgBY5tKnxuW7xy2pwUvdfMnozikmSscxGDiw6G2I=;
	b=5kJO7BtWFJRj5jHnPK8Q+bD7gc6wEuJIhGmDCWAcEdmTt4rwETUtF5w/bEtzSbchOYPt
	 RiShbZceeujl7rb8PLxeDIKlC6YQM/c9TeXwMHswBE4NbiuHDRDqQRR0YqPVpS3sUEOrF
	 udmcR7NrWDwhHqQqwHHa0wWLNMHRaHvO4nzy/m+eRe2caGXR7ndcHFcBlCQQgSBUAbolP
	 5pCSigwHDd/tDqMMm5WU2DmpmZpkJnfirNeN0mbhYChYnzuhcliKTASurE9VCw9/F6/rA
	 zKR7ls7b2MOUbWa0tYXn87infT/w+mn2LFhzMIxrBjw+YB2lyAtGQq4lgnEK+jlt/oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PQPugjLI;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEC9606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 07:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CEC9606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PQPugjLI
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so16203515e9.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 23:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794036417; x=1794641217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PSwvgBY5tKnxuW7xy2pwUvdfMnozikmSscxGDiw6G2I=;
        b=PQPugjLInEABVjaemwtq7Hu8bTFa2wVlgSheOLBj1ew76vrFonee9caA3Yqej2AkYO
         TxHEEixr8E5yJ0bQp2o1uyHpd9zyym8zxBJXbt/XDerDBsr9Q7HZi/373arHH6yrOQxI
         E514PhTSAscHwrdKYHRiGizCCh6z4DQjjhAQN4syvRjQfZbIB+hRrcFao6nTUrnB5LUi
         BKUB5lD0ESlT/Dof/Sb88v7mcwECxkCTrpJqe4bqNP4rUZiBbILHRLDi5fPdqS3iYuMl
         2p13t9zik0xEVaMfekckwFJsqTbjhZ9fTBV9vSATdAmIvMzKtOMeuHWpFh6o8LSg7GF2
         Gllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794036417; x=1794641217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PSwvgBY5tKnxuW7xy2pwUvdfMnozikmSscxGDiw6G2I=;
        b=nF42psPh0tl5DeNeCB1MZ1zEs2XgfaxXO2P/hCRcFBJE3YPi6LW+9wfAzLRG+x+BL9
         +pSe6LyyDeMo5v3JrRae9bPidy9knHGfBtxaLf09Hf4g+/N+9hTw9Sr8i1nyn204NUxG
         hQ58FO5fR4OX1CLirI7Ehk0Pl5J5c5+SI2GVBjlRc3g20363uibc6TUpcL86PqLZ6dmv
         8udi0vEGUqI9EK4gsikp6Vm5oqaPu+1u1amtOTY3dsf4CasF/fDOlS2PmB8ystasb0Tv
         HsN1V7bdF+YFgg8VYXLDzxu9EhJljNW3yIpSW392Zf48uqDSpk/PXAvN1fQMaBlOAKJu
         avfg==
X-Forwarded-Encrypted: i=1; AKwUvBw7r7EiDJkN0MqPj5AIExDsg2Z0ClTpLtyS0uLvK2lNlKSgl4LhHrKJZQe6i34PVQ4nzacjOqw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8VePAfas1/1rmqY7R551bkARGuYTKihAnULqGI/WdfooAiHHWd
	AL9xH6+A0FvdEOzuUMsALXytZ0HIy1I5v/jVo1Q6NxS2c1MFCPVsZK7d
X-Gm-Gg: AYBFou0inEO31uLF343jayTiHV5NY4qINl+p3iTOdkwZGmf7Q65ZBIFhojWCLzwzYBV
	zoKkef/2YiEVI6jTK/t6lQYM2cPY7NI+v4MTNNI2GlRphIPWOA9bR+6KSRRhnQy9pbh6qfU3kjT
	9i0sTP1IRUwiCk3FK9Gi+BCEPG7OzBvYqUigM8braw+vFHb5VJmBmNNwTpKdIwPD7NdAmHluXGa
	TGclCE6xt4SDhJJnCN1Enq7SZjj0XeRCTZVKEmO+3Dk01PywAa7GC9qV/ZOo1yPxrD5Gvc1/8He
	0Jd9zRzInMBgfsDEZa1jbAlnWVQ2bm6Jx2X8hfu6GCTcor7BOUUI+y1JOLQe/uHOkX9SCKqFed1
	ox9LmYHRpoZ7/lWrn8lGvDgqJCk2OwKmSz9oK1PWR8tH07hLV9Nfn6bFWLBOrWSOc7nPtwC3f3q
	/3pl0Hhiv5N/elQF+gjdYvsT1zSOOTy4xUS+5ZnISXMtGXXGHJxg3JgIvyq0XZPhuctbawrfIOu
	dsOB192TX8niEVjQDpWnd5JdJ6Y0A/W+sRhHuitsPakhkOPpwrs/d6VYcpNMkJdp0YG/Qv87Q1G
	J8m+YfEcwiB4qspTqF4/dRNEbI/BXW/DcsE0kU6St0PDJe56WCGEJ4TjXosMSEfBQNow1F3xAB9
	QpYB8q5dtmlFlrN2XTm1+O2VJUWk496/BDWHA3WTmOijK04MnVJg=
X-Received: by 2002:a05:600c:34ca:b0:4a1:7c56:d4e2 with SMTP id 5b1f17b1804b1-4b6df212530mr76856485e9.16.1794036417341;
        Fri, 06 Nov 2026 23:26:57 -0800 (PST)
Received: from DESKTOP-IR7J1S9.localdomain ([129.45.78.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e3283b50sm41843175e9.10.2026.11.06.23.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 23:26:56 -0800 (PST)
From: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
To: Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>
Cc: syzbot+3e16980543e238b95bd1@syzkaller.appspotmail.com,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] dm cache: fix divide error in too_many_discard_blocks
Date: Sat,  7 Nov 2026 08:26:48 +0100
Message-ID: <20261107072648.554-1-drifabdelmalekmohamedsaid@gmail.com>
X-Mailer: git-send-email 2.47.3
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

too_many_discard_blocks() uses sector_div(), whose divisor is a u32.
discard_block_size is a 64-bit sector_t that calculate_discard_block_size()
keeps doubling, so once it reaches a multiple of 2^32 the divisor is
truncated to 0 and the division traps with a divide error. Smaller values
above 2^32 are also silently truncated, giving a wrong quotient.

This needs an origin of more than 2^45 sectors, which is unrealistic (this
is a thing still in 2026!!) for a real device but reachable with a fuzzer.

Switching the div operation to one that uses 64 bits divisor would cause regression,
so we just limit the value of cache->discard_block_size to U32_MAX.

Reported-by: syzbot+3e16980543e238b95bd1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3e16980543e238b95bd1
Fixes: 08b184514f65 (" dm cache: revert "prevent corruption caused by discard_block_size > cache_block_size" ")
Tested-by: syzbot+3e16980543e238b95bd1@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
---
 drivers/md/dm-cache-target.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index 1a5072425c4a..b51ceca60afc 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -2383,6 +2383,8 @@ static int create_cache_policy(struct cache *cache, struct cache_args *ca,
 static bool too_many_discard_blocks(sector_t discard_block_size,
 				    sector_t origin_size)
 {
+	if (discard_block_size > U32_MAX / 2)
+		return false;
 	(void) sector_div(origin_size, discard_block_size);
 
 	return origin_size > MAX_DISCARD_BLOCKS;
-- 
2.47.3

