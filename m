Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803121A2C25
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784202054; cv=none; b=YfxLw1jC/kiesFhZSI0jy/RVZ+5GDisfFprTUA+jVQCGMdyz8dYfx3AjtxRGL+LNeXcTOhuINt6+QAi80ddbYNUofdrUJikGXsvMc1t+gcdXV6G7eEZv9csiLllxTolZzu0JDDoMQiTJjAIoJsuK4PgNK4GtR6D7qxWbFaEzDeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784202054; c=relaxed/simple;
	bh=hZgCgOCoornqt8Ct82L4jbRel5wqHjB5fS/HgAzjx8c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FhHx32TrobAKv4aP49lAru1bjD9lR35mTbf9xaCZ+PMpWwPA5ZzNdZZSSxqfGHwOgoUjd4G8uZ/gOYcUG71zsWPRCZ8hoJppDuvoNgPVDuZ1MhvhcwdrDSo8NJsxz3aT0dzcKOimsBet6UKK8SHoS8MyhB0gfecmHQveP4q+TxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hes7pwn6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hes7pwn6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39A01F000E9;
	Thu, 16 Jul 2026 11:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784202053;
	bh=Pv6/N2g+IHIoj4eU60wIDyq8fKJOuxF9LLk4jwugN+Q=;
	h=Subject:To:Cc:From:Date;
	b=Hes7pwn6AkxJR5h8GjPY2mcpXj3sxEU8PhgFaI+1eJ9M94bOThzfZPWCBXcxMLwk5
	 ij+8RYz+q+1fzngdjyWERg3OIvurPVpZBiWHHnoJWSQrRaxYBPzHI/7uYmcTney6pj
	 +4dV+jOpu6uK2d5Hq/+P/p7CzWIJbWTBjd2BtMbc=
Subject: FAILED: patch "[PATCH] KVM: TDX: Account all non-transient page allocations for" failed to apply to 6.18-stable tree
To: seanjc@google.com,kai.huang@intel.com,rick.p.edgecombe@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 13:40:41 +0200
Message-ID: <2026071641-falsify-antiquely-4d9a@gregkh>
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
git cherry-pick -x a8b2924676ec42d76597f849baba31acc3ba1bfc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071641-falsify-antiquely-4d9a@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a8b2924676ec42d76597f849baba31acc3ba1bfc Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Wed, 28 Jan 2026 17:14:35 -0800
Subject: [PATCH] KVM: TDX: Account all non-transient page allocations for
 per-TD structures

Account all non-transient allocations associated with a single TD (or its
vCPUs), as KVM's ABI is that allocations that are active for the lifetime
of a VM are accounted.  Leave temporary allocations, i.e. allocations that
are freed within a single function/ioctl, unaccounted, to again align with
KVM's existing behavior, e.g. see commit dd103407ca31 ("KVM: X86: Remove
unnecessary GFP_KERNEL_ACCOUNT for temporary variables").

Fixes: 8d032b683c29 ("KVM: TDX: create/destroy VM structure")
Fixes: a50f673f25e0 ("KVM: TDX: Do TDX specific vcpu initialization")
Cc: stable@vger.kernel.org
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Link: https://patch.msgid.link/20260129011517.3545883-4-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 04aecdd3a6c0..72d916c957bc 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -2384,20 +2384,20 @@ static int __tdx_td_init(struct kvm *kvm, struct td_params *td_params,
 
 	ret = -ENOMEM;
 
-	tdr_page = alloc_page(GFP_KERNEL);
+	tdr_page = alloc_page(GFP_KERNEL_ACCOUNT);
 	if (!tdr_page)
 		goto free_hkid;
 
 	kvm_tdx->td.tdcs_nr_pages = tdx_sysinfo->td_ctrl.tdcs_base_size / PAGE_SIZE;
 	/* TDVPS = TDVPR(4K page) + TDCX(multiple 4K pages), -1 for TDVPR. */
 	kvm_tdx->td.tdcx_nr_pages = tdx_sysinfo->td_ctrl.tdvps_base_size / PAGE_SIZE - 1;
-	tdcs_pages = kzalloc_objs(*kvm_tdx->td.tdcs_pages,
-				  kvm_tdx->td.tdcs_nr_pages);
+	tdcs_pages = kzalloc_objs(*kvm_tdx->td.tdcs_pages, kvm_tdx->td.tdcs_nr_pages,
+				  GFP_KERNEL_ACCOUNT);
 	if (!tdcs_pages)
 		goto free_tdr;
 
 	for (i = 0; i < kvm_tdx->td.tdcs_nr_pages; i++) {
-		tdcs_pages[i] = alloc_page(GFP_KERNEL);
+		tdcs_pages[i] = alloc_page(GFP_KERNEL_ACCOUNT);
 		if (!tdcs_pages[i])
 			goto free_tdcs;
 	}
@@ -2872,7 +2872,7 @@ static int tdx_td_vcpu_init(struct kvm_vcpu *vcpu, u64 vcpu_rcx)
 	int ret, i;
 	u64 err;
 
-	page = alloc_page(GFP_KERNEL);
+	page = alloc_page(GFP_KERNEL_ACCOUNT);
 	if (!page)
 		return -ENOMEM;
 	tdx->vp.tdvpr_page = page;
@@ -2885,14 +2885,14 @@ static int tdx_td_vcpu_init(struct kvm_vcpu *vcpu, u64 vcpu_rcx)
 	tdx->vp.tdvpr_pa = page_to_phys(tdx->vp.tdvpr_page);
 
 	tdx->vp.tdcx_pages = kcalloc(kvm_tdx->td.tdcx_nr_pages, sizeof(*tdx->vp.tdcx_pages),
-			       	     GFP_KERNEL);
+				     GFP_KERNEL_ACCOUNT);
 	if (!tdx->vp.tdcx_pages) {
 		ret = -ENOMEM;
 		goto free_tdvpr;
 	}
 
 	for (i = 0; i < kvm_tdx->td.tdcx_nr_pages; i++) {
-		page = alloc_page(GFP_KERNEL);
+		page = alloc_page(GFP_KERNEL_ACCOUNT);
 		if (!page) {
 			ret = -ENOMEM;
 			goto free_tdcx;

