Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819943;
	b=FN3GSYVyMtjDSIp+ap2zPaCRlQa726ALOdj/iLmhbz5M11LrmgXU0C7ak2LWrfERA+2X
	 ORP3xpz5e7HX4K7jiaZPB4XWap94v6kdAFXIFHTRbIoMH+gUbSGXy1FFA8uVJVS451mhN
	 SjWIY7ko+j9Oh6px3ozVV7kClZCDfBLEwOlMArzVTjLYxKfu2TIU7Kbk44MERX8qH1lQN
	 JsOJrf/vGNwVj0+rK4k4pwZBSsJo4leu5ZVKOGRQHtI28IoOkuZmB47bJt7iP6B8vMVlP
	 1j6y35axiCboP4U1CQ3hgxxG7gXvnyvSQ/rzxQiGSMUCBK2Lb47AzEozGYWGufjJA5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819943;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PIiF6RmHkEDMjG/kAQYcvho09nv2Ri/FtFMmUilV2Z4=;
	b=OWnmijwDtBLtm+oSMTYcKY59UikhO9e56EXF226PWAyioGT8cAcSSAuJ/1weADn2AnXA
	 4yowKo8H58K5N5hLJeltKUpvOQ84G1sjqgrDRv+4W+RBErgjeLzyTSn3uuq1yjGvoshXI
	 C8ULI6lzvraf67BLNBcEHApLgS5QqYKb70Hu9PneAEFexTshrg1t0Uxc4nFovWJOZ61Ra
	 pedpHX3WPbL930uQ3ZXaQ1cVRT21457/BMKKBJqO7zvdKp5zOnFidcLlHH0HJkcTCt45J
	 fv5MB9hXf2ewMAm4YJ/GOQMiIxLQSDPk34/ZUCJRKWyGy39s1TMGJB34eNjTHupuABQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=c8pQS6O5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF18606D830
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=c8pQS6O5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3111F00919;
	Wed,  4 Nov 2026 19:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793819943;
	bh=PIiF6RmHkEDMjG/kAQYcvho09nv2Ri/FtFMmUilV2Z4=;
	h=Subject:To:Cc:From:Date;
	b=c8pQS6O5ze0gahWbyaVQdIJN++7a0gqvmq7VASpjpLW6RHtOPvlgVine8s/l7QE0k
	 marcSwMOBsnT/2BDkrjbsO2bTXH5k0ZaqeILzAR/A72VGPhX7/ULOeY+guukvwHqoa
	 jEe0WCxBNBmn1fW2yoO5yS6Hms+PAb8JriGdqMCA=
Subject: FAILED: patch "[PATCH] KVM: VMX: Preserve negative return value in vmx_handle_exit()" failed to apply to 6.6-stable tree
To: xiaoyao.li@intel.com,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:18:59 -0500
Message-ID: <2026110459-cone-playlist-3832@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x cef48693da1e964e9f192bfc16cd0ed287c48337
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110459-cone-playlist-3832@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cef48693da1e964e9f192bfc16cd0ed287c48337 Mon Sep 17 00:00:00 2001
From: Xiaoyao Li <xiaoyao.li@intel.com>
Date: Wed, 19 Aug 2026 17:49:00 +0800
Subject: [PATCH] KVM: VMX: Preserve negative return value in vmx_handle_exit()
 with bus lock detected

Preserve the negative return value from __vmx_handle_exit() when a bus
lock is detected, instead of always overwriting it with 0.

The purpose of bus_lock_detected handling is to force a userspace exit to
inform userspace that a bus lock happened. The negative return value can
achieve this purpose, and changing the negative value to 0 fails to return
an error to userspace. So, preserve the negative return value.

Fixes: fe6b6bc802b4 ("KVM: VMX: Enable bus lock VM exit")
Cc: stable@vger.kernel.org
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260805034602.5B2BB1F000E9@smtp.kernel.org/
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://patch.msgid.link/20260819094903.3060020-7-xiaoyao.li@intel.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 965141e0d4c8..6df390ae8708 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6864,11 +6864,12 @@ int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 	 * a bus lock in guest.
 	 */
 	if (vmx_get_exit_reason(vcpu).bus_lock_detected) {
-		if (ret > 0)
+		if (ret > 0) {
 			vcpu->run->exit_reason = KVM_EXIT_X86_BUS_LOCK;
+			ret = 0;
+		}
 
 		vcpu->run->flags |= KVM_RUN_X86_BUS_LOCK;
-		return 0;
 	}
 	return ret;
 }

