Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD86D382F25
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 10:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518492; cv=none; b=mMV9QbhaT9ZIJQOCWpgxG8/iQMfitJOUUH0foGvnqXuNMNkoAumi4EXQJUglD0eMxKPWVgojEzP0w4S6qjt4D4Ciph45n8pGlv3jdox6odsJ0rDLCTddBCVXH9fGG3dIa6lERvI2EWV3QiXFrWjfbKe6VVtsgcmC3ITVem21hn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518492; c=relaxed/simple;
	bh=KD2n/tPYSeT8BliNarrgXdctnELvx/1FIIA7Bd+R6qU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZHpYb8SzWRfZTYgucADYVHpGVJ0ZgLOr0NW9nhbxtOpiCoS6kJASwjVMX7HuDYxKNbYZxe/0bekcvjD5y2UVQzQFGUmrOHI2ZHhjWcmu7A2epXlp6Ur/UTmy8D0cOfyIo+l7eD1xFNmRCBWs1QT0kFY067zMtl9NhsimM8AUOSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cW/KHsd0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cW/KHsd0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1E21F00A3E;
	Fri,  4 Sep 2026 10:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788518490;
	bh=pzwmwpLv9zmn9uB49L8cB+otmgxpPKEXcUJ6whqZtlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cW/KHsd06exME6YF65m3xJiCpBvb9BeCs3achPXFRsm3AOxZq0OFytTvjjk0qpOmo
	 8JjO6P3nKqdZm23mTH5CtS6Pz7dfLLfaso+AJhp1DwacIs+v0FxaLE/33eo7pYI0iM
	 /xwNUQYDx84d4nymKU16qxLKQ93XehyqKkU0/cwhZKvmFjHTjWCjnW0QTP8BesjzxW
	 nIgksHChbQ93NN+od2UbNnxWeT9+keMMUgzj5UvpHuthqSCKoSNHJJp1KjYNkv5bsy
	 wfZ9KOXACMOJVDHzA4smHsyKur+pkt49Sr3p4wdjgdjPC8X+EF2NYGT/RLgFvLByjU
	 Ys1EI7DXWgOPQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Roger Pau Monne <roger.pau@citrix.com>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] xen/balloon: improve accuracy of initial balloon target for dom0
Date: Fri,  4 Sep 2026 06:41:27 -0400
Message-ID: <20260904104128.2544168-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090358-maimed-fraying-66f7@gregkh>
References: <2026090358-maimed-fraying-66f7@gregkh>
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
index 88511187458a9..9e7ba37fe8d46 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -720,7 +720,8 @@ static int __init balloon_add_regions(void)
 static int __init balloon_init(void)
 {
 	struct task_struct *task;
-	unsigned long current_pages;
+	long current_pages = 0;
+	domid_t domid = DOMID_SELF;
 	int rc;
 
 	if (!xen_domain())
@@ -728,15 +729,21 @@ static int __init balloon_init(void)
 
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

