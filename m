Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302BB3E5A29
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 08:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787648288; cv=pass; b=Nzq/CHtW4FXuUEThrSBr1FtragxK1RYB9sGJ1b80BmtqJ1KZLosIYB6Lhn82XlKDtB0w3FMyBt17KzXlf/IO3ZzVrD3LFZykzOUIn0ouF1yZKn6yiAUI8Cu6WzeU9Tz/zM6a7P3pfdwODRQkh91OZ8EIaWzirJN3X+QaBl15Gng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787648288; c=relaxed/simple;
	bh=hv7psFl3Ws9ReChTvMwa0l+kAvHLDTCuxuec1CNlfM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d5Ad1j9j7SbWHZuiylurBbrktMHOa5kDsjxrlD2xg+ys4ZvGbinD71hAFzyFIkmxUyic2SDt+9ZIPfPND5Jp13lCHhhyLmwGuMmQjWaLIDfl+ZRFOt9TqZ4nkFKuvTE/SOaJzcE9y+v/75QBVxUVUZxTW5GCEnnwh/v8yUlw0vY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7sOk6Nv; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7sOk6Nv"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39fa5e3a428so4505701fa.1
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 01:58:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787648284; cv=none;
        d=google.com; s=arc-20260327;
        b=FR3eII+4uqthy1ZJBmKSviP3VAemqOX8ju53PO6Z7bAc/ANxgOpKTIO21bfAwl0aju
         sI8F6miTNtCfp9yrvK1cBpvtrE6ZYXO6s8DTsOwuiFUrpp9UHNauvAlZCTeXU+Uv5v4H
         RlHzoHLOMdy5yzw9av+hnYpxtBNOw8c8SJpTDRuOzc6IXz3ONVISDycQtPvAgvweeDMo
         G3eVqHFwpTNBZWzAB3F+W2IjiYAA5YqybVpM7UNvwataQUGFBQuQ95BtvrVI0pnIZJNI
         iw3LE0iDFmMTD3zz2TBVFQciDGR/Ma4TCQbgNkaCxmcNe1+ZvRo7fl2zF/Wi8NnuZkOq
         uc8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5ezw+lHG90KyeeujMITgw3JFtWqOY7cmyGIM6ONzm1c=;
        fh=cet4sjKLFyZcNeKnAvGNCvpiSTtL3eggGSHHFcaVqRE=;
        b=GEUgiBsntKXxbazmL2EZDu6tuMMMKnkpyjw4eGU8jfJ4RJ940CfIPLzO32/tBIx5Nl
         OHDQppdEDYVnA71jZHIL214HHejC9My/GeYs6y9zGSNCpjAr/VB6oVPs81hjGLpVk/+x
         9UV2RTmVP7pQAs/t4xR4Lxgi8VC7vugIuRP2VrN832HFZ2IVdGJFPhRW66GH4SptUeW9
         8UdX9YYBjDr4QtaqSIEAAukyt9dpSUq+G3BT8bVJ18w3FCc7o+ZuatNPkmjODR8mx/f6
         VorM4/FSOz/UmKIOEGOFnf3vmMH0B1ziAvIAywu+KzK+7KfaPAvouQd/zRi1SZTJzikN
         px6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787648284; x=1788253084; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5ezw+lHG90KyeeujMITgw3JFtWqOY7cmyGIM6ONzm1c=;
        b=Y7sOk6Nv8fIOfg6wic3A4ZRsv32+C4wbxkO4Tym5+kUVrfw0wHxBSGudIiAF0lG6xQ
         rUMduuLjyzlm2A4iJbzOUBsHSsWQYkNqL6M/MYkzVMM9CWfdc8Rr6ePyxrxlNVJw0IOV
         y+AvAke4Nt3VyJvLJlYVTX9/xIbezq4jbHPx3dT6isxPkaYm/gaXkZUTI6+tNCEyisGA
         FCMi33wgt3wxO9SitmcgJZaf8ml4e0Vr5E8IGnnMHtJ/HTuoJ4tzBaEbfuofd/ymMYkR
         ocZtN8/oD3hhB9U/yh/oR5p8+IKZnmCPFT/9fyahpuIHR0rBUkorzRu0Z8v2EXrQdIHz
         5RzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787648284; x=1788253084;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5ezw+lHG90KyeeujMITgw3JFtWqOY7cmyGIM6ONzm1c=;
        b=QL+zfeYl0yWsAtd9sXEQRICpMr5Ucbe5HJ+kvlUaKcQ3Qfak0ONJXTfocxN1gmFzRO
         SXkw+t4t6dM9wBYo9/KCZb1Njd0WfKgyk+wQ/VoRbjCYJXu2LbZhIxCGF6/AU8wyPtwa
         OAx9+WFRDiErg084piDKeAg0bToSDD45pXZd5ouxoMrg57pJRcumkzopwEckvoDExCnf
         rczDFOTK9mxoQgKyNVA7cArCLrxRYiasPEOCQ1NQzfP5fhoNzG/QyBt9G432XWwXcgXf
         c2IA79FgR0uBHdBA56cP/d+ps3XH6u4MOykkRz9mg9FSRG6hMZqzhzqIRMBWgmujfHzn
         02Iw==
X-Forwarded-Encrypted: i=1; AHgh+RqW03bopd8J5VYdZqw1lpWubcdC+gXW2T/NmB2POtGAgFjULlMhjBtmv51/i6IXidZMoWoHKoQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lgMR6c9qxZqnPlCDnaUL51Y+HXfFZXH59NgxyltbkJu5VEiCfJ
	ng40I2uAoWEWJyub2kYv0yWc8bW4lLfozu8oWJLt88UinPjsTkLWRoK71e2ZcZ9reQoIuWNFJWi
	4OsKWHup96hZ9Vfg71Wx6Q/HFcRTG9Ck=
X-Gm-Gg: AR+sD13BSxDeS13VNEGgCkOhlqn+Zj3rCl2VkxxBdtllXxexNcG3rc6HZGqg2rgJlX6
	eCZ6dQC1bZUxN6uxjK9m7Umepddni7DHAbt/Hn6Q1W9h4/zL5pgeHKHKMgpQa9M2B7fsAmIGRfH
	T60nYogj1/JzqJNs9guQ9dpR1l2LHsPJZm8VMn3J76PL5b4adICGzyuc+LSNiXLw5+78aNXSWNU
	yCaKIXwYLnaoPrCvFNf1AjEiOCA9eddA85/BnlT/ewOrH43cHSAE/IbJQCKNJoonCednsZfWfz1
	38M8twowIyXgfNYnbYnAIVpgDgknJ7HZS/Sv9gmEj1Sxzs52JRvt6Mr9LvbP0OU1bt/XTV7culD
	1qA==
X-Received: by 2002:a05:651c:a338:b0:3a1:7927:c302 with SMTP id
 38308e7fff4ca-3a1eda808acmr10530241fa.2.1787648283761; Tue, 25 Aug 2026
 01:58:03 -0700 (PDT)
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
 <CAPyJwA8m_Xd2oyV1i9k+-6f7A-j0FiC97yXL=Ci8ZAErs5W4vA@mail.gmail.com> <226b2f34-fa25-4ca6-8afb-0b3dc942715c@amd.com>
In-Reply-To: <226b2f34-fa25-4ca6-8afb-0b3dc942715c@amd.com>
From: Mathieu Fluhr <mathieu.fluhr@gmail.com>
Date: Tue, 25 Aug 2026 10:57:52 +0200
X-Gm-Features: AcwNN1VgQYuPNfWZAsoIgdXuYlvjSNx0u-75mKCYFe6GTjYsbwfcHq3iOmLOPQM
Message-ID: <CAPyJwA9GvqeaBYhN56L1S9YW-rwWgFejrcNcE=54DQC3Eaqxww@mail.gmail.com>
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

> The behavior that is described here sounds like a platform firmware bug
> Are you on the latest BIOS available from your OEM?

Ywa, And I even rolled back 2 BIOS before, All 3 are showing the issue...
...even the exact same one (with the exact same CMOS settings) that I
used in 2024 without any single issue.

> Can you please confirm:
> Your CPU model number/codename
AMD Ryzen Threadripper 7870X 32.Cores

mathieu@ubuntu:~$ cat /proc/cpuinfo
processor : 0
vendor_id : AuthenticAMD
cpu family : 25
model : 24
model name : AMD Ryzen Threadripper 7970X 32-Cores
stepping : 1
microcode : 0xa10810c
cpu MHz : 2188.582
cache size : 1024 KB
physical id : 0
siblings : 64
core id : 0
cpu cores : 32
apicid : 0
initial apicid : 0
fpu : yes
fpu_exception : yes
cpuid level : 16
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
pdpe1gb rdtscp lm constant_tsc rep_good amd_lbr_v2 nopl xtopology
nonstop_tsc cpuid extd_apicid aperfmperf rapl pni pclmulqdq monitor
ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx
f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a
misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core
perfctr_nb bpext perfctr_llc mwaitx cpuid_fault cpb cat_l3 cdp_l3
hw_pstate ssbd mba perfmon_v2 ibrs ibpb stibp ibrs_enhanced vmmcall
fsgsbase bmi1 avx2 smep bmi2 erms invpcid cqm rdt_a avx512f avx512dq
rdseed adx smap avx512ifma clflushopt clwb avx512cd sha_ni avx512bw
avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc
cqm_mbm_total cqm_mbm_local user_shstk avx512_bf16 clzero irperf
xsaveerptr rdpru wbnoinvd amd_ppin cppc arat npt lbrv svm_lock
nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter
pfthreshold avic vgif x2avic v_spec_ctrl vnmi avx512vbmi umip pku
ospke avx512_vbmi2 gfni vaes vpclmulqdq avx512_vnni avx512_bitalg
avx512_vpopcntdq la57 rdpid overflow_recov succor smca fsrm flush_l1d
debug_swap
bugs : sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass srso
spectre_v2_user tsa vmscape
bogomips : 7988.27
TLB size : 3584 4K pages
clflush size : 64
cache_alignment : 64
address sizes : 52 bits physical, 57 bits virtual
power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
[..]

2. Your OEM (from /sys/class/dmi/id)
I am using an ASUS Pro WS TRX50-SAGE WIFI

root@ubuntu:/home/mathieu# cat /sys/class/dmi/id/board*
Default string
Pro WS TRX50-SAGE WIFI
231230340100705
ASUSTeK COMPUTER INC.
Rev 1.xx

3. OEM BIOS version (from /sys/class/dmi/id)
root@ubuntu:/home/mathieu# cat /sys/class/dmi/id/bios*
02/03/2026
13.17
American Megatrends Inc.
1317

4. AGESA version (see commit bc91133e260c8113c1119073c03b93c12aa41738 if
the OEM didn't tear it out.  Otherwise look in BIOS menus)?

The BOIS shoes this information (I also put the ones from previous
BIOS I tested):
BIOS 1317: ComboSP6PI 1.0.0.1e
BIOS 1203: ComboSP6PI 1.0.0.1a Patch A
BIOS 0803: StormPeakPI_1.1.0.0g

On Tue, Aug 25, 2026 at 12:09=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 8/24/26 14:37, Mathieu Fluhr wrote:
> >> The issue is obviously a severe HW malfunction (you mentioned MCEs, th=
e
> >> Ryzen CPUs simply totally locked up), triggered by poking certain xHCI
> >> controllers on the I/O die of these CPUs in some wrong way.
> >
> > Yes. As mentioned, I first thought that the emulator itself triggered t=
hat by
> > doing something that the CPU did not like.To be honest, I barely play w=
ith old
> > Android versions anymore, but seeing that I could reproduce it even wit=
h
> > Android 13 or 14 made me suspicious.
> >
> > I _guess_ Google implemented a workaround inside adb for version Androi=
d
> > 15 since using this version, it remains stable for more than 2 hours.
> >
> > But, in the end, the situation is that from a simple user account havin=
g access
> > to some usb plugged in devices (I usually add my user account to the pl=
ugdev
> > group and use some known udev rules to access my Android tests devices)=
,
> > you have a way to crash the complete system.
> >
> >> Opinions seem to vary on whether CPU load must be present or absent.
> >
> > On my side (and I am here only speaking about my TR. I don't know about
> > other Ryzen CPUs), I can't reproduce it under load, and one condition t=
o
> > reproduce it is my CPU going in C2 state.
> > -> I did a 2:30 hour test using several youtube videos playing at the s=
ame
> > time on my desktop, also stressing the emulator with some 3D Mark runs
> > (as mentioned, I first suspected the nvidia driver to be faulty). As lo=
ng as my
> > computer was busy everything went fine. But then I let it stand still f=
or a few
> > minutes, and it just crashed.
> >
> > If you need me to do some further tests or experiments, let me know. I =
will
> > be more than happy to play the guinea pig here.
> >
> The behavior that is described here sounds like a platform firmware bug
> to me.  Are you on the latest BIOS available from your OEM?
>
> Can you please confirm:
>
> 1. Your CPU model number/codename
> 2. Your OEM (from /sys/class/dmi/id)
> 3. OEM BIOS version (from /sys/class/dmi/id)
> 4. AGESA version (see commit bc91133e260c8113c1119073c03b93c12aa41738 if
> the OEM didn't tear it out.  Otherwise look in BIOS menus)?
>
