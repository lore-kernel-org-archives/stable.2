Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D543CE0AE
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 12:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782477945; cv=none; b=dayacexGuUU18eVSZiZMuIgoFjSlDCb2tKxMyurSYsNsZ0REnQ6B5C0/dCUAnmz6g10I0VNFrxZyCHRUWfmxBh38zX5tFQ0yLHm8liArgKX7r8WqWfipWCclalDbQJf10nqyrkxM7T+zYBXLaoGYFLYGXviDCcmRgpD041JY+qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782477945; c=relaxed/simple;
	bh=FkHjxpGiBuenLLWbujcCQGF4EPJtHSOxZuihQUx1EGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDZkNcmIkw2yv//hhdpGKROA83vF+nsBluKkCssHFoODfTuuiy46XrStQVJE/6GwR0KWa2IwrDhCeJBCvumHHhoaxTZJL5GEFv9WHAgLP5Zs4RrQy4k9yZFntmby7LhDHirzo5PabCk+D2+L14vwx08lj+XUsjnUx0lbd9o0+o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=NMTZ0sKL; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="NMTZ0sKL"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490d6730461so934855e9.3
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 05:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1782477942; x=1783082742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lMV/un0aP1rvQ3NoyXXiybhIDkcTe8lzMrAhqzhFogg=;
        b=NMTZ0sKLgIe85FdLRr7cq1TgnEaWGsKL5bXyrWZnIV47kDOQcWeoYiPYz5DKk8Qb13
         sldYmZRIlZ8ytntxIpekQuew+FZaAy/c+g2ETgGb9oFPD2SlRH/3Gh2MnU6CkAdCpQUv
         7SJXdmts/uerGJc480Kn754ARM6iwT/vVhv52iLgs7lU2/kjbM4fAttnG7Z6w6WEieaM
         CEvs2E+QoGyELmSrB0jcVCwBNDylTyUzFItsTMjt2PXLjBwsFxmhjaB3zB7acVy41ruW
         YC9KBjwKtQKNylbbEmHoZl49KD2895TQw0BJMAPD9PPj16jSVx+1AHNd5ynfkG3pkajD
         rsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782477942; x=1783082742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lMV/un0aP1rvQ3NoyXXiybhIDkcTe8lzMrAhqzhFogg=;
        b=D09eUltZz3CCsIzRSIug3VvIigwHpHaLClKOEifmyS+I1t1XUunTiO5vvEENIcM2+F
         Y+Lmh3rAtuypJ1uKFFprvbj4RD0uU1x964Nci6NV3J/w0ohAcSQJMet+zaLNDHq2qp2M
         Y7rJ5ahrbNBB+5JaqN+G965Km/bPX7+IxhG0ixPtqMMqz8iGlsDlp9aaZCy5JxMoL6BB
         fYivXzDzwppN0SrLbmiSQOlMDUdK8QMF0Jzhbms9Hr2BMR4ZfnsGzMyv6ve2LRIPYf7q
         CIFAjotig9oZE/gEJCRMVQIZqLwSoNb4UszX4L+KOSPTe1n8Cv+x/gujEkMr4Nd3awCF
         mkhA==
X-Forwarded-Encrypted: i=1; AFNElJ882XllgRstsKVynY7v6yp4EPQaqbYQ+qgC7LKzdzIBLOKbAHdnArxUfDwnea16Ab3YzhXJdts=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZKY9FB+/mVgqhqrIYaw+qscv/t46o7FFf7R5fdGLnqJvJCd9P
	1TdZDZvFExiGyMqikrnxhCJBebKH6TklD6HinlPPpJmN5JvkMh1RFojU70smNZuqrZSEjX+nb/J
	r0Q8gqBE=
X-Gm-Gg: AfdE7cmGGZvrCpjCgTh9ny37z9eKa0XliriK72TzqYnIgdEgcIeTxeDWqke/mrP/Sbv
	UTxG1yXgyihiO2J0MdSpdIYFuzjzexFFqrRFVjwzhiAgEkzGuHiO6NURYuK86vhoGw18Qkp3srQ
	SwZ5RDKT9upu8D5y+QewwVZLhW3aY83GL5Q1sJwXbFT0X2QqpnE2nQXDNFsNkaoPVyi66BSpgbL
	BomseaQ0Rs9107vew7yZiFldtknJtYMyHXWrQwJ11ByKt/qkTm43K0igUAgdMOiLY75zwKbRIm6
	a1gzHBWCeOfClBMnzn5Hs5+S2INc2hYn4iaTD4dhTbu6SxDc5fZd4/Pcrwg3AHVp2Y/hnv3hHTg
	SF0WFHTSC99c9YIgUDknY0unBSUFGv5r9u3vSIcIIusBHGG7Zw2CmipWUbsuDwfMJY2lHq4QLME
	8GZUhx7f/Cx7yEqU16ovvn9w5Jcym2+xittPvfi8WtldNo
X-Received: by 2002:a05:600c:a00c:b0:492:6e72:eee with SMTP id 5b1f17b1804b1-4926e720f83mr11158555e9.3.1782477942131;
        Fri, 26 Jun 2026 05:45:42 -0700 (PDT)
Received: from jwang-ThinkPad-T14-Gen-6.fritz.box ([2001:9e8:144d:e00:98f2:1188:3abe:e8d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49269020266sm73981765e9.15.2026.06.26.05.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 05:45:41 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [stable-6.12 1/3] KVM: SEV: Ignore MMIO requests of length '0'
Date: Fri, 26 Jun 2026 14:42:21 +0200
Message-ID: <20260626124539.201250-2-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626124539.201250-1-jinpu.wang@ionos.com>
References: <20260626124539.201250-1-jinpu.wang@ionos.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

commit 1aa8a6dc7dac8b83234b53518311bf78231f4fa5 upstream.

Explicitly ignore MMIO requests of length '0', so that setting up the
software scratch area (and other code) doesn't have to worry about
underflowing the length, and to allow for special casing '0' in the
future.

Fixes: 8f423a80d299 ("KVM: SVM: Support MMIO for an SEV-ES guest")
Cc: stable@vger.kernel.org
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-3-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 arch/x86/kvm/svm/sev.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 115c59c86f44..9374b1a93df8 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4356,16 +4356,22 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 					   control->exit_info_2,
 					   svm->sev_es.ghcb_sa);
 		break;
-	case SVM_VMGEXIT_MMIO_WRITE:
-		ret = setup_vmgexit_scratch(svm, false, control->exit_info_2);
+			break;
+
+	case SVM_VMGEXIT_MMIO_WRITE: {
+		u64 len = control->exit_info_2;
+
+		if (!len)
+			return 1;
+
+		ret = setup_vmgexit_scratch(svm, false, len);
 		if (ret)
 			break;
 
-		ret = kvm_sev_es_mmio_write(vcpu,
-					    control->exit_info_1,
-					    control->exit_info_2,
-					    svm->sev_es.ghcb_sa);
+		ret = kvm_sev_es_mmio_write(vcpu, control->exit_info_1, len,
+				      svm->sev_es.ghcb_sa);
 		break;
+		}
 	case SVM_VMGEXIT_NMI_COMPLETE:
 		++vcpu->stat.nmi_window_exits;
 		svm->nmi_masked = false;
-- 
2.43.0

