Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F8637647B
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 16:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782925001; cv=none; b=KxAcbOTVzWvjzPvV6mHksYP0Mc9ScyQnaNbnS1RQQ0YqYb6Kt60RsOURCI1tx3VWcK4RlahieB9r34fkIoSyG2zl5c8BYB7MpWi4hAhXLQDNikkHEA4vX8T8D2n7F7Aeg2zPMkiNQZxzwgkladIvey71P7734C2LixXCPIKLHwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782925001; c=relaxed/simple;
	bh=LWCSSYbvZ4ZgsMDaus3LM8CVJNtwgefrMZfBUzegL0A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lnLioBYcOFjNckR4QnlXTDdJhpBzoPdfaQ3RTgIYZht99y5ZUNsbkGvxo44yvKr/gHOZMrVIxtjVO+lKg2/xYRH2R5VAQhJAroENztU1KdW9Ff1vw+UIxEqh4cRGPjDwuTJKLLWqQ7nXfOI4ZZ+FBD5rxI/bzrYdxmaj0ykH+7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aDvgwupW; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aDvgwupW"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8478e603285so1812023b3a.0
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 09:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782924999; x=1783529799; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pwPe/fCvCCe9amvNR+OBJKvY1CXaERhOlDRt+CktIxg=;
        b=aDvgwupW3zSNtfyDQOO0g3DXze7W7pREJCSx5J3UmyQt40KLpflEzKM4af3M0pL9us
         qpIBULhzRKQzs1OHitiN2yDwElTRYug//eQCBEA9Y73H2vFIdORoWGlyXBnl/Zy67KPs
         HbySHgMMfv3u+PMEp3bePG0zckneeXqNEMJcMrYDcZdvB9zOwmIDqhnR0HEo1Xj8Qu2H
         BZb+fTx0295UTzK/apxwMQTPpM0T2WcWiAAZxF1JgMdNCN2biP2EK3y5QndmhpoBL52v
         fuzMhuvQ4DaU4Z7BFarFPnqOb7R2TayqVmbjalhvw9tbujlmMwIfk3uLMyfszVfoJlHT
         CMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782924999; x=1783529799;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pwPe/fCvCCe9amvNR+OBJKvY1CXaERhOlDRt+CktIxg=;
        b=KdaOCFQGsMy1pKsHB1RT6seN4dcpeqzvffvcF48hUi8QwWyrDtBCjyOh7v/pkgDnlC
         tV1+/Zt7agIFMjuiJwYOTjQHcE7X0a5roFap0JilGKr6qGGopyqNe3wFGAR7y/0xiQ9+
         zP3s6yyhJXZQWgAy7csk8mFdl675h9N+NaI0piNQc5MAkSCtJp/1fdgojBLxFUcVbCqu
         vrpjZL/Lf6t8KKrFdpJsZjQ+F/KhlfdH1qpZGGLFkKqN43jauuFOfHllOzUVv/xfoCiY
         7QFyD5jPdVYS8k+eL+5eZ5/LmztcI2y1up+vagQvUof3qLsr9l16JayH969EWixuYQ47
         kKgw==
X-Forwarded-Encrypted: i=1; AFNElJ+VAuNDKhBU9L6DLDZEMyjiN4ULMPiZZPZwCAsbi+1AmxX2ePDcUcpxa2lXJS9o0O4tO64h+q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTI6/B+RXuZoYf/ilJtosWe8f9mVo7P/vAj0XrJ1bakMgp3rjN
	/CsDMy+jj936E2mhz/E9yDx9EWxoDs37icwxwxT3GHWoyIMSeB3wuR5IkaWeyneD3tnxkH3rbUC
	8Vbky8g==
X-Received: from pfll12.prod.google.com ([2002:a05:6a00:158c:b0:847:87ec:2a9f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9283:b0:847:8f33:b159
 with SMTP id d2e1a72fcca58-847bf8231acmr2005298b3a.10.1782924999054; Wed, 01
 Jul 2026 09:56:39 -0700 (PDT)
Date: Wed, 1 Jul 2026 09:56:38 -0700
In-Reply-To: <d9f98e2f-d2c6-447a-b3b1-17f07d1fac3f@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701144543.39582-1-pankaj.gupta@amd.com> <1cc159b9-5f94-4524-8e03-efe91601ccfc@kernel.org>
 <akVAnGuiuJttE5-6@google.com> <d9f98e2f-d2c6-447a-b3b1-17f07d1fac3f@kernel.org>
Message-ID: <akVGxp2fA6O3lk-G@google.com>
Subject: Re: [PATCH] KVM: SEV: drop FOLL_LONGTERM for encrypted region registration
From: Sean Christopherson <seanjc@google.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Pankaj Gupta <pankaj.gupta@amd.com>, pbonzini@redhat.com, tglx@kernel.org, 
	mingo@redhat.com, dave.hansen@linux.intel.com, bp@alien8.de, x86@kernel.org, 
	thomas.lendacky@amd.com, hpa@zytor.com, yangge1116@126.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 01, 2026, David Hildenbrand (Arm) wrote:
> On 7/1/26 18:30, Sean Christopherson wrote:
> > On Wed, Jul 01, 2026, David Hildenbrand (Arm) wrote:
> >> On 7/1/26 16:45, Pankaj Gupta wrote:
> >>> commit 7e066cb9b71a ("KVM: SEV: Use long-term pin when registering encrypted memory regions")
> >>> added FOLL_LONGTERM to sev_mem_enc_register_region() so anonymous guest RAM is
> >>> migrated out of MIGRATE_CMA/ZONE_MOVABLE before a long term pin. This breaks
> >>> virtio-pmem which has file backed (MAP_SHARED) host mapping where GUP rejects
> >>> FOLL_WRITE | FOLL_LONGTERM since:
> >>>
> >>> commit 8ac268436e6d ("mm/gup: disallow FOLL_LONGTERM GUP-nonfast writing to file-backed mappings")
> >>> commit a6e79df92e4a ("mm/gup: disallow FOLL_LONGTERM GUP-fast writing to file-backed mappings").
> >>>
> >>> Drop FOLL_LONGTERM when registering encrypted memory regions and restore
> >>> the previous behavior.
> >>
> >> But that breaks the original issue of breaking ZONE_MOVABLE/CMA?
> > 
> > Ya.
> > 
> >> If it is a longterm pin, it must use FOLL_LONGTERM. :/
> > 
> > Heh, well, KVM showed that that's not entirely true for many years :-)
> 
> What exactly do you mean? KVM MMUs sync through memory notifiers and doesn't
> need this.
> 
> It's only our "interesting" CoCo code :)

Yeah, I'm just being cheeky and saying that it's obviously possible to do what
is effectively a long-term pint without specifying FOLL_LONGTERM, i.e. saying
it "must" use FOLL_LONGTERM isn't super duper strictly true.
