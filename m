Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801800;
	b=eMvNechfcf7Lke2qmSoJPHOkQLmzhD/omoP1ADlsgR36GRe6PMU5pRDdr0QOe2/ozICZ
	 2PQbSVe82is3C4sNO1qPJ7HKTbnoIfm1mcdmXJuzhakhGikf6lQVKbKMLWv351IXUPNne
	 zVYmCWPb6H53XEwpTVRR4N0hQtfdy6cKzj404nyCZQb8hjroRXFNctocccy6rWjlBgslu
	 45bondr6z531Jqc/yrjgHcL9aIYCYwbC6sxVMGnClk9VWnT1q5CqGnMyxrALcU65uB8oo
	 ueoP56kjoVeSPCB/u5wXsNovC5jzRu8QNZasxKcp5wze763LLD0tGO15N6Xi99oTv5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801800;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6vhh8d7LmXkPbUIdWeeFVCQWN9kkOoFbFS6ReDcu/bs=;
	b=UVVHGLWXuCPf4cSMpmquWRJpvDKreoTiyOgcY9AIpyXxa5WQBGlhHvO1K/4/ED2OSz2B
	 bt0fhuAsTwLVZddruEkq9wM0wSi52G4eqJiqaXTUkruL9vyY657l4xAHrvf0f2rNeSowJ
	 odJkli8Hr8c3yX9TUP/IbIVQbFXkx/kscIBlx9l66+BVZIEltew13I4om6cme7cJ2uMt4
	 JDdPjzmjcGY2nXCx3zL8Acnq4j2xeVgUwV7QoTJlHKFI9qT5+H38ZSZ4xgnXDOtpAUo8J
	 81yBhgPJ/znT6tWcOefwyI2Ut/tsxRLDQj6Yrez/z8jiWOnlhpD5DJWwCKwXiyT12gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=gkoipYpI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87ED606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=gkoipYpI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309031F000C1;
	Wed,  4 Nov 2026 14:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793801799;
	bh=6vhh8d7LmXkPbUIdWeeFVCQWN9kkOoFbFS6ReDcu/bs=;
	h=Subject:To:Cc:From:Date;
	b=gkoipYpI6KTblY0KewcRT8yyVxEMOh4TiebTum6Ap8soV7SOVx/QilXGMD0oTgaeG
	 30eLoutfKKyU+kUY2jR3qkxhBZqLTLjps7YUZGlxkHx46R4yvG1WXsRF7A/98teQRf
	 d0zmGG594fPum2J+qLzghNmLv9qcnKU0nIigDqzQ=
Subject: FAILED: patch "[PATCH] KVM: guest_memfd: Gracefully handle xarray errors when" failed to apply to 6.18-stable tree
To: seanjc@google.com,ackerleytng@google.com,david@kernel.org,dtighe@google.com,fane@google.com,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:16:37 +0100
Message-ID: <2026110437-amusable-desecrate-4962@gregkh>
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
git cherry-pick -x e6ecb88711d93b9e014532f17d3d29b57e80932c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110437-amusable-desecrate-4962@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e6ecb88711d93b9e014532f17d3d29b57e80932c Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 17:13:27 -0700
Subject: [PATCH] KVM: guest_memfd: Gracefully handle xarray errors when
 binding a memslot

If inserting a memslot into a guest_memfd's bindings xarray fails,
propagate the error back to the caller, i.e. fail memslot creation as well.
Signalling success and continuing on with memslot creation results in
use-after-free, as the guest_memfd instance will remain reachable via the
memslot after the file is freed (kvm_gmem_release() won't nullify the file
pointer due to lack of a valid binding).

Opportunistically WARN and reject binding if KVM_MEMSLOT_GMEM_ONLY is
already set, partly to guard against goofs elsewhere, but mostly so that
KVM doesn't need to worry about clobbering flags when unwinding on failure.

Regarding the unwind, the slot must be fully prepared before inserting it
into the bindings, at which point the slot becomes reachable.  I.e. waiting
to update the slot in order to avoid the ugly unwind isn't an option.  And
as part of the unwind, explicitly nullify the relevant bindings, as xarray
can store a subset of entries when populating a range.

Fixes: a7800aa80ea4 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
Cc: stable@vger.kernel.org
Reported-by: Stefan Teodorescu <fane@google.com>
Reported-by: Dennis Tighe <dtighe@google.com>
Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260823135031.4F6DC1F000E9%40smtp.kernel.org
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Link: https://patch.msgid.link/20260922001332.1121266-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index b8797382cc5b..751d0ad94f74 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -655,6 +655,9 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	BUILD_BUG_ON(sizeof(gpa_t) != sizeof(offset));
 	BUILD_BUG_ON(sizeof(gfn_t) != sizeof(slot->gmem.pgoff));
 
+	if (WARN_ON_ONCE(slot->flags & KVM_MEMSLOT_GMEM_ONLY))
+		return -EINVAL;
+
 	file = fget(fd);
 	if (!file)
 		return -EBADF;
@@ -693,7 +696,13 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	if (kvm_gmem_supports_mmap(inode))
 		slot->flags |= KVM_MEMSLOT_GMEM_ONLY;
 
-	xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);
+	r = xa_err(xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL));
+	if (r) {
+		xa_store_range(&f->bindings, start, end - 1, NULL, GFP_KERNEL);
+		slot->gmem.file = NULL;
+		slot->gmem.pgoff = 0;
+		slot->flags &= ~KVM_MEMSLOT_GMEM_ONLY;
+	}
 	filemap_invalidate_unlock(inode->i_mapping);
 
 	/*
@@ -701,7 +710,6 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	 * not the other way 'round.  Active bindings are invalidated if the
 	 * file is closed before memslots are destroyed.
 	 */
-	r = 0;
 err:
 	fput(file);
 	return r;

