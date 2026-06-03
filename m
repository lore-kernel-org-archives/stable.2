Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B968338F249;
	Wed,  3 Jun 2026 06:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469102; cv=none; b=YQ6zWC1FEG11zLGf+2LpgaBD7YuGz1tlct0yHiX8rxBJycifIoDyFhmOphpA5ikAnfP7OFyaUTCZakIihykjOgtbI0ubMI9Djy1J/noE0xrclQ0l5C9+vWL9a+aB51wxKoNSCBW/+smJEqUnqpHnANT5WRjb2AQMZHhh/pjXvOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469102; c=relaxed/simple;
	bh=rqsUBhnH/dKfvfEIRcCqGgxOLcrhs1zTyLnKxsShSuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBBPID3Ydlu/LkNa/mP3abq5W5rKeVACu39LPc5kCA2h1ppgmY6GJEzmQDEghkEG0mqmMGOefIeOlCrezPqypplEY+WsKq6kxvGHPZlAIf+XZAWYciEYF2M7+BkqQzK8/xVfY9sapFtF0gL1QgAJEzwT6dOp5YLQ7HNbFRow/Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9yaNg8X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9yaNg8X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042161F00893;
	Wed,  3 Jun 2026 06:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780469100;
	bh=iTLUdDr7rhfaLhCvrgm+quO9P8A4imXJ7Ipa0t0cs/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L9yaNg8XpN9Ca4wKpFXg8n6/BMSZM5Ui0s/uLMhC88fnGB2SPh8eL7ETi15uUU/Jn
	 Gexrze8xT4TXlXkChMCRI2CgGdAhC5XjoiOvix4yRKHgc3C3xQWiPYSGs0MwC1rQVT
	 ESq0tZR74gp5RaoQPt+qoCCy6t594DowVAD7C236qPeAQVI7arQuMt63vfy5Vl7und
	 8ucrPeH/eG1QSyvvoINpSJqACRR3c0Tqa7mo69KYThd6Ywvf4PbNeGmVzA/lX/Dklv
	 F8HIC8O8haPoHO2TN8Ydkb9h6qJMFPZkFkdlNthhXeS6KDJkioSAXAc50hsvPCKE7+
	 6Fin0w0mwUVTA==
Date: Tue, 2 Jun 2026 23:44:58 -0700
From: Oliver Upton <oupton@kernel.org>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: maz@kernel.org, joey.gouly@arm.com, seiden@linux.ibm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Take the SRCU lock for page table walks in
 fault injection and AT emulation
Message-ID: <ah_Nal3ai65tgt-z@kernel.org>
References: <ah7_BAAzHggzdZeI@v4bel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah7_BAAzHggzdZeI@v4bel>

Hi Hyunwoo,

On Wed, Jun 03, 2026 at 01:04:20AM +0900, Hyunwoo Kim wrote:
> inject_abt64() rewalks the guest stage-1 page tables via
> __kvm_find_s1_desc_level() when injecting an abort for a failed S1PTW, and
> __kvm_at_s12() calls kvm_walk_nested_s2() to perform the stage-2
> translation. Both walks reference kvm->memslots through kvm_read_guest(),
> which reads the descriptors, and __kvm_at_swap_desc(), which updates the
> access flag, so they must run while holding the kvm->srcu read lock.
> __kvm_at_swap_desc() asserts srcu_read_lock_held() on entry, and the other
> callers of these walks, handle_at_slow(), kvm_translate_vncr() and
> kvm_handle_guest_abort(), take the lock before calling them.
> 
> inject_abt64() is reached from the SEA and size fault injection paths,
> which run before kvm_handle_guest_abort() takes the lock, and
> __kvm_at_s12() does not hold the lock across the stage-2 walk. Take the
> kvm->srcu read lock with guard(srcu) in both places so that it is held for
> the duration of the walk.

Just state the expectation that srcu is held rather than giving the
play by play. Perhaps:

  walk_s1() and kvm_walk_nested_s2() expect to be called while holding
  kvm->srcu to guard against memslot changes. While this is generally
  the case, __kvm_at_s12() and __kvm_find_s1_desc_level() call into the
  respective walkers without taking kvm->srcu.

  Fix by acquiring kvm->srcu prior to the table walk in both instances.

> Cc: stable@vger.kernel.org
> Fixes: 50f77dc87f13 ("KVM: arm64: Populate level on S1PTW SEA injection")
> Fixes: be04cebf3e78 ("KVM: arm64: nv: Add emulation of AT S12E{0,1}{R,W}")
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>

I'd prefer if we scoped the critical section to only the relevant calls
to the software table walk, like below.

-- 
Thanks,
Oliver

diff --git a/arch/arm64/kvm/at.c b/arch/arm64/kvm/at.c
index 9f8f0ae8e86e..889c2c15d7bd 100644
--- a/arch/arm64/kvm/at.c
+++ b/arch/arm64/kvm/at.c
@@ -1569,7 +1569,8 @@ int __kvm_at_s12(struct kvm_vcpu *vcpu, u32 op, u64 vaddr)
 	/* Do the stage-2 translation */
 	ipa = (par & GENMASK_ULL(47, 12)) | (vaddr & GENMASK_ULL(11, 0));
 	out.esr = 0;
-	ret = kvm_walk_nested_s2(vcpu, ipa, &out);
+	scoped_guard(srcu, &vcpu->kvm->srcu)
+		ret = kvm_walk_nested_s2(vcpu, ipa, &out);
 	if (ret < 0)
 		return ret;
 
@@ -1665,7 +1666,8 @@ int __kvm_find_s1_desc_level(struct kvm_vcpu *vcpu, u64 va, u64 ipa, int *level)
 	}
 
 	/* Walk the guest's PT, looking for a match along the way */
-	ret = walk_s1(vcpu, &wi, &wr, va);
+	scoped_guard(srcu, &vcpu->kvm->srcu)
+		ret = walk_s1(vcpu, &wi, &wr, va);
 	switch (ret) {
 	case -EINTR:
 		/* We interrupted the walk on a match, return the level */
