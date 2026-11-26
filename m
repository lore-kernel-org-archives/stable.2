Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795660938;
	b=mha6HJ/YjwOXBE7rPnIqodFixRIkVt8KLo8Rb3jw3nXEelkn/3coQ7CQdHnoFN0azzrA
	 BsKLyjgO2rM67BlgMeA+uu1Ll41IfsJ/RbsPUGU0uu3YD0TWGS+yqTKo90zHeZBc1nwZO
	 EkF5UxDDDpHETzCF6OmDlbsQMSFlvrHV0viv4s8B5+b4gL9Od0wziBSHYIdaoElLyDYnl
	 QYNpLSgAz2hbAP+bor2kQZA/AaVzF3JUvso5vY6dThJhDE4IJYm4njggHUjR1YHww0VBl
	 /CaYcjKWq9hzWhetZ/Nnc0baeZTI15Spg6f44oG5KxtPwNFtZyh0KRd4ZK0roOoXxqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795660938;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:In-Reply-To:References:Date:Message-ID:User-Agent:
	 MIME-Version:Content-Type;
	bh=6Wy5oFRN2V0Kiq6yTdbpLe5sq9EA0nzBLoJ1V+78Tzk=;
	b=E5fX+aZGsd1KPu4no8103+UxMn7/lk/Gnj7jKBA9BBMHGJoYOktKojErELGIAJtMbtLy
	 y21sVdxacjNt+hT1H8GDEGu35U3vIgtoWUnPtL5f4sWB3zPhY98VE2yeEEp+tuVRCnJ3p
	 82tZ9rn5iI6Qpgqt0lV1tE5LKC6eWWQhX9VMalYRafMwOAVfMeSjBGEbvyF0hRPmqmTxF
	 D97cOg8aYKlEvXF5nYbRQj64xBpPT7ny+SfPJ87OAA2sKB8zKlcyApvcHikIO79VogfUi
	 N22PAM8Ckwm+iHGPTszDip45BFA4RhN7v8EjfZjdTXSdJszW6Kd+rb28Bmk7Xrw9/0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ysZhgFT+;
	arc=none smtp.remote-ip=115.124.30.99
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A608606A31E;
	Thu, 26 Nov 2026 02:42:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A608606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ysZhgFT+
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795660933; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=6Wy5oFRN2V0Kiq6yTdbpLe5sq9EA0nzBLoJ1V+78Tzk=;
	b=ysZhgFT+NinjLaPnG/zjYSP1GbeW/XQuZlqKXNkXBTjBylETvmY3FkVWy/cN2IDIZ6c5uTL6KC4WdWKenk6PNCesdcIxS7M8GSOYdFqv0IGsxRlFQ+bVnOc5XL2co5bEvFwIFHj9hzVLnDVOt89jPGDvb/RbScdsiUAzFfVhSwg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=ying.huang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0XFT.1oD_1795660931;
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0XFT.1oD_1795660931 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 26 Nov 2026 10:42:12 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Yadong Qi <yadong.qi@linux.alibaba.com>,  will@kernel.org,
  mark.rutland@arm.com,  linux-arm-kernel@lists.infradead.org,
  linux-kernel@vger.kernel.org,  ryan.roberts@arm.com,  robh@kernel.org,
  gregkh@linuxfoundation.org,  ptg-linux-kernel@linux.alibaba.com,
  stable@vger.kernel.org
Subject: Re: [PATCH] arm64: fixmap: fix missing break-before-make in
 __set_fixmap()
In-Reply-To: <awbvHVSX7sB8jzYA@arm.com> (Catalin Marinas's message of "Wed, 25
	Nov 2026 14:22:21 +0000")
References: <20261123093505.974-1-yadong.qi@linux.alibaba.com>
	<awW3Dw743-rw_-cf@arm.com> <87mrqxto23.fsf@DESKTOP-5N7EMDA>
	<awbvHVSX7sB8jzYA@arm.com>
Date: Thu, 26 Nov 2026 10:42:11 +0800
Message-ID: <87wlq0s48s.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Wed, Nov 25, 2026 at 02:36:36PM +0800, Huang, Ying wrote:
>> Catalin Marinas <catalin.marinas@arm.com> writes:
>> 
>> > On Mon, Nov 23, 2026 at 05:35:05PM +0800, Yadong Qi wrote:
>> >> diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
>> >> index f66a0016dd02..5593d7e0d523 100644
>> >> --- a/arch/arm64/mm/fixmap.c
>> >> +++ b/arch/arm64/mm/fixmap.c
>> >> @@ -126,12 +126,19 @@ void __set_fixmap(enum fixed_addresses idx,
>> >>  
>> >>  	ptep = fixmap_pte(addr);
>> >>  
>> >> -	if (pgprot_val(flags)) {
>> >> -		__set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, flags));
>> >> -	} else {
>> >> +	/*
>> >> +	 * Break-before-make: when the slot still holds a valid mapping
>> >> +	 * (e.g. earlycon re-mapping FIX_EARLYCON_MEM_BASE), invalidate the
>> >> +	 * old entry and flush the TLB entries caching it before a new
>> >> +	 * mapping is installed, so old and new translations never coexist.
>> >> +	 */
>> >> +	if (pte_valid(__ptep_get(ptep))) {
>> >>  		__pte_clear(&init_mm, addr, ptep);
>> >> -		flush_tlb_kernel_range(addr, addr+PAGE_SIZE);
>> >> +		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>> >>  	}
>> >> +
>> >> +	if (pgprot_val(flags))
>> >> +		__set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, flags));
>> >>  }
>> >
>> > I guess that's easier than getting the driver or earlycon code to do
>> > clear_fixmap().
>> 
>> Yes.  And because set_fixmap() flushes the tlb on x86, IMHO, it's a
>> little hard to justify the driver modification.
>> 
>> However, set_fixmap() only flushes the tlb on the local CPU instead of
>> broadcasting the flush, because fixmap is either per-CPU or used during
>> early boot.  In theory, we could follow that approach and perform a
>> local flush instead though the benefit may be marginal.
>
> Local TLBI won't work on arm64 since the page tables are shared (any CPU
> can speculatively load the TLB) and only FIX_VNCR has per-CPU entries.

Got it.  IIUC, because we have the shared page table and the BBM
restriction, even if we change the PTE for a per-CPU entry, we still
need to use a global TLBI.

---
Best Regards,
Huang, Ying
