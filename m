Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971495;
	b=wRGRblc3XXef5R2KHlKm95jhNnsYwlwmkABFejjCmNYO+ypS27DXpNjinC1oc3D5XxsS
	 Q65H9wqCihmQ/q0tyHOSRreuIAQvJefDPchra+JpwN6cE+kEBwwfrWEgcSUdzmDOL8tHC
	 AJyl470a2Aes26ZiiDNB6vZJtYez1f0wtMvQprNA87XoZvWNb/bxf8m6jC74eiTxrTtX7
	 p0idxe0wuePz8htkHvMoTgejSEhTSe2KvcyZOKtrQQF+gHbp7jKBnPIjvxqx2x1zH0yxE
	 zszBhdeQFBbt3ex5WHqBl5ZxEECYFa2mBH06NlNoHhffVJGo4CeD98fciooxND2T7nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971495;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=J0k81AaSZG5RCYZs07Q31tQwSWTtO2itLHTAMq+LJwU=;
	b=bHCJAKt8mMwA91qQuwKpY0pqg33evwKqAHGLqHQgyvQXS7Ch8DcEOQ681zU9oZmgBfoY
	 sYZSJcV9DrKLJf59HUvieJM1Cry1J/D2+e05CFQpC0im5iizk2qrEEBGkO5ZF0UdbT5Dh
	 +9ndM6fxKBE9T8WN3mrTc+ts8pEYGM6KpM9fXc1XLDYsUMfzWAObEU0GJrqYIBX9YbXPs
	 aLCMnCTsqtQhDHjM/JSyBd59JwVyrN/8fFquxxpgKqZjOXHtP46w/sVvsXVytq+7dw2rl
	 osMpl29aW3NFBW3/ygYVfD0xRJKHVFcxm5qtb7mxpghjPB5HcIN31xFNfOmfeX5ABFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jOQjNgCo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520B6606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jOQjNgCo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854771F008A6;
	Fri,  6 Nov 2026 13:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793971495;
	bh=J0k81AaSZG5RCYZs07Q31tQwSWTtO2itLHTAMq+LJwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jOQjNgCofnb2CAgEmqzkOqt4wLZ8xH/ZdF1mX62it9eeBO4S4C8SwJRj/s5TrkO5l
	 a4uSIdcoI5PgQkaKE+ZULap6H8NMJz3dGPruaPDBm/dBiqC7E3ZA/1qvgbNNvaXGOr
	 dMXy+V96ILpMyMLuMneMhG8BFeSIlvt0o3nmNMsoYDsX6V+YpGJsIR5dCO7CznQISe
	 ZIKuKa5yRUOL9o9PuuMx13g54yWeKu1VtP0grcKZmXSzXKkWfrCgOJOziAVBxxlwII
	 C04MF29G4HWu71qWonqimgh2Py5o4CLXOJUIpvJa/YPKURTViY4AUjXowSsYunlXo2
	 7Fp+329kw84UA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] KVM: Only bind memslot to guest_memfd instance for CREATE operations
Date: Fri,  6 Nov 2026 08:24:52 -0500
Message-ID: <20261106132304.64937-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106132304.64937-1-sashal@kernel.org>
References: <2026110458-mobility-lucid-2243@gregkh>
 <20261106132304.64937-1-sashal@kernel.org>
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

[ Upstream commit 513333a5546017da2a4a6173bfb70372f83733b3 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 virt/kvm/kvm_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 297fd43b1da6c..5521743d6e8cb 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1763,10 +1763,10 @@ static void kvm_commit_memory_region(struct kvm *kvm,
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
@@ -2127,7 +2127,7 @@ static int kvm_set_memory_region(struct kvm *kvm,
 	new->npages = npages;
 	new->flags = mem->flags;
 	new->userspace_addr = mem->userspace_addr;
-	if (mem->flags & KVM_MEM_GUEST_MEMFD) {
+	if (change == KVM_MR_CREATE && (mem->flags & KVM_MEM_GUEST_MEMFD)) {
 		r = kvm_gmem_bind(kvm, new, mem->guest_memfd, mem->guest_memfd_offset);
 		if (r)
 			goto out;
@@ -2140,7 +2140,7 @@ static int kvm_set_memory_region(struct kvm *kvm,
 	return 0;
 
 out_unbind:
-	if (mem->flags & KVM_MEM_GUEST_MEMFD)
+	if (change == KVM_MR_CREATE && (mem->flags & KVM_MEM_GUEST_MEMFD))
 		kvm_gmem_unbind(new);
 out:
 	kfree(new);
-- 
2.53.0

