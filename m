Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235EB51E432
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 20:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924197; cv=pass; b=dx2akjDtSQkSdUfGC160ScbC87ynNzbhBpOB2L/YQR8lLHmq8uQCz/LGq1tBZLv/19M/+kPvilFx9S/x3+DWQPXifOs5b7itfj2V1oavRLKpXbZIHqwgz/Ypm+Z9lqMd5PK9V9y6h4xmoK9egJB8lUmqiD5Iag0UkdfqwafQvUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924197; c=relaxed/simple;
	bh=aUqSZx5Jyb/Fk1gOVNP06/1f1jP/+rE+8FXc33EN0Jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ett//T3BBY10z3QZA/t5YK7+8o/Xo7hPxqx85sgzyiuWW778W5+pfeOkSbwZMYeECETn40zNcKPdrhXSUIMqlqwEUJKcB7FwLE6UTSXjOT+pwexVS6bNSKlLUMAJglUKPcRhxYjYKB8ZYgc3mb7I5GnzYoaMH7hFZkCaGGFG5Og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VXHaanHQ; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VXHaanHQ"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b1b12de661so31261a12.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 13:43:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791924192; cv=none;
        d=google.com; s=arc-20260327;
        b=GNqYOZs+carmD+GZZVSgXuX3XpJHNzGdryICZ5JFp1Wb5o4v2TY13ccdhwJOw/jQqI
         wsqW+MRaRwT4iFuqD4pmO1jl4an3NPutdfR3HyTRiNhJVY+dNmr7DsyqZZKoXuC6Q8vM
         b8Y1ui4ximfaU6wAcFb7HnwDzzGkJhQv9Lk5scc9QVkzMLtEG7oTY9+mLv0oOFs3BpqF
         WoYe0wDHsvboz40RmqM04zU+fjnRNgexbyS3/KvhQIXLkSOfipJRkbEYzHKOxhp3YtkC
         u2UAN1Jk5mwDeEVvc8hYVgExjwLHj6qUP1KtupeBgO/4d34xQ2XbCjr7aseaBfQw/9+5
         PJFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aUqSZx5Jyb/Fk1gOVNP06/1f1jP/+rE+8FXc33EN0Jk=;
        fh=fQ+Lo6hbPzOj65hr6P1uiduRDoBqNjNm6Cx+Y1ME/GY=;
        b=bNRsXBJvMOyYZfbrq5PIf9WyZzc7rATDAEUkBbBB0tdgG+lEBvxgrPzs21PrNibylB
         /nVzXpnydAQIPoOvEzQYVAHQBsVPjw0VIOoNtieyfaqkn3pBAZFnu9o7OW0ZCtNSRe6e
         15wxE6rokuBGeidj0LHFiNrBS7qxqdfggYDbH/KCBiS39qx5f2gLSKma0ps6ZTyIZjbv
         nZjDaOxImshNeYJJHRKMAqt26xaOK0bsPuulWehFuac9s1tgbsdGwwUMVpeNj4d7p0NX
         dV2Jd+AJT239gSJFrZE1DA7pVg09QHq/KnSJGTpCfLdX0KNtDVzieAVpfVd6wh4RqxAl
         VDNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791924192; x=1792528992; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aUqSZx5Jyb/Fk1gOVNP06/1f1jP/+rE+8FXc33EN0Jk=;
        b=VXHaanHQ/eTBrPRL2Xka3nGMQGz2gCSnvjbzw1gMtINrNoibDMWmIxJAjhOQWAliyB
         zkFYB4W0QH6afS8XSud2PgiNPOpVk/c3VE8iMAB1vb3izGOsgUGCto+PRE4A2zQD8gza
         r4b46Onr2K4fPrYmrrJX4jB55wHQRhkT1vh43lUN9wve0RwchnXyO0XGm7OcA0fxx7mn
         rV3/lC73Rg64thxnyP70r5LRkJD4Q681jgvt2gWbHQ51WOObNlkjYkBX0u+4bQkzg5iD
         5outp2Yre+pBSi0PGPGGDseSDJKhyp3CDNsKW9/5GtVEbgXI/2MSsGFBVf60Ihvxyuvn
         1WeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924192; x=1792528992;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aUqSZx5Jyb/Fk1gOVNP06/1f1jP/+rE+8FXc33EN0Jk=;
        b=103MzG8nHIgAqaa9/zDtzInlzfmQ29acKz1E/l4DFZxCQe3JT2R+KkoNXjngJZQcG+
         D0KbTDqEkUNyiT6E2hVWTLJDa1Fz1+BadLi8qNKVuijg4fVQjPglwj72xEWCJmSUnfFZ
         /0dynLgrzeEfkggsfobmQLPGmTJRZLdupHKevaxtwYd39IXlev88mVqREgC7wFqCa127
         nES1+N0G6h+C1tpDtgby/a/CfGkPBBj5SNbRCq0h3b6rV0DVBE6TaQo4MuNS1E3PQxln
         1L+cZZuPYt3OhsEXqSSSMRZcL6RlWn1oRTYzwIOletRr0yI7J7YXIdlITzMHJygJNYUt
         g2Ww==
X-Forwarded-Encrypted: i=1; AKwUvBxtfH/wS9YrFTxi1Ht4B0XPECn6b+8XewWiSJaUY/P1dK33yD7948ywdXd8N8FNrzJATp1oR2E=@vger.kernel.org
X-Gm-Message-State: AFq9FYJSb9/yT+lOPDPHQLjI1zkHOCaKJJygq0vOlaaAnmUjyF9fxkdi
	YJKKriXf1eqBAEz+2K6Nx6aCWf2YdU1K+mwBS/CWvlj6oylTFVlvs1Upyf40gcDk+iT1EXmC/rK
	58XN+7z2RtZ+7aMjEi0+1Cq3dxcM0hDRd48EJokbO
X-Gm-Gg: AYBFou1J0gvh1hTR5hg7PMdAnj6o6Rk837Vi3Hlz1KvgZdIInrpbI2gS1uy2Zpj/QvH
	Zv/g/aOB/WJRlQTtmfWtcLB/FMQEfIxhcyiQE/e3TUvGb2OyoRAHAwMC7Bk6lAudngrIMXUusvd
	TW0HaaA2tldtEew29iNBAsSSSutrDoosfmLptwpnzyE8E9Kx8nMMgLxEIwU0qF8nzq+gdVrIuBQ
	qpCZ1Ut1n/rKJVqLUfrme3v1hOYjPQhpIJCRXzuU0Z2dJmMN+Q5rympOsI5pwMre6vt5c1Tvhvi
	p/g2/to+XChNUdIQ44WLj3gGEN1si+iAwluVrAoY930i+IwRWpxN1LY=
X-Received: by 2002:a05:6402:a593:10b0:6b1:d313:16f8 with SMTP id
 4fb4d7f45d1cf-6b1d3131c5emr128393a12.0.1791924191858; Tue, 13 Oct 2026
 13:43:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013195358.163375-1-yosry@kernel.org>
In-Reply-To: <20261013195358.163375-1-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 13 Oct 2026 13:42:59 -0700
X-Gm-Features: AclHuK-YmNn8NSDVLimMh9Yal2P17VNQJ0PnXTL8TAurb31p4J1MK23ZmaxEhr8
Message-ID: <CALMp9eRDjH=GgeCUe50JngFJtup4Lx2t-uHgpyEwyVB9VjQPVg@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: SVM: Update tracked pCPU on pCPU switch
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 12:54=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wro=
te:
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
>
> Because the per-VMCB cpu tracking is shared between ASID management and
> per-pCPU hardware VMCB clean bits, also mark both VMCBs dirty when
> updating their tracked pCPU so that the inactive VMCB does not run with
> stale clean bits when later entered on the new pCPU.
>
> Fixes: bf260dc9e7b8 ("KVM: SVM: Trigger new ASID allocation in both VMCBs=
 on pCPU switch")
> Cc: stable@vger.kernel.org
> Reported-by: Stefan Teodorescu <fane@google.com>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Jim Mattson <jmattson@google.com>
