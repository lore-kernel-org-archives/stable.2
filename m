Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB21469855
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344278; cv=none; b=QbtU/ZvwvLUtqbIJJjD35PhrNGMkDR/qIY4oScdgTxaWI4+ofRVJduSbycEUIU04rJfuTrLY79zR0MJxU8R8fVwnW7rykb6ufg3sJyULGp2TOux+YK9rAznZLjHI+QEOJ6e14ONfpX8sLFgtAFtEpk7o+fMTujGbdOFsPxFWKrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344278; c=relaxed/simple;
	bh=tKMrYlgPx/vPhZoe9Ez1oXffURqlW0H1B1LdgfBIxgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pxlx+VzbaRaquOdVNZgbw6GfeypogDrDOoIjwjR03Pdj9xVjL/1Vj5yEfPwO2ueIzZRabNaOgCk3BEcAgqp8lBURA9P8z7BnaM7vuH5P/qQEjPHsszEq8uGmSWGkfgsQLSrNsVdfU3rf2XKMkuCN+Dw9dHAqzsrGqtDz51Fn8y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzkpjywQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzkpjywQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B201F00A3A;
	Wed, 29 Jul 2026 16:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785344276;
	bh=dTt4YVWDsuPGPPrBSmm6rav9ZephfkTveaEosfnxDnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JzkpjywQAmYDdpnM6WunBumK5eVurkiFP/mCRp4FwpucLj+rDU2CY1v0xJPDrLrTI
	 nX8UMWcl4/o53lCxgUoNqLhMg+Vr5qrFzdTNh1lu8sDvsQNNnORoFgeqAi8leN2pBL
	 yEv0ou+Wv3Zl8LL9riqWHiyVxNno/Qjg5OKjwpxD2jnQQrDzWDoiYbwVVy6JRNjZpU
	 fi1QfTGqFXDAf3PG+uRv2ue6Y8V2EuAXHy8EA1+KQR9cd3EB7+udLDwrE9IqI/Rahq
	 Coo9NsJqRKfY2PZf4wmDA1gynoQUSZ5JpBri7T5AynwpNpTrzyECVKSRqp/jkCECPG
	 z2dl8Dj3TFmnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	stable@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] fs/resctrl: Fix double-add of pseudo-locked region's RMID to free list
Date: Wed, 29 Jul 2026 12:57:53 -0400
Message-ID: <20260729165753.3661352-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072135-smashing-sudoku-fcfa@gregkh>
References: <2026072135-smashing-sudoku-fcfa@gregkh>
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
index d82d5de183b107..1bc8b98e175c18 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2744,10 +2744,6 @@ static void rmdir_all_sub(void)
 		if (rdtgrp == &rdtgroup_default)
 			continue;
 
-		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
-		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED)
-			rdtgroup_pseudo_lock_remove(rdtgrp);
-
 		/*
 		 * Give any CPUs back to the default group. We cannot copy
 		 * cpu_online_mask because a CPU might have executed the
@@ -2756,7 +2752,13 @@ static void rmdir_all_sub(void)
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

