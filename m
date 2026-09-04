Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47922345CC9
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 13:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529651; cv=none; b=F7Jz0exZMw1frF3+T0ot2fIsX467DXNY2Hd0JRGWc39RUbT3gSpspse1m1UxmaF4g4vZzg01xXhHCMwxPr0RkJxzZ3vT6PaMm/FgmXzIb3gc4GS4yB2o5GCeywNBl0ZAoWGFj4kUnD/GOB6L8J9P24Ft5tnoBQhJj0hFnFSBIx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529651; c=relaxed/simple;
	bh=TAMDMnmbRyZ5zigjtHQ0AkWymV+j6JGWGwy3QknJHM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DIPH4UZNl69F+Ip6joi4iOI7pNjE6Fr7JT8dZ3DNM0A+VXSq5HS5rnfGmUdWJqh+Qf5xsayHi/8P5JN4d2Xg5zXvx/FcaYScHDHpNYKUDBLqYGUfg/G4k+L8f+9sa7bw6C0haarPXRWPAcxr5nTEtGkdQik5Y76nPLgFUPmx910=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zi+PyUoW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LOQ3GZiK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zi+PyUoW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LOQ3GZiK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788529649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PeqkA8UZ+GyljqMQ8QpuzgboiP8WpSErb7CDUOo5SrM=;
	b=Zi+PyUoW8C+wxzDILL3u3enzCOBz613taMb6AqQuSlODhfp4laXGu4gD4TkdpvNwTMws5w
	f3bq/66DsbmnHExX3FGLvH7UWkNTANUsUNA5HHh36AJu7+bECeHxXldyYPYnOMu4ai2Bfs
	tFEcVykfyN6e8vipayO1RLenYE5SOmQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-kDGjllFjNPGJ95lYyrolXg-1; Fri, 04 Sep 2026 09:47:27 -0400
X-MC-Unique: kDGjllFjNPGJ95lYyrolXg-1
X-Mimecast-MFC-AGG-ID: kDGjllFjNPGJ95lYyrolXg_1788529646
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6a5f96426b9so1118752a12.1
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 06:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788529646; x=1789134446; darn=vger.kernel.org;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PeqkA8UZ+GyljqMQ8QpuzgboiP8WpSErb7CDUOo5SrM=;
        b=LOQ3GZiK33xrXZhSrxTGvP5h1eeCTRiMzden8PE585IkCFPgQvvyTGSuDvT9FGeHqO
         rIoLeqwgsB+TiAJ2JQbibPFLm6rZirQ6QS5CLjh6hGVf1Zkzyngpo/YuzYw8N5w5pOLa
         4gs5kbmHF86E3H3racxZc1Za19y0oCG375XYZWBhWLMXWRFf0Lczg1Kn+NPnON5QDfz+
         AnJG3PBavE3JH+KBJ43IFiEDeD5GPCFvou8FAvcIu6zRrxWGuVpkAC3GN5EZjFDHnaTt
         t/k0K78EHzgetjKbBZh71I6lUIlKtCPUM9JO2TB3PgXy+UdZc2k1lF0HUpUGwEuyWKgn
         6JMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788529646; x=1789134446;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PeqkA8UZ+GyljqMQ8QpuzgboiP8WpSErb7CDUOo5SrM=;
        b=UxYosK53itAlQhAAQvjalqFo3w7tlBeHm4KWNFdbYNrOi7xSOkiwNPRaB+mbdqCPgR
         q7w9b5FY+EMCj79ZY25z5Luaw5rKtajpf8P229lELpZwegDZlYVkNoirgOud+tphjqLo
         +ZGjPb9Ll5fFKDafIIKeGSvfBQwBEeCCZzsq/juQHw5ZYfvhOkejfk0dvWW4khYSTlKN
         K6nzCf4hlhQIK3O5Fdrg87NGYTiBhGEvqoXokhG072dc9ZO/hRLyUvnTowMyo24gkgW2
         2Z2yFyH1BDSI5094QTz1zDpRRl44pxPcRYM+pLC4QNv+lIbYfiSw1P1M9Adeiq0SPXME
         G5oA==
X-Gm-Message-State: AFuF++lIXaxspglZmt51dvq/94kJle8Y+QHnGDYh0oWM9fJeiTnUbyKm
	ZDCMLve+rQtjX5tWVzG4ING6KQSjYLsce3iDUkqzDCre56NU7bmm5tgVeBIjxhN1fyFIp4LQMx+
	vUFmX382xkVC5P61W5yS5eu10zZFMlxRtfXWNzGuvZbFwV90zAxLM4wZ+Ow==
X-Gm-Gg: AYBFou34TfuZcC+GOvEjSduOb4xQwRdAWadQQY2DLR5V86iW/2v0dZmAtCg3kzMyYzz
	sg0Sb1ahT5inAOzZfWTFE5i9EGQFfndrgtubYlcIphW5z3wl4oVa0du5XK7+kglAiRZjcu8c2AV
	BiCXSY7ns37+i4YzkR9SSf/W0ruLIfCq33f30jn9J7N1cPe4q+aGQ8A5yZN62Y4CBwGIYTN7In3
	wio4kQctPFhrNvZB1IdWsa8VaYZJ4+PxXpGfHPNaGmITm0Cks6m9PQAxcwI14Wm9bLiRaCHsWMX
	Fwcvd0QkjONUQ3lgotyGIS4k2O4/NUJ7cl+8Os2kFL82qCxowgAK2l2Qt2Z6EEnRhn2xwJnMiBc
	imuykJwtOA5WjvhRRhMWxIiEZJalurOAvVaCZ08dvOKzOOIR/
X-Received: by 2002:a05:6402:2752:b0:6a7:ea54:376 with SMTP id 4fb4d7f45d1cf-6a7ea541ef3mr1340650a12.30.1788529646267;
        Fri, 04 Sep 2026 06:47:26 -0700 (PDT)
X-Received: by 2002:a05:6402:2752:b0:6a7:ea54:376 with SMTP id 4fb4d7f45d1cf-6a7ea541ef3mr1340636a12.30.1788529645791;
        Fri, 04 Sep 2026 06:47:25 -0700 (PDT)
Received: from [172.16.2.95] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e6c1bee2sm1212418a12.29.2026.09.04.06.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 06:47:22 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: stable@vger.kernel.org, Aaron Conole <aconole@redhat.com>
Subject: Re: [PATCH 6.6.y 0/2] Backport
 'openvswitch: Fix CT limit teardown use-after-free'
Date: Fri, 04 Sep 2026 15:47:22 +0200
X-Mailer: MailMate (3.0r7028)
Message-ID: <275CA8A1-829F-41D1-8370-A28B6A712E90@redhat.com>
In-Reply-To: <20260904093840.1815273-1-i.maximets@ovn.org>
References: <2026090350-daily-ultimatum-52f4@gregkh>
 <20260904093840.1815273-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Reactions: disallow



On 4 Sep 2026, at 11:38, Ilya Maximets wrote:

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
>  net/openvswitch/vport.h     |   9 +++
>  5 files changed, 120 insertions(+), 53 deletions(-)
>
> -- 
> 2.55.0
The backport looks good to me.

Acked-by: Eelco Chaudron <echaudro@redhat.com>

