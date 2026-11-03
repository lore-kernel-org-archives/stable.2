Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793739592;
	b=i8bwhUGG1KIjAyFor3Z9G/H2I7l3TbpUbIJ+QTYAK7QX3oEjWkCtCy+DPclUWrLdrAzE
	 pTawZ/HXb46x1+GGJUgy3jw21Z/K8ZTeqEXbhu1YlQLFz+t1jXBoaw5CeKuAgbdkmyzL1
	 2i9+JsHUqKSqyQKChZN8F9jBzCo3AVwd3Ta79vUuycDyKSy/0xhk7slY0sEywEXuvTdFI
	 5w7UtWhE2Zq7m8ehrMOSITrP+W3/D6nugiQ4vvx++8nqO/RSu++3pFGzfpFszGZSz8s/y
	 BvgDW5JO8ggH7FdPDBkZ06hhhHig5qnu2P0zpFYVMpsfo8COunAcPRui9qkKc12CYLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793739592;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=2lqPU1i/NYd7KL1kWuqVHp4WfF9iJW5OIp18EbwlBIc=;
	b=WzQ6ISMpvE5QS3XpsQCsISq+OHMGt40VUUUoI38ctuzBH+jn1FanRY6F/8GeAs4VmUQz
	 zTrjyRJVHiaGej+waoptHUCPIJUdLVFye63IQ1vgI/o6yocZDcMysc3Awa5pZ82AP7M5Q
	 xZXZSxuao5T7Xzq364rfB4kuBSkWBiuUocHcA50Z9DRAx+uDr0uiCNxUrv5MZG5h7uFq0
	 cBSTVdUtcDxQFnW5eOrNI+RkyfN+gFkBiY8VWtD+nLGR7bhGF3wkKoUxO4ADq71UzGfQO
	 MQ8GjHJjcoQ7CBcR2AD/RMpjkyFAUXQBHeptU400Y3A6u6fTW65DYdZxwV/kMIGdnzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NBd+gJib;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D169606A32C
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 20:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D169606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NBd+gJib
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ae59682799so70302a91.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 12:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793739592; x=1794344392; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2lqPU1i/NYd7KL1kWuqVHp4WfF9iJW5OIp18EbwlBIc=;
        b=NBd+gJibaoQYskPfAkbrVrOzpoeJtBC0rrW8GDF0IBN1coriGAYyV3e0AbtkVf8ZLc
         Z2H/K+jEUURxrbtPMgHIauEZTbxBvOW5MLkHkmtPLyB1eoN82pwSBZd4WKLnGpmRQJXZ
         iAXrOnxAf7BYMZb4sAb0d75Bt0tHEk+Bsi/cBLhmBP/Lr6+Vq5cSbjKL5rnltGpxGIFg
         RnvMIDH61RKmoVIi9jt0zL66xhgG6RWkYWtCbWdKlkwM+9EqGTFw0qYaVCMP/KXYcYuM
         m3azISPBoD7KwfGcXGvtfKXxNTpJoOcntsXWd+ovflAEtitTrb9Qplazlalg+tDBSQB4
         qxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793739592; x=1794344392;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2lqPU1i/NYd7KL1kWuqVHp4WfF9iJW5OIp18EbwlBIc=;
        b=M+E3KBWxGhFGjVxloz+5Eq713wKM7qL1ll0qGfxWGJi1nROOEGJmwYupyn2VeCKOCf
         VmAsJqPt8ClHXcQllv3kviIh9rwed/Afvnx3LlA7vY51dz/sDGuiBLtmxS3ZYUIUiLgY
         zBzKhCUJoE6HxXJzfXlHtLH6BitXJP3bTAGRU4IaihH7gzVb786mUYyTyQkVXm6k+Vza
         pUWqaqtG2K1FuGpqqpOokIgFILbmOM133wzm0WB40AVfN3DXscBjl3kHhuFm7kUQpbLG
         b/OC1TQI6WHZFjAg4mqv6fRqq033IjbDmhfGMThJnTEC/VhxGP4/NNhqZWXCuxDvzGrn
         /DPw==
X-Forwarded-Encrypted: i=1; AKwUvBxkT8BLOarfh6aA9F3OA6beImyHwFIkmcOBv9O9f/uChLkPJcCeNPkUBfgP2k/aTsXDd7CxYrw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ZueVKCofZSwZkTBDxrgJkwm8cd63vQVLiHE4ukyc3MPTW6wn9
	jMKa3D2zwfEcTf0P/+fIdbI6PqqVWkcxkthre6AFemsOjdM9oC4PuGWCB0kFiGMqAFTUmyLBGEJ
	ry9Uc/A==
X-Received: from pjhw8.prod.google.com ([2002:a17:90a:5288:b0:3ae:c401:753])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d887:b0:3ac:8af9:4a77
 with SMTP id 98e67ed59e1d1-3ae897c94e8mr12522138a91.10.1793739591455; Tue, 03
 Nov 2026 12:59:51 -0800 (PST)
Date: Tue, 3 Nov 2026 12:59:50 -0800
In-Reply-To: <CALMp9eTdY3=1BrOYgov852VeAy3+Os7bvhWogvB0YF-JQrmtig@mail.gmail.com>
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
Message-ID: <aupLRleTJSIDTE9M@google.com>
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
> On Mon, Nov 2, 2026 at 4:10=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> >
> > On Mon, Nov 02, 2026, Jim Mattson wrote:
> > > KVM needs to do better.
> >
> > Meh, KVM is doing pretty darn good, all things considered.  Yeah, this =
code sucks.
> > But I'm not convinced the alternatives suck less.  We've gotten the set=
 of missed
> > consistency checks down to effectively zero, module the TPR mess that I=
 do test
> > by running warn_on_missed_cc=3Dtrue.
>=20
> I don't understand the TPR mess. The SDM says, "With the exception of
> fields corresponding to virtualized APIC registers (defined in Section
> 32.1.1), software may modify the virtual-APIC page referenced by the
> current VMCS of a logical processor in VMX non-root operation. (This
> is an exception to the general requirement given in Section 27.11.4.)"

Oh, I wasn't aware of that.  I agree, that gives us an "out" for vTPR, most=
ly.

> I would argue that this prohibits changes to VTPR between KVM's
> software VM-entry checks and hardware VM-entry to VMCS02. If the
> hardware VM-entry fails because VTPR has changed, section 27.11.4
> gives KVM the freedom to implement whatever "unpredictable behavior"
> we like. Yes, that probably does include loading MSR values from the
> VM-exit MSR-load list, but why complicate things?
>=20
> Something like returning to userspace with
> KVM_INTERNAL_ERROR_EMULATION following a prohibited write to an active
> VTPR seems far easier--and cleaner. What am I missing?

My biggest concern is that KVM could kill L1 if an L2 coerces L1 into tryin=
g
VMLAUNCH/VMRESUME with invalid state.  KVM simply can't *know* that an unex=
pected
VM-Fail was due to the vTPR wrinkle.  Even if KVM re-checked state, it's po=
ssible
for the vTPR to be "restored" to a good value.

I.e. if KVM exits to userspace with KVM_INTERNAL_ERROR_EMULATION, then ther=
e's a
non-zero chance of a false positive.  KVM could exit to userspace if and on=
ly if
it caught the guest red-handed, but then we'd still need this horrific code=
 for
the other cases, so that seems rather pointless.

warn_on_missed_cc helps, but in practice it can't detect cases for which we=
 don't
have test coverage.  So *if* there was a bug that could be exploited by L2 =
to DoS
L1, odds are good warn_on_missed_cc didn't catch that hypothetical bug eith=
er.

Maybe with AI we can be 100% confident that KVM performs all of the VM-Fail
consistency checks?  Again, I'm not opposed to alternative approaches, but =
at the
same time I don't feel a sense of urgency.
