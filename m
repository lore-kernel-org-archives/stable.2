Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819945;
	b=P91VUD3f2rqybuLzLN/qkkMGAQVpFB4NPK4QQPKv4Tw8MPeDXd1Av+Szoe46yxIDa1k3
	 iVBUp4OI9iFtRBWnngcTcjYSdBnFRyosU89vyr0ApPEjSiULvqlor8Lt2MByiok9Xhz89
	 tNR0bJ34l5Yl70SyfMlAtEjeP0McPoSyatuHp2IUy3ynBCADoJWuJFpJfDjO4onQrph9w
	 1WdTa5odcZ6wEmQlLYUvBoY/QA8mQZdXRnUUKUPWMvvDO43SOxMkm15Y4uRNEwEuWdM28
	 fxRyAQQ01112aa9vKpzL5dGScI2RpHS2+QrMGYc503jVXWkpIZ3oXak1PwBCpjSXyBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819945;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bhU31nf4hhO7GtrkowpV5PZgpvAJx7GyOrPeOFI2gUQ=;
	b=03m0Kc6gbpjZ+oVTyYXIKg8Olacu+i9gSgnK2+A00k45gPhAt0kooJQIkU9R0usTo5Xf
	 YgPrV29sXI4ob5lAHQe3iIyEH/9eyHpj9BSNT99/JY5RdT+qf2NIsH+Vz5wwYNAtx6yll
	 RQ61l1Hu3if/D3Dvf9P/PKvRFpi4s3zTXkaKXA0Jv+Zu3zPvnxHjV7sDU+3A04c7U+zjJ
	 L056KleAGQIh/52TaAPV/obr1wI0FjOGkcXxg+IuxzwaHMpZMTez/pToxafQyPgDy8LC2
	 WpYXOF/h+Huu7d1pj6XwQ6ntxuHSlpBKQxiIzXvX/rXZAxgfRqo2VhRHn/y5Ccnz/zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=OFtNbPNI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCDE606D830
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=OFtNbPNI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904BB1F00919;
	Wed,  4 Nov 2026 19:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793819944;
	bh=bhU31nf4hhO7GtrkowpV5PZgpvAJx7GyOrPeOFI2gUQ=;
	h=Subject:To:Cc:From:Date;
	b=OFtNbPNIgjwh7BboWaO5eDEwqFfFqXJgbk2qYBnJVJtAVThX2piuExn9Oy0JeLUb/
	 x5bXBrWhPpH/41me1Tw2Xk+U66ZIFj1RTWfojD7jV9smqnbYYUmLupNuMzXBcmRikJ
	 h7CeJw5b6r1DrWV3Xb1p0qEZXZ8WfpD3nwiicGag=
Subject: FAILED: patch "[PATCH] KVM: VMX: Preserve negative return value in vmx_handle_exit()" failed to apply to 5.15-stable tree
To: xiaoyao.li@intel.com,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:19:00 -0500
Message-ID: <2026110400-steerable-maternity-eeae@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x cef48693da1e964e9f192bfc16cd0ed287c48337
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110400-steerable-maternity-eeae@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

