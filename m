Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BCD3AA9C4
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 09:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781603987; cv=none; b=o7W3TF/NQLRt1Zm2ql33zj3vFSVcLmp7iLINrPFlb61v/dX26CKh6c3eO+2FREuG/rYJbJvTK/XMPBpg38SnFrWrwYDtXVEiYQwFpxSAHo3oss9opQRiQMJ4/4AuH4HJ3c8xk08T0FgcoLXS7VSyKLCIsJ/Hz7N3+h+J39G7mIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781603987; c=relaxed/simple;
	bh=MQuDNs9DOFDasrbFxL0RULlj/5TRohoyZCluNgEoq8I=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=E+HoChgPyqYYuP762yanZeaFOHpks3JPdF/q+o8z5qMlsSyLdh2mzkxb4dc6BFbSlqhH21saM0Iru0AZd87MUlNbP5AgCgUihmeKHUd0jc5KkOUQAdZxIYKTK3TPBg8d6QkegX8TG7bJPpJjox114iIKHBRCEulKRWqS1yLFA1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToII2jQH; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToII2jQH"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c132ac5ec2so43144705ad.1
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 02:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781603985; x=1782208785; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HbaHTZBnCq318ZtN8K7oKcSJ6YlokHTKs6GlCUe8GzU=;
        b=ToII2jQH/n0Q+TKw1h7yoObpdUyHuoWVNb9URh+a/ji2DjtpgLSTMphggkhvoeKz7g
         iVoCklWweB1KiJOv9sqgIh2gS/b8Atq38pSmwgCWymI1AFfbduu9uQg8Y7oIRVKH8jGU
         c8xpO7xsUQ+zuT4WHcWcWHmF5UGg/2MrlQckAnjjxwcAN86wgnyN/44+3j+nKA+YHu3I
         0cPwlh1C81cTjnZITu7/RNEq+pBV2KbteMfZJovW/xKDYhECaxB7NBlZn7zZ2lynJKQ/
         wiwgQpBYxyDiJyOhqRMCAcrWOPKxaD3VKs47R7BCfsyIIrnpsJaePT9mDe9nDi6CK201
         0DxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781603985; x=1782208785;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HbaHTZBnCq318ZtN8K7oKcSJ6YlokHTKs6GlCUe8GzU=;
        b=nTYSOTeLAK0MPsANS7DwZ3DTYp2UlbRb5uaNX+wQJ+HEAhPx5sLkOmhkLd5GDfhCcg
         DgV3/wqmtWR7kKeIq6XsXcxXtBgKdwbYMbk6tdTaYsXUmSCAMG+Hm/+/9BRGvVf3Y9p9
         vGCoFUync1dbR5s/QQ2jA2VUGlXaWjgKEXCgYB4G5h/Hu/7cpirI8X6KUPIJfYZYjxwd
         W24i2Uwnci8FhMdlVpewCuC7AEcsF0BgHsrd0fX1KPjRZWSBK9CfGxTxctquxkh//d0y
         JD/TTamQpw2Kj8GM28J9KDjNc5t7J2IktOXj3I/7YAMJIizY30x+lq622MvLdo+cFcSd
         WrFg==
X-Forwarded-Encrypted: i=1; AFNElJ+E5VeP0Uq/3OcWgADgGNObfRgDRw+vTwfzNhz0n+M6/faGFBk7O+AX1BCKHOx7OUbzLF6furk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhY35k43BtVv/MxPM23GohkA+5qxGhqhP+EZELVCSdvbfVPux4
	p5qnQ65cPKGlfPwaSXuELNqotEWkYaPHSfmLP8H0lrYl4gxdK/tQ+bQ3
X-Gm-Gg: Acq92OEJaISaYEB9Hh4oiU2njyGnCl6ZHdaEqX5D4ddVFHGKnxBJboUbgE3anpIgBEZ
	oTtDB7xMIhzL8SvtPIpDAG9HfkTDwZyhADUVJk3jMOkBDOMu3EjtXK5aCSi+rr57nDwWYehxBm/
	DytX62TUR9mwSKxk5zOfuUWLPADFJc5MeG7UX07BvuTVGeAIM3nYST0bezddjf4j/m0uu09gt+Z
	1yyCKPlfiJs81ZFA7sMHEyJVdHHTDFagu91qQLNoI1RF1YGAjF3Inn5u8UyL7FsL875atwHa3mq
	onUwNBmQDCNO52gJ6/CW0Kv/fBO8+P9QMhAjKMMRPS4Pnp3SSbdbT/k/MGDLmoOcaQ1s6AXbhUc
	TBA70FOfhSZPDFF6crcGzb+t13c8eHXsxCROq7U3gPWeIBKTAC1G/Hgbhmkozcnqy2HveDUwPR2
	tEohn7QXMsqjrR8QzSWsytgloH1A==
X-Received: by 2002:a17:903:234f:b0:2c6:a21d:5bb with SMTP id d9443c01a7336-2c6a21d0986mr10010875ad.33.1781603985350;
        Tue, 16 Jun 2026 02:59:45 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c433460a60sm153761925ad.76.2026.06.16.02.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 02:59:44 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>, Mukesh Kumar Chaurasiya <mkchauras@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] KVM: PPC: Book3S HV: Validate arch_compat against host compatibility mode
In-Reply-To: <20260609053327.61563-1-amachhiw@linux.ibm.com>
Date: Tue, 16 Jun 2026 15:17:59 +0530
Message-ID: <cxxqerzk.ritesh.list@gmail.com>
References: <20260609053327.61563-1-amachhiw@linux.ibm.com>
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
> detect the mismatch and sets arch_compat to PVR_ARCH_INVALID. This
> triggers kvmppc_sanity_check() to mark the vCPU as invalid by setting
> vcpu->arch.sane to false. On the next vCPU run, kvmppc_vcpu_run_hv()
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
> Cc: stable@vger.kernel.org # v6.13+
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
> Changes in v3:
> * Fixed null pointer dereference in kvmppc_sanity_check(): added check for
>   vcpu->arch.vcore before accessing arch_compat, as vcore is NULL for Book3S
>   PR and BookE guests (only Book3S HV uses vcore) [Reported by Sashiko AI]
> * Added Reviewed-by tag from Vaibhav
>
> Changes in v2:
> * Fixed issue where v1 allowed guest to boot in Power11 raw mode when
>   userspace ignored the error, by adding validation in kvmppc_sanity_check()
>   to ensure early failure during vCPU run [Found the issue after posting v1,
>   also reported by Gautam.]

Would be nice if we could post the matrix test results which Gautam
posted earlier with this v3. I guess you meant you already tested all of
those - it would be nice if we could explicitely put that info in the changelog.

> * Introduced PVR_ARCH_INVALID constant for marking invalid arch_compat
> * Dropped all Reviewed-by and Tested-by tags due to code changes; requesting
>   fresh reviews
> * v1: https://lore.kernel.org/all/20260603141539.47620-1-amachhiw@linux.ibm.com/
>
> Changes in v1:
> * Moved this patch out of the v3 series [1] as discussed here [2]
> * Addressed below review comments from Ritesh:
>   - Based the PVR validation on cpu features
>   - Fixed hcall name typo
>   - Stable backport
>
> [1] https://lore.kernel.org/all/20260522152744.55251-1-amachhiw@linux.ibm.com/
> [2] https://lore.kernel.org/all/20260522152744.55251-2-amachhiw@linux.ibm.com/
> ---
>  arch/powerpc/include/asm/reg.h |  1 +
>  arch/powerpc/kvm/book3s_hv.c   | 15 ++++++++++++++-
>  arch/powerpc/kvm/powerpc.c     |  4 ++++
>  3 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index 3449dd2b577d..7472b9522f71 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -1356,6 +1356,7 @@
>  #define PVR_ARCH_300	0x0f000005
>  #define PVR_ARCH_31	0x0f000006
>  #define PVR_ARCH_31_P11	0x0f000007
> +#define PVR_ARCH_INVALID	0xffffffff

Logical processor version is defined as part of the PAPR spec. We should
ensure that this invalid PVR is also documented in the PAPR spec.

If you have already taken care of that, then please confirm and feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

