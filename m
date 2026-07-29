Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E43451988
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 18:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785350116; cv=none; b=jsdwuLlEEyhoMbyFTQ5AWpPxUcS/1OWQP0HAVOd1Hf2fxC96IZsNnICezYFTJxiKG9zENJLDlsptrOmEzJBVBWhXkvlB90+mxI0j0h10B8G3SIAVTxFxWkw0nBSD/1EbGYyd+XCOkmXUdA0UHEpUAT2gknrXl+q2njSqfG3HjJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785350116; c=relaxed/simple;
	bh=P4JKwfJcRarxZgH5MOEjdqkCGpaY+iVUz/vHYj5AC9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=flx+vSr2dHfq6xbUD9V7Op4oOyZdTowHZhkf6uA8dwey3Gs0zpDHv9qxn0SMU6OB5Ir7Kgk0cVadg+hXsXtd2I3K4vh8IDYHOSMqiDALSlnyT5gIUnrCfXk7bRYi4jWvWZn839qPl04FeZMxCGx5jogR0G/z0kgENxiEcXmMSe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRxcgpYZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRxcgpYZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DCD1F000E9;
	Wed, 29 Jul 2026 18:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785350113;
	bh=BgPkzG6u+zyYB7wVR3fFdH279aTgA6uSEnRNRlYq7hg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BRxcgpYZYBrF4JM4TxHnfSEVOOGi8Kgik0wSpOXfST05l9MvVuDYmwD+hJoyxJed1
	 q8aAmYLbPOxV/f8YgX7KwX0GZUzWqIfw5hhtavwoFZZKQDKmgnipR9iZ49VaSeH7D+
	 wCB5GRNllHLEYTb1T4gigj4gBpSOFK296MMI44bVnpMuYxv2mgS39hFBXfIEADVW48
	 NoGKAh+aOWWN30k61fnltGvDDfFKdAPFpKwgK+mbifTpOdABddg2UqwQovqSvuuRHE
	 umgXivKm/E0HBL+wDEhCLVx7SATQ2NCw6ssVhFDUeNnK9j+9IelHdWypfVdelHJZdA
	 3crcInJmfP6bg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	stable@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] fs/resctrl: Fix double-add of pseudo-locked region's RMID to free list
Date: Wed, 29 Jul 2026 14:35:10 -0400
Message-ID: <20260729183510.3962416-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072136-revisable-repeal-74a2@gregkh>
References: <2026072136-revisable-repeal-74a2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Reinette Chatre <reinette.chatre@intel.com>

[ Upstream commit b9f089723aee892efc77c349ae47a6b452b293c4 ]

A pseudo-locked group's RMID is freed when it is created. On unmount
rmdir_all_sub() unconditionally frees all RMID of all groups, resulting
in a double-free of the pseudo-locked group's RMID. The consequence of this
is that the original free results in the pseudo-locked group's RMID being
added to the rmid_free_lru linked list and the second free then attempts
to add the same RMID entry to the rmid_free_lru again.

Do not double-free a pseudo-locked group's RMID.

Fixes: e0bdfe8e36f3 ("x86/intel_rdt: Support creation/removal of pseudo-locked region")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org>
Link: https://patch.msgid.link/551432dd7e624a862b8e58314c38aaba0afff3e9.1783377598.git.reinette.chatre@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 1e73b6fae3b4c5..f0e879d3ac3037 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2376,10 +2376,6 @@ static void rmdir_all_sub(void)
 		if (rdtgrp == &rdtgroup_default)
 			continue;
 
-		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
-		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED)
-			rdtgroup_pseudo_lock_remove(rdtgrp);
-
 		/*
 		 * Give any CPUs back to the default group. We cannot copy
 		 * cpu_online_mask because a CPU might have executed the
@@ -2388,7 +2384,13 @@ static void rmdir_all_sub(void)
 		cpumask_or(&rdtgroup_default.cpu_mask,
 			   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
 
-		free_rmid(rdtgrp->mon.rmid);
+		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
+		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
+			rdtgroup_pseudo_lock_remove(rdtgrp);
+		} else {
+			/* Pseudo-locked group's RMID is freed during setup. */
+			free_rmid(rdtgrp->mon.rmid);
+		}
 
 		kernfs_remove(rdtgrp->kn);
 		list_del(&rdtgrp->rdtgroup_list);
-- 
2.53.0

