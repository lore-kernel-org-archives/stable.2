Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDB93B994A
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 10:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628333; cv=none; b=CuqA0zVup5jJEtUqvt0fYGZWNAOFo03zyqORK8orOjIM7ZeUeGd2SVCcOPr738qPYFZ62pOm2mjG9nAArbDIShEebytXDOFZfwt4VeX45eXnkN7kN9ccHj0pfMKfCFX+BzfzVXaaP5y2jfiIeK0Rq2iplREJADbatZgS56L2tQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628333; c=relaxed/simple;
	bh=GSXxN0eWF8nqsERR7svBbbQL2/gSrtSIzI9DotIhoVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fihUH7snL9eV+cJ9e0Kai7EYiyJKdgRZxz17heCfGXfSquqvWFhcDOSMhRunxjKu8688GSpkYq2NsaPh+9tMc02T687fPZ65FCZ3XZKX2auMFEsKLYFMvMgi29GoxtntVLNETv9RhNzeQH5pPdcj9Mk/v5GrXjnxP40FIuidn9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3KaAU8Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3KaAU8Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136531F00A3F;
	Tue, 21 Jul 2026 10:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784628330;
	bh=DTRDiBZffB9xyHJghOASEwSlbTHF27uRzVRDtEgkznA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U3KaAU8QcK0dBiMwVFbBi/43PgBVRvfBbjyJVt+E+K3RL8wwYPHQe6DgzGh8K8saA
	 NwTKEIwyH8eosXMn/tGm4lrC9jQRClvNNnrbxG608Eyp97CbrRbjO3auCiUFOnvXpG
	 lTgLirDGQk07dVmSzIfIymbXCf90gW8LJTW18o5ywUzPjRQBWlaK2nb7yVFRMLZ/eK
	 kiC2BQdFeVhEARL2v+giY2Cc3pD8Z6uDMMpQDG+Gf2tD8ue7MfCSXTDpwmq/XsTvQC
	 jI1X1naA80Btc8L1D2EfanqeL2QoJWr1pRzxCUpZyrIz4j1jrjkospgTDy8iBgxV0X
	 BeB3IqiJoMkzA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wm7Ls-00000007ADC-17Vo;
	Tue, 21 Jul 2026 10:05:28 +0000
From: Marc Zyngier <maz@kernel.org>
To: stable@vger.kernel.org
Cc: Oliver Upton <oupton@kernel.org>,
	Wei-Lin Chang <weilin.chang@arm.com>
Subject: [PATCH 6.12.y 1/2] KVM: arm64: Ensure level is always initialized when relaxing perms
Date: Tue, 21 Jul 2026 11:05:22 +0100
Message-ID: <20260721100523.2877434-1-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026072033-wrinkle-closure-7d3c@gregkh>
References: <2026072033-wrinkle-closure-7d3c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: stable@vger.kernel.org, oupton@kernel.org, weilin.chang@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

From: Oliver Upton <oupton@kernel.org>

stage2_update_leaf_attrs() returns early before writing to @level if the
table walker returned an error. At the same time,
kvm_pgtable_stage2_relax_perms() uses the level as a TLBI TTL hint when the
error was EAGAIN, indicating the vCPU raced with a table update and the TLB
entry it hit is now stale.

Fall back to an unknown TTL if none was provided by the walk.

Cc: stable@vger.kernel.org
Fixes: be097997a273 ("KVM: arm64: Always invalidate TLB for stage-2 permission faults")
Signed-off-by: Oliver Upton <oupton@kernel.org>
Reviewed-by: Wei-Lin Chang <weilin.chang@arm.com>
Link: https://patch.msgid.link/20260701231620.3300204-2-oupton@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
(cherry picked from commit 100baf0184896f859290a684f864b8200d8ac872)
Signed-off-by: Marc Zyngier <maz@kernel.org>
(cherry picked from commit f35e314d4512480316454d3e963c513faa68decf)
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/hyp/pgtable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index deabc21caae37..70274579cd412 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -1314,7 +1314,7 @@ int kvm_pgtable_stage2_relax_perms(struct kvm_pgtable *pgt, u64 addr,
 				   enum kvm_pgtable_prot prot)
 {
 	int ret;
-	s8 level;
+	s8 level = TLBI_TTL_UNKNOWN;
 	kvm_pte_t set = 0, clr = 0;
 
 	if (prot & KVM_PTE_LEAF_ATTR_HI_SW)
-- 
2.47.3

