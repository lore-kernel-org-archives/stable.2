Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793751123;
	b=reQFo86xb4bjfTeX6qp1QHeGyH1qN4lVrOaMBIUbJmJ9yvY5Zs22ei3bNQkqIB+tPlHX
	 rYkbUaeWTirHOs1gzAh7H973+FTmtnq4zfQ7E/s+Qo9g/hdnLjqgGdRIiZSnrWrizM+Jx
	 CXtrxlweIgC6tNbA3wkZOmt6qnsq9HWaM5jALCCnh9sy6fIil+3hwffrgJfquNw4tb7x7
	 oBkP4toT0+Le0t/gwRSavWIgR1x/eISy7265U6tSyoSDa04jFzBX6gNBAaYlGRNVtrb3P
	 cVHHq15m/VWpYgEWpFjjyF9OX6sIlwb89G/a6fRl7jD0n1gm5238AG7X3r+QrME9H8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793751123;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=5CGACUUg3rBEi7UMlfaanowNlMmekE/5bj9+aCr8KCE=;
	b=FZ/BUSeLjrtq8a2UFZn8JZ/UVziDcVCbxXtY9MFpiYgoehUmo8vWam3TkAqaR4m6F5eS
	 BYY+daqY8ISQE7Y/xJjtQXMztnwULBIlGBCVolb3ih30k/4ZFEYa6IhzpSANJzmNF+AMG
	 ceWDR2KsXpXGu5uueiroHI/p0YIekGwER4Hq9Dq+8KWCdvBRAYSynq0zTrYOCyxYfnqae
	 xXeqD5qSa9kwKb8a727OWgoz+wdhmczAo2UfKc77Cm3rj8DVsSleKfq/uIJvpkoSKoE0H
	 bZId42FvVmVj9uhJvbglLVFhouss1k62pOTHB7CqZoTdEIh+qXHz5wG+HTPaHMM+sPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OsArDVuJ;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06087606A324
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 00:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06087606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OsArDVuJ
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ad30487d55so382069a91.2
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 16:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793751122; x=1794355922; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5CGACUUg3rBEi7UMlfaanowNlMmekE/5bj9+aCr8KCE=;
        b=OsArDVuJLp6NUYXfYw238qc/P3CK3zuQ6BazvZ1EEdC7EMd6YFVzUNKOhukTzidjDI
         S4qdNw1R5tS+bBycAL5J83vHTRz5RoyFfBUAQmo5ct8llMvTqJ+9I07ETINP7LdUzReS
         9cKlszU3NzF4SQEfEaAywJp70+N6B8X1nW2H8nJVviu+LxNZ7rHDI6LIGGbkiywL9mHe
         V6zsAsfFmG5636Ig4RcXmD9ff2j1sEbD1dlwsa7qCjJHFEiuvfMnjjiK1Rce817xDFAE
         ewKxqOErzBvSKGh/F0l2FsjrUb5L0YmHPMjkPcyAzypQr6h8fbBm6fU35kHRKATZCtVm
         2lYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793751122; x=1794355922;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5CGACUUg3rBEi7UMlfaanowNlMmekE/5bj9+aCr8KCE=;
        b=xbqIp7VXjGllgdG/FQgcJG8zL5k2DMXR75ooHf16Hf2w93kS1PoiKhDZR07Eqns3lZ
         ujX+TnDiM+xXENy/k2X0uDvoh3kGJcXS5nqzwbFdpDhZoIZ6kEJLjhQUpUFLG1f514HE
         fwmpDdf2wWqZXIt1pVzsA7ZW5IOijchE3IWdyGxdXxxM0NYM4hVuquvP06iCkV9I9MqK
         skpshigcp+Y2SsSDiRr+IVJ5KmvPJM+NFtkYKaKPeNfyxhCc2G+MDzhIumhFC6RS1Pz/
         oET6kkGJfr6ue3mbCOcQuggIkQLq6N9fmYb8FuIjO8HPXupOi2wGh2PPwzKjB/QuzFrK
         rBIw==
X-Forwarded-Encrypted: i=1; AKwUvBywRu4M9iDMhPTZe7MqOcvTRgocJA14ZC2y05vaJ0kIVi0FhFZvhu5+kzDB7MjICj86sD/VtAw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2AI8eNTtl/9eoYGBR538BxDilT1KRFX+6Mi6S4VRrFRWGne1z
	SE9iEFWq2SUSlpXFdiuMfXhOPX0g+m2g9ptof4BtCuuFzMaxBzlN/8uDwjR92POzp0lZllQ1jJC
	P8K80fA==
X-Received: from pjbcm14.prod.google.com ([2002:a17:90a:fa0e:b0:3a6:f87a:f3e1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ec5:b0:3ac:a203:e0a5
 with SMTP id 98e67ed59e1d1-3ae897eb741mr12643918a91.11.1793751122089; Tue, 03
 Nov 2026 16:12:02 -0800 (PST)
Date: Tue, 3 Nov 2026 16:12:01 -0800
In-Reply-To: <CALMp9eR9=JTv80HuG5zAcSj91tJos2ecFA_Sc5Qbs4s5XetKHQ@mail.gmail.com>
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
 <aukmeb9mV8b504T6@google.com> <CALMp9eTdY3=1BrOYgov852VeAy3+Os7bvhWogvB0YF-JQrmtig@mail.gmail.com>
 <aupLRleTJSIDTE9M@google.com> <CALMp9eR9=JTv80HuG5zAcSj91tJos2ecFA_Sc5Qbs4s5XetKHQ@mail.gmail.com>
Message-ID: <aup4UcK__je0wtp6@google.com>
Subject: Re: [PATCH 4/7] KVM: nVMX: Process each host MSR entry at most once
 when unwinding failed VM-Entry
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	stable@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2026, Jim Mattson wrote:
> On Tue, Nov 3, 2026 at 12:59=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> > > Something like returning to userspace with
> > > KVM_INTERNAL_ERROR_EMULATION following a prohibited write to an activ=
e
> > > VTPR seems far easier--and cleaner. What am I missing?
> >
> > My biggest concern is that KVM could kill L1 if an L2 coerces L1 into t=
rying
> > VMLAUNCH/VMRESUME with invalid state.  KVM simply can't *know* that an =
unexpected
> > VM-Fail was due to the vTPR wrinkle.  Even if KVM re-checked state, it'=
s possible
> > for the vTPR to be "restored" to a good value.
>=20
> The only way that I can see for L2 to coerce L1 into trying VM-entry
> with invalid control fields or invalid host-state fields is by
> exploiting an L1 nested virtualization bug (i.e. L2 is running an L3).

Hmm, I agree L2 would be a tall order, but L1 userspace running against KVM=
 can
definitely get bad state into the vCPU by abusing KVM ioctls.  So not a VM-=
to-host
DoS, but still an unprivileged DoS (given that /dev/kvm isn't usually locke=
d down
by default).  Of course that would still require L0 KVM to have a missing c=
heck,
or require L1 KVM to be buggy and let userspace modify vTPR.

> In any case, if L0 has already performed the checks in software, then
> failure of the checks in hardware implies either (a) misbehavior on
> the part of L1 or (b) an emulation error in L0.
>=20
> > I.e. if KVM exits to userspace with KVM_INTERNAL_ERROR_EMULATION, then =
there's a
> > non-zero chance of a false positive.  KVM could exit to userspace if an=
d only if
> > it caught the guest red-handed, but then we'd still need this horrific =
code for
> > the other cases, so that seems rather pointless.
>=20
> Let's go back to the Xen example, since by your argument any L1 can be
> victimized. If an L2 VM somehow coerced L1 Xen into trying VM-entry
> with invalid control fields or invalid host-state fields, and somehow
> L0's software checks passed, but the hardware checks on VMCS02 failed,
> you would continue to run the L1 VCPU with L2's SPEC_CTRL MSR. Surely,
> the possibility of a malicious L2 exfiltrating data from L1 with the
> assistance of L0 has to be worse than the abnormal termination of L1?

Probably.

> (Note that I'm just playing devil's advocate here. I don't actually
> buy your argument.)
>=20
> > warn_on_missed_cc helps, but in practice it can't detect cases for whic=
h we don't
> > have test coverage.  So *if* there was a bug that could be exploited by=
 L2 to DoS
> > L1, odds are good warn_on_missed_cc didn't catch that hypothetical bug =
either.
> >
> > Maybe with AI we can be 100% confident that KVM performs all of the VM-=
Fail
> > consistency checks?  Again, I'm not opposed to alternative approaches, =
but at the
> > same time I don't feel a sense of urgency.
>=20
> KVM *must* perform all of the control field and host-state field consiste=
ncy
> checks. Otherwise, we risk priority inversion with "illegal guest state."

Eh, not sure if that matters in practice though.

> If KVM is missing any of these checks, then it has an "internal error."

I agree, but KVM has historically had a *lot* of those types of internal er=
rors.
Even now I genuinely don't know if we have 100% coverage and accuracy.  I s=
uppose
we could add a cap or quirk the existing behavior, but I'd prefer not to do=
 that,
because odds are good the restore code would eventually bitrot.

I guess I'd be up for having AI audit the checks, and then ripping out
nested_vmx_restore_host_state() in 7.5 in favor of kvm_prepare_emulation_fa=
ilure_exit().
That change is pretty darn easy, and would likely revert cleanly too if it =
came
to that.  Sashiko would probably even understand the implications without e=
xtra
guidance, i.e. would hopefully flag missed checks as new features are added=
, so
maybe my maintenance concerns are unfounded.
