Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971494;
	b=hWBP6KoPHtugqPMwwKQb+eAvS+loyKw/vSBlWtZTg/uVFhfBHDl04X7LnRh6o7/bV+aC
	 hh2co9zb6KEXpJDsROyELZZhdWXPjlbouJqJ73itX7XEiCUvmg2YQqw+aqg2GHj4sPGY8
	 6yDRDaHpIXZvkvbzwOspXgQ9/H7HYAOOw6Oha7ONznFKfkvGYCf0JFVlA198RmayeJeZH
	 pVLqC43bZZnsMOfhdlwi+8DGqdh/y2PNSVXxXSrXIeB3NUhQ5eeNFEwrE8VGoCwTd5g1/
	 lF1Xr4tpxfyvO1c8ZXct2JFUW+C6oXZhRFwRqiMmtCOlqwJaKzQds1Jvt2w6O2fIilA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971494;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=v52H+Zt2yLvlSt6TyHFwvKsYqfVFJAwo/JcghmyhrlY=;
	b=Wk7QlPqdGl4SFOnPNrfPyN6Yb8SVT6LLgMUc4UhMQzf+tLj7ckVrtlP5lWrBT0LwD/kT
	 0IV5ssgMShQP/pLFDWL9MuvUCo68GJS6uHx/McV4yy+rajblGzqNZvI3bE8z+X4DFk4hp
	 oTKvKxj+h4gxuN73oNUNpnN606ITkgrDhHfMQYNu/piQEv0lG7aA0iafq/JaSm37mB8zj
	 RmB5viXTEO1qMSw5mdB1QBBtWkbgrKPNGvwSBfCQGLqAQao8vOIgX/KYShtHbfWaijAJT
	 tmje3yQCp5x5O9iKxFGUmk32PoyXFkY0fcTK964/0j4t4cQg8LHlpk9LIeF7QupLC1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XbAY7cp6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9FB606A338
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 13:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XbAY7cp6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2531F008A4;
	Fri,  6 Nov 2026 13:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793971494;
	bh=v52H+Zt2yLvlSt6TyHFwvKsYqfVFJAwo/JcghmyhrlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XbAY7cp6k1HccULzA7cYfPsEjqJea4p3/VM3oXozRmbi0cR7oHOI6KXuOhxrgSkAt
	 d0KHEGGaqHxur0YkQMLOReI1Gl+aKhniNOvgmY2KORgfRzjiYw+uWgTP7Cx4tyJICn
	 Fq8aldL69W89COtNGnPIA/BQ+IGi9WQZidUgop7xnASXJLvBPBkwreI5r+C3zVTDZd
	 31sev4Bu1IkdjupOjPV1UsAB3x2KkxhRtQaShkvUUmZx4NMqdhHy0Rtbdmp4mwIXvK
	 8sucP9MZN9NOPmsZBs9pci7m4dJ8nK98Echugj5v4R4EuKgUIYdzJMKKbERjBy58X4
	 Joj8z8VZMySag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] KVM: Harden and prepare for modifying existing guest_memfd memslots
Date: Fri,  6 Nov 2026 08:24:51 -0500
Message-ID: <20261106132304.64937-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110458-mobility-lucid-2243@gregkh>
References: <2026110458-mobility-lucid-2243@gregkh>
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

[ Upstream commit af62fe2494da84eb01752282c8228c9bb3fe9f67 ]

Unbind guest_memfd memslots if KVM commits a MOVE or FLAGS_ONLY memslot
change to harden against use-after-free, and to prepare for eventually
supporting dirty logging on guest_memfd memslots, at which point
FLAGS_ONLY changes will be expected/supported.

Add two separate WARNs, once to yell if a guest_memfd memslot is moved
(which KVM is never expected to allow/support), and again if the unbind()
is triggered, to help detect uAPI goofs prior to deliberately allowing
FLAGS_ONLY changes.

Link: https://patch.msgid.link/20251202020334.1171351-3-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Stable-dep-of: 513333a55460 ("KVM: Only bind memslot to guest_memfd instance for CREATE operations")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 virt/kvm/kvm_main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 23e7d1bb80b04..297fd43b1da6c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1748,6 +1748,12 @@ static void kvm_commit_memory_region(struct kvm *kvm,
 		kvm_free_memslot(kvm, old);
 		break;
 	case KVM_MR_MOVE:
+		/*
+		 * Moving a guest_memfd memslot isn't supported, and will never
+		 * be supported.
+		 */
+		WARN_ON_ONCE(old->flags & KVM_MEM_GUEST_MEMFD);
+		fallthrough;
 	case KVM_MR_FLAGS_ONLY:
 		/*
 		 * Free the dirty bitmap as needed; the below check encompasses
@@ -1756,6 +1762,15 @@ static void kvm_commit_memory_region(struct kvm *kvm,
 		if (old->dirty_bitmap && !new->dirty_bitmap)
 			kvm_destroy_dirty_bitmap(old);
 
+		/*
+		 * Unbind the guest_memfd instance as needed; the @new slot has
+		 * already created its own binding.  TODO: Drop the WARN when
+		 * dirty logging guest_memfd memslots is supported.  Until then,
+		 * flags-only changes on guest_memfd slots should be impossible.
+		 */
+		if (WARN_ON_ONCE(old->flags & KVM_MEM_GUEST_MEMFD))
+			kvm_gmem_unbind(old);
+
 		/*
 		 * The final quirk.  Free the detached, old slot, but only its
 		 * memory, not any metadata.  Metadata, including arch specific
-- 
2.53.0

