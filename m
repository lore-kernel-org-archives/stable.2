Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793972066;
	b=f6o3zZt7j8xIBBJ4UzTT3GRJN6e22Cwvph6JYFngWw4stk/WlQc4pIUwTya271ypJGpC
	 o7FRX+aeJm2idBK5yajaqGLEYIr9fxt5JBJLzsckQ7f65EfCsjuHQJYTI/VAx5PG90yME
	 Ex4amHYYKOtV2zC4hdqUZwmtVoSJhoU2VDaX5uPf1Dvti2p9h23T7UVgQ+3wvvXLOaPiB
	 rEIynFzhIw6NcYO6veQCJAZCecFVE5kFt2OiVS58u73VAg7mk16xIOreU3c458AD1WK4Y
	 D10mDyMonxM+d0VljZgP3TCOZAmF2tZgBH6788v/JWjU26zVTWlHlR5z72FIWFKQIUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972066;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=w3C8M1cy164ZCHYkwL9QP4A8fq91NVznA1aa1mB2Hts=;
	b=p0WG8tOVaPGqiZMVQUjAwNv4bXaVa3Y1Lofox8lAlht4FiujOhz950uwf9JbDXPtCVW8
	 XYfKiAGxF5TdBi7O9GTpslLucooLPRMivsPvgFhgsEhDl13CHSOmJe9F6XLpfANNNer/q
	 FolpIDlKMs88gsqBisS4HHxE1frxWNfI4isatqrCIhMDVWqKOXPWWK5411qbUFfO6vSas
	 Lurue6+ZXQh/QjvKY8CnO4B0cO9sNTMAiTyVwl4lD4YUyDJzF2L7V92PSG90Pm5bd94Ij
	 droMX2DMTOGYaHJ2YxqyRTddZSFVaxp8h41sawG/UmDYVmxFlMZADCSP2gvb08HS2Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iubR4jkl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54346606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iubR4jkl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A3D1F0089F;
	Fri,  6 Nov 2026 13:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793972066;
	bh=w3C8M1cy164ZCHYkwL9QP4A8fq91NVznA1aa1mB2Hts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iubR4jklwbfeRGZTq/Ge+ErxlWiWPyIPap92KzVCVPZsbREJuzdLas3rgx2FoXfXs
	 4mvDUGheuHYZ6ejxJDtN1Fs02NK5aod4ct9w5QsJzDRnjWvehZFyZLiZ9yr3udPk1O
	 nl2oePvhs8+4GU4D1VLdZJer3QVs+rYvM5cOn6L4OLQRJiPzqQDXnNhy1kUQbTx98E
	 l9uiKQFjyMF6CUNoae23dtzJ86jSkXa+ZGAf2z/0xjb/5B0YGtFxEA5WkZGrLgG40c
	 Lw6aTx/qzd0MNP5upKwIFpfLsv3BoxmrBUIxvLH7JemfYWPtcl56SFp1Ny7vMKyd3d
	 XNyRuBCTIfpBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] KVM: Harden and prepare for modifying existing guest_memfd memslots
Date: Fri,  6 Nov 2026 08:34:23 -0500
Message-ID: <20261106133356.250405-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110459-universe-gladly-03d3@gregkh>
References: <2026110459-universe-gladly-03d3@gregkh>
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
index 7debedc1ddaae..0d017f75c5a11 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1725,6 +1725,12 @@ static void kvm_commit_memory_region(struct kvm *kvm,
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
@@ -1733,6 +1739,15 @@ static void kvm_commit_memory_region(struct kvm *kvm,
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

