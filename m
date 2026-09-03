Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6AD4A5C24
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439661; cv=none; b=DaQ2bfYsWRXO8DEhXuJ9IMqb311cNLFwOqh8tVYV0Hr4wHncFZ0IetuMqlix1HGdtJwpkGt68udZnTC3yIr0Yk/FlxlRHCAGnB6c04DmDdLqkq4L+EKX08CwDPR2UmQs8A5OcEFmpWMyiBS5OOJrvyhRx+mmn9OFzVcq4oGT8W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439661; c=relaxed/simple;
	bh=tom56x0IkH0Zt+n3hbjJjuTiwH9ROV8/PUn6idBOnGs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XjiDpHz4kG/XZd90g6f4Nmv5zm4kzEwZYdB1WBxBhf8r8BYbgeS1uYNI6r2dXI13XbplSKnqCuyRtbaY2rX3dNZj/zkAVS+HYgGT+mNFXExoTZL9q/DllDu2uZ56MY3fJzsoy8xy2lvm7ei9kEgKopKSqx0bTTt0ondGCd2GiS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PTch/ll1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PTch/ll1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70141F000E9;
	Thu,  3 Sep 2026 12:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788439660;
	bh=j9ikdjMo6lXKw483IHWDd4bh/ei0PSA++1TvLysh0B4=;
	h=Subject:To:Cc:From:Date;
	b=PTch/ll1W2JKMnSCJ3DXl1/0KHkCzdPCtVEFOaO7kitwngovA5d4yzfKO29sXg8zB
	 IQ8FKTk4fq3YlNo5khiyokTsDzJZrxwox9C7tT/LwqfLl719nlE8SwwCvOH/bYT+Os
	 p6b2J2ndpwrYgrn/OM/IzuhgXxwGFcxUSGR0gKsM=
Subject: FAILED: patch "[PATCH] x86/xen: fix init of balloon stats again" failed to apply to 6.18-stable tree
To: roger@xenproject.org,jgross@suse.com,matthias.goergens@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 12:53:58 +0200
Message-ID: <2026090358-booth-lavender-dee9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 5d00a11d484e7b31a358cd81afebccb4602dbe8c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090358-booth-lavender-dee9@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5d00a11d484e7b31a358cd81afebccb4602dbe8c Mon Sep 17 00:00:00 2001
From: Roger Pau Monne <roger@xenproject.org>
Date: Wed, 5 Aug 2026 11:40:07 +0200
Subject: [PATCH] x86/xen: fix init of balloon stats again
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
Reviewed-by: Juergen Gross <jgross@suse.com>
Tested-by: Matthias Goergens <matthias.goergens@gmail.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Message-ID: <20260805094008.95778-1-roger@xenproject.org>

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
 

