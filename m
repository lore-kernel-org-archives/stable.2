Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF7741A920
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784202037; cv=none; b=t2vOzG8XLCDoff/ObWpRzi9+dKhD1aIla5rm8ztzcfkP5KVg4NqHC++duFsm6BRhpGB2ZMTpUTP+qryOJfGZJaJSO4mLYsMzKqHbLrMHPlWVXC3pExdN2PBlEoVrTOn444KbvxGeBekpRoJ+VNU9SK/SHRWEj5ICdh7dIDnHErQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784202037; c=relaxed/simple;
	bh=O7Wsdmnus0DXGENbd42re/KFawlKB04mDucepRVrIuc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=db++5ndaNr8t17SbrvyCt0vrK9P6CF3vDERPxzDqm8uZY7F39YrpCYJfQrKbkX0xy67/ekvJ8kXRc1jKxaAM6xMCvDTbhig5A6kwZxGGhdnzTM93iJMSvdq9iDaPCCCaluhEkCipuPXuEzip72+eWs15eaIZVl+mjJhu9iqXt20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uAC7csIi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uAC7csIi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7201F00A3A;
	Thu, 16 Jul 2026 11:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784202036;
	bh=rTkdqBbtO95PWgK9tPHV2LtqIMKgEPtjDZ/6ZbhU8UU=;
	h=Subject:To:Cc:From:Date;
	b=uAC7csIiG8ZtWAuRjmYwfrky263d22NnzoEE3jCNgxxQ1zdey3jFYV8hYrYquXsu0
	 nGXjKJRrXtC8k1gApnC7dxXq7xdODbjMYDXeCn1YAKE5BY+gskGOGSxSQ55qUiSuZH
	 Ux+3Cja1ip1v6A6KStf4e/QyVEQUauSFEYiA8dXc=
Subject: FAILED: patch "[PATCH] KVM: SEV: Don't terminate SNP VMs on #VMGEXIT without a" failed to apply to 6.12-stable tree
To: seanjc@google.com,michael.roth@amd.com,pbonzini@redhat.com,thomas.lendacky@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 13:40:21 +0200
Message-ID: <2026071621-spearman-moving-353e@gregkh>
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
git cherry-pick -x 1797e00bf802d64b859ea18505087daad92019c8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071621-spearman-moving-353e@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1797e00bf802d64b859ea18505087daad92019c8 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 20:35:43 +0200
Subject: [PATCH] KVM: SEV: Don't terminate SNP VMs on #VMGEXIT without a
 registered GHCB

If the guest attempts a non-MSR #VMGEXIT without the registered GHCB,
return a GHCB_HV_RESP_MALFORMED_INPUT+GHCB_ERR_NOT_REGISTERED error to the
guest instead of exiting KVM_RUN with -EINVAL (and in likelihood killing
the VM).  KVM has already mapped the requested GHCB, i.e. can cleanly
report an error, and so exiting with -EINVAL is completely unjustified.

Fixes: 0c76b1d08280 ("KVM: SEV: Add support to handle GHCB GPA register VMGEXIT")
Cc: stable@vger.kernel.org
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-19-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20260529183549.1104619-19-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 6c6a6d663e29..7c2ebc81306f 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4520,9 +4520,12 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 	sev_es_sync_from_ghcb(svm);
 
 	/* SEV-SNP guest requires that the GHCB GPA must be registered */
-	if (is_sev_snp_guest(vcpu) && !ghcb_gpa_is_registered(svm, ghcb_gpa)) {
-		vcpu_unimpl(&svm->vcpu, "vmgexit: GHCB GPA [%#llx] is not registered.\n", ghcb_gpa);
-		return -EINVAL;
+	if (is_sev_snp_guest(vcpu) &&
+	    !ghcb_gpa_is_registered(svm, control->ghcb_gpa)) {
+		vcpu_unimpl(vcpu, "vmgexit: GHCB GPA [%#llx] is not registered.\n",
+			    control->ghcb_gpa);
+		svm_vmgexit_bad_input(svm, GHCB_ERR_NOT_REGISTERED);
+		return 1;
 	}
 
 	ret = sev_es_validate_vmgexit(svm);

