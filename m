Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128093F327D
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 14:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786459210; cv=none; b=HuEO2hONNL87pSJf3SX9qzubUO5QSbSBQzXpzSRj6tJ3Qb4HILNHLzFFJkSagrO5pvMQtbrRVHpz85YjjmTD5nIrwgXDu/K7Jzy0fiWXnxInJN9xq/kQ1ndKNq6eS1ATpx1baJr7OvNnmifiGZnGl7Ol2HEDXTwErLT47oAvqmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786459210; c=relaxed/simple;
	bh=UFX6Tqeb6IePKdToSptpGmrdLCj2iNkNV3bvfdpJ3Qs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L/2S0Vho5pqYaAzZUCGI7GGwDuX8JpeZxZU/EgLGkJsv2ZgCZ31pul/I8skiCjwQXIqHhKZQ8TMps+ZguYRWR1KfQtFTIDedmDxkBXPPvvsYWvO5c8C0VpS284gFFy9qjSGROmT5tDYDety3L/5kNfk2AK7ose48HmffYvJthGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nusgcz/M; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nusgcz/M"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbbb9c9bfc3so1910809a12.1
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 07:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786459208; x=1787064008; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zmcZw7eQs6vTJnb1q/TfEti4GMDcO2FFXTD8wseJb6M=;
        b=Nusgcz/MABz224RhumoVsNiUERLzHl1qcC9Nh7HnA/kCkwwcEaRApK7evAMZijGg4u
         WQyGrKAxWFO7caNd7IGPJONb3+o8hLmoUVZZWg0/S53d3ma0Ttu5kpbSdSb8exWVBbRm
         wNSQ9k5XMgYdCLboClBKnVw2/B8+6k7PxyFE47UpdCt6Gy5v/AnvGydRs4VMqSjj6+n2
         2TSv3uyK1cPtJlkqYeAWe5o2Fs/GI+mKShZRzTwNhXxNWm3Jbcu4Ht13BPlLwaKgcTwF
         coPPx9UKi9WrEZspoiMFwobiT3vwVHVT9hgYjzx9AD9BiJmaI828pKOgsA2Ryq66jrlu
         cUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786459208; x=1787064008;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zmcZw7eQs6vTJnb1q/TfEti4GMDcO2FFXTD8wseJb6M=;
        b=hP/PdxmhBwe5ZLq26SrDUcdD/C5vh9ZHp1wA3oiCpmyh9lWFE1s3CGZ+jPA1YARaEW
         cqsiChom3dekvurBi3ZfjcBMqL+ROqgbKfW/p85nDQP+FpRWNPyQXXbATYHCOQ/lYq8D
         Js0VKtpdipWm/KhnB5cfoqstigAX3PLUnbNIX678JZNzrvjP9zvHuB9WWU0EqHtTReda
         w2YT+rOSXtRV4uyMA8AWn9kvGQKkM1PNcVBOR0cJfhAblHRSlyyE+u7iYsnNNv5A+bAt
         DF5BjsrCVDqoHW9XEbP9Kq5pyYT0p4x4jLnxQeHpfyu/NFtOQPYnR4nuYJXOVOLuEvxw
         FKHQ==
X-Forwarded-Encrypted: i=1; AHgh+RpaCKrA75fXmcRbJxGrJRfD55VV7YhvD7hFhLtgLpo0ITfJoWLM3wehK9/MCvxqIVCzmSA0j2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqOWO9ezYeAkLDOt1an+3GZp9DwRLemCDCX0EIpxSePzPwmH2z
	CwijxSIBEbHSAjCsBpSuWFzjeO9YiEM4oLesZXMFLoIWarDb1igTs7iD1P/2xe+XWBrb771+MaE
	vgZCX7Q==
X-Received: from pgaq65.prod.google.com ([2002:a63:4344:0:b0:c8d:1b0:ab70])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:ce4d:b0:3c0:eeb7:28b
 with SMTP id adf61e73a8af0-3cc2b8df2afmr5644517637.8.1786459207891; Tue, 11
 Aug 2026 07:40:07 -0700 (PDT)
Date: Tue, 11 Aug 2026 07:40:07 -0700
In-Reply-To: <20260810152730.841260-1-david.lee@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810152730.841260-1-david.lee@trailofbits.com>
Message-ID: <ans0RzGmObCkAb6e@google.com>
Subject: Re: [PATCH] KVM: pfncache: track all MMU notifier invalidations
From: Sean Christopherson <seanjc@google.com>
To: David Lee <david.lee@trailofbits.com>
Cc: pbonzini@redhat.com, Kyle Zeng <kylebot@openai.com>, 
	"Dominik 'Disconnect3d' Czarnota" <dominik.czarnota@trailofbits.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="us-ascii"

+David W

On Mon, Aug 10, 2026, David Lee wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> There is a race condition in KVM's gfn-to-pfn cache refresh and MMU
> notifier handling. An HVA-backed cache can publish a stale PFN and
> kernel virtual address after the corresponding userspace mapping has
> been invalidated. The Xen shared-info HVA interface immediately reads
> and writes through that stale address, resulting in a host-kernel
> use-after-free.
> 
> The cache refresh path in virt/kvm/pfncache.c drops gpc->lock while
> resolving and mapping an HVA. It uses mn_active_invalidate_count and
> mmu_invalidate_seq to detect an MMU notifier interval that overlaps
> this unlocked window. However, mmu_invalidate_seq is advanced only
> when the invalidated HVA overlaps a KVM memslot. HVA-backed caches are
> explicitly allowed to refer to memory outside all memslots. If such an
> invalidation starts and finishes while gpc->valid is false, the active
> count returns to zero without a sequence change and the refresh accepts
> a stale PFN.
> 
> An unprivileged process with access to /dev/kvm can reach this path with
> KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA. KASAN-detected use-after-free in
> kvm_xen_shared_info_init(). The affected function reads and writes Xen
> wall-clock fields through the stale mapping, so the issue can cause a
> host-kernel crash and memory corruption.
> 
> The attached KASAN output confirms:
> 
>   BUG: KASAN: use-after-free in kvm_xen_shared_info_init+0x344/0x3d0 [kvm]
>   Read of size 4 at addr ffff888046000900 by task poc/1266
> 
> Add a notifier-specific sequence that advances for every completed
> invalidate interval before mn_active_invalidate_count is decremented,
> and use that sequence for pfncache retry. The existing barrier pairing
> then guarantees refresh observes either an active invalidation or a
> sequence change.
> 
> Fixes: 721f5b0dda78 ("KVM: pfncache: allow a cache to be activated with a fixed (userspace) HVA")
> Cc: stable@vger.kernel.org # 6.9+
> Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> Co-developed-by: David Lee <david.lee@trailofbits.com>
> Signed-off-by: David Lee <david.lee@trailofbits.com>
> ---
> Bug found and triaged by OpenAI Security Research and
> validated by Trail of Bits.
> 
> Trail of Bits has a reproducer for this bug that triggers a
> KASAN use-after-free and can share if needed.

Go ahead and share, syzbot has been reporting this race for some time, i.e. how
to repro this isn't exactly a secret, and the more testcases the better.  This is
also like the fourth or fifth proposed fix for the bug (bugs?).  I think the most
recent version of the fix we are pursuing is here:

https://lore.kernel.org/all/20260811094829.98794-12-dwmw2@infradead.org

Thanks!
