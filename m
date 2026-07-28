Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E493A7D73
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 12:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785243401; cv=none; b=KVU9kqhhsNKj1Tzh6KUNaG9bSrBDuR5yYZVx8DQByubzgCQU6oLSiT1f4f2fLH9uLpLngg9pdH2IamnZ28+Iqg52pQQLv9zMhFTjgL4iPhcEC/4SsyThvSw4BPz7Bufjji6EGAgiULtg1w5tmsQNwARi2LAHbwgc2N5jxroWLVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785243401; c=relaxed/simple;
	bh=2mUG/5Gv8BPU0v6r9PAYr8uS3KM6Rl2rXwTOeCiroeM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ez3xZOO1tXm6XwCADguOqC5uiUSyBVpoCbipJ8x4Tukuf1NlqFdzGmeYU92kvTIHJGo42COC6uiXZHDgHtBr7AkvTswM5U4XMbzkjZo0Cov75fYZmEuBQej5ZgyGbSuv0W/DepukiT9T4GL3Vztz1h6q+UXrogbcZWsXoVl0mCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G7QpwFNu; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G7QpwFNu"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb733fc5024so5329930a12.2
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 05:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785243399; x=1785848199; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zWMkY+0t8YjnkN9cHKao+n9nE2vmLOdCEDy55XomyXg=;
        b=G7QpwFNuCzwFEzAb7aAD3+7azwYoXcIyovyyilXPiTEBof/5eUSfVJuCPVCszMK9ow
         WkF3vcQPMKvzqTG0QKrGtgbkpkWZQ0MQ1yDi9p4b+my0qjV3ETFNo9nZ0LMalk/TYjO1
         K1n97iXkiIQIOa0K26li746vbg2otzhAOkoSHZOavc1BoZKbLsZC/AzvKIiLYwgtTPTd
         HKelCnMwiSjig7YHlAJQ7K6+xEwYi2+tGX6O8rNV+NKsXTQYhNXjScmwOpjAHo5FTnNC
         hCqgLfvYKnW0ADPyIQIigmOHEQmTM8tOhLmeisNvJDRztcfcgeb82aKmD19IFceMKTkN
         W1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785243399; x=1785848199;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zWMkY+0t8YjnkN9cHKao+n9nE2vmLOdCEDy55XomyXg=;
        b=S6GfbNDAVebWv9YTg8Ertc8VjbgX+4ecSKeT4bLj02uXL5GV0+Vm4hKKVojhFKxXPG
         +yWBkDvRNqg9YFvKoEFcKQQYowO+jG+pJe5lKiOQT2UvTcQZ66uqj42GvGETEulllF78
         K0j7aqRLriz/pRj5QYxhlf7jODhC2EIdOpGwTuHnY4rW5gkwLRKkM7hmbDpvbwCYqoBy
         XlQQri85Ycv9kOxG4Z5wze3AohQgJd+PYgkWGVq5Hv9nukZJ4QKRHGW11x3Gvx5mvS9c
         heqUjTbEJlek0/DStNMM3WziFG79ZPQ3CYJTbABYahBqVIIxf9H9Gdf2iYIcfFRdnPwg
         958w==
X-Forwarded-Encrypted: i=1; AHgh+RrJe0XAxgP7CiTZA3HwWu1Ej8Ut8fSGseoI3yhXP4prku63RSbx7NWMzFPcfgLpEYpA32ee7Qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJa95JlswSPdga8sPzEmLZznd9uiDrC7NsMpzp/mJtippubsmX
	mSCeFFDGt1+yhcJYjeHel0N5hWXRZRHDI33Lygq/QrJwY2MjrEJZUJzAoeeF3KICabCYje/KMkN
	Su0bYJA==
X-Received: from pgmm5.prod.google.com ([2002:a05:6a02:5505:b0:c91:e464:eab5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7f81:b0:3c3:b57b:6291
 with SMTP id adf61e73a8af0-3c8aafd66bbmr3065895637.18.1785243398916; Tue, 28
 Jul 2026 05:56:38 -0700 (PDT)
Date: Tue, 28 Jul 2026 05:56:37 -0700
In-Reply-To: <CAGEsz8FbPu_DtOkTij0RvBriK1R0FspzEU6Oef0Gers-gS1d3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAGEsz8FbPu_DtOkTij0RvBriK1R0FspzEU6Oef0Gers-gS1d3w@mail.gmail.com>
Message-ID: <aminBc88wFWw4NSC@google.com>
Subject: Re: [PATCH] KVM: x86: Cancel IOAPIC EOI work before freeing vCPUs
From: Sean Christopherson <seanjc@google.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, security@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 28, 2026, Myeonghun Pak wrote:
> The IOAPIC delayed EOI injection worker dereferences local APIC pointers
> from the VM's APIC map.  Since commit 17bcd7144263 ("KVM: x86: Free
> vCPUs before freeing VM state"), kvm_arch_destroy_vm() frees vCPUs and
> their local APICs before kvm_ioapic_destroy() synchronously cancels the
> worker.
> 
> Consequently, if the delayed work is pending when VM teardown starts,
> the worker can run after a local APIC has been freed.

...

> Fixes: 17bcd7144263 ("KVM: x86: Free vCPUs before freeing VM state")
> Cc: stable@vger.kernel.org
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  arch/x86/kvm/ioapic.c | 12 +++++++++++-
>  arch/x86/kvm/ioapic.h |  1 +
>  arch/x86/kvm/x86.c    |  1 +
>  3 files changed, 13 insertions(+), 1 deletion(-)
> 
> AI disclosure: I used AI assistance during the audit and am treating the
> issue as public as required by Documentation/process/security-bugs.rst.
> The reproducer has not been posted publicly.

Though that doesn't seem to matter much given you're the fourth person/group to
independently report this bug. :-)

A fix is already pending:
https://lore.kernel.org/all/20260727171718.543491-1-seanjc@google.com

Thanks!
