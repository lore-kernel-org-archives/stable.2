Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23364BE43D
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 19:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791918013; cv=pass; b=TCoYs4/ILRTlTMql2Si4V4GE22YAuc6X9No1E2YxiWl+15+tj+NFAZ/u+NQ7NnCwPPLwqtIUecy5/ox2Eed8i+oH22HCitL5nJelqd4uy/WJLZNbb1jHx1Hrpkx6011072IOU2UeAmssppUr/6A1ONEyLhcXNEwga0WJDhE3Pa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791918013; c=relaxed/simple;
	bh=fZ4uddyq93kdUrPDDPzN84geaPqliQDSF+n3XASEkPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a3aAm2OjxBYEmIyGVloJFyas4yUsBv3yrOPa8EA6qPdj/fCJFwMOrgp/aEhYaMvM6Lg0nguA4+accM8+X3LhteyqQJyBIV3mEr+Ug4EY+qXE8Z1aCqkKSjwqOsc8n0a5AjdBdJYLtO2uv2CUwnGjZCCml3XEmhUH+xG9JbL5zuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v2hzQUNk; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v2hzQUNk"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b1b12de661so29727a12.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 12:00:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791918010; cv=none;
        d=google.com; s=arc-20260327;
        b=cg3lU8iMCTU7ulbb80uWu5NbAeJpqvgcjaWnPaH1QphTPZUA4uEYJ6irVhmD7oDGU9
         4PHaOydzcUdcWo+PI015r2d5Uy4fdzVsNefLHrDiqF270txaL7kfm5ItuxzfNUOdbihQ
         oGj7VFgkT2wXQI+2CM1h9wucdaZxdMlXbINI/kMkn0tBJyMbWDcQMl21E4RuQwDG+OY2
         DvYKDTzvTJ2bqEaRgQyf5LBgXtLiACd7lGrt/gtDyndkm/r05cJDumzL9x42iRi909aK
         0udjHT5k4E3Zbp446zrE1mdtxiQ+7nU0BB/9fsb475TLUXzweeStoG5BHT8V6CSTDEg/
         N13w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+2TmVY4407RNY3aYogF/mtX0taIxsikxKl2uKNeM1jE=;
        fh=oorjl/rpY79O8AOdUzMv+uq9YOA+pKIc36kxtQ6l+ks=;
        b=DqNsZCN4b5wZm+adZlgjx1xUeHUzh0af6fjC9nzyRoKtRKnG+A5PEGdVRLz9+C4RkB
         SVc3/9ew1neaBgXsnWJbRIn8B0nx2i+bhGf5KkTPxM5+YIPLAbtOUBR1tZS/A2H8i1+A
         hp4dGW+H6GdTbsRDLeBZZ1rTUgchDtWzkO3AtiSZgvy4z1ypUFN2TPM4vZnkKAeqWOf+
         DNH1VUUcZG4R0ZHl5mTQl1uciSwHoP4T2nEWnDAxQXPPslqMNtBy7VHv/U8gKsq6p1AZ
         DZCBPDDZjY2GZ/SHc67lMQVNUV8VPyHTMEVi6d2rUSiNWPPygppTLfi6p1ot9XDv8h3r
         LveQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791918010; x=1792522810; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+2TmVY4407RNY3aYogF/mtX0taIxsikxKl2uKNeM1jE=;
        b=v2hzQUNkuIvEveZpIsJ77vpV3lCuvmGKnXBClwSqlxxY0m2WCvdYquUZIq4OIhqpue
         7/xbp9EZ5P/avWFl5g3JzhyOqJv6mpx59BAy2P8/0XBTaV5Tl3ycS9SunIUt/+8qJeDx
         knMATjY2CPFNPRhdLrEjLlJFSnsJ5OavXWIjsiRFNTIamZMd2D/cfrXdWGxJX+kgzu3D
         WZinIhLuKh3m7OiTRCUG6Vd+qACky2PlqzwzcxE0zAezglew/hPKp+pN4twF9toAeoVn
         7xh+Jf7rtiEECFKZZYgV1uP6RtLgIRNS5+dBL93l8kyqJaqsKbOwQLV1Ql1huz8phxqc
         3LjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791918010; x=1792522810;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+2TmVY4407RNY3aYogF/mtX0taIxsikxKl2uKNeM1jE=;
        b=JUQB52EdJ+aMaUDQi+yDc0EF7CQaRrSzcDvqbOXRiD01caozga+RxVTsMX0BfYg9BG
         h6hDi61dfCkc0IwhyFWzA9DY9BZUU5tMuTwxiWhe8q2Qb0XEdbMuXBJSZFKW3hKAjE3h
         1f2azkhuGQp+mY7pwN9k2nQg/OPl31DGvkxgzwizA8iHyT4SYonhCLgTSmOM8gfZswOF
         kDQ2UkC1XT6E+IBqXGCwVxCqB2wNXQr8oY9b5jJRtYBL966HneyVHHjIcER/mNU41dRR
         zsqpBG/BDkp8jIrfAtpSshzzBNFS2/ymvzsKVi+Jx6kk9j3X47aUJiDZJPwS4IcfsQDm
         eDvA==
X-Forwarded-Encrypted: i=1; AKwUvBync38+x4EWRKFcXPw07p7OXDjhn2X4UJEkFNht/4i39m/Z8DWutdEhB0DZQGfjilYBms6sJBU=@vger.kernel.org
X-Gm-Message-State: AFq9FYI97jMAhRAEvK+RgNCjjyLrzg+O887BqEtFq2+/73m+wf2p932L
	PtKGd1O8R322MPYuLOZ7NQfdr/XUWRyIvyLQfRurM4IwWUYkLEIGfAorBIQOqOkbAnNB7jVp+hq
	ZypLtEXc9B/0LEKXr55rrPnIjdSX/56hvcKnq1NhY
X-Gm-Gg: AYBFou3jsiZHJpjSo9nAWpE3VSZhDBlGHkD6oR1xLzvK9UOmNobHtDLW7djrQ3z9k7+
	Rw54iwJi7F2R0ncjCXYEjmK1oFT8YQfjzPEHd9ZyLt9lpfXTGOOY70POAPv9jQX71zGuWkOA6Sf
	au9RNwn7WbmkXnn9iwefWfceES7KwZvakE6dnLeBDog3/sEKeyMdVXfWKaSJSkbEoMAhYZa6PID
	FNE5oHlQVIXPc2aalQLqik0YcgXvQdJ3a6eltLdQ5/a75nNDm2wiotCRqQE+iITvYf1SwQ3+uui
	I3IpubXyDihksUyowjDpMqfCryRd2HghL+9DHtsbVstQhUKHnSZ0KErlnLKY6sqBKJw=
X-Received: by 2002:a05:6402:c4d2:10b0:6aa:128c:36ad with SMTP id
 4fb4d7f45d1cf-6b199a6f8c9mr124512a12.10.1791918009269; Tue, 13 Oct 2026
 12:00:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012224736.2306637-1-yosry@kernel.org> <CALMp9eT6eJSDaJVJ_1mrn8-sP6F88q-OcGrEgUWy-YpAkuA9vg@mail.gmail.com>
 <CAO9r8zMsih9vRJFWgbE=bgWAqBzwPO3KJiAyBVA_hJBgjPp6mQ@mail.gmail.com>
 <CALMp9eRRb_8vbm3YM9dw7XbDsnjQ1wRYK10oNq4JAgkUZdpFLg@mail.gmail.com> <CAO9r8zMBxWT=A7+tFUTtDiTu0GNodQEiGw+EKRLesQghk9aBSg@mail.gmail.com>
In-Reply-To: <CAO9r8zMBxWT=A7+tFUTtDiTu0GNodQEiGw+EKRLesQghk9aBSg@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 13 Oct 2026 11:59:56 -0700
X-Gm-Features: AclHuK_85A6WrUV9oaB4jqIb4cM1YcK9_2Ebbr94ohiYvgrV5gIw2KetiZ5wyYM
Message-ID: <CALMp9eTqEWczivrxr06hhGg=519-POMRiSTg5WzRieuXZzTK6Q@mail.gmail.com>
Subject: Re: [PATCH] KVM: SVM: Update tracked pCPU on pCPU switch
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 11:11=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wro=
te:
>
> On Tue, Oct 13, 2026 at 10:55=E2=80=AFAM Jim Mattson <jmattson@google.com=
> wrote:
> >
> > On Tue, Oct 13, 2026 at 7:49=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> =
wrote:
> > >
> > > On Mon, Oct 12, 2026 at 4:58=E2=80=AFPM Jim Mattson <jmattson@google.=
com> wrote:
> > > >
> > > > On Mon, Oct 12, 2026 at 3:47=E2=80=AFPM Yosry Ahmed <yosry@kernel.o=
rg> wrote:
> > [ ... ]
> > > > > @@ -3892,13 +3893,22 @@ static int pre_svm_run(struct kvm_vcpu *v=
cpu)
> > > > >          * - The new VMCB does not detect a pCPU change and runs =
on pCPU A with
> > > > >          *   the new ASID allocated on pCPU B, which is potential=
ly used by
> > > > >          *   another vCPU/VM.
> > > > > +        *
> > > > > +        * Note that dirtying both VMCBs is not strictly needed, =
but the per-CPU
> > > > > +        * tracking is shared for both ASID and clean bits, and t=
hat CPU must
> > > > > +        * match where the ASID was allocated.
> > > >
> > > > Is dirtying both VMCBs not strictly needed?
> > > >
> > > > Per APM vol. 2 (rev. 3.45), section 15.15.2:
> > > >
> > > > > The hypervisor must clear the entire VMCB [Clean] field to 0 for =
a guest, under the following circumstances:
> > > > > ...
> > > > >  - The hypervisor executes the guest on a different CPU core than=
 one used the last time that guest was executed.
> > > > > ...
> > > > > Failure to clear the VMCB Clean bits to zero in these cases may r=
esult in undefined behavior.
> > > >
> > > > Suppose vmcb02 runs on pCPU A, migrates to (and runs on) pCPU B, an=
d
> > > > then migrates back to pCPU A with some clean bits set. At the next
> > > > VMRUN, pCPU A will happily load stale state for anything marked cle=
an.
> > > >
> > > > At some point before that VMRUN, something has to clear the clean b=
its!
> > >
> > > Dirtying both VMCBs is not needed in all cases covered with the new
> > > code here. IIUC, clean bits are VMCB-specific, unlike the ASID here
> > > which is shared.
> > >
> > > Because ASID is shared, we have to reset the ASID generation for both
> > > VMCBs when a new ASID is allocated through either, and update the cpu
> > > variable tracking which pCPU allocated that ASID. Since that cpu
> > > variable is also shared for tracking which pCPU ran the VMCB last, we
> > > also need to clear the clean bits every time we updated. IOW, if we
> > > had two variables, asid_cpu and vmcb_dirty_cpu, we would need to
> > > update asid_cpu on pCPU migration for both VMCBs, but only update
> > > vmcb_run_cpu for the current VMCB.
> > >
> > > This is all annoying and confusing, but that should go away in the
> > > static ASIDs series, and we should go back to only updating pCPU
> > > tracking, flushing the ASID, and clearing the clean bits only for the
> > > current VMCB.
> >
> > I haven't read the static ASIDs series, but in any case, this patch
> > should stand on its own, in case that series never gets committed or
> > gets committed much later.
>
> It does. I just didn't spend time trying to improve things beyond the fix=
.
>
> >
> > My complaint is with the claim, "dirtying both VMCBs is not strictly
> > needed," which seems to imply that dirtying the inactive VMCB here is
> > optional. In fact, once you update vmcb02.cpu/vmcb01.cpu for both
> > VMCBs, dirtying both *is* strictly needed so the inactive VMCB doesn't
> > later miss a pCPU switch.
>
> Yeah I guess it can be verbed more accurately, something like this:

I don't understand your prevarication. The comment, as written, isn't
"inaccurately verbed." It's wrong. With the current implementation,
dirtying both VMCBs *is* strictly needed.

> Dirtying both VMCBs is generally not required if only one VMCB
> switches pCPUs, but since the pCPU tracking is shared between ASID and
> VMCB clean bits, it must be done once pCPU tracking is updated.

Clear as mud. :)
