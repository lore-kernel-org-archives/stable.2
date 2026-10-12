Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1388F4AD4AA
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 16:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791824061; cv=pass; b=Tt75iH6GoQlMyxX2AiFERLM6ApXnaSoD6y1mzOWs/NyYgbj4hqw+qUY1hSLcDgZXeMVQiNXKwkPewyhp/HZvnplqo3fcJ0SFv8CSIC9i41+0JRX7OMZdJzbKHcBJcttKs3BIjIE+HIof0OECl9fXjCqOqJ0GkuF9OFzuF/xPwxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791824061; c=relaxed/simple;
	bh=FF0GEoo8z94QCKgAWxqe4HdlXwZe+F2vajwTpAEkw0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zwtd0VX+FkhPJTqZXlxxz/Uhuhc2+4Mt4EQ8vU1+kaIcMM0CNXZBvmKo85l4olsJ2j039xLDcID9Y52m+3t90aHpwFkHOgduyFrViGQMg07bScAtcQljjzwA9zYAo3rygfTkuEBowqRRi9Q3q8nnfK0NmTAmGtZjQNbIDVP1Dfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OPUUnBQP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jgzg3u13; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OPUUnBQP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jgzg3u13"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791824058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NYH3S1JoBPkOp4UPQkopxXaknUWmfyg8ET0Anq8DUUU=;
	b=OPUUnBQPmZwG4397q7V5pGGo9KimsB6EqQJdSSQtNJ65nTcCTe+diLfbv9dChclOUpPwrr
	FYapRBKc4rZg8jqbsGyZj2msEEndRH/ywfyvPL8qMes12vtThiCTz5BbjufqUfcj6x4ri3
	k37V7jq089oWZhlCxVJxVHw8EiH5c98=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-maAcivDXPxOPTLDYAnQrSQ-1; Mon, 12 Oct 2026 16:54:16 +0000
X-MC-Unique: maAcivDXPxOPTLDYAnQrSQ-1
X-Mimecast-MFC-AGG-ID: maAcivDXPxOPTLDYAnQrSQ_1791824055
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a19df2328cso15936405e9.3
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 09:54:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791824055; cv=none;
        d=google.com; s=arc-20260327;
        b=RBpqu+Gg5iEudbEiser1P7qFB34rHr7wAov9dWsaQRyz6tlwlBaqfWtpUNuea9vWNS
         PPF/n66EoaCS7lypx+Bv9rAYKWYCg6e3XgQ1wne3g5mT+jznzxjlUgeE7KsQ15300OKy
         S5ENTAPY3dUIHwmESWQGK85dd1shbP0jfEipA/vUFMHj1AIT62N5HpziuKgJQkjUyD9c
         bLnvWdN5yn1TzKlKg8Ji7Gei7whaJ0yuyywvNXS18AWo3rn46m6jUuUJm8k7lyVuecgS
         Wqot7V/hCZRrokre8A2qRMlpWBB7BjsLDTyC2HTwsDbm7Updk1O+qswKY9m3Jm/8AYFZ
         Dqiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NYH3S1JoBPkOp4UPQkopxXaknUWmfyg8ET0Anq8DUUU=;
        fh=VYpLGeZoUsH9bDH0fIE1Aksx2MBXs49IDNf9USqmNTo=;
        b=EjU0t6utCyhhDsaZRM8OITih+/mKSRM0ux9ThczRB5xTy3eiDtjqrEaLP7Zma1bZS0
         ud0DnujdlunBmwkB6MaYDHgg55BRWcVcgUWNJPLjW2ZZVhmgiXH+TndiA316EDWhGCVX
         XyQb5msfk3R7EAbv4oAe/ff9tTIZpIsFQvqVIK1demsTRiJgmE65bTCLjFeQvKYQtZZq
         vQ2WmnUmKi21IGvAsyYdAqgddp0vEGmLNVXxWuFY95xgj/eXElS6ol3+r9s+ZeDvySuq
         hqPU1n7a/psA2iqJqYZTusLi32pfpHD/emymUc4xWIUXU49eJB448VEA7sMWr0KyqKYj
         iPBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791824055; x=1792428855; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NYH3S1JoBPkOp4UPQkopxXaknUWmfyg8ET0Anq8DUUU=;
        b=jgzg3u13BnnevV7IHTcWK7VCztgkY41/GEfp3nPBY98+OBjpeWhcO0oOCt9Yrcwr+u
         +UV/Z/Zg6sz2iYaTm1bHpHoyB4xGzaw/KY0oxwOGNHpWtU55vkoLz1nFYgGWyaMLyeZC
         SaypY+oKp2hMemdI9GRDe/mLLGM9GEkEgOstxbabMGpRaybfwNu3Jn4g43zQMAt9ABC5
         9OphJQ62kLechDi+NGRIrvCechHhNexYMjWqs2eJ+eMLH6Lh+T2Kiwm/Ia4jivUlqwsm
         4H/fC1MtgjlrnUQj5l8DNHgvWPB1dXltdEmpPNX8D1lZkUfxSiEG9neplJhPLrLFACf6
         4Oyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791824055; x=1792428855;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NYH3S1JoBPkOp4UPQkopxXaknUWmfyg8ET0Anq8DUUU=;
        b=2PggXbu/A2UcfMGEhic5u20qZy5TKPqWDYgVyHG0iLLYx8gZMFWksghL0K/bCbADFe
         +UTK/AYV8sPRI9HOr/OGuHr/dkWZqV+axbrA7nyvcjnz5gP/nWiZfK7n1hrPpk6Of5JE
         zQr0kNzwq6S+0brY+884dsjHvaqs9zStg7Q5jiBRT2pnnSkL/K6mb7e0mgKdAaV3LAH1
         8SE8w96huuBNwlpQp3jCWB4rPJY0jt6GFn5WIFKRwAiR+ljIKBE9XrQXO1lX2MOzZaLs
         4DaT6ukStmvJ874A/gFq1fLZXwLHstQluZcaT4vo17q+HeMihoe/VmSV+89ZU48lAtc0
         IPWw==
X-Forwarded-Encrypted: i=1; AKwUvBw3TYQsi/wpdnPAtMr9u75+UP1K+dqcbve3IjeNlf01L9c0DXXZNaPE+O1xtZgmUjeUps+AS0E=@vger.kernel.org
X-Gm-Message-State: AFq9FYIB8mLBU1mafDUA7C57vE0LRHPNFWgQOBWS6L4Y4XohxpWBRlH3
	tqcXJLZMmGQyiFa+AfxM7b8Y7zUkUAFaxUBofx7dtzG17h+urzrhhZUGtWH8SAxqQ6WLTz9vlGq
	ATm4Py3nOwmFjV3FfwITVvjEeowv6MzrZg+2HQBUeBl9f98yMo0NDMqLgXRJogJ6mxjC/gZH5OV
	lfw/EeLHs0CRxIuxaid4GgVjCmnY8l4eRE
X-Gm-Gg: AYBFou1w0xjFr6i1VKxGcuXaqBpoYFvdPjRluK/SQQ2wuPksObkoNfWwWKiyxGebsJ1
	Obakdzzj+F7xd0+h+MR581B296C36UHjECJVMNngg9Ts7olZQ0JLeNkQWlv3qNwivV/cte/hLAb
	aAWXONMQLI4pen2lL2I6nBRZ0+8A03GFMQJXo6HiTOBio8UJjTfadRuqzbr7mPvJN1bX3bLdmjC
	OVBe/pCrlMpIKIHLPK3cmPRT1oa4dCM5VnmHAIaWDUPAwtBXIqfwiuFeaHmGg==
X-Received: by 2002:a05:600c:870e:b0:4a1:6dca:51e3 with SMTP id 5b1f17b1804b1-4a18e4487ccmr195289375e9.3.1791824055346;
        Mon, 12 Oct 2026 09:54:15 -0700 (PDT)
X-Received: by 2002:a05:600c:870e:b0:4a1:6dca:51e3 with SMTP id
 5b1f17b1804b1-4a18e4487ccmr195289195e9.3.1791824055037; Mon, 12 Oct 2026
 09:54:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009130450.361690-1-pbonzini@redhat.com> <as0NBfuEY-60pgtz@google.com>
 <CABgObfY=xYUJJtYvcVhjdTXOah6eofi0O4C3J3sa60KCC+WO6A@mail.gmail.com> <as0PQm_PS3LC9KWc@google.com>
In-Reply-To: <as0PQm_PS3LC9KWc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 12 Oct 2026 18:53:57 +0200
X-Gm-Features: AclHuK_qwsSa9vmKTJ15UjQhyDRORe0UQJYVVCybVzQPGOouYVa5WGxdhHqz64A
Message-ID: <CABgObfbA4YtSX-K_fsWuTjkkfLh5EMQ2673tJzhZaoAoT-028A@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/mmu: Cope with the SS bit being set in #NPF exit codes
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	SimonP <simonp.git@mailbox.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 6:48=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Mon, Oct 12, 2026, Paolo Bonzini wrote:
> > On Mon, Oct 12, 2026 at 6:38=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > On Fri, Oct 09, 2026, Paolo Bonzini wrote:
> > > > When running Hyper-V from Windows 11, KVM is seeing the SS bit set
> > > > in nested page fault error codes produced for shadowed NPT.  The AM=
D
> > > > manual is unclear about when SS is set, including whether it can be=
 set
> > > > when SupervisorShadowStackEn (bit 6) is not set in the MISC_CTL fie=
ld
> > > > of the VMCB; in fact, bisection shows that while SHSTK was availabl=
e
> > > > to guests since Linux 6.18, this started happening with commit
> > > > 687ee95c1b6d ("KVM: nSVM: enable GMET for guests"), which seems unr=
elated.
> > >
> > > It's not unrelated.  As you note below, this is purely because Hyper-=
V only uses
> > > CET when GMET is available.
> >
> > Indeed, my intended meaning is that bit 1 of MISC_CTL does *not* have
> > the side effect of reporting SS failures...
> >
> > > This is wrong, I reproduced this with the KUT CET test with gmet=3D1.
> >
> > ... howver, this makes me wonder if you meant gmet=3D0? Because if you
> > need gmet=3D1, the Fixes would be fe080f58dec24049 (i.e. when the gmet
> > module parameter was added).
>
> /facepalm
>
> I did indeed.  And I quadruple-checked that I could trigger the splat wit=
h gmet=3D0.

No problem, here is new final paragraph to exclude the theory:

---
Bisection shows that this started happening with commit 687ee95c1b6d
("KVM: nSVM: enable GMET for guests"), even though SHSTK was available
to guests since Linux 6.18.  However, this is not because bit 1 of
MISC_CTL (GMET) somehow enables reporting the SS bit; rather, it's
simply that Hyper-V never uses CET unless GMET is also present.  The
WARN is reproducible even with gmet=3D0, with some hacking of
kvm-unit-tests's cet.c testcase to ensure that the first access to the
shadow stack triggers a page fault.
---

BTW, while Simon said that GMET+CET now works properly for him, I
haven't retested Hyper-V with the MBEC+CET combo yet, and I wouldn't
bet on it working because there's no path in which EPT violations
would set PFERR_SS_MASK.

Paolo

