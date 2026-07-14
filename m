Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CE247DF80
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 18:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784055180; cv=none; b=dg1dbAdM7SjB05Vi62Cn+23z7ffkBHNhaB7D26cYGUjcv6dR47pj26jrZ2ks5ufVGe8M2+8cL5FWgWjT3upsn/YRp/X2SAg0joKQUGqXHaQV7TnhN1pvikkmwsveLtgZTR+GZ7LMgiNQXNuy2v1IESRKpn99E14hgjdhomIYtuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784055180; c=relaxed/simple;
	bh=1xwTUh0XQqqeQexWpf4nYNoBpFIntTgU7ikkAM9WIvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2Da8C8LmkzE3263dfFjUkGKVOmfDNgyXToiMeCvqHCtdFj5ELcP0vlO3MnjV28jomyteK/68R96QstZBdoTeAL4oXOxsBQplz5oD7MgyDf6HbicNYzWbRmyT0XH1dULyoc6esc66g+lfWVkyqI+U2wFIxIb96qmXCYhIOIzux4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jr8vmDj+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dlOOdpNq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jr8vmDj+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dlOOdpNq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784055164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nIfwW/o8U7z/0oL+ZaQUBUaHVA8qfCLS7p9kgkBe1fQ=;
	b=Jr8vmDj+shCe3i11Pbg0V9yvgDERCYb2gOmKHz0hHFjix4LG2SvbkuZr6QBjvVbU6mkCS4
	EaZsG+AEmWsQAQjjAlUZx9radzDuDwfx0trPKpK3h9puycUiOoP9dEt8bNMXWPcyQLYTpo
	kw/KsYuP6KLjF5BVf2foCuzGF7sc/Ks=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-N0Fhe8KZPJe_VhIW0S5TIw-1; Tue, 14 Jul 2026 14:52:43 -0400
X-MC-Unique: N0Fhe8KZPJe_VhIW0S5TIw-1
X-Mimecast-MFC-AGG-ID: N0Fhe8KZPJe_VhIW0S5TIw_1784055162
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-472bdd6f529so2826585f8f.1
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 11:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784055162; x=1784659962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nIfwW/o8U7z/0oL+ZaQUBUaHVA8qfCLS7p9kgkBe1fQ=;
        b=dlOOdpNq4HKcX111TjfaRAlQv5lgzphm7aSghlnSZLOYTY3SB9kNvDWgyCpmn2//0+
         64oCBpIttXIm/BjlH+3r3XNxQ2ivtqOeg0lA6yE1riX1tt+V5v7gNUydNNV1+vtkVyvG
         FP2PFJ9lHGk62b71n90S0Xngqq6T1ATtmC/I9YfsdzAdel1CG5a6qHKNTXOHApUnebZb
         eoVQs6m9o33WBbMR8Dh9pP3rF0p0s9skSXZjWzCWZzReckPGgfP0hyQrx93WBPbktYEx
         +2eQJw/tkeqKrMLXUumguRape9p3jQ8M2May7UsTGG1uSpRhJwBpbtCW2B0s2c6K5vYL
         9hhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784055162; x=1784659962;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nIfwW/o8U7z/0oL+ZaQUBUaHVA8qfCLS7p9kgkBe1fQ=;
        b=I+ALB2Lv41qGH2xqNE+EOlCbyK3cjwr3d/yDaj4sNupDC92Sf2dsfxji8ZXHJZ608p
         hiOUCUs9Ymf9QhMwib2hkFddEXyeFHKgS9hsk/NxV+NLQtHYMvY/AkvVE9RdRxpQLB94
         ExJ/BTlJSwVhVdFzhJ6AKhRg6ytX7rzZyhtOjT6rR5XTAPwtvdZoGykInfiEAnk+p2OA
         r+2Z4Bt7Wl5KRZjqVJ3kspjKbQqBwZAum+C3qzC8nVroYpQ4lyHLEr58eKPNJWbltP8o
         by23JtQzFb0FTWZyqwNt0PjsdsgyziQ8WwKiQUNM8xImJcCgbgJlExbmTqm0q5fidTRZ
         Pbkw==
X-Forwarded-Encrypted: i=1; AHgh+Rodq81fw/28yA9XIi1tiDwg/+8S3gvBH3ttZdXO/P5nZqjnhOOWUhpx5mF08op4cZDMxD62GIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8NM4C6y2z0xKAidwOuqpInW4OtTWMKFiV2LZlK1ekzmdNwpM7
	m1Dxt5ZvOHR6QazixLaQ1+yi+FsjB6khZLWXjN5J8GCoOpdStrz6gAtYVsNukSahcOG62GLra7z
	89niyxqTiIrLWTD3+ckNccaIHv4CLuTnJm4S9wqAgR8spM2kyNRnoLKFp5A==
X-Gm-Gg: AfdE7cn/LhJtN6GkDvvY9rNJV/R+gPGubN8LUkIE1VIE5tDrrmf7kDXb1+7QPlzXEEK
	b+XgEo14KVdZwSqQgGMl9svrJTo0z3sa8w5RGp83j0djOOz95ouktyouj+aiKutulQEG0+oNVRR
	lN/S3uwLO851Ze2eaGtOzEcnILb6f/dA77sB67dxBHG9e/YCMC/e47l2SQ89SKdh15sg3uyyoZQ
	tgApOzPn5/NxAboh3drnwoMv1Om3JVsCM4+s6268zj/lRy4X7jR/xUZmIAOqVzHvtgWSJV8TlJq
	JEVKfK7p4pcRp17tZEryb5J4TsmhIH8vg14GXinUYRbfgylJwhKXZrHzVR7J0BmrmWrAXoASQOl
	SYF/09CxsNSTK+6GHFnDerAS0iq21WPWla8I=
X-Received: by 2002:a5d:5f49:0:b0:462:6aa1:4393 with SMTP id ffacd0b85a97d-47f4886edc6mr4094729f8f.4.1784055161954;
        Tue, 14 Jul 2026 11:52:41 -0700 (PDT)
X-Received: by 2002:a5d:5f49:0:b0:462:6aa1:4393 with SMTP id ffacd0b85a97d-47f4886edc6mr4094699f8f.4.1784055161476;
        Tue, 14 Jul 2026 11:52:41 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464a9879sm11237677f8f.22.2026.07.14.11.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:52:40 -0700 (PDT)
Date: Tue, 14 Jul 2026 14:52:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Rientjes <rientjes@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Link Lin <linkl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>, virtualization@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, prasin@google.com,
	duenwen@google.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	Ammar Faizi <ammarfaizi2@openresty.com>, jiaqiyan@google.com,
	ahwilkins@google.com, Greg Thelen <gthelen@google.com>,
	Alexander Duyck <alexander.duyck@gmail.com>, stable@vger.kernel.org
Subject: Re: [RFC] virtio_balloon: fix Use-After-Free in page reporting
 during PM freeze
Message-ID: <20260714145155-mutt-send-email-mst@kernel.org>
References: <20260709224330.946683-1-linkl@google.com>
 <8d316b6c-41fb-4ae3-8923-3b649b92b33d@kernel.org>
 <20260714092146-mutt-send-email-mst@kernel.org>
 <5e18d7ec-a9d7-2cc3-7741-695ec3580ffa@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e18d7ec-a9d7-2cc3-7741-695ec3580ffa@google.com>

On Tue, Jul 14, 2026 at 11:21:33AM -0700, David Rientjes wrote:
> On Tue, 14 Jul 2026, Michael S. Tsirkin wrote:
> 
> > > > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> > > > index a1b2c3d4e5f6..45a90fb3abf8 100640
> > > > --- a/drivers/virtio/virtio_balloon.c
> > > > +++ b/drivers/virtio/virtio_balloon.c
> > > > @@ -1055,6 +1055,9 @@ static int virtballoon_freeze(struct virtio_device *vdev)
> > > >  	 * The workqueue is already frozen by the PM core before this
> > > >  	 * function is called.
> > > >  	 */
> > > > +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
> > > > +		page_reporting_unregister(&vb->pr_dev_info);
> > > > +
> > > >  	remove_common(vb);
> > > >  	return 0;
> > > >  }
> > > >  
> > > >  static int virtballoon_restore(struct virtio_device *vdev)
> > > >  {
> > > >  	struct virtio_balloon *vb = vdev->priv;
> > > >  	int ret;
> > > >  
> > > >  	ret = init_vqs(vdev->priv);
> > > >  	if (ret)
> > > >  		return ret;
> > > >  
> > > >  	virtio_device_ready(vdev);
> > > >  
> > > > +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
> > > > +		ret = page_reporting_register(&vb->pr_dev_info);
> > > > +		if (ret)
> > > > +			goto out_remove_vqs;
> > > > +	}
> > > 
> > > Hm, that failure handling is rather nasty.
> > > 
> > > 
> > > In virtballoon_freeze() we document:
> > > 
> > > "The workqueue is already frozen by the PM core before this function is called"
> > > 
> > > Your report states:
> > > 
> > > "Workqueue: events page_reporting_process"
> > > 
> > > 
> > > I assume that workqueue is not frozen yet because ... it's not freezable :)
> > > 
> > > So could we queue to system_freezable_wq instead, or define our own freezable
> > > workqueue there? Then a driver doesn't have to worry about that.
> > > 
> > > -- 
> > > Cheers,
> > > 
> > > David
> > 
> > +1.  Just system_freezable_wq will do the trick.
> > 
> 
> This makes sense.
> 
> I'm curious why this bug hasn't popped up earlier, presumably any VM that 
> has gone through suspend while reporting free pages through FPR is 
> vulnerable to it and could have panicked as a result.  Which would suggest 
> maybe >99% of FPR is done by guests that never suspend?

Quite possible.

>  While under 
> pressure this issue seems reproducible.

