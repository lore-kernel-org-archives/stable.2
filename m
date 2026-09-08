Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3563159E329
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 19:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788894793; cv=pass; b=KydT+6/GL97KMstu5ICgY4sCkGTa7ml7ueQsr8oR9fmI+zDKkwP9TVpPR/+GDLNWXcCVSHlaYJBIE+kYuF+/1TuzapGfWcJ4CQyJvONfhkrUL+eSlNgHs9y8kNk/Oz5OjP5lMB4vYjq6/J3dMj0tMKBhRSi/dyHDcye6D+pd5aY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788894793; c=relaxed/simple;
	bh=i+PUh1GNjddjRlItZQFpQ9yZWIJbJi9QYvWdoApv6Ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dqSveIzWk8CcuXB7C8IOE52hJQeCyfCMkLq6W9LoIjwjVWRdDxm/GHfhSQ2pSMITrvomwHRJce/4U9tURxLX/CeTmVEWBNbmXp5i3srGztcHB2QRgiSzf3Jef6MTRBRrzjtviyMh6brlIbZoLqObPElL9cW9PphvgLTcjVI3kCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VjPz4+3V; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VjPz4+3V"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a6141a61c0so29759a12.1
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 12:13:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788894790; cv=none;
        d=google.com; s=arc-20260327;
        b=p05HzmPTgG59jucrD8z1S6H6dTMuOPp4Vz9VAC1QPxx2o1BdSaaOHHD9F3x5TfvwtR
         XlxTEUwCM5azMMfY6lanQcGki4EjM+v0ORnVe0iwV0yA2wMhBhKcM0hVJ42qPho9M9Mf
         y98cQ4uZLdBgAHysZjeP9ATbTSEqiHlh0yMKGSMgNwdHpYytmeLFjjxMyE9lHAEpWbSg
         dvG/VL0uNNuxpjQ8dNtbZxsR6i8o37UOMytT2DTLZx/DBlCVVvvizOt558yX6Sv4c7lB
         TyxIp0PnES50BoSwX1rjOVTpfu6Q0SWu9+QokCff7SN/B/svRy0BGvGnTOLslo+bMbIr
         EUCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AM+XuJvHrqKZpdS1uMi2WfLrc4OBcDJEv34L7k2GPeo=;
        fh=IbII3vFRadoWWA2EYfoPzPaff76SzLNfI13mPNnII84=;
        b=jBQjVoyuvTvsln56fFkZEr/oY1AIj3Q10zlq7gDY1QmPSqkzwdD2vuZwYz14o0U2DX
         o+2K8fl/Sx++h/9+PASbqAQzyRIhyTX3iRWubrB5fioLlf16NKe5JMgbBPchWa73i7eu
         F2UPWpjN5UIYEHn39OlcCbfSQYwKerRhY28jxCdZU1yC9Hf1lwhLEzrUXAk1fQV7Dm83
         YThMMQLlVi9Z7iyXvxDh/zvn9s7QdHvBo9r9/LDEuwQ24LNHg9JVqN8bK3hZZTWpJuAV
         he/QamlBQ/c/DUai7NdW1V+kgO5DElzjBo94o/bxKLxkfC5T4II3My+WCKIduRA222YI
         kbCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788894790; x=1789499590; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AM+XuJvHrqKZpdS1uMi2WfLrc4OBcDJEv34L7k2GPeo=;
        b=VjPz4+3Vu+RZbDsH1o7nFaL9KaXSKC/4ED1RdbR1W/Nk16RR7l2CXQJRaKKRZ6U4PT
         tVwViYwKISmNzfKI8d23S8IGM6pzKwF8IyQJReRL0cPub/B1Goa/HsY6JOQc9FZbvKsm
         BMfsZqw7m2jTAHZqLfBro8WZ95HFos1mLCkySVzvHkcQr7xDwywD6TA0QyZpH/EfTHLq
         WaE3/rRo6tOE3+ltuIL/kcFzI93546/TeViqkWurFNyx1qt6XySbSoK1wuktS+MSzk7o
         i16KV7aIYFrknUsViCk6HRPwNZ8C7apBxeJG0QcIaXEuzGaECrQjVb4oZcNWkFqYj9Du
         NLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788894790; x=1789499590;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AM+XuJvHrqKZpdS1uMi2WfLrc4OBcDJEv34L7k2GPeo=;
        b=B+54CyPl/flbl6nMCvwLbUczi5kNEH4WfCI0Hgq8+UHQYJ++9rWqqhQXvBPKwp2uCm
         FEhFUFcdNOCW3+yuitds0HJYpJ7hJQ52W7a4AH7VFryUyjbV3p333RTud9p02M/HnClH
         BkVQ7KTkKg08ub95eM7CJ14DC8rV8QIVrTVNmqNy1L2tN1fBPt2M6cvtfWUAzfZvMEjJ
         6OVR16pUKzFxDLjgj08dxn9j5ykqZvtr9nFrYZmwPBuR3nvdvskmXm/AedY8rpt6ahJU
         D/IUil46JzGcDPk6hSxwL/KLSrV3oxPALIOn7lY4wfE4MgrnadmDD78BJFPqxIZthN0A
         SBMw==
X-Forwarded-Encrypted: i=1; AKwUvBy30r047DLj0N0nyE2+UZRcQIOtfc06wUNYaVYPlgNNEPATIO8thBdIF7pTCeoBC7CMsyoDS0I=@vger.kernel.org
X-Gm-Message-State: AFuF++nIAiCljMPWe25mf+sVzOqOXK6J6gAiyaQqBRl//1deMHZAPOCQ
	KMfGJ/GjcJlb6MmJIUnaZrMupcV7fzdQ0rZhadnra7A6L0I+JQij97xOvA8xfdJY62qm8j9AUru
	BQtLPMFRK8biOjXAosdZ4DZN2f99pOisIU1Onuq7g
X-Gm-Gg: AYBFou2t7OmurBzIzzraLDYc7B/4dsP6gqF1rtbz4vHitQUTrdESALE87iBELISKOOK
	QjHy5vE0oseWicdVRkP92jG9XNhcAEo/eZoXCylCW9Pbzd052/Nk1gH3rS45zLmTteEFhUGGYzQ
	eIegal6ypnZ13fBFvlbdHODjZtw37frXoaeS0W6Fzfy9KCZVOq97mpHB0L+GnQtS5QkvS72Y5X5
	5FlvqEhn54KgcyHqT6lr7DZUBqrMegjyItdxb0oYXWFFsk3O5YD6oBFq81SHEiiwwRJvIjp01Aj
	2PGAK8OXF/HmKag4RoYHj1za2/xhdyax9lgn+3OcawxF/F0ddOLzkRA=
X-Received: by 2002:a05:6402:1f06:b0:6a6:7385:3eac with SMTP id
 4fb4d7f45d1cf-6a98ea6695fmr7436a12.11.1788894789633; Tue, 08 Sep 2026
 12:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908132838.2116068-1-jmattson@google.com> <CADrL8HW3Q=8eBf-=h6BAPdUN_X1Z_-KG=i5a5rA2kF+V4JURww@mail.gmail.com>
In-Reply-To: <CADrL8HW3Q=8eBf-=h6BAPdUN_X1Z_-KG=i5a5rA2kF+V4JURww@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 8 Sep 2026 12:12:57 -0700
X-Gm-Features: AcwNN1WICV71coBtmvzzLnIk4EtMFsoM2wm7296OoHvg6Zg2kiR6KXAOxhndtII
Message-ID: <CALMp9eRJXozpUpdOhqDCWn7VbqHb9G9hn4aZnxS_fef4ad1yTg@mail.gmail.com>
Subject: Re: [PATCH] KVM: nVMX: Don't flush shadow VMCS12 to guest memory
 during vCPU teardown
To: James Houghton <jthoughton@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 10:35=E2=80=AFAM James Houghton <jthoughton@google.c=
om> wrote:
>
> On Tue, Sep 8, 2026 at 6:54=E2=80=AFAM Jim Mattson <jmattson@google.com> =
wrote:
> >
> > When a vCPU is destroyed while L2 is active, KVM synthesizes a nested
> > VM-Exit, which flushes the cached shadow VMCS12 back to guest memory:
> >
> >   vmx_vcpu_free()
> >   |-> nested_vmx_free_vcpu()
> >       |-> vmx_leave_nested()
> >           |-> nested_vmx_vmexit(vcpu, -1, 0, 0)
> >               |-> nested_flush_cached_shadow_vmcs12()
> >                   |-> kvm_write_guest_cached()
> >                       |-> __copy_to_user(ghc->hva, ...)
> >
> > During process exit, do_exit() calls exit_mm() before closing file
> > descriptors, so vCPU destruction runs with current->mm =3D=3D NULL on a
> > borrowed lazy TLB active_mm. If the borrowed address space has a writab=
le
> > mapping at ghc->hva, __copy_to_user() corrupts an unrelated task's memo=
ry.
> >
> > Skip the flush when KVM synthesizes a VM-exit with vm_exit_reason =3D=
=3D -1
> > (e.g. during vCPU teardown or SMM entry). In these paths, KVM forces th=
e
> > vCPU out of guest mode internally--no architectural VM-exit is delivere=
d
> > to L1.
> >
> > Fixes: 61ada7488ffd ("KVM: nVMX: Cache shadow vmcs12 on VMEntry and flu=
sh to memory on VMExit")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jim Mattson <jmattson@google.com>
>
> Hi Jim,
>
> This patch looks good for a stable backport, but I feel this kind of
> bug could easily happen again with the current API.
>
> One simple thing that would have prevented this would be to:
> 1. Change kvm_write_guest_cached() (and related) to take the vcpu
> instead of the kvm, and
> 2. Check that vcpu->mm =3D=3D current->mm before doing the uaccess.
>
> This wouldn't be as suitable for a backport, but I think it's better
> for preventing similar classes of bugs. I'm sure you (and
> Paolo/Sean/others) will have better ideas. What do you think?

There seems to be some awareness of this issue within KVM, so that may
not be necessary. Also, as Sashiko points out, we have issues with
reads as well as writes. I don't know how many choke points we'd have
to test.

AFAICT (with AI assistance), all of the current problems are rooted in
the following call to nested_vmx_vmexit():

void vmx_leave_nested(struct kvm_vcpu *vcpu)
{
        if (is_guest_mode(vcpu)) {
                vcpu->arch.nested_run_pending =3D 0;
                nested_vmx_vmexit(vcpu, -1, 0, 0);
        }
        free_nested(vcpu);
}

On the SVM side, there is no comparable faux VM-exit. Instead of
calling nested_svm_vmexit(), the teardown of SVM nested state is an
open-coded sequence. Maybe something like that would work better for
VMX?
