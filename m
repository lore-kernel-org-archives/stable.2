Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94373E7BC5
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 08:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562585; cv=none; b=bFmNxwD1CIH4rmvQKDP9naXE5wW4cDwwzO/dgDES4RTuQCl/38ZRn/SvIrUePMlcX+w46YyuMXL50xcX66qWHk8FZEIG+z0NjMHufjleD9SgXc2cIrNwvMzECMeGKU7dHzpcWaHGwoMjNzx8W3Iv8f7Ao5021HhFPiFNq5KGbs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562585; c=relaxed/simple;
	bh=LlVaHHKNreDqrAgsZmX3obR/wUgACqksUy16IL59Uik=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SW4FGwWY9FLwEvGLcKHUF3TpLRXKU3atvc4kOk+SNYeGvIEcH78qvJVjS7XyilrChgKvhGdpoL56sMymPRkjSaPhOC0pTjCLOwflnVg87UJehK5AE7/1IGkqiG8xwTcZcdUCTVTKk6xa2murPQ/47fACaxThDspDkyzo7blIdE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y4EbSURH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y4EbSURH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFDE01F00898;
	Thu,  4 Jun 2026 08:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780562584;
	bh=xTV384x7qp7V4ND+iz3ft/ZGdRYqNqF/XDNoKSpI79M=;
	h=Subject:To:Cc:From:Date;
	b=Y4EbSURH9BCIVh7vRYv196MxlYQyGHSXco7kOmnONoIWgSHDeoBcWvG2hdiWegX7j
	 B45sPRv25GWOX2tXYBJ5GEgRRiNUmwz5ZKBh4i4lXxF0J1kfbmRTCYQXiXnozAaJ8r
	 3G0jIGrlwyyGBaYHqvVXJl552P+wH4TIZXsnzry4=
Subject: FAILED: patch "[PATCH] KVM: SEV: Reject MMIO requests larger than 8 bytes with GHCB" failed to apply to 6.12-stable tree
To: seanjc@google.com,pbonzini@redhat.com,thomas.lendacky@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 10:41:59 +0200
Message-ID: <2026060459-alumni-duplex-df4d@gregkh>
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
git cherry-pick -x dcf1b2d4b0564a27e4ca7c654871aab4f9620046
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060459-alumni-duplex-df4d@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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

