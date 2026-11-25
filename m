Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795589799;
	b=cvKTTruxTD1XAD1R9fdEmMTTfubP9RwgBA6Q9nhQg5m8qcC75V3au6LYYrkix1zWpaY6
	 F2PbdWv6cVcYwjJBpBCYKQZINio9BGk+vIPUc3nRNu1gtIka00C7fe4VuB+1kS1K6/vjv
	 d/u05/cLuHDGmTWKKuMWO3L8G44PI0zP/1GhPGreay9TdufSUIBz8b6jd+MhGNAQGaWem
	 mt0q/IRcZKPxx+WT3tWSrB0hPiyrqevj7N7pM2GrBBfTgk1/8KK49apzfXZ2yOCnQFDZ7
	 AOyMZ0SOmo5zSEwS9T9kG42E9hjoX7huxZHhormmsZCDjGW4WtI386gYLcnKNrtYIWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795589799;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=4BneDH3BrmldgDuSfaRvWpkmdpUNgHqyqEERpyedMrs=;
	b=WrrgSIhHUIVCa8NrLGl6sYey64MSS6ob0f0S87h1Ktf9lXYx6tOfe20nrxQxh59bIWha
	 KqqcJY0pmPEf+eeqAkxnNbCeFHzFDyLVRRDWq1cO6PWWSAWGES0K0A8NoATO/980wLEH0
	 NuvdntcWV0bBGvEVdMMY6ore5x5mDnc6ncHirsrNmHdGWr3Pd8Yn07hinf2XxSTmksH7Y
	 xrOh9gssMt6KMw4z2i2metpIX4Fa1hoBgZjAiwvGZGn1VLlgLJVWy3Cs/z19SZkQg1x1Z
	 pAmpCwJIUyEHQnclmQZ3t9nB37h5AvZOv5M9FiA/lIDcXaX3Vu1ARhuzgEtuOzGL9Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	dkim=pass header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b="XBUlah9/";
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C109606A680
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C109606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=XBUlah9/
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4ad6219f7d8so4674575f8f.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 22:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1795589797; x=1796194597; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4BneDH3BrmldgDuSfaRvWpkmdpUNgHqyqEERpyedMrs=;
        b=XBUlah9/GQf7hrF7Fc0I5v9Mld1l9uEgPBgSa5e60UnZPTMgSRfXCaR0GlgV8QtsEW
         1l0+3I4zvi7ugP9docqB6bogu8Gcz+3Anw3I1KziFN/T4+OhQcLzpOcC81HZwvgt9xBs
         LDr9jUk3cEoqQp7xe+AX5X8HwkkU4Zdh9NNYJIhlYeA4H7NYoc1BWGCT8QlfWStrsSk0
         1KW71nEYkMXf/XZcyuNB+X6qqw6vtzX9DhNm0kca1awI9gioFCYhsw+fJWlOY24Y5ZPf
         hr8GNgaiWxmZtStudQtaUeDZkWOWNpxD2oUuH01qEMF9GH9qzlW0HWGQyLgAbUPMG086
         Gqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795589797; x=1796194597;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4BneDH3BrmldgDuSfaRvWpkmdpUNgHqyqEERpyedMrs=;
        b=aWCb8AmW4JpOH3YErK5W/bWyfDbxlfdhJ50Svpl9O8iSKic3ESt3bojZVLy96RHtmA
         ImJY3rhKaf7BFMTFCaJBc88PvQ5858we8GfFTZi1lnPKrokcZiBTcu/3GYJES4WCchXa
         VMUQur36QjWsKH0yXp/u45piIA/+uB1Bv7At2jJxWmm6jlO5QjTHAst0vLJEIv5QagP5
         418+xr41/baNvUYKUXBrGsSWd1ZAbS2atFlG0hugxYTZ61zXvSvZZag73twyjXWtqPwP
         Myfmd8V+BmGZJUVaNtW2dqVQ4HJQNRnIkVAbk0KQehrOpsdzrhitpma3FWqpmtUqKPag
         nZUA==
X-Forwarded-Encrypted: i=1; AL+hErE2V9VTuiP/gvr2I3sB4GvVEoRV3DRxyynjvHy/7twHCdEPrgO4Jx3u5zF9y6Po6uLMFREhqBo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ywtIqwMFIU3kRyJBBeN01zWEgj9NX3+JkHrWzMpUvAWK8eqAp
	MVMjjynwqLaHPD6tibM9ZO6OYqwcKFlzjZ74iAbRUtKJbJUzqJ9pCnC1X3WJWPoenjE=
X-Gm-Gg: AZFdTZeP9uSpWsLj2BwDjo26oxjT9cE1Q4y9I3n55LJ2T4u1w3DyavAB1pIfQGqZ6rv
	cm0BrAwhqwQkOIfT1OtD9xHHdjHHRes1uVEImlx8IWxMDK8YJ5suoVjw6mIo7WLlFXLJW0xi2E6
	L+BWHin0OOySK6wQIQcT45W/VScYn405LBHreuekh3aZhrfqAmKUyjOEK95BugaJvI2Df0RdL5j
	vcDftqA2M9dM/WlPwIlgyPjHRAUB8cEiSCtg9pc6L7bh1ecAzYeyRkfugYXZaVK062nRVmqxoMu
	V6LSQhz8jQDpHueg0OlAJTdFe/emr60YLk3nMPVMtOrsCt4bmb3yZU+QgpGQswxpcRSgnQaQNEQ
	S7X/z4X99Yasp/9T+d3h0QVpOIBKUxPwDt7ub8+DqzyIq22RadlvojvSbmjTynYXSpTeo8nQ/Cw
	ZZdAqn/o0MOb7mg9WQWAJNWZnsoraCEOlvQYXgcOD/4h24vEAXh+qj8hvwj7/N5NdT8iSlGexT2
	RHAz2uXKvXLLzP6ojeQa+0H0oAZhglhayX4XdrF2uAXm5Bt9AiWISAL8/mjFwoOX3PFsog11AUC
	dQmL9VhfjqDZCq919/4=
X-Received: by 2002:adf:ee47:0:b0:4aa:5396:a792 with SMTP id ffacd0b85a97d-4abb514608bmr25076345f8f.23.1795589796866;
        Tue, 24 Nov 2026 22:56:36 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm36981016f8f.24.2026.11.24.22.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 22:56:36 -0800 (PST)
From: Dan Carpenter <dan@pereq.eu>
Date: Wed, 25 Nov 2026 09:56:16 +0300
Subject: [PATCH v2 1/8] KVM: arm64: Drop an incomplete MMIO access when
 resetting a vcpu
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-double_exception-v2-1-224689d8a764@pereq.eu>
References: <20261125-double_exception-v2-0-224689d8a764@pereq.eu>
In-Reply-To: <20261125-double_exception-v2-0-224689d8a764@pereq.eu>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
 Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Steffen Eiden <seiden@linux.ibm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Christoffer Dall <c.dall@virtualopensystems.com>, 
 Rusty Russell <rusty@rustcorp.com.au>, 
 Marcelo Tosatti <mtosatti@redhat.com>, Sebastian Ott <sebott@redhat.com>, 
 Eric Auger <eric.auger@redhat.com>, James Morse <james.morse@arm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>
Cc: Karthik Bhargavan <karthik@pereq.eu>, 
 =?utf-8?q?Cl=C3=A9ment_Blaudeau?= <clement@cryspen.com>, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 Dan Carpenter <dan@pereq.eu>, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0

When a vcpu exits to userspace for an MMIO access, the next KVM_RUN
completes it.  So for a read, the next run increments the PC counter
and copies data from userspace to the destination vcpu register.

A reset should cancel the MMIO read/write access.  Otherwise the next
run will copy memory from userspace to the vcpu and increment the PC
which skips the first instruction.

Clear vcpu->mmio_needed in kvm_reset_vcpu().

Fixes: 45e96ea6b369 ("KVM: ARM: Handle I/O aborts")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan@pereq.eu>
---
v2: new patch
---
 arch/arm64/kvm/reset.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 10eb7249aa9e..26081d273408 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -199,6 +199,7 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 
 	/* Reset core registers */
 	kvm_reset_vcpu_core(vcpu);
+	vcpu->mmio_needed = false;
 
 	/* Reset system registers */
 	kvm_reset_sys_regs(vcpu);

-- 
2.53.0

