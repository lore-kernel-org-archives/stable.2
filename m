Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833969;
	b=ipTdhvKpS5r8TWR7UjRoyy0toLB/tkPKZNLVm+BOWBWx0ecSDZNSV0i6tKF8dNz0eNHr
	 y2aIMWwYOlCt5A6O9q+M3t1cmd0mnXILs1yNGAA9e5hazAV8pzU8xR8PTPJh+CKFT3eTf
	 4ByrFa5EwT1hdm7Hl+IPBz6KuR4y9jm8LeVepep3gJCetaQDAuDM20U8HaaWWib6dAjau
	 20dS6iklf3Wjb7mExma9CkIBkjidiefL3BvD/TeB5eGCOBiKnBrQ5yHtKabMOaf2PRSe0
	 yiFOz5/29UBW3vRx6RmSwOF0LRhaFOJWIRHgnQqqpMYSyfAOdWfzNs/ujzBe0Ftjkrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833969;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VWHDw78KbBQvRXrU6ADXH6epROhnLWbxMOV+M6dmUZw=;
	b=ytYA2BSZTntZAJUube5KddeY2ATuBkwXUh8aGhPRy8ixIovdtY6HqFqLO2/BS0ZxBL5n
	 N7/fCNrw7Kk9pPs8dlJFEEZtWVvq15TMsBz4iY6Ji3DwARExVaqmKdIsWPbg/ypXa6Ins
	 5aTAQ4XmUh0QW7P/6qhZxDgJ+gwsMyR74jlJUFrgJQMwEsQf0irmswV0bBh/8Akt1SpuW
	 9WmzJHQPPCJ/iOvunm+XCwTey0qwBdjr37PBIlnO5kzZBsytXMYjtTQL05q2SscDlGFuf
	 bHK9mXj/bBBO8Oy2trOWIxjj3eZYr5o+XT1ARbd/tcH1eZEuGWE5k50nrZyOH5O58mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="A/chLtig";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450D8606A329
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 23:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A/chLtig
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F196C1F00A1A;
	Wed,  4 Nov 2026 23:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793833968;
	bh=VWHDw78KbBQvRXrU6ADXH6epROhnLWbxMOV+M6dmUZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A/chLtigYW3GGgOK5dMhBexDh88uvdlD3ug7nCOGXEDTFm5sQqnZcKf1/rp/5sdK2
	 QBkHql2yJvpYY7kzAsIzvc8oWJSrwdojwso8lMTPj5oAdJmj1StkbBsc5ObThSY2x6
	 jHVgwMXxSZtLOecmC2RZyCtgmSqfDfBqoiEkIxZ71mC2aU4nUx65tD/cfE1fn6FY0y
	 8eKissqiFXkE1oAMLsL8Y7+TPxlSwjDOKkprAdMX+2zjCuXhlhddQcGUYC4dEc5LBF
	 4qUf3Ctxzp16TLG6GMNMtHofotrWSqzLnpuv510h+0ECPhDwkgLei5mvzV8igAvbiC
	 BHwKCGtyXruOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Stefan Teodorescu <fane@google.com>,
	Dennis Tighe <dtighe@google.com>,
	Sashiko Bot <sashiko-bot@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Ackerley Tng <ackerleytng@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] KVM: guest_memfd: Gracefully handle xarray errors when binding a memslot
Date: Wed,  4 Nov 2026 18:12:46 -0500
Message-ID: <20261104231213.845770-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110438-crown-brisket-9c6b@gregkh>
References: <2026110438-crown-brisket-9c6b@gregkh>
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
[ sashal: Used gmem instead of f and omitted the guard and rollback cleanup for the unavailable KVM_MEMSLOT_GMEM_ONLY flag. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 virt/kvm/guest_memfd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 71afb0ca0cc94..2e9b5129b5a22 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -520,7 +520,12 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	WRITE_ONCE(slot->gmem.file, file);
 	slot->gmem.pgoff = start;
 
-	xa_store_range(&gmem->bindings, start, end - 1, slot, GFP_KERNEL);
+	r = xa_err(xa_store_range(&gmem->bindings, start, end - 1, slot, GFP_KERNEL));
+	if (r) {
+		xa_store_range(&gmem->bindings, start, end - 1, NULL, GFP_KERNEL);
+		slot->gmem.file = NULL;
+		slot->gmem.pgoff = 0;
+	}
 	filemap_invalidate_unlock(inode->i_mapping);
 
 	/*
@@ -528,7 +533,6 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	 * not the other way 'round.  Active bindings are invalidated if the
 	 * file is closed before memslots are destroyed.
 	 */
-	r = 0;
 err:
 	fput(file);
 	return r;
-- 
2.53.0

