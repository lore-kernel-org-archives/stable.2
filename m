Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801807;
	b=Dp2d71cgtuNwbfiS/9ZowaVEqJtdi2JhRLvx8IRoip5QBG7yYgJIGAj1fAAhCfqz6uQx
	 4/tqJSawDAFwAKgXP1Lj5PQ7CGbCZT0CtcYELuhEPK92VV5Xuefx+UzePDLudMstYI+I7
	 xT0GsqVaWVXpksXO0OHI8FD5ZuwmM90X80Tts7Um6N/jkzQ0TIJZkFoVdMbAxcG3DF4l0
	 qcfVgc2rzjnqaIxV9OLO5wzcOkRHbQ7nqyVqn1tC+pG0cV/hO7ThUBF/aDGTCkGaB6Nnf
	 eH73eNV3Pcq45l0KiA0zmkd2e2UFX/jtNLZEBQRniQ1y2JgRlT5a0qxshUar3UiShIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801807;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=FHGfNk0yZptQopCLDcFDSPPnYNGtrLmf5K6Nx8XMSuo=;
	b=XJfj9Gnholoj0HHOceJYdoj7gCAKYMeQiQqc9t4jeTuHPGcgyeEA8sB4BrDnq+/0WPcG
	 aChVSaWtjZTjHIYBZjtPNQHr/JLWrUXu34IfDEuPjGSpMuI7cfwMIhLzIg4mDDneMxpJK
	 7tJ9GETwTD+muPyfDKn95+0W1XAIoN5ie2tQNsAYs5cQ/ZL1qPplBlKFWKuB9DEyDX2yg
	 8wEm6TexxKn7yYPKgljTKBZ5bviRbgiiMNWyh3CIbu2AwlUq/RCDP1Gbv41s4By1Dr62x
	 JP/iO3oafCW4y+JikQOuRiGILvBL6VXhHdrfFz7cIieGFb4syims/VFvgA9i8Au0UxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=j6cotRsJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6571C606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=j6cotRsJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09D11F000C1;
	Wed,  4 Nov 2026 14:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793801807;
	bh=FHGfNk0yZptQopCLDcFDSPPnYNGtrLmf5K6Nx8XMSuo=;
	h=Subject:To:Cc:From:Date;
	b=j6cotRsJUJQ/wjs5rdT2h6+QgSekswcEV03ukAUa507J+yGpPdYtt04j3dCrX4Cc5
	 SVIjz5jfO9CKCjsrB52VP2YejZClVVql+fh4KfkHKbLLxewmQf9PYRCUMosiBsztYu
	 iM7vRdit+u37ecc87H1DxP/WKP8ZYqMQZR9XKBUE=
Subject: FAILED: patch "[PATCH] KVM: guest_memfd: Gracefully handle xarray errors when" failed to apply to 6.12-stable tree
To: seanjc@google.com,ackerleytng@google.com,david@kernel.org,dtighe@google.com,fane@google.com,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:16:38 +0100
Message-ID: <2026110438-crown-brisket-9c6b@gregkh>
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
git cherry-pick -x e6ecb88711d93b9e014532f17d3d29b57e80932c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110438-crown-brisket-9c6b@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

