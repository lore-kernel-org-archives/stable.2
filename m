Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB25364E80;
	Tue,  2 Jun 2026 07:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780385283; cv=none; b=cQlYKWUThdGULK34nw6BeoHCmPu4TL8osKgvV4lx5VMf9JLi5HtdJXii+XBZfGZOS7A3OSLZDMuG36WA0E8HpmoqrQhwxvRgw0y1x14mBBeCU0IFse6DEOhdIkZJYF7Tbg549dpoOtuUaW3HdiWR6Se8Xi702rmWkBgf33xkr4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780385283; c=relaxed/simple;
	bh=hhvCEdB/JJDW0uD2o6q9xX0G9xeuu8KLHs00YAyAOhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tBzcMHgUP6AFaphKEzCmItIdzlC3CciukTPcGWOerDnHcpF7NpMsn2wLLOgXO3DxGNRRE7G+JtpmUsj0VDBjhnWeivANLw6/0CyJP0uhjRqIn8XM2mmwv8w0mxXtb/kmuBE1FaVRUcwSZF6EcYl/xVz2zvKn0VC4t4KiYjZlcxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnzFNL6a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnzFNL6a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E571F00893;
	Tue,  2 Jun 2026 07:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780385281;
	bh=o+FDLE073g6f02yiEQlUrQXnN1L23r2BUAEWpK9WN/I=;
	h=From:To:Cc:Subject:Date;
	b=FnzFNL6asX5tiFGJ4FDSnxLwOmy6GVVmW4vf+EYKUjmUoLh4F3hUctWRp+axCGwvj
	 gj/Z0rFeF2XuN24vyslrQfotXvmb6QuqsZ7GAJNYAkfAjLZlpeIWxcm6pFYehWLA/H
	 ZvbCKJ5elcyVa+N5FEbO/ROhNUsgoiLmn3G3C1L5ienKArfehr4dShRw+9kdCnqFEi
	 F0oAhh2xEQ0Rq9Nesu2TD6J42LGHaFGzGBvEWiyquklyEWjibFOWccLHvdct3ibXha
	 wH+tCF/7Dj7QUCex/VoYasg7a3zAtqiasw4Y662pOTiL3N1e1UhpE7IvTbKzGYvu+o
	 GLK05HYzZVimA==
From: Oliver Upton <oupton@kernel.org>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Oliver Upton <oupton@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: arm64: nv: Fix handling of XN[0] when !FEAT_XNX
Date: Tue,  2 Jun 2026 00:27:59 -0700
Message-ID: <20260602072759.37885-1-oupton@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XN has already been extracted from its bitfield position so using
FIELD_PREP() on the mask that clears XN[0] is completely broken, having
the effect of unconditionally granting execute permissions...

Fix the obvious mistake by manipulating the right bit.

Cc: stable@vger.kernel.org
Fixes: d93febe2ed2e ("KVM: arm64: nv: Forward FEAT_XNX permissions to the shadow stage-2")
Signed-off-by: Oliver Upton <oupton@kernel.org>
---
 arch/arm64/include/asm/kvm_nested.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
index 091544e6af44..f5d4eb925198 100644
--- a/arch/arm64/include/asm/kvm_nested.h
+++ b/arch/arm64/include/asm/kvm_nested.h
@@ -131,7 +131,7 @@ static inline bool kvm_s2_trans_exec_el0(struct kvm *kvm, struct kvm_s2_trans *t
 	u8 xn = FIELD_GET(KVM_PTE_LEAF_ATTR_HI_S2_XN, trans->desc);
 
 	if (!kvm_has_xnx(kvm))
-		xn &= FIELD_PREP(KVM_PTE_LEAF_ATTR_HI_S2_XN, 0b10);
+		xn &= BIT(1);
 
 	switch (xn) {
 	case 0b00:
@@ -147,7 +147,7 @@ static inline bool kvm_s2_trans_exec_el1(struct kvm *kvm, struct kvm_s2_trans *t
 	u8 xn = FIELD_GET(KVM_PTE_LEAF_ATTR_HI_S2_XN, trans->desc);
 
 	if (!kvm_has_xnx(kvm))
-		xn &= FIELD_PREP(KVM_PTE_LEAF_ATTR_HI_S2_XN, 0b10);
+		xn &= BIT(1);
 
 	switch (xn) {
 	case 0b00:

base-commit: 5d6919055dec134de3c40167a490f33c74c12581
-- 
2.47.3

