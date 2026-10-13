Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A090C52ED3B
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 17:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914101; cv=pass; b=Zl05sbwUCcnMw8iCCO4LELN+x0J/ur/GpHLGrNdcu4TWNYuDmr5TrQa8k6fF7/euRutVAkD9J8sUD891UDcza6hRLiC00q9HuJuv9E4CzjZXzKzKH7U3hjNFUdPww+ZRpVUEaXgsZxHKgfl3TCWNoKd9m/HGWhtX9fZLK5DXTH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914101; c=relaxed/simple;
	bh=BMSS1jckBQ2e870f/uI3vrk/j+iBZv6E/rBVCsIo22k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oz5B+kk2BiQ+GxnSo6+CkGeMQES/YSPiIEEWTOSpnyxUaUoMMsVHR+tWnjV7AK1zBSKYkxp4ep6DkJrQ+RzUgOa+TtYucgNGtHs4lMfGcfEL4EhbwiSnwfQZliSDBg05tL+c9v86dXmq3q8YO+c4KO3wWQf1K5iwy2/sDIrfNSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TdzfnWTJ; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TdzfnWTJ"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b1b12de661so28736a12.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 10:54:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791914098; cv=none;
        d=google.com; s=arc-20260327;
        b=maoJSHT49ScAPtwLXskMbScVARJDuHktrKdIpxJof169igG3FqQ+D8+KqlTAhg41Qw
         Ad1uzMvYognI+zluGEDtv8Mz+CiLh0MOVWuw4nawsZIbJzByfKMoZJ1kC2GVyJ2OxcTl
         hXSI7vsFgfoVSPimWTjluKGR5tYXQd3a71tLnSmUF7JvYJNDVtt5yjcDOSMcfTroLu5U
         l4LJ21RPeKAWFBGbKy137fOJxfY1i1nmdeZzGqp2BOIA9avE11u/YeZqJIW37h4KxMHS
         1rgT2uyUcQODqTPWpwrP2kYwwSpbxk0s5rxiu1TCmncYjFwtbKLJ0Gl/PA8dmv3U7PeD
         ewAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SRtjnC1p7Gi1e00oi/1sIVluDFzpjss9Zq5iLpeEpPQ=;
        fh=FN5gzpXX9QX6nrIQujtvYN90Y4I7t+Vco32GHjT2i5Y=;
        b=nHF39LgYwAvTrpaDU2aU/mONBXCYDkI/vkIbACpfjI8MBq+WRA1olJPre5fzUlKKno
         GlohoVVQc/hBu2AkbHthFjIbk2YFfZM3aR+Wzc4z8VlokM4xw5Nx8Q8PbEFAZq3eiMab
         tFQTn8pUO2tkfRL9g7HQJSe2r0+mPJfxkDFeetnK1sufG5uNMAWKRRVwaajiW1p+CSfb
         xl80uTaEiY0CyGCrNUHhP2qU29yxpjRX+w3gQwjlOLuqAGVNomvWaXYaI70pxjYo/TEa
         esHqcpFFNSK9YouAVEkYG5mPxhLbF7Rv4xEFKzDBppL7pFf5EyuhaKGJICuvaPIgKv/J
         SItw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791914098; x=1792518898; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SRtjnC1p7Gi1e00oi/1sIVluDFzpjss9Zq5iLpeEpPQ=;
        b=TdzfnWTJ0JE4/RKyDdhY635Wlr0PdD+bTTKkJhom5yLAE/BFvIk2t5NwioHKhupKQJ
         Sfp+OcN2pW4OI1AEHHMoVEAs8vvAgMX7MDKKy7RKj2Oo13oEDrgj2+PbgmW49ppQyiIz
         NVqVlu6s6A/VgYlcZlqPS8CW2WLnr202X9VMSCnS2flGKOvd3eIZ5hX2quvDMqR8smEJ
         YdHQCl3mRnjZwyt5CkulHrslCszA2udgoU5PGQyUhY9CaOUZ1/oPx7xdzcde3qwTVEln
         2SX4/8G9SZu9gRhq2n15tsjDrYy+6lt43T0obPvRKoSU9ropeaESFA3BnfsRa8y0O3Vh
         af3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791914098; x=1792518898;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SRtjnC1p7Gi1e00oi/1sIVluDFzpjss9Zq5iLpeEpPQ=;
        b=hyD2D1rPWEc3rnEJXi7XrugJy7N42EfkpQw4PHTD/fWMkN3mI4qA3peLnC6zOcWCe9
         93N4Wizvbbq8KT2wexalFhfqwE7YC+uClMmisWR+EZZ9JMw0x14M2KUPD0TLX3DrE2tx
         1mASQ+pek6NNJWbs7zuXQQiqXXEO+TX5bHJR8ASoDv92RHPXQgtMZr3arGBO66Qda1jo
         mrk0o8YQPh7lAoLh9vqPk9ZfAQt3PreDf7SqfmfgkXOsR1n9iFFGGsQ3OCul6lJVCk0y
         hRrDcOk9WBFr0rrm/cL3N9TPVO9S+OjSK5qN8BsFiNjpb3wIsJA6mmBmXSICLoNV/PIB
         abQw==
X-Forwarded-Encrypted: i=1; AKwUvBwTb+Yphb8+WMec/6UQgIPqOyCO2RI3jXHJ6zHEiovsTBI7mmcAsbDfDPFrjKKkS2BPlxhIprc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLN+cEsAGxny93KJICemb4PYjjNwDPZqfVnd+2EzJ+ixNjzcTzv
	RUT362+//M49lryviDBNevxFcuzzXSu1RShFykoDIIq08okJXiMr5cFb99fCLws7D9qS7ie0coS
	SYF4WpJxSicv343XppMohreKfjTj/QDVGRK6ZbNjw
X-Gm-Gg: AYBFou3/e5ZhYz6hp5eXWYyONQs/2XMvBtMYhHtc66JInudCM28o0LjloyDYGA421wJ
	5extOWThgJJ4Sqjwx1UraWEjWUSqJSOSiYVehIF63nNDjhrUlrfEbYYJd4qliN2ut4CZbglqa2+
	P12RJ2rib5Y2SWDa1uLHAD+InxQp68d/W0UkOyqr9R3NSYbyTek+6hvBpHtFVaYCZyF8Xk3oh8A
	xhAbcWLoY8e2SXAYWLsj6u/XZ+LLo7T90DSGJKfgwjLoBz7zg5FD/4DzSvZFqVOC8UmYQUnUaii
	PJ7mMDWhh15qxbh0fGQ7pg+TeCgwkaafIkaun6uSJfRFGmPLJ03GCWQ=
X-Received: by 2002:a05:6402:150a:b0:6b1:b3bd:1576 with SMTP id
 4fb4d7f45d1cf-6b1b3bd200fmr133982a12.8.1791914097201; Tue, 13 Oct 2026
 10:54:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012224736.2306637-1-yosry@kernel.org> <CALMp9eT6eJSDaJVJ_1mrn8-sP6F88q-OcGrEgUWy-YpAkuA9vg@mail.gmail.com>
 <CAO9r8zMsih9vRJFWgbE=bgWAqBzwPO3KJiAyBVA_hJBgjPp6mQ@mail.gmail.com>
In-Reply-To: <CAO9r8zMsih9vRJFWgbE=bgWAqBzwPO3KJiAyBVA_hJBgjPp6mQ@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 13 Oct 2026 10:54:44 -0700
X-Gm-Features: AclHuK8WC6fCM25ehSI8d6hZUp_f28nDxtHAyGF1VNE9tdU9vNWCl9URQ28bhU0
Message-ID: <CALMp9eRRb_8vbm3YM9dw7XbDsnjQ1wRYK10oNq4JAgkUZdpFLg@mail.gmail.com>
Subject: Re: [PATCH] KVM: SVM: Update tracked pCPU on pCPU switch
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 7:49=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Mon, Oct 12, 2026 at 4:58=E2=80=AFPM Jim Mattson <jmattson@google.com>=
 wrote:
> >
> > On Mon, Oct 12, 2026 at 3:47=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> =
wrote:
[ ... ]
> > > @@ -3892,13 +3893,22 @@ static int pre_svm_run(struct kvm_vcpu *vcpu)
> > >          * - The new VMCB does not detect a pCPU change and runs on p=
CPU A with
> > >          *   the new ASID allocated on pCPU B, which is potentially u=
sed by
> > >          *   another vCPU/VM.
> > > +        *
> > > +        * Note that dirtying both VMCBs is not strictly needed, but =
the per-CPU
> > > +        * tracking is shared for both ASID and clean bits, and that =
CPU must
> > > +        * match where the ASID was allocated.
> >
> > Is dirtying both VMCBs not strictly needed?
> >
> > Per APM vol. 2 (rev. 3.45), section 15.15.2:
> >
> > > The hypervisor must clear the entire VMCB [Clean] field to 0 for a gu=
est, under the following circumstances:
> > > ...
> > >  - The hypervisor executes the guest on a different CPU core than one=
 used the last time that guest was executed.
> > > ...
> > > Failure to clear the VMCB Clean bits to zero in these cases may resul=
t in undefined behavior.
> >
> > Suppose vmcb02 runs on pCPU A, migrates to (and runs on) pCPU B, and
> > then migrates back to pCPU A with some clean bits set. At the next
> > VMRUN, pCPU A will happily load stale state for anything marked clean.
> >
> > At some point before that VMRUN, something has to clear the clean bits!
>
> Dirtying both VMCBs is not needed in all cases covered with the new
> code here. IIUC, clean bits are VMCB-specific, unlike the ASID here
> which is shared.
>
> Because ASID is shared, we have to reset the ASID generation for both
> VMCBs when a new ASID is allocated through either, and update the cpu
> variable tracking which pCPU allocated that ASID. Since that cpu
> variable is also shared for tracking which pCPU ran the VMCB last, we
> also need to clear the clean bits every time we updated. IOW, if we
> had two variables, asid_cpu and vmcb_dirty_cpu, we would need to
> update asid_cpu on pCPU migration for both VMCBs, but only update
> vmcb_run_cpu for the current VMCB.
>
> This is all annoying and confusing, but that should go away in the
> static ASIDs series, and we should go back to only updating pCPU
> tracking, flushing the ASID, and clearing the clean bits only for the
> current VMCB.

I haven't read the static ASIDs series, but in any case, this patch
should stand on its own, in case that series never gets committed or
gets committed much later.

My complaint is with the claim, "dirtying both VMCBs is not strictly
needed," which seems to imply that dirtying the inactive VMCB here is
optional. In fact, once you update vmcb02.cpu/vmcb01.cpu for both
VMCBs, dirtying both *is* strictly needed so the inactive VMCB doesn't
later miss a pCPU switch.
