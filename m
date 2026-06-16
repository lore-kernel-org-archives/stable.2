Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79A73D88F0
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 18:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781633577; cv=none; b=Yz1wE8C7rlKEzGNSwU9VhODSe8s87pTWKj3g1Le7KZnDgYf9g2+DVgptbnWEpnTrVRJzs51q5EalnuKP/F07k4QDHZGL6lX38a2yYG/8232dP1foLpSDdO2/c72yw4Mq2gOfcLV60IkHU3w3zbq1jPyh+yVAOyVCHH+GFtgpjcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781633577; c=relaxed/simple;
	bh=p3rzxF0uYdPZbVvU5s/vULcaTm/bIqRnUxzNNp5+2go=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=q0iy7WD8GraeTESqMSj30NbA7IWST5YmfEMh3Wd5L2Czzz5H4f66OVgQTxdRiUoYX4tlRybdQrHW5HuRCQ0czIIOVLP5yQNeXXwciIsxMzsB28FhBUKwFX4pk3kugd/HOyvbkO3ZjTuFbccF8m+QtMccSoY7kHsTAY+GGJyCRwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oWvIo0Hc; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWvIo0Hc"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36b8e1760ccso3053855a91.0
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 11:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781633575; x=1782238375; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HfqVrP82kq5rv5P4+q1AH7lRylWPBjjSEnRhd+rTAto=;
        b=oWvIo0HczpqhcQaIJUeyQ5YKFBZ0ntaT/nGq75FMDOEPHanmcZabzMj75zw5KVioSV
         gp/PQruedkWSVm1/XIfQZiau0IkBYNh+BepiRVpFymMJI8vPXqyjtVCYVu/r6aylIu3R
         hK9cFnC0lpkXkXd/UOrRw4HYDPTX7mZtyHJQvAdvm53fXCdwV5GoMmetlb1vFzaET8BS
         zQ0BXhk7OTxTqdaEDvgzxysRyLF4Z0ByXVcD7PtQC/mYwCj21591NOV85GdNB2YzVA3f
         VAyYquHh0pMCUfKPWPOYCs4Fd8rFncy+zbjMaKH+kvHPaVFZZzG5MvZ5UJOh2ltWUf2w
         svEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781633575; x=1782238375;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HfqVrP82kq5rv5P4+q1AH7lRylWPBjjSEnRhd+rTAto=;
        b=O661NizeeYZTmE+0UJLhmCdZwZWbf3MYS/09xrgVJjbAuD9JVoYsPU34FOngteEWsi
         k/U+I92m3H6btmYFh5q3ouXQqtFFT8wUTvoPFwDXl6nWLR1bIw19iv7Iqhjeit1HdzZj
         HcTZbBdsbr1P1R7DBA6qsWCEVphlUFyI6qeODk65F6MCezbTsMHfjeRFYTc3qpDf74ou
         UxCc+HtsP6fwQ+J2ZjSWG8iZYFwCe7nvjD1/7WJF/E66yzMjazx/68O7yN93LHFTVOFj
         eFxWQMdaa3sIhAuryQxKgaRqlhKOWNHlT1cgTGwlNMzgD6dMQZ13MuUNvgUtShWD5LXJ
         /Y5g==
X-Forwarded-Encrypted: i=1; AFNElJ+HGU6vhec6AOR22XwO80HLDiePyAvvHUlmkh/maFCneyEb7OhVLd/6U1z++lWNHbdmZe49lK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVkd0/p4wyFPm7rtfQOQ1eB2jn5fs7EnwmpBSd9KLR+jYRNUUR
	v21sOxiW8uFLyGmUa1rla+T9qgSVWBJGSr3EJOeHLWpcRoU5ZEVaHkX3kDUyeg==
X-Gm-Gg: Acq92OFwDED6XgDE51Haob0+GVMZQCrctPvlivz5XpVpH7PcBRybM2Y/UFLtcPBY3Kw
	+fXjG+6DCAmsqdzXwBM8Ie4CIMJJLZEbfAXIBgC9WayJ5jTrkJvdgZVVoRT5cY5g1ZPfuxc0xig
	8mdtqRqPJoYrclWCrZ4l7ayHre7aQJRzVmn1Rrlxm1bej/VUkHxtd2cCfUPgCeyB/O2dYsPuiFu
	zQXNdNXdkSKrhVaTefN/B+YasXMbUdOkhjLPtFepXLkliostkHM+ka2HR5oK2lDUkw8gTEypoDL
	w849Rtwr/6BkZx0nP3omiyYQungEgl7bHj4jxi0w5LKpNxETh8FYVWTaAcKXe4OYoGRdFmAp757
	sb4FGtFw24zJOKpr9ka6f/WepnhT1/zHXwVE+Qqk4JVV6h0vCWg1IWBYUDVqYuZO0iamgwrh5IH
	Mw7dy1UqyO7NMl81zGLeiFSmej4w==
X-Received: by 2002:a17:90b:390f:b0:375:2a38:1d40 with SMTP id 98e67ed59e1d1-37c9369f042mr546951a91.20.1781633575059;
        Tue, 16 Jun 2026 11:12:55 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c5228eb5bsm3519929a91.12.2026.06.16.11.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 11:12:54 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>, Mukesh Kumar Chaurasiya <mkchauras@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] KVM: PPC: Book3S HV: Validate arch_compat against host compatibility mode
In-Reply-To: <20260616163405.96962-1-amachhiw@linux.ibm.com>
Date: Tue, 16 Jun 2026 23:37:53 +0530
Message-ID: <7bnye4ue.ritesh.list@gmail.com>
References: <20260616163405.96962-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> On IBM POWER systems, newer processor generations can operate in
> compatibility modes corresponding to earlier generations. This becomes
> relevant for nested virtualization, where nested KVM guests may need to
> run with a specific processor compatibility level.
>
> Currently, when running a nested KVM guest (L2) inside a Power11 pSeries
> logical partition (L1) booted in Power10 compatibility mode, the guest
> fails to boot while setting 'arch_compat'. This happens because the CPU
> class is derived from the hardware PVR (via mfspr()), which reflects the
> physical processor generation (Power11), rather than the effective
> compatibility mode (Power10).
>
> As a result, userspace may request a Power11 arch_compat for the L2
> guest. However, the L1 partition, running in Power10 compatibility, has
> only negotiated support up to Power10 with the Power Hypervisor (L0).
> When H_GUEST_SET_STATE is invoked with a Power11 Logical PVR, the
> hypervisor rejects the request, leading to a late guest boot failure:
>
>   KVM-NESTEDv2: couldn't set guest wide elements
>   [..KVM reg dump..]
>
> This situation should be detected earlier and rejected by KVM. Without
> proper validation, if userspace ignores the error, the guest may continue
> to boot in Power11 raw mode on a Power10 compatibility host, which should
> not be allowed.
>
> Introduce a validation mechanism that detects unsupported arch_compat
> values early in the guest initialization path. When an unsupported
> arch_compat is requested (e.g., Power11 on a Power10 compatibility mode
> host), kvmppc_set_arch_compat() uses cpu_has_feature(CPU_FTR_P11_PVR) to
> detect the mismatch and sets arch_compat to PVR_ARCH_INVALID (0xffffffff).
> This sentinel value is architecturally safe: PAPR specifies that valid
> logical PVR values must have 0x0f as the first byte, ensuring 0xffffffff
> lies permanently outside the specification-defined range. Setting this
> value triggers kvmppc_sanity_check() to mark the vCPU as invalid by
> setting vcpu->arch.sane to false. On the next vCPU run, kvmppc_vcpu_run_hv()
> checks this flag and returns -EINVAL, preventing the guest from running
> with an invalid processor compatibility configuration.
>
> With this, when a Power11 arch_compat is requested on a Power10
> compatibility mode host, the guest fails early during boot with:
>
>   error: kvm run failed Invalid argument
>
> This provides a much clearer failure mode compared to the previous
> behavior where the guest could boot in Power11 raw mode (if userspace
> ignored the error) or fail late during H_GUEST_SET_STATE.
>
> Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Reviewed-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> Acked-by: Gautam Menghani <gautam@linux.ibm.com>
> Cc: stable@vger.kernel.org # v6.13+
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
> Testing: Both Anushree and I have tested the below scenarios:
> 1. P11 guest on P11 host - Works
> 2. P10 compat guest on P11 host - Works
> 3. P11 guest on compat-P10 host - Correctly fails with "Invalid argument"
> 4. P10 guest on compat-P10 host - Works
>

Thanks for incorporating all the changes and adding the test result
matrix in the changelog.

The changes looks good, feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

