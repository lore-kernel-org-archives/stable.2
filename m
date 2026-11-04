Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819828;
	b=pJPUlcrLte10C4asEYDXSdAQcvrH3V2z7XsuIDJOOSLD9q7wjRIIS8+ZnwjEXj/qsI/P
	 hOqLA1LblvvJpiM060E3nVKkygwvZccyt2+SjOeJkhisxvvgUWk4s4z+irv3wTqVEN4Vo
	 Qe1UEtWWtmCESOxPF1K2GB29GUMm5qNVQkutPU9V05MsHPvOR/r32ReG/XTDzZ5imKdr+
	 xdmdMDuFqCw79tcpzcBGfPElOUYJ6kBCx2KtqNTVfjdIqCJIVIe+8XlSZElPVuF83zqQo
	 +PhY9TNLZ230Yumk7c6tMxIHf04gohvgTBvGsg8mrBPVOAXSMxOSffhysYXDp15UabA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819828;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Yl56cRNLnv9harW7QWtcVPOgcXF4VMM+EmwSNbYGSCo=;
	b=aIPbbuEXNjQsyqc+A0sQpVLlqkR2jOsy66kBSfcEoVzKRcIMVZN88XtHElHuob1J7pf4
	 TtzyLijQ4AtzkacazdRnsNm4XxBSYnEm3v15bFrc8JErthFReHcjFqHSdY2G8l1+Sk6N9
	 dbQfg5akVjmX6yHSX1u3lZOZGl8hgJTkIzwrOfxPMtuWu5InsqKEXuiwBqDf5h9bu3sS/
	 mWazev7wAqNpW/pZpIRaI5laPEZzJ+cbnB+yk2a7RDn/Cieq6knKbcvWsqEanXvvN1xUu
	 PGV6pUbD8Wrl1vC4miyBnjhoGbYff7Il6a8SlWcuqyxeCGu/RLrrePw+4h8v6EOKl9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=yJrPL42M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F23F606EE80
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=yJrPL42M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3171A1F000C1;
	Wed,  4 Nov 2026 19:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793819828;
	bh=Yl56cRNLnv9harW7QWtcVPOgcXF4VMM+EmwSNbYGSCo=;
	h=Subject:To:Cc:From:Date;
	b=yJrPL42MvmR8czuO8cUzAMa+BxCL/kIO+gY9E40rLIvtbqTpBaekHEQL63KFVvGJE
	 Ip03It/rqlQjH8CSThItuc/ev0Dp4oR8SDBKzBGgb5zZpEV9ZJrDbuetPwtvoy7YnO
	 wHkU0SXsg5EzFgMMl4fC2wXOXyN7rGWftqo+0ie8=
Subject: FAILED: patch "[PATCH] KVM: Only bind memslot to guest_memfd instance for CREATE" failed to apply to 5.10-stable tree
To: seanjc@google.com,david@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:17:01 -0500
Message-ID: <2026110401-reprise-curse-1d84@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 513333a5546017da2a4a6173bfb70372f83733b3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110401-reprise-curse-1d84@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 513333a5546017da2a4a6173bfb70372f83733b3 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 17:13:29 -0700
Subject: [PATCH] KVM: Only bind memslot to guest_memfd instance for CREATE
 operations

For additional defense-in-depth, and to avoid having to handle impossible
unwind scenarios when binding to a memslot fails, bind a memslot to a gmem
instance only for CREATE operations, i.e. don't attempt to establish a
binding for MOVE and FLAGS_ONLY operations.  And when FLAGS_ONLY operations
are eventually supported (this is currently all dead code), creating a new
binding would be incorrect; KVM instead needs to do a 1:1 replacement of
the existing binding, i.e. FLAGS_ONLY will need its own dedicated handling.

Update the relevant TODO to make a better guess as to what needs to be done
to support toggling dirty logging for guest_memfd memslots.

Because it's dead code, no functional change intended.

Cc: stable@vger.kernel.org
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Link: https://patch.msgid.link/20260922001332.1121266-4-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 3c0dbe60a5b4..c53a88cea1f2 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1742,10 +1742,10 @@ static void kvm_commit_memory_region(struct kvm *kvm,
 			kvm_destroy_dirty_bitmap(old);
 
 		/*
-		 * Unbind the guest_memfd instance as needed; the @new slot has
-		 * already created its own binding.  TODO: Drop the WARN when
-		 * dirty logging guest_memfd memslots is supported.  Until then,
-		 * flags-only changes on guest_memfd slots should be impossible.
+		 * TODO: Drop the WARN and do the unbind() call only for MOVE
+		 * when dirty logging guest_memfd memslots is supported.  Until
+		 * then, flags-only changes on guest_memfd slots should also be
+		 * impossible; unbind the old memslot for defense-in-depth.
 		 */
 		if (WARN_ON_ONCE(old->flags & KVM_MEM_GUEST_MEMFD))
 			kvm_gmem_unbind(old);
@@ -2106,7 +2106,7 @@ static int kvm_set_memory_region(struct kvm *kvm,
 	new->npages = npages;
 	new->flags = mem->flags;
 	new->userspace_addr = mem->userspace_addr;
-	if (mem->flags & KVM_MEM_GUEST_MEMFD) {
+	if (change == KVM_MR_CREATE && (mem->flags & KVM_MEM_GUEST_MEMFD)) {
 		r = kvm_gmem_bind(kvm, new, mem->guest_memfd, mem->guest_memfd_offset);
 		if (r)
 			goto out;
@@ -2119,7 +2119,7 @@ static int kvm_set_memory_region(struct kvm *kvm,
 	return 0;
 
 out_unbind:
-	if (mem->flags & KVM_MEM_GUEST_MEMFD)
+	if (change == KVM_MR_CREATE && (mem->flags & KVM_MEM_GUEST_MEMFD))
 		kvm_gmem_unbind(new);
 out:
 	kfree(new);

