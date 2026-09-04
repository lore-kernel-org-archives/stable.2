Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4B449C4BF
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 11:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519752; cv=none; b=DYxkHCOhG3rWCJ3VaI3mqAlk94MD61yTV88s/U3Q0H1S6PPyXC5lebeZ54YBjOuORu+fseq4Tz7OsHFR72ZTwZMKrR/hr9yJxyl8l7YTZj6iCsw6FvCoJxLxTwFuZetEAf/IENfpzsDeVpE2zb9Y5BKQaN8QRCtHoGJkBxELRc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519752; c=relaxed/simple;
	bh=vz446Xc7UbvAWBzSx7ijOXj7HG+620H0dL8z6eeu4OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h7LnHWF6bIkIdH3ugLqUQ1+V7deMzsGr1i9aIy6U3wMD/S534EXMixFXSsTcU1ZrwdiBMwfkILDtDUELAceYjuPwU16+uVDyz27gLouAYmgWINhfO/nryuOeNX6JissRjh4zquBA0eOgG5owHr+B5kqpz2VhKyVIQY6ShGedylQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMc4WZw6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMc4WZw6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD061F00AC4;
	Fri,  4 Sep 2026 11:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788519751;
	bh=QFJUDiK3tVt7BYA2IMEMTbce0cQlV0xHvmalGWQ1Rhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NMc4WZw60LI5QjIcpFMQYojaHu37OWhiJmL7OQdNPNVIYtZSAjNluxK3w9ZpIIqtG
	 Z001CCObXPFmhkk/ES+W5ZEWSESpT4cW7y3ONXGwQYhjpOJ3YzfbmOHs7s2Fo1Pk7K
	 hqnODAtZjbM6y98odvRA1aYTNBsQwXNezerd7vcfXmVKQWGiZVlRDqvdZYEkX5YPId
	 auZbeIqQ7MaH2dqAM8xSFzbJnfQAofjCvz+a8uCh1m4h+5Db3zKcrwbLCc3vUpvH6j
	 0R2vxZvplvojlweW2v6Yqr0zH2YR8KO0o3C14ACQCypIzzazmfSXz6s+e/UPtpKX3u
	 pFfV8ZepQ36GQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Roger Pau Monne <roger@xenproject.org>,
	Juergen Gross <jgross@suse.com>,
	Matthias Goergens <matthias.goergens@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] x86/xen: fix init of balloon stats again
Date: Fri,  4 Sep 2026 07:02:26 -0400
Message-ID: <20260904110226.2841462-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904110226.2841462-1-sashal@kernel.org>
References: <2026090359-kissable-animate-cb41@gregkh>
 <20260904110226.2841462-1-sashal@kernel.org>
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
index 1fb5dbce0b66c..af34de2a8a23d 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -671,7 +671,7 @@ void xen_free_ballooned_pages(unsigned int nr_pages, struct page **pages)
 }
 EXPORT_SYMBOL(xen_free_ballooned_pages);
 
-static int __init balloon_add_regions(void)
+static int __init balloon_add_regions(bool append)
 {
 	unsigned long start_pfn, pages;
 	unsigned long pfn, extra_pfn_end;
@@ -695,19 +695,26 @@ static int __init balloon_add_regions(void)
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
@@ -718,6 +725,7 @@ static int __init balloon_init(void)
 	struct task_struct *task;
 	long current_pages = 0;
 	domid_t domid = DOMID_SELF;
+	bool append = true;
 	int rc;
 
 	if (!xen_domain())
@@ -737,6 +745,7 @@ static int __init balloon_init(void)
 		} else {
 			if (xen_unpopulated_pages >= get_num_physpages())
 				goto underflow;
+			append = false;
 			current_pages = get_num_physpages() -
 			                xen_unpopulated_pages;
 		}
@@ -759,7 +768,7 @@ static int __init balloon_init(void)
 	register_sysctl_init("xen/balloon", balloon_table);
 #endif
 
-	rc = balloon_add_regions();
+	rc = balloon_add_regions(append);
 	if (rc)
 		return rc;
 
-- 
2.53.0

