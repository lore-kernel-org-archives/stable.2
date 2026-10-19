Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792435808;
	b=ERX/kOAHlGJKryViTIfR51U7NpN8ipRRhCCDk8geyuuGnXHePyLYuHOrhx7J3xkAWtuq
	 UZO8EKp2Nm+nqsYAEoYvVgzNcNqagWfQVbgvQXmXYgh7T3Iy9PTrNY5jbSbKe2QyuuZD6
	 Lj5mskyEXg2rcbE+PuadN/nxzmvCnoTyfgAN8H4QKzxtsC7snE4c5duSUxaSOkxEkqDk/
	 AthdPsEGAsoEGYZM/jeRRnlYugML8iG5KN0XAdo3XXE16/YyJpVErVMYanncfByLVWJNN
	 MzTFi9Zk6zYGePmstCLXwcME/w2qOb4oB80at8ur/Go0IhYA7yiQQl0D4EMyFetqBtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792435808;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qQajsp9ObyIZH1W2JtDu/mB6mPActDF2v9UueTjQ/T8=;
	b=WQSO5RR0A2MDi1tHnSGzoZ6IZRb2Tyd9lW58qZykliBLtEHPHbIZb/t0IX81A/XP0ucJ
	 tsfvFz6sheDkyB7UPuEnYTltOCEgpe6gasYPVVS3KIwm/uvhXi/P9mvtLkrooygTlyHSv
	 JGdCXhYopeeRPnPoJqdxOIz6kfat6Jwpf7OzKAC3+snbLhK2aVgj7l4Qa/OKZ1271HZsX
	 cyIUqeH3V8dF4PmjPRCWrWLBNYDX1NhXH+w22G5lkXsmfiXmJ4H4ituf5JEuRw6dwTfeH
	 WosAMcsdVOOm2Xuf5tJjBfh4vz7lzKZyw3DB1lvowgd6ZfOQO33JGBE/IPzBA5lg9TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=PC4SbAoc;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB00606A31B
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 18:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEB00606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=PC4SbAoc
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-917a707f37eso25260666d6.0
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 11:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792435807; x=1793040607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qQajsp9ObyIZH1W2JtDu/mB6mPActDF2v9UueTjQ/T8=;
        b=PC4SbAocOcKCk1olB/9Of3Mk7Qksv9J9g2B61lEgWdLNvU+Yk1s6PVk5lvuLnEx4lr
         mvmVmSWV7KSn+Z2JaGwGn9L7La1IOFjQymWkn1bzEOHufm9ZTc5KURasEQh5ElYjRbXu
         pfUjc4qrhvx9DsP/4jkQtXaZpcv3Mp6YWNCZLk3TQKeVpjmfiT5+GN3fj3zKf54x4M71
         COp8q/V0vv1J9MIAQaXyPB8ayYjoIXNHmwfy7X+Q3jY81iGkW7zlJkNKNoXeZZFxp9ZG
         gaq36sIN76PGb1mJmGGJGzCb+KRwuTdKUGb69h3rHTb9E9+eurkZ7j0jfzTeNb7aSTA3
         QUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792435807; x=1793040607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qQajsp9ObyIZH1W2JtDu/mB6mPActDF2v9UueTjQ/T8=;
        b=qCIJrt891XP/+u/621BTPHyNqT7nLcvDOGv+iexOp4ZI6kp21m/IBzBuFigPg4Ov3x
         jrdK1KJC64e7+khglhnZHM9ymbZoOjZuQES5l+h/Nxcxfno7arOMMYYP9boOZO2XbtUe
         2rgtxTm+JMyOcqu0CnDFinGULvHSbORHCbXkNcNLhpqaTA1LYcKc1kxZS/tfmpLFMKhG
         KjOAYfLvFHs0SXi8p57H7s9o5AhYUkyOxVJ0ib+RJGSSLlb+Syb5QJ6DYqUg5Gz0Paz8
         UVOX5e16AEJRFqV/+GTki0eeXrQoA+CH/LUXhGbg4ojqb9RjDF7hHbTNdieEXuTgyFWy
         A4Qg==
X-Forwarded-Encrypted: i=1; AKwUvBzXUqZ7+1k9GiFWwjuXImuI32kiC1upH54CWkHJoqPGNM8aTJ4llwynARXOzgoMSqovRi6aDPk=@vger.kernel.org
X-Gm-Message-State: AFq9FYL0JaxrFPksnMJq+vWZAVFiEDdQalsG7OKLWP/uttwI8/yNouim
	XZTzQ6dVazeNZNO1rqUu/+wjHiMjP7IUKrvqrWb9WrXDbdeYUFfs/6IKnUaQaKE+cRk=
X-Gm-Gg: AYBFou00L6fkMNe1n2rr8y2B/G+RoSb4B8h5w6v1Skagof3DJGrGglYLEmzuSOhlHPT
	95mP1nJPmK/1ogO1iuNJdMhy5DTbbU1mSW8Yf1Mg9VQQxHZqQjef/ALtqf3s5WShCkVJFBB543Y
	sCCVBJ0vBzBFC97gY8D1GQoiZvbzIBYhZHqZEXDKG0VzPt7CacWfUPIwrgbJP/ldJEIm/PsH9i5
	e0zPt0VjVc0t0qGvcUoFFL21Fbs1B5OKvo5zRcpv402v1HXaqomOCW2tScpnD5tcpskga2GuOXy
	ECl0IUbbgf6ii4ENtefrtSbbcc7q1f1vJTOepjrdJcbyoj/fxGCeiVCLlBt5DrY4iugKPf7fmf/
	0qJ0pGFUycOUwYnTMJpJ9P9ThylPjAfJxsAc67Afeo6Pz+wyXR8/aZl7u0xeLiXVQ7g5aGCNVDU
	VeDsVIf27FfPmwLTK1bhpSsptR9V9IKa3tO8oi5zlKbNvmK5SQfJNUaoWj2oMmUTaTLmuehMuWZ
	IqoKPNEfuG7OG/qgv+6anToo7ftpTvjXAoNq7vRRnGyn2E0bG5BZ/+dMg8j62G1Gc7kDzRnE1/h
	xFJ9U4sx/rvHsu9RDTY6q20P8QCP6Z3B3peBUFruDw==
X-Received: by 2002:a05:6214:5d02:b0:917:a2ba:e478 with SMTP id 6a1803df08f44-91bdf01992dmr155941286d6.23.1792435806990;
        Mon, 19 Oct 2026 11:50:06 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c0411586csm3122706d6.44.2026.10.19.11.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 11:50:06 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	hannes@cmpxchg.org,
	david@kernel.org,
	mhocko@kernel.org,
	ljs@kernel.org,
	dave@stgolabs.net,
	roman.gushchin@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH] mm/vmscan: reclaim every zone in per-node proactive reclaim
Date: Mon, 19 Oct 2026 14:50:02 -0400
Message-ID: <20261019185002.3428594-1-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
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

user_proactive_reclaim() limits per-node reclaim to
gfp_zone(GFP_KERNEL), which is ZONE_NORMAL. Proactive reclaim serves no
allocation, but that limit makes shrink_node() skip every ZONE_MOVABLE
folio, so writing to /sys/devices/system/node/nodeN/reclaim never
reclaims a node's movable memory. A movable-only node, such as dax/kmem
or hotplugged memory onlined movable, reclaims nothing and fails with
-EAGAIN.

To reproduce, fill a movable-only node with clean page cache and write
200M to its nodeN/reclaim: the write fails with -EAGAIN and the page
cache stays. The same write to a ZONE_NORMAL node frees 200MB.

Scan every zone, as memory.reclaim does.

Fixes: b980077899ea4 ("mm: introduce per-node proactive reclaim interface")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index e82ba737c028d..90f7a7bf4e426 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -8180,7 +8180,7 @@ int user_proactive_reclaim(char *buf,
 		} else {
 			struct scan_control sc = {
 				.gfp_mask = current_gfp_context(gfp_mask),
-				.reclaim_idx = gfp_zone(gfp_mask),
+				.reclaim_idx = MAX_NR_ZONES - 1,
 				.proactive_swappiness = swappiness == -1 ? NULL : &swappiness,
 				.priority = DEF_PRIORITY,
 				.may_writepage = 1,
-- 
2.53.0-Meta

