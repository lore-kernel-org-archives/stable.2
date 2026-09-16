Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28E73C5540;
	Wed, 16 Sep 2026 17:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789579431; cv=none; b=nrERR5jJH9geisnmv/ZTHUP8H5dJkoxDA0XrFM2wv8+tQJrEJqgi7281ZUInpi8Scgt9ASNIoWOilYd/KZFt3CQ0aG+1LjHRvxJ6/lbLF7BskSEkHnLSQ6OAYP3IdJc5m8yOzKFlxEqaA9qqNXRxc/aUKS60enxnlrHkPWyNjvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789579431; c=relaxed/simple;
	bh=i/9Nz5U0exD65WjNlUWRI5iAClBZ5byKB6pnI1UoGUk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WFrw1LW0HQ4CXbOhzfYAom5lQfwDUHwC9wWESGGbz6rbabvq5sdAR8Mj69AtoaAwKPxn20Mzi/m6/OyVwy62lDbGVdI95ZGeTUZM6LirEoA+C0bOa9s/Jbh5tnOvwVZVZ/3yw2xwoRfATKiPiaRpDiWceiHAU4Ne7G3pjfdtB4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACnETyc0KpqD4xuCA--.45751S2;
	Thu, 17 Sep 2026 01:23:40 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: chris@chris-wilson.co.uk,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	rodrigo.vivi@intel.com,
	simona@ffwll.ch,
	tursulin@ursulin.net,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/gt: Fix ce use-after-free in signal_irq_work()
Date: Wed, 16 Sep 2026 17:23:12 +0000
Message-Id: <20260916172312.2087555-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnETyc0KpqD4xuCA--.45751S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF4fGF13Jr1rurWktrW5Wrg_yoW8Zry5pr
	43JFyayrZ5XFsxuan8C3W0vF1aga4xtF18Wan5Gw1xAwn0q3Z5J34Sya4jyFyY9r4kXr1Y
	qrWqqa4xGF4UZr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9q14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
	WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
	xVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JF
	I_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F
	4UJbIYCTnIWIevJa73UjIFyTuYvjfU5byZUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgUMA2qqok9p+gADsx

The final intel_context_put() may drop the last reference to a signaler
context. GuC parallel child contexts are freed immediately by
__guc_context_destroy() rather than via call_rcu(), so reading
ce->signal_link.next to advance the RCU iterator afterwards is a
use-after-free. Cache the next context before the loop body instead.

Fixes: c744d50363b7 ("drm/i915/gt: Split the breadcrumb spinlock between global and contexts")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/i915/gt/intel_breadcrumbs.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
index c10ac0ab3bfa..f840e98792cd 100644
--- a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
+++ b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
@@ -174,7 +174,7 @@ static void signal_irq_work(struct irq_work *work)
 	struct intel_breadcrumbs *b = container_of(work, typeof(*b), irq_work);
 	const ktime_t timestamp = ktime_get();
 	struct llist_node *signal, *sn;
-	struct intel_context *ce;
+	struct intel_context *ce, *cn;
 
 	signal = NULL;
 	if (unlikely(!llist_empty(&b->signaled_requests)))
@@ -210,9 +210,19 @@ static void signal_irq_work(struct irq_work *work)
 
 	rcu_read_lock();
 	atomic_inc(&b->signaler_active);
-	list_for_each_entry_rcu(ce, &b->signalers, signal_link) {
+	for (ce = list_first_or_null_rcu(&b->signalers, typeof(*ce), signal_link);
+	     ce;
+	     ce = cn) {
 		struct i915_request *rq;
 
+		/*
+		 * Grab the next signaler up front, as dropping the final
+		 * reference below may free the current one before we
+		 * advance the iterator.
+		 */
+		cn = list_next_or_null_rcu(&b->signalers, &ce->signal_link,
+					   typeof(*cn), signal_link);
+
 		list_for_each_entry_rcu(rq, &ce->signals, signal_link) {
 			bool release;
 
-- 
2.34.1

