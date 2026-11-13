Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794598303;
	b=UdsbRsyJuQjEbOU+es/ZjRADZx+BwuBWwZ+D9IXGBayyDHYF6dUBS6kbPUEtTgu1dtN8
	 Z6sjrxG1J9p4zE8h4XfnXlHrk7ywKfmaJVTc2AJ1lFmmhD5l+MTrQwK+/sVdC53XWNq/j
	 PASwoW2mOzHjE0jxBKvFdMul2B8NDXNy6ItihB1u4LiaDrunOtutiTqnBQbb2Iy9DspdE
	 vQwnHJW5NnaxLp4iwm72BHklsKsKFDQ6rlFeeeQMtdZepL6eGEGHnQywz8DEHOxQTTGJy
	 dE37zio1QUSc6CI1p4c4UhpAKvohLJsmgbD3r5U0PU6IxEffic/3MX0yoe2vUesw04g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=pw/GtRqnRmkmoV0EVd3bZWIv5BPfPAggSs7FVXENh7M=;
	b=S3j9NlYLsSkF81DsnPA43NPpPdvFlmsYm/kxJSxOANLd8H/pitDD2oy6KyCpfJjAzREj
	 69gNH2lioPxuk+dh/cnzfy3gZH/JU2nrZte0nQ19CLNnBcFlNzinceytK96qnrWakkeCZ
	 LD3a+FElHpyHFxJHmMn/w3O19AvZqwZq73Xo5cQaHWRVqtB81ZnmS2WkA73f53WBtLyHX
	 wexpIwT6y/vTTGfURurrLoBz+AKKTPyYxpp/1dngsaeJz0JJI2OeB1gjgLoWnCWK91I73
	 rnI+4Rmg0aAg5CcYqJzVoIujDcGik+EGfccccWlrQARca1jApDEb1vVCyvfbKoCUHOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i96HhJqv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267C4606A327
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 267C4606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i96HhJqv
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b309147589so13293027b3.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 11:31:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794598302; cv=none;
        d=google.com; s=arc-20260327;
        b=kbXoQXw8xFaIDFoC3EqXnT6Iu63qMFF0NygY/4kcHu9QCVCphTqZ1vy4GSepLqwWn0
         zLPTu0gtvjvmeKxjR+IjyMLdWBZleOw41XLWaExHtQgDXhtpAA97E6F9KCKzMHYaVys7
         UjG1RJMA/wq6mdc+g0+yYws7mFXTf3Wau9IrZ/KvFCTGfM+OvYR00CEkk/Y/G8VUCNOU
         DKq1STX3DslpVk+3chVS29PE/BZvt44wZDKeanGm6SQ1OieDLuB7O3HMJUyTzYRChCTV
         7L/x6ZJ9bGrBh8eCCNaZCgGVAErVvsMLEDhk6HPO1zmdZHx9XH3I92EYPSXw/AHWOf28
         aqAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pw/GtRqnRmkmoV0EVd3bZWIv5BPfPAggSs7FVXENh7M=;
        fh=qkML40X+/MY637tSQB5usiHJzhAMoCLL8sS/RjKhb7Q=;
        b=Ch6mqbuCyJF9G8zDTRr51ZcwY7ghp2s+7rtWgToNstuoeCJj1l9BUcuohx9+mxzW4n
         h876+p08w7facXwCOaVkfvuguovxyZ+19TqVceSfZp5n2TaIB/MjVkX4fauoc7mrYWwS
         FVejb7qoEiQkzxL8rW9gz56aVSuZZNsyasgzzdck0F7DLRFxf3+ZGgIpu95fHztD5q6S
         67a6P+4O63yiJRnIdEDiv+aXT6Qq2Fxaax2xYaE0dqSYJqRMOr1pPlX4TAvEeXErLiLa
         2Ku6lzRhSyFkTOj0oaPTomrZcZFL9WNGpbUn5GXvFvXKm+qqms3sBLAdgIlOlUhJziX8
         v9VA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794598302; x=1795203102; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pw/GtRqnRmkmoV0EVd3bZWIv5BPfPAggSs7FVXENh7M=;
        b=i96HhJqvWrTkfloIwP00dkvZjwmY9I0ZZlc18pqW4XTYz/FL1eSvhFHrDERrtxKx7T
         Pk92K6uR2BRK+HurO3NJ7E7da4ordorE0kumjyEgsY50RREZTrepkmdspMqGqL3j8y5F
         xKUalHrwFszgeFazkrZU4nj4HPbJ6b92FO4Slde25lIRsMSbtkHVzMTiz80CTL9+1rhJ
         FBrb0gnZDTApJzlGKfYxOKV+pEmtOHF4d8/HgW1NcDaip119+FvQX2wxxIBQ7TaUtGkp
         XIJ9X0IfWJWqRH6JDUvVqqZXIhC6DVavhXXLV7xle0OuWoMpEy7a4wrtuFRqf81pCx4n
         Jfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794598302; x=1795203102;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pw/GtRqnRmkmoV0EVd3bZWIv5BPfPAggSs7FVXENh7M=;
        b=EqZzEOy/vd0KNPqFIzcNSXfaxmjwYX9MX7aKlQbEacU1bemjVXb6uGGaHHkab/NAx2
         UC7XR+J4NQvPepBEpu2ZyDL1Nvc4Z8yXEbKTnY93wUibL3C7nwYVXYYh/wUR4y0j4y+C
         cUrZjG6tCV7F1xnbmG2IrIpSagco1DjYiyhT9TUXbopGi8tcUix+U9iU/T5GQQDjrIY1
         faR0wVUZFHABD2sFNATDn2FklQbEq5jZt4tibBeXL6O5zc//4klJ97MWr9KQybNiw8NT
         cuPWLp0mlNcYbrFhYNpsGJ2dVRVyM9wq6QzoMN4DrgOwMIVzOKe7nfidT6IDJcB4GNxJ
         nRWg==
X-Forwarded-Encrypted: i=1; AL+hErEYbM6U/acfYOAi/bfzyLFL5FN4m0Hw9gJsB/2VWA1vhYMKuEi1zpl1nFP+2pyIkihXwVW6VkI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/RkoO8ej1+cmJhu+nLNa52RWnbwYG2tw9f9SoaN3/Tey1F3NuC
	MjHeSkYCtHl+V6xq48hqdbdDPAJCyVyV3EsOykG9hCSHRcZQgtnY9eAlEmDCZWaTEEAT5zDFgpy
	rYM84TOfGqXLoA/zl0bbzTarqDEoWUJM=
X-Gm-Gg: AYBFou2ZElR63nCTRidQeAPRooJFnuISxWXN7VqLsIBMDDbRUwND538Va+iFF+LAlAF
	TnFOBgPujVeuQbNVsecs84Izz1IDzRSUi+fXXER0LkNslnlpfoQn94JSBCAJtECIieDOeIvKLgJ
	5eSuCHzHOxx/sm002kxMurYhV5+ZQLYOnmcZODB46C3z304TqoMx5ZbrZOWUIrTFMbqDGqOXF6e
	Cpak4tMLB+sosD99wqXEsNt1VD55Y05xXW+TW8uRUQ0+tHrGqzpLJn/fM1Ax/BaqHTeWX736Rqx
	z46tTxy3xxmoq4b1SgAtdS2E/KLL8+fAjwhLRfxfnjGRipJWvqNlDobzlYvr0f2ySm3p/sdxAfX
	Xlp/xa7xWqDjsDXF09JufWGHL93LM74oJDoMz/zrlUJEZ0T9KkB/Mcs5bOOH7svkpuyB4x+sIJv
	jvOZt4j7IThfy/c8ZLmITn4yiEizfHNEFG6ZCpa4pU5Xm3+VYkAQyp1/uZpzHKnZfVPZdccaA4O
	fjjEj2W
X-Received: by 2002:a05:690e:1384:b0:677:d804:94b4 with SMTP id
 956f58d0204a3-67d896dbe48mr2401686d50.65.1794598302165; Fri, 13 Nov 2026
 11:31:42 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112233807.70664-1-sidchintamaneni@gmail.com> <avdXkLKJwuNv0vZ4@kernel.org>
In-Reply-To: <avdXkLKJwuNv0vZ4@kernel.org>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Fri, 13 Nov 2026 11:31:31 -0800
X-Gm-Features: AclHuK8cZbEkeSRDtbCQkhfrXJYZHXhWNH4fr0GNR6OJpPd_lgMe_pOQXSkn9K4
Message-ID: <CAE5sdEgEFjGz6W0e5g4uxRVC2Otyvr4Pak-aAZogObWaFtNsTA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] tpm: tpm_crb_ffa: Only register driver when ACPI
 TPM2 uses FF-A
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>, 
	Stuart Yoder <stuart.yoder@arm.com>, apais@microsoft.com, rlmenge@gmail.com, 
	hargar@linux.microsoft.com, linux-integrity@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Nov 2026 at 10:31, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Thu, Nov 12, 2026 at 11:38:07PM +0000, Siddharth Chintamaneni wrote:
> > Prior to commit 677042afb97a ("tpm: tpm_crb_ffa: revert defered_probed
> > when tpm_crb_ffa is built-in"), built-in tpm_crb_ffa only registered
> > tpm_crb_ffa_driver from tpm_crb_ffa_init() after crb_acpi_probe()
> > confirmed start_method == ACPI_TPM2_CRB_WITH_ARM_FFA. After that
> > commit, tpm_crb_ffa unconditionally registers on the FF-A bus at
> > device_initcall time (and when loaded as a module) without checking
> > the platform's ACPI TPM2 table.
> >
> > A platform's firmware may expose a TPM CRB over FF-A Secure Partition
> > for UEFI boot services while advertising a non-FF-A start method to
> > the OS in the ACPI TPM2 table. When the ACPI TPM2 table designates a
> > non-FF-A start method, Linux has no consumer for tpm_crb_ffa and
> > should not probe the FF-A TPM service.
> >
> > On Microsoft Cobalt 200 systems, the ACPI TPM2 table does not use
> > ACPI_TPM2_CRB_WITH_ARM_FFA, yet ffa_init() discovers the FF-A TPM
> > partition and tpm_crb_ffa_probe() unconditionally sends
> > CRB_FFA_GET_INTERFACE_VERSION via FFA_MSG_SEND_DIRECT_REQ2/REQ SMC.
> > That request wedges the calling CPU in Secure World (with Non-Secure
> > interrupts and GICv3 pseudo-NMIs masked), hanging boot with an RCU CPU
> > stall:
> >
> >   [    5.507519] ARM FF-A: Driver version 1.2
> >   [    5.507519] ARM FF-A: Firmware version 1.2 found
> >   [    5.507551] ARM FF-A: Notification setup failed -61, not enabled
> >   [    7.150580] Freeing initrd memory: 293640K
> >   [   65.515248] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> >   [   65.521346] rcu:     10-...0: (3 GPs behind) idle=dd9c/1/0x4000000000000000 softirq=37/37 fqs=5262
> >   [   65.530031] rcu:              hardirqs   softirqs   csw/system
> >   [   65.535589] rcu:      number:        0          0            0
> >   [   65.541146] rcu:     cputime:        0          0            0   ==> 30028(ms)
> >   [   65.548102] rcu:     (detected by 66, t=15010 jiffies, g=-951, q=1384 ncpus=132)
> >   [   65.555228] Sending NMI from CPU 66 to CPUs 10:
> >   [   75.560686] After 10 seconds, these CPUS still haven't responded to the NMI: 10
> >
> > Check the ACPI TPM2 table in tpm_crb_ffa_driver_init() and return
> > -ENODEV before calling ffa_register() unless the table is present and
> > specifies ACPI_TPM2_CRB_WITH_ARM_FFA, matching the check_acpi_tpm2()
> > pattern in tpm_tis.c. This ensures Linux only issues FF-A TPM requests
> >
> > when ACPI advertises the FF-A start method (for both built-in and
> > modular builds), while preserving normal FF-A bus probing on platforms
> > that use CRB over FF-A.
> >
> > Fixes: 677042afb97a ("tpm: tpm_crb_ffa: revert defered_probed when tpm_crb_ffa is built-in")
> > Fixes: eb93f0734ef1 ("tpm_crb: ffa_tpm: Implement driver compliant to CRB over FF-A")
>
> Pick the older.
>
> I attached a prepending patch that caches the start method, which can be
> later used in tpm_tis and tpm_crb.
>
> So that totals four patches:
>
> 1. My patch.
> 2. Your fix using the cached value.
> 3. tpm_tis update to use the cached value.
> 4. tpm_crb update to use the cached value.
>

Sounds good! I can put together that 4 patch v2 series.

Two quick notes before I spin v2

- Module loading with CONFIG_TCG_CRB=m and CONFIG_TCG_ARM_CRB_FFA=m:
  As Sashiko flagged on v1 [1], because tpm_crb.ko directly references
  tpm_crb_ffa_init() and tpm_crb_ffa_start(), returning -ENODEV from
  tpm_crb_ffa's module_init would prevent modprobe from loading
  tpm_crb.ko on non-FF-A systems. In v2, I will move the start_method
  check into tpm_crb_ffa_probe() (matching check_acpi_tpm2() in tpm_tis)
  so both modules load cleanly while still skipping the FF-A probe on
  non-FF-A platforms

- regarding the location of caching approach -
  tpm_crb_ffa never allocates a struct tpm_chip, and both tpm_tis
  (check_acpi_tpm2()) and tpm_crb (crb_acpi_probe()) check start_method
  before calling tpmm_chip_alloc().  Would it work for you if patch 1
  caches start_method once in tpm_init() (subsys_initcall in
  tpm-interface.c) and exports a small helper (e.g.
  tpm_acpi_start_method()) so tpm_crb_ffa_probe(), tpm_tis, and tpm_crb
  can all query it before chip allocation? (Also noticed a small '||' ->
  '&&' typo on the header.length check in the attached patch.)


[1] https://sashiko.dev/#/patchset/20261112233807.70664-1-sidchintamaneni%40gmail.com

> Fast-forward when these are in the mainline, I can send my change with
> Stable-dep-of tag to stable@vger.kernel.org.
>
> Br, Jarkko
