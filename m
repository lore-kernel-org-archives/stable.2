Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497683368B0
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 05:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786944173; cv=pass; b=XjUKG7E6x5FLK4Q09DzUXrtL5etAfQN6G6MQDYEv+L2p0tigEoQDcrZ+FzigF+GHKMFigML910207FaLIUKnPlihK4a4fYs0UZUQLb/6n0/V5f1lwskv1qycGYetUme1e6pv20rcgv1hyrYixD7jELD/ULo4ucHDnPTPYvSiOiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786944173; c=relaxed/simple;
	bh=e0xnRgyREImnasAzvOkXDBgFJdJvQcsRSz9+u4temI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W4T8hIEUeJXcV+Dytm15J16aO1d7pVz3gl7028ZIdmftZR3mjPiQCS/0cKGwAPkGlmWWozldDWfBuQzuNblyr1LPM8spyy3mU3m9OrRI7RJYjUG4jki8y1rEu9Ln51pp5XrMwO06KqCE9givLCLjQ+boTZFjV1ye2AD2Qn/wS9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cloud.ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b=Y+eNRb+Z; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Y+eNRb+Z"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c16111a9b8dso27503866b.1
        for <stable@vger.kernel.org>; Sun, 16 Aug 2026 22:22:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786944169; cv=none;
        d=google.com; s=arc-20260327;
        b=fXWBiJ5ril/Wu0t260kqwg/6szF3gEMeYG9tp5npwio3JlGX4TqobFtOlsxjLJSKt8
         5Ljm6Sst6yhzu1FAXkfbl5n0jVMZWrDo4R3T2/s/Zr9Z1n09uqKMYz670uaGJoCPqcqL
         0koStnJUtbz+/YLKKRXQjsjDcdJVLQ9IZXHsRk0rEfMDkhBwLLtrtNIHXnQn8JWzh+YH
         6PVjc4wkcuFBt+bAcFT5+xEvvpAvFxQbPa8ysgAll8hIU3Rm+y9t0YQXEyQ3767FG7/V
         VWEyXk+aLYs6WRIkJHSXXjDtpg7t6nVX60AwxeHzr+S6MjHOUon+t1Q8sxLAIM0+n85j
         CqEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FkHjv4B0RhE+ZZpyo98MM2KYi9gPyH6r2f+1qXQ/E9A=;
        fh=su6pHkUROnI4YJRGgc+m1uzF0tZJFvOSh8/erAkFrwA=;
        b=RntOLP5/JRWSrZ1UN0+sGHTrfF/KS6tonpXPMk/vUjcFGoBnvNJt0eusGrkaFo6EH6
         BOVevCsxC3rHEz3i3HizQqEgK3G2T/9+qTRUNHsuQzn1TG9nzSVEkUmVx8IdRRPe72pY
         KhivUwyO0VSE+VHlEOeSv519JJV47Tr5f1GFRzHN7qbJSht18dPzX8s2txG6cQusXDvD
         rh2xnk1tjtZWX1/MKhGbEW4v5DfYpJdJW2MyUYW0pgGaiX2ZyhccZDbyvKu70tG0O38b
         Wpop6dTG7PQaoxG4g4cZUIhwqGJNoDIRyXiFsWSHgrvkRwUy7+xvvn8oDOG9RYw2CRpn
         FfCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google; t=1786944169; x=1787548969; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FkHjv4B0RhE+ZZpyo98MM2KYi9gPyH6r2f+1qXQ/E9A=;
        b=Y+eNRb+ZrH1ZKArDQ6yCs7IciNh9ooZDhNvMPyGEgQJ3pjtu0ZfcLCM+NVec73Z993
         nhWMlCo7VF5HxeV91Hvyq5hotB3VY4LHD4O9UyrtnjoifykVcaF33/wpGj8T19lXXSfa
         ZUNo0LNPZ2RZZ1j4JRVjEWY7RcS2P5OyafEDWxgo9Z6ziyQFYizhg6tn0bGTe/5JLif4
         /1ghb/YlcxWzSD5/FOErbdcyx1nrr3MS5k306a4m8u2gEZOGWLGPli9dFh+4ALAPiV4t
         kixdOZHG/cbpZetEwrogVHDqVdr6xL7dfsVuKZwpLadGtr1dZnkqzb8kl8Fc2emiXlwF
         gMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786944169; x=1787548969;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FkHjv4B0RhE+ZZpyo98MM2KYi9gPyH6r2f+1qXQ/E9A=;
        b=rxDuCYrzcm1bn9P0sJ8sfblJo4fr9sabzOzZgmbILORxPJ88h25yR6m4MTLEaLdscR
         wzuSCDjLw07BCBxcDcNHAczmbTjD7V9vF7SvotcnTdMvUXQq5MYXH/VZ6FlW+d7MvZMy
         KFwwxaWxnM2kXPkLqh5r82Pa5n+ypUwZ9xKytse6ZJ0hQKKPicCJyOTXNHvyVGpn/JAA
         6XSRS/mHmVKdGSDA+vMmrYLtujTlw0LjYZdHCW3mu9tnj8HIyMtS3nrDpDsh9VC0GY87
         zXdK3pNlbI8+NK8uJouSDkuRIQZGLNHt0qnd5rOUBoGOl3G9UI6OxM93CGUJu/bDceDY
         Frzg==
X-Forwarded-Encrypted: i=1; AHgh+RprTReKbFg1zyShD/NN811zg9xYAUeb7dnOLSxWhF8ca9wWo6mbEXTD9y40XEWL181LHHkSiwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5X5cM5psvAyBk+JTo7br/JZZCLZhIdrA259iOER4ng5hWJhRl
	70ZmTO1u4nO44Haz5/0TWvOrL5MN35jVFivaiakVBBTfNNOVOwg7IZFSITcQx8DV8WX8ta9PGVK
	awYLSzW28qYk+wBZIHH1ZrJGNoU7/Ukn1FDCjAL/1jQ==
X-Gm-Gg: AR+sD13CAzDMmmLl52yA0+YojieO3ah3E4StWDfxz9RTh6jvOtqmC3I//viSfIU9SAy
	vsNmlCXYM75/RmpyZrdxPxADe09To8cXSXG4QooJl6LVHFCdfy6a6K4q2SqfJhMbXBzwt8jySEX
	ZYiyi3uvk2qwgfUOo8gOaP7N75xJYPjTClXQsWg76u6v8/WVB8JdXwHMXJ9LxI5uXEtoULPoJf4
	41DgxjJjofECIhyMa8kxK0jSlRinYrVOtwtvHlAusdi2BC543/Hws+QREDNoDhjwdX/NoQy/TPo
	RPaWFSePUCvAx/3cMSKTpl66gCmJESvOhG/tUtdY8g7BsfFu6ZsVFaKyMXVmiq7qsEVt97aA5kQ
	gaQ==
X-Received: by 2002:a17:907:c1f:b0:c12:e4f7:9a0 with SMTP id
 a640c23a62f3a-c212a17c930mr480247766b.2.1786944169231; Sun, 16 Aug 2026
 22:22:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814100652.225499-1-jinpu.wang@ionos.com> <20260814193000.15@kernel.org>
 <CAMGffEk4a8cF4utrMYpNvbcxBvuEhPnTY33_3GGs3RU4uy52vw@mail.gmail.com> <2026081730-denatured-spiral-61b2@gregkh>
In-Reply-To: <2026081730-denatured-spiral-61b2@gregkh>
From: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date: Mon, 17 Aug 2026 07:22:36 +0200
X-Gm-Features: AcwNN1UcfQ9L3xnE1pskOYHuvw_OyAzhgLCvraIVx5TVR-KniA4RytsQeKRCiI8
Message-ID: <CAMGffEnmhVpdLmtqFjX0OFWEZtEenCT1mbRm4DdmJDiaBnhNtw@mail.gmail.com>
Subject: Re: [PATCH 6.12.y 0/4] crypto: ccp, KVM: SVM - missing SEV/SNP
 platform-init dependency + 2 bugfixes
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org, 
	dmitrii.omelchenko@cloud.ionos.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 7:01=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Aug 17, 2026 at 06:51:27AM +0200, Jinpu Wang wrote:
> > On Sat, Aug 15, 2026 at 4:33=E2=80=AFAM Sasha Levin <sashal@kernel.org>=
 wrote:
> > >
> > > > Patches 1-2 are the missing dependencies of commit 3f8f0133a5fc
> > > > ("crypto: ccp - Move SEV/SNP Platform initialization to KVM"), alre=
ady
> > > > queued as of 6.12.97 (bb1c8464702540 on queue/6.12). That commit
> > > > dropped SEV/SNP platform init from the CCP driver's probe path,
> > > > expecting KVM to take over, but the counterpart commits that give K=
VM
> > > > that responsibility were never queued alongside it.
> > >
> > > Queued the series for 6.12, thanks.
> > >
> > > --
> > > Thanks,
> > > Sasha
> > Hi Sasha,
> >
> > Thanks for queueing the series.
> >
> > It might be worth adding a rule for the stable-kernel scripts to
> > ensure they don't pick a single patch from the middle of an upstream
> > patchset. This could help prevent future regressions like this one,
> > where a commit dropped functionality in anticipation of a counterpart
> > commit that was left behind.
>
> How do we "know" a patch is in the middle of a patchset just by looking
> at the git tree?
>
Hi Greg,

I agree it is difficult to know purely from the git tree. For my own
automation, I have added the following rule to my Claude.md:

Before backporting any commit, check whether it's part of a
multi-patch series and, if so, pull in the whole series rather than a
subset:

  - Look for series markers on the commit and its neighbors:
Stable-dep-of: trailers, matching Suggested-by/Reviewed-by sets, same
author + adjacent commit dates, and a shared subject-line topic.
  - Walk both directions: check commits immediately before/after it in
upstream history from the same author/topic, not just the one commit
named in the request.
  - If the commit being backported removes/changes behavior that
another sibling commit is meant to replace (e.g. moving a
responsibility from driver A to subsystem B), verify the replacement
sibling is already present in the target tree or is being added
alongside it =E2=80=94 don't land one half of a two-sided change.

The reason for this is that we queued 3f8f0133a5fc ("crypto: ccp -
Move SEV/SNP Platform initialization to KVM") without its counterpart
KVM-side init/shutdown commits, leaving 6.12.97+ with no code path
that initializes SEV/SNP, which causes a host crash on SEV-SNP VM
start. A series-completeness check like this would have caught it.

Thanks,
J
> thanks,
>
> greg k-h
