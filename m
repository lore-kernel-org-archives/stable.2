Received: from mail-oi2-f41.google.com (mail-oi2-f41.google.com [74.125.231.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9963C1F36
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 23:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790031835; cv=none; b=qoAx8Qpa7+3drgo3DnkSCYbV8+XzrBSxngGuBd+TojZHUV1d6Pj0PXx7DGo+q7SYQa0ENHlTTGi7FYOlKpV8/oAP0M72KUZ51EpLq6AP/XxqxB3sZ5ox2nmFflXPIveov3wdkpRjgqP+mCtylUai0Dpf5qgIw1ioNvPApb2ipKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790031835; c=relaxed/simple;
	bh=kh9puILIR9r20G3kwpzzv7NaVqtxLvbguKQW3SwMZ5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j6WxNehbb38alkDevRn44acni7igpCXgq0E6+ttfpD7evAsmxVZS2Sgbv/bRie4IdfX6wvoBU0DHxHk1ayck7LYa3FGSmMVomUzC1RSPI8qUAUTqCtVDUtI2y0EVWedpB3E/WY6rKHSFeIJr/tBD0y0KE60wCuNB1MyPwaIDYjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJtiu6gf; arc=none smtp.client-ip=74.125.231.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJtiu6gf"
Received: by mail-oi2-f41.google.com with SMTP id 46e09a7af769-805cc8b4231so2079555a34.2
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 16:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790031833; x=1790636633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OdbPBPyzaOM2wXlSY62pNAL0ZMKs+usFBD9FO5JbEdo=;
        b=RJtiu6gf6NVWi16q+NFEmBHvIqrrqdw3bUrNst3yKEkzLY9nwfl3bJhtXM0mELCNkf
         RCdbB4qA3RIBfyTipAR50KyF9Bjm2eDI16LGJVZ4mgd2hvKxiV1mSRFCTSQjBwbH4QO3
         XT9Ax1UgRmZQpPeaCgltVBurOsXB5XhRy+ZtXsnSBAJcmv9PhC2WUblhPnZRthDQiH3e
         xESxURzq1Zw7hdsSI+aaxIn2P7oUBm9sqcF6nNRLMDNErYnYpuYXFvjgyi9yDdaKDQnN
         Y+lNKe7d0LBJq0f5yE6dlrQz+H8qs7InnnDgFCKNWNePWtNIpOymedxoGiTD4n7ifo61
         WcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790031833; x=1790636633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OdbPBPyzaOM2wXlSY62pNAL0ZMKs+usFBD9FO5JbEdo=;
        b=NZCn3asgwRGjCGkhsqwQA5IQRrH1/Be6HawFCBynoZfpEo7RdYf+tmdvOrykjEe7bV
         fsWNObKufo6SnRX2pNIyBVSk4eXy+kABgPD4hmQLTF+l+rMgV6lpHfNnIwNzLIGK0V19
         LbX1azMWQeWLKqhNw3cE7aS7NZ2tuGLGrIsH28z14ZcrKG0gWSLqqs1Vy/oEURkdrelM
         +vIgusQ1dalwG54GFstQzFrUtzTVsOxvrr8GzEPleaHf2gMcsLhhxje7bgjQ3+Wt/DV9
         S8yloAO6hXyvSwdzqsXC7NnKxTqeb3pfnpSAtg9RF2KOHmhmQBbUCX5geTm3qhfmXyOF
         d7zQ==
X-Forwarded-Encrypted: i=1; AKwUvBzFSzNeNmpvrdv7D1xbaZ1wfE/nWm+arAUWl+i5ebQwJW4UgqBbyIY2icdyHAAeykS/rQSvfdg=@vger.kernel.org
X-Gm-Message-State: AFuF++kpwJBmSzkxbi8LjlnBCap0lSQ+HbA325ozPeFH8HWs+sDXSnT7
	0qfUgnA7F9Jrh7lLwO/1sKjaYVd+uxy0e7se0y0qeQ74JfEcX+p2WnyW
X-Gm-Gg: AYBFou3LYOu8dKeu0q0E0U9tccj+dbOJBvuwAVP37LH9Yv5o17udvzdKb/WhR6AmkKj
	VcFJ3VnmQNEeg3WTRKMqv18+2d1kjXL5T0BitA2aEpU/VE1pWxuHi0usep0O5qBeoADfuYDx1c+
	oi+sTWOhbJc3vs3dPmUfG8qjTat6UvmE+992f4ezilt70Zrhl11LcF+7nlXbxqIERqYs0GPPd3W
	+/7xbuWspSkAaExMPG55X655Bfk/5jEA4mbBxGvvS+tmmajRvHTp5qT9aJtTpzAeLJ+ReFkt2UO
	hn1pJU2blcNO5c8PsmrIBFLTSiVgXo5zqPw9+rGfO5I407LNQ0/2m2tZZfnl+J4vMhp0W+2sUib
	sXfFEkl70/LzAWgLI2glSgQ4ZgbTEWOOWdaE+7t9+CeOQY9W4BHLVJxZmoMwC7B+4LVQvMTRXTn
	kDiPd6KJukt7Jwp+rCG+Q20PHuVImDBwWy59OW7JsxvO4yI5VtsPVlEKggHY8pQSz8hx5OBFsG6
	x3we2fcY2Req08iSg9e2dL5rX/G
X-Received: by 2002:a05:6830:610f:b0:806:e047:cd7d with SMTP id 46e09a7af769-80de045b1d3mr12860708a34.7.1790031833370;
        Mon, 21 Sep 2026 16:03:53 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:f::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-814e648bd3asm184805a34.17.2026.09.21.16.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 16:03:52 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Hongfu Li <hongfu.li@linux.dev>
Cc: Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Chris Down <chris@chrisdown.name>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Hongfu Li <lihongfu@kylinos.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/memcg: migrate per-node hugetlb lruvec stat together with hugetlb folio
Date: Mon, 21 Sep 2026 16:03:49 -0700
Message-ID: <20260921230350.3649114-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921-for-hugetlb_state-v1-2-8a6eec92661f@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 21 Sep 2026 17:12:35 +0800 Hongfu Li <hongfu.li@linux.dev> wrote:

> From: Hongfu Li <lihongfu@kylinos.cn>
> 
> memory.numa_stat exposes per-node hugetlb counters from per-node lruvec
> stats. These stats are accounted against folio_nid(): incremented on
> the folio's node when handed to a user, decremented when the folio is
> returned to the pool.
> 
> During hugetlb folio migration, mem_cgroup_migrate() moves the charge
> to the new folio and drops the memcg data of the old one, so the free
> of the old folio right after the migration skips the memcg per-node
> lruvec decrement. The hugetlb count stays attributed to the old node
> for the rest of the life of the charge, while the target folio gets no
> increment on the new node; its later free decrements a counter that
> was never incremented.
> 
> Migrate the per-node lruvec accounting alongside migration. Global
> memcg totals remain balanced because they track resource consumption,
> not node placement.

Hi Hongfu,

This is another great catch, thank you for working on the fix!
I was able to confirm that the issue exists and was fixed by this patch.

Tested-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

> Fixes: 05d4532b60e3 ("memcg/hugetlb: add hugeTLB counters to memcg")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
