Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5815437E7
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 19:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067660; cv=none; b=LZ5RJBiO11YLE5cs3woAwDlOewkz7eUHVX9e8bv0vFbZKtWtIJUt1b2fbUHXR2suz1iru83KCfgY4VkcSmj83Qr1f1BiA3Wpd/Y4iHu0DTfMQ0L86HHtX0DXsbQbN4n+HHlKCUUULC8XauxtrGt0dwUQBjlm1TLK+qFqDiCzYyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067660; c=relaxed/simple;
	bh=FqUfnO60l6okYiwM4VWfFq9KvwuGV4cZ59aEc2ZKs5w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NH7YC61F5PRePejrighS1pbos6WBTCV4bU19umV3FPf/pVGUxpRHexWJqchoy26ZQxWTDaptVAsOfMCtqLYuaT5nmStTQd1G3EtWFbZXIk2RYfwgwFxEEIkUf4t7c/EkxIyDxiFskqLTQTkyVzPx8j3OzOY4lkHoLC0OIl9g0JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jw82HjPu; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jw82HjPu"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d55d8cd938so339625ad.1
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 12:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789067658; x=1789672458; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=37ZIH47KtSaQZ8vEucDa+UZuBoEfIorK83eyPZ+bYGw=;
        b=Jw82HjPu7ODPKsLrcuh62e75Abquyn/F0WvCmMuamN61j99+UcPfj/I37X0qjviBli
         jkx/xh+Y0wVz0zO2p9E/oamWbv/URQyHrO9Pl8PM42SFjFebiAvIrl+wkG53zgtqR/w0
         UF4YxFWO+uMbYJa8QisKWTzorTzBlTeUF4b1my9kVUiTXC7N/oB4znkivSaLmwIM/+tG
         lWv5s83YFv58RHTyzc772cCRn5wL+drZrMRjXWG54vWNtoBbDcIjEegMoyAWAsWI6/N7
         oqZn/rmC1JqGSXwvmYIhiwi3biqWhMkCopYkTz1pP6jLW6mG7RSCacyFPabWeQZ1THX+
         mrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789067658; x=1789672458;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=37ZIH47KtSaQZ8vEucDa+UZuBoEfIorK83eyPZ+bYGw=;
        b=O9bFtGSNUgL8yicRWHDObos3bVqRLYCnVaO5xI6Krz338a0bP+XbcaN9xmTZXOjMhG
         xoxL0zUcGa87bJ26x8zcScSAqiFIZEZ9KjpYkrpxcw6+rk/mUSqVqZ1qfOO/W+z8d6c0
         xlAVQOt7/D5MrzJipZ+GPsE4qurQ0lkXu/8eId7hHg2ACtFf5Y/mPujG4ehvujwgLP8m
         FeXcWmvhhJ6eP2MkKxFQa8vmbzJKrIQHFW8JbF2Wqs4PYyMK0r8du74KRL7Dm3JO3CEk
         DYXKVdOCm44QxamOslW3qEBo5/mj4/b7QAI5gWyU2AvNaMXH/J4XK1RUu0ttdgsLDpFD
         IUPw==
X-Forwarded-Encrypted: i=1; AKwUvBzfRaF2HFuaTjaZH45f85kR4UI4eSXii8zgdq+gNtRQLCERKUK0D2wyQvdcesjat2ZJYo7Zwow=@vger.kernel.org
X-Gm-Message-State: AFuF++nyaCSw3gkrNKFFVVbpfzS2SQD6LayAefJksZ1q5wE4lM0s7k1e
	0+rDLFtFtc23mJ7lLZm0eUtV9I65hDpilWoN8gVGubJUUiyP8ZLV5ddRYPRu3mEbgioi1eYsP9V
	A1NtMsg==
X-Received: from pltt21.prod.google.com ([2002:a17:902:d155:b0:2db:36c9:8778])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:98f:b0:2dd:1701:3b6e
 with SMTP id d9443c01a7336-2dd2a357fc6mr15756725ad.16.1789067658128; Thu, 10
 Sep 2026 12:14:18 -0700 (PDT)
Date: Thu, 10 Sep 2026 12:14:17 -0700
In-Reply-To: <CADrL8HWRjzzs7YmNkGDYQWDnygw=OcdgqCWCOfdt9af0-XwvVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260908132838.2116068-1-jmattson@google.com> <CADrL8HW3Q=8eBf-=h6BAPdUN_X1Z_-KG=i5a5rA2kF+V4JURww@mail.gmail.com>
 <CALMp9eRJXozpUpdOhqDCWn7VbqHb9G9hn4aZnxS_fef4ad1yTg@mail.gmail.com>
 <aqGsukcRG6khmxpt@google.com> <CADrL8HWRjzzs7YmNkGDYQWDnygw=OcdgqCWCOfdt9af0-XwvVw@mail.gmail.com>
Message-ID: <aqMBidJ_96qroogH@google.com>
Subject: Re: [PATCH] KVM: nVMX: Don't flush shadow VMCS12 to guest memory
 during vCPU teardown
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026, James Houghton wrote:
> On Wed, Sep 9, 2026 at 12:00=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> > If the above works for PPC, then KVM can nuke memslots before calling i=
nto
> > kvm_arch_destroy_vm().  x86's asinine memslot deletion in kvm_arch_dest=
roy_vm()
> > needs to be addressed, but that code exists purely to do vm_munmap(), a=
nd can
> > and should be moved to kvm_arch_free_memslot().
> >
> > All that said, I'm not sure this aggressive fix is the right thing to s=
end to
> > stable@.  For that, James' suggestion of hardening KVM's usage of
> > __copy_{to,from}_user() seems like the best blend of being comprehensiv=
e without
> > being overly invasive/risky.
>=20
> This seems kind of nightmareish to backport; there are a lot of
> copy_*_user() callsites that will need updating. Maybe I have a
> different idea of the diff you're suggesting.

Nah, it's not many, because it's only the __copy_{to,from}_user{,inatomic}(=
) usage
that needs handling.  Everything else is strictly scoped to an ioctl, where=
 (a)
current->mm can't be NULL and (b) KVM doesn't make any assumption about the=
 address
space.

At a glance, it's 11 total: 5 in virt/kvm, 4 in vmx.c, and 2 in PPC's book3=
s_64_mmu_radix.c.
Well, plus 4 more to also harden {,__}kvm_{get,put}_guest().

And even if that number were doubled or tripled, the backports would still =
be
relatively easy.  The overwhelming majority won't conflict, and the few tha=
t do
should be trivial to resolve (more than likely, simply drop the change).

> I wish we could just change the uaccess primitives, like
> {,__}access_ok(), to check that `current->mm` is not NULL (and WARN
> and return -EFAULT if it is NULL).

That wouldn't help at all in this case, because the access_ok() check is do=
ne
when memslots are modified.  Which is the crux of KVM's problems: KVM decou=
ples
the initial checks from the accesses, relying on kvm->mm to

And even if we hardened all of the uaccess helpers, we'd _still_ have probl=
ems,
because it's not just a NULL current->mm that's problematic.  The last refe=
rence
to a VM file, i.e. to struct kvm, can be put by a different _process_.  I.e=
. KVM
still needs to guard against reading/writing guest memory using a valid, no=
n-NULL
current->mm that isn't kvm->mm.  That can't be genericized in the uaccess A=
PIs,
because the rule that only a specific address space can be used is very muc=
h unique
to KVM.

> That diff is also not trivial to backport; many arch implementations woul=
d
> need updating. I have half a mind to send an RFC patch to linux-mm@ to se=
e
> what they think. :)
>=20
> > So, as an immediate set of changes, what if we do this over ~5 patches,=
 with patches
> > 1 and 2 tagged for stable@?
> >
> >   1. Add kvm_copy_{to,from}_user{,_inatomic)() and return -EFAULT if cu=
rrent->mm
> >      is not kvm->mm.
>=20
> SGTM. This is not mutually exclusive with the generic uaccess changes
> I'm suggesting above. If this is actually reasonably backportable,
> sure let's backport it.
>=20
> >   2. Hack-a-fix PPC's kvm_arch_flush_shadow_all().
> >   3. Do x86's vm_munmap() in kvm_arch_free_memslot().
> >   4. Nuke memslots before calling kvm_arch_destroy_vm().
> >   5. Change the current->mm checks in kvm_copy_{to,from}_user{,_inatomi=
c)() to
> >      WARN_ON_ONCE() on failure.
> >
> > And then in the near-ish future, take things a step further and do:
> >
> >   6. Fix the vmx_leave_nested() trainwreck.
> >   7. Harden the common kvm_{read,write}_guest family of APIs even furth=
er by
> >      adding an early WARN_ON_ONCE() on current->mm !=3D kvm->mm, i.e. t=
o detect
> >      bad KVM behavior as additional defense-in-depth.
>=20
> This all SGTM, thanks Sean.
