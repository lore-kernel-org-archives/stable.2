Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9E14252C8
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 12:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783600603; cv=none; b=iePxDYvOxhE8bxgbcFz6MB0GoC94w6+BZKsAo+FlIbGnWId+qz7LX0r4dtVk87zq/wvbpksiAApUQfPd1guoB0Y8zva2HzC209elcQvFT7rm9dJGxHyy/CGnZNqKilM/FAm9X7Rp8qPJLfGfQrg7L0DO6yRUFt5ZXtYw1+cx01A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783600603; c=relaxed/simple;
	bh=CdLOGrLsX4K4SEZ10SMqCGElMKDoLo6fIagv31h55LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=inRSOJX06BoBYrhmWqzxKg3+KTrAxZOzv2WuEgdPjdIGX3hyziiLWBfeYmIT4T2skfj+ici55cxE1aL0xDJU1QiuICAoi5hX8jR81byqcSWLHtvjnxa3I6Kc+TiMLUp4hbaMGOzv5D6BjGq+uS+16Vy32Skq0z9UPYvg+qYZmtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RVD3DWoY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fgg3s5D9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RVD3DWoY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fgg3s5D9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783600600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KavkeeVI7BmP8QSeokBd+WQVOIUMBshHyo5uj4Thjyw=;
	b=RVD3DWoY8zUsbfY2YHfZ/sw/kvYlfmNgaCJPPLND/73QGPxvwiUopMBr/O/wBDKTyZ5fvJ
	W0ROZOPXEdEFczeZKDEJrcOgLwLZQ1nmMkoLMKUEhUZsAYeLQ26C9wFdJJ7ixTPgdGwfsF
	RE+I4hQNfMD4yT3sa6qiFO13mUuNQOc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-fAxGPTvMO-e1lMqSl4U45Q-1; Thu, 09 Jul 2026 08:36:39 -0400
X-MC-Unique: fAxGPTvMO-e1lMqSl4U45Q-1
X-Mimecast-MFC-AGG-ID: fAxGPTvMO-e1lMqSl4U45Q_1783600596
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47345535410so761716f8f.1
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 05:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783600596; x=1784205396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KavkeeVI7BmP8QSeokBd+WQVOIUMBshHyo5uj4Thjyw=;
        b=fgg3s5D957zD8AHoeXv264kTnVOdE0WBXNaxMgh1ftvGLQLU+GBvXB9Gl2XhhWDsIY
         FcHyQMy8BJRk9DLU7qbTvFNb0Xw0rTD/u0eC46EgiAgQz9ItBBQwJ73N/DpXs2TYolDc
         baarJiwdHWluZzThNP4TtUmx444SDqN62Hem/trddGR8M29bvJoDNOPhK8qPiVEzpcS5
         kGxObrAghuoKmNq9VobvbJos/T81V1oHWR27qY93hGn55WsbTq430YGH1RiXXqF+mZ0s
         yjPV6X1rHV+tUqW0fxFblG85aqhwbqTZ1WBr+rnRzbHfZKDEEv9fGzN9UbYBzLr7D0B9
         BJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783600596; x=1784205396;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KavkeeVI7BmP8QSeokBd+WQVOIUMBshHyo5uj4Thjyw=;
        b=mqwVftgjSaJTVYrFg8aotph0mJIPtJE53/gHr602ddfcR3UaNF8hFgFZjw+QNNBbVd
         Rb8omrV4+VJ4S8H7clRW0lLz1mbl2OvatZSARo28em+kyB8jn5gNuaCIe8tD1vwMltqH
         VeTuOOm0vD/IE1ywWuBy/1NFcMRH2YfmRNGLnRA4FgoZvE0FWHZbWePk58M1ukuVM2jJ
         PqPwTsAZKmkrhC3NS5QCkmWfEPfV+K5OTbb5axgpCs7eN5AEdMAa1K9NOpKk3L0xn4PN
         lXtGGVI6yRGvH3r1MNQVgVllilL/gzFuuokKdnXLlUQi7X/HHPLxRw5hUsfSX2PmO9Vn
         E81Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq9K4xPgJLAkxMPBXYmdmTw4IvCwnEsFTBVF8wonFyv0YrY4vnDfQTpeUrCjNpP+Di1V2ITZhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtLHqNjGhYsArAv7s51G5uEIXNB1XElpmffXO64o3MH7chbUnu
	cjc1wHj5XKD+Jmo3xTxUc3r0TUdTE2d2chTkKnEm2shMRuMHvPNarli7qrmLH32Dya870yA1HZa
	0aW6zUw7dxGZJDPvtTZ98IyzSBR1Pg4MrHX+RVdOz5vdoofLYkd2oSaqZKA==
X-Gm-Gg: AfdE7cn3OADH5wjSdkeOz2eSZiCJ4w5bgyI2yrDwxhiuyA21JdkrjQNPVIlgFyXBD9y
	qO9vQRRn/5dyJse0YfSlOrIeB6T53KPemV5W6AwGrNzPfdWrBjU1v1utULnC1ceX7+7XbwPM2/z
	9hN28YlfuSjGDmCOTKYdpPx+YHky8UDBKRh8kcvcfpThYVAWfpFKl+GtKeHzVsVrV0Amyhd+7ZH
	F7mcXlUwodvJFnppTRapnVnpBJFd6/3QLPtSSz3W049Be9mDcfziW2vBXo4zVUzBqjQX/NLbGnT
	+1OrexWJHVTctvSyoO8EA5rU63AdBfdF6FxIlPiiNMFLK8PkVDN30eNIiwYr45NPoU4dcGqxKS0
	fytKPYdGNEqaQnLNB4wBQJd15VhTRO0Eg
X-Received: by 2002:a5d:584c:0:b0:472:ec66:274a with SMTP id ffacd0b85a97d-47df074e24amr7671047f8f.7.1783600596095;
        Thu, 09 Jul 2026 05:36:36 -0700 (PDT)
X-Received: by 2002:a5d:584c:0:b0:472:ec66:274a with SMTP id ffacd0b85a97d-47df074e24amr7670997f8f.7.1783600595551;
        Thu, 09 Jul 2026 05:36:35 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a558easm51266922f8f.27.2026.07.09.05.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 05:36:35 -0700 (PDT)
Date: Thu, 9 Jul 2026 08:36:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Carpenter <error27@gmail.com>
Cc: Haoxiang Li <haoxiang_li2024@163.com>, marcel@holtmann.org,
	luiz.dentz@gmail.com, yangyingliang@huawei.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] Bluetooth: virtio: Fix virtbt_probe() init and cleanup
Message-ID: <20260709083606-mutt-send-email-mst@kernel.org>
References: <20260709114745.4030794-1-haoxiang_li2024@163.com>
 <ak-T4SMxr4rw10jP@stanley.mountain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak-T4SMxr4rw10jP@stanley.mountain>

On Thu, Jul 09, 2026 at 03:28:17PM +0300, Dan Carpenter wrote:
> On Thu, Jul 09, 2026 at 07:47:45PM +0800, Haoxiang Li wrote:
> > virtbt_probe() allocates vbt before setting up the virtqueues, but some
> > failure paths return without freeing it.
> > 
> > The probe path also registers the HCI device before the virtio transport
> > is opened. Since hci_register_dev() makes the HCI device visible and queues
> > power_on work, move it after virtio_device_ready() and virtbt_open_vdev()
> > so the transport is ready before the HCI core can use it.
> > 
> > On failures after DRIVER_OK, reset and close the virtio device before
> > deleting the virtqueues and freeing vbt. This also cancels pending rx work
> > before vbt is freed.
> > 
> > Fixes: afd2daa26c7a ("Bluetooth: Add support for virtio transport driver")
> > Fixes: dc65b4b0f90a ("Bluetooth: virtio_bt: fix device removal")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> > ---
> > Changes in v2:
> >  - Rework virtbt_probe() error paths into an unwind ladder.
> >  - Free vbt on probe failures.
> >  - Reset the virtio device and unregister the HCI device before freeing it
> >    when virtbt_open_vdev() fails.
> >  - Close the virtio device before unregistering the HCI device in remove().
> > 
> >    Thanks Dan for the suggestions. The blog is very helpful.
> > 
> > Changes in v3:
> >  - Remove virtio_reset_device() from the virtbt_open_vdev() failure path.
> > 
> > Changes in v4:
> >  - Move hci_register_dev() after virtio_device_ready() and virtbt_open_vdev().
> >  - Reset and close the virtio device on probe failures after DRIVER_OK. Thanks, Luiz!
> 
> These are Sashiko warnings.  To be honest, I would feel really
> uncomfortable blindly applying them without testing.  If someone
> can test, then great.  Otherwise, I would probably apply v3.  The
> stuff that Sashiko complained about was all pre-existing issues
> even though for the last one it said it wasn't but it was.
> 
> regards,
> dan carpenter

why make changes at all if no one can test. in fact, why have a driver
then.

-- 
MST

