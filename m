Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36E233260E
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783606873; cv=none; b=CUKepMu/V0K1PbSazcFgE4AQpjwgbFTZ5A1XggWBAWCxBjx/GCi13JYyZjEXa+4BF7/Iqq9nhMu/Jn590ml1SyrJFPRz4VKnUrb179+zdDTsaprNjL94clB5rqjxvxHzBT1h8kPLNBPYdEF32Z/JHdsexZxH0MmSS8d5YE3Ii1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783606873; c=relaxed/simple;
	bh=tZELtjKJqBuV9EVwMW9I8r+Zfo5ceXTDE5jeQ+a8vOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8oKCHMW79fkZop7FTGsO3pu6/ahM+uOzPpPEGfPRiUT+elw50a/n9NCNNGBuK+f+yp9q+KVN78k0oKhX5CeG+ctZAE1UuNOm4+NcX0bpUgLueiuVi/U7ItxtIf7TauSBA0qaWvZJUCdmUz/51KKM0wApFVc5cTjRNv7PerZlg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VKVZQ/2F; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FNX6rtba; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VKVZQ/2F";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FNX6rtba"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783606870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b4EU8eRYY65P/bki26bW15zZV0Wc6U0922CjckSToFo=;
	b=VKVZQ/2FPFXNGMBLm1goKnd5iZExhjIO0GxYjckJuF4mU9tz2CqeMis0JjT4abhq8OVSkb
	pb7/rZ9odIAyJZeMNhVJDAK3CF9s33DOlFD/PFdQc763BpPYojbRh89vLT2Iul8agQ09sS
	M7/6KefVfP9Yxs14G79dBVbhsO4LSbM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-0Men0OcvNwGe9rjVlia8-w-1; Thu, 09 Jul 2026 10:21:09 -0400
X-MC-Unique: 0Men0OcvNwGe9rjVlia8-w-1
X-Mimecast-MFC-AGG-ID: 0Men0OcvNwGe9rjVlia8-w_1783606868
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493dc8408fdso19296685e9.1
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 07:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783606868; x=1784211668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b4EU8eRYY65P/bki26bW15zZV0Wc6U0922CjckSToFo=;
        b=FNX6rtbaycqa+upmuph4EPhdjnj/paeoV6HQ987AP/1taZfqD/IcxtZj0bRuctb7kB
         liXAvC7D/Ugz9TEcEWmU42S76taYXAFgrIuW4K8kBPxWmt9KifT6GpIHgFGldJ8zcIJj
         91PuVthg4iwsivZOBK0dDyIdrYKqFwW6EdbBri77vY6futdnfWttH1oil6ZHW7vAg6ty
         LutK/7EE+9/CmkQ6xybaSDJNtjik3STZP1WIhkFLXJnj93iKoeIq0rhSk3iICRNauJqi
         FgYBQfyHlm2Nye1Zc7LfBi26Sl/Sc9o7AgYNrMQQUfuEZ3vzHjsq8kGCYVtAovTjdjSB
         R1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783606868; x=1784211668;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b4EU8eRYY65P/bki26bW15zZV0Wc6U0922CjckSToFo=;
        b=Hxi7fjOLpYEPPknAK0IpOqY94m4OaRuIgWfk4lo0l+4jIc3gFX3AByCqYyXLRZsbqA
         L1La3ppi9WiIkX7Ah6DXtUBoYinFx8fmJP8+q/87f1fiLvscVRv2U26dlNEPx+IszXaQ
         1njNMIDHBv4nYK3z3ydvB+sPrWpUY1zLIeCIlQN3gYU1JdIz+ogcQpoQVYXkUW4v02qH
         IWY2oJ9fCbeTykN2rpD6eNmltC0ICL4p0B8TFvNLZWpms226mc2l0nBM/iUk0C6azM6c
         YBfM3Dq8ak0X/GrDTim0z16bNvthjYUIi5hY2uAf0axG5h2GVj2ColzcgntM3Tc1SQnL
         1ECg==
X-Forwarded-Encrypted: i=1; AHgh+RpQA+dksymXxENKiSh8THYNRBvoCMMyphUMgImhAdHarPXlfI7AlAKQN0UuMoYiqNd0bVa5/gY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz9x2Ll0gA8kcph+SA3Oaa/OYFixgfqUyxtVUZhEMEaoF1RJki
	QwnLCz4PLUYVpGWug2bFvEgsGdkDVy0lvex8ATLTztolJS9dOkVfgcU8opkjTsR1GxMEEHazHID
	dDXaCKtcGqGWpKCyU2yi1A4UjCN+vagxiIsxu6cW088AktxH8oz0DtWJHrg==
X-Gm-Gg: AfdE7ckHZQ+JsmlItMB/PvbvQE5ymkV4Yr85xsk/YoEimMp1mp/jbKpIq1FCduu35C4
	NsCSMXIeETOhIeVHpY0os0wniSAyUiyufLmqRhvDloHmUwJagZnLKtBBS4x716NIvMsRWCVDrGc
	lgUSevu8bOff5V5qhQLTdKSVln910PJm6lGpcF7ZtOBC+d0UB3bJjXyO5DowcJClz/dRwINKcUg
	f5xwxn1nYBDr3JrtBgdyQI+EzOkh140Het1xgDBMaPsrWr11jXUtElOLpyclH56YXNuqtWbC0TO
	1+n2YZr60K955Kxt4YctHA9NLyk5e7f6qC297B459Ty/sgxEPNCWktpHcmkovH5o3QbkaaNmFfd
	TZ4Ceex7ncfOg6ZmLXmjgR+il60BtMtx7
X-Received: by 2002:a05:600c:3f0a:b0:490:e974:e006 with SMTP id 5b1f17b1804b1-493e68e8195mr71460455e9.29.1783606868081;
        Thu, 09 Jul 2026 07:21:08 -0700 (PDT)
X-Received: by 2002:a05:600c:3f0a:b0:490:e974:e006 with SMTP id 5b1f17b1804b1-493e68e8195mr71459835e9.29.1783606867530;
        Thu, 09 Jul 2026 07:21:07 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e5a5d174sm165949165e9.2.2026.07.09.07.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 07:21:07 -0700 (PDT)
Date: Thu, 9 Jul 2026 10:21:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Carpenter <error27@gmail.com>
Cc: Haoxiang Li <haoxiang_li2024@163.com>, marcel@holtmann.org,
	luiz.dentz@gmail.com, yangyingliang@huawei.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] Bluetooth: virtio: Fix virtbt_probe() init and cleanup
Message-ID: <20260709101904-mutt-send-email-mst@kernel.org>
References: <20260709114745.4030794-1-haoxiang_li2024@163.com>
 <ak-T4SMxr4rw10jP@stanley.mountain>
 <20260709083606-mutt-send-email-mst@kernel.org>
 <ak-lvwzHUfuFcRRa@stanley.mountain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak-lvwzHUfuFcRRa@stanley.mountain>

On Thu, Jul 09, 2026 at 04:44:31PM +0300, Dan Carpenter wrote:
> On Thu, Jul 09, 2026 at 08:36:32AM -0400, Michael S. Tsirkin wrote:
> > 
> > why make changes at all if no one can test. in fact, why have a driver
> > then.
> 
> It would be interesting to see what proportion of kernel patches are
> actually tested...  Testing the code is often impossible because you
> need the hardware.

Sure I agree - if I am refactoring kernel APIs I would often
compile the driver and that is it.
But that is different from poking at a driver specifically.
If I do that then yes I expect the patch to be tested.



> In drivers/staging probably very few patches are tested.  Every couple
> years I look at the data from where the problems come from and it's
> normally from complicated changes from the driver maintainer.  The
> number of bugs introduced by checkpatch and static checker fixes is
> really tiny.
> 
> It's about risk vs reward.  Fixing a security issue is a huge reward.
> Cleaning up the code.  Fixing obvious leaks and static checker issues.
> Those things are all valuable because they raise the standards and
> they prevent copy and paste bugs.
> 
> I consider a few things:
> 
> 1. Is it a security fix?  I recently fixed some memory corruption and
>    broke a driver.  I tried to be careful, I wrote a long commit message
>    describing my thinking, but I still messed up.  And that's okay
>    because fixing security bugs is important.
> 2. Is the code new?  If it is then there are probably very few users,
>    and the original developer is still around so it's pretty safe to
>    change.
> 3. Is it an error path?  Code on error paths is hard to test in the
>    best of times.  The risk is very low.
> 4. Is the change small and obvious?
> 
> On the other hand, I often leave known bugs.  In this case, we're talking
> about a use after free if the driver fails to probe.  That's not a
> security thing.  It's unlikely to ever affect anyone in real life.  The
> fix affects the success path so it could easily cause the driver to stop
> working.

Exactly, agree on all points.

> regards,
> dan carpenter

