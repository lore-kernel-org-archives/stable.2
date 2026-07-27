Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8CB390230
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785165943; cv=pass; b=iNb+UAfPghZb2CDmjeqsjiFku8fY73+3za3Ny1uGiviF1S4ApP44R9QIGxVAkpNOtzWVcJY4AjFEYJikL+nhjGAjle2nWsQY/YDpGrWtYekWY/X24h08Ki667uhG6IXb3cCIQaGUwdpkv8S/0JnesY+GprVaWVnpRrTUHCYFnYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785165943; c=relaxed/simple;
	bh=uF1fNPxVyFqjEpgw53mbvgBu6WUcDvDr1PA4TgWZFlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lL0kLz+y/5IKN5tPmp15IgOQPndniqs58BftX3XjyJDH1CDFM9QLcyxXWgKWxcak+W7SzjnRY6MS85pAuHJEZDC6qnkpdg+JUui8zoP7BqlGu7Opnn0xMl+OFRW9vizXmUwCo8MpZH/OewnHaobyEZKGQ9e5oede852Ub4iv6VI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnMlg+ZC; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnMlg+ZC"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c1c4c7ddaf6so412492866b.3
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 08:25:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785165940; cv=none;
        d=google.com; s=arc-20260327;
        b=H5XaO6u2uxxorfU1GQymEzw7xuOtbdMVWjw+GiV1XA6ta7yEoR4Z4KZr654611esdR
         klSHycT/DNBAv/8emLcVCvZdG/ILkNoMIBoFB6dTJjmrNUSpJpZbqNiMlQhXf+/fUBVf
         0k+4SSv3lVPAPuT2kBkMTHgUcK/cU5m/bsG9TfKKAD5SMvJrURli5wx8R9S4hh9j3jv/
         NC614l6zhFUSGsDDpkCumKDPjxugIwoXL4TpPb9cpwHxYQCeuhlp61Jel6DuWukHhQoO
         caCXnNNWjHQ7A905y1MMY2PmOzPoIso0pJ5EfKdQP4O0AMU5BeuIVleVx40oZTzB01oJ
         Ak/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZyQ5PZuTPEONWfNnvhVP4hsLVBIUJquX0mumyw6bxWs=;
        fh=wmKob5Z4ARJnSBnsUqnpj8Q5he++ZRIjOpcyAi6AFfI=;
        b=Te9lpqDbayrQXAZhrfkDacSS25oM8LL2kZHjJUMtucGcStgOSb2jeAP4C5tpNHzI1o
         kIMCAPbiaaNVr5/Xxb6CMLrKVkmOuQe+Z+IREnBhjFo6xIefyGupRZAHxgYxmKtou9Jq
         cfh8bFiSgHtjOJmew1EPspCo07ImE/+x0wMehl4mE8HbCALWNjC+Bok/ueaz7Kynl8D5
         5/DVO/H8xsjejwxuqa2NuhxvJzeO1xwXnOVeY8aotjnOoqcr6YRU2QqRuiS+sBo4HP1T
         9AycWBx1D9qXCCWf8L/qgjiQaC1Q7G9s0TIO31vjgxmOD+1/5mBl42YyfiNmC359CKh+
         yBKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785165940; x=1785770740; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZyQ5PZuTPEONWfNnvhVP4hsLVBIUJquX0mumyw6bxWs=;
        b=cnMlg+ZC5Xaqh6CuSuFvImkISd2XUh+oSEYCCiVEf+g0Fs701fEhOGxwIrdWpBAnWf
         i9XuDK9XVOZByLclKIp5r8tOma7VxGlIkvgcDTUq4kg9yyVxtNi1KSdSehQt8Yc/mnlx
         nBIp15zhsJ/FFw3XP2ed6ao5DURUJ/HUNv9tJ1iPFctEXDx1B161QdhcWHP+MdDR0Y0i
         Njxk7v3jjPe1MFVJA9D0FxbjsB+kgofQCpXdcURN6D03OhbF7Vy5wi2iz168wWlfkyCL
         11tz2LgB3D7wSPA3X9LhpHl0FYBRWGkT+cOgklUjtrYpe0U6E86Zijmk4f9axFDBXRSW
         51dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785165940; x=1785770740;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZyQ5PZuTPEONWfNnvhVP4hsLVBIUJquX0mumyw6bxWs=;
        b=pTW0uioYjj99mWae3dRQSWrKO1Iw0k1aXkcedw9W3uDEbn1Gi5+2f/uDmrXWNhSEMK
         9i4nOyqPyqexk5oj6LI1yW4ADfACXYSizUjMEUrOEKmwUYg2pCJyxTkDR8BwjDugOTMG
         DGbmShqfLWfzmlSE8TWSW/kP2e86vRRwPY/R8KAm2u694O+2xawSiiOrhcgqJL9UZhpT
         LyYImLgq94bq+h8m8S1N8g4vxlppdKlQznFwOsOA2LnvmUlwD+8bDYbuI9eZmFSGx0IV
         GOmqJE9Nenuf5mLyL6gPmoot5LNzHzaK1ABT6djQZZBgt7B616jKG3R91zVdHM4YWmQX
         hpog==
X-Forwarded-Encrypted: i=1; AHgh+RpvMs9HBA1QLAHI/fSsWyymShu8wsxjWRKXAFoZ6sYvEOW5rULYcrL7L943fohJZuqpBSyQLpY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj0oN+OkqtwX4ey03IhRGJjxtsKaico0C7KzKZYycUcWwwV0AS
	kI9877XUgmTUd/1euxrS92WslFoJxPPeeVCY+ydyR6sacxNXUg45mT9Mn5UGadCkPF/xnFqBB4E
	NYmjQwG2OzE3yReQ+Tc5zJEnhZZO3aME=
X-Gm-Gg: AR+sD13/pI//oCFJd0FNT1kl9zDED95kxsSpxSQBVFrJcktrRguTlGZRi1LMoTEa/zK
	SJYU3TpRODjKNJCOsiCBG7E7yzNvQfKTP5BcpOvp18umdu1LsSjoHGO6Rv4o2ePBrO4ROMsMwU0
	S5aXKOjuKA2SMze9IVzc5PZJQzmAAoOPMvAp36vCsCbpauqQx7+YbI+y9Ibf71YXLX8bWS4s7Wy
	tnaUjF/oSOjQB3SU0POvK6UsS9izJSOceKip4baEbOg7Wi3xooyEWSb2UohrPPgTtglpJ4ebFhp
	tzdL5JXNOko5Os+B3vyKBm3vOZbNxfh8fqYi0+2UYhHR4e+pdZZGjULOtg==
X-Received: by 2002:a17:907:c26:b0:c15:cd7c:fcf0 with SMTP id
 a640c23a62f3a-c1f1eabef74mr350397466b.1.1785165939596; Mon, 27 Jul 2026
 08:25:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717195336.98500-1-nikhilsolanke5@gmail.com>
 <20260717195336.98500-2-nikhilsolanke5@gmail.com> <20260726182946.79a4ef98.michal.pecio@gmail.com>
In-Reply-To: <20260726182946.79a4ef98.michal.pecio@gmail.com>
From: Nikhil Solanke <nikhilsolanke5@gmail.com>
Date: Mon, 27 Jul 2026 20:55:27 +0530
X-Gm-Features: AUfX_mz3Tx6f_QGAH6lPEIgpArKnzr7KWgpSIZN5Zn993HpKDUv4hxmZ1aapDq8
Message-ID: <CAFgddh+1Bk=CFkKYNzB=L++UejkhCEcTHp4A2JL2v+P6uBuF2w@mail.gmail.com>
Subject: Re: [PATCH 1/2] usbcore: Add quirk for 255-bytes initial config read
To: Michal Pecio <michal.pecio@gmail.com>
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, stern@rowland.harvard.edu, corbet@lwn.net, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 26 Jul 2026 at 21:55, Michal Pecio <michal.pecio@gmail.com> wrote:
> > diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
> > index 45e20c6d76c0..442c15f92ccd 100644
> > --- a/drivers/usb/core/config.c
> > +++ b/drivers/usb/core/config.c
> > @@ -912,6 +912,17 @@ int usb_get_configuration(struct usb_device *dev)
> >       unsigned char *bigbuffer;
> >       struct usb_config_descriptor *desc;
> >       int result;
> > +     size_t usb_config_req_size;
> > +
> > +     /*
> > +      * Devices with quirky firmware will stall or reset when the initial
>
> Has anyone actually seen a device that stalls?
>


Regarding the "stall" wording, I was referring to the condition where
they fail with -EPIPE error when these devices are connected through
external usb hubs. The directly connected devices I've tested
typically fail with -EPROTO instead.  I'm happy to reword the comment
if you think that would make it clearer.


> Even if no device currently uses both quirks, I think this belongs
> after the msleep() below, to minimize interaction between the quirks.
>
> >               if (dev->quirks & USB_QUIRK_DELAY_INIT)
> >                       msleep(200);
> >


Alright I'll address this change in next revision.

For the remaining comment and log message wording, I'd prefer to keep
the current version for now unless there's a strong objection. The
patch has already gone through several review rounds and I'd like to
avoid extending the review cycle further over comment phrasing,
especially since the implementation itself now seems to be in good
shape.

Thanks,
Nikhil Solanke
