Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986948;
	b=2vHJ/VcJuAHzukR3Hy0nqAj9NxVme9MuEdEjs4AgpGsbv5qXqlvLpaLiJ3P/g2chmMq/
	 6fNUEKVPm3iWPGkL7ETKDuzvBzTWtyBc7BkFmAty/kV9p8h38NmZpPs3CKDG4gYfgmRmU
	 3FGlsd6PiBnnN4+1vWvkadrhxJS+S9Sf7KdZYzZJQeT9fZj2LUZPE7HMTP7XdnmhipIlG
	 d/rKykZJQibJyk7wWYYTQd97pb3IvgYPNpRVQPSRCXGc08sDRXBES64gCKwFtF+7zWEUG
	 zuCZ3PcSMiufn46EfVeDSoGs28QUZTxmEdWS2B60V8C5hwD9AhAuXquP1zZpqZCF73Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986948;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=dUFLil/A/qxmQAsi18K2mSML2dlbE2/nzQZ4zVZkdWo=;
	b=vVaGpwzwWOszkq20itEn6Rptc8fgGdyzW6TvntxKM8seTxZpYbr+bPaw6ddQ/auM7Bz/
	 DmbN1EQ3ZBaDvgRZ5DDstjaDwi/UqIVcTRXkFvD0Erf/SnZRIFeFnUwTGEHnr7FxfHyiH
	 2OVgvhNQgQW2czAxUlvyTDo8sG8ZqXXdMNp41PHpnFuftCwM5uxJIkayx/R4oZDDWNewK
	 tVoDtGyF1SIa3ZxtnW2a3dhumGPyc3gE2IG4V3zPO+4+t15lCnyH6BqTcNBoCxODJ7OWV
	 F5bDuW24BsvuGkATIcQ+kXc3lIHAvWwNRouHGdRXVDCW6D2kQTD1XXTdLkALXpOHyFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dBQ7YLJ3;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74529606A329
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 17:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74529606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dBQ7YLJ3
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-54dbbf252cdso1192853b6e.2
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 09:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793986947; x=1794591747; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dUFLil/A/qxmQAsi18K2mSML2dlbE2/nzQZ4zVZkdWo=;
        b=dBQ7YLJ3uODDOED/2DgPxg8PsjKo7WdunLMq/Uc7+ISd0xKH3HFCKcXvKdHh6BMlXx
         EjiCPxj5VMx2JYp5iF/IqOeaY8+s6X+kf0q9q9tow5Z8rYr+gqWqMkWbSOlu56KONeiR
         l+Xv5r3f/0YAyu2cC32fHKpW+p3LFHqFgEWt65YvYp6Ea3Wbkm7+8v8yc6jpdPVaO1fx
         AE4t/igBoDkEOZrDaCQClAIa5RB+RkrAOqajMK6XGsGv7ALoZzNdOAaDEHaX3oKz1FPz
         +YHe5qXhv1g2afWUa+kV+f91ozWPt+tLI9bZC6o+Ma9p7X4k7aqrJYkKgILfcUiiJMb2
         obxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793986947; x=1794591747;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dUFLil/A/qxmQAsi18K2mSML2dlbE2/nzQZ4zVZkdWo=;
        b=OGMY2W8nLduIGaHpUKrnXBV3MEduAXrHey8v/7NASBSbavizq6A/haEvzlWwhEE6gR
         oRCh9O4tQjoIGGJH5dQTCWoQfX3EkRAsn5t3SvAa806cBfYtOT9U/zA8ikTi2FZ26lxP
         tz281JqfvawHls8sU8ZA3RkXDVFAEU28VJwR0sE1aAqYlsbtep8CU/p09HNDbfqL1bSD
         Meoy4M7qQ5Xb7G/DWT+UpEBiUGdAUs1fZgH0o5vN+z8oHPqKkSGxmbZP7NuUE2UKabH5
         FyzJiwydRQPABqq1SYQW9qbjV40c+WiYJahM+kUDQAeXxFeoVUpiCo6JSf6UPfEgYwsF
         gjNA==
X-Gm-Message-State: APuU4Z+xB8cPjIpOJjZqVLIE07S1InSd5ZKQaPdK/Sx//qJgBOlWlcJm
	Cigv5BiWevIjdb3AaBXMD8SYoUM3VQspfS3A7qZ6ls6WQ+LMrPm4gYn8TCtOKUCM9Ozz1MVZgXQ
	LI2NzOrh24g3KU2r32xjtYBYkoQxGkDcrRIYv4idCJrIBlTjaQu0iWWfToMRpRAaa6Rhoos+nRs
	ZIsxh5EiihPcrgvr9qxtH8F7jfa7p684BpZggyVJ3MaP3hyi+nAy6d
X-Received: from iohc24.prod.google.com ([2002:a05:6602:a998:b0:9c7:7f8f:934f])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:4f47:b0:4b9:a8ac:480 with SMTP id 5614622812f47-567e14d9facmr2577739b6e.30.1793986946809;
 Fri, 06 Nov 2026 09:42:26 -0800 (PST)
Date: Fri,  6 Nov 2026 09:42:23 -0800
In-Reply-To: <20261106163056.541441-1-ehagberg@janestreet.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106163056.541441-1-ehagberg@janestreet.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106174223.743929-1-tjmercier@google.com>
Subject: [PATCH 6.18.y] mm: remove '!root_reclaim' checking in should_abort_scan()
From: "T.J. Mercier" <tjmercier@google.com>
To: stable@vger.kernel.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	mhocko@kernel.org, zhaoyang.huang@unisoc.com, shakeel.butt@linux.dev, 
	qi.zheng@linux.dev, kasong@tencent.com, baohua@kernel.org, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	ehagberg@janestreet.com, "T.J.Mercier" <tjmercier@google.com>, 
	Rik van Riel <riel@surriel.com>, Roman Gushchin <roman.gushchin@linux.dev>, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

[ Upstream commit 19999e479c2a38672789e66b4830f43c645ca1f2 ]

Android systems usually use memory.reclaim interface to implement user
space memory management which expects that the requested reclaim target
and actually reclaimed amount memory are not diverging by too much. With
the current MGRLU implementation there is, however, no bail out when the
reclaim target is reached and this could lead to an excessive reclaim
that scales with the reclaim hierarchy size.For example, we can get a
nr_reclaimed=394/nr_to_reclaim=32 proactive reclaim under a common 1-N
cgroup hierarchy.

This defect arose from the goal of keeping fairness among memcgs that is,
for try_to_free_mem_cgroup_pages -> shrink_node_memcgs -> shrink_lruvec ->
lru_gen_shrink_lruvec -> try_to_shrink_lruvec, the !root_reclaim(sc) check
was there for reclaim fairness, which was necessary before commit
b82b530740b9 ("mm: vmscan: restore incremental cgroup iteration") because
the fairness depended on attempted proportional reclaim from every memcg
under the target memcg.  However after commit b82b530740b9 there is no
longer a need to visit every memcg to ensure fairness.  Let's have
try_to_shrink_lruvec bail out when the nr_reclaimed achieved.

Link: https://lore.kernel.org/20260318011558.1696310-1-zhaoyang.huang@unisoc.com
Link: https://lore.kernel.org/20260212032111.408865-1-zhaoyang.huang@unisoc.com
Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
Suggested-by: T.J.Mercier <tjmercier@google.com>
Reviewed-by: T.J. Mercier <tjmercier@google.com>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Kairui Song <kasong@tencent.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Yuanchu Xie <yuanchu@google.com>
Cc: Wei Xu <weixugc@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 mm/vmscan.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2c66fbcd6e84..160481706b42 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4844,10 +4844,6 @@ static bool should_abort_scan(struct lruvec *lruvec, struct scan_control *sc)
 	int i;
 	enum zone_watermarks mark;
 
-	/* don't abort memcg reclaim to ensure fairness */
-	if (!root_reclaim(sc))
-		return false;
-
 	if (sc->nr_reclaimed >= max(sc->nr_to_reclaim, compact_gap(sc->order)))
 		return true;
 
-- 
2.56.0.455.g6c5a503b38-goog

