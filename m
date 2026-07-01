Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611B8339844;
	Wed,  1 Jul 2026 23:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782947798; cv=none; b=X27199lYMxM5ylh550hsJSjpmOORFphv9Uq0Xdy2YMTV2KuE2IRUZqZXQL0vjbLBSKVQimh/2mw9olgfVa8CtbN+B2bAEoWOXTk4DlOp6e44ceEmuhF5bBJomdUYvPgRgNdGsMCNhIk/mLQTXFL/8u40aOo6STlyMCEXPqc+zYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782947798; c=relaxed/simple;
	bh=L5iGngYUj0RbDf/5xP7O0OjWCeduaKf3x7KzlbZXqrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T99nkahX3KvLYtloGsoEV2thixSGdSeLb9l6+qnGXjUQNMWrMCqNS8O0YhWOvlyW+fkB5983lvBliR/MXFXq3DpNhdP3bodAuVq4Y/6iD22bXLxuP16ChNhnr0kCSni0LybUOK7w+0dNyPIpLSlG1J7qOohaRY77H4UR0z+ntU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z37mFTGj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z37mFTGj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C021F00A3A;
	Wed,  1 Jul 2026 23:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782947795;
	bh=v3m8ksM4Wyb2JnziDDpNDINV68xLDgBcf0+7K7rEBXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z37mFTGjKarxUECh06uZnaCNQVi6vO5KdtYEg+nKcVpkf/0ZW6MmQDMMdWPeNh66I
	 xBS8aUIGvrbXj+QmOsEdTxrQ4c40Lijd2PHzcDQy4taR0uB4EJh90Kx3e1gsv+vMfv
	 wLtSdEkc7549HTJK6ROsx8UUcUUm6STaTXu2bBGUEkASabmK/4eNURmHH6m3GkveBN
	 +5Vs3jtN/+dxumJ2QKljZ3cbF6uw6wS4PhdYPaJc7WvhCxilVLmwrW0fgkxtFrvFuD
	 aBSr/RE7hdL7L+uReNB73mmeVVA7EQdJNW98WxoS0P7/qprgEoO2zAUMDoYw3OEMs0
	 /SjUNcDrlOBPg==
From: Oliver Upton <oupton@kernel.org>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Oliver Upton <oupton@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] KVM: arm64: Ensure level is always initialized when relaxing perms
Date: Wed,  1 Jul 2026 16:16:19 -0700
Message-ID: <20260701231620.3300204-2-oupton@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260701231620.3300204-1-oupton@kernel.org>
References: <20260701231620.3300204-1-oupton@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

stage2_update_leaf_attrs() returns early before writing to @level if the
table walker returned an error. At the same time,
kvm_pgtable_stage2_relax_perms() uses the level as a TLBI TTL hint when the
error was EAGAIN, indicating the vCPU raced with a table update and the TLB
entry it hit is now stale.

Fall back to an unknown TTL if none was provided by the walk.

Cc: stable@vger.kernel.org
Fixes: be097997a273 ("KVM: arm64: Always invalidate TLB for stage-2 permission faults")
Signed-off-by: Oliver Upton <oupton@kernel.org>
---
 arch/arm64/kvm/hyp/pgtable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 91a7dfad6686..31aaca35693a 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -1358,7 +1358,7 @@ int kvm_pgtable_stage2_relax_perms(struct kvm_pgtable *pgt, u64 addr,
 				   enum kvm_pgtable_prot prot, enum kvm_pgtable_walk_flags flags)
 {
 	kvm_pte_t xn = 0, set = 0, clr = 0;
-	s8 level;
+	s8 level = TLBI_TTL_UNKNOWN;
 	int ret;
 
 	if (prot & KVM_PTE_LEAF_ATTR_HI_SW)
-- 
2.47.3

