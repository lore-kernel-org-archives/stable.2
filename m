Received: from mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A928645DF48
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 07:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581517; cv=none; b=lIFMkQDCIHHf0LrIj100Up/7je+n8zH6VUp/3dxxiAj0MlOezq1i7J5K0JJCSYU/w8IxfAkQE9H/1zs5DHpqL9Joij7jmO2zZdkYbGgvkTVXqS70ZRZ0XwnAZnQ1IyqD/gQmOu9u01DBi3anoJY7ceI4q1WrOZm9igoJ778APWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581517; c=relaxed/simple;
	bh=szjlKSRr4QKhQ/BXliXytwAbzwuxRJ9hxfloPYxH0y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lvyn7A6dOxYEZmFsouYJlPla6AMeQSfNhnPzAx9zhErdhx9EZqF7t+26HnoGJJGLS2IOl8Nm6pdxmJXmnlPRQKE4CplJzvjF5bwiohUXrhfHgVbx3t1GiiOPmP2nCjzKU70nxoOW0EqyHiNTY51MD93vY0NZscigd97XuJpCwew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f8y4G1Cd; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f8y4G1Cd"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=szjlKSRr4QKhQ/BXliXytwAbzwuxRJ9hxfloPYxH0y4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790581512; v=1; x=1791186312;
 b=f8y4G1CdBqDu3V54WbDHPXjnskb/zdQScluqo4/h3HqHKPPNwimpjI1PyN5fiOd4Z4g5YXnc
 K9Ewa9wntTozqE59vRzoB2+2VabfoZ3Nf5AogR4rDNWHINvYaKcgpEz7PY60lfJqd9EX9tdpiVA
 Bpu4Z9DeBENnz8nD0/WBQVpU=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 437b5fbf289d208b;
	Mon, 28 Sep 2026 07:45:12 +0000
X-Mizu-Trace-ID: 437b5fbf289d208b
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b8f42bb8a9so4292e87.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 00:45:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxp7LA9UAQHWGwj49FDP8PYO/HzCLYvPOeyEoERwwsfvWZ2zuLgFM4hvpS5rWqdujMapx/2fLo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5fwQi2FhBEFXSZwEJspmc0E1F++I3Q1QDNJIPf90Ybwph06nY
	XSWLCaIietHHqHtZnns9HYFkS/9skdog3BHszy9ZkbbEY+vvPK5f8acB3zTaTN4RkO3jJivVJ/c
	wEGeTBOwrjhfLrK6GuyrTw1XBsiYgWm6rzhafoV3F
X-Received: by 2002:a05:6512:1386:b0:5ae:cf5f:4a88 with SMTP id
 2adb3069b0e04-5b8ef2571demr154509e87.8.1790581510337; Mon, 28 Sep 2026
 00:45:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922130821.1666713-1-vdonnefort@google.com>
 <20260922130821.1666713-6-vdonnefort@google.com> <am2rfnuwjkglavbtzkt2lk2gclahvca5irrv5me4vppzkotexf@yauajpybhsnm>
 <87qzie3beb.wl-maz@kernel.org>
In-Reply-To: <87qzie3beb.wl-maz@kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Mon, 28 Sep 2026 08:44:33 +0100
X-Gmail-Original-Message-ID: <CA+EHjTwwxL3Cs-7B2NgEyedu-ZQFt96ck_V-erCUaTB=hrh5eg@mail.gmail.com>
X-Gm-Features: AclHuK-ALEhQXkggSsAxXnC2DJjXeZyCoNf81U4HcBABH4AnShcbMTLpdrkikjI
Message-ID: <CA+EHjTwwxL3Cs-7B2NgEyedu-ZQFt96ck_V-erCUaTB=hrh5eg@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] KVM: arm64: Use kvm_s2_fault_vma_info in gmem_abort()
To: Marc Zyngier <maz@kernel.org>
Cc: Wei-Lin Chang <weilin.chang@arm.com>, Vincent Donnefort <vdonnefort@google.com>, oupton@kernel.org, 
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	joey.gouly@arm.com, seiden@linux.ibm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, 
	kernel-team@android.com, qperret@google.com, Sashiko <sashiko-bot@kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marc, Wei-Lin,

On Sun, 27 Sep 2026 17:30:04 +0100, Marc Zyngier <maz@kernel.org> wrote:
[...]
> > Perhaps it is worth reserving plain "gfn" for the value we use as the
> > IA of the (shadow) page table, and name this variable something like
> > canonical_gfn. Similar to what kvm_s2_fault_map() does.
>
> Maybe. We have gfn in the vncr fault handling code as well, but that
> one is the result of a S1 walk, so maybe more obvious.

Agreed, now that s2vi.gfn sits next to it. I'll rename it to
canonical_gfn for v2.

> > Huh, I guess you also fixed a bug here? s2fd->fault_ipa could be the
> > nested ipa instead of the canonical ipa.
>
> Yeah, it appears so. Worth capturing in Fixes: as well.

That one came in with a7b57e0995927 too, so the existing Fixes: covers
it. I'll mention it in the commit message.

Cheers,
/fuad
