Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595669;
	b=GoGpkM9cyw+eQJ49hAVzi7iFjEFl9VcIQF7/m+JjZIRyIGnmVtFUykEAYnS5S3i1HE5k
	 K1ns5I2SfYxI8m44F4GwFIPwMAb+1uOfcvTlDcaOem2ykQabBnnFX1aKS5CgzbjQReWk7
	 EbCkLJc/tTGg7EOpptC/UOk9qsArDKiHo7SGYbSkazIVrz2KH+YpU37iLs/lFYw0A+KWp
	 SSY6k08LsIKQcWo+7hJJ1r+NP2yCw1KDoZPxkoluN5K1N4CRk80SF69XkpjSzw8Gzrn4Q
	 zHazYseLXfRrxWMNYCvvmvgehRSuv2QnVCFEsFVr698Hk1h6xrQDdJYHCayfHYfr6Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595669;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=0YZLYsLs1zDQz5M0rn0ZPlb3pIBZFLCQPnvXndpW+/w=;
	b=oVYDXGtsO68iY8PDV1EC14d8czYhcgasNrNxHgDcDW8rAFsvjin5MFK662lV3g167zVl
	 gAuvS2MkDlrEnLEngzf9wnxsxkw+FxQ8WIgSBOEGmnnAC++Plu26/DCKzjV2z87T6lAoi
	 Nb0eNPsDY9KdBVkA2dLOHG3G1n8S/xyB8aUdd6hjEWhF1tJbafN6fWv59QGthifXj9HDp
	 MBqJO5eeYB+RW3F21+GC9Hqkz1xCIm3DK3aFG9z0TMccuP2ATbmQZ5qsrL1ZCF8Ha7mEl
	 q+lFvEAF3gexQXe1dGXFD1q3YclXLE+VA91oWkSc80jKR6R9wM8YjMWg+8DOuhtBd2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=hk8eLAfv;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CA0606A323
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:14:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2CA0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=hk8eLAfv
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48c5358fc28so783537f8f.0
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 08:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792595667; x=1793200467; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0YZLYsLs1zDQz5M0rn0ZPlb3pIBZFLCQPnvXndpW+/w=;
        b=hk8eLAfvxJtBkeMiOfCn7G6FUZUYj0JZy1OvouDmazmx9rgkV0HqqYmYD3ThrNsj0p
         cXsCsqrpKF5rfL2jhtObUdLTxiY7JtFOsV74zYWoj0PFFpsJnt7iTuzP1wcHG2KNDzOd
         kLxp0wsVNg1XpSrCW5AxOOXj+WYcs433mL3/Ylr1ZW4N/Fm0MGbxoUqZ7n6FsIM3ehcn
         qW8uiQtpZanBWkeaWgXJ3LtkRAyYZlKN3dL8YnuPnn1oSWXEuJTVMYC++HdPB0F3o+Pc
         saxSSdxqrN8t0PEhpd8EVWBjK3yjo+2vZMjnIcJ+YFH+pKK8VelWTnSnvOrnXqG2lPgJ
         WkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792595667; x=1793200467;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0YZLYsLs1zDQz5M0rn0ZPlb3pIBZFLCQPnvXndpW+/w=;
        b=ObsCgNzk5YHX5cLaXkDPGrezfnQhjSO+ps+Sg1sTxmru5egpvwwDKUPQw9/iiJAjED
         C0L0Hot508L2Xnc1xCVv1CuWmo/o5KomBefQMNdHD4NGoc9MuvYeOYutVIxLPMIGNZ0T
         7Co3OYvyQHm3ylwwq/l7Mq03Ql4N7vQK7pqM4NkllYBynDfRRVgHOuxcacVMxoZp2D4+
         q1MNaT9Bem4Ip535lzC/nAkOQB9vMDrQn2l4M2bsrzMkhC46tmCmrc/Or2ltjFU/Bkia
         MmKB/Lc+DNYyyHtboesWZ/hmOoDT8Ob3+SVu8W3lpqBMLhpf/xITLu8LFv5iNLX7X2eB
         uVAw==
X-Forwarded-Encrypted: i=1; AKwUvBwNvYAhzUZFPqPh7b3iUbdzQq4HEYL/Mttq8ckJZbrmNJ4WwnvQLfmK9g8ZDQIQaLBplH/PM0I=@vger.kernel.org
X-Gm-Message-State: AFq9FYK+kiiP+pi+kFQP/P62/lQOYD27N69uvdcKDTb5yHshp8OfgqBe
	bRd7Gv8TJpb7kTLNz0tt7co/ILuhXS1zYbF7k8TrIfTWPcle+DZujrJsC/FmerVSSA==
X-Gm-Gg: AYBFou3vf7+aPWCUkRtUwKPQItT7EE10UfNaO+Y3r5npa3lESQniUW1yRT4qm7fdg0m
	Bw6AtoKX4+YpOn4InCQSkVgDtJTV6402DIOQm5/wur3oFU8Um6BYhrMh4PNVmWptToymsfEN1pD
	lAuwDRpfq0W5TXYmXjHQWyH8P0DOHTlc5WgZVN1Cew+ofi9ogyNKP3O5V4TjdXJOTCcghwZXKzk
	FNELr669b9G5TOu3vtZ0V64n1Dep0xQH0p0oaDMaSV6quEPgJ/lBu3aDrJ5+Ozk4Jc402PuGfqy
	p2xrKQ1VDploZBGOHtPyd+dUtEJYHkqJ767tryfcjiBUEbThsH+58gaqB7aCrvVdNynt79MvVNm
	TQM+zY6PQpTBLh0iLTlBi9yC1C1p8UB1Op/cAyfEBKwthaC4Bg2PuITd7Gmq5M6i0mNC0IVOWJg
	MssdOVZFcX8GTs9tgftb7VAejSDdGrbF8MrTF9Qs0frfDGNy9Ti0nZ+ugyRdGiLtiDHyUcYMGJ7
	ZVIMFmXWf7yh5Yyj28NkLuTXF43xtYd5hInv3WFvWLcfHJiefrP7hFjAX2hji0pAxVbTstD9qqv
	mZyVaip3CXCglxsg1rGFcP41
X-Received: by 2002:a05:600c:3e83:b0:4a1:6425:be69 with SMTP id 5b1f17b1804b1-4a1fdb078camr50365605e9.17.1792595666559;
        Wed, 21 Oct 2026 08:14:26 -0700 (PDT)
Received: from google.com (197.183.140.34.bc.googleusercontent.com. [34.140.183.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fc1066cfsm58540435e9.1.2026.10.21.08.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 08:14:25 -0700 (PDT)
Date: Wed, 21 Oct 2026 16:14:21 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: oupton@kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, joey.gouly@arm.com,
	seiden@linux.ibm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, kernel-team@android.com,
	fuad.tabba@linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v1] KVM: arm64: pkvm: Clear GICv3 LRs in the hypervisor
Message-ID: <atjWzRABsApbZ8CC@google.com>
References: <20261021110000.508827-1-vdonnefort@google.com>
 <86qzhjz1iz.wl-maz@kernel.org>
 <ati1DrtmMd-63bIN@google.com>
 <86pkx3yylb.wl-maz@kernel.org>
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
In-Reply-To: <86pkx3yylb.wl-maz@kernel.org>

On Wed, Oct 21, 2026 at 02:25:52PM +0100, Marc Zyngier wrote:
> On Wed, 21 Oct 2026 13:50:22 +0100,
> Vincent Donnefort <vdonnefort@google.com> wrote:
> > 
> > On Wed, Oct 21, 2026 at 01:22:28PM +0100, Marc Zyngier wrote:
> > > On Wed, 21 Oct 2026 12:00:00 +0100,
> > > Vincent Donnefort <vdonnefort@google.com> wrote:
> > > > 
> > > > The LR registers are architecturally UNKNOWN when the CPU boots or
> > > > resumes. However, in protected mode, only the used ones are reset.
> > > > During boot the HVC __vgic_v3_init_lrs() is never called because
> > > > vgic_present is only set in init_subsystems(), after cpu_hyp_init() was
> > > > called.
> > > 
> > > Why don't you fix this rather than making the init even more
> > > different?
> > 
> > Ack, I'll make a patch to fix that first.
> > 
> > > 
> > > > Also, the PM notifier isn't registered for pKVM and the HVC
> > > > becomes unavailable after the host is deprivileged.
> > > 
> > > Sanitising the LRs on PSCI_ON is probably the right thing to do, but I
> > > don't understand why resetting the LRs is out of reach from the host,
> > > given that the host is fully in charge of the interrupt injection, and
> > > therefore controls the LRs.
> > 
> > I suppose I could reinstantiate the pm callbacks for pkvm to at least reset the
> > LRs?
> 
> I think there are two different things:
> 
> - pKVM must not rely on the host resetting the LRs once it is
>   deprivileged (that's the PSCI_ON case)

Definitely not a hot path, but if we keep this one ^, isn't a shame of making
the host issue HVCs on CPU resume to reset the LRs if we know the hypervisor did
it anyway?

-- 
Vincent

> 
> - pKVM must not prevent the host from resetting the LRs (that's the
>   "mind your own business" case).
> 
> Both need addressing. If that means the LRs get reset twice because
> pKVM inherits the PM callbacks, so be it.
> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
