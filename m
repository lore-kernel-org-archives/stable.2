Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.192
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795092257;
	b=gfqjAkgzePE2Shvm50k5KLu4pUFdzfGok1rH/uu0GC3WCRjnICadUp0gTQzzA4+cWiVD
	 Jk6eGiFusrgEbS8OzOnkU3ubct7rjs87Z/LQVvw3sLNnc+b6LDjZ3qvW79ZYGBrk5lIzJ
	 41ZYfvnOlknbJ+lZAkNESoX5vBecMlOWscT5PwQNnxLLSxS2GF1XJ/slYMs5YoV4530kE
	 iuMA6LgnlpCQHrsMd/VmxH+QbFj/BCm378IYxCsC8fcwN2mmJ0GvURQWmBMDDpsi8fJux
	 NaCVRzyN+bkeqEDryrW1LDGHsoieDYg4gA2CrS6yGvAH5iHz7yxhm4DfNgSB70kRPjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795092257;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=odGKjtuO2fcSEp2Bw94sYra7hu3Cvd+3dwpUXKWdflc=;
	b=0+8ik0vpQMGxLlzUkkyEuUbjg63bz7c6aVwFLT4TvpV8GFryZSkf1UeBUUVvQYr335w4
	 P0OVUk5BIjcPKTU0X0a3So9jeP8aMTrFA3K0+zlIL3rSc3e7kDY7FszlJUe/tyaw+9sSM
	 GZ1dufGdkEx2+sA+sMh8RS2r70WlsT5crcMcggFwUKzX6kn86MYLeS8IIXaXOIat1/99P
	 jOlr2WMPrsyp2pxnWblM3/m0SsDolshDTL2Ir1P8AU4fN0F8bU9Xxc3+bm6eA/n8Wf4N4
	 qvuYBjCWA5gbaSLfVVZX4ZpghYFVR3GmRqFNexP5mHOKw44rJzAOJp9t+DA1HNQEDFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Xm5K9aUy;
	arc=none smtp.remote-ip=95.215.58.192
Received: from mta1.migadu.com (out-192.mta1.migadu.com [95.215.58.192])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6143160A262E
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 12:44:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6143160A262E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Xm5K9aUy
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=odGKjtuO2fcSEp2Bw94sYra7hu3Cvd+3dwpUXKWdflc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795092254; v=1; x=1795697054;
 b=Xm5K9aUypliUEN5W5tlLqwSvf5vjzoa3e/CT6q1LEZa5hLPqMRcmR9ayLYTJBsZsnapm+m2S
 23fByICux5qIvvIPrFRC21cniwWgGgHef4Mts/CijyVMTpMPjMplYXRcDz2SvIt2MGOeDB/Dw9j
 rOnsSNri/aFkuDWngWhVsj4w=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4bd90a8046ddf6e9;
	Thu, 19 Nov 2026 12:44:14 +0000
X-Mizu-Trace-ID: 4bd90a8046ddf6e9
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5be58ad9600so8105e87.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 04:44:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGxHu9zU1kgg8Ll63+haL31YgorQPEskllQSmGhWRHXecqG3fmNrwXtrbEG6tLyXfgfrvum6o0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8b7Maf/LczZhMtpdkhPhQeTOUvqbZJTYhNnPixU2UOJGWWiSuN
	pMEvfAtHXtItsCscmg7Oa5BstQXmwldnMaS9AgMOnoa013fMtGfbcLmvwQyDLn7bLS1d1Jl1dgq
	+yO9B8s30xc7cHn1IhJD8Or55BX/XnquEqly2ww3r
X-Received: by 2002:a05:6512:4011:b0:5c1:4d61:20ff with SMTP id
 2adb3069b0e04-5c1b6774040mr72185e87.10.1795092249237; Thu, 19 Nov 2026
 04:44:09 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117074428.7544-1-fuad.tabba@linux.dev> <20261117074428.7544-2-fuad.tabba@linux.dev>
 <avxfgWNePsGPK9mm@gremlin> <CA+EHjTzUrDxLSMEo6X66XhKtQ-=ew3zZhMdFWR6U9Ga17WLWkw@mail.gmail.com>
 <av5CBjbeidUUWiLq@seanjc-mac.roam.internal> <av7bYb1geEGzaj8e@gremlin>
In-Reply-To: <av7bYb1geEGzaj8e@gremlin>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Thu, 19 Nov 2026 12:43:32 +0000
X-Gmail-Original-Message-ID: <CA+EHjTwzdsMKw2MFB9kpV=Xtm4JFpTbWRn0BOSwSB+x=RJhVMA@mail.gmail.com>
X-Gm-Features: AclHuK9ExBlvjAlpEcQpW7OIX1pR4w0klOAvsUXwgDHyVbn5Bw8uFWJCaQ8SOYE
Message-ID: <CA+EHjTwzdsMKw2MFB9kpV=Xtm4JFpTbWRn0BOSwSB+x=RJhVMA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] KVM: Stop KVM_PRE_FAULT_MEMORY when the vCPU's
 dirty ring is full
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev, 
	Wei-Lin Chang <weilin.chang@arm.com>, Will Deacon <will@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Lorenzo,

On Thu, 19 Nov 2026 11:18:48 +0000, "Lorenzo Stoakes (ARM)"
<ljs@kernel.org> wrote:
[...]
> > > (note that it skips CSR, SBI also with a changed exit_reason).
> >
> > Ack.
>
> Probably worth referencing in commit msg I guess?

Will add one in v3.

Cheers,
/fuad
