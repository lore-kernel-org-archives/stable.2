Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93593FE658
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 08:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562575; cv=none; b=E8TwATNkERcJVr9flzkbPOzWeBlVv3m4UiiNvXkq36gTWk6rvlqX5KssMoTbmG17ScWE/SpNgyH2KtLGvkYpuLPhblG+43WpgHqLCQcFxkSbOFrIUlNTmk62Df/m1blv5AwAaIMU7xC7Mj681xFS+6ixSY/uayrj337gmMHq8UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562575; c=relaxed/simple;
	bh=0MOCKLJJJk8IAA1wWWEi6N7vrFjZud2u7eNDCjc94hs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pihQa7uuWZfyWefRg9ej+ZzDlTLkh4bQtEeG+gVf84Hurls0u92VQFNvkhc3Y/yZ6KTavHwlbVAQcFw90Dv5ak4tSJa0f9l9H6G+uvlK9yVH2k8DLh80fft5vjkVLQ8eWvafLoQuoXd3MK4zIAUkB9uJ1uEN5MyyhBteun4UYDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e18WZbHA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e18WZbHA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEAB91F00893;
	Thu,  4 Jun 2026 08:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780562574;
	bh=IVtIjAkswhXdXlcBFa+EYbkN7BICroPXQIMyy0KnrTY=;
	h=Subject:To:Cc:From:Date;
	b=e18WZbHAi+rNBuhOjRBwjAhWEA/gdtTR5d7iA7XLc9viLOeq88wJqOOBN/Kd0x67M
	 BT52R9b5ECjYH5BVI4+4szoNhTst793OHsAIh+xif15gequMqef5aEJ+P6rVkEWLgI
	 KD87JYqXwTj8IGRULy6umO9AeuxW6ZJcY5Yaq/JU=
Subject: FAILED: patch "[PATCH] KVM: SEV: Reject MMIO requests larger than 8 bytes with GHCB" failed to apply to 7.0-stable tree
To: seanjc@google.com,pbonzini@redhat.com,thomas.lendacky@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 10:41:57 +0200
Message-ID: <2026060457-unwed-underling-1ea6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.0-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
git checkout FETCH_HEAD
git cherry-pick -x dcf1b2d4b0564a27e4ca7c654871aab4f9620046
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060457-unwed-underling-1ea6@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dcf1b2d4b0564a27e4ca7c654871aab4f9620046 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Fri, 1 May 2026 13:22:28 -0700
Subject: [PATCH] KVM: SEV: Reject MMIO requests larger than 8 bytes with GHCB
 v2+

When using GHCB v2+, reject MMIO requests that are larger than 8 bytes.
Per the GHCB spec:

  SW_EXITINFO2 must be less than or equal to 0x7fffffff for version 1 and
  less than or equal to 0x8 for all other versions.

Fixes: 4af663c2f64a ("KVM: SEV: Allow per-guest configuration of GHCB protocol version")
Cc: stable@vger.kernel.org
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-4-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index fb2174b6d1ba..e6579ca9f364 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4502,6 +4502,11 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 		if (!len)
 			return 1;
 
+		if (to_kvm_sev_info(vcpu->kvm)->ghcb_version >= 2 && len > 8) {
+			svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_INPUT);
+			return 1;
+		}
+
 		ret = setup_vmgexit_scratch(svm, !is_write, len);
 		if (ret)
 			break;

