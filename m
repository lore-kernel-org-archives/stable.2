Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795657622;
	b=EIIpLb8RTA6clbful8g/8BmbFYWxS1DLmHpXelHwFhk6O5LxeOZutjogY0TfgBAE73sI
	 GljhOTj+qSYqvG5gdzz44zrrD+h1YI7ht3GcktIeqraATUouAsGMhkUHSW0iwPD7XYI+h
	 SuYNqCmZDvWleep/jJ99CQlLsn/wwPsNq7TTGPD61hmdjHYRrFFOan5ErMFQNReskovho
	 cOLI7xHxgYus82PxUDHyJVzAr7TftkcrVcAHmCyeyK6Ko9s8v72O3PiC7W9uGLSO8GVZ/
	 x7l0BC/+9M4jVQclraMAsPujqI40hfMy7mBZD6vFKVO5Sf9VLTUOoeBp3F1KkVWgXGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795657622;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:Thread-Index:
	 Content-Language;
	bh=W2EQK2hOfQhR4mMPTSrPSxv8Zf/b5iZOJhmrVlnPr4w=;
	b=RDp66c/I/wCYmoEhFsSVUKsx02uUahmfJ8hsk8T4oh8aqVIGZVVthUgBaGUbFEEVQbZW
	 vCTEhRQqabClN9HKp2vOilIuxPjhdToX/iiQwgHbXY//W929LKR+JqK3TcffPCykr1eIu
	 R7SqFX+/KwTV/0F47lvymVNV4JUXmCdXptISSrIwGhjYHgnOkvV0cUOc9Ukf8KABwolJf
	 tDoOEU6jTpwPYmTqaOy0DVq6VjX2PYYNYM6fumAI8Uw90sFgqrvYho96+JLPDM5pS5A/c
	 +CKdItUQ29686AULQxSHMpNylo/lQ1gGADkh14x6rCFD6qUJVHZj9Mo7FVZ7WLxdatg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cksJBI8v;
	arc=none smtp.remote-ip=115.124.30.98
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EA2606A321;
	Thu, 26 Nov 2026 01:47:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63EA2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cksJBI8v
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795657612; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=W2EQK2hOfQhR4mMPTSrPSxv8Zf/b5iZOJhmrVlnPr4w=;
	b=cksJBI8vCDqOKJGJ+ED7qJB9iNfpsYlMIH00+6f72ymohmQp/Q53gsVHGASA9PPs7juQuWXx8rdyZVETagPifKuR4wd6NG2D8JvUCGb04c9EshEY1rh5eU96sgJG+WagJkP69mFcfo+Wjz9/vGbnJwBk72/Z9klTHG1irVEBX/8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=yadong.qi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0XFSrPkD_1795657611;
Received: from LG41624401116(mailfrom:yadong.qi@linux.alibaba.com fp:SMTPD_---0XFSrPkD_1795657611 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 26 Nov 2026 09:46:51 +0800
From: <yadong.qi@linux.alibaba.com>
To: "'Catalin Marinas'" <catalin.marinas@arm.com>
Cc: <will@kernel.org>,
	<mark.rutland@arm.com>,
	<ying.huang@linux.alibaba.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>,
	<ryan.roberts@arm.com>,
	<robh@kernel.org>,
	<gregkh@linuxfoundation.org>,
	<ptg-linux-kernel@linux.alibaba.com>,
	<stable@vger.kernel.org>
References: <20261125063224.553-1-yadong.qi@linux.alibaba.com> <awb34Zfblg-A1tHQ@arm.com>
In-Reply-To: <awb34Zfblg-A1tHQ@arm.com>
Subject: RE: [PATCH v2] arm64: fixmap: fix missing break-before-make in __set_fixmap()
Date: Thu, 26 Nov 2026 09:46:50 +0800
Message-ID: <001001dd7d48$01c04cc0$0540e640$@linux.alibaba.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIlHPfcVfRmir7bpqVzZq45BGzU7gMX4XPYtpeU9nA=
Content-Language: zh-cn

> -----Original Message-----
> From: Catalin Marinas <catalin.marinas@arm.com>
> Sent: 2026=C4=EA11=D4=C225=C8=D5 23:00
> To: Yadong Qi <yadong.qi@linux.alibaba.com>
> Cc: will@kernel.org; mark.rutland@arm.com; =
ying.huang@linux.alibaba.com;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> ryan.roberts@arm.com; robh@kernel.org; gregkh@linuxfoundation.org;
> ptg-linux-kernel@linux.alibaba.com; stable@vger.kernel.org
> Subject: Re: [PATCH v2] arm64: fixmap: fix missing break-before-make =
in
> __set_fixmap()
>=20
> On Wed, Nov 25, 2026 at 02:32:24PM +0800, Yadong Qi wrote:
> > __set_fixmap() installs a new PTE with __set_pte() but never =
invalidates
> > the TLB; only the clear path calls flush_tlb_kernel_range(). The
> > dsb(ishst)/isb that __set_pte() emits makes the new PTE visible to =
the
> > table walker but does not invalidate stale TLB entries. Overwriting =
a
> > still-valid slot therefore leaves the old translation cached and
> > violates break-before-make: accesses may keep hitting the old output
> > address, and changing the attributes of a cached entry can trigger =
TLB
> > conflict aborts or CONSTRAINED UNPREDICTABLE behaviour.
> >
> > Two in-tree callers overwrite a valid FIX_EARLYCON_MEM_BASE slot:
> >
> >  - earlycon: earlycon_map() maps the UART before match->setup() =
runs.
> >    If setup fails, con->write is unset, or the DT reg-io-width is
> >    unsupported, the slot stays valid but no console is registered. =
The
> >    console_is_registered() guard only blocks successful =
registrations,
> >    so a later attempt (e.g. a failed DT earlycon followed by =
earlycon=3D
> >    on the command line) remaps the slot to a different UART.
> >
> >  - samsung_tty: apple_s5l_early_console_setup() overrides the
> >    just-installed entry from PROT_DEVICE_nGnRE (FIXMAP_PAGE_IO) to
> >    PROT_DEVICE_nGnRnE on the normal successful boot path.
> >
> > Both are valid-to-valid changes (different output address or memory
> > type), which arm64 requires to be break-before-make.
> >
> > Fix this in __set_fixmap() by invalidating any existing valid =
mapping
> > up front: clear the old PTE and flush the TLB, then install the new =
PTE
> > only when setting. The old translation is gone before the new one is
> > created, so the two can never coexist in the TLB. A first-time =
mapping
> > (old entry invalid) skips the invalidation and pays no extra cost, =
and
> > clearing a slot is handled by the same step.
> >
> > A clear (!flags) always clears and flushes, even when the PTE is =
already
> > invalid. An invalid PTE does not imply an invalid TLB: another CPU =
may
> > have cleared the PTE but not yet completed its TLB flush, leaving a =
stale
> > entry cached locally. The unconditional flush preserves =
clear_fixmap()'s
> > TLB shootdown guarantee, which callers such as the KVM VNCR unmap =
path
> > rely on when racing with a remote invalidation.
> >
> > This belongs in the callee, as on x86: __set_fixmap() there calls
> > set_pte_vaddr(), which flushes the TLB unconditionally after writing =
the
> > PTE. x86 can flush after the write because it has no =
break-before-make
> > requirement; arm64 must invalidate and flush before installing the =
new
> > valid entry to avoid TLB conflict aborts.
> >
> > Fixes: 9aac5887595b ("tty/serial: add generic serial earlycon")
> > Cc: stable@vger.kernel.org
> > Reported-by: Huang Ying <ying.huang@linux.alibaba.com>
> > Signed-off-by: Yadong Qi <yadong.qi@linux.alibaba.com>
>=20
> Nit: commit 9aac5 added earlycon_map() -> set_fixmap_io() but I think =
a
> a few other commits later caused overriding this fixmap entry. I think
> set_fixmap_io() was underspecified, not requiring a clear_fixmap() =
after
> use but they inherited the x86 behaviour already which did the =
flushing.
> Anyway, I think a better tag would be (to make it arm64-specific =
issue):
>=20
> Fixes: bf4b558eba92 ("arm64: add early_ioremap support")
Agreed. Will switch to it in the next version.

>=20
> > diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
> > index 951004ad700c..5da49e201b6f 100644
> > --- a/arch/arm64/mm/fixmap.c
> > +++ b/arch/arm64/mm/fixmap.c
> > @@ -126,13 +126,49 @@ void __set_fixmap(enum fixed_addresses idx,
> >
> >  	ptep =3D fixmap_pte(addr);
> >
> > +	/*
> > +	 * Break-before-make: when the slot still holds a valid mapping
> > +	 * (e.g. earlycon re-mapping FIX_EARLYCON_MEM_BASE), invalidate =
the
> > +	 * old entry and flush the TLB entries caching it before a new
> > +	 * mapping is installed, so old and new translations never =
coexist.
> > +	 *
> > +	 * A clear (!flags) always flushes even if the PTE is already =
invalid:
> > +	 * a remote CPU may have cleared the PTE but not yet completed its =
TLB
> > +	 * flush, leaving a stale entry cached locally. Take KVM VNCR =
unmap as
> > +	 * example:
> > +	 * When CPU1 wins atomic_xchg_relaxed(&vt->cpu, -1) in =
unmap_l1_vncr(),
> > +	 * CPU0 calls clear_fixmap() on its own slot so it cannot finish
> > +	 * vcpu_put() before the local TLB entry is invalidated:
> > +	 *      CPU0                                  CPU1
> > +	 *                                 invalidate_vncr()
> > +	 *                                 unmap_l1_vncr()
> > +	 *                                   atomic_xchg_relaxed(&vt->cpu, =
-1)
> > +	 *                                   clear_fixmap(vncr_fixmap(0))
> > +	 *                                     __pte_clear(..., ptep)
> > +	 *                                     <delayed before TLB flush>
> > +	 * kvm_vcpu_put_hw_mmu()
> > +	 * this_cpu_reset_vncr_fixmap()
> > +	 *   unmap_l1_vncr() =3D=3D -1
> > +	 *   clear_fixmap(vncr_fixmap(0))
> > +	 *     !pte_valid(__ptep_get(ptep))
> > +	 *     <skips flush_tlb_kernel_range()>
> > +	 *                    <stale TLB entry still live on CPU0>
> > +	 * If another nested vCPU then schedules on CPU0 and calls
> > +	 * kvm_map_l1_vncr() before CPU1 finishes =
flush_tlb_kernel_range(),
> > +	 * __set_fixmap() also sees !pte_valid(__ptep_get(ptep)) and =
installs
> > +	 * the new PTE while the old translation is still cached in CPU0's =
TLB.
> > +	 * Unconditionally clearing and flushing when !pgprot_val(flags)
> > +	 * preserves clear_fixmap()'s TLB shootdown guarantee.
> > +	 */
>=20
> There's too much text here. Move it in the commit log if you want and
> just write a few lines in the code, something like:
>=20
> 	/*
> 	 * Break-before-make if the slot holds a valid mapping. Always
> 	 * flush on clear since another CPU may have cleared the pte
> 	 * without completing its TLBI yet.
> 	 */
>=20
Much cleaner, thanks =A1=AA will fold this in and leave the details in =
the
commit log.

> > +	if (pte_valid(__ptep_get(ptep)) || !pgprot_val(flags)) {
> > +		__pte_clear(&init_mm, addr, ptep);
> > +		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> > +	}
> > +
>=20
> With these changes,
>=20
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>


Best Regards
Yadong

