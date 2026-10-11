Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A930C2475D0
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 00:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791678669; cv=none; b=cu5VHbGoo/sOpflVSepdt3YQOrHBniqEnhOWnqoE4PoExAE0/aS1kKwEU91f/sd5cjvq+xmhbdnupyX6w5RvOF5+Ea0IbxYcGITQkspAGvFJR2sm+PT6B32RBUE2Lz5WmVOo6PQBUqT/60WCb9gRH3ThqxVOmus+3YDf5UWrFrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791678669; c=relaxed/simple;
	bh=847Ia3IGc+y8ajZnza1rYhksWRa32beXNH/by2oLOFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/y3rNGZ3pggQ24cKF4hYE7VUXD4W2DGleTwtXITgvIgBNWt3qQfr5OKNv0FST8oqneSOZaKKO49qCdGzC1IRckjwlxhFXdbt06BCNHDnbV/iiyflVd8BsIX7ndFmJOSYOGIiKuTq3KYaDyCD47UJJi2iGHr3lA+Tywu6oJVCmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzsQWFiq; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzsQWFiq"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d577so677658a91.1
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 17:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791678668; x=1792283468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Texf7avohcxbJhjAidkKzynfx9gkSXyM44DuVmdFRSI=;
        b=OzsQWFiq9PIoRbF9yoR1vZMUWuAqhyOm4AB+X5uQE457te4ux9rHL1XIKZ5JKRqagB
         5T2xnjxhM4dZbU5hfSsMotMkZozgwt+GFtHwZb/A7Pi4egeTn1OEj+D5Ayf5KDFo68yo
         kVpfgr52xyXJPeinmZFqjYGyVHGzJ7viXFl6K/70bpB3aUSakeXlNBUhmE1v6wcrCbg9
         cXvca3bCbuQWkRk2U72sFw2n81ZGTB4W1RkTowAXLpT5LZTsSBERt05xHXs7CJPQ2N8q
         u3nVHskvODGQUcXLBPyT6yU/n0Pwimxe1pWX3wVtfeEO0EIEoRti47xhrEA2d0G4GH5A
         zp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791678668; x=1792283468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Texf7avohcxbJhjAidkKzynfx9gkSXyM44DuVmdFRSI=;
        b=XidZfssNpPQYsNbBdkfQ43Y6hCx41wDU/HJl+H+gSmlCbB2qkQHX+Wlo+QJH0Gthbi
         i1LuP57Db3vYOlZKZ6EwmKxlruU+Nu7XgWglMHLJDL9+KFU24jKHjEeDRi+ZPhCiK7bp
         Vac/KFjOCdq1XsIzLnKEv67xij+TYYr+XBJpHB4NOvz4EAQeq67p+EJKQ2KUT3F0Y5CS
         qhR1S+RTT77FNw7goHcmdvf5H1+3xOd5cDA4dt5BoiVVlts8qJ+zxuqZMJbdMyJPJI/j
         l1BwdiXkzm+FLEETmGoodbe4V6UFEYd+rEoFt4nO5sR3hgg0eXP4sSmddE/zRJTC74TM
         LSFw==
X-Forwarded-Encrypted: i=1; AKwUvBzkBqAu7Y4Esu12sS2/XjJf04+t9wFcd7YAU2Eom3OhXWUwyx97OmEwQudaYs7GtfBWCuvHmRg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKO2uvtg2rbGhc05I6J8NBU1v1KdMScqC/c9YTo4qjHqwHVX5rf
	m8r5tKOqNWmyY6azme9YutaLNtagR2T0Kze77GJi6Aq9+WUiOZwx0MPM
X-Gm-Gg: AYBFou2Z9WMbZc0d5snoHw3BdKdTePsDgOA4MYsL5dRtF2cdXnKc6aAVE1/SZB4Ju5F
	jW7VWbV14lR25lKLeSi15uNAeFqGwpv2Oi/dvlY1s4oC9DWt7XLrmXn3e2ElpBrPib3fsOq+VBp
	EBuW1z1fR++tKTENrPTQZo6GVaiMR/McBI3Zyym+Lpqtj5z5z5n0Ikn/Xmqdh8vOv0usHsGUHU4
	SvZgaPAPcqm1oHeV/gzRN4hI7uHOCqHIPbz0bFevAo+r7sINAudEAvVfhJBINsTV69JLlzZEwJ3
	VSdW1bwI2ABCmi/TtoVNNjaiE2srZYhIi+dVpJJhIe2EXTnw0HzX9nmXri9rqkgTndT3AV9Vpkx
	SNXBbs7KeKUuuTwlMZa8PTYjwK1kEhz6rhbEtjyyXwbT/BN+BgGGhsh4EG7KqDkztKR4HN43LeU
	o3aiTWwCL9UzQlvylzEjRR0in65oRxGq12Cur04IMcdF3s1WL4MN75m8TORr141R1O8QYcCFS9+
	s5wTzBAQjiDZ77jhIYr/LOUg4CWz+vICC20zwDi9kfs62Cwzl+Wlygvom6OY+nd
X-Received: by 2002:a17:90a:ec87:b0:3a8:c0cd:57fb with SMTP id 98e67ed59e1d1-3ab3ac9a1b0mr4922031a91.42.1791678668019;
        Sat, 10 Oct 2026 17:31:08 -0700 (PDT)
Received: from bloom.localdomain ([2604:3d09:178e:e100::a891])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab371c32cesm9681761a91.16.2026.10.10.17.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 17:31:07 -0700 (PDT)
From: Ivy Lopez <skunkolee@gmail.com>
To: akpm@linux-foundation.org
Cc: david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	fvdl@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Ivy Lopez <skunkolee@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] mm/cma: do not count skipped ranges in cma_declare_contiguous_multi()
Date: Sat, 10 Oct 2026 18:30:59 -0600
Message-ID: <20261011003059.169430-2-skunkolee@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261011003059.169430-1-skunkolee@gmail.com>
References: <20261011003059.169430-1-skunkolee@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cma_declare_contiguous_multi() adds the size of every candidate range
to sizesum before deciding whether to record it. Once CMA_MAX_RANGES
ranges are recorded, a candidate smaller than the last recorded one is
skipped, but its size stays in sizesum. The replacement path already
subtracts the evicted range, so sizesum is meant to track recorded
ranges only.

When more than CMA_MAX_RANGES ranges exist and one is skipped, sizesum
can reach total_size while the recorded ranges cannot. The sizesum <
total_size check then passes, the reserve loop ends with sizeleft
nonzero, and the function returns 0 with fewer pages reserved than
requested. cma->count, available_count and totalcma_pages still
reflect the full size, and the final message reports it as reserved.

For example, 8 free ranges of 1G followed by one of 512M with a
request of 8G + 256M reserves 8G and returns 0.

Only count a range once it is recorded.

Found by code inspection and checked with a userspace copy of the
selection loop.

Fixes: c009da4258f9 ("mm, cma: support multiple contiguous ranges, if requested")
Cc: <stable@vger.kernel.org> # 6.15+
Signed-off-by: Ivy Lopez <skunkolee@gmail.com>
---
 mm/cma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/cma.c b/mm/cma.c
index 527b2d894f3e..c2cdef953ee9 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -594,7 +594,6 @@ int __init cma_declare_contiguous_multi(phys_addr_t total_size,
 		size = ALIGN_DOWN(size, (PAGE_SIZE << order_per_bit));
 		if (!size)
 			continue;
-		sizesum += size;
 
 		pr_debug("consider %016llx - %016llx\n", (u64)start, (u64)end);
 
@@ -620,6 +619,7 @@ int __init cma_declare_contiguous_multi(phys_addr_t total_size,
 		}
 		mrp->base = start;
 		mrp->size = size;
+		sizesum += size;
 
 		/*
 		 * Now do a sorted insert.
-- 
2.56.0

