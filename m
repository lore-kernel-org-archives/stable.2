Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219BD52FE50
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 18:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791915089; cv=none; b=Upj+TxNznFkpAFVMhW7mYNxoQAvNz+q5Jd62Cy6aEnv0Prx+CaNu1xk+hMMlY5VbVHWf58RauhKIfZh2TRcTm0VHv5nMTh0HGYLZbQs9hzCjm9otirMaMrIeF2TxS9iyWoy/uvLEPGOGJ93zilLShq2F3q6Oqvfci9k0MoeHLMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791915089; c=relaxed/simple;
	bh=kv86hYmMBQbE6TJlkSIrAxs7peU0eDUoWLJiPP1cayY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lAmgRWtokyQw8+jWOELANYuMOEP5c4YFnQNLr7rLRyynBXp4+wQi3B0AGX1x363I7HyQfSShCYHqucn280GctMNG90eRdQaFeuJJUZ7d4I/I4UZw+NaQBI75i+vOYbUP9oei34L3lhsQ83g0rvGCwoJ+HGFzjEb+LqbS9op2izM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJjPYU4X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJjPYU4X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69621F0089A
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 18:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791915086;
	bh=4OjR8fAbEV1UOCWAVOuvTsWKBC+1E/b3SdLW0QHtZAI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gJjPYU4XkvKCROILlLtY5tlRdwhWjqjMgP4JXpxehr0p+1eA52vm6bnNOiDPEPkyP
	 ysEU/jeL0S0xjdZOhtwsvCfA8ROOFpEqfKVr0n6c6ST2ZhwNi8LpSKFFOjWK5K4hFp
	 gnVKCT3/3CmwHPRs9diP7ci9voap7K8jlQDS4vMe1zztoA7GWMKw3pT6jBLJPNoHBz
	 YCPenXESMk0WSbA5a5bvXM0jRhl9oFXyDrUbRENkGv1dn6nK32qdbncvPGn3q6dimn
	 4MworbUIF4YKWjR9h9Q1bKUYUGJ5slVRQiVFSI+NKNcr4PuZlxtKUdgVabtHsbEqTQ
	 QVzwPl15cMVTw==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b1aa377c61so3785140a12.3
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 11:11:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxe99r9CHsltqihepICYRim2bxUmUOngzoyhJ/WLgmZaY73vWw8DeJO3nGo7Mp5hF92msMVttQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7nlivq7gEzqI5QB4n4iEXSMVQnTbFSHo13H9rfVb9s9LFTyml
	v34O+YqNua/4F5XieCxkCt5NYt0v6+dVICW2B6aleYBHAiy1iFgQ4EviKehHNqr6w1G3pkMKTxE
	T9WDZQh8yCcsNxlMmNF8N1iVFYQmNPFU=
X-Received: by 2002:a17:907:3f97:b0:c37:aae1:c6d6 with SMTP id
 a640c23a62f3a-c37aae1e8a2mr135061066b.18.1791915085716; Tue, 13 Oct 2026
 11:11:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012224736.2306637-1-yosry@kernel.org> <CALMp9eT6eJSDaJVJ_1mrn8-sP6F88q-OcGrEgUWy-YpAkuA9vg@mail.gmail.com>
 <CAO9r8zMsih9vRJFWgbE=bgWAqBzwPO3KJiAyBVA_hJBgjPp6mQ@mail.gmail.com> <CALMp9eRRb_8vbm3YM9dw7XbDsnjQ1wRYK10oNq4JAgkUZdpFLg@mail.gmail.com>
In-Reply-To: <CALMp9eRRb_8vbm3YM9dw7XbDsnjQ1wRYK10oNq4JAgkUZdpFLg@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 13 Oct 2026 11:11:14 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMBxWT=A7+tFUTtDiTu0GNodQEiGw+EKRLesQghk9aBSg@mail.gmail.com>
X-Gm-Features: AclHuK88B6hXdxvdCMwDNqS1gVFH0NICZdcesTbWDjUVLSw6ju3r10N_RvKj5UQ
Message-ID: <CAO9r8zMBxWT=A7+tFUTtDiTu0GNodQEiGw+EKRLesQghk9aBSg@mail.gmail.com>
Subject: Re: [PATCH] KVM: SVM: Update tracked pCPU on pCPU switch
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 10:55=E2=80=AFAM Jim Mattson <jmattson@google.com> =
wrote:
>
> On Tue, Oct 13, 2026 at 7:49=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > On Mon, Oct 12, 2026 at 4:58=E2=80=AFPM Jim Mattson <jmattson@google.co=
m> wrote:
> > >
> > > On Mon, Oct 12, 2026 at 3:47=E2=80=AFPM Yosry Ahmed <yosry@kernel.org=
> wrote:
> [ ... ]
> > > > @@ -3892,13 +3893,22 @@ static int pre_svm_run(struct kvm_vcpu *vcp=
u)
> > > >          * - The new VMCB does not detect a pCPU change and runs on=
 pCPU A with
> > > >          *   the new ASID allocated on pCPU B, which is potentially=
 used by
> > > >          *   another vCPU/VM.
> > > > +        *
> > > > +        * Note that dirtying both VMCBs is not strictly needed, bu=
t the per-CPU
> > > > +        * tracking is shared for both ASID and clean bits, and tha=
t CPU must
> > > > +        * match where the ASID was allocated.
> > >
> > > Is dirtying both VMCBs not strictly needed?
> > >
> > > Per APM vol. 2 (rev. 3.45), section 15.15.2:
> > >
> > > > The hypervisor must clear the entire VMCB [Clean] field to 0 for a =
guest, under the following circumstances:
> > > > ...
> > > >  - The hypervisor executes the guest on a different CPU core than o=
ne used the last time that guest was executed.
> > > > ...
> > > > Failure to clear the VMCB Clean bits to zero in these cases may res=
ult in undefined behavior.
> > >
> > > Suppose vmcb02 runs on pCPU A, migrates to (and runs on) pCPU B, and
> > > then migrates back to pCPU A with some clean bits set. At the next
> > > VMRUN, pCPU A will happily load stale state for anything marked clean=
.
> > >
> > > At some point before that VMRUN, something has to clear the clean bit=
s!
> >
> > Dirtying both VMCBs is not needed in all cases covered with the new
> > code here. IIUC, clean bits are VMCB-specific, unlike the ASID here
> > which is shared.
> >
> > Because ASID is shared, we have to reset the ASID generation for both
> > VMCBs when a new ASID is allocated through either, and update the cpu
> > variable tracking which pCPU allocated that ASID. Since that cpu
> > variable is also shared for tracking which pCPU ran the VMCB last, we
> > also need to clear the clean bits every time we updated. IOW, if we
> > had two variables, asid_cpu and vmcb_dirty_cpu, we would need to
> > update asid_cpu on pCPU migration for both VMCBs, but only update
> > vmcb_run_cpu for the current VMCB.
> >
> > This is all annoying and confusing, but that should go away in the
> > static ASIDs series, and we should go back to only updating pCPU
> > tracking, flushing the ASID, and clearing the clean bits only for the
> > current VMCB.
>
> I haven't read the static ASIDs series, but in any case, this patch
> should stand on its own, in case that series never gets committed or
> gets committed much later.

It does. I just didn't spend time trying to improve things beyond the fix.

>
> My complaint is with the claim, "dirtying both VMCBs is not strictly
> needed," which seems to imply that dirtying the inactive VMCB here is
> optional. In fact, once you update vmcb02.cpu/vmcb01.cpu for both
> VMCBs, dirtying both *is* strictly needed so the inactive VMCB doesn't
> later miss a pCPU switch.

Yeah I guess it can be verbed more accurately, something like this:

Dirtying both VMCBs is generally not required if only one VMCB
switches pCPUs, but since the pCPU tracking is shared between ASID and
VMCB clean bits, it must be done once pCPU tracking is updated.

I won't respin until Sean takes a look, in case he wants more changes
or prefers to make changes while applying.
