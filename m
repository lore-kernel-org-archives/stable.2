Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793972067;
	b=RJr2QY7P8rdaoDYIaQ3LimldWyFh2upCVDSqYKDmtb308USaTsZVZMcowUEn3xFsDVP6
	 C7Xnvgbt0u4AINng3kMIrEEb25KziXvNJvXPMeVPAnV3obYcNzmMWFWRUkR4kY1qKNmby
	 97zXp/8zYBB6FYD+BlPkf3bUit9vk+S8w//IBiYws2Oth2eNZ5rPTyiuAI7k7NBK3VeLY
	 IYdO0a2gmRyDu1WPvCbbHiDskAu+LMUoOjX6K6ZByj66SQGXYmlKoaX6uZ4gnWXlYIp84
	 qvWNQIh0SMSNykK+6Ev8T/ixNMyWi2Yb727oDo3mF/kt14rxlVTFhi6RdSPw63/2Hpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972067;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TtXFU+0yHW+YGDhASK4gJvSDfkD6UBXQ7WlzZT3bUcc=;
	b=D5bzS3EBb8DfbR/QUuDFz0zrC7KFFgMaZkzK1+YG1re27lOxVfKZT/MrUDQ3UZD9Y9ne
	 w6hKwDct+8n26V656oKEJn9kPBQ/KnmQQaAEEZUYWT/Ta1+xbG1Kvwmggvq4RwxHC8cj9
	 CUv0vipYdu29cSx4YqNoI2yXr3iwVOGnd2u+kZcRn1C/1FjLhPJyf0GDFRO4lOu35sDhR
	 nVg+0MZClsAXK6mj2lEHywLUxOSHJJbggpUTVr7YjUtGDlfQh7rcwK/iAuytd7vz+ZllT
	 60G11Cd0HtmBJxQ84b2ZlEWjlETSuGo+zp4KNomX0V1HWOTC1IJeYIw2daCnrDa1Krg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EqhiQHB8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162A9606A32E
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 13:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EqhiQHB8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724B61F008A3;
	Fri,  6 Nov 2026 13:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793972066;
	bh=TtXFU+0yHW+YGDhASK4gJvSDfkD6UBXQ7WlzZT3bUcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EqhiQHB8ryObazO6KWhapm4KfQN9sUagc5Hb4DqvO3ayV3mNuy6LgMMK8rHBcpTRp
	 ufXSNeS7NtVHPr2Fy4QkVduKGqkvEQeqxbCX5uPPCAKmJGWmd+8NctMDbpllrlp6/O
	 NQ+9EK8OKxL+XVLEo1zdV7RoCTfhV94HR4rKInnJuR7O4+9LRkcvihNphDVEeyGiHm
	 tACoS9v3HXa0ovYaePMy/WQ+QN1g8FD+huMdQD6tMCfnl5mdKV0XSVAC9HUw+WTmWr
	 gickSKlOLo377XHr20GFr1dF2kyuhpCkHs/kSwKl9DqJXhxuOZ+ifj1z7jSxP3cu3D
	 MbXoUhgQ0g6uw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] KVM: Only bind memslot to guest_memfd instance for CREATE operations
Date: Fri,  6 Nov 2026 08:34:24 -0500
Message-ID: <20261106133356.250405-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106133356.250405-1-sashal@kernel.org>
References: <2026110459-universe-gladly-03d3@gregkh>
 <20261106133356.250405-1-sashal@kernel.org>
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
index 0d017f75c5a11..c574cd2f4f722 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1740,10 +1740,10 @@ static void kvm_commit_memory_region(struct kvm *kvm,
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
@@ -2102,7 +2102,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	new->npages = npages;
 	new->flags = mem->flags;
 	new->userspace_addr = mem->userspace_addr;
-	if (mem->flags & KVM_MEM_GUEST_MEMFD) {
+	if (change == KVM_MR_CREATE && (mem->flags & KVM_MEM_GUEST_MEMFD)) {
 		r = kvm_gmem_bind(kvm, new, mem->guest_memfd, mem->guest_memfd_offset);
 		if (r)
 			goto out;
@@ -2115,7 +2115,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	return 0;
 
 out_unbind:
-	if (mem->flags & KVM_MEM_GUEST_MEMFD)
+	if (change == KVM_MR_CREATE && (mem->flags & KVM_MEM_GUEST_MEMFD))
 		kvm_gmem_unbind(new);
 out:
 	kfree(new);
-- 
2.53.0

