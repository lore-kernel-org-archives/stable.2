Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06881EB5FD
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 07:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789197594; cv=pass; b=VptJhahndNpEByarwngz0lwGsx9kdPs8kZBxx5EH5erjWeEEvRmwNo6H3YEgVJAs5uZzDdrVUzkZdhhiQzguRkz3X7fAKVpni4BcABsQaQI0GdWcO39xQafzQgekigkV25GvjBTyvvu8AW81tcAnAi7f6GUKqwdFTGNmKAY/nFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789197594; c=relaxed/simple;
	bh=pGpH0+ouhnwwNkJU6TGm2wYa4a8DQmd3BmREAcSC/hY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jtKvJawR2yzrdldDt8v92ha5UMT3XSuAI2U1mZP+YLoe8NsKZSMmYcKfZ2DCV7kEMQXHjM8qs3X5rSYQtRNLT3z5EMj09HuIy5SOOfmOUMioAWzEsZ1O8RyZMZ4dz8bX/2vdLqv8JfH95qHie3m691dlQ5W00T1/6ZevPRvJ5pU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=ZsRwpwIa; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="ZsRwpwIa"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f89so125653f8f.3
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 00:19:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789197590; cv=none;
        d=google.com; s=arc-20260327;
        b=pF65RdHrQ0luv5CL52FISEmYC7ztmiJrMpev/1jserxFFzaRqGahgGDYfSU2TtRT7I
         62JxAWRHC10/fBouCQJW1v6fUjeznmXMhCIYX5OrolkIqmu5KPTneP9H2Y2GpbAxzljj
         BTASFSca23TKfGLa615/6ujR4FW2G8+IEtzVNd9OsisoHdosflq1yGcSxNYX/wz9wQ6K
         gxRfKWv7DNrW1Db9NJREiU+SbR93uw2vzJl20/Br/7+0aNcprL/UEWCyIYFGGCXSMbCb
         wPr6aXQQSB0cAtyKpn/+sbknHnDdo3VAmS/7V9eeCFwKDjYS0CkoWsv5eFag/tTUpFmS
         oImw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9RWV49ckuigD55nYwZZoBmV/ryAALoCGfcRf1WteUKA=;
        fh=PUxwEJyF6YwBV494J4O/GSXQWPnosvVX6XZ4pfy/v1Q=;
        b=owvbc9GYADVHsZh04zkgs2JNTDhvHPTPF4+L7Kv3iQFO/9zoB1xTIUituRskObBoWL
         NmMfUrH1rN7nA8szEzucvrt3wke4KomHydlYMLuMlnxoDHT78sZY98nRdNC/F9vYFws6
         hqijEcsZOr44zBdvHITRV7po1IiEyZb9bnpZappt7bCRcaZNufIHJxhDk9Y1j2DE3aIc
         ajCxLaaIzO4yPqyEVRz4TdzNC6nVi8+MkXWyxltjH2MTgOjVUsv+sWhKH+7LItR3I28C
         JUqsEbqZV3G5KHEQ4OQhHdoYz1BdBmlEZ2WqTA3xGwEt33TjoHTNBMTYO/lq5W5Sybxe
         JX5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1789197590; x=1789802390; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9RWV49ckuigD55nYwZZoBmV/ryAALoCGfcRf1WteUKA=;
        b=ZsRwpwIa85u1zXhnKFyhmzRZJ32K7oQ82tXuZRnTAuOJFpF3e2vAs0Wsq9D4/7Bunh
         dul2WJQOWT1kDjXgbdxK9VdoErOhu9mS0b//FHbmCk3VnG3bJn10dKkc8yNHtkAX1RZR
         yFIUGW43t/1e+pKSWCR2wM0aDjIVI03mtIOc9B9fbw0b7oLZJwUYuDgoIuPShlV6S3TB
         8vYO/wfDkUoCWc45Io7S9EiPSWM4QCOmoQV7a3HHiWKB1Ns77iyclvjMcUyqzQmHYVcD
         XKaknhxaBZnBW9ocUQPJD+qJDUPMD+tcc/tBuCIXU6t5dOJJ64qdsFyZS6ttaWQmYLBf
         Y4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789197590; x=1789802390;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9RWV49ckuigD55nYwZZoBmV/ryAALoCGfcRf1WteUKA=;
        b=L/48Vur5bEufLhRcGwjX8ISZa/l+sYSmUuyEtnh8ufxqvZpxXIefUJF+KbmO7bEx8b
         mxrl06Ezd9RUthMK2oVL8LlfuXZHZxTki8Hp0jsaTlgOVxl+n2bxt8GF5UrQ8oDiPd/x
         KKieq63CSyDeyoTaVguj1o9yILxSKuyhmPEAA/2WjriesqHx12ZF2uoUQ1DP4vQ14yFx
         fC1FCi0kw8YmhaKYF/wG9x1RmvXQUpSMrzPD1oXEhmusUHVHrh4jkMj8Ygc5lrxRad34
         Rf8lN95cRRwb17fr3WHNs15L/MJPQgSc1XmdNti7e0HIab0m9k2EpnJTHO96Uh5DLyUu
         1qQg==
X-Forwarded-Encrypted: i=1; AKwUvByzttLFMZU2zZF9XpzpxsIbVuW1yQMmGsny9kLsfHyeaPVD+z6hfKGpHkFtPmWINYtEQADGAJI=@vger.kernel.org
X-Gm-Message-State: AFuF++n+mf+ba9vWGLk1WPDkt0UDMMyBAO/YZjlGnl+1yUKWJuvRRjey
	xGqld8TZi0fv+JE0amQuHsi/ULlT+s8u1v6jg8Rc/6Gq91dBBWRk/R2pavU1ToETxeq5qzuAkov
	gSDmxDXr+DpLU/9wClZGTcrNe4IkH390ZxPSIquEs1w==
X-Gm-Gg: AYBFou1YDDgzOLbxIFdRllZLw5uhk9+zp7Vb1pMFAJfgTi62kEFPk7H/A+Fq+XPs6UQ
	TY5gNw9FL+H3RnMQWMuWmnZ6FbwhzWDQ/JRnL7VDQmXHozFLX5I7yaxRd8W0A3k1DPlztdg8Ntg
	TlFGuxOQL7PVYk+EzsegFTO7Ntf74SVmHQ57QdT+vnvD5Nu2fOlL511NDm3cqvNJK1SFG5IktMx
	KBZRToEAMqvdcyoljSs5oKH4gBrZVSxCsuaMfohk8HxlG+Yzp8GwGCrZ/sT2CEh8o7tILjnfQuX
	vCrquRgySDO8AXepnT0U02YrmYFhJzFSpCNHHZq4hFbQuSMVflIwK7tNI1sapWR4PkBvUk+Vl1y
	4Zz6pLMEdICn2/1DY0nfFWcYhKci5RM3X+Q1XbHaUD2c0rIKLr8IJP6uMN1cVEcvWiIGlRtde7/
	A=
X-Received: by 2002:a05:6000:702:b0:486:f600:8e6b with SMTP id
 ffacd0b85a97d-486f6be9493mr1750445f8f.14.1789197589863; Sat, 12 Sep 2026
 00:19:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826064117.58029-1-min_halo@163.com>
In-Reply-To: <20260826064117.58029-1-min_halo@163.com>
From: Anup Patel <anup@brainfault.org>
Date: Sat, 12 Sep 2026 12:49:37 +0530
X-Gm-Features: AcwNN1WADS_UyMRbl-o6HEs2JIz2PBNtpUz7lA9SsGRbmoy5E-S50JL4uCJxHNQ
Message-ID: <CAAhSdy1AugX4AiU6xj1R3SQ9bRsRFBNu6=_aYM=G9SMkXN8Ghg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix sdata leak and stale snapshot_addr in snapshot_set_shmem
To: Zongmin Zhou <min_halo@163.com>
Cc: atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, ajones@ventanamicro.com, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Zongmin Zhou <zhouzongmin@kylinos.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 12:11=E2=80=AFPM Zongmin Zhou <min_halo@163.com> wr=
ote:
>
> From: Zongmin Zhou <zhouzongmin@kylinos.cn>
>
> A guest may call SBI_PMU_SNAPSHOT_SET_SHMEM repeatedly. Each call
> overwrites kvpmu->sdata without freeing the old buffer (memory leak),
> and if a later kvm_vcpu_write_guest() fails, the error path frees
> sdata but leaves snapshot_addr stale. A subsequent
> SBI_PMU_COUNTER_START then passes the INVALID_GPA check and crashes
> the host with a NULL buffer in kvm_vcpu_read_guest().
>
> Fix this by clearing the previously installed snapshot area before
> installing a new one, which keeps sdata and snapshot_addr consistent.
> The SBI spec suggests a single invocation but defines no error code
> for repeated calls, so KVM must tolerate them.
>
> Fixes: c2f41ddbcdd756 ("RISC-V: KVM: Implement SBI PMU Snapshot feature")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch as fix for Linux-7.3-rcX

Thanks,
Anup


> ---
>  arch/riscv/kvm/vcpu_pmu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index 752f1014d633e7d67f69c27b72088ed560c187ac..14f73490f12cbc5a8547859f0=
d1bb1170d89403b 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -454,6 +454,14 @@ int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm=
_vcpu *vcpu, unsigned long s
>                 }
>         }
>
> +       /*
> +        * Clear any previously installed snapshot area to avoid leaking
> +        * the old sdata and to keep sdata/snapshot_addr consistent if
> +        * the re-install fails below.
> +        */
> +       if (kvpmu->snapshot_addr !=3D INVALID_GPA)
> +               kvm_pmu_clear_snapshot_area(vcpu);
> +
>         kvpmu->sdata =3D kzalloc(snapshot_area_size, GFP_ATOMIC | __GFP_A=
CCOUNT);
>         if (!kvpmu->sdata) {
>                 sbiret =3D SBI_ERR_FAILURE;
> --
> 2.34.1
>
>
> No virus found
>                 Checked by Hillstone Network AntiVirus
>
