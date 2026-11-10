Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794295832;
	b=Xpr2N1ZCq1Gbc09WdRUY3X1gMkQGMBO4jGEX22cXb/Kmzsyvb0vUgjSzSgoZj0OJ2WVk
	 AYfdqhxAGCQUGLu44A1nWAZ2jaCjPDlAsx8Ky3qhC5g1BgJnklfAUcgn/QvUGfc7F/GZH
	 AdpJR13TcOfv5Prv7RzMIV9tEVs8fqo47puuNKreaA6HXTkio3nM31ue7NZ6th8CoCm4M
	 qqyf3NDsxlmBYdeIcHrb7vAcl+Id61dqv+nBPT6Hr0Vd2RhIrtOmQ2pSU+eSV3PyTxcfw
	 InfFaiHaelC2J8XTHF5cPHNh/I4FyD4v/XJWmoesMr+55H5cZ/gDEg971ScFg/Q8sFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794295832;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=n/mipAiPAsiU1Qihd7eL8JbMbD0pDTKsgAcGw/m0GFM=;
	b=ntArVCpdeZH1S38jnTeW6p22pe5DwUsCMqYtd768MSYJvn/Yt77VIxuGfvXTHaSPeKUi
	 wctNHHI/KkJG2HgjdBAzqumESKB2jHLmCkk1GTfRNWutq5SRoWRitMeewtpUtkvD8Gbah
	 Tl3jWAd5Vjq0PV+2Oci3Jyzuq2ApCzfr1q2P42NsjbDLJd+VtLBQ5vFHSiY36N5wySdd2
	 bb/wzWoi/cg6PNSRiZLNUuRi8FCF3QxGJczRTnr2+gXPfe2uqyMED6QZdoc5Y7BhUzi81
	 4MbG3acdIDidFDtBroySoZbWEQTcDgzgkzxwAVr+fseLqqUXjfs0/woPCuy/BbnmzbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B18o8tLT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7847606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 07:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B18o8tLT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BDA1F008A2;
	Tue, 10 Nov 2026 07:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794295831;
	bh=n/mipAiPAsiU1Qihd7eL8JbMbD0pDTKsgAcGw/m0GFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B18o8tLTTZ5HKsccOhnSL0/DSvNlOiRqJ7XJOwUsFtIpsEkEOcITWkxlN8ODxIFWY
	 0DvrW54X5Gyqbw8GeCL1sOJAG1FYYZDQAq4sd77prmi5R5Pki8n7yn3Ym+bVMMSPIf
	 J9eplEBKrBaw3k29xydbXDmJJighZv6X3lIGWfQKXSzQHcfPSsFnJ60UIV61xcX0WH
	 AfkbVWIaaOsKrGQx1sLfNOkRoua2SaDvzUPvzqrnIfvkiv6ZRpjwIDgCeY9NgUcgTn
	 L1qbmAwLhOsI2+V5O3UcWVRI5Eo63oqaYPwBj1Vx4yOWe43TGJ+d07BFMppM9dmctH
	 kDJAqyKwSsAqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] KVM: x86/mmu: Bug the VM if KVM attempts to walk more levels than the MMU has
Date: Tue, 10 Nov 2026 02:30:29 -0500
Message-ID: <20261110072540.551383-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110072540.551383-1-sashal@kernel.org>
References: <20261107054141-failed-6.1-115f9405a2ed@kernel.org>
 <20261110072540.551383-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 115f9405a2ed6d78ee7ad8436bdd638743f6d1d4 ]

Extend the "EFER.LMA && !CR4.PAE" check, which exists largely to guard
against KVM configuring a paging32 MMU with more than 2 levels of paging,
with a very explicit check for exactly that: that KVM isn't trying to walk
more levels of paging than the MMU template provides.  I.e. harden KVM
against all bugs that would cause KVM to generates accesses beyond the
bounds of guest_walker's arrays, regardless of how KVM ended up with the
misconfigured MMU.

Note, don't use w->cpu_role.base.level directly as the paging64 template
only provides two levels of page tables for PAE paging on 32-bit hosts, and
handles the third level by manually emulating the PDPTR access.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260902232028.2767071-4-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/mmu/paging_tmpl.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 42d459370f781..4ff63e273687c 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -356,13 +356,14 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	pte_access = ~0;
 
 	/*
-	 * Queue a page fault for injection if this assertion fails, as callers
-	 * assume that walker.fault contains sane info on a walk failure.  I.e.
-	 * avoid making the situation worse by inducing even worse badness
-	 * between when the assertion fails and when KVM kicks the vCPU out to
-	 * userspace (because the VM is bugged).
+	 * Queue a page fault for injection if any of the below assertions fail,
+	 * as callers assume that walker.fault contains sane info on a walk
+	 * failure.  I.e. avoid making the situation worse by inducing even
+	 * worse badness between when the assertion fails and when KVM kicks
+	 * the vCPU out to userspace (because the VM is bugged).
 	 */
-	if (KVM_BUG_ON(is_long_mode(vcpu) && !is_pae(vcpu), vcpu->kvm))
+	if (KVM_BUG_ON(is_long_mode(vcpu) && !is_pae(vcpu), vcpu->kvm) ||
+	    KVM_BUG_ON(walker->max_level > PT_MAX_FULL_LEVELS, vcpu->kvm))
 		goto error;
 
 	++walker->level;
-- 
2.53.0

