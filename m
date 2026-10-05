Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556E34AD4AE
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210963; cv=none; b=EdNUQlCEHzigI/t/Fugtquhz2VY60Mb8OxFTuph9hkm+NzbvwdiIV8NVccmHosnrnqlmLLY2PByPdbsXquUbgqk14KIDTf2C8ZoH0YqPtxEH2IEMg+a1jRMiuL2QT1xa2qOpVD0NzvQhpE8Y5JZDTCUuUPk5dsqM/L0RJHawRqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210963; c=relaxed/simple;
	bh=wM8fKp5Y+Z4RRdxgtsBUPOad7x0ATF/5ulF6VpVy1cc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GJCCCPJFzzluZ4l+uB/rQcUa7w0sHI7TVwxPCSxeNyuVtuiRLHFV9p2K04Cionu70P0SKL22CuU1vXG/UkVd6rrIfrtTAnN/z8f2nkstHlnWNyk4vb7UNeKodwomntZ1r3VH1XXdRGqFTeVtXHxOZ4kjwgGyXzx1+72+dW3FcSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BR7NUFAG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BR7NUFAG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2701F000FF;
	Mon,  5 Oct 2026 14:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791210951;
	bh=xRMaT7ytMi7g9bjqDT932CEsTcU1xU15BF8fRT93FCQ=;
	h=Subject:To:Cc:From:Date;
	b=BR7NUFAGXgJImgMvY2p/MEtDBogMSvQuNzghNUZ0TuQMjTLVybhZvK2DDUSK+W+Y5
	 VFOdODYBA608Tty9bK/PVuBD+SDiymeL2XbnZAjS38af77PX7o1m2hGGU+83NN79Yu
	 ikaZnD8Wp4U/rjBRuuPR/E/82KJCZzXbJBPL1ciM=
Subject: FAILED: patch "[PATCH] KVM: arm64: Apply the fine-grained UNDEFs without FEAT_FGT" failed to apply to 6.18-stable tree
To: fuad.tabba@linux.dev,oupton@kernel.org,weilin.chang@arm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 16:35:49 +0200
Message-ID: <2026100548-subsidy-prepay-7444@gregkh>
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
git cherry-pick -x 4bdd2b3a708c1feb701cb8b62feb8ad2fd77bb07
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100548-subsidy-prepay-7444@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4bdd2b3a708c1feb701cb8b62feb8ad2fd77bb07 Mon Sep 17 00:00:00 2001
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 29 Sep 2026 10:00:28 +0100
Subject: [PATCH] KVM: arm64: Apply the fine-grained UNDEFs without FEAT_FGT

FGUs don't actually require hardware support, so don't gate fgt trap
config insertion on FGT. This is the only action required to allow FGUs
always, as kvm_calculate_traps() already computes the FGU bits with or
without FEAT_FGT.

This also fixes a spurious WARN when a TLBI OS is run on a guest in vEL1
without FEAT_TLBIOS on non FEAT_FGT hardware. In this configuration the
course-grained HCR_EL2.TTLBOS trap reaches the handler handle_tlbi_el1(),
which expects an EL1 TLBI only from vEL2. With FGUs enabled the UNDEF
will be injected without needing the specific handler.

Fixes: f5a5a406b4b8b ("KVM: arm64: Propagate and handle Fine-Grained UNDEF bits")
Cc: stable@vger.kernel.org
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
Reviewed-by: Wei-Lin Chang <weilin.chang@arm.com>
Link: https://patch.msgid.link/20260929090031.3829185-2-fuad.tabba@linux.dev
[oliver: Take Wei-Lin's suggested changelog]
Signed-off-by: Oliver Upton <oupton@kernel.org>

diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
index 3806ff0920fe..f59d89d04eca 100644
--- a/arch/arm64/kvm/emulate-nested.c
+++ b/arch/arm64/kvm/emulate-nested.c
@@ -2386,9 +2386,6 @@ int __init populate_nv_trap_config(void)
 				print_nv_trap_error(fgt, "FGT bit is reserved", ret);
 			}
 
-			if (!cpus_have_final_cap(ARM64_HAS_FGT))
-				continue;
-
 			prev = xa_store(&sr_forward_xa, enc,
 					xa_mk_value(tc.val), GFP_KERNEL);
 

