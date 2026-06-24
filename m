Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2615E22D792
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 01:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782264959; cv=none; b=RsFXQz/EMQ4WUlrAkrZ42TpNcvFc0V1C1q+ooeInETXJjvsCRU6qEs33JJdn0QNl8tHq+X/J9rIDLX11mAODuZj4IQv8MuHZbhwOqeXrGx1W1cC8mSRRAjyr3pZv7IHAb4dAIEm5zqtEWBwXJ655BByILLpvhe2sChl72DAr/o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782264959; c=relaxed/simple;
	bh=2cVaFga+65dyxq5fyUU7g2cHTGGl6qw3goVZxZqgnAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyHqb+I1Iiu6J2cikx7IwFFsNmWyZ9Oz1UOYFRCjy1w3bxQbopcCgExztIProidgmmXo/MQRREW+RtZh1sTyi4CM8AEf6Jkui6VAOqUf5qyWwiYLtSm5sp7HCYV/DzTVxNRUWrXY/uceHSS6p5S6leiqtF0+s3dklVkJtY7v9mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=lKo3FBPD; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="lKo3FBPD"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-517654b8e28so2806131cf.3
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 18:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1782264957; x=1782869757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9taatE6id6TePTU8SCXYGtw69S0M9czLSbV3oEX+B5M=;
        b=lKo3FBPDg6b93rlaw0CQcbYvplJLN1hsBbcYOiW8Ee8q8UlpVFRmxIF2OltAN+RNb+
         kfbHVmrppwTFs45B+CAYRuMiWjEE+Int7gVcMPdGK/abqmKFBhihMVS1eS6qZiEXk5lw
         sAQHpoDIRIoFVSfedHWnT80EHyjNoEp9+7UVcrs4/8WFpacv48O/NcG2A0tfRcofW3nK
         iGX50UDQEK6Y3AdJ3pFrWS1f+162kb1fAN0/m7l1IakJ/z++1A8cj3MKMSRvGyu7CP6S
         abYY9TT/Y363qO/yazQzUvak2hgNYjxko5+NIneIsQ9P+QTHYh5WkDsVEx+MrCFKrquw
         dG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782264957; x=1782869757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9taatE6id6TePTU8SCXYGtw69S0M9czLSbV3oEX+B5M=;
        b=EQDLpWrWS3O9EKrhBPfq2zZWHRFfBua4mJuR/WG8uOsBaJ1EcTE2te3PxemkvRQpz/
         npf742bHYNS92i1ZX/UK0kUdTBbgI7sVILLVeczO9+/djQEGwt254/nx0caNWzpdE/S+
         pI2kV5atSX7LOrLEMPW6XAgujJShpSScwLZp3VJaFUaaDvG1C+ou0OCq00NNe0sNnOre
         +49ALM8ThBarh/duU2RA+U16u6aYzSc2eoeLDBxt5YR4talNtVY79ykE4vSHGJDnRxyF
         Bkv6PCLPRiea9tnsbrGvbVjKu5NIlln1287sC41rizBPywdrZ8/OkLDLlX26WrxmVzvV
         wMsA==
X-Forwarded-Encrypted: i=1; AFNElJ9VpYDSSjAcbzK3LsGFYn0n06tCmjbijO4RLZVvwaHes8Z23+8V5BYMicoxSXepbSfZJ/VMfto=@vger.kernel.org
X-Gm-Message-State: AOJu0YzikQ4JVlxhssS9pGzk4sU3E5tDVKxdZyYGYYEMcrpdiIIrQZxL
	dXCPGDVRcBMvJ5ZG46iddaGWmfS/jFEGdrwruD3CGXstySLnFGo6fW6dCTANjxfvsQ==
X-Gm-Gg: AfdE7ckiMGikUmI/ymS1QySCwXQfK7jfttHuMwLWqsVoQHtxM7gKtuxkvWylwsHgKpw
	424VPZdN2T6CzRBbVtB6PKPxWoBqpi2zPwWqzgQHs4KT7wg/0JcWFDi7pXADd9AiikxufggF9ml
	XeUrIvfNIEG281DDdRGkXhxtYHAGCanynNoNA2UyJGK0oaCeTwpR/Uc46jjiJgBS/TXWJlCVrhc
	ivgIPpMIZ+9MYOFzDVmTb52ApU/GvapJy/kHjaeHxsl5imCI60vzm8eE93Ee6lVgNegjAA11/h8
	+nFLVzLci3Cnl4BsFdaSiT2YZcWy6uY+8uxWeFkiO6rb0bsn52gKUMhXuA4gw+wTbJaJ07dCtb+
	quFwteEsakqli3jkbmdz0bNe56R7ZX4sEm8IKhkugiRzmhQhESHHFAwYRDjRuki7U/9iThgRw0F
	GRA8cJ3gMypUhU+wmijt2nXjJaYaS/+EwI
X-Received: by 2002:a05:622a:609:b0:519:ff6a:7cd9 with SMTP id d75a77b69052e-51a06938e9emr270710221cf.31.1782264957030;
        Tue, 23 Jun 2026 18:35:57 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210:d62f:1911:f952:16ba])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a514b4f93sm35410741cf.2.2026.06.23.18.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 18:35:55 -0700 (PDT)
Date: Tue, 23 Jun 2026 21:35:53 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Nikhil Solanke <nikhilsolanke5@gmail.com>
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, michal.pecio@gmail.com,
	stable@vger.kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] usbcore: Add quirk for 255-bytes initial config read
Message-ID: <5159fd69-dddf-4073-a8e7-95fa77de0b7f@rowland.harvard.edu>
References: <20260623161035.5792-1-nikhilsolanke5@gmail.com>
 <567e8866-4308-4e5f-819c-fe778dbf74f8@rowland.harvard.edu>
 <CAFgddhJk0EYG71fnKdio=RHC-cH+JmL-EZ7-oVD-LdHoa2TBSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgddhJk0EYG71fnKdio=RHC-cH+JmL-EZ7-oVD-LdHoa2TBSA@mail.gmail.com>

On Wed, Jun 24, 2026 at 02:44:07AM +0530, Nikhil Solanke wrote:
> > Moving this delay up here changes the behavior when the quirk flag isn't
> > set.  While it agrees with the intention of the USB_QUIRK_DELAY_INIT
> > flag, such a change should be mentioned in the patch description.
> 
> How should I mention it then? Nothing comes to mind besides the
> obvious: "Also move the USB_QUIRK_DELAY_INIT sleep to before the
> initial descriptor read, so the delay applies consistently regardless
> of whether USB_QUIRK_CONFIG_SIZE is set.". Or should i revert it back
> to original position?

Actually, the best approach here would be to put this single change into 
a separate patch that comes before the current one.  That removes issues 
of making more than one functional change in one patch and improves 
bisectability.

But to answer your question: In general, a patch's description should 
explain the reasons for the changes that the patch makes.  Especially 
when a particular change doesn't appear, at first glance, to be related 
to the patch's primary purpose.  (On the other hand, it doesn't need to 
explain in detail what the patch does; we can see that for ourselves 
just by reading the patch's contents.)

> > > +             /*
> > > +              * Grab just the first descriptor so we know how long the whole
> > > +              * configuration is. In case of quirky firmware, try to grab the
> > > +              * whole thing in one go by asking for a 255-bytes sized buffer
> > > +              * mirroring Windows behavior.
> > > +              */
> >
> > This needs to be rewritten, as it is self-contradictory.  When the quirk
> > flag is set we issue a 255-byte request to mimic the Windows behavior,
> > and only when the flag isn't set do we grab just the first descriptor.
> 
> I am sorry I didn't understand how it is self contradictory. The
> comment does say, "in case of quirky firmware..."? Am i missing
> something?

Literally, what the comment says is: Grab just the first descriptor, 
and if the quirk flag is set, get all the descriptors.  That's a 
contradiction -- you can get just the first, or you can get all of 
them, but you can't do both at the same time!

> > >               result = usb_get_descriptor(dev, USB_DT_CONFIG, cfgno,
> > > -                 desc, USB_DT_CONFIG_SIZE);
> > > +                                             desc, usb_config_req_size);
> >
> > Don't make extraneous changes to the existing indentation (or whitespace
> > in general), here and below.
> 
> Well the linux coding style guidelines mention that those descendants
> should preferably be aligned with the function open parenthesis. Since
> i did "touch" that line/part of code I though might as well indent it
> a bit accordingly. Should i revert the indent then (in this and the
> other place)?

The style used in this file is to indent continuation lines by 4 spaces, 
because some of the continued statements are extremely long.  If you 
want to align new continuation lines with an open paren, you can -- but 
you didn't even do that in the example above; you aligned it with the 
space following the first comma.

And while you did change some nearby code, you did not change the code 
in this line.  So reformatting it is not justified.

> > >                       if (result != -EPIPE)
> > >                               goto err;
> > >                       dev_notice(ddev, "chopping to %d config(s)\n", cfgno);
> > > @@ -957,13 +976,25 @@ int usb_get_configuration(struct usb_device *dev)
> > >                       break;
> > >               } else if (result < 4) {
> > >                       dev_err(ddev, "config index %d descriptor too short "
> > > -                         "(expected %i, got %i)\n", cfgno,
> > > -                         USB_DT_CONFIG_SIZE, result);
> > > +                             "(asked for %zu, got %i, expected at least %i)\n",
> > > +                             cfgno, usb_config_req_size, result, 4);
> > >                       result = -EINVAL;
> > >                       goto err;
> > >               }
> > > +
> > >               length = max_t(int, le16_to_cpu(desc->wTotalLength),
> > > -                 USB_DT_CONFIG_SIZE);
> > > +                             USB_DT_CONFIG_SIZE);
> >
> > This is another example of a change that has nothing to do with the
> > purpose of the patch.
> 
> Isn't that what you told me to change? So the logs are accurate? I
> made that change because you suggested it. :')

My comment referred to the two lines directly above it, and I did not 
suggest leaving the code exactly the same except for indenting it 
farther.  Or inserting an extra blank line just before the assignment to 
length.

Alan Stern
