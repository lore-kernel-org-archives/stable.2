Received: from mta0.migadu.com (out-207.mta0.migadu.com [91.218.175.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98FF3CB2FE
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 19:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791486798; cv=none; b=Pzlaz94+0Z+fxWM9o2n/n9m3ycO2nhV35DsS02EmQa599GPJYePAz+vJWPMTTyKXYhvnV+TKftSczXrW2jjzVGrizkDW4lWPwqsu74uJ67Jm+szkxj42furr5VR5XTZPMv/I5YDQ0m19rCI/4bw2e58heb+N2OrCqoTsX3LDhDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791486798; c=relaxed/simple;
	bh=0GTmQaFxokRtWOJdiFeBX/Ou/YTJPcm5FTNprMVwfos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K6UILO1gmflOkuj6yyToAch3Qh5HLaQCVymuyHpQ5jk60/hlyPQ0x9TCa0VQQFw5KJq3FZ/n1K5JSY/50jl9/bLg1UHQAF3kkcUmxkgxutsd7q28PLYAspjFOTeRuFyWSjYFbqIec8m879XsxFXV1mpC4WDQ3GXel2jq5dEY6Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xSVMttUe; arc=none smtp.client-ip=91.218.175.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xSVMttUe"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0GTmQaFxokRtWOJdiFeBX/Ou/YTJPcm5FTNprMVwfos=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791486792; v=1; x=1792091592;
 b=xSVMttUeUuIPHeQpJm6ueIo9a1dLiPPQfRC2ONMMgvy0PFzsJlXCL53TvjaaxCfPHF4Rm3i3
 k1eXz9Sjs3hC9QIDmsUuEFQqZAz7o82gVjST5jnJ8yhVzjoJhtzCrwOr8ZwKm3PHWAswDjNyx77
 YIHZpGxEMzUfEf5jTYCKiK8o=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 197006dd8ddca769;
	Thu, 08 Oct 2026 19:13:12 +0000
X-Mizu-Trace-ID: 197006dd8ddca769
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5bcc04c71f5so1646e87.0
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 12:13:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByDNGPjsBd6Jm8NMpMeDY9S1tqb0hoSaGFPFiuRpBwYpg0W0cJDPFhM5Kpo+iVSLKuZSGXhKkE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJuKJNCPqlBkPQVMqzR9v/OU7wAmPtTRHxqmyKha7XbtR20gl3i
	mTV3X6+eqtQ1SOvn0cp/rD7ToOBNtV+pK0znY2Pn2nw+3HkDG1+OwHBXnscnxuBwK9ulsg/JH5Q
	/kzv05tEyg2XMiWk2MyvhohIxVJ7NqaPAZtAHn8za
X-Received: by 2002:a05:6512:3b25:b0:5b8:ebf3:3370 with SMTP id
 2adb3069b0e04-5bcdd51a3c2mr4841e87.5.1791486791535; Thu, 08 Oct 2026 12:13:11
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008104212.3134550-1-vdonnefort@google.com> <20261008104212.3134550-2-vdonnefort@google.com>
In-Reply-To: <20261008104212.3134550-2-vdonnefort@google.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Thu, 8 Oct 2026 20:12:35 +0100
X-Gmail-Original-Message-ID: <CA+EHjTzworzPjJNdsFuOn8Jy_qDm_dhrgKqVsVKAdhzu7n6+KQ@mail.gmail.com>
X-Gm-Features: AclHuK_YRyUU2-fzg9DOXVPL5Sq1bOD0ID3Nxy6JWAxfr7jy9NZNQ53tG52YgK0
Message-ID: <CA+EHjTzworzPjJNdsFuOn8Jy_qDm_dhrgKqVsVKAdhzu7n6+KQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] KVM: arm64: Prevent 64-bit overflow when computing
 hyp clock rate
To: Vincent Donnefort <vdonnefort@google.com>
Cc: maz@kernel.org, oupton@kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, joey.gouly@arm.com, 
	seiden@linux.ibm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, kernel-team@android.com, 
	qperret@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Oct 2026 at 11:42, 'Vincent Donnefort' via kernel-team
<kernel-team@android.com> wrote:
>
> The hypervisor clock rate is delta_cycles * NSEC_PER_SEC / delta_boot.
> It is computed whenever a deviation occurs. If the delta between two
> rate updates is big enough, delta_cycles * NSEC_PER_SEC will overflow.
>
> Prevent overflow with mul_u64_u64_div_u64(). And as a bonus, simplify
> the clock estimation with mul_u64_u32_shr().
>
> Fixes: b22888917fa4 ("KVM: arm64: Sync boot clock with the nVHE/pKVM hyp")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Tested-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad
