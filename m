Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4954052B2
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 18:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785348127; cv=none; b=GmECMmIaW04eOXM670yjK57rkYhfF+U9TIwGi/ivLj+2NGWeq1ZPDCyOKaoxVfB9BLDlsRpuJYfa958A9waohB01sRw0ByeFSpYqym6a2VEqpujJpITfyFBRF4XjQEa4LSGv2dgeoSq0mWOVN0RZKSjGRYFw371eOqxlHVlmqfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785348127; c=relaxed/simple;
	bh=NjTn3z6P0Cc5YfCtX65QaU2s8F+mGzt9EthAlYSshKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+tetlGFwfL2u9r9iXHqJk1z+j7uprVN9JQDZuXwAuqfAGsaNLyIgOIQmbOQAHewZ9QQAH1cA+lBwGTcLjigIrqDF5YYNjotsdq0zQewQoia73A8A+HAEItrwYMHiTnTw7ygGhb8R0ZAxtaFFkBIWSvyxpMC/oSExf4QD8NZs7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOnRxrVZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOnRxrVZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4BD21F000E9;
	Wed, 29 Jul 2026 18:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785348125;
	bh=sYWI/GZo0mEV/krNaCkdjPLOTnOYJOTjVj1oXu8jFMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SOnRxrVZz0AMURA7XCCJ49IhE84TXa3nCDRVtK2UAJtPpjWNp8NUT1Q/MRcHlQSir
	 KXe+NEuqXn8zya8YhS/415AVspGakT7s4GdFFwU8IKfqwUM4Ar1ojbhKtG9LWT4bhl
	 u/sihJzTaoYLM1BqdY4IP3mmUuSmWyxzS5bH5Uiao+MD42csrnynNgSEkQxTFz8Ezf
	 fGU46X9Uk9aUmZXfS9G2uPx9+/Lt6xX63alyNBKT9Ny5EQ2Yk0kn14Fsm+0MA3flm5
	 11fS71Lh2KC+mfV7PHtRV8/Kad7kpV4mPmIsgqURSnhCiRkOoOhNNwO6upqnmN+oD9
	 9XFf5hdKfNpCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	stable@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] fs/resctrl: Fix double-add of pseudo-locked region's RMID to free list
Date: Wed, 29 Jul 2026 14:02:02 -0400
Message-ID: <20260729180202.3682984-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072135-tricolor-chaps-010c@gregkh>
References: <2026072135-tricolor-chaps-010c@gregkh>
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
index 15ee89ce8c68c2..1100747ffebf7b 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2477,10 +2477,6 @@ static void rmdir_all_sub(void)
 		if (rdtgrp == &rdtgroup_default)
 			continue;
 
-		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
-		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED)
-			rdtgroup_pseudo_lock_remove(rdtgrp);
-
 		/*
 		 * Give any CPUs back to the default group. We cannot copy
 		 * cpu_online_mask because a CPU might have executed the
@@ -2489,7 +2485,13 @@ static void rmdir_all_sub(void)
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

