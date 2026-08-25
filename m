Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D5B35A395
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 07:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787641411; cv=none; b=VH0bLfkuYw9qONF9mwbvB6IzOMui+Z2/XA4Cj18U98BoUntvPlEzh5l9rVLyGMzDz1HZoSPSRK4EuM9LKQjYzCEocEC1bUhQoayvDIKdq4SIF0e5oVuBCQKTTKmc5W83CZPEdSVtd8dFObFMMY2Si8b/Q2H6reWm8k07VTas9KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787641411; c=relaxed/simple;
	bh=LOf+RtJBXhs6s/eIJdx9ZRDZnUklk3vYSZNk0xKtRkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lk4JouoFUoaYAQ6GCSBhH+b5xmejzLfH25nSKCtfxMpV0zNQ61J5evpZKjIEYYNedUCWt3/rfFLovmNuazjuqKLOfxYwYiP/GVy/wSjeVqpIihoWhiCgoS8vqkIyltQhjs65GPEJ/Pw079tS58JvubG20MvpGejYHYs50D4akzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9Zm96d2; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9Zm96d2"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a0a4aa99bdso7412246a12.1
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 00:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787641408; x=1788246208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CMzGm+i1YzxWvRFmcCkLX0OTQ3u6nTrGUJ+DECAkF1s=;
        b=H9Zm96d2hwd/yfziz3J+EdS0l0/RLQka3SMvYiWETiVWsPeDMuC+/WCjsDZA0sHkhU
         ObWfFjjUxCLfH/uWjQtdHOQ3/bdJrubzF/ER3bAAoLOsK9XX/Y+39wzEtea7v4KpLf7q
         SQ0XrP2MIdj+JUGeZJxGcGrGidSHozTrNIailidrsHrEvZsVGPnkAM6dvt7o26se24Fc
         pnbCOKwvmh26BlUBTcVjjKP78/cxwJAZOLzNlBnaPYNRfFs7EjyHWIVZbJ/tHV1j8Qs5
         zQOzB/rzWULYsiTGtEM2iN1lfCSUukHgeJuEiNjkThmtI+K73vrsHV20XWkRM3HFnmPa
         +gVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787641408; x=1788246208;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CMzGm+i1YzxWvRFmcCkLX0OTQ3u6nTrGUJ+DECAkF1s=;
        b=GYGuL3gOTI2nwLSr/T5YuLFotci/JW+39OE3pCP7VXW1+jpzSI8o4CXjCcYvfwFZGp
         si/VSXt1yTNETiTK6HhHjFc/AtAwVbIfjFNXRYSkAtsr4fpPtC6HpHHIFCx8YJp1WUJJ
         mEIhmCcQ4+/O3OY6cwRtcsCZMTlSg66WaAdB+CNlfv2IBbXvKQQtM/R1jT7WMH8tv/Cz
         8+c/OUE2yWPplzlag+DTB2I4l4j5pjOQEG69n5IbwFfQqJ8NGr9XkEuVx6bzjYrZeJdV
         1z3NOB5NR32k28aDKKNkFoYwQHGedCtfHIqw7ci+opF3toIuU7eBK6WmEfPHkPEF1Uiw
         0Lew==
X-Forwarded-Encrypted: i=1; AHgh+RogHPB0c2s/FOPG1rj2Xq/chMaN47lZCvHebQxG8aOFaJyKOWEoFOUCD5AN2OVJqYxUmWOEX+w=@vger.kernel.org
X-Gm-Message-State: AFuF++lbzmEvVSEiyi5DJE8sc5i8OAtkdDVWE8polPEIPne5P0GkTb5G
	HA6Btqc1WwcF5DDR5PIPl1lZTpgA4CnIDK5OD6MikE00ocivwZnrCDi5
X-Gm-Gg: AR+sD135MuHg/+VQLFApgIs4aWqBu+84VxjDjnC1P6oKbgA1EsjjnYi6rkAnnn5mHAk
	/FISbd1DlZpjT/CI6ml+YkkW8eSxCmmsCqkcZixnyBf1FDLJrbzXJi7Q8iK3fSU5smpYajOJe7t
	5BpgJZ05+Rq/fWxriF6AinH7vvsopN9jR/AMA7hR25ycsSNN7rJP4VtPoObA+LULmINM/v+03Qc
	xM4rImTVqf1wI6iPSuCDX+Bg45atJ8FZHsRygCNnq7OhaW+Jli+VAl9bTmn9al1E9zGhu6pTabo
	T0ib4wej22OKAWu9emNiPNI7rmwcaJSYi+ZBsU8sQZ6leYInxJiNTT5uTVuDqUUiirIfsDg0VgE
	qUP+2g/F3Cn/+4hozqyjbbATLU6SI4mdOb3707SN0ZughfAkFK1FlDi59AcI+hSgtRgJh+3jpQ2
	MBKY9EWjreal19O3i1wdI6Nl+vn/Yu2V1DnYCijPHr5Vnt0yY+2uq/Zz3Y/ZRC63f2Xlvjdf5Fg
	upDymuTbJoTVfybDoTqMG3S3aXEVNkxCPSs5cI6OOuWFcMS7wU/4Jvsci/9hXo4IBPA5AuQqU/4
	7HOJXSHjqfp4LsW4xnl2iZDWXw+Si9Y6QiFq9X3/OdR7jQmODfG2lcB1hHktzqc0YIDXoatMGhf
	V
X-Received: by 2002:a17:907:948a:b0:c1f:922d:34c3 with SMTP id a640c23a62f3a-c24926a1c3dmr2295180566b.14.1787641408067;
        Tue, 25 Aug 2026 00:03:28 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-af54-b201-7419-a557-62e9-4d13.310.pool.telefonica.de. [2a02:3100:af54:b201:7419:a557:62e9:4d13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24966f64e0sm1897627466b.32.2026.08.25.00.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 00:03:27 -0700 (PDT)
Date: Tue, 25 Aug 2026 09:03:25 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzbot+9cb1ac7fce4944ba9165@syzkaller.appspotmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] klist: avoid accesses after waking klist_remove()
Message-ID: <ao051-T1sSobzcXP@gmail.com>
References: <20260825040408.59225-1-kmehltretter@gmail.com>
 <2026082559-cyclist-annoying-7a55@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026082559-cyclist-annoying-7a55@gregkh>

On Tue, Aug 25, 2026 at 07:25:48AM +0100, Greg Kroah-Hartman wrote:
> > to go out of scope and its caller to free or reuse the node.
> 
> But does that ever actually happen?

klist_remove() waits until the node is removed so the containing object can
be freed. bus_remove_driver() can later free drv->p, while device_move()
immediately adds the same node to another list.

> > The task reference keeps the waiter task alive if it returns and exits
> > before wake_up_process(). wake_up_process() provides the full barrier
> > required by the sleep/wakeup protocol, so remove the explicit mb().
> 
> I'm confused, what actual bug is here?

I found this during a targeted klist.c review.

Only later I cam across the syzbot report. That report became too prominent
in the commit message.

klist_release() sets waiter->woken, then reads waiter->process and later
writes n->n_klist. After seeing woken, the waiter can return on another CPU.

My initial KASAN reproducer was klist-only. One thread held an iterator while
another removed and freed the object. A delay after the wakeup made
the race easy, hit KASAN on n_klist in qemu arm64. 

> > Closes: https://syzkaller.appspot.com/bug?extid=9cb1ac7fce4944ba9165
> > Tested-by: syzbot+9cb1ac7fce4944ba9165@syzkaller.appspotmail.com
> 
> Are you sure?  the whole bind/unbind mess that syzbot is throwing at us
> right now is really causing people to go down odd paths in thinking it's
> even a valid thing to consider at all.

I did not verify the dummy_udc bind/unbind sequence. The klist issue
does not depend on this USB path.

I can reword a v2 around the generic reproducer. anything else I should
investigate before sending it ?

Thanks,
Karl
