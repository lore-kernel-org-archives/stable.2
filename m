Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A96F211A09
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 01:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786413004; cv=none; b=l7GvC/PiDm7WGSc4X+zT8SO5+X15I6DAR3VmoYc7QqW0vQOHxtRhWgtL2MlAwWqqACSzpwv+5Nl1OFJTjsuZ8jRi5+cLwGV+vwxvLozQw4QVhjWW1mtlSiLXc5fBBHuUJ4Gk9dVko6QGTrIeFxTMQuUzcoQT4zt/NnjLN240GuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786413004; c=relaxed/simple;
	bh=Z6SG/NwwtHfXdADr/9JYC+vNYy7UsF+flFBXcbMPVNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KC6eTnsnIp5Rnmyk7gdVfWynsbpszJECBMu5lOUWI9M6OnxPBwLAWOuDSxDMvvMbgpo9joWaEluQkxVLkecl4rI16Wp5KhLc73Q0Kc+tjbI1nnhjMTyNXeVPFmQSdCJZRglUa2tTeoGHmT2lmby7Uz3cB07O7pW0geGcOSHg+kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IM+41Foe; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IM+41Foe"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so2738462a91.3
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 18:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786413002; x=1787017802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LyCUFd5Ia3m2ipCngARvaobB//O+T0vT7ppXh15aqaQ=;
        b=IM+41FoeObK5NZ9OWf2YD3qlS2j51qDrFhVq2wI/bbnp9uy85EOW6/ZI/riCJA32Qi
         jHipgd8Jc/aXNNqH4D9t2vAtKAEMFlJEebmPMfdzgPJ+CHcu2DTkfMDzCz9Jgc75MfhR
         DbR43TakeM2MfkTOaZjK/yuOR4gTU3PqkeAlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786413002; x=1787017802;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LyCUFd5Ia3m2ipCngARvaobB//O+T0vT7ppXh15aqaQ=;
        b=sJ0B2KwUTKmePA+vOIyASQm6CgBalp09c7SiPYO8KBhJ05EhlOXlYHX6G6bKR43RT7
         pZTj/OG/kxX9KpWM+hBc1bTnIKBmJ/128O6xY08w2PNekDidNRzOVbovcAE5A/CmeZ5i
         1Y5qjJqitNb4Oww+R3mkeiKCahEEWgVZCpiuPfxvgCqx95RSBNBqoOxs5k+dQ1Lg2sFc
         BJLsa0IgES3b4/aOHHaobzWwCpj491yAgl+0M0uPULeiyYyd5GquMGdx7RKiljdDDVLr
         mLEiFCBYz01wquZdCb1s68+dgGXaeNIJ0ztg2EQYjVxromsUPqB9ldoI1iSUbg2eUWYu
         X+9w==
X-Forwarded-Encrypted: i=1; AHgh+RqGNwTwmJ/VxAI+EDfUNIadErFlLgvtm5vt81gFKWhWmrozIiQZvo6f1apYUdmlBudopyUqZ1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs2n1yDfWa7zo3BYZrBp8a1ZQbWpRTG/ptxbeSXiB4GmaHe6NO
	B3Hex0QC5g09LbumLn9LdnAxv+K5BetlMCG5i/agCn1Fr4AHYbFazZwREuLbRF+Pmw==
X-Gm-Gg: AR+sD13PFqxstR4KM4SVMv5UumxmKvyp/OjzrYaQegMaZOfNJwojDKRRHwm3PeW9CN6
	uTCmXmwqNqhiw4WMZfhoROWxau0RQ4mRxddJarsA5jLhJtZ5YKKBjgipXKSfpbVlVHMGPBjTt2M
	TlUXANr8TgJhh+pboCHYmYw9rmyc0an+P4N6HJLOrNcyfQwsA3rDRT1GyyEuxcS3YUU8esnhNU2
	1vm0WLa3QXyNFFQkh4mwRREuP2KlwDtJLCve3g2ByVZN2Fmy4xP7VcaBoxwiNDfQOFC204s8+Oq
	/ReVf65FhngF++k/xLnNwNkPKYS8eXfp3NwPfUMqRs4U2x8R8BrdFdZbetL268B80tCGZs44WDB
	h1bdZjy/Fzcfyebs2hUF+rOnZg4z5f54pha2oqFzi5t1WNPvhO40jAEU+ZWdGMah0ojq68gFxeg
	f7InsOTWbHbfOW9j6PfgGGAtbMXlX7obrHR4hhh5RB4w1RVXJMWEgqdrOyFeEStl2dRY0h5gBsx
	MGrpUzO1vHAIM1mww6u8a41uURO5w==
X-Received: by 2002:a17:90b:4c8d:b0:37f:c69d:ce69 with SMTP id 98e67ed59e1d1-392cc9f4517mr5253439a91.10.1786413002348;
        Mon, 10 Aug 2026 18:50:02 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:ddfb:e755:8f7f:81af])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d4050827sm1478928a91.2.2026.08.10.18.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 18:50:01 -0700 (PDT)
Date: Tue, 11 Aug 2026 10:49:59 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, stable@vger.kernel.org, 
	Hyunwoo Kim <imv4bel@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: x86: Check for invalid/obsolete root *after* making
 MMU pages available
Message-ID: <anp_WfTodatOEOZ1@google.com>
References: <20260808062208.522577-1-senozhatsky@chromium.org>
 <anpVAhjqvBvIuoa0@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anpVAhjqvBvIuoa0@google.com>

On (26/08/10 15:47), Sean Christopherson wrote:
[..]
> is_page_fault_stale() needs be checked for the TDP MMU as well.  I had the
> pleasure of doing this cherry-pick for an internal kernel, this is what I thought
> yielded the easiest-to-read sequence:

I knew it!

>         if (is_tdp_mmu_fault) {
>                 read_lock(&vcpu->kvm->mmu_lock);
>         } else {
>                 write_lock(&vcpu->kvm->mmu_lock);
> 
>                 r = make_mmu_pages_available(vcpu);
>                 if (r)
>                         goto out_unlock;
>         }
> 
>         if (is_page_fault_stale(vcpu, fault, mmu_seq)) {
>                 r = RET_PF_RETRY;
>                 goto out_unlock;
>         }
> 
>         if (is_tdp_mmu_fault)
>                 r = kvm_tdp_mmu_map(vcpu, fault);
>         else
>                 r = __direct_map(vcpu, fault);
> 
> As a diff...

Sean, can I trouble you with a request to submit your cherry-pick to 6.1.y?
