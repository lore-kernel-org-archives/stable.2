Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8283F7897
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 08:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562498; cv=none; b=gv96IEHWCYmFHpHjaD3gfMpEfTWvt3UIF645kBF8AScCF2xEkJ6L24+qwxTRyRU8pi7kF6FvejlqG0jWi+VPqQPBLi/ZhB7/cNsARKv0y0jvbL9wZKOzkcu01Ck3PAAw8M3DVrHNjzl1RCwFTSQYYMPK3F8Ya9/NQ+5J2Chgp4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562498; c=relaxed/simple;
	bh=7Y7ib8qwTXCL9NfxGsrlTPaWsgpIV4jwH35tyq9nvqc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YBFUqZatoLQwpvm15An44/FVwX+btdMMiRxstzagem/9W6ATNgqoxIiBF6S/7CsXmnWXaaneB9bUCZCg4dI7Glz/2KaOeWX0hy3vC9a5XsswrvJDqn7ktK+DXEvu0QKXLUzT5vl7jLowIsUsv0eeI9fwkXUALdV9MIK7QFe3Vn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HjMACS7R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HjMACS7R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07091F00893;
	Thu,  4 Jun 2026 08:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780562488;
	bh=B5gYo0u7ChHRtZIhpdreuQ0Z3Gdzuc1tPb/F5DzGPKY=;
	h=Subject:To:Cc:From:Date;
	b=HjMACS7RRipA6fDGcsIXtSZ5CHlptExGnTiUv5t7bFJ3jJcn0cq+J1xSh5Rk18CDy
	 2K1GkFF4xw3wmlihY7rQqDBtjPjLEdO41c3yZgilWzGfvzkP0Mx0eZpXw71IBZTJg7
	 HafT39pOV7fK1zOzCev65QRJ8P/3UxHjR7JU/8i0=
Subject: FAILED: patch "[PATCH] KVM: SEV: Ignore Port I/O requests of length '0'" failed to apply to 6.12-stable tree
To: seanjc@google.com,pbonzini@redhat.com,thomas.lendacky@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 10:40:31 +0200
Message-ID: <2026060431-morbidly-roundish-7889@gregkh>
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
git cherry-pick -x 3988bd2723de407ae90fa7a6f6029b4e60238c58
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060431-morbidly-roundish-7889@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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

