Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793831765;
	b=DIShqfjfkyNc74EJfLquzY7dBYDBuTvBRRXFUmR0waAPRkLgGZwCKXic0V9nywYr36iM
	 I38ECVFr+B67bS317H2BkEwURUCowx9KIlPoGKISvFQJ69QI2yVS8krdiM3xDsU9GaSEq
	 KZorcnzh64Jk/d3k+dWyix1BdIeN7iTyZBtYSRarB4uEuAPFRrfBrWYSKljSS7bz7d70S
	 BnK0l9E+0B4MS09laHCNImR03YXxCg/ir4RYVo43QvP0Xb8cMwHK7n6X8q9ZDf455UxTi
	 2X8pcu1gVJ0nNuURyzhlEcqqrZfeAWbt3hbi5F43FSDWpxKLnc8ekpyhBkgagzC+/Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793831765;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=I8J1e6HSd1WWXfvc45MdlxK76ZO1XFwPn3fXtYypCrA=;
	b=w9LYSPYGs6bwhke+23Vm0q0ggN0qBgFJSolI2xjShzDslu4GmmP+Yox3ybYD+4bc3Nqo
	 19WviFvyBj2SJnNZrqYmF63dyfO7Md5i5pN1C83xku21rU9sPCI2yMV2MiL6AvAqpw34I
	 CG/KjxXezx/MLlMYH8SmB2mrjqVw3RdfmABJ8r4BAQig3eNdsc/tt4Lj3L+rycNoYFg4v
	 27mkRRCc86EWX+gZlMkxW8JOOlwQyBRCX5oQMQnkSoTllS98Pvm3bXdB/Iw2N7/f81O0C
	 QfI4tVWWK5ydiV5kg/LiHwksCaytteFGBb+Gtatb94z5DfmBPoXUPw0aPF66d3doFUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AfEE7im2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBC1606AC0C
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 22:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AfEE7im2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40161F00919;
	Wed,  4 Nov 2026 22:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793831764;
	bh=I8J1e6HSd1WWXfvc45MdlxK76ZO1XFwPn3fXtYypCrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AfEE7im2Oyy6TmufPuAe9u2WQPEreQvG/vAbRP+VDFbymKmFvH07ppfxYzXhWCwvM
	 6uJUyDhrJ9sOdYFC+SlY/9mpB5gra6PEfp9fqq/O4MPn0RZ1FrsPw0C6fdkvZXzr0U
	 YbygtCcyOfGvozENq/1uxOSjY/qMb0LgZ4/NaFzCkAfilLj+zcJKhMb9zyQMbHY4pg
	 VQDkPE9LzLbxfvGov62igWFaCbJ4+Aa6vwWNoRK9+/vzeYnCcRdBHtoduTfDOawvP0
	 7ABstyZMrUthgbCgywuFeRvLlM7RB6OEc8V9i6Ls4IV5aQPZj3M8LQpNs8o6a2/9t1
	 +9z9FrN8Vvf4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Stefan Teodorescu <fane@google.com>,
	Dennis Tighe <dtighe@google.com>,
	Sashiko Bot <sashiko-bot@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Ackerley Tng <ackerleytng@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] KVM: guest_memfd: Gracefully handle xarray errors when binding a memslot
Date: Wed,  4 Nov 2026 17:36:02 -0500
Message-ID: <20261104223313.638389-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110437-amusable-desecrate-4962@gregkh>
References: <2026110437-amusable-desecrate-4962@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit e6ecb88711d93b9e014532f17d3d29b57e80932c ]

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
[ sashal: Changed the two &f->bindings references to &gmem->bindings to match the existing variable name. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 virt/kvm/guest_memfd.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index a59a4446b8461..2ab7bb46a371e 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -576,6 +576,9 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	BUILD_BUG_ON(sizeof(gpa_t) != sizeof(offset));
 	BUILD_BUG_ON(sizeof(gfn_t) != sizeof(slot->gmem.pgoff));
 
+	if (WARN_ON_ONCE(slot->flags & KVM_MEMSLOT_GMEM_ONLY))
+		return -EINVAL;
+
 	file = fget(fd);
 	if (!file)
 		return -EBADF;
@@ -613,7 +616,13 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	if (kvm_gmem_supports_mmap(inode))
 		slot->flags |= KVM_MEMSLOT_GMEM_ONLY;
 
-	xa_store_range(&gmem->bindings, start, end - 1, slot, GFP_KERNEL);
+	r = xa_err(xa_store_range(&gmem->bindings, start, end - 1, slot, GFP_KERNEL));
+	if (r) {
+		xa_store_range(&gmem->bindings, start, end - 1, NULL, GFP_KERNEL);
+		slot->gmem.file = NULL;
+		slot->gmem.pgoff = 0;
+		slot->flags &= ~KVM_MEMSLOT_GMEM_ONLY;
+	}
 	filemap_invalidate_unlock(inode->i_mapping);
 
 	/*
@@ -621,7 +630,6 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	 * not the other way 'round.  Active bindings are invalidated if the
 	 * file is closed before memslots are destroyed.
 	 */
-	r = 0;
 err:
 	fput(file);
 	return r;
-- 
2.53.0

