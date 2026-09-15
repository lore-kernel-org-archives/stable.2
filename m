Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620EB4BB5BD
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789491455; cv=none; b=VxBo/R7ZVCxMCAUYW/ibdWoh2Zs64yXcsi1iu9ixI5HHJqwlLI3VLHIFqWTn0fo2JH3Ed0YIEGoo4LhTbSVTXmkF9yibHQpi70Q6pwILTMNRlNJPaa2uaBYxBkkwQWlvoin2n7Cg3ANPdPry3H1nPXiksRLtloSjBemsgY4tHh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789491455; c=relaxed/simple;
	bh=UGQOSKqIrs/SiqDtxOFHpCo7Bu74vgweEvsNVqBBjrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+si+4gGJHGnFp8WJesvpRUXFChxbkq6kkO0uI+3vpFNUTt90f2HzEw8hK+JqSzPg8mcd4Xh7UWx/HDRYa/PuMYF6NnWx5g/N3qlMyFr8oyWZVxkkI0pRoh8BL0d6MI0uAGuTe2d84rFyjEG3EEum/PepC9FOTjWOk85sbLtGM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qt68yUx+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=q1pYs+1E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qt68yUx+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="q1pYs+1E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789491444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lVwyrtqiseLR+Flggta8C18yP1zmqacQADadqELow/g=;
	b=Qt68yUx+1GhhRslqSphHTmbfFvhhRWSDtZYaRwILB0VH5ty7l7I82fiKGKJUlVpFNkp8Go
	sO19/ETPiC4/lgL6Fvu23XM531f0Pa/xoCUBkMEWCXNMlVEmjWFrfWun+5J1BMFjeD2VXm
	+cj162VoD1RCkNs+tmAQhiU474VfuLU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-S20ZwlOrMiG7Pm8ABwBkmQ-1; Tue, 15 Sep 2026 12:57:22 -0400
X-MC-Unique: S20ZwlOrMiG7Pm8ABwBkmQ-1
X-Mimecast-MFC-AGG-ID: S20ZwlOrMiG7Pm8ABwBkmQ_1789491442
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49cd74fc1aaso24655125e9.1
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 09:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789491441; x=1790096241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lVwyrtqiseLR+Flggta8C18yP1zmqacQADadqELow/g=;
        b=q1pYs+1E3+ddnw2YbDv8FszSaPIRmxowpUQlSM9xlQ/i4LiawhX9O3Z9IY6yq8dBwY
         3wL1ZeiaBFslOlKzwUkNnOEmOcPS6WpD0SNzpPokL4tWNqxA0oxm9WBJtRwrVmadKyCn
         L9xrYQ3dugF5KXlvKdE+asqaQMFRLdpdiYu/8HHRmW+HhcdR+xvqOIQgEO+qVPQEJ683
         /OS4rPxMxhqDIoSE66JAn+q+iW1+G87RloDuxwWBSb+kqv7u6+JaLtbEHY8h8u3vdP/0
         ljXyzHt6jdslMEeevh5K5YKIqcu/8mdhSvULAQ+fYXG93Hv2nH695eyb8q9m/MPCCu+H
         y2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789491441; x=1790096241;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lVwyrtqiseLR+Flggta8C18yP1zmqacQADadqELow/g=;
        b=apnYewRK+yYwQhSoVNHmrWOs26FTvofxY9AVLjEH0ABnomZGhCGykc0JkUnuhyzht4
         SprhetuwoMBlJdvKB9xJvfrgHRsweuRQOcG2/3t27gtqk1J5rOQFIiVREes5S0fFglGB
         phea2RwyDW5viERkh1X3Zurfoy5APhpAzD8+k8apOuocSH++ktejJtSUsKLXH1XVE1TM
         qfRKgx9HCEKPRNBrdckeGbKvsyfSvynBprHUlkqGST6oxXo2jPiCBF3TVIgak8cAtsTX
         NXJt2S9CTMAnNgdUU956TOy+nT8wlyBe8TkNLEAEiu/Zr4O9AotJIdjoAAfmwR4avIg5
         cbDg==
X-Forwarded-Encrypted: i=1; AKwUvBy7M0coe/2/uIHd6iAsr2K6ueLEF1yFiEsvFiB5tRs8lCEf63PBMkI6gAjX3fPoJCuXlHlynrw=@vger.kernel.org
X-Gm-Message-State: AFuF++mN+4DCE7LzF5/gAxpYoMghNDSN6wNiWqmxO6akwXumJFt13fGC
	KJT2JmkZKLvU+/JZJZUKtaZFqES8bJMZxR5eDjGVfHnsh8xaxtAm5J2KOQTakivRijZYR25a9FJ
	wAdOXXMkNbHU0a6wI2TGVaZg6QSwR7yoE1PZwBoHzDVp/aBzUTqME8gZIAg==
X-Gm-Gg: AYBFou24+Q4O80bujaqZxX4TSdoD7uGourUqQ5oqbKHdDRfStHM2eZ0jqFzJduMsLdg
	aA6nRPuW9N++1uK24IDwKddHgzYzqp1h3NzkSvYJNuVo161pAtmC/yJUhl07kYVT3yt+R6fxrS7
	TUpFxoWI+flE0vK3DCibcMi6kD062O5M+ly2XVFhauH19G6vi3Q9RMr3WzNFmXYWLkpJRlVjP4G
	r1MbJsFRLbS6p0K7CrM5RRcfAqBPZQvi4P1ifMeWvatDRgs+8WzXK+LjlJXoPEWR55Jvs1+jMsY
	8+uch52/tcNQyciBhcl32dS2tIG4MWP1zOpgyzvT7iF5atTQtJP1tR7hPUs5CkIZv9qXz/vmnDL
	RHcIeBgGvgMBWv9MG6SaOSuu7RlCU8nNQr/n8VwwOD0Xl9g==
X-Received: by 2002:a05:600c:4e47:b0:49c:fa20:cc02 with SMTP id 5b1f17b1804b1-49e7a677cdbmr79242445e9.25.1789491441597;
        Tue, 15 Sep 2026 09:57:21 -0700 (PDT)
X-Received: by 2002:a05:600c:4e47:b0:49c:fa20:cc02 with SMTP id 5b1f17b1804b1-49e7a677cdbmr79242155e9.25.1789491441110;
        Tue, 15 Sep 2026 09:57:21 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e83d9fae9sm3560385e9.6.2026.09.15.09.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:57:20 -0700 (PDT)
Date: Tue, 15 Sep 2026 18:57:15 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] vsock: ignore empty child namespace mode writes
Message-ID: <aql3oxZkJIMT46hS@sgarzare-redhat>
References: <20260915111417.2726515-1-qwe.aldo@gmail.com>
 <20260915141547.3010692-1-qwe.aldo@gmail.com>
 <aqli0Mq_jv28h7eW@leonardi-redhat>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aqli0Mq_jv28h7eW@leonardi-redhat>

On Tue, Sep 15, 2026 at 06:32:59PM +0200, Luigi Leonardi wrote:
>Hi Aldo,
>
>On Tue, Sep 15, 2026 at 11:15:47AM -0300, Aldo Ariel Panzardo wrote:
>>__vsock_net_mode_string() returns success without updating new_mode when
>>the transfer length is zero. Its caller then reads the uninitialized enum
>>and may permanently store a stack-derived value in the write-once child
>>mode.
>>
>>Return before inspecting or storing new_mode when no bytes were
>>transferred. This also prevents an empty write from locking the current
>>mode.
>>
>>Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
>>Cc: stable@vger.kernel.org
>>Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
>>---
>>net/vmw_vsock/af_vsock.c | 2 ++
>>1 file changed, 2 insertions(+)
>>
>>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>index 622dbd0467..816d25b314 100644
>>--- a/net/vmw_vsock/af_vsock.c
>>+++ b/net/vmw_vsock/af_vsock.c
>>@@ -2883,6 +2883,8 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
>>				      vsock_net_child_mode(net), &new_mode);
>>	if (ret)
>>		return ret;
>>+	if (!*lenp)
>>+		return 0;
>>
>>	if (write) {
>>		/* Prevent a "local" namespace from escalating to "global",
>>-- 
>>2.43.0
>>
>
>Code LGTM.
>Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
>
>To reproduce it, I suppose we need a kernel that does not come with
>`CONFIG_INIT_STACK_ALL_ZERO` set.
>
>@Stefano do you think it's worth adding a test for this case?

Not a strong opinion on this on my side.

Thanks,
Stefano

>
>Just out of curiosity, how did you find this bug?
>
>Thanks,
>Luigi
>

