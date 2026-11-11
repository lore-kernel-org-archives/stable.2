Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425821;
	b=Xowki91PFEr/TjlZ/AgU/GLwszcs3TP0UjOBlyeApGnGVQu+TawIovk5HdbNT2K/PQjV
	 bPhByztBsjXpGK6dyeSttafMRZtCM8A2MTheSTDqlASxrbHByP6ug4n0b72Wf6jSG8Lv9
	 0Br4lYlmX9hVGj7oAYzWarzYa0W396bgqGgY6arF1ZIRL4BgR0gb3KajFSRX+SP/N7UFr
	 8kgS1lJRwCUcObRDjIvPwYniTFx6uzRPpxHcrFVvbMXMRhHYZSELdMtgPfq58zK1V8PEm
	 MiAoJekkSRj6lBDQNN4NxbpWPD7r6PyloWIE7VyAmNl+a2xIY++TbfEGGkW/iuDTGJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425821;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ynkqpfoo89FiGhZpNVW9b/28/m2NWXyJwBRmujZItCE=;
	b=dGhCozSpr9CIC6L4MGeUFicye5qcv3aduQ/AEYK/loA/AfivJFY1t4sylW2SUh6Ak19N
	 epjlA+URvp1uHvNZA9EvfIrx0L9gMsxJjRxZdhaBYTZ4ulJts99hIpXIHKleoNWQsXO7B
	 rTlvx0rte5U02YQaXZTQtt5Rjpg9gWefVVPIHL25DpTiEn/16uil/ZtQTOUahpZKI0+pd
	 MJ7pAsckCtA2FcZHrHN7ZUqqNNaQh6c//5HDvc+apZz3+MG+sV16h9he7Tduiz9OtIane
	 4Jix9guEqIMpq28gbR9pUm2a7rezMdCB/242bFzLz3rsdFFGuiGpMXvRrgWLR6Rf2zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFFQFB0q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F6B606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 19:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFFQFB0q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6EDE1F00A05;
	Wed, 11 Nov 2026 19:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794425820;
	bh=ynkqpfoo89FiGhZpNVW9b/28/m2NWXyJwBRmujZItCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SFFQFB0qzqKX1kqIrau/Hv2mRbuvHVNf/NXUfjEOxKietJzb7z5gHybCtX6BnpRXk
	 jgUner7oZifrDWhZh4/HjGq1zUNN+OiNiSZ2sT0GStENeDJ+Mo3IF0bWX/75y40zE8
	 NJnlL3rcvnXWnE1/muJOYUsSRDRtJkHUaSWgXJDfNVI9SlGi3VqlJ7Q6UBb1ldI4SC
	 WGneaErL6n+jA94K2p6QlS4bhcvCoTGtLr5HQTN/TiP5pZUN6QV5ACmjQXH4O2+NeF
	 VD6pj35SsNr1Of9hALvypx3dHAi1BCIoRQP4iih94fFfOTgsfI6SHPevIZajsF3KeE
	 TXq3Aay1YrLqQ==
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
Subject: [PATCH 6.18.y] mm/memcontrol: fix stuck FLUSHING_CACHED_CHARGE bit on isolated cpus
Date: Wed, 11 Nov 2026 14:36:58 -0500
Message-ID: <20261111193638.3989262-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050841-failed-6.18-d2f28a1a652e@kernel.org>
References: <20261107050841-failed-6.18-d2f28a1a652e@kernel.org>
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
[ sashal: Adapted the schedule_drain_work() changes to the direct isolation checks in drain_all_stock() because the helper is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memcontrol.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 97ed5ad4053f0..60b4885dcd118 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2005,6 +2005,9 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
 				drain_local_memcg_stock(&memcg_st->work);
 			else if (!cpu_is_isolated(cpu))
 				schedule_work_on(cpu, &memcg_st->work);
+			else
+				clear_bit(FLUSHING_CACHED_CHARGE,
+					  &memcg_st->flags);
 		}
 
 		if (!test_bit(FLUSHING_CACHED_CHARGE, &obj_st->flags) &&
@@ -2015,6 +2018,9 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
 				drain_local_obj_stock(&obj_st->work);
 			else if (!cpu_is_isolated(cpu))
 				schedule_work_on(cpu, &obj_st->work);
+			else
+				clear_bit(FLUSHING_CACHED_CHARGE,
+					  &obj_st->flags);
 		}
 	}
 	migrate_enable();
-- 
2.53.0

