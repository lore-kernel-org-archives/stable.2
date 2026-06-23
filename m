Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95B6399001
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 07:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782198519; cv=none; b=Fn5//6Qd2uqZQj+/N6HlPeyy81BrOIwGsLVcUkdgP3NC+IxNiryn9yxKdvKUY4hUycQ33DpzXR8lJ8kwlPyyCWtaxlIORUWRGhrDe0n5J722shhIDyZW4/T4qJSovDfI0R5krpBF6M/cukC5StBnxKaAHjbvtN7OJh4es+P+SHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782198519; c=relaxed/simple;
	bh=Ke1LitD4OywmlOwFcW273fMBllWzfXSPBRZr63oLg7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkZK0sdAVW1QzdhMARx228bUtKFoS/dq3DCrFtUQHL1cFPF8RAzMIC8bSl4cLFMA14N0dtdju5psz5kNpjwsxz+ta72kQNlQgJWoqwEVN31aSJA77+uLDB/nwhgOm65JO3a0N+Wu5JQP3jcgkD15XInAN0spx9XJK+SyeNsgxjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SQuO6rCY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YAwZIktk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQuO6rCY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YAwZIktk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782198517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T+KsZAD0oHJlxnltaTZ/cFJz2c7aO0R1ESRDEl7NjrY=;
	b=SQuO6rCYIa7J0jQ6vqHVn/uIM+S47P/nK0QYani3oKO5Eo+hfJ11yyHiHItnc1touqpjb7
	/ghIW7lhToFIQPVkzLh+78q5AM+AEBRpZcchivaV/moyHRJFBMetwIplY1RiDDhKgRLhnK
	Z7E/n6q1ghf2Us0Y/+zyIrRRaPaRlls=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-5GiiRButOdicZQPVdWr7Xg-1; Tue, 23 Jun 2026 03:08:34 -0400
X-MC-Unique: 5GiiRButOdicZQPVdWr7Xg-1
X-Mimecast-MFC-AGG-ID: 5GiiRButOdicZQPVdWr7Xg_1782198513
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490a060eb84so32649415e9.0
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 00:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782198513; x=1782803313; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T+KsZAD0oHJlxnltaTZ/cFJz2c7aO0R1ESRDEl7NjrY=;
        b=YAwZIktk0PD2EezLCR2w5MtbTWbOGZf8+inqb+DiU1VX8oPoNBSGC2mG+jhDemWQYr
         GZCtD2Km6+giwI1Vpr1ekgAvXrIAyx3YNcj+5LDgaK9gjaIbBb2UFuIOarpwTvaoOc03
         9XURtnkHuacj/IGBaEfIUfW4igvYbQujGwOHGXezkAUTpFMbol76vis1jCGpb6RPnlVA
         +ZPzWOU4X8gybb55hHcrweoE9nloNylXbqEtsG4Jaka3R8prNPF5YjO4FzXPAYf69jYS
         6opIL1bQTra6bzaKII5bCUsNcSQsf0GSaST9hlLpS9AvYbdYnR7pkVhKW9OaxP35WB24
         2g/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782198513; x=1782803313;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T+KsZAD0oHJlxnltaTZ/cFJz2c7aO0R1ESRDEl7NjrY=;
        b=R3dXB2kPijOFTH701srxwAQYsMboCfcLkK69YQA9qTTDAwR1rXOG34za1MOZHkwLz+
         ihjAJ2djODkJDAAotQQNQNUh5yHG17rz1gS+dEcy+nhDMXCFtwZB70/tZw/wi1Xk9W8v
         F2ItOts2MZAJN4WA0I3RTHmr6yCTqVqvfmz0nJFy2Dhvr5yoTOGq2bCfVVZdmc3zFmDB
         4V6GMBN0gygka/MEFqs5WHQD6o1EYUMTANzgkwHm49NHi0Ufnu6dtzg7UTJ1wd14acDB
         Qw+5FkTG1ECi27t7UWMSIBwHuTHaw7nAij3FF2aEBdtZ0SQ1SdjYmPsmL2zuZ5j0eUyK
         6VPQ==
X-Forwarded-Encrypted: i=1; AFNElJ9aVAZ9fd7YV/6SvaM584OP8aFS200o9T8V6J0IN/+rJYx8i2aw0fYmJwhLxaixGUiPUjsyjRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDWSlhDBb4mobbBTALp5RqaRIe2JcjMsmAnGyJ/6bLii/p3zCZ
	osb4WdGvRxu/PTc8okT2eK/qqRxTTBuj7xaKo008LZXwousZY7sPD7I7J5f2vhdbl7bNPin+4dm
	k0HOBq1zC9m67G+bYFCeObzL5yIyZhWXoHHcfq9xLTra6npv7D9M4EcClKg==
X-Gm-Gg: AfdE7cnrZw0wXe1BY18GThxF97zCJQ6h04EtnJvFkM/3g4t+CEefsZHUfPE07Tyt5WP
	rMBsgtlITfb8cdNSyaE6PDedHpSrxYprQxDvC+eGfs/Aep5mksmPFKsWp/Ms3pzo/WndT+rxxt5
	bPwUZ5BNQoDGUmmP91p/OxtwwXLWHIPlIvxP6wjRM4HjYglMCL6qdeGEsYJN4WcmRCwXXLvVwh+
	O4z8L2vCioujPjVq8r/yO/whjBWjuxdvNdXQQWT4NkNx+5GNlG5QrPKR6Krdb3Ekh1vtCalln+n
	dr5prqKqOyT9OKfe4Bxs1g/3K3DHy73pUk1M0hpwz6J/K8gBv4vx+ZMakSy7tCNMz8EBRv9sksJ
	zg8lBwqhhblT51jbQkL5QCga78FwRqW6p9nlXIIzSRvEglpsYWPJUiEUkdOtq
X-Received: by 2002:a05:600c:4453:b0:490:d32b:39d6 with SMTP id 5b1f17b1804b1-4925b37973bmr21307765e9.19.1782198513365;
        Tue, 23 Jun 2026 00:08:33 -0700 (PDT)
X-Received: by 2002:a05:600c:4453:b0:490:d32b:39d6 with SMTP id 5b1f17b1804b1-4925b37973bmr21307275e9.19.1782198512939;
        Tue, 23 Jun 2026 00:08:32 -0700 (PDT)
Received: from sgarzare-redhat (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466643f4ee6sm31772016f8f.5.2026.06.23.00.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 00:08:32 -0700 (PDT)
Date: Tue, 23 Jun 2026 09:08:27 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Brien Oberstein <brienpub@gmail.com>
Cc: netdev@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org
Subject: Re: [REGRESSION 6.12.90 -> 6.12.94] vsock/virtio: large AF_VSOCK
 transfers reset under backpressure
Message-ID: <ajoulmq3g7nuYHF0@sgarzare-redhat>
References: <467b01dd017b$733792d0$59a6b870$@gmail.com>
 <ajkAlpiyPWmNPWfx@sgarzare-redhat>
 <618701dd023e$063de350$12b9a9f0$@gmail.com>
 <ajkmjgGdJp9Dj6em@sgarzare-redhat>
 <672f01dd026f$54fa0600$feee1200$@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <672f01dd026f$54fa0600$feee1200$@gmail.com>

On Mon, Jun 22, 2026 at 01:48:27PM -0400, Brien Oberstein wrote:
>Hi Stefano,
>
>Confirmed -- the 16 MB buffer fixes it: with socat owning the VSOCK-LISTEN
>and SO_VM_SOCKETS_BUFFER_MAX_SIZE/SIZE at 16 MB, a 6.12.94 guest passed
>21/21 large transfers (1.5 MB x12 through 8 MB); the same 1.5 MB payload
>failed every time without it. So the per-socket workaround covers the
>bridges whose listen I control, but not vsock services I can't
>reconfigure, which stay broken on 6.12.94.
>
>Agreed the old behaviour was buggy in its own right -- it was
>over-allocating past the advertised buffer. The practical effect for me is
>just that a config that worked on 6.12.90 no longer does on 6.12.94.
>
>A question mainly for stable@: until the merging work lands, would an
>interim be acceptable -- something that keeps ordinary small-packet
>workloads under the limit without reopening the DoS? I don't have the
>kernel-side expertise to judge what's safe there, but I'm glad to prepare
>and test whatever interim you think is right, and to test the merging
>patch when it's ready.

Let me try something: one of my patches merges the SKBs when we exceed a 
certain threshold. That should be enough to fix this issue with STREAM 
sockets. I can extract this patch from my series (which does other 
things as well) and minimize the changes so it can be backported to the 
stable branch. I’ll see if I can send you a draft later today for 
testing.

Thanks,
Stefano

>
>Thanks,
>Brien
>
>-----Original Message-----
>From: Stefano Garzarella <sgarzare@redhat.com>
>Sent: Monday, June 22, 2026 8:22 AM
>To: Brien Oberstein <brienpub@gmail.com>
>Cc: netdev@vger.kernel.org; regressions@lists.linux.dev;
>stable@vger.kernel.org
>Subject: Re: [REGRESSION 6.12.90 -> 6.12.94] vsock/virtio: large AF_VSOCK
>transfers reset under backpressure
>
>On Mon, Jun 22, 2026 at 07:55:30AM -0400, Brien Oberstein wrote:
>>Hi Stefano,
>>
>>Thanks, that matches what I'm seeing: large transfers reset mid-stream
>>instead of the sender being throttled (reliable above ~1.5 MB, fine below
>>~90 KB).
>>
>>The bind for me: it's not just this mail bridge -- I use AF_VSOCK for a few
>>host/guest services, some of which open their own sockets, so the
>per-socket
>>buffer workaround can't cover them all. That leaves pinning 6.12.90 (losing
>>the DoS fix and further kernel updates) as the only blanket option.
>
>Okay, but in that case did it work?
>
>>
>>A few quick questions:
>>
>>1. Is a -stable backport of the merging fix likely, and roughly when?
>
>We don't have a fix yet.
>
>>2. Could a smaller interim land in -stable sooner (e.g. more default
>>   headroom) without reopening the DoS?
>
>What we've merged so far is the best we can do for now, but anyone who
>wants to help improve the situation is welcome to submit patches.
>
>>3. Will the fix guarantee backpressure for any packet size, or just widen
>>   the margin?
>
>It should fix STREAM sockets for any packet size.
>SEQPACKET/DGRAM is a bit different since we need to keep boundaries, so
>it will come later if needed.
>
>>
>>Happy to test any patch
>
>THanks, I'll ask you to test.
>
>>I have a solid reproducer and can turn it around
>>in a day. I'll also file this as a tracked regression so it's not lost.
>
>Unfortunately, it's always been partially broken, using more memory than
>specified, so I don't know if this is actually a full regression, but I
>understand.
>
>Thanks,
>Stefano
>
>

