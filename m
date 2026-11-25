Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795589805;
	b=Og//o78/eAJPl9rLof9/b27SaJsgBQ5tQ7uZ7d9RjwW2bPbN9/QE8Uqe+UGFGshmk5vS
	 4kMr+lwqd7qXFetl5MqzFaaGZC3uQadpO1k6oL5Qj7ATJX43TncLZ3Um51RHDXk/b008U
	 S1jHrOEmZX8Uu2ccd2+OWOSNj5DTaWfuJ/gZAzYci8tzSpxcMhsqmdZPml0c/VgqlH9oh
	 IjIFhTyhWrNUqdZB2Fv2uKBZzZhpuzll1VzRSXMTFtLPJGc6mwQvdgQo2nIkfsaBDfZhd
	 Rpp7Ch9nqh8Hs/bAwfiALjv7shgJr6PBix17cl8X3e7QcwgrwmUVR65BHq2DcAQyDpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795589805;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=QoytpwQW2+7nMQ4LJ/J4mzx2IC+d/7ZRY8SoLyVie08=;
	b=2Qmu7nIcl/FfOznkDrvXlJE/A9yN0+7yqN1KeMZl6vJIMMmEk8QXkS2z+TBFjJ2X+zTo
	 boi5R6MZg2HaLDNEMk9SzppwHO6Pedt9D12EfnEbPvWLHy4knqY3os5TuYMWWzErm8lY8
	 7ZaXAV0V4oaYp4I1GC+mRQEX9DgUTFDb5iygKnGiEjtSStgEBuy6EUU9BZm0Oo/ywhgz9
	 NYfFZeFCJJHE42p3yFbQxoNw0KoTrffz8neT1KGnMgO20b1RUPog7uaCQGAz+2l7OhW6t
	 DEJIq/zWTu3IBpekHD3zHF0Q3eCiow8siGaQdKzfsDOve7I5ZNa7ZnJXR4gMxz8OcBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	dkim=pass header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=Qwu4TVHn;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A000606A337
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A000606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=Qwu4TVHn
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4aa5833c263so5149679f8f.2
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 22:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1795589803; x=1796194603; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QoytpwQW2+7nMQ4LJ/J4mzx2IC+d/7ZRY8SoLyVie08=;
        b=Qwu4TVHnW5keU4MSRtovHL3kWNCRibVMHT5yd6sFTANGcYG2F4QtvKQtJk58u0+Yw+
         GIxNJ0WrtEkkB8C0DhGkPNDoddvnXaWkhAEyfpLWjA6Lu5seBZJZ9woFcCEFD9Dhrpz1
         2+8yQVao6dgIYPABEpcwn8VFa6A7M2iE96PhtMuKDKuUgyDcM+0g4tpr20TLFQU6CE+Y
         VL1h7ONRvNATfpbYeEWlgEL7xWF0d4O0km2XkfSdLjFevIBYdSfORFIIilnHhPyVCake
         iPNrytXSRzPAzRZLHcHvzauBwBEu5RXzAWCxasQm8qpGi0yysz4fgLPuKbj04m/Dm62n
         +zkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795589803; x=1796194603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QoytpwQW2+7nMQ4LJ/J4mzx2IC+d/7ZRY8SoLyVie08=;
        b=Leo+L3Ker7JXOvOxSgITxBFTSTMIESqqlgazpADe929ms+Oa2EPLmc+MIrl4q69zvX
         xE0224S6boBEw+iXWU46AWqbWMAWB7+dgHqqIIiRJcTsxc1XnuA2Yepk+/WEMtcdIG3b
         nQggoZdZ5pXFaKmXMH7EeB4YTMYDX6Su1dAcBM1iAFLcVcIR2bxuJXDC1HDDyGPrWIYa
         DBpnRv2OjfbHCo/fXIHGsLp9tpWAabmr5mEHRCWW+zNWLgNuvTKj5bHeSuFC87pHD74q
         NxgWPJFtjKXHXM2vhb7d+IA/zUZNkrAK1EtwppaF0147MynWk3YOGDEQ4FJ+njWjsW6f
         Rn/Q==
X-Forwarded-Encrypted: i=1; AL+hErF4jmwbMiyPCbZq/vbDh2uP/kU7GttZclepYE++AXcSrYvBBFlm9BfYYhkFv3VjtBn9nKxjZTE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+s6aGerQ3y+t9fLxTuXDTH28bLq/TSopRiXDe99CcYO93hRX+1
	FCInxmhqQTVwdv+zi01PNs8SmDQapiRVn4DyGSuFxOKnJc2Jfd9VtgLa9iitpWhJDXE=
X-Gm-Gg: AZFdTZfBV+WMpCjZ3hIHbpJO9qvHquedK4ts7UU2zXGKGHNlf0N2kEdjlmdN0QvQEvu
	4IR9k/4kOx9Rk1nBVmIeb9N5GWrCn62QT3Fq50OyE7AQ4MeceWOjgxZsorKdZxJFeLHTZALDcxJ
	yc0YSySj/XfybKQiiqSGpioY2MM2+RR3feGzxZctblhu3W2RjJFMbjuajiZ5+06uUTnrC38uS58
	RNvbDXVF1T2he7Hcn0eiKN+WFps9sNxxkl4VaroJy+//WvMpoTOYl7oRoBipyuKgF4SIXcR003p
	4lCB2sxXW+E4Meh+7AoH0BWglV69WCGl/ZG9sf8AyrulUU0Zj8zzaKadReO2B8Uy6Wy5ppfIVkp
	n4xuJOV0wNJrnL2m280uAwujyyr84tAtmCcAfMyFZUhSoeYamZAGIhwsrWvEd6Iw+q57mXCLhJL
	scusvS/TwwTMDgawNUyMvwN/cegiaAjZAmu8QHrJFrYDXu/DpJlnxUbjo7EqWAHGI9RhlWK79ts
	EB9X9Wsvh0aAfKXgs7it4XH7mfBgPMbANE5Y/G8pzMjn+xysgDypBt7sbA8jN0AfGCZhyLlSeM8
	HOBBxRxMgoHKDFCI8i/cR4hdVDXim72/qdxKhmO9
X-Received: by 2002:adf:e00a:0:20b0:490:1881:80ec with SMTP id ffacd0b85a97d-4abb3a4d2camr23594315f8f.36.1795589803330;
        Tue, 24 Nov 2026 22:56:43 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf6804sm31864281f8f.10.2026.11.24.22.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 22:56:42 -0800 (PST)
From: Dan Carpenter <dan@pereq.eu>
Date: Wed, 25 Nov 2026 09:56:18 +0300
Subject: [PATCH v2 3/8] KVM: arm64: Discard a pending SError when resetting
 a vcpu
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
Message-Id: <20261125-double_exception-v2-3-224689d8a764@pereq.eu>
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

Resetting a vcpu with the KVM_ARM_VCPU_INIT ioctl keeps a pending
SError.  We used to rely on vcpu_reset_hcr() to clear the SError but
commit f1ff3fc5209a ("KVM: arm64: unify code to prepare traps") changed
it to only reset HCR_EL2 before the vcpu's very first KVM_RUN.

If we reboot a guest while there is a pending SError then KVM delivers
it to the freshly booted guest.

Clear HCR_EL2.VSE in kvm_reset_vcpu().

Fixes: f1ff3fc5209a ("KVM: arm64: unify code to prepare traps")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan@pereq.eu>
---
v2: new patch
---
 arch/arm64/kvm/reset.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 9c1b42890c96..a5d298d5ce61 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -207,6 +207,9 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 	/* Reset system registers */
 	kvm_reset_sys_regs(vcpu);
 
+	/* Discard a pending SError */
+	vcpu->arch.hcr_el2 &= ~HCR_EL2_VSE;
+
 	/*
 	 * Additional reset state handling that PSCI may have imposed on us.
 	 * Must be done after all the sys_reg reset.

-- 
2.53.0

