Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296670;
	b=5nku3VDj+Ur7+DDFOkJQwDMPWWUtHny0pG4AW7XU16gNc3r7Fiy9xt61Jo7v79StOeHs
	 Pdk3m100QgJ5uuVVbsxrhVRyFAOT5j3pM/Z/KCGNMoNSMFmGKhrJtomcFqkfVbFb96Nyu
	 pzMRq43vBdnVw0Wj2S8ypVKKUfmI4sVrPcNhDQYf8Zy2ScCUd5EoOcmZfj5iBmTr2Iyxs
	 V0agLzfY9mSwg4tfNoUbbXVZK1xtfoc2A6voEzTgOBxxHB5OJRXwp+80O0xiQNT0vhFlb
	 nqk9JCG8VBB3NMDyET9muVsLyuOvKTfo3sj/N6DgzwGVlTENT6dERKW5l+iFoQ47lwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296670;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=j7hB9UmgE5bE7phPFIfa4zIRob+FNIkKK3B6AzXiIoo=;
	b=Kb1XEPNatCqgUWiQSXr+O07N0JaBuiaxZh2RB5Xlpa0h34IV3JW4Cw1AePGXFbrOZXNw
	 zZG61FQmz5zsYg02gsz5wYGld4a205gGtD92qgHRM0TU+N2qcp/L3IwVWJbFC3jt3okpn
	 Tik5RXbvPPplATD0LwAEzr3dojgIUGcoFnkP/5TgzElyHwDVrrllH29bhceTAnDGv13Db
	 jmVNaUwoSSc3FSnS9qZCmG6D1KZY9XYby/advPeAfDGzqxGIyH04B9i85rv2NDu17FtBP
	 7uRiC7ea6hAY96TJXIZFpSgnzwg2mc7igEGbMpwmtJbfwF5QPlgJ3HwOYWwN6d4fNvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eP+97yF6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE71E60A2636
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 07:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eP+97yF6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5615C1F008A1;
	Tue, 10 Nov 2026 07:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794296669;
	bh=j7hB9UmgE5bE7phPFIfa4zIRob+FNIkKK3B6AzXiIoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eP+97yF6ICj3ru+J2WVi/Fz9AhfbYb+Cq/dWuG0kNkQ/xBR+53VaFG7QfW9BH28Pb
	 pUwT/gCukKZBzZsi1QQ1Q4yqZ3cw/KPm3QxM95gz5AXsv+ebAgO2o/C2AoPeQjm16e
	 McrYSHVYogsiTS3Or60xKcK/AhLWcwUR+6IPqBtqlJuu2cWwZtYmfAkaij4qz5EZj9
	 ncXUzbCFGBHQDpesxBkju9rMQ9iT8mZXxJ9fzMvhSRdvCyBLGMfWxud+9a9HXotYlo
	 EoHzSTpFUG/mmRYFR1Vz9IYIpPQwaY8Vfk9NBN5EUOfDqdXoxkwJ0a9QonXV4SUPXo
	 KhzYV1UGreA8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] KVM: x86/mmu: Bug the VM if KVM attempts to walk more levels than the MMU has
Date: Tue, 10 Nov 2026 02:44:27 -0500
Message-ID: <20261110074259.559852-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110074259.559852-1-sashal@kernel.org>
References: <20261107061520-failed-5.10-115f9405a2ed@kernel.org>
 <20261110074259.559852-1-sashal@kernel.org>
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
index 0db6414300d2d..37fa59aa0a3ec 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -362,13 +362,14 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
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

