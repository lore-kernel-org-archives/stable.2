Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7C82868AB
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 13:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785074400; cv=none; b=hPz3M4GXe7E58X7XT9QDBpqMP0APnXAcXXRl40s0TykNKuCIhW+FJ2ic/yfG8Fd49jItiUlB9ybB6kd2AFOtkgwCLfvMiAeD+RLTt1XpGfgNavXgwUies9S+Y9ms8HG0Bfc0CdYUyTP0/UuShPkjgUCQjX27laD8qmvl0OhyfQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785074400; c=relaxed/simple;
	bh=rc9POOYrJKPXnRDJa3hqtq3XClaNiDie4wjILd7U/Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZK12Jw/aSMjcW7yEwZ2LLYHUcUNPQgPT9Uv8FrwlNwhKd0sXyoKmB5HPpF8BD0kWhsqqXvlhhLH+zbsPGRiFVnW9pWQA5+md+fjpuOGUeHRa6DIY1o2HQzpsqagG+QxCa82zsoJJQCG/iPKQnWExFEy+NXMIcWcQ9UNsMsSjwcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FapMr/qf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FapMr/qf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995B81F00A3A;
	Sun, 26 Jul 2026 13:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785074399;
	bh=jg/doISKdH9b+uvjJBkTZzqCT5LurKMO32TZayfE8yw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FapMr/qfygRTsT3/1iAx7EYA64JAOydwkFcK8e18fCx7kJfXfz9qVbkX7arSxujiC
	 MzawWeVWqnWaHy68TrJOp4SuTmsDfUfjWZ7plrehGuyqsfKw9Cf0TL4bynbwAgOwMM
	 fxtZLe9JkxAts5sauU9T50gj95Jp7wHmwnNUqI0eAUZVKJ4Dpw7begB1MdivcJrKXB
	 XBD1yI2NxQZh+EEFQ4Fv9Wxn5KSLmvR0jDyT/vkZy5DnSei/O2I2b+87YeBxX6aobz
	 dPJsmwxX6ZUY/P44iJDCk2sz8/ZvAuc41BVMPjbRg030K03stL4yH4wQ4n7N5nP+1X
	 hKNp7anCQjHEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/7] thunderbolt: Remove usage of the deprecated ida_simple_xx() API
Date: Sun, 26 Jul 2026 09:59:50 -0400
Message-ID: <20260726135955.668115-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726135955.668115-1-sashal@kernel.org>
References: <2026072000-womb-upturned-7ecf@gregkh>
 <20260726135955.668115-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit dec6a613574cd3dea799170b7aaa8fd76e22f176 ]

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

Note that the upper limit of ida_simple_get() is exclusive, but the one of
ida_alloc_range()/ida_alloc_max() is inclusive. So a -1 has been added
when needed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Stable-dep-of: 2c5d2d3c3f70 ("thunderbolt: Prevent XDomain delayed work use-after-free on disconnect")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thunderbolt/domain.c  | 6 +++---
 drivers/thunderbolt/nhi.c     | 6 +++---
 drivers/thunderbolt/nvm.c     | 4 ++--
 drivers/thunderbolt/switch.c  | 6 +++---
 drivers/thunderbolt/xdomain.c | 4 ++--
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index 73be797acd5092..42ba960831e20a 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -321,7 +321,7 @@ static void tb_domain_release(struct device *dev)
 
 	tb_ctl_free(tb->ctl);
 	destroy_workqueue(tb->wq);
-	ida_simple_remove(&tb_domain_ida, tb->index);
+	ida_free(&tb_domain_ida, tb->index);
 	mutex_destroy(&tb->lock);
 	kfree(tb);
 }
@@ -389,7 +389,7 @@ struct tb *tb_domain_alloc(struct tb_nhi *nhi, int timeout_msec, size_t privsize
 	tb->nhi = nhi;
 	mutex_init(&tb->lock);
 
-	tb->index = ida_simple_get(&tb_domain_ida, 0, 0, GFP_KERNEL);
+	tb->index = ida_alloc(&tb_domain_ida, GFP_KERNEL);
 	if (tb->index < 0)
 		goto err_free;
 
@@ -413,7 +413,7 @@ struct tb *tb_domain_alloc(struct tb_nhi *nhi, int timeout_msec, size_t privsize
 err_destroy_wq:
 	destroy_workqueue(tb->wq);
 err_remove_ida:
-	ida_simple_remove(&tb_domain_ida, tb->index);
+	ida_free(&tb_domain_ida, tb->index);
 err_free:
 	kfree(tb);
 
diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 3c879a0d92f94a..61558a6bd7d161 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -465,7 +465,7 @@ static int ring_request_msix(struct tb_ring *ring, bool no_suspend)
 	if (!nhi->pdev->msix_enabled)
 		return 0;
 
-	ret = ida_simple_get(&nhi->msix_ida, 0, MSIX_MAX_VECS, GFP_KERNEL);
+	ret = ida_alloc_max(&nhi->msix_ida, MSIX_MAX_VECS - 1, GFP_KERNEL);
 	if (ret < 0)
 		return ret;
 
@@ -485,7 +485,7 @@ static int ring_request_msix(struct tb_ring *ring, bool no_suspend)
 	return 0;
 
 err_ida_remove:
-	ida_simple_remove(&nhi->msix_ida, ring->vector);
+	ida_free(&nhi->msix_ida, ring->vector);
 
 	return ret;
 }
@@ -496,7 +496,7 @@ static void ring_release_msix(struct tb_ring *ring)
 		return;
 
 	free_irq(ring->irq, ring);
-	ida_simple_remove(&ring->nhi->msix_ida, ring->vector);
+	ida_free(&ring->nhi->msix_ida, ring->vector);
 	ring->vector = 0;
 	ring->irq = 0;
 }
diff --git a/drivers/thunderbolt/nvm.c b/drivers/thunderbolt/nvm.c
index 69fb3b0fa34fa3..8901db2de327cd 100644
--- a/drivers/thunderbolt/nvm.c
+++ b/drivers/thunderbolt/nvm.c
@@ -330,7 +330,7 @@ struct tb_nvm *tb_nvm_alloc(struct device *dev)
 	if (!nvm)
 		return ERR_PTR(-ENOMEM);
 
-	ret = ida_simple_get(&nvm_ida, 0, 0, GFP_KERNEL);
+	ret = ida_alloc(&nvm_ida, GFP_KERNEL);
 	if (ret < 0) {
 		kfree(nvm);
 		return ERR_PTR(ret);
@@ -528,7 +528,7 @@ void tb_nvm_free(struct tb_nvm *nvm)
 		nvmem_unregister(nvm->non_active);
 		nvmem_unregister(nvm->active);
 		vfree(nvm->buf);
-		ida_simple_remove(&nvm_ida, nvm->id);
+		ida_free(&nvm_ida, nvm->id);
 	}
 	kfree(nvm);
 }
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index df83383800a8ef..29c9b969228db4 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -777,7 +777,7 @@ static int tb_port_alloc_hopid(struct tb_port *port, bool in, int min_hopid,
 	if (max_hopid < 0 || max_hopid > port_max_hopid)
 		max_hopid = port_max_hopid;
 
-	return ida_simple_get(ida, min_hopid, max_hopid + 1, GFP_KERNEL);
+	return ida_alloc_range(ida, min_hopid, max_hopid, GFP_KERNEL);
 }
 
 /**
@@ -815,7 +815,7 @@ int tb_port_alloc_out_hopid(struct tb_port *port, int min_hopid, int max_hopid)
  */
 void tb_port_release_in_hopid(struct tb_port *port, int hopid)
 {
-	ida_simple_remove(&port->in_hopids, hopid);
+	ida_free(&port->in_hopids, hopid);
 }
 
 /**
@@ -825,7 +825,7 @@ void tb_port_release_in_hopid(struct tb_port *port, int hopid)
  */
 void tb_port_release_out_hopid(struct tb_port *port, int hopid)
 {
-	ida_simple_remove(&port->out_hopids, hopid);
+	ida_free(&port->out_hopids, hopid);
 }
 
 static inline bool tb_switch_is_reachable(const struct tb_switch *parent,
diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index 8a40584024c4fe..3df7d0c937c9e6 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -1005,7 +1005,7 @@ static void tb_service_release(struct device *dev)
 	struct tb_xdomain *xd = tb_service_parent(svc);
 
 	tb_service_debugfs_remove(svc);
-	ida_simple_remove(&xd->service_ids, svc->id);
+	ida_free(&xd->service_ids, svc->id);
 	kfree(svc->key);
 	kfree(svc);
 }
@@ -1107,7 +1107,7 @@ static void enumerate_services(struct tb_xdomain *xd)
 			break;
 		}
 
-		id = ida_simple_get(&xd->service_ids, 0, 0, GFP_KERNEL);
+		id = ida_alloc(&xd->service_ids, GFP_KERNEL);
 		if (id < 0) {
 			kfree(svc->key);
 			kfree(svc);
-- 
2.53.0

