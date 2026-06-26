Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EEC377EC2
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 11:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473073; cv=none; b=sqxj17hkt/dsWJ0mJxuov/IaQs5y94P8JUGNWRlJIpifQqOFRAWDD5MoiMWC7ehdv1WOrJE0h/kJzS12zxp9fDoG4il8Cih6y3WW52/5UC3/N0o7y7JNwgeMDDL9mbRnKVb2BEEOPNgUGnMR4J2UMYP4HZn+Z9v69POSwSQhdwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473073; c=relaxed/simple;
	bh=XlzafqtqzssCQn0fo6uVy5EqI86whNIzBdn0viwW6Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AAhWwuf3gCDH3i7whlGYUn9kV04RKaNsoDKkBBiLKbUpISbHCJsbr6SbKCj+TbMDYCSpDpo12gVoz91gwi3oRrvg7OZfdWn/Xm8ZMWzXgwtf6qc5p+pKqPiAErFtuZ8pRN5CEFPGPVcsHBq4ECqNif7RGSzuC4X2XojXAtJUVik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VWbHRe5c; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Va7huqeL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VWbHRe5c";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Va7huqeL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/74rsUhBrFOpgTK5uyMNeeX5nCLK5VE3Yzf3wlvBABs=;
	b=VWbHRe5cw4p43dEKk+ApWo+uKZTh7+e7OJhQFeRUjxncM4lrMc2zz2r6poViZcNiIlLEKe
	TU1vNY13PRrHll+8PPU0IuPI9aSUJQY0wkHQjUHJbZDwQ3QM8Sr7ue4FG7VlLrzmbwGMqu
	/flrr4YxKEIpyobYNGOluubw3nfcwo0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-DB7zKTOeMDKkZVh-egsgQg-1; Fri, 26 Jun 2026 07:24:29 -0400
X-MC-Unique: DB7zKTOeMDKkZVh-egsgQg-1
X-Mimecast-MFC-AGG-ID: DB7zKTOeMDKkZVh-egsgQg_1782473068
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4629f312a67so715068f8f.2
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473068; x=1783077868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/74rsUhBrFOpgTK5uyMNeeX5nCLK5VE3Yzf3wlvBABs=;
        b=Va7huqeLrkZJIr3TS/Mp98wY9kQTND1RzMJSPt97dh1e+ye5j+QfwLmsI9SBeMcKim
         VEnofBfuHEZjAR/8J5oFvCJxK4k4Z1uz/dtOO0fnyF6CIL/OoQtL4RTMyLtSHPl4S04d
         wTIDIjD1Q/Wy6H97Y8aKqoLRxKZF8lCBKVfthLAPUzlmatrPds7oNRo9VWLMA9nxTT08
         1+qptYr7NYf7sor3WZXJfYJxvfMT3KXxcpSj2Krqeh6C9GiKCbQfvO/9ymgVVlsPbPdR
         lefOLeUFtc0syMpP/7HXvmQbewRDBzZF6IxF/g2rfNvMjAeqhiwTuDQQz65QaOVt4JId
         n4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473068; x=1783077868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/74rsUhBrFOpgTK5uyMNeeX5nCLK5VE3Yzf3wlvBABs=;
        b=KKDjFNqaaGCB0uzGUQ4DovBPQ2qw70UTKU+fZZXWDVO366DDVwDUjgInHqGpbKc7Jq
         uCBHGsrqUd7+VqjB0BqZKnnSE4oeWCasYp2CFnLovGuF7LBc2+KbPVSGjOEKJdljHUTP
         AguxrCnGRpqb0bD2jbWJRx5sOuSWDpDLxGtsRrUANMP6Vq8pkoejOFfjyUbZ7r5kGbwX
         PebXzaQSixWq9l9n5vdsJDHRPA9yY7gzKvP8p+hKOx3Rlq8oo+ZjNZ2lJZ3ZYcxrUYyd
         TXmAwZxw/L7+TC2h4gcmmMFOzq4IpxlEicGJYvg3gTdKLKONkWqwFzM1cP91QCuaQux+
         +nqQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ExRy6OpJKNbUNrMo2Ic7hcSJnjuduPaV+qbqm+ry3f08wXDAge0TcwlXMHhlwqNbnVJ9Zh2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR80ezgnfHBNpKw/UtfXgT1cApWqij7d5R8XWBzQvDnWpvV4YX
	x64FD7ddTapHYnGWuD9GVRn9jLBlc+4Yp47uPTYv7KKa/uxWMCU5VNoKEE0TxWWC15+fSafkbWJ
	VVyrLwDIVknx6ydhE1ygIgY5LdZ4PIv2RUQkvZeuO2lmkNtmWKLEpMBJuqw==
X-Gm-Gg: AfdE7cmJnpTWaZl6lL+uosAyh6wZ6nzCS5ocMe6jVw0FxZcwrwr80V6XBmKLBHbFNiX
	JHEJkBsi1Kc19V7HOdUZA7GLHgMT9k/2TmpW1KKmYiKzsQV9DjlTuIrlIBgghuTyk1TxMwhYw07
	ckdX0gtorBt9c8Bn5BUAmv3kbyLMFeDattva+SZZTYEhlFmhR0zrnfbIwXd/oxADOh9ELieb+TM
	zJcH7C0xPakTRv2sN1FBAP15ivJXYOS3hJbeBRfv2mcswBlWdcu9a91wJ3aLTaz7+fwKW3Tw6Aq
	yMlcTKhf+EZFws7xex5DibMPpqRwFm27ZbSAltJCibFTyWgWdvxge4StahQhnIyxZ+cHYaB3Hp3
	GkUI1vEaoLbwd4rKLT8/tYq0z1PU7jtvShoeiiW6sqjoVEBHiH5n3QH8q3rn57HRXeUMFbOLo3d
	AIG1vzNSbd7cwmZmCR
X-Received: by 2002:a05:600c:6308:b0:492:5e36:155a with SMTP id 5b1f17b1804b1-4926688f440mr95373305e9.34.1782473067792;
        Fri, 26 Jun 2026 04:24:27 -0700 (PDT)
X-Received: by 2002:a05:600c:6308:b0:492:5e36:155a with SMTP id 5b1f17b1804b1-4926688f440mr95372715e9.34.1782473067259;
        Fri, 26 Jun 2026 04:24:27 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49269016362sm67309945e9.13.2026.06.26.04.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:24:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>
Subject: [PATCH 6.6.y] KVM: x86: Fix shadow paging use-after-free due to unexpected role
Date: Fri, 26 Jun 2026 13:24:24 +0200
Message-ID: <20260626112425.1777712-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 81ccda30b4e83d8f5cc4fd50503c44e3a33abfeb upstream.

Commit 0cb2af2ea66ad ("KVM: x86: Fix shadow paging use-after-free due
to unexpected GFN") fixed a shadow paging mismatch between stored and
computed GFNs; the bug could be triggered by changing a PDE mapping from
outside the guest, and then deleting a memslot.  The rmap_remove()
call would miss entries created after the PDE change because the GFN
of the leaf SPTE does not match the GFN of the struct kvm_mmu_page.

A similar hole however remains if the modified PDE points to a non-leaf
page.  In this case the gfn can be made to match, but the role does not
match: the original large 2MB page creates a kvm_mmu_page with direct=1,
while the new 4KB needs a kvm_mmu_page with direct=0.  However,
kvm_mmu_get_child_sp() does not compare the role, and therefore reuses
the page.

The next step is installing a leaf (4KB) SPTE on the new path which
records an rmap entry under the gfn resolved by the walk.  But when
that child is zapped its parent kvm_mmu_page has direct=1 and
kvm_mmu_page_get_gfn() computes the gfn for the 4KB page as
sp->gfn + index instead of using sp->shadowed_translation[] (or sp->gfns[]
in older kernels).  It therefore fails to remove the recorded entry.

When the memslot is dropped the shadow page is freed but the rmap
entry survives, as in the scenario that was already fixed.  Code that
later walks that gfn (dirty logging, MMU notifier invalidation, and
so on) dereferences an sptep that lies in the freed page, causing the
use-after-free.

Fixes: 2032a93d66fa ("KVM: MMU: Don't allocate gfns page for direct mmu pages")
Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d288c60ae200..a67d013fff4d 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2329,13 +2329,15 @@ static struct kvm_mmu_page *kvm_mmu_get_child_sp(struct kvm_vcpu *vcpu,
 						 u64 *sptep, gfn_t gfn,
 						 bool direct, unsigned int access)
 {
-	union kvm_mmu_page_role role;
+	union kvm_mmu_page_role role = kvm_mmu_child_role(sptep, direct, access);
 
-	if (is_shadow_present_pte(*sptep) && !is_large_pte(*sptep) &&
-	    spte_to_child_sp(*sptep) && spte_to_child_sp(*sptep)->gfn == gfn)
+	if (is_shadow_present_pte(*sptep) &&
+	    !is_large_pte(*sptep) &&
+	    spte_to_child_sp(*sptep) &&
+	    spte_to_child_sp(*sptep)->gfn == gfn &&
+	    spte_to_child_sp(*sptep)->role.word == role.word)
 		return ERR_PTR(-EEXIST);
 
-	role = kvm_mmu_child_role(sptep, direct, access);
 	return kvm_mmu_get_shadow_page(vcpu, gfn, role);
 }
 
-- 
2.54.0

