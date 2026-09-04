Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3B2472782
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519751; cv=none; b=oGrrf93hs3ZxK5hT6j4KoucG8RO8R/lPDGy6YxyavKL1cOTFecjIb637Hp3jLUpR6BHlu7/ZzHhRIDn045ouEGpPn3qgxlfSM6Bo42pdsXuaFi0K4gz0ef/D3BaSxupBQCro3vjYFb6hWG1yezNemK9kuK7npoyUrz+XwZQgfbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519751; c=relaxed/simple;
	bh=is5CKwtGyIzIkuS4NPT/w+anGqHfLZChAv0sh40KZW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qJzX+BlqqCODpAlbuJlqD/YNEDtZnHj1bGo9TO5+lQn8IDpS1LGMspmAomCozFs+cJQTuIB9cBNCJCrfCvdOXeNVdabO/ScepWfUFMHDdXw/NWpYiShMr6mtwyKC0vu+BVTWsnVdqt3YM8ZNttwMUQM49nlr6oTVBi5+17nvkzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+ShDA6e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+ShDA6e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C581F00A3E;
	Fri,  4 Sep 2026 11:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788519750;
	bh=Pe9002Stf//99wdvIHgCBaHjwuqpJYnydmLPvWuibKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z+ShDA6ebZCA01XuppaINfgSLwfhCmtrTv2vBsvZ57nkHegxo9Z1aDFRXDxp5nx71
	 v9VGs0uOXLu6EzPTthG9Hpxggpu/14YBSCX3DQs/faId5KXusLs6Yg2xjG00PSdJrf
	 i9BXDmoZ6FGo+fMNYX01J23C02+kywB0XwGXxK2tHa6XN8DZQIdKgpwpUrnooCiClX
	 XXdKpN3h8Y1SzpBwdCTMISRuUZr4XVMBtlnO5QjXJeWnJzEDXr71TwCS/aUecmEOfE
	 JLsWe8+3fhBxlDaL/dIaJICLsfv36cFhF769yeo/hWRw3diwz1ZU9U7ctN0sjIULQU
	 bkRrt/+BK96Cw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Roger Pau Monne <roger.pau@citrix.com>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] xen/balloon: improve accuracy of initial balloon target for dom0
Date: Fri,  4 Sep 2026 07:02:25 -0400
Message-ID: <20260904110226.2841462-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090359-kissable-animate-cb41@gregkh>
References: <2026090359-kissable-animate-cb41@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Roger Pau Monne <roger.pau@citrix.com>

[ Upstream commit b13cd24c15d74f6dfcddf0d53ae6efb58d3f0461 ]

The dom0 balloon target set by the toolstack is the value returned by
XENMEM_current_reservation.  Do the same in the kernel balloon driver and
set the current allocation to the value returned by
XENMEM_current_reservation.  On my test system this causes the kernel
balloon driver target to exactly match the value set by the toolstack in
xenstore.

Note this approach can be used by both PV and PVH dom0s, as the toolstack
always uses XENMEM_current_reservation to set the initial target regardless
of the dom0 type.

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Message-ID: <20260128110510.46425-3-roger.pau@citrix.com>
Stable-dep-of: 5d00a11d484e ("x86/xen: fix init of balloon stats again")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/balloon.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index a76d5530533ff..1fb5dbce0b66c 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -716,7 +716,8 @@ static int __init balloon_add_regions(void)
 static int __init balloon_init(void)
 {
 	struct task_struct *task;
-	unsigned long current_pages;
+	long current_pages = 0;
+	domid_t domid = DOMID_SELF;
 	int rc;
 
 	if (!xen_domain())
@@ -724,15 +725,21 @@ static int __init balloon_init(void)
 
 	pr_info("Initialising balloon driver\n");
 
-	if (xen_pv_domain()) {
-		if (xen_released_pages >= xen_start_info->nr_pages)
-			goto underflow;
-		current_pages = min(xen_start_info->nr_pages -
-		                    xen_released_pages, max_pfn);
-	} else {
-		if (xen_unpopulated_pages >= get_num_physpages())
-			goto underflow;
-		current_pages = get_num_physpages() - xen_unpopulated_pages;
+	if (xen_initial_domain())
+		current_pages = HYPERVISOR_memory_op(XENMEM_current_reservation,
+		                                     &domid);
+	if (current_pages <= 0) {
+		if (xen_pv_domain()) {
+			if (xen_released_pages >= xen_start_info->nr_pages)
+				goto underflow;
+			current_pages = min(xen_start_info->nr_pages -
+			                    xen_released_pages, max_pfn);
+		} else {
+			if (xen_unpopulated_pages >= get_num_physpages())
+				goto underflow;
+			current_pages = get_num_physpages() -
+			                xen_unpopulated_pages;
+		}
 	}
 
 	balloon_stats.current_pages = current_pages;
-- 
2.53.0

