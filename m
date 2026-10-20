Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.193
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792537808;
	b=jrr/JxEJu5NAFcuxkvQ0p8hQmSZT93s2xa5b8sKPtZ2tV03z6OgcLf6wzvensI2cGmEW
	 O7a8+yQI4PgoA4jibynnSQnaz44Vh5SZdxm9Aklh6KU37tEPwtFvwHi/ldeBHtIJL24xj
	 T5LQkGxum2PvTpudkTzlXxWD/E5+5FyGxRJ4vfngFJTbAqXjyAXByuimcARnk/gpyDBA1
	 ne/CY755BOvJlL9OK2jEFgBm/lwnOoCB+ml+Y2fY00hj426VeJbwjmji1wntTIE9E/n5P
	 v9YMlMeG5p32RmqOl9jln1xGJNcuu4Labwf6gKFLWIbdrTP1h3ttUisiP8q7krLxYMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792537808;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=P2tX6F6c1b9WPZHS6VLVV3K2kSTZMFFjbVRLrh7B9c8=;
	b=Fe7+tSSrfNlhbhEhjKdGiE/xDX3Y8YD+FxVETCSXWAxGn+qm6y+OugvrzBG50VZQgCtr
	 P1hDwfPRMVx1VXurhXAKmKMpe5+LwtbgcBHB+YowMtWwBuGwH+hRd6ve4yw/dk+reyJjY
	 jBYJq+KDSwdvph6c4n/QwrbKqS64SMEEntx1G+B/YFEjDKIcnhiU3xhbGf/lmykCKMMFQ
	 P9hH9HHM5zae7+Ni+vEj7NsMX8pmbzYxFZ19PU0aaQ33aR7iWSFuTAi27Oy2Tgm1t79Mz
	 QzLKLCaof1lTNbawKGnXNKj+4HTyqwaa6eoKx83p6mKdlMPPpruKMuof2HIRyiEB2tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FXQYyZ4e;
	arc=none smtp.remote-ip=74.125.82.193
Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8CE606A31F
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 23:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E8CE606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FXQYyZ4e
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-366421dc8ebso277906eec.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 16:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792537806; x=1793142606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P2tX6F6c1b9WPZHS6VLVV3K2kSTZMFFjbVRLrh7B9c8=;
        b=FXQYyZ4ee7N+OmcvvHjgLzE5KvKF6Es0Ggd9KBeTLLtMA0G1RiUBo41egIOT1n015P
         IVGvwSb2VzpoAqNsNIobOqfmvcge5bGmdY7XCL4cTgMJ59LjhcMTUBxKz3MxIBwkxhWF
         9LZO7B9xnhh69sXtDTrMwD+yWY1IC5KJaK91+TIf1K9MtbYVOZ8Cs3lyQfCVbDOR3uZr
         gDr+7e+py6aaqRGl5cf7ahuy0F80Rpf5OfTrBpeBLXrLmR5RMaO9IIsAMd9idozWNAZZ
         8WdthJSlQaqsPh+NEuugoh/Dcg2aLqrfOnoHZdowZXrzw5L5t3qIAQajZuezLh3eK09d
         wrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792537806; x=1793142606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P2tX6F6c1b9WPZHS6VLVV3K2kSTZMFFjbVRLrh7B9c8=;
        b=uD/tO4l/ePairO6OelgAfs15S1mFd69WSNwoWsS7MBL7dcMnT9EBgIXl7Hedv8sW5Q
         xmF6EFRlqoggEL+hS00P9oZQnB6H6YCmQDxxKFtMw2SmQlD/sYNpy5yZ1s2V49Qfqb7l
         Zp2lBCqHrlwRQ+WmQyVhKC49PsuYYZnc1aJ+komUHyjC1SoIHAPuHdhKddvm/zRhtiOP
         Z5OJIzXnnC3dmTvx5Lmhp6mFykpLr4HTNzXZ4lWw5RNT/mgkkh6uF9Y0XEzxKo8xcs15
         YDs9MqQ7f1c8g2EZjgdkbHMkjG5JivsEiwrmiyPGf7xl+WMYs0Ou+DgMrZP0r06a5TaC
         dPZg==
X-Forwarded-Encrypted: i=1; AKwUvBxqZwdcm/hBywA5yZNBnOUJgBxDeKq0VrVkXbgD8Mg/zu3y8zXGI6jr0Q3zvzdJIGn6UB5IDX4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJTtEoEnLQIIihDVvnk6disAlqgX6D47JNt9LTylEbwAwQvbJji
	JcZt8ifgvxaWIXW9ctdPQU/uhAaN/2/6Yjd7aN96ZREPB4mHcFvCmkc1
X-Gm-Gg: AYBFou3V2LugZSgDTb+gi/YOnjx5hpCenrPp89S0c5+NK6moDlQ8jEHGzm/6oHNTktB
	DeLL24mZEVIYERzYX9koyz9ukV3s0pucEfqGyfxnb0SrOqXB06bQ0IYbfayUI/Fyf1HPmZfhQgp
	eWjBIT5+TGMLCEbyFStCMsDDyX29UWx4uGvBHm+RD32wN2WnC9mU8HUZqATjNMxyRU14OzHD4kc
	jbN3o5gRs5wA7Dhk/Ejl5Gnk4T53rL96SqpDG5qU2zNNPRJcY4tcapI//uAxn9SOmsTQwdafcMw
	QI8bcj9YnXZ7suq0qenvNSHyIOQAfeog7G7pMisRcub2da61tXvnGr/Ka+cQxRx/T8AHiW3v7b0
	FWg4AL3uP0thevnwDjp/KteUdbPb8dR6XSzgqJa+YGVlWZfId/pBskkua9s7OhR/RPeu7LP/ysO
	9+61eclniGf31L2BM66OOKrZ9Rwsz0nIUFIjHOodmblx3TVfRf5+HGbao+1s1e/GobAVV7kGjUO
	1L6UhIJzFKRK9L+DElmcnlZNuuhtf84njSWRtbzfgbWVxNlO3TJdTPOQYBn57zKzbhmpliPSpM2
	0Q0Fs+o=
X-Received: by 2002:a05:7300:4fa6:b0:35d:5e81:1d87 with SMTP id 5a478bee46e88-365fac8800amr4594466eec.12.1792537806333;
        Tue, 20 Oct 2026 16:10:06 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36741f753f7sm1598433eec.27.2026.10.20.16.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 16:10:05 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH net] dql: Reset the adjusted limit when resetting the queue
Date: Tue, 20 Oct 2026 23:03:58 +0000
Message-ID: <20261020230358.6649-1-dennylin0707@gmail.com>
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

dql_reset() resets limit and clears the cumulative queue and completion
counts, but leaves adj_limit from the previous queue lifetime. Since
dql_avail() subtracts num_queued from adj_limit, BQL flow control and
qdisc bulk dequeue can use stale credit after a network queue reset,
until the next completion updates adj_limit.

Reset adj_limit to the new limit as well. With num_completed reset to
zero, this restores the documented adj_limit = limit + num_completed
relationship and makes the configured minimum effective immediately.

Fixes: 75957ba36c05 ("dql: Dynamic queue limits")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 lib/dynamic_queue_limits.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/dynamic_queue_limits.c b/lib/dynamic_queue_limits.c
index f97a752e900a..acef6a35ba3d 100644
--- a/lib/dynamic_queue_limits.c
+++ b/lib/dynamic_queue_limits.c
@@ -191,6 +191,7 @@ void dql_reset(struct dql *dql)
 {
 	/* Reset all dynamic values */
 	dql->limit = dql->min_limit;
+	dql->adj_limit = dql->limit;
 	dql->num_queued = 0;
 	dql->num_completed = 0;
 	dql->last_obj_cnt = 0;
-- 
2.43.0

