Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9AD3F7A96
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 08:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562511; cv=none; b=Kvor4Woi9WktpaPp24kwiO7E5u8fxUiGPWeVEs88X1mDQJd+tkzXWFXJ5mudizw49k0BBKatC5OC384D8Quu6NnCguOlXlml16oy7PcfzlwJFZYhH5AL/XZFQQDA6+riVPfJhxuSmpsZ7XhKfRqIsYJUD/JD33lWjkvCWKzmbEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562511; c=relaxed/simple;
	bh=LwQa52A582KF/qY4e0RInI6VQ2VkydoqTePzebXANHU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RsoyLBu4tMxsrayCD1p/6EcSQpoV965SD4zrnSc+/Kbl3tDrLq8vRIRtIFzRkJFibRfWJLgm+2jR2hKm0dr3efgJ70vNSFOaQzjWnAhicqUR4xfabcoBWTIYcQIp5XTihK6uM2JZlik39c77FEozLU7EX+ARq6vghbcf0JkitL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y0b5tV2Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y0b5tV2Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE811F00893;
	Thu,  4 Jun 2026 08:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780562504;
	bh=E8s/JS9bz3nyRSoQFes7LIxHPK382GL4XF2KDcKbBRc=;
	h=Subject:To:Cc:From:Date;
	b=y0b5tV2YfRAitVLMz+Wo+4alXj6P54LCsrJ8dk3nt+ariIxwOPYRztlcQdDO9GhE1
	 TGXjhVHPth+sqhM+aRnOXS0YB2Pl3w3H8t9hErsO1QsawqkEACc3Ql5wxsRCAKDhXB
	 o6Ii4WJjsvyuSyydi8m+Ch90FMgfIzNnTpLDZyo8=
Subject: FAILED: patch "[PATCH] KVM: SEV: Ignore Port I/O requests of length '0'" failed to apply to 6.1-stable tree
To: seanjc@google.com,pbonzini@redhat.com,thomas.lendacky@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 10:40:33 +0200
Message-ID: <2026060433-ion-facial-492a@gregkh>
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
git cherry-pick -x 3988bd2723de407ae90fa7a6f6029b4e60238c58
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060433-ion-facial-492a@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3988bd2723de407ae90fa7a6f6029b4e60238c58 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Fri, 1 May 2026 13:22:29 -0700
Subject: [PATCH] KVM: SEV: Ignore Port I/O requests of length '0'

Explicitly ignore Port I/O requests of length '0' (or count '0'), so that
setting up the software scratch area (and other code) doesn't have to
worry about underflowing the length, and to allow for WARNing on trying
to configure the scratch area with len==0.

Fixes: 291bd20d5d88 ("KVM: SVM: Add initial support for a VMGEXIT VMEXIT")
Cc: stable@vger.kernel.org
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-5-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index e6579ca9f364..52703c954856 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4585,6 +4585,11 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 			    control->exit_info_1, control->exit_info_2);
 		ret = -EINVAL;
 		break;
+	case SVM_EXIT_IOIO:
+		if (!((control->exit_info_1 & SVM_IOIO_SIZE_MASK) >> SVM_IOIO_SIZE_SHIFT))
+			return 1;
+
+		fallthrough;
 	default:
 		ret = svm_invoke_exit_handler(vcpu, control->exit_code);
 	}
@@ -4605,6 +4610,9 @@ int sev_es_string_io(struct vcpu_svm *svm, int size, unsigned int port, int in)
 	if (unlikely(check_mul_overflow(count, size, &bytes)))
 		return -EINVAL;
 
+	if (!bytes)
+		return 1;
+
 	r = setup_vmgexit_scratch(svm, in, bytes);
 	if (r)
 		return r;

