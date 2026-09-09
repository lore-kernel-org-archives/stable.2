Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7226D54A7CF
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788968881; cv=pass; b=Nk4+jbYpJCachFPIM/Pd7ZD9jTY/ct2b3KRekq02+wTUgGsIyaHvHiCoSPiNbIzf0f6GCp/K2W9lbqLDyBX4agkgDOh5UsBOxQRmC/P8gf14i1YsMzYLsLT8LgCN/bFVwDcm7y4E4T78eOf5VV4dGijmWpOVbBND1nYPbwEA/EA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788968881; c=relaxed/simple;
	bh=LlddFKck7Cbtl7cf66qSmn1rFxhlvvhQVK4P3MceWSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tKmLMKyzoe4xSN5H47GktB/szmHBDLCvNdk3j4zNk8E0x2FhR2ZC2BOclvaZfP5efaCiEMHdnl90GeVeietuQdnYb/UTTFZ4/7LTiHCAnWZEpuh4S5ywLcQ15aZrQTJYZF0zeGRkTZv4CyxsVSQnNfDQqoCEOGLlegFpFCM3RiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b1E3FjHM; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b1E3FjHM"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff176d5eso9830691fa.0
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 08:47:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788968877; cv=none;
        d=google.com; s=arc-20260327;
        b=D90TtYL/3PvhVHNPgJ1ADouzAd1w2M9aHEJt/QPCdbBQRBQKTpBjZM58pv9f5G9UOH
         rsyt+xh6zAmrFNZ6HP3hVDUHXmdI05Xg6xh5EH2jwDNTmaQ0hJNAjnxhjkZ81EDHQBAK
         UEIRxPR+PCfQmTw1z921toA79tNcGURTyJYQI0sR4asENNLH+e1uDo1opjLBT1rU/X69
         4y7ytvafMuObV1tE9YplFqxmEsesEJE2DEbzWa82tTU2bnkrOZr523Vr7qCobmuweAHk
         ytfOVPNITknjNqNe+m/jbxX2yS0BFeozxqN1/onXUXF8nc9U6SwauySUqle8E9Ua647t
         Xxiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N3dn5TYGV5agCqPjCqQ+csmVjiwwOdvOPtqg6BBzXUE=;
        fh=VZz4jCl+qbClqcW2nxorOEMHGaQvsFtIkOVkyn7TeYQ=;
        b=YZa/OwxrZz6UUBiylchndcxrEl0gSrNhYnhBAdcpd4rH7lgGjrFAIIpUFX8R+lt5D4
         U+C//n3kmkrqFTk31h90PcDFQtoiql5EhDQTUKWFvUmhk2RE/T8bIpWC2/ZjUWqXKVw3
         GsAzOPXmO2YTK+aIWNeCHad79o03RsWL1U2Xv4+3RJK7KBg+G4/gP0pQ8WK7VboU9TUG
         fSQ3eSvTsPaykP3V001JsCTPM+X2j47eW3zvFBc2DE/rXK7y7RL7Bfy0Rbdax38fjGj1
         Cp+Xkt29Fq4NY0ffi2VlYmhwGRc1zGLd+jF7KfWM4zrh/lQqg7szPi1ZvoLQlYoswR+b
         1dCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788968877; x=1789573677; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N3dn5TYGV5agCqPjCqQ+csmVjiwwOdvOPtqg6BBzXUE=;
        b=b1E3FjHMwqAgBw+3zwyYps0xrihQFk7hzssDGLr1NhVO3kCtGDxtVTVQZL3p3AeXct
         +KiprsEVEb4aeNcvVFhLxCuAVnI1NxfeCFzb/kw4k0sWOoR5XcPbgVY9H/RWogcIzkJ4
         sudpcsivnbezxHM/NNTbrkU31CTQeKHgHYd0TgmjQtU2yqIMW7ZoJf5J8Nr7UGioUQmc
         F4/goqsKYMV2J2Iy0lFt6xgaZSQVNYi7tKfb1pX6OLeRdORsXYMLiftVy2fZIYGsGjxV
         qGPbdtYiP95ckKcJvj2sWVBgZMAQUhKdda2q4otvwdg2WKScWVx+mrS+b05Z7uPzwTv8
         VmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788968877; x=1789573677;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N3dn5TYGV5agCqPjCqQ+csmVjiwwOdvOPtqg6BBzXUE=;
        b=asArNMTNGMvyVE6OlTwUrY50CAed9RLUFHaGzr/hfTR7TX4wO0nDfWmf04oywVVdl6
         pcQwLWlKr1IG3vG7Jne3ZxcsqJzSxGQO9afpUuSPTLhqbNJAHks8LVbxYWiFxZVQ31Sr
         FEE7WI7+PDyoCdwp6/Bz3iV7d9SZHL4sPQ9EQ4fGRtj7gIjKnNug0AC6tqbWdaSByhxw
         OKDI8dyVGGap17JTq8s/VVJnmn4AI3BqgNWi1lHD/k2rUKLRxo/F765xkpX0qf2J9whc
         bzkEUT+idrMQfGwBsS6oGj1oGA4L/dv7mhIrzR3nuesNpeFNh2nYKrw2VoqmFhR/haFq
         A4fQ==
X-Forwarded-Encrypted: i=1; AKwUvBxn/KPI/NkvMIsvjhx7V0Uqs0TUnUJygg01NJ5o8ksWlNvm6oqqSkN/MszpaX1ExN6M1GR2l3o=@vger.kernel.org
X-Gm-Message-State: AFuF++nRrW9t9Qyq0YTpZc1X1k98Pdb/0qAzXR7QHRFUusjjF8iT7vOZ
	vDoNNSopoMJ8+jEyQ//9aWrKLT06+dwi/ZJBl45PQOPmGrl3weiTfs9vho9UqCarmmMH01ObM/0
	GYz940+TnK0Y73ymmBcMcrKGKxEzYzlhvUYf0OMeJGick74VfJkLd4dQC
X-Gm-Gg: AYBFou3Ug+DX7zexal/5MhEjr4yEGgb5MdB6W6/ZwGydPcJALbzWj47Og1trpCmFUQG
	BKMNEQdwhSS7CfL14SlXbc/HAYUDl+4rlCsXmK5I0Uio/6Nql+HmxZeI7nNURYaVo14staVO56s
	nqIVYMVI32gCI25jrgmQpzDoYEbk6nCiSW2ygHQIfQtp+XQjG2fLFHbNIRhEAOIdfrsOlJXwIwU
	9elkZPdX2y4Nps96ztiJDc/LcuWQMs6TFppsHhTIBcZ4pxs3GLqt+kUWfttlDQWMF5xAuAJiZ0E
	0hQW8LtBhVzAIfVol1ErBE6QT9ZHT9xKGKnQc+0OqdBAmZu6bOjMieoukWN1HdF765I97qRIVWc
	7sPnwbuXXlJTdrNg9XQyp98XE5CEfgGbYqcQpFItounffUhkjLCZxUpV+nV99496FYog=
X-Received: by 2002:a17:907:c817:b0:c26:3190:2965 with SMTP id
 a640c23a62f3a-c292b1369bdmr624367366b.12.1788968523659; Wed, 09 Sep 2026
 08:42:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908132838.2116068-1-jmattson@google.com> <CADrL8HW3Q=8eBf-=h6BAPdUN_X1Z_-KG=i5a5rA2kF+V4JURww@mail.gmail.com>
 <CALMp9eRJXozpUpdOhqDCWn7VbqHb9G9hn4aZnxS_fef4ad1yTg@mail.gmail.com>
In-Reply-To: <CALMp9eRJXozpUpdOhqDCWn7VbqHb9G9hn4aZnxS_fef4ad1yTg@mail.gmail.com>
From: James Houghton <jthoughton@google.com>
Date: Wed, 9 Sep 2026 08:41:27 -0700
X-Gm-Features: AcwNN1Ukhgq6q__G7rqPGKWnJ807asXYRqEwL6FyIEahxFvLlFuJPzatqI0LcmU
Message-ID: <CADrL8HW89mwdaXKv700G1LS2ymWY7CoGV9VBF8QZWkPPC3eUaw@mail.gmail.com>
Subject: Re: [PATCH] KVM: nVMX: Don't flush shadow VMCS12 to guest memory
 during vCPU teardown
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 12:13=E2=80=AFPM Jim Mattson <jmattson@google.com> w=
rote:
>
> On Tue, Sep 8, 2026 at 10:35=E2=80=AFAM James Houghton <jthoughton@google=
.com> wrote:
> > Hi Jim,
> >
> > This patch looks good for a stable backport, but I feel this kind of
> > bug could easily happen again with the current API.
> >
> > One simple thing that would have prevented this would be to:
> > 1. Change kvm_write_guest_cached() (and related) to take the vcpu
> > instead of the kvm, and
> > 2. Check that vcpu->mm =3D=3D current->mm before doing the uaccess.
> >
> > This wouldn't be as suitable for a backport, but I think it's better
> > for preventing similar classes of bugs. I'm sure you (and
> > Paolo/Sean/others) will have better ideas. What do you think?
>
> There seems to be some awareness of this issue within KVM, so that may
> not be necessary. Also, as Sashiko points out, we have issues with
> reads as well as writes. I don't know how many choke points we'd have
> to test.
>
> AFAICT (with AI assistance), all of the current problems are rooted in
> the following call to nested_vmx_vmexit():
>
> void vmx_leave_nested(struct kvm_vcpu *vcpu)
> {
>         if (is_guest_mode(vcpu)) {
>                 vcpu->arch.nested_run_pending =3D 0;
>                 nested_vmx_vmexit(vcpu, -1, 0, 0);
>         }
>         free_nested(vcpu);
> }
>
> On the SVM side, there is no comparable faux VM-exit. Instead of
> calling nested_svm_vmexit(), the teardown of SVM nested state is an
> open-coded sequence. Maybe something like that would work better for
> VMX?

Maybe, but I don't think I'd feel any better about it (because the
change is still KVM/x86-specific).

Thinking harder about this, I think it is always invalid to call
`copy_to_user()` if `current->mm` is NULL. The riscv implementation[1]
seems to require `current->mm` to be non-NULL. So I'd be much happier
with a check in `__access_ok()` that `current->mm !=3D NULL`, but I'm
not 100% sure that is okay.

I'm also trying to think a little bit harder about the exact mechanism
that causes the memory corruption. I think for `active_mm` (and
therefore the loaded page tables/CR3) to be different than the mm we
destroyed in `exit_mm()`, there must have been a context switch to the
victim user process and then back to the dying process after
`exit_mm()`. Right?

[1] See arch/riscv/include/asm/uaccess.h
