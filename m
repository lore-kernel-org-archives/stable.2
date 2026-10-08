Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114F94B7A48
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 14:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470598; cv=none; b=Z3RWOfYgUxmYNPdWf18FRu7IWTdeidkGFpQHcq12t8Azo56kWyvBBGAb2+EZ6IsZ23D2pyv2IQ37OagZOcvutuOknPj+C5LPkGaM+eoL4Vqce/obMDF2xjw9semQAxBN3xDTOr68062Jpc0ORypKbgXys4ovZ+RC82QQ9wRdpow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470598; c=relaxed/simple;
	bh=bVSz5b56bkzLjbvZW0ZLHPuGtjffYa78eWvGcdS66xM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jXXq00dZccv19Fqed4Fr1bqeYeZtvOW2cq+oWbw29+dpPPqYQiVxhpsWolz0orxYBsRc5PQYlU8Es0nFoS6juuuLK04IhVbqoRJqP8SaRngmlU3Lkenamwz/6h6MWaCMmj7A8VHHWzHG3kKjVJcNASi3eO28NMMLTTJyVvjurM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fj9gfpeB; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fj9gfpeB"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48b02a2359aso866126f8f.0
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 07:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791470595; x=1792075395; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=njenST8z+MlCZJXnP+cCIOtU5L3jm/Pu2Fkh+12SdlQ=;
        b=Fj9gfpeBbMrhhd0fZvS6MBSCZAqK7a3Hg7/wEwYoa/XQr25FSdqUhn5v0t+9DDzSBM
         gRGX2oqqqW+OTrtzobfz2Y6r/BD5cRsKoXNqzmu8rz+c7sJMZSP8UdRKVFU51rnIcRVF
         A8zV9e/mOEqhY3t3EgxzQxmTTxQmhVDzavLUrRYHBdeeiouRU5rXLakCrRX0fSCQLyLx
         a1AuSfLh2GFbUI6X8gQ17JKmbOBI4JZwLJwVCuBaER3Wqsp8nv6Yo8mJVzEENC7NcCa/
         c/5gtN8y763uHwpGzyRMPt9l7j6joXAmWaVttLhGICK0DsHplSE6XBjLFeYNAsJx554Q
         8i0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791470595; x=1792075395;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=njenST8z+MlCZJXnP+cCIOtU5L3jm/Pu2Fkh+12SdlQ=;
        b=AewoKsPMvkie5vHNlZZfjWD+07JapeapiZI9dnplIAdPgfufgHpfjJqdN29oF8Q9bH
         Q9ROHuHs1pSKlxBYuH2UOQG8+cp+gq5OWBLLYCLE25Ua+HWiV5i7HRYe5xqJxgLl82gB
         nj/7IdM9JHr1QGpi4PdRsnR11v8Ec4jieXURbA1+pDMCFOyYQt/fHviyLa1k4S96W8MV
         Km/KukaOSWow3mqVWCciFJKBk8VvWc5mOwhb01NIIS+y1E0jHemGkCIpx0/cZ9e21vQv
         BIanFvUurGChgLGVWUAwVsYs40jdJlOoltOz033w5D1N7zejxhPRRHF9TFAnK3/lyDo+
         O5qQ==
X-Forwarded-Encrypted: i=1; AKwUvBwlon6t3UBj6LZlUIevcUiPksKjAG6nZf5jl3P6fRtrCw2CyybqEw7N3zylmyH4ipBv/BA7Ltc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIfZm+tIKiuXgGDdsMsxpEtL+Adf4vkuex0IRGGk8ze8j5y+Iup
	aAsVJlMf+84I4H7wnG2GnwyuPaxobC/cXnEBdMEr9M0NWkHrq5AGIyFD
X-Gm-Gg: AYBFou3jF3B2tjG9xiWrOxQh+T9h0hpANF7FizPcNFH2iq5zc0O7thxTKzRa/y/DERu
	a4GFcapPNG2yXdNGrYVgDZjpUam3wQKaHnpJ9UdebJSWyWW7ore+paWeXrBXhjbCVJrxTgqbNCl
	Ah9VDuuUu2WXyYb8az6MmnWOhY9Y03flqwgVj3VMGQYtHSS9gIvZSvhsxs3vljkQ0qUk4pNtsO/
	Mixk90zebBftSDSpcZiWegDCRYJz0g1pj/+FPe4zqXn5fQXInPMVZGbd4GYs9BdGyovqdZWdWsA
	pM4XL6KUpNtoEITd4cRkz7v/MMHHdq+xd88z6k4d4QZg5YKq5mGR8+LcZMV80CVJzsDKScLiMil
	wrqwcmkGZeApawLU2V/HgjfqC2DASujXgYDgFrOAEdJfeF3Bv0/wMvOz0nRmDFfSYc+4cWp8bIz
	ZU6JgljMAVHtPonv0RXK5hK+vfQQAEkN3Xl6CCaBk1goozYe5IsGXrfWnOBnn9G/mx+geMxBgA9
	VDkXZFaHJM/smPiP24c0Gz/hI8KEY0NTqRbN5F2cfC/QZcmTOrcajNVY6s96EDytONFKyzsGxKv
	gQfD80GEpYtp3RhRVz7GOGSwGhmx
X-Received: by 2002:a05:6000:46c7:b0:488:8347:a110 with SMTP id ffacd0b85a97d-48c7ee936a3mr3668082f8f.7.1791470595152;
        Thu, 08 Oct 2026 07:43:15 -0700 (PDT)
Received: from [10.54.182.141] (82-132-212-209.dab.02.net. [82.132.212.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d1ffd2sm11381000f8f.34.2026.10.08.07.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 07:43:14 -0700 (PDT)
Message-ID: <20b406ac-94ec-4b0f-a307-08082092ae08@gmail.com>
Date: Thu, 8 Oct 2026 15:43:05 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring/cmd_net: prevent infinite retry loop on
 unextractable timestamp skb
To: Bui Viet Dung <dungvn2345@gmail.com>, Jens Axboe <axboe@kernel.dk>
Cc: Willem de Bruijn <willemb@google.com>, lollipopkit <a@lolli.tech>,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261008050745.498415-1-dungvn2345@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261008050745.498415-1-dungvn2345@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/26 06:07, Bui Viet Dung wrote:
> In io_uring_cmd_timestamp(), the skb processing loop terminates whenever
> io_process_timestamp_skb() returns a non-zero value. If the failure is
> due to a full CQ ring (-ENOBUFS), the loop stops and returns -ENOBUFS,
> ending the multishot command so userspace can drain the CQ.
> 
> However, if io_process_timestamp_skb() fails because
> skb_get_tx_timestamp() returns a negative error (such as -ENOENT when a
> timestamp cannot be extracted due to changed socket options or absent
> hardware timestamp data), ret is not -ENOBUFS. The unhandled skb is
> then spliced back onto the head of sk->sk_error_queue and the function
> returns -EAGAIN.
> 
> Because -EAGAIN leaves the multishot apoll armed on EPOLLERR, and the
> unextractable skb remains in sk_error_queue asserting EPOLLERR,
> io_uring_cmd_timestamp() is immediately re-invoked on the same skb.
> This results in an infinite busy-loop consuming 100% CPU and completely
> blocking progress on any subsequent valid timestamp packets queued behind
> it.
> 
> Only break out of the processing loop when CQ space is exhausted
> (ret == -ENOBUFS). For skbs where timestamp extraction fails, dequeue and
> consume the invalid skb matching the behavior of sock_recv_errqueue(),
> allowing the queue to make forward progress.
> 
> The issue was discovered via manual code audit of io_uring/cmd_net.c
> and review of the error handling paths in TX_TIMESTAMP command.
> 
> Fixes: 9e4ed359b8ef ("io_uring/netcmd: add tx timestamping cmd support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bui Viet Dung <dungvn2345@gmail.com>
> ---
>   io_uring/cmd_net.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/io_uring/cmd_net.c b/io_uring/cmd_net.c
> index 90d4ec7cc761..a5a1b8b66b1f 100644
> --- a/io_uring/cmd_net.c
> +++ b/io_uring/cmd_net.c
> @@ -138,7 +138,7 @@ static int io_uring_cmd_timestamp(struct socket *sock,
>   		if (!skb)
>   			break;
>   		ret = io_process_timestamp_skb(cmd, sk, skb, issue_flags);
> -		if (ret)
> +		if (ret == -ENOBUFS)
>   			break;

Sounds fine since there are only timestamp skbs in this list, do
you have a test case?

-- 
Pavel Begunkov

