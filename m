Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B598367B7E
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 20:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784753165; cv=none; b=pw9bZSFeaz7Sp+/tiEDRR9k5J05yvRCQFBysFwZwzgNdVOCXvqq7ek+3+FPtRIvmLhss6abHFscqwBDRshaLNtK71YdQbyDAl1bxBhti5vTw+QhXyf+c/TjfazEgOcz+n1QEaBsEUbD0XKIxxEgv8wkW9GSGLGToqG+wTOT41KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784753165; c=relaxed/simple;
	bh=Jro+S1urwV9VgFmKgbhzrATwwOWCyi2FY/Wr2eFCpEY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eTvlXl42989SCeLnSG1QR20E9oD+BH9GIzfuiJP0iSTadzFzixyr4nloiM99n1h/V+iI3Zsl8QlL3OEUe82N+zQP4OtVbC90iqb5GgjH7qXG8tqmD/56NdnFfsrlPhtbQW2YqVHsOKYWGYn0hzoDLBAZMiKQfLZq3qr2VP9FWPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HcT3AwZJ; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HcT3AwZJ"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84e086f8e0dso3232476b3a.2
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 13:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784753159; x=1785357959; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SisaSmmFXYUYWjETBTWlOGLFpT6OcQLzXOoQK4qPlWM=;
        b=HcT3AwZJT9agiKrrLhKXzz93q0PYM6sSlChhP7vgm8/M9P+8lL8EkHd8bB6S1uA/eo
         b6KCh4Mw2Tx4ca1YqTtBvvg2WmA62omMZ/bcyr0qARp99Btv+/dcJlf7hj8grI056WeH
         RMnMWu4NzfPfygvUkhCc/Ooa8K9+mHdAPNrcsPhLM+iPEfbf495aJgINrJ6DsPEUAco6
         Ew7Mw7+n5A7+SAPLopLdZoc/3gB+cb3J2I9af3Lh0s7UKl5rwAoFFRRX2NpXXY2C2ScO
         bt7aH4ZdL/BKMUw+iPuP0/l0/wERTyjKgUnuBEtLUWu21g6bywxdUN4Gf820Jf7SXCWp
         KRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784753159; x=1785357959;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SisaSmmFXYUYWjETBTWlOGLFpT6OcQLzXOoQK4qPlWM=;
        b=iZfeKZ2WotTt7qEo05gVVIRQatfd5JaHi1fafxKYMs5QEe4exTFpFAtw+bz7RbmsL9
         zN6Lxxm6nMed14N3WYUQ4g8jTiowcRzQARkFhm3lWOj5DpZgy0/bJ6gM4o3SnfUGnw74
         EHPG25sRpp2U6MOl/uGrpcUeouyM/oPYwAA/81LiwDXCFmEaOTiHf6gCeNHdxYhTV4IL
         COMS3mxGVIPBGAFy5dvunWms27p5BrVeUReFXkmH9aW4CXMrssKXjVxicZLs2OfBzdEl
         KL8NegfsA/rhph1B3gdXvRB50Pg9qU8nflJvPAzR6yDAFqC/2Vu2LN5VX6UXFejCTqTu
         4b9g==
X-Forwarded-Encrypted: i=1; AHgh+RpQNVFC3Ub63IMcuYumwBzILx5Q9KT6s5GC2uXYSWaVH7XIt73Nn60ZYawCz5NcWYGsdo6Xgeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC7imnBDs6AHPa25DGRqJcY4hfyITGLzuPyQShoFJcbTcOCjdc
	D83J0Y6QfiOTUUXpFYc6Km1jJjP9NR/bij3GQk0B+a99PD14iueDFKIZ0yRmM95XO53j3n+tmrF
	j5jUgVg==
X-Received: from pfbfc30.prod.google.com ([2002:a05:6a00:2e1e:b0:845:f28c:430e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:21c9:b0:848:60d5:9526
 with SMTP id d2e1a72fcca58-84e2bb37304mr483794b3a.43.1784753159239; Wed, 22
 Jul 2026 13:45:59 -0700 (PDT)
Date: Wed, 22 Jul 2026 13:45:58 -0700
In-Reply-To: <CAO9r8zPhmLNdVgyXib-P+Ge_KSp=a8gA3mLDcpjJ5br-eXpj8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260713180153.2728382-1-yosry@kernel.org> <20260713180153.2728382-2-yosry@kernel.org>
 <CAO9r8zPhmLNdVgyXib-P+Ge_KSp=a8gA3mLDcpjJ5br-eXpj8w@mail.gmail.com>
Message-ID: <amEsBpHgIM_H7lDm@google.com>
Subject: Re: [PATCH v3 1/2] KVM: x86: Check EFER validity on KVM_SET_SREGS*
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026, Yosry Ahmed wrote:
> On Mon, Jul 13, 2026 at 11:02=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> w=
rote:
> >
> > When handling userspace SREGS writes, check the validity of EFER (i.e.
> > allowed bits) before writing the new value of EFER through the
> > per-vendor set_efer callbacks. This prevents userspace from writing
> > bogus values (e.g. EFER.SVME=3D1 with nested=3D0).
> >
> > Note: on KVM_SET_MSRS, KVM only checks EFER validity in terms of KVM
> > caps, not guest caps, so it is possible to set EFER bits that are
> > supported by KVM but not by the guest CPUID. Potentially allowing
> > userspace to set msrs before CPUID.
> >
> > However, for KVM_SET_SREGS*, check the validity of the set bits against
> > both KVM and guest caps. This is consistent with other validity checks
> > (e.g. for CR4) that check validity against guest caps, which already
> > imposes the need to set CPUID before SREGS.
> >
> > Cc: stable@vger.kernel.org
> > Change-Id: I45701ec440e4fdd8f086eb70db0c0845fb0ed509
>=20
> Forgot to drop these, sorry :/

By "these", I assume you mean the Change-Id here and in the next patch?  Bu=
t keep
the Cc: stable@?
