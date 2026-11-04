Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793836767;
	b=cS64P/slBonAJ0vN6m6MsF9iIw62B/o2KzGJhhbUKkRnh2E3yA8LipVY0+pKGtYjNJvm
	 7eqKFP3MKV5qT6g9vlpH/ijw+Uz4tx0/APNjnpmUGaQtxaei2TAoYNr2mlp5Nhq/ujR1M
	 9OYQSxgrgX4L1s8bqqJw/eP4C0lkL5rb1Y94N4uGkaFfIi+LNVxdCQCsw+lkKOI/8c2+N
	 hqm1JpK/jVjYOGPokN0XB0M77luMiUJ9ShUk3eui/HBDYctOO3XT7wloZPiZ35gYDJGOm
	 RvVFDm5lYtpakHAL0OQpqymTh3kTIGREHy32Bbl0ZXekf+q9QQ9snhkpb3DCcWUAYyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836767;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dkiq8G97zH+ba7bC4JuE4QsITtbGVvYbvH0HqLcYoWQ=;
	b=hvd9ONrK6u/AdCsRI225UxQZWrR92msGEvOxV8NzKZKVuR5ZccRWJj7RdU21lc8SZGU/
	 lPYBF5cFj2IVW0RZRFleO+8vyU4KtA4F+rKeF3JHr9qYLR5xWb7Km5Y3xKSaH8lymUMQ7
	 CoQ8ZjpUP7O7JPlScmq03nDLLT0TuWT5967FaUvReIs0Abj3fJ/19wH0O3gPy1E4QGvXj
	 5msCFtwidu6bPvbA/qy4TntW+ZNPc1jlucLGwSJ48ouCW63qp2S68nWy2VFkwNcYj7AZ8
	 XGpUFBXJeeCkZU6YkNlYancKKYcR5aTfkfEmgEphSOAkfOV3umRurv852IwKi+sVw+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Vc9LIe1U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2097C606A32D
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 23:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2097C606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Vc9LIe1U
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b579ed8da6so2199a12.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 15:59:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793836765; cv=none;
        d=google.com; s=arc-20260327;
        b=p/FtWKdDNXhY+mQQ4+0a41E3s9TzXSAfBUfxVXut1YhYWtQBOhjG9LtUl4lSNOVMOl
         6re3ewBQRfVROn4AlxHUklW2Yz03thDh6QgXZdZnd0E1/1SQEWXj6rTb2OEdbYawD+wY
         jLy/WPOX0qrLRMt0K+f54FUAlqIDEFGCoIpNZJeQbragcrkNFxWEnFCXh7O0Zp9AEzcz
         H3NUXnbMIvq1yp+8xoUaN4R9rmqETjUMW0q9geRIBt+8nBvnAnMRfePCxMNJ9VnHStK9
         czhzc4ps1+z1JsDxI5208uXG/ejlN2d0CH+O8rdaZBD18C1v2SEcXhkQCVETpkgsxAJm
         Ot9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dkiq8G97zH+ba7bC4JuE4QsITtbGVvYbvH0HqLcYoWQ=;
        fh=wcPrmAGjsypiOAY+HHUab/QecZepJ8bsFcf8NmHFsTI=;
        b=UiHXbtoraWJC20hbtOj14/wnwnaQAMf2KPuBvjIToC0yVm3SqobDMKbRcNr9NwpJpT
         ogqmgPMtBrZ76kXsEfGSzk8xl9YEd180Lf/wiYW6jcw8Bb60xc+fpKu9Lb+T+H5GFfKA
         1QgFOQTgsA13CeFh2ZnAHrYIy9Irs8/jkXHjB2F2MmLqrCrNWCocPu7Iw57GnidKnNUl
         YtkEnPA8QXpiuRXQ1OQwrnxRXFAH7z4WDyyxJtD2bu6V0jd+52mnjo1jf7AmtVQaGqeV
         mAVD+MTt49aSKC4weQ17E3USoeispGn8/tIFNoStdgAeQnQXZLmkjh7fDz4vFccQAoeD
         5y8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793836765; x=1794441565; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dkiq8G97zH+ba7bC4JuE4QsITtbGVvYbvH0HqLcYoWQ=;
        b=Vc9LIe1UafFwZGai+igL6zs/Uc1hhnfx4DdJRxwvpr+7zSjSTZKN1ETxXX8zGMpdnN
         q5w4J1gdbeRebvVAKTHV1XJ/mljgTwBZ26MEVrWaGU4MMl06uzqTt8jN7d/RJR3KB3ZP
         FPNqjWU9A3ORayG155iRJlNh1r3+/Qggc03cHKppDCDHulNi0aosghQ0oCIDY8btbeY0
         PFlorf5a4pYeuFL393kwZNK+irgZm5BqUJ+3YtxCyo1OM4kxaXaOEweJS6CJiZAMM6OO
         YYNrzPf2HVDHqDhDSZTrHaYOSYnNBeENCBZ74dmXTZxIFWJi0FyMnHV6uTDdwSTeBSiF
         /wvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793836765; x=1794441565;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dkiq8G97zH+ba7bC4JuE4QsITtbGVvYbvH0HqLcYoWQ=;
        b=g8cNNFTIdBqR+VoCbEUHRI6pwcW9ZNRDhI5sMBOiC29lmCeBBpFZXVH5mjdL0gdfG5
         zd0Nf9S7Co5PvUMvv1WMplNdIg2Wut2ak/taMWayN+YETgtbIouOudwM/HqtKlv+IUFb
         RvoJ+GoqOgLPxOomVyIrv3LzHx7bAOj8l6cykaX27uzwM9HysIjoyVCpTiZY23HzJRk3
         qepz75n5AoA7exK/BhtZ1kiAt0FusLuRLwL3R3ozYQM8dSGuoIxnvxNmMKb7DL+gBijJ
         uL+1W6LrhmSaWDOifeyoO/VsHOswB5s83aEvFHQX6p/plq1RVEt3wiNd/nKI2QxLh7rP
         gYiw==
X-Forwarded-Encrypted: i=1; AKwUvBwNlBzrmk8LnQmCK00TO1p+suJ+IPNsK3zJBwQ+ithfq3GyNarp10HnUy0ApyH5uvtgo+6CfRI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+w50G7GIogsNpydVD/U6fbvaj0EeHQSv/3glpcnWk7lndrueZU
	3yJS07CFbV2k3KesLzmoXk5e90h0QfzuZNs0/hl9kv0aYEPuBaMthG44bW3sFXUC23UiqhtLm40
	92TMsuH+aRqaUWftPVOm7wcojIWn8bYFKi7qhW/bJ
X-Gm-Gg: AYBFou3/dtWb+WKNbg7cxGYQwfFEssATbW3edotRmzXuVncJG14dDTdbQEOLx4q5rPl
	Vygrw2g+9a0C84yLPyRR+kCflc5SrQeToF15ls7BidFHNWn5V6wT5A3hMU3QxG7ipXFRWCakv3v
	9x8TUw1AZp8625omP44hKhMG+AYtDLY7IbwZ6pErJXG6GMnJ01Ggs30YlT+RzbXE51LI3E3zeWz
	fWima437INk2NV34r9VlLy27/YKWdCEMX6RKdgLspPGvMRdguPr+/xVSwPnVM9wqWGNtncBnxlF
	cGBQYY2j3OzxPJVVwFBe/VGYszXsApAN1uZlaQ7dSK1v50hpl0umwP0J+oPis6yXSkYKynuNKT3
	NAUrDRxdtwPK8tK+Sqj4E2RLQwGXZzqs55swF
X-Received: by 2002:aa7:c952:0:b0:6a6:8513:7e14 with SMTP id
 4fb4d7f45d1cf-6b57cdc6385mr16040a12.9.1793836764713; Wed, 04 Nov 2026
 15:59:24 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020234535.3182385-1-jmattson@google.com> <20261020234535.3182385-3-jmattson@google.com>
 <auuZcZhBhrkZd9qM@google.com> <CALMp9eTpWP6XSYPJQjBwPsNWmPzLNh+EDGivMFZsUnixqpGkVA@mail.gmail.com>
In-Reply-To: <CALMp9eTpWP6XSYPJQjBwPsNWmPzLNh+EDGivMFZsUnixqpGkVA@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 4 Nov 2026 15:59:11 -0800
X-Gm-Features: AclHuK8_LY-OTUKdxgAEiTiBoWtOGamSflwZcfkOr9pBxGweoCUz57HuFcean9w
Message-ID: <CALMp9eRU6G-spTgzkKdh6E=U7omQsFDM_2nH4KEPZieg1e-zgQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] KVM: VMX: Refresh LBR MSR intercepts on full MSR
 intercept recalc
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Like Xu <likexu@tencent.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 3:49=E2=80=AFPM Jim Mattson <jmattson@google.com> wr=
ote:
>
> On Wed, Nov 4, 2026 at 12:45=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Tue, Oct 20, 2026, Jim Mattson wrote:
> > > Re-apply the LBR MSR intercepts in vmx_recalc_msr_intercepts() if the
> > > LBRs are currently passed through, so that changes to userspace MSR
> > > filters are reflected in the MSR bitmap.  Unlike SVM, which can simpl=
y
> > > rewrite the intercepts in either direction, leave the bitmap alone if
> > > the LBRs aren't passed through, as a filter can only force intercepti=
on,
> > > never prevent it, i.e. the bitmap is already correct.  Note, clearing
> > > msr_passthrough to force vmx_passthrough_lbr_msrs() to re-apply the
> > > intercepts on the next VM-Enter isn't an option, as doing so would
> > > leave stale passthrough bits behind if the guest LBR event is no long=
er
> > > active.
> > >
> > > vmx_recalc_msr_intercepts() is invoked in response to
> > > KVM_REQ_RECALC_INTERCEPTS, which is raised on MSR filter updates, but=
 it
> > > skips the LBR MSRs, and vmx_enable_lbr_msrs_passthrough() does nothin=
g
> > > if lbr_desc->msr_passthrough is already set.  If the LBR MSRs are pas=
sed
> > > through when userspace installs a filter that denies them, they remai=
n
> > > passed through, and the guest can access them without exiting to
> > > userspace.  Conversely, if a filter forced interception when the gues=
t
> > > LBR event became active, relaxing the filter leaves the MSRs needless=
ly
> > > intercepted.  Either way, the bitmap remains stale until the guest LB=
R
> > > event is torn down and recreated.
> > >
> > > Only x2APIC MSRs are exempt from userspace filtering (see
> > > kvm_msr_allowed() and the KVM_X86_SET_MSR_FILTER documentation), and =
the
> > > filter is honored when LBR passthrough is first enabled, so KVM's
> > > behavior shouldn't depend on whether the filter is set before or afte=
r
> > > the guest enables LBRs.  Drop the LBR MSRs from the comment claiming
> > > that they can't be filtered by userspace, and clarify that
> > > lbr_desc.msr_passthrough tracks KVM's desired interception, which may
> > > not match the MSR bitmap when userspace filters are in play.
> > >
> > > Fixes: 9254beaafd12 ("KVM: vmx/pmu: Reduce the overhead of LBR pass-t=
hrough or cancellation")
> > > Cc: stable@vger.kernel.org
> >
> > Meh, this isn't stable material.  Unlike SVM, where LBR virtualization =
is tied
> > to a pile of other crud, if userspace wants to filter LBRs on Intel it =
should
> > just not expose LBRs in the first place.
>
> The functionality is not equivalent. For whatever reason, MSR
> filtering can be modified dynamically.

Oh, and, duh, MSR filtering doesn't disallow the LBRs; it just
reflects them to userspace.
