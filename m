Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC67414A06
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550116; cv=none; b=RsWLUrMN9eEFvkDxUBuXqMz1CtcPybweC2dsoG90XGXmHbdXEhHA0uToOKWcmejowrSIF+sj0kdUIzw/NNjPDc50SmHBXIC1kmS6aGBdh2g1vnwkSv0deakcV9Age/sfgh0owArHRNB7HWb/sz8tp8xg1whpRK9syuAYhfeKYgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550116; c=relaxed/simple;
	bh=TnsD0hTj6sHwb1RvYT73R0zOfUGdCp4YZwVmjDVGh08=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uV4EvBwu+wK7r42mc6E055yNewPLOC3XFKosNXmU30vrcI94oLAGBX610bfdcdH5Rn8caP3fCj1hfN830Vsq2vynYd/ei/NT+EMcYJDhHOVtc5eNFCSAWNIiY2bQDaJPmBjJqs0sCIEerNPQ0J9MmfONvX4r8VO8sYFaYcnocVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UQUYsROO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UQUYsROO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F271F00A3A;
	Mon, 20 Jul 2026 12:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784550115;
	bh=uZQ9wr5Xi+A8BkiyUw5z+bJ1YVHwCzHAbgLBvdN7wTM=;
	h=Subject:To:Cc:From:Date;
	b=UQUYsROO1C+bNDOdpjde+hiTPOlKV6+CmWDbDf3n7M3qaFzeU33kXIUWmTmvnzgIH
	 OIhVSHat70UBpMYFHcYcfgl2ktz0gsUAONs540Rvv5eaD2g9e9GlyxjKXSybUh0ifb
	 +XtLWIhtyoj+otYimIGmVV5+TXt61GIO2/VMnofw=
Subject: FAILED: patch "[PATCH] KVM: arm64: Ensure level is always initialized when relaxing" failed to apply to 6.18-stable tree
To: oupton@kernel.org,maz@kernel.org,weilin.chang@arm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 14:21:32 +0200
Message-ID: <2026072032-musty-tightly-d28e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 100baf0184896f859290a684f864b8200d8ac872
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072032-musty-tightly-d28e@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

