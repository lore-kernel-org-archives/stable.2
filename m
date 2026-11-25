Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795605627;
	b=gJR/moAQXx/vi9OkkRSRpQibVF19sVYqGStDjm8kBOtY9iBPGarREinQ/+JBduUw/Wsn
	 hoG46Vi1NJ9Fm0Nzyp9BaWePS0NT/TXRLatJNlw6gEWLEaA5yxFknCT0My29/DtksrTw+
	 Y7ncjRA+PK3RwiKdrSXOCmEwzFw227L4dy5xRguG28Lo9ORzGtvrMWCdvHM/axGZ8WUs1
	 2PSDhwpR47CgD7X82OLVu2ERGrlEPSeOk7cXEKWoz81Cajmxcfw/2EKsFgmyKhtYa2bC1
	 6GZxqIG2/BhHALJJAG4a8Bx4wlazNw+BMt6GDlzKRR7CgdsaoUT/83YTPQFT0m8JxzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605627;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=/OU0PI8ciyVjraR4T19Cul10vgtOe6ygyMSUrcMCTI0=;
	b=y4zuoKBNPePj7o681JUogXewkUpjiARoQY5ydTBnf5O+ZZfZhqhwCuhoN+Lvn+lxcCiI
	 PYD32nL7UyUGdSAPLWO02QeaFTC+ubLKDUHkVza36bpInXdmFybke86BgOkX27S2qT3SE
	 7Ys85piKJVPiYLacRgOJ27o+Pn1DVyJ7OrB/pO/B/60r8k8KykIPkTWxwMH7XKbZpsDwx
	 Y700rSGcMWbNhyHGAPsY2a6YB4pYNiEgkhdC0suGiojAgbTDOioZjgxsHo8QssrFbzdGX
	 N22DRJS6OJAZz/f76SJvYSSgLZx8gVC0e28eg3VykAqhTiaCNxIQ8fVFi/dLk1UKfww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IYWlv2F5;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=XLZ2kSEJ;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C0A606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8C0A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IYWlv2F5;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=XLZ2kSEJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795605625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/OU0PI8ciyVjraR4T19Cul10vgtOe6ygyMSUrcMCTI0=;
	b=IYWlv2F5BwxqmTofVSz7YQqFYfjlPsWVUr2/9fiVee0GP100/5vA/Hfb5OguaH63OYRVsn
	pIYhFTDDNdxBRcHVgIODSZ4+eWC9zWYPmjjQvrnaYWzGJLqOpwuWQL/0ovDztx1fiiynI3
	9uSWLE1SxKC0sADMYQ9UHolyXgQE/XU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-Z66-d_RbMlamOmB-j7DkXg-1; Wed, 25 Nov 2026 11:20:23 +0000
X-MC-Unique: Z66-d_RbMlamOmB-j7DkXg-1
X-Mimecast-MFC-AGG-ID: Z66-d_RbMlamOmB-j7DkXg_1795605622
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a1fdde384cso39247505e9.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 03:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795605622; x=1796210422; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/OU0PI8ciyVjraR4T19Cul10vgtOe6ygyMSUrcMCTI0=;
        b=XLZ2kSEJruI5GD8L2ZcmRVo2suX0U6gqsHsw4W+Snn11KpFT0u2yuOXltCX3dosUXF
         WN2BxWMUToepJeKSe9IzhkdHilOH8cVx7O9aARtvD9MYximwv4gTIUs4pY0YEKFyozEE
         UbQg4Ko6+CwcJZDcbZsaas3ml4/zLKe4nYhn5nKAkmGrd0Nc4WZOFKME5HTxMLMxeJAu
         8r8xut5ydUEz0Zt3P/ntcHTDEfV7L9PyfI0oTAGv9MiYx5wXY8tKxa7xcrZYJoC+Sa0s
         gBGo4TlSiOExzgkOex4MKyb088KhpHOVb1guTI6IxSbBIYC/N6z+fB0DyhNUnUowNevq
         x0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795605622; x=1796210422;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/OU0PI8ciyVjraR4T19Cul10vgtOe6ygyMSUrcMCTI0=;
        b=vd8KHpGMjEmgsdkXMmQmW2qU9IeGWdggDR/EgjV7OH+WZ/x3FJy/7ShcsttQPLcxfV
         XAhHUXzn6AYsSDG9MH6048+H1aZKbqE0Iq2rrz9EkjqSIoUV0s/huq/NE+ZsBYj/gioB
         3qlC89nGZplI3ocDIAzjk3FLwXC4fnIXsmSBGdQaK9f8QLLckO8C4wkwXcO1ID+hryDP
         5r4Rsic7GC/pI/okzp0yJmwIdB1F9WEjPvAdYeuouQFc+arfZA7yGMeYhzSjUtaA+lFk
         8Y5AEIXLWS9Zrxytia3i26cP8A5XjDhWHLKmpFnl4fSWbQq0S4uxgarlhtZPqi++gp+X
         dQow==
X-Forwarded-Encrypted: i=1; AL+hErHsHmAkfsN5g8n8PdOEESUu24vVRYkAsM+0NAPqsAAWRXoHbwDK1rJKj+Z7qvAcwOXvIoNYOj4=@vger.kernel.org
X-Gm-Message-State: APuU4Z89pgq2jLFVn1oANCIKXeAZ955MZL7mORXv8YrQIMOyqDcvkRso
	jey9fXZTqG93Osl0mUwPVTYYH+eSB5hPZ+gX+MdQAUizGhxPz+9QgIANflKgx0CQ+XlXnhWnCqp
	MfsYmyRUMoxpPtDqhm174wk6gkhy7ltZzq5mS0hwjKLnbbxeHQN0IE+mSGw==
X-Gm-Gg: AZFdTZcjYsxgG+VnGc8LryALJ7TumNrKGuiQpukIPBQaoXQ2acokM4pNcgq1QzSxiXu
	OATmWGKRsytH9FZZvofG+gQMgE2EEQfHalOcpdaCGYQ9B/fJWDoAuaNVoDKVkTNMzcQ53qw+Dp5
	D5xsej46hYQ/WL6i9rjYNEhhQpk9sNgdR/gj22vkZHhdYit1SZsOFbkKW0tQdYUwyHE9mrnhhSW
	GKdbg+2ep7fbeLGE0Tt0qazzQhKwFG8ntqQhpUpq04AxzqSdI+AsKjBrRXhjylE048hDjqOE7nW
	WW1NIn6ON9SU4dLJz7FUn1hqPii1EhiznDtos9dVSscLZxFv4T5lGXjv0O9APRYZhvmUjjLRdYM
	BVM6II6m9m49sY9KiS3g9YSf1B5H2M7OA0uqzThfJUG+TlorYJFMpaKM+H9In9tdzXzUo0X+MDF
	KLJli4lTWNNHiD90Vs91cE2yJ3LDJfpjKnx/lFA+3m1Vt/
X-Received: by 2002:a05:600c:638f:b0:4bb:6752:8400 with SMTP id 5b1f17b1804b1-4bb8881a2bbmr321271125e9.17.1795605622511;
        Wed, 25 Nov 2026 03:20:22 -0800 (PST)
X-Received: by 2002:a05:600c:638f:b0:4bb:6752:8400 with SMTP id 5b1f17b1804b1-4bb8881a2bbmr321270755e9.17.1795605622152;
        Wed, 25 Nov 2026 03:20:22 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a9846sm601076005e9.11.2026.11.25.03.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 03:20:21 -0800 (PST)
Message-ID: <5f93ca8c-fe7c-45ec-9b88-4817d1b6a543@redhat.com>
Date: Wed, 25 Nov 2026 12:20:20 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] ip_gre: fix stale header length after erspan
 version change
To: Henry Martin <bsdhenrymartin@gmail.com>, dsahern@kernel.org,
 idosch@nvidia.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, horms@kernel.org, yanhaishuang@cmss.chinamobile.com
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
References: <20261125074617.629026-1-bsdhenrymartin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261125074617.629026-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/25/26 08:46, Henry Martin wrote:
> @@ -1499,6 +1506,7 @@ static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],
>   	struct ip_tunnel_parm_kern p;
>   	__u32 fwmark = t->fwmark;
>   	int err;
> +	int hlen;
>   
>   	if (!rtnl_dev_link_net_capable(dev, t->net))
>   		return -EPERM;
> @@ -1509,11 +1517,28 @@ static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],
>   		return -EOPNOTSUPP;
>   	}
>   
> +	hlen = t->hlen;

This is weird. The patch is broken, but it compiles successfully
(on some slice of the CI) because the first chunk is applied without
fuzz in the wrong context. Still causes CI build issues:

https://netdev-ctrl.bots.linux.dev/logs/vmksft/net-dbg/results/926627/build/stderr

Minor nit: also reverse christmas tree order in the first chunk

/P

