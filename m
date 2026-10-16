Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE8732B110
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 01:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792112967; cv=none; b=RKyv1FTMvvdcwiiqEy3/wp7zOb97qDbY4uzkjrJG/irWtJAr6I1lobPFAVEVXVKjdiJg1XKHqb7IU++EJ1St4SXxzjOQG+IdgdTKUt0RCtqFnBc2WZqveFIJSst3ynZj7wuIfmjf2qBQ5tUUSrlkaDusf0pWbgTcawzt1jZsWfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792112967; c=relaxed/simple;
	bh=Fnap2Rx62fYsbiLE8UE3rOQY6lE5SWcRUsRCoHhTdNs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ew6orX8zTklJLJqUvqTRXV4pPEnNogfmCBt/rm2k546MjDmmCX+5b2cjksTYYbegZs9dvozxEe3z28sW7gCCDqL9vMhZPUdLy/2AY1aCZ6o98b4ayPRCuyEmuDjujffYu2RDikLJFpwzePQpwUCKqEM044SDd7SHRQqqKDMw94Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I97P7zEP; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I97P7zEP"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd65070d3feso393844a12.0
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 18:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792112965; x=1792717765; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8LGdcJ3oqZPjHIrBM3BmFTUe/r+rIIS1a0NntXDK3pA=;
        b=I97P7zEPnc6uOCizd9gyJS15Fgnkb88wz+7QVTaCe1+pitOR8wjY8hR594Wn2EB50w
         tnIoNnwa1+r6i3JQ+zJa7a4d9WokSW0dI6AJ7YQtn+0CkkW+XauLzR1+8qn7Foe3bXfK
         KobL3Tkq9afWfgkncqGWznFRYIzjTpCrlWV6BldeaLZlyok1hflRVL5I7CsgUWq1mufn
         lYrfdL4Mi3dd8Wc5piobaBtFLTj5V2R05WYKrWzBN2WuZNvzJ2wodM+T71m6GbuhjEca
         sXlYZ44zA2/BBfcqKe10eDHmkcBBjaH90SwCNHbYyM3F2MCoUf5s/5pct8dLIqwwfECM
         rBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792112965; x=1792717765;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8LGdcJ3oqZPjHIrBM3BmFTUe/r+rIIS1a0NntXDK3pA=;
        b=ZqQux4LGCLugMTt5dj06cW82zIYiC1KPCsBQZMm8yG8Ss2cDxG5gVji9+9r0xkUstg
         W3nMkO6ahbvbNx5J/zUmgKeZ7roh3z6BnwkKeBG/Deh74b/2r4yPO72j7BjXfYkVx7V+
         KzNgM3w/gbfDwSTnlnbTvzf4AAC5eCznQb3z68bjDZgrMBISJbIM5D/IHSXm5906MtEu
         Y0pgsQEmNgATEIKufy6itRM5aDjJq+JFvewMnSbZVagLy25vvd4NuX2mdkpaTLLsjhUo
         W7wCQHOImfLKlX0mbrAnvovy+IZ/kI/Ld/3hqVyLhuItdzIIiZkUEd8UqBmcNfDgS1mE
         YpCg==
X-Gm-Message-State: AFq9FYIanRe5uNn0kweLhhSdYsXHDEBK3ZNQVy3bKGEAJkU6jvOXoUql
	FkCGcL2UPPcrgghDqoMiA+k8Y3MVK8l0jwnzYOFYDN6rzGiQpqLQa9hn+0kg98WjGfF5oZSKrVs
	mx8pDdg==
X-Received: from pglk22-n2.prod.google.com ([2002:a05:6a02:6b96:20b0:ccf:9d14:abe0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:394f:b0:3e1:3734:63e0
 with SMTP id adf61e73a8af0-3e202037737mr1140181637.41.1792112964479; Thu, 15
 Oct 2026 18:09:24 -0700 (PDT)
Date: Thu, 15 Oct 2026 18:09:23 -0700
In-Reply-To: <20261015160346.181835-1-aaltinay@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261015160346.181835-1-aaltinay@google.com>
Message-ID: <atF5Q7ICoyOArbRL@google.com>
Subject: Re: [PATCH 6.18.y v2 0/6] KVM: x86: CPUID faulting fixes and AMD
 CPUID faulting virtualization
From: Sean Christopherson <seanjc@google.com>
To: Anil Altinay <aaltinay@google.com>
Cc: stable@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Oct 15, 2026, Anil Altinay wrote:
> Please backport the following 6 upstream commits to the 6.18.y stable tree:

Why?  These aren't typical stable material, especially adding support for a new
feature (virtualizing AMD's flavor of CPUID faulting).

> 1. 690dc03859e7 ("KVM: x86: Ignore cpuid faulting in SMM") [v7.1-rc1]
> 2. cf7d65d1d6f5 ("KVM: x86: Consolidate CPUID fault handling for emulator and interception logic") [v7.2-rc1]
> 3. be7fd7c3e8bc ("KVM: x86: Prioritize CPUID faulting over CPUID VM-exits in nested VMX") [v7.2-rc1]
> 4. d1bc99885a59 ("KVM: x86: Remove supports_cpuid_fault() helper") [v7.2-rc1]
> 5. e93a93f11490 ("KVM: x86: Virtualize AMD CPUID faulting") [v7.2-rc1]
> 6. b16c2aca369d ("KVM: selftests: Update hwcr_msr_test for CPUID faulting bit") [v7.2-rc1]
