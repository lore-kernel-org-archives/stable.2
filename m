Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F5046983A
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 10:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788517851; cv=none; b=Vx3gqODajW3pzKdSfspVmL+0oOx/i8b72Insc/g8gLH7/o6iQL3lDkFuW9wBVWDCIv3i9DkiotxY8yja1EQl+USEhn8mgxZqF3jPhQVgedoXchUF97RQV/OQhBkTiLvVySGIe6JBoNh1UUOU6GUUzqTgr++vGksM2cmE0044cRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788517851; c=relaxed/simple;
	bh=+HUKfVlDqAXhZLv5ZV3UgKAKURaLWFl9EMbcwWl4voc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UZ1gZnNtNFT085aa9633yRl9YmImz7MRo3FCPlZH8s2bUN9gf7lHQ6FqefU/XkxH7P2Rq/DsGmGyMAV7RM84JgfCS0ePePNSQEsqzUlJtWyJs3YnF3c1lwFBobNbp8YHkBJ2Tyo6LwLyozdUhULXH+Hl9AT9Fmz9VgjFhBodDec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAVIisM9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAVIisM9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BEB1F00A3F;
	Fri,  4 Sep 2026 10:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788517850;
	bh=CzqT6JRCxFDxzWXYFpnVNEQbz2zG6JP2fVvPpQdp2pY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VAVIisM9XMSDfZFcwNtNxM0PFwjN3zjRFYYFODKIJV1hs8fTLD51qqll2ThEEulUs
	 tc2TQv030ZUcBGbZfozshd4kxkx8VGHVssH6r+i850v9hqpN00Q8HkOwEz2gmBEiQn
	 v/lQf1aG2uud4tNzdbHY/bz72QBYIxFtMOkUFKCx1s4NU8EcVLOIJB1bXfI7lj5OyD
	 5mc5TcxlvmXbCNkFVM6gfQL3Ld/1HAUT9Yk6XL0lYDpcP1CmW3wCfcKv8GHRVqcJIh
	 W7fLignj1NNLwu72xZCc+9OS7rVNIj1LYdCowCNsyXAYB9Mox14a0mF8B/oRXH2L3G
	 kFB9FnzzZ3pOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Roger Pau Monne <roger@xenproject.org>,
	Juergen Gross <jgross@suse.com>,
	Matthias Goergens <matthias.goergens@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] x86/xen: fix init of balloon stats again
Date: Fri,  4 Sep 2026 06:30:47 -0400
Message-ID: <20260904103047.2503626-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904103047.2503626-1-sashal@kernel.org>
References: <2026090358-booth-lavender-dee9@gregkh>
 <20260904103047.2503626-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Roger Pau Monne <roger@xenproject.org>

[ Upstream commit 5d00a11d484e7b31a358cd81afebccb4602dbe8c ]

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
Reviewed-by: Juergen Gross <jgross@suse.com>
Tested-by: Matthias Goergens <matthias.goergens@gmail.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Message-ID: <20260805094008.95778-1-roger@xenproject.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/balloon.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 9b6531eb28b65..d4c99165b3a9c 100644
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

