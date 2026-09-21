Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888AA33509B
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 23:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790031666; cv=none; b=uGqMwSZKvunDnt5zGhO4CGXajiUuw8gocR1jZLfGA6fhmzEXwG1hlp9j7vGAbh0QHdWtsa0ojgW3bYaNtHOZkIQ7sZcEdVEAfxI3Skz3H588567RDM8aW37d0a0MS9S66HDg79osIE6TkYnhWtHLK14v/aIRtQnp4gqCZxie2OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790031666; c=relaxed/simple;
	bh=EjC+4qtN4o0XkUeuqg1YL0w5wvMKJ3skAJAqWc2Dp3I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DdonJ1MJ3487/FUDZUdtSUdE+lhpNYP8VUav0D6lZ7KUQbmvURl05gwJ+eYlBk6pFT0IuACV2dph2s03KKFOvvpH8ZY5WDOPLS5+6X+4EloyvGbcGck88AdLkgY6G4PKlQHPusaAgGdmNLQvHge6xAxuVHfy0w4cR+y6wWsEF/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VRY0TVuW; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VRY0TVuW"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39de4e72b33so6418000a91.2
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 16:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790031665; x=1790636465; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IAWEuivCKeaJ1rv2SoBZaEfOqut0K+iQG7gFdMAjrJE=;
        b=VRY0TVuWK4aQKuMU4Si5pe2Yl/arBOfCJdh0eDK/WWElE/XzDShwQRXmGnVFpGfO6r
         HFBuYkxkURyH9l/ZBaTRM9KGaUyaNyY4IQodErM+4t+aPa2IAPdRYAqffEVYmnxNGMES
         u334FrEkWAC6a53TQPU8Ijxe044R+nuapAFxozdIJAZPRZcrWNtJksYwfdGHwQ4YVf6c
         BM45yBwX+WrCmwIIxaQlcr8UkIOGA4YUndnZUwlQUr9AKwTQUqyrdJU2qUSwvxCrxlVJ
         1QqxnJu12AzY3pnJzXrVM8mHGkoaHGC/kO1mKU1vQ/zFd1DyiGE+cDKhqtjbzWrxnLJ0
         jL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790031665; x=1790636465;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IAWEuivCKeaJ1rv2SoBZaEfOqut0K+iQG7gFdMAjrJE=;
        b=Ry+sgeA8/G8eMFpZW9Togj3btH0oYoj5G3lQRqEUeac0XT0FTFjczEYKkTMZG62Tdc
         z0HoLv2v1cPoz9mvgJH+j0bb7sr4u4pl6/NKEHt5Lcvs6NwgfBwZX7Tu0Xp4EAllntuS
         5iEJrdCWIidT6xBpd04NHtpZ73kFXy7hrfWoLQJLRv00P9dlgvICRkG5mcGZsA5tayQt
         leuEmH9isjnk4QHzcDPlKYIjMAGywCWToF6smvfyRaaoEzPr8c8SzKZ0emMWUGMUI1vS
         0OeoxhfefYT+C8ItXOQXYUiEhFjbepGLDhZXiG5H1JvyAKa2DgePGEr8mQ/5sK9iz7x8
         tlkg==
X-Forwarded-Encrypted: i=1; AKwUvBwSqy7zYPkumpglJ0YxqX32iMDJg3vZwVZPQscRoaFTRpci72VaE6s8pX4VV6b05yGMZvJxnYY=@vger.kernel.org
X-Gm-Message-State: AFuF++m+B4Or60xrpeAEmgjnHrpsQHimxpvEjnK0U9yGnAti827/zql2
	FS9fR9uI14A8VKI2NRcs3Wwto96nBVHQjFNQUnupTCCkvvUqNQrgbrpf24+3zSbmLk2m1rYxiDy
	rGOKgRQ==
X-Received: from pjbku19.prod.google.com ([2002:a17:90b:2193:b0:3a0:23c6:94f0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:384c:b0:39e:4c80:44bb
 with SMTP id 98e67ed59e1d1-39e54df6c9dmr17859783a91.30.1790031664580; Mon, 21
 Sep 2026 16:01:04 -0700 (PDT)
Date: Mon, 21 Sep 2026 16:01:03 -0700
In-Reply-To: <CABgObfatLAp3AsPktQVtVq0MgeJV1Bw+54i5LKye5KzjVPqbyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918094322.152817-1-pbonzini@redhat.com> <arG1Nh2yuMQyAdhV@google.com>
 <CABgObfatLAp3AsPktQVtVq0MgeJV1Bw+54i5LKye5KzjVPqbyQ@mail.gmail.com>
Message-ID: <arG3L3TL5_xCBtc9@google.com>
Subject: Re: [PATCH] KVM: x86/hyperv: do not overwrite hc->ingpa for slow
 SIGNAL_EVENT hypercall
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

+James

On Tue, Sep 22, 2026, Paolo Bonzini wrote:
> On Tue, Sep 22, 2026 at 12:52=E2=80=AFAM Sean Christopherson <seanjc@goog=
le.com> wrote:
> > > diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> > > index 9f5adcd26cba..e3a8e8236230 100644
> > > --- a/arch/x86/kvm/hyperv.c
> > > +++ b/arch/x86/kvm/hyperv.c
> > > @@ -2501,6 +2501,7 @@ static int kvm_hvcall_signal_event(struct kvm_v=
cpu *vcpu, struct kvm_hv_hcall *h
> > >  {
> > >       struct kvm_hv *hv =3D to_kvm_hv(vcpu->kvm);
> > >       struct eventfd_ctx *eventfd;
> > > +     u64 conn_id;
> > >       int ret;
> >
> > This doesn't apply to any branch I can find, and there is some unnecess=
ary variable
> > shadowing going on here as well.
> >
> > The actual change looks good, but the diff is wonky.
>=20
> You're right, I probably generated this from the wrong branch (or
> machine). The right patch is at
> https://lore.kernel.org/kvm/20260918135030.171564-2-pbonzini@redhat.com/.
>=20
> (BTW, I would like to talk about memory attributes and kvm-userfault
> next Wednesday... and whether those are two different things at all).

By "next" Wednesday, do you mean the 23rd or the 30th?  I want to make sure=
 James
is pulled into the discussion as he know a lot more than I do with respect =
to
Google's use cases for KVM Userfault.
