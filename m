Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B077F52FE4F
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950711; cv=none; b=NX80R2XzeOsQF9mMByPprQnh0ZqYatdzFj3cQZOghsBy3Y3gMUuEaGmKwjHTRNrzuP7+vMfI8ZHqoLaJoJYNnob9NBhIMYVW7EFHAJW/7POQ8CBLnxUeGpuGXwAeTaaAdwFzH402LsDMe/xrPh7GAtuHrxWSxzCS+8Bhj4Lpcps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950711; c=relaxed/simple;
	bh=WF0mVgbdGM4ktBHB9mkAWT3e3aoJiso4uwkJXnQ/3mU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BoydP31LqU1kYZQRUgTes6hgLhkiN/Swj4AxRsvzJgYrMRJOUbnQIsWJbRaw1QJg7+BPP+JNKKwt0Faj/x/NvHnZBeja8p1nh2TY2eZp+a4H0v6JCix7XfcHFqAhb89lxrlLkpWm2/ekUz8P7xCVaqwKXofkfsgiyc3WOYvnAR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qaZnWHsU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qaZnWHsU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185231F00A3A;
	Wed,  9 Sep 2026 10:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788950710;
	bh=MYTLXktIqkBIkoHB/osZU289W9jkFCFudAGzssIoFhM=;
	h=Subject:To:Cc:From:Date;
	b=qaZnWHsUG0W/ZaezSdILAMBTGUaubmXR6exUxl331OrrOVtH/xpBNPivwJbW3yo8+
	 ampdkxciKNAw7EnhjqUYbo+B4KsUg03JOgne7IGDFVAfaUrRX/UdfWESdTSX/5LwF2
	 Ff4pZ6VVrYEOUQ3YYEu7oBc63nlSWJWvpoLAXieg=
Subject: FAILED: patch "[PATCH] KVM: s390: Zero initialize data structures for" failed to apply to 6.6-stable tree
To: borntraeger@linux.ibm.com,imbrenda@linux.ibm.com,mjrosato@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:35:23 +0200
Message-ID: <2026090923-egotism-glorified-65fc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 4e2c7f7cbc27418f9a290399b986c1b85ff93b90
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090923-egotism-glorified-65fc@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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
 

