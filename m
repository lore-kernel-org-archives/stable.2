Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C5D23AB88
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 00:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785543424; cv=none; b=VdC6nnM1K3acp1IzqnOFH4H4dzOmhauqG3b+HDWDyU23koxTHK9HCO4NbGtibd/Cq6YfAqn21Sw+lLBMRBCTfjuSN6Hc3YBy/NONkn/xUWAvy6R+MtCSXiLw8ZA2hS9xQoN66wbmrpYG06EvLU4rgwuo04IA37u/jTv4Rc28WU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785543424; c=relaxed/simple;
	bh=AYV6oj9zpGuUjYDdThONODwSdRyt5PjMWy+DUh2trK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJ7CIMt9taWG3eXO3mu3Pd136qF61oAVioEBgk8PsE/i3L0xCufTAAJ2Fzw7DGNJ0VhyhsWNJM61W19sxGztEZyq4nOH9mNfE7IA8mOM7nTPY6E6sk/wCkWj+nxFv9+cCgZ9C1oMXBfRQhDhSIXaCc9CINCUpuoHhCbRh0qAGGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zb2KlsDc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cFabma+v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zb2KlsDc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cFabma+v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785543417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YTUbWgbCMoV9mNudsltxaFWvTkWg6x0Ijnt3ApilYfU=;
	b=Zb2KlsDcu/i6sOY+h56bLgRn1EppUYuALnVGx+DJuJdC2Uc/hPRd9x4eSam5WA8aY6Cx/q
	aWmBwh+3XkHcE7C5lppG0CZL/NwL0qQKenw7DpFdRltRRMm28wbfGbEdWFxNUlAnqn44Sx
	6ss21DAbya3S+L0e918u4ABta4vBi4o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-Wc_bxd2xMI2Kxld5Yl_sig-1; Fri, 31 Jul 2026 20:16:53 -0400
X-MC-Unique: Wc_bxd2xMI2Kxld5Yl_sig-1
X-Mimecast-MFC-AGG-ID: Wc_bxd2xMI2Kxld5Yl_sig_1785543412
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f83416551so1704114f8f.3
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 17:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785543412; x=1786148212; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YTUbWgbCMoV9mNudsltxaFWvTkWg6x0Ijnt3ApilYfU=;
        b=cFabma+vdTjIu/KUBPP4CLysOx1ysjza3BotT8Kbf+5u68ATcobVssjjuU8glRfOo4
         WXkgRn5LwsYZmRZmNQk0HhGntD/s79Qul09i9VID5xkKOGeHEIk5Yrsb2BciuMhsfgML
         B4WNCMAGhGnTcit52dRRS2fMaBbzzi4EYQQzGiIxiXPqUGSu9nX70PwpQbQOvhc/WKYu
         mFI9geoV1Q7Och9K/54BgE4dX2fyAtZsgl+6R8nsXmM9HTuqrW2v38i0GR3Gf+zSRMtb
         XRFjUJv/fiXuwBzxg5NyWLJHmGCsjz40T0qlXoIffSdA2UdJDZwB6Ho5/ylIZEGv0JOK
         WNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785543412; x=1786148212;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YTUbWgbCMoV9mNudsltxaFWvTkWg6x0Ijnt3ApilYfU=;
        b=o6JrboEbNqRcs2GT0J5n2rEMMoK3Snly2wl2IFZDuT7ug3sf5ZoPuhe418KT93P+Ad
         9ubS0VoeaK9htBbwXyTvBGRHaoyjjhYulWokRW2UfPnOV0uejl8EiHezLKIbWFRX2Jp0
         UZUkXFQiiR1Pm3xJtoNO6TwQykZKA8MH6L8/2eI0Bx5EDfWZsWR/F9iuRGXsaktILLBv
         7McZYX+XSNuMyI/0oFZgt6TkOh6hY66TeWuqW+M6eUZJ4vJU7J/O3YDz0nEv02YiELJt
         /czMW4u8iI2Xo3k/GSF2mbk1RdQHTAApR2wVC0pYbN0MPRaBMP9VvmVqi/NFTWetasnY
         u+8Q==
X-Forwarded-Encrypted: i=1; AHgh+RqpWsRb89pjiWi0+MkTPU3Eu0cTzvMXnfhhIzAOlQsmklykWVzORdvNYXQ6XdnwirOATxY0Pq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTHgLqvFPJE/N5KSuRzkekfeEUk5EqpsFwpwFH8ESw3XnogEnu
	B0QZyMM0psvr2FhCnrxhMHFC8vVkJgVisZ4lq0Id/BsXt73tpIaTJt4zMUaBkBwOEDpmjEK7seQ
	bVyuQCaW9930KnWSKzPjQkkRwDEJpKg7Do+ttr1rBK3qdjV/MCNWO26P31A==
X-Gm-Gg: AR+sD114BfsZFATcoKK4dJzmpb1lIhbRfJwWBL2dCt09Eh68ynDxOVKa1CBIxHshQh2
	y0Bp8y5NnaIZIFdEuHs9gMIjmJ3TKNyhvpHLH/ieG2yDz2uwr8w0cMEsZjsB18kChLoklWVEJ91
	Zr+CIYrjvT9MdJLSjZvI4ATILG9PaIPj8i+hjRggwzundWu92TsYz8RZPVqLuAnusOwMfxIL2hE
	yRYDd/aBRDUeSCSvuznOMLHySILlRXu3AV/NCdi8EKJE3EtcYjVxZJUrBmbLA48G8SMA6xTntGz
	47soWUgF1vC6VT5/qc3JKReFiUjdPNctRhA9afYXSOC65NyjDgdBJL8u+aEEgo24a8Bhq1jdNSo
	T9Etl/d00VR35m6eC3GlE4hk=
X-Received: by 2002:a05:6000:46d8:b0:47f:6a3a:9e6b with SMTP id ffacd0b85a97d-47fd72f1612mr1988333f8f.32.1785543412352;
        Fri, 31 Jul 2026 17:16:52 -0700 (PDT)
X-Received: by 2002:a05:6000:46d8:b0:47f:6a3a:9e6b with SMTP id ffacd0b85a97d-47fd72f1612mr1988296f8f.32.1785543411814;
        Fri, 31 Jul 2026 17:16:51 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0c8bsm10836910f8f.34.2026.07.31.17.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 17:16:51 -0700 (PDT)
Date: Fri, 31 Jul 2026 20:16:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Link Lin <linkl@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	virtualization@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, prasin@google.com,
	rientjes@google.com, duenwen@google.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, Ammar Faizi <ammarfaizi2@openresty.com>,
	jiaqiyan@google.com, ahwilkins@google.com,
	Greg Thelen <gthelen@google.com>,
	Alexander Duyck <alexander.duyck@gmail.com>, jthoughton@google.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] mm/page_reporting: use system_freezable_wq to fix UAF
 during suspend
Message-ID: <20260731201559-mutt-send-email-mst@kernel.org>
References: <20260721005603.1710551-1-linkl@google.com>
 <20260722173639.34d3f58413354218b24a5b0d@linux-foundation.org>
 <CALUx4KSfUUud86k4SLwETJAciRc8kZ9QocvBj39KmzXDiQ7J1g@mail.gmail.com>
 <20260723051327-mutt-send-email-mst@kernel.org>
 <CALUx4KRoCco0HA=Y_qFzSD=CegbJPUkQkvjRb1Y3UcgRdwQToA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALUx4KRoCco0HA=Y_qFzSD=CegbJPUkQkvjRb1Y3UcgRdwQToA@mail.gmail.com>

On Fri, Jul 31, 2026 at 01:21:40PM -0700, Link Lin wrote:
> On Thu, Jul 23, 2026 at 2:15 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > I suspect rest of work items we have, e.g. update_balloon_stats_work/update_balloon_size_work
> > all have issues around freeze/restore and error handling.
> >
> > --
> > MST
> >
> 
> Hi Michael,
> 
> We have indeed discovered a kernel crash in update_balloon_stats_work
> after the balloon driver failed to resume and initialize in our
> production fleet.
> 
> Alex Wilkins <ahwilkins@google.com> diagnosed, root caused, and
> reported this vulnerability.

I wouldn't call this a "vulnerability" just a garden variety bug.

> I am currently drafting and testing a
> 2-patch series to gracefully unregister callbacks and cancel work
> items on resume failure so that the VM continues running without the
> balloon driver instead of crashing with a kernel panic.
> 
> I wanted to follow up and let you know that we are actively working on
> this. I will send out the patches to the list as soon as they are
> sufficiently tested.
> 
> Best,
> Link

