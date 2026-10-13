Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841DA53E2EF
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 19:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791919850; cv=none; b=D+Otw9MaCjk10Pk/UhryMDC3zQdWerpMynFl7osbNIKIHpBtBf+k8VTavZdRZ5a2vR7Pj8vczb7ky4mCtcHmmeL7Sp5IO/bB+mOkpqt8XWosjGzRe9Fvpy/PZ0ob9nCw4SJorrEyBVkqE6zb1QjJp4khhxUFj/SB3QVZv9TS4r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791919850; c=relaxed/simple;
	bh=paauPkaVJbrdDjHEcfZZ9niUqvuJhcPdXpxOLo0Wkm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fvte/Mqns+5grEh4dk8N2ltHDua8fZH6DXC1ghZ8AL3ttHI366GsJjFh8+IVMvkfYrVgLJqyiP8umcvEbhfhu5pvt29mpQFJ8FvMxXaE54Lr/FZcNUAqJME0CQYoVXYOpfkWX/zveB1b8I9DB5m9p6SmPXQOnuu7VNIS3FXYgYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGUI9eV0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGUI9eV0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5551F0089A
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 19:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791919849;
	bh=uPqQ0vIPN/soLCMFGUyT1DIcNjqx30fFPuNDdPzV0V8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mGUI9eV0pRKXRdEb00mojNJn8VadRvvPj5QruhwmP0KYmKdxK4W8+UcC9SBZLi2Xe
	 b8ToGHnyVCPmNmB/ndsX8cr13KsvICnQqSASwg/x+MepZnyuH+pnbBOSVnVsjIecus
	 0hYQgr35vyc4gEfvRXT9LwE1iIX23sJ++Ej3SZ8OaAA3FGVrk5frDsKpQTVg6XhoN9
	 z0VYm/3pyKY43WBOAAe6bIvc7zl9zeAgrD267FA/HBJZAvlmEe4JkT4gcjEvZ1Ipty
	 rgMc8iIWexMchlN9y6IxtZLc6g55Wfzn0HfnSwWI5HVofuiaHq3q5GF5V6V+n5uKE8
	 lXW7ICIZ22uGg==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c2e69aa07c3so39338466b.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 12:30:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByNHUc0cpdC27DLR+B7usodlhbhTa59qs70xN+Zw59Ie1inveWuy0/Hvt3bdhbbA940D/8YiMc=@vger.kernel.org
X-Gm-Message-State: AFq9FYL9bJjo27lclK5InYJB7Bnk4URwKF/L1MGP3D/QnO0woua/oJUf
	kLlz2aypJb4GDsiOJm6L2V4ymbqgVbm4n9yboEbqfFrg/L15zdWG1P/6X6hay7Rm+LElqgLwr09
	qChfdMQ/FgZsBnuVrp29upF9/g8QD+nU=
X-Received: by 2002:a17:907:d86:b0:c2e:7e0b:6294 with SMTP id
 a640c23a62f3a-c31a9fed470mr1333487166b.8.1791919848062; Tue, 13 Oct 2026
 12:30:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012224736.2306637-1-yosry@kernel.org> <CALMp9eT6eJSDaJVJ_1mrn8-sP6F88q-OcGrEgUWy-YpAkuA9vg@mail.gmail.com>
 <CAO9r8zMsih9vRJFWgbE=bgWAqBzwPO3KJiAyBVA_hJBgjPp6mQ@mail.gmail.com>
 <CALMp9eRRb_8vbm3YM9dw7XbDsnjQ1wRYK10oNq4JAgkUZdpFLg@mail.gmail.com>
 <CAO9r8zMBxWT=A7+tFUTtDiTu0GNodQEiGw+EKRLesQghk9aBSg@mail.gmail.com> <CALMp9eTqEWczivrxr06hhGg=519-POMRiSTg5WzRieuXZzTK6Q@mail.gmail.com>
In-Reply-To: <CALMp9eTqEWczivrxr06hhGg=519-POMRiSTg5WzRieuXZzTK6Q@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 13 Oct 2026 12:30:36 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMc1BA0beaoS-4L9_xrvU_R5GHJ6tQ1jLZ7k7G_ESRa1w@mail.gmail.com>
X-Gm-Features: AclHuK_VmVWn5lsSGsJ8NDu_doh2aGVIk_oXyzeOAJfB1m5k_GVRfMXRguTlK0c
Message-ID: <CAO9r8zMc1BA0beaoS-4L9_xrvU_R5GHJ6tQ1jLZ7k7G_ESRa1w@mail.gmail.com>
Subject: Re: [PATCH] KVM: SVM: Update tracked pCPU on pCPU switch
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 12:00=E2=80=AFPM Jim Mattson <jmattson@google.com> =
wrote:
>
> On Tue, Oct 13, 2026 at 11:11=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> w=
rote:
> >
> > On Tue, Oct 13, 2026 at 10:55=E2=80=AFAM Jim Mattson <jmattson@google.c=
om> wrote:
> > >
> > > On Tue, Oct 13, 2026 at 7:49=E2=80=AFAM Yosry Ahmed <yosry@kernel.org=
> wrote:
> > > >
> > > > On Mon, Oct 12, 2026 at 4:58=E2=80=AFPM Jim Mattson <jmattson@googl=
e.com> wrote:
> > > > >
> > > > > On Mon, Oct 12, 2026 at 3:47=E2=80=AFPM Yosry Ahmed <yosry@kernel=
.org> wrote:
> > > [ ... ]
> > > > > > @@ -3892,13 +3893,22 @@ static int pre_svm_run(struct kvm_vcpu =
*vcpu)
> > > > > >          * - The new VMCB does not detect a pCPU change and run=
s on pCPU A with
> > > > > >          *   the new ASID allocated on pCPU B, which is potenti=
ally used by
> > > > > >          *   another vCPU/VM.
> > > > > > +        *
> > > > > > +        * Note that dirtying both VMCBs is not strictly needed=
, but the per-CPU
> > > > > > +        * tracking is shared for both ASID and clean bits, and=
 that CPU must
> > > > > > +        * match where the ASID was allocated.
> > > > >
> > > > > Is dirtying both VMCBs not strictly needed?
> > > > >
> > > > > Per APM vol. 2 (rev. 3.45), section 15.15.2:
> > > > >
> > > > > > The hypervisor must clear the entire VMCB [Clean] field to 0 fo=
r a guest, under the following circumstances:
> > > > > > ...
> > > > > >  - The hypervisor executes the guest on a different CPU core th=
an one used the last time that guest was executed.
> > > > > > ...
> > > > > > Failure to clear the VMCB Clean bits to zero in these cases may=
 result in undefined behavior.
> > > > >
> > > > > Suppose vmcb02 runs on pCPU A, migrates to (and runs on) pCPU B, =
and
> > > > > then migrates back to pCPU A with some clean bits set. At the nex=
t
> > > > > VMRUN, pCPU A will happily load stale state for anything marked c=
lean.
> > > > >
> > > > > At some point before that VMRUN, something has to clear the clean=
 bits!
> > > >
> > > > Dirtying both VMCBs is not needed in all cases covered with the new
> > > > code here. IIUC, clean bits are VMCB-specific, unlike the ASID here
> > > > which is shared.
> > > >
> > > > Because ASID is shared, we have to reset the ASID generation for bo=
th
> > > > VMCBs when a new ASID is allocated through either, and update the c=
pu
> > > > variable tracking which pCPU allocated that ASID. Since that cpu
> > > > variable is also shared for tracking which pCPU ran the VMCB last, =
we
> > > > also need to clear the clean bits every time we updated. IOW, if we
> > > > had two variables, asid_cpu and vmcb_dirty_cpu, we would need to
> > > > update asid_cpu on pCPU migration for both VMCBs, but only update
> > > > vmcb_run_cpu for the current VMCB.
> > > >
> > > > This is all annoying and confusing, but that should go away in the
> > > > static ASIDs series, and we should go back to only updating pCPU
> > > > tracking, flushing the ASID, and clearing the clean bits only for t=
he
> > > > current VMCB.
> > >
> > > I haven't read the static ASIDs series, but in any case, this patch
> > > should stand on its own, in case that series never gets committed or
> > > gets committed much later.
> >
> > It does. I just didn't spend time trying to improve things beyond the f=
ix.
> >
> > >
> > > My complaint is with the claim, "dirtying both VMCBs is not strictly
> > > needed," which seems to imply that dirtying the inactive VMCB here is
> > > optional. In fact, once you update vmcb02.cpu/vmcb01.cpu for both
> > > VMCBs, dirtying both *is* strictly needed so the inactive VMCB doesn'=
t
> > > later miss a pCPU switch.
> >
> > Yeah I guess it can be verbed more accurately, something like this:
>
> I don't understand your prevarication. The comment, as written, isn't
> "inaccurately verbed." It's wrong. With the current implementation,
> dirtying both VMCBs *is* strictly needed.

Yeah I am just trying to clarify that ASID is shared, so we must flush
both VMCBs, but the clean bits aren't, we are only clearing them
because of the shared pCPU tracking. That being said, no comment is
better than a confusing comment, so I can just drop the note at the
end of the comment.

>
> > Dirtying both VMCBs is generally not required if only one VMCB
> > switches pCPUs, but since the pCPU tracking is shared between ASID and
> > VMCB clean bits, it must be done once pCPU tracking is updated.
>
> Clear as mud. :)
>
