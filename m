Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B5341B8F0
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784201984; cv=none; b=Ufkny8oQxLZoUKs03hMZUEEJoWg1FObUwFPAkISgwwbCArIWXbbC2Jgg32KSLlAedLIODOA6xy11xqHhb41Vn3vqh8m5s9SHJD8DvUv4YXvLl2UmqS85b+ToRATNMaiLee4Cs0HFrUo7K1FsaiHcSarQ3eOJykG84SCoJSQ9Mfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784201984; c=relaxed/simple;
	bh=D7Vi944aPUXjy6501nNTLkaw3+BVi9wjqP0BC0W0qo8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QDXNqvmaRUEU8oftIEJ2w9j0dE+o1BCrN7NXcPg8YmJMhnJHxHn597erlQlWOzQIgAWirWm+xGiaOW+hRijVd0uNES+XolGQcf8Hq3zoUL4oCMjUOrQ6gP0hC3iHmpylPXvjCJTFNs7AegWUqScHY6fbMMlsHr+LCX7rXYuQUzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D650WqAq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D650WqAq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8791F000E9;
	Thu, 16 Jul 2026 11:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784201979;
	bh=gfl/1vr8SVTz9+te+De6Peu8vRizKUAwPLv00dbiVzE=;
	h=Subject:To:Cc:From:Date;
	b=D650WqAqtqVvYEDMsd2QQ/a1oWirU6WP9lsU0zSOgjgPzd/vJParoUpdPNF5zGQE7
	 0/DI03ELs74GZWhv9pEOF9SLW3wZzpjP3g+CpZBTecbzezqeLOn9eU7eBW61QLNp2h
	 EcI0j+BmnlkhhbwniSmJIFrIJmMrg96jYaZ4GWw8=
Subject: FAILED: patch "[PATCH] KVM: arm64: Clear __hyp_running_vcpu when flushing the pKVM" failed to apply to 6.12-stable tree
To: imv4bel@gmail.com,maz@kernel.org,tabba@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 13:39:26 +0200
Message-ID: <2026071626-cattail-yippee-a1e7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x e8042f6e1d7befb2fb6b10a75918642bcd0acf9a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071626-cattail-yippee-a1e7@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e8042f6e1d7befb2fb6b10a75918642bcd0acf9a Mon Sep 17 00:00:00 2001
From: Hyunwoo Kim <imv4bel@gmail.com>
Date: Sun, 7 Jun 2026 02:56:10 +0900
Subject: [PATCH] KVM: arm64: Clear __hyp_running_vcpu when flushing the pKVM
 hyp vCPU

flush_hyp_vcpu() copies the host vCPU context into the hyp's private
vCPU on every run. ctxt_to_vcpu() expects a guest context to have a
NULL __hyp_running_vcpu, which is only ever set on the host context, so
that it resolves the vCPU via container_of(). While this is generally
the case, flush_hyp_vcpu() copies the context verbatim and does not
enforce this, so a value provided by the host is dereferenced at EL2
(host -> EL2).

Fix by clearing __hyp_running_vcpu after the copy.

Cc: stable@vger.kernel.org
Fixes: be66e67f1750 ("KVM: arm64: Use the pKVM hyp vCPU structure in handle___kvm_vcpu_run()")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>
Link: https://patch.msgid.link/20260606175614.83273-2-imv4bel@gmail.com
Signed-off-by: Marc Zyngier <maz@kernel.org>

diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 06db299c37a8..02c5d6e5abcb 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -128,6 +128,9 @@ static void flush_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu)
 
 	hyp_vcpu->vcpu.arch.ctxt	= host_vcpu->arch.ctxt;
 
+	/* __hyp_running_vcpu must be NULL in a guest context. */
+	hyp_vcpu->vcpu.arch.ctxt.__hyp_running_vcpu = NULL;
+
 	hyp_vcpu->vcpu.arch.mdcr_el2	= host_vcpu->arch.mdcr_el2;
 	hyp_vcpu->vcpu.arch.hcr_el2 &= ~(HCR_TWI | HCR_TWE);
 	hyp_vcpu->vcpu.arch.hcr_el2 |= READ_ONCE(host_vcpu->arch.hcr_el2) &

