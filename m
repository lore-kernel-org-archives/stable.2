Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607A045C70F
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 07:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790149786; cv=pass; b=LRerAeME5AwPTaIHQLT5YkKGYQx0cujSLOVoV2GTDpb1pJcRm8Uq9uY/j9rNqAT2qYFuphmrt0OBPsZhmKaPGHHJQKFdK1klo4Dhg5a6SdZe8rWSyG5qsDSeyH+VQ29oMOgvYyKSejJ/RBZPbHJZvXCzyCP7VxM+VeemOP5yXhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790149786; c=relaxed/simple;
	bh=a5qiSmOjocnn+sDqyBmDHtNspXpe+m+DapVB6S7w/58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AQ24lmBjLB+ViD+BoCpcvNGPvqVuWfU10vUb8Kl1HAE8kTjkprUxym4bDepchu6SP2Bous1IpHNcmYG4dqRqSeVod3vUZJz+EbTXNVj/g3yZE2bQ3r+mGSVUgP2A98dr5C52n2Nk++Vhnh9ACddigZrKuHzXLhElkbftAp6DbpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H1gk+bPF; arc=pass smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H1gk+bPF"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ccead2aecso2547715e9.0
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 00:49:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790149782; cv=none;
        d=google.com; s=arc-20260327;
        b=Hy04uoZ+qu57UMaM13ltcFkXXCy7JHk34QNm/IgBtIBOuZNAP+6/OvFReHbIgzAhqd
         92dTbd1dLdwFb1xUALpFHF3GF569OxhcrAO6R+2IYjtzxq6zkA0T/ffPSnZPh7zwNieO
         UmE2gYZAqdFA3blwTle78wdy8J6LRu+LsxaHeV7ToLRK68kjA1JQxsw7yg9Xtdo7Lk9J
         TOd3m2jfvRNhqCD8UT1d1f3aTwJex+amiBuLnHV9C2RcH1dTBwn6v6mfhb6915ex9AMF
         d+v6R+Jh3PsdYZI5xJqJjpzQJB1jTG0oayX27OkfNJNeWOIg7nSo0GyAva9kGYnUqSU8
         vMaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dtR7efeps0npha21Xq8cylYx7rCwpCT5/pR+0N1hrII=;
        fh=2mP+pJggPNCdSHANLJ91cUFqhCjso7LAPKRkrBNbUSI=;
        b=cypuJVM8x4bJdUv4b7wXZa5877lRUNibUqbnQZdYl3Po7v0fxg2/y0Af+Knho3RShZ
         +0NtNE/bmBrMh+2woSSgCEgA8Lb3rPwp++RiqStDYGwgwbG/y+cCG5w9Ia993i/pY+s/
         aTGh4qAEBcXqg3jan/4QAwM4w+1dZsl064eu8sp5gG6rIdD5CLnsQZHpINaA2rnCPqhN
         G5tZJQveBl2MHeN97oDi0dHhSyMt5b+jl9/Tv7ZXyrF0+TRsDvNE+7CnWjr+6RUmjWs8
         +dKf/3Vm9penJBf5VkPivvu5mD/WeXLJh3+C1Yt9/YkfVZG36URR25sViw9LcVy98I7F
         0+6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790149782; x=1790754582; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dtR7efeps0npha21Xq8cylYx7rCwpCT5/pR+0N1hrII=;
        b=H1gk+bPF44wAFVBBtIZ179iwIMQFcnENuYrlmkkddAYX+t4Z4ppKLxxoosG425QuvI
         rZNRSb+wWjnjYw/CvKEXWJrCMgvCA/hEXNXwHpfsiDKqxZOOErgSd7QpA5qTd5MLTOhS
         yLOuWUECktK+vlY8nGxzCxEPdO6uheTBLFbX5YP963M9KytN4fURPtqbRPVw6Iv/ShZU
         ie1XTBJ1PpOfowPUmpZRgwTTQe6/k7VFCROvE9HjZmU+L7h4f+4Up4RJ7bh3qZZgjBHl
         jLpPiDYNNtuQAY5MctOJhydbFCB3H/tWPQbJJHK0+D7oSehK/zM8Kw8KoGJ3TK5npS97
         ibWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790149782; x=1790754582;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dtR7efeps0npha21Xq8cylYx7rCwpCT5/pR+0N1hrII=;
        b=vmGcMEPAMwt6CovNw7oWMQ6ed8jSWzCLuTtvix1DuPP5CT3+vxdw43SjmDKVQnRjal
         UfdI6dqoSae1OOU/nnBft3+VU0/gWBdEl8mz2HIYzbjlUCGob6vbbVrmaeKUisoh1ZOi
         +tCgvctIWc2Jga/qSbSlLmjjPjENjKrMmWUvhjkhF99vnhq/KTx/rmOiGNQwIjOAFuqf
         0QBun2Okd0MtL+L4SaZPCCaOV6Lq1B55FLFZ9CDjjplpRdEl3LkeqjieIQzBNhp5yeF1
         abaaGIQKVu4NWqHeyPgI456kSXjjE09bcG8tyfGwQ1I0FzrJYe9YQ6Oi327bmaIDAqvM
         Yr+Q==
X-Gm-Message-State: AFuF++k/mBlqml6DhWN6nPUZgD/G8qrV8yoD+NTGnDDGUeyKd0AuWAcA
	rXjVyZIIbXksYeLACJ2is3pyGtyDxKt8y1G6LOecPXCRGVmXX/eU7FyIFwxmfKfN//Pj9f5GZ77
	moMBvwP/Mjj1Q/fIe9jtt0Oo9Dz7B+W5/P4UDQ5sB
X-Gm-Gg: AYBFou0FdJw8UBR1R3Whp53zy/QpnJ2XK/Bibfe/gGUWn7QltDpky3civVmNWCwq2b7
	5ACXIVebC299dCKQB1YZxwecJeRtLvZrfX+brwW642Wgau+FrKsteeqzRgsvCZ1EjDPIN9Hq2zO
	FNKQBYt7OJLMoVrV29PPBpq4Np4+YkinUermi0R4bDuKI1wt/ap7zn1tH3NUtEK+31RejO5Y6On
	zMsn5DTUgaMa+pRqrFcyIYL36kQYjBcvZXnmNvHEH4WuD3gf85W8NLOFIBAeN3NtjYJqW+SNtfY
	+o5/wscGp3EsdNuA2Lbh7Af1Q8PsdSUGvrF6BDokCpTeMw76YAhPeYwotz3VhoHWCTcbSxlO+KS
	0sm8oaqmyBA6FX+NWlAFU5YXW3d4g4GqH
X-Received: by 2002:a05:600c:a45:b0:49c:fc6c:bdfc with SMTP id
 5b1f17b1804b1-49fdf135915mr19518175e9.19.1790149781738; Wed, 23 Sep 2026
 00:49:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH5fLggWya+4rz8LWjaCqYQ8eBfds2-yim9NFZ7nZpz6ABdG+Q@mail.gmail.com>
 <2026092330-humorous-unnerve-a325@gregkh>
In-Reply-To: <2026092330-humorous-unnerve-a325@gregkh>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 23 Sep 2026 09:49:28 +0200
X-Gm-Features: AclHuK_AuowFRdZa3Yw4MYohDWyGhwuShhOJclOMm3C5bCDpSjswI1Cp1sONUBY
Message-ID: <CAH5fLggJVV07nNnaeLBaC4qe1bDPw4AySGHQR9X9HoUbU69-Mg@mail.gmail.com>
Subject: Re: [stable 6.18.y] Backport request: two ntsync fixes
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 9:47=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, Sep 22, 2026 at 09:22:15PM +0200, Alice Ryhl wrote:
> > Hi stable team,
> >
> > Could you please queue the following two upstream commits for the
> > 6.18.y stable tree? Both apply cleanly to linux-6.18.y:
> >
> >   180a232ea78003d1dc869b217b4e49106fd58e8f ("ntsync: Honour caller's
> > time namespace for absolute MONOTONIC timeouts")
> >   61611481f7b599e0526a3782c626b1a9deeb48bd ("ntsync: reject wait
> > ioctls with zero owner")
> >
> > The first is needed for correct operation of the driver, and the
> > second prevents wait ioctls with owner =3D=3D 0 from leaving an unowned
> > mutex in a corrupted state (count > 0 with owner =3D=3D 0).
> >
> > Not sure why Fixes tags were not included for one of them.
>
> The second one also is needed in 7.2.y, so I included it there.

Thanks!
