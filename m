Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426573;
	b=kcLkMVCBmYcTFYhsz7jacYgPDZ3tGW2rxH3sNxNhTz7xJlLMjrWm/TBUym5BxGTldQyD
	 94J8CtMonGGrj3oT4YgAej0mojU+V9HfRSMMhlpYLVSxVDc+/W64WgJtfESnzc1L/2KSA
	 JLfGFsvF1rKsRitAvLL+oacdqq+RQXZOk/hZmlbO/JGm9E8ci5sgt0COvMx/fsA05A54X
	 B4zc1bXFOQ5DIrRksRrDcr+QdUg1XAQ0rwkbjkkraA2O+4kLdNFUUsh7By8s0xdqmyWkR
	 yKNdCC86KfyOiGyGaQO7qTnZz4GHCYRsxkIGhUKoVAYov4TLw+snAh9hB6AjFHJfKcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426573;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Oc6ejAXbOWvHTL82rIpVWqGj664xm50y5XMfyuasBD4=;
	b=EnZ22c3Xua2aLeaItMQcYK3J8llkf/y8PhA+PoxUQrhw/AKpumyZwKhfSUrn3Dc5JzXc
	 UIuCU3wwAJol8eOdYX6i0Vzw8cQ0LVJ4wt4FETVunwVEafHs0eD+hTHBj/IgcxaDi1VGk
	 dGKjptOQxSC2c1XiRr6roXuD6BH5bS5WE+pehZSA5W7hDgAWlvq8YcdxbLbbuVoz6P8lf
	 ZHzBiYASsQNMeeKca6Wctgk/G9tnRE5y/rqpSPv/dEAJscAi9DrIjgET666rbOvkYS0AE
	 2CHsrPad6TwYbx4EAuzEGVGentblijExxYmlP9ETf+CMGj/0LRMYAxrGcZ/XZ03z/lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RVU7pDRI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B20606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 19:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RVU7pDRI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90E31F00A05;
	Wed, 11 Nov 2026 19:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794426572;
	bh=Oc6ejAXbOWvHTL82rIpVWqGj664xm50y5XMfyuasBD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RVU7pDRIZmN7g1hdECpmXx4OGKYHOvrSRSUO4Hu3SLEPh2QLP42T8rVFVp2QYsywV
	 Vg2eIimGlCSH0JfwpisHUOfo+EWbUZm0Pwy25O476tSsGB6KheserOKE1Rfnd7tDpV
	 KwF64w3DawSWmGuf33fAUobEL+Ed02rZcurGiZS5X4U1wOqLMmaErtaahFZIbx2oak
	 pxq+NnxmAueaMR2msNuNZx3WRbFSi5nXojxokNxKYn3eOGySB5XMNFq1xV5GBeZljA
	 HntG0VowicFMWri+orrxZI+Bq8oBTC6HoJyWeTA13Qydzwxr0fd6YuI6uLF6AQoj5d
	 avszLxfswRGig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rik van Riel <riel@surriel.com>,
	Michal Hocko <mhocko@suse.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/memcontrol: fix stuck FLUSHING_CACHED_CHARGE bit on isolated cpus
Date: Wed, 11 Nov 2026 14:49:30 -0500
Message-ID: <20261111194854.4009938-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051931-failed-6.12-d2f28a1a652e@kernel.org>
References: <20261107051931-failed-6.12-d2f28a1a652e@kernel.org>
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

From: Rik van Riel <riel@surriel.com>

[ Upstream commit d2f28a1a652e0a43f6f63de9b4e4d8d5f2716803 ]

When drain_all_stock() sets FLUSHING_CACHED_CHARGE before checking
isolation, schedule_drain_work() can drop the work in a separate RCU
critical section, and housekeeping_update()'s synchronize_rcu() can race
that second check, leaving the flag set.

drain_local_stock() only clears the bit for work that ran, so the flag
remains set and the stock is never drained again.

Have schedule_drain_work() return whether the work was queued, and clear
FLUSHING_CACHED_CHARGE in drain_all_stock() when the remote CPU is
isolated, so future drains can retry.

Link: https://lore.kernel.org/20260828135036.7d44361f@fangorn
Fixes: 6a792697a53a ("memcg: do not drain charge pcp caches on remote isolated cpus")
Suggested-by: Michal Hocko <mhocko@suse.com>
Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: <stable@vger.kernel.org>
[ sashal: Adapted schedule_drain_work() result handling to an inline branch in drain_all_stock() for the combined charge cache. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memcontrol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4d1caa4faf69f..e5a4ec28f4955 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1871,6 +1871,8 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
 				drain_local_stock(&stock->work);
 			else if (!cpu_is_isolated(cpu))
 				schedule_work_on(cpu, &stock->work);
+			else
+				clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
 		}
 	}
 	migrate_enable();
-- 
2.53.0

