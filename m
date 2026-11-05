Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793852934;
	b=XAqPh5k7lylajD++7gGWQtUy+WaVduN8op8BM1oTXZnJl4/DrHUci2yQeHeRegHsxX3r
	 hIcrYT49JLzZnPQBbklxjnppo64MAaE7y4YxoYBMq/j/5QTsE2gZMoWRgt/F+MU8SCnmn
	 RyAZCYcsjWEz9Fka8zaf3xuM2g2kcPNhQvoVGWOV1q0vEY42vv39SU+HYB6brv3uMuHXf
	 3h3hPo4ollaPCcYPuF6CNo93nSlV/4BEPp8J9Ovz1fWSoSvnzx4Cqb0t27HE22amOBdXw
	 tUg1LIerzAurXJGzpiObF/OzYS9aZq2ptDpvqtIbecoAIwoenWQGd3WdpPjLapKMnUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793852934;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=KEm42QihUL6odJc0vgDavSCwsWRiCbS6wHuc5+HRkrA=;
	b=cYw8bOCQLD2Pt0wbnucm7RkRcG9PIbXy+LdG+3lxoatJZ9FJR+meIJl7TPpzFLrHqEPh
	 IKQHeclYgG3HK1mmnb1RjSdd/AgscfdOMLEmXrh82jTqMIgWs7ke0e84TT37KTEMCYOPu
	 Dcas4D9Zi1van2MyMpv4joPv8IFo1/TOcVkR4PnL6LJsOLTl2oPKJFqv9Gr7t5BBc7b3l
	 bZbJR1eXxQtxvsQR6dig/ocb8YKsVZwzIC/L3tJ54ZAWG8GwSHGLukWyX6zJGvVlKcliV
	 IDf6AZlbuwCEXXmuLauPgOlpgxi4KBaJJjlTx0Pbh9IcPjmgB9Ojo5+3TzkmG5N5/Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=Pz8epZir;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AC8606A329
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 04:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9AC8606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=Pz8epZir
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-533861a59b8so14333461cf.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 20:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1793852933; x=1794457733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KEm42QihUL6odJc0vgDavSCwsWRiCbS6wHuc5+HRkrA=;
        b=Pz8epZirP16nHrgC4NO3PtdE3tUSEr3wJ+iQYqzaekJJRox81tcwLnWeIbBdoJMsvU
         uvgXwQF5elg9BvTN6nZS3BJ5NvVeNpCkEZHrA+i7J9fDvWGr3EN5ttyWtefaDG4Q/6nn
         I46sb4z0BLAyOZdtWa+LKOXoaQJNAvFaemIe9+Z9HALKuCgoTtMkrIIez2l/2sHwOQmG
         RrVrbh3rzYmaTo0NjYPEcbp5eDJM2cknb2pJhClM1wA32YSQxQ26JB2IEFMVDcVTvX3n
         7virYrZ03byn73qeFxsEGsKhTU26y450YpB8T0hRjsUlCjjfI/9os3AXNPTT8YmnFrlu
         p4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793852933; x=1794457733;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KEm42QihUL6odJc0vgDavSCwsWRiCbS6wHuc5+HRkrA=;
        b=tbbxE5FD67E5LLhyQInF32c7ihvRpGGXI9nzmEsASRSZiTOlQa6nChZJbFVaQfHwvs
         KOwayuY8h83654jrqkXAfDDjnjU/1Ptx5b8JDwwn5PTsrAK2iOWs8OOQoO8a9yDThuqp
         StferGiDRdNubjqemaIn7V9RGGtAdYhgr2fG+7J9+rwwK9dOFtNyF/7ieas7OJmd8Rwb
         E0yUoQsjlBEnux6+xdCtGHW1jQtioKIFk9DVNurx3CVpN6okpIowfLNhUf0HiK8tDnLM
         Nm5OdhE3YgT7ZDpikrbZTVYcCqDsEkbzZjW5olD9D06JSHDD5UOS59o1ioC1xO6mZ09P
         BQDA==
X-Forwarded-Encrypted: i=1; AKwUvBzuV68Mudeq+y+ElpOx1pmO5zn3lO/BdXAoQxzRBtkW/tm0U35TaZ8I1VL0LHaTE4hGKHlMw5E=@vger.kernel.org
X-Gm-Message-State: APuU4Z9OMHGPAUiljL06jXtj4Jx2SnrlY7/OaUJuojFwbO27WiGlXQHJ
	RkM4oWV8lVsfF77I+1LfeDlHVG6Xq4b9C5tucnnCklvOykE18VHPMrVNKvD1PF+3Dg==
X-Gm-Gg: AYBFou3D44M8nsY2gb0/lslpuG2MWRQo1+FN2caywK555GzKRDSnBHAgEmQsKaYwow0
	FRyTN9YE+Yn6gDZ2oZRz/jyzPFPIb5zMGSkDE9rhY80/2tFtpwIbqqeLVoEgniPuHJ9eqzr8reC
	NBQ14LD4FHvJBseL67tARgBuv6yNQcWu6VNFVeWG6l6n8Yg9wivhybFuPEj9k4n2jwH1hpX03Oq
	kOnXNVlRRcS4zQ6h4q/ZALBJ1fWuvn2HSxP431kmkBtTKfd8X7E/X9+Sy+NUgD3SAtdjYj5+QJR
	MM7s42C+3CNGhG+cTKOWheVhWhXXWONt2qaM/5JERnbDh0kk8Q0q8ZEoXJGoaPy4oEVYEIdO2+i
	OKhL8qROVG3e0/9rWD+p9xioHuPHGUzlM6FagoFAb1f2HW5Q3dzAKDmtoNXT87cVr1V88QqoLZ3
	OU2Bwm6csuquorOZ/TfFLA0q4EYuyxA//kC1wHAbH29JE8jYzteFhxDwHZYYmHFhXYolASJd2aA
	8Cy8mDy13CgMsmjXIEswFLqHsLyRQFBo3UCR+kUBcKtJWhyxVJyLDMazRxOI4ea8Z/ysU7zUMjZ
	MLaTEjKwUdqertWVTAUmuGXduSsB
X-Received: by 2002:a05:622a:514c:b0:53e:82eb:c111 with SMTP id d75a77b69052e-542b75248f7mr298071241cf.36.1793852932573;
        Wed, 04 Nov 2026 20:28:52 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::66b0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e9378dc70sm16474186d6.37.2026.11.04.20.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 20:28:51 -0800 (PST)
Date: Wed, 4 Nov 2026 23:28:48 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Cc: Michal Pecio <michal.pecio@gmail.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH v5] usb: xhci: Fix use-after-free race in
 xhci_stop_device()
Message-ID: <82a746b7-4e87-4d46-88c3-bb881f11b8de@rowland.harvard.edu>
References: <20261104000031.679944e7.michal.pecio@gmail.com>
 <20261104035637.3325-1-25031212351@stu.xidian.edu.cn>
 <20261104151544.26672-1-25031212351@stu.xidian.edu.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104151544.26672-1-25031212351@stu.xidian.edu.cn>

On Wed, Nov 04, 2026 at 11:15:44PM +0800, YuanZhe Liu wrote:
> Alan,
> 
> Thanks - that is a fair point, and I agree that the generic exposure is in
> the core: usbfs can drive port state on a hub whose driver is being
> unbound, and usb core does not serialize the two.
> 
> The awkward part is where the lock would go.  do_proc_control() releases
> usb_lock_device() around usbfs_start_wait_urb(), so the control request to
> the hub runs without the device lock, while usb_unbind_interface() ->
> hub_disconnect() holds it.  Making those two exclude each other on that
> mutex would mean holding it across a synchronous URB, which I do not think
> is acceptable.
> 
> Two shapes I can see on the core side:
> 
>  - refuse or queue hub class requests to a hub while its driver is being
>    unbound, or
>  - make usb_disconnect() of that hub's children wait for in-flight
>    port-state requests on that hub first.
> 
> I am happy to prototype either one; tell me which you would prefer.

I'm still not certain I fully understand what's going on here.  It 
sounds like one thread uses usbfs's do_proc_control() to send a 
Set-Port-Feature(suspend) request to a hub, presumably without claiming 
the hub interface.  At the same time, another thread tells usbfs to call 
usb_driver_release_interface() for the hub interface.  Is that right?  
If so, read on...

The issue here isn't a race, or locking, or a matter of a port's state.  
The real problem is that userspace can use usbfs to send a 
Set-Port-Feature request to the hub without claiming the hub interface.  
If usbfs had to claim the interface then the problem you encountered 
could not occur, right?

It looks like check_ctrlrecip() needs to be more careful.  A whole bunch 
of requesttype/request combinations -- basically, anything that isn't a 
GET-* -- should be forced to call checkintf(ps, 0) if the target device 
is a hub.  After all, we don't want userspace interfering with the 
operation of the hub driver.  This special hub-class handling should 
come directly before the code for the printer class.

Can you write a patch to do this?

> What is xhci-specific is that xhci_hub_control() is the only one of these
> paths that walks per-device state: xhci_stop_device() looks up
> xhci->devs[slot_id] and drops xhci->lock while sending the stop endpoint
> commands.  ehci/ohci/uhci only write port registers there, so the same
> interleaving does not give them a use-after-free.
> 
> So I would like to keep the xhci hunk as well, as memory-safety hardening
> for the case where the core does not catch it.  If you would rather see
> the core change first, I can send that separately and rebase this on top
> of it.

That's fine; I'm not concerned about the xhci-hcd portion.

Alan Stern
