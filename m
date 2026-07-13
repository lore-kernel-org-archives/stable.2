Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E2F35C1B7
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 19:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971809; cv=none; b=RFCbndypHRqfBPhwG2/kB5nvfZ6Youx5+zDnwGbFApiHFSjv8AL7xn4rtnDmUn1nk/1VwJDkZ92RTmvUYklpPusRrZICYj4fy6JYNwl3Q45+PtB+gyalXO1bWRsuEbSPzmDRjQ/AcWiFpJtwi6pUUYnZtiWPFSyX0JEKnF4bil4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971809; c=relaxed/simple;
	bh=+D5yjWN6rVMXpGyTufspKcyF6W9cMssILiwjIivzAPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1S+QxbF4Vq+eTwZ7QfYvl9u7KyLdDMhLxzuspGpjsYNa1sCMHRpDsdzgAXhT8ah2a5FvK55gD7+Zl28JR5JrFM+ubRFre22srqaMjwUacONchnQPQA4u0nzkM+dozTW0UkN2e6Xc+4/54K/yY8qyFyKRRod6pICbXjVDhnCN+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZLRMYk7J; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fJmqsdV2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLRMYk7J";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJmqsdV2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783971806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oh/99NzF4tGS13cUL+eRJ8P8DrHZhD3bwsodlnkuIoc=;
	b=ZLRMYk7JqIkGvR3S2YMaIEwm5m8qzIgw8AkWTnKRaFOjgVzmKsnxGbULSeP6hH66hNFOrI
	QXRzAhyZFSmRaNuHgnBJeSkcXWxwzHoUo9BfBVAR3kshuawtAgGoFtWAeQbVMfJ0oGRni6
	2U+OyhzpHNH9R0Z5SAMAF4B6pDItqps=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-WJkXRNi5Pd-S4IwPeIdKhw-1; Mon, 13 Jul 2026 15:43:23 -0400
X-MC-Unique: WJkXRNi5Pd-S4IwPeIdKhw-1
X-Mimecast-MFC-AGG-ID: WJkXRNi5Pd-S4IwPeIdKhw_1783971802
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-472a798fc7cso116293f8f.1
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 12:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783971802; x=1784576602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Oh/99NzF4tGS13cUL+eRJ8P8DrHZhD3bwsodlnkuIoc=;
        b=fJmqsdV2/nmyZhsmqa+20YytvG02f5kGwRyg7PhVyez4MKCHf5jlDELR68rKrZZeVk
         IDkG/EK/AAFe2TcP/nTPSFJX8T3NBkG76MmkN3WcDpydpSqHF469Jf/Vi5ykXhsd+Vi5
         iBYK/OgamXEALY9YV7havrHxZ/xctWveOzA4bmIohzpWSwqx2Qb1XrNphqbeihBA5yEo
         /AbqJFFiUmiWF08P7XM2fR9o8JP1z0nB70p/JvNZ5JhpJ35yjrusBDyC1i5xF7zm//tZ
         6FgOSwNKe+Fgo1DAno3qxrwrvQf6/nl2PaYZIaalcnmmetpgV4wVQBPj7X1mkSdaW1rf
         S09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971802; x=1784576602;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oh/99NzF4tGS13cUL+eRJ8P8DrHZhD3bwsodlnkuIoc=;
        b=EW2QrYobIdXZQ5JGcLyUyp3DUwkF8tEn+Um11+bdR/in6LTkXE89tE2ztcuwC1sHgQ
         5rOxOobp0UNsDjP689K7wrhd4hi0mi9CR3QB390rfu5Wf+CElEA7LEsrSaKju7A4rd90
         eJt9VmX5QwTakhr139yJXWJDoz1foAA5EYqt54F6y+jh9WdUFNq9A5LY6oOxKW8jFBsE
         IMnbgrFWXNrdahua6VJPizhFJqBybDaSghDod0jdRLy9bD+44QEgLolBsQvBh6C3CerE
         jkpI404P8LSHrnOZDqSrCQRWnN3hPLTW1/t6FdbL7jpW1CIDlvtw1jPqeMS9I7ZPb7F4
         WRUQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr9aoRnUf2JEgs59c8GnYtDmQ3O7fR9i+fYMfQ7twlALyDDid/G6y74xHtc6huoS1h8jNAymqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YypBR8Lp78UhFmpeMcp0QCg718Lr8vO27GV/JWbeuFK/duiPiV/
	c83Ei1QaneixTqiyte9Jb6OQ8S2t4tx8DnvYbRRJI+oM1WjmkrG2CJSFSY6OSZ5aVbGhHHvpMDx
	LP0KAQ3m5zSjoO6PMzIhf0dCIrYGdXLG0/ettPoR3oT//WWpw+Ul4jx0ova5xgR06O2q2gmg=
X-Gm-Gg: AfdE7cmM1izacaEz2ktefM5IQ3PCMG+VHTguMlJc1bMlJv6ndqQTCA0NCeRTh4aXPFs
	Yv7mZ+GXccr5kxF4V56sQP0tqBTGtVnHzNwyZAs8OI7QBlpz/R5jfUMY9670mFqjy1Wb+NXpJfP
	ABPQhHvBmE9lXhljMWFu3gs0XRJfvrB70Df88c5/hz6iIwI7FTX9URPBfVrcNMddP/eP8PRj6i6
	cAiju0lcWD0+t87oOds4XbwNh6lfcq/bFMLL1QuRvyRKlvUoK1ygJx810f/548l30RJEOHxH7Hf
	6QtR1qTprsY0mpaunJh+OT3HUB6PtxxNcwVT57E7L1Q13gGWErXWrsm5sugp5v+z9EkGo4UMh6i
	nT2QE8j+wAbrOdF8wp3SIdZp0b4GmKjji+EA=
X-Received: by 2002:a05:6000:1841:b0:473:823:1924 with SMTP id ffacd0b85a97d-47f2dcd7860mr13165050f8f.39.1783971801733;
        Mon, 13 Jul 2026 12:43:21 -0700 (PDT)
X-Received: by 2002:a05:6000:1841:b0:473:823:1924 with SMTP id ffacd0b85a97d-47f2dcd7860mr13165028f8f.39.1783971801248;
        Mon, 13 Jul 2026 12:43:21 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4634e0e4sm1936476f8f.4.2026.07.13.12.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:43:20 -0700 (PDT)
Date: Mon, 13 Jul 2026 15:43:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Rientjes <rientjes@google.com>
Cc: Link Lin <linkl@google.com>, Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	virtualization@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, prasin@google.com, duenwen@google.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	Ammar Faizi <ammarfaizi2@openresty.com>, jiaqiyan@google.com,
	ahwilkins@google.com, Greg Thelen <gthelen@google.com>,
	Alexander Duyck <alexander.duyck@gmail.com>, stable@vger.kernel.org
Subject: Re: [RFC] virtio_balloon: fix Use-After-Free in page reporting
 during PM freeze
Message-ID: <20260713154243-mutt-send-email-mst@kernel.org>
References: <20260709224330.946683-1-linkl@google.com>
 <20260709161253.6b5e9ba349f70a3ebfb8180f@linux-foundation.org>
 <CALUx4KQ=bYTpDoDAZ+iVb7Ehaa0LmyPDsEWk3xFFmTVYKrpAUA@mail.gmail.com>
 <59e3dae7-a203-2e1d-3b65-875b7e0e122b@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59e3dae7-a203-2e1d-3b65-875b7e0e122b@google.com>

On Mon, Jul 13, 2026 at 12:41:07PM -0700, David Rientjes wrote:
> On Thu, 9 Jul 2026, Link Lin wrote:
> 
> > > > Fix this by:
> > > > 1. Unregistering page reporting in virtballoon_freeze() prior to calling
> > > >    remove_common(). This clears the RCU pr_dev_info pointer and flushes/
> > > >    cancels prdev->work on system_wq via cancel_delayed_work_sync().
> > > > 2. Re-registering page reporting in virtballoon_restore() after the
> > > >    virtqueues are re-initialized and virtio_device_ready() has been called.
> > > > 3. Unwinding virtqueue initialization via remove_common() in
> > > >    virtballoon_restore() if page_reporting_register() fails.
> > >
> > > AI review thinks the patch didn't do the above:
> > >         https://sashiko.dev/#/patchset/20260709224330.946683-1-linkl@google.com
> > 
> > The AI reviewer might not have parsed the entirety of the fix I proposed.
> > The patch submitted definitely includes the changes to virtballoon_restore()
> > for steps 2 and 3 (re-registering page reporting and unwinding init_vqs
> > on failure). It seems the AI failed to parse the diff correctly. See:
> > 
> > +       if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
> > +               ret = page_reporting_register(&vb->pr_dev_info);
> > +               if (ret)
> > +                       goto out_remove_vqs;
> > +       }
> > +
> >         if (towards_target(vb))
> >                 virtballoon_changed(vdev);
> >         update_balloon_size(vb);
> >         return 0;
> > +
> > +out_remove_vqs:
> > +       remove_common(vb);
> > +       return ret;
> >  }
> > 
> > > It also might have found a couple of pre-existing bugs in there.
> > 
> > Indeed. Regarding the first pre-existing bug found by the AI (leaving the
> > OOM notifier registered during suspend, leading to a UAF if memory pressure
> > spikes during S4 hibernation):
> > 
> > I actually addressed this in the commit message:
> > 
> >   "(Note: The OOM Notifier and Shrinker/Free Page Hinting features suffer
> >   from an identical lifecycle flaw and are also vulnerable to UAFs during
> >   S4 hibernation when memory pressure spikes. This patch focuses on Free
> >   Page Reporting, which runs periodically, to ensure clean backports to
> >   stable kernels)."
> > 
> > Regarding the second pre-existing bug the AI flagged (leaving uncancelled
> > works on system_freezable_wq if virtballoon_restore fails on the cold path):
> > the AI is correct that this asynchronous work cancellation failure exists.
> > 
> > Since these are separate, pre-existing lifecycle bugs, would you prefer I
> > roll fixes for the OOM notifier, shrinker/free page hinting, and work
> > cancellations into a v2 of this patch, or submit them as a separate patch
> > series to keep the stable backports clean?
> > 
> 
> I think it would be best to have separate patches for each fix; Andrew, 
> please correct me if you'd prefer one patch to address everything.

It does not matter much but yes separate ones are a bit better if
each can be applied independently.

