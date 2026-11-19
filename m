Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.241
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795067149;
	b=ax4Z2YprXjeZJeXyzUjMrY3ESH1Kqht5Utf2cZioT+0Fhm60MkAmtiDpKo6VjXbR95DK
	 HQy55YBjRMs8w7RYcIzNXIeokXutFrItZeleADg61aeYYF4/r2HJEXsj57U0ZVrMgNANI
	 wPx/AwfVmV09WqLuNJVZMeG9fhwN7R256YfhSV9UwVSUVuBkuzMP5mru0W8jl5y7HGu8B
	 XkSM1zTKfse7DjAKxUFNa3PtrmdtbeGO5Y5jxBK7ZH3HUWzIlG6KOONl1EM/X6QAjszKU
	 tL+iJnEKdKPpa2/oEP8jlur4OlWcpxiM5FghJ2reySq579HKblx0EFH+DYj8OoAR/1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795067149;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=u7b8dqCM7GZ/vOl3/UCLJZVLgWwemwNrrc/Owmz3wdo=;
	b=RMYvavnEfGTYt6CMu115ebWGNx6xGYGYoYfdnHNf/0hrGlcIVrsB78w1TzlwujCwuKqT
	 papiiuJKk93pFv8Mq2jLhpbvu3BfccO36DxfafACZGfwq3X5jCYsWZokNgztBHm3F3fec
	 J1DRaxM+dUXcekPXjsLH76pZ1D0x+BaeHs4mxX0DWxZNY70Zi5eAMHiaEZt7CxR2PJC1S
	 7e05x1h5h5O4f1PUQH5+q302mA+6v3LtAwIYbNVcHr6O8qmn6OkoUJY9h6y4KECon+BI8
	 ZmVU10c7WGjRCxfppT55Ur8YwUvwnDMo+0NMFhE7nCcgMANJJ7Fh8lUwGKr6WAjewDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="WcNaqrT/";
	arc=none smtp.remote-ip=95.215.58.241
Received: from mta1.migadu.com (out-241.mta1.migadu.com [95.215.58.241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62D2606A335
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 05:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B62D2606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WcNaqrT/
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=sYq/ACkmGYZN7x+02+N05uhDgHOkpTdesVa83wIaO+4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795067146; v=1; x=1795671946;
 b=WcNaqrT/Hv7zyP9uwgTiYlnCr6qNL2JdcrL552tg2TpkSgF/aqlUGH2D6deXEceAkrOrq6pn
 tFRyEpTXeBSdoD5z0bmrd7A06mSa3PVlL3iPinLziz4fN9o/luK+Hrm4Y/zB/idITolPXFW0txA
 zWfD6/w+Eve355TAEBXcnarY=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a6d9900c927f0b46;
	Thu, 19 Nov 2026 05:45:46 +0000
X-Mizu-Trace-ID: a6d9900c927f0b46
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Date: Thu, 19 Nov 2026 00:45:33 -0500
Subject: [PATCH v2 2/3] dm thin: keep a thin on active_thins until its last
 reference is dropped
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-bug-dm-thin-rcu-gp-v2-2-055d627763c3@linux.dev>
References: <20261119-bug-dm-thin-rcu-gp-v2-0-055d627763c3@linux.dev>
In-Reply-To: <20261119-bug-dm-thin-rcu-gp-v2-0-055d627763c3@linux.dev>
To: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, 
 Benjamin Marzinski <bmarzins@redhat.com>
Cc: dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <qiliang.yuan@linux.dev>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

get_first_thin() and get_next_thin() let the pool worker process the
thins on pool->active_thins without holding rcu_read_lock() while it
does: they take a reference on a thin under the lock, and
get_next_thin() continues from that thin in a new read-side section.
thin_dtr() takes the thin off the list, waits for a grace period and
then for the references still held.

Once thin_dtr() has removed a thin that the worker holds, nothing
updates its list.next pointer any more. If the thin after it is removed
and freed before the worker calls get_next_thin(), the walk continues
from freed memory.

Leave a thin on the list until its last reference is dropped and unlink
it then, under the pool lock, so that removing its neighbours keeps its
list.next valid. Have thin_dtr() mark the thin dead, so that no new
walker takes a reference, and make the walkers skip dead thins and the
ones whose last reference is already gone. thin_dtr() waits for the
grace period after the thin is unlinked, before freeing it.

With a test-only 3 s msleep() added to the worker after each thin it
processes, thins 1 and 2 of a pool with three thins are suspended and
then removed while the worker holds thin 1. Trials in which KASAN reports
a slab-use-after-free in get_next_thin():

                       before (trials)   after (trials)   change
  KASAN report                  3 of 3           0 of 5     -100%

Fixes: b10ebd34cccae ("dm thin: fix rcu_read_lock being held in code that can sleep")
Cc: stable@vger.kernel.org
Reported-by: Benjamin Marzinski <bmarzins@redhat.com>
Closes: https://lore.kernel.org/r/avz7qDWd2g-uubmL@redhat.com
Suggested-by: Benjamin Marzinski <bmarzins@redhat.com>
Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
---
 drivers/md/dm-thin.c | 51 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index bdd250d1eb2e1..f79f5982ae36c 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -356,10 +356,12 @@ struct thin_c {
 
 	/*
 	 * Ensures the thin is not destroyed until the worker has finished
-	 * iterating the active_thins list.
+	 * iterating the active_thins list.  Set dead once thin_dtr() starts,
+	 * so that no new walker picks the thin up.
 	 */
 	refcount_t refcount;
 	struct completion can_destroy;
+	bool dead;
 };
 
 /*----------------------------------------------------------------*/
@@ -2318,25 +2320,28 @@ static void process_thin_deferred_cells(struct thin_c *tc)
 	} while (!list_empty(&cells));
 }
 
-static void thin_get(struct thin_c *tc);
+static bool thin_tryget(struct thin_c *tc);
 static void thin_put(struct thin_c *tc);
 
 /*
  * We can't hold rcu_read_lock() around code that can block.  So we
  * find a thin with the rcu lock held; bump a refcount; then drop
- * the lock.
+ * the lock.  Skip the thins that thin_dtr() is destroying.
  */
 static struct thin_c *get_first_thin(struct pool *pool)
 {
-	struct thin_c *tc = NULL;
+	struct thin_c *tc;
 
 	rcu_read_lock();
-	tc = list_first_or_null_rcu(&pool->active_thins, struct thin_c, list);
-	if (tc)
-		thin_get(tc);
+	list_for_each_entry_rcu(tc, &pool->active_thins, list) {
+		if (thin_tryget(tc)) {
+			rcu_read_unlock();
+			return tc;
+		}
+	}
 	rcu_read_unlock();
 
-	return tc;
+	return NULL;
 }
 
 static struct thin_c *get_next_thin(struct pool *pool, struct thin_c *tc)
@@ -2345,7 +2350,8 @@ static struct thin_c *get_next_thin(struct pool *pool, struct thin_c *tc)
 
 	rcu_read_lock();
 	list_for_each_entry_continue_rcu(tc, &pool->active_thins, list) {
-		thin_get(tc);
+		if (!thin_tryget(tc))
+			continue;
 		thin_put(old_tc);
 		rcu_read_unlock();
 		return tc;
@@ -4131,28 +4137,37 @@ static struct target_type pool_target = {
  * Thin target methods
  *--------------------------------------------------------------
  */
-static void thin_get(struct thin_c *tc)
+static bool thin_tryget(struct thin_c *tc)
 {
-	refcount_inc(&tc->refcount);
+	return !READ_ONCE(tc->dead) && refcount_inc_not_zero(&tc->refcount);
 }
 
 static void thin_put(struct thin_c *tc)
 {
-	if (refcount_dec_and_test(&tc->refcount))
-		complete(&tc->can_destroy);
+	unsigned long flags;
+
+	if (!refcount_dec_and_test(&tc->refcount))
+		return;
+
+	/*
+	 * Unlink tc only once nobody holds it: a worker holding it continues
+	 * its walk from tc->list.next.
+	 */
+	spin_lock_irqsave(&tc->pool->lock, flags);
+	list_del_rcu(&tc->list);
+	spin_unlock_irqrestore(&tc->pool->lock, flags);
+	complete(&tc->can_destroy);
 }
 
 static void thin_dtr(struct dm_target *ti)
 {
 	struct thin_c *tc = ti->private;
 
-	spin_lock_irq(&tc->pool->lock);
-	list_del_rcu(&tc->list);
-	spin_unlock_irq(&tc->pool->lock);
-	synchronize_rcu();
-
+	WRITE_ONCE(tc->dead, true);
 	thin_put(tc);
 	wait_for_completion(&tc->can_destroy);
+	/* Let RCU readers of active_thins finish with tc */
+	synchronize_rcu();
 
 	mutex_lock(&dm_thin_pool_table.mutex);
 

-- 
2.43.0

