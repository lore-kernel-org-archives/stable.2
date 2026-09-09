Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFC2526A96
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950723; cv=none; b=jmhzSWxX9wPAbtDHgwI9svJSfjjHkYfU7nqO44qAxosncuuaSYE1VcjEjT5XExLh4jrnIf/xJ6KAXeMhCAn7oYR/TwVa5Se7ySfN0JgUY3Npivt7dQm3Pd4CtMpTfn1qPcj7E/n4BUnXw+P5hZzGmh7a+H81yJAF/kh699onCKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950723; c=relaxed/simple;
	bh=EW3L8DEYwfHqiz0WTaiUFp+BFsBnZxhXEjDZVTEnnzs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ucUcQqOnOHN8A/oW1KDWdIt0p7vkQtpKA1sXtheKCp/JOqhocZIDNDLGYn/7Ppyd+6oAcECnKkpwhB5vr1Zia96KI733ftcNFZrSkA5ZMtKhxrjvZ/NpVt3mSzp2loyh5xFgsL0bnde19Xr9TTEkMSB4sAU2YP0lUZZFGCo9Imc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g6mUxNlK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g6mUxNlK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514CA1F00A3A;
	Wed,  9 Sep 2026 10:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788950721;
	bh=d+y6n1eXLqmOdKoProfkia6W/No+9Af+WHL6L9SrH3c=;
	h=Subject:To:Cc:From:Date;
	b=g6mUxNlK883YU9I+FnKiNnsW5Ua7mVTOrzWxlWhDBQGFxtEO1H00Ac1Y3ocKd+DQn
	 ds0BUrJ95/syuESNh6R7pCeuoKHfYgULzw6ZIOcWLz+W6focEgm5eLs83hGWKTZRz7
	 uNMJxNsA/XvbefgtgKjbbq7xN+4yX4Bp81WHwaUs=
Subject: FAILED: patch "[PATCH] KVM: s390: Zero initialize data structures for" failed to apply to 6.1-stable tree
To: borntraeger@linux.ibm.com,imbrenda@linux.ibm.com,mjrosato@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:35:24 +0200
Message-ID: <2026090924-endurable-recharger-fa78@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4e2c7f7cbc27418f9a290399b986c1b85ff93b90
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090924-endurable-recharger-fa78@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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
 

