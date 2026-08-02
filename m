Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3865538836C
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 08:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785660826; cv=pass; b=i5gMsmtpZK/XiAVXphx9Thb2TznVQZvumTLMgxWfxKivWfse3q3EiTqZPUz+RuGTl40v38Nk92jt4b8MmVmWqBqp5xzsiyJw3dU2JpKcONijsTW6ej6ufQGn8gOvtam5/h7rs2nl6eMtgfI9zR6nnVfLlQ+YyFeTZZOQ8GohQ18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785660826; c=relaxed/simple;
	bh=GlDcPw1uDy8z/zj9y8sPWY/XJkKEOhvrec3hjox2kSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/RH8m4MjNWkrgbXYt5kRh4wcRlM9qayxP1GTfu0shhDKKQwWApqhRuMnkqZ+F1EDi5aYnGJR8RIZKtjWWumUeA09FVMpi6jKo9eZVH+JlTpz9FlfgPpz+F2Fr7qsCiwalPvjsHhsA2jBv0BKvfcU2b7btEhbksACDI57y7yj/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJduNRdl; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJduNRdl"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5b015b2d792so2315293e87.3
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 01:53:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785660821; cv=none;
        d=google.com; s=arc-20260327;
        b=HAHYS2MWBeiupewTEkVuHQe9LOgcqC/4bro0wt6jjJp+C3PdthkhVsIwgzVNnh4pNA
         eYrbZSRwvRJlkZoxCAlodf7ypwhN2jfa/2vU9wyyqGvVmGBgk+5lztBxx2I/CknIAlVO
         8qCR1FcaKKEQOdWxaHlsp6AKb66pQ8LEuLU5074jxVEbGUXO44H88VlLLUcKNX3QIs+p
         uA77DvZrGiZI8f/EpBwp9FAdO2/Ghs+X+ewk8si2Jp8RBtFz2Kh5hxl1FO8Bq+m1AZo4
         BYsN13nOKzcl8+OKCLhmIEE6RYUXdU+IQke/NsrMuTG8sVebclOIGk2zP7ZMu+/ms6V+
         eRuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v4W89YSh3PEwSTfuZU0IYJ+ax6WMvSRUucxN96Vtil8=;
        fh=8oMW/PwfOCemzmd5FjMYcw95b+97//TC1Sm4G4jWUyA=;
        b=W0S/Dv43oqewgKpnAgKdfghMQYZFwhgFoKjTWFSS3IsH0HHzfucsQ4PlF9p1oCdfTc
         mXNatFjwrN5ZW+dqn62zZtjnSGGs4VCiyaRsyh+uEoHjE1jzNRjb2+XbPxIkVVPEvn6m
         WpJb1X94Kcrz5QbkMJwF8S6CzaQDffbHRSPPNcbZQ2989i/BODBb+pXjmebrOGj3I1mU
         H7BUPUpZAIMl8LiLivunSzpLsEh1jhsL+i/z8OjKmHDCch9WzndsswDm1RfdhK+p5ewC
         8/7jlPUxMrqCQKjl5JjWctIbyzqvFjrnPSZnT+nTCladopbcb5/rLX0DwOqhtEe1K9Dg
         LsQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785660821; x=1786265621; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v4W89YSh3PEwSTfuZU0IYJ+ax6WMvSRUucxN96Vtil8=;
        b=UJduNRdlO8hSJ0rcfagVdGnOEDSmjnDRcUDqyEVzZRkF8s9r2BaTgpm5MsEOblXfdL
         37DuDOV9IL0jjNcVZgdE+5SP7cSNP1sDAgGgf6T45P4GhK066RlEDWU7dz9ymVMS+8Ei
         2mkcCgTotOpBWdt46fU4/5hGJFC4/MvkgK/KQ5yZFYt9dd1QX7ma5A/dBwrNmm90DZN5
         oxBF4+CovkkKQyKHopy5WPqkSTCVGVu3EORmPyKieraiJRYMJROyi71TodwlMfyE1RlK
         mR107EsTRToJrNghbqcsfror63iX9AltZ8JBtp7EtyonpjBUV/McPNDD5oqjaWK9Lvjw
         oMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785660821; x=1786265621;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v4W89YSh3PEwSTfuZU0IYJ+ax6WMvSRUucxN96Vtil8=;
        b=L20XPt53yxzXnSin0wvQ2h6vvaDWkf3ZDWFJR6eUn/rTiWt9yPhB9CB70s1CxfCWvH
         H4lL1TDFIaq+BVrKhqddE/boS5XCarFH3V7t197/duhmwxhD15oEYeJ3cqoCmmRUIXDA
         ht2c6HiE56g+EVMXqv8KkbKcbU/pNCJLuCuTaH2ms8lppJP3EoPSfjipdts7Hls7/+Z2
         olvX+wuHfUBpmRAyuBjRLHZILhg91MEI56oIUV47wKKGx2073xhaDfQUtNgUKClWt8Ju
         HXU9WULEY8fQWMjEjjCiKShrTfe+LRptqsF6TeqmdVFpkUPVxwlmhz73Z9s+xHmrp9wu
         ic+Q==
X-Forwarded-Encrypted: i=1; AHgh+RqHuRgYw9r0GP4CM5gvsBVhaKgLCuHWV8+M62HgEbZDQ/Ms9rBgb2/Bl6N7NJsbggsPio3gp9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs25fpRWWSUpIJLiVGzy1ASlyNSS8Af3GmvlyBF2FEYxeXyCak
	zARytGYvt2CmPPlUeLTo1/RtJ2enVVGe/R+8Y7CzbZhLHnO2wu39dGuF7dEZze4CkGtmleNx8z7
	iK/XT4AnmjWJWSwbCi8C4joxICGcJSD1PqOj3f2Y=
X-Gm-Gg: AR+sD13G9jXWlyxLpMb7tY9U07e66gNvSaJMhRW58aOb76+vSyAXt092KVcZBmWUafL
	Ybhbjb0USnh65ddWAsTYZq4ZXx4JM4qLkO4QBj7uooeRbJh96+5IW9yb1f37NOoGHVvTHMdMwHS
	Udn1tLGt3BUDBZXEYQcBgmJ3VaoLIZFMZFtRoyzuKTnvSPS7fv+eyxKk8Nrv+7RxUDQIXZLO9G9
	QBC9hsvuh+rn/866rGWnCyqMqUBMF7CQax7AivXvUxw1K0uf8stDmZEtDkzEhASTagofKdsTkCN
	AnDTmCn3GltoUzLdLks73Fd9fPEAMFqA9Xje/Djq6Oh7gwPwxHDNGzlrPgxoIlN7xP7Ys/Qbt+A
	=
X-Received: by 2002:a05:6512:6883:10b0:5b0:23b4:be97 with SMTP id
 2adb3069b0e04-5b2e4f1ad94mr606688e87.6.1785660820400; Sun, 02 Aug 2026
 01:53:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726113511.57596-1-skyexpoc@gmail.com> <20260726113511.57596-4-skyexpoc@gmail.com>
 <2026080222-capped-registrar-be10@gregkh>
In-Reply-To: <2026080222-capped-registrar-be10@gregkh>
From: =?UTF-8?B?SEUgV0VJ77yI44Ku44Kr44Kv77yJ?= <skyexpoc@gmail.com>
Date: Sun, 2 Aug 2026 17:53:28 +0900
X-Gm-Features: AUfX_mwsnzhqwwiZ5-vWpV54VrFFRaFP87nkGsCAIHxTVBUc4dBUHQK3zx-PnBU
Message-ID: <CAOC0qyK9YwvzZt4q4pWL_TQXETcG=yULZ98twetzYxv_n7Vr+w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] usb: misc: usbio: bound the debug hex dumps by the
 received length
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans de Goede <hansg@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, linux-usb@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Answering your question on 1/3: the diff was generated by hand with
diff -u, not git format-patch. That is why the hunk headers have no
function names.

Your comments on 3/3 are correct as well, including min_t.

I am not resubmitting this series, so please do not spend more time
reviewing it. Sorry for the wasted effort.

Thanks again.

Greg Kroah-Hartman <gregkh@linuxfoundation.org> =E4=BA=8E2026=E5=B9=B48=E6=
=9C=882=E6=97=A5=E5=91=A8=E6=97=A5 17:46=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Jul 26, 2026 at 08:35:09PM +0900, HE WEI (=E3=82=AE=E3=82=AB=E3=
=82=AF) wrote:
> > usbio_ctrl_msg() and usbio_bulk_msg() hex dump the reply with "%*phN",
> > using a length the device supplied and that has not been validated yet:
> >
> >       ret =3D usb_control_msg(usbio->udev, pipe, 0, request | USB_DIR_I=
N, 0, 0,
> >                             cpkt, cpkt_len, USBIO_CTRLXFER_TIMEOUT);
> >       dev_dbg(usbio->dev, "control in %d hdr %*phN data %*phN\n", ret,
> >               (int)sizeof(*cpkt), cpkt, (int)cpkt->len, cpkt->data);
> >
> > cpkt->len is a u8 read back out of usbio->ctrlbuf after the IN transfer=
,
> > and bpkt_len in usbio_bulk_msg() is le16_to_cpu(bpkt->len) read out of
> > usbio->rxbuf.  Both are handed to "%*phN" as the field width.
> > hex_string() in lib/vsprintf.c caps that at 64, and dereferences every
> > byte up to that cap regardless of how much room the output buffer has:
> >
> >       if (spec.field_width > 0)
> >               len =3D min(spec.field_width, 64);
> >
> >       for (i =3D 0; i < len; ++i) {
> >               if (buf < end)
> >                       *buf =3D hex_asc_hi(addr[i]);
> >
> > So the dump reads up to byte 67 of ctrlbuf and byte 68 of rxbuf.  Both
> > buffers are sized from the endpoint packet sizes, so this is out of
> > bounds whenever ep0 wMaxPacketSize is below 68 and whenever the bulk in
> > endpoint is below 69.  That covers every low, full and high speed ep0
> > (8, 16, 32 or 64) and the bulk sizes the supported bridges actually use
> > (64, or 63 for the Synaptics Sabre via USBIO_QUIRK_BULK_MAXP_63).
> >
> > A device answering one of the five usbio_ctrl_msg() calls in
> > usbio_probe() with cpkt->len =3D 255 therefore leaks up to 60 bytes of
> > adjacent slab memory into the kernel log during enumeration, before any
> > user space is involved.  On the bulk path a reply claiming
> > bpkt->len =3D 0xffff reads 5 bytes past a 64 byte rxbuf.
> >
> > Unlike the endpoint size issues this needs no malformed descriptor at
> > all; it only needs the dev_dbg() calls to be enabled.  When they are, i=
t
> > is a slab-out-of-bounds read under KASAN and the bytes reach dmesg.
> >
> > Bound both dumps by the number of bytes actually received.  That is in
> > bounds by construction and also stops the dump printing stale bytes lef=
t
> > over from an earlier transfer.  The matching dumps on the two OUT paths
> > are left alone: they use lengths the driver itself just wrote, which th=
e
> > size checks above them already bound.
> >
> > Found by code review.  The out-of-bounds read was reproduced under
> > AddressSanitizer with a userspace model of the two dev_dbg() call sites
> > and of hex_string()'s field-width handling; it has not been exercised o=
n
> > hardware or on dummy_hcd.
> >
> > Fixes: 121a0f839dbb ("usb: misc: Add Intel USBIO bridge driver")
> > Cc: stable@vger.kernel.org
> > Assisted-by: Claude:claude-opus-5 asan
> > Signed-off-by: HE WEI (=E3=82=AE=E3=82=AB=E3=82=AF) <skyexpoc@gmail.com=
>
> > ---
> > --- a/drivers/usb/misc/usbio.c
> > +++ b/drivers/usb/misc/usbio.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/dev_printk.h>
> >  #include <linux/device.h>
> >  #include <linux/lockdep.h>
> > +#include <linux/minmax.h>
> >  #include <linux/mutex.h>
> >  #include <linux/string.h>
> >  #include <linux/types.h>
> > @@ -141,7 +142,7 @@
> >       struct usbio_ctrl_packet *cpkt;
> >       unsigned int pipe;
> >       u16 cpkt_len;
> > -     int ret;
> > +     int dbg_len, ret;
> >
> >       lockdep_assert_held(&usbio->ctrl_mutex);
> >
> > @@ -181,8 +182,15 @@
> >       cpkt_len =3D sizeof(*cpkt) + ibuf_len;
> >       ret =3D usb_control_msg(usbio->udev, pipe, 0, request | USB_DIR_I=
N, 0, 0,
> >                             cpkt, cpkt_len, USBIO_CTRLXFER_TIMEOUT);
> > +     /*
> > +      * cpkt->len has just been written by the device and is not valid=
ated
> > +      * until below, while %*phN dereferences up to 64 bytes of whatev=
er
> > +      * field width it is handed.  Bound the dump by what was received=
.
> > +      */
> > +     dbg_len =3D (ret > (int)sizeof(*cpkt)) ?
> > +               min_t(int, cpkt->len, ret - (int)sizeof(*cpkt)) : 0;
>
> LLMs love to write comments, please think about what it is attempting to
> do here and if a comment is even needed.
>
> And that line is crazy, please write code for people first, compilers
> second.  Make that readable, because as-is, it's not.
>
> And finally, it's obviously LLM generated as they do not know how to
> properly deal with min_t() lines due to it being trained on "old" kernel
> code.  That's wrong, please do it properly, you should almost never be
> using min_t() anymore.
>
> thanks,
>
> greg k-h
