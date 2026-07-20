Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52868413D76
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550119; cv=none; b=kBLg865T0CZ30aHsI5x1uOXb9E86hQ6rOmI/gzLcPUKs91vcQmMH84rmYlqHIxYqLl+Lts4C0G+5YP2yaCr7O20VtjXuwO1DsQW/DtG2k9iHCDk2ppuEyVIHq/5/lzLCnRXCsp5aLxfuSQSp7lgB6E0J+Ub1gqi8PzXT+RePDSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550119; c=relaxed/simple;
	bh=l/lIkch7nyPowj46uEwHRQlUuBwkoWUs+E1LDKuwL/0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TcK/32IVQF4Uku02CktKOLty3O4AudK488ifBoRpHyf2O8DBEecU9dNBBic+fC51n9CuGNzboxAjaB9+qcMXuDg6qAY/NvUxPhjC7ivrsDFnF2t8SQcu3rbAeUT2wYtT2Ei+2GYK4PwsLqWfnFK4Iyx/K74XeBoFclcbGuDASWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lBeamBFu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lBeamBFu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D34F1F00A3A;
	Mon, 20 Jul 2026 12:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784550118;
	bh=N1KhCUCmnbcstkYMCgSfsxUY7X0Bat17PPWx9IZ8nI0=;
	h=Subject:To:Cc:From:Date;
	b=lBeamBFuM7Q4Dm/UBXLTwYJXPu/mJjVn5H8PIzEmfKf+GCsZkoHjD1p27r4EjxozV
	 NiQqz9AZZwt7ZjY0EzHCvMKB7cOYIKOup2nAgN2Nd5sDKpdNopln8+u8+q+npw3/at
	 MhuPtMb/bmzokS5/XjfFkQDGzmV/Tlqiu1L1NGb0=
Subject: FAILED: patch "[PATCH] KVM: arm64: Ensure level is always initialized when relaxing" failed to apply to 6.12-stable tree
To: oupton@kernel.org,maz@kernel.org,weilin.chang@arm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 14:21:33 +0200
Message-ID: <2026072033-wrinkle-closure-7d3c@gregkh>
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
git cherry-pick -x 100baf0184896f859290a684f864b8200d8ac872
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072033-wrinkle-closure-7d3c@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 100baf0184896f859290a684f864b8200d8ac872 Mon Sep 17 00:00:00 2001
From: Oliver Upton <oupton@kernel.org>
Date: Wed, 1 Jul 2026 16:16:19 -0700
Subject: [PATCH] KVM: arm64: Ensure level is always initialized when relaxing
 perms

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

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 0c1defa5fb0f..386a7468136a 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -1356,7 +1356,7 @@ int kvm_pgtable_stage2_relax_perms(struct kvm_pgtable *pgt, u64 addr,
 				   enum kvm_pgtable_prot prot, enum kvm_pgtable_walk_flags flags)
 {
 	kvm_pte_t xn = 0, set = 0, clr = 0;
-	s8 level;
+	s8 level = TLBI_TTL_UNKNOWN;
 	int ret;
 
 	if (prot & KVM_PTE_LEAF_ATTR_HI_SW)

