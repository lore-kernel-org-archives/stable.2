Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469E53909A8
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 03:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035931; cv=none; b=pSA20iCXkyaN08hDjpqdX7bTwNVzCJkE75ihwlAU+I6kre52xfjDICTfSCGNL0DBDqLB/JerBgAdZygPY8LS33dm8mwBB6UtUltONJqjtQBzPT0Au2lXIhBCNposlLDF8nEAL1aeuCoszWKUQltbJTkC2S8nlWrXlXB1UuXusbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035931; c=relaxed/simple;
	bh=9tNs4dqxRFyP90eQFauIOedcWXZRofnOvwz8agHbVaU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=BWLZiuZ/PIB2CbvORDsfkDX39xnGsOOu1PjG1HmzWJQZ7J453g8FgBHziwX6Ngioj6PkL7oA+F+RuhkwS/J4bcaHmlqOwQJbfxCSW3CycTDDgmPzGTlSGmzPSA3v2Z2azfWcPIlMxk7e9bJdEwv4Ppg5oZTNq2edD0C8E4i4W+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPLD3TsP; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPLD3TsP"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35ef6b49813so875039eec.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 20:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792035929; x=1792640729; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ekxAbaTw9lcA/repE4rySfHgfzkYuU+ooIR190sGV+c=;
        b=hPLD3TsPSGMnptvsYH4IuzPpO6zxpFiXTGuNM538iTOXrk6/earv2op6r2zGPbu4Z0
         6HQXzaMnxQte1gGlLwGJsRP2UzyUMYcS19bd8qrDyexfQDHZz+aEriGRhV2UvOlJ90Z8
         P6L8u7CPTKO20IPTXLviOxK6l2IVW0c/tlMZ4mD+jGyfz1dWe8MyWbYZ4qQ20LyC0+6s
         5/7NyqFwCLlezfSgHwWJyzN3ysnSyQABQ84Muf5/Zm6slKw7/iaQrt7ba+3qzN5utG6u
         MRuOtlJh6W8ydLW8jO6W4hMeXpUn7TX9rx1QbJ/hcOQeZprv+PMEn8PZU/ebh0n6YFK5
         K1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792035929; x=1792640729;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ekxAbaTw9lcA/repE4rySfHgfzkYuU+ooIR190sGV+c=;
        b=aMxlu5nxMAxCSfVBVYrRyi58pISnP2wfboBA1Jn6NfQPkGVliO1FogOeCPGFRxbbtz
         H9WOKZezCLfcLHnKe39qO0zkzfzO/jyB0qwIOK+9W4RHNi9goNBcZKvGaCyNR38mNahO
         DGGf9p9ZcqCq5jAk8rxnv7x0jZub/aw63VA0fGF3FNJ4gGkgwhmazwETV2HZLk2iFi/n
         Y/qY5i+5gTHuJMBaHUdtaoISKigLc5JpEKdEX/MjDYzaEsRjRKgqSMUtBBzxrdhuyKw8
         OaNL/G8kGCCgflX+2O2OzKXlihc87/ElkZ9kPtF2HGbfJG1Rknh9d5AJeOSCuCRrxXqA
         hV4A==
X-Forwarded-Encrypted: i=1; AKwUvBzngh87uf4eNae2glOSo2/2SKJJ8O2c9mo84tH0to7DhAPN9wEIapa5ycPgXc9OaaYvhVG9+a8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLKrmph+2i3P/ZORp30YAyV3IYJWynipWXqLfJpjGgvklYKcIr5
	Ib6my6xudgBe+TUxSLsjOMuR2vV1RR1oh67gZiEipBwGO5PVUt/b8D6iqERbrQ==
X-Gm-Gg: AYBFou2lgka+6Bah87QYMgpkHPc4HGBriK0sBT/kqmSqaOA6qptDc0Iyen3XcwKCT8x
	sGVrdY/wK9BUy/o3yYjtKxEImFkekAohU4PCCBTYY3DgtwcElQJdh6jcSzA8rLX+OCNpOiEYdho
	TOl4btzw+8uVaDgaNvcP2+/guoWc85jEVkYAxA1+2XlVw/GB5/D6VLUM6/SMrRXeWpgQPY72mA1
	cbmoA29hQP4lnmSvPoFzMk26be7Z0es0POmqtvXEkiSZfAc7MUUJRyO6V+LeAB8ZJCrCoHigv9Y
	XymGYcVcIxPbsKrXqow1SoEPxDd82Dost/ogSOJPeGSvLO990gDkdBGgE7dC4YqQvKO3nEBcsM2
	s5xFIMT1xwWdHjaBuF3vOJiFv7YSbE6EQaCgkhcV69M2CmFSq17nC8oco9+VRKvB/fEuQm/x4Fj
	9c0pGFm1iNXNaKtr03Xv6avxadJkTwcF/LJCpvprnWPxJG77C9hIeUqsNe9W3Ky28Laoy1
X-Received: by 2002:a05:7022:7e08:b0:144:fa58:95d8 with SMTP id a92af1059eb24-16a61a6ebb0mr33060504c88.27.1792035929111;
        Wed, 14 Oct 2026 20:45:29 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a5866477sm50853605c88.22.2026.10.14.20.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 20:45:28 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, Alexander Graf <agraf@suse.de>, Avi Kivity <avi@redhat.com>, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, R Nageswara Sastry <rnsastry@linux.ibm.com>, linux-hardening@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Disable preemption around host-side HPT lock users
In-Reply-To: <20261014185215.71832-1-amachhiw@linux.ibm.com>
Date: Thu, 15 Oct 2026 09:14:32 +0530
Message-ID: <v773r5jz.ritesh.list@gmail.com>
References: <20261014185215.71832-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> A previous change ("KVM: PPC: Book3S HV: Add preempt_disable() around
> virtual-mode HPTE bit-lock users") at [1] added preempt_disable() around
> guest vCPU HPT hcalls and page fault handlers executed in virtual mode.
> This ensures vCPU threads cannot be preempted while holding
> HPTE_V_HVLOCK or the reverse-map lock.
>
> However, several host-side virtual-mode paths in book3s_64_mmu_hv.c also
> acquire HPTE_V_HVLOCK and lock_rmap() in process context with preemption
> enabled.  Specifically, kvm_unmap_rmapp() and kvm_age_rmapp() take both
> locks during MMU notifier callbacks and memslot flushes, while
> resize_hpt_rehash_hpte() acquires HPTE_V_HVLOCK during HPT resizing.  If
> a host thread is preempted while holding either bit-lock, any guest vCPU
> thread scheduled on the same CPU spinning for the same lock with
> preemption disabled will never yield, resulting in a permanent CPU hang.
>
> Fix this by disabling preemption across these host-side critical
> sections.
>
> For kvm_unmap_rmapp() and kvm_age_rmapp(), place preempt_disable()
> before lock_rmap() so that both the rmap chain lock and the subsequent
> HPTE_V_HVLOCK bit-lock are held under a single non-preemptible window.
> To preserve the ABBA lock ordering between the two locks, re-enable
> preemption after dropping the rmap lock on any retry or early-exit path
> before spinning on cpu_relax(), allowing the lock holder to be
> scheduled.
>
> For kvm_htab_write(), the HPT migration restore path, replace the direct
> calls to kvmppc_do_h_remove() with kvmppc_virtmode_do_h_remove(), a thin
> wrapper that brackets kvmppc_do_h_remove() with preempt_disable() and
> preempt_enable(), mirroring the existing kvmppc_virtmode_do_h_enter()
> helper.
>
> For resize_hpt_rehash_hpte(), place preempt_disable() before the
> try_lock_hpte() spin loop and preempt_enable() after unlock_hpte() at
> the function exit.
>
> [1] https://git.kernel.org/powerpc/c/abbbe5ff83e7c9ed3a4d61b73011f1df7bf87907
>
> Fixes: 6165d5dd99db ("KVM: PPC: Book3S HV: add virtual mode handlers for HPT hcalls and page faults")
> Cc: stable@vger.kernel.org # v5.14+
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
> Changes in this version:
> - Separated host-side fixes in book3s_64_mmu_hv.c into a standalone patch
>   (guest-side paths were merged from v1 resend).
> - Previous discussion: https://lore.kernel.org/all/20261007182116.12479-3-amachhiw@linux.ibm.com/
>

Thanks. Looks good to me. Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
