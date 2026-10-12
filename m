Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710F23A6EE6
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 23:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849503; cv=pass; b=b+w0Sd4aahLOp8aUrolwvDj7vJQG70ISQwWgzh80wPuaz49ftnCES5/ATdlDLz0bnKGmhBEvgO7bfSQy4HAlsnRBrFM9FJ54ipEgtyiuQE1SbuaF4AJxh6mkYTaIEkI32p+Lfy853hxzGjAJwyTG0UyKe92pW+wMkZOl0ZexWU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849503; c=relaxed/simple;
	bh=TIKNEtSSZZwsgEqG1OHBoYhHPulcgW5G9lXX9ggjeUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LDD97couNzjrt7VgdkLA8XOKwFtjTaHNz4+jrx3Lo8eOC/rz98KqVBlWBCR1WFFdzfU4XPv6N420/pan8kxPQcFoBMi9apjmSBToW1CB3X7OwzqURRJqzJXfR8wpVgAoG9tRjC6ROIc7HDZVniHrFmLdPavPJJ7b+gV9CHOpQ7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wF1WxYBp; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wF1WxYBp"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso17210a12.1
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 16:58:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791849500; cv=none;
        d=google.com; s=arc-20260327;
        b=PTM3wxRlzohOhjDJfZVhi1qZgdinIvl8QQYPCL+Jc55rkiNtBO/6lK8eTB92q64qUE
         LR5aNSS90YqJa5lOwBfcw7pkIK4KlTLzpJ3P+yq3KvJxTNZVGX7qFh5R0frYbEGOMv77
         zdbKQijo58A/JQ+7/wG/E7oR5+XjeG7u3PByTSVxy60IoAoCy3yv/kyciSm2fCwyjrM3
         13RGR3aZRZelw8WVQhgsACneAIteXVimbzJz5HWN4H8YnDoJwFk9Bm+PTdGQJBAgprcL
         JFv/SQkcTZuoheZM6IepESnD3KmyuQo45D1sR6qcMBdfKOJ9QqrRQEyFrtmqLuOL0pD5
         H7zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jke8sZvl/cOH5/M2fMJSe4QmNznKAe9ZWNvWwbINTQg=;
        fh=uxCCFmhbFHAZYCLfBA1BpVMrd5HOwmMYRRSZB87NuOc=;
        b=DjNHGCTs6fVePHjuIKDCT8a9xXvxWHDs2YSdcImrCUoy2gCkDHD9Hx31h7lES9kx1F
         WUZ26MU/6dRzsoUbUaIEsflSiT5VhnGQwQbp8iSy+QSX22dd7cpyaCZCEJn9eBy3MGnq
         2Uk7PkZMhOwzZ+1lpDO6cLM9Ry2//ohZ/NH4XguyFVLTd48YHdb/yAabtL6qTdiJlKSD
         /Iwzf8tKi/ixMAMvZNnO7QEdX5OmrqZBab4HvFc4jhHaQXJXsq2taZyB5ZuTItPziesg
         b298qD+EJ5wKDuebCl7gWMSMdEoo4XHE8nguEhXxTunCmUfvhyswlOjt3ddygvl2vq/G
         lNBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791849500; x=1792454300; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Jke8sZvl/cOH5/M2fMJSe4QmNznKAe9ZWNvWwbINTQg=;
        b=wF1WxYBp4orfIRTGTI0Mvux02f0J6r1jR8uGj9ruWSeLuvUV/05FWTQG1y64tTZaC2
         /T2iB3YXssW9fFJsgoIalFvdSexYxzwaEGbkmINrVRKB5b0Aug7d10DBnODufnKdTTug
         TlOTVGP/PozQmqAR9pNvPVXeEeZK1uVKdoWxIh3mHNzb/uwWc2uqPOdkxFU/KBY5m97P
         BAbd/kl+ief0Qrbiw/oH7dLDr6X63CHzZn3+infmOiI53B2jGXdmW+WshoAHO0cSv/iW
         9lIWIlDRziUKEka/HD4FPLYv6GgVyse6lqAuD1Y+gOrMfzqMndnWDuOVmm86m0tVlFnw
         qXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791849500; x=1792454300;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jke8sZvl/cOH5/M2fMJSe4QmNznKAe9ZWNvWwbINTQg=;
        b=zlnJIuNyMgbH+TZDCNJtJTijM/6a1Pi1sgDnNbRX6/XVgPJomDyahoumzKngYgsTsO
         992RAX9nSFyE3yrETArhzq2FcfiJrCJ010CZRZjTwMgOwyR27k8Sm5/mO1Zo9vODHPca
         zsgVE9QA0H8aqaD4TWG0FdT75JnCdjTNKjNCT3W5nHrjN316SPaGGA7tW7AY2egACuWr
         e4LAGyhIiSUJWP8LflcuQ7qlmV0CaZD1bF7zjB14MgvUYk7kP/HJDbLSXIPslfe0O01p
         bas24UX9lc47iPI93ZOkAgOKDrve4XNTZxii/tvD6Pnsd9JC/Ibqz8j25YoRO3blf0Hg
         1acw==
X-Forwarded-Encrypted: i=1; AKwUvBzYF9Ceu0/HGidD39tTdX67waPlzY/VEpkHeqRz/RaVTk+NRX+JHYfT+nqPysZsq9fcbub9obM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLcyGiXCUrBLPw4yxPPQ+u7grHbKgVWs+T6dsC8z4ei9Ow48vWP
	lssl1QRXTqkdYyn5R4ZlVKhGufEy5J5GvH5myhXo9BcICG7SXhAvDpOR3CuiuYnFE5xmDW8Ratr
	mU7B8hxeAbs/qzbXujmJVbOnkVhoCCLi/D4+xPhGk
X-Gm-Gg: AYBFou3XCgMA76RK0nV66DoVgy6bUlUKisbzGBSc9Y5sX5nhT2y8e8lOCLrO4Cva6LP
	+pvtdIW8gs6DZcP07Ayyp/FTcy6dn/FminZKikmurjgpSXT6mHnNmOB3+7wOKOsmFrsAOKLof5Z
	Aee0VbcI0rUxXbCvNSsBMei+nbgx09Lh+w1y8AnU09Q4824R+vqoiT2lwt5pW1wQXxdqCKZCQpw
	HOJiCgq+Rw+awsFQPK+qIBo0zbEDavs5YJT6x2azJrkaYdxy/x4ergopQ9f/vJrqMZN8xkqwKd/
	0pgxHysNlWYfIHASWArLyDgxpt6U+qZ9zS3tDI0u7/kTA7FvXgN0LCg=
X-Received: by 2002:a05:6402:20d1:20b0:6af:97c0:ce51 with SMTP id
 4fb4d7f45d1cf-6b199a7e653mr81874a12.13.1791849499352; Mon, 12 Oct 2026
 16:58:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012224736.2306637-1-yosry@kernel.org>
In-Reply-To: <20261012224736.2306637-1-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 12 Oct 2026 16:58:07 -0700
X-Gm-Features: AclHuK_xvWgK5Pyi-Cy4y6lMrx0iKf50IEOBsBnEGOqjLi6FdmtUTEnp7aghPX4
Message-ID: <CALMp9eT6eJSDaJVJ_1mrn8-sP6F88q-OcGrEgUWy-YpAkuA9vg@mail.gmail.com>
Subject: Re: [PATCH] KVM: SVM: Update tracked pCPU on pCPU switch
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 3:47=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> When a pCPU switch is detected in pre_svm_run(), update the tracked pCPU
> and mark all fields dirty in both VMCBs (if nested is initialized), in
> addition to resetting the ASID generation in both VMCBs.
>
> Commit bf260dc9e7b8 ("KVM: SVM: Trigger new ASID allocation in both
> VMCBs on pCPU switch") reset the ASID generation in both VMCBs on a pCPU
> switch, but only updated the tracked pCPU for the active VMCB to avoid
> unnecessarily dirtying the inactive VMCB. Leaving the inactive VMCB's
> tracked pCPU set to an old pCPU still allows an ASID allocated on one
> pCPU to be used on another:
>
> - vCPU runs with both vmcb01 and vmcb02 on pCPU A (both track cpu=3DA).
> - With vmcb01 active, vCPU migrates to pCPU B. vmcb01.cpu is updated to
> B, asid_generation is reset to 0 in both VMCBs, and a new ASID is
> allocated on pCPU B (setting vmcb01.asid_generation =3D gen_B).
> vmcb02.cpu remains A.
> - vCPU switches to vmcb02 and migrates back to pCPU A before
> pre_svm_run(). Because vmcb02.cpu is still A, no pCPU switch is
> detected, leaving vmcb01 with cpu=3DB and asid_generation=3Dgen_B.
> Because vmcb02.asid_generation is 0, a new ASID (asid_A) is allocated
> on pCPU A.
> - vCPU switches back to vmcb01 and migrates to pCPU B. Neither a pCPU
> change nor a generation mismatch is detected for vmcb01, so VMRUN on
> pCPU B uses asid_A (allocated on pCPU A), which may collide with
> another vCPU on pCPU B.

By "collide," you mean that two vCPUs, potentially from different VMs,
will share TLB and paging-structure cache entries? Yikes!

> Because the per-VMCB cpu tracking is shared between ASID management and
> per-pCPU hardware VMCB clean bits, also mark both VMCBs dirty when
> updating their tracked pCPU so that the inactive VMCB does not run with
> stale clean bits when later entered on the new pCPU.
>
> Fixes: bf260dc9e7b8 ("KVM: SVM: Trigger new ASID allocation in both VMCBs=
 on pCPU switch")

Commit bf260dc9e7b8 hasn't made it to Linus yet, has it? Perhaps Sean
can just squash this in, rather than carrying a fix for a fix.

> Cc: stable@vger.kernel.org
> Reported-by: Stefan Teodorescu <fane@google.com>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---
>  arch/x86/kvm/svm/svm.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 136069dfcd44f..0a0af0cbb6bba 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3880,7 +3880,8 @@ static int pre_svm_run(struct kvm_vcpu *vcpu)
>
>         /*
>          * If the previous VMRUN of the VMCB occurred on a different phys=
ical
> -        * cpu, then mark the VMCB dirty as hardware's clean bits are per=
 pCPU.
> +        * cpu, mark the VMCB dirty and reset the ASID generation, as har=
dware's
> +        * clean bits and ASIDs are per pCPU.
>          *
>          * Reset the ASID generation in both VMCBs. This will lead to ass=
igning
>          * a new ASID now, and then again when switching to the other VMC=
B.
> @@ -3892,13 +3893,22 @@ static int pre_svm_run(struct kvm_vcpu *vcpu)
>          * - The new VMCB does not detect a pCPU change and runs on pCPU =
A with
>          *   the new ASID allocated on pCPU B, which is potentially used =
by
>          *   another vCPU/VM.
> +        *
> +        * Note that dirtying both VMCBs is not strictly needed, but the =
per-CPU
> +        * tracking is shared for both ASID and clean bits, and that CPU =
must
> +        * match where the ASID was allocated.

Is dirtying both VMCBs not strictly needed?

Per APM vol. 2 (rev. 3.45), section 15.15.2:

> The hypervisor must clear the entire VMCB [Clean] field to 0 for a guest,=
 under the following circumstances:
> ...
>  - The hypervisor executes the guest on a different CPU core than one use=
d the last time that guest was executed.
> ...
> Failure to clear the VMCB Clean bits to zero in these cases may result in=
 undefined behavior.

Suppose vmcb02 runs on pCPU A, migrates to (and runs on) pCPU B, and
then migrates back to pCPU A with some clean bits set. At the next
VMRUN, pCPU A will happily load stale state for anything marked clean.

At some point before that VMRUN, something has to clear the clean bits!
