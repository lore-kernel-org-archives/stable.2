Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795589808;
	b=abYyNGo3mebP5YTA1m/zzVyf0bXuYD5F+DRamkef/09C0GQFX1CZRG5+3eQEnf/ClMpt
	 Q97MaNvhQ2LcKHdYjaqyb/MgPkEzTYIL5k1het/V/AyDL820h14NhEJNqhHZLEWQi6KBb
	 hSJPnl4JAvBdj6Kdeu3oQ9a3I+bgrlFaGypMy0Drlqv3Z5KxYbsHqZ5ATUdMeNaCqPgCa
	 X4AKbX2ckEK9rH8Ijd+3JpclYXJSfU4hdsl8893MRm1xYhLz3j/K3+FllgTj1urGY7HeF
	 7wlrmD9TVcpa3GEPy6eTqD8MnEnB0qjeMYZ5jRM8g6UNazAkUaKf/VHFaOx1W4imt6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795589808;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=FprakhUf8NJ7i/pJUhVF+s5uu9taLAIMe4T8Serof+A=;
	b=ADpdT1yFMDsbDAIfb1iVtPUAYdfvFYGf4g+xM1FmiBvYrpYCCkVNp6Ggdvj/q1PdqQKE
	 erpGVPgdgUggyERtJXvrCjvT1628QEvUES2XIrE3ktLkUA0TkPWQjKcnhgk5YbGTThYSl
	 z3NA6PzR8hpyPzj+Z2FoY2BUTXo2M1f1U2zLaTshJq1SQt5RBc0QCLx20qdzNsGDoGtGJ
	 GCXBr/1xiXq0WIM7E6ectOApQgwSt91ZEUXkmNZBsRd6eyLwqklwMAxGfUnp0OVwro2FR
	 hPuFr23ov9E9n/eReHa18QGZaMytronlZScPXcDUWfh1d/Kcj5ObM1u4OJ872Jci2Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	dkim=pass header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=RlPZXaa7;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DF4606A6A6
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1DF4606A6A6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=RlPZXaa7
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso4714768f8f.2
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 22:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1795589806; x=1796194606; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FprakhUf8NJ7i/pJUhVF+s5uu9taLAIMe4T8Serof+A=;
        b=RlPZXaa7fe7EQZlpHI+2GAQlXvVlmpHFOev8m+dtEjaz87EYAL8kAQJNFvcebnJnCJ
         QayppHZcapAX1zGtIIZsMb3RlEGPDjqVmWDvVCnvzPYoTLjBV9ke6fhmRYjzuIaAP7jA
         uK7+gZzUDH1J8jBhKFSXooKzUaz9d+QZLs7K7nY9iph4N8+4JXQtNDxgs+EMim1wIgD6
         3tmYEVVTb6u68vD0HJXKScfYOusBlvBMoLIrGEGqC4lPbYcn7H4MFr1XSBLw1XgIUh2h
         xgqu/Fuyde2lH67JzlyZNxMTaIY04TI3Dwh75KA5/W7iI/mh+UWUbKewCi1k6FPdGR+x
         yANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795589806; x=1796194606;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FprakhUf8NJ7i/pJUhVF+s5uu9taLAIMe4T8Serof+A=;
        b=JvatdCP+9PZsVEpfa+YicwMHGAGEU9Rky9bOaTegnrSNRB/xiFKUO0eXYbWsXU2of1
         Y9dKt/N1AlGhZKVaflteztVdlcXM7+hdnNC8nVDIehnw8U0t9jlrwK9a7A8saiF/l0Ox
         jwxmPoUPIXCvp+dUR4Cor663RFoc5L+YgOLnQ7oS4R/r1HNTzdrcgf57AA3+hsHYYhvC
         0QyCcjVmaFzaz1LqMXoGRx/xXjBDob0hwUcAExQELPbNj1jRUf51U48P0yD7Qc+Lniye
         3wgRIXetqzBACfLwKZIb/hzNqPmnlR86g5aYOt0Y9NIufcxc6/b6Fan3FaVMVEi+oStD
         XEUg==
X-Forwarded-Encrypted: i=1; AL+hErGLZyFYsJAsV5XVYUlbirT9A8OZuWf5so/uxwtUoKsp9WobmSTMz05QnpiCPRnc6qPKF/2Odx8=@vger.kernel.org
X-Gm-Message-State: APuU4Z876SF3G7MHmKUD7vCPCxUip1ef74u5zlJgkCGmlUa6Ok8ACqTl
	Kz91fmP7GEzmXw6xThhy9R7gTBLUfHbpD26Eqj+6Rt3qsok4kmsg3POFURWwkRotJvk=
X-Gm-Gg: AZFdTZfLDBOkiRqY4yKq6qjN+lcvlxFfHTkkAzDL+rZiXI+TtsG0aVnWlK/CtX/woEi
	cCey2Ab9anO9L9dLBETIKVD4g/yqStv9Aioj5mt+8y4FQ7Quii2una2suqSGMq3iMXs+gZ5P2DY
	+2bydS6fStZgitmJmuURfSS+23QtlzTjMWh8U1xjqS9YzCCcX9O9b4fj0lncyXqPsvsuBw6WowC
	yUsct0gHP8ZBbhuy5CY5hhxpRFb8lMCtmOXUlJMdT5LtANavm7Oh+Yy6BvBbb3IdjTpHiRwV7yw
	wwXOH/BppVkd7R++7hlrRZMImBt0SIsgxAE+rWMhdViB/0mjBuU5L8EmXnrdhcUmdVzW3StdOav
	X0YYO2TR0K57KBBVYNDpP7G+3IkhhncsrLe4GvAJClupG7TLv72209RFoWpM0GMwJRv1iawyWmH
	6YOZQe4FWvqGAeCFtlS61uzR8ONFeRHKpK2HJrj03DJNWpoPvfMkfs3sck6Im4DHder6qZiJ9g6
	Oo4sNBnm0Zwmef5vNO2pFMt9eco5gNSIWIhcD4utkLPd0bp/gTOi8GXkP3i4sXSoN9qOWfmafjl
	8zBLLWLax4cE0IbdaN8=
X-Received: by 2002:adf:e014:0:10b0:4a6:b87:d799 with SMTP id ffacd0b85a97d-4abb400bb42mr23914238f8f.17.1795589806244;
        Tue, 24 Nov 2026 22:56:46 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ad644140b5sm29125406f8f.17.2026.11.24.22.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 22:56:45 -0800 (PST)
From: Dan Carpenter <dan@pereq.eu>
Date: Wed, 25 Nov 2026 09:56:19 +0300
Subject: [PATCH v2 4/8] KVM: arm64: nv: Discard nested SError in
 kvm_reset_vcpu()
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
Message-Id: <20261125-double_exception-v2-4-224689d8a764@pereq.eu>
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

Vanilla KVM stores a pending SError in ->hcr_el2 but nested KVM stores
it in the NESTED_SERROR_PENDING flag.  Clear the flag for nested
SErrors when we reset the vcpu.

Fixes: 77ee70a07357 ("KVM: arm64: nv: Honor SError exception routing / masking")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan@pereq.eu>
---
v2: New patch.  I split it up like this to make backporting easier.
---
 arch/arm64/kvm/reset.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index a5d298d5ce61..d80b38b2ce6c 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -209,6 +209,7 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 
 	/* Discard a pending SError */
 	vcpu->arch.hcr_el2 &= ~HCR_EL2_VSE;
+	vcpu_clear_flag(vcpu, NESTED_SERROR_PENDING);
 
 	/*
 	 * Additional reset state handling that PSCI may have imposed on us.

-- 
2.53.0

