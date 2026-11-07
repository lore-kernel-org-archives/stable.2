Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046774;
	b=MADVidtJn5ilQ1Ec1OwOUoXb4aflMgB7T7rtKdYUN391vl+HEKKcm2sE4RAjax8lnV1/
	 j9hX+XLV2xdAncxLOklR1zvWhEo7X6RuI1IS+dzSpOoXBhKuvyN2OH3811HiBzJrgHsEe
	 Yf7DExeEgPppyX56jJWGC9JedITvilt5BolWrG/ZCqa+u4Xl3Q+6Wj92JYQwRaJKSkEs+
	 OuPk3JOaPqe3MhB5mK0WrTZh38LApHx2YI15CfEiIOHHe9dHB298m5oSgMTXVXRfXLUXy
	 HVvojQtM1El9xia+PYQOwAF1wdapMRAE44jiEjpUO5KFP7WqRjp3OfXzitNLwtqOnvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046774;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=izzoHrihS+18biOU++fg/N6YdNh2x0gC+MHhDQ/9vPg=;
	b=wvpawIaVBuxqWlZETaN9xJGIz66+h9r+VnpLhz5QjW9AzTPCk1o6zLnSMjhczHGcVOR/
	 twDsSZcLjXJOtdMYCSA2SQm9BLF94bUP26PxR6kOMbPMo+wJzH9Kafhw36KlN899/QqZ0
	 z1Toe9ZR0Vf3R9OyL1sGN0FxzmgnDUzzdbhZt0ucl2B+f6L/DURD8/p694vzrhb39gGjN
	 0Ff2ATVM/GBbuW0+KKf0h9Utz0Bo+AsX5bpdghwq/qMSSimKBtnr+lPiOnb1onagSTydS
	 97eTZxgrl9EZRLz6IAG3N15uYeNGD87FMDvv0iMhpCF2/VIFPW0p45fZQ/g/P/qsPGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k2B34HUq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEACC606EEAE
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k2B34HUq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725601F0089F;
	Sat,  7 Nov 2026 10:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046773;
	bh=izzoHrihS+18biOU++fg/N6YdNh2x0gC+MHhDQ/9vPg=;
	h=From:To:Cc:Subject:Date;
	b=k2B34HUq/r0nZYRZERiOHhToNj92V2o6N8FLRcsr+zruu36o1UpLBczTeybmX1w7a
	 j3unE53PgeG7VvChQjuzsG5lRgDVXwXvUm9L9tNNy69qXX+r+etUuok71dhaOSI85C
	 8ui6tdi0HT6Oz5TXp7oqtHo9PxEZuuPkwVJ2fMF4rGlIAOz5U+7s+iW2VD31IKcWiD
	 jcSZ+hO/yhhrsLR8pwr1yQhVmv7aXHcIQlLCMa/S52r9eM2aFb/QJPm4KihQ8zORuD
	 +/tWLZm+jcRWVeI8X9o/7PpXsmaG0+aGvA3brb+Xmu6uim7vIvDcL3pR/Ar/CKzlva
	 vhvuJEE1tBDLA==
From: Sasha Levin <sashal@kernel.org>
To: riel@surriel.com,
	mhocko@suse.com,
	shakeel.butt@linux.dev,
	akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/memcontrol: fix stuck FLUSHING_CACHED_CHARGE bit on isolated cpus" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:19:31 -0500
Message-ID: <20261107051931-failed-6.12-d2f28a1a652e@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x d2f28a1a652e0a43f6f63de9b4e4d8d5f2716803
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051931-failed-6.12-d2f28a1a652e@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d2f28a1a652e0a43f6f63de9b4e4d8d5f2716803 Mon Sep 17 00:00:00 2001
From: Rik van Riel <riel@surriel.com>
Date: Fri, 28 Aug 2026 13:50:36 -0400
Subject: [PATCH] mm/memcontrol: fix stuck FLUSHING_CACHED_CHARGE bit on
 isolated cpus

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
---
 mm/memcontrol.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1709ac96bbdec..c6b85e3a5a0b3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2306,7 +2306,7 @@ static bool is_memcg_drain_needed(struct memcg_stock_pcp *stock,
 	return flush;
 }
 
-static void schedule_drain_work(int cpu, struct work_struct *work)
+static bool schedule_drain_work(int cpu, struct work_struct *work)
 {
 	/*
 	 * Protect housekeeping cpumask read and work enqueue together
@@ -2315,8 +2315,11 @@ static void schedule_drain_work(int cpu, struct work_struct *work)
 	 * pending work on newly isolated CPUs.
 	 */
 	guard(rcu)();
-	if (!cpu_is_isolated(cpu))
-		queue_work_on(cpu, memcg_wq, work);
+	if (cpu_is_isolated(cpu))
+		return false;
+
+	queue_work_on(cpu, memcg_wq, work);
+	return true;
 }
 
 /*
@@ -2348,8 +2351,9 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
 				      &memcg_st->flags)) {
 			if (cpu == curcpu)
 				drain_local_memcg_stock(&memcg_st->work);
-			else
-				schedule_drain_work(cpu, &memcg_st->work);
+			else if (!schedule_drain_work(cpu, &memcg_st->work))
+				clear_bit(FLUSHING_CACHED_CHARGE,
+					  &memcg_st->flags);
 		}
 
 		if (!test_bit(FLUSHING_CACHED_CHARGE, &obj_st->flags) &&
@@ -2358,8 +2362,9 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
 				      &obj_st->flags)) {
 			if (cpu == curcpu)
 				drain_local_obj_stock(&obj_st->work);
-			else
-				schedule_drain_work(cpu, &obj_st->work);
+			else if (!schedule_drain_work(cpu, &obj_st->work))
+				clear_bit(FLUSHING_CACHED_CHARGE,
+					  &obj_st->flags);
 		}
 	}
 	migrate_enable();
-- 
2.53.0




