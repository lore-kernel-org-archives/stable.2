Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046980;
	b=OHWO0aQFOISpxkcU63Q/CUcPhQL6WyJs4whurltUDKqh/kQqNPrki46mVmFG1b0mY2QW
	 WzMsRU/vArGbFeurGa5Zwf5M3nDhsRGdnGrrbB7SLJZewXwn4ZPvZK3ZCkw9aS6OA2ACF
	 mON2TE/dsF06RhI6mfU9GiAoziC4cliL2OpKgLfQDJf1fI+zjeuYTsgxUJ46Um45U0G7Q
	 nKrm+GQWnKdwJWlFCy7gmKyKu/BHRjbHn9GYTDgi0AtmOqTMT/I04E1wiqGbJAEUIVo7V
	 yF3GHXB59JrN2Bgi5kQ0xxJnp0SFrendjQtjdB+9GOdAM539fLiHIIA0mYhc1yFiOlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046980;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=CO4r4ZhF3CFLUQrNSkOYlPZkD0+Bf1K/4NqK4eB5N30=;
	b=XERTZBeCLJ6Lbxb7xfMGeo6+JSPMsO2hUHFEKg9xNYFtSv3/yJoBBnqEiJykGwDJXM10
	 DXOgCwlXKxeyBAiEP8BZrGUVSV96gQczmMaENssOXvNUw6dbCdbP4mkTmWPK+L+rWKGVM
	 MM/c2aajDaYqABiJ/tM5lYTuShW9kwyDkwvMWIvRzPM9TLHoDUJINaCxcdKDUsjTRFtFH
	 U3YQ5W2UQcCWxJ9ug356eVqBRmmvCEDS7+Om1bO9Yv3PdSnQ0ivJyb3qA/5ucAqTof3h4
	 wlD5bBchPPW3o66ooFvAbHlprc3z5NvwNhPceRHEGjtZ5OLKWrJ46ZvKGCVzITjHDyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lUkWoRG9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48324606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lUkWoRG9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68A71F0089F;
	Sat,  7 Nov 2026 10:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046980;
	bh=CO4r4ZhF3CFLUQrNSkOYlPZkD0+Bf1K/4NqK4eB5N30=;
	h=From:To:Cc:Subject:Date;
	b=lUkWoRG9t5H0usixob4/riWOBzJYI4V4NEXD2rufTeORZoL+r5lnUyvjTGlroa5S2
	 R6OrpbhjCujjHa6NVYr57wZDPNwGD1tlZpor4qbK7MEZqRMJatwfhiiFwExzp+62Lc
	 cWU09MmWKGqi0fBgRmlXpiPX02cjlimxuZ0NLStVvw5XDNtgh07GZ7VqzdRbs+0SKJ
	 ye1o2awc+Mk1Y3nSQJAEvclBFx1IwOXRVvIGoFilg130vGv7in+zJ6tfm0U7oCYlMk
	 3rlYLOpNkxt2Sq6/aci7qUOwY/PYfsQTTEQ7Weot6Exf0XZ/e0V/NY4L7nfGQusBgw
	 ZZsO558mfD6Pw==
From: Sasha Levin <sashal@kernel.org>
To: maz@kernel.org,
	fuad.tabba@linux.dev
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: arm64: Move IN_GUEST_MODE ahead of state being loaded" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:22:58 -0500
Message-ID: <20261107052258-failed-6.12-22b6557ad05b@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 22b6557ad05bf05c73246f62c19af3e04017270e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052258-failed-6.12-22b6557ad05b@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 22b6557ad05bf05c73246f62c19af3e04017270e Mon Sep 17 00:00:00 2001
From: Marc Zyngier <maz@kernel.org>
Date: Thu, 15 Oct 2026 11:05:35 +0100
Subject: [PATCH] KVM: arm64: Move IN_GUEST_MODE ahead of state being loaded

IN_GUEST_MODE is advertised too late, when state has already been moved
onto CPU registers and cannot be observed by another CPU anymore.

Move the IN_GUEST_MODE publication ahead of the state being loaded, and
immediately check for pending request. This ensures that there is no
window of opportunity for another CPU to observe OUTSIDE_GUEST_MODE and
yet for state to be loaded.

This also simplifies the "state rollback", which solely amounts to
synchronising the timer when no irqchip is present.

Cc: stable@vger.kernel.org
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Tested-by: Fuad Tabba <fuad.tabba@linux.dev>
Link: https://patch.msgid.link/20261015100539.1011760-4-maz@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/arm.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 7ce9f3bfa7fff..cadc82ba5a5a0 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1321,31 +1321,33 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 
 		local_irq_disable();
 
-		kvm_vgic_flush_hwstate(vcpu);
-
-		kvm_pmu_update_vcpu_events(vcpu);
-
 		/*
 		 * Ensure we set mode to IN_GUEST_MODE after we disable
 		 * interrupts and before the final VCPU requests check.
 		 * See the comment in kvm_vcpu_exiting_guest_mode() and
 		 * Documentation/virt/kvm/vcpu-requests.rst
+		 *
+		 * Requests to self must be posted before this point, or
+		 * won't be taken into account until the next exit. No state
+		 * loading other than what happens at vcpu_load() time can
+		 * be done before we have checked for pending requests.
 		 */
 		smp_store_mb(vcpu->mode, IN_GUEST_MODE);
 
 		if (ret <= 0 || kvm_vcpu_exit_request(vcpu, &ret)) {
-			isb(); /* Ensure work in x_flush_hwstate is committed */
-			if (kvm_vcpu_has_pmu(vcpu))
-				kvm_pmu_sync_hwstate(vcpu);
 			if (unlikely(!irqchip_in_kernel(vcpu->kvm)))
 				kvm_timer_sync_user(vcpu);
-			kvm_vgic_sync_hwstate(vcpu);
 			smp_store_release(&vcpu->mode, OUTSIDE_GUEST_MODE);
 			local_irq_enable();
 			preempt_enable();
 			continue;
 		}
 
+		/* From here onwards, we are commited to entering the guest */
+		kvm_vgic_flush_hwstate(vcpu);
+
+		kvm_pmu_update_vcpu_events(vcpu);
+
 		kvm_arch_vcpu_ctxflush_fp(vcpu);
 
 		/**************************************************************
-- 
2.53.0




