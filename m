Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479573B0596
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 05:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792213773; cv=none; b=bYxi4fCCnlapjaEeiaq6AdYt4PUf2X9UrjgmyKfKJV3r9iMeYhMj3SD+0L3x4PFfrQ/m6LOO25PZCADkYCxijA/LySgJemv7EC88CBOI2oKbNJPf4Y8+MqLI+dOMsM6HvxBs9wW6spsC/IYGvLoEVZatHkiZncqqHRXriqL8W7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792213773; c=relaxed/simple;
	bh=GtwgCIcdUhmCTpOZjA9h2ouHNvm1jXvZOqzlD3teHsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCiSEbQTd1DW2B55VJt28nB+v+G+WiVTKmJpg71GasXnS8AkeqaOfRm6Ap079JgIWzGX0X20o61IucW5aS9+G2xumuzEd9+i2vCP3JVtbGhA//YBZznQea4wJ0hewHY42+VrriXtmrPBqLs1GmYIrr/TOjRxQYaRe39H+tJf2J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gt5nales; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gt5nales"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a052aff9e9so122609b3a.0
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 22:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792213771; x=1792818571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ltltwVBtHl3kghO+WSesRQLC/X/BP4EIFkAkNpxFFq0=;
        b=Gt5nalesXLQ21y3xL7yOJRshONEbrE9EKiuGXeTG348zaTuoivWIvqTE5/8DAC1tU3
         ynyJ5yAxNtQgkPapiE3B8Zy/SDbuM4pk1zcvTHUWgi5wYgVZQGXNFrpMoWt/HMGRuLg9
         yemDEUVB5lxGdHUifXIlWn3TPR9iz7K9MZnKkb5ht3Gld3EJ3Ua1rpi5S2/InIagL9be
         py/WS2tbhQrE+YIY5aUIb7J/1M+ZHZHv8XahCTF37jXPC2tVBlX69Sp82keBrjx+YVw5
         66BUMUAC7ltUBeGxyPigLlRYOU7VzYXAGXY3iUYWNpLRdieWFczk+FYsJ5iA1IqUrb6m
         nEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792213771; x=1792818571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ltltwVBtHl3kghO+WSesRQLC/X/BP4EIFkAkNpxFFq0=;
        b=bFFXf8xnLKmyPvanFD/d55gHMqs0RMl0dz9KUsjZezvOmp15l0tLzUp7c6LHXiC1Hv
         1wJBLOzW3iqULjMqvJ36Qd5AFBOsjLiLsPGUHotlMRc2+dbQKS4COWe9ADcdOonm6//z
         zA/glV/VWaPPuUW1DSAqoOkDFYGFcwxw+8HEPxs63mOZLlTqtguEAbNGeg8iduHzb87H
         y5UHv8NLEvYhV7frKN0DK+Qdpf+fTTN5LgogP+X5xC4TVPjZ5KDYPUjWthMD71ftOV8j
         Dc0y/I8GpIyU0IBp3N3EjXFSvZ07G/XYLbO2//yiCEXoZT/V/Gnrd6bNtyV8swITPR3x
         u6fA==
X-Forwarded-Encrypted: i=1; AKwUvBz7wcOv7zKq6K/6f2/LLj4hLdS/0bVrF6ZbYlMGBYBEEaT/5wbAZjC+k48xTkD1ZzLTfi2uRGQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJpQ8Gvm28OXxXm6i+zDrFdUZ3Tb5FQSc3cu4/fkAIV6nhb1FTs
	mwhVqADenEjtSGhROwSvZybnG3nZajZ7Ib3SpA7EHlB0ds1znkTSqaV3
X-Gm-Gg: AYBFou3RJXufGDh9cTmOPSoljk5Kbm4TJnw1PXv5W7JeuFmNvXSFApOfEi5/lhM5jcC
	QFdIEx+DBFbortGjoY1H4DpKZ0SSJNSV2YdvMvCiC+84MCx5jLeP0bwv9n6EzPxKFnjuvBiKUgy
	3Pd+Bn5ZD3boboNI68kKs1Ul3YLGYkz0LEEZCemEq66mI6V/lwRdK2jV5GTZ1eppUE36CtVhGJe
	hHrUVX4XnHdpUwsTswIJzwEwQwz2KuYjsIHMPxbhE1gmsZStGjUZtb0h20UtxSyHffXB+u5TgVI
	o5F192e1aLiNh3GUHv91tWkWPvKgrw9RGDWjvq2v3yA9Kt4AIatRg93CD4ArK4dj1vbams18y30
	tWIGw5KILy2BQpl9oP3xr0X01mhkss1bclkJ8+KB7pS1zvnkkY4Bb7fsuTOjHdouKLEUBdr6ww8
	XwbOpR22OHCvFm0dQ9uNKtUTsmg5fB3ZnXuSvEKWN5EzqvFXVy1gSwGXTXEwY8GegBwkWjf/6o+
	8i5t2HvuKcw3Bvea00fsJlZA3DdSM4OrQxn8oJxoRJTxvITxfR7Vsm3ImNrdRPXcIvwgurWQQNG
	h0e0H+lhT9pvWS5msBHuaWh3BMIFiHVjHlx6DpapRl+p9XeB+InmNO3i7LSEJw4oH9VtpCZOOy2
	4BG5VPthQuw==
X-Received: by 2002:a05:6a20:d48d:b0:3cc:8f53:26c0 with SMTP id adf61e73a8af0-3e225fe541amr1150821637.17.1792213771457;
        Fri, 16 Oct 2026 22:09:31 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89febdc2209sm1446036b3a.33.2026.10.16.22.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 22:09:31 -0700 (PDT)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: akpm@linux-foundation.org,
	hannes@cmpxchg.org
Cc: david@kernel.org,
	mhocko@kernel.org,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	ljs@kernel.org,
	kasong@tencent.com,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	yuzhao@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	apais@microsoft.com,
	rlmenge@gmail.com,
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>,
	stable@vger.kernel.org,
	Hardik Garg <hargar@linux.microsoft.com>
Subject: [PATCH v2 2/2] mm: multi-gen LRU: fix NULL lruvec->pgdat deref in get_lruvec()
Date: Sat, 17 Oct 2026 05:09:28 +0000
Message-ID: <20261017050928.128582-2-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261017050928.128582-1-sidchintamaneni@gmail.com>
References: <20261017050928.128582-1-sidchintamaneni@gmail.com>
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

