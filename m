Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819820;
	b=LUf6qKSNoZmB2Ip7m1T125VUOxcVNVzQyORMX8BVdI3Q3xl4/7fYSJ6XWjJOs1VE8gux
	 Kv8yrxwCwhzrT2ZsiA3Ij61sZ6PYxKDU/FmSmFKnCl/y0zsC3S5NAvuGcSzrEtfVZPf9j
	 gjWSdfFxIIxKf+8sManMmdTuvwssd6ZKVDMfKmn9z0yOgSexTvZAZ1h0AwuRRCe7hdMsW
	 eiW26o1BSXq8VDYBF8NpDl6BhK5cfL5e2Y7LkPE5oNix2lsSAhZUohqt+OxpIxqPmPMbn
	 bXdf+8dzsxXiyozxTJPyhJfLQ68jWdShiVjDym2NC4sjF8l64bIbzWtbczEDgYQREWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819820;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ANQpjCuGh7cx3JwWGCzVhLqSzjFG86py9XG0Q4ZYaLg=;
	b=10j/+WKHV3BbBuyAvrnu2pApiT2QxlS83jqyC7vcOvlu9yewicXK45gDj+H6B526SUAn
	 QSTrXKUV+rm8RZW1daVjXbP8N/5RagLE0k7YqZif8GhS0On1qXGeo5rWgmDuquU1nX/Up
	 Q61GrfkpvH1UaW3yB+yY+BjIF1wHOAJKIUOhq3a0GoQ4MLvPxh4bPLiZa7/aEsD+EelYG
	 wUDr5KJqMELjuOZjCMj8OfmqIVwKSjcM+mUeNJ1ZBLpOozWO/WO0PPF5BSY34jxp44PuO
	 H8/PN2s2tZDFAnqe/8a3lwojFv0dQyxUZWhj2gvENzQCDvjsM1gJCLL+ar7egLYMZoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Xc2Qfeid;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E72606D807
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Xc2Qfeid
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FAB81F000C1;
	Wed,  4 Nov 2026 19:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793819819;
	bh=ANQpjCuGh7cx3JwWGCzVhLqSzjFG86py9XG0Q4ZYaLg=;
	h=Subject:To:Cc:From:Date;
	b=Xc2QfeidUU1cArJSTR5z7BnSjVZQAzlKTqAfOaLPPEUcmp+oLpGR4i7Y9YwA4+XNI
	 QUh1RpIOQyPGdTaOi41ykh2iNygKvDiAcLH8pjpy3o1IBggQ5uOf24DlsDW3QXYLuD
	 Crsu0pfzYmq2II3hOE22Ckbf69Zynu61TxXfHdZ4=
Subject: FAILED: patch "[PATCH] KVM: Only bind memslot to guest_memfd instance for CREATE" failed to apply to 6.18-stable tree
To: seanjc@google.com,david@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:16:58 -0500
Message-ID: <2026110458-mobility-lucid-2243@gregkh>
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


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 513333a5546017da2a4a6173bfb70372f83733b3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110458-mobility-lucid-2243@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

