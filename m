Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047585;
	b=N5abjLFlblU4T4rcz2mfJ8pqZwXblTo50HlI7zJHVCdGUHLeh2OzLHyBog0gf2rswNEI
	 3TzZZuKpXfetXXhZtjxJq3twBhPOcRSN3NGCyF9fOL6zlf6m7/OX36xjGDFIXeNDj5IR5
	 VxJOkK5ykhOp94iOfrj9i9jVDFwOJKWdhnh3AE5d/dKSprGB54XgTRoUskOO/aXHMmBu5
	 KhdJdpzU/AsyCRaU4aZOX5ctC8tZfXPaheAVQKSWY7oX69Z+CoB9OZwt5J7fa2v6l7xlJ
	 ibDR0jlVUWssZacXfQ645StG2mL3Wd9tWpdtlxcxBmmbFd1D8X6lc67/3VLJXbAJj8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047585;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=S9QGnDfxQYI0WWEKhVv7nwRiWvEDuxPdjGEI/1T7Lww=;
	b=iad/PKmyQITI4D2ITd1O93wN08bABvXOdMQypEWJI29qdxt3xZy/CEwp1qVD16BSDj9/
	 ixcEGWc5agAl4m7v1i+y7fSUYjQmarz4XrxyTMFjCP/GSzJe1GU22rn7m4Q8gL8d4lOh1
	 /uwn7vbE+GP5YNcbsfR65E99fstbgDTed+LZTjp953M7AlPb1ejxvUIDt9OOgsaqDxI6T
	 rSVIEXVL0P860h9u+Yb921f6/u7E3TF7S1k78Tq6by6BSBdh1ctTkfmOt0dbpHZsfG7bf
	 k1k/i0/dVGmLnA6a0aIzrwdluChsC6BOnufYBwNa9xWec3E6CQ4+YZQ7qpyMvCmJO3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RGECl/cl";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B896B606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RGECl/cl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33EC1F0089F;
	Sat,  7 Nov 2026 10:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047584;
	bh=S9QGnDfxQYI0WWEKhVv7nwRiWvEDuxPdjGEI/1T7Lww=;
	h=From:To:Cc:Subject:Date;
	b=RGECl/clTVlkgDiuJ0Z9vbOHm/w7zezmKhEoxZ875fwDIdjHnj9uNwZXwV2kSJaOF
	 FK/UMtsx+2kx4m1Yt2/rac6jh9psEqSBqVsZ58A/JMOQBz9DapGUXh2JQNQFew3//U
	 T6ULzkkBESyucjE7fA0pE9yTRx6F0qlRzc3VpQjz0Bivlq0SD7hz4QoFd8DuwOz6IO
	 bDTFL8YjNzcrwMtTLydCFM8fnfwY1DN8skSAlYxvnRcdVAQcJ5mkhCWco0HbJvtwru
	 dms7BFWmgpnbRxh+YkLiX9zJejUIOwJQJcwshvzD2yMsVWHpbANZsjseBkiXY/9Nzm
	 reOYWp9rgp4yw==
From: Sasha Levin <sashal@kernel.org>
To: chenridong@xiaomi.com,
	baohua@kernel.org,
	hannes@cmpxchg.org,
	akpm@linux-foundation.org,
	axelrasmussen@google.com,
	chris@chrisdown.name,
	david@kernel.org,
	kasong@tencent.com,
	ljs@kernel.org,
	mhocko@kernel.org,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	tj@kernel.org,
	weixugc@google.com,
	yuanchu@google.com,
	yuzhao@google.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/page_counter: avoid integer overflow in effective_protection()" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:33:01 -0500
Message-ID: <20261107053301-failed-6.6-7809ce47b056@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 7809ce47b05671e1fa6d74bead892d6ad6c1403b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053301-failed-6.6-7809ce47b056@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 7809ce47b05671e1fa6d74bead892d6ad6c1403b Mon Sep 17 00:00:00 2001
From: Ridong Chen <chenridong@xiaomi.com>
Date: Mon, 7 Sep 2026 10:54:44 +0800
Subject: [PATCH] mm/page_counter: avoid integer overflow in
 effective_protection()

Patch series "mm/mglru: fix ineffective memory protection for non-kswapd
reclaim", v4.

For MGLRU, memory.min/low is not honored during non-kswapd global reclaim
(global direct reclaim and root-level memory.reclaim), because these paths
shrink memcgs using stale protection (emin/elow).

Patch 2 is the actual fix.  Patch 1 is a prerequisite: an integer overflow
in effective_protection(), spotted by the sashiko review tool, which patch
2's new caller would also be exposed to.


This patch (of 2):

effective_protection() scales a parent's protection by a ratio of page
counts, e.g.  for recursive protection:

	(parent_effective - siblings_protected) * (usage - protected)
		/ (parent_usage - siblings_protected)

The multiply is done at unsigned long width before dividing.  On systems
with >= 16TB RAM the product can exceed 2^64 and wrap, giving a bogus
protection value and silently breaking memory.min/low enforcement.

Use mul_u64_u64_div_u64() to multiply in a 128-bit intermediate.  Because
usage and parent_usage are not read atomically (a child is charged before
its parent), usage - protected can briefly exceed the divisor, making the
quotient overflow 64 bits and trap (#DE on x86).  Cap it so the ratio
stays <= 1.

Reported by the sashiko review tool [1].

Link: https://lore.kernel.org/20260907025445.1836238-1-ridong.chen@linux.dev
Link: https://lore.kernel.org/20260907025445.1836238-2-ridong.chen@linux.dev
Link: https://sashiko.dev/#/patchset/20260826133054.88529-1-ridong.chen@linux.dev?part=1 [1]
Fixes: bc50bcc6e00b ("mm: memcontrol: clean up and document effective low/min calculations")
Fixes: 8a931f801340 ("mm: memcontrol: recursive memory.low protection")
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Assisted-by: Claude:claude-opus-4-8
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Chris Down <chris@chrisdown.name>
Cc: David Hildenbrand <david@kernel.org>
Cc: Kairui Song <kasong@tencent.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Tejun Heo <tj@kernel.org>
Cc: Wei Xu <weixugc@google.com>
Cc: Yuanchu Xie <yuanchu@google.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: <stable@vger.kernel.org>
---
 mm/page_counter.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/mm/page_counter.c b/mm/page_counter.c
index 450543f4b318b..98322803941a7 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -8,6 +8,7 @@
 #include <linux/page_counter.h>
 #include <linux/atomic.h>
 #include <linux/kernel.h>
+#include <linux/math64.h>
 #include <linux/string.h>
 #include <linux/sched.h>
 #include <linux/bug.h>
@@ -376,7 +377,8 @@ static unsigned long effective_protection(unsigned long usage,
 	 * otherwise get a smaller chunk than what they claimed.
 	 */
 	if (siblings_protected > parent_effective)
-		return protected * parent_effective / siblings_protected;
+		return mul_u64_u64_div_u64(protected, parent_effective,
+					   siblings_protected);
 
 	/*
 	 * Ok, utilized protection of all children is within what the
@@ -417,13 +419,20 @@ static unsigned long effective_protection(unsigned long usage,
 	if (parent_effective > siblings_protected &&
 	    parent_usage > siblings_protected &&
 	    usage > protected) {
-		unsigned long unclaimed;
+		unsigned long parent_unclaimed, parent_unprotected, unprotected;
 
-		unclaimed = parent_effective - siblings_protected;
-		unclaimed *= usage - protected;
-		unclaimed /= parent_usage - siblings_protected;
+		parent_unclaimed = parent_effective - siblings_protected;
+		parent_unprotected = parent_usage - siblings_protected;
 
-		ep += unclaimed;
+		/*
+		 * The usages aren't read atomically, so a child can transiently
+		 * appear to use more than its parent, making the ratio exceed 1
+		 * and the quotient overflow 64 bits (#DE on x86).  Cap it.
+		 */
+		unprotected = min(usage - protected, parent_unprotected);
+
+		ep += mul_u64_u64_div_u64(parent_unclaimed, unprotected,
+					  parent_unprotected);
 	}
 
 	return ep;
-- 
2.53.0




