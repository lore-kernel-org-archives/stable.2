Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE72578F2E
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782143338; cv=pass; b=jOilBJ6oBKerdSKCgQTQTF3ydOSy+lOMYUI1VMfQMRwX7W+BArQLKU4Z4aGBijcycMbnJFzdtfdN6SYszFNvfKdyoXT/poEbDkDSJ5l1FPZXnP4B1rPRJfRwnQlT+4t1B4bLU0PwnubT/fM7l/JKFusS5Gvo4y+mEJoaX+nAEM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782143338; c=relaxed/simple;
	bh=9KXUHzooZ6A4y0KMRUZR+/Wvmg2ePvw6LkNmcJ3n8rM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l5BnA0Eeq4lNmqP97UkUsix39rGMWWPiFFfZGRM3n8/OyJYDy1Vu72XAEvCgZM4TU6J4Ba1rs4bDR1ae5c7ZrpiBqImrHOhQbQ50Kg3CvvTFayovXSMul0WULX/L7+jJ1P6W3sUFF3SXVW7wOj7k1kFjcgwhz5Ne7+Mqv1A7Bdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nx2dxMfI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MRLNOYxY; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nx2dxMfI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MRLNOYxY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782143336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9KXUHzooZ6A4y0KMRUZR+/Wvmg2ePvw6LkNmcJ3n8rM=;
	b=Nx2dxMfIKexh9hoGgYPfnZaNTQ8FFaooFvlAZbk5/ykoUW1o5OhthUJTiCacS+wFsgFyvP
	xQTOgIhcGPnJgTsrVfWWESa8D1O6bJGAAcmj5zkcorB5+ipd69grkCBuqYkxCb+vem4l2x
	Pn/Edt0mpr50DExrA8Pe6Iz5KyEcT3E=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-l2b_ZfIlMOuCZSP_yeBO3g-1; Mon, 22 Jun 2026 11:48:55 -0400
X-MC-Unique: l2b_ZfIlMOuCZSP_yeBO3g-1
X-Mimecast-MFC-AGG-ID: l2b_ZfIlMOuCZSP_yeBO3g_1782143334
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-6a0e15d07e6so3858032eaf.1
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 08:48:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782143334; cv=none;
        d=google.com; s=arc-20240605;
        b=ADPIA2QiYrDiLFW66Xo4AqrOAGHBn2TQm1/OlPFeYZ5ai/h7B5XRGi3abkYu0SNX3S
         VB2Jzu0d10jut3X3ZtLXBmULGK06+uPot+ga1MjKfmY8hjNWTsupv5xYPF2KVUExmJ9T
         p/4ad8PTdBLycKNuw0jmRLpcsEsF8HQqQDghlKa9vpWSXB7xNjh6sAhpgOPIrqMKVFc7
         MwVm8DTqZYYHk+P1b1/agQDRaLMAuoC7c3CjXeparcWc6ibdY+oi+eI6OKjHRoHSMy0o
         /3WBVqdPEUbD09eXKo81PB0YSX9xXevszUovca86vAGkksL2LM2p2GkKFhmo3xhJcNRA
         4Fbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9KXUHzooZ6A4y0KMRUZR+/Wvmg2ePvw6LkNmcJ3n8rM=;
        fh=VJhm9fo5SUO4RaGSaxh6xBIYVpieVoxrjCA5Lzp3sfM=;
        b=h5xnmY1N0ZRfF3pn7B89+cvYfaLYOUfSwqXIdG/IJ5gE8rcb7Y+jKEwuKJT1lY5S2x
         Smr1dhPGD69RfcSgzvMRRv3rIsUwhqVbhv5LCx+SyC6OmAlboRe/O+SC8Zzz/rNi/M4h
         ExUSsCrCAyoMpL5YUJ4L/92ItQ90jErH5dJuXBgEPvfEVfIHw0o1JJhWW3YOIUDTTuOl
         B098yYcrAhKJzbPKrQfYCwvZoYrBCPm0DK4TkcvS6odeqqkbO5jH03hUYHTIz38Gljzp
         OBYuBhJBILTYzUzCwiXkWGwNFpdvB6KmBh4i6IoojarzeT+IKyqqKE33pVA69GI4DFJM
         oxfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782143334; x=1782748134; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9KXUHzooZ6A4y0KMRUZR+/Wvmg2ePvw6LkNmcJ3n8rM=;
        b=MRLNOYxYhItLcRFl/tu9QFd0YsFm6fWUgADos1IgY/ciySvjsZxmDxpRMy5zOIBuP0
         3Hg0b9qA23F8Ui/AyAw5OqeKmSgB7shCHj/DNF6uDdqfDhCr8GJIGqJ9HLv/Rs2fk2db
         FZjeBbQtSwFqMPoHA5Z2qAMY3Q8OAkdPSL/T7OhsPQ9M7S/Hj+lV5QUY/1Vz/PRiaIya
         aIu+e5n88jCyrUpAeX5I4EEkYKDRIYfOU5L5QOrv+FGXFdqNkDR6/93Bfa8lscfoY5yf
         70Ps9h3dQ4kgprhwenPgh473OH/x94ehqhmURbSq4sOyr+muhiO/3B0dItgv4mDr5Cel
         +Kaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782143334; x=1782748134;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KXUHzooZ6A4y0KMRUZR+/Wvmg2ePvw6LkNmcJ3n8rM=;
        b=L9avWdVJQOUly70F5YHxc2555Pe2fFKPa7659VL2pMFwsfT4keSE8MCyNG9GUjQl4j
         3YzUFWp3K8klofWH752nHYrFanYqUYHG55YKaftT11OkhiXU1XEh8O106UaMmgrw9vox
         uAbwkEvDtpHHM7+j7LGZizwpcoHG6y/Epouu+k8RS2r/YjufqI1LaN6G+TpOVUj1gJ9X
         a1cTu+99kaikyzwdN2/PnT/DHhZisi869bZRb2O4O9dGfFA6APsArNs9k7qjgpHZx0Ya
         ei1npKdrUXUzHL/uncX83Bd8svihXRXMg8zy1eZfcvj/fPE3IYccOnrXM/HcWP8zngrs
         iCOw==
X-Forwarded-Encrypted: i=1; AFNElJ8tYReoP1cz+ZOyO786cramCNKSHN/cv1bpSko9BWHQTYdUb6EXiF7RpWBVDXgCSOJSzmhiOhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQXwzks3t19RW6scgVVcbHHrOjcMZxQ9S59Bsp0PEo1AT4ec4S
	VMUncfrpOv7jNCkGen2udr9GJOSGol+a8L0qJEfgaImxkNTY/RaxVTRqdakCTlJiW4KIJ+odgUT
	OwPdg1B4L0rZldbYSnt3MpxotUg75hCZwF0TuDos3+dzNKZZXqpoN487XrlRcEau+d+wl3zhA/7
	sMl/e03bjxLsPiNegwD43SUaUXDU3RfLFJ
X-Gm-Gg: AfdE7clzkEqJXNR32SO7BaiHP3XQvxOuucOcSzgxji7vL2+vclzzl2RoHdpbaop96IO
	XTYggjiU9C+0o5qzf55PfHSD4+dY+cxPNGH7m8iRmaWdm5VnbFuozveZYBUOGDz3/bw5tR2LLd6
	IgDAOdAT3ndezluf9ZA8XEKAaG+a9l5Vt8YDLuxSV9D0/Y1+P77HyO2x6OLZ0d2VICjpHRatKTP
	ldp4CbypBRr+dRgJliff7elV9Jf
X-Received: by 2002:a05:6820:8108:b0:69e:3c79:6e7c with SMTP id 006d021491bc7-6a0d8992909mr12978971eaf.46.1782143334544;
        Mon, 22 Jun 2026 08:48:54 -0700 (PDT)
X-Received: by 2002:a05:6820:8108:b0:69e:3c79:6e7c with SMTP id
 006d021491bc7-6a0d8992909mr12978928eaf.46.1782143334005; Mon, 22 Jun 2026
 08:48:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430014817.2006885-1-desnesn@redhat.com> <20260503071749.6abda137.michal.pecio@gmail.com>
 <CACaw+ew8uV5g1G-6qZGtVBEYZ3k+fvFrOq3XMyq-Nuhbq5mdnA@mail.gmail.com>
 <20260503213111.117db3a1.michal.pecio@gmail.com> <20260504093118.615ff480.michal.pecio@gmail.com>
 <20260518083339.507e24bd.michal.pecio@gmail.com> <CACaw+ewSWTo72fSk2Q7ZzCM8pNuyrX5ua+qA=SZOQuNNMKSA5Q@mail.gmail.com>
 <20260522110328.0d3eecd8.michal.pecio@gmail.com> <CACaw+ezqEO_PgjGeYCLq5hA2eKczFXgmZLa8qjPtVJZCGwsdsg@mail.gmail.com>
 <20260523022944.59799d83.michal.pecio@gmail.com> <CACaw+exPdwXVsJc5Xr=vN1WJt8XR46=X0-8PP=+5dWY5zUrKeQ@mail.gmail.com>
 <20260523102815.5c05c70a.michal.pecio@gmail.com> <CACaw+ezMnQh2_oqbZ0jF99+wOADMU2vSMqxh9BoJoefjAC_ixw@mail.gmail.com>
 <20260527103221.7f8b15b0.michal.pecio@gmail.com> <CACaw+exN3fdzGQE7oK-hRE3KpMrA3ckPDRAcXaFbd=ySXf8E5A@mail.gmail.com>
 <CACaw+ewuPm-eOACKX3Ux0UwJBRSftoBm7H+rxE2Z9E7KzWb5ew@mail.gmail.com> <e9472b38-4a91-44b5-b75e-dc7abd23793d@linux.intel.com>
In-Reply-To: <e9472b38-4a91-44b5-b75e-dc7abd23793d@linux.intel.com>
From: Desnes Nunes <desnesn@redhat.com>
Date: Mon, 22 Jun 2026 12:48:42 -0300
X-Gm-Features: AVVi8CcAlAvfkd2ErCnICSEvqW5Np5KqWlEvhK2rTPgdX5mT-Gkc_TQT0VvBDf8
Message-ID: <CACaw+ewAk_fs7gw83kRJ=Gj9oSPLMru-txtbPohAttZEyn0qvg@mail.gmail.com>
Subject: Re: [PATCH RFT RFC] usb: xhci: Kill hosts with HCE or HSE on command timeout
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Michal Pecio <michal.pecio@gmail.com>, David Woodhouse <dwmw2@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	gregkh@linuxfoundation.org, mathias.nyman@intel.com, stable@vger.kernel.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello Baolu,

> >> To IOMMU maintainers: should I send this patch to the iommu mailing
> >> list and move the discussion there?
>
> Yes, absolutely. The iommu mailing list is the right place to discuss
> bugs and fixes, so please go ahead.
>
> > I meant as a new submission to IOMMU maling list, since this started
> > in xHCI at the usb mailing list.
> > Of course, that is if nobody has any comments or objections to the patch.

Sure, just submitted this RFC as a new submission in the IOMMU mailing list.

Thanks Michal and Baolu,

Desnes

