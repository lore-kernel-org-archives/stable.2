Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793661281;
	b=DkC60+2nQWqlyGVFQDDMlwYv2A4l/tLRqWf4NS1EuHzZjoOZduxIo61IlVQgN1Px7fAJ
	 X06ABi0qrpFPoxDUWdR0ct/1gO6/N+/fdM9kf9qIuwtgDpaptVSIYwEgDLsZp9csR2P4n
	 sDHF1sAh3mxrcuFiuJ4qxPQXT6wmicjCbhLMaQm0lKnIyFyb/7oYE8LAV/vmSD+JmfFOq
	 MGLKOLjPnPgU5gQwsZyloD9+bnINO6h8SOyqH6zm6qGFCGuKhsAlguszuG7Qju3zmV2oH
	 u3zIZB0UNPj4mIyS3BGKsPmb8vODf7xGdBGsCPKe2e+xwB2CR7PXAtppJrUG1B/uVsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793661281;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=etM9WyQmfIPzfMLv/GTxvxnLWL1yIZR3UqJiNo2KVLc=;
	b=PeH4odyGlhz5ntL1CT6Og8KKC54KHsXdnfOkyWHcCaJe6weteBm0dq52fOE63LdUG4kR
	 4kO4hjWkI2t5Wl+qxcHV+J8BiY2F6VjF49ymH7kCrpRl+JHwVYHJmaFFGJO5Fm69EFEv1
	 NZlnoYWqRPBeKLbSvrbUITZJJLT9PEngFbYj3W0eSN4OmT9fIgAaz3r5Vm2RgwOTNb3qA
	 Rh4Fwohm3Iri7u+fXhoJoEER2Zi0Akdwswml5Gst4Nkg0gptq7QjWE9LNeD6UKF55+NAZ
	 ul6KoVVaQEx1ibZoZGVVFqwr/Cx+pILoOaCBwkyaEKOw0vlg5s+4e+foL+KbRj2SZ0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FW982Yz8;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B4D606EE94
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 23:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11B4D606EE94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FW982Yz8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793661280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=etM9WyQmfIPzfMLv/GTxvxnLWL1yIZR3UqJiNo2KVLc=;
	b=FW982Yz8s8M9viqacjOi25OLn+Ob6QXqNu3fFgRPeANVwYoHTk4iD0tR6vzlzx7gdZN/XE
	YdxRspKFuNJMAhNtG8cbFQxz5ofB4tCFWlh0Jaf6lVKfZUn/nkeJErq3QSe1kK5YA7f04Y
	JdXtIdDwsPUzAKrxnEiapEl3j975J9g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-326-ZJ455oz0PCC8BD_SFMchsw-1; Mon,
 02 Nov 2026 18:14:36 -0500
X-MC-Unique: ZJ455oz0PCC8BD_SFMchsw-1
X-Mimecast-MFC-AGG-ID: ZJ455oz0PCC8BD_SFMchsw_1793661275
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1708B1956075;
	Mon,  2 Nov 2026 23:14:35 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0F52B7D5;
	Mon,  2 Nov 2026 23:14:33 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	James Houghton <jthoughton@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	stable@vger.kernel.org,
	Stefan Teodorescu <fane@google.com>
Subject: [PATCH 5/7] KVM: x86/mmu: Cap number of parent PTEs per SP at 1000 (the arbitrary rmap limit)
Date: Mon,  2 Nov 2026 18:14:26 -0500
Message-ID: <20261102231428.13523-6-pbonzini@redhat.com>
In-Reply-To: <20261102231428.13523-1-pbonzini@redhat.com>
References: <20261102231428.13523-1-pbonzini@redhat.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

From: Sean Christopherson <seanjc@google.com>

When potentially reusing a shadow page, zap the shadow page if its number
of parent PTEs exceeds KVM's (mostly) arbitrary rmap recycling threshold.
Letting the guest create a (mostly) unbounded number of parent PTEs allows
the guest to coerce KVM into creating lists containing millions of PTEs,
effectively bounded only by the maximum number of shadow pages.

Because PTE lists are simple singly linked lists, removal is O(n).  Even
worse, if a list is constructed just so, teardown can be O(n^2), e.g. if
SPTEs are built such that zapping child SPTEs always zaps the last entry
in the list.  To cap things off, all paths that walk PTE lists do so
while holding mmu_lock, without conditionally rescheduling.

Using a doubly linked list would not address the issue, as removal would
remain O(n) since KVM still wouldn't know where in the list to remove from.
Removal could be made O(1) by storing a per-SPTE pointer, but that would
largely defeat the purpose of reusing SPs, and would penalize well-behaved
guests, especially for nested TDP where aliasing page tables is uncommon.

So, cap the maximum number of parent PTEs at the rmap limit.  In practice,
well-behaved guests will likely never run afoul of the limit.  E.g. when
running Linux as L1 with TDP, the number of parent PTEs for a single SP
tops out at under 200 (though undoubtedly obscure workloads can push it
higher).  Deliberately use a "greater than or equal" as opposed to rmap's
strictly "greater than", as the rmap code checks the threshold immediately
*after* inserting into the list, i.e. the limit is 1000 for rmaps, KVM just
very briefly blows past it.

Apply the check to both indirect and direct SPs, because while a fully
direct MMU naturally limits the number of parent PTEs to '1', direct SPs in
indirect MMUs have no such constraint.  E.g. if the guest maps a huge PTE
into many locations in its page tables, and KVM is backing the hugepage
with a direct SP, i.e. with a series of smaller pages, then KVM could end
up with a direct SP with many parents.

Note, shadow_mmu_try_split_huge_pages() always restarts the rmap walk or
bails entirely if it gets to the point where it tries to grab a SP, i.e.
there is *no* pre-existing bug that would be tripped by zapping a SP and
thus rmaps when getting a SP.

Cc: Jim Mattson <jmattson@google.com>
Cc: James Houghton <jthoughton@google.com>
Cc: Yosry Ahmed <yosry@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: stable@vger.kernel.org
Reported-by: Stefan Teodorescu <fane@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20261027171518.1432557-1-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 5a2cc6a17a9b..f4b12d6aef55 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2355,6 +2355,16 @@ static struct kvm_mmu_page *kvm_mmu_find_shadow_page(struct kvm *kvm,
 			continue;
 		}
 
+		/*
+		 * Note!  Unlike fully direct MMUs, direct SPs in indirect MMUs
+		 * can have an arbitrary number of parents, e.g if the guest is
+		 * mapping a huge PTE at many points in its page tables.
+		 */
+		if (pte_list_count(&sp->parent_ptes) >= RMAP_RECYCLE_THRESHOLD) {
+			kvm_mmu_prepare_zap_page(kvm, sp, &invalid_list);
+			break;
+		}
+
 		/* unsync and write-flooding only apply to indirect SPs. */
 		if (sp->role.direct)
 			goto out;
-- 
2.52.0


