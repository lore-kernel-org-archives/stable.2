Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794499928;
	b=3J3NVZ8hLVtXIrDpYLTZczR3dGDwh2N66HgcF3LkwQALpuBV76IyMQdApdqxivmybCBE
	 1vWdRUXR1cej8zLCqPuw96uRveqEeuYKm6uDGgAiFWNr5hXNiZCu9wZoAwudnKnrWPV7y
	 KlBmsid4nJC/FBAUgdrQ+iWremcpI46fYjIOVsKoenqdqk6C8Y5pO4V30LLK8NjdtMknc
	 WJ6T9y41b0j/eOmjVYt2qnldwKKt8Ap6Gqke4RBzPvlhChRnQ1H2IOa/FT61B44Jz+TF2
	 HOoDXMND1HSswZo33uMKy78Y+EdXhl6cG2JW6+PqB8jZYIpDygC4fl9oRPxdhGwkrIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794499928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Z5H3JZnDHei4Ba87P8qtf4+QG1tTAZiOmC3aN62AyUA=;
	b=bkqlkTSTgE81YKsMW9fIJiKUwVjah1LcLl5c1bm+m+guqwNf65+F2SsGQahcCRBCSt0H
	 /MWM+8ErHmsPJH1Zg4zI5D7PllG0NOuYjeP78sHG9iEgYWjxuNIVJNg/sjEd0Z9iUlD5s
	 2MVvRuVAzN1kO+oUka0MmUVOxDWLGF6N1RL7pLP0kzk5QC7chpnSeZkNG7Avutxydch/g
	 sRrfL4hwuZWaoD7um3402lEGx7TtHAVL+ycORzQx2LLrWgAb3Nk1B4HP3oShVeD6BNMq7
	 0UiiLpDdxH7ynWzUJlJ2G3S71uXJGN0dche0InsnrHuKkuaoQYxywn2njqnGUU4jseg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=hcLBh0np;
	arc=none smtp.remote-ip=209.85.161.49
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5B2606A323
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 16:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB5B2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=hcLBh0np
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-70b875f6f13so3763092eaf.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1794499926; x=1795104726; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z5H3JZnDHei4Ba87P8qtf4+QG1tTAZiOmC3aN62AyUA=;
        b=hcLBh0npSAywjr1PPuz57wOFXYve8m2WOyXnzZUgbNEb7c9QtrzqFPE4/Ji9/kuS9m
         T35iYn9QrePsyCHJni4apXz0my9u0PxqvY3xczQeqTT67q7rHT9/QSDSwMUdDjE74HDs
         0wbvtRY25iiLFwuM4FQPjau3Iquv+Tce5tUrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794499926; x=1795104726;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z5H3JZnDHei4Ba87P8qtf4+QG1tTAZiOmC3aN62AyUA=;
        b=RfNY2dkoXWd2ltMm1V1c4fqEDW4sVVSPb2R/KWqAkBg8QdjI8f7Ck3vkHqwb6CIopX
         PmGQ/mSoIV1NvpsvJn3vbqckDwdtIZvzV2dYwdBxDYHpAIqOZuau0/k105h3tr2OeDYO
         jx49yE3j4qZsgX39zbKn8TbOLSVSkf7v36SQaOF0R0u7B/1e00fgoLxFZIqAjhMzeV8v
         5sSX17/m44ynEBS1SRtPwr+d3JSlwOTOzHf1imrX4P4worClomsRERhjEYfTbKe1RatW
         CiY/JGkYK0NPLcFyoZy8F1ne+8vlhl+dCnL3INA6/b2hBuxhcFGw0K0Jv4o40Cwdcp9J
         Ez7Q==
X-Forwarded-Encrypted: i=1; AL+hErH0Dc8Y0gizJKzc7yUsL/NHcs7LsAU0P+2fXqC/5i4KOLp9sfzgyS5OSe5035ISPApzTfkbH3E=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tVtRYHwCzHDdlwl/J4mW6loCMelvA2q0PXKPveMNyL3Asd5ik
	AkSRxGLVMpf1vR02B1nvt07qWy6wqhnassW5thvlObX40Xo1riIMXp4tEbCD3T1dQws=
X-Gm-Gg: AYBFou1JBLqFSCZcRknSQWJf3apfB/9VuBfOWZDdbtBmIE56Hd4+vnBpRIi+N3HLE0m
	5ooQQryDzZtr66z6pR8N4BIICRinMxM4Z2Sh1NibuNpkqwCE9K6B+eMRYo7sN2wZ3FhLa8LJ2J9
	CB2+8g0b6wlHdb7lj2wdrvN2QIhdgZQmj//rPuGR6g00xsyB2GfWCdoDLp6/8o6Kc/cvO6PguqZ
	09oVkRHnaphzf7z2ODfq0mpuD0ZDQfmco1gG3sKmN6tO7M6Wgi+6pO6+OEjgv10mGJKYnjg+XsE
	8SE6BDilqGBU1mPMoH5V/ANunesmXdL0QEd4yn3jBjWmu9m0W7mIWaVrU2d0j77TE4whOpARQdc
	kSybHQ4POm6B305rwlUbOMs0yABOYlCBHoXlLpaa9KPXdqmXI6xss83tlPqncwHMtHyTHhdYsVn
	kSe9qu5Bpwj46CwS/aKnourfZko1cVfrI+oXbxtOrxUU8fMtHwuQGX8OetCWZ9a5tBQ/ZfejcUA
	HUk0QWgXyi1T0neuWS3vNkWUhMHAZQ17Zxssy23midMwg7cva+oRdmrMrPb/qhOksJIXElNK5Gu
	0M6x8tUtM0kPNPWVmVUh09mCHGPwmofobyMRx+0=
X-Received: by 2002:a05:6820:806:b0:716:f44b:2dd8 with SMTP id 006d021491bc7-7191785b304mr4102008eaf.31.1794499925700;
        Thu, 12 Nov 2026 08:12:05 -0800 (PST)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-86287f0e257sm84600a34.1.2026.11.12.08.12.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 08:12:04 -0800 (PST)
Message-ID: <67b2c06e-0caa-4ba1-89ee-17cb814d173c@linuxfoundation.org>
Date: Thu, 12 Nov 2026 09:12:01 -0700
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
Subject: Re: [PATCH] usbip: Close all listening sockets in request workers
To: raoxu <raoxu@uniontech.com>, valentina.manea.m@gmail.com
Cc: shuah@kernel.org, i@zenithal.me, luiz.von.dentz@intel.com,
 pengpeng@iscas.ac.cn, brgl@kernel.org, pmenzel@molgen.mpg.de,
 gregkh@linuxfoundation.org, ihadzic@research.bell-labs.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <E063498E65C71B8D+20261112121648.1458957-1-raoxu@uniontech.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <E063498E65C71B8D+20261112121648.1458957-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/26 05:16, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> process_request() forks a worker after accepting a connection, but the
> child only closes the listener used for that connection. All other
> listening sockets are inherited and remain open until the worker exits.
> This occurs when usbipd listens on multiple addresses, including the
> default IPv4 and IPv6 setup.
> 
> A worker waiting for a client request can therefore keep an unrelated
> listener alive after the main daemon exits. Restarting usbipd then fails
> to bind that address with EADDRINUSE, or starts with only the addresses
> that are still available. A single-listener configuration is unaffected.
> 
> Pass the complete listening socket array and its count to
> process_request(), and close every listener in the child before handling
> the request. The accepted connection remains open, and the parent's
> descriptors are unaffected. Make process_request() static as its only
> caller is in the same file.

Looks reasonable to me. How did you find the problem? Can you share
how to reproduce this problem?

> 
> Fixes: 328f7f8a0a1c ("staging: usbip: userspace: eliminate glib dependency")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> ---
>   tools/usb/usbip/src/usbipd.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/usb/usbip/src/usbipd.c b/tools/usb/usbip/src/usbipd.c
> index 3e22b651c754..5ff5b46674a2 100644
> --- a/tools/usb/usbip/src/usbipd.c
> +++ b/tools/usb/usbip/src/usbipd.c
> @@ -339,17 +339,20 @@ static int do_accept(int listenfd)
>   	return connfd;
>   }
> 
> -int process_request(int listenfd)
> +static int process_request(int listenfd, const int *listenfds, int nlistenfds)
>   {
>   	pid_t childpid;
>   	int connfd;
> +	int i;
> 
>   	connfd = do_accept(listenfd);
>   	if (connfd < 0)
>   		return -1;
>   	childpid = fork();
>   	if (childpid == 0) {
> -		close(listenfd);
> +		/* Do not keep unrelated listening sockets alive in workers. */
> +		for (i = 0; i < nlistenfds; i++)
> +			close(listenfds[i]);
>   		recv_pdu(connfd);
>   		exit(0);
>   	}
> @@ -568,7 +571,8 @@ static int do_standalone_mode(int daemonize, int ipv4, int ipv6)
>   				if (fds[i].revents & POLLIN) {
>   					dbg("read event on fd[%d]=%d",
>   					    i, sockfdlist[i]);
> -					process_request(sockfdlist[i]);
> +					process_request(sockfdlist[i], sockfdlist,
> +							nsockfd);
>   				}
>   			}
>   		} else {
> --
> 2.50.1
> 

thanks,
-- Shuah
