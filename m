Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0572FFFB8
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 19:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782674289; cv=none; b=qcseK33jjVDUR5fBsbHBP2BOYlHmn2ArB6eLfVdtIysNxqbsLXgCtukq7PWWpHwMT/i/bwitMF5nhkhYCNlaeZNCnL6ef67vdXcr1bQ1ivNRmjipynyHnjy7F50qkHIvFz0p/QSlsRh05NgLcdTzfO3qZby8f4YNHaJG4DSLgHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782674289; c=relaxed/simple;
	bh=n/G92GrsA9ruso1DbYIYE4AnAPuAZp/VAjINM+B7Ly0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2y5xJn5zwYzblxToh+3JrgBix/eQ0hMS+R3YHjrO8ztZ6Go9GhOK/jZHW2Id8QJXLgBfIyNshBkioHAJac+i2FdHuQ4CyMFVEQjxeWCfGzKy/3KN9D3Kggbmo5lpTQw9qZLCZUfds1cS27nBTv/ZNGsdYjD6aetNGsnFS7cnEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=Xxul7sXu; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="Xxul7sXu"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51bfe9a1550so1349711cf.0
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 12:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1782674287; x=1783279087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oo5Z8Yt77eV159eB51RytXZ95igPn7LmT+HtkoqhKVU=;
        b=Xxul7sXuHGHi+ll0holyF4sdpxdTJvRDQ7SnP+xGyabk8dvVpGkDlSeYwy7o3xPkIh
         tJ1nqASfQ0mKMDEnEji7qpgBMUkWQgL2GJlWhIDGRwgZwLrQcWWLYRT3V4KXlffRx7l9
         KvPXVtSvwMXFKNXOsnGK5+wM2pdezRLxt2rhe0m6Oyg5WrLUkz8dkr6hFjVdLB+ZH50o
         9p6xtkoW0Zaje1gJdK11HMu48alPaC8mLQ2b/mMvBL3EhfG732/5UwFTXA+pknJTRdpw
         EsnOikqJMpwdq3QuF8Cz8VduDFm8Sll1HxflbQ3b+58VC1TQLAhQuttrzFn1jSsusGmo
         Ca/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782674287; x=1783279087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oo5Z8Yt77eV159eB51RytXZ95igPn7LmT+HtkoqhKVU=;
        b=PW+qWjh9DYnSow7IkZ2Ea7S5IiVpSihBsa6fy1Jwa7xGql11THNS5hc+KVFw35S2TX
         XcCu8YBJYP7ChxcTGVXKyCyi0Jp+EtGbjL1tmi3gRDFaF7a+au2X0mP4+lBLL8xxSQMl
         1ChKMYPem93lUtIy01e7ai3Tjavn/gjhoxzbJ4hbxYkocPi8Ya6GTuGKm6PzjOSbXASm
         ughIHRa7oTX1KCVHq+Q690ZPvXkQAkR+fHc4LIVgan4WX39QrarSv88YfUoFNF34+l2Z
         FwRe+Ea9A87eCCYghZEsy0B5WTfa1xp0Ewbi1H3DJBbUte9X6vKx4jkdht3koYjBLE5w
         OcPA==
X-Forwarded-Encrypted: i=1; AFNElJ/+tcJamBVZ66WXDxEvEJRUxW5eRo2QvSRBqHRWqhANH4sHKuAtaW+clSGWsNxqOQnuTyoicNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBJViLsMHJwbBH62Nk7fnvAgbg4IBbhXs/+/Jg+gmqLjLYGlxZ
	RTLxVLEJt2TOuk8TesT2tqrixWbmZnvJ4Li8Ah7CMtdP5H18D44fiLfJJzieZkN9yQ==
X-Gm-Gg: AfdE7cnzZ2rx6MUnGTSAnpzAnmJ5wR8HfibNgH40alrYy0LA5LDsFKfaGwgTfEvuagW
	pdG48Ea1EixJcbvRxKYIVaUndbT8OgnucKs5bKrDRiO43V89mC1sm+a/N27ByaKHjh7dP0XQ6Pb
	xrU6DcWcX9vXD5FRkpMMCgKwQMY8OOLFlUbBw0FIGmFmGVwXjxCNZH8WLZiPwNP9ZI20RjYilT/
	lmxAfNeQcs/7EQna91XKYONIXyw5cfjcLzPru6RSxEGXYNAHnHIOwPWkW3d2wZxV7WtX0V0rKtn
	0E1OkGKT/WwFG3XUXk6Ao5Up9d9fLdzLoof3FKqYrVTLRPLD8P7FzNHDtY8TGYPnfglPvC1nQ8c
	E+0p8cDQt1AWBzMJXMA2uTbzdFZly/tQtj2CBlfjxjdLDUya+WCaifk8Qm+zd7RYTuEvPwIl1NR
	XLaEx5qXcs4IV/t6XADcdSrwCLZU54yf7a
X-Received: by 2002:a05:620a:a0c6:20b0:92b:a2f6:d1a9 with SMTP id af79cd13be357-92ba2f6d1f0mr646592985a.44.1782674286568;
        Sun, 28 Jun 2026 12:18:06 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210:d62f:1911:f952:16ba])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926000c343bsm1872097985a.28.2026.06.28.12.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 12:18:05 -0700 (PDT)
Date: Sun, 28 Jun 2026 15:18:02 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Nikhil Solanke <nikhilsolanke5@gmail.com>, linux-usb@vger.kernel.org,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] usbcore: Add quirk for 255-bytes initial config read
Message-ID: <8f5bb295-fc1b-4698-8f2f-2d40fb4d9f93@rowland.harvard.edu>
References: <567e8866-4308-4e5f-819c-fe778dbf74f8@rowland.harvard.edu>
 <CAFgddhJk0EYG71fnKdio=RHC-cH+JmL-EZ7-oVD-LdHoa2TBSA@mail.gmail.com>
 <5159fd69-dddf-4073-a8e7-95fa77de0b7f@rowland.harvard.edu>
 <CAFgddhJ2HeJ=oTBX_axMJcgJq7GXH9abe+LH+x9NGekGO4BMyw@mail.gmail.com>
 <eb0dfd45-91c5-49ba-a297-b183dbc52c8c@rowland.harvard.edu>
 <CAFgddhLZ9SuOzG_6mW09j9aDkCp6TedpNkzJ6TUD+DnR3TDLKA@mail.gmail.com>
 <02060df3-b8c5-4a86-b3ab-3a28eea8a562@rowland.harvard.edu>
 <20260628165040.76fd608d.michal.pecio@gmail.com>
 <62e1fab3-1045-41f3-bc74-4c7624011619@rowland.harvard.edu>
 <20260628190201.00afdccf.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628190201.00afdccf.michal.pecio@gmail.com>

On Sun, Jun 28, 2026 at 07:02:01PM +0200, Michal Pecio wrote:
> On Sun, 28 Jun 2026 11:48:36 -0400, Alan Stern wrote:
> > > How about "keep unrelated changes out of a stable patch", i.e. always
> > > do the delay (if any) after the first request, regardless of size?  
> > 
> > This is not an unrelated change.  Rather, it's deciding on how to behave 
> > in an entirely new control pathway -- the one where the 255-byte quirk 
> > flag is set.  The old pathway is completely unaffected.
> > 
> > I suspect no devices will have both this quirk flag and the DELAY_INIT 
> > flag set, which means the location of any delays in the new pathway 
> > won't matter at all since they will never be used.
> 
> If no devices will have both quirks then new delay added before the
> first configuration request will never execute.

Correct.

> If such devices will exist, then it probably won't matter whether the
> delay comes after or before the first request. Purpose isn't known,
> but it appears to be rate limiting configuration descriptor requests
> or delaying other requests after this function returns.

In fact, the commit that talks about the Logitech webcams does describe 
their buggy behavior to some extent.  It says that they seem to reply 
with stale video data instead of the real config information, and from 
there it's a short guess that adding a delay gives time for the video 
pipeline to drain or time out.

In addition, the fact that the delay is needed after the first request 
but before the second suggests that the data corruption only affects 
transfers longer than 9 bytes -- which the new first request would be.  
Therefore it would be appropriate to have the delay before the new first 
request.  Whether another delay would be needed before the second 
request (if there is one) is unknown.

> Either way, no known need exists to add another delay before the first
> request or alter the existing delay (or its conditions) in any way.

See the reasoning above.

> In general, I always object to code which serves no purpose because
> such code is easy to add but very hard to remove when it gets in the
> way. There are no known users, no test cases, only paranoia.
> 
> So I would keep the delay code completely unchaged.

At this point it's entirely theoretical anyway, since the devices that 
would get the new 255-byte quirk flag don't also have the DELAY_INIT 
quirk.

> And skip other random changes like error string nitpicking. Reliable
> and up to date information about how many bytes are requested,
> "expected" (what does it even mean, to somebody reading dmesg?),
> received or verified to exist can be gained from source and usbmon.

Good point.  But I dislike messages that actively produce wrong 
information.  Nikhil could get rid of the parts of the log messages you 
don't like, but he shouldn't leave them as they are.  He could even do 
that in a second patch, separate from this one.

> A stable patch is supposedly supposed to be 100 lines with context ;)

Nonsense.  An excellent stable patch is 7 lines, including context.  :-)

> I really think it could (and should) be a simple patch.
> 
> This is what I wrote a few weeks ago. It's an unconditional change
> for all devices, but it would be easy to turn it into a quirk.
> 
> 
> --- a/drivers/usb/core/config.c
> +++ b/drivers/usb/core/config.c
> @@ -938,15 +938,14 @@ int usb_get_configuration(struct usb_device *dev)
>  	if (!dev->rawdescriptors)
>  		return -ENOMEM;
>  
> -	desc = kmalloc(USB_DT_CONFIG_SIZE, GFP_KERNEL);
> +	desc = kmalloc(255, GFP_KERNEL);
>  	if (!desc)
>  		return -ENOMEM;
>  
>  	for (cfgno = 0; cfgno < ncfg; cfgno++) {
> -		/* We grab just the first descriptor so we know how long
> -		 * the whole configuration is */
> +		/* Try 255 bytes first because that's what Windows does */
>  		result = usb_get_descriptor(dev, USB_DT_CONFIG, cfgno,
> -		    desc, USB_DT_CONFIG_SIZE);
> +		    desc, 255);
>  		if (result < 0) {
>  			dev_err(ddev, "unable to read config index %d "
>  			    "descriptor/%s: %d\n", cfgno, "start", result);
> @@ -975,8 +974,12 @@ int usb_get_configuration(struct usb_device *dev)
>  		if (dev->quirks & USB_QUIRK_DELAY_INIT)
>  			msleep(200);
>  
> -		result = usb_get_descriptor(dev, USB_DT_CONFIG, cfgno,
> -		    bigbuffer, length);
> +		/* Don't bother if we already have it all */
> +		if (length <= result)
> +			memcpy(bigbuffer, desc, length);
> +		else
> +			result = usb_get_descriptor(dev, USB_DT_CONFIG, cfgno,
> +					bigbuffer, length);
>  		if (result < 0) {
>  			dev_err(ddev, "unable to read config index %d "
>  			    "descriptor/%s\n", cfgno, "all");

Making this depend on a quirk flag instead of being unconditional would 
yield a patch very similar to what Nikhil has already posted.

Alan Stern
