Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF677351C31
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 18:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966197; cv=none; b=kkOhLX7HSiIrs9w7je8jRPnVkQEbZjpMtqZL4XHxejdBIrsAvUhzM86NSs5w+FVhnh/4lcGMEQYxd6xuiy/g3DNFD47AlBndH3lLTaeAWgdwxMvAjOMRSyJiGlkhjd++ZUI+uOxDRhc7GLbg9LEuQR0Gk+36Ah4dO11gjIYsNn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966197; c=relaxed/simple;
	bh=AjgIWghdFYFTReALUR4dxHultO6p0oNeQVTcDBCXUS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UbBpUKFrWEKJx62KlNOqV9T3LkeKLLOvHwJOV0Mhj/IluuoQAkVEOfkz1K/1Dh5VrLYXXnlGwJOenB3iVYvhMaxSXklfRXgOMKOKQ64igu549oczwGITzm81/9HqNBqM5n+24ATcaZsvHqUfcANO8FNcNYMYFPafMAQV4ymxdq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoUiroz5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoUiroz5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D281F00AC4
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 18:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783966195;
	bh=AjgIWghdFYFTReALUR4dxHultO6p0oNeQVTcDBCXUS4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=eoUiroz5YNAKl0+zUVJM9l94tJfBzgqNLcB/VvHzuYLbsRqrqXoBYw5JXYxBOZEEd
	 up7iFH4uAck8y9rwo3SjO7ni6Kn8Cvs7odcK1jOtN+Cryr+2DeZwJth7zoAOlTnoQN
	 cyX29ypGs0lMj3yME+RveE4btqPKYnh+JlNxIk4TPCECItX/MDfI613LrNK5qLV08Z
	 hiMJVoG0Kf3t7iKP9KfsZb7Um7d24F78uG8pEYDH2Jm4uL0LCWEp4DvOMMKI6lHWNL
	 FCfzFCFDb7aiO2ZSAiAEV+W5tgd+61K/dvHg0EK6s82/5Kpg0lSl5cNjrIfWAPwbDN
	 pV3vSBndRtqlA==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c15e03c2763so35331366b.0
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 11:09:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro0MZ5ssPWTKgM4pmzCZOfhD9Y30AWP0e+u8aOqeyzeVjl9Eo3hHqphfBEm/5OVU6hJyd3xS7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8p79NVdnk5eDCIzSWPQ+5Y/9JqiRJtB8jW7YRI3HhFzlJ7rzE
	+QyzCyXpNI4/1UxkmoqU1vH+waoQz5VO+6Q56euwWKOOARcFxHwCizXijcZ1TNvRkRfWOL2mYHk
	VA5wlTei4ZbnOOhnWNe/Jr1cNLuh/Lqs=
X-Received: by 2002:a17:907:3e92:b0:beb:d461:7b09 with SMTP id
 a640c23a62f3a-c161e89f210mr540204166b.11.1783966194573; Mon, 13 Jul 2026
 11:09:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713180153.2728382-1-yosry@kernel.org> <20260713180153.2728382-2-yosry@kernel.org>
In-Reply-To: <20260713180153.2728382-2-yosry@kernel.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 13 Jul 2026 11:09:42 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPhmLNdVgyXib-P+Ge_KSp=a8gA3mLDcpjJ5br-eXpj8w@mail.gmail.com>
X-Gm-Features: AVVi8CfA0knMptWzDciEPgOB08A5RKL7bIyn0rifQCDim0HLfgvv18cOw7GIMYw
Message-ID: <CAO9r8zPhmLNdVgyXib-P+Ge_KSp=a8gA3mLDcpjJ5br-eXpj8w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] KVM: x86: Check EFER validity on KVM_SET_SREGS*
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 11:02=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wro=
te:
>
> When handling userspace SREGS writes, check the validity of EFER (i.e.
> allowed bits) before writing the new value of EFER through the
> per-vendor set_efer callbacks. This prevents userspace from writing
> bogus values (e.g. EFER.SVME=3D1 with nested=3D0).
>
> Note: on KVM_SET_MSRS, KVM only checks EFER validity in terms of KVM
> caps, not guest caps, so it is possible to set EFER bits that are
> supported by KVM but not by the guest CPUID. Potentially allowing
> userspace to set msrs before CPUID.
>
> However, for KVM_SET_SREGS*, check the validity of the set bits against
> both KVM and guest caps. This is consistent with other validity checks
> (e.g. for CR4) that check validity against guest caps, which already
> imposes the need to set CPUID before SREGS.
>
> Cc: stable@vger.kernel.org
> Change-Id: I45701ec440e4fdd8f086eb70db0c0845fb0ed509

Forgot to drop these, sorry :/
