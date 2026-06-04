Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3275B3F7A9B
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 08:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562600; cv=none; b=jNrTVq5Q6UE8xjMZ7LIHzYE04VHopycsXoSd7Bs84UyNYDADleyatNi2zFXWH5njH7jLbu+G61lDp1p4iCBiR9elSD4QHk61g4a3WlP7gzN3xsIuz1vcGYZVLsLvDpn7Jci4slPTfLPU8/uS0OY8vSyQ/ceMpOfYtFDKlHW/TXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562600; c=relaxed/simple;
	bh=9zwMrrwxWYQBR3y05kjebbVC4fZdDg0vPeu7ichoZ78=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DvjlOxQwBYbzLF2m4bJn9BgKFNS8P7n1vU3bKJjOvioLFAmlZwvAukKpqNW1Jo5wg1F0d/XY4RVfVgRzK0dXo7ltDjn9rkvGuE866KoRUNX8iwzOFUEuYoigpPKb4L62P56Jcg5b42kjbPWKxRVfatqbozG1uE1L07vVZfup0LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H8vfAifn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H8vfAifn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71ABD1F00898;
	Thu,  4 Jun 2026 08:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780562599;
	bh=vtaFPggLExX1fWVOrzeJw7KEMZQKbdyWV6LE+AfcohE=;
	h=Subject:To:Cc:From:Date;
	b=H8vfAifn8m6FSPtr2NKcvHPuEshoHdP13N48eBAuZiIwrS8+iqRDClZT/nrEV6On9
	 TwkA8avUnj/av4G43fC0GhXEuWa3Ei2R0RD/ARnu1P6iXrPGCEVKS4xNW0XLm6ndHL
	 JkCNGe7/azoxr4GTXVyiMfBJ6cmnO+c8seGy8+YA=
Subject: FAILED: patch "[PATCH] KVM: SEV: Ignore MMIO requests of length '0'" failed to apply to 6.12-stable tree
To: seanjc@google.com,pbonzini@redhat.com,thomas.lendacky@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 10:42:06 +0200
Message-ID: <2026060405-uncaring-gamma-5f3b@gregkh>
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
git cherry-pick -x 1aa8a6dc7dac8b83234b53518311bf78231f4fa5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060405-uncaring-gamma-5f3b@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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

