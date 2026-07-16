Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B242B41B8EA
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784202031; cv=none; b=tKr3BICMn/mUqzoJPjEZpOIr7G/TGurOlYt6TfZYaixBP1lKPa9GLT92Xn4tJ3XbtBHQQqsxLI6AfLhcVc4PF9cH/esP1yV94cEagjcRLdrOaGnKpz6LF6+lLvTepIYrmrj6/7WOHcyN9O7Tmyib0X/gejhZdWIX7dPZfhRBy4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784202031; c=relaxed/simple;
	bh=SfOD7tlw3bEkoxVpL3EIL2pg6/GiiFYrAu37aETBAu0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mafMkyrP3BwYB5MSC+OBt2mXnUJHlgRVb0c5m8N+q1QEjozHaBGemUNi3mgdR8QYuQ5O6Y/X/md92mQ7yX7gBRtCprLiFB/7K8HIdZeUqHleDmWRbzPzrVXIiKJqNxffGzgqjycVqNyYuMSIm+81It1GpDcbJ73qEWkk2R2S7yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cQ4NObU5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cQ4NObU5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741551F000E9;
	Thu, 16 Jul 2026 11:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784202028;
	bh=x9vG9Z6T6F8UrO5/1y+QgNBehR0bIyepS1LngJ5G0vI=;
	h=Subject:To:Cc:From:Date;
	b=cQ4NObU5Dvjp4WWnuy8iU6Uxp0wYdfkM371O1MJqiOyIm0MktYPKEfUXjoZoEr5bP
	 aUUcEjNAcx/QfT4QbdO34tuUgSs1Tvxk9PESSgzUnIttXsVV0pitkGeu42IhP01piQ
	 Rt0GAA1teWKKq3aDrWMC69lweDcnK4ZbWZFkoTd0=
Subject: FAILED: patch "[PATCH] KVM: SEV: Don't terminate SNP VMs on #VMGEXIT without a" failed to apply to 6.18-stable tree
To: seanjc@google.com,michael.roth@amd.com,pbonzini@redhat.com,thomas.lendacky@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 13:40:20 +0200
Message-ID: <2026071620-sporting-snowdrop-2d52@gregkh>
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
git cherry-pick -x 1797e00bf802d64b859ea18505087daad92019c8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071620-sporting-snowdrop-2d52@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

