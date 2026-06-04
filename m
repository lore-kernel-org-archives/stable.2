Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210B2401490
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 10:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780569587; cv=none; b=MYW9neqUbHwPjiyk0KzhnYDI8f+Z5Ybgev21fVAXwPpdz9gUtWXvLoxsrdTyyioLbDPOpuDgjeda1rXVpMOVX/v6FIUGZceLS3nlsnTuf2nRLlsqKVh3ukEQ5S0OQrDDNyShZIXoRi0QUR/aVrYIfEeDFaPaBBanMjgP2V3XVhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780569587; c=relaxed/simple;
	bh=2Vh56h57Z0T91eA8r4mMnsXiuc3McXuOqM+28axWqVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bR0PCxXu7fBNQw4dSc5wYaKJgb4Zu9St9fWcSgC3vHZkhuWRoBMtOad3ByCpKM0TlQAEplgfM46jMEtBeJLrLL4OQevzFLqcGo3xqFyai9uR1u387KDlieouUp24lwRYPhhO2DPJR7Fe+nGQ+krYPin8ohrCNs2hKZk8Fus7mbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V+ilH8ko; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VpZCfonc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+ilH8ko";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VpZCfonc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780569585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aXLe0Lyqp3ntcJ5AmrAA7vOVVp+FJ2nW9Yvine+7m/M=;
	b=V+ilH8ko2mmfkyocfAHnaOlVAw1/mSkIh2VFO/C+EMjewjoRx1oTGOW+4aZBGwSP01JHhn
	zGgpmnHV0bj0jnNIaxkQSqqZgzOyUmOtoTthgx/RbvQY1JKin3It07j5FPtY6X7NzlKcvd
	GfRmWJ7RM0W9aLytT+11hULYCYUE+6w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-BipsMtadPnyv2ZT0B3DfTw-1; Thu, 04 Jun 2026 06:39:44 -0400
X-MC-Unique: BipsMtadPnyv2ZT0B3DfTw-1
X-Mimecast-MFC-AGG-ID: BipsMtadPnyv2ZT0B3DfTw_1780569583
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490b4d3d3e6so4534625e9.0
        for <stable@vger.kernel.org>; Thu, 04 Jun 2026 03:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780569583; x=1781174383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aXLe0Lyqp3ntcJ5AmrAA7vOVVp+FJ2nW9Yvine+7m/M=;
        b=VpZCfoncwY1fB4+hinZsrq1WO3odm3ru35Jv7VlxAyuFdxyxlFld4YGU6NZPSYXFMa
         Fzap4JsczqbEzOhQYFOt4FwyU7GOfEIq01dDkkx6Ia2HDmbpgi5BGRh64vKL3AlI5B2R
         3ERL7y6Kmxar3lMR960bDa1NEdW8BJxAihz9Ov/LqChhY9dARMIRtHEFRELkrmp5weTq
         sU0NKG2t38jLokSJPwGQH/PqPZ4Xfgsd6MNcOHW2VoJRCCyqW6J9+jAXLxy0dAW/8Z8T
         tyD4AlgEYXi5zkX/dRYKgvzKI2fmRJ8iktitbZNcWxkNtnL4eHNTexK9cYJ3kIL79N+b
         ZVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780569583; x=1781174383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXLe0Lyqp3ntcJ5AmrAA7vOVVp+FJ2nW9Yvine+7m/M=;
        b=snszThIjXKKtuGTC7cOGu9b0khwhvhUHIoTUA+AqfC+t08LeFl2e6QPoOoK097He/4
         4DnWx7l3L42KIuKmsRVroqvfwYUdkQ3Wo2lX1dK3YKxtvINkx4oakVSBRUbGVWEtA9Jn
         HscvNqduNH9TRTH+fUODOu9VQ+kdD1FhQDDI8sEA63I0uSmKDCl/psALtgSSCWr7KUQl
         2FlvFdy+x2gFUDJ8VGJNKKk1pxRAiOcrLSxVZdx+oeiu5kTHHHkPIKb26RmGpxOh9Rm2
         GHIi/f9pXjmTbbDE4zmGGNtyWFDO9HWCjP8QomrDpdysBw0CdGTWhOloY3zUh6bZ67J8
         1NuQ==
X-Forwarded-Encrypted: i=1; AFNElJ80kgDGZh2iVQV5vzIrH/qfzX/b09pUp/nAMcMZJo9XCm+48c87Y050LY3gGnDKjQB3oRZBDHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/rTxoIYLPJggaDDeO9f1BQXwRjSQf4KOQat/4PLWzn/biDlDK
	+ZnKPUUeTlbgBR7qcTNy1jIf6U/RRBi5T/Z+leN39d8Om1lr35BkLyKc/HNXTtMyFU4esdEfKbX
	nkuZCzUNX6whHTEmNribdIoKWe/TeShVyGtqTV8x0dhODBvcu1BabQjs78Q==
X-Gm-Gg: Acq92OHvzreImhLln80L+o9lj2KDAUxy3aU3Oq/W6UvMjQgI4NCYr6Z9jNY+o9R8Xf0
	H5tDKcT7fKIFiDtAgv7rDj+APWu/zCcwFmUMLiQJFenEe+ePGyCJDYpzxHnwyHb+V7tBzbX6Cy0
	DbF+ZK34S+HMISXs+k7GNwMhHzG0Lirk8fTsR+6HHXj8VD0n9ePv0HKDQ4j1i1542z4Xk/+qqSU
	WW0WHfwhz4pwZ/C71RRwglXXmb3qzjvnDP0KmJLNNIrQSU+y8kzDCvaSARMUkxGiqBZoQpRlCNV
	WKicb7D+bcGzUQMus6azPn2GfKPDrf/tWiWRAAoR9e7HRaQ/46iRCiI1FqtxTWAi95y8QMxXJ6k
	wJG8RRVbsrDWOhkcH/u1sDVU8kAfMwtROjYX4MckHNFVqJFj4d2oFhq1HUgVOzAgkJKbP4pyBQY
	qad3TnZQ==
X-Received: by 2002:a05:600c:608d:b0:490:b8c0:d471 with SMTP id 5b1f17b1804b1-490b8c0d5eemr115722285e9.23.1780569582735;
        Thu, 04 Jun 2026 03:39:42 -0700 (PDT)
X-Received: by 2002:a05:600c:608d:b0:490:b8c0:d471 with SMTP id 5b1f17b1804b1-490b8c0d5eemr115721305e9.23.1780569582103;
        Thu, 04 Jun 2026 03:39:42 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d69sm25192327f8f.29.2026.06.04.03.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 03:39:41 -0700 (PDT)
Date: Thu, 4 Jun 2026 12:39:35 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: pabeni@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, stefanha@redhat.com, 
	bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH] vsock/vmci: fix sk_ack_backlog leak on failed handshake
Message-ID: <aiFT9FBrEW_fW3KW@sgarzare-redhat>
References: <97069506-352b-4152-a57b-5a974320529d@redhat.com>
 <20260601095646.180085-1-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260601095646.180085-1-rafdog35@gmail.com>

On Mon, Jun 01, 2026 at 09:56:46AM +0000, Raf Dickson wrote:
>On Mon, Jun 1, 2026 at 9:26 AM Paolo Abeni wrote:
>> I'm wondering if sk_acceptq_removed() should be bounded in
>> vsock_remove_pending() ? (even if that change would probably be
>> net-next material).
>
>Agreed, that would prevent this class of bug entirely. Happy to prepare
>a follow-up patch for net-next once this fix lands, if that would be
>useful.

And maybe sk_acceptq_added() calls moved in vsock_add_pending().
That said I was wondering about other transports, but it seems both 
virtio and hyperv have a simplier handshake that doesn't require the 
pending list, since the socket is moved directly in the accept list.

BTW if you are going to sent a follow up, maybe another improvement 
(unrelated so another patch) could be to use sk_acceptq_is_full() 
instead of `sk->sk_ack_backlog >= sk->sk_max_ack_backlog`. Discovered 
while comparing vmci with virtio.

Thanks,
Stefano

