Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793499230;
	b=xO2QzK0mGENRpALSgfuhA6gsVShpUmSQiMs88SqQ0J+MKhjgIvdEM1Mr75oYmWRPpVMy
	 AYTljPQQwqQxwdckBOvdYA8QkqBc7Dm2fslfUN6IzXbkxW4rgxpYo3xg/nhd+4d5cMhZX
	 eoF234gwFYQBlG/pc1e6VIbaet7DDGDJWmaeEMkCRFbH5ZlItSczYsPNLaCovm84geedt
	 MHTMH+2FQtyfyG99iYw1VodzdJf1DUoefw6elL6J8lbD5gbXFqwslbfqk3RE/B7ayvVdn
	 w7wbY76Lqmr6K9Z6Z14O9cmuXTmuYUQ3b8SpokZwPlR6zJP3Wqi6b9EfhQztrL2mzGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499230;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vO0BDg/8068w2sWF8c7lp9ZJV9hDUZO1hrE8aPsToAA=;
	b=zgm7I6/x4sVt0lLuBncjRQ6TR4kvXeGaQDzdJRXi4ylXO48swBTTguEH1oEsbp+SSBjh
	 Q1UA6vvMUSBs9lxTqDv5zHhpA+eYZJWedUCueOohdWGHFvnTUdQ8CDtWa3QC2W+CyThsY
	 bHuXZVFMMVSjqZsukX7PSgNNt7czaB0HRrIbfWE/+uHKWs6NYzqvip6d2XOA62iPC+m/c
	 qBdxP6W8gTEBFCh+F4O+nUnTOgZnB4joZCHExzUAjMNwsNUz9IpS3KD3I88jUlbG0IHet
	 p219Ybc+VyZehd8eT9G9KKfumb9dBfe0W2ON45PzgqKo0kXkvkC9leCZJxNJJfNTY/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=GNmjsmd8;
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96832606A330
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 02:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96832606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=GNmjsmd8
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93e63ee7b4cso195624985a.2
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 19:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793499228; x=1794104028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vO0BDg/8068w2sWF8c7lp9ZJV9hDUZO1hrE8aPsToAA=;
        b=GNmjsmd8iGlfyBA1iasvKglTU/FEUH1bUdSpfcXjk1tMl+SxkcJZjHg4tkHHvtroeP
         0vmUBDD+pG3IoM8tTP/kFrZxaC0s8cUzTxo5yBRThneKxH0gnUJRuD7/hIu0/Wu2El0D
         7lT+8XCqhgSs/DpjBGyS43yWOWDCiDaKvjvIv9ED1kB1vIYk8iJZ9uh80JZHQs/SjscJ
         p55ebujVQf7xav0vx7NwkgNmZlyZ/HcGv7aT9uFs1cO0vshiYyhjahKpjjUDRGAsR4Zk
         tmGC8v7U6q1cIm1mAzQ9Oe+1AwiXqjESmHz8O4BI+CyrRHs/Bss37DFXx+Nly4ed906T
         um/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793499228; x=1794104028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vO0BDg/8068w2sWF8c7lp9ZJV9hDUZO1hrE8aPsToAA=;
        b=RimamWLzovbYMviGtpJqu0luhzoWNekdINNgYaTsnhnjWKinmZmLHQuzl+ZViz//ur
         8yQNL3kSCe9R9eei6aov+/CQINZ+JfoifpzcaCBWTVaMmVrabu64bFPx7lpiHgmpx9Cw
         daBxvr31jttztX2wOX9xJ5m6uPyZPeJg8/emBoJ0C7BNyeKUqon03qJLbYlbLxRLuvNZ
         DhxMziRB5xGaflT+myXzrUK1NIzRA358lvulc4R7Hi2e3WoRre9pu2T8f5iOkAYzgxty
         Bwb8vZYzqR+zatW6Umv2uEyaDEZzFx4ShUXEpJRNuxx9wxXelxvL8d9FTek2Ry2mGQmF
         ZJiA==
X-Forwarded-Encrypted: i=1; AKwUvBwV4VgHb6K4HtkttEcqMKxhCu+sk3F2rlF9LZHUbN5+sQYKlbtVneKFqqRSlF1hYnq9I1NykAw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJSSYWuljxvVKUI3kPO3m3cdrtMoQMe0MpY8ngYfqDQzKbKverr
	JcYuJ3peK4j4U2nNVBAJM0H0qcDut7rhqvt4fD5PQvFDG/igfAwhmKe69nhVheaclYQ=
X-Gm-Gg: AYBFou1pcow5np3JdXpYptZoigrNEut4ZbZC2f9xgWph7jcjTllAxx/1v2XoscdEog2
	er8rOLJhyaZ42QcqeKRAxEGuiI0xwvDALVDHefIuO8kVKoQ602sNbV4HN2HIU3Sw8XqfK7Rm0Wr
	BBirdC3JOGodxQinbetw9fKbUp8oYbSHyuZPUCzbl+mcdDXViHF6ZvJeYBpmE4HmDIHTvnAgofU
	h+487auAJGYvJYTM7gW3VUyt05ZYXsRdtcwddwxlpFYArq1rtJCuxUqGRbgHR1oDAk8vp+LSvMF
	vF5kdJ+CPj828Du5bk/xvvxuHQHD1tNMCfKZAojWukNcS5Qx+PC04gRCUgqla8IH629Q63W5i2n
	smDrOLHGtbdTmDF85kd1HD4Vk1PG6y+iSJxebt0/4vhpy8r2W5iGr1NifuEXb2rdG62V18+nct5
	/5zoh/QYeCsprFIw1Fkp8qRjS1iAnEtrj2ckYwU/Nzm5nl8WaGLdsBzXb8Eabr2fsQwmysQWLTP
	1ABYVxY0duTIV4J6P7m6gYvANwQjyNLbanACX2dz3PHdGL3019grRDgMzwBxxZOaMuykOLlTXce
	qCQ2Y0fyDSnQSZVyZUlRUAess4swquomd52I9yBs/F4fDSosyvUWdskXniCo26wTwDay4UXkefz
	1ytiqg4iEKg==
X-Received: by 2002:a05:620a:2a01:b0:93e:c12c:f136 with SMTP id af79cd13be357-94421824e76mr1073212985a.81.1793499228208;
        Sat, 31 Oct 2026 19:13:48 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425858552sm498131985a.18.2026.10.31.19.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 19:13:47 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	rientjes@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	gourry@gourry.net,
	ziy@nvidia.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	Bessel.Wang@huawei.com,
	jiang.liu@huawei.com,
	mgorman@techsingularity.net,
	anshuman.khandual@arm.com,
	stable@vger.kernel.org
Subject: [PATCH v5 01/12] mm/page_alloc: reset can_retry_reserves when the slowpath restarts
Date: Sat, 31 Oct 2026 22:13:29 -0400
Message-ID: <20261101021340.2251928-2-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101021340.2251928-1-gourry@gourry.net>
References: <20261101021340.2251928-1-gourry@gourry.net>
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

Commit 2c4c3e29897d ("mm/page_alloc: simplify __alloc_pages_slowpath()
flow") retries an allocation once with reserve_flags when the caller
becomes eligible for reserves, guarded by can_retry_reserves.

A restart after a cpuset update or a zonelist rebuild retries with
can_retry_reserves already set to false, so a caller that cannot
reclaim (GFP_NOWAIT | __GFP_MEMALLOC), fails without trying reserves.

Reset can_retry_reserves on restart. Only a cpuset or zonelist change
restarts the slowpath, so the retry still runs at most once per change.

With a kprobe helping to make the race deterministic, an allocation
can be made to return NULL. With this patch the allocation will succeed.

Fixes: 2c4c3e29897d ("mm/page_alloc: simplify __alloc_pages_slowpath() flow")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/page_alloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a8cac5e01066..f1048168c90c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4783,7 +4783,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	unsigned int zonelist_iter_cookie;
 	int reserve_flags;
 	bool compact_first = false;
-	bool can_retry_reserves = true;
+	bool can_retry_reserves;
 	unsigned long alloc_start_time = jiffies;
 
 	if (unlikely(nofail)) {
@@ -4805,6 +4805,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	no_progress_loops = 0;
 	compact_result = COMPACT_SKIPPED;
 	compact_priority = DEF_COMPACT_PRIORITY;
+	can_retry_reserves = true;
 	cpuset_mems_cookie = read_mems_allowed_begin();
 	zonelist_iter_cookie = zonelist_iter_begin();
 
-- 
2.56.0

