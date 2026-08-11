Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1C03290D9;
	Tue, 11 Aug 2026 17:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786470114; cv=none; b=rOxvXw0LaDgDn9trUb1UvWLcltHPzNsfqVEbBe9ZnTwjfR3PhFpNdI6QVUau0JnmOjlHf0thf2uKIFCzf2FmCLWD2N193+BbmnFieJklN+UDubdp+KQC/jJ3AqgLOvl4If/4WE7A6dgBG+rOlxuug4U9qlmXZiEzK1+oXhvDVuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786470114; c=relaxed/simple;
	bh=1n2YYjtZWiB20n1lGKnHccZDzdfAYSI2i1BnQ8gsZic=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=iWVnHQdUUx4kSOaV5wxqpUTGrz+TzTES1Bn/GL9QYgIfPb/Hn4nM0wkTtckUqDwdTBfxJyYVlNu2Cdi3MgC6ksbXoths3Lg1Gw6gR8jgEueREV+IC2meP1IgR2qt0W74iZX2QM5GSj0+xuv7ZeFOT/wxhc57tN89Rfi8V5xz6vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pb0puAyt; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pb0puAyt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=DqTJr5+SAHL2Duv2tZeFpi9lykUrjvqrKKLR4bseRKk=; b=pb0puAytJMT1FjlH5L4qfGKrNF
	ATOiwGf9vjrm9LLyvss9D3b2WY4g/gPK9nMtDICYhYQdSinevnF8Si9CqTPaLLKnahrbLtiBkY7pr
	gLOrfln8hHd9cPZADwuwQLoPn/F1KmIfJdtD4l14Ehd3COcfGdFdCkvxl706XIHdUzz9FRzIQiSwr
	c4+Oqb3p5ad9U0K+WIllKk682pX8JGjVJiey1ORZ0hKnSAQS7kqIQ51HEIZh2RGRnMumsTmkefssS
	Ocfqe+2t1q8NNYb6ZCCrKuWs5hoBGbM5FoukRLzHqmPmgVtncbBXtSCY0y1N7vta4oiJ31VZzN6wh
	2FGF74hA==;
Received: from [2a02:8013:6d1:1:1427:d5db:df17:4279] (helo=ehlo.thunderbird.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wtqTy-0000000EojC-3z15;
	Tue, 11 Aug 2026 17:41:47 +0000
Date: Tue, 11 Aug 2026 18:41:46 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: David Lee <david.lee@trailofbits.com>,
 Sean Christopherson <seanjc@google.com>
CC: pbonzini@redhat.com, Kyle Zeng <kylebot@openai.com>,
 Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] KVM: pfncache: track all MMU notifier invalidations
User-Agent: K-9 Mail for Android
In-Reply-To: <CAC_etQGgLq9fxr5kG=VmndnRENZZTFnLr_PKTHKiPYjn-zYuFA@mail.gmail.com>
References: <20260810152730.841260-1-david.lee@trailofbits.com> <ans0RzGmObCkAb6e@google.com> <CAC_etQGgLq9fxr5kG=VmndnRENZZTFnLr_PKTHKiPYjn-zYuFA@mail.gmail.com>
Message-ID: <07B5ACA0-4586-478B-8F4E-E6C626ADC256@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

On 11 August 2026 18:16:58 BST, David Lee <david=2Elee@trailofbits=2Ecom> w=
rote:
>Hi Sean,
>
>Please refer to the attached reproducer=2E
>
>Required configuration:
>* CONFIG_KVM
>* CONFIG_KVM_XEN
>* An x86 KVM host
>
>CONFIG_KASAN is not required for the vulnerability, but it is used to
>produce the attached diagnostic output=2E
>
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Reproduction =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>Step 1: Build and boot an affected x86 kernel with CONFIG_KVM,
>CONFIG_KVM_XEN, and CONFIG_KASAN enabled=2E
>
>The confirmed kernel source revision is:
>
>~
>a13c140cc289c0b7b3770bce5b3ad42ab35074aa
>~
>
>Step 2: Compile the attached `poc=2Ec`:
>
>~
>gcc -static -O2 -Wall -Wextra -pthread -o poc poc=2Ec
>~
>
>Step 3: Run the PoC as a non-root user that has permission to open
>`/dev/kvm`:
>
>~
>=2E/poc
>~
>
>The PoC creates a KVM VM without any memslots, maps one anonymous page,
>and runs two threads on separate CPUs=2E One thread repeatedly activates
>and deactivates the Xen shared-info HVA cache=2E The other repeatedly
>discards the backing page with `MADV_DONTNEED`=2E
>
>The race is timing-dependent=2E The supplied PoC runs for 90 seconds=2E O=
n
>the confirmed test system it produced the attached KASAN report in
>`splash=2Etxt`=2E
>
>Best regards,
>David
>
>On Tue, Aug 11, 2026 at 10:40=E2=80=AFAM Sean Christopherson <seanjc@goog=
le=2Ecom>
>wrote:
>
>> +David W
>>
>> On Mon, Aug 10, 2026, David Lee wrote:
>> > From: Kyle Zeng <kylebot@openai=2Ecom>
>> >
>> > There is a race condition in KVM's gfn-to-pfn cache refresh and MMU
>> > notifier handling=2E An HVA-backed cache can publish a stale PFN and
>> > kernel virtual address after the corresponding userspace mapping has
>> > been invalidated=2E The Xen shared-info HVA interface immediately rea=
ds
>> > and writes through that stale address, resulting in a host-kernel
>> > use-after-free=2E
>> >
>> > The cache refresh path in virt/kvm/pfncache=2Ec drops gpc->lock while
>> > resolving and mapping an HVA=2E It uses mn_active_invalidate_count an=
d
>> > mmu_invalidate_seq to detect an MMU notifier interval that overlaps
>> > this unlocked window=2E However, mmu_invalidate_seq is advanced only
>> > when the invalidated HVA overlaps a KVM memslot=2E HVA-backed caches =
are
>> > explicitly allowed to refer to memory outside all memslots=2E If such=
 an
>> > invalidation starts and finishes while gpc->valid is false, the activ=
e
>> > count returns to zero without a sequence change and the refresh accep=
ts
>> > a stale PFN=2E
>> >
>> > An unprivileged process with access to /dev/kvm can reach this path w=
ith
>> > KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA=2E KASAN-detected use-after-free in
>> > kvm_xen_shared_info_init()=2E The affected function reads and writes =
Xen
>> > wall-clock fields through the stale mapping, so the issue can cause a
>> > host-kernel crash and memory corruption=2E
>> >
>> > The attached KASAN output confirms:
>> >
>> >   BUG: KASAN: use-after-free in kvm_xen_shared_info_init+0x344/0x3d0
>> [kvm]
>> >   Read of size 4 at addr ffff888046000900 by task poc/1266
>> >
>> > Add a notifier-specific sequence that advances for every completed
>> > invalidate interval before mn_active_invalidate_count is decremented,
>> > and use that sequence for pfncache retry=2E The existing barrier pair=
ing
>> > then guarantees refresh observes either an active invalidation or a
>> > sequence change=2E
>> >
>> > Fixes: 721f5b0dda78 ("KVM: pfncache: allow a cache to be activated wi=
th
>> a fixed (userspace) HVA")
>> > Cc: stable@vger=2Ekernel=2Eorg # 6=2E9+
>> > Assisted-by: Codex:gpt-5=2E6-sol Codex:gpt-5=2E5-cyber
>> > Signed-off-by: Kyle Zeng <kylebot@openai=2Ecom>
>> > Co-developed-by: David Lee <david=2Elee@trailofbits=2Ecom>
>> > Signed-off-by: David Lee <david=2Elee@trailofbits=2Ecom>
>> > ---
>> > Bug found and triaged by OpenAI Security Research and
>> > validated by Trail of Bits=2E
>> >
>> > Trail of Bits has a reproducer for this bug that triggers a
>> > KASAN use-after-free and can share if needed=2E
>>
>> Go ahead and share, syzbot has been reporting this race for some time,
>> i=2Ee=2E how
>> to repro this isn't exactly a secret, and the more testcases the better=
=2E
>> This is
>> also like the fourth or fifth proposed fix for the bug (bugs?)=2E  I th=
ink
>> the most
>> recent version of the fix we are pursuing is here:
>>
>> https://lore=2Ekernel=2Eorg/all/20260811094829=2E98794-12-dwmw2@infrade=
ad=2Eorg
>>
>> Thanks!
>>

Thanks=2E Sounds very much like the reproducers I've been running many tim=
es in parallel on my test hosts since Friday, testing various iterations of=
 what is now in my xen-srcu-prealloc branch=2E But I can add it to the stab=
le=2E=2E=2E
