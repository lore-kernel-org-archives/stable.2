Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512DA37F32C
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682029; cv=none; b=cs3/p4aRI943Paz+Hofv+Cm3Dz4eHggqxKDpuTrKTnQgyRIO88arEhu7LEy8uC8ePutzLSVYoschAheMF/lrIvlnHE5MRrBuGDCTaK/f/tNPk4/iMLo2xO4B4ji6SvCInfALDx6eeetbqBv0eUcIyNZJq9zbpNTfLjlZEdqmoi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682029; c=relaxed/simple;
	bh=CZm1t1Tfr3Qx+LMGRdO1T1gHNSZLlZSStpEMSfiAW0A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aid1/FQZzoVWGovbKJQzmmQWNixolqDP4Gpio7hIFgyxFwBcTFcQj66QMf5F4hDXEnaQXUp2wd9G1cWZVZ1JGOOkYVlh5J4MnlLxfGgUr/XR/JPG7zw26PF6pKbLXqtBmy0Jcj7REKoPfHvVX+142D5Iq8nPO8BsMOj01CnLGxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FD8GhCTQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FD8GhCTQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA8C1F000FF;
	Tue, 29 Sep 2026 11:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790682028;
	bh=CWSzMJKMKw+5BgrhswnvqDxXcW3mA/qLVWPxfcFQboE=;
	h=Subject:To:Cc:From:Date;
	b=FD8GhCTQmsCvviBxUSSG0hs88Nvl6HNxL4Je7VvfBL/3XuVdOm+eoeI323NAVgHfJ
	 7Ngxp+UQ2N4DWkDVlJmpcBPObA8j9e8ebW1vNGNQaBoi9MucjJ0x2npQscafYim4gc
	 BwbnRm9/86Xkx/PNfF/cvgy39z0uDsMpApKhCCvU=
Subject: FAILED: patch "[PATCH] RISC-V: KVM: Serialize IMSIC attributes with vCPU migration" failed to apply to 6.12-stable tree
To: xb@ultrarisc.com,anup@brainfault.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 13:40:14 +0200
Message-ID: <2026092914-dreadlock-impound-a776@gregkh>
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
git cherry-pick -x 8ae12ccaec6ec74945d8c1ef39f2c1b8df779abc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092914-dreadlock-impound-a776@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8ae12ccaec6ec74945d8c1ef39f2c1b8df779abc Mon Sep 17 00:00:00 2001
From: Xie Bo <xb@ultrarisc.com>
Date: Mon, 10 Aug 2026 09:21:15 +0800
Subject: [PATCH] RISC-V: KVM: Serialize IMSIC attributes with vCPU migration

KVM device ioctls are not serialized against KVM_RUN. As a result,
kvm_riscv_aia_imsic_rw_attr() can snapshot the physical CPU and HGEI of
an IMSIC VS-file before a concurrent vCPU migration releases it.

The HGEI can then be allocated to another vCPU before imsic_vsfile_rw()
uses the stale tuple. A GET or SET attribute may consequently access the
new owner's interrupt file.

Serialize the entire IMSIC attribute operation with the target vCPU
mutex. This prevents the VS-file from being migrated and recycled until
the attribute access completes. Acquire the mutex killably so that the
device ioctl remains interruptible while waiting for KVM_RUN to finish.

Fixes: db8b7e97d613 ("RISC-V: KVM: Add in-kernel virtualization of AIA IMSIC")
Cc: stable@vger.kernel.org
Signed-off-by: Xie Bo <xb@ultrarisc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Link: https://lore.kernel.org/r/20260810-imsic-attr-race-v2-1-00ed95ad321e@ultrarisc.com
Signed-off-by: Anup Patel <anup@brainfault.org>

diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
index c1af23e79ae0..f17dc559a709 100644
--- a/arch/riscv/kvm/aia_imsic.c
+++ b/arch/riscv/kvm/aia_imsic.c
@@ -965,9 +965,14 @@ int kvm_riscv_aia_imsic_rw_attr(struct kvm *kvm, unsigned long type,
 	if (!vcpu)
 		return -ENODEV;
 
+	if (mutex_lock_killable(&vcpu->mutex))
+		return -EINTR;
+
 	imsic = vcpu->arch.aia_context.imsic_state;
-	if (!imsic)
-		return -ENODEV;
+	if (!imsic) {
+		rc = -ENODEV;
+		goto out_unlock;
+	}
 	isel = KVM_DEV_RISCV_AIA_IMSIC_GET_ISEL(type);
 
 	read_lock_irqsave(&imsic->vsfile_lock, flags);
@@ -991,6 +996,8 @@ int kvm_riscv_aia_imsic_rw_attr(struct kvm *kvm, unsigned long type,
 		rc = imsic_vsfile_rw(vsfile_hgei, vsfile_cpu, imsic->nr_eix,
 				     isel, write, val);
 
+out_unlock:
+	mutex_unlock(&vcpu->mutex);
 	return rc;
 }
 

