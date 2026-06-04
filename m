Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA96402433
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 10:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780569610; cv=none; b=XOfhivbg/CND5QZBjK1Zq+D3Su04VREr7aoYfcW21cyepO33d5CZB5Uct5R2D08OEtIZuaiA5CHJXfsFjemSqvamDWcNhJE4AfkzuOm0eQ1nnCVtbFhVBzO9Soo1/DYlbcrXMPpymfb7WoI4ZktoNUvVayohOfu1TZvFZPhgu6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780569610; c=relaxed/simple;
	bh=NgX+c99SJB1lXKqlQ8aRE/jWzmvN8g9EUrDawofw5ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVEyAsLDAVX1MCGpl7K+Y5aS7TzNhl5Y9sOtVitBxUdseTt+/UrgmKy3oYU5lkAzx35piZJuEnglqRrwpvAHLDvPvZBKnKzk8tu88NUoPkTRcMCWBrQKW+2b/RNSSfc1moUxJCb0bw51O2hY3BbGpoFcx1wVTqxDBJCnSRmTze4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FJWiuNqV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Crzq/dCV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJWiuNqV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Crzq/dCV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780569607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NgX+c99SJB1lXKqlQ8aRE/jWzmvN8g9EUrDawofw5ms=;
	b=FJWiuNqVtWfZFmBtuUn6q5w2MsyMTVR2FsUF98Unuv/ao/BZQlNNY5JGrpVyT/aJ4Ykwav
	WDyayg+SU3cbiJ56wGPIvjyTCpxi5DmnI1oSjo/J631uW7rdKIh/n5M+XQFrkW08LomdSX
	VnS/POAUQx6vuCLNHlsllaf5V/ElwF4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-PvfAAaU6PCCXkUsEO-s0mg-1; Thu, 04 Jun 2026 06:40:05 -0400
X-MC-Unique: PvfAAaU6PCCXkUsEO-s0mg-1
X-Mimecast-MFC-AGG-ID: PvfAAaU6PCCXkUsEO-s0mg_1780569605
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490af284fd8so4561095e9.3
        for <stable@vger.kernel.org>; Thu, 04 Jun 2026 03:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780569604; x=1781174404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NgX+c99SJB1lXKqlQ8aRE/jWzmvN8g9EUrDawofw5ms=;
        b=Crzq/dCV3JoDc7wD4S95Jx/MY5nmnVkxSmMkIgApvM/KZWrx1mFpVG5OxRcvyVyj0b
         tl95cBOgTsdwhK4Tl9f281gCrN/Fj3UwRCmSa4e34DHCieiqmtRyGRnOKgjo8ETlmnyC
         WbkOtOAMGFaau0m6Pys13tOME0GgHAhjk84zWyHtvd8JLGnVEF4b1O0ythPl+GF3rXEi
         Kql6IJDPBVsZ+uie4GEDIGrA3Xgeo1e0gzcCkBsNrwJjsbCOzUTqeAc7YMQ3JSCGSAbw
         kkrEc3PMNWYDwOg0ahMNVFDYBZRafw5BQXodDkZdPewfRZtjNRKAPOKJq+W2pfk5iL9Q
         uJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780569604; x=1781174404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgX+c99SJB1lXKqlQ8aRE/jWzmvN8g9EUrDawofw5ms=;
        b=C9ISawxgiJTBGDYde8Hcz++MWcQqxNJiDJwzFbwKOaBD+HphOcMTKDo9KwvcHLsqnC
         DU5zGHBa4VE8APLKwoGDb0qNAbTkNMnbHWxfewh2EjG/y+Uy5JM4ea9ijEbG9gsismOo
         3vyA5vgoBfMWyjP6+woX56O3GC551vdADzj624VazekEq9Qu69NCaUVvX+olBZmPHrDN
         ZHlQ5scAh79C4lvNB3/F5917eHIMV8VQgyI/ZJNxrOyVDjhghcoj6IPGERmIqYphDnoJ
         lxYE0u0vUlT7p1OucfPUvDDjiANCOgF+OEohHOVbFMD1PyflrwniFSNFOlw6MZMAL4xk
         DySA==
X-Forwarded-Encrypted: i=1; AFNElJ838M6NfPdiyCOagQy1XA6u8Qa81p/GPIZmrNcqYoqFzfectGHCipY05giWfKeXhgankRZmR44=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFvMF5ztPDndO/LNnnv4epyHb3Iw2ST33BzycNl7ptgUTCf5xJ
	AIzN2x+ihrzHbLUkKdWXkZKhLccC+4rBJF2ahVSIxVrYpoHPpP6zCI9NTG1b6A3ZCZvS6PUoTKa
	8OdvNbP4URNnszWv1gzzOVd4MdaKbgVF4yERx0ENhix7Pp44YLg4QxV4oyA==
X-Gm-Gg: Acq92OFyiERM5GnfIqiwDxylsXewqrylGPm53cz6RatOheKuFYigzVDt6Z0pj5hcnOI
	9ZGkvUU1Y1Wn/gOg32bVB1vUAtcZaNZvy+eD4h000996q8CCB7WIEkg2IjksmlA542vaLrO1XJg
	l99sFcUt0bL1ylY7NeQ/VQXmDAZBCEQSIXDB9YNozkgN8kCPdG0z7vbQls8wONpIDmpxrmFfk8T
	Z+yD7Sehzhvd54FoZcvlXi77RohEZYVgCQuEslMmIIyqXgG0YiKhVfa1GPLl8xrh9PGekOY+zNX
	yNOEz0XLlKpNosAn3uIDSGwXyTrOu0f75+JkzNZr0b88jpBiESMT7A7TJTtfgOY56Ryfqr7wM5i
	xHtvg/gYGpkE8NnNtHUjYRk1MBB7OABB5mwNIbxSkhGXSMb5kZqk3s8ZI357M2vr+Owyh8/tuNd
	NyxJtzeQ==
X-Received: by 2002:a05:600c:1993:b0:490:bb19:b110 with SMTP id 5b1f17b1804b1-490bb19b19amr71419195e9.27.1780569604479;
        Thu, 04 Jun 2026 03:40:04 -0700 (PDT)
X-Received: by 2002:a05:600c:1993:b0:490:bb19:b110 with SMTP id 5b1f17b1804b1-490bb19b19amr71418665e9.27.1780569604008;
        Thu, 04 Jun 2026 03:40:04 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b7e6c774sm73719575e9.1.2026.06.04.03.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 03:40:03 -0700 (PDT)
Date: Thu, 4 Jun 2026 12:40:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stefanha@redhat.com, bryan-bt.tan@broadcom.com, 
	vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, stable@vger.kernel.org
Subject: Re: [PATCH] vsock/vmci: fix sk_ack_backlog leak on failed handshake
Message-ID: <aiFV8w-cvY2jUsqb@sgarzare-redhat>
References: <20260526104356.469928-1-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260526104356.469928-1-rafdog35@gmail.com>

On Tue, May 26, 2026 at 10:43:56AM +0000, Raf Dickson wrote:
>When vmci_transport_recv_connecting_server() returns an error,
>vmci_transport_recv_listen() calls vsock_remove_pending() but never
>calls sk_acceptq_removed(). This leaves sk_ack_backlog incremented
>permanently.
>
>Repeated handshake failures (malformed packets, queue pair alloc
>failure, event subscribe failure) cause sk_ack_backlog to climb
>toward sk_max_ack_backlog. Once it reaches the limit the listener
>permanently refuses all new connections with -ECONNREFUSED, a
>silent denial of service requiring a process restart to recover.
>
>The two existing sk_acceptq_removed() calls in af_vsock.c do not
>cover this path: line 764 checks vsock_is_pending() which returns
>false after vsock_remove_pending(), and line 1889 is only reached
>on successful accept().
>
>Fix by balancing sk_acceptq_added() with sk_acceptq_removed() on
>the error path.
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Cc: stable@vger.kernel.org
>Signed-off-by: Raf Dickson <rafdog35@gmail.com>
>---
> net/vmw_vsock/vmci_transport.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

