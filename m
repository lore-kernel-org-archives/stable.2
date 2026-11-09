Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235402;
	b=edTmLJ8m8DF1/DJLj+RKLCoZ5X778XjJ/jHQmTOdKU9y6pvRpkBIn93NHJ4K8zYyCJWz
	 scYqLLeE49AY0y4gnLujBYksGrH06bmly+fq+jSXQJq9o1J0PhzwOTUAWVtSuZ8ERwnYE
	 VZQCx1GJe+PydX835hMc0rL/b9/RNI/Zo40KQhA574pg7p17LW/6OeGtpdatYETILF10y
	 wYcyJ5gKOQld/Z8RLn2ea/SX5rusxDaPxgL1gwTHvyf4/wf4/sn3eXqvYnhR3EHVs22X/
	 6C0c6NFduikH90pajRuZPZS9svIr3h7W4JKhEy56bKCUs85uP/bY/rrEIJKMAXoU55g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235402;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=eab7x+/IWkDtBF2+kKHfms5l8bMxSW46Z6JtuZvSMn4=;
	b=OQoDFCXlxJ81GEEIw9yLZ/XF4YRnrqlIeicRSzy5oFXcEuyAORiYEuBGkwmbecHs8NkE
	 eYrqlZZ44S4MIPeZ9/SWJ8Qc89lklEcTnZKHWk6mGZYZn7yEjN848qZL7/qoJqzKM2u26
	 lExyJybx27JUvYueStXPOWTRmp+ohC+33rJIYT1PVqEi/7eJm0k1B4DQRO87+dOz+FVhi
	 ofewk/EwatZxuAEmx0Lhim5YMSm/WBVOFczBnUA7qh+oaQNCsMTL6F8fsXmj2ZhLklV1u
	 CkEURsL7L7UpqEBBMCnTChVupPIJ0q/rRdcN7nkcEBtm3QA0j8OAZ07zQZa0Odk3/GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ieee.org;
	spf=pass smtp.mailfrom=ieee.org;
	dkim=pass header.d=ieee.org header.i=@ieee.org header.a=rsa-sha256 header.s=google header.b=WnvVtmaf;
	arc=none smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDC4606D826
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 14:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BDC4606D826
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.a=rsa-sha256 header.s=google header.b=WnvVtmaf
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-702fd86d674so386687eaf.2
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 06:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1794235399; x=1794840199; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eab7x+/IWkDtBF2+kKHfms5l8bMxSW46Z6JtuZvSMn4=;
        b=WnvVtmafzpOEtLJCghvPAp1Yk2EkRfKAcTofbdAd/PD9dKkk0NkVsGGRDUJB8qdxb6
         7QWgZBEOxNuBvdbPrDDUAw6ycTOABv0xkgQrd3XhWAI8RAbsJyg8ZISzYDUdjc8ygzKx
         gw9p47qYVFfInjin6l8dseThpuz2KMOIvJuSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794235399; x=1794840199;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eab7x+/IWkDtBF2+kKHfms5l8bMxSW46Z6JtuZvSMn4=;
        b=kT0bCv2SdZZ54FpFntg4VCU6ta+UAKFL2Qms7lcTO7d2m86clcptFck7Y4r3OyvAqH
         SdCWCth9CefY0kboBNaoLWJPQsCi93wWR4tiR/04qVrjhI26q6+In1fVMjoW9NiXt7eK
         j9MVNnix2A5Dif94I71wXXgFXB0+tn9sgMvjcBS0a6461JEwavcQKzd393nvUMn64kG8
         lU2bDleqQeKdeF3GdTFB3avK86Z6nXtOEYnyVNg7qMc2PLtjGXPuD1bewncVQRr1gmNb
         ysGEhpbP/ltUgQRBQ/XuVWfIjDz5c1sYANyD1CBy2xUnnUjCW8wOb90vVEsUMsfKySvk
         eFvw==
X-Forwarded-Encrypted: i=1; AL+hErEOth+iyTZK4KxVMITw3Pe1O0H+2F88r0cK/8pQXi2XqgwbFlJIIfI/Oqj4FpTI6fwxMETzYqs=@vger.kernel.org
X-Gm-Message-State: APuU4Z86PehAGKH1bRrJ1arJvb74RqIXNTnFd3oWN1PE4D9khae3iFbV
	4EFKaCw/ZUWQVAL/SEF0EYXbWVzTv3tCS9ttkIK4HoL20qSuhVfqt9o6ARu2uOluFg==
X-Gm-Gg: AYBFou2Q2iJ4RTZClf0dxV/7HFvGjWbWZLtTaa5z4Ii8jz86RwsBzZzO8YSBbrcFbTM
	88Hba/BVfgpSCLO0awWVf+VsBi5thoKqwpg5s6yiQYoav/qiqKah/N11u78g+RFE50pNsMjHpMC
	czEinHvsNp8e+U7B3twcXDP3DE0uNPF/K8EEwBjxF7I60MBO+469gC+LHHINka03HeAaoLg/hjk
	oI49oObT2THGpT+QM9EtV1TH84VYlJsZa1ZzKwctm9yAotQI+DQ7SBOmyDJJTBM2HpaK6eiXvLc
	oFUCubMpk9SFWKj84AYAcz6wb4AvSo45yfzj6RMW2tDKAc6bNe2XtCWEqfZO+ONHo3/FBwGVn32
	onlrlOOvb093DIdzcLuwTCNR5PQnAX3yNZ6LmO3npw0NTeA8TzPHG1gXcjcjiaHWpXHj69Iyvz9
	PkoxHeJ0SwlKB3vYdavg6ARDatG5qJTHidCR/u2xJ3pGTu6T2JO5w4cBrIhLb3JJjPncjsNEn37
	jEI7GU3qDTp64HuLwt1xXlbeyY+xQ2XxKOFmNx77DmC+Io4fX4waztvyuEV23x/SyRVMj6KZYKi
	CAJmOYaqum3yy0zLsIJPU4E=
X-Received: by 2002:a05:6820:1c8a:b0:716:db9f:682c with SMTP id 006d021491bc7-7170f34476fmr2344540eaf.69.1794235399476;
        Mon, 09 Nov 2026 06:43:19 -0800 (PST)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-85f4fbce9cdsm3779583a34.20.2026.11.09.06.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 06:43:18 -0800 (PST)
Message-ID: <ff30d76b-a58c-41d9-a4ab-1fdb7f931f46@ieee.org>
Date: Mon, 9 Nov 2026 08:43:17 -0600
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
header.  We verify that the bytes received are enough to hold a
gb_operation_msg_hdr structure.  But the 2-byte size field within
that structure lies at the beginning, and there was previously
no check that its value made sense.

A valid header->size must be at least sizeof(header) (for a
zero-byte payload).  It looks like gb_connection_recv_response()
might handle a header whose size field is too small, but
gb_connection_recv_request() does not.

In any case, I think this fix looks good.

Reviewed-by: Alex Elder <elder@riscstar.com>

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

