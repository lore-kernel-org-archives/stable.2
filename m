Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976697;
	b=2DCARSSQ+o1HQUX0xoKDJYJB+0vcJdadhTxqDcZ5kiRRlcDw7wxI8cEmBFzgr1gX49q6
	 QruyiR4A3mP/s73zzZXKMv0obQE27074335GoGWoVJBMCdA2kyNyQpfDWMwOmMNJJxVNu
	 Z7kerRq7JSlDAkd0WSvH8iPeBouzy9sC6wbfSF5oezUrYBd36GbFRZs7IH/88HkS+OKjP
	 TTr/tDwkcBKIbDkEXUbFf7NHDol5oBfHPIRy8Wkb7prpGcATq/mctaYKJzcI1MCgBjhvq
	 1m1ZUjPl7kst0iRP+bbNizumAg9jSv+7BYoaDkCJE4jPD4u+jY9qruMD9hcR6Od1Waw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976697;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9K0vdNioD//L6HDfSZt4OaRsnn9lIo3nlsbjefKDJ6s=;
	b=kFRIMTYQGox7bNejRl3Hh6VF4Xmb5OS0SvkEXYUnXLuQ/piRiI1OV9VuCdjZmUjp7sSz
	 kZ+6bTzMQerxXVXRqm2/2GLuVBd2ZvXKTeX5W15vuDu2IOjEGs9VxBfbcctM6sCGiUVjf
	 FFEwnGSd1ryTLMAjqfs+K9PbeOvqUbww4ZEK310gWXqNsBezcdb2PRZteRFfrPkOVhsLl
	 xMmJxBIY5PfRt2vgbH4g1Qhijhp7i1UOb9JyoNdly2MUOGIMX+wq5OL6EwDWZymJ4VNRY
	 CVIeP66WBxQ3jvySPzmLeSTUzhkqmXyUF6QMD2UYIcNPF57Qathw+XiXEXAS3mmrbSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZZj5HNFd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8666E606A332
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 14:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZZj5HNFd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3CD1F008A4;
	Fri,  6 Nov 2026 14:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793976697;
	bh=9K0vdNioD//L6HDfSZt4OaRsnn9lIo3nlsbjefKDJ6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZZj5HNFddtDMcw9Kr5N5faow0oG11oerN8JOItXeJqfUJ9VJm9h+ta46h1tAq6Swo
	 HzRYKtvBHdthajwXx+PmufyrUVtuqZ7hNWqH4/h63F4L/e2mbutmfB71b516kBvTce
	 9v70tzlUIy9OlfJkLEL4+uIC1iqCXgkV4F/IiCf+Tqqx3SgeIGOejDMAWKebhA1cUq
	 3k+BwX8LiKlZrE5jtXdMZMg9sukT92y9veV2nG+NiHE8e+hAhP1WI4XtQkY+uSfi2p
	 sT1i1U2aTZCS5+WKbkc+cf028lMDyr/0+JyGps5IMYepL5/HroG1CAUDCqVv6J/xDx
	 BGi/PytPj7/jA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Woodhouse <dwmw@amazon.co.uk>,
	Paul Durrant <paul@xen.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] KVM: x86/xen: Take kvm->srcu in __kvm_xen_has_interrupt()
Date: Fri,  6 Nov 2026 09:51:35 -0500
Message-ID: <20261106145127.399900-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110400-cinch-argue-06fe@gregkh>
References: <2026110400-cinch-argue-06fe@gregkh>
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

From: David Woodhouse <dwmw@amazon.co.uk>

[ Upstream commit aa8ad943f242ef14d136c5440b1178de77466c9e ]

kvm_gpc_check() checks the cached memslot generation against the current
one, which dereferences kvm->memslots and therefore requires kvm->srcu to
be held. __kvm_xen_has_interrupt() does not take it.

Most callers do happen to hold kvm->srcu, but not all of them:

 - kvm_emulate_halt() on the VM-Exit path, via kvm_vcpu_has_events() and
   kvm_cpu_has_extint(). vcpu_enter_guest() drops the vCPU's SRCU lock
   before entering the guest, so it is not held on the way back out.

 - kvm_vcpu_block() -> kvm_vcpu_check_block() -> kvm_arch_vcpu_runnable(),
   which is the case the existing comment in this function describes.

On a PROVE_RCU kernel the former produces:

  WARNING: suspicious RCU usage
  include/linux/kvm_host.h:1092 suspicious rcu_dereference_check() usage!
  ...
   kvm_gpc_check+0x344/0x3e0 [kvm]
   __kvm_xen_has_interrupt+0x83/0x310 [kvm]
   kvm_cpu_has_extint+0x1ff/0x370 [kvm]
   kvm_cpu_has_interrupt+0x16/0x100 [kvm]
   kvm_vcpu_has_events+0x4ce/0x690 [kvm]
   kvm_emulate_halt+0x52/0x1f0 [kvm]
   vmx_vcpu_run+0x988/0x2630 [kvm_intel]

Use guard(srcu) so that the three existing early returns don't each need
an explicit unlock. SRCU read sections nest, so this is harmless on the
paths which already hold it, and srcu_read_lock() does not sleep, so it
is also safe in the atomic case which this function already handles.

Fixes: 7caf9571563e ("KVM: x86/xen: Use gfn_to_pfn_cache for vcpu_info")
Cc: stable@vger.kernel.org
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Claude:claude-mythos-5
Reviewed-by: Paul Durrant <paul@xen.org>
Link: https://patch.msgid.link/20260831213632.81023-11-dwmw2@infradead.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/xen.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 8e38f976feb47..baa0c6d180962 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -416,6 +416,16 @@ int __kvm_xen_has_interrupt(struct kvm_vcpu *v)
 	BUILD_BUG_ON(sizeof(rc) !=
 		     sizeof_field(struct compat_vcpu_info, evtchn_upcall_pending));
 
+	/*
+	 * kvm_gpc_check() checks the memslot generation, so kvm->srcu must be
+	 * held. Most callers hold it already, but this is also reached from
+	 * kvm_emulate_halt() on the VM-Exit path and from kvm_vcpu_block(),
+	 * where vcpu_enter_guest() has already dropped the vCPU's SRCU lock.
+	 * Taking SRCU does not sleep, so it is safe even in the atomic case
+	 * which is handled below.
+	 */
+	guard(srcu)(&v->kvm->srcu);
+
 	read_lock_irqsave(&gpc->lock, flags);
 	while (!kvm_gfn_to_pfn_cache_check(v->kvm, gpc, gpc->gpa,
 					   sizeof(struct vcpu_info))) {
-- 
2.53.0

