Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AFB397352
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781966237; cv=none; b=Nh4KjuduC4oapsxPwMFODfeq2eUK2gwaf1jqreYLHP4ofSY9MCl9Kx9uAl/dPeueFhbPeySNf32R3lKsgVp3fz+dDnPN8Syjkcq1MSfh5Jqj7zmUYsVpuOKyOxCAOJH5K+8IBOBZ5GnvzHlJDuMCnCL+6RsA9gVtzqoYQgberQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781966237; c=relaxed/simple;
	bh=3LnB2KEMsWTwILNjzOPYbu/QSICMjx+q5S3tQtePcpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYIPMfqMr1yKSx7TlfYtvFNyZ5WKX2XD/tPo5gO3CWP0lP76bVFNykFgb6e/1jB9sdKpBQ+J8inNPsqwLLKxS17q3EV/DYsOKHeGSvGgP13QRXcGlXLKBwqAR0V5zuo+5rxy6Qcf5kIq9xVUay5JIbKsRGSp+X+9DVTHL6dTUmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=E0m8vB7i; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="E0m8vB7i"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5177945a22eso20652271cf.1
        for <stable@vger.kernel.org>; Sat, 20 Jun 2026 07:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1781966234; x=1782571034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JZrVAzbLCWnlT/KunNGolgjG4pmV/JlH45+vzJSkxkg=;
        b=E0m8vB7iGtLAjtl66ovcC0dKnCaTLqOTSeSvpXZtqg1cQx6J4xA0Umz/GjNPnMa0f+
         /S6A2PFFjIp5LwW/nzaOJ155NYAw5gfnt0woVTVnKxB7TfjEwjBRu3GNlXtKrnhVXtJ4
         3wwjQkrPQQ9Sh2RNtv4OUPR43JrqqaziEkXVjXjuz8/d4sNMo4HEfHySjPhS6KqIec+o
         iRxCDwgg+BIY6c9KvEn/HmZ9sFLHGzaw2ZR+3zP9pOAVeBE0/dOEJs1EmojyirPqHJX2
         BwlfkQ3iTycBu4YTuFCD6nPlC/fSLlNOHXhkpbXfgQirsCceouvOYvmUrU/lqzFjUKvo
         /6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781966234; x=1782571034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZrVAzbLCWnlT/KunNGolgjG4pmV/JlH45+vzJSkxkg=;
        b=f8IiSeCpNr8vlsLH9oOvDwZhu6EN6csTffythLhUiqpK4/7e+WdtLO7L7mhT2TuaGA
         P+PdTO2qnJaAmZFk/OGF3kZnHF+MtRysUsgBMYviK90N/0a/3E2UBP2OBzxDB8Hno7jw
         TJTHIPcMp79Vcn/Jh3zfL2g3ZxQ+E0AO5wNsyJQRws/t0Wxh1PthhCeIrayWpifNHXIw
         nk3MLWOD1P/IyYLLNbW29XZK/XPG8t1H30GZpsNmfpyOcgzHVSpwh8C+Qj+3sitfvipt
         RP3HjIJHAiWdOXKQ9wpUg2BDg1HGjy39V1dYjiVsR/O6eDChzrJW8HOKYnJhAiVYgco4
         MV4w==
X-Forwarded-Encrypted: i=1; AFNElJ+cO3apYwnjzchDAazXgkw/S2OSbwo/+b7rUhG0zVWroCyytIxQoEsb4PhLe5IadT47LKYde6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+JjoaeCuEVVYD0SxLM+GCAMRqYLT+BBXh1Mw9lRLFyto7NL+J
	jcTUPw1dstDsMw0m5LcLxqqw/GJ2fqKz0CSMUsZ8TUSzhqYcyUrNx+f46iqcQgOA8A==
X-Gm-Gg: AfdE7ckCZuwMMbB2+u8bW7/sKJR96QjG9WJNGodVfXQzTj4orYoQOVRbNmN+t+e9vVp
	dI4FziQE7Y0S92Tsr5eNlLFtQfHq+crABDxxS61qcAyNRTLgdKdFHNZ7hXlWpohfeDl7dZ/YKzj
	SK+meHSrdHyqe3elViyaIeE+MohuQSTX7fva9AijYHqJx63/HtCGoFbNzORgjKdyhCqtzXgHLP9
	CEsUH3fUdZfqgmUOQ+6Pk2LAcNTxd9svrYEXSOJImjwhhlwM/ouNCnzti4lXKb6PqtKSxFhB8iA
	j/vx8EedCw3xoZ/Xd6jFUuZs9zFwoK4W+9ttWZ0NzQcVEMMF9dJs4JWvy20w6qls8s5Gej1vCCe
	0cBFY37rEKhJSQcB2OdO7KgWfNnMfCtgxtTkaVDMrcMA48Zplh2BdmCNQsW0DNk76ZUQMHlDKq6
	4RPaX38uc7PnRytrpTufY1p6gC3/uYoVQ5
X-Received: by 2002:a05:622a:957:20b0:51a:35d:ab59 with SMTP id d75a77b69052e-51a035dac3amr52318961cf.39.1781966233460;
        Sat, 20 Jun 2026 07:37:13 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210:d62f:1911:f952:16ba])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a09202f35sm22205601cf.8.2026.06.20.07.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 07:37:12 -0700 (PDT)
Date: Sat, 20 Jun 2026 10:37:09 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Nikhil Solanke <nikhilsolanke5@gmail.com>
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, michal.pecio@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] usbcore: Add quirk for 255-bytes initial config read
Message-ID: <8da4a00f-a01c-4b38-82a3-a718e5588f51@rowland.harvard.edu>
References: <20260619095936.24080-1-nikhilsolanke5@gmail.com>
 <8175e40d-357a-4513-b827-752f679e9904@rowland.harvard.edu>
 <CAFgddhKKuGQgu0Ahu_WRyZocQGwPZkUejjoaJQ+P8--+k=Lwkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgddhKKuGQgu0Ahu_WRyZocQGwPZkUejjoaJQ+P8--+k=Lwkg@mail.gmail.com>

On Sat, Jun 20, 2026 at 12:38:00PM +0530, Nikhil Solanke wrote:
> > > @@ -946,7 +949,7 @@ int usb_get_configuration(struct usb_device *dev)
> > >               /* We grab just the first descriptor so we know how long
> > >                * the whole configuration is */
> >
> > This comment is now out of date.  It should be rewritten to explain why
> > the quirk does and why.
> 
> I will explain the quirk above where the variable is defined and reference
> it here. A reader would probably question about the quirk there.

Okay, so long as you don't keep a comment that is now incorrect.

> > > @@ -957,26 +960,39 @@ int usb_get_configuration(struct usb_device *dev)
> > >                       break;
> > >               } else if (result < 4) {
> > >                       dev_err(ddev, "config index %d descriptor too short "
> > > -                         "(expected %i, got %i)\n", cfgno,
> > > -                         USB_DT_CONFIG_SIZE, result);
> > > +                         "(expected %zu, got %i)\n", cfgno,
> >
> > Likewise, "expected" here is wrong.  It should be "asked for" or
> > something like that.
> 
> For this branch tho, we are expecting atleast 9 bytes. if we don't get
> those we simply bail out. expected is the right word here. But this was the
> originial implementation. With the introduction of the quirk, the wording
> of it does fall apart. Instead of adding more branches just to rename a log
> message, let's just keep it as "expected"? In a similar branch later on,
> when we ask for the bigbuffer, it does make sense to use "asked for" like
> you suggested. I will make the change there.

Again, I don't care too much about the exact wording; I just want to 
make sure that the log message isn't actually wrong.  Saying "expected 
255" would definitely be wrong, but saying "expected at least 9" would 
be okay.

> > > +                         usb_dt_config_size, result);
> > >                       result = -EINVAL;
> > >                       goto err;
> > >               }
> > > -             length = max_t(int, le16_to_cpu(desc->wTotalLength),
> > > -                 USB_DT_CONFIG_SIZE);
> > > +             /* If the device does returns the full length configuration
> > > +              * descriptor, skip the second read. Fallback to default
> > > +              * behavior otherwise.
> > > +              */
> >
> > New multiline comments (or ones that are rewritten) should use the same
> > format as the rest of the USB stack:
> >
> >         /*
> >          * Blah, blah, blah
> >          * Blah, blah, blah
> >          */
> >
> 
> Alright. About the comments formatting, all other comments were not
> following a consistent format in the same file. so I didn't bother to fix
> such small style changes. But I will still fix them in the way you (and
> kernel code style guidelines) say.

Yeah, don't bother to fix up comments that the patch doesn't otherwise 
touch -- that would be mere pointless churn and would make reviewing the 
patch more difficult for no good reason.  But comments that you _do_ 
alter are fair game for reformatting.

> > Whether the quirk flag is set doesn't matter.  All you care about is
> > whether the information received earlier contains the entire descriptor
> > set.  The first and third tests here should be removed.
> >
> > There is some question about what to do if wTotalLength < result.  My
> > advice is to use the smaller value in this case, but not smaller than
> > USB_DT_CONFIG_SIZE.
> 
> In the case where wTotalLength < result, wouldn't it be better to consider
> the result value as the truth? Or are there scenarios where the device or
> the buffer will contain gibberish just to fill it, which is why you
> suggested a smaller value.

Sort of.  Software that parses the descriptors later on will ignore the 
extra stuff in any case, limiting itself to just the first wTotalLength 
bytes.  So there's not really any need to keep the excess.

>  I did understand the part that it should be
> atleast USB_DT_CONFIG_SIZE because its the header, but isn't that part
> already handled above with result < 4? It does ensure all the critical
> fields are actually present.

The critical fields are not just the first 4 bytes, but the first 9 
bytes.  If you want, you can change that test against 4 above, making it 
against USB_DT_CONFIG_SIZE.  The reason the existing code only tests 
against 4 is because it knows that it will issue another request for the 
full length, but that won't always be true after your changes.

>  And with just the second test, the code will
> naturally jump to the else branch for any cases like you mentioned. I will
> change the max_t back to use USB_DT_CONFIG_SIZE and everything seems to be
> covered now? Also looking at the 3rd test now, it is actually redundant.
> Thanks for pointing that out.
> 
> 
> > >
> > > -             /* Now that we know the length, get the whole thing */
> > > -             bigbuffer = kmalloc(length, GFP_KERNEL);
> > > -             if (!bigbuffer) {
> > > -                     result = -ENOMEM;
> > > -                     goto err;
> > > -             }
> > > +                     bigbuffer = (unsigned char *) desc;
> > > +                     desc = NULL;
> > > +                     length = result;
> >
> > Don't keep the entire 255-byte buffer.  Use krealloc() to shrink the
> > buffer down to the right size.
> 
> I did intially though of using krealloc(), but when looked at existing
> implementation, bigbuffer is alloced with wTotalLength while ensuring its
> atleast USB_DT_CONFIG_SIZE (9) bytes. Then when we receive the result, the
> bigbuffer isn't realloced as per the size we received. So I tried to mirror
> this exising behavior in fear that I might mess up something else while
> trying to be smart. (Although yea, it is waste of memory).

You're right that the existing code could have reallocated the buffer if 
it received less than it asked for.  I believe it doesn't bother to do 
this because that possibility is considered to be very unlikely.

In fact, you could arrange to do the check and reallocation after the 
two code paths merge back together.  That would be the best solution.

> > Again, I don't like this name.  It's not a quirk in the size of the
> > configuration descriptor type, which is what "USB_DT_CONFIG_SIZE" stands
> > for; it's a quirk in the way the kernel asks for config descriptors.
> > (Or in what size request the device will accept, if you prefer.)
> >
> > And the 255 value doesn't belong in this header file anyway.  It should
> > be defined in config.c since that's the only place it gets used.
> 
> So what about USB_CONFIG_REQ_SIZE? it's what you had suggested before in
> earlier conversations (without the QUIRK word in between naming our magic
> number 255).

Yes, that seems like a better choice for the name.  Or maybe 
USB_CONFIG_BIG_REQ_SIZE or USB_CONFIG_WINDOWS_REQ_SIZE, to indicate this 
isn't the value we normally use but copies the behavior of Windows.

Alan Stern
