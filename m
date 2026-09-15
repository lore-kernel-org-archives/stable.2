Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5D132A3C9
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789491054; cv=none; b=EUBfrMgQdUlG1UCvt7C9NxJDVjQqUdXdCmKoLwOaCMmdDD1spEKtEvQ7+yyMt0ryl7j8p1Z+nEF0pehTxA8J4hJZ1Qmb8HsQ48FNfTVwZ+kDkhwWvzEtZM510LuEHVcaMrHCUGr0H+jacq4kwV0Tr7PoQ3DhVDEqsHbOWaqFOcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789491054; c=relaxed/simple;
	bh=O4R9PW4W6s+z3xFlBUuBjGuMFpMqVv3R2aRzaj5ablw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/zpH6fKSK7+bGrrdS+VeLUg7LqhM4AgxRJaA/Vo4eFbBfyhDgxCytTf7H9Zv1uQnOU4c8QZaGm5yFDMEZ4LKTDu7ODpfnJOjr87++CDYWJg+6ldO5lIjROaDTQK4wC0r4gU9LK7hZQuwiqQI/jjRZM+7n3s49bp2KAFOGaQxTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yo3qjnrW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bb2CXukN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yo3qjnrW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bb2CXukN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789491051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yiDclPOUuZB4wifuZIMfqinOjKT1pGRb7hKV2bNRr6c=;
	b=Yo3qjnrWKr99mEatN67oAZRgZnsKy74bmLDSvAMWFV+g6gO1Mj9NLCuBDJs80bHbxBvMqS
	goU93OBe/PYa1E6prwl+TWh1ENnM6ZiudcB69cypWSigO8YMN92JAARCAHvqn8StQmwyP8
	SROSdR5ZicMyPYlKBI5Agidposevb5c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-ERfnpJhGNdiLhVvCiA6jqQ-1; Tue, 15 Sep 2026 12:50:50 -0400
X-MC-Unique: ERfnpJhGNdiLhVvCiA6jqQ-1
X-Mimecast-MFC-AGG-ID: ERfnpJhGNdiLhVvCiA6jqQ_1789491049
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-495689bfcc8so38814995e9.1
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 09:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789491049; x=1790095849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yiDclPOUuZB4wifuZIMfqinOjKT1pGRb7hKV2bNRr6c=;
        b=Bb2CXukNqEDNspiy7PlKVZNJkmhveoi5oV+4qxuDDtsjk0/Yx8Ax9+ZPrYcd35CCGM
         Jw3tbT9tbilrUCjTlvhc3P21/+GfpAHCmcTXJy9T/zmdeO9b9MccpPN5wWrbFJRJjY3L
         29Y9IKeXBD7uVKOzNNZ2uWPK7Hsh4ygb/obOnphC19i9b/zCfV0+/A1rRgiI3vTUvkQ2
         HrradPGXV1uMNQpveYtInc5svnUN++uA2zAB1U7a3bW3aj+MfJQTXZEuVPnwucNv/Rl2
         /BIGXyQ3ZLnYWSHc6qgv0G6lEAubvRPl/CGUbZVl4K0TIFcXXQuiIRXBjA9JWY5NlAJb
         gf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789491049; x=1790095849;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yiDclPOUuZB4wifuZIMfqinOjKT1pGRb7hKV2bNRr6c=;
        b=pyZALec6q3jJCj6YsNX0DEjePSKSrXGTMyRTDDjG+aEEfNG7fTvXhOG0AMl/cKjp/E
         y875/uobHUdijIFPBws9xAirk+9koBbBQI589NfmFoaXxOz+Oid/KwpsIVPNHmkdKQPv
         zppMaMtIbkFEQ7a9DJ49Jam0DsuF2YQwR1qRqmzz6CE45au7syJ7VL5MtPRqwqybgUDR
         iVGWIZjq3HY5RSt11t9YBpmY3Bnw/ppk4h45hIGXiN8qmXfjssz0ekgEaBNJvTzgrIpj
         jFF7dHE6A11Ei5zhuZfzbs6SAqhpiWcArwM3BT8CaqN9dkjQhN/BS8ndm7xOxfxKfXGt
         e4/Q==
X-Forwarded-Encrypted: i=1; AKwUvBzS/48mYIWdjj6gWOlnINyVoRF7/dhTrIC5JA1UUK0+R73Fe/KuOmfAsB65wRtCMcdr37ekPnE=@vger.kernel.org
X-Gm-Message-State: AFuF++kh5UmJy5jyPUDRk8YgGLe7omuD9E9Z/rkKLLqDPV92WQCHZY8F
	oDnfgAcIGt9WnkFUpFAQ+HrUBS+xkVPJI3miLwM4E4NgBr5WhzSW2LdgPsHbKQ0ZYTOYEplt4x3
	ld32HSg6MpfppfsEzh03z4oklgTVI3F3JCQLaFQltLmycwhd4If4ZCQtANfcsOAQ41A==
X-Gm-Gg: AYBFou2oH9lje52m20+Wo52F9il9Ffybnf36SVyw0CCo3oxqGy1XsLId1ZucGHTTPOL
	HWXEAC5ApjJpoktjq2X4pjaAUM81dKKKx818t/8OkKM9QF1og9ljOyHxsGNMNzfsiiZ4RIRJkyX
	u1kvLaRBqFYT+Z8eyuXDt23Ir0vMcbzHQTFK7PsHULspUT6tYZadKCieKxTOj68D83tpKTM2XSx
	mSvyIUjA++RiOVyO5z83K4FcGO/merJRGyNMA6vQleyFPup0MjrDVXktcfdqQPFPvJ872DujmsC
	Oglh/snqw8Qlq8OPKQYXEEU0NVz6K7EKGyTP+0RVI+RXpDY3qx+vLoHaYuVvUgBbDIy1QyJFUPt
	N0vUOOJ+ywEvnCiUpxF4BdDB/w6jr0LSOMzl73AYeSMcgaw==
X-Received: by 2002:a05:600c:4f16:b0:499:bf0e:95c8 with SMTP id 5b1f17b1804b1-49e7a65cd80mr116938365e9.1.1789491048807;
        Tue, 15 Sep 2026 09:50:48 -0700 (PDT)
X-Received: by 2002:a05:600c:4f16:b0:499:bf0e:95c8 with SMTP id 5b1f17b1804b1-49e7a65cd80mr116938035e9.1.1789491048354;
        Tue, 15 Sep 2026 09:50:48 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e83f43ed9sm1438985e9.0.2026.09.15.09.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:50:47 -0700 (PDT)
Date: Tue, 15 Sep 2026 18:50:43 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH v2] vsock: ignore empty child namespace mode writes
Message-ID: <aqlo-DLHC39UlmgE@sgarzare-redhat>
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

CCing Bobby (and I guess you're missing several maintainers in CC)

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

A changelog after --- or a reply to v1 to explain why sending a v2, 
would be nice to have.

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

Better to move this before calling __vsock_net_mode_string(), no?

That said, __vsock_net_mode_string() needs some cleanup IMO but I guess 
something for net-next.

Thanks,
Stefano

>
> 	if (write) {
> 		/* Prevent a "local" namespace from escalating to "global",
>-- 
>2.43.0
>

