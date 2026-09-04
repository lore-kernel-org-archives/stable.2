Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2861D476078
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 13:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529667; cv=none; b=EZAXIbKOcamQILjXRmnnyGUlUCEVJPUyatF0mrE+W/00z9qK8kq7XHF5wWr1p2wry42kWbKL7UG7WHad3lRFzEcHdRKhP3YX0f4lMXKm619TkkquFc3RcNCl17Dr2bOudzXETxQQkdyVAZOWGCQylCoK3cOu1biiyzEXCWuBSzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529667; c=relaxed/simple;
	bh=25i2A2szwLSgteJ1M4DB1p6sapXWkvoq0Ium9ucg/S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F6OBqKa55vHGbzrjjbTExxYzet03GOeOks9e6xJFSqXf9ocGFCVIj2TkaWpdSVOGwnO9ucMPzHzou/9nWkfahTZX2PZQyiapdIpkzyEfbaV0qtxQrKHRhxt5C9VwWe+T6CMEJw+IsyUdhLkWo6WrpFyoO9JuAhbZmf17NR+pptU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bFVVkt6m; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hn91cg8v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFVVkt6m";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hn91cg8v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788529665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7CNErS5IWCEX+tiB7+LPr05wOYMkfDYDiJg4qp80fOA=;
	b=bFVVkt6mSQ0oRDUi4lB9p5tOZLCynfHGKKLFNAgmLQpyOFtKzqpDE9PrWcxSdMafZ8ys29
	h8FFZJCXnp0RSJrRW/NAkloqCuZI8SK1cDlcyuZuRtfnJ1VL3gBscvJpK2zliCr5OpqQVP
	pXrfgAa6z19jfcsLDioLReAg92TYr+w=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-lcJuz_uCOQup4ygYXVU1nw-1; Fri, 04 Sep 2026 09:47:44 -0400
X-MC-Unique: lcJuz_uCOQup4ygYXVU1nw-1
X-Mimecast-MFC-AGG-ID: lcJuz_uCOQup4ygYXVU1nw_1788529663
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c20e5890680so89817766b.1
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 06:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788529663; x=1789134463; darn=vger.kernel.org;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7CNErS5IWCEX+tiB7+LPr05wOYMkfDYDiJg4qp80fOA=;
        b=hn91cg8vCZaQVhLELQMFiW41ixqlSwyI8elOQ8vuKIpGQo+5vxHWvn/OnNim09USZG
         1r15kxC+dIwQHZ7x2csPWtFPrFSX3OZ4C85f7CNEpwLL4/i8pPUnk66kDpPAcLEA7ROZ
         w6src9jYPyEKCcYNlh3QTnR4TkKZdpEdO5OFw+F388oniDeW13Ws/X8aXLBbnWJ9DkzC
         kYBtwVlNNp2T4UgHRumVraGUw78ezZ7fMPWv9/Di12IXTAql+e0BnNS+E+XydJc+VmYY
         7iBNaqF2uaeydF6VBDaHfuqyDj6blrf/zTkPfPDaruDYMn6crZbMscM+/DUBllYhca+s
         refQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788529663; x=1789134463;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7CNErS5IWCEX+tiB7+LPr05wOYMkfDYDiJg4qp80fOA=;
        b=MyA0bnrW8EEZIZPlspi5FK70PX0jtAqpY0usnFB/wWav5TOmzgDyxB0FhQRNGsQZNb
         +Oq39y1W9CNzsMbHX94E3ioG69/X9nj2AodlB+2nTLCb1DB6wkDmHQlCnXhcfTiem8RO
         a3Lz+12LnsEoESmu9vw1eM62agcjU1YRgplm9pkmzXBmW5eWUpubLKEANLBhBJ/WtlaS
         9on5uHwKuZyhhhCGoleHu1L+GuWMmmMSJxwR335g3KrzArVFa2grQfyUnc0kU1F5cDhG
         kY6anx5X3LnXfRyzdPZOINorRK3hjpc2o+jP+648So9xtumK1qSYMdFYysUcarZgrZqo
         DKAg==
X-Gm-Message-State: AFuF++mbXbP+4cWG9PczSJ/sk2m+fe0ChgfVX0GYIc3/ZET9MmsIjsOd
	bP3k95MW/goCOqXitWwGBNFOLVJ/H/U0SriCbrObj/VJT21wJ8oNmlAXhulfu7dbgUeWJsdYmX0
	MRP9QbdtHhlH3BmkRU81mtmgaH0TmXM6119SRXSvC2eW54Gg2pFZ8699hk46MadPlsA==
X-Gm-Gg: AYBFou3erfoAkf3+IZUTYJ4EFHtz8GWqc9h1y+oiQQK3x+WvvSZoJ46Wof4fgsDv9mQ
	Lgd6HHxXU/zpLat7N5NGn3hCTSYV8o5ZOEb6qhTq2yMltzx0NtIIYo/qIcncDNvwgtTirDDKSrH
	DhIqNiSMdihinFLlBumIHR5mXUiCYRi3POsZ/I0BFhMtR349e/HWmUNmUWOA9H/NUQa+lrSNIRQ
	Rb9onJNKT5jzd3frYf+xcCvy9IY3qghduLTuN+I7wL2mk7yNpVWeSRFj0xcViS8jURyLeBkfrHE
	mnDfCidAc9P5FDTXY5RYbqptQgjj1LptEOGVMon+IFEfZc7RmOAnifZX59/kl+JP5uApVInQYL/
	UKMItfAqZ3XLMvL5hXZAewDqi0xhWKBO6sV1u4spKtyJPnLfM
X-Received: by 2002:a05:6402:5508:b0:6a7:ea54:397 with SMTP id 4fb4d7f45d1cf-6a7ea542423mr1199568a12.40.1788529662653;
        Fri, 04 Sep 2026 06:47:42 -0700 (PDT)
X-Received: by 2002:a05:6402:5508:b0:6a7:ea54:397 with SMTP id 4fb4d7f45d1cf-6a7ea542423mr1199548a12.40.1788529662151;
        Fri, 04 Sep 2026 06:47:42 -0700 (PDT)
Received: from [172.16.2.95] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e6c1bee2sm1212418a12.29.2026.09.04.06.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 06:47:39 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: stable@vger.kernel.org, Aaron Conole <aconole@redhat.com>
Subject: Re: [PATCH 5.10.y 0/2] Backport
 'openvswitch: Fix CT limit teardown use-after-free'
Date: Fri, 04 Sep 2026 15:47:37 +0200
X-Mailer: MailMate (3.0r7028)
Message-ID: <1D27342B-45A7-481A-8754-B61DD5C5396F@redhat.com>
In-Reply-To: <20260904094826.1817930-1-i.maximets@ovn.org>
References: <2026090351-garnish-ferocious-2169@gregkh>
 <20260904094826.1817930-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Reactions: disallow



On 4 Sep 2026, at 11:48, Ilya Maximets wrote:

> The patch doesn't apply well without the previous kernel-doc fix.
> It seems cleaner to backport both instead of modifying the main patch.
>
> Ilya Maximets (1):
>   net: openvswitch: fix kernel-doc warnings in internal headers
>
> Yuqi Xu (1):
>   openvswitch: Fix CT limit teardown use-after-free
>
>  net/openvswitch/conntrack.c | 122 +++++++++++++++++++++++-------------
>  net/openvswitch/conntrack.h |   6 +-
>  net/openvswitch/datapath.c  |  10 ++-
>  net/openvswitch/datapath.h  |  26 +++++---
>  net/openvswitch/vport.h     |   8 +++
>  5 files changed, 119 insertions(+), 53 deletions(-)
>
> -- 
> 2.55.0
The backport looks good to me.

Acked-by: Eelco Chaudron <echaudro@redhat.com>

