Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F3F4F96CB
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775934; cv=none; b=EmI2S2JMCke1qhNpC7fPsxVacq6TL8hgfd/egGOMaNFKudI4RYPPWDPdTIYmoaCWEO6g8MvzMjBWDSoggHof0fIpUriy0xGX4doFzXkaxWvEVtTZfNQ71+/vJzYt9WAVSzWGKGCHOsmD7nO0bENIHaaFUKC/yOj5IpYpsr/foCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775934; c=relaxed/simple;
	bh=tfUpyRLqXw+Me4tlpBprkaNOfMsNPXIKHnEumnJWxX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXS0J4oXK8bgjxNd8bpjSsr1496Qgg59JMaVWVGfY48droRxjjfCGCjUCWJQpBM3GoYCOaX9sngchucy4a8KwecoTuayyXHKuGw2an7cRviWVBmlTbAEJM+lA8Io831Be465fCU+fvEbzkCdswr39Juc/hVgQqPhh8HlSRrhr4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=VAV9VtKb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tGouMiU8; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="VAV9VtKb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tGouMiU8"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E9E9F7A06F3;
	Wed, 30 Sep 2026 09:45:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 30 Sep 2026 09:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790775905; x=1790862305; bh=ZvxwjX+NjS
	TG86xQ6ystZEGsX/+E3h8M62mr0TCeJ+I=; b=VAV9VtKbLHw5TlzMJvpv8A5j14
	R5VOldOKMAtFaD/g6/K0G+gk0SmcYSEYEGStPfollqx0UyZwrbrjN9U1wYAjxbic
	XYiqvr1qT3IaCu+T2Bnx4zQOVOhE4JQ3C/nYkbAwFuSmMC38T42TpRxGvOEKTDhE
	FRBoy4Kyu5LV/t1Phe84r59tHDVwgIfxGzoOL8yGsoPBfXeiFJ4d7bbA7gYCn83Y
	qtPtF3XeEDePTnlCBxtmgdWiNHlwS9xj7iS6wlaqNQQjhEm65ebtJoz6JaxJdaG2
	ah2VfDhATrjtxcD6+XL/vogRb3rMLlMqG+0qd5FQ+a0tjJHe32HwLveCYaug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790775905; x=1790862305; bh=ZvxwjX+NjSTG86xQ6ystZEGsX/+E3h8M62m
	r0TCeJ+I=; b=tGouMiU8cXvP3nKhE+8bwKQhUM69Z7yO4Sig/3ZVLT1R/bCwTDP
	/96c7HEfbdskBVfaz7xf2q/FtMXhSds1tqL3h9aQNNTFkX3k1fVkYCM8sMgbznvZ
	LYzeY2St0tWvhh/VIBU1IucID3RudJ2WlXME4YnJ9bUxZyqq0HUOXsHOVXrRr7Ry
	fCcNIVis6N4tvKZjjpmZMFE3+jkRn6H4Ed477xq3zMW9ydhEI5tV6gvBALXLNNDI
	yjQVjZFhyEiRmp+FJTved0qUcL+e6UWCZehts2OtTEhCXN2v+PecCpHl/yYdDqTY
	2xRMtd1uUtRDWAQLGypNVQKZstZEc8vlVrA==
X-ME-Sender: <xms:YRK9ajhvu0Ll11maJvLbZBcpQd_n9iZarI00eGj-NHLcjjCao3pbfQ>
    <xme:YRK9ar59P94bkry7I8GjoHloGNl0W3BQPKnBdIkJ-7BJTkqHx25zn9_RNj9Z-xpeF
    OYa2qlB7kJ7ye0qx-KjCB8AsT_6jfcugd6v4qklrME14IYOhrM>
X-ME-Received: <xmr:YRK9agFZ9CpTnhd5K_eDy0MWFX6SFTPVUyZCv5W3kzkk0svE71mofetIkrvk2g7XZRg0te2NGcIcwRJ_cfRDF2yydf-znS_iVPMSdUgRH8A>
X-ME-Proxy-Cause: dmFkZTGqTedq4KSAHCiCZP1StgCgB3oHSgIQzZURPPvE3xFZj265vYX5j6tmiIUxw3BsNV
    iihKpftYhSmlvfdmWzubgkSRoVErkCVvDptedxkATRcojcte8LaqvJ2ZHk/oNP8HDmzB5Z
    jGH9w4amV1INSyYBADNl9lf36Ga9swwNYJ8cWlXlz+W0owHDah/LPbBoG3N4Iz/l23cdId
    XYpQ02R285dzrSIhGzzb+/MPcnXx4eNNNT6POS8fG4xSA0zjyBVrG1U2UHWKtn91ML1ZFq
    p308Z6D6Rr/keJltsrkaVpgNZ+GO5kMbXrQEQwTM7mgIrYJIEj2lNrt25yRHH8TenzwwV4
    9cCNn09poBq2kOmGiVjWhIGqA8yUhIDp3GDFm9PbFZOxz7oM1y9rEOOdKJ9OJANdpclwLZ
    KDEkP84r3ixCrzlFEsOorEFjLa7YyPgsWypNttibJdtLoQuBRkJJSjDSPCeXAXBURckjcc
    uL6knTsGTy1MZ774kpWsNUxnNd6sKkFrxpbsIjUixoNcknQkKeOFfJxaotQD9Q8H4bqTuj
    vVY/HQ8Sv09d95xRDR5lR8Uhh3yoeTBvULQ7+dqDpXzr6ePpZCb28yoSaIO/eWYpfHVoft
    P3ZbS2LMTXMzC3xRF5n+flXOPWJfR7mTxEhPQTWYmfxCYtxmoL5pKuZdxaUA
X-ME-Proxy: <xmx:YRK9alI2HnqEfvZg4dBd2zehjhSOvdJd87qxJw-R0jRknn8WA5FikQ>
    <xmx:YRK9algGlBuyDGc1DPN6Pva02SD1y0HUirQbYGHCtW3WFfs8KPNHmQ>
    <xmx:YRK9arkAiBcHG1LAX1SlqiSKSS8Jrrs5mztH6THi1tIVujonzoWNaw>
    <xmx:YRK9akUbpZSxtyQf8rNMRcaIzLIIAY8sjwWQ98GVmR8hd0r92z9HHw>
    <xmx:YRK9atMyDisFDnnF1OLtRX5NAYOWVDPdhb_xTBO06ri8C6tzfMEyoPsk>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 09:45:05 -0400 (EDT)
Date: Wed, 30 Sep 2026 15:45:00 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Thomas Huth <thuth@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 6.12.y 1/2] s390: Replace __ASSEMBLY__ with __ASSEMBLER__
 in non-uapi headers
Message-ID: <2026093056-clever-lustiness-56a5@gregkh>
References: <2026090944-either-skid-8b36@gregkh>
 <20260911112209.352376-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911112209.352376-1-sashal@kernel.org>

On Fri, Sep 11, 2026 at 07:22:08AM -0400, Sasha Levin wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> [ Upstream commit 42398caf16c955251a2dab86f797b76adeb99899 ]
> 
> While the GCC and Clang compilers already define __ASSEMBLER__
> automatically when compiling assembler code, __ASSEMBLY__ is a
> macro that only gets defined by the Makefiles in the kernel.
> This is bad since macros starting with two underscores are names
> that are reserved by the C language. It can also be very confusing
> for the developers when switching between userspace and kernelspace
> coding, or when dealing with uapi headers that rather should use
> __ASSEMBLER__  instead. So let's now standardize on the __ASSEMBLER__
> macro that is provided by the compilers.
> 
> This is a completely mechanical patch (done with a simple "sed -i"
> statement), with some manual fixups done later while rebasing the
> patch.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> Link: https://lore.kernel.org/r/20250611140046.137739-3-thuth@redhat.com
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> 
> Backport notes for Linux 6.12:
> Keep the assembly-guard conversion only in asm/nmi.h, whose guard is
> context for 546dde823a36 ("KVM: s390: Fix memory corruption by not
> reinjecting CK machine checks"). Drop the other header conversions,
> including changes to machine.h and net/bpf_jit.h, which do not exist in
> this stable tree. Preserve all stable-specific header contents.
> 
> Also include the one-line irq zero initialization from b239410c7653
> ("KVM: s390: Zero initialize irq in reinject_machine_check"). The target
> expects this initializer in its interrupt.c context; it also ensures
> that reinjected machine checks have zeroed padding and logout data.
> No functions are added. The target's machine-check fix is left for the
> separate target backport.
> 
> [ sashal: Reduced backport -- upstream 42398caf16c95 touches 33 file(s), this
>   backport carries 2. Not backported here:
>   arch/s390/boot/boot.h
>   arch/s390/include/asm/alternative.h
>   arch/s390/include/asm/asm-const.h
>   arch/s390/include/asm/cpu.h
>   arch/s390/include/asm/cpu_mf-insn.h
>   arch/s390/include/asm/ctlreg.h
>   arch/s390/include/asm/dwarf.h
>   arch/s390/include/asm/extmem.h
>   ... and 24 more
>   This note is generated from the file lists only; see the resolution record
>   for the reasoning. ]
> 
> Stable-dep-of: 546dde823a36 ("KVM: s390: Fix memory corruption by not reinjecting CK machine checks")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/s390/include/asm/nmi.h | 4 ++--
>  arch/s390/kvm/interrupt.c   | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/include/asm/nmi.h b/arch/s390/include/asm/nmi.h
> index 227466ce9e416..6454c15318544 100644
> --- a/arch/s390/include/asm/nmi.h
> +++ b/arch/s390/include/asm/nmi.h
> @@ -33,7 +33,7 @@
>  #define MCCK_CODE_FC_VALID		BIT(63 - 43)
>  #define MCCK_CODE_CPU_TIMER_VALID	BIT(63 - 46)
>  
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  
>  union mci {
>  	unsigned long val;
> @@ -104,5 +104,5 @@ void nmi_free_mcesa(u64 *mcesad);
>  void s390_handle_mcck(void);
>  void s390_do_machine_check(struct pt_regs *regs);
>  
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
>  #endif /* _ASM_S390_NMI_H */
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 6f13144906417..3fc07da7fd7a5 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -2863,7 +2863,7 @@ void kvm_s390_reinject_machine_check(struct kvm_vcpu *vcpu,
>  				     struct mcck_volatile_info *mcck_info)
>  {
>  	struct kvm_s390_interrupt_info inti;
> -	struct kvm_s390_irq irq;
> +	struct kvm_s390_irq irq = {};
>  	struct kvm_s390_mchk_info *mchk;
>  	union mci mci;
>  	__u64 cr14 = 0;         /* upper bits are not used */
> -- 
> 2.53.0
> 
> 

did not apply
