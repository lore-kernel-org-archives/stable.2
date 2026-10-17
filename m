Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB0F37E5E8
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 05:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792213650; cv=none; b=RDDBKeBEjNw5s89wQA1fpDoZvK50z6338oBZpRILgwF27qNevK01KsunzjgqP9l0x9guGRBUhBmyVmBmr39EhtkiiT4FfoIrShkpGAnIOLbqv9uF/mCdmt5hNShNw82V2BRNbEQxcgWOsm0/DH5OzHs9JFCmDKRwzLZ5doYitIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792213650; c=relaxed/simple;
	bh=GtwgCIcdUhmCTpOZjA9h2ouHNvm1jXvZOqzlD3teHsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXbg75BgbVM66446pJ+tGeIDxx5mL+vEV++wkMu7pBG0U/hvTsCHWnLCWxDVDkHPFwieI6/S76op1DgRqw3QmOyJfBMpylDb0eS/YTyvE/B7/95tJU6G4SPoSEVMPHQoCjnMSnnbqdybYwMB7GpPZDadqelxqdUWJVAJHp1xA7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcMQTKxb; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcMQTKxb"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc1d57602e8so257949a12.3
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 22:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792213649; x=1792818449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ltltwVBtHl3kghO+WSesRQLC/X/BP4EIFkAkNpxFFq0=;
        b=FcMQTKxb4Nm7APF8CyNf+HydWybpXlFGUocmIeY/wOxlwj9bpfkZuKGjaVkownxkHJ
         ui21mM+QFwbDDxJZmMMmlC/y/7UiRoAemfuDTeTZb3imHZyA6mPwldHXzQjDnSP1LSrg
         DCwEXAZX9cC1Q5ecZCvxoX37czWUuf3383UMBAZ6qbR8G+EltPw1EkRvWamhQ/YSYEUb
         UjutEVtRFGmL0HminVqS+LZfPa3wRZc53g0UaTceUtof4HKYBh7QXZKNyoKX15u3MlUn
         XM0YVWgMTucjHiuHkJPL8S1d3NtEJHMo/vY7k7kxF2DZbEc9/gmIxfXGHjNFvS6k0G0/
         Ze3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792213649; x=1792818449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ltltwVBtHl3kghO+WSesRQLC/X/BP4EIFkAkNpxFFq0=;
        b=LR3inwsOxJZYvkRtIfM9ImeDKYTw4jMV1IobAc3R2vahpwpLB2tBYgaW8v4XSBDGrC
         9ygimQlOhY4xazImfpMzpsoyCoJeKRZphkluBiUZh5m672EKF0iQqkLvUUugcEf1GXmQ
         mZzFLLIUH5KJJvBwb0unoUH4lQLRa6mlIpXIsNNKuza4JUj+Sc44EdINDMHijIFrsL5L
         7ofKPjx30s0BJP3i3tF3Kn7grAsdZ0m2wZ4X0H94dvaJo3cP7CagZ1Ox8Xacwgp9p68S
         HxqaWoH8TJ9pmqk9OMk2ikZOwFjhjve5fs9vhFF5dzRykaV9z/iCFtO/DG8oXDRst5Mc
         zZDw==
X-Forwarded-Encrypted: i=1; AKwUvBz8xF107tOreDJrmSZQGdbOJeJkYbvGdY8NFpZWwed89NQmo3YtOcuBzM3KnEUBhI38W0hAM7M=@vger.kernel.org
X-Gm-Message-State: AFq9FYK7gOkIeX3KOg4djZ8IxxWFdIbAH17dIXJQE8nVJVfCUBHpMRYd
	eEMqkfRRu9X3zMHK/IEcLTAwq7xBlJkbodQR/nNPGa1EAl5Shz7ermT03r3sDw==
X-Gm-Gg: AYBFou1Z1q3ChiRDxgQnjW2KrcPJfICAdlxeScbCfZO94D66EyNy6heSBVNyZZnTjOn
	/hNp6NWrP9/INIzo5sYz5pmFpiOzHvYJhGxofIRLgOrcs+Esbz/9fzf+pX+kAlMEetbMtfcW1zB
	gr+sPGsSgUWzHawxj5Ruwb0eOus/r5grZQL2W6tdifDqGQqu+7kNtmhuwSbuwyjzHMRBntQ05ai
	sUopAaTrlZj0Wxmai0cXRgBUHBY64oEcCGYsrBWMzkIFUK2qTWIPunsyeE3DSSOxMMs7AN3nGzr
	9dSdOFAgpyMzGLndSIbRuKObeiSZLTD4zErC/Z9b8t8647GqRQQ7+TjVkseA/gxzVugbFQdUsIB
	5AtDEk/pP8QuJ4X0KAwMtrpgkluMoSkGFGl29ka3Fr5qHfuuWEaXW/XOXUbm5o+Kfy+xrourpAO
	MpmHobJAk+GUpfxjyKd352VONCY9XjP5hXhMA0ELX6InWpG5r1YdkzEmFhIV8Vyp0RY1YFGAyGJ
	Pg1Nx4MxkRfiB5f9jkT8cqA7Y4YRFC1jFAVLpOT55SHs7z1u7xnru4Jb8O/irtGg3jiNvEzHXqp
	7Hjx/yZtZLZfUXRpz90r360JZTwsEttCYV95B/tlTsXp+EHVd26/Sb6cGU+7aHFUgv9M+JAuShb
	4utnbO1qqrQ==
X-Received: by 2002:a17:90b:3ec6:b0:3a8:a1f6:3b32 with SMTP id 98e67ed59e1d1-3acef1885b1mr1603861a91.38.1792213648677;
        Fri, 16 Oct 2026 22:07:28 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd65484a66csm2111964a12.2.2026.10.16.22.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 22:07:28 -0700 (PDT)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: 
Cc: Siddharth Chintamaneni <sidchintamaneni@gmail.com>,
	stable@vger.kernel.org,
	Hardik Garg <hargar@linux.microsoft.com>
Subject: [PATCH v2 2/2] mm: multi-gen LRU: fix NULL lruvec->pgdat deref in get_lruvec()
Date: Sat, 17 Oct 2026 05:07:23 +0000
Message-ID: <20261017050726.128260-2-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261017050726.128260-1-sidchintamaneni@gmail.com>
References: <20261017050726.128260-1-sidchintamaneni@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Andrew Morton reported that get_lruvec() has the same problem as
lru_gen_shrink_node(): when memcg is disabled on the command line
(cgroup_disable=memory), it returns &pgdat->__lruvec directly and so
bypasses the initialization of lruvec->pgdat. The MGLRU debugfs
interface calls get_lruvec(), then dereferences the pgdat pointer in
lru_gen_seq_show() and other paths, so these can hit the same NULL
dereference.

Fixes: ec1c86b25f4b ("mm: multi-gen LRU: groundwork")
Cc: stable@vger.kernel.org # 6.2+
Assisted-by: LLM
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Signed-off-by: Hardik Garg <hargar@linux.microsoft.com>
---
 mm/vmscan.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0c57e4f1eb15..99e9f07fa2e1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2745,20 +2745,9 @@ static struct lruvec *get_lruvec(struct mem_cgroup *memcg, int nid)
 {
 	struct pglist_data *pgdat = NODE_DATA(nid);
 
-#ifdef CONFIG_MEMCG
-	if (memcg) {
-		struct lruvec *lruvec = &memcg->nodeinfo[nid]->lruvec;
-
-		/* see the comment in mem_cgroup_lruvec() */
-		if (!lruvec->pgdat)
-			lruvec->pgdat = pgdat;
-
-		return lruvec;
-	}
-#endif
-	VM_WARN_ON_ONCE(!mem_cgroup_disabled());
+	VM_WARN_ON_ONCE(!memcg && !mem_cgroup_disabled());
 
-	return &pgdat->__lruvec;
+	return mem_cgroup_lruvec(memcg, pgdat);
 }
 
 static int get_swappiness(struct lruvec *lruvec, struct scan_control *sc)
-- 
2.45.4

