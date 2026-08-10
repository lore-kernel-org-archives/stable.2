Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3203B42E3;
	Mon, 10 Aug 2026 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786355879; cv=none; b=IO6zJ/57kvjLd3ayQDoR7iBxE7iwvcZj8M0wkJY/VDws50d8bLPd8osVTw3YGO4QLG8jyNE2U8C3/7Zq1kWnzxpinMIdzlyaGOmrkkR1z5UXySpsnp5EJMXy73uAYMGmLeKvaf4Bgg7KQPGzb2/qPaBAMLmZeOV3lCzxQMEYLno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786355879; c=relaxed/simple;
	bh=fmI8xADi6KWlR3J6/Hbvd2ecHxpAV7Iqo9WVc8nZUVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aYj/XjNj5objn34RvJKgwd4j4taWDbRwGqmcVIbPbyqWRdt15uaiT5p4tWVpkRHHtwEooaeG/XylzrsrE6eLKNTuJ89r1Db9GjP3/FWzQw4PmPdIebXXwUV/pUJl52bvFWOaeDs4jYEgIV226PdO2aBrF/w0bX4ofu8txY+Z80I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=KUfI1DZj; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="KUfI1DZj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=aL4Y3k21PGVS3UmK0vSrCZe8gNNQ0oA2E/XU6jNiXg0=; b=KUfI1DZjXqL/Vruue4o5aBZ2p3
	OoixOh3ygSwcf0yEhumKG5uDDA11d84lWixiNYDVdNpqnMtMmA/9qSu/H7JTMIvA6ozviX92N8qU4
	HoHiHB3qxa7Gp3nwRXUJB6/gn3w208eQA0PYeaWo7rqZcEftdPkRsMRjvqRp8eaowh7qFEvNLrgY2
	Rd6UJClXQsR3owlDWTF7Y385ZrQtc/nz2mkWLuOygLA+5nHt8C6KRz+Twaiq/Zv8PtgClqTJ5+gbl
	zGyA4UbMItmYiObBMQKKIP4Mzq2qUSU+2xK68Fi2D6dV4aNds31V7wmI0lAl6gne0niurOL3Uq5K1
	Tt1RHXlA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wtMlL-002fPE-2v;
	Mon, 10 Aug 2026 09:57:44 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 10 Aug 2026 02:57:36 -0700
Subject: [PATCH] mm/vmscan: report RCU-tasks quiescent states in
 shrink_lruvec()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-rcu_task_shrink_lruvec-v1-1-4d9f7d5251cb@debian.org>
X-B4-Tracking: v=1; b=H4sIAJCgeWoC/x3MUQqDMAwG4KuE/9lC04cpvYqMIjWbQelGMmUg3
 n2w7wDfCRdTcWQ6YXKo66shE3eEukztKUFnZEKK6RYHjsHqXj6Tr8UX07aWzfZDauiZmZMM/Sw
 RHeFt8tDvPx7v1/UDSyqAyGgAAAA=
X-Change-ID: 20260810-rcu_task_shrink_lruvec-711112e87de0
To: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>, 
 Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, paulmck@kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 stable@vger.kernel.org, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=1691; i=leitao@debian.org;
 h=from:subject:message-id; bh=fmI8xADi6KWlR3J6/Hbvd2ecHxpAV7Iqo9WVc8nZUVM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqeaCToqI2nT8QJTT84s4jrQ7GMvHwM36xgVmyh
 5GeZm4IMW2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCanmgkwAKCRA1o5Of/Hh3
 bXz0D/9wIlKhOvTMTno87Pfk5Lc4xEpnhJ5xET8HtTcF1K3Ho1A0Hx/Id26g9EBF112EyxBkIiF
 5+DLmbUKFj3geNY6shSQZUgyH/jIe7AYj/Dfnmj0gGgno6sQ2TxGOadkpv2gZRTcWJKFwM15moG
 ySksHCa2U6y7rHfkn1QPGr9hXM9dz8KI55VUbTa8h4ZT2+V2ajxqMUckYlistFjA43J6eFa+bh7
 ncsWzyxcQzp+kDiEkeVYIVTrBuP6rzgqcBK898ZoSqsqMQ6WQ8fTI0OdRAovmiK82rwbvSJPgX1
 BXkFAffch4gPDytj/K4pMbZrHCTp/mfVCcpaX7v4EG2ISzN2El8BpRSFISafFXmTKtCKqH8QVdC
 DIFZhMk8Zrkaa7H6o7DZIwcPnbAJDxzuLdzRrCSTJC2obsn/TNtVmymRdUnZHXYgkgRjk/7HctI
 L22Z9mrWFukw1n5gYajo1z6oBYBLohHhNIyEFr3ncHO06B2otAGW+J/KbKFtwHF1cYdgZQeZFCD
 bTTjjNmpwMIVIltTt9PLrvomJaHLfMin5R6R96nIOnALSun7XAqR/A8VBCauE/8+Rg052j/Xu6k
 rxsqqPlNIw6TTdgXP3BbKZvR/m3gtmgoCOcg2CfsyOsM5Y34AI3jjYhPzPd9eazsWDuFiXeOMHx
 hilvBDWbfGwTYtw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

I am seeing some rcu_tasks stalls in the Meta fleet during reclaim.

  INFO: rcu_tasks detected stalls on tasks:
	0000000088620d09: .. nvcsw: 6735/6735 holdout: 1 idle_cpu: -1/8
	task:GlobalCPUThread state:R  running task  pid:2552016 tgid:2524552
  Call Trace:
   shrink_lruvec
   mem_cgroup_iter
   shrink_node
   do_try_to_free_pages
   try_to_free_pages
   __alloc_frozen_pages_noprof
   alloc_pages_noprof
   pte_alloc_one
   __pte_alloc
   handle_mm_fault

Nothing promises direct reclaim returns in bounded time, and the scan
loop in shrink_lruvec() only calls cond_resched(), which is a no-op on
PREEMPTION kernels.  Involuntary preemption is not a Tasks-RCU
quiescent state, so the reclaiming task never reports one and becomes a
holdout.

Upgrade it to cond_resched_tasks_rcu_qs(), which reports a quiescent
state even when cond_resched() does nothing.

PS: This has been discussed in [1]

Link: https://lore.kernel.org/all/amdWVTs0WKOxguxP@gmail.com/ [1]
Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 26436059ea394..6ac2fde137b89 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6023,7 +6023,7 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 			}
 		}
 
-		cond_resched();
+		cond_resched_tasks_rcu_qs();
 
 		if (nr_reclaimed < nr_to_reclaim || proportional_reclaim)
 			continue;

---
base-commit: 6b8c8af514d739d0335f5579b585e02babe8a727
change-id: 20260810-rcu_task_shrink_lruvec-711112e87de0

Best regards,
--  
Breno Leitao <leitao@debian.org>

