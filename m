Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906FD2E2DD2
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 01:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792113073; cv=pass; b=lNq6PISH7jpNmcTDzLKyCivFIiZ+n80KWLnT4WBC1+vM112p2y2hRgf43YmffA7owSCJiO/ROFAfVksNcU0gYv8Dsu+7OReROtFbWFQSh+Nvf+CQjZy4IVkhm97O7vXUb1HTL57Le2f+26qHjK7BdFJq8YzYEaGpUvHzIvWnzA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792113073; c=relaxed/simple;
	bh=JzG9jaJYiued69pJ3zjgkohjroIPbtGqeOHKXUqa6kI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gC7dgb+I34LFwBF2TG7tf62h0uoy8g83S1HMJ+oTSMfcVIs7K9gPZH6EZ63xF6Io3QSm6SEpKjAV8egB9uhpbG4JKghKwMs6dnvHyAhD0Wu6B4sdRw4S1xDUlBV6nF/4yLkrbdXvxOMk4W/qoTsa2Oo7RHH5JTN3EkQE2Zm2S2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9HaZW5P; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9HaZW5P"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8aea7b7ca0cso45690557b3.2
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 18:11:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792113071; cv=none;
        d=google.com; s=arc-20260327;
        b=ZcnmqJUe4e/k0YVm/A8jauOTfmlpwb0yNixkqsoivCWdvytWMwnHljXSjabSop8Bnm
         IRqffyyJM+3QYXdV5ORtjqA/Sneo8D2gNL8Wq5ywY5qNO1vvU0Pt8laNu0IMbHH7YLUu
         Cx9Si/Aq08tsLFInc+tnxrpSzIur+hielg23zZG9X2sBKVv+9B6jbPsPcOmBmZqowGBT
         IrYdquNVqoeQJsvV/tzFfJ6Wcjc/T8DEt4lxKXtv334UDxirovyWoqYxVH0RWR6kB3r/
         8RDDZuhuR1MSG1Vvesx1252kgh/XOYfvH750xj+dCANLI6U38C1l3/WGjp9Ab7itDY+N
         oHRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VQkIfSljpkAXMtApCpc6CLLTd+fi+11lXbgR/qs4Vvs=;
        fh=H55OUr7CBfn/mH7yjTFNTXlzEbXsRN8bYo7JtjknP1I=;
        b=UTKBPocCmvMj+IJWn1sjU0i0g/PU21G9WTwWHw8xKiYEcWv3FEFpWnTY05IySJ7LC8
         q4uTH8K6+TO0dtwFTmkIM/DCgikd6e9wg1GS5EUJT1OqXVSpe2FU/TApgjYVDkR74C0x
         k0VfzUb6jbBJsmarVqrJDFnBBGE5H8WZYUcqK+4tCGX1VTF4blZIrwUPslRlsvnlELS0
         OUkB3VinUsqWRqdPTbLalOohWmlHj7FPzrIa81r6ntXwiC33rwaKOCTrXbKHM0Wp+4af
         WwlOVXiPrnn2Hd/o4FbMCkRvVlk0bJDG3bUw3di/lPvO028cVhZGInIXnsu9pXEISzXn
         ZQXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792113071; x=1792717871; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VQkIfSljpkAXMtApCpc6CLLTd+fi+11lXbgR/qs4Vvs=;
        b=j9HaZW5PoxhSqNwvgD0NsFCSS/JbqOhSQfeCvhwAK1DaEInaPVzP+vD/aBJkDw2eiM
         GJKvNQ1Kk8AOZYmfjgSy4Aw9Dtqhj6EBZFgejjiFi2cfcnBxTDIvyGB4TEbKpH9uZxEi
         HAKGkygSLVw/+eZ/6ClYz/f4Pdtq6gwFcP8UbeWsFU2lxDyVB7Jd31houVlvPBoz1a7k
         6jtI5/lxB88olW2p9hmrkx+e02vZRPEhEXwB9568RPEsJ3UtQhC3TJH0Gyq2tctymKyC
         jsc4/vHMJotVqBtBEcdAzobUfI8Q0TFSUuQgzY7tMqbxDI5j6BsqRBeYihDQuwOkXMj4
         ri/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792113071; x=1792717871;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VQkIfSljpkAXMtApCpc6CLLTd+fi+11lXbgR/qs4Vvs=;
        b=iP+XVZDpF8GyNtcBdhpsEPIOSmek18UEtnRwrd8lLkXkHieJl4KhDnTKkRi4fGRbdr
         OD/Az0cbKudmZeNaqZAITkKD8gQTaGTr/nAqbFylXg1b6VaGBt9r5uwlyqQxrS9GmCBt
         nQZupjkEhjYcQGV5Bfw40zDQ4wtfgI1r4ZWJTNXcoTlGMEevF/OWRx1o25iCzhtW/mZv
         f213EW32BuY9MB/lO8pHwN2D5+nvk7/DdFdpUlazZS6N1U9+4OlE//8fFNphSHoIpLL5
         lKmj16PMNgjgszFXX9G3IC/dFJFT4Wadvyd2Va7biC5LjfK7MuTBiGbNUHvN6jKSsd+t
         9+Bg==
X-Forwarded-Encrypted: i=1; AKwUvBzk6PL2MQjdDukwdclAyaB1zqx+y/cKSdsrVkxe1LfvgMRsYQ4r/XPO/pawvMRCzybHdnr5DVU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJXCIKYpzN+Yq1m5sYnqOML830jZ+5YjJAQfx3WXzxnF+XIs9SN
	C+ISTzYb3AV7mWbMLh8JGvlMl+7SfffwJ82Rd3XZ2Uiz3nlImBMH0KHSj7fww1jpTLOpCmLh0AY
	e6pUNGgRgqaOK4OnAGZ0VYoeIa79GHMc=
X-Gm-Gg: AYBFou12dpkZRK0LwDJmWbX+TbYMpsbozqs9OHRiubHeFZS+kIBa8XL/vPJqHwjGkih
	BUO+18lLhQj5Ejntw288XvQy1+DG8RS5Usz84Xn+CSIw2daxnS9Ohloq9GnHgnMTMUSWwVj46xk
	e1EhVr3KTKgocKQzfI4O9YM0YEtjYj+uDXuT96DjnslERvo1hs3eeBUM3dIOUWZtftb5shVGfRT
	wtQDUVJQyW36wLK/mRJJmGFQ5HVIxU1KGVUzLGfXAlDAzB9YqGP8HF66vywyaan8XNcPBPsnLre
	iGkcO2SMJDH1fIqHCnI6v7HIvqgGJw6isrdISh9KID+uM2CRDIN+T7d8ATMVYQrkzvTuWQJ7MY8
	sFPee3X5PGiEeG6lf9/Yt
X-Received: by 2002:a05:690c:c4e9:b0:8b0:8ec8:d4df with SMTP id
 00721157ae682-8b08ec8d874mr61136177b3.53.1792113071334; Thu, 15 Oct 2026
 18:11:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pm-ocfs2-objects-candidate-0089-v5-076c780eeaf45afb2a53@gmail.com>
 <202610151231.3D8F9A63@keescook>
In-Reply-To: <202610151231.3D8F9A63@keescook>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Fri, 16 Oct 2026 09:10:58 +0800
X-Gm-Features: AclHuK8edup2SupqX1o3fhs6D1NgY4SqIBp2hHyIkSs-U-DuEilWC35HgZo3hmg
Message-ID: <CAFRLqsUAQuorPYcEOWJX-hgduzG+CGYUy=ozS-rXB-Cs+VNBTg@mail.gmail.com>
Subject: Re: [PATCH v2] ocfs2: Pin owning modules for open debugfs files
To: Kees Cook <kees@kernel.org>
Cc: mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	heming.zhao@suse.com, akpm@linux-foundation.org, kmehltretter@gmail.com, 
	christophe.jaillet@wanadoo.fr, ericterminal@gmail.com, rppt@kernel.org, 
	rollkingzzc@gmail.com, brauner@kernel.org, sunil.mushran@oracle.com, 
	kurt.hackel@oracle.com, jack@suse.cz, ocfs2-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, baijiaju1990@gmail.com, 
	jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kees,

Kees Cook <kees@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8816=E6=97=A5=E5=
=91=A8=E4=BA=94 03:32=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Oct 16, 2026 at 12:42:32AM +0800, Cen Zhang wrote:
> >  static const struct file_operations o2hb_debug_fops =3D {
> > +     .owner =3D THIS_MODULE,
> >       .open =3D         o2hb_debug_open,
> >       .release =3D      o2hb_debug_release,
> >       .read =3D         o2hb_debug_read,
>
> Please match the indentation of neighboring member assignments through-ou=
t.
>
> --
> Kees Cook

Thanks for the review. I will fix that.

Best regards,
Cen Zhang
