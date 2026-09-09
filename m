Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A25530E06
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950720; cv=none; b=T1TWI8BkpufNFbeb8JqiIKblI0+kvVd1lMj1wSkuyj0Hd3WKt597PpuwNI8+XmImxpy4yCuFpXKFke3qAAclVVm+7qRHKmUylT3dczs8OpcEcnlkf55pz1XX5sUz/fOPGcCCsWkvDzIOR91P4/Z3VDzrSJRNHPZqibx8Cje9/ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950720; c=relaxed/simple;
	bh=1wl/i6ANso5agq5tE1c7CC6r30mRzxel4V3XoV6gMYI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PoYgMUJgvUhKq/WZ/WxrVHjUrBXZXf6gBYJdM4TdfRDa6RYMrXGgqaCZOqRzB8//a8rIQOs9ytIvKwpN9VGtlhO4YQvUbsZ2mTLjliwDkPd8GctXDd/1EnUT0c7hUeP4q1+U8Sh/2rDjte07cId/lqGCrb5P5f3SsOxEFilaX5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=117PkCV3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="117PkCV3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E8D1F00A3A;
	Wed,  9 Sep 2026 10:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788950719;
	bh=4wLMJef2ZNTMv+QLJP/78pmpMM0IS/kMe1AlFPvkXtA=;
	h=Subject:To:Cc:From:Date;
	b=117PkCV3ADypXwWMIYAllXoaHczPMCt8PF+pmijnDQR8avFF/EB/slMaUJzJGH4Ux
	 NByh5DdW3e1w0WZw0Usx3uZvB8hEHN7uKxN/FcHAzEgSa3UTcEegmsC3OZJnNqsVcU
	 iG8XQtp3e34+Few8RbkvU6vvcv6iAYuUV+gUVkCM=
Subject: FAILED: patch "[PATCH] KVM: s390: Zero initialize data structures for" failed to apply to 5.10-stable tree
To: borntraeger@linux.ibm.com,imbrenda@linux.ibm.com,mjrosato@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:35:24 +0200
Message-ID: <2026090924-animator-theme-7c73@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 4e2c7f7cbc27418f9a290399b986c1b85ff93b90
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090924-animator-theme-7c73@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4e2c7f7cbc27418f9a290399b986c1b85ff93b90 Mon Sep 17 00:00:00 2001
From: Christian Borntraeger <borntraeger@linux.ibm.com>
Date: Wed, 5 Aug 2026 13:04:49 +0200
Subject: [PATCH] KVM: s390: Zero initialize data structures for
 inject_pfault_token

__kvm_inject_pfault_token() only sets .type and .u.ext.ext_params2 of
the on-stack struct kvm_s390_irq but the full ext substructure is copied
into the cpu local variable on inject. ext_params and pad contain stale
stack values.

Interrupt delivery only uses ext_params2, so nothing leaks to the guest,
but a host user can use the migration ioctls to get to the data.

Fix by zero-initializing the irq struct.
Do the same for the inti data structure.

Fixes: 383d0b050106 ("KVM: s390: handle pending local interrupts via bitmap")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260805110455.7200-3-borntraeger@linux.ibm.com>

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 518a69c55e85..611dcb534210 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4474,8 +4474,8 @@ int kvm_s390_try_set_tod_clock(struct kvm *kvm, const struct kvm_s390_vm_tod_clo
 static void __kvm_inject_pfault_token(struct kvm_vcpu *vcpu, bool start_token,
 				     unsigned long token)
 {
-	struct kvm_s390_interrupt inti;
-	struct kvm_s390_irq irq;
+	struct kvm_s390_interrupt inti = {};
+	struct kvm_s390_irq irq = {};
 	struct kvm_s390_interrupt_info *inti_mem = NULL;
 	int ret = 0;
 

