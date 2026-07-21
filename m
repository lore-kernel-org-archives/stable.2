Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7F2392822
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625335; cv=none; b=TyY3ycUWYGCmXPCZWFOMxWyvpDbMTGr+okrKUZlYTIetV8WynWH+q7c6fyxATBPn3IyavwIMdwKuLo1Q2jhAy2nnkHrsQ6qAj9Pba4i0etmjaIw7QvcaVViipiBmim8Hj4ZvE/JWUgwSNjZiAzzacn6a1n6vzp61q8Ox1H7RBOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625335; c=relaxed/simple;
	bh=LQZjV9tp55f6bc8Vsz2NZD05D407MVcjghmSJ4wAsko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tP0Ks+jL6RwkVzXSKv+ygic24q176nLPGDAIFWKotAePAbwOlRzwL4uideoEkkfYAcQfkzBe07uCgBcBVX3RvN3eyITW8Ahf4QxEEOHghcMXfwB8qk6yrx2ilTOql+Me0hTNzds/zgy+LlAwjfhteZ4vO6Py4RDiPNum8piQiy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4o/133j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4o/133j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836C51F000E9;
	Tue, 21 Jul 2026 09:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784625333;
	bh=D/CO1Wjj3IwkPMQhZA39T4kU50hDOYX6LqEtYQ0fDJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L4o/133jlBnYqoJ4t1cIleLiaqXSyD5svE1t34XNeByTBnN6JrInIERbCMv9SyWOG
	 1M5oSnnJd4M0er1gqzAPGr4N8+BQZ8sIk9wcGueVjlhWWMuvMSJ+883Ag4IG1LNiG/
	 Bt3i3yOIeLnmDqwyB63DdqpkT1lgipdck884DYI2T2vPn2RI0Pl8d43lN6l+7dJSU5
	 hKqCqRVl1Gu4Y8lxUuPhCqeZN4iE/qYvugjZW35kw52UT2AozSmzT7dnETL25gRAek
	 dC5iPnoPjZh/AMLLDzmrdf0FHSqqjTvZdPpYyaOlS+I1dmcYFhqMAsUcgH1thHBsJc
	 8wste+bhi8/6g==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wm6ZX-000000079Es-3VB5;
	Tue, 21 Jul 2026 09:15:31 +0000
From: Marc Zyngier <maz@kernel.org>
To: stable@vger.kernel.org
Cc: Oliver Upton <oupton@kernel.org>,
	Wei-Lin Chang <weilin.chang@arm.com>
Subject: [PATCH 6.18.y 1/2] KVM: arm64: Ensure level is always initialized when relaxing perms
Date: Tue, 21 Jul 2026 10:14:51 +0100
Message-ID: <20260721091452.2812794-1-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026072032-musty-tightly-d28e@gregkh>
References: <2026072032-musty-tightly-d28e@gregkh>
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
---
 arch/arm64/kvm/hyp/pgtable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index cbf8cd2e16735..3e056afea0722 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -1291,7 +1291,7 @@ int kvm_pgtable_stage2_relax_perms(struct kvm_pgtable *pgt, u64 addr,
 				   enum kvm_pgtable_prot prot, enum kvm_pgtable_walk_flags flags)
 {
 	int ret;
-	s8 level;
+	s8 level = TLBI_TTL_UNKNOWN;
 	kvm_pte_t set = 0, clr = 0;
 
 	if (prot & KVM_PTE_LEAF_ATTR_HI_SW)
-- 
2.47.3

