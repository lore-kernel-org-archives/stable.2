Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A773FF885;
	Wed,  5 Aug 2026 09:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.215.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922842; cv=none; b=pC4wNfpMKqNuh0V3D4Q58v6zB0BM1iIMf5UT0cF2laVdob0qGLwYk6mhp9lnjNSssFBNyTtuiOGEF+RggxZKbsq3TtwOmZCbR1l6YVc8rq8RXnesoA1evJ9eIZqTiWjmvL3FaDoShaI7jVE0TYY8YdtMgVS1jdR7e9MPaGk9HYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922842; c=relaxed/simple;
	bh=0112Chw3jbokaV4W4IlIg7iYZ3kgKd4owSOC8Ci1t+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h2ZpVFVtSlxrGpRvE3VGXE3SRPqyGtyXNPXgA2TDBpbJnlg2yDqVsJ37bRk9sdwVS4uVspxGr51zIDsbNC7QHSqRL/QGhJSFeSu3adujAvjwmgkKVZG8l69VY3Q2x9v9FDWGELt1qv2ULWFGku//XR/wEkUA9iKzwqn4jFahWx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xenproject.org; spf=pass smtp.mailfrom=xenproject.org; dkim=pass (1024-bit key) header.d=xenproject.org header.i=@xenproject.org header.b=Rz/Fywb9; arc=none smtp.client-ip=104.130.215.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xenproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenproject.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xenproject.org header.i=@xenproject.org header.b="Rz/Fywb9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=xenproject.org; s=20200302mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From;
	bh=jqWNmZY06DVMjdGxIRpnMRf2z1reaDJOSpTrbBkvv8c=; b=Rz/Fywb9AY5sDD9He27t1Qc5k2
	RRLgVyzgKt6l6h3C7jNH0drpNd+kl0uZZKYtPt3ybteq3VJImA/JPSCDOwYFsKpWvwIvFmKquewtp
	ud3QY0S6HTbjv2yVc3EgHFTnekJymgHrZpge7sFIVCqzIjlfT0KP6S7FcjlRKbpMe30Y=;
Received: from xenbits.xenproject.org ([104.239.192.120])
	by mail.xenproject.org with esmtp (Exim 4.96)
	(envelope-from <roger@xenproject.org>)
	id 1wrY72-006IBs-32;
	Wed, 05 Aug 2026 09:40:36 +0000
Received: from 224.pool85-54-217.dynamic.orange.es ([85.54.217.224] helo=localhost)
	by xenbits.xenproject.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <roger@xenproject.org>)
	id 1wrY72-00FGrj-18;
	Wed, 05 Aug 2026 09:40:36 +0000
From: Roger Pau Monne <roger@xenproject.org>
To: Juergen Gross <jgross@suse.com>,
	Roger Pau Monne <roger.pau@citrix.com>,
	xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org
Cc: Roger Pau Monne <roger@xenproject.org>,
	stable@vger.kernel.org,
	Yannick Martin <yannick.martin@okazoo.eu>,
	"Thorsten Leemhuis" <regressions@leemhuis.info>,
	Matthias Goergens <matthias.goergens@gmail.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: [PATCH v2] x86/xen: fix init of balloon stats again
Date: Wed,  5 Aug 2026 11:40:07 +0200
Message-ID: <20260805094008.95778-1-roger@xenproject.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The handling of extra memory regions done in balloon_add_regions() is not
correct for PV guests, since the initial target is set to reflect the real
memory the system has, not what's described on the memory map, which can be
higher if memory != maxmem.

Introduce separate logic for addition vs subtraction in
balloon_add_regions() and handle extra regions correctly by adding them to
the total amount of pages, instead of subtracting from the current and
target pages amounts.

In the common case PV domU/dom0 and PVH dom0 will use the addition path,
since the initial target reflects the real assigned memory.  HVM and PVH
domUs use the subtraction path, since the target is set based on the amount
of memory reported in the memory map, without accounting for released
regions.

Fixes: 87af633689ce ("x86/xen: fix balloon target initialization for PVH dom0")
Fixes: 0949c646d646 ("Partial revert "x86/xen: fix balloon target initialization for PVH dom0"")
Signed-off-by: Roger Pau Monné <roger@xenproject.org>
Cc: stable@vger.kernel.org
---
Cc: Yannick Martin <yannick.martin@okazoo.eu>
Cc: "Thorsten Leemhuis" <regressions@leemhuis.info>
Cc: Matthias Goergens <matthias.goergens@gmail.com>
---
Changes since v1:
 - Also fix PVH dom0 without unpopulated pages support.
 - Account for XENMEM_current_reservation possibly failing.
---
 drivers/xen/balloon.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index e7f1d4ca6d75..e7f74ea7cd5e 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -679,7 +679,7 @@ void xen_free_ballooned_pages(unsigned int nr_pages, struct page **pages)
 }
 EXPORT_SYMBOL(xen_free_ballooned_pages);
 
-static int __init balloon_add_regions(void)
+static int __init balloon_add_regions(bool append)
 {
 	unsigned long start_pfn, pages;
 	unsigned long pfn, extra_pfn_end;
@@ -703,19 +703,26 @@ static int __init balloon_add_regions(void)
 			balloon_append(pfn_to_page(pfn));
 
 		/*
-		 * Extra regions are accounted for in the physmap, but need
-		 * decreasing from current_pages and target_pages to balloon
-		 * down the initial allocation, because they are already
-		 * accounted for in total_pages.
+		 * There are two different use-cases depending on how the
+		 * initial memory target is fetched.  For PVH dom0 and PV the
+		 * target is usually set to reflect the domain assigned memory,
+		 * and hence extra regions need adding.
+		 *
+		 * OTOH for HVM and PVH domU the target is set to the amount of
+		 * RAM reported in the memory map, and hence extra regions need
+		 * subtracting to reflect the real memory usage.
 		 */
 		pages = extra_pfn_end - start_pfn;
-		if (pages >= balloon_stats.current_pages ||
-		    pages >= balloon_stats.target_pages) {
+		if (append) {
+			balloon_stats.total_pages += pages;
+		} else if (pages >= balloon_stats.current_pages ||
+		           pages >= balloon_stats.target_pages) {
 			WARN(1, "Extra pages underflow current target");
 			return -ERANGE;
+		} else {
+			balloon_stats.current_pages -= pages;
+			balloon_stats.target_pages -= pages;
 		}
-		balloon_stats.current_pages -= pages;
-		balloon_stats.target_pages -= pages;
 	}
 
 	return 0;
@@ -726,6 +733,7 @@ static int __init balloon_init(void)
 	struct task_struct *task;
 	long current_pages = 0;
 	domid_t domid = DOMID_SELF;
+	bool append = true;
 	int rc;
 
 	if (!xen_domain())
@@ -745,6 +753,7 @@ static int __init balloon_init(void)
 		} else {
 			if (xen_unpopulated_pages >= get_num_physpages())
 				goto underflow;
+			append = false;
 			current_pages = get_num_physpages() -
 			                xen_unpopulated_pages;
 		}
@@ -767,7 +776,7 @@ static int __init balloon_init(void)
 	register_sysctl_init("xen/balloon", balloon_table);
 #endif
 
-	rc = balloon_add_regions();
+	rc = balloon_add_regions(append);
 	if (rc)
 		return rc;
 
-- 
2.53.0

