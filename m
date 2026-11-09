Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794234032;
	b=e7zdaI/OemQ8Ar8HYbUNoQpCCElyrmLfhzj0b9o6f6zUzimcww4xwdb/9j0ZFL6pzPc1
	 LK/uLOmZEV/afkc6ifkNZZrBJPbF6i/WVcxEat6QaRQwKZ0q08cdw5f+qC6RkremMawOw
	 QdrQquzzZSL+gTr8pKrSnX8hg3e5hg4udPXQat71zChJsTiWQYP/x9/T642fL+kPJ3q7u
	 0SKjRA+P95wFzFzA2pl+tQjeciOzsVK+In3sc68ziMi7zGmdkXeJfWU2FFnX91Xpf+ncp
	 RlxYu0t1O41P5xf48SJomWIz3plIEhy5THjfbVKJHCn32ItCjpAoxO0p9tawgwJkNqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794234032;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=hubSjltHAXR5uDS+bxrzSwe1dA3n5xgryNb6ZUfKWAw=;
	b=kJmtIb/OVmoWVXQr3NdX3AwaIYF8Q/tOwsnF7fCfEzaXlVcmm2bzFwOD0okFFhseimpv
	 5A4ukvmS8mFfPCJZ/TPQC9dxZNbfMsvl0MMyAdDIeeOGzYbg1wuGyQrefTWJxeuMeQGCy
	 MoQcqD+EIv0v6zghZ+BUEirIFz9H0sy5LuPr5ZlEiGT/hxeoGNv8jWwKGFurzxU/45dty
	 t5Em4u9B1lfrD6P+6FSpCBE9AgXh5mcHtKWHvVk3EAFu8kZUuh6DlJ9g9jPIyvwKo16T7
	 VP9LqvApowT+oDQC+4BJo5szOUWwEvUqIvl88huWwkeKnmE7ftpIfFm1Fhl7iHtbfIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ieee.org;
	spf=pass smtp.mailfrom=ieee.org;
	dkim=pass header.d=ieee.org header.i=@ieee.org header.a=rsa-sha256 header.s=google header.b=MMjHrPYp;
	arc=none smtp.remote-ip=209.85.160.53
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DD8606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 14:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3DD8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.a=rsa-sha256 header.s=google header.b=MMjHrPYp
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4adba7b3399so322517fac.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 06:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1794234029; x=1794838829; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hubSjltHAXR5uDS+bxrzSwe1dA3n5xgryNb6ZUfKWAw=;
        b=MMjHrPYpfPhWZk8ZjaRup0ksZgMPr1lrBm/bRST8pphRDxk50GNa5QPB71s0C5+061
         FROeJMg5DKbJt28fMuADNYE5mDZ63pt6Fx4ZKkzGY0wZE9xGbRsHVn1nCbxAdbon5Ghk
         RW2vhIUuWnYsu9he9zupLcrk/dfjr4tJgi2DI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794234029; x=1794838829;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hubSjltHAXR5uDS+bxrzSwe1dA3n5xgryNb6ZUfKWAw=;
        b=eUbqYScplzefBnwPFXtofoKPo6rbbMuuE0Ff/qfIsIqgU9ZiSJ+6JRgIsxrN79jGqP
         VjXMcImsC/n7SokqxjRSfttAtQ5TJOAJDRTAQokkJfJVsJBfaTzOxQDv2evNuJCcUcvT
         L3lSOIuRHdl745YMl0kEu7XAy3sjgRs/OvREknEnvfh9HtSq2agcv9+yykHV3YwBUtxU
         4Jw14JeVEKXazef3jiFgxWJ5faZkjAbjMe3Kv8JmlxPIvu4l1RCRtzFcUrMJUVoJuZvK
         JcLl4GwD9shvsbgd/CUh2nVSyxIvKsuibW0OGWsfOZ3QRHWo4l5rdIVZeDrONY31ZK+K
         rKfA==
X-Forwarded-Encrypted: i=1; AL+hErFKJHwssH4UUV78La5mdiP5aQH8kULiE62VKZsSG4KENXKsCniqWFYFE9YEowP16CyZTZsm+l8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+S4glaDQdDMdz4lrwLWNwDiN9Sep20XrS2J2boXTSBNXmdj8fz
	wd8BM1dCYBNr8Odrnckc1RCltfRupFDwzqi9x1yWIw8B0PK29X5UvaXYVSGD9nefIg==
X-Gm-Gg: AYBFou09NNDHITojAMs/hpWGzTTwIWmHtEV8kE8WK0gLstA7+PKeVXfrbHE6U+RAJRU
	0g+LRCy21TF4g0YtOqabV6ab4ydAM3PnHzNxjROGiBXTbCE8Xq774IJXcxWq1sFu7R0anYPjPV/
	AeYzSKsUG3811hEceDpj3OFW4RJHJ+KoOUMZU5DN8zigP3Q8JNoU93NtcS2vNBaD5jJsGf6qmBt
	vAoKX7+k+feBjYyN7mvtWX3k+SiFPqew+aBhB/90evTaeioUJFADJwE8o+tXvvKLe/G6k9O6tbF
	hns3AcamAzgZEnvsTBfYluDJulT3MJGXdc1QtqUJtnsJpBUkDvQ0SgrPU6jh/QlZieTS4PNS8P5
	WdXB9zH6McZv0L5ZOXW7H6igEEGCfZrlxSt8/sQHCs2lbK+O2y6Fm0LQtvxN59qy0FsZoURLTV1
	St/uasxrh/F1f6cHuvtNyVbd/KqfXECoTvRIGhC5diZ+hRsusSyxh1yuD+4YeTkZuoHpSOjmMN8
	TG5FZVQfAkbs2hMv3fcuu0uzw+jnz1V0xG8qx4Xt5oy939slsE0chpRVwNkqD/vhGLS5/LcAsr9
	aJawwM9QUXs4rOWtOuINB20=
X-Received: by 2002:a05:6808:1691:b0:4cb:b6dd:2fe2 with SMTP id 5614622812f47-568143aa037mr2688600b6e.4.1794234029567;
        Mon, 09 Nov 2026 06:20:29 -0800 (PST)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-56813c71bd0sm4503398b6e.4.2026.11.09.06.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 06:20:26 -0800 (PST)
Message-ID: <f27cb885-76bb-4d2b-b863-437c78029f8b@ieee.org>
Date: Mon, 9 Nov 2026 08:20:24 -0600
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
Subject: Re: [PATCH] greybus: reject messages with claimed size smaller than
 header
To: Zhao Feng <zhaofeng2@cmss.chinamobile.com>, greybus-dev@lists.linaro.org
Cc: johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,
 syzbot+693652ded53d3eb9cb91@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20261109013336.1122-1-zhaofeng2@cmss.chinamobile.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20261109013336.1122-1-zhaofeng2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/8/26 7:33 PM, Zhao Feng wrote:
> gb_connection_recv() performs two sanity checks on received
> messages: the receive buffer must hold at least a full message
> header, and it must hold at least the message size claimed in the
> header.  Neither check verifies that the claimed message size
> covers the header itself.
> 
> A message claiming a size smaller than sizeof(struct
> gb_operation_msg_hdr) (e.g. 7) passes both checks when 8 or more
> bytes were received, and the claimed size is then used as the
> message size:
> 
> - gb_operation_create_incoming() computes
>    request_size = msg_size - sizeof(header), which underflows to
>    SIZE_MAX.  The request handler then reads payload from a message
>    whose payload size is SIZE_MAX; syzbot reported this as a KASAN
>    global-buffer-overflow read in gb_svc_request_handler().
> - gb_connection_recv_response() similarly computes
>    payload_size = size - sizeof(*header) for accepted short
>    responses, which underflows the same way.
> 
> Reject such messages up front in gb_connection_recv().  A claimed
> size equal to the header size is valid (header only, no payload),
> so the comparison must be strict.

So the problem occurs when a message arrives that has a bogus
header.  We know we received enough bytes to hold a

> 
> Reported-by: syzbot+693652ded53d3eb9cb91@syzkaller.appspotmail.com
> Closes: https://syzbot.org/bug?extid=693652ded53d3eb9cb91
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
> ---
> No Fixes tag: the missing validation dates back to the original
> greybus import; the introducing commit could not be verified with
> the trees available to me.
> 
> Not runtime-tested (no greybus hardware).  The affected function is
> identical in current upstream master, so the patch applies there
> as-is.
> 
> This also answers the question raised on the syzbot thread about
> whether the underflow is reachable: it is, because the existing
> checks compare the *received* size against the claimed size, never
> the claimed size against the header size.
> 
>   drivers/greybus/operation.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/greybus/operation.c b/drivers/greybus/operation.c
> index 8459e9bc07..83b16c78f7 100644
> --- a/drivers/greybus/operation.c
> +++ b/drivers/greybus/operation.c
> @@ -1046,6 +1046,12 @@ void gb_connection_recv(struct gb_connection *connection,
>   	/* Use memcpy as data may be unaligned */
>   	memcpy(&header, data, sizeof(header));
>   	msg_size = le16_to_cpu(header.size);
> +	if (msg_size < sizeof(header)) {
> +		dev_err_ratelimited(dev,
> +				    "%s: malformed message received (%zu < %zu)\n",
> +				    connection->name, msg_size, sizeof(header));
> +		return;
> +	}
>   	if (size < msg_size) {
>   		dev_err_ratelimited(dev,
>   				    "%s: incomplete message 0x%04x of type 0x%02x received (%zu < %zu)\n",

