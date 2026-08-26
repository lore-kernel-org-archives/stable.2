Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2660437F321
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 06:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787725666; cv=pass; b=aKRiqm+imaGWKnFh2dZyV/6ncNMjfNWD03dsbFvC8ZaipNQUN65aORlNYNp2gE03FYNFFP9Ik21NkF9gIzLYwOT0DpRqx6JiO+OgMz3ABHVhFkvvxE+OJ7TNJzvWvTaT2YjgA69az8Lo5p4Bdt88/iQer+eOAWbDlrbznEklBBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787725666; c=relaxed/simple;
	bh=SRuRWxMQzXeC+rs0OpNQyle4kcKw6RCGP24XO/bNQ5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jSjCKpa6cWvpcuIZ/hm4pBMvB5lMYwdB69b1UN0eyd71PDfkbvsmYFAlKDwZel0cHZAb6ktT3vz36Gf428RejdO8bikoq8QSE2yGiqjzPQ2etMm/W6tess4cZ8PQe2FIScmv4M80+ePiCmt7eAG+wTpJkxm//xY2R7kroCPMkug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cu9oHB9q; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cu9oHB9q"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39c95395230so4469761fa.2
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 23:27:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787725663; cv=none;
        d=google.com; s=arc-20260327;
        b=YC8TdZr8mIgD/oHBLZISDZZ8Qg4bwy4HevEd16AvEMwTCcPKv5qULqSAhkvT/xRE0R
         qsQuuqD6ugSPlfpUnnVEC/Zl9GJ1lfZePVzUYE2axx15cIitzR2uRbDCIe3+lDRwxrn3
         016lKWhrHyp07/5XsPTIyob757j+4r75F6rZZs/dpq4j4ZSYhT4S7b6l/mr+8SNmA2UE
         FwLHlzwWKermgW/lAAOjHLEO+ndOCOM0MJNJ3UnDIHuwJOaLtjeVTa58Yls6i8mhAPQ4
         oNKDZZCv4n+ojy5xXKd/bzZCaIwjBeyGzNq4do+0VguNBXCUl+n/YHASYqA5Ukb4ZIpc
         FLdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bCQy5KYAnT0Nqu+N8f/uz+vDCHlQ4T9ZBMVo1dyy1DU=;
        fh=XrmX/Mp3eCuCatV1+oCog9HSUD4RojTM6NizaNIw2aM=;
        b=PuEgPil4SBO/UBI6yNmumiqFA4fWXPDOxChb3qpGlswqrz/Mn7SP6RMZdHcsQ5sczR
         3fcQd/4SKgmJzal4SUQmvsITkWd+OqMXboAw5qnanswAjAaM6dmzrOelfuoQT/zlmhTZ
         5CtlFC0WCehswEe4sRAjz4rIh8jIWbjr4/CPUTvfW6sYqU8ylh9w0KFgxFWw0jJqADPh
         LjSf9flVFeEWPQ8u3nBE4woMrJST2bVqm1XW/GyQxecuMz2komCrCx7/XqHCjuZrEp+P
         G4LC62FYbgnRbnWo1Bf8iQVE2qAEJd57oqGUPr4RowuA79s3eb9yzG/tkWdY2sdW03a1
         yGBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787725663; x=1788330463; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bCQy5KYAnT0Nqu+N8f/uz+vDCHlQ4T9ZBMVo1dyy1DU=;
        b=cu9oHB9q/726O+EvsplabMDIgCrtrtFmQZoyp2oIvy+/Q1SmEMY7wGlLVowjG4+OqH
         k//wznaW3aOt0n8l2fe/ZOaftAb7+Qsjwo6ZtdwwoOcEH+P/ClQk++nRvR9F8HUQ12QA
         CGAgKDDxvC9lBfw9R+W1fK1+Jb88qPE2k10u1POq3487spkUfgGjnmahSs8ajaNGMxBf
         5ofz6lwE8vxJI34u4P7nZfTKAa/LBTh0icdjGDpBzID475nLWl4JJXK2nZY1MqzjvDJd
         ZPm1iyCoiXw8JhU57xbiofpHMkBA18rI6271hRYyQCXrYXbStodh9q5y2oLiK/QJvK5u
         odCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787725663; x=1788330463;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bCQy5KYAnT0Nqu+N8f/uz+vDCHlQ4T9ZBMVo1dyy1DU=;
        b=AGa6Y+GcANwqOdRvXwgjEIiODsyTB3XPh084hIQi/zKsoXIGOnXyOvoSV0w8aQ7/D+
         BU3IzysY3A0zXcfN/jaGZXTWXkkCyOujcwLZwmi8NGOIXh0mpNZjGSDj7Ni3WTNZYdh+
         A6iHPhM4ETbUrx20ROLHHOZY8lvUY8ADIlSPe7J0HayGBLbDv+luZJ37mcT4MK9G5faf
         xcPyTj05SaJJ5IU86k8kGcNqUX9075qEL7yyBA3dFDNao4WyzlUsvwJ/rezD8XCpM7ui
         1+Zq6AQDAh7+XOvllDX6V2h3GtCT6ZIaxexTpDPAp1L7ghN/Z64Z0Jy5ZtzLBXx+W8Ea
         ISHA==
X-Forwarded-Encrypted: i=1; AHgh+RoxgA7v9lwUoOPkPSQaSxkuv8d6IfKr3EH3pQqExFzdf9vamxmxMkk5j3T9ncvg6QzTgAcnPb8=@vger.kernel.org
X-Gm-Message-State: AFuF++kj/ENsX5Fsz7bj7o7+mZaUVJLBupzZuEOg9c6c6l8DpsyTfGoE
	/XOpI+y0T/Tp2lAJNdCnLrwzS3HStI68KqEDEbKxpy/VEIa4C8ZDKE+suTI1KU7CnYwLnUYHwqc
	Fe8PeVQqE8l7KyU+fRQStetrLOvs37hI=
X-Gm-Gg: AR+sD131X4+pNRWIkWnIh0MwUT2b66I2fV61fXdo36Xp0ZyvCyVfv0EsAuCcd0Zu3Cj
	ecSMiPSVinqXM+kRduTPADaSU30wE7jeYHny02OgulWTN1tWe/F0Nxgcon5ma2T9lzlbxculPIa
	abzrT7UlqYpi+UaAiy46UfBA484GTFEPiOGs0WZgomaIqMcKWsy+KGelONmSkm5TvGOl8bi64tg
	u3xoVX2B5czfNIhnJyoBs2Jl/3Jnn9uI6Oqg/bM23e0LOuT8LY5W2k5SZmRdKtTVLpgXeBqOiy6
	Ioj46KwPSxbrPXy80b0U+voPS1338lH9mPHVXz0+jXaCiHmRPCjyGYMo8M7MgVXsF9aQparLhC+
	j
X-Received: by 2002:a05:651c:41d7:b0:3a1:a8c8:2e21 with SMTP id
 38308e7fff4ca-3a1fd67d0eemr7541131fa.9.1787725662800; Tue, 25 Aug 2026
 23:27:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPyJwA_D9qw0T72f8zwM1yKjP+To=maVANbcdsWM7yRmbBxYvw@mail.gmail.com>
 <CAPyJwA9R=p8_uxyYODb00g_nUq26SRsWHBGgAAJnR0YMTRRo4A@mail.gmail.com>
 <CAPyJwA9P48LDcOr7u_iT1WPFBCHxh9w6cxFvyi5GS3syM6crbQ@mail.gmail.com>
 <07435e6b-ee30-4c85-8c8b-0ce3a4ead1d9@leemhuis.info> <aosGtkE_diwVJJtB@eggarch>
 <20260823174059.46fec036.michal.pecio@gmail.com> <aoser8dLytrwqBC2@eggarch>
 <CAPyJwA8m_Xd2oyV1i9k+-6f7A-j0FiC97yXL=Ci8ZAErs5W4vA@mail.gmail.com>
 <226b2f34-fa25-4ca6-8afb-0b3dc942715c@amd.com> <CAPyJwA9GvqeaBYhN56L1S9YW-rwWgFejrcNcE=54DQC3Eaqxww@mail.gmail.com>
 <f6f2f984-f31b-42c9-b120-6c179803dd2b@amd.com>
In-Reply-To: <f6f2f984-f31b-42c9-b120-6c179803dd2b@amd.com>
From: Mathieu Fluhr <mathieu.fluhr@gmail.com>
Date: Wed, 26 Aug 2026 08:27:30 +0200
X-Gm-Features: AcwNN1XQnKUyXlrnQKHlAQ_Lew01uxWBW7szTdABYW8DO1E4QbjhmLgnHDZw2_0
Message-ID: <CAPyJwA-DqScij982KfUQQ3ad2nHF4=SEBjjQhQGr1yCumdMXHA@mail.gmail.com>
Subject: Re: [REGRESSION] 6.12.36+: usb: hub: post-resume delayed work
 triggers > uncorrected MCE / data fabric sync flood on Threadripper 7970X >
 (bisected to aec11e5f9c45)
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Lovekesh Solanki <lovekeshsolanki00@gmail.com>, Michal Pecio <michal.pecio@gmail.com>, 
	Thorsten Leemhuis <regressions@leemhuis.info>, Mathias Nyman <mathias.nyman@linux.intel.com>, 
	linux-usb@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Forest <forestix@gaga.casa>, Slavik Dev <developer.slavik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> The workaround you can do for now is to disable runtime PM on the XHCI
> controller to avoid triggering it.  But it's a platform issue.

So, long story short, the kernel source code is correct, and the issue come=
s
from the BIOS/AGESA, correct?

> For a proper fix you need to reach out to ASUS to get an AGESA upgrade.
> You can ask them to reach out to AMD if they need assistance/guidance on
> the versions that contain the fix for this.  You can share this thread
> with them for reference.

I will. But this leaves me with a few questions here:
1. Do you already have a fixed AGESA on AMD side, that ASUS could use?
2. Does this issue also affect other threadripper generations, like the 997=
0x?
3. I guess not only ASUS is concerned but Also ASRock and Gigabyte which
also produces TRX50 mainboards, correct?

On Wed, Aug 26, 2026 at 5:14=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 8/25/26 03:57, Mathieu Fluhr wrote:
> >> The behavior that is described here sounds like a platform firmware bu=
g
> >> Are you on the latest BIOS available from your OEM?
> >
> > Ywa, And I even rolled back 2 BIOS before, All 3 are showing the issue.=
..
> > ...even the exact same one (with the exact same CMOS settings) that I
> > used in 2024 without any single issue.
> >
> >> Can you please confirm:
> >> Your CPU model number/codename
> > AMD Ryzen Threadripper 7870X 32.Cores
> >
> > mathieu@ubuntu:~$ cat /proc/cpuinfo
> > processor : 0
> > vendor_id : AuthenticAMD
> > cpu family : 25
> > model : 24
> > model name : AMD Ryzen Threadripper 7970X 32-Cores
> > stepping : 1
> > microcode : 0xa10810c
> > cpu MHz : 2188.582
> > cache size : 1024 KB
> > physical id : 0
> > siblings : 64
> > core id : 0
> > cpu cores : 32
> > apicid : 0
> > initial apicid : 0
> > fpu : yes
> > fpu_exception : yes
> > cpuid level : 16
> > wp : yes
> > flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> > pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
> > pdpe1gb rdtscp lm constant_tsc rep_good amd_lbr_v2 nopl xtopology
> > nonstop_tsc cpuid extd_apicid aperfmperf rapl pni pclmulqdq monitor
> > ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx
> > f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a
> > misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core
> > perfctr_nb bpext perfctr_llc mwaitx cpuid_fault cpb cat_l3 cdp_l3
> > hw_pstate ssbd mba perfmon_v2 ibrs ibpb stibp ibrs_enhanced vmmcall
> > fsgsbase bmi1 avx2 smep bmi2 erms invpcid cqm rdt_a avx512f avx512dq
> > rdseed adx smap avx512ifma clflushopt clwb avx512cd sha_ni avx512bw
> > avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc
> > cqm_mbm_total cqm_mbm_local user_shstk avx512_bf16 clzero irperf
> > xsaveerptr rdpru wbnoinvd amd_ppin cppc arat npt lbrv svm_lock
> > nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter
> > pfthreshold avic vgif x2avic v_spec_ctrl vnmi avx512vbmi umip pku
> > ospke avx512_vbmi2 gfni vaes vpclmulqdq avx512_vnni avx512_bitalg
> > avx512_vpopcntdq la57 rdpid overflow_recov succor smca fsrm flush_l1d
> > debug_swap
> > bugs : sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass srso
> > spectre_v2_user tsa vmscape
> > bogomips : 7988.27
> > TLB size : 3584 4K pages
> > clflush size : 64
> > cache_alignment : 64
> > address sizes : 52 bits physical, 57 bits virtual
> > power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
> > [..]
> >
> > 2. Your OEM (from /sys/class/dmi/id)
> > I am using an ASUS Pro WS TRX50-SAGE WIFI
> >
> > root@ubuntu:/home/mathieu# cat /sys/class/dmi/id/board*
> > Default string
> > Pro WS TRX50-SAGE WIFI
> > 231230340100705
> > ASUSTeK COMPUTER INC.
> > Rev 1.xx
> >
> > 3. OEM BIOS version (from /sys/class/dmi/id)
> > root@ubuntu:/home/mathieu# cat /sys/class/dmi/id/bios*
> > 02/03/2026
> > 13.17
> > American Megatrends Inc.
> > 1317
> >
> > 4. AGESA version (see commit bc91133e260c8113c1119073c03b93c12aa41738 i=
f
> > the OEM didn't tear it out.  Otherwise look in BIOS menus)?
> >
> > The BOIS shoes this information (I also put the ones from previous
> > BIOS I tested):
> > BIOS 1317: ComboSP6PI 1.0.0.1e
> > BIOS 1203: ComboSP6PI 1.0.0.1a Patch A
> > BIOS 0803: StormPeakPI_1.1.0.0g
> >
> This isn't a BIOS regression, it's been around since the beginning on
> this threadripper model but it was harder to trigger.
> The Linux kernel changes in the bisect exposed a platform issue.
>
> The workaround you can do for now is to disable runtime PM on the XHCI
> controller to avoid triggering it.  But it's a platform issue.
>
> For a proper fix you need to reach out to ASUS to get an AGESA upgrade.
> You can ask them to reach out to AMD if they need assistance/guidance on
> the versions that contain the fix for this.  You can share this thread
> with them for reference.
