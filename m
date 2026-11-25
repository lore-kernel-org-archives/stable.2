Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795599164;
	b=QLATcpY9N6vHfWS0jBJPrM6Gy1cikHKYjowMjCRJnyhhGqjxGwroSvxO8ZXYnLOcf8uM
	 ZL9kA6q+xtcCYgJak+C26fHbTCzFEs7k5G+UJcyNnJqY2m/raWUtxtLh/dqESbX/dZQRg
	 GBNFOCFdbXANFVJlpNTs2CWbsuDxsdkCqKTIOFro9WXTQkNuW5l6CSCjtjhe8Kp36mW0j
	 hcPyBgaV3rZbL0FLY8DOQ7hhMQpBND+Sbb6Q5Zv763JquN1U3Z3hZBmG2qk+OOGTZvCqa
	 EtD8KjyWdBqR4lGi8MRSHoV4N9R/qEK5dnHE/HvpKOh4yQoo2P5YjAHhH3UbzCGQMaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795599164;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=vz6xI/WxixrEpdd3ywwOb3jpy1gOGMCFJ8JE8A5AwCg=;
	b=gDfr87hMMr150Un/Lu43zK4EChDm9CHOllEu6cKgejyQxtpc2NIEjqZR7QcHqV19EKzt
	 0Vvrhacil7xjHLt1P19MbhioRGtj8LRb1ZOSw2N00wRG/jOXPAoP116dIrQzx+ZyQ+i/1
	 mMrGbsaNpmYfOWZM6lwHqc/utyaLhtn7Lo99uCy9wMaHRhwbijaXFluXDK0DlbbNH4Vne
	 U4S+T6MSkDmTDMQymAjVXFRx5kE9CC/JdxbLn+ZHi3vPi6rPmJOiZ9CK1l8GlBlEbx0oC
	 //1LmzQbnXFnxFOfqp4zP03HLhHNzXoJOgK52VphmHQLdQd5lOh3E9IXvXlTcA8FgbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	dkim=pass header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=AqWEO8Cw;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00275606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00275606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=AqWEO8Cw
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-497614c95f0so3113910f8f.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 01:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1795599162; x=1796203962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vz6xI/WxixrEpdd3ywwOb3jpy1gOGMCFJ8JE8A5AwCg=;
        b=AqWEO8CwQkTMHtVYcIOLuHqCHa8uPTdR6xogLnmlooFf70UL6doHQoMWgb+TBbtYm8
         +/kTYzofe6h8tAPEA/By5779kp9X1qykliRXQc75+CRg/neatW43jeGrV/QCG6b4nksZ
         ITNPn+N4wGapg7eibENnYvHVgERO0nVHReG/IXYyV5dcbrjZkpwDs4MjpTKd2aE7VLI2
         zMh4u6j1TwDt1abI13SFwlyWM73qP4XsPOxo+zUm0GWE8FWosugaVzTkv38puBYs6Uwu
         YS2QSEBXOOIpfQWSaKG25ZIjvlUYLNmRLr8XawyzKXPtytjX+w0sSzLfY13c0BTd8aj9
         2N9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795599162; x=1796203962;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vz6xI/WxixrEpdd3ywwOb3jpy1gOGMCFJ8JE8A5AwCg=;
        b=FJuh0LZHx411WYste6Jd51D7umng1ddnPuVtvMTCGpeTSn69rQT+NbtVY5LpN+LtW9
         WFukTCTijEha+gbcMMDAC+gnqSN0v4FL2rv3QTx8B7beX63P9sv5kLHkOPiLG/6bYs6c
         /pyKs7u1HK/bFYPEyaVCWpoUXwj7+xQXU31DKbhBXIVXx++aeUPwwGTh/LFHBm2BPj1l
         XEhrsxVDHQz2n8zgcs6zUfVTig1ex37JuDmXXZRClpMj7MFXE8KHTwB/FHg+TfvfOcnT
         OxmygoyyvtgyTsrPs9xJytK0ZazbzSC0KAiHCjWrPIIe82ZSU+j4hfM1NXhQfsT6XRjx
         EIxA==
X-Forwarded-Encrypted: i=1; AL+hErE1X0itkHSmONXGG12QofaaP0SIOLW+Qs1yTeBV0wVM+1fhS562F+kGYzH+m+X7PUfLsByTvlI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+4h6x/8BUQE6uffQ8REDZtWK4kYdiDnIGrY5wBY3P1d/JAQC/
	pmEcEaIhVF/ei0vRW7AaeJ++z7PfATD2GE+JLjiIb0MrWpZbnWhFI8KnSaw3kE0MGTw=
X-Gm-Gg: AZFdTZcie9at946+anqbic+CGp7arnXoWGdSeKAS1VQQxqXic1ZITjUEWmPoNM+9X9/
	4ivyq91df+FCYzgJ9gOxF4V1be35sChdWT+fRxpHzVL9QOFJl4PvSwlIxK1tMj2z65BBpIWRKy4
	lWk4oTJ1ENFLHxKgE+oheyrgdGKTp/jy68Wr288g6l4qDQjEgX+B5oseHs1caFPFctdsX7md/Cd
	Wx1ePAwRUcZJ2maUtD5mZq9aDwzywXEXlE8YO2fwjtconJnQ4joRESF4K82eNELm8e5O7e7lDEr
	ChKwkevQyoLgJ4u6T/BZVxDeyezaJ3vBPnhLQgNFPnVnTsSqwBf9OvVovzAG9UxBsLwVPzBQb32
	7u6+5DpaVBhgfu7aYmR5KGXbAjFyS+zvdgjpScibnRxLc7bNSM/AtQMTgT8AluahA47CmJDjuGa
	r83pDvFO8oYUqZ5efUccXo1QutuCeLhHTMq8Pfc2st7aV+gloXAwVvUyjUNoeBmDg7fUmRI47Ai
	f1uqc7REz8tqqu70hybf1JUnO4UOjarYdYUmaiuLMm8R2TFOsK4GXmRNpvyNAD75ksFK8auGIig
	+/1YHyso/8SWYpzVlyo=
X-Received: by 2002:a05:600c:1c28:b0:4bb:867b:f0f0 with SMTP id 5b1f17b1804b1-4bb88810708mr406437605e9.15.1795599162309;
        Wed, 25 Nov 2026 01:32:42 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bba6a0d65fsm32122755e9.3.2026.11.25.01.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 01:32:41 -0800 (PST)
Date: Wed, 25 Nov 2026 12:32:38 +0300
From: Dan Carpenter <dan@pereq.eu>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Christoffer Dall <c.dall@virtualopensystems.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Sebastian Ott <sebott@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	James Morse <james.morse@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>, Karthik Bhargavan <karthik@pereq.eu>,
	=?iso-8859-1?Q?Cl=E9ment?= Blaudeau <clement@cryspen.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/8] KVM: arm64: Reset SP_EL1, ELR_EL1 and SPSR_EL1
 when resetting a vcpu
Message-ID: <awarNqNt6Kec5G0M@stanley.mountain>
References: <20261125-double_exception-v2-0-224689d8a764@pereq.eu>
 <20261125-double_exception-v2-2-224689d8a764@pereq.eu>
 <0c7c59df-69cd-40fe-830f-60c0f3cedafa@arm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c7c59df-69cd-40fe-830f-60c0f3cedafa@arm.com>

On Wed, Nov 25, 2026 at 09:08:36AM +0000, Suzuki K Poulose wrote:
> On 25/11/2026 06:56, Dan Carpenter wrote:
> > Resetting a vcpu keeps the old values of SP_EL1, ELR_EL1 and SPSR_EL1.
> > Commit e47c2055c68e ("KVM: arm64: Make struct kvm_regs userspace-only")
> > changed the reset to only clear the general purpose registers, SP, PC
> > and PSTATE, and later commits moved these three registers to the system
> > register array without a reset value.  Commit 85d703746154 ("KVM: arm64:
> > Fully zero the vcpu state on reset") fixed the FP registers and the
> > 32-bit SPSRs the same commit missed, but not these three.
> > 
> > The impact is that the guest that boots next can read the previous
> > kernel's stack pointer and exception return address.  KVM_GET_ONE_REG
> > also returns the old values to userspace, and a rebooted VM doesn't
> > start in the same state as a new one.
> > 
> > Zero them in kvm_reset_vcpu().
> > 
> > Fixes: e47c2055c68e ("KVM: arm64: Make struct kvm_regs userspace-only")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Dan Carpenter <dan@pereq.eu>
> > ---
> >   arch/arm64/kvm/reset.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> > index 26081d273408..9c1b42890c96 100644
> > --- a/arch/arm64/kvm/reset.c
> > +++ b/arch/arm64/kvm/reset.c
> > @@ -199,6 +199,9 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
> >   	/* Reset core registers */
> >   	kvm_reset_vcpu_core(vcpu);
> > +	__vcpu_assign_sys_reg(vcpu, SP_EL1, 0);
> > +	__vcpu_assign_sys_reg(vcpu, ELR_EL1, 0);
> > +	__vcpu_assign_sys_reg(vcpu, SPSR_EL1, 0);
> 
> nit: Please could we move these into kvm_reset_vcpu_core() where we
> reset other registers ?

Will do, thanks!

regards,
dan carpenter

