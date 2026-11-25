Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795574617;
	b=3X3/NbunTHWO76u3piKsdeelY7tlfjMV9yoizikMO1QfavjBRSLPwwvUeG2otllHo9/F
	 dx9DLzW6Kjt1alIjj0TnFl1Sq8IxEt6sfpxqsOxVQZw9jKiddQ2IGoJhT1oOMWSBo8m0D
	 GRuf+3c6XVGJlaVRpDK9WcKWXmL1JHbMiONMAN6LAZFFDNbyXET8kDX2cwX2iBswTng0p
	 vEKc5Y975PSfwqR6uUx8CIK/5WzH2jqhpBdKDukxjShNophhOEZsroBasyjJ3QHqNEs9B
	 rHWUUmtxSwERdBnRSBlcXo1p+jVT1iuhq6S+uYcNal83e5woQ4cSHm+I64mKDIs/0Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795574617;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:Thread-Index:
	 Content-Language;
	bh=/z1KVAHLgv0AOzLrNBK2aI9URthpRD6ryQLaugu2dXM=;
	b=pixbmZkFW2q7sJId0ZBICXFzpu50jG19Ochh18Eh8faizBrM1k1uDONTeZ1eH2NkqBS3
	 mDsGloNbQlbAU9taD7brqVRhKlWwp1DFe9yv7s8e26woltBL/vL65jU18uy5jCKFrm7Hm
	 HqHm+uTm2ez13INp7LcmMxj57CejTReC8iVPTBYKNfsVwbyuYm/6hrN8Gfwleq4kWc9Nv
	 NI9KgCWGDLgiaUQUjdwaP3QVW0TXLvKzDYlnnUmmFLyBPSZNcyXUp2iyQLsoIvvmJVipK
	 Ss5C38Xe1pcKXMynWNGlgsHSZRmz52WsxglnCIMOlAfLI7qLCF5Qb5drsGPdSCVj98g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=I4UkGECd;
	arc=none smtp.remote-ip=115.124.30.110
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19823606A31E;
	Wed, 25 Nov 2026 02:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19823606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=I4UkGECd
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795574612; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=/z1KVAHLgv0AOzLrNBK2aI9URthpRD6ryQLaugu2dXM=;
	b=I4UkGECdGVolSzd47GpV6fTGiXcndi73PZMks7RGVQCvXAcyKBL4jcrlbcrzFKuy2lsLuuNE+4pQT6yV3vMtw4z07AuCsG1uq/M4wZoyjzpIFpSYEYDcwXZZKZSvkm5u6ytSWkElreMs3nmnjtB4Pfc2J+P37YdE3j5m988UkoY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=yadong.qi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0XFPzcfO_1795574611;
Received: from LG41624401116(mailfrom:yadong.qi@linux.alibaba.com fp:SMTPD_---0XFPzcfO_1795574611 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Nov 2026 10:43:31 +0800
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
References: <20261123093505.974-1-yadong.qi@linux.alibaba.com> <awW3Dw743-rw_-cf@arm.com>
In-Reply-To: <awW3Dw743-rw_-cf@arm.com>
Subject: RE: [PATCH] arm64: fixmap: fix missing break-before-make in __set_fixmap()
Date: Wed, 25 Nov 2026 10:43:30 +0800
Message-ID: <000c01dd7c86$c20cbee0$46263ca0$@linux.alibaba.com>
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
Thread-Index: AQH7ElggY0dR4+WfGztAU9vFXs2ztgHFVm0LtvSuwoA=
Content-Language: zh-cn

> -----Original Message-----
> From: Catalin Marinas <catalin.marinas@arm.com>
> Sent: 2026=C4=EA11=D4=C225=C8=D5 0:11
> To: Yadong Qi <yadong.qi@linux.alibaba.com>
> Cc: will@kernel.org; mark.rutland@arm.com; =
ying.huang@linux.alibaba.com;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> ryan.roberts@arm.com; robh@kernel.org; gregkh@linuxfoundation.org;
> ptg-linux-kernel@linux.alibaba.com; stable@vger.kernel.org
> Subject: Re: [PATCH] arm64: fixmap: fix missing break-before-make in
> __set_fixmap()
>=20
> On Mon, Nov 23, 2026 at 05:35:05PM +0800, Yadong Qi wrote:
> > diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
> > index f66a0016dd02..5593d7e0d523 100644
> > --- a/arch/arm64/mm/fixmap.c
> > +++ b/arch/arm64/mm/fixmap.c
> > @@ -126,12 +126,19 @@ void __set_fixmap(enum fixed_addresses idx,
> >
> >  	ptep =3D fixmap_pte(addr);
> >
> > -	if (pgprot_val(flags)) {
> > -		__set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, flags));
> > -	} else {
> > +	/*
> > +	 * Break-before-make: when the slot still holds a valid mapping
> > +	 * (e.g. earlycon re-mapping FIX_EARLYCON_MEM_BASE), invalidate =
the
> > +	 * old entry and flush the TLB entries caching it before a new
> > +	 * mapping is installed, so old and new translations never =
coexist.
> > +	 */
> > +	if (pte_valid(__ptep_get(ptep))) {
> >  		__pte_clear(&init_mm, addr, ptep);
> > -		flush_tlb_kernel_range(addr, addr+PAGE_SIZE);
> > +		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> >  	}
> > +
> > +	if (pgprot_val(flags))
> > +		__set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, flags));
> >  }
>=20
> I guess that's easier than getting the driver or earlycon code to do
> clear_fixmap(). Note that I queued Fuad's patches for missing barriers
> onto arm64 for-next/fixes, so please rebase on top.
Sure, will rebase on that.

>=20
> Sashiko also has a valid point about keeping the TLB flush =
unconditional
> for the clear_fixmap() case:
>=20
> =
https://sashiko.dev/#/patchset/20261123093505.974-1-yadong.qi@linux.aliba=
ba.c
> om
Got it.

>=20
> --
> Catalin


Best Regards
Yadong

