Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E507C3346A6
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410610; cv=none; b=WE6/q367xsrHNuT5QCDIWGvPfkn8btNbuxqf24Nvr+bDnTmxG1N5YhZ9Zzm6DI/ShoW29RLvj2CtlTiO8wxJ8WVctmxg+jRSt9Vxqn29xdLi1WaN5yELNV+mZ9VXXgdG/1Ljj4efBbEP/hJnmnB0wMDW/iQjrONZ7cgqEwiHII8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410610; c=relaxed/simple;
	bh=6Cl/HUdwjBu7h+DF9NMHuCalt7QXfzGmzPgeIn7To6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdeB5L9O4uFxxsRgYm9r1rMCHmjvvI2K7pcjYwoNLWEMIKdfmzugYOTHBWJhO4jMAMg2BPMitazpVCtylpOlkcguPvP141TLG7FpispWDoDyKmaE2CvquiYWTTib3iyODJb7AGWmcq4SA4Mf9BRcRBANmn4awGYkXZrhAzwSzu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=E7T2pZui; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="E7T2pZui"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8ce9df31130so39044976d6.1
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 07:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1780410608; x=1781015408; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LHe8y8YQdchVIYSL7xdgz4Vu/wRZj0mJWgDbRik2L/Q=;
        b=E7T2pZuidHpmH/VFUtoulmVOMBsMfsisDLakjzaP4CXKAXYWvAT+Da3KZ66aK9jGHx
         wzyppECVgdhRiG+ZJUME/q9skFx2va+WuhEm+hHiYVW8OleAx1VFk/ZS7XPBQEZ59/jH
         1XQmH4JkWOAgfddDfIfJwSqvaMlszeV+weerd5h1419B7bBIROHkmEHIMhNr1hMSFyRj
         82dDtz3zGHHJ13GHnTUhHapXKODsy1zTUAGCuftES3k49xRFd0PTKfORpNzruzXbi1fQ
         fH7/67+A/92bVxN2XeLXnbP12fb+dy2y7u+7gXBJDKc0Grn6U8VECuEC/qx0xF6vadkU
         lKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410608; x=1781015408;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LHe8y8YQdchVIYSL7xdgz4Vu/wRZj0mJWgDbRik2L/Q=;
        b=DUXYQRM9Polx2+P5AYX+Iikg3OADp16ndl+gLupxP8EltvSq6iERRTppKySTaOmuoE
         mPCFP0esWbd87XR7ppQKFmampWmsWz/ZOD/ce1WSPNfbIoJLRVHl0sJkR6UQ9iOE59c8
         98+dk8/asYrQcjj2gA4unBKhOCy+l/I7CVKvL9HA3bTL+6hRHWHhJWD28Is7LlvtPVoK
         8iykyR657D8BQhwuP0W1zZrVqAuFRu8eacinaqqrtvBmImYk8Sc1Vu0k9eTDNSqGvxqp
         Iu4CdRGCPk4jljMo0sUyBJHrCMpF3cXeglCJHsf/wUgCa3i6tjhL/JZ3xrnvwbIw2z6M
         4rAA==
X-Forwarded-Encrypted: i=1; AFNElJ+9pKWMhb7YrTwC/6L27EcTNXTN6GDOi1hInZJs4dPrd9CDVabQHgcEy7B4q1rKcZEiyZHVcCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxezsJrd9/tswmZR1dfubBPmnitdUtC1aqB08vq3QSRlMjoFxf
	//Z/t67C5wBtkTY2hTjddFfUVyX/MXeqvlPVM/tIs+6k/6WHOubdpjKSZk8GFuo8xA==
X-Gm-Gg: Acq92OHTTmT9sQKDWogFHo1MOPQSsXuk23i/12KBphoogya3AS2yBfeFxs6A88qRdAL
	lJR1fNRWTmj+XRzfZhgeSRmzuGRhVPIuePNmEgaIIjfCuS1wGpbHxvmw4G6VxrStKZ6fDvG37ZL
	t64BWdhfFKzAK+w3kIvJ9qheTC5BFIZsqUOoVHwqMAISJuUGqFsc1c7GNaX9jXUQPIAfy6iFT1K
	Pp4BPjqkh2zp078LYiaqhQmnih8/sjkncTiGOn+o8nuRtPeQOizU6PRHbUMncOJt/35ptNSsWsW
	/MaSe3gz0WIZW/jlfA+0kDzZCMA1bTgt22blA6fCcR0b7xDTQy8Br5UPM2CzAF3PoXOhIxbr+l6
	yWg0C73vEfi4hzSmfg55d1asaSU/CAfGNuFI8nEfRo8OidoM0r+QyT7TmRMTY2pHCJ2Kwe0Kluj
	niK5MVc4HMZtI6iRm8ri+LSVuHQ/LJnoekXh3mh80koBhsIrNvtsBz+w==
X-Received: by 2002:a05:6214:5343:b0:8c9:cb98:5fb1 with SMTP id 6a1803df08f44-8ccefd4ce75mr252266376d6.12.1780410607839;
        Tue, 02 Jun 2026 07:30:07 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210:d62f:1911:f952:16ba])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea23e115sm120741666d6.42.2026.06.02.07.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:30:07 -0700 (PDT)
Date: Tue, 2 Jun 2026 10:30:05 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: "Jimmy Hu (xWF)" <hhhuuu@xwf.google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: udc: Fix NULL pointer dereference in
 gadget_match_driver
Message-ID: <d0042def-a513-479f-9742-12942346cd5a@rowland.harvard.edu>
References: <20260526070635.839701-1-hhhuuu@google.com>
 <1f7a7bf2-4d21-4944-9da0-36082d052b25@rowland.harvard.edu>
 <CAJh=zjLLrY-NpV-ZcmH0V6q8CjNuKt7CmW-GEFQ8_y3zm9v1yw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJh=zjLLrY-NpV-ZcmH0V6q8CjNuKt7CmW-GEFQ8_y3zm9v1yw@mail.gmail.com>

On Tue, Jun 02, 2026 at 01:34:07PM +0800, Jimmy Hu (xWF) wrote:
> On Wed, May 27, 2026 at 2:00 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Tue, May 26, 2026 at 03:06:35PM +0800, Jimmy Hu wrote:
> > > A NULL pointer dereference occurs in gadget_match_driver() because a
> > > race condition exists between the DRD mode-switch work and the
> > > configfs UDC write path:
> > >
> > > 1. The DRD mode-switch work invokes __dwc3_set_mode(), which calls
> > >    dwc3_gadget_exit() and subsequently frees the UDC device name via
> > >    device_unregister(&udc->dev).
> > > 2. The configfs UDC write path invokes gadget_dev_desc_UDC_store(),
> > >    which calls usb_gadget_register_driver() and subsequently
> > >    compares the UDC device name via gadget_match_driver().
> > >
> > > If gadget_match_driver() runs concurrently during UDC unregistration, it
> > > may access the freed UDC device name. Once the freed memory is zeroed,
> > > dev_name(&udc->dev) returns NULL, causing a panic in strcmp().
> >
> > I don't see how this can happen.  gadget_match_driver() runs during
> > probing of a gadget, which takes place only while the gadget is
> > registered in the device core.  But usb_del_gadget() calls
> > device_del(&gadget->dev) before it calls device_unregister(&udc->dev).
> > This means that at any time when gadget_match_driver() can run, the UDC
> > device name must still be allocated.
> >
> > You should run more tests.  Add debugging printk() calls just before and
> > just after the device_del(&gadget->dev) and device_unregister(&udc->dev)
> > lines, and inside gadget_match_driver(), so the tests will show
> > unambiguously when these things happen with respect to each other.
> >
> > > Fix this by checking dev_name(&udc->dev) before calling strcmp().
> >
> > Adding a check like this will not fix a race; it will only make the race
> > less likely to occur.  It won't prevent the name from being deallocated
> > between the check and the strcmp() call.
> >
> > Alan Stern
> 
> Hi Alan,
> 
> Thank you for the review. You are absolutely right about the TOCTOU risk;
> the simple NULL check does not prevent the name from being deallocated
> after the check but before the strcmp() call.
> 
> I will submit a v2 patch that uses get_device(&udc->dev) and put_device()
> to increment the UDC reference count during the matching phase. This will
> guarantee that the UDC device name remains allocated and valid throughout
> the entire duration of strcmp(), eliminating the race condition structurally.
> 
> Does this approach sound reasonable to you?

No, because you haven't addressed the issue I raised at the start of my 
email, namely, how can this problem actually occur?  And you didn't run 
additional tests with the extra debugging information that I asked for.

Alan Stern
