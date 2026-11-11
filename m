Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426993;
	b=TRXDGd84ZtrjQzfltf1c3HCuZZT+HWRvXwerkCNzMIKhK5SFuHFaefMwUlJ5UvZ1S3pj
	 l4nlZDl5Xht+M28kNvJYk+RdOs0xRxqDC5VHhlepYEG2yA4G2l2q/KYHjN3EIbixPG7+L
	 VL34HnE6MU7lYRcgpr52KZ7gAc/buE2LIA8iNTGHdGXFDbvfh2TPcQ0UvY4wvFbP75sNn
	 b4uAxlF56IMDDZGNTtg2HUtxIxHZeSxHhHnAlK4sVPwsSklC7JuhVUZEnGpfl7Q14rlrb
	 tm4A4XgKyVJXdfiqc83SLy6EYKSKTmuZqNR1r8fIpN5xfeK++Co2SLkSxj/Hzt73IHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426993;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yjWrPc+ppfsKBYDCt8Z9w/1rLGeHPWTkfaCA8ci4MQ0=;
	b=0nB28u8G6USXjG3fjEbyE8oVeJkcLn76S8IdTf+pfgz3TPVTp1ewfTNhBDMQERGYRPAx
	 LWq+0O06/8+tPf+IcVn6pjRUPZfHrReCEc7Z78rs92hI+zq3DiB4TB+5oRoyFksLRp3sH
	 R9Gjv155V8nzRhSAGuOSE6lq+iOZKYcP5ld8BeTn4rYLYiFkdBiAsS5w0c/zqz3zHk/ZA
	 Mbcbqm2rIJ1Ho+A3Mqnid4sqqsW1UuSMGi6awW8BEtmjd8LAv1iF4bFs+HFbanGCW539B
	 ESNKXJX1PgYSCStACLUR1cQgQFhGOhww6v6FfClBJv6Bz61T9WqxT5CmXmUNSvTi/YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gb9Tvmnz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F87606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 19:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gb9Tvmnz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A691F00A07;
	Wed, 11 Nov 2026 19:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794426993;
	bh=yjWrPc+ppfsKBYDCt8Z9w/1rLGeHPWTkfaCA8ci4MQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gb9Tvmnzprz4iRLtdlm2oKB1Hm7aN+C3JTf5xQPOHvI4KTtv8NQMLsiMUbnr+BeA+
	 xctKIQEZ27PE2+xka19PqKxja3FeWwhel6IkBewVo4TxujROSJ9CS5X1zH2V5JwlYY
	 w2mTDNEOe5t6T+hdAW4wnPjRksZRngQOC/Pvs+/vZhgn78tj6BClj44Na8EqPbnGGO
	 DuPmxKc4cuv6cxarea8WLbMU/gZdgdDv00rcWuLxpJ2xay0nOIar4kITGvRNZE6Nuv
	 17NJR6gFCi91p1cYRsucQN7LmAaUwUQEphOLE+GmafylzKf8cIh0tsTZTyj8hnjw10
	 nY8hKvEijfuZQ==
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
Subject: [PATCH 6.6.y] mm/memcontrol: fix stuck FLUSHING_CACHED_CHARGE bit on isolated cpus
Date: Wed, 11 Nov 2026 14:56:31 -0500
Message-ID: <20261111195600.4028594-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053203-failed-6.6-d2f28a1a652e@kernel.org>
References: <20261107053203-failed-6.6-d2f28a1a652e@kernel.org>
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
[ sashal: adapted schedule_drain_work() return handling to a direct flag clear in the existing single-stock isolation branch ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memcontrol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 852fa93efe1be..d31ceaeb13b05 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2396,6 +2396,8 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
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

