Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8F131E826
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 02:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785292196; cv=none; b=jfDpmD30EnMOqoGJ0TBEHCUdDYDI55UKDfX1mXprv5nGX/hcWBT41uBiNAaEVY6B0e6+fsKbPkMw69J49ugsUuFgEf31SJQFMUQlduS7aunAg9aSX5CMyRk0JSN80WIpTO2hz5IqX9hgt7+kw5sba4zQeL4Q4J/6Lt9oGIRTo1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785292196; c=relaxed/simple;
	bh=5dpZ9girKC73FTyBAFtpbQ4amhLeABgdVMNuS8E0jw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6/acz9aY4PlIHDBp29QCviE6r9CTmv0DGoYbhmc8tvf4eaxglvqsJbZnctB4WuKPak8d26j4grtygpE0JUyhIqtRLBAV6lKvddOgeIe+Uda4y5OfwVN7ZGcVF1N1JCvAgYbFWxobMTEDh3BR+B2C3E77QEPGRCgwXtCJVl8fKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRgDQc7w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRgDQc7w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6339A1F000E9;
	Wed, 29 Jul 2026 02:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785292195;
	bh=LjdKH/5lHqw710RONU6Om5kY72UcXiISR3GDtvnk4g0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IRgDQc7wQV4S0GEU+vWfCzkfV8VXr1uyEsjzH//Ugw845UC4moy5CFdPWMsnXUneW
	 89WC9iX6EOVqOLfDQTvvW95JTZ62OajPqwU3b5KiCFfq8PFo9nZK4tM9SxL1Wk9e8P
	 /KZ4nqPs96xYum/dVBya82YQLT67HEi3HxvFOgYEgOKRnN16TfCIn8vdrxvaENwwAG
	 cZFlGOHrcKuWbhcUvVZ0rw2RYQ4bfsE5KyB+vUcHhKgIxQO9gwlW5pA8572Wv+0Bvp
	 PelaQiWpbeqrBQsBoXmcZnGUMabE5fcw/ej/+TpVR273qemy2Dum/IF6n8nVYhkgy0
	 dPCs80MiVVzBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	stable@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] fs/resctrl: Fix double-add of pseudo-locked region's RMID to free list
Date: Tue, 28 Jul 2026 22:29:52 -0400
Message-ID: <20260729022952.1112657-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072120-luster-garden-e534@gregkh>
References: <2026072120-luster-garden-e534@gregkh>
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
index 2d48db66fca857..3db8992d1ae5f4 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2922,10 +2922,6 @@ static void rmdir_all_sub(void)
 		if (rdtgrp == &rdtgroup_default)
 			continue;
 
-		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
-		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED)
-			rdtgroup_pseudo_lock_remove(rdtgrp);
-
 		/*
 		 * Give any CPUs back to the default group. We cannot copy
 		 * cpu_online_mask because a CPU might have executed the
@@ -2934,7 +2930,13 @@ static void rmdir_all_sub(void)
 		cpumask_or(&rdtgroup_default.cpu_mask,
 			   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
 
-		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
+		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
+		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
+			rdtgroup_pseudo_lock_remove(rdtgrp);
+		} else {
+			/* Pseudo-locked group's RMID is freed during setup. */
+			free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
+		}
 
 		kernfs_remove(rdtgrp->kn);
 		list_del(&rdtgrp->rdtgroup_list);
-- 
2.53.0

