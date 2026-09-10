Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C983D59B688
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 19:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789068787; cv=none; b=er8zoah9R8QKySa1fZdL65EIPpc2gSvz7kEQIDbVPw4osfsPKR/yHyLeGvIc76pFJlUih/G4adwNe9VmcREZ98mUAl0fRHxIGdOxLirPjo6fANTLB9tQ3WUopYDLVMGNfpaiW/KcIkfdzXR1onVWpRM2tYjlQHeoppjhbGdSK4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789068787; c=relaxed/simple;
	bh=OaL2gIY4/rvYENHa/VV3JZ6qts0VkGiuYhfofseuZ9I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=usbH3V7lhkzuDV7NPh/Lmw3oZ8elKVXAqIxufxlD/theGhxxwyNGX90dte6+J2p34GTgXr5XTXYOPej/m+7Zdxht+g+kpkFSpTKg6WJDXYKPeeZ0N1kWZnVnPDmLH1LOeHONlcCIg1VhG2U4TtqBaKx+oLP+oBEKEcc6dHW8CNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tepGuMwe; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tepGuMwe"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-868f443cbd0so43498b3a.2
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 12:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789068774; x=1789673574; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0LO3wehpioybmx3i7IEixw9RnbaJnGBUVwi8qW7M7RA=;
        b=tepGuMweAM+uILF1KssKPC0y1nCdviJjfFZiQnschqJAPvW4VLZD2l56daP+wpV2xS
         Qaw1Z3a2vlIXkpCJN1Wq8FwNv5plD2A7EhavmzXgSULk6D2L29Kl9lHd7t8pLU8kZh1V
         vkvIoBrmMBrw/sddhF4vOtNEhKpM0tqM9+g7u0PdsRRWJZkybnmxE0a4Lxu79004lCLO
         Pt94NagDmeg4fUsu/ou0e7uOXc5mcUiEubTSOeLcZbCDsK7wRiASCP5QNfXc5dBQvLEg
         3+0fd1MKidjU2rwws0HqBrSy0UeZSmuzIHCu06JnmJHfo9Vprl2gwFbig+ckNspRa77T
         cQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789068774; x=1789673574;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0LO3wehpioybmx3i7IEixw9RnbaJnGBUVwi8qW7M7RA=;
        b=paWggKKY/gRaAWgF4sfiCUgmogV//+wdjsN9/dSX3dved0AcguthQvgyxgDN0U2qmt
         R/33pn7K8uXY6qQLxMKK2g2PMldUw+qkpPThckiGH2Det332mtCXxHAmq5Etk3djxMI7
         ykWBhEC0O4eFgACwpVyQlpa4mDPz7rp7UikpqUEGZxPiqvi5NXeZ1AOm10j5IUoH2qFx
         mvz5Oe6kGqfM98Acn/m0HuLRyaJdYPE+0c5XL+FClq8m9uoESb5B+DU/2hQzItr0Q2Kg
         atXWciVxrFoeDEAX0LqclbTgavQiyA+nMumm1WcWeebGumoKfM0Vn+i5CkAT7Of8f1xh
         u2KA==
X-Forwarded-Encrypted: i=1; AKwUvBzn3LfabvNXHuwx52N3Bng+tJEVnl1rAcss2kAkLensqFzgOudtRnVgBLd38ybd+cpXrlh9gE0=@vger.kernel.org
X-Gm-Message-State: AFuF++kUv9lTXp25IAI1ZB9nxennmUEuwQL9Cw5VNjjWX83Skc1hSVFm
	BIUelnIBkcwpUcSlpuqxPnTO2+Q/4cL/2MZJkmDw/0D7E+RummS/xkxXaj/yq+mZam5JWtKEdKr
	EEUoscA==
X-Received: from pfqf15.prod.google.com ([2002:aa7:9d8f:0:b0:848:49f6:6f5c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ad8e:b0:848:30c3:45dd
 with SMTP id d2e1a72fcca58-86b3041253emr623075b3a.11.1789068773550; Thu, 10
 Sep 2026 12:32:53 -0700 (PDT)
Date: Thu, 10 Sep 2026 12:32:52 -0700
In-Reply-To: <aqMBidJ_96qroogH@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260908132838.2116068-1-jmattson@google.com> <CADrL8HW3Q=8eBf-=h6BAPdUN_X1Z_-KG=i5a5rA2kF+V4JURww@mail.gmail.com>
 <CALMp9eRJXozpUpdOhqDCWn7VbqHb9G9hn4aZnxS_fef4ad1yTg@mail.gmail.com>
 <aqGsukcRG6khmxpt@google.com> <CADrL8HWRjzzs7YmNkGDYQWDnygw=OcdgqCWCOfdt9af0-XwvVw@mail.gmail.com>
 <aqMBidJ_96qroogH@google.com>
Message-ID: <aqMF5GVp6qHb-WcY@google.com>
Subject: Re: [PATCH] KVM: nVMX: Don't flush shadow VMCS12 to guest memory
 during vCPU teardown
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026, Sean Christopherson wrote:
> On Thu, Sep 10, 2026, James Houghton wrote:
> > On Wed, Sep 9, 2026 at 12:00=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > I wish we could just change the uaccess primitives, like
> > {,__}access_ok(), to check that `current->mm` is not NULL (and WARN
> > and return -EFAULT if it is NULL).
>=20
> That wouldn't help at all in this case, because the access_ok() check is =
done
> when memslots are modified.  Which is the crux of KVM's problems: KVM dec=
ouples
> the initial checks from the accesses, relying on kvm->mm to
>=20
> And even if we hardened all of the uaccess helpers, we'd _still_ have pro=
blems,
> because it's not just a NULL current->mm that's problematic.  The last re=
ference
> to a VM file, i.e. to struct kvm, can be put by a different _process_.  I=
.e. KVM
> still needs to guard against reading/writing guest memory using a valid, =
non-NULL
> current->mm that isn't kvm->mm.  That can't be genericized in the uaccess=
 APIs,
> because the rule that only a specific address space can be used is very m=
uch unique
> to KVM.

Oh, and I'm not saying we shouldn't try to harden the uaccess APIs to guard=
 against
a NULL current->mm.  That absolutely would be worthwhile.  I'm just saying =
that for
KVM, it sadly isn't sufficient.
