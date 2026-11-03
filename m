Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690531;
	b=ZgXFkUNQaXlgIkg72W98waWceL+3CsEFx5Hrz1GJ+a4toEzOPYROmU4DXEY+QetZjHgg
	 6eg4TLi5SAqw8gQe1ZqFh6aUIYTOxf831SpOojbsPVEsIrJMbB87szHoMYUhIQWGYRRkR
	 /u5u3B6JNjpVrHd5VY4oSuGXRwsjWSfYwk82nSCRUpbmqNrasoCrB8wzuomfoGPAKXKQ+
	 Ly3d3mzgNcN6xv39VkqwSxjqR1tx76FMaQU0KkMlMH7cU9hOzQcf92Q07a1aY6v6I7ad3
	 SXqi0IGlE6mwck49vzsIB0l1oToWsTa1q9anvE7ezCkPMJ5vwi24k2+xksuG5J9VSKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690531;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=aU0Fo/t+9JMAeVCzpMHJlOqMoWJ9Ex7tTQwt5AkyeMU=;
	b=i3Gz4WR/ajP2aI0q5ivfXpmtsUrX3HQ7QyrM+xEtKbrnSIBHRAOAXCZNUAVAXf5z3fig
	 lTJrGZxriWRf86Xl4vn9j7RbTezNnoPmcnIBryr0KaXEcnj2fxqioT2WOy6cUmC+TPAuc
	 FPCzkB4cM1vLx1ziJu+zVArEQ+oPKmp9Ow/Ow8xkFfKV1V92KkZqY84Zvl8yv5Od0ApUb
	 3lOjzV2gDi/EZewKR2Sl8JlOhxv9A738gpdVqZ9Mgm4t8uuxZyvcresq9b7bEGLS7psV5
	 GLiDwA8Eg1LJepJMNr42pdEXuGAVC/+cWoHHVUl+fJceRa00Bwm77mXM+qr5pt15Pug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=odyE8Yx6;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7E5606A32F
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 07:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F7E5606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=odyE8Yx6
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a214af2076so28729415e9.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 23:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793690529; x=1794295329; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aU0Fo/t+9JMAeVCzpMHJlOqMoWJ9Ex7tTQwt5AkyeMU=;
        b=odyE8Yx65t7UsqvcKqLhGzKhrrqO8u63aeWrdMumgLCHNAkRMRNKLZ94Fdb4ABER4G
         Xqxm/dhzsDrYsM3LYV2j6/Iw8zJ42pkhJsIT+AHkvC0LD4ak4XsSszP8mU+ocuZ7G8iO
         RLbQOxQfAiqF5C7K2pXjz1ukuvWPTDx4eQkaPV4WjOrugqcyHQ155B+DRXG8EqpS+iHs
         cimiWx/UsmQHZW12PGCdfs5k6bNUs4XBVMhSfJv6lgEdTjGiQOOKtC7Ew1BVUxLe8OsK
         31D0UZANQTVx0TNw12/y7SFZvysT0hxyv/YuVw4lPEREjVVGLY6cDMFr+FCmkwojsSA3
         6JQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793690529; x=1794295329;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aU0Fo/t+9JMAeVCzpMHJlOqMoWJ9Ex7tTQwt5AkyeMU=;
        b=vO6LV2GAHw58hDgS4AFNaY8C9woKwdmbOJdqlsnADZzIMX1OPkAC7EpDrH9lOL1Qdg
         QTfJ6HtP7LaxXcS1r9K8cR0IahhwXZGxHDk2Odp6qtULtwnC2V8W67YsIAjsxBfldhKA
         BMePUeO4VZt/9SVxIW0K8Cw4U2WeVWfn5RIzJDwHZJ8me+aMwAltIudMpMTXaWDurbkB
         54uvarNzAKwpw++bKFvXbSfohdG6Y6ToJum9DdXIM3qiIyI8DA+nOarwCR47OxvUorNV
         MSqwPh/vVtxuYIU+W519Xo/3RwqKkACaVRSqNR/7LvFWAzSF/byIKhU/ZxCZVy9ZyC0P
         Ybmw==
X-Forwarded-Encrypted: i=1; AKwUvBw1tFsvaNT17FBdqlHXIti8+hJ5MJCaO4e4EVM3yjKD1NqXmMZtxAaaYoX6y1NhInr3VJKNYQU=@vger.kernel.org
X-Gm-Message-State: APuU4Z94ZNvarbi7fCSkS9RA0JrB0s3imwidoeyQJQY+RZrfNh8gWzcy
	OhAHsTtotuqg5bM1bKt8UZId63cik5Q7syajFiaNNNv6VKZgAU6hzQvUy2Mm7w==
X-Gm-Gg: AYBFou36kWsSv0dtFn7ORJLoxXUq/EUw4DawxwHOGyfZJ1kYUpFxSXpwi8vBfoEj+h5
	CEwG/TXHSurQYg/zGneuadeHb4jFgmBNoNZFBMsMyhQKNxXkmexpRS3i46VJ78X1yz4IKaTpvZ5
	X9vCcIjMtU8SdDYTCVgBssrHrDTs7uUb1kDd3+AAYAWf0DSTtFLoijZAbp8QISKbwvZFIDOVNmO
	zLC//KsLvgaBFjjictYyQV8E2AetSfL96yPaLmYwxcrZ9xdvWiUS2p2g7pgW0VGEGVqJK8+dySL
	KxdhPQjGBeAkJmT91sfEWBlsmGu8JczNXpVCsBkvwe35qbApr/sJQmvqOJyGopLiU4zrBfZosej
	tPZFMon6i6RzcqzBNua4kMQaiFvYfD1SfeGDWulziHMxJzrAt8N8b9kna+ZD7bi91PoACse5O+R
	/oZmVTJL4vKliJ96MQleiCw7/BOn/6Llt5XYdTts8By4tA1zWdbra57EJ3liXFD2G/R8qDNM03g
	EpWlwBfR//PwVvqr/Sb4Tgkhu3nuOFymgW/6Cj3Fgw9ubavgAr3F7Yh4z7pMK29dslllrMCN48p
	47IMeP9fmepaTNTAwPSVwFzwHwqol14Ust6NbD5ipMZLnI89/Y66/G0BeZ4MU+Dgb2ZptplpX+F
	vQmgFeuvEoJCCTzInJjnPZlsR3Kz2RO2kTJU=
X-Received: by 2002:a05:600c:190f:b0:4a2:1a:a11d with SMTP id 5b1f17b1804b1-4ac1275c26emr262447705e9.0.1793690528518;
        Mon, 02 Nov 2026 23:22:08 -0800 (PST)
Received: from [10.77.100.5] (ipservice-092-209-215-046.092.209.pools.vodafone-ip.de. [92.209.215.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a80e184esm41772445e9.2.2026.11.02.23.22.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 23:22:08 -0800 (PST)
Message-ID: <2479af7b-7919-434c-a205-14e3b545c9a4@gmail.com>
Date: Tue, 3 Nov 2026 08:22:05 +0100
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
Subject: Re: [PATCH] platform/surface: aggregator: Fix use-after-free in
 ssh_ptl_shutdown()
To: Wentao Liang <vulab@iscas.ac.cn>, hansg@kernel.org
Cc: ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
References: <20260917135607.2154130-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20260917135607.2154130-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 17.09.2026 um 15:56 schrieb Wentao Liang:
> ssh_packet_put() is called on the loop variable of both
> list_for_each_entry() loops in ssh_ptl_shutdown(), freeing the packet
> before the iterator advances past it. Use list_for_each_entry_safe()
> and move pending packets to complete_p, as their links use
> pending_node, so that each loop walks a single list.
> 
> Fixes: c167b9c7e3d6 ("platform/surface: Add Surface Aggregator subsystem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Thanks! Overall valid fix, but similar to Ilpo I'd prefer this to be
two separate patches, and a better commit message for the typo. See below.

With that, feel free to add

Acked-by: Maximilian Luz <luzmaximilian@gmail.com>

> ---
>   drivers/platform/surface/aggregator/ssh_packet_layer.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/surface/aggregator/ssh_packet_layer.c b/drivers/platform/surface/aggregator/ssh_packet_layer.c
> index 3dd22856570f..871780828419 100644
> --- a/drivers/platform/surface/aggregator/ssh_packet_layer.c
> +++ b/drivers/platform/surface/aggregator/ssh_packet_layer.c
> @@ -1983,13 +1983,13 @@ void ssh_ptl_shutdown(struct ssh_ptl *ptl)
>   		smp_mb__before_atomic();
>   		clear_bit(SSH_PACKET_SF_PENDING_BIT, &p->state);
>   
> -		list_move_tail(&p->pending_node, &complete_q);
> +		list_move_tail(&p->pending_node, &complete_p);

This is fixes typo and should be addressed in a separate patch.

>   	}
>   	atomic_set(&ptl->pending.count, 0);
>   	spin_unlock(&ptl->pending.lock);
>   
>   	/* Complete and drop packets on complete_q. */
> -	list_for_each_entry(p, &complete_q, queue_node) {
> +	list_for_each_entry_safe(p, n, &complete_q, queue_node) {
>   		if (!test_and_set_bit(SSH_PACKET_SF_COMPLETED_BIT, &p->state))
>   			__ssh_ptl_complete(p, -ESHUTDOWN);
>   
> @@ -1997,7 +1997,7 @@ void ssh_ptl_shutdown(struct ssh_ptl *ptl)
>   	}
>   
>   	/* Complete and drop packets on complete_p. */
> -	list_for_each_entry(p, &complete_p, pending_node) {
> +	list_for_each_entry_safe(p, n, &complete_p, pending_node) {
>   		if (!test_and_set_bit(SSH_PACKET_SF_COMPLETED_BIT, &p->state))
>   			__ssh_ptl_complete(p, -ESHUTDOWN);
>   

