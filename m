Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EAC3ACA5B
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 09:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780909923; cv=pass; b=JKZPWkYELFyBoZW/tbyRbsMPC0gzhJS6H7ecZxEeVJIClc80YSWPbzyqmhLaYTsBwyrLEVt2TYE5lhO7OyOf8WhC77tfT+Lu8AW98+nsuZyjYV3OA3cMYg+pn5nE/HArZwFTKtRnVrWTpGVW1jbdCBRz7Zc/Q1CwKaXpYD0oF0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780909923; c=relaxed/simple;
	bh=g6QNJFkv6IlGascc0FjOpWGc85Q3//n50YZG1Fc0EeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FS31vWvjTmJktRWTJNtlv6gpeVa/XEyMA1vKAzDrJYSpI9HU4/0fxA/LrSxJyuGj/r/52e+16EYTWc144DZoYft+MdtZPJ1wL/aqOn/7rvInq9M/4p1f8la7eFah/PwZHuN5OZ9687IoC74eppgVriRPXhg3i0mw1eWoUrX9MGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGsGNnzo; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGsGNnzo"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490d1e54b3bso2379405e9.1
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 02:12:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780909921; cv=none;
        d=google.com; s=arc-20240605;
        b=EN7Ayp6WVbd73N8t67aQgPkt+wOwZpiEgyijxRWRgXsXOpILbmrsDOZkReytIHxAmP
         HC+9O7ive5RzPpFSYqQsCP+8LP7lJ2sswO5rk5bD/QpM+4UfmXTtxfgShy9ifzHIVfmS
         1OEKM/A5dPasHBYfsMqzFFaFMLks05up0fYGhGLTmpa5eLrukNqerW57aWnNb9iSvTmI
         h5dzzeSCvD20W64WlnlQobMHhbUAqgm6L1ADH0UwQFJSGNAPpJtZ/U70kVegj9LUF5a4
         ckZUdWY/LJ02K8ruP6VKvbd++ZIPHEEda+Lwf623WvN83vLi4wyQnvPWgv93OvrhH1D9
         gaZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DKFV4KkC6COWNrZ/xgUNGbwVmIaCHTzuBxaE2v4BzGc=;
        fh=3Ikm9WK0A+aov0abIU2V5WaFKOrUyxlBsPPJPZoBov4=;
        b=fsCm4ecxuKeqCExs/PQpPYtKiY+gZsIewuQzuNkwebrYwi8tNXRj/BRBFRmK2kL2kN
         QbPeQXhFSrPzJjvdm7kxriOT7KzriZbLT3B7A7PK2yQBxees6DS3MH8YEjK4gMMHkcAO
         44owNURxckh9v9FgEYWXWVyHJ3vqQ07lMlCOWnyGG9WNSJtDddSrRtgqUeOod/qgVVeI
         bo3dwdzEImdS/fJfBkUQ7TrUgT5p43bnRkExOAjBc2pqUoGIKg/hkCeKwRNgQVDQBjv3
         /aXyUeTdzuZmG5sraHk1RqaH0E39D+ZOjdjFAWj7ZrsoOoKddFvGUKSUBXxD0KRRiX7K
         J4MQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780909921; x=1781514721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKFV4KkC6COWNrZ/xgUNGbwVmIaCHTzuBxaE2v4BzGc=;
        b=AGsGNnzo9x56J3OXNY0peJwc8cObv74QdmdzG78J2iWHb2Xd51mycOTRIo9y+rEpLL
         zD1x9KK1sGSilBviasbJ3mmZrRVMBqSVr9qPy3ykSHCkHKXcBC/b8ep8lLSLL5Mp8zs4
         sJfFYkrxLpLatwlr7FRwJTZWyhUwRv0jtz9EOiO6SnWhbFTY46q9/JTdoWREP1kanclD
         qvWgVBxBkpum7Bnu+/geQS5vDIrO/DAi2Uz+Kl5MdGnpxSSAq9YeUE3w+d/1VUdx8LJy
         y2HrCScscRE8sH8LT+o04W7Gd6CUnI/bc1kM0yjpPtvN0UgmEN6Rq8+cTWlXgOfZqc3B
         2J2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780909921; x=1781514721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DKFV4KkC6COWNrZ/xgUNGbwVmIaCHTzuBxaE2v4BzGc=;
        b=jjmpiTT/oI2k6PWnLasQcIlQQJjvm346vVlq04EmeylpMwE2Q0q5QKVd48i9rtbzrJ
         vLzb+Fm8jbDejTIc+CGuf60y22pFjMIkCjIAgYOJsUQWhVIFIxSOmCe+2HOsFXCssMUf
         h01aNSMTKuPQTsen4+xveb/FGf0/UkLWOH7xVix8Wy1HdhhZcQfSibka/+xNSQxD6Yhz
         AjzZ+Ay/3eOPIZbJktExm94eb6P9ljbreD0zS27xzlcj04cKmkGmUkqinc8k87xD7x/r
         X32Aw6TwuE1XUfu0/HWN3iVPRYb6dCnFi9wVVkk1X3v3g1TpApybaZYBzsT//L3wWkNd
         NjNQ==
X-Forwarded-Encrypted: i=1; AFNElJ+A2GXynnxfqsJlBGNMXWcTUorIOHO2nuk1oG+QVUPVXbAznt3LfIU92E1rqbR9ZMBmBDItN4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzka7dngQhjaHkLA45jXJecpsgwyFrkWd1R9onJc3TFdjZxuZX3
	zXHWfIMaZlE7bTvPfjQnN4ydU6cKsOGodlLChynNgSLAuI2H+dPekEFmtvVpPULrfzGg8/9I+LS
	03s9z5WbPMVzTnsJ5HC33GeBQoLLO7RQ=
X-Gm-Gg: Acq92OGbDIi/6+uscbZy9GyweCGJRe6hCBkEWLpkoHcSE/tEsRIYmfBjKdQf6Hph6Ho
	h0okSmbMWYWEjWBOgqvrvdJSYY3adH8NJG7aWSzKH2xcd0BchJrHUKEGGexUHKnrJp5Og15CvCf
	90HTkq/A8XuW4q8AOyl2k8Kto2pSs8Y3D4bBAnVXMQt+qrQ5FZo/2V24XkCiv/iEGDMfH+KIhqQ
	z/vRRcqVzsQPn/5oDbY+z7SqVSEDGczIIJ67tTiUqbucrq7RriXm+w4LptwEaSMGMgUc7Jt/Hdk
	slTLNGcGkx9oWep+eAbBSBZPhVhiqYu1jP/mUmOSH9dXjcRbfvs=
X-Received: by 2002:a05:600c:674f:b0:490:b4bc:4f3d with SMTP id
 5b1f17b1804b1-490c25b06a1mr230055115e9.18.1780909920408; Mon, 08 Jun 2026
 02:12:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aiZiZy8a0al7xVXe@hovoldconsulting.com> <20260608074931.5911-1-sammiee5311@gmail.com>
 <aiZ_DJGvrmotkM3J@hovoldconsulting.com>
In-Reply-To: <aiZ_DJGvrmotkM3J@hovoldconsulting.com>
From: Sam Hyeong <sammiee5311@gmail.com>
Date: Mon, 8 Jun 2026 18:11:48 +0900
X-Gm-Features: AVVi8CfxVZIX1PxJbVJtzthThC-GPmY30UFKg1hngZQYial9sUn64L8BAAVvloA
Message-ID: <CAJciObGR+joLEEgj_ProZa4i3TmVs_RB7OHP3T=pW2CDkSu8+Q@mail.gmail.com>
Subject: Re: [PATCH] USB: serial: kl5kusb105: fix bulk-out buffer overflow
To: Johan Hovold <johan@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johan,

Sure, thanks! I've just sent a v2 with the "Assisted-by" tag.

Thanks,
HyeongJun



On Mon, Jun 8, 2026 at 5:36=E2=80=AFPM Johan Hovold <johan@kernel.org> wrot=
e:
>
> On Mon, Jun 08, 2026 at 04:49:30PM +0900, HyeongJun An wrote:
>
> > Yes, I used an LLM to compare the custom prepare_write_buffer()
> > handlers in drivers/usb/serial/.  kl5kusb105 passes the full "size"
> > to the fifo copy, while the ones with a header or trailer, like
> > safe_serial, reserve that space first.
>
> Thanks for confirming. This needs to be documented in the commit
> message, see:
>
>         Documentation/process/submitting-patches.rst ["Using Assisted-by"=
]
>         Documentation/process/coding-assistants.rst
>
> Can you send a v2 with the missing tag?
>
> Johan
