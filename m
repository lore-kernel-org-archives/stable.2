Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345343988F9
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 11:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820029; cv=none; b=Mpk9Q1cGMKY4z4gfjREY08yqG1wTcBPZ9IyxAhxfFcimflrVFtnNQstwoP/bkqiMriwXewe6Y5IFuIOTIbUFhIVGOF0g5ViyodvLSWROnNWMQNcqwpHa+v9BbkNfXr5bvHRt/2Sj+tAtWgleCJJxdRTTL9eBDN0ViS0z/N4Z9Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820029; c=relaxed/simple;
	bh=o74wfL8s1rLkd7zI65jrA8msIbQNU0hccGkpygWaWmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MyzNrNQIR4rrJK7eIMohhACmLhBZ8hBRPaRyTmIpY8gAdKOEZlfzJa4CDkqduYNQpcoFgdSLRsCNsFwiUDHnYPbaZzwrzi3/uvq/SMDV/fA88vILmE0/tdudNcTi08N2SYi9kf/+/IyHgVMXu4/ZYuK3t3j7rRepPwC0H4f64RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=g27i+rSn; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="g27i+rSn"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-473b4139a83so211443f8f.2
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 04:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1782820025; x=1783424825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KwYeM8W++Hp1eioV/dv67xKEijFj30e/B/6NIOTe/3M=;
        b=g27i+rSnW+2Ke1paoIXAoGR1PExNAAQPmevtqmsF3ngI56FkGe9y/Rq3y5DyCiRSb1
         tZqHHcMpzXLnd8VPjqTOr41QM2nn9BsePUBT8dDsmCscjcB6LpSNZZ6+zh6vrwh9YSNL
         HAxHEn/uiKh7OlbPdVSARC12b69hp1RX8uFwiur8W8423nKBC9pn5uq2vF9LGaPi86S5
         RPPuYsTran349G4Sr3SJq/na4o54JECnqZYERneBUJ26llZ2aZ9k3URpyRX8h4j2LFB0
         vOy2d/FS6piFJHQtBnTxY+w8M1OZiYyhDL2QN09mIUwQ18ty0/xRuTWkYxh9k1ANgbHb
         Glcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820025; x=1783424825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KwYeM8W++Hp1eioV/dv67xKEijFj30e/B/6NIOTe/3M=;
        b=h7uIJ8LaSY6hc7DnH1LQzZ0ob/jKS4v6vh9cxFfEWtTgEJ+pKgJJheOALQgYO+BhDC
         7sUoviPdH+WcwZu9qAM+17qhYWle42cGLjGsMRtjRaiEYVjwaXTp6O9WIJ02DsHkVnUC
         2/DPHYQMnNsBNgaMqbXJ6DkDNs9OYeri4MpBSgbMnBTNnVYElQkyNgVkQ1Vy3/xyDegv
         2oy84hDRcEORRQyHXBDbfmuEvnW0uaAjGc1T3wFgUO9+IGfHJ9t64TmUncBfVCiQMk5S
         9DCTa4FVHoZlHTTvAFemPJui4YM/q9oBrRf4rlAxVwiW/oDKrAethpVvsyDBkyw5oLpm
         PMVg==
X-Forwarded-Encrypted: i=1; AHgh+Rp6EupPrDvGq5WgE4jUcoklacOBlUa6oNzSfxHgcNVl+Q6x2Y3yuMQECqV1z4juO8GsVXbV1mE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiPHLxYxCmb4TOeOaBFDztni0pXGdC3hAYkjyr36EmqeVcvgFI
	vblSjyxm/NYTxYdImQ5JuMuKn0Cs0yo+w4ro+Q33SIhq/ySUT0hhFOgsgcwIEDG02B4=
X-Gm-Gg: AfdE7clD0BRjXIVWb7xapjLZjSz+HgS/o8AxeEd8CyiBOBJDG+umqeHvihQwLjWsvRU
	TmyI3WBgi65xhzR/ztwPgKOBLKJ+K2XzeLJxg+YHVYcjoaRh4Qq2pl8Fq1o1kySfAMX3fM0TcVJ
	KSRAyQOP4vBzwu5KPWj1RWhxk7GoLxIkO+R0rF1XLC63F/lURLIhZham3fN5eI+G679lyxq+HAL
	KE9czL4Uj8pu+ZRzWsSuHyx8PSTqScoFTUzfukgqEKwY+VrgjKHZ1zJxyk8Rx2zSLtYIiBzBoyw
	cnFYiBNhI/Uph88KWGtul+cclfof4P9xXIp7z+j1SenQR9Jd+eTXxpsJyNx9RWnPij1XNjGIyUe
	o7QWVREoNY9HvuhYs3d3NVopht6/h5MY8V36NyD/6OUe7EuA4We5ciz37PQ8wIVet2fkueQdx1O
	XdCuk3JdSXACyihl0NJjXkN5h7ZTRUveMV71Vf7p8yMusGBw==
X-Received: by 2002:a05:6000:24c2:b0:46f:7d90:8124 with SMTP id ffacd0b85a97d-47550313dd6mr2387117f8f.2.1782820025445;
        Tue, 30 Jun 2026 04:47:05 -0700 (PDT)
Received: from jwang-ThinkPad-T14-Gen-6.fritz.box ([2001:9e8:1453:7800:1346:8041:6728:42f3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47567979eafsm6925731f8f.34.2026.06.30.04.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:47:04 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Michael Roth <michael.roth@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [stable-6.12] KVM: SEV: Unmap and unpin the GHCB as needed on vCPU free
Date: Tue, 30 Jun 2026 13:47:01 +0200
Message-ID: <20260630114701.319917-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

commit a847a44f67eaf99faad905da38c080f0ba7ee02a upstream.

Unmap and unpin the GHCB as needed when freeing a vCPU.  If the VM is
destroyed after mapping+pinning the GHCB on #VMGEXIT, without re-running
the vCPU, KVM will effectively leak the GHCB and any mappings created for
the GHCB.

Fixes: 291bd20d5d88 ("KVM: SVM: Add initial support for a VMGEXIT VMEXIT")
Cc: stable@vger.kernel.org
Tested-by: Michael Roth <michael.roth@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-18-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20260529183549.1104619-18-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 arch/x86/kvm/svm/sev.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 73e493177351..580ed430f426 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3168,6 +3168,20 @@ void sev_guest_memory_reclaimed(struct kvm *kvm)
 	wbinvd_on_all_cpus();
 }
 
+static void __sev_es_unmap_ghcb(struct vcpu_svm *svm)
+{
+	if (svm->sev_es.ghcb_sa_free) {
+		kvfree(svm->sev_es.ghcb_sa);
+		svm->sev_es.ghcb_sa = NULL;
+		svm->sev_es.ghcb_sa_free = false;
+	}
+
+	if (svm->sev_es.ghcb) {
+		kvm_vcpu_unmap(&svm->vcpu, &svm->sev_es.ghcb_map, true);
+		svm->sev_es.ghcb = NULL;
+	}
+}
+
 void sev_free_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm;
@@ -3195,8 +3209,7 @@ void sev_free_vcpu(struct kvm_vcpu *vcpu)
 	__free_page(virt_to_page(svm->sev_es.vmsa));
 
 skip_vmsa_free:
-	if (svm->sev_es.ghcb_sa_free)
-		kvfree(svm->sev_es.ghcb_sa);
+	__sev_es_unmap_ghcb(svm);
 }
 
 static void dump_ghcb(struct vcpu_svm *svm)
@@ -3461,20 +3474,12 @@ void sev_es_unmap_ghcb(struct vcpu_svm *svm)
 		svm->sev_es.ghcb_sa_sync = false;
 	}
 
-	if (svm->sev_es.ghcb_sa_free) {
-		kvfree(svm->sev_es.ghcb_sa);
-		svm->sev_es.ghcb_sa = NULL;
-		svm->sev_es.ghcb_sa_free = false;
-	}
-
 	trace_kvm_vmgexit_exit(svm->vcpu.vcpu_id, svm->sev_es.ghcb);
 
 	sev_es_sync_to_ghcb(svm);
 
-	kvm_vcpu_unmap(&svm->vcpu, &svm->sev_es.ghcb_map, true);
-	svm->sev_es.ghcb = NULL;
+	__sev_es_unmap_ghcb(svm);
 }
-
 void pre_sev_run(struct vcpu_svm *svm, int cpu)
 {
 	struct svm_cpu_data *sd = per_cpu_ptr(&svm_data, cpu);
-- 
2.43.0

