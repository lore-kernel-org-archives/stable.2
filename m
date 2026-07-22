Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1478A17A2F6
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 20:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784753257; cv=none; b=ZJzjzmTQHa34VUo4mvptEpxxQwveseUf4mmuanPQeBnD7olLrtUnBMu9E4auN1b+/HPw8nPRpZNZErAObpY+WVo2G1aRn6md3YZms4/IHZZ894nTJkTtYGDGMcIugzGMb9X3RMSnfUjhZPzLEt0wpT+ln7GklMafCNKKA5xbWZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784753257; c=relaxed/simple;
	bh=nB9VrNzuWoGslIOdZzdpFkq9H1Wpjrd6gX6tLwuLbAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zf9fzqUbORA9o4pcY9qj9HW8ITRXY4HMuKfXROFx8I6yoh1UCJjfp/fNxs6Bsrp+7pD0n6o+UEkD6zy5TPmvmdeEfaedtBKzWha/6Md8YRAK9xCOCZ8EFL3Ovc29Ewz7X8Zh/ye2bKQ30I8wjvo5FBknqfgQQvOrtRPFXKyYBAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRKEtdaT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRKEtdaT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08931F00A3A
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 20:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784753256;
	bh=cdRr0jmB/T9AWrg/YvJSx1PCAp8xSH/+1A1h2U0ng20=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TRKEtdaTOqn+oWgi8aBjZdtcR0DWnWZ9Kg/giHO6fiS5lYlJymFsOT0Z6dZnN6Y22
	 /eBouExB1LEyuie9kmPCWCbKV4+CwRxqygxSsAhsPxvvtRwpsFPH7rXRwlMd8vvGcq
	 4dzz9ZrTZC0kjHlhaeP+a6klmtkcWX2rE3Qi6YEJMhISdwMGZtGb/uBpKLCzhnm2Aq
	 kBSNDefzzWCQj4p4yOzGQYQ8bWDRMWyNbvP6jM2yAnRVgtV/MCuHi6flFObUiwTweH
	 qFtaIu803Xwy5EaeOqsBTEt21muygZuAvCXSe+V1iiy8HmmDBUP/GefooqcyCxy94I
	 8owH3pvRyEqgQ==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c1671ec8692so61662666b.0
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 13:47:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqTcrnQCs08y1Oh52paa9BkCmbuIECBOye/ip9ZqLLKD1TRtXYfUAuD1eoqpfbOo1NqO8vdSOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFrd36DQKno2lBrX3rNVUdPj5ueg7KYL8RTLS3z1xo/bF5M14i
	xnkhjiyxaSqDknnvHsAwp4gbvsW5/bSshF5bAj742j/I9A4mOlNrcKoeHLKgAfxgGeOTZ417qcn
	db4jbZDyPoq+yrLAnAQdor4jzx6RRm/I=
X-Received: by 2002:a17:907:72cb:b0:c15:c117:da40 with SMTP id
 a640c23a62f3a-c1c508f9d6emr20165566b.44.1784753254923; Wed, 22 Jul 2026
 13:47:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713180153.2728382-1-yosry@kernel.org> <20260713180153.2728382-2-yosry@kernel.org>
 <CAO9r8zPhmLNdVgyXib-P+Ge_KSp=a8gA3mLDcpjJ5br-eXpj8w@mail.gmail.com> <amEsBpHgIM_H7lDm@google.com>
In-Reply-To: <amEsBpHgIM_H7lDm@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 22 Jul 2026 13:47:23 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPE=P52yXeEgs_7xo3pXsVKNHJcCjNeAsdZ6TMT0weqDQ@mail.gmail.com>
X-Gm-Features: AUfX_my3XTJXEn2Up3EujXSNrb55q0kPbfmaJfjDaXww6yDmGrqsABMSCiK4L00
Message-ID: <CAO9r8zPE=P52yXeEgs_7xo3pXsVKNHJcCjNeAsdZ6TMT0weqDQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] KVM: x86: Check EFER validity on KVM_SET_SREGS*
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 1:46=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Mon, Jul 13, 2026, Yosry Ahmed wrote:
> > On Mon, Jul 13, 2026 at 11:02=E2=80=AFAM Yosry Ahmed <yosry@kernel.org>=
 wrote:
> > >
> > > When handling userspace SREGS writes, check the validity of EFER (i.e=
.
> > > allowed bits) before writing the new value of EFER through the
> > > per-vendor set_efer callbacks. This prevents userspace from writing
> > > bogus values (e.g. EFER.SVME=3D1 with nested=3D0).
> > >
> > > Note: on KVM_SET_MSRS, KVM only checks EFER validity in terms of KVM
> > > caps, not guest caps, so it is possible to set EFER bits that are
> > > supported by KVM but not by the guest CPUID. Potentially allowing
> > > userspace to set msrs before CPUID.
> > >
> > > However, for KVM_SET_SREGS*, check the validity of the set bits again=
st
> > > both KVM and guest caps. This is consistent with other validity check=
s
> > > (e.g. for CR4) that check validity against guest caps, which already
> > > imposes the need to set CPUID before SREGS.
> > >
> > > Cc: stable@vger.kernel.org
> > > Change-Id: I45701ec440e4fdd8f086eb70db0c0845fb0ed509
> >
> > Forgot to drop these, sorry :/
>
> By "these", I assume you mean the Change-Id here and in the next patch?  =
But keep
> the Cc: stable@?

Yes, just the Change-Id.
