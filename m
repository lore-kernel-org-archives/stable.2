Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AC052D2DE
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950746; cv=none; b=mPq+HGnXxXhRfPLUG2M/D5v4F2CY2HaukiJwv/NskuqB0ojWlr53tt6UElmY6d1Mle47OB53lC0KWlY+DxA/xFYfgsvAyDBAXp8ceBzJ8jFonoJcJcWhvmozx619gtqfviIofGGZzTftYxSx4Krju4IX2S3Qx0FZsQuT68/S50s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950746; c=relaxed/simple;
	bh=LVRiAGN5VVF3RryATQiPDwrWOh35NaN9jZYRZHfikeA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QxeG4hdocZqP+FIoxzdH15Y2CgmEjKmSAAletF7fwPLQlJ0QU+/KaeXB0SXMs1iqAOLtJwv4zSmWfxgoE5VVg+nhe7lQZHspMl4bnuJw2bktIR+dhXS6zht0Si3SZBKUixLih758rE244v0bvAoZ5zLSsrerqCaWq/cKIfXrUPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y3Iz3ygl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y3Iz3ygl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB5E71F00A3A;
	Wed,  9 Sep 2026 10:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788950744;
	bh=ZCkTRnCGA3TQc77J6E4cuRa3lCyJmE6TYEtkz/O1W8U=;
	h=Subject:To:Cc:From:Date;
	b=y3Iz3yglOiPiHwIrnm0JouOeERV6mjxoTZRhwv7x9HJiYzH+rtS8TRTeq60dEWp+J
	 HxolXj2fax0pIxFDqThW/ilVnHf9VVwY9p8LEiDBLzVM4C48l/zMngbLlYD4iWgHud
	 yHb9CQ2OHWn+of4CJqV5wJ396X7A7Q5e/NknJ+2Y=
Subject: FAILED: patch "[PATCH] LoongArch: KVM: Set vcpu->cpu before IN_GUEST_MODE is set" failed to apply to 6.18-stable tree
To: maobibo@loongson.cn,chenhuacai@loongson.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:37:50 +0200
Message-ID: <2026090950-throng-dominion-88fe@gregkh>
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
git cherry-pick -x 32d05564a6128d59ea876cf9078fe6866a809e14
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090950-throng-dominion-88fe@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 32d05564a6128d59ea876cf9078fe6866a809e14 Mon Sep 17 00:00:00 2001
From: Bibo Mao <maobibo@loongson.cn>
Date: Mon, 10 Aug 2026 12:21:50 +0800
Subject: [PATCH] LoongArch: KVM: Set vcpu->cpu before IN_GUEST_MODE is set

In function kvm_make_vcpu_request(), it will send IPI to physical CPU
when vCPU is in IN_GUEST_MODE mode. And physical CPU is set in function
kvm_check_vpid(), thus it should be called before IN_GUEST_MODE is set.
Otherwise IPI will send to wrong old physical CPU where vCPU is running.

Cc: stable@vger.kernel.org
Fixes: 2fc3bd86db4b ("LoongArch: KVM: Implement basic vcpu interfaces")
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 20c207d80e31..fd0dd22a7162 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -300,10 +300,10 @@ static int kvm_pre_enter_guest(struct kvm_vcpu *vcpu)
 		 */
 		local_irq_disable();
 		kvm_deliver_exception(vcpu);
+		kvm_check_vpid(vcpu);
 		/* Make sure the vcpu mode has been written */
 		smp_store_mb(vcpu->mode, IN_GUEST_MODE);
 		kvm_deliver_intr(vcpu);
-		kvm_check_vpid(vcpu);
 
 		/*
 		 * Called after function kvm_check_vpid()

