Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057E33AE1BC
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 21:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782249262; cv=pass; b=NcqW9sZth/fIByWmIp8nzgsKEajd6GGbegP3YbEjGk53P5hMtNIR0kqxJcC5ROCpf45IvSKbJkLcUBJqt2FINqsRyCSj+Lu8wfpztzZPc06SdQPsK7Bdfci66WOt1lyYyJcZEDBOipp66mD3Pm9hmkDreH0LUVo7eR4IoyytV+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782249262; c=relaxed/simple;
	bh=BEu6oE1hirZSlFOt35YJmaquG08gwWbriv8/eCijrXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOeFilMjW26mQBiDYxwiNUTOXCPWiMAalhMcFAe9g5mKV46QEjLngGGvSr1/EIevPxqDNSm10KWh5HPr8C5LSE3yf7uKnFepsXnUycQt8R14w0JFGt4gx2SgvJ91QdL5OR9TeB35ZWf0GCTGbalklWNgMmB4wEly8OHJtRMc274=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sl0yFM9f; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sl0yFM9f"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bec49f7e35eso50516566b.2
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 14:14:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782249259; cv=none;
        d=google.com; s=arc-20240605;
        b=g2Vtssnt8Myr6+ORSA6AI9eeMfA6SX8FJgGDjNtIDX2ghVrJnSMudfC1ZR7HeVzwYR
         8tfPib3ALii2VZ4L9h6eoKLJ+jgNUNDtrt2GJ4NCffdO91sV8QNVzvQgbT9WOtmyBM7p
         kTJpYuxpt758UupN+btyVfH5TotD5NycgHuaGWJYUh7tNkS5kd/wbroeOOQXBIK2nA5D
         gnB86jNNDgGHU5JMRQVZ5fBGvmBtxpGjnNDgTpRHsUBF6E74NFqKc3fMKeanMgV9ZP74
         1K7IKRXXfFdb8NXshL0EitlWqhHs6dKu2ZrqH+s/7XGP3ASpDlFrHWAhZvH7ObAcz+uM
         FYQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=71fysXJovgrDCc8Ak5Zz96I/xjwYwfjNFkfuKiiFSRU=;
        fh=I84fkDWB3XwTwIdr/ASWGvLLuwBVPwUf/mj/dvLOnWM=;
        b=RDBHeyg1LUlWnJidQC62Sr1iE0zhtgr/oGs2SilMTbJOWdkv420whb+oHmNZ4HiCeT
         G3TC6usGJCBaJuOuz45dJuVUTtFWzjWHqPG2YmuN4LJ0lCfbHQ1puIwxljDDMjSXL68e
         5NHSlIwN/qp3Sruy3NEF2Xag5nb1zxdihqGQUHkneOLIO6FGLX2Y2DrGJhuZwWcmVkLv
         jwi3M5zTFzZMRM+qy6pczlADnKcNIyTyRad2uky8SjyVVDh/pCSNu0ND3k3Ch6yT4p8G
         t6lCGRqI0g9YZck4uCQXn6cQiLtdPEtsTVDbnjtV3UKu4UGp1+QTIQGjIPOX7cQshUCM
         sZwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782249259; x=1782854059; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=71fysXJovgrDCc8Ak5Zz96I/xjwYwfjNFkfuKiiFSRU=;
        b=Sl0yFM9fmlE/0dP2EFtzcITAAp0HejHQhaNmqIAXpLIdhlQ/C6UbKpz5gK1e2ZDH0y
         3a5otLbdkPZzFWLT7UE+918hOBWtzduIWZtQzcH1bDIbTxiUvxwSHTTSJBkNEmlQUlSE
         C2Zvu/lo2k5BZCOyvBSolXycPTWfcqywGn1ChKrj6jTdoUVv654TWlXiKcGR2mgs254n
         Hi42tL2sVvzmubRhXeqUhY90EF4mY375DCSQHEQFuxV2/0gPx0G9MdmfrjXJwJSsimMo
         1bKoKhTl5paVWMjv1pflCYUidBHWl9OKaHA1hJS0O7QWY6kpjU9goNlYSg0uKWTGyLeA
         AaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782249259; x=1782854059;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71fysXJovgrDCc8Ak5Zz96I/xjwYwfjNFkfuKiiFSRU=;
        b=YNOFLvREDrY+q4bA31LBMgCAtIJyEcrbJXbh5XViF0nh6uTPBGxk4xtU0FcgG9/nLN
         dg1o84XvEbrYPU7uPglZ7pprhspHX37teGgaDr0HdTHnoD9Rhrl5YRnoR1m27W+WEx3b
         l+jeyJqsE7Bm2Rsxwmbd+P3GbdH29l0mron3baABFcXlvHgt6anUai+diKR3hc5Y5NBR
         U74eVezDBgPvuCepertRgXi1tvX35YXHMYqRd/jORNtIjR02jEnedw8jGq+rCIekLkZv
         AqcWn9lZMVaw6Y16LKPfRxEvFoOZrk6ASG/N8neUr9Ru5JxkWi5KYjiML6g01xHlqfLF
         n6/A==
X-Forwarded-Encrypted: i=1; AFNElJ8HevX0VGcyY+icEZymXxwGKRlMAcnrlvy0yif0yakaowBZfkNxCoS/nHNa5Rr7zuonVRSdmd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfENuezHSINg4cpjOjEsWF3TKwbmKfY++EUuiqGzLI4XzLTBmc
	t2iVF6b3Tdt8iyq7ufay2RK3LAMEtoNq2HIyO0rsdEZJhJQiPRbumu6xSspjlXsjWvgICgpQy4O
	SQ7ygnGy5PBmGSAngTp2PK3j2XGC+mmE=
X-Gm-Gg: AfdE7clgxGvhm+Hr9As79RWDoCs6WVpXqW7vKJ3MA8SU5VdCdap3Px03tIYJ1wDfGJa
	YIrO/LbXCqbjhoDkJG9dcQL7Kye4UMpRMBx9I/4XKqw2RAkFOvyUkux9dFRL2Zdwt1x2QQNjeoC
	/oTcp6aAukTOuO7lHSa+d7qFrR5KHQQmU6VBuhvnPEDUhcJZzz6Ph0+EACyTvTfguhz5+RPIkkg
	HHig5gOghwsV7uib5vNRD1CpJ3B3ahpqY6uo81/jE64kHX1+yluMPDrxXiDhPK1AwjYNT7WiQ==
X-Received: by 2002:a17:907:3f1f:b0:c11:1753:25cc with SMTP id
 a640c23a62f3a-c119f025261mr13470466b.42.1782249258699; Tue, 23 Jun 2026
 14:14:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623161035.5792-1-nikhilsolanke5@gmail.com> <567e8866-4308-4e5f-819c-fe778dbf74f8@rowland.harvard.edu>
In-Reply-To: <567e8866-4308-4e5f-819c-fe778dbf74f8@rowland.harvard.edu>
From: Nikhil Solanke <nikhilsolanke5@gmail.com>
Date: Wed, 24 Jun 2026 02:44:07 +0530
X-Gm-Features: AVVi8CdIaeu_joffRLcSvxxiZQ1_ZI76_fR_kxTsWH5gxda-81WTi5hBvd3VxLE
Message-ID: <CAFgddhJk0EYG71fnKdio=RHC-cH+JmL-EZ7-oVD-LdHoa2TBSA@mail.gmail.com>
Subject: Re: [PATCH v2] usbcore: Add quirk for 255-bytes initial config read
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, michal.pecio@gmail.com, stable@vger.kernel.org, 
	corbet@lwn.net, skhan@linuxfoundation.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Moving this delay up here changes the behavior when the quirk flag isn't
> set.  While it agrees with the intention of the USB_QUIRK_DELAY_INIT
> flag, such a change should be mentioned in the patch description.

How should I mention it then? Nothing comes to mind besides the
obvious: "Also move the USB_QUIRK_DELAY_INIT sleep to before the
initial descriptor read, so the delay applies consistently regardless
of whether USB_QUIRK_CONFIG_SIZE is set.". Or should i revert it back
to original position?

> > +
> > +             /*
> > +              * Grab just the first descriptor so we know how long the whole
> > +              * configuration is. In case of quirky firmware, try to grab the
> > +              * whole thing in one go by asking for a 255-bytes sized buffer
> > +              * mirroring Windows behavior.
> > +              */
>
> This needs to be rewritten, as it is self-contradictory.  When the quirk
> flag is set we issue a 255-byte request to mimic the Windows behavior,
> and only when the flag isn't set do we grab just the first descriptor.

I am sorry I didn't understand how it is self contradictory. The
comment does say, "in case of quirky firmware..."? Am i missing
something?

> >               result = usb_get_descriptor(dev, USB_DT_CONFIG, cfgno,
> > -                 desc, USB_DT_CONFIG_SIZE);
> > +                                             desc, usb_config_req_size);
>
> Don't make extraneous changes to the existing indentation (or whitespace
> in general), here and below.

Well the linux coding style guidelines mention that those descendants
should preferably be aligned with the function open parenthesis. Since
i did "touch" that line/part of code I though might as well indent it
a bit accordingly. Should i revert the indent then (in this and the
other place)?

> >                       if (result != -EPIPE)
> >                               goto err;
> >                       dev_notice(ddev, "chopping to %d config(s)\n", cfgno);
> > @@ -957,13 +976,25 @@ int usb_get_configuration(struct usb_device *dev)
> >                       break;
> >               } else if (result < 4) {
> >                       dev_err(ddev, "config index %d descriptor too short "
> > -                         "(expected %i, got %i)\n", cfgno,
> > -                         USB_DT_CONFIG_SIZE, result);
> > +                             "(asked for %zu, got %i, expected at least %i)\n",
> > +                             cfgno, usb_config_req_size, result, 4);
> >                       result = -EINVAL;
> >                       goto err;
> >               }
> > +
> >               length = max_t(int, le16_to_cpu(desc->wTotalLength),
> > -                 USB_DT_CONFIG_SIZE);
> > +                             USB_DT_CONFIG_SIZE);
>
> This is another example of a change that has nothing to do with the
> purpose of the patch.

Isn't that what you told me to change? So the logs are accurate? I
made that change because you suggested it. :')

> > +
> > +             /*
> > +              * If the device returns the full length configuration
> > +              * descriptor, skip the second read. Otherwise, send a second
>
> Strictly speaking, the configuration descriptor is only 9 bytes long.
> What you mean here is the entire configuration descriptor set.

Alright i'll reword it.

> > +              * request asking for the full length.
> > +              */
> > +             if (result >= le16_to_cpu(desc->wTotalLength)) {
>
> Shouldn't this be: result >= length?  No point in repeating the
> le16_to_cpu calculation.

Yess. initially the length assignment was happening afterwards in my
patch. then i decided to move it before the "if" statement since the
outcome of length was going to be similar in any case (within if and
after if). but then i forgot to modify the if too. Will fix it.

> Like above, this string should all be on one line.

Will fix all the strings as well

Nikhil Solanke
