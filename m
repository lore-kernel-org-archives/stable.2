Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8192F3B47C4
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166878; cv=none; b=hF7hEeEFwPf+gX9nDfo+DU+mBnU3T9ZcyqlfyceQthL+mWZuc+db9lMlODr3Eewj26NW8O/RSHssTnTzYd0gcP0pRsqs5nPkPRpUdOe6eSqPqc/9d+WQDSUcg4+4Zd4o7cPHbfibGir9VRhvkYhtCcsCi2nCdQTu4mWUjrLxneY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166878; c=relaxed/simple;
	bh=sAhWawEsEFQOxC+y2Ptezfmt0/RcokJ1h1aJubJNv8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gN1tasoBBa0pTSyOSCjQWIuVQkzzZVmVdMZ/DiRSVxyXKPo6mZeGoSW/pDKVfVyQHOtMuHqrx7mNvYxl13B1qSOxYs1jArZ0IA6RrI+C2vnkCdQFFfuXxCH09KYejowLH3gh9po3hI3WA7yipN1j01morkNGZ+jsvLWRM470Usk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkhAuxOm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkhAuxOm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CEC1F000E9;
	Mon, 27 Jul 2026 15:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785166877;
	bh=77uWoljunC1bp9yDZhYYhgf/wXMv4dMPOnjnQGdNs8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HkhAuxOmV3ehKwM3D407Cl+hpbh4TfPKvcWMRm+CGcmU68fSAsj+NTJ4BL0lffB/G
	 NP9HP+t/bGUURANiHsfj/PK6ApOsftFwt/X4gVWubHcxQBz/TcMuTqnFCKL2osIAYw
	 37YQQ4CJ6/8a+/+b0iFddksOVZN3l4bsyUtERVhQUzQwJzj8spjr/hOHL1mAtn1qE2
	 rovWpMO0ILPEZDqqy5j/wJcRuTpxCUQMkhHNJlBe8XHNnseLk3sRkXLE1Uh3Wu9183
	 /sKLIM+tjqAFQmV6VWk3cu+XmyOyD8ICAGNJ6etIUVkZfbxuj6WX1UKrlR3qmyuc+5
	 GKncc2TDA4AcQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/6] thunderbolt: Remove usage of the deprecated ida_simple_xx() API
Date: Mon, 27 Jul 2026 11:41:10 -0400
Message-ID: <20260727154115.1516559-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072001-numeric-suffice-a245@gregkh>
References: <2026072001-numeric-suffice-a245@gregkh>
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
index 1ec8892f875f44..5d7099b3b0c60b 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -329,7 +329,7 @@ static void tb_domain_release(struct device *dev)
 
 	tb_ctl_free(tb->ctl);
 	destroy_workqueue(tb->wq);
-	ida_simple_remove(&tb_domain_ida, tb->index);
+	ida_free(&tb_domain_ida, tb->index);
 	mutex_destroy(&tb->lock);
 	kfree(tb);
 }
@@ -397,7 +397,7 @@ struct tb *tb_domain_alloc(struct tb_nhi *nhi, int timeout_msec, size_t privsize
 	tb->nhi = nhi;
 	mutex_init(&tb->lock);
 
-	tb->index = ida_simple_get(&tb_domain_ida, 0, 0, GFP_KERNEL);
+	tb->index = ida_alloc(&tb_domain_ida, GFP_KERNEL);
 	if (tb->index < 0)
 		goto err_free;
 
@@ -421,7 +421,7 @@ struct tb *tb_domain_alloc(struct tb_nhi *nhi, int timeout_msec, size_t privsize
 err_destroy_wq:
 	destroy_workqueue(tb->wq);
 err_remove_ida:
-	ida_simple_remove(&tb_domain_ida, tb->index);
+	ida_free(&tb_domain_ida, tb->index);
 err_free:
 	kfree(tb);
 
diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 85efec989ac573..2f68128e89ecdb 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -458,7 +458,7 @@ static int ring_request_msix(struct tb_ring *ring, bool no_suspend)
 	if (!nhi->pdev->msix_enabled)
 		return 0;
 
-	ret = ida_simple_get(&nhi->msix_ida, 0, MSIX_MAX_VECS, GFP_KERNEL);
+	ret = ida_alloc_max(&nhi->msix_ida, MSIX_MAX_VECS - 1, GFP_KERNEL);
 	if (ret < 0)
 		return ret;
 
@@ -478,7 +478,7 @@ static int ring_request_msix(struct tb_ring *ring, bool no_suspend)
 	return 0;
 
 err_ida_remove:
-	ida_simple_remove(&nhi->msix_ida, ring->vector);
+	ida_free(&nhi->msix_ida, ring->vector);
 
 	return ret;
 }
@@ -489,7 +489,7 @@ static void ring_release_msix(struct tb_ring *ring)
 		return;
 
 	free_irq(ring->irq, ring);
-	ida_simple_remove(&ring->nhi->msix_ida, ring->vector);
+	ida_free(&ring->nhi->msix_ida, ring->vector);
 	ring->vector = 0;
 	ring->irq = 0;
 }
diff --git a/drivers/thunderbolt/nvm.c b/drivers/thunderbolt/nvm.c
index 3a5336913ccac1..b0fce68f5a0ef9 100644
--- a/drivers/thunderbolt/nvm.c
+++ b/drivers/thunderbolt/nvm.c
@@ -30,7 +30,7 @@ struct tb_nvm *tb_nvm_alloc(struct device *dev)
 	if (!nvm)
 		return ERR_PTR(-ENOMEM);
 
-	ret = ida_simple_get(&nvm_ida, 0, 0, GFP_KERNEL);
+	ret = ida_alloc(&nvm_ida, GFP_KERNEL);
 	if (ret < 0) {
 		kfree(nvm);
 		return ERR_PTR(ret);
@@ -159,7 +159,7 @@ void tb_nvm_free(struct tb_nvm *nvm)
 		if (nvm->active)
 			nvmem_unregister(nvm->active);
 		vfree(nvm->buf);
-		ida_simple_remove(&nvm_ida, nvm->id);
+		ida_free(&nvm_ida, nvm->id);
 	}
 	kfree(nvm);
 }
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 17e330c97a0f77..e3446d784e8e75 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -806,7 +806,7 @@ static int tb_port_alloc_hopid(struct tb_port *port, bool in, int min_hopid,
 	if (max_hopid < 0 || max_hopid > port_max_hopid)
 		max_hopid = port_max_hopid;
 
-	return ida_simple_get(ida, min_hopid, max_hopid + 1, GFP_KERNEL);
+	return ida_alloc_range(ida, min_hopid, max_hopid, GFP_KERNEL);
 }
 
 /**
@@ -844,7 +844,7 @@ int tb_port_alloc_out_hopid(struct tb_port *port, int min_hopid, int max_hopid)
  */
 void tb_port_release_in_hopid(struct tb_port *port, int hopid)
 {
-	ida_simple_remove(&port->in_hopids, hopid);
+	ida_free(&port->in_hopids, hopid);
 }
 
 /**
@@ -854,7 +854,7 @@ void tb_port_release_in_hopid(struct tb_port *port, int hopid)
  */
 void tb_port_release_out_hopid(struct tb_port *port, int hopid)
 {
-	ida_simple_remove(&port->out_hopids, hopid);
+	ida_free(&port->out_hopids, hopid);
 }
 
 static inline bool tb_switch_is_reachable(const struct tb_switch *parent,
diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index df5e40c6876c48..6d178e70e2b1dd 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -808,7 +808,7 @@ static void tb_service_release(struct device *dev)
 	struct tb_xdomain *xd = tb_service_parent(svc);
 
 	tb_service_debugfs_remove(svc);
-	ida_simple_remove(&xd->service_ids, svc->id);
+	ida_free(&xd->service_ids, svc->id);
 	kfree(svc->key);
 	kfree(svc);
 }
@@ -910,7 +910,7 @@ static void enumerate_services(struct tb_xdomain *xd)
 			break;
 		}
 
-		id = ida_simple_get(&xd->service_ids, 0, 0, GFP_KERNEL);
+		id = ida_alloc(&xd->service_ids, GFP_KERNEL);
 		if (id < 0) {
 			kfree(svc->key);
 			kfree(svc);
-- 
2.53.0

