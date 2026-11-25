Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795589796;
	b=XJbCa1FMtkCEWXNCV2eCvdzoajY4XoeqFT1uHW3zfifDkZ10uDL6ZFJtzafTDx/OuFK0
	 ZpRx3Lw5XYIDiTyy/1xN9ucdg0h7Re95ye1xB1Ih2ZgZEsRTQEvALRINHEQYvMadd2rqt
	 86Ry8vg1o7NIsxUIaVTT+wMB/FFSQsLHQXPVjQuj/aURNQS5D1BRXKnz26XAC14OI70zz
	 EksIpeTOu5H+GDMn8KUOsTtK1PMzxMKBWBYYn4hkPvzLFi8nNMWC9mULNjACCE3L8UPx0
	 vlysJssJ9IZaVl76cXQ6RwbKA6Obl1PCNSf5OYecawmK8Pcawy9YO/WxuuRYaeZnDcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795589796;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=WQnd85yPB60bhdolGWcMJlVAtTrb9nbyVFLWQL59DRE=;
	b=quYj26OhzxMbJ1kR6mksokwvAR02GdCf0L61TZ5bWxRBC0wk8VohfKKklEBTW+IJLpUQ
	 hrAlDka4JciyeoBhFfmVygbgY012devhrmad+0QS/rn8f50J2JMDJ9Ss8OsSSQfKZI/ym
	 0OpEEt8ynFT+UDDPC8LB3pN/cMZUVSKU4K5Lm0RSB6d0BKiwY4FTKr7oRQb8ebEfe/tH2
	 2lhwG9h2sDzVY1styx4+iWJNe4RoWizGr6UlONSYCCj3CXANhKn3fkgWRZBNZ8d9zQ6gJ
	 B/ABt53GJtJTpYgQ3QRf5ew2YUfkCTwnZFJt4OsGufiIBjMh8y7SYd5UMjoLahCPLXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	dkim=pass header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=M9cXuD2e;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E690B606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E690B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=M9cXuD2e
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb72b44a97so46082385e9.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 22:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1795589794; x=1796194594; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WQnd85yPB60bhdolGWcMJlVAtTrb9nbyVFLWQL59DRE=;
        b=M9cXuD2e16YtiBuyCgCK5y4vErgs+z6SK5xnJwotqHno/AfUjPvKbgA19vHhFIlzm0
         CoEgT1A1ucZpKSv83wPyzLCRMhmNSvnKKvLHje7W1IoId+eGvlOXWNcO/LuWFJSF2oQ/
         3C1NHvYuzPb+9ZNPKRv/I9o4XlU42ogdA1sK8XIhFWrOmE7p5Gs0FNva2+CPFg57IuDv
         zx2vKk3GUUYuZdj0g/LoIuZqsT0GpUzoCR9yIk6Bu1330PrnaKiKdtIOC4AR7Lp/Pc8y
         r42fLnp1w0W87Wg4Mfbm3N8nf1eI221hr99iwK46F0BG2rXdWB5Pf02hDOFpZDgRXHaw
         lEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795589794; x=1796194594;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WQnd85yPB60bhdolGWcMJlVAtTrb9nbyVFLWQL59DRE=;
        b=M8FRdRCD+OzeNocwKF5Vydwj3Sx8MldSePoNduqTu6cK/jkxKwaaRGwGVFxuvQ0CUO
         3cVCOBDam+BcXVxTY19l9LpV/XdcXtEYp5wT2gd411yUogdsrjHeElecW2cfa9df0P+6
         le20SOJdyumc+4fzKTGl8V44RZAEI0MmuOkNTMeqbOodJdvrXU4+1yrwdn9CWp5kpR82
         /cWytquaR7ZH5aTwBhQ33zaOZ1rdv2pb0RDfouWxzJkWCvUhKQEJ0MvoTZHqUFXppZnb
         P74cQJiOUst92MfTtxl/IaGGMaMENwnCPbOZ7sqs38DBh3KMhf+p/YMYEsXmINuVs1dV
         n9fg==
X-Forwarded-Encrypted: i=1; AL+hErH4yXHmF/BF90GIlb7pZIXoTou8Kq09A/YEZ+6N9d1kmdzJTY6Nzzkbm+ttP5mu+lOpNp4bZB0=@vger.kernel.org
X-Gm-Message-State: APuU4Z++XXVj9Mp2sIUDsfAbsu0BPFjFnYL+tCxNYQH7xLN5eqPoor1c
	/g8M9XprQRZ/LxOZLByoakqkGOsr271LjW2rpwSbxDrS1jxivZtUiW5sOBTu2vJDMw8=
X-Gm-Gg: AZFdTZeReKMmGOBaEWs19G62m7y6k3mdxuMQ4lCp1ttZosbK2iVGfH4gBqtcdi4l4yy
	elpm6Siag8DrdZ1S4Vo85N3o8iVVltUmNrNjUuhK/X5G5g1jffD222cxrDgAoiFUQ22/t+yZBre
	qftjwGlinfkHUH5VDwg8tf9JJSFbGT9vqI5zaAbJ4uE+T0Gd14oTGk68S4hMZRbZ0MKIQ/yg+/u
	g+idKNgucvCnyqcciWjGTHiQ51xzP6Ju6XgkNfMeJEn49ICxy99YSK6BYvhJH6CZCz//FPaf8eQ
	J53zqwNs6QI1ByFAHLmkOOCi3x9r7KlAZpI9v8Fj+XRNwoO9mlChtVt3mR6RPkkY3629t6CcL+M
	EvtvMxjXCaK5eVP1FcgZz2VBvvzX+MdGp43EwAjpVry3+LluyVAdHSc3ZZJBbJqXEBqnWWuxQV1
	73cfzJr7K2wgukk5H935VKt/nj+k+qlAouFBfzTFYUG/ujS/W3lxcyMinGoW2nOQjrLjSIybnCj
	5iKjgyfi3HTPVK4Rj34H3Uvrn7plHCYY6IIcculdvbpxUnqx/doD4jxf9NlSHD+XaKxGeMzicwZ
	+WFRaS1XCHYzzOXrdG6a
X-Received: by 2002:a05:600c:530e:b0:4ba:eb:eb9b with SMTP id 5b1f17b1804b1-4bb8880aba2mr330852995e9.8.1795589793909;
        Tue, 24 Nov 2026 22:56:33 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b8429sm777474785e9.14.2026.11.24.22.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 22:56:33 -0800 (PST)
From: Dan Carpenter <dan@pereq.eu>
Subject: [PATCH v2 0/8] KVM: arm64: Fix kvm_reset_vcpu() and SError
 handling for nested virt
Date: Wed, 25 Nov 2026 09:56:15 +0300
Message-Id: <20261125-double_exception-v2-0-224689d8a764@pereq.eu>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WOQQ6CMBBFr0K6toYZxKAr72GIaaej1BiKLRAM4
 e62GFcs/8z7L38Wgb3lIM7ZLDyPNljXxoC7TFCj2gdLa2IWmOMRAHNp3KBffOOJuOsjLFVxMEQ
 lAkAlYq3zfLfTqrzWvxwG/WTqkycRWgWW2quWmnTaGNM/cY0NvfOfddsIyfefUWxnjCBBkqlQl
 yeFBZpLx57fex5EvSzLFySRl6jpAAAA
X-Change-ID: 20261120-double_exception-a34dcc521118
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
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0

Our formal proof work at Pereq found a way to trigger a WARN() by
injecting two SErrors.  Then Sashiko found several related bugs
and testing uncovered a few more.   The original patch is the same,
it's just that I have added others as well.

I have included a selftest for kvm_reset_vcpu().  I have a selftest
for SError as well but I have a question about that so I'm going to
send it seperately later.

Signed-off-by: Dan Carpenter <dan@pereq.eu>
---
Changes in v2:
- All the patches before [PATCH 7/8] are new to fix other related bugs
- Link to v1: https://patch.msgid.link/20261123-double_exception-v1-1-cd82b59a232d@pereq.eu

To: Marc Zyngier <maz@kernel.org>
To: Oliver Upton <oupton@kernel.org>
To: Fuad Tabba <fuad.tabba@linux.dev>
To: Joey Gouly <joey.gouly@arm.com>
To: Steffen Eiden <seiden@linux.ibm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Zenghui Yu <yuzenghui@huawei.com>
To: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
To: Christoffer Dall <c.dall@virtualopensystems.com>
To: Rusty Russell <rusty@rustcorp.com.au>
To: Marcelo Tosatti <mtosatti@redhat.com>
To: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
To: James Morse <james.morse@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
To: Sean Christopherson <seanjc@google.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Karthik Bhargavan <karthik@pereq.eu>
Cc: Clément Blaudeau <clement@cryspen.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org

---
Dan Carpenter (8):
      KVM: arm64: Drop an incomplete MMIO access when resetting a vcpu
      KVM: arm64: Reset SP_EL1, ELR_EL1 and SPSR_EL1 when resetting a vcpu
      KVM: arm64: Discard a pending SError when resetting a vcpu
      KVM: arm64: nv: Discard nested SError in kvm_reset_vcpu()
      KVM: arm64: nv: Replace a pending SError when injecting a new one
      KVM: arm64: nv: Don't deliver a pending SError to the wrong guest
      KVM: arm64: nv: Re-inject a stored SError after the exit is handled
      KVM: arm64: selftests: Test that a vcpu reset clears the vcpu's state

 arch/arm64/include/asm/kvm_emulate.h           |   1 +
 arch/arm64/kvm/arm.c                           |   1 +
 arch/arm64/kvm/emulate-nested.c                |  14 ++
 arch/arm64/kvm/inject_fault.c                  |  10 ++
 arch/arm64/kvm/nested.c                        |  16 +-
 arch/arm64/kvm/reset.c                         |   8 +
 tools/testing/selftests/kvm/Makefile.kvm       |   1 +
 tools/testing/selftests/kvm/arm64/vcpu_reset.c | 210 +++++++++++++++++++++++++
 8 files changed, 251 insertions(+), 10 deletions(-)
---
base-commit: adcad7f4e6332cff3d6d7165f41584899f598534
change-id: 20261120-double_exception-a34dcc521118

Best regards,
--  
Dan Carpenter <dan@pereq.eu>

