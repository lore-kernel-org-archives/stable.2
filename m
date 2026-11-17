Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.244
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794902677;
	b=V/KbtJD/5+uhuTtO8THfbWa1U0WzWeHNg9qLWqYFMHmGz04/H2g4pEpryreL+PbWOzhU
	 jA7qJ2wODg22p+coRllXsfhCu4c4RBAar6qJ5TUD2C+xvBaedmyUBOlunyWcW7NfF828O
	 jukhXIz0x/led1MgKV7he1Hp+YMVG2eb/VV8FgTgxtTkUAfev1yMKZ2XhcQzB4h4cPToh
	 IXWLF3OY3OXsbXvhzbkO+MhULSr0ZXlVFglsQghkAARTrSZPRoxF3LKHLJRuQ+nUtNlqF
	 kT4pGzZMlOMpInnY+VyDQlaLV47MIngZF1jtuJHJe/gBv3a4lXZHkzU62j0aYhHkI7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794902677;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BjhDYtdm4/pQJcy2Nq6/VwI3066PPOd59IcuMnYXHok=;
	b=CMjlqH33eSgKZ7OhhFDNM4U32MHLLb9zYyK+ZDOwNgMCr/0ZenQKSjBnU9nSKJJ7acha
	 rAAilot+TAxdwjGNhJ3L6IvkIHMwarCgiBXmFEL8HnB84GOfEiLY8L9h6hAXnKFLHK6L9
	 l22tOjWX/ksdwAqj8A1MJWTqVLwQQZklYNkUXylmlZmX7EGb8L+sD9dJm4DcqikQz9pgI
	 c7V/vgo8SZkXxryD+bM6kgWGaseW6KqfcLDd/lGhvym2uHzUBqVn/aHDXn1upFo8l5SAD
	 C747kiwcf0uAfGbskS5WoxZarpu7bz9COhcDmjNWuAHKxTBsiehbIqUp0iTe25wEcEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HAnxMb7g;
	arc=none smtp.remote-ip=91.218.175.244
Received: from mta0.migadu.com (out-244.mta0.migadu.com [91.218.175.244])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBFC606A88A
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 08:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDBFC606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HAnxMb7g
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=tIZd3eeHeKEfMcEKXFH5YHQpdMOXGI0H+yUu5ZTMA9E=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794902673; v=1; x=1795507473;
 b=HAnxMb7gG7n9/CDjQ2lgY4jNGhnGQXAorlcDp5JPO6iaUb9qklCz+7BqgpGX+FxkiHXxFqST
 gXjVDMVvWS69YleOfAhqee/ffXnz+wCPpDD88l8t2CSyfcSLFyRms3J+70k8tYrLaWzjyEpmWZ6
 iWBTkicnQMvY2ejUk7QyH+8w=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 86acde6d42413ff3;
	Tue, 17 Nov 2026 08:04:32 +0000
X-Mizu-Trace-ID: 86acde6d42413ff3
X-Migadu-Flow: FLOW_OUT
From: "Hui Zhu" <hui.zhu@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Down <chris@chrisdown.name>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] mm: memcg: fix zero throttle delay on 32-bit kernels
Date: Tue, 17 Nov 2026 16:04:20 +0800
Message-ID: <6931674296b98139f5e02821d66ad1855eba36c9.1794902513.git.zhuhui@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794902513.git.zhuhui@kylinos.cn>
References: <cover.1794902513.git.zhuhui@kylinos.cn>
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

From: Hui Zhu <zhuhui@kylinos.cn>

calculate_high_delay() stores max_overage * max_overage * HZ, computed as
u64, into an unsigned long before shifting it right by 34 bits in total.
On 32-bit kernels the store truncates the value first, so the shift always
yields zero. Tasks over memory.high or memory.swap.high are then never
throttled, and the reclaim retry loop in __mem_cgroup_handle_over_high()
is skipped as well.

Keep the intermediate in u64 so the shifts see the full width, and clamp
to MEMCG_MAX_HIGH_DELAY_JIFFIES before narrowing to the unsigned long
return value: a truncated result would escape the caller's own min().
Nothing changes on 64-bit kernels, where clamping each term is equivalent
to clamping their sum, which the caller already does.

Fixes: e26733e0d0ec ("mm, memcg: throttle allocators based on ancestral memory.high")
Cc: stable@vger.kernel.org

Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 mm/memcontrol.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 84f4a8fd4d16..1ba42724ed1e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2576,7 +2576,7 @@ static u64 swap_find_max_overage(struct mem_cgroup *memcg)
 static unsigned long calculate_high_delay(unsigned int nr_pages,
 					  u64 max_overage)
 {
-	unsigned long penalty_jiffies;
+	u64 penalty_jiffies;
 
 	if (!max_overage)
 		return 0;
@@ -2601,7 +2601,13 @@ static unsigned long calculate_high_delay(unsigned int nr_pages,
 	 * MEMCG_CHARGE_BATCH pages is nominal, so work out how much smaller or
 	 * larger the current charge patch is than that.
 	 */
-	return penalty_jiffies * nr_pages / MEMCG_CHARGE_BATCH;
+	penalty_jiffies = penalty_jiffies * nr_pages / MEMCG_CHARGE_BATCH;
+
+	/*
+	 * Clamp before narrowing to unsigned long: a truncated return value
+	 * would escape the caller's min() and look like a small delay.
+	 */
+	return min_t(u64, penalty_jiffies, MEMCG_MAX_HIGH_DELAY_JIFFIES);
 }
 
 /*
-- 
2.53.0

