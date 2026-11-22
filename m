Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795374852;
	b=qoZlwZPKvzYSNwbnYvoVxVccV5U+ocJEw5vHDjp1vbp/KdGzNHy/cRe9C8qrw5dyslzj
	 NBH1mVZasFlfKZMXwpbsHHSKFTuud4hEwyxTMeV6jYyhTAZyUzd8zYa6Zn+PQk9GtK8rS
	 jYdGD4kE2LYmkTTlDjle1a2yluH+ORABDNYfh4phEtF8gCv5hRQjtNS3QYmPzHE9xOn4P
	 kozD4CP6feiA/KM88wvzxaWd85+9815ahXImSg1nImjujsysKtnzU7yxOQW8qxFOuf4zo
	 uc6Q0PEA97r66lqjKxoGcGiH4HY08t+f1eVcJM9Z8R0TKqFheRf4lo3jqizMuNdwbLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795374852;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=SPoTViWJGHL7QSLz+I0tDgbdnIX9thSbIOpbmEgxuw8=;
	b=pEF7TjXcTtXWXaB3u7AubE6nMCqpIuqKGvkA2ibbSNfoNX6i4gjgbrj9jxjjNmzZ1gGN
	 hI2Yh0pHh8mIv0QxJduRlPeyCD17HXWHsgwqmaqnZ6B6pSR0wycoK9G8Si/dcOq/YGJvb
	 QwYpaeyGTmdE5PanWDdxm6GwN3f8kHUzz2royeAb+91eu74BNoq7QaFqIQmN2LTkQ0zDF
	 49HnU98wAv8pf4GVVYGKfOTV05Tabs0LeYoUiNacufKOHANPcdPtA1UOVycmAZvhpjjVG
	 z5UyYQ5P/TJf6c1qFdc9vrz4q2O5MZTwkTl6MVFFyGEYGK/YQQEKm+MsIp8ToBrowIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZpAwrYuL;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=I+9gw4J3;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4AC606A32C
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 19:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C4AC606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZpAwrYuL;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=I+9gw4J3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795374850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SPoTViWJGHL7QSLz+I0tDgbdnIX9thSbIOpbmEgxuw8=;
	b=ZpAwrYuLf5EdLloLxtncynvxdkf3IrcU3uWbIR/1vn8nDClXS68XwwZqoZEaHb4EEWypM7
	if1l767wKwZ72NATFFD+S78SrI6tfnWhXMGf6KGmtG31XeFcBx1KlJPtHHT/yLha4LI1b3
	bO8IaXfLRF2/9MoTLpg/x08hhJSGBzw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-3AKGMwwePRGa7HCd9QJqww-1; Sun, 22 Nov 2026 19:14:08 +0000
X-MC-Unique: 3AKGMwwePRGa7HCd9QJqww-1
X-Mimecast-MFC-AGG-ID: 3AKGMwwePRGa7HCd9QJqww_1795374847
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4a647e776b4so1848385f8f.1
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 11:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795374847; x=1795979647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SPoTViWJGHL7QSLz+I0tDgbdnIX9thSbIOpbmEgxuw8=;
        b=I+9gw4J3CXiFaFKNO8WIQqKcUIlUxmMmLmeqeDzziAmXvCXmDmgPzFJrv1qGn61o9i
         Lr3kEFiyPxYYT8ELEJS2aIroU6GwFekZNB7ohrLW5gm97gAwuRUbv0cNOZtkdNjHtO9+
         P2MyFgopF4CcvZij8UHwjiiicla7IY2Pr6o2anJI+75rTB6OJPfQlIFQCKA0PWmHPN04
         3qQy0rnJRuECatkNhiUkUEWO48rl5O8aNwbGNRr5NpqaMTlizV0rZipvIs8odH/R1le/
         ZWNM0BdgolBZ5KBFI2ImmGtSGSCALIH9dX+t2tmX8p33ZpQngxHj6NZlnuDEQT2drhLO
         2EkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795374847; x=1795979647;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SPoTViWJGHL7QSLz+I0tDgbdnIX9thSbIOpbmEgxuw8=;
        b=Hh0BFXh7uZGftBSU4r2lzfChjpGaoRBgT/RGqxHStVr/JkBzKlgF3kQhkoPqLKkXV5
         SofWaV4DVVre9VoMTrH1J+QLJsNEUWyU/PBh3HS8l8N/LwF4kBTzPn5awkoSoJFqFnjt
         AU4YvMnUhs+b99rXX9gpG+CoyF1oEoApQ6/Fa7OfCeStlzJ7szYkrfcbP4+WKVkv25z0
         4Z2OrM6xcdEyOgJtv7+wHPNdiIEXY4HHt1seB8nSX03Jcm4okq0UFiR/Bg2t6UG+PgcL
         5X2/QJ0LHg82Gej9DrHepe4RJu+kSTQ/UCiW9Os+MbbvENhjQWHA4J4Ew5TRBk78SB+a
         fUYQ==
X-Forwarded-Encrypted: i=1; AL+hErFPbBOpZ3xgmAwKgunMpOSv61VLqflFbYQOcN+33IVUC1qX7YpAL5Y8EFMFbbZhIKuY2YcWKAI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/3XvCzBBzW3MKBFYPyk9t963y91jx54nt8ZXPO7rnxILV5Jqge
	o8a6s/wEo71CavWlmx70lRPYC+FFbX9qOhkEDBB6FkELXGvZCZpAu0FEhOpcrYJyAAecufUjUn1
	pB7wIZxzzirRZD2W4RC+A4fV4fzBh+zHMhod1jk2aHflH3RMkW9QT67rv5A==
X-Gm-Gg: AZFdTZeFRv9ML8tEuwR8+7OLP9AdV7lZeZ/sEs0b2gdQWK68tOwSKbCk96ky2e6mlUC
	lpXqtpzVuZE+TroQGw0hH1ua58c4uhalFDYGzCq7BNscVqohNIUe8ZMfBSRd+qrT/3SXbXBeBUg
	IPEj4vhpYpcTlNfJ/V8vTKxlnfOGaRQmyMene/6ecgY8rCSRz6QQfIIZUHxybPVcyH/2/53p/9g
	Zz8E3s5Sh/mRuuUwVeG4t0VZxiIoWyFfRWIXuhbtt3O8XBIj1Elbb9C/gMOrAe5uknTQAgKfAfa
	S2OGC+5Hd0F58HtMqnLj1k9P/bWWmP0wPXstdGBZYui3KGgiaNHF0ksvqrSR2FM1fIO9UuKqLit
	SjUL/ObLSj8MUHckNf/7nq+hN3GROX6owcS3r+7P5
X-Received: by 2002:a05:600c:3b8c:b0:4b7:6c16:7b43 with SMTP id 5b1f17b1804b1-4bb8881d019mr195708795e9.10.1795374847322;
        Sun, 22 Nov 2026 11:14:07 -0800 (PST)
X-Received: by 2002:a05:600c:3b8c:b0:4b7:6c16:7b43 with SMTP id 5b1f17b1804b1-4bb8881d019mr195708385e9.10.1795374846810;
        Sun, 22 Nov 2026 11:14:06 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1524:9e00:c39b:a740:e7:3fcf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90660cb4sm198874085e9.2.2026.11.22.11.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 11:14:06 -0800 (PST)
Date: Sun, 22 Nov 2026 14:14:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] vhost/net: bound the count of VHOST_SET_FEATURES_ARRAY
Message-ID: <20261122134901-mutt-send-email-mst@kernel.org>
References: <20261122092235-mutt-send-email-mst@kernel.org>
 <20261122143829.2674252-1-hengyul@cs.unc.edu>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261122143829.2674252-1-hengyul@cs.unc.edu>

On Sun, Nov 22, 2026 at 09:38:29AM -0500, Hengyu Liang wrote:
> On Sun, Nov 22, 2026 at 09:25:37AM -0500, Michael S. Tsirkin wrote:
> > this is followed by:
> >
> >                 virtio_features_zero(all_features);
> >                 argp += sizeof(u64);
> >                 copied = min(count, (u64)VIRTIO_FEATURES_U64S);
> >                 if (copy_from_user(all_features, argp, copied * sizeof(u64)))
> >                         return -EFAULT;
> >
> > copies at most 8 bytes.
> >
> >
> > did you test that this patch actually helps anything?
> 
> That first copy is bounded, yes. The unbounded part is the loop right
> after it, which is outside the diff context:
> 
> 		for (i = copied; i < count; ++i) {
> 			if (copy_from_user(&features, featurep + 1 + i,
> 					   sizeof(features)))
> 				return -EFAULT;
> 			if (features)
> 				return -EOPNOTSUPP;
> 		}

I see. So all it is doing is checking that these features
are > 0 and erroring out.
Let's just not do it - we don't have to.


> It reads one u64 per iteration up to the count from user space. With
> count = U64_MAX and a large zero-filled mapping, it only stops at the
> first unreadable address.
> 
> Yes, I tested it, on the vhost tree at 44293796526f (KASAN + lockdep),
> count = U64_MAX:
> 
>   1 GiB zero-filled mapping:
>     without the patch: EFAULT after 27.4 s
>     with the patch:    E2BIG at once
> 
>   2 GiB mapping, SIGKILL sent 1 s into the ioctl:
>     without the patch: the process is reaped 46.7 s after the kill
>     with the patch:    the ioctl has already returned
> 
> I have a small reproducer (a few lines of C). Since I found this with
> the help of an LLM, Documentation/process/security-bugs.rst asks me to
> treat it as public and not post the reproducer to a public list, so I
> have not included it here. I am happy to send it to you off-list if it
> would help.
> 
> Thanks,
> Hengyu
