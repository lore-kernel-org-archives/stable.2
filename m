Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD793AC0C7
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 10:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783680164; cv=none; b=BPAblmiabUvuWXZ5wUCTru7DoedpqWcRxqpsFa5U6fqACdjP1W4xLKwdmz2EwNCyA6Jdvw934AjH8Mu7RverIJl7W3l87bYckmoiZRpZgsd7B+loQaqfMqX7gTRxr+4ediq3aotMPG5ITrGg4mHVM/0Ofq94gGF5Jd2jTcoOkm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783680164; c=relaxed/simple;
	bh=hvg2eIJW3W5IntN8hk1akDVckNcGwAcn6UofVGjU3eI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WFEWaOWtzByHs1h7QagqYK4PdDJsumCjmwGX/XwlMF+plt5x3d2JDdBlQEMuqlTUUPkog6Is7lz0ZqWYmfMc+/2CKJnf1u1meHSRirm2JCvWoj8NyOX8L+8lF4+9Rhy3N91sVDqLA9gdbbsKSO6E+O35xf98XqJkRlFD6be+OuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dQg29Hbq; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dQg29Hbq"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-4744b72f90bso480222f8f.0
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 03:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783680161; x=1784284961; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fIBOMMuJQhrTdV+Tjmcx1KZT+n3b2t8dDXgjQ/32pgM=;
        b=dQg29HbqOS2hDj2Zyk29gwtZ0AfWc381B7nm9gAm0RQ1Br6zlSmRtoQL/PlJviKi4y
         3Mob2ABBbYWYUw8xZdoO/uibqtRXookzc212bW46MryQKCNlnbO+VGV9FSAjPuLj7qBj
         y8VJRJ+j/KR4InmR7qK4M2oYpRbVJzGRweLG6dXPplftl9Cm8awigCR09ERwtirN9Uzp
         Hq2GfCODdPW3plrtoGgCx1+F4QxpOpyGzJvTJ/jLTaiayUUtHaiXE5OfTYAk7hTSiQHm
         /BKNMBhMHP/zdLs6Is6k31L//YxKcH4kRgMZTKp75g6A+1Y46IE1PX1kIPKmJrXUOP2D
         kNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783680161; x=1784284961;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fIBOMMuJQhrTdV+Tjmcx1KZT+n3b2t8dDXgjQ/32pgM=;
        b=FijLZi5pgA9BNMCcpTK1zbjRihH/tJ81j8jDbSE7YzPrjo8DBEOMJ5w26vYm1RqKdM
         SKp1GlwwbeGffk51ax/hqgeKWgj0HJEBbf/AtRP1hPbw898MlzZ/ymNGMD9O13f9dNU4
         wHbjMv1MyNLDWh1PsI/dldikgvK9hWuMt0W1LcRb75G71816y5q1okjN5SeW8IJkHEEs
         5qiA0tYv+fwC5GnMSsFSAwCtzShRYDqk6w0QeOcs7quoE/MjZktIaB0Ip7EZHNip92QL
         1QTk8VI29xVcV6ENyLe/RK9wLzoH27fBhk5wfU6VpZfy7qZitO+mfAP+iR76m2MUWNCd
         ilBg==
X-Forwarded-Encrypted: i=1; AHgh+Rq42GJF1O4zG/6qDIgBfTKxw9ywwwGd7dwfBf1GAtFJm9DwoAjzzkkgxFeRnA0D6ltyI8EANMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA3SX0VNJA3+VOEaMs8LfYYcEBgYpW/dKul2AMIlUtfAnCBqHl
	UP4ONSfTeALAuF0mpCaTzol5UBuxI2OcZ8uNN5gz9v8BrX9n78SCdQ76eTYnH9Bc6riHbpHhDfU
	z2dMM2JAPPvGQ4w==
X-Received: from wmlz4.prod.google.com ([2002:a05:600c:2204:b0:492:1eeb:6111])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:528e:b0:492:4363:e7eb with SMTP id 5b1f17b1804b1-493e68f03damr112833265e9.32.1783680161137;
 Fri, 10 Jul 2026 03:42:41 -0700 (PDT)
Date: Fri, 10 Jul 2026 10:42:20 +0000
In-Reply-To: <20260710-spin-trylock-followup-v1-0-affb5fe5ed00@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710-spin-trylock-followup-v1-0-affb5fe5ed00@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260710-spin-trylock-followup-v1-1-affb5fe5ed00@google.com>
Subject: [PATCH 1/2] mm/page_alloc: don't spin_trylock() in NMI on UP
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Harry Yoo <harry@kernel.org>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Brendan Jackman <jackmanb@google.com>, 
	sashiko-bot@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

As noted in can_spin_trylock(), using this is unsafe in this context.
commit 620b46ed6ae17 ("mm/page_alloc: return NULL early from
alloc_frozen_pages_nolock() in NMI on UP") fixed this on the alloc side
but missed the free side.

Reported-by: sashiko-bot@kernel.org
Link: https://sashiko.dev/#/patchset/20260703-alloc-trylock-v5-0-c87b714e19d3@google.com
Cc: stable@vger.kernel.org
Fixes: d7242af86434 ("mm: Introduce alloc_frozen_pages_nolock()")
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/page_alloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9c97a86da2b9f..5fe1c11f919d7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2979,8 +2979,7 @@ static void __free_frozen_pages(struct page *page, unsigned int order,
 		migratetype = MIGRATE_MOVABLE;
 	}
 
-	if (unlikely((fpi_flags & FPI_TRYLOCK) && IS_ENABLED(CONFIG_PREEMPT_RT)
-		     && (in_nmi() || in_hardirq()))) {
+	if (unlikely((fpi_flags & FPI_TRYLOCK) && !can_spin_trylock())) {
 		add_page_to_zone_llist(zone, page, order);
 		return;
 	}

-- 
2.54.0

