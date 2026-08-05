Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2038F3DBD4E
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 06:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785913176; cv=none; b=AVnM1IUtISFxbyM0YgqNDmxIWNa7cTLmI6ZRrmImG8cuF+MFwHBAHRJga2lgU4RchNG7rh+yK3VgUdiexaLtZgz0uRYd8wB2+7gRTWoEm18ubDoGAwu29FcaOvGZlqCNcjRSOVFT+h/EZL0pEDhCsk5rekxRB8bDvWt50edyw7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785913176; c=relaxed/simple;
	bh=TgALdl+iEj9JSliTz8VrDMLm1WU+EhCs6+N4E75pEjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ab3zfxZOifcPjXRaIDQZLAeqV1GMaoMWEGGL389QRwtiz+ulHSu8s/18aVs6f3Rk6WHRwS0KUMVJqqM1aiEcGYeBly1AuGVoIYvQmidkIp1EbItEniWdigD+koQ4Gb6XrFstGPIF7kHJucdcfdvoHOhmbBZAbz/YbCHuVCV1Yv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NxWw8qEY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JeazDuot; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NxWw8qEY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JeazDuot"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785913174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lEhxxpwyE/rpJMtoGJj64x34mE0/II12LvK1GhW6WUk=;
	b=NxWw8qEY1lf5Nbb1/UsoWr2PpehXEUCuVUo6uB+zIAZjbiWenAJPv2ORwHNv2iuK5vn3V8
	/mCivdrh9Tr3okgu7zG09kDzp91kVjsOW33KKpdwG2kx76awoR7kShECBfMbd2OF/2b1XR
	n4lfR3hYiYVIlO9OUk70dAX9iKd8KIk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-m69-1YJrMv6DYgoTJeW0SA-1; Wed, 05 Aug 2026 02:59:32 -0400
X-MC-Unique: m69-1YJrMv6DYgoTJeW0SA-1
X-Mimecast-MFC-AGG-ID: m69-1YJrMv6DYgoTJeW0SA_1785913171
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47fe85684b9so487423f8f.3
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 23:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785913171; x=1786517971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lEhxxpwyE/rpJMtoGJj64x34mE0/II12LvK1GhW6WUk=;
        b=JeazDuotjyYx0NtfCm7GFKC/gOPshkzK7D6G/QY61xjPVdHICFA6dLuzIo6c87oBHI
         /Y3NVlmG6sReBENXXorPvkFWhWjx2lOt0j2lI/MUU9uTPy7Zi2emCnMHfmWQxNlI4xLi
         HOZXVlTXlywWUmCfGxq56mCY1gj5+2Q3XDN0ZGtV43pPoyopXoYtqJaTc/8cH8OVL7A5
         UI+Me1gsAT5lKMX7XGKHT9BGAn0sPHT14MFNDN42DRp8G2EsEbZTYkce2hUUf+sHCg9b
         9Skf/Ti2C0W9Hwi5+wOCZ9r/TWtDqpNWAuMvOcLqPEtY34Yjw54wCZDCDywbYYWmV10i
         n9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785913171; x=1786517971;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lEhxxpwyE/rpJMtoGJj64x34mE0/II12LvK1GhW6WUk=;
        b=B+WICfjKBWKMHp4wK0VWFBCKcuvHqVaQpvm/6ZFc4IvHBmWoe1w+7oxmqgo78hiboq
         lUH6OO5ADmg0sTC45E8XEc+foC4mAXYnamjqoCv4LOXTnRlcwJLc7+SPR5Qha4ZiUvyW
         ajhmh9008WQvdwqxKVf2l6Sj0O13xwlfdUqDEKKC86Wzd60396nUWJHKUM9KUKAB4nJh
         K3QB9BOFAQ9755NE7E5aTOGEmH0k1l6/YRd7Qv2PTL0jX/LD/ALcIgBFPX0gXJ4lrQsR
         0exOkvN27R1DW1U7qH/Q8cRMSZKtvyPdTggfmhcgxd+f2HGjbDil2enMV1rNPnP7AE/N
         V90Q==
X-Forwarded-Encrypted: i=1; AHgh+RpyDwpMSzrjas/+omTtBAXP7w55ESPUBLGxKMg0So1tvcR4j04LI/DKOqvwc65J5YlwrgdCMHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5dtARhmDXyLMuglO9lUVD1Xc+EUmU2kViRSYOFWCwgItmcf12
	1jDVZP7GE4+NUJQw2X6DHgOzM/CzM2a2BdMKQZ6fRBQdJ1ESX1zC6D+uJpJ8/NFr2dGonkSTqM9
	fD6pCyM4B8D2UXr4PeQFR1MhN+LBdCPhkRDOeWWBNQA3azNJ5yeDgGIIDkQ==
X-Gm-Gg: AR+sD13U3DcL9RHS40fH+Ins8TnCkzrnQLJxy4OYLwnRC99W+/5G7VJB2LcTK9S+9C0
	+Ee7+5idsBRI41rsoNI0GQE2GncsRzHiuxYfFS/W9Wq5J3mCRQFeFsyVscj0P/WvP2vEgRw2WbC
	WQ/Ykita4ejEJkZu9sZyg7HYKlhifa6FexeloBRx1097lao2/Id3ukD4KKexWwdbKdt98wC+3TU
	Gc2wj1j6Cp3rwahhT8g6JdzKrUebzgL9gu/Wi3bSS6ZoNAfdPnoRP5O++HYMfVkP4Y9uKS9xhSF
	eZJw/FprMT25Tj96oYSPCzn7+ujapa6tw1/jV7VQbF6wO6BbDTBQYkXQY0Ct6jQqLhp2JneJTBQ
	COvpfdpJK2LH4QvczKl0k/w==
X-Received: by 2002:a05:6000:4211:b0:47f:96e3:5309 with SMTP id ffacd0b85a97d-47fec50d87amr7251146f8f.9.1785913171408;
        Tue, 04 Aug 2026 23:59:31 -0700 (PDT)
X-Received: by 2002:a05:6000:4211:b0:47f:96e3:5309 with SMTP id ffacd0b85a97d-47fec50d87amr7251098f8f.9.1785913171014;
        Tue, 04 Aug 2026 23:59:31 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47febfe5d7csm6573640f8f.15.2026.08.04.23.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 23:59:30 -0700 (PDT)
Date: Wed, 5 Aug 2026 02:59:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xiong Weimin <xiongweimin@kylinos.cn>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jason Wang <jasowangio@gmail.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] virtio_pci: do not mutate caller irq_affinity.pre_vectors
Message-ID: <20260805025834-mutt-send-email-mst@kernel.org>
References: <20260805032934.1606700-1-xiongweimin@kylinos.cn>
 <20260805013203-mutt-send-email-mst@kernel.org>
 <178591242683.1657366.2004019380773321385@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178591242683.1657366.2004019380773321385@kylinos.cn>

On Wed, Aug 05, 2026 at 02:47:06PM +0800, Xiong Weimin wrote:
> On Wed, Aug 05, 2026 at 01:37:01AM -0400, Michael S. Tsirkin wrote:
> > "tmp" in what sense? if we can come up with a sensible name, just
> > "affinity" will do.
> >
> > We do not need a comment arguing with previous version of the code.
> >
> > just assign to desc, instead?
> 
> Thanks, will do. I will post a fresh [PATCH v2] as a new standalone
> mail (not threaded under this one) with:
> - a local "affinity" copy
> - that comment dropped
> - desc = &affinity, and keep passing desc
> 
> On the virtio_input thread you also asked whether this is real or
> theoretical for stable. For this virtio_pci patch: real when the caller
> passes irq_affinity and MSI-X policy falls back.
> 
> vp_find_vqs() retries EACH -> SHARED_SLOW -> SHARED. A failed
> vp_request_msix_vectors() currently does desc->pre_vectors++ in place,
> so a later successful attempt sees a polluted pre_vectors and gets the
> wrong affinity layout. That fallback path is unconditional in the
> driver.
> 
> I have not collected a userspace failure log yet. Please let me know if
> you still want Cc: stable on the v2.
> 
> Thanks,
> Xiong

do not cc stable on theoretical issue.

there is a bit of a language issue.

if the issue is real describe it:

"this was observed: ... "

if theoretical say so

-- 
MST

