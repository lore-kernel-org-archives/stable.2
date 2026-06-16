Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5331F378D72
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781620093; cv=none; b=SQy32xfZLpITWZgkSznRWR0TEoF747rEcP6+Pa38CBv8yo2cBjDE8D3B/UwkvjfiYpkJqsUl6NoI1fSdA7v9wzjXKJ4tODav7HqpryhQQneKIYoYczep95VqNbLR9vr2g3g+pvPalcsefNqHmIvpiJlGnRLm5Vy6yGOlVlM/KIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781620093; c=relaxed/simple;
	bh=yvUtyGChRITdacoZi2gl3Px5RNLwduZ1sP3kH8lYtxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2Y3XXeZO+tidQPkfvetUPX++i3upUAc1YuXtxtf0GEq5FCvecoR+WQ/V/eWpO2TFFY4/vjNnZly0tH3SrSiGob5aV6yiDrsa/b5EXoVrnI3kcsxCry4MEKNc+8wbWA1Jm7+//4r3EpDDfdNVDXEABbfu07ZyNJohi9b38tAlDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=ZtQ3S2lg; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="ZtQ3S2lg"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51790c0a692so54868121cf.2
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 07:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1781620091; x=1782224891; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QBzxltYFB5IlhH9MRB9F4u0mC5z3CJixmHvtZ6C+QV8=;
        b=ZtQ3S2lg+R58dMhjFI9tb2F5ZIzHQ5AqXdxiUnEdn+ZuLdneiX1VIpCVXa5Y92nszX
         3B+RjNPtaGJtdrt0ckIrM7mt7JqB4HuS5KkPnSGRa5bBkp6lDeEz8W5ELrRkdRMOtRGu
         YR/Y9lhRFyS76mYlzuXuE61PazZjbxxm9PVPGiny6mBgDXkkYbCe//xVHxWiR2ifJ+6n
         x+TSz8O/i6BcGDo/g476DcUb3ONCLO1JxkO+2hFR/DTfWYVZuiOSIGPHYg6p9cC6U8xz
         K7+gM6B5toYV+tJp6Qs6pChlcB4paEYtkxeBnwtzsdCL4p7zqs9K2WpZc3KRk6nCsgA4
         E6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781620091; x=1782224891;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QBzxltYFB5IlhH9MRB9F4u0mC5z3CJixmHvtZ6C+QV8=;
        b=rU64LfTX04i4K7c4/Z5ZqN1wvpyZuNVlI77e0IRCcbOpMxiY89AxQfu8hSVDKIO+Zv
         QSi5SAO8YkMYBqUFJDeIciDGqwkkZ7+846KZCSnFF4iaDb8DLnePjNUiK8SRg5N/3bYq
         FdUQ4H14Z9qoDAHTkjPaZS13nXLic3fFreVLOdSZHFAV3pidcq7xAiJlyu8nekLC1WsZ
         BzWqnnTIrY0jRJy9oVXO2ac4x+Y6j1NYzxOlkLVCwA4VzYpeGd+iBYCq5iTgzLNDJ3E2
         eZmKmjrb6gSqyrTquM0Ol9PSF9TZp4hIeHLVCTMPD3b40fA12vsU1l2SJbLuzOQd290P
         ZuXQ==
X-Forwarded-Encrypted: i=1; AFNElJ8bVEvgPHkKvKcJRQTR+4JmX53+8syXFXJhAS4t8wQwEa4H+wvNYGX9zru/XIPugAz6piB51qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKoqazB/KbWjJPi1/0FTKaeRneAd9/pXusisvoEweBEKNTROhv
	vYU+sgDfrFLf2Y6iP/Bf+R7oX2SQVCnLVWPk8I/CuLumHy4oBXQyt+gMlxWWtG7bOlLcrWxOAMT
	nU2Y=
X-Gm-Gg: Acq92OHD77qKPogDPySOEXjKXJxzmjX3OuOrjKqI97xa7HXJZ84dNLuDnxHFLvzm5bM
	7ksRib7Exl0hxR2AZh2xxbDa9WuenBHrPOI0nQR30X9h8FyBh+eDKl1VuLwI9u6RNHt8oyh5R9S
	+B7YHY+gAXYVmplPLfQVuJJQc58ILsNJO1n3h1MDHnmg811wvsDR0m4AvDC9WWNPulnwcQ5gP7Z
	ttFPaX0fBcQbJdNxWA+MLm48uT5n4g8wB2JjOSzoqvNCLgh1MgeQMzg3uUEcVrWKxJ1Aytq8S/+
	QxsSd418hu/OgqFKRK4BkW8l4MCE8gti6h5flCLELY+Jx1axFPmpwwE65C5hh/6Ns9RfWijaYc0
	ECQcl9iuRDi3A6sUhxStmiRqv6MKd4fbn/6kz8/K4Hln4t/1Ganve46TdDkgxUwVtkrn1qGuezg
	1Ao9STsigtqc7YEK9a+oKCVXTUqerrhzWt3fhJVi9Kweg=
X-Received: by 2002:a05:622a:2c8:b0:517:5ffc:4a11 with SMTP id d75a77b69052e-517fe4bc675mr269519021cf.36.1781620090787;
        Tue, 16 Jun 2026 07:28:10 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210:d62f:1911:f952:16ba])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51955b271fbsm107149761cf.22.2026.06.16.07.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 07:28:09 -0700 (PDT)
Date: Tue, 16 Jun 2026 10:28:06 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: "Jimmy Hu (xWF)" <hhhuuu@xwf.google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: udc: Fix NULL pointer dereference in
 gadget_match_driver
Message-ID: <adbaf493-fe24-489f-9ad5-87eacc7c187e@rowland.harvard.edu>
References: <20260526070635.839701-1-hhhuuu@google.com>
 <1f7a7bf2-4d21-4944-9da0-36082d052b25@rowland.harvard.edu>
 <CAJh=zjLLrY-NpV-ZcmH0V6q8CjNuKt7CmW-GEFQ8_y3zm9v1yw@mail.gmail.com>
 <d0042def-a513-479f-9742-12942346cd5a@rowland.harvard.edu>
 <CAJh=zjJqarEkrzajpdcUAZwOxisbdrwTPwX_jHWzuWZFSQ16SA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJh=zjJqarEkrzajpdcUAZwOxisbdrwTPwX_jHWzuWZFSQ16SA@mail.gmail.com>

On Tue, Jun 16, 2026 at 01:14:03PM +0800, Jimmy Hu (xWF) wrote:
> On Tue, Jun 2, 2026 at 10:30 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Tue, Jun 02, 2026 at 01:34:07PM +0800, Jimmy Hu (xWF) wrote:
> > > On Wed, May 27, 2026 at 2:00 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > >
> > > > On Tue, May 26, 2026 at 03:06:35PM +0800, Jimmy Hu wrote:
> > > > > A NULL pointer dereference occurs in gadget_match_driver() because a
> > > > > race condition exists between the DRD mode-switch work and the
> > > > > configfs UDC write path:
> > > > >
> > > > > 1. The DRD mode-switch work invokes __dwc3_set_mode(), which calls
> > > > >    dwc3_gadget_exit() and subsequently frees the UDC device name via
> > > > >    device_unregister(&udc->dev).
> > > > > 2. The configfs UDC write path invokes gadget_dev_desc_UDC_store(),
> > > > >    which calls usb_gadget_register_driver() and subsequently
> > > > >    compares the UDC device name via gadget_match_driver().
> > > > >
> > > > > If gadget_match_driver() runs concurrently during UDC unregistration, it
> > > > > may access the freed UDC device name. Once the freed memory is zeroed,
> > > > > dev_name(&udc->dev) returns NULL, causing a panic in strcmp().
> > > >
> > > > I don't see how this can happen.  gadget_match_driver() runs during
> > > > probing of a gadget, which takes place only while the gadget is
> > > > registered in the device core.  But usb_del_gadget() calls
> > > > device_del(&gadget->dev) before it calls device_unregister(&udc->dev).
> > > > This means that at any time when gadget_match_driver() can run, the UDC
> > > > device name must still be allocated.
> > > >
> > > > You should run more tests.  Add debugging printk() calls just before and
> > > > just after the device_del(&gadget->dev) and device_unregister(&udc->dev)
> > > > lines, and inside gadget_match_driver(), so the tests will show
> > > > unambiguously when these things happen with respect to each other.
> > > >
> > > > > Fix this by checking dev_name(&udc->dev) before calling strcmp().
> > > >
> > > > Adding a check like this will not fix a race; it will only make the race
> > > > less likely to occur.  It won't prevent the name from being deallocated
> > > > between the check and the strcmp() call.
> > > >
> > > > Alan Stern
> > >
> > > Hi Alan,
> > >
> > > Thank you for the review. You are absolutely right about the TOCTOU risk;
> > > the simple NULL check does not prevent the name from being deallocated
> > > after the check but before the strcmp() call.
> > >
> > > I will submit a v2 patch that uses get_device(&udc->dev) and put_device()
> > > to increment the UDC reference count during the matching phase. This will
> > > guarantee that the UDC device name remains allocated and valid throughout
> > > the entire duration of strcmp(), eliminating the race condition structurally.
> > >
> > > Does this approach sound reasonable to you?
> >
> > No, because you haven't addressed the issue I raised at the start of my
> > email, namely, how can this problem actually occur?  And you didn't run
> > additional tests with the extra debugging information that I asked for.
> >
> > Alan Stern
> 
> Hi Alan,
> 
> I have captured the KASAN log with the extra debugging information
> you requested, which shows how this race condition occurs.
> 
> The log shows that after gadget_match_driver() enters execution on
> one core, a parallel core can invoke usb_del_gadget() and complete
> both device_del(&gadget->dev) and device_unregister(&udc->dev)
> before strcmp() executes.
> 
> Here is the exact timeline from the dmesg output:
> 
> 1. At 268.595241, task 1374 (configfs path) enters
> gadget_match_driver() (on CPU6):
> [  268.595241][ T1374] [CPU6
> android.hardwar]:[JJ][core.c/gadget_match_driver/1568] Enter
> 
> 2. At 268.595250 (only 9 us later), DRD work invokes usb_del_gadget() (on CPU3):
> [  268.595250][  T102] [CPU3
> kworker/3:1]:[JJ][core.c/usb_del_gadget/1529] Before
> device_del(&gadget->dev);
> [  268.598129][  T102] [CPU3
> kworker/3:1]:[JJ][core.c/usb_del_gadget/1531] After
> device_del(&gadget->dev);
> [  268.598159][  T102] [CPU3
> kworker/3:1]:[JJ][core.c/usb_del_gadget/1534] Before
> device_unregister(&udc->dev);
> [  268.599405][  T102] [CPU3
> kworker/3:1]:[JJ][core.c/usb_del_gadget/1536] After
> device_unregister(&udc->dev);
> 
> 3. At 268.599427, task 1374 starts comparison, where it triggers a
> KASAN invalid-access. (Due to kernel preemption, the task was migrated
> to CPU7):
> [  268.599434][ T1374] BUG: KASAN: invalid-access in
> gadget_match_driver+0x150/0x1cc
> [  268.599448][ T1374] Read of size 8 at addr 66ffff801a49b880 by task
> android.hardwar/1374
> [  268.599454][ T1374] Pointer tag: [66], memory tag: [fe]
> [  268.599456][ T1374]
> [  268.599460][ T1374] CPU: 7 PID: 1374 Comm: android.hardwar Tainted:
> G S      W  O       6.1.124-android14-11-ga633402dff84-dirty #1

Now I see the problem.  I had thought that the gadget device would be 
locked while gadget_match_driver() runs, but it isn't.

> To resolve this object lifetime issue, I see two potential approaches:
> 
> 1. Protect the UDC device lifecycle during the comparison phase using
>    get_device(&udc->dev) and put_device() (as a lightweight fix).
> 2. Serialize the configfs match path and the unregister path using
>    a subsystem mutex.
> 
> I would highly appreciate your thoughts on which direction you prefer.
> Does this data address the scenario you raised?

The problem is to make sure that the udc structure (and its name) 
remains allocated during the match.  The best way to do this is to have 
the gadget take a reference to the udc when it is added, and have it 
drop the reference when the gadget is released.  Not take and drop a 
reference every time the comparison phase runs.

Unfortunately, this will require changing the way we handle releasing 
gadgets.  The gadget driver's own release routine could be stored as a 
pointer in the udc structure, and there would have to be a new 
usb_gadget_release() routine added to the core.  This routine would drop 
the reference to the udc and then call the gadget driver's release 
routine.

See how usb_initialize_gadget(), usb_add_gadget_udc(), 
usb_add_gadget_udc_release(), and usb_udc_nop_release() interact -- that 
whole arrangement would be affected.  But it wouldn't be a horribly 
complicated change.

Alan Stern
