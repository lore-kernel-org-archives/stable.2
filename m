Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819940;
	b=5fEbIyNreioUhZ4NVteP/gXX/F84AEkB9RK9Dyh3EFP4kdRrySz3nnxO5XBksDna6d9b
	 MrgZmZMWBAnuReWi44F+xa2hv+ZvEi6q6/YUepvQM+4MXeKIjfxdFRuaJKTEGwsL+WVhf
	 9XT17rEraWqZeqLCiJ+ie3hEVpCtslyqWcun/RUA/twt/knRBUSR/2G6jOkYinge+PkEv
	 F9zMWRemSe4XsiRdfBwhqRHp/gXRFMGHFpCFrcQqwjTNErbb6JrGW65MlOQYAXaEhpM8B
	 bBWb2DdV9no9bGf3FkBqshEOjTN0v6G6TEd3M/rZXf0td90Z8ix9bN1ym9bUWbYLQnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819940;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wILK9Jud1UPBfnnpgz5cYI9CgidpRAc6SKwjnSPSOM8=;
	b=0JebcZnBk49hT7rCSoVT+6bVYSE17/7QZ2Hwyuxyg9Ryf71HB6ZOO7ExEOQEFudml0Cp
	 5/ik6pPMULTwXy5rpqho+N4ZiuUz60PNw4t/sYWK4/bkHhGQ5FDHyko6b+nSH/3fUbNUi
	 HYe9orVpZtEttSoXo3U8shMS0YGIxGpVxNnMG6HjjRIxB+s3GtW95u5qRBwCyDhGgN1i1
	 ljN/szEeGGELdwCf29PWs+FrLljZN2QekxUD5snnDsEnRMdqiqSXtSrPXRfbHZYWt1FFB
	 EemciX9ItUUHL0GWTWBO4Qlmzbv1gIs45KIpfv++bqL+GBZowxLyKb91gWl5EW7YsdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="DzIm5/13";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4E7606C924
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=DzIm5/13
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B7D1F00A02;
	Wed,  4 Nov 2026 19:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793819940;
	bh=wILK9Jud1UPBfnnpgz5cYI9CgidpRAc6SKwjnSPSOM8=;
	h=Subject:To:Cc:From:Date;
	b=DzIm5/13P5n1kyG1Bl3dQiP9O+nyIlfYwbANU+7mMOosiXCU2/QBF1rd9crRjJR7B
	 vynHzXbTt4VsKGSKB0zHpctKNAsX0krV9Rk4rvlDakd0JaPXH1mdvRS1d7n2paOMAX
	 JH/z9J3xJ3QugRbq9FclGOFkiWoT/vQC5c8L9g1o=
Subject: FAILED: patch "[PATCH] KVM: VMX: Preserve negative return value in vmx_handle_exit()" failed to apply to 6.12-stable tree
To: xiaoyao.li@intel.com,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:18:58 -0500
Message-ID: <2026110458-starch-scroll-7508@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x cef48693da1e964e9f192bfc16cd0ed287c48337
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110458-starch-scroll-7508@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

