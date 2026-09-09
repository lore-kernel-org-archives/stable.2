Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6048652ED3D
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950748; cv=none; b=aQ30MH3mCzstXQcdmwww095o1xlewHuJjxNuWpMhBSs7ISY3eNt8doAU6Q6mh906VgIX6KR/JK0+m37x+Fzthg5ky4Pta2uwgLN5/PxjwvQrFWs+ENuBarhdZ8P2NRLhLi5labevadPGfRldRFhufsEMX3gmhbaY30032htft7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950748; c=relaxed/simple;
	bh=vkl5jlcomuwuaGQQk9yolvIFnu+9YW+BLe8XbXSS1bY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DWt75PiYgiUAeu4Z/6AuznhcetsdUybjUcxWbF1DMv4GG+meIjxLL6dXueAcAWKPBM6jvzBOFILYe2hwAmCJmFJlpRAE4fBQ5o2IfSgISfCpYX2tQ8GzdFCDz2HRNDe5uWA1y4Z4qcDdFPFOBDEAm4DQXx5V14S6+DU9W93Brwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nN1FUUV5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nN1FUUV5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD5E1F00A3D;
	Wed,  9 Sep 2026 10:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788950747;
	bh=mmxne+UhPbtYCC0LpXfHynZi3NwYzNDUiVJKsLYA37w=;
	h=Subject:To:Cc:From:Date;
	b=nN1FUUV5JNQJoXO5+z/9Tj4GSuSUGyK45YRH8Qd40IlBwjupKLVvELdIku8vHChZv
	 VLRA18UrK8CYyA1AEODpHA5euIzeqy4/5COEwY2/RzA2n+HRr4LWCXqCZjGDh6BiCg
	 6l1/7PgIZyodD+jU4PmResMA/k3JxAnqQpi3CNjE=
Subject: FAILED: patch "[PATCH] LoongArch: KVM: Set vcpu->cpu before IN_GUEST_MODE is set" failed to apply to 6.12-stable tree
To: maobibo@loongson.cn,chenhuacai@loongson.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:37:51 +0200
Message-ID: <2026090951-vagabond-cosmic-2408@gregkh>
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
git cherry-pick -x 32d05564a6128d59ea876cf9078fe6866a809e14
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090951-vagabond-cosmic-2408@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

