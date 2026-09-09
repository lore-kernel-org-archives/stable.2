Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AC7531AF1
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950751; cv=none; b=p1ipHsRF15OvTPdZoK78te8IgFbpGwDSr+NjczgRhbzDCgQv+IXz6ToF13WSmTGNihlaYyuFxiLIbChajqK8Kp2JfpbQsuo2jnYCYY7gmovnSCo9MSnpsiJWdp5OoDsBkzErBqNG/m18SYYAckSjMxbga20xbFWrXewvyUc2HVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950751; c=relaxed/simple;
	bh=ba0rqr7G6r9TKGJi+cFBHWuqo7QLaCT0WsNoVNTphfY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sJZ3uoDpnEully2G0quv61VLcKrckKrA7Qk9fYLcCYrenV9RkHvjEZBKOBKou3syJxtfqyXTqB+kcgwjXTnt3NltgXedLW1tfGe/LffDbe2zdFCGQfa3DCVS4grfJuI/ZfxYkR665p+EMW/+pUsn4ZSQ+8EpTJ1YsTxSw3B4smA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pAUoGJK9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pAUoGJK9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911E21F00A3A;
	Wed,  9 Sep 2026 10:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788950750;
	bh=xprfk0vvh0kqix8dH+Er973TJ2wCN7c8BWhh5Sq8iOE=;
	h=Subject:To:Cc:From:Date;
	b=pAUoGJK95ZHn03IZTAe36khh6v0MheQxEaUcrHYh1OnMglSPUgR5GNSiLGAxXGI15
	 NQO/IKMtkuVZbHFP0zpylHME1ALa+IvzN8WxSxcBSQ79eoYkZpLp4jZRZcSCCu9a0k
	 J4TXel2WGjeWWrtnfn/d3jgpCuXQ93kQ6grIBc5I=
Subject: FAILED: patch "[PATCH] LoongArch: KVM: Fix resource leak in kvm_loongarch_env_init()" failed to apply to 6.18-stable tree
To: nagachaithanya9911@gmail.com,chenhuacai@loongson.cn,maobibo@loongson.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:38:23 +0200
Message-ID: <2026090923-chaplain-train-47a8@gregkh>
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
git cherry-pick -x 910132bc7d72f26a8b288c2a38c32445a48d5be0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090923-chaplain-train-47a8@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 910132bc7d72f26a8b288c2a38c32445a48d5be0 Mon Sep 17 00:00:00 2001
From: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
Date: Fri, 4 Sep 2026 21:44:54 +0800
Subject: [PATCH] LoongArch: KVM: Fix resource leak in kvm_loongarch_env_init()
 error path

kvm_loongarch_env_init() allocates the per-CPU kvm_context (vmcs) and
kvm_loongarch_ops, registers the perf callbacks, and then registers
the IPI/EIOINTC/PCH-PIC/DMSINTC KVM devices. If any of those device
registrations fails, the function returned the error directly, leaving
everything acquired so far in place: vmcs and kvm_loongarch_ops are
never freed, the perf callbacks stay registered, and all previously
registered KVM device operations remain registered. kvm_loongarch_init()
propagates the errors without calling kvm_loongarch_env_exit(), so
nothing else cleans up either.

Unwind the error path in reverse order of registration, so that each
failure only undoes what had actually been set up. Use the same helpers
in kvm_loongarch_env_exit() to remove the device registrations during
normal teardown as well.

Cc: stable@vger.kernel.org
Fixes: c532de5a67a7 ("LoongArch: KVM: Add IPI device support")
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
index b6ddf5827c03..236523d2449d 100644
--- a/arch/loongarch/kvm/main.c
+++ b/arch/loongarch/kvm/main.c
@@ -385,27 +385,52 @@ static int kvm_loongarch_env_init(void)
 	/* Register LoongArch IPI interrupt controller interface. */
 	ret = kvm_loongarch_register_ipi_device();
 	if (ret)
-		return ret;
+		goto err_env;
 
 	/* Register LoongArch EIOINTC interrupt controller interface. */
 	ret = kvm_loongarch_register_eiointc_device();
 	if (ret)
-		return ret;
+		goto err_ipi;
 
 	/* Register LoongArch PCH-PIC interrupt controller interface. */
 	ret = kvm_loongarch_register_pch_pic_device();
 	if (ret)
-		return ret;
+		goto err_eiointc;
 
 	/* Register LoongArch DMSINTC interrupt contrroller interface */
-	if (cpu_has_msgint)
+	if (cpu_has_msgint) {
 		ret = kvm_loongarch_register_dmsintc_device();
+		if (ret)
+			goto err_pch_pic;
+	}
+
+	return 0;
+
+err_pch_pic:
+	kvm_loongarch_unregister_pch_pic_device();
+err_eiointc:
+	kvm_loongarch_unregister_eiointc_device();
+err_ipi:
+	kvm_loongarch_unregister_ipi_device();
+err_env:
+	kvm_unregister_perf_callbacks();
+	kfree(kvm_loongarch_ops);
+	kvm_loongarch_ops = NULL;
+	free_percpu(vmcs);
+	vmcs = NULL;
 
 	return ret;
 }
 
 static void kvm_loongarch_env_exit(void)
 {
+	if (cpu_has_msgint)
+		kvm_loongarch_unregister_dmsintc_device();
+
+	kvm_loongarch_unregister_pch_pic_device();
+	kvm_loongarch_unregister_eiointc_device();
+	kvm_loongarch_unregister_ipi_device();
+
 	if (vmcs)
 		free_percpu(vmcs);
 

