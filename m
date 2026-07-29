Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD334D8D93
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 18:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785349230; cv=none; b=tu/6Eo/QP3W6CYJM71fyfTgYSLRGi5ifSAX9pwnIqF1g9wLits4k2oH/ygH3MYObpwNSlqbyCiM+meLqvOvlziZ3KfWNg8KW3DjVBYpj9pgte/cTAtgVEwM/ZEYV1nm7ecaSZUGISxiPlIKSTMqqE82uYb7+Oth9koKQbmygYmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785349230; c=relaxed/simple;
	bh=uawrH/uGuP9E15owHcNm8HFwB/FPs4Q0XSaJKAGfquQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dZbC78VVcTyoF3lZN61UdDk+J2gAhJOjvy4HsFUFQvXyj53eBUJhqKXPODp8MW8y9n7/mLuLlgjNR2GJfyZYYRH1j0l8wxe/KxM8XoQH7UmpCIE8ohFDc52A6ut95cuYcwV9u/nu3YlUwzwwcA2af3U3Le4D20d4xBjrGAgxbdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4biMvCd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4biMvCd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738A21F000E9;
	Wed, 29 Jul 2026 18:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785349221;
	bh=09Laa6jazcrPPxh8WVM6hqXDWMlAuRMIqV/c2/lv4lY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e4biMvCdAGWgdEYf9I+jHSa5G+LeTBHM7fUbM4vc14G73shi581p6Fph+fDoA4HCn
	 u5FbOafvj+qZWypJaCCAjPjAkm2zf9CTpf2UGG7vZ/UMqbqc5K9og/Tm4KmG/ZDMMS
	 FPJwDiW2p9+MAUNIO8YvDQoNTz+tn/G12DunPYwm1SyQPjDBzkGP2GnmIRuYYN87hb
	 x6W5gZqZGSAqG9qn7Yq1C3g8xZGV9bYRYWSUMslmmboQq1DktOHxLKS+KXGUvniB2+
	 Qt6GK2FGWf5KDQvvELD0JVRqjzypH6uB1qH27nDbED73y0hVRaekPM0Uk6JETbrzne
	 iDEcYrOqPA5iQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	stable@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] fs/resctrl: Fix double-add of pseudo-locked region's RMID to free list
Date: Wed, 29 Jul 2026 14:20:18 -0400
Message-ID: <20260729182018.3774977-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072135-ether-exuberant-c02b@gregkh>
References: <2026072135-ether-exuberant-c02b@gregkh>
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
index 2ec16477eb3e1e..dcf54246aafa1b 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2439,10 +2439,6 @@ static void rmdir_all_sub(void)
 		if (rdtgrp == &rdtgroup_default)
 			continue;
 
-		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
-		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED)
-			rdtgroup_pseudo_lock_remove(rdtgrp);
-
 		/*
 		 * Give any CPUs back to the default group. We cannot copy
 		 * cpu_online_mask because a CPU might have executed the
@@ -2451,7 +2447,13 @@ static void rmdir_all_sub(void)
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

