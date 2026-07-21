Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDE248BD5E
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 10:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629718; cv=none; b=gnlr+svBLlmkDH2cZhpJvOrXjwj/Qz013rgO9dy7lBP01qjeDJYMAN/sGKWWb+cTq1wDCTec3XdQ+zTORC9GJwAO+dZ4Kab9TJXlnUHqGhTe9QIRLHRGs9NiNGo4sWJJ6R4x9ITGsniWvF+rNKM8v0NsUWe5ZmZ/nM28xicld38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629718; c=relaxed/simple;
	bh=flLnTzzvdktYAMXGKCG/ht6BWQVMu8ko2+dOzbhNc0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e4sNQug09Fwo/D3aIluYOCKXWuybRPugL6Ih9F4ukdHSZ5eUom2m35e+bw7e/eN9rXiQltwUogqtHOz1vjbFlTiZShhSUrY9skZBeQfWQGKzM67HB+oeC7c8HpUujwIJ+Qqkt40hEDAJORazDkxDV0ZUC/voutI7fPt6RjlkbSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fEyBqXFJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TsHuZG7A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fEyBqXFJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TsHuZG7A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784629716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qX+yOp5vEEJO47GrrgFjd6hpRsB9whe/kZX5TD9uf8A=;
	b=fEyBqXFJe2GJXq3BzIrtPbWXcTKN/oA482fi+cSerBOZxf3SuuZxqqxGJqdZubKF87Q/uG
	rS3Pvwzta8iX58SQfrlES9vIrNMxtXysRD9L8odMVrHUz+4ssk5GUctLkaDxYdrTyE6BKa
	UUzYIhDIzvt0YzYRw48+c/UOL3845yY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-wsqSe65WOAyYsNQu7xhgEA-1; Tue, 21 Jul 2026 06:28:35 -0400
X-MC-Unique: wsqSe65WOAyYsNQu7xhgEA-1
X-Mimecast-MFC-AGG-ID: wsqSe65WOAyYsNQu7xhgEA_1784629714
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4954c2d4081so39076445e9.2
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 03:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784629714; x=1785234514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qX+yOp5vEEJO47GrrgFjd6hpRsB9whe/kZX5TD9uf8A=;
        b=TsHuZG7A43/BydLbUNZXnP9AMTAlcTxD8OmCJhuwQ2cpxE+4w3DsqP5pyGSIvN8/o3
         bjZTglMg6OxQz40zW0+nkyD7mGJoJbFDwTRqrDNDzt2an76wnUYyCZyoA41++30ZKgfH
         K6RN89Mr4NaLci9cfvnp/62gigNRjSjPU9wIfQgfQeGP9VNCOD5vOacVzr5PKAcOxyOM
         aGEGNUohAY2JIeN3Rk0QXbkJ6oKAd5Ob3ezE+4fe/YSKCxeQ0Js7bxXrjSyk8wgSTZVn
         hSxAmr67C3LCnJ5Rs7+7flAFg6FDs5iOORlEL3arGquj6EoNaiupvfFoSAfY3u+AASlq
         aD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784629714; x=1785234514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qX+yOp5vEEJO47GrrgFjd6hpRsB9whe/kZX5TD9uf8A=;
        b=Lgq2Xcd2vDigRJuEDiqUeP/HhIOsWTx91gn65BSBCdijL8i0VUhNgynAjxK7/MAITJ
         aonisw/Dm9bvSJ0zlXiT2XtoieHYlGyqp7+vhmv5lypTz6paBnSvUi+Vn9n5R0ASdNzO
         yT8sWNIhNs/6YKSp6P3C+R+DPnfCy/DkaH+0LUMGh/WkqMbO6aS5pdKFkG6arbWYaC33
         X5UduFJHnB+pm2uRbBHmQcfWfqyyHF5lT2OY3J5zS2elAA6Gp57EqkTBM7R7bVzqyBQF
         W1NKjSFIJ+BmPDI4Eix8hGHJUSkfg2iZVby9rGIcSUIdUVmCs2P5Inxj7v5vBFZmTPhB
         ThJA==
X-Forwarded-Encrypted: i=1; AHgh+Rp5MuT3qcdoigwX5rvNbCJvQPfZCjYq/uacfNT6n2zZblLsAHAczW5LsF2vbyRQIhdRSEWwz8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXSJxeBrxXZ2ASgxiuptTx7F9sKxGS73tvaqYIOWKDHVbMyqHQ
	sSphAjlLD17V6nv6IHf/fmZLFxgJhTujVxitklrYt/haJIK7OmHnpZVH3Ang5ZUXTmDVPjgSVd8
	e5WCKGI+YNv4fUQ/cCao6Q2o4bZTIYsi1TUEigYx3d+7Uhp+dAHRhlAt3Fw==
X-Gm-Gg: AfdE7clwowaNT8BjibCwMs2xiFIkKasF7C3vBnz2kye5/AlyWoZ1O2j0/mMaWw3x8YC
	n2iZOKPBVV3zuUkKLeoPpss/n+n7r3S8FS0AVfEM0dJsaDFdaHMcp5j72rIlAKq3wLC9VyhTkBn
	FItEtV84flo8q/Br1hXkcB7vWf5e1Z5UPtmVWVXqaXsTgbAjpFd3kQfeWGXLm3h3rC+HhqyIxis
	iJrDxsULi71/HINL1P26gpx0NpUZwIUX/78Yw4IoFPFiAyCX81D6qmNPJQ6Sc+QnDkVoI6HypVY
	R1lIGZP49c/XwTc8rE+J0xRiQGiXG5WM/fLiIQ51katq53tgPWCCs7f/NfuLm9cMt6q1oCgxlVN
	DUNCzLEfjw34bTr1+anDxZCkZ3ZCIfie4DmdA/2FuRMV5qVPC+U0njv8245awIzfFqLe7Ik9zD/
	gwGk2c
X-Received: by 2002:a05:600c:3510:b0:493:cc25:85cb with SMTP id 5b1f17b1804b1-4954a3e20b1mr207187195e9.8.1784629713271;
        Tue, 21 Jul 2026 03:28:33 -0700 (PDT)
X-Received: by 2002:a05:600c:3510:b0:493:cc25:85cb with SMTP id 5b1f17b1804b1-4954a3e20b1mr207186825e9.8.1784629712755;
        Tue, 21 Jul 2026 03:28:32 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.94.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495653687b2sm67947495e9.1.2026.07.21.03.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 03:28:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: x86: Check for invalid/obsolete root *after* making MMU pages available
Date: Tue, 21 Jul 2026 12:28:29 +0200
Message-ID: <20260721102829.313226-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

Check for a "stale" page fault, i.e. for an invalid and/or obsolete root,
after making MMU pages available for the shadow MMU.  If reclaiming shadow
pages zaps an in-use root, i.e. marks it invalid, then KVM will attempt to
map memory into an invalid root.  On its own, populating an invalid root is
"fine", but because child shadow pages inherit their parent's role, any
children created during the map/fetch will be created as invalid pages,
thus violating KVM's invariant that invalid pages are never on the list of
active MMU pages.

Note, the underlying flaw has existed since KVM first started tracking
invalid roots in 2008 (commit 2e53d63acba7, "KVM: MMU: ignore zapped root
pagetables"), but the true badness only came along in 2020 (Linux 5.9)
with the invariant that invalid shadow pages can't be on the list of
active pages.

Note #2, inheriting role.invalid when creating child shadow pages is also
far from ideal; that flaw will be addressed separately.

Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Fixes: f95eec9bed76 ("KVM: x86/mmu: Don't put invalid SPs back on the list of active pages")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c         |  9 +++++----
 arch/x86/kvm/mmu/paging_tmpl.h | 10 ++++++----
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 234d0a95abf5..41f92ed1ca37 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4852,16 +4852,17 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	if (r != RET_PF_CONTINUE)
 		return r;
 
-	r = RET_PF_RETRY;
 	write_lock(&vcpu->kvm->mmu_lock);
 
-	if (is_page_fault_stale(vcpu, fault))
-		goto out_unlock;
-
 	r = make_mmu_pages_available(vcpu);
 	if (r)
 		goto out_unlock;
 
+	if (is_page_fault_stale(vcpu, fault)) {
+		r = RET_PF_RETRY;
+		goto out_unlock;
+	}
+
 	r = direct_map(vcpu, fault);
 
 out_unlock:
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index df3ae0c7ec2c..1ba840a73b7a 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -864,15 +864,17 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	}
 #endif
 
-	r = RET_PF_RETRY;
 	write_lock(&vcpu->kvm->mmu_lock);
 
-	if (is_page_fault_stale(vcpu, fault))
-		goto out_unlock;
-
 	r = make_mmu_pages_available(vcpu);
 	if (r)
 		goto out_unlock;
+
+	if (is_page_fault_stale(vcpu, fault)) {
+		r = RET_PF_RETRY;
+		goto out_unlock;
+	}
+
 	r = FNAME(fetch)(vcpu, fault, &walker);
 
 out_unlock:
-- 
2.55.0

