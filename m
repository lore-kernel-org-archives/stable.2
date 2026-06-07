Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AAC28371
	for <stable@vger.kernel.org>; Sun,  7 Jun 2026 07:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780815965; cv=pass; b=gr4WBQhkxdAz3sSJ8kwC+Yi3AFfrecP+1UOpAJgYoJwYR1zEsAE2UgrSLaD6LfX5m2sVI1V8OVfTS8y1HuHhKH3bZiVZeHnEjkd2Ue+b+n9VNWXGJM+T7lcEmJqECpyG2ryItxtNWndR40BL7leIli5/+Omu0aMrvV+zSc0mQ84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780815965; c=relaxed/simple;
	bh=mUdV0DhC//w8Ri1SkoNj46XOQCm6jOMYkSM/1+jIZmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dddj83dMGfvRl5oIb+IBUZMKrAGryIZ4bQldd3iFkQQYrYRUklsWIc061TATeckSUdsRSKOnZFZ0xaRVbzpKQAhrRR07fBEKtPoKIPWVZjzRaWZJD0we6+t994MFJrOOf9HInJ2E6wdfRi4kNxHplrgq4goZbJWPRIMEaCDF6F8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z4LtezML; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z4LtezML"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51765531803so1404071cf.0
        for <stable@vger.kernel.org>; Sun, 07 Jun 2026 00:06:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780815963; cv=none;
        d=google.com; s=arc-20240605;
        b=d1eKDXulOkocfmSRBHk4INjyvPhKIxo5grKQJd47j1lD2+kuUmC6kyDm1c0/kboxKS
         yEn11xKnypVm9sGK7QwFNoaCHVh+vYixMm8oHi7DpypuQ95eulUCJCUsYg/H8YGdO4OG
         uYr4uy2OaS88glTtgY7DIcq5jhT8KnyCGVRLzcDoj++YKjbXIPqXjFuY6OXbn7HGiMCh
         uWV8i183GTh0Wpx0LldVSy6+0Quh0pyQjWnRVwltYQgFK8qzmNifOWNAfmjFxA+0EAX1
         +noV7OqV++pxPEIcsTc/0OdhoyrVGz648XFe1SpRDn0WMj4G3XGYw7PuJNU4N+03QA0B
         /MDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uT5ydn+EqJZsAMkKj0fC6IolXW7qV5RfXWPNY69Zc+Y=;
        fh=SliV3FUdmBdA8EmertLiwM8k9wOnFRToKPOPgMv9EiQ=;
        b=OhLlf3r+qwULx+AKUp6OuO7Bsga7ZZnOiAO3sM+1e4nEudd3roGJJfBdttvv2Xk0jF
         gFMcV5SaG3Dv+S0DezAKHjnGbEDMfNIz9ZpaUSYChjlIcmOyRjSo0j4VxPrUsvsr3uHc
         ROEbXOYCjzsvylmJtignFK3FeAWWU5gNedk70RPIzvle1t+wC/3yE+ZRIjde3sADPaOu
         8dztVQG9vypUTIW+qO6gv2Tj2KvWSBrR8ZOGL2YHJHuBQOE32Njco9aGtibLia7m752y
         nBQu5J8GFk6ud1R/QER8qHeqAJ/i7RQNqdfIQtu+a9EKHMncohe+X5llE/1SPUUFeCov
         uwpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780815963; x=1781420763; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uT5ydn+EqJZsAMkKj0fC6IolXW7qV5RfXWPNY69Zc+Y=;
        b=Z4LtezML//FW7NHenba2NTN1ifrNrNpzMixwF1w/zQwH0hegxvXCIfG1Al8UKhahh+
         gXwO/XnFjSKd8T1TExmjPjEm54PNIJ6A5f79kar8fZU/RY9f9ouX4ksjlENQlF5cfMZv
         YG/brjP/qaw1INrhwgU0BLHLvRYkatQIqVIBiMeiphp4eL7HTJYmvE10Hyf0TwQ9V1ga
         /DW/foU73vx5jbgi3i0/vIfbo8zFVzU52uUbp9DTP4Puzo8X4y9N1R9ohE/Z3hkY1cOY
         vXLdbQTypT57TRrgRFL7CLHaT8M+/y0RFJ21bvDR681fNa3aG7z217S38pcLniOfU647
         IMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780815963; x=1781420763;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uT5ydn+EqJZsAMkKj0fC6IolXW7qV5RfXWPNY69Zc+Y=;
        b=V7Pp3RYUa5TMXcrjuSBnalNU8BljUIkyX7FXMxP3uV1vnF8nGwvSwDGdSIz0lrkyVh
         vALMzObPDyQ5nuCwuGQkvmqyH7UsBwxMYkem2X6eG8RwokSnJi264kd4tuyoMdyhooWy
         7QAhqzr0iwV/5z4yvCPv7TfwGrvI2lAoiv3u2AWTD+sP8ZgauktMTMIdHoO0ynzsXW3/
         ykGqmC8oj6sqBD3pMrcIjgrmnRToW9bBCW4NQ2fK/41qatf0Z6OkRVIiNhC6UKNWMZA/
         3q0Czy00bNnI5x++rbzLDw3bEwgTmebF06ycCdMDkyOlUh/UsheCtQSz9aV+JNyUqMdq
         Sjtw==
X-Forwarded-Encrypted: i=1; AFNElJ8HbG+xtpFK3Zwcfs5YiI/UVXzWwbVcb0TkSA2SnN0I/mwiwSASOkxv7yfsMjhevgZ9tNvEoEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNEbsge8oG1n1mV5Jd3ZzvvbTVxpNfA8ovdG93sUDRydXg0jUt
	wjppFHFSfIDP2IBQXdi2CElvD9sazLPCARAjzCt7/4GQY1Jy3KGciBrWyrJVCpG5rUpx8WFx44L
	XOorhxtfvnimYTFOuEw4x3sDkLFLnIDOXz27rDR7L
X-Gm-Gg: Acq92OEpDEtW4khIPzNONNDpMEKsGnU9txAkLi7PTKLLmdCbjSB9UsAeC8J/xpvGidA
	Lnkc5wsKvroVqgTCBKp+PyMhYIxhmwEYGRsgtVD61vBYkzUCkasiEBuEL2UyMKFUdVulXxnbO8F
	l0+7hR7YgoCfDV6Z/6C9kiat8TA0ZU5Skm4IFpp4rUTqEyOFDjiYAj68Y3VvhZzl6gBXsObCs32
	nkrYqx+V0vy2JvsFaJW7tG8RnYyu5GMV39HfylPKC025C2QAJ2yFVrUw8exJ42xpDw2yhPlhXiX
	GNV0UQ8Yb1lmat7W1SE=
X-Received: by 2002:a05:622a:6d01:10b0:50f:b69a:f4a8 with SMTP id
 d75a77b69052e-5179806b242mr16836941cf.7.1780815962364; Sun, 07 Jun 2026
 00:06:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606175614.83273-1-imv4bel@gmail.com>
In-Reply-To: <20260606175614.83273-1-imv4bel@gmail.com>
From: Fuad Tabba <tabba@google.com>
Date: Sun, 7 Jun 2026 08:05:25 +0100
X-Gm-Features: AVVi8CdRhmH9BYOsHsmFgRsg2rtea41QIta7Nrzuj5tjiY1ErqsUXnoxLXLi0HA
Message-ID: <CA+EHjTxSsPvT11WRUJ5hRS7c6xNwmKK2ZbU_mCcBLBqdFM=xNw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] KVM: arm64: Sanitise host vCPU fields copied in flush_hyp_vcpu()
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, 
	seiden@linux.ibm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 6 Jun 2026 at 18:57, Hyunwoo Kim <imv4bel@gmail.com> wrote:
>
> flush_hyp_vcpu() copies the host vCPU context and vGIC state into the
> hyp's private vCPU on every run. This series sanitises two fields that
> it currently copies verbatim (host -> EL2): __hyp_running_vcpu is
> cleared in the guest context, and used_lrs is bounded by the number of
> implemented list registers.

From my side I think you've addressed Marc's feedback. For the latest series:

Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

>
> Changes in v3:
> - 2/2: replicate kvm_vgic_global_state.nr_lr into hyp_gicv3_nr_lr
>   once at init (guarded by gicv3_cpuif), instead of reading
>   ICH_VTR_EL2 on every entry behind a gicv3_cpuif gate. (Marc)
> - v2: https://lore.kernel.org/all/20260604151210.1304051-1-imv4bel@gmail.com/
>
> Changes in v2:
> - split into two patches, one per field, per review.
> - v1: https://lore.kernel.org/all/aiFe-CXo-XVTFz1g@v4bel/
>
> Hyunwoo Kim (2):
>   KVM: arm64: Clear __hyp_running_vcpu when flushing the pKVM hyp vCPU
>   KVM: arm64: Bound used_lrs when flushing the pKVM hyp vCPU
>
>  arch/arm64/include/asm/kvm_hyp.h   |  1 +
>  arch/arm64/kvm/arm.c               |  2 ++
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c | 12 ++++++++++++
>  3 files changed, 15 insertions(+)
>
> --
> 2.43.0
>
