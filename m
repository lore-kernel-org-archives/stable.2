Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62603B14AA
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789489988; cv=none; b=u3znHsZLMbydAoWsu7+2+iGac1rPGqy2EsgiR5H6EEbSMC02ShkWjWlKqGpq+GoLFQtav9Dw8+8XF8ZGLoYhwJU+PZBB+76zep8wksEViXxgLNST1hhqj3bU9Q6DrFt+MD9Gu/D+pxLo5cWPpLMID/PeFVPHbVDvT6/QcvfWtZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789489988; c=relaxed/simple;
	bh=Xzgz+4tsqdIJiJ44u0qBX2B1GLvXUOfXVH0aIZzJ9Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2rZ7yX13Tsc69dS2jSp/QlGoWtSvd3Rkpkb+U6RXYe9XRRypZFmWKLl4qjiL/4uM4FgFBUFxFwF/90a1Gu3ccGI10PUZcvR7Z3IATBMotsY9iiT030Ua5O+1xSrXmESugsD6yO3jsJDBHi9He30IHlwtnmWX466Q+6vItD3bv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EMuy/4E5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NiyXGILZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMuy/4E5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NiyXGILZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789489985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zGgRa3VPDYgehvQnqiC0LfcNhzBWNqGieMYcbjfd6B4=;
	b=EMuy/4E5cIH/zpPjsfVnZ+f5iluwYV677C8HfFeKeG3iEOEdWFUFD6XYcEO4kVRTG365m4
	tj52mKho/n8mdZIwPPwwDHwU7AxHJQjeaIWqZ4mkS7XEEONP4wlsRoL+EmcSGTYq1blYZ9
	cY1wlFYBiMLi0iA7CLJkoK0mpSb6GHI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-7vA_0aqtO8OazJiso8QcNw-1; Tue, 15 Sep 2026 12:33:04 -0400
X-MC-Unique: 7vA_0aqtO8OazJiso8QcNw-1
X-Mimecast-MFC-AGG-ID: 7vA_0aqtO8OazJiso8QcNw_1789489983
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49e76a80fe5so30533065e9.2
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 09:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789489983; x=1790094783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zGgRa3VPDYgehvQnqiC0LfcNhzBWNqGieMYcbjfd6B4=;
        b=NiyXGILZXXkYsKiUM8gekg0NdAkMrNWfZPRNbtbyW0Jch4fUcvZyglEloXy0rv3pmg
         fjTxNQAxhRHszyeHFb53qxpBptHq1S+TL73LcZ8Mmprmzjt2kd8xVqN1oRPcw0loo1JT
         Y++A4c5bTIrSGd1vjjI1mIDIRhZh92dXxs/T7TyKmYNqMmW6LBqVnffvpvK4NYQiCncs
         IxjWdBOIfo0s5uB6DyklvFZWg8iXUfenDDoOK7p2jo6YbcAK5XmooCbDw1qLiN6Z/S3M
         dkjLid/MZfcr4KGHRvmdPpOWFRxZ8P7bPMdWByyUzKFIrFhE7p56InXjyfjlNLtzb2oQ
         H9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789489983; x=1790094783;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zGgRa3VPDYgehvQnqiC0LfcNhzBWNqGieMYcbjfd6B4=;
        b=vSAlxk1bQ7P2zkJHm8mSidbtYHLLzR1c3l3DlbPEwVuWIrxLffVKuFVRXUX0/foiUC
         qId+KvjGA0q/PtEdzPegdYBaO3iRZ5vNdIoq7yXtx/kJ5zg+vCInXWnlWsLGvqL9HKoR
         3iDJHz4oT1udPUJlrPPcXTXmwxgZSYANdmSldPFZXqeW+NTxokVC/0Hm8+CoS3BPALmj
         vagXebQo8OJaAzTaqXZHy/7gBRNn/y9elPyiZUohsdrhK9bnN+551qtqzkDyBYwETauN
         UHMcCdw1cfb5bi0ZaZJE84h5b52A2z4bAoP558W4ykAuN+IJ4l0A408noeMPJKII7vgf
         Uv4g==
X-Forwarded-Encrypted: i=1; AKwUvBzJVPoTjkODdSZ0lPfkBdRNo34E8ieqvsw4FocN4EXJ2TafZagkn0wnrMtQt1KoUrBGb9oOgYI=@vger.kernel.org
X-Gm-Message-State: AFuF++ki7gfVjSJ4jZvBImNu29dg+/F4dclK3VOROlDUvwIForhu23JW
	8cmAMYcQE/dIjXKzZHF+qPtPVzA3JM00zEDmIg6w0kw0pymODnY6MwAt0tsMjYizLWHtMuJYCoP
	qJUMlBFy/e2sxL9angjBQ3Fvs5R5Bok0+gKMoYyJ4m3WS2IDHsVtXwZ/6Dw==
X-Gm-Gg: AYBFou16ydvVqD3EAE3VhEwSYppBRpjwc887MjRzAQxHOKybQJ/oY4EX6A0MMcN5Fhy
	kGwVlL7W0fr6ZF5uNVNdR7O5FqtAxNreKPCFvsfTXULrbmcxKPZ1MY7Nr8lvY/NvLDpaZIgArUA
	ntqHevqmD8p7u+O3QhFJiIK+vi5zUxjOifQImfVN/j/MJAnzqOykQzSThvSbrIKJrPRVsWSc4B4
	ADMIs6oF/k4UeZ21HYF4SvqyMjxEseL6SHfPRNiHRdy7Z5VBE1K/QDMJ9+Knazn3C1fuq1uUE0M
	xbFJnuokpU2qnxsJ6pWGwdwiwVDjURihGcwwK0JpuZd8H7mfj0BMRsJMpHGEwAnelgA6f/C1PGC
	0q369HZNlAbIXYBqsjJIG0r6DZzwrlQG5Jgw=
X-Received: by 2002:a05:600c:548b:b0:49c:fc6e:8caf with SMTP id 5b1f17b1804b1-49e8227eb75mr26724395e9.19.1789489982811;
        Tue, 15 Sep 2026 09:33:02 -0700 (PDT)
X-Received: by 2002:a05:600c:548b:b0:49c:fc6e:8caf with SMTP id 5b1f17b1804b1-49e8227eb75mr26723975e9.19.1789489982463;
        Tue, 15 Sep 2026 09:33:02 -0700 (PDT)
Received: from leonardi-redhat ([151.29.41.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e83dba8f4sm1920305e9.13.2026.09.15.09.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:33:02 -0700 (PDT)
Date: Tue, 15 Sep 2026 18:32:59 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] vsock: ignore empty child namespace mode writes
Message-ID: <aqli0Mq_jv28h7eW@leonardi-redhat>
References: <20260915111417.2726515-1-qwe.aldo@gmail.com>
 <20260915141547.3010692-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260915141547.3010692-1-qwe.aldo@gmail.com>

Hi Aldo,

On Tue, Sep 15, 2026 at 11:15:47AM -0300, Aldo Ariel Panzardo wrote:
>__vsock_net_mode_string() returns success without updating new_mode when
>the transfer length is zero. Its caller then reads the uninitialized enum
>and may permanently store a stack-derived value in the write-once child
>mode.
>
>Return before inspecting or storing new_mode when no bytes were
>transferred. This also prevents an empty write from locking the current
>mode.
>
>Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
>Cc: stable@vger.kernel.org
>Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
>---
> net/vmw_vsock/af_vsock.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 622dbd0467..816d25b314 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -2883,6 +2883,8 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
> 				      vsock_net_child_mode(net), &new_mode);
> 	if (ret)
> 		return ret;
>+	if (!*lenp)
>+		return 0;
>
> 	if (write) {
> 		/* Prevent a "local" namespace from escalating to "global",
>-- 
>2.43.0
>

Code LGTM.
Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

To reproduce it, I suppose we need a kernel that does not come with
`CONFIG_INIT_STACK_ALL_ZERO` set.

@Stefano do you think it's worth adding a test for this case?

Just out of curiosity, how did you find this bug?

Thanks,
Luigi

