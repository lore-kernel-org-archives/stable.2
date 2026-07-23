Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EB93909B8
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 17:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828885; cv=none; b=J5FcGCM34ygnyaI5AsixNOMqY8stAVy8YYC+MZki8EIbGQd0kpD2jjgUwQ9oq4oyBQedIAkAIYEWc0tDBJyiBbPAo1qcEwDppsN5auAAXwXlUAovF2KywwRAKSv8wMlhfqtyyBhuCZJdAMts3HO9IfH2iMQ/MbMx3qSbICsNGp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828885; c=relaxed/simple;
	bh=3qLyTYWGoxi6sGfiYqAC/+yt//wOXa44KtbXz74JOFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tEyKcrxH7FCuyLJ4BSRMfI7ekbUkcbtFZiX2xSfpqvL8ZLgynFOZGP5CpkBNF9TRaDpKyjofFnUd5IyvEMk/ijqZ3JI5SKu0iL1XYJj4W0Bn/cdOz4iW1X4vV/J/S3wp8FvYJQfb6ngKQNTpKpfrcYeTRwwXqnGx/OO+tw22NBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6901F00A3E
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 17:48:01 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c167aa9500dso124925366b.3
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 10:48:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoRtefCWFZpbVfjurGrSK964PEFROuyb7zEYptjPI2UFKmPZyOdYldUy41ZwZWhQ8rN/6O8hpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiNTVmh5qGeSzJchc0CbZ3rqeqE/tNiWtAWEvxiZXDrCJ8SB7C
	pVfttbhcF7GhsxqAIZhk1YZPqUmf1GmOkhWLBSlWOMnFlmwQ1wWsOHML4Jn7Dlaw6Bz1jlgvpjN
	1lsx7VeQ4I/duUI88ROuYzp07zPf5nAk=
X-Received: by 2002:a17:907:c0b:b0:c15:df6d:4b45 with SMTP id
 a640c23a62f3a-c1c50d1daf5mr222586666b.36.1784828880876; Thu, 23 Jul 2026
 10:48:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717060505.2971514-1-yosry@kernel.org> <amE5DiLbq5PdYuNn@google.com>
 <CAO9r8zN5uGtYS-Y3qUNDmBh5X3zhjuHkbpEis8ti79977KkGwA@mail.gmail.com> <amJSJuDGXI4oXE5Q@google.com>
In-Reply-To: <amJSJuDGXI4oXE5Q@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 23 Jul 2026 10:47:48 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMsvecLoM1pscH=zRFXuYYo8vstQOF3Cv6Oad--4KEzFQ@mail.gmail.com>
X-Gm-Features: AUfX_mwOz0TVEVCFwWOuSTuZGjTc2sWFVy4j9PunZy6jkkFBS9wZX3wwzu-Jah8
Message-ID: <CAO9r8zMsvecLoM1pscH=zRFXuYYo8vstQOF3Cv6Oad--4KEzFQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: nVMX: Only update last_vpid on a successful nested VM-Enter
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

> > The reason why I moved the call to nested_vmx_transition_tlb_flush()
> > is that it only makes sense (semantically) to update last_vpid when we
> > will actually use the VPID. Otherwise, if a VM entry fails, the CPU
> > couldn't have cached any translations associated with the new VPID,
> > and a flush is not needed if the VPID is changed again.
> >
> > IOW, the choice was purely based on semantics and code readability.
> >
> > > Because the other way the TLB flushes
> > > can be queued during VM-Enter is via the MSR load lists:
> > >
> > >   If any MSR is being loaded in such a way that would architecturally require
> > >   a TLB flush, the TLBs are updated so that, after VM entry, the logical
> > >   processor will not use any translations that were cached before the transition.
> > >
> > > E.g. if L1 successfully loads one or more MTRRs on VM-Enter to L2[*], then fails
> > > on a subsequent MSR, architecturally I believe L2 TLB entries are guaranteed to
> > > be flushed.
> >
> > Hmm that is an interesting case. I guess the right thing to do here
> > depends on hardware, but yeah I think it makes sense in this case to
> > service local flushes in the failure path. It still annoys me that we
> > would update last_vpid even on failed nested VM entries, so part of me
> > still wants to move the call to nested_vmx_transition_tlb_flush() just
> > for that, but that may not make sense for the VPID disabled case.
>
> Yeah, but I'm not convinced that KVM is actually diverging from hardware.  At
> some point during VM-Enter, hardware needs to "officially" switch to VMX Non-Root
> and start tagging TLB entries with the new VPID.  I can see that being at the
> bitter end, when success is confirmed, but I could also see it happening before
> ucode starts loading guest state into hardware.
>
> Heh, I wonder if we could abuse the MSR load list to deduce when hardware switches
> its TLB tagging to VMX Non-Root and starts using the new VPID.  E.g. maybe put
> DS_AREA and PEBS_ENABLE in the load list, followed by a ton of MSRs to chew up
> CPU cycles, and then reverse engineering how translations to service PEBS buffer
> writes are resolved :-)

Sounds like a very interesting exercise that I do *not* want to do :P
