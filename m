Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163835;
	b=wJLMNqGM57zkX+Hf0IDV+4OzUPCzcSH9hbEPJGl6O2OMZJaiaI9uUgTx+K7RBGsJKc3q
	 4dYpFUtCMGMDAoelJCkPAPXzUPIW6rVBshrtWDjs5Ue/pu7nXwxolVEgvRfD5/ov2luBN
	 4itokIx3qXF64IUe0ph3IPiVFxptyj0dFGYJnmqpclbs1do5J22DicEDP9+abA0qgBkRS
	 QCvoOPwUv6wArYrTAlZ06d6a/+VREH6svT7rJyldw//AMbXuB4K7ZKsmGmS750TYHhEH2
	 vPoWjzSI0Xh29Jq7zeIsL6/V8htPdaHfopL78ZX2s8to420S2Q8lJO9+/CYWZRsfH7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163835;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZCyEGFLuMrF8ud7Iy/GAi36dvb9TvTE7pQNBco9ToNs=;
	b=v8VlvLtqKa2f2rjB3dYHNBaixUDmKzLya6ccgTvi9cJ28hoRpb9BN1nL5LkRLQy07Ykg
	 yDEVa89ZladrPAq8mheOOeDUXl0+Y6phCqSx/1+ODq7TGpE5HhX/LfQw704zoLr8C0wED
	 f5eXnV2vJohFOwLrIDraN3uyHDiuChHFx29jX/M1vK62ONFIZaQHcsBXxzo8KwC3QpuxT
	 2F6XM4z4K03MHpq0Xif7eXbdIEJNVzxbnUpA1O0vWUPkAj1umP39glyOhxW2mLycuNrZm
	 CUnnn45PzPSuV1T3AF4xTnNQPCaGq+l62dmUoppTN0ft9FpyrntfVaH0iF6JXNxt+aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tPGgjm8d;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1A5606A32A
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B1A5606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tPGgjm8d
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cde4b4e936fso966882a12.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 00:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795163834; x=1795768634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZCyEGFLuMrF8ud7Iy/GAi36dvb9TvTE7pQNBco9ToNs=;
        b=tPGgjm8dHvqkhvM6qaWX27QGfhfch+yhwN+RmPTN25HBRzCfLyqMVAQWFxpyoa4mtJ
         bSfnf0bo7bGgXmOVnaXbm6JbJLCd2G/RgTMtPCBO71hgU8rQ3a4sGT0p9cTIPVQmEyGa
         SA1TWTAAZ6YAbzS8RDhjPmfDnSd3BG2Y+Pw/oMGUa+4k73ZnQqXgYYYfAVEENUa3rwEy
         pqPSDGPlcOceSwKE0cTtVhJdxsPQX47V4vbKH4BJUHf8UJBa1QmRmljkZrTlJHFTxyw8
         g7YsmMnuthmIvMKgBLuW8yMludgCDcLLXbeUNnIY/cje4YvgaW4oMhSDm+/DSxn9pA7D
         pp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795163834; x=1795768634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZCyEGFLuMrF8ud7Iy/GAi36dvb9TvTE7pQNBco9ToNs=;
        b=w3U5rhWC7JOzXfe4kjNThKVsbh1Dc8/Vb6VoKI6xYLzH93XgpQviPV2A5xg3oWvGZM
         k3U7giRKJf+5I9pilMuU56O1vw1TJMDsfy+MR/Uka3zXw0N+8mx9xx0XV2KWb6JN6EtU
         XbQ+J4ABI7phhkskmTuSdhXlGgjPJcsaPAHjLc8LeSFNOApgOt9Ql0syDGUe1iuV/uQ5
         /2pqO2Y4gKKb+OhiPDFdjKhGZFIc+k3iTNzH1955c/P9jL4Rqg2SRdKdLs5hvAgfFdj5
         oAg2CISJ2r/hye6QqgBvxB650iR7cSHWlZvC7tcZcFn0zq+/MmjSF+yLAFjw3edvM21t
         KR4A==
X-Forwarded-Encrypted: i=1; AL+hErEdni5xU/xOEgzXEz0uVmS3sEsuNX0Lu4fmhVxiI0NMJtLwu6SZWbRZpT/3pChI9HucISswWH4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/VrERPY3VQszdQdRS59Upw2YF/+oY71Jv3/Rr306TPoMtchqmc
	NwGH7LYzHvhY2cIQVbLHtizqe2caS8OmtWm2fqO3oRQqbcmE+sj0mH3+
X-Gm-Gg: AZFdTZe548Em59jYRZgN2rrs3QDqXEpm7FTP51nnqpx2EjS7/gvBwNZobOXppljONVb
	Qcd2kLzrNaxRZDNlW3zXtAtrCDsA6zQ0gWKJ3MYNhRMk5RhSzECRKDyhpP9KK427jpCzz+D3saY
	+eD6+b203cpoVrh7hnkLeqy9PT3Ugrh75KZddi1aV7uZmK6zXFy3y/IK/dhU9rhCpRwOSmjRbFj
	zC0MBZS+uqCUUgvK4Je31q5erjNwDi4OWubfIA2UGFVB3+/AVE25AAV5yXA3jfcjHXYiuwdd+65
	u0XgP57BdQcRMzLujf1WkWRlZm2xoC9Ezs/j0lSH8R3dlNhi05oq2CKu6xUOdweKHvqNzYpIAgN
	6awcs8M+3pICWOAgaesL+MwX9oUaqZPXHvaAcJuIcxZvYxxNIX9MGW8aV7c0XvSob0hGAoxpVJ2
	9BpStWdfxXN3muyhDTprB2ngZaBQplu6fT5RHOZm78ox8LWyhkvt+Ru92uMyFfod+CyfVc2F+MR
	XFixeWneK973LlANRMM/bfub1Df38RfqwKyhbOI8oCc+XV+LIQybo2baJo1gAUlDSeiMSTe8hxD
	qzDgE8ndJXlHBtKW1raPgAYQoPrCDsHDTeTd/QLfT4xzzw==
X-Received: by 2002:a17:90b:2f8c:b0:3ac:9ed8:f301 with SMTP id 98e67ed59e1d1-3b41c93fac6mr1453272a91.30.1795163834405;
        Fri, 20 Nov 2026 00:37:14 -0800 (PST)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0b52dsm3590057a91.5.2026.11.20.00.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:37:13 -0800 (PST)
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
Subject: [PATCH v2 1/2] mm/slab: restore the rcutree. prefix of the kvfree_rcu parameters
Date: Fri, 20 Nov 2026 16:37:06 +0800
Message-ID: <20261120083707.296481-1-zhanxusheng1024@gmail.com>
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

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

The move of kvfree_rcu() to mm/slab_common.c dropped the "rcutree."
MODULE_PARAM_PREFIX, so rcu_min_cached_objs and
rcu_delay_page_cache_fill_msec became slab_common.* and the documented
rcutree.* names are silently ignored.  Restore the prefix; the
slab_common.* names, never documented, stop working.

Fixes: bbe658d65802 ("mm/slab: Move kvfree_rcu() into SLAB")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
Reviewed-by: Harry Yoo (Meta) <harry@kernel.org>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Reviewed-by: Hao Li <hao.li@linux.dev>
---
v2: as in slab/for-next-fixes.

 mm/slab_common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 01c64ef661e7..41dea01a8c1f 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1367,6 +1367,10 @@ void __init kvfree_rcu_init(void)
 
 #else /* CONFIG_KVFREE_RCU_BATCHED */
 
+/* Keep the prefix inherited from RCU */
+#undef MODULE_PARAM_PREFIX
+#define MODULE_PARAM_PREFIX "rcutree."
+
 /*
  * This rcu parameter is runtime-read-only. It reflects
  * a minimum allowed number of objects which can be cached

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

