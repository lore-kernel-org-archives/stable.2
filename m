Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B474EC677
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781046; cv=none; b=UUDnFRkD0Xh6dxH/y2jgOR3VBcv4q2t6wBHYWa2AD0q37yoZBP1k0xE7nK4GLAebaWc9uMpsidU4F2g/e1LXyda6F7OiOtXvSa+w2E9R5R0Y6pinaFja2YR9BGAwBAzbAb9KzPhQT8hTDAFMz8dwn7owTrdgPHK+WpCVAw+ti7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781046; c=relaxed/simple;
	bh=ecG4bpEmaqHjUcxNt3UumlqcxA5sUvryYiuPZM43gAY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Mg7d9rxca55OcvmC/cVu2mMSgHoBZreQkxrL9Enjq4dX6SJODxILixiQJjNf2w1wMlZRALTWchwmyXYzitGRSgUxoOAF0UPLTf3d9Xlr9SPy8CfH3xEdgO71+XbhwqlRDLUYYRpT8KXQ7YILAXCS4009coMRAWmAViBsFtbP5DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CWC+nOl/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CWC+nOl/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517BE1F00898;
	Wed, 30 Sep 2026 15:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790781030;
	bh=vgh4Ci23kFPvkXkXySNIEdnUcfhOMgczkWx7yKo4pSU=;
	h=Subject:To:Cc:From:Date;
	b=CWC+nOl/7egepxiKsasJMIY39a6rks6CsFEGU4pwTWODGbm/nGF8nenAkZDFdiFds
	 zl7BA3O39Gxo2SSZtHo4rqwHBqKPeusRjzBxYvw9pImsCPEnBMmcQGZYooqikkXi2X
	 vlEmMdrEIHACfozi85ANSkB8x19mKyDQUPRkaGWg=
Subject: FAILED: patch "[PATCH] KVM: SEV: Free have_run_cpus during VM destruction even if VM" failed to apply to 6.12-stable tree
To: seanjc@google.com,fane@google.com,pbonzini@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 30 Sep 2026 17:10:24 +0200
Message-ID: <2026093024-dynasty-embolism-3c71@gregkh>
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
git cherry-pick -x 12c1f6e03f944e399bd2c88441dca5dc702b95a5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026093024-dynasty-embolism-3c71@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 12c1f6e03f944e399bd2c88441dca5dc702b95a5 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Wed, 23 Sep 2026 09:37:20 -0700
Subject: [PATCH] KVM: SEV: Free have_run_cpus during VM destruction even if VM
 is no longer SEV

Unconditionally free SEV's "have run CPUs" cpumask in the VM destroy path,
i.e. even for what appear to be non-SEV VMs, as an SEV VM becomes a non-SEV
VM if its state is intra-host migrated.  Alternatively, the mask could be
freed in sev_migrate_from() when "converting" the source VM, but that gets
annoying because ideally KVM would nullify the mask to guard against UAF,
and nullifying the mask would need be conditioned on CPUMASK_OFFSTACK=y.

Freeing the mask during sev_migrate_from() is also not robust against other
KVM bugs, though that's kind of a moot point since any such bugs would show
up even if sev->active is never set.  I.e. KVM must get that side of things
correct.  But, that's not a great reason to add more code just to make
things marginally less robust.

Fixes: 6f38f8c57464 ("KVM: SVM: Flush cache only on CPUs running SEV guest")
Cc: stable@vger.kernel.org
Reported-by: Stefan Teodorescu <fane@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260923163721.1584779-2-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 5705723f1f41..cdc1c04f60da 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2980,13 +2980,17 @@ void sev_vm_destroy(struct kvm *kvm)
 	struct list_head *head = &sev->regions_list;
 	struct list_head *pos, *q;
 
+	/*
+	 * Free the mask even if the VM is not *currently* an SEV VM, as it may
+	 * have been an SEV VM prior to intra-host migration.
+	 */
+	free_cpumask_var(sev->have_run_cpus);
+
 	if (!sev_guest(kvm))
 		return;
 
 	WARN_ON(!list_empty(&sev->mirror_vms));
 
-	free_cpumask_var(sev->have_run_cpus);
-
 	/*
 	 * If this is a mirror VM, remove it from the owner's list of a mirrors
 	 * and skip ASID cleanup (the ASID is tied to the lifetime of the owner).

