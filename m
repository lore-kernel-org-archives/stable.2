Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793664635;
	b=P8pbM79CmuyoTm+kiQUNoy7LFVi9/Ze4YIeycQles6ofxKSevAMDzrEavkq38E37KSUC
	 u54lxgd4jCg0/xkK82le+aXPJ+iMqKxpYrMr+/5kctINNe0tEBjAcYcqD/LObm20E3MPF
	 41aVzeYTvGCIwPaIfHa/9IBF0Vvc4nNh7U9nU5p1vQMgNUg2q2fI58j23WGQ+0zQ4bd5Q
	 TvNFKH8yo97HvePnrJbfsHO4fDVFlEVzJX+FJyhweOn3TWtM/wQRdIkUSlXBHfEeLxI35
	 nyA8/yZuFwwHtfAjmw/EvJBi/Luuj89KkHp8q1gvGC9w+NbjbTYdUcsmmMpG/rwThEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793664635;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=J6L8mY31MNtz95VGUAtfNyYMcOeErTGfjG4txWKjWTE=;
	b=4lQdNlnNvdmvRzgaTdswIl2O76/36eRf9+LuiAwGagaq5TO4jvajZK9cfzE3xzHwL0LL
	 Z9wETQjFr1BG4b3o19j7Kw7d04G1mJC2mRVW+EyBp+Ch9ta5UVmyi/TL5I0KDnEmigeFx
	 /q1G8DJ7hecnIu1wZLUa/y3dZxFW6ydD7mQ7D+J+D7PeUEl5JmUDoGIcxdyeXp0fYKDVF
	 o6HZsk0Bg9UkStt/EP5vYKlNCedKHCJzCUlko0WnnhXB/GcrdCXvjF9eezq8AahSY3eZW
	 yfzfHKTDlOBk8mxTmw4KPtD3Vfg9bGxA1gQ9rT8FSC1InVpayFSKq3WxMFh3tv+8oLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ehVpHByY;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080B9606A327
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 00:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 080B9606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ehVpHByY
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a59717b0c0so2768867b3a.3
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 16:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793664634; x=1794269434; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=J6L8mY31MNtz95VGUAtfNyYMcOeErTGfjG4txWKjWTE=;
        b=ehVpHByYYF2DK9rR/bSPBeu58DBwDQ4nrUyGNi9vI0lfJ7BQa41cOtPIazX8pL4Q7x
         U4kKinUUgvsFQDFBkmqv9T14DpG3DG5iPDfjEQX4geYGzX0SNEyA/ZMvnKAltqaRKvbM
         AbAtm3VMq+LfszI+ln2vBRayeWn7xX/cT/ioXUaEvIXpHBD2zOMDcjRtV+4/pAdvLZs7
         HDR1BPNFlvYgnoDcTnkNm+K40M2ojo+mJGYX9/Ei5p82ARUgcYcY0EmjtiEkwXdEL9xX
         NlaqjSQ7VlXc9mbhexOQC5Ji0NE/Y37yvdPT1z10f9EI4xII66hJL1hsRS1mUaRWPQLD
         YNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793664634; x=1794269434;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J6L8mY31MNtz95VGUAtfNyYMcOeErTGfjG4txWKjWTE=;
        b=hyYvakIP1v1Qk0FJUNIXw6/ThmBOugK8ENPYRY8EKctFcKHC+2kYJCcC2czNyiMfJ8
         49VwccZd8NLVMdlANlqiwywNCRqmps3rKygqb6+2EEkWSW8jZPpQCOWEupw0qMpRo2Yu
         yDpuaHvHOJ1dxFehlut5akcRY01s6gbRsJuatihZRr8jU1WN/satJlJqDlxYWSPIkQ6Y
         ksfPRjqIuudRZDymx/A13mU8EEf3rylndE+upWcyXCKPQIL6njEzjkE62vnsb+trVtlk
         gDHDiEb9M/Z7vMJ2Pq4Pg0hlEsBormr0i7AtwHsSzbWLJGLHDF7fOGQWIMa/+c821meq
         tdWA==
X-Forwarded-Encrypted: i=1; AKwUvBwopSwUN+1silFkgeDD9hmziYDrf7xfW4CEI+/XPQVLghypp/BxT3zZDkQr5Nd0/0/Mz0N1lak=@vger.kernel.org
X-Gm-Message-State: APuU4Z8koLIwHYeV1JmgRv458MvbMMlW3KiBQUcPkvi/zg+amIk/uYjs
	PIKLASeI1RwjqcTE+Ln8IDnI/B6UOMJg2R9dmA5k/iyMrhovFNHgMNQ3VuSvOASk5zM1R9ssU7S
	V6Gm6/A==
X-Received: from pfhx5.prod.google.com ([2002:a05:6a00:1885:b0:8a0:9321:5329])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ab05:b0:886:9078:546
 with SMTP id d2e1a72fcca58-8a9be96509amr9968061b3a.26.1793664634176; Mon, 02
 Nov 2026 16:10:34 -0800 (PST)
Date: Mon, 2 Nov 2026 16:10:33 -0800
In-Reply-To: <CALMp9eT7cnBf6kSXZLWuMyG9a52QveWjzzLz3Z9E=kPuX_ahVg@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261102231428.13523-1-pbonzini@redhat.com> <20261102231428.13523-5-pbonzini@redhat.com>
 <CALMp9eT7cnBf6kSXZLWuMyG9a52QveWjzzLz3Z9E=kPuX_ahVg@mail.gmail.com>
Message-ID: <aukmeb9mV8b504T6@google.com>
Subject: Re: [PATCH 4/7] KVM: nVMX: Process each host MSR entry at most once
 when unwinding failed VM-Entry
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	stable@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2026, Jim Mattson wrote:
> On Mon, Nov 2, 2026 at 3:19=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
> >
> > From: Sean Christopherson <seanjc@google.com>
> >
> > Add a missing "break" in the inner for-loop of the open coded mess that
> > unwinds MSRs back to the pre-VM-Enter state when VMLAUNCH/VMRESUME VM-F=
ails
> > due to a consistency check that is caught by hardware but missed by KVM=
.
>=20
> That sentence does not accurately describe what the code does.

"attempts to unwind MSRs back to the pre-VM-Enter state"

> > I.e. move on to the next MSR in the VM-Entry load list after performing=
 a
> > write using a value found in the VM-Exit load list.  Processing *every*
> > matching entry in the VM-Exit load list makes the processing quadratic,
> > which is problematic if the load lists are full of MSRs that are expens=
ive
> > to emulate.  E.g. writing APIC_BASE triggers kvm_recalculate_apic_map()=
 and
> > a whole pile of unnecessary work.
> >
> > Functionally, arbitrarily restoring the value of the first matching ent=
ry
> > is "fine", because none of this is architecturally correct: the load li=
sts
> > are never supposed to have been used in the first place.  In practice, =
it's
> > likely a moot point as no well-behaved VMM will have multiple, divergin=
g
> > entries in the load lists.
>=20
> This isn't "fine." This is disgusting.

The "fine" here refers to what is being changed in *this* patch, which is t=
o
load each MSR at most once, and to use the first value encountered, e.g. ve=
rsus
the last value.  IMO, that claim stands: in the context of the existing cod=
e,
this change is "fine".

> The assumption that the VM-exit MSR-load list will "undo" every
> assignment made by the VM-entry MSR-load list is misguided and wrong.

No one is assuming that.  The comment even says *exactly* what you're sayin=
g:

	/*
	 * This nasty bit of open coding is a compromise between blindly
	 * loading L1's MSRs using the exit load lists (incorrect emulation
	 * of VMFail), leaving the nested VM's MSRs in the software model
	 * (incorrect behavior) and snapshotting the modified MSRs (too
	 * expensive since the lists are unbound by hardware).  For each
	 * MSR that was (prematurely) loaded from the nested VMEntry load
	 * list, reload it from the exit load list if it exists and differs
	 * from the guest value.  The intent is to stuff host state as
	 * silently as possible, not to fully process the exit load list.
	 */

> Xen, for instance, puts SPEC_CTRL on the VM-entry MSR-load list, but
> it does not put it on the VM-exit MSR-load list. Instead, after a
> normal VM-exit, it restores the host value in
> vmx_asm_vmexit_handler():

...

> KVM needs to do better.

Meh, KVM is doing pretty darn good, all things considered.  Yeah, this code=
 sucks.
But I'm not convinced the alternatives suck less.  We've gotten the set of =
missed
consistency checks down to effectively zero, module the TPR mess that I do =
test
by running warn_on_missed_cc=3Dtrue.

E.g. for Xen to run afoul of a misbehaving guest, Xen would have botch its
handling of vTPR.

I'm not opposed to trying to figure out a not-horrible way to snapshot a li=
mited,
hardcoded number of MSRs to make KVM less wrong.  But I sure as hell ain't =
going
to spend cycles on it at this point, because potentially clobbering L1 MSRs=
 when
L1 itself has already screwed up is firmly in "don't care" territory right =
now.
