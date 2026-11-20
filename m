Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163839;
	b=136UxMwFHicbFJMMoItiw6uXNrWnZJ8lhBKEt1LL6X5qyHyt+wra+LyPG4Sb71eUxzMg
	 O34GgVU09bVGraoi2TghZvnhLHgtIv8d7ANN4sumyzoHEy1enmSRYNNOJ39fC4aXi18gr
	 oBhEWzb1VRGA8aVNdduBp673RiFu4GEjQRommwDrgMxHLz/IQf5KYhnAwmghLzTfsIkNd
	 ka2s0vWU5OYbwn70V74bM4AjfpnToA4v7c3rQ2NKwYKk+1JZ4fCzChwugadAT4eTGL+zQ
	 PCMkDG1/ajd1AA/M3UVFiUj7/UUJae6agdY0SDXm3Jv15RSlGIB2SWTzq6qUAnO65zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163839;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=g/fHu7Nley/JjRttReoBdOyGfNrnA+dp2NZ1oWj3jhM=;
	b=Kna18i35QUpKdaYEKcY/7QCPvfSNZs5V7BFwFsEZ8aM3nA7TEVUNvRY37mV5P5j6+2/Z
	 xl8Ma/vxZbsImdZDMUK5p6izXn6le9UxpyzdZNUTREaNGqMzJwFdO3aQeYB0IiV/IgSUO
	 TUeL0YN0W1r4s6JBPNLW6CoffXZ+gzFiv14oiQQpIYoNL63sBuFV0Cy8KM4m18h2z8u1t
	 4ukubhoVtYrQdL7hUMNWTT+gJxYJOGhUPbU4eXF9Nhntyt0GhEsGkobjJySG8uxJjXZ/k
	 0AZlBJ/2L7jgdmfXbD53wPwVX868yE/1yfThW9MbpULqdanRXgsjIGecZqz5TvXePCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MMBzzU1p;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389FD606A331
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 389FD606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MMBzzU1p
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b41188c8b9so549536a91.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 00:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795163838; x=1795768638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g/fHu7Nley/JjRttReoBdOyGfNrnA+dp2NZ1oWj3jhM=;
        b=MMBzzU1ptyoyq6zsyOP6nVX94qw1w/E3iaH/MXmFwXbKgU4DESzfqOE33mcwIozVCP
         NRnyKlCO9LcGbZgX7stkIeWUYqon8Dau79yCnyAP/48sRENzWzOPKr9wCyPeuGKQfhi9
         1DADM+f4IucDs2bcWE9Jmjk6h63zVQhhie1xKUOl2UNoy66ePEtmnxr0nSQqqg6rRo10
         tTTW7QLefJHfjAkfjNRM2yS1jgMZa7x58lOBWfvOSzQI5mOYV/szpqw1GC2jMgfYOi5V
         89Qq9Ml97mudCkqmuTNgo0KJ1a6NyIQbQyQJxUB6HvKUfXVu1VVlJzG31zsPpDOUxuHx
         PynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795163838; x=1795768638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g/fHu7Nley/JjRttReoBdOyGfNrnA+dp2NZ1oWj3jhM=;
        b=nNCzv2YWCgXPYOpl/UTR6PS1pPPgzU3uQmhlOcN6hTwXT2svxGHP08V0nqM+QxssUj
         NMbpk+jisv3GoMJYZRLX3FBSVRwpjb7TslbleRIFRMf+2Y0+HnWjOdzMRcRw6+tnRKwO
         5zDtRB/oNWV3/rOedaH1F2sM9LaVwhgEV1xSXOHhd0iKE1ZHiHsdeJDDVb8BoDGna3kU
         5cLXonTOsx04V0x7mR+eIa0PJN+gScRXSEgaf7kbbB/kjGy4VvEVL0PLD28a6oiS8tnQ
         La5qWq/wGltKOzdp2M9QfYlBzyIbJuHgnsMpSW/DB7vzFdtRvgxADnrCXUyzFtWSQnPM
         2RDA==
X-Forwarded-Encrypted: i=1; AL+hErEPWXD/20waa5F7Bz7jDiw25r9wmM1gQVScwUekHa4EaNu70c12l3M2xtZSnbTzTrJ1blSk2aY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+TF7ss8CSA71rf78FwkztZl3SX3h4Au0u/+VYFOvvwL3NSUiqS
	uEmknAuJOB7RiWULKz0I1BkjUokC3Us80Dv9VmaSLrzghIGPY0Xj0Ca6
X-Gm-Gg: AZFdTZdDQxQR9wMpMw1fjGEfIB1y/dql3auGr6ddDLkPK8N1FyOUJImVyP55FrHrQXI
	IqkjeBYuyBjzgagKoVylUo1wZmxDujJHpD+yNqMX4KXzJ8atIyyQv/VajZsGJC5AzJ9Zkh2bPC+
	JZSsCwvMkz00TRoyabBIgHWw0L15PJ0NVgXiYgkE1S3A7VNOnVnVzGR18WFtXnzojQRuGrZALnU
	QyaQWJJdNLH8Nllad7p+jh4D5Gbm4so9Zt5VczbsxscmLQFa5fwrTNNgdtxAg9LsUkL0cIx0GBs
	rh+o9QkXvJpV846uYcr7AwO3Q1jP8ZbHNyr4FuILgTbwxWY3RK6PhCjFG1i4BrkyW437ayGzdxk
	MscFzvxGoK+hgu6Zk02vjIbPas9XTK1XPnSL8O6ELJ9UYV5SJpRj87w6sku7IY0xK9/Hj2b9nbo
	GtDVIkp0Aa6cjI1ZfGZxwJdjwxayVm2nEeP02nbhuvArJYnQeDnxief3ikDlnjLyc0olKZTHamN
	KKw31vwYJIjL09xFb84qAbWUa7VY7Dc7JI8nssoO/1vcbPCLedS8JL0LTIKdMh2uK2e9ocG4cND
	2S6DJezJPd08q+GoPlOBK8sSoKsBVQm423eB2zl8iK63ZA==
X-Received: by 2002:a17:90b:3891:b0:3b4:127a:2bc2 with SMTP id 98e67ed59e1d1-3b41c8d9bfamr2140676a91.14.1795163838461;
        Fri, 20 Nov 2026 00:37:18 -0800 (PST)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0b52dsm3590057a91.5.2026.11.20.00.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:37:18 -0800 (PST)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: vbabka@kernel.org,
	harry@kernel.org
Cc: urezki@gmail.com,
	paulmck@kernel.org,
	qiang.zhang@linux.dev,
	akpm@linux-foundation.org,
	hao.li@linux.dev,
	cl@gentwo.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	linux-mm@kvack.org,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] mm/slab: don't queue the page cache work under krcp->lock
Date: Fri, 20 Nov 2026 16:37:07 +0800
Message-ID: <20261120083707.296481-2-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261120083707.296481-1-zhanxusheng1024@gmail.com>
References: <20261120083707.296481-1-zhanxusheng1024@gmail.com>
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

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

Commit 56292e8609e3 ("rcu/tree: Defer kvfree_rcu() allocation to a
clean context") deferred page allocations to a workqueue. To avoid
deadlocks with the scheduler, it used hrtimer to queue the work instead
of queueing it directly.

Commit d0bfa8b3c411 ("kvfree_rcu: Release a page cache under memory
pressure") later added a backoff mechanism under memory pressure, but
did not consider that queue_delayed_work() with delay = 0 immediately
queues the work and introduced the deadlock commit 56292e8609e3 tried to
avoid.

run_page_cache_worker() runs under krcp->lock, from kvfree_call_rcu()
callers that may hold more, such as set_cpus_allowed_force() under
pi_lock, so it kicks the refill work from an hrtimer. Under memory
pressure it instead queues the work with a delay of
rcutree.rcu_delay_page_cache_fill_msec, which may be 0, and a zero delay
queues it at once, taking pool->lock under krcp->lock.

With the delay set to 0, calling kvfree_rcu() on vmalloc memory under
pi_lock after a drop_caches makes lockdep report:

  Chain exists of:
    &pool->lock --> &p->pi_lock --> krc.lock

A zero delay also defeats the backoff, which is there to defer the
refill under memory pressure.  Clamp the delay to [1:100000] ms, so that
queue_delayed_work() always arms a timer, and update the documented
range.

Fixes: d0bfa8b3c411 ("kvfree_rcu: Release a page cache under memory pressure")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
v2: clamp the delay to [1:100000] ms instead of using the hrtimer for a
zero delay (Uladzislau).  The changelog is Harry's version from
slab/for-next-fixes, with the last paragraph rewritten.  The
Reviewed-by tags of Vlastimil and Hao on v1 are not carried over, as
the code changed.

Tested in a VM on v7.4-rc1 with lockdep: with
rcutree.rcu_delay_page_cache_fill_msec=0, patch 1 alone reports the
circular dependency above; with this patch the boot log says "Adjusting
rcutree.rcu_delay_page_cache_fill_msec to 1 ms." and lockdep stays
quiet.

v1: https://lore.kernel.org/all/20261028134647.3176080-1-zhanxusheng1024@gmail.com/

 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 mm/slab_common.c                                | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0b3c140babd9..0d1d76a6af70 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5763,7 +5763,7 @@ Kernel parameters
 	rcutree.rcu_delay_page_cache_fill_msec= [KNL]
 			Set the page-cache refill delay (in milliseconds)
 			in response to low-memory conditions.  The range
-			of permitted values is in the range 0:100000.
+			of permitted values is in the range 1:100000.
 
 	rcutree.rcu_divisor= [KNL]
 			Set the shift-right count to use to compute
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 41dea01a8c1f..6fb453118641 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -2262,12 +2262,12 @@ void __init kvfree_rcu_init(void)
 			WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
 	WARN_ON(!rcu_reclaim_wq);
 
-	/* Clamp it to [0:100] seconds interval. */
-	if (rcu_delay_page_cache_fill_msec < 0 ||
+	/* Clamp it to [1:100000] milliseconds interval. */
+	if (rcu_delay_page_cache_fill_msec < 1 ||
 		rcu_delay_page_cache_fill_msec > 100 * MSEC_PER_SEC) {
 
 		rcu_delay_page_cache_fill_msec =
-			clamp(rcu_delay_page_cache_fill_msec, 0,
+			clamp(rcu_delay_page_cache_fill_msec, 1,
 				(int) (100 * MSEC_PER_SEC));
 
 		pr_info("Adjusting rcutree.rcu_delay_page_cache_fill_msec to %d ms.\n",
-- 
2.43.0

