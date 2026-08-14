Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6AF423EAB
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786702031; cv=none; b=Hx9iYdOAUpG/GsJuzYw74stxaWelpaX2NAyGXMYrLfeptPGhEY/LPwTZLNF4trxjhYnNY2I46hIUC9q8bIrP/EykqnphNn3tfuossC45BCvPAly61wAPllOwmk3T1DoQP8gpVdp0vijdGoxsF6G6RylrJ2UDHK5YIRjVWVVtdSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786702031; c=relaxed/simple;
	bh=lu3oiZHdn1oPafs4VvM13GKorlZWiahF5Sq1agc4u4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MhQrN+CWqs9ZWz5DIws2PuBSrbpHTGR11xXlzhpJYn0m6xlohJilUU/7xLReVUEY31nvrJyeDDiPsB0PCS756nKM0uEmrkmLsRpzHiNwB7xdcLiVISpdEdUj22QWGTa18PhvIVlHShCxIh7TFb7mZrj+QYWjBwIf9a06VgKxnu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=fy36nXAQ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="fy36nXAQ"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47df6a5655aso80266f8f.1
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 03:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1786702016; x=1787306816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wnagy4hoKWrnjLDCc/m5J8blIL9xShDWIzlqFoowWGk=;
        b=fy36nXAQVHcUjObK3n6fsylJcs0LPEkRSkrvIzvxlFoYifCRrBcV6cw06XeLn8djOg
         0pvLDMHEYJKI5YoLiGFEnyku3tWbIuHwhtlnyu/Hj/HMS5X7yRIM1nG6Yn/Om0GUArBC
         KlOmHlCCINlCWnk9NMbWzYI7d/V/xn/fqu9F1E9HrqpJhvUQ0uPDOvQGtqTHygOUZrPR
         04BuIKI+KjIpOCXKm2c3MObrP3Z6mkLIX5HBLNCAXLtmIq/nLDjMQ5n6B48aw9hYKY4j
         fziF7ZvTEWZU7vSLsViusG7S1++7jEw4Y/S7/dPDu8sdaz/jNDxIfVPUFrrBhxEQ/kIo
         06YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786702016; x=1787306816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wnagy4hoKWrnjLDCc/m5J8blIL9xShDWIzlqFoowWGk=;
        b=L0IA5r9j57h9wcj8ADEsP/QR8ku1ucbw6f7KyLjoj3pv03tpGgmjRsJiMTEYSfmGm7
         ap4yMs5vURSu4NZPdG4KndyYn9qtUZKbkkQ9h9CwHq4dvqAE6imsoD8lE7UwH4rmcWrk
         r42+RPrhQjfUMgLgnXenYstNfNWELiIvblfhc26tEUMI7vDuaWIDZvSt5RUSi/gEhDve
         Wdb3oEHIHazV/BHbeo17vjubk2yxAV/kfDBn89N0tlphAmgr+1gQCm95TR1woA31cR8p
         jdFhvcTHkbNoc2Z37eFEdvDVbSwcnAfH76fT6tulFn5tX5MHw/N/7EtsamKQD11Ds+Av
         Qd/A==
X-Forwarded-Encrypted: i=1; AHgh+RpRVbifHXtWJ4S9p3henElmwKWS71j3HXJTUE4Mv3IeBto+IDkrg6bvJlv6u1F9Eo0jlYu1GHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwskZEN575u4U6w+j/UvnF8jxm6FI3qcM8mZ6fZuIWRZXT7j9hU
	oFzCxifh0qo8DUJ4hgDDwpaZlUwAfN2PrPpExFvIZYDUpKmGhU7D+ZnYXtctESOHzAA=
X-Gm-Gg: AR+sD10vafD/RaJhCI6P92bRk/mfd/YZGU6cKvURRjgZqSpCtJfDEYFq186mBHtFUsj
	XSJlTHGpc2Hd2dRO7CvdcwpP9tErugxo92cP2F6uVEOXUFt24gT15bnNx5G7g5ZN8SXjTInbGfG
	JQF3SlZDdeVsOJAWvxmuEiTse+IdWd3zZmCJfpjDSDzPRTSGNlwF1Q5DdFcUIj1BYAiuUpSqqAz
	eJqXtWZPTpIe36EbQ/VMWdC4YJb75Lx6hUYDSCJIMkqvm48ZYH9GY3I4THLUalxEH9L/r7bIdl/
	SP8h4nVuzjMNrbg77nHdhUTlHykxKBdScAjoEy0JLASHtWVc+MpR4/vFBFuu4g6GKmQegnP+K5E
	7c931DTcRZcxFPohU3UN65ptwDh1OYOAYi2RrpuhjxIxRhUAN4kvP0UH9vIiaeRqzkvW2oiNoLo
	0JYgdqZ9IgXMw6yrhE/ayNy5WAPh8adVC9Rzy0yiBXtOEIK3md2VmDyMFEbMeeOUytuCvVUAvi2
	Ep8lnSpmXdOV5sc1mvTDIyAevrD6qKfzQbG
X-Received: by 2002:a05:600c:354f:b0:495:650b:4c61 with SMTP id 5b1f17b1804b1-499879690acmr29766545e9.3.1786702015874;
        Fri, 14 Aug 2026 03:06:55 -0700 (PDT)
Received: from jwang-ThinkPad-T14-Gen-6.fkb.profitbricks.net ([2001:9e8:144c:bd00:56c3:670b:dfc6:d046])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2b1d9bsm6948207f8f.24.2026.08.14.03.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 03:06:55 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: dmitrii.omelchenko@cloud.ionos.com,
	Ashish Kalra <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [stable-6.12 2/4] KVM: SVM: Add support to initialize SEV/SNP functionality in KVM
Date: Fri, 14 Aug 2026 12:02:55 +0200
Message-ID: <20260814100652.225499-3-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814100652.225499-1-jinpu.wang@ionos.com>
References: <20260814100652.225499-1-jinpu.wang@ionos.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ashish Kalra <ashish.kalra@amd.com>

commit 6f1d5a3513c2370bbd6115dd430906bc2f4bdc53 upstream.

Move platform initialization of SEV/SNP from CCP driver probe time to
KVM module load time so that KVM can do SEV/SNP platform initialization
explicitly if it actually wants to use SEV/SNP functionality.

Add support for KVM to explicitly call into the CCP driver at load time
to initialize SEV/SNP. If required, this behavior can be altered with KVM
module parameters to not do SEV/SNP platform initialization at module load
time. Additionally, a corresponding SEV/SNP platform shutdown is invoked
during KVM module unload time.

Continue to support SEV deferred initialization as the user may have the
file containing SEV persistent data for SEV INIT_EX available only later
after module load/init.

Suggested-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 arch/x86/kvm/svm/sev.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 6cec696461da..bd0344bacaf1 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2972,6 +2972,7 @@ void __init sev_set_cpu_caps(void)
 void __init sev_hardware_setup(void)
 {
 	unsigned int eax, ebx, ecx, edx, sev_asid_count, sev_es_asid_count;
+	struct sev_platform_init_args init_args = {0};
 	bool sev_snp_supported = false;
 	bool sev_es_supported = false;
 	bool sev_supported = false;
@@ -3088,6 +3089,15 @@ void __init sev_hardware_setup(void)
 	sev_supported_vmsa_features = 0;
 	if (sev_es_debug_swap_enabled)
 		sev_supported_vmsa_features |= SVM_SEV_FEAT_DEBUG_SWAP;
+
+	if (!sev_enabled)
+		return;
+
+	/*
+	 * Do both SNP and SEV initialization at KVM module load.
+	 */
+	init_args.probe = true;
+	sev_platform_init(&init_args);
 }
 
 void sev_hardware_unsetup(void)
@@ -3103,6 +3113,8 @@ void sev_hardware_unsetup(void)
 
 	misc_cg_set_capacity(MISC_CG_RES_SEV, 0);
 	misc_cg_set_capacity(MISC_CG_RES_SEV_ES, 0);
+
+	sev_platform_shutdown();
 }
 
 int sev_cpu_init(struct svm_cpu_data *sd)
-- 
2.43.0

