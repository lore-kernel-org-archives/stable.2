Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794849538;
	b=hg1B5fMww2jKlLOlOrJGWSV9T9+GJEM2/VvYycpCRTD17h1Qxqpa1xmkkjD8qj3ysXit
	 6sm1oPh6pWxz6hV+/PJD5SX0O6yT2quUQKM24XpjTh3OuUcWTagdVZY0Xv/9jfIUrByc1
	 AX9WkOKy3G61j9JDAS3/M36lRkRNNMBqlMEv51ZPqRQj8mRJ6WBHXfEttXZP/wZHRBq1B
	 OvfCLdLTnw6Xn4gRVb8KwihZnvsND3BU421Y3ivBA1ofNelGJa3XclRbBc4oCoQIe0KPK
	 Uhbe2lGfF5/sIatcZ70k48t/5gvEUBQL1SYATpNS5GtP6Zn0CpHVhBDVPoIwCs9UNcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849538;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=OzaqIXPqhSSG4ejd/hB4U1AFDk/wquty1pyzaNNEA1Y=;
	b=2jYAtUiSdPY5+/zYj4iFsaw+OKY3XOSv/Goywv44f9pzdm/dNRAVD+I7p/xjbDFZ+1+z
	 ewfHFaZMA5gVwBHZuobuBQzrIKEIhDLMQQ6FO1tZxYQ5aSJ7kGOvKuVDikZDoRMepGhXd
	 ltSWJ1242EWjypo2XkMnEvAcmQFfbZR8HB2n7gGe4Mk07jCM7FWeuZmJyTEtq18KrO2GS
	 NTF4GIvzeis5P5EKCkdz2Vna4iP0Jjrft6FQ+VeqfvInpiGkhBeP8zHdaaAzgqwlTIYnS
	 oKpPvXhYrrU07q65m2WS9z0ScFFvKmdNggcC/rzoKcrYuh9nbxyPOd1z0GTwh0N2vtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TXGTtgf9;
	arc=none smtp.remote-ip=91.218.175.128
Received: from mta0.migadu.com (out-128.mta0.migadu.com [91.218.175.128])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3778606A322
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 17:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3778606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TXGTtgf9
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=PAxYfgYQrRbaE3T1nWWUCpJHJViNiRZaZVomuIz4tHw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794849535; v=1; x=1795454335;
 b=TXGTtgf916t0FrahnyYwcZuggrp0Un3kaP7LDIevjUCrJAOLgjU1S4cMB0aRW0xH7ChUaaPB
 tBgrj/D+jYsjn6DCNxKI4o2GGSkh4i8FbEEoV6mKLCi9eoAxp125hWOBbjiIv3cl67Qxa9ETatO
 Ndi9Z8IiczMNUcaZPpi8pgd0=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1558a152b9a96594;
	Mon, 16 Nov 2026 17:18:55 +0000
X-Mizu-Trace-ID: 1558a152b9a96594
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5c14bc5a743so13565e87.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 09:18:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEyAQhIxODNQj7pYgrIGt1siqL/L98lQOQRHTUdgVAEBrbcxW50hoFKsiwDjbWD+WaQlToWYgs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9mrj6Kyyq27tC4nolZ5/gAYIW/tWB/J+Jw+LoyZsGV3T2quNka
	IuC8WbD6gS39tyU66/pEsgLjymDfNirOp5FRXp2q6N2rcB9DuKHslPnaTj4HkSvoJh15ZEHElI9
	pStKZUUMOOKc1rXpntuSZzAGG3Il0EDtQT25mBa8q
X-Received: by 2002:a05:6512:110b:b0:5bf:f84f:1d74 with SMTP id
 2adb3069b0e04-5c17e52e81emr262285e87.13.1794849533007; Mon, 16 Nov 2026
 09:18:53 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110110724.3614412-1-fuad.tabba@linux.dev>
 <20261110110724.3614412-2-fuad.tabba@linux.dev> <avM81YcTBTJ8zCMX@seanjc-mac.roam.internal>
 <CA+EHjTz-Nb-g9YQKX2fKk61hC2BfzXfmUHv=2j+eZ18YuTv2Eg@mail.gmail.com>
 <CA+EHjTyqJfGS+5UajX=RYTAG-qfhZ-vmGi=1SixXydWhwGHLUA@mail.gmail.com> <avs5UD79FB_DG1Vs@seanjc-mac.roam.internal>
In-Reply-To: <avs5UD79FB_DG1Vs@seanjc-mac.roam.internal>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Mon, 16 Nov 2026 17:18:16 +0000
X-Gmail-Original-Message-ID: <CA+EHjTwXO_Ym1+ErHT9Si6FwHtDaPDmMRwY+RS8LDNK421rchA@mail.gmail.com>
X-Gm-Features: AclHuK9xW32VPDT60mgyMDdb5wXbr3ChwJoDPUUlo1Wmi2N2JEJM_TMFlrp_0kc
Message-ID: <CA+EHjTwXO_Ym1+ErHT9Si6FwHtDaPDmMRwY+RS8LDNK421rchA@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: Stop KVM_PRE_FAULT_MEMORY when the vCPU's dirty
 ring is full
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev, 
	Wei-Lin Chang <weilin.chang@arm.com>, Will Deacon <will@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Nov 2026 at 17:11, Sean Christopherson <seanjc@google.com> wrote:
>
> On Mon, Nov 16, 2026, Fuad Tabba wrote:
> > Hi Sean,
> >
> > On Tue, 10 Nov 2026 17:18:22 +0000, Fuad Tabba <fuad.tabba@linux.dev> wrote:
> > [...]
> > > > Eh, I vote to just use kvm_dirty_ring_check_request(), I don't see any harm in
> > > > clobbering vcpu->run->exit_reason.
> > >
> > > Will do.
> >
> > After taking a closer look, the clobber is problematic on arm64, where
> > KVM_RUN completes a pending MMIO exit only if run->exit_reason is
> > still KVM_EXIT_MMIO. If a pre-fault stops on a full ring after an MMIO
> > exit, the helper overwrites exit_reason, so the next KVM_RUN doesn't
> > complete the exit and the guest repeats the MMIO access. The ring can
> > be full at that point if the pre-fault dirties pages, or with NV, if
> > the stage-2 walk for the MMIO access does.
>
> Wouldn't that require userspace to do KVM_PRE_FAULT_MEMORY after KVM_RUN with a
> KVM_EXIT_MMIO return?  If so, userspace gets to deal with the fallout of being
> stupid.

Ack, so v2 will be as you suggested.

/fuad
