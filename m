Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792715335;
	b=LJ2uwJNUFsYb48cX8lKigaGxdqGkz0LN7yZxKzRZz2NZSaxBKavyD1BT0m4W73nsK4a0
	 1owvxszQTWYtPWzfIMmXdKzAgFHKxbaC2FkfftoPfxXRb0vr6K66uB4QuX+TjP5vVY9M0
	 VnF+a4L/CRvlm32qVpn73eEnBG+ayWVx9VOV/ZhWOQWGBpTFTz81Og5sQ3Zt2BZKqr7aI
	 w6hgtqb7fZvgzeDYd5fB3XTd+H0GxDlErAnQHa2zLu71WJN7wf6NOe213ck8Iu9vt0nxc
	 CdZHAw/23kgchHDADOjJ270QntM3BCwl6mB3TZFZTeYqZDqOT+uBC4HjQSDKK6Qn9kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792715335;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=igRysZJrW5JAQ0vNF0XIF2AY7svHdNyPSgMCke+h060=;
	b=tFlu47qQWbowjFCO5qQLRxuL6FjW7SaJXEJZ4DoiJ51EPaakGM/8HITnJg+LBVGKio5s
	 +jJoTtnzev4nJqvOiCJvxY3dKVVrvu6Y0cW6Zz4g1uk8b7mvKJU0/7Gh+1GVtHozXnEFG
	 Hbx+JqfoJEJC0Dy9SbP209PvZmLUXReGRCNXqxvr9R/XJ02YuonEC/gMy3ljXVELtahD8
	 /Tqhw527Je2jcl5s+4Yh4dSovc9yId6X3sgg+0AB6h/FzfFKiItF/SnfhOv2SDe9oPjLV
	 4C4VGnh5JPJ/n5hlZfyoEhYoJruzBGtw92Pr6Wy1p7cyKZfJ41ettCB9dm464cwdiEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AxsCL79P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5CF606A31E
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 00:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AxsCL79P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1671F01825;
	Fri, 23 Oct 2026 00:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792715334;
	bh=igRysZJrW5JAQ0vNF0XIF2AY7svHdNyPSgMCke+h060=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AxsCL79PmDws1gsXExA+Fj1XyFm2/UZ/FMq8xRuAU8CESvKFoQP9IYI2rqTZzt37z
	 /ogzSlD1yehDAUyByCwIUnrWtF+yreUv49soXJ+AYe4NHmKMh1P1cz7TiAs91GSyuA
	 59STu7hAVztlUSyZLBO19NDJMhGVDjrYxjMeNKIhpbI20wC7aIptiFN/yEDAsoGu5w
	 yOAcVe34X5gXxcWwlWJpaR+H9CjWZ2O+guiVxa2h2QkvTts7c0DYtPeUpHG6tXWn6P
	 XuPIBWTEWDABhoZ4I9S/3Oiu1afDCmyRXR3gl8fjFRWhj4bPBih2nSxpuU1MrN+dYP
	 9QdIfLSGM2jqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Woodhouse <dwmw@amazon.co.uk>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] x86/kvm: Silence per-cpu pr_info noise about KVM clocks and steal time
Date: Thu, 22 Oct 2026 20:28:49 -0400
Message-ID: <20261023002045.2270144-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102116-motion-upchuck-3417@gregkh>
References: <2026102116-motion-upchuck-3417@gregkh>
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

[ Upstream commit f3f26dae05e39f0f286f588669b54d49b61dcfb8 ]

I made the actual CPU bringup go nice and fast... and then Linux spends
half a minute printing stupid nonsense about clocks and steal time for
each of 256 vCPUs. Don't do that. Nobody cares.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Message-Id: <20211209150938.3518-12-dwmw2@infradead.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: 81d99abe2bd8 ("x86/kvm: Don't consume async #PF flags on a kernel #PF in NMI context")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/kvm.c      | 6 +++---
 arch/x86/kernel/kvmclock.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 4286b0f247ea3..32d3319115e51 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -324,7 +324,7 @@ static void kvm_register_steal_time(void)
 		return;
 
 	wrmsrl(MSR_KVM_STEAL_TIME, (slow_virt_to_phys(st) | KVM_MSR_ENABLED));
-	pr_info("stealtime: cpu %d, msr %llx\n", cpu,
+	pr_debug("stealtime: cpu %d, msr %llx\n", cpu,
 		(unsigned long long) slow_virt_to_phys(st));
 }
 
@@ -361,7 +361,7 @@ static void kvm_guest_cpu_init(void)
 
 		wrmsrl(MSR_KVM_ASYNC_PF_EN, pa);
 		__this_cpu_write(apf_reason.enabled, 1);
-		pr_info("setup async PF for cpu %d\n", smp_processor_id());
+		pr_debug("setup async PF for cpu %d\n", smp_processor_id());
 	}
 
 	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI)) {
@@ -387,7 +387,7 @@ static void kvm_pv_disable_apf(void)
 	wrmsrl(MSR_KVM_ASYNC_PF_EN, 0);
 	__this_cpu_write(apf_reason.enabled, 0);
 
-	pr_info("disable async PF for cpu %d\n", smp_processor_id());
+	pr_debug("disable async PF for cpu %d\n", smp_processor_id());
 }
 
 static void kvm_disable_steal_time(void)
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 1d986b353b3e5..047f97813bf34 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -174,7 +174,7 @@ static void kvm_register_clock(char *txt)
 
 	pa = slow_virt_to_phys(&src->pvti) | 0x01ULL;
 	wrmsrl(msr_kvm_system_time, pa);
-	pr_info("kvm-clock: cpu %d, msr %llx, %s", smp_processor_id(), pa, txt);
+	pr_debug("kvm-clock: cpu %d, msr %llx, %s", smp_processor_id(), pa, txt);
 }
 
 static void kvm_save_sched_clock_state(void)
-- 
2.53.0

