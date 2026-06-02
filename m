Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB27B31985D
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 05:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780378462; cv=pass; b=Gdsaga5d/kZ0sUtrCXVr1oFgwUokryghD+L2PNWEW0YB53vmoPsQJDujA+UACNqBkIFlFi19BDa3hXcKkkx+fOFxHS/p0TjSWBxKwHACms+EygrdPNb+caavlK4D+b5/OgwpQSvgAZAYumGVlIK820vAn1EyMrMnUB0jNCnaw2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780378462; c=relaxed/simple;
	bh=7MCh1WehuUu3JURwEcRIdX8TakMkC1Oqa6Ne90OmRa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FA0NeUquo9BNYAkA1AECWeMIe7m66rq63JOYvgVQDDZHnUfZCbzD9nVSiRV52CSbddFNpbJhYSTr4R/j4uY8V7yAYf4bc8Itgq0hsGjqgbpGAvxLpANXlzCrdQt7c4c4h+UQfUB/GmsN6rMJzC6C/jUrc0PRY4EExn0ur1r7+WY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xwf.google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=peqtZNLl; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xwf.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="peqtZNLl"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51765331535so2821cf.1
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 22:34:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780378460; cv=none;
        d=google.com; s=arc-20240605;
        b=FQZCnKD90Z9Cw8wsri0FgpApXVt1q8hfmXlp3UIHavhfKnyFitazvXByaI5c24rGMA
         OwGqJWbiLQZI/76JxjpNwuY/cfZx4aHpXCj8SYL/iMWj5KRu0IzTQkZS/BxrnkajhBml
         ERKPCBhJ5ZaR912WIjZUgaoYiPrpT3vH9Te7zQGzb3i1YW1Sh+9wDElDMrdiJcPGCJkT
         3VzFcyUfLOOO8v8vYKVv8J/gdvPcj/vuILfWhG0xGdWcYmifz6fbi2xJaxcKF019AN40
         9aButiU67mckOGh1RVpjbJMdpIp9PYx2iw5lDdbwbg3Icrc1tgkPY4GVgSuGVQRxYOwb
         Tdgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=i0l2wtQxncflisN7xBk+r4OI4gRjk3fLa+hgzVH9c1Y=;
        fh=AdtYYcF8CSXTORXxUo8c0diWbWlVZFVHRQwESr6xkj0=;
        b=JvZj0eSyiXO9K7vvFAp7DLPayvFtvAiNnsBPxe0BI5kms8P1bWPjmiv2Dhg0UWbErt
         /0PeYlm3aVdc5IPznkicWLN5sYk2Z0M9s7v8jdrN/4zaWfchFJYg1dS2EzAD54gDYseW
         aG4BJ9ahRP0poiWNI4Zl/qSk47tZnSXv/Q9nROKv2lAeVGgwQKEaWNSbWUH3vpbgtImy
         OaueFWixZZOb93tLKKx1k+xn7qspQDgO4Kt2RJ2CxG8yI9JAKa89r7Feh+aA3g5y8+RR
         gnRaOjqpr7KqoUBHWhe830mx2+sBnJbZ+4mTgm79bQGW3CXvTtv3Iee9F8QDD0gAIdM8
         K61g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780378460; x=1780983260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i0l2wtQxncflisN7xBk+r4OI4gRjk3fLa+hgzVH9c1Y=;
        b=peqtZNLlH8C4EUSOQiGBOOxeV3c1UYJltkTB0rnyusaNanQ4h0wKg38kegQvuN50rM
         ys+64Hja4YA8IZfnbtutbqqvlvyl8cfOgHvAe51aksr2qFo3Z/LSuI2tQ939GnW0eViG
         e/LiJcqx+DIMZ/y7gucKg23q3e0bpanUX43O+W9z7uf04ljmGZx3aXrh3dKYFO927QJz
         SgMtFJYs/xQZp4+KyQslY9EBifRKxSnTLRAYOjst7vzskM5Pri4iTtbBWoh4VmfFuLy1
         5fVIN5pMUHPSwGm/kGqlgDqIUmeH2b6jdSp90q9/bHS9L+q2k+OMcmpMpqnFg1rxQdgA
         gGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780378460; x=1780983260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i0l2wtQxncflisN7xBk+r4OI4gRjk3fLa+hgzVH9c1Y=;
        b=Y2o1dS/hj1E8I66eQ/U0hrsyRDmFW2kMCupAn2QwVLq/V9TmtWQ53uA8vIM/LsI68l
         NSqzIyofx3tZTSShJpRx/5QDSt9BKqujWQeGd+H44dUz/wHr80QOPLO1tB823gpZHHxe
         gbO4LsipnUsmnPlbAGYoqv9KP42SclL8iASj5EKoLNx1EdQZNPPFcE7mR03cWuZFQMCi
         KJk2dCsFAYrXmsNWyrMUP37qQL0JWgg42Jlmd3wKz1O5Pwz+TZ0qw+SN6TV4Do5Gf8E7
         LEkXyfgxr/zile3bF5W49Mex+KdZC5efQuQw61U3R5SuMMtJhWRsvMjwt7Ovum5zvOeA
         IRmg==
X-Forwarded-Encrypted: i=1; AFNElJ9uS9KNBNhgo3Z2raeV/+1+lIJuJrucLIChiUgz+BioZeJP5XOkqlQID/FccwdsLST5YQAIO0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4zSn54ZI5RKMRkBDdVVKEYWkK8th+PPOV53KBcd6XBONTQGMp
	UMwteZug7J7O5qsdYDvYJCTdL5Tysr2bDU0VYdbKzDpjCji6S75ddBOitXhcutiS8wYL0jOXgQv
	rg2RUf26IQCyeVOHugCne/BwIQ0AqNwOrLkXcOZ/+
X-Gm-Gg: Acq92OHq2ic18WNnMWRm2DmK3MGd5lDRVMdNouhFziTzukYxGAhC1QAj1KYqhynHoYo
	0L+PauopHOdINB8RqGTjpOT2wKVeDB8JCdlhnAP7+tCqC5nes7Q8CTVlWkgBqJ0+fteXAcfBRi8
	Bg5NpeyYgNs4rh3mEiBf94h5M4+d6SA5kw165XtqzG/D8YPMyZXdRbUX1TZSToBsnRjeuZAfRTO
	HWNRzBs4fSwghjBxehbsARDqIK7R+lO9ROq20i/j7ofIKGrt8b8QGXLHrEOJTdKu2sUP+lf9h0f
	oWfgxraadhB6kgmVpT1d
X-Received: by 2002:a05:622a:5c10:b0:517:5d71:84e5 with SMTP id
 d75a77b69052e-51768fe06fcmr6099541cf.5.1780378459480; Mon, 01 Jun 2026
 22:34:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526070635.839701-1-hhhuuu@google.com> <1f7a7bf2-4d21-4944-9da0-36082d052b25@rowland.harvard.edu>
In-Reply-To: <1f7a7bf2-4d21-4944-9da0-36082d052b25@rowland.harvard.edu>
Reply-To: hhhuuu@xwf.google.com
From: "Jimmy Hu (xWF)" <hhhuuu@xwf.google.com>
Date: Tue, 2 Jun 2026 13:34:07 +0800
X-Gm-Features: AVHnY4J1Pfr-KMpUk2aKTCSyb0iCgb3wHalc4jtJOnhX4DoFuPOdgWZoWR9FlSc
Message-ID: <CAJh=zjLLrY-NpV-ZcmH0V6q8CjNuKt7CmW-GEFQ8_y3zm9v1yw@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: udc: Fix NULL pointer dereference in gadget_match_driver
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 2:00=E2=80=AFAM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Tue, May 26, 2026 at 03:06:35PM +0800, Jimmy Hu wrote:
> > A NULL pointer dereference occurs in gadget_match_driver() because a
> > race condition exists between the DRD mode-switch work and the
> > configfs UDC write path:
> >
> > 1. The DRD mode-switch work invokes __dwc3_set_mode(), which calls
> >    dwc3_gadget_exit() and subsequently frees the UDC device name via
> >    device_unregister(&udc->dev).
> > 2. The configfs UDC write path invokes gadget_dev_desc_UDC_store(),
> >    which calls usb_gadget_register_driver() and subsequently
> >    compares the UDC device name via gadget_match_driver().
> >
> > If gadget_match_driver() runs concurrently during UDC unregistration, i=
t
> > may access the freed UDC device name. Once the freed memory is zeroed,
> > dev_name(&udc->dev) returns NULL, causing a panic in strcmp().
>
> I don't see how this can happen.  gadget_match_driver() runs during
> probing of a gadget, which takes place only while the gadget is
> registered in the device core.  But usb_del_gadget() calls
> device_del(&gadget->dev) before it calls device_unregister(&udc->dev).
> This means that at any time when gadget_match_driver() can run, the UDC
> device name must still be allocated.
>
> You should run more tests.  Add debugging printk() calls just before and
> just after the device_del(&gadget->dev) and device_unregister(&udc->dev)
> lines, and inside gadget_match_driver(), so the tests will show
> unambiguously when these things happen with respect to each other.
>
> > Fix this by checking dev_name(&udc->dev) before calling strcmp().
>
> Adding a check like this will not fix a race; it will only make the race
> less likely to occur.  It won't prevent the name from being deallocated
> between the check and the strcmp() call.
>
> Alan Stern

Hi Alan,

Thank you for the review. You are absolutely right about the TOCTOU risk;
the simple NULL check does not prevent the name from being deallocated
after the check but before the strcmp() call.

I will submit a v2 patch that uses get_device(&udc->dev) and put_device()
to increment the UDC reference count during the matching phase. This will
guarantee that the UDC device name remains allocated and valid throughout
the entire duration of strcmp(), eliminating the race condition structurall=
y.

Does this approach sound reasonable to you?

Thanks,
Jimmy
