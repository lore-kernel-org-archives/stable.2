Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296299;
	b=obwAtyPh8jrYpX+dYSaiJaW362iGNoJ1xukb8Iuxl6HSXwXRiOS1fkbNIgDz5y6elYTD
	 ltbt9VpQs1z5NPEDlnTxxMQ4ky9W+FlORQ2X9SJ77Yf7cYd8nGqaiKZzJkwGw8LKo5g7d
	 o6nA/gpTqiOUlI1xv9x2aFE1K0QNqkWtHXFbA6jqDYod3WJD3q2+FrF9btJLfq5w7P8fN
	 burT4ORNJ0jAqrpe4IvyAs5Z4bgVlS31hcSFatSCEDrEeK/TB4VN/NPLL2qGldunZzz9k
	 pONg8rWqTN5gzNZDBzN45GPED2Lo0rb/q3tt8fWCsaptwvOn2uu+kDOuPkr3uBwPKPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296299;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MRNR05ywzXoDNMzNmIdneSWE2qR9GCkFL0EWomGoqo0=;
	b=h23s+2EiGKsCfraIcBOMMxLNeJ+JFjyJ2ELlWdmvGJTQ2/GPQTe47Hdm1uURkVB52jht
	 s4UJH+nWligLXL6icmy3ulrQULJ4TgS1XU57C8rl3nqpnCe81iG+LkLETdvW3n+epKGyO
	 lv+8nIw8piCvZbQKBzs1ZWGkffWUPhO7OzwXQpFDdlmmr5SGaC4OLiciDqrHMCOTg9PPg
	 M3DloP8vt+7MpRJ4oSmw78Nelz/F9cDDxDG6JraPyyPEJV5Xb2pT2Lh1ioYPA7nOybooZ
	 6GUINNu0n0zGh3miopv3gPzLl13fvP+TAu3dKzmov8g71j7QE53J0/bw2EwVCcFOxYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JwyrvKsb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22E3606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 07:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JwyrvKsb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D301F0089F;
	Tue, 10 Nov 2026 07:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794296298;
	bh=MRNR05ywzXoDNMzNmIdneSWE2qR9GCkFL0EWomGoqo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JwyrvKsbjy30IljQbItFS4ilUUOfeDvDt5tuqcQz8jhQL3S2u104Dc19Fkcp/eUJy
	 jnFxAhWMqb8rvyTKkwsoZ9g/QzMXHdSN/JQy6ZxQHPnjliNS5BGXv8g0V8O8AaYRwI
	 UEKKNf2XJvkNu5ASyEyUi7Yc+roxcGD0HFpBFTiYbM0b693nGbD0r/YYtxtdqd+M/2
	 1z13yrptDIe7bs/pvOzYnC+jQaJuX7zqeL5q+xsJNTmObAPD9eplGR0AQmNKXedIWX
	 2W2tgsNWpCcS1fFPVakCAztJPMGdOk14BJ0M1JYLpkMkuEwMZyMR+v/c2idORczBBL
	 0tbkqGo7Ekgrw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] KVM: x86/mmu: Bug the VM if KVM attempts to walk more levels than the MMU has
Date: Tue, 10 Nov 2026 02:38:16 -0500
Message-ID: <20261110073556.556612-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110073556.556612-1-sashal@kernel.org>
References: <20261107055823-failed-5.15-115f9405a2ed@kernel.org>
 <20261110073556.556612-1-sashal@kernel.org>
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
index ac139fa59b377..2ffa502aa4d1d 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -391,13 +391,14 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
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

