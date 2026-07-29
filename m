Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D993F86EA
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 20:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785358129; cv=none; b=kvOrbYGsC5bAlt7n3Seqqq5OUzagzY0GidItg7Uw93D6zw40rZkl434saG7c0GCKUAsuzDjYNg3cvHOUVO70XyywFPwbS3lp80sUOkX6H6evyhYVTIlQUKzt7WoXZKESaySbrzeAmSvBohcOtjUdV3WmXy9w3PnZBGnZ/F9qbic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785358129; c=relaxed/simple;
	bh=EzORmWbOjgOdnv1LZqbbycpAYD+6JKJ80AzJHP3kIpU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cEwmeorzZDr6TkZIaAJR7PBb1nbtnPO3YYxVBJZudzc66nOQFWAkGPPKyvoX70hdcrNrUmf6aM19/tuaAXX9X1wERDRlCNbc9Z5ppwLsk2AVUiK2DJ+I+MCAc47v+2aLPRpZFu3n69A86a2NH0nR2shvgQwn5PbL66k7i0MXnZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A0kn65CC; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A0kn65CC"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-847a00bcbd0so1768988b3a.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785358124; x=1785962924; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9S8u6Lrf74gQDTv+Bi/zcI3VRSjgCqo662Qkt2dHTqQ=;
        b=A0kn65CCjR3/dXOinCix/8b/RQMdi5vQm9h4ZiVlI5E9cx0+5QBRLxM0mhO9GGedO6
         BX5ZToAPM8drX9XZiPiCsuNRKiF1savT+58CQd1G+ZECoykAH+EeWSHV7FKJg348gxJZ
         ykZAtfsMfDgXRUJRT/ddBHrOscIngAiK6gJzXFR+PMNi/qvOgKzZG8PEn42OTBJJ+qlh
         0fBeGqadvnXFdU8mP2yDhQ2lmAEDswhwGy+TUiTGhUN8pBYQBi3yWSWPO2Mu0+K0zyHu
         aucO35tK8ZHkzeiY0idfsQjopD63PJPE+2wrW2D6TirvkO8c4pfMONGRQcPDw8yZ7IJL
         NwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785358124; x=1785962924;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9S8u6Lrf74gQDTv+Bi/zcI3VRSjgCqo662Qkt2dHTqQ=;
        b=OI9I9hdtvDNPBSMBLNoRU8r6FSS/9XH7j+kDMgPvrSFgmy5/nUQ1Ab0MyTxLMqW1MC
         Rz5I3ihN8D70hzT8DKY8aYLYmA6HK6qO0gK+T+W5clwQkfBFMJSb8g9u/h4+NqmO0Sl3
         AK4U5BO2fMCu/Xjk/JYsYhvDjBsILnJUbHA2UZ1ktjpQ7abUpO6QXcgCrFxWUfZ/VOIW
         UNHQyYoQJsHWNokikpRNuQSQcid8ZJi5SR9o05R/CcLjN4iit2Z/zOj2zveRYcfJU8JX
         4bh+E/w0c/7jxJ3DEatV1ZxImmAjlBR8F75wGvInKCY/H7SFOlykTZ/SweSJ7D7iSwSt
         wCDA==
X-Forwarded-Encrypted: i=1; AHgh+RoOUWA4Y/K4237BATqwc4VCP4RfipWS2w1u9EGMqMMkpbLiwc6aTPuAAc5wRMyvzQK+bfunTro=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvT+LXqvxU7KqLR2+QVp6sSRqZ8zMHP1ZKI1WiM98YwKkLVm58
	G2lola0gWebBsqpMzlWLxcIoxby+WKnctzDIda+TO3orTkjNtNmiZlvqs6KvKBxa4QhJDkeiLW8
	DiQQHeA==
X-Received: from pfwp10.prod.google.com ([2002:a05:6a00:26ca:b0:84a:3e5c:a215])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1748:b0:848:30c3:45d6
 with SMTP id d2e1a72fcca58-84eb9e810bbmr337677b3a.14.1785358123914; Wed, 29
 Jul 2026 13:48:43 -0700 (PDT)
Date: Wed, 29 Jul 2026 13:48:43 -0700
In-Reply-To: <CAO9r8zOrCMqBSnxqxnqj1M1Mmr5wMU0H9uVeNuOYKLwhvQA0Sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260713180153.2728382-1-yosry@kernel.org> <20260713180153.2728382-2-yosry@kernel.org>
 <CALMp9eRhWq+MXj8zax8hS48eZVE031kctfa=SC1ngT31iBtC5w@mail.gmail.com>
 <CAO9r8zPe0ONLFaL+ZLM4qs=8EeUzd+Gn+vzsOxryga3SsK4e7w@mail.gmail.com> <CAO9r8zOrCMqBSnxqxnqj1M1Mmr5wMU0H9uVeNuOYKLwhvQA0Sg@mail.gmail.com>
Message-ID: <ampnK2k6oL79wCzV@google.com>
Subject: Re: [PATCH v3 1/2] KVM: x86: Check EFER validity on KVM_SET_SREGS*
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026, Yosry Ahmed wrote:
> On Wed, Jul 29, 2026 at 9:52=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > On Tue, Jul 28, 2026 at 9:53=E2=80=AFPM Jim Mattson <jmattson@google.co=
m> wrote:
> > >
> > > On Mon, Jul 13, 2026 at 11:04=E2=80=AFAM Yosry Ahmed <yosry@kernel.or=
g> wrote:
> > > >
> > > > When handling userspace SREGS writes, check the validity of EFER (i=
.e.
> > > > allowed bits) before writing the new value of EFER through the
> > > > per-vendor set_efer callbacks. This prevents userspace from writing
> > > > bogus values (e.g. EFER.SVME=3D1 with nested=3D0).
> > > >
> > > > Note: on KVM_SET_MSRS, KVM only checks EFER validity in terms of KV=
M
> > > > caps, not guest caps, so it is possible to set EFER bits that are
> > > > supported by KVM but not by the guest CPUID. Potentially allowing
> > > > userspace to set msrs before CPUID.
> > > >
> > > > However, for KVM_SET_SREGS*, check the validity of the set bits aga=
inst
> > > > both KVM and guest caps. This is consistent with other validity che=
cks
> > > > (e.g. for CR4) that check validity against guest caps, which alread=
y
> > > > imposes the need to set CPUID before SREGS.
> > >
> > > Where is the requirement to set CPUID before SREGS documented, aside
> > > from this commit message?

It's not, because it's not a true requirement.  And for me, this isn't abou=
t
whether or not KVM has a documented rule, it's about how likely it is that =
this
change will break userspace.  And for that, Yosry's statement is perfect: t=
he
risk of breaking userspace is tiny, because unless userspace is getting cre=
ative,
it already needs to set CPUID before loading SREGS.

> > I don't think so, and also coming back to this again I think the
> > commit message is wrong. The whole basis for doing validity checks
> > against guest CPUID (other than the convenience of using
> > kvm_valid_efer()) is cr4_guest_rsvd_bits, which is initialized based
> > on both KVM caps and guest CPUID.
> >
> > However, cr4_guest_rsvd_bits seems to be initialized *after* CPUID is
> > set, so it only checks CR4 against CPUID if userspace already set
> > CPUID. It doesn't impose a restriction to set CPUID before SREGS, but
> > this patch is.
> >
> > So I think this may be too restrictive. We should probably only check
> > against KVM caps, which was the whole motivation of this patch to
> > begin with (disallowing EFER.SVME if nested=3D0). Maybe we should just
> > drop the Cc:stable as it won't apply to any of the stable trees any
> > way, and do this on top of the kvm_caps.supported_efer_bits changes?

...

> I take this back, I think I was right the first time.
> kvm_vcpu_after_set_cpuid() is called on vCPU creation (confusing?),

It's confusing/odd until you realize that zeroing CPUID is also "setting" C=
PUID.

> and looking closely at set_sregs_test seems like it specifically verifies
> that CR4 bits guarded by CPUID bits cannot be set before CPUID is set.

No, that isn't the goal.  There are two goals:

 1. Verify userspace can't set CR4 bits that aren't supported according to =
the
    virtual CPU model.

 2. Verify KVM doesn't try to "help" userspace by populating CPUID with non=
-zero
    values, e.g. so that we don't end up with a CPUID version of
    KVM_X86_QUIRK_STUFF_FEATURE_MSRS.

Combined, they effectively create the "rule" that userspace must set CPUID =
before
setting certain CR4 bits, but that itself is not what the test is trying to
validate.

So I 100% agree KVM's documentation is lacking, but what's lacking is a cal=
l out
that KVM disallows stuffing guest state that would violate the virtual CPU =
model.
I don't want to document a specific ordering of ioctls because then KVM wou=
ld have
to enforce the ordering, e.g. would have to carry code to specifically reje=
ct
setting SREGS before CPUID, which would be a waste of code.

> I think the main difference here is probably that CR4 bits that are
> guarded by CPUID are more "advanced" than EFER bits?

Nah, the only "difference" is that it took us longer to notice that KVM was=
n't
validating EFER.  Blame through KVM's history and you'll find the same bugs=
 for
at least CR4.
