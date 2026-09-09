Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF199485CD8
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950709; cv=none; b=a+4vo5DK4rGoMMhswmXPCk50Hbgzh2DoLUiaSe4SIIlMdG71utQUOSpv2TvYfk4aeiBCd0q9ihkjEIy1YCE2mDXc5Z885WZk3Bsngdhndpx3zfyvE9GPHcUdkyV3JTnC4DXcxkm1hEYkbwN1xpXLST+dSjE+XAyBnl1IXAkaE9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950709; c=relaxed/simple;
	bh=Zl3MvifUtO2zwlIain+AbStGk9ZFQxeByZl5hko4M8Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HozSu/S2JPo1eACYGjVurLM7ioIvyWqwaWvxS8MwKwmlDgXdMA9uUH59AXCQWXPLSObSK3nQZ1EeWfnsLzkj9vAFd3HndnFon/nfbd1jfqCLhCIpuFwJUBS3RjlCuLfZ+ou4dVJ/g1Ujwy8s6JNiX88mcVADGEyQjCN+vlSQ6Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kr0S7wvi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kr0S7wvi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4431F1F00A3D;
	Wed,  9 Sep 2026 10:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788950707;
	bh=z2ciGKEmdQCE7+67kr876/yOUPKKXJ0mOIh8bnmRXnc=;
	h=Subject:To:Cc:From:Date;
	b=Kr0S7wviILWgh16LubPjYEC+g0opOAoMO9n9Q2KIk5TsvTJJ7ULwxE8h9NNh5vFXW
	 yjIUQVPkPMsSGidRRiUtjRD2LnsOasKWKos5aq680fS/YMsbcGSvqxQFpQd0HUtG8v
	 +nN30HosAhoUNl9lZCzcdfSC7m/SXkkcs19i/THM=
Subject: FAILED: patch "[PATCH] KVM: s390: Zero initialize data structures for" failed to apply to 6.12-stable tree
To: borntraeger@linux.ibm.com,imbrenda@linux.ibm.com,mjrosato@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:35:23 +0200
Message-ID: <2026090923-boondocks-sulphate-e6e5@gregkh>
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
git cherry-pick -x 4e2c7f7cbc27418f9a290399b986c1b85ff93b90
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090923-boondocks-sulphate-e6e5@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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
 

