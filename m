Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1243009E2
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 12:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782130941; cv=none; b=IE/pmwnfxG5ZIBp7A/wVozEXkvPGm0ZWSkyRqG2u1MpqF94nkxayYsZymKNcjDCpLg62uxAcdHPnEtNgwqzEV6ITnW6Qsqc7j7PEqmbarfcGG3yfdO3b3f4sC26m/QD5n0zdmdkv4xJ4F6f9n1E9IvbUOMGE9B9iFTIqc/snLhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782130941; c=relaxed/simple;
	bh=ROjtMhAJVqAplE9ZCKI+gepuDwCOm8vYUnpYF87scYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xi1RT5v8AaHlEH1K57O9gjIPvurK7c1MsViwBOW5y7CNTin7TAcjsEj6/N0HAv1g9k10zQ3t0DmSUVFZcsZQiyuqd13tLbkaZa7re4CH5V1NeDEL1JVhUAxPaq9zjtj61DiAov9oJxMAcDATSDKUFNUcwXdnj5HcGBWONDazrEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Flvu86DT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FrOuaElU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Flvu86DT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FrOuaElU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782130938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NE61WDsqzyH4+WIlfYLsAL+lHpKgDOSKscv3FLr3jxs=;
	b=Flvu86DT33CVa5iOavrcKY5m6X0h7OL0WBLbbrvw6pxcwd4UrbZIh/GTIBWyajk4RR7ZrN
	YNseOBbhzvYsFSRmO1VbD9n3xo1dNcjXZMu8IEbIrjUoj6M3AXCqSI4FeUYlrpAAQ5hUr+
	NACu4chwZ4c8QDbuFhwk4wdzDerbWps=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-5NpusdHWPaen0c0GKnf-IQ-1; Mon, 22 Jun 2026 08:22:17 -0400
X-MC-Unique: 5NpusdHWPaen0c0GKnf-IQ-1
X-Mimecast-MFC-AGG-ID: 5NpusdHWPaen0c0GKnf-IQ_1782130936
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49221de4ed4so28100325e9.0
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 05:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782130936; x=1782735736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NE61WDsqzyH4+WIlfYLsAL+lHpKgDOSKscv3FLr3jxs=;
        b=FrOuaElU7tcVLBEpK03HOHt+zo52scmlRr82q/oNCRzsq/KnswTTKi2sO9CgIEe1/C
         KVhxtLb/Kn/93vLazh082SedQ1jyoy8dxoVmbNiMh2jvFta+Xy/kH7ryuumTUvlitt4s
         1jVrK1rW8DbrkfD7Hcxp9jgVI26BC16uXUnIgUmWGS2PQ/E6r/Rv7ge3bIw+HehU+scC
         mb8R4eu3XiRDv/kRoWO/6y4PaUfeK+iqY2KQR9qX4YlRc/IS2seQi3aM2PqhOxiSKAYp
         NmWAdg61zc6RuilLiozrRXEE9D2iYeMwqURAFfQyyXfN034/sxEfJhBpTdUhfqSWMiLj
         DlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782130936; x=1782735736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NE61WDsqzyH4+WIlfYLsAL+lHpKgDOSKscv3FLr3jxs=;
        b=YDDo89mtYC+wfpO3MrLWbPdhAZnVWc1l+NbrMo6c0tKiVNc+pJH/agS0dmyJGbDXMl
         cB/j/odsx4KJ/mFWq8/2wIAMOTHExl/B3ZwLYGUhFybLUxr8mK8Yry0aLlTR6dapRoKb
         FY4IDhdqFeQXmG3tUvWAE8WzQzNxrrhkP4eDwv9KJJJyEf8NBFmZxVsBQN5gdxRcFEd8
         0BLWzSLChNF3HL7UL7ZyWWSYm8GmModg2ZvFNl95EAcvFScGTDPBHBTp7jqg7TzBg/rq
         TJC/bMyVPxJMaONmqg1VNqTzIYzqVOmkZPnlAsPgz/EzPJhpHoP6anGODiUZfS8UKwT4
         bcDQ==
X-Forwarded-Encrypted: i=1; AFNElJ/njkXx/0Ga4slI3lZAivj2ojlK2mQ/fWM4MtW5fWvSqXoz/V8oLB71eGQuTMO5sUimuuPvXlI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1PVjrsVmix6cgl/tJpJ9oW15n6MvOJ1FyDdcwXxgKWPWLN2xq
	8maqUv75MyuR7PxuzvB/t6tvmp/1qVa/uu6IXD+/ZPO8GcIQij7qcSIoAQPkKgU6gjkFy/6zaXY
	S6AWXf7GNQ3b9vpK9LBsUXPBlCwKEhYLDa7Gg47jqGn9iDltEwTKaEYtx2dHvyteCPA==
X-Gm-Gg: AfdE7cn2NTIXL9+z65X80pRB9ZNxiC3H9HR5Hgi2BOroxVXOHCPXCYr8fwO0Hg/K/Sp
	feFqlPQQ3w9/hetRMNqoy+VJqQPwSChzjvBqg3OgGlmJkxSxRz2o4vSO2v38UY3rn8BUG6Pe1wK
	W+ShD3DlEtqSZTAqtWx68DSxo5YqhnaUggIG85ceepSW8WJFFSkw6pjbmXL7/ezkIP4z/IAk8p8
	3dz262HoRXFgNwgxZJNIikSCSKyzH30Booy1PDS1jyMKAGBTieLjNMTwuc8mEreEXRWqy603qRA
	/fjsCXK2itj8I3HCe5JbMRbBv3ukTjtXlnYKQ2r/9Sr8Fj4IAK/iNAJJXeLQzLNBEWgXbQgDOIq
	Q69BM83dqLYI3kJHaqz7a03WOZUPS5kNZt5U5bGZazocSRzBgJXbsJt5S/8nx
X-Received: by 2002:a05:600c:1c1c:b0:490:b724:507d with SMTP id 5b1f17b1804b1-49240e40a01mr263798005e9.11.1782130936097;
        Mon, 22 Jun 2026 05:22:16 -0700 (PDT)
X-Received: by 2002:a05:600c:1c1c:b0:490:b724:507d with SMTP id 5b1f17b1804b1-49240e40a01mr263797255e9.11.1782130935490;
        Mon, 22 Jun 2026 05:22:15 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466667881bfsm27415740f8f.22.2026.06.22.05.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 05:22:14 -0700 (PDT)
Date: Mon, 22 Jun 2026 14:22:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Brien Oberstein <brienpub@gmail.com>
Cc: netdev@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org
Subject: Re: [REGRESSION 6.12.90 -> 6.12.94] vsock/virtio: large AF_VSOCK
 transfers reset under backpressure
Message-ID: <ajkmjgGdJp9Dj6em@sgarzare-redhat>
References: <467b01dd017b$733792d0$59a6b870$@gmail.com>
 <ajkAlpiyPWmNPWfx@sgarzare-redhat>
 <618701dd023e$063de350$12b9a9f0$@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <618701dd023e$063de350$12b9a9f0$@gmail.com>

On Mon, Jun 22, 2026 at 07:55:30AM -0400, Brien Oberstein wrote:
>Hi Stefano,
>
>Thanks, that matches what I'm seeing: large transfers reset mid-stream
>instead of the sender being throttled (reliable above ~1.5 MB, fine below
>~90 KB).
>
>The bind for me: it's not just this mail bridge -- I use AF_VSOCK for a few
>host/guest services, some of which open their own sockets, so the per-socket
>buffer workaround can't cover them all. That leaves pinning 6.12.90 (losing
>the DoS fix and further kernel updates) as the only blanket option.

Okay, but in that case did it work?

>
>A few quick questions:
>
>1. Is a -stable backport of the merging fix likely, and roughly when?

We don't have a fix yet.

>2. Could a smaller interim land in -stable sooner (e.g. more default
>   headroom) without reopening the DoS?

What we've merged so far is the best we can do for now, but anyone who 
wants to help improve the situation is welcome to submit patches.

>3. Will the fix guarantee backpressure for any packet size, or just widen
>   the margin?

It should fix STREAM sockets for any packet size.
SEQPACKET/DGRAM is a bit different since we need to keep boundaries, so 
it will come later if needed.

>
>Happy to test any patch

THanks, I'll ask you to test.

>I have a solid reproducer and can turn it around
>in a day. I'll also file this as a tracked regression so it's not lost.

Unfortunately, it's always been partially broken, using more memory than 
specified, so I don't know if this is actually a full regression, but I 
understand.

Thanks,
Stefano

