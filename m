Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1490C3FF1DC
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 08:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562593; cv=none; b=DjjftcHp6Zt5KqdDW6RSROCfxXnIlYZpZB02kxLA2o/dCo2NnTNl3MAOcoTfi4sawSXFQQz+k5mGnc5vok4ETYdZeAuSbZ37yc1zaNPHoWY+hgFt0G+BWrryY1HIJaOmmi9R6DYZBUWJqlqGlypoNftPH3iOd3+9ApnE+86sibE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562593; c=relaxed/simple;
	bh=Kn3GTMkhJvNoMMN9DYqq9bq4STRVRkeUsEKH5Ks8Atg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZiQrN8uS8Nb6+jX2DGXlCol0kAppY1AOBTF2+TO5nlq6Knx8kyHdkOIaZ6Iji/jBcOCF+rfazSFmD6wUwYTagrSKgL6IZsxG/8zncXOf70Zj0YjtYRn+hq0pr6GZKJcWAMdDwGMEXjaf2Zz9SJ5If3SSmF2hef9/WM4cwh2mFsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H7XCvu6t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H7XCvu6t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1391F00899;
	Thu,  4 Jun 2026 08:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780562591;
	bh=nG7Fbc8FRKHgmkBqFw+0c4+u6yNOvwMSa9P55vZK9Ho=;
	h=Subject:To:Cc:From:Date;
	b=H7XCvu6t4Y9l/IHbo8QfSkTdvMvNrnjJxwQa0i3+WirRKL6ahlhG1VPvkFVl5KnnG
	 kJzC2LXgNkVPiG+GxFpsbdCP7yW1ExNkLcFfqqYDO8h2Q52uXPP4H+M2jwGQimwDnn
	 KbxN80VOOfHq43jhbGJta0wvUMWJQFrFjsOJLaQA=
Subject: FAILED: patch "[PATCH] KVM: SEV: Ignore MMIO requests of length '0'" failed to apply to 6.18-stable tree
To: seanjc@google.com,pbonzini@redhat.com,thomas.lendacky@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 10:42:05 +0200
Message-ID: <2026060405-animating-immature-f85e@gregkh>
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
git cherry-pick -x 1aa8a6dc7dac8b83234b53518311bf78231f4fa5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060405-animating-immature-f85e@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1aa8a6dc7dac8b83234b53518311bf78231f4fa5 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Fri, 1 May 2026 13:22:27 -0700
Subject: [PATCH] KVM: SEV: Ignore MMIO requests of length '0'

Explicitly ignore MMIO requests of length '0', so that setting up the
software scratch area (and other code) doesn't have to worry about
underflowing the length, and to allow for special casing '0' in the
future.

Fixes: 8f423a80d299 ("KVM: SVM: Support MMIO for an SEV-ES guest")
Cc: stable@vger.kernel.org
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-3-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 23170b64f4a3..fb2174b6d1ba 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4497,13 +4497,17 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 	case SVM_VMGEXIT_MMIO_READ:
 	case SVM_VMGEXIT_MMIO_WRITE: {
 		bool is_write = control->exit_code == SVM_VMGEXIT_MMIO_WRITE;
+		u64 len = control->exit_info_2;
 
-		ret = setup_vmgexit_scratch(svm, !is_write, control->exit_info_2);
+		if (!len)
+			return 1;
+
+		ret = setup_vmgexit_scratch(svm, !is_write, len);
 		if (ret)
 			break;
 
-		ret = kvm_sev_es_mmio(vcpu, is_write, control->exit_info_1,
-				      control->exit_info_2, svm->sev_es.ghcb_sa);
+		ret = kvm_sev_es_mmio(vcpu, is_write, control->exit_info_1, len,
+				      svm->sev_es.ghcb_sa);
 		break;
 	}
 	case SVM_VMGEXIT_NMI_COMPLETE:

