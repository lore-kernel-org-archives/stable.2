Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCF1348453
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823685; cv=none; b=RPW6FxWZ+KxaSFS3JiEYxY4ZA6SfAoHNEszMOvvLL6nelkZX95jUlDA0+Nluz75YgxUfeaKrgIfcm99n4cWIOKFpfUhWjf9qx6VPJxD4uSR5lvM4dxJpYHxoVchvinS1tn0qTPt78jYthlJNdshkfp4mI2XtEhfM85sztvKQqMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823685; c=relaxed/simple;
	bh=Zn6zFRPZqXi0QzW7YY3iv8zN7h8vLIg8vDHuWf+op1E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QnflGfMem246NC1ctFIFTmseAmIM/3MvvTU9QIq+9vFXUnW7GxVRnc/jfWdPV77p4lnRQoyhH9gu8jbzGB+wiPJ78U99ZEFgobRhKCxlMCelPmLn1axwBP5kSiyHG97qZRxihdu5dpGPbu7x+dMZKqaqlWwIktzMGgQBSggH/1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pAWBHwDe; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pAWBHwDe"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38dbf293831so3949834a91.3
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 09:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791823684; x=1792428484; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LibxDXO+KDgRqmVow7/Whkw5PtEP6MVPh2MsRLI8bpU=;
        b=pAWBHwDeCXCPPzSeHjx7RpuXvh6ZivLEmhNU/RIsqV36A1hDm51HpG8tfTqijdvcuZ
         rYJW4XlJ0AYvKFGg2yRSo7m2+0SRnb0b76HaCcapLrJkyaxSMVb6EF3TB5oteTXdbNH1
         gAeix97OMT9STD19Nu+wv2V/dS/uY85opjbXW71bTlHJagxgOXiYo+2ZjdwRfVAeKxbn
         CjYP0nrMBA8sqUfqCDjFAG52Xcuhi+BSeT6FIPllEaFlEUJRXimR5BtT7f22ThNwM8qT
         8JSA15CGIgUQoeLgyVA/yeHgIMb83tJQ5RI+5Qq7V4YBBfTGz/tF6z48hhv9uTkFClYj
         bbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791823684; x=1792428484;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LibxDXO+KDgRqmVow7/Whkw5PtEP6MVPh2MsRLI8bpU=;
        b=2z/wBaM5oicYh4b3jmofxCLnJtIi9TnaTVqYOBxn4EidR4sU8klkfQbBIaWWxDNpD0
         N0T9dFVedAdo9Wn7bmEITUOEhVOM38QG4AjV1mFPxHG97WBB+wd8nmO9D2eG3CE220oW
         77kfXqPQt/e76NrqdyrnHfpfcV4ZY469EJWVBO9xS43/Xot6bpk4k4+IHFl75RqZIqm9
         jm3NHSlyBo6YExpTNX2/x2ci7dAz7GBCuE8FDvd0gEoFdhej3rgsbwfsNG/uaYbxe/tu
         jBaKXmqm0dYmAh8pyYPYYArsF/Faih00VJ8dM3OvCVTonM2merYQurtzazcN4Z1Eh993
         CGQQ==
X-Forwarded-Encrypted: i=1; AKwUvBwNerNZkslaK6qK2FcLgpTr7p4wjLugdHme1K6usl4TsNdoWOnHnouS0R21vtNpy35Es6XEbZ4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKtqPeSlgmjWzjBoHrYz4WiBCaj+t4rb+krkQQvC+qeYo2sx3oF
	FEW3+fc07k2N4vUCf4qAXC/F7bp9tP793M4ygzWwrBcoPn+iNDUfnhKpa8BFqPyhY0+9X01Oqyx
	Kk3aVdw==
X-Received: from pjbov12.prod.google.com ([2002:a17:90b:258c:b0:3a8:a8e6:f289])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:916:b0:3ab:e588:c2a0
 with SMTP id 98e67ed59e1d1-3abe588f906mr1929716a91.56.1791823683410; Mon, 12
 Oct 2026 09:48:03 -0700 (PDT)
Date: Mon, 12 Oct 2026 09:48:02 -0700
In-Reply-To: <CABgObfY=xYUJJtYvcVhjdTXOah6eofi0O4C3J3sa60KCC+WO6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261009130450.361690-1-pbonzini@redhat.com> <as0NBfuEY-60pgtz@google.com>
 <CABgObfY=xYUJJtYvcVhjdTXOah6eofi0O4C3J3sa60KCC+WO6A@mail.gmail.com>
Message-ID: <as0PQm_PS3LC9KWc@google.com>
Subject: Re: [PATCH] KVM: x86/mmu: Cope with the SS bit being set in #NPF exit codes
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	SimonP <simonp.git@mailbox.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026, Paolo Bonzini wrote:
> On Mon, Oct 12, 2026 at 6:38=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Fri, Oct 09, 2026, Paolo Bonzini wrote:
> > > When running Hyper-V from Windows 11, KVM is seeing the SS bit set
> > > in nested page fault error codes produced for shadowed NPT.  The AMD
> > > manual is unclear about when SS is set, including whether it can be s=
et
> > > when SupervisorShadowStackEn (bit 6) is not set in the MISC_CTL field
> > > of the VMCB; in fact, bisection shows that while SHSTK was available
> > > to guests since Linux 6.18, this started happening with commit
> > > 687ee95c1b6d ("KVM: nSVM: enable GMET for guests"), which seems unrel=
ated.
> >
> > It's not unrelated.  As you note below, this is purely because Hyper-V =
only uses
> > CET when GMET is available.
>=20
> Indeed, my intended meaning is that bit 1 of MISC_CTL does *not* have
> the side effect of reporting SS failures...
>=20
> > This is wrong, I reproduced this with the KUT CET test with gmet=3D1.
>=20
> ... howver, this makes me wonder if you meant gmet=3D0? Because if you
> need gmet=3D1, the Fixes would be fe080f58dec24049 (i.e. when the gmet
> module parameter was added).

/facepalm

I did indeed.  And I quadruple-checked that I could trigger the splat with =
gmet=3D0.
