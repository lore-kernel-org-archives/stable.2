Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795581151;
	b=VDpLLPDcN6pvkZ96psvI4Q7NQqro0vRfFFHF1+uVvgV7uAFfnUiR/sEe2C4m6xJ96Q9D
	 vuhLFcW24cVTgQep+sGkV6jTbj/RzW3NGKtzKnNX+UJIccOlVJhEsfZMmFgkXmUEBiU01
	 2tcRAuu14tSMKDO4j+L6IKGv12Qh0EW5mf06FVgXWM7onJO0SsrXZaCVVfUivANpoOVtD
	 wIHsa2r/XKJEoNvYxKQ0NYPXIbYQnOhVidcs9QtTRiFM7Ij9IhyCn3AqaF9xA3XEzROJn
	 bcvEW7qPKZ2ghFb33iuok93ncd7nq8YuZ6nbXKDnw+D87ef1mvfIpYRQztZSB+/gYTw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795581151;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7xv7NqRPboZD8n16IYobKNVKDgaIUvKlpeGZVo5xpek=;
	b=ALlJUpuLsFAwUiEXmXgwsEMXULqCDM63ICcsN/O7yuk6BmXcjmTssiLUhPhL10Cx1RuS
	 lXr1X2ll7fAOK1Tiihe7Ivmib8fGNXVClSorx8FWrtTR0Yt7WuZWRu691YIN1f75sTOg0
	 1Wa/cnPJm63Pb+7biLLhBSHC+zHAvbJIZ2O7LxYTXXCf1mHimY3kxbLrvfhKRPEkzno+q
	 OTK+IIgvkCIl53wuGKRtDHo/CfgT8fy7YO5kC8tAuCrEjiq4DgScSSBpNGJbqXug2WK1W
	 e6cWGkxDl+iw7VK1u4ITC6IOrrAQ2N35EP11dn730D6WDeiOCa/C7OZnw0vCHz1O0SQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jYILALBk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45101606A334;
	Wed, 25 Nov 2026 04:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jYILALBk
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795581149;
	b=hmcqr5LB+2LhCy8rDA4reEgZmoCWIJ8vjLKBVzqrzW0DLQmkdYuQJyFWvphxioYGHWW9
	 Cyp5R8zPSCKVzUCUh2pUXFVmBmCwmh4R/rzFV8moNFpOP/rHUuEfRdx3SGXXW82dqGzcA
	 8tLaYwm7Owdu06UiGWRg3+m2vyx64VWmfwfMmsTYMUksdi/yRQefBlTtS2OZEdDAfh8TO
	 FCd33FrvcPpusV24m2AIDBUUUMkZhV3RQCOZ2dZwq7eu8usZNTlDFIkv3cQnWyQE4c29i
	 WhUyW9xL/2vqBLqFN6wOpycKd95xBqd+e3CgM9ZPgcZlh0wJJ//g6c9MYsLQhifWJLA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795581149;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7xv7NqRPboZD8n16IYobKNVKDgaIUvKlpeGZVo5xpek=;
	b=cT9mUDxYvWxpwOKL4IMOT/yEnw/t7M/GgR49qD5Ub/vRt5OiLyzhgz/MvtlnwTn8HlPM
	 zBgl151PBv6rW7ChvrBivm1ECpNBcSwPzIQfk/du6EsQUBgasSbIIwDFCw09SmDDxNxW7
	 OgMqu09afqcraG3v8qnLyLmlGZtyx57kHNIEHW/vrZm0NttoGO55kjdwpZ63n5wazoY0N
	 9H+8P+0DopqS7QuZgj6AGqLMr3VABeBE4PeDoGoDFI/4SIKcQ9lrbihEBeZ8BL6H222c8
	 1zkoYyOLdqllQ1cMSKwT+NIh67Fy/6/gKmtq35XT2s04J/gyG4yvjAlKfM7Q0zrPf/g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 07D081F000D0;
	Wed, 25 Nov 2026 04:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795581149;
	bh=7xv7NqRPboZD8n16IYobKNVKDgaIUvKlpeGZVo5xpek=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=jYILALBkmVyPpqeIaCvXloKfkSZxc04kYD1KU81hG9hdFleABl5Jv2mXccnFtV+bD
	 xdwbHeXZJty0881h+Tp6LBagqM4eIB/PVGcTR52sZ32vkytNnduebxANBVxHa0hGhK
	 pVuyuUdJA5e+xCRwTnL98FgqpyjqEP8I9UR1xuOI1j/0qnXTzv9O3B3X/cHE3piA5J
	 gh+Nt2ZTZIdyTT8elNA+o6q7177FTMDw5cepUFkQVfB1xxuFaoY2HjjIhIMn98njlr
	 otBGBQu/O5CLP0jmedwufMMTBdEw8N/1zgOvrnxuBZGB/OVVFc8QA96EXmbco2z5Tb
	 DZgaipeufNbUQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8E2A94CCDA;
	Wed, 25 Nov 2026 04:32:23 +0000 (UTC)
From: Bingfang Guo via B4 Relay <devnull+bingfangguo.tencent.com@kernel.org>
Date: Wed, 25 Nov 2026 04:32:19 +0000
Subject: [PATCH v2] mm/mglru: skip oom killing for order != 0 allocs in
 kswapd
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261125-fix-mglru-kswapd-age-v2-1-4cc37437af9b@tencent.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ6CMBBFr0Jm7RhaEcSV9zAsShmgKi1pC2pI7
 27BuHMxi5e8+W8BR1aRg3OygKVZOWV0BL5LQPZCd4SqiQw85TmLh6164dA97IR39xRjgyI65el
 QpjnLZJHlEF9HS9HbZq/Vl91U30j6dWs1euW8se+tO7PV+yWK/4mZIcOatW1DMhN05BdPWpL2e
 2kGqEIIH9I7E4fMAAAA
X-Change-ID: 20261026-fix-mglru-kswapd-age-98390614c746
To: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>, 
 Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Yu Zhao <yuzhao@google.com>, 
 Bingfang Guo <bfguo@icloud.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Bingfang Guo <bingfangguo@tencent.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795581142; l=2716;
 i=bingfangguo@tencent.com; s=20260905; h=from:subject:message-id;
 bh=qV2l1gYt5Q96N5XOUnCBfwyMyXQq9VOKcjW+/oh4RQU=;
 b=S50EhNmVKqI1zc8Itdg9ig9CLE0dcM5ia7nxqwpj/tzGTLAG6/LlpCYTP4xUP/YJbJAfurPnW
 JIZfOZMkqW5BSmD9w/7MpCOjXskbmcPqC3VT2QBmY65mCiJkaw3fCeU
X-Developer-Key: i=bingfangguo@tencent.com; a=ed25519;
 pk=7YoBtD5pTW/XZHfmJ9x+FaHVq1TstMOvF31LTY3F+0w=
X-Endpoint-Received: by B4 Relay for bingfangguo@tencent.com/20260905 with
 auth_id=1006
X-Original-From: Bingfang Guo <bingfangguo@tencent.com>
Reply-To: bingfangguo@tencent.com
Content-Transfer-Encoding: 7bit

From: Bingfang Guo <bingfangguo@tencent.com>

We observed that when MGLRU min_ttl is set and the system is highly
fragmented, high order allocations (e.g. order == 9) will fail and wake
up kswapd. It can not make any progress, while pushing generations of
memcgs so that they all end up younger than min_ttl_ms, repeatedly
triggering the OOM killer in lru_gen_age_node(). Then the whole process
repeats until all processes are killed and the kernel panics.

The purpose of the min_ttl is to prevent thrashing when all memcgs are
too young to reclaim instead of preventing fragmentation. So fix this by
restoring the behavior in commit 30d77b7eef019 ("mm/mglru: fix
ineffective protection calculation"), which skips OOM killer invocations
in lru_gen_age_node() for sc->order != 0.

Fixes: 30d77b7eef019 ("mm/mglru: fix ineffective protection calculation")
Signed-off-by: Bingfang Guo <bingfangguo@tencent.com>
---
==== Testing ====

Tested on a VM with 6 cores and 6GiB of memory, HZ=1000, MGLRU enabled,
min_ttl_ms set to 1000, and a workload that fragments the memory then
allocates 2M pages.

Without the patch, kswapd kills all processes and panics the system even
with plenty of memory available. With the patch, allocations fail but
the system remains stable.

--
Changes in v2:
- Reword the comments to explain the purpose clearly. (Kairui)
- Relax the skip condition to sc->order != 0 for soundness. (sashiko)
- Rebase to mm-unstable.
- Cc stable.
- Link to v1: https://lore.kernel.org/all/20261027-fix-mglru-kswapd-age-v1-1-b1ffdec4ae52@tencent.com/
---
 mm/vmscan.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 836f50814ffa..9fadc6f9da49 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4351,7 +4351,7 @@ static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
 {
 	struct mem_cgroup *memcg;
 	unsigned long min_ttl = READ_ONCE(lru_gen_min_ttl);
-	bool reclaimable = !min_ttl;
+	bool reclaimable = !min_ttl || sc->order;
 
 	VM_WARN_ON_ONCE(!current_is_kswapd());
 
@@ -4371,6 +4371,9 @@ static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
 	 * The main goal is to OOM kill if every generation from all memcgs is
 	 * younger than min_ttl. However, another possibility is all memcgs are
 	 * either too small or below min.
+	 *
+	 * OOM killing for fragmentation is not desired. So skip this when
+	 * sc->order != 0.
 	 */
 	if (!reclaimable && mutex_trylock(&oom_lock)) {
 		struct oom_control oc = {

---
base-commit: a3d0117e02bfa1c3bb6c50e7afe42bbecdbb3459
change-id: 20261026-fix-mglru-kswapd-age-98390614c746

Best regards,
-- 
Bingfang Guo <bingfangguo@tencent.com>


