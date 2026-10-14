Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3758E348445
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791991146; cv=none; b=SJJ75Oh0QxnuG9o/8muavhZxwQ7SycfzYJG4XEByE2Ri35ydEJfIMysRRh/S7VfsFiHeOr7vb6A9iorOz5pO2a1ixOhM8bqcp0C231+12pMUSvJmOhOHJfv0gByf1LC2FKjXuFSq55EKXUlX1KjoHpw4qQ1OnsDR7X/43vE+hYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791991146; c=relaxed/simple;
	bh=BKamWIqFcl6MvkHKSzS9zD/R2Uz2oPHMVQ8ACHLpZfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yta7Hq77u88Y8gxztjw2trXtZBYtcHprbJ8+6wHVCZiCyMrqSGNmP2yoB83Wjm5HQJbdVvMGlOr6EGJtuUo0snJ/XCuAGUcmEmN0hhC5ludxUDqbG2QDuIpQ0UyXaCK5W6AyVdO+jMry8KuTyTYRghkRPYzc05SXfXO51o0ClgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNHafvYm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNHafvYm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3031F000C7
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 15:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791991144;
	bh=BKamWIqFcl6MvkHKSzS9zD/R2Uz2oPHMVQ8ACHLpZfc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XNHafvYmkFtkx6A4PH96CuMn8ZFQ+eCQMGM6u8msHfoaNajNChbf6dyI9kOaTTM2j
	 0l3W1YzrR8mwAHlIEoivgTeb16NamuaoATLjeS1rs9YvVJIQA89+NoVNeX+GHjNE/n
	 kWXAGDjay2WDXETxKNC54XSceB4/S3XfSIMHw22sJmU9Vxn83bYSZw3C4sRAtZXmP2
	 7nb/emv0ocMAAkop9rIF/qA+VAc6exm1A6WCQw7xz+sXhWUX4eohVQaSwz1etyigXJ
	 Mk4guGs2koD4zYej5/N/SdnU3kIeCHRRyszRJx7AfM2n6aU3LTDiZq89cxADbRN+PP
	 k6jqLgdXu/GXQ==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c2e8c710847so528993866b.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 08:19:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxLFUJBTPIBr6w4iXtk6mYgwnhLydsuSpvjsacvyIyBKFKsqgFhQghNjaBiIrDyEe1Mb76uyJc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLAIKsTTMQjh98wC3x55gfEJSj0RmeWivQml4TYQA0/7Yn6yUQT
	mFc5QJ7Gc3Ww7lbAi+QQzWl+T+4tzefvxZXvZHjNovBzUHlUswmVi8wHlD8n/HCOgFlCCEcAn82
	ptoHFoDqk9hBqkOMrUCJm20VGlj9+jyI=
X-Received: by 2002:a17:907:3d4f:b0:c2d:d408:5d9c with SMTP id
 a640c23a62f3a-c31aa024423mr1457908566b.48.1791991143734; Wed, 14 Oct 2026
 08:19:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-2-yosry@kernel.org>
 <CALMp9eSoidVrzHqTrq09LB1SCwsf5DuwAcys_q7o0TyrKM1Ciw@mail.gmail.com>
In-Reply-To: <CALMp9eSoidVrzHqTrq09LB1SCwsf5DuwAcys_q7o0TyrKM1Ciw@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 14 Oct 2026 08:18:52 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNcG=5SQK5QBC8QT2QR7K5AJtAOp16atDc5DYc0shD1Tg@mail.gmail.com>
X-Gm-Features: AclHuK-RLadQpGZYKKDsFgorRiy_o2uslxhBSul-IYazg3s2dFeFGqvVHZ-qWeo
Message-ID: <CAO9r8zNcG=5SQK5QBC8QT2QR7K5AJtAOp16atDc5DYc0shD1Tg@mail.gmail.com>
Subject: Re: [PATCH v3 01/27] KVM: nSVM: Flush the TLB after forcefully
 leaving nested
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 8:02=E2=80=AFAM Jim Mattson <jmattson@google.com> w=
rote:
>
> On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > KVM flushes the TLB on nested VM-Enter and nested VM-Exit, but not when
> > forcefully leaving nested. In this case, L2 TLB entries can leak into
> > L1. Flush the TLB after forcefully exiting L2, similar to nested
> > VM-Exits.
> >
> > Note that vmx_leave_nested() handles this correctly, as it reuses
> > nested_vmx_vmexit(), which handles the necessary TLB flushes on an L2 -=
>
> > L1 transition.
>
> Fixes: ???

I figured it was too old to be meaningful (i.e. we'll backport to all
active stable kernels anyway).

But I think it should be:

Fixes: c513f484c558 ("KVM: nSVM: leave guest mode when clearing EFER.SVME")

> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> Reviewed-by: Jim Mattson <jmattson@google.com>
