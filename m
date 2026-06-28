Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADE5194C95
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 16:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782663831; cv=pass; b=pR6JkDhEU9hAQXZj5Yfxi32Q4ptST2Hz7+kVAt7ksTF1OSvYy1GY+8qb9+IRhPRSxOuWStomKFPWkgwrho1EBAiZ00B3kuSJK0fyNLuYX3CavfODupCMpq8VEsUgjebB52QMc2DRFMctllcFBReEcaTbsvw/zQGLI59VZhfU6p4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782663831; c=relaxed/simple;
	bh=5OLImKYP/mPH8qI5V/oFbG+GvYL5S1bGpUq89sWRLyo=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tMn86bA7KK/mFMOJ5znSiBkIenBsznvZW+MrTwfGIbaXrJAHBoAJnE3jW6jtd97MHAIpPpXxc4VqXpVAMptefF94ew65qN6heetBGJJ+t8AOlNA5lXqZbjqMrqZvSoCvPYhGqz1pIdpEWrp/d8+a8x1b5OwK+z13OFqKXWfbwRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNdUWzHL; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNdUWzHL"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-80bab6cf5ebso22552627b3.1
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 09:23:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782663829; cv=none;
        d=google.com; s=arc-20260327;
        b=QnWLowHRLBNP8UjNNBodqSayvkSftWWS6nJXpz8g3FjASEEcrnXQHcZVv+4J+yIHoH
         yPNIeIChptooakP1EdgZ63yVDwNU8on62197AwBbDKZxVnkfcyE2fc6KWkYRFuiBNxUb
         +idb+khnVGNe3W6Cfn0xgRpsVZOf3cfs8G1gMqUbhrQNFNFEeQW9y2l+C3kpvv2Aa0JZ
         GUksEPTbfeyP/n4MB8ub3whPSBPptRjrbrqzF4RAJ42zHHA6DjQx/a2fN6eAYSmGHVVv
         UffC9fZ3a3wk9kI4ODykTcJg7gwucVlW6GgW9WG7AzooVevn24g19FhUbOE3kV8u0wo1
         5/AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:dkim-signature;
        bh=5OLImKYP/mPH8qI5V/oFbG+GvYL5S1bGpUq89sWRLyo=;
        fh=s41zdAKEd7Luy5u7U20CqptgXSRTDQU7SfOLsGMen4U=;
        b=o/uh47qGvK2xkhOUz0qgv8XTVlZKdLqEpy/z8SlN4tB3zAyiM87+niUh9UrMITDYo6
         WIM8YO176haKybhOnDthQTx8DQ7p2bqm5C0/ygKB0TpAVuKvAQUQCAW13GnQGtN/RILG
         rxZ+/zWJOy/ZdTqEh9WcVMCRLRgtxFOYIQvyd8eUcCN+B8pi03TqJxieprmZzEx4B+SJ
         cXLo1smvVklb3QvHxHWmJ7Rtjdv63XcfKsFAlnS25oont1kPdQAtMEQ5wpvwflO9ln+E
         lZQkBVTctlGGid7pp3tDVlGuF6aTg3cSinALxS6vZPJ86xwgEgEe42DhumlO+Ee8BGcU
         2q5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782663829; x=1783268629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OLImKYP/mPH8qI5V/oFbG+GvYL5S1bGpUq89sWRLyo=;
        b=FNdUWzHL+JaJMuq4NFFdca+2lRDsUd5oSMptFzGAD1BUSEOu9BVroXtMfz3SIQHj8G
         6NPl1X4nqio2fwqFm2mj3w+wkZsBY2dv0aZ6cWhTesxgsf242j/+lVpv8A2FZ0nPXpwt
         9aGqLT80AGAazqi7gkIUWpQwtLtLx5ZmM7wyVNbE6ZdjHVWvGsHI1lVrnvJUztdqDes3
         YCvQBk0r9DNf/3FndsRzdYrxFQOJdS2pnO1CuDVn0hTYAKWHUV6/Yr681+fT2flyzkgw
         SvWfGJS0VpGSgMfYMsEm0sh6uZOKvpLirGYITBeNBNR75m+FZ8jlip04UQrZzxB/HUW4
         YUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782663829; x=1783268629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5OLImKYP/mPH8qI5V/oFbG+GvYL5S1bGpUq89sWRLyo=;
        b=tDkshKjm/hm25QL8vg7LzT2Iohwise7DHjABfjIFNDw5KfPCKA9vnUQib2ImxrgkC5
         GPWm+BSXSck+TyGblrU/RqbkeGTz0T9Jmxx+vQxk4Taf4bpNC30RwOAX+ipUYlzBDgku
         5qGZ6ZVxQYRi+KiM2fz+Jyo3m+XcJWS/mBwggJUOPc50ihAgMZbENyM9vxh59Ks4qlwk
         4WSFJJKoY289r9pZg4oMwlvNIb8jjWzC/VsAGmX6Wmt/QBrcTKtyEqF+rBP5YHMqbVIm
         t7ai79lGqROxp7AxbPnlYZ8nQsyAEVxmMSgyc/il+DuRY5a6eVDtrleVuC4kFdMRbB4v
         HWMw==
X-Forwarded-Encrypted: i=1; AHgh+RqhY14IcsWlwQgX7l3Mj6hNgGaVTxcQeT5iVCyCnfPXv5+EuerWjm/D/RSxwSaIqozBrpi/kzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcjUvJ/JDFrWpjbvoE2KwaDeoAAuDdErwSVa43ZF0/vWYJOCvU
	lgSTXY6JJHsMMEZcmdmtbxQ46rkg8Evjr45il4zDqUPzSWIPJVdPDSOxNpCT7Vnf4RzytwAsXOg
	E76KvfmlH98Hs6U3UHb6o4BcdWGiWd5w=
X-Gm-Gg: AfdE7ckS0IllZoQFnj2nzCla2HiGrzP3oC+0qFAfV0Ehdnjedcd6+mi6r7JZmkJreiY
	5k2IFS09m07wjcUOY8XSsdupc52WEz22Vm985983Ir/xHZmUUrlvuoskO4Nc0V4zvmAqrhifq0n
	xxJPibR/Av7PiOxYvmCrYwKJ5FkICSwCjtt5Q82zSAUwvYzMOySiYjpLl+isKzzypSh2H2e8UNc
	13p+jZrj1EKMF6aeIiITFWyNStFXUPZMTxed13camnZ6dAd0gt3tjzHOABntXx1Ojqm9dNlhw==
X-Received: by 2002:a05:690c:112:b0:7ea:3cda:4246 with SMTP id
 00721157ae682-80670e4828dmr202936807b3.3.1782663828777; Sun, 28 Jun 2026
 09:23:48 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sun, 28 Jun 2026 09:23:47 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sun, 28 Jun 2026 09:23:47 -0700
In-Reply-To: <612b5987-1bc6-4b42-bfba-9c72ee5d51dc@endrift.com>
References: <20260628004106.26920-1-alhouseenyousef@gmail.com> <612b5987-1bc6-4b42-bfba-9c72ee5d51dc@endrift.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Sun, 28 Jun 2026 09:23:47 -0700
X-Gm-Features: AVVi8Cf_Hsynpd7VFdZCCXNQws45bnaGAsdX41yi79mlGX0Szrz_YJ4WDc7NEQE
Message-ID: <CAMuQ4bUX-jpuX8LcCpAwb1b+OoK+jP2TtpU3BY4HvERM69iG+A@mail.gmail.com>
Subject: Re: [PATCH] HID: steam: reject short serial number reports
To: Vicki Pfau <vi@endrift.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzbot+75f3f9bff8c510602d36@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vicki,

That broader fix sounds preferable. Please go ahead and split it out
and submit it; I will drop this version to avoid overlapping work.

Thanks,
Yousef

On Sat, 27 Jun 2026 17:47:40 -0700, Vicki Pfau <vi@endrift.com> wrote:
> Hi Yousef,
>
> On 6/27/26 5:41 PM, Yousef Alhouseen wrote:
> > steam_recv_report() may return a short positive response and copies
> > only the bytes actually received. steam_get_serial() nevertheless reads
> > the full three-byte header and trusts its length without checking that
> > the serial payload was returned.
> >
> > A malformed USB device can therefore make the driver read uninitialized
> > stack bytes. With a complete-looking short header, those bytes can also
> > be copied into steam->serial_no and printed.
> >
> > Account for the stripped report ID in the return value and reject repli=
es
> > that do not contain both the header and its declared payload.
> >
> > Fixes: c164d6abf384 ("HID: add driver for Valve Steam Controller")
> > Reported-by: syzbot+75f3f9bff8c510602d36@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D75f3f9bff8c510602d36
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> > ---
> > drivers/hid/hid-steam.c | 9 +++++++++
> > 1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> > index 197126d6e081..8c8bfb10e8b8 100644
> > --- a/drivers/hid/hid-steam.c
> > +++ b/drivers/hid/hid-steam.c
> > @@ -454,11 +454,20 @@ static int steam_get_serial(struct steam_device *=
steam)
> > ret =3D steam_recv_report(steam, reply, sizeof(reply));
> > if (ret < 0)
> > goto out;
> > + /* hid_hw_raw_request() counts the stripped report ID byte. */
> > + if (ret < 4) {
> > + ret =3D -EIO;
> > + goto out;
> > + }
> > if (reply[0] !=3D ID_GET_STRING_ATTRIBUTE || reply[1] < 1 ||
> > reply[1] > sizeof(steam->serial_no) || reply[2] !=3D ATTRIB_STR_UNIT_SE=
RIAL) {
> > ret =3D -EIO;
> > goto out;
> > }
> > + if (ret - 1 < 3 + reply[1]) {
> > + ret =3D -EIO;
> > + goto out;
> > + }
> > reply[3 + STEAM_SERIAL_LEN] =3D 0;
> > strscpy(steam->serial_no, reply + 3, reply[1]);
> > out:
>
> I already have locally a patch that fixes this as part of my pending Stea=
m Controller 2 support. However, it chooses to fix it in a different way th=
at would affect all uses of steam_recv_report instead of per-callsite (with=
 only one callsite fixed). I am hoping to get this patchset submitted soon,=
 once more widescale testing is done, but if you want in the meantime I can=
 pull out that single fix and submit it separately; it's a bit more sprawli=
ng and involves adding a new function for combined send/recv.
>
> Vicki
