Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091724C6EEE
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 12:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791982480; cv=pass; b=tHow+ssZcf2pqr4C5GunmFx4iA5p0x6Bhpczqjm2vTrMbXgjcICW5num9ifo1EbM5WBoaKgsOxrnqPKAPuA6KWQpCTj5UGtEXBiSqsVRmL6xlXLlqOpI1am/bqDlZ5QbGXKVNb0oq5xjRBEdzVBFLShi9D1iOr7iM+WytPb/RH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791982480; c=relaxed/simple;
	bh=KYS/c54vQeVbWBTD+IBBHhIs4+bHOZYRw7A3ClKDlRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qT/j1cEz66fTTkLHGrUv4Ee+wVPlrQTXr8nNWLbltcRc5ArR+bORK425hM7y3H7Oy/NzRG9yx3NyA4GsYuCdYWYbTckJXX7A+Nkb63Yixp3vJHI5KwH1XC6uvYViWPavCf/F6Y8IC0Tw2FUNJBlne+BMSycN9J2a4Did7xuU/MQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GhGkwpJT; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GhGkwpJT"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso38186a12.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 05:54:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791982470; cv=none;
        d=google.com; s=arc-20260327;
        b=Ql3QiP6TMyMHNwLFkS9LH3vy07cV8yPzIDQsafLB5GWIbMiuPqLhroXbTT2Mimn9dR
         rBMHZjaNEF7K2Me4CyyzvRN/zuO8rT6ue/7IY9q7LE5krzXUG1x4VNswRmvKOLhQXoJ2
         TYS4Lle4w7gvKlW3ez9hfOCxYx9veAbTkHwvDU0pxKbu7BGsZzbV0lmPZE1tI9Jm4gZa
         a5UmCDAMEWTJfEr+L1tHy1f00/0cvsZI3rIX1w3H2NoTcxieiMZNtKYv0paqLFAhpBkV
         /p9uXTSe7ynB7fPxAgndPCcc1C3wBUruaEMnpIg18fNIh+U50JIVEAlGpZvTOSJ9/FQW
         NPig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KYS/c54vQeVbWBTD+IBBHhIs4+bHOZYRw7A3ClKDlRY=;
        fh=kyob89wWSiKIyLpM8pPOm2Fdu7ilchJv7ITcG8+YbM0=;
        b=Q/rdHV01xE1PwPn/PEfN+Wn8fe9q3+k/BLgAX84/Gmm22xSq3+hep56taN9czXM1UP
         67kMpF6NWcEbrIqsDYd6rxK5+qL1SQoyYz5QclM1MeYbA4RqAVwyQ8WuUpdm0sNz5PH6
         ujDOWd3LtaiYo6ZsULFi2R2KhqRxqm/AK59F3xLVWbjuKjFQRpINC7NBGdOSCJoFqBzm
         C+3iJRHQbo7W60RBsXfOBUUERI3ZolhbmUvTCEup9RvRXDAR/apzDG4+0gDQ3QKt1Mwl
         Aayet2OE+uGZk1alJtrwEJU5l8jIBBurOOXUlaUd3Yj+kL/RazBYyKA06QunOTHGq3ct
         sFNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791982470; x=1792587270; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KYS/c54vQeVbWBTD+IBBHhIs4+bHOZYRw7A3ClKDlRY=;
        b=GhGkwpJTT6fXiF9yrbpcPpLZFt8cagCklO27tAT0GOlKOZd10Pt5nn2X1ARx/ukQ/0
         5MGj8JFAUPzR/X6RJDy0A7B9xmrxOP7FNsGVL950MyNWwmqTQKvmH2bilzrC4KPSFWQh
         +/8p25SEMCixJ9FCt3tfk50NMJPhfsf2m5ezWVA39gXJPC9GgHm3Vs0U+ZLVX5ZB+IJ7
         aUrmRaRnNhG41Dq8PlivhI0WZ0WR4Szgy9m5XpYbsKeetYowEMLxy/JkCC65WublRiTm
         LQXjmw+pZIuW64Onl2Zos796QocP86vo7CFhe5oCbBXxaE46ksmfhod6kC5xzBKUPqYu
         HuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791982470; x=1792587270;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KYS/c54vQeVbWBTD+IBBHhIs4+bHOZYRw7A3ClKDlRY=;
        b=mTUTi+O8wljtsta/mgqTz9PrqlS51jqfbvnpBFiM8doCn264DggLOmpHmHEKUFGfx8
         ELwBAJ2KJSOljWfvqhTfE7MP7LvzlRZjPdpkpAMVeCk+7nzzR7mXXUktdHAH4/GYTzB7
         4x9o27EXUzFcAGpTyD415pk0i0P770FWqv9QjTb4nAR49FIhKNPHZUNEf9n0b4NGHZjr
         ua474R6eh2HXQLs7hfxocGkWHN5WFji0bPNTbZ+fPVyCl+MskucTj2Rktkfk5RI8E2RM
         twLDJXlpFp1Mcy/R3IfJeQxoe/4EI46JrA0V40rzInsxjEUFbca5ws2QL/q7MJ4rssic
         ed+A==
X-Forwarded-Encrypted: i=1; AKwUvBwpWKsHhEep7Rdz2nlNZeEOuerw+DsqcMQsRr+JtqmyP3jVnNB2b5Hyb3ZzwkGSV2AseRkCMp8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJz4NcXaTPle/MCf2YSZcYjetPD6bBVCHMnsGZxyxkmAIIfRGjv
	ckyMQsqe9diEuaAtCq7ymF0fYyZXnrohEqhTswHvC+ChJsqwmXPcf3ZHDMbC9L89WCm8vwWdNq2
	HDrzdKxLdlCfJPsKyimHbTUuMnU1sgb3tkpsIT2eC
X-Gm-Gg: AYBFou0CfTlaCygXGILTHZUGyibOjDjl1Hzvo8LLu3qJAZDf3loxPDez1ICuo/nKU/t
	3anh50SNmOhRIuWEBK4jvWNmPHaPcxFWlQ5N6jz7/7ptKuLETPQrcAuNJ2s7zaCOgB8naOj2Ahc
	Va6PMNyfXvHw2dJVJn074kqvfwc+anIht7ompEA4i7WfcKUHt6GF65LCirYmDqBrRoc3tdKZDAt
	1FaIKIQC6d9cYRJTsgeILvkogzrbvj2mcnNTKczwwrzXApbIuqgq6uKI0b7XU3LHBz/YZZrcbRz
	iHLgRd4FsiGcyLkmXPseNf+S0jrZTyLS+YT72JCoqanB5jgXWfLbxgM=
X-Received: by 2002:a05:6402:c548:20b0:6ae:1503:5a27 with SMTP id
 4fb4d7f45d1cf-6b20aae063bmr28860a12.8.1791982469402; Wed, 14 Oct 2026
 05:54:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013231728.883001-1-yosry@kernel.org> <20261013231728.883001-3-yosry@kernel.org>
In-Reply-To: <20261013231728.883001-3-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 14 Oct 2026 05:54:17 -0700
X-Gm-Features: AclHuK9rxlY9ryi2n9m2aAdyaSNARNmcvyrOyG0s9ziCGiHhPOebsZRxyO6FDgo
Message-ID: <CALMp9eR-CPo2n_7uN7paJQZvmPXA6=7Fpo0xJePeadXwuD600A@mail.gmail.com>
Subject: Re: [PATCH 2/4] KVM: x86/mmu: Drop for_each_shadow_entry_using_root()
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 4:17=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> Drop for_each_shadow_entry_using_root() and open code the walk in
> __kvm_mmu_invalidate_addr(), the macro's only user, in preparation for
> handling failure to initialize the walk, e.g. if a cached root was create=
d
> for a different MMU context and so can't be walked.
>
> No functional change intended.
>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Jim Mattson <jmattson@google.com>
