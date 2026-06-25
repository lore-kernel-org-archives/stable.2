Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79603E3C5B
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 12:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782391953; cv=none; b=bsx9LIPaO2FQVmj+dcXhhOMwPTDc0wqGMMlDJlmf1a2QTAwZS8WIqolax5Hs3iZ/GN/a7Fgs/khAM+3dF3rmQy7/rAHy6BA7xX116aGTDrKgBw1yFcoiHXZnDCwkVVvFNl7vk1eTVTbu6lNDGNPbEpRPpI0DLroLg0F94b7mQsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782391953; c=relaxed/simple;
	bh=idgWC1YzTy71ZQ6ALsF5BVgCL3tKBfiQM5GVp0I1RZY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FTEgiN/+0joVR2EepPAbIOgrHFsr1wpZWZrNfVL4Jr4DvtWI9Z2MaejPWoJGfNNC8JmgUoJXiKsfTus/Q3qaPHT3qSY0yI72uNB3JrQRQJl+A5qwEC3m/EZv2ScUXDSD6VlxttBhhtVtJrzsjoKF73KjIXjSMSN34fDD0O/lD8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YcZYIV/R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YcZYIV/R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38991F000E9;
	Thu, 25 Jun 2026 12:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782391952;
	bh=QR172/8uo3PRA+j0ARv2pj7ji/n35PH2+PRyRy5XXQU=;
	h=Subject:To:Cc:From:Date;
	b=YcZYIV/R00VpSHFGT3nb2aSq7uSIBQz+HjXHG66jr72r0ois6LFrBj6XGx9FkHL6/
	 FlkDQUwZjvzbPuzTmspOS/1lkDxxiJ8PqhBrg6iUeWWSTAwwNlbMVJVwZ9hJTUeQN+
	 xJKaLsrFBzv25GgV9KvPsdsORejjpJz3kMNxfwCE=
Subject: FAILED: patch "[PATCH] drivers/base/memory: set mem->altmap after successful device" failed to apply to 6.12-stable tree
To: georgi.djakov@oss.qualcomm.com,akpm@linux-foundation.org,david@kernel.org,djakov@kernel.org,gregkh@linuxfoundation.org,icheng@nvidia.com,osalvador@kernel.org,rafael@kernel.org,rppt@kernel.org,stable@vger.kernel.org,vishal.l.verma@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 25 Jun 2026 13:46:56 +0100
Message-ID: <2026062556-emcee-reexamine-cc0e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x a2b8d7827f48ee54a686cb80e4a1d0ff954ec42a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026062556-emcee-reexamine-cc0e@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a2b8d7827f48ee54a686cb80e4a1d0ff954ec42a Mon Sep 17 00:00:00 2001
From: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
Date: Thu, 14 May 2026 02:26:57 -0700
Subject: [PATCH] drivers/base/memory: set mem->altmap after successful device
 registration

If __add_memory_block() fails at xa_store() (under memory pressure for
example), device_unregister() is called, which eventually triggers
memory_block_release() with mem->altmap still set, causing a
WARN_ON(mem->altmap).  This was triggered by modifying virtio-mem driver.

Fix this by delaying the assignment of mem->altmap until after
__add_memory_block() has succeeded.

Link: https://lore.kernel.org/20260514092657.3057141-1-georgi.djakov@oss.qualcomm.com
Fixes: 1a8c64e11043 ("mm/memory_hotplug: embed vmem_altmap details in memory block")
Signed-off-by: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
Acked-by: Oscar Salvador (SUSE) <osalvador@kernel.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Richard Cheng <icheng@nvidia.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Georgi Djakov <djakov@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index d31a421f7483..b318344426fa 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -797,7 +797,6 @@ static int add_memory_block(unsigned long block_id, int nid, unsigned long state
 	mem->start_section_nr = block_id * sections_per_block;
 	mem->state = state;
 	mem->nid = nid;
-	mem->altmap = altmap;
 	INIT_LIST_HEAD(&mem->group_next);
 
 #ifndef CONFIG_NUMA
@@ -815,6 +814,8 @@ static int add_memory_block(unsigned long block_id, int nid, unsigned long state
 	if (ret)
 		return ret;
 
+	mem->altmap = altmap;
+
 	if (group) {
 		mem->group = group;
 		list_add(&mem->group_next, &group->memory_blocks);

