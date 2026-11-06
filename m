Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986845;
	b=mbuh/6kjh548PS3P0RWzB5BJiDAdh0CVmdMHbzUjO1yCfQYyW6zgvCQowHloiC7LawNP
	 83bfTY2ZtNl1O7Z9piXN+3TZUdsQ56aF9370ZlJeXj/Twad98mss+S5XODpjH16WEGOW7
	 BSGXTAXmmg6if5Feq1LXT1sWqYKosVUjWWVWi+uY1B/yWoXqQcutGGoP5oSXxOF0+Fk/b
	 sBf6O49+DOKoa7z3IoI/RjUmaRdaCZ4z4/GhThQ0SLDkagNfwNo6y3UXGJDKNhO2VFGDZ
	 d4CMhTCPQeqyQAhKzGe+TwBeBwRemF4n18KSE/PK9fxUwBd0h0Cp9Wlb+vc17Nx/Zvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986845;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Y13j0LTUOpG3IGiPRUu5f/tDHT82BAGPGt8tpe2/3YY=;
	b=EEnodPzWyAlBXsTZJ2zGmubjSPRvVBCNUEMiAddPUyj0JAF0i4iUDK+T7orec1j8mf7R
	 hBr2OvOCF8ply1//1IIbEeFTXQtCsEzHQQF1uLw2lctLXnCCcWA7nIFKPPzoYfQ2Gh63D
	 ptz9KnSo39Nk2CLUkwVBnsc3OYOZ+zxxTqa2O6f3J8x+vIIZWdIYgEIwHFFfjoQ3D/W20
	 JAGIGejwlwxGtSmsflWIa767AedMlgrJriZBJ4YK0WOwFYhYlcdpSSpVn31Jyqx89FM6H
	 eoIgxBHnouZP9GFuWOppM1YOUBzWJ6Be9PcP4dHVR/MJ7RY18NEt+922L8iSaqc6inw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DFzQhfFw;
	arc=none smtp.remote-ip=209.85.210.72
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD23606A32D
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 17:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DD23606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DFzQhfFw
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-84586110393so1068665a34.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 09:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793986844; x=1794591644; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y13j0LTUOpG3IGiPRUu5f/tDHT82BAGPGt8tpe2/3YY=;
        b=DFzQhfFw93o8p19bSYcOWrNTPQ9ovktUQVuzg3nvO9Yj5zg8cB5XIsdPA8L8pAcNBe
         lhQtoSFmtDdIAOlGWYAiZuPjtdRzQO4arF/n658BRAFKb0FSu+YOYK+mwq5JR4A2rjrv
         mbb1CvjS8Vgpf/db2vuwW4j483wUvaxkmn5x8bru0ZDP+vnaM3rEnCvhzbUDafkBgTKJ
         5HGytZVm3fn9bqPiENoe509TeVjJsF2ePfmSEUPnpDaz3kKkH5IjPmNoX02DQBV570ta
         rHJOg38QmOY6TWU7k5/pV5ZbeDuJZzRprPEB6yRYji/pTpqMiGTIbLqhYF+29rjb9C/e
         5vwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793986844; x=1794591644;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y13j0LTUOpG3IGiPRUu5f/tDHT82BAGPGt8tpe2/3YY=;
        b=Jr3G/05OriWp+g6frDjPhATZc7qlMlxzGes8l1R6zm7D5pNQ93VFOFj7egiq0R8s3K
         uc8gC06aPKRj7kgraGh09yoV/69KeRmNahj8q/TmFXsj8GnDlSDMAkPhLE/s8Zp8q1kV
         Eoyr7OrZH8d9k7onGLoDt/eocQJhDq3Le1l0ws1rbIv99TKHO2Ss0/o4KpyQ+PmBjBpT
         JZoFu0WmaleIBLRXYVP7KrpLysF580vB9if/Nmxo5bptscYKqIDi72pxQu8IkSdvRWoc
         SE8WyE53N79GIMORV9/dQSJWlZBJDVNSquD9nMS6F2wDtew6W0pkCPIDLY4QMXZoUMpq
         /mEA==
X-Gm-Message-State: APuU4Z93ArKRqrKyMpy0Umw7+MRFo5VypUfjPz6gnPlF3YXkIot45yJ1
	B7rj9BxGsUYk3CNEG5p+ovAd6//BQjMbPInHduLa56mUrzruhS+lpQkJpgIjkyBNE+HZSzUSlAx
	ggiECIVAYOttflp7at6vCwprmn7xNvfXUECDZMgmnNkVtFUzJab826IJkH50nBsqcfVduDCfzMN
	CfxBaQO95uO52HP1ajQUbNfPz91K6loyxR6anEyGYFnqD5U7uAthn8
X-Received: from ilef12-n2.prod.google.com ([2002:a05:6e02:618c:20b0:53d:490:b043])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:2443:b0:4f5:eaac:517a with SMTP id 5614622812f47-567e0f40db8mr2120139b6e.1.1793986843828;
 Fri, 06 Nov 2026 09:40:43 -0800 (PST)
Date: Fri,  6 Nov 2026 09:40:31 -0800
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
Message-ID: <20261106174031.740868-1-tjmercier@google.com>
Subject: [PATCH 6.12.y] mm: remove '!root_reclaim' checking in should_abort_scan()
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
index f9b5fbd072db..333e3c800e78 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4752,10 +4752,6 @@ static bool should_abort_scan(struct lruvec *lruvec, struct scan_control *sc)
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

