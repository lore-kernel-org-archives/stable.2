Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793746379;
	b=CLe9EBhWRkqWQYRFK0opNcuLuu92peGpoAlLUkaOj2itff/tFCVLnbInboYuJsUytP/c
	 ivaCsfXCaFrP8N9Ty54NYbz0BSJmH1SgE81G8kz+p9cw5RYOl5FAQypZ8JXy8sVoR3Cd/
	 oJIXsjb4VK53X5z4mqciALLZU7skcz1zPZTsaSVgKF8XS360VMjtZ+eabLLPYgcCPR4az
	 Opiy0Vh9yOxE5UDvgRF/X10oUukxrSjcJjrFC7DAnXZYmGG8VWOzPQ/wASimvxXGKc4xX
	 wsPoXE1xGdPyFaDZGlW94ISeAl022eD86GfctZVYb6jwDuYXMmsBHg8NNYbHkvORbLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746379;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=wU8VIKFjJ28dxbK4Nnp3pL9e9+Uyw+0nyAWTkSUuFuQ=;
	b=S60wSfLAt4xZ19HqmyubparKIV2/oV0mjXjk5ORdzIvrV1WwyZowqMrTJfNlmdkOQqym
	 b16RGsTj5wQ3/IgxAWAEnno2/1PdyBNNOW1C5IUI5ZczUd60rPpdskE1BOC6rkhQpe+5R
	 WVXfPrAq+0pLnze6Zcsv6T16yPXpshs5J7TW7xStYL1s+kcUQGaWBFSlGyJ16UzNpPXz7
	 xaI4owbYZVnmea7MpU9rOlTUlebWzlL92ua8KO2vTd0bd58nTTgNo3PDxK+JHkPK14aFi
	 8hG0Wqa7ZW4L3oLX7HWhpNYtcSmm48xvLAyeyj3Xne+94zU+kPB0FkfJU9kbgflfPJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eNGImLt6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6823D606A32C
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 22:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6823D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eNGImLt6
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso1719a12.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 14:52:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793746378; cv=none;
        d=google.com; s=arc-20260327;
        b=rhMMwk7FMYVE2YjIRVKAeWbbBj4H1Tn19PzTRr602zvVHkJM1NrBkUfG/iqjEAPz4S
         gxcq0baXVuJ1NeRoI3wtO9n9PAPVaPVcGjoc6rXJQfLp4aGW6OoQYqh0PRbKgoWcuFPq
         SSk0J6KwJJMVSbVriSELwKugTzJ1hvC+Yt0MY+IyxU3Aau7KCILPIaVV3DQlpl7tf0dN
         4heVWDG9lB4IXhJNIRuHxkNYRMQQRvlUG7lcBgf60cY6BAO2yWFxn49B0K24HZalzd81
         SIf+fTmbjIV4GO5DCcxUbtCve12BeweONyQKbSXhxoIuNJYM8WTgr888dAG68NJ2oW/S
         b0ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wU8VIKFjJ28dxbK4Nnp3pL9e9+Uyw+0nyAWTkSUuFuQ=;
        fh=dhYxT3qdZeEE/YrsY2F6iCg/LLVmld0KWuau/RSeueE=;
        b=I18dxs8HC5rZVO9G82z1OCocnr+xe9wtnXvzWGHRmrtll5mzn/IWSa2ClKscw7EKF2
         OpcuPwXkyKDO9PLLTIc+qnYI7QdW88enGliI1Vw/YHEaswoLMOOQRTbzEzpXdQt9Np8b
         xF2cDfYjODWj3J8c0QusNSMPoLs3RdcjxTuxLUbz1ULJp5S6w99VBIq/uCvjv8Lsvbmz
         f7rEAk4S7caXuSZCNcLAGegGYp7b5OLC5G7oajUn+CHsttNx+4YeYcr2I9GIC2kKXO5X
         iLKZsWHROOoURitji6RvYoqh0K2kXBAPHaYIPotEKM9pw8uNryvbqyYzcNrMruRCPKn5
         tZ+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793746378; x=1794351178; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wU8VIKFjJ28dxbK4Nnp3pL9e9+Uyw+0nyAWTkSUuFuQ=;
        b=eNGImLt609/blukDHj+qIScHQh00PJevkjX3mOAgLa5iI/zNT/9ZVwf7BvzZ3MWt9E
         UGNWsaFthxVOeBQOZmvYjIqQtaWMKVFtVBHnJJHEfOhPJ4TQIOh4hwZCCNkEgzGFQNny
         iAyfqYKaBvouXJOxXlq/xRAzQBYVxsVVa1NvpILAnHkCORsuj13nMGb4GsOhCnRKx0Li
         UPqngc+U18phoHm9bPxQDopmqX/WqOMgvZCW0bb5kxfLQ4xupEeOZT4Q6q4BsQxuBX0V
         TsA9YPykslpZNErJZCYVnQNxm4L8C4nF2XEkCvdMQ6bgUFSXsu1kfQ5r8YBQAiWKQz36
         YvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793746378; x=1794351178;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wU8VIKFjJ28dxbK4Nnp3pL9e9+Uyw+0nyAWTkSUuFuQ=;
        b=JUSKKTltM544eRuPgpDwrSwt/ek5q1u9sgNpc5idogJzyFcs01l6OShb5pVOUtUi8T
         GQkV8bYqt7g62sfEWmnGY1tnnyDXny11HtShudvxHKdzqqPbMBo8rt9RK61X0FakDYYy
         VOEyJ7XGp16FiZVry758Gb8Uhv4J8mXNie++zjYFKlw/6VBWaKGQOs+5laB98awxIB2o
         ZPMgUo2ZX6leMxZApiGV5lz0KuKzCc0F3CKKHXV1bpU0KnLFHL5AUSO3Vfj++G9R8SvF
         E8fDZryxUcxO2hUUzxSQBYyn2eh8M4qpNewKZDSpLzH2VRu9bih7fflEmMiJbC7XO3qr
         rs+Q==
X-Forwarded-Encrypted: i=1; AKwUvBxN5c1uoqLphb96PcrqUsdP427iGpLt4joYhIsFiWB91/fzPN7s73fQjMdHn7EpuQs4Inhp0uw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Y86lrYgyTicPrIKFhGOxdRJDG5RBD58r3Wv84mPLOYTNA2RUw
	pmz+9nKq3lsgo0iWXMZK1kjI3HvbxG4a0F1xQN75KD6WMxMscB+dytq9MAhewCeEy440MvJgKYQ
	ZVqf0a3Ea4VMPq/UP7SyWgTZm03dDzFQZDbUyNxL/
X-Gm-Gg: AYBFou1Ik+8CZsax9ojz7SakWeUywcxWQnkp8OVtFQibYOWpiOTYceV582QIJ6QBANV
	g11omJFuApGgK+S6CPcJkCDu2waxv8Zt6ydmce+ypMLTro+Kwhk+SOzzJ0m4a14y4BVHgaJ0jhS
	mFHLfFGIVO3A42ZecKzOTo1DQudBv3NaJO8PvtzMZJ8S0SXfy+nCUl42FQgt5VnLpw8dLzaiSA8
	JpQNc4XPhBWx/iqI3CkoFyZ1ILsXfK3L7+FFCxroSkFb8A01IFB4/RJO1dueVDaAbeLE6WyrIMW
	sbGXVbf01mdpVLFTRt7OvFwZcQA6Qn2Bb5+KksgMQAi/BAKlTDwtK3iatGGWgxotxqfAQLfCOj5
	kayDz4TWRKbFn5EdQfDTAt5vFt79bBcw70dSM
X-Received: by 2002:a05:6402:c103:b0:6ae:188e:e119 with SMTP id
 4fb4d7f45d1cf-6b55ab86764mr7858a12.9.1793746377460; Tue, 03 Nov 2026 14:52:57
 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102231428.13523-1-pbonzini@redhat.com> <20261102231428.13523-5-pbonzini@redhat.com>
 <CALMp9eT7cnBf6kSXZLWuMyG9a52QveWjzzLz3Z9E=kPuX_ahVg@mail.gmail.com>
 <aukmeb9mV8b504T6@google.com> <CALMp9eTdY3=1BrOYgov852VeAy3+Os7bvhWogvB0YF-JQrmtig@mail.gmail.com>
 <aupLRleTJSIDTE9M@google.com>
In-Reply-To: <aupLRleTJSIDTE9M@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 3 Nov 2026 14:52:45 -0800
X-Gm-Features: AclHuK-Z7OQBlFOF2zRwnhwZ_UDz9nzcNqJTQa47B2hjAbqqScBEB0lSSXwokYA
Message-ID: <CALMp9eR9=JTv80HuG5zAcSj91tJos2ecFA_Sc5Qbs4s5XetKHQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] KVM: nVMX: Process each host MSR entry at most once
 when unwinding failed VM-Entry
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	stable@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 12:59=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Nov 03, 2026, Jim Mattson wrote:
> > On Mon, Nov 2, 2026 at 4:10=E2=80=AFPM Sean Christopherson <seanjc@goog=
le.com> wrote:
> > >
> > > On Mon, Nov 02, 2026, Jim Mattson wrote:
> > > > KVM needs to do better.
> > >
> > > Meh, KVM is doing pretty darn good, all things considered.  Yeah, thi=
s code sucks.
> > > But I'm not convinced the alternatives suck less.  We've gotten the s=
et of missed
> > > consistency checks down to effectively zero, module the TPR mess that=
 I do test
> > > by running warn_on_missed_cc=3Dtrue.
> >
> > I don't understand the TPR mess. The SDM says, "With the exception of
> > fields corresponding to virtualized APIC registers (defined in Section
> > 32.1.1), software may modify the virtual-APIC page referenced by the
> > current VMCS of a logical processor in VMX non-root operation. (This
> > is an exception to the general requirement given in Section 27.11.4.)"
>
> Oh, I wasn't aware of that.  I agree, that gives us an "out" for vTPR, mo=
stly.
>
> > I would argue that this prohibits changes to VTPR between KVM's
> > software VM-entry checks and hardware VM-entry to VMCS02. If the
> > hardware VM-entry fails because VTPR has changed, section 27.11.4
> > gives KVM the freedom to implement whatever "unpredictable behavior"
> > we like. Yes, that probably does include loading MSR values from the
> > VM-exit MSR-load list, but why complicate things?
> >
> > Something like returning to userspace with
> > KVM_INTERNAL_ERROR_EMULATION following a prohibited write to an active
> > VTPR seems far easier--and cleaner. What am I missing?
>
> My biggest concern is that KVM could kill L1 if an L2 coerces L1 into try=
ing
> VMLAUNCH/VMRESUME with invalid state.  KVM simply can't *know* that an un=
expected
> VM-Fail was due to the vTPR wrinkle.  Even if KVM re-checked state, it's =
possible
> for the vTPR to be "restored" to a good value.

The only way that I can see for L2 to coerce L1 into trying VM-entry
with invalid control fields or invalid host-state fields is by
exploiting an L1 nested virtualization bug (i.e. L2 is running an L3).
In any case, if L0 has already performed the checks in software, then
failure of the checks in hardware implies either (a) misbehavior on
the part of L1 or (b) an emulation error in L0.

> I.e. if KVM exits to userspace with KVM_INTERNAL_ERROR_EMULATION, then th=
ere's a
> non-zero chance of a false positive.  KVM could exit to userspace if and =
only if
> it caught the guest red-handed, but then we'd still need this horrific co=
de for
> the other cases, so that seems rather pointless.

Let's go back to the Xen example, since by your argument any L1 can be
victimized. If an L2 VM somehow coerced L1 Xen into trying VM-entry
with invalid control fields or invalid host-state fields, and somehow
L0's software checks passed, but the hardware checks on VMCS02 failed,
you would continue to run the L1 VCPU with L2's SPEC_CTRL MSR. Surely,
the possibility of a malicious L2 exfiltrating data from L1 with the
assistance of L0 has to be worse than the abnormal termination of L1?

(Note that I'm just playing devil's advocate here. I don't actually
buy your argument.)

> warn_on_missed_cc helps, but in practice it can't detect cases for which =
we don't
> have test coverage.  So *if* there was a bug that could be exploited by L=
2 to DoS
> L1, odds are good warn_on_missed_cc didn't catch that hypothetical bug ei=
ther.
>
> Maybe with AI we can be 100% confident that KVM performs all of the VM-Fa=
il
> consistency checks?  Again, I'm not opposed to alternative approaches, bu=
t at the
> same time I don't feel a sense of urgency.

KVM *must* perform all of the control field and host-state field
consistency checks. Otherwise, we risk priority inversion with
"illegal guest state." If KVM is missing any of these checks, then it
has an "internal error."
