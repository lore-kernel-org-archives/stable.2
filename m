Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.67
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794902680;
	b=YIHMTO+CS2PfF0mtvN4D0cX3nvXJn1zUkv4QT4UkyaZqmXWFJa1tTPPJqAx/mkSjx5EO
	 Bss+FBk1yKEka1YTXbKcN5QPmpnrA4vLd/5smGVglvHByzG03BrqmwuJdgLPhbABWnQn1
	 imYqI4MUGkM3XMkPKWf5ajYjE+oM77L3i0KhdEyTYAiBLJxG9CjTB01s7KcDp6eamIGz4
	 +ofmLtIBomIUqYJBvQkis3/FaTIdrhwv7L34SADTd3sGUJNnkoBB1CoikOm1QOrvoXfks
	 gro/zyeZeBuW0x7mcPGHw8z56hZQc7T/JlIPQjy1WX5I0PApctlryQpdK4BUYGopwHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794902680;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vXF8oVQRnsv2ot54KZJo/sivs9IEK1CA2mVPqtmHEpE=;
	b=rrmJB3EQWjfCA7IrAY11WMFl0e7RQ/McblMg0LWtEPKSBeoNhSpJpYEyrwMSHBBOWZhf
	 5lNTEmb1Ba3TzbrcINZVQ3JroZQsq7ETETHjbWYfYAPUtlyLikt2Zac5UjRY6mJqy3bRY
	 uEruuiIs2lZMxR4YN7JVuiIYUFDNeWfNpoAssey58fJN4ynEff6Suby/xbasCn6hisckc
	 oTmEi+vcY2HxqbAVdgE9bWkNkrMJynrYDEz3/oKtSio1j6L4Rm18wvZ2NeZoN1TbqHPrZ
	 p7X/AGKYaXJnRzcoatxKnUuWA+QYTZqgwNDzexFjPSHCBTIc8qB/7HGN5dTuiLYXxmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lmfEcNYC;
	arc=none smtp.remote-ip=95.215.58.67
Received: from mta1.migadu.com (out-67.mta1.migadu.com [95.215.58.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6597606A897
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 08:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6597606A897
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lmfEcNYC
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=tUoF/AF9aJL8T6z27kbc5MffrFYSSF3reZSFJQMzMtw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794902676; v=1; x=1795507476;
 b=lmfEcNYCbZTd26bIDYO2TnJG/JHdK/UTeHJrWAv9/mpX1ujBe5n7AnpNLBSFWpfwlxbfNEEG
 7kDhevuwHoZoActQctm33DJVN2Mc6zlE5trLRzPWrxBI2lDcsYQBgCNxb+uTcsfj7uLTWLyPWh+
 qwfku+otFb//lzvlhCA9ua5U=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9847e282a775229b;
	Tue, 17 Nov 2026 08:04:36 +0000
X-Mizu-Trace-ID: 9847e282a775229b
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
Subject: [PATCH 2/2] mm: memcg: fix memory.high throttle lost to u64 overflow
Date: Tue, 17 Nov 2026 16:04:21 +0800
Message-ID: <f1cfcbc31ade9851c3c09db6bfd190682a130245.1794902513.git.zhuhui@kylinos.cn>
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

calculate_high_delay() squares max_overage and scales it by HZ in u64.
max_overage is the ratio ((usage - high) << 20) / high, and memory.high has
no lower bound, so the product wraps once a cgroup is about 130x over its
limit (at HZ=1000). The wrapped value is arbitrary and can be exactly zero:
with memory.high set to one page and usage at 2049 pages, one page past the
8M mark, max_overage is 2^31, the product wraps to zero and the penalty
comes out 0 jiffies instead of the 2 seconds the formula calls for. The
caller then takes its "penalty_jiffies <= HZ / 100" exit, skipping both the
throttle and the reclaim retry loop.

Clamp the overage to MEMCG_MAX_DELAY_OVERAGE before squaring it. The bound
keeps the product within u64 for any supported HZ, and by then the delay
has long saturated at MEMCG_MAX_HIGH_DELAY_JIFFIES, so no penalty is
shortened.

Fixes: 0e4b01df8659 ("mm, memcg: throttle allocators when failing reclaim over memory.high")
Cc: stable@vger.kernel.org
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 mm/memcontrol.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1ba42724ed1e..aeec1bbabb26 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2521,6 +2521,15 @@ static void high_irq_work_func(struct irq_work *work)
  #define MEMCG_DELAY_PRECISION_SHIFT 20
  #define MEMCG_DELAY_SCALING_SHIFT 14
 
+/*
+ * Cap for the overage passed to calculate_high_delay(). Squaring a larger
+ * overage and scaling it by HZ overflows u64, and the wrapped product may
+ * come out zero, skipping the throttle entirely. At the cap the square
+ * still fits in u64 for any HZ, and the delay has long saturated at
+ * MEMCG_MAX_HIGH_DELAY_JIFFIES, so clamping never shortens it.
+ */
+#define MEMCG_MAX_DELAY_OVERAGE (1ULL << 26)
+
 static u64 calculate_overage(unsigned long usage, unsigned long high)
 {
 	u64 overage;
@@ -2581,6 +2590,8 @@ static unsigned long calculate_high_delay(unsigned int nr_pages,
 	if (!max_overage)
 		return 0;
 
+	max_overage = min_t(u64, max_overage, MEMCG_MAX_DELAY_OVERAGE);
+
 	/*
 	 * We use overage compared to memory.high to calculate the number of
 	 * jiffies to sleep (penalty_jiffies). Ideally this value should be
-- 
2.53.0

