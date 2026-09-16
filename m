Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955564AAC44
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573136; cv=none; b=Q1u2asOIyZxefV1x6vOTC5bs7mkyIpWqY9BGi9D3zKirPk3ow6oGVaEX/3A8arRLAQozenR40hosQbNb92+SklT+zl3iSB07pIZkHh7XbZcipJXdT91W/8t8cV0DOnz3jgzwdkGyjoSpFd5PXaBB6yNa8TCy6MbEOCYv+l0YrL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573136; c=relaxed/simple;
	bh=huEs+LEHo8cFHfOkkR7JHzzpk8mAxFJ2h/PPE9NkvtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lw5qlWchvZvlaB/usmu/qAA1mKz0DUikQZ8FVgr9rZGSbmytMuW/5pFrCvdRlB3P4aYNbx67Q635Jkne71O7iTL9PIoU0ee9Cb6zN2tg4AZgTKUpsEygElMIcL9+9JNtuGTWJ5BCPPBy+6xeXJ/79/z+1VeTDxhuOrlOrmi4nPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bhJDkRgu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cOe2/Vn1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhJDkRgu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cOe2/Vn1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789573124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QJCqqA6Q4AOgIHS7UBKFb/3fKqTDi7g5pa0Z96svO8U=;
	b=bhJDkRgujq0iWc9JPmHM0rD7BoafFpOkDfsW/CHeLT/A99pLbMQp5Nj6kU18QScFiyA3hq
	PCyUu2zVOQQqC3VsPClc8/rsYy1UOgLK0SQawtWDOxKN6c8SyTY5lmh6Q1Oia8x7Zeq8cf
	ZDWskb+i1dSydTGijN0hXFlgHkvKNT8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-piOLPy3WMuWMxpOvWWs-fQ-1; Wed, 16 Sep 2026 11:38:42 -0400
X-MC-Unique: piOLPy3WMuWMxpOvWWs-fQ-1
X-Mimecast-MFC-AGG-ID: piOLPy3WMuWMxpOvWWs-fQ_1789573121
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-472c330e555so2611749f8f.1
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 08:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789573121; x=1790177921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QJCqqA6Q4AOgIHS7UBKFb/3fKqTDi7g5pa0Z96svO8U=;
        b=cOe2/Vn170kHRte8QHpTEwRT0IGE6bNpHwsgcDSTrDNKlxg1DaMWVpOopu8uj/JNY2
         4q7Lv3421UqsGckKANvR3YbYA+CrzqYL+MC8vvBx8UdFQwrwDAwlpJnYTEq0Shr+0PMn
         fqtmDzko+Xu+fCdbLWSafAAWBBdx/oYBl23qCChtL72+6NFHUXMSlQxzrwfHl/l2WbVz
         jJs4vBlUMPN3lEkzmHxFTamcl0dgzXm9hSnabfXsQk/lNPVC0uuoDil59R6y8Iatw6VT
         sYHYWzQ4fzyQkEIbhK8Tllwe2Q2jzJGNaHsN4OYv8YYYE+IJ75eCtcg7KT2Lhwxz7PnV
         SDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789573121; x=1790177921;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QJCqqA6Q4AOgIHS7UBKFb/3fKqTDi7g5pa0Z96svO8U=;
        b=0Z5Kq2bqGc3JRxnoLAqOMWqSQvoGxAqyutvbio6EcDgO3FkWeluRJqK7d38JiLHjj8
         CgRh7U+ktuRMKLmuf3xH+YEjfyg4fxvdEBDiah/1R+6nEDB6LmcqPlK2c6nSoew49tY2
         Cy10+9urarEbQAZS4Xbebqj8Bd8Y+yL6dFn9k9tdchyaQdLZTWmDlOviJ3wiAMhFVxhM
         TkG/RmPGb8rhGYjMxuXi7JYTIqflAZ4nVDJWoKXDOE1YkJMHJTVqBSEAaugQEkj5QRkW
         IMuKUblBtQPr8CjVPFVGi4xxybcuG1kZuomoSUzvrAhKmQ7hlzSgqRbkP+k0mMPjZEK6
         +NFA==
X-Forwarded-Encrypted: i=1; AKwUvBwG6h+hbYDe44U4V7xm3J3LNGK91Tfv+9E8/JToWOsTx0v7Ma+7BJrLm5SS/swapSVs/pqPW7E=@vger.kernel.org
X-Gm-Message-State: AFuF++nLNcOG1btDelYo0KXa7eH/MNPMm0vCPI278PCTZ0s3rh48Iz0/
	Cysy0OtKFyabYEXTPh8VKvuw0ZIaspl5gN4mekHNTRkI3iKekFGTjr+c8cTtPtbe0OfXF37psVm
	rSLJFT5r1clxa6lzx/fmEiNSMWgVsxAYn8IILqX4J27Zd4jf36D8V4/xMNg==
X-Gm-Gg: AYBFou28GaXgAcRT/bvmvV77h09SkotL6mwQo3f40qVHxIFoTZJLD3sxDo/sjn0oxCM
	I2l7VlgXtYbQb69ufJ+wmVayGiX1wL3fU9GObi4LGg9kWnySTkjskon0wUy6sYBDLbUgjbEHWY4
	tpsjKRe8KtcmttdPFJ5biqhQtj75cXweGhCdbgn7hROXybo08CAMim2qqUUBnlGy2H6voE6/uyX
	LDxiVJZQC/zaALu6FxzWHBKUQXHLFEd/wbe9boWS3wnIzYXwhOkkt59JPCQP72A8jVEDMEeQric
	GdKgZ6cZRJ/6X1v6oJwFcdiqe5GBSoCobAec/vMnkLxSwQk4usg6S1szi+q28xHZFFv7giKmkh6
	joJXKFKX2B8FqTHqAOU81bMAOgc4cJ22RnvXStz9aArk4sA==
X-Received: by 2002:a05:6000:4711:b0:487:fb0:9ff with SMTP id ffacd0b85a97d-4870fb00af5mr2913411f8f.22.1789573121105;
        Wed, 16 Sep 2026 08:38:41 -0700 (PDT)
X-Received: by 2002:a05:6000:4711:b0:487:fb0:9ff with SMTP id ffacd0b85a97d-4870fb00af5mr2913360f8f.22.1789573120615;
        Wed, 16 Sep 2026 08:38:40 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf1fad3sm7165977f8f.12.2026.09.16.08.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 08:38:40 -0700 (PDT)
Date: Wed, 16 Sep 2026 17:38:28 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: Bobby Eshleman <bobbyeshleman@meta.com>, 
	Luigi Leonardi <leonardi@redhat.com>, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] vsock: ignore empty child namespace mode writes
Message-ID: <aqq3t5p0hN2jsSpT@sgarzare-redhat>
References: <20260915141547.3010692-1-qwe.aldo@gmail.com>
 <20260915173050.3176344-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260915173050.3176344-1-qwe.aldo@gmail.com>

On Tue, Sep 15, 2026 at 02:30:50PM -0300, Aldo Ariel Panzardo wrote:
>__vsock_net_mode_string() returns success without updating new_mode when
>the transfer length is zero. Its caller then reads the uninitialized enum
>and may permanently store a stack-derived value in the write-once child
>mode.
>
>Return before calling __vsock_net_mode_string() when *lenp is zero so
>that the helper is never invoked with nothing to parse and new_mode is
>never read uninitialized. This also prevents an empty write from
>locking the current mode.
>
>Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
>Cc: stable@vger.kernel.org
>Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
>Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
>---
>
>Changes in v3:
>  - Move the !*lenp early return before __vsock_net_mode_string()
>    instead of after it, as suggested by Stefano Garzarella.
>  - Add missing maintainer CCs per get_maintainer.pl.
>  - Add Luigi's Reviewed-by.
>
>Changes in v2:
>  - Return early instead of initializing new_mode to the current
>    value, which would silently consume the write-once transition.
>
> net/vmw_vsock/af_vsock.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 622dbd0467..XXXXXXX 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -2879,6 +2879,9 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
>
> 	net = container_of(table->data, struct net, vsock.child_ns_mode);
>
>+	if (!*lenp)
>+		return 0;
>+

I would have moved it even before the net assignmet, but in any case, it 
doesn't make much difference:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

